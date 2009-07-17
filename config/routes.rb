ActionController::Routing::Routes.draw do |map|
  map.connect 'documents/:year/:month/:day', :controller => 'documents',
     :month => nil, :day=> nil, :requirements => { :year => /\d{4}/ }

  map.resources :documents, :only => :index
  map.resources :pages, :only => :show

  map.resources :games, :except => [:destroy], :shallow => true do |game|
    game.resources :missions do |mission|
      mission.resources :rolls, :only => [:create]
    end
  end

  map.pagesearch "/pagesearch", :controller => "pages", :action => "pagesearch"

  map.resources :users, :except => :destroy

  # election stuffs
  map.eight '/08', :controller => "election", :action => "index"
  map.eight_rss '/08/rss', :controller => "election", :action => "rss"

  map.login '/login', :controller => 'sessions', :action => 'new'
  map.logout '/logout', :controller => 'sessions', :action => 'destroy'
  map.register '/register', :controller => 'users', :action => 'create'
  map.signup '/signup', :controller => 'users', :action => 'new'
end
