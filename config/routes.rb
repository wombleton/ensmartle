ActionController::Routing::Routes.draw do |map|
  map.resources :sheets

  map.connect 'documents/:year/:month/:day', :controller => 'documents',
     :month => nil, :day=> nil, :requirements => { :year => /\d{4}/ }

  map.resources :documents, :only => [:create, :index, :new, :show]
  map.resources :pages, :only => :show

  map.resources :written_questions, :only => [:index, :show], :collection => {:rss => :get}

  map.connect "budget-pages/:id", :controller => "documents", :action => "redirect", :id => nil

  map.resources :missions, :except => [:destroy], :shallow => true do |mission|
    mission.resources :rolls, :only => [:create]
  end

  map.games "/games", :controller => "missions"

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
