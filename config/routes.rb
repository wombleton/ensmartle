ActionController::Routing::Routes.draw do |map|
  map.resources :realms, :only => [:index, :show]
  map.character "/realms/:realm_id/:id", :controller => "characters", :action => "show"
  map.learn_spell "/realms/:realm_id/:id/learn/:spell_id", :controller => "characters", :action => "learn"
  map.forget_spell "/realms/:realm_id/:id/forget/:spell_id", :controller => "characters", :action => "forget"
  
  map.resources :spells, :member => {:tooltip => :get}, :only => [:index, :show]
  map.resources :users, :except => :destroy

  # election stuffs
  map.eight '/08', :controller => "election", :action => "index"
  map.eight_rss '/08/rss', :controller => "election", :action => "rss"

  # tradeskill stuffs
  map.armoury_fail '/armouryfail', :controller => "characters", :action => "armoury_fail"
  map.add_character "/add_character", :controller => "characters", :action => "new"
  map.armoury_search "/armourysearch", :controller => "characters", :action => "search"
  map.login '/login', :controller => 'sessions', :action => 'new'
  map.logout '/logout', :controller => 'sessions', :action => 'destroy'
  map.professions '/professions', :controller => 'spells', :action => 'professions'
  map.register '/register', :controller => 'users', :action => 'create'
  map.search '/search', :controller => 'spells', :action => 'search'
  map.signup '/signup', :controller => 'users', :action => 'new'

  map.connect 'professions/:profession', :controller => 'spells', :action => 'profession'

  map.root :controller => 'election', :action => 'index'
end
