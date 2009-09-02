ActionController::Routing::Routes.draw do |map|

  map.login "login", :controller => "user_sessions", :action => "new"
  map.logout "logout", :controller => "user_sessions", :action => "destroy"
  map.register "register", :controller => "users", :action => "new"

  map.resources :users
  map.resources :user_sessions

  map.resources :sheets, :as => "characters"

  map.resources :comet, :only => :index

  map.connect 'documents/:year/:month/:day', :controller => 'documents',
     :month => nil, :day=> nil, :requirements => { :year => /\d{4}/ }

  map.referendum "/referendum", :controller => "documents", :action => "referendum"
  map.resources :documents, :only => [:create, :index, :new, :show]
  map.resources :pages, :only => :show

  map.resources :written_questions, :only => [:index, :show], :collection => {:rss => :get}

  map.connect "budget-pages/:id", :controller => "documents", :action => "redirect", :id => nil

  map.resources :missions, :has_many => :events

  map.games "/games", :controller => "missions"

  map.root :controller => "missions"
end
