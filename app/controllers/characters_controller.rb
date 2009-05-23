class CharactersController < ApplicationController
  require 'wowr'
  
  # GET /characters/1
  # GET /characters/1.xml
  def show
    realm = Realm.find_by_pseudo_id(params[:realm_id])
    @character = Character.find_or_create_by_name(params[:id], :include => :professions, :conditions => {:realm_id => realm.id})

    if @character.realm.nil?
      @character.realm = realm
      @character.save
    end

    begin
      @character.update_professions
    rescue Timeout::Error
      redirect_to :armoury_fail and return
    end

    @character.professions.each{|p|
      decorate_profession(p)
    }
    
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @character }
    end
  end
  
  # GET /characters/new
  # GET /characters/new.xml
  def new
    @characters = []
    @character = Character.new
    
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @character }
    end
  end
  
  # PUT /characters/1
  # PUT /characters/1.xml
  def update
    @character = Character.find(params[:id])
    
    respond_to do |format|
      if @character.update_attributes(params[:character])
        flash[:notice] = 'Character was successfully updated.'
        format.html { redirect_to(@character) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @character.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  def search
    @characters = []
    begin
      api = Wowr::API.new(:caching => false, :locale => params[:character][:locale].downcase)
      name = params[:character][:name]
      if name.to_s.empty?
        api_characters = []
      else
        api_characters = api.search_characters(:search => name).sort{|a,b|
          b.relevance <=> a.relevance
        }
      end
      @characters = api_characters.map{|c|
        realm = Realm.find_or_create_by_name(c.realm)
        realm.locale ||= params[:character][:locale]
        realm.save
        char = Character.new(:name => c.name, :realm => realm, :guild => c.guild, :armoury_url => "#{api.base_url}character-sheet.xml?#{c.url}")
        char.update_pseudo_id
        char[:relevance] = c.relevance
        char
      }
    rescue Timeout::Error
      redirect_to :armoury_fail and return
    end
    render :action => "new"
  end

  def learn
    @character = Character.locate params[:realm_id], params[:id]
    spell = Spell.find(params[:spell_id])
    @character.learn_spell spell
    spell.known = true
    render :partial => "spells/spell", :locals => {:spell => spell}
  end

  def forget
    @character = Character.locate params[:realm_id], params[:id]
    spell = Spell.find(params[:spell_id])
    @character.forget_spell spell
    spell.known = false
    render :partial => "spells/spell", :locals => {:spell => spell}
  end

  private
  def decorate_profession(profession)
    spells = Spell.find(:all, :conditions => ["tradeskill = ?", profession.name], :order => "id")
    profession.unlearnt_recipes = spells - profession.spells
    profession.unlearnt_recipes.sort!{|a, b| a.id <=> b.id}
  end
end
