class SpellsController < ApplicationController
  require 'wowr'  
  require 'rubygems'
  require 'open-uri'
  
  # GET /spells
  # GET /spells.xml
  def index
    spells = Spell.find(:all, :limit => 20)

    @tradeskills = organise(spells)
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @spells }
    end
  end
  
  # GET /spells/1
  # GET /spells/1.xml
  def show
    @spell = Spell.find(params[:id])
    
    @previous = Spell.find(params[:id].to_i - 1) unless params[:id].to_i == 1
    @next = Spell.find(params[:id].to_i + 1)
    
    if @spell.tooltip.nil?
      begin
        fetch = fetch_tooltip(@spell.spell_id, @spell.name)
        unless fetch.nil?
          @spell.icon_base = fetch[0]
          @spell.tooltip = fetch[1]
          @spell.save
        end
      rescue
      end
    end
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @spell }
    end
  end
  
  # GET /spells/new
  # GET /spells/new.xml
  def new
    @spell = Spell.new
    
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @spell }
    end
  end
  
  # GET /spells/1/edit
  def edit
    @spell = Spell.find(params[:id])
    @previous = Spell.find(params[:id].to_i - 1) unless params[:id].to_i == 1
    @next = Spell.find(params[:id].to_i + 1)
  end
  
  # POST /spells
  # POST /spells.xml
  def create
    @spell = Spell.new(params[:spell])
    
    respond_to do |format|
      if @spell.save
        flash[:notice] = 'Spell was successfully created.'
        format.html { redirect_to(@spell) }
        format.xml  { render :xml => @spell, :status => :created, :location => @spell }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @spell.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  # PUT /spells/1
  # PUT /spells/1.xml
  def update
    @spell = Spell.find(params[:id])
    
    respond_to do |format|
      if @spell.update_attributes(params[:spell])
        flash[:notice] = 'Spell was successfully updated.'
        @next = Spell.find(@spell.id + 1)
        format.html { redirect_to(edit_spell_path(@next)) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @spell.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  # DELETE /spells/1
  # DELETE /spells/1.xml
  def destroy
    @spell = Spell.find(params[:id])
    @spell.destroy
    
    respond_to do |format|
      format.html { redirect_to(spells_url) }
      format.xml  { head :ok }
    end
  end

  # GET /spells/1/tooltip
  def tooltip
    @spell = Spell.find(params[:id])
    render :text => @spell.tooltip || ""
  end

  # GET /professions
  def professions
    @professions = Spell.find_by_sql('select tradeskill from spells group by tradeskill order by tradeskill').map{|s| s.tradeskill}
  end

  # GET /profession/foo
  def profession
    spells = Spell.find_all_by_tradeskill(params[:profession])
    @tradeskill = organise(spells).first
  end

  # GET /search?q=foo
  def search
    spells = Spell.find :all, :conditions => ["name like ?", "#{params[:q]}%"]
    characters = Character.find :all, :conditions => ["name like ?", "#{params[:q]}%"]
    @results = spells + characters
    @results.sort!{|a,b| a.name <=> b.name}
  end

  private
  def fetch_tooltip spell_id, item_name
    api ||= Wowr::API.new(:caching => false)
    puts "I'm searching for item #{item_name}"
    items = api.search_items(item_name.gsub!(/[-:]/, ''))
    
    puts "found #{items.size} items"
    for i in items
      fetch = fetch_item(spell_id, item_name, i)
      return fetch unless fetch.nil?
    end
    return nil
  end
  
  CACHE = {}
  
  def fetch_item(spell_id, item_name, api_item)
    api ||= Wowr::API.new(:caching => false)
    CACHE[api_item.id] ||= api.get_item(api_item.id)
    item = CACHE[api_item.id] 
    
    puts "Item from api: #{item.name} << #{item.inspect}>>"
    
    for created_by in item.created_by || [item]
      if created_by.id == spell_id or item.name == "Scroll of #{item_name}" or item.name == "Formula: #{item_name}" or item.name == "Recipe: #{item_name}" or (item.name == item_name and !item.gem_properties.empty?)
        # open-uri RDoc: http://stdlib.rubyonrails.org/libdoc/open-uri/rdoc/index.html
        open("http://www.wowhead.com/?item=#{item.id}&xml", "User-Agent" => "Ruby/#{RUBY_VERSION}",
          "From" => "wombleton@gmail.com",
          "Referer" => "http://crafty.melee.net.nz") { |f|
          # Save the response body
          @r = f.read
        }
        doc = Hpricot(@r)
        return item.icon_base, (doc/"wowhead/item/htmlTooltip").first.inner_text
      end
    end
    return nil
  end

  def organise(spells)

    tradeskills = {}
    for s in spells
      tradeskills[s.tradeskill] ||= {}
      tradeskills[s.tradeskill][s.category || "unknown"] ||= []
      tradeskills[s.tradeskill][s.category || "unknown"] << s
    end

    ts = []
    tradeskills.keys.sort.each{|t_key|
      tskill = Tradeskill.new
      tskill.name = t_key
      puts "key is #{t_key} and result is #{tradeskills[t_key]}"
      categories = tradeskills[t_key]
      categories.keys.sort.each{|c_key|
        category = Category.new
        category.name = c_key
        category.spells = categories[c_key]
        tskill.categories << category
      }
      ts << tskill
    }

    ts
  end
end

class Tradeskill
  attr_accessor :name, :categories
    def initialize *a, &b
      super
      @categories = []
    end
end

class Category
  attr_accessor :name, :spells
  
  def initialize *a, &b
    super
    @spells = []
  end
end
