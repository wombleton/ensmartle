class RecipesController < ApplicationController
  RECIPES = {
    'Alchemy' => 'Recipe:',
    'Blacksmithing' => 'Plans:',
    'Enchanting' => 'Formula:',
    'Engineering' => 'Schematic:',
    'Inscription' => '',
    'Jewelcrafting' => 'Design:',
    'Leatherworking' => 'Pattern:',
    'Tailoring' => 'Pattern:'
  }
  
  # POST /recipes
  # POST /recipes.xml
  def create
    @recipe = Recipe.find_or_initialize_by_profession_id_and_spell_id(params[:recipe][:profession_id], params[:recipe][:spell_id])
    
    respond_to do |format|
      save = @recipe.id.nil?
      if save ? @recipe.save : @recipe.destroy
        if save
          text = "#{@recipe.profession.character.name} knows #{@recipe.spell.name}!"
        else
          text = "Whoops! Maybe #{@recipe.profession.character.name} doesn't know #{@recipe.spell.name} after all."
        end
        format.html { render :text => text }
        format.xml  { render :xml => @recipe, :status => :created, :location => @recipe }
      else
        format.html { render :text => @recipe.errors.inspect, :status => 500 }
        format.xml  { render :xml => @recipe.errors, :status => :unprocessable_entity }
      end
    end
  end
end
