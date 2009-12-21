ActionController::Routing::Routes.draw do |map|
  map.logout "logout", :controller => "sessions", :action => "destroy"
  map.login "/login", :controller => "sessions", :action => "new"

  map.resources :mention, :as => "dont_mention_it", :only => :index
  
  map.resources :users, :collection => {:use_sheet => :post}

  map.resources :sheets, :as => "characters"

  map.connect 'documents/:year/:month/:day', :controller => 'documents',
     :month => nil, :day=> nil, :requirements => { :year => /\d{4}/ }

  map.referendum "/referendum", :controller => "documents", :action => "referendum"
  map.resources :documents, :only => [:create, :index, :new, :show]
  map.resources :pages, :only => :show

  map.resources :written_questions, :only => [:index, :show], :collection => {:rss => :get}

  map.connect "budget-pages/:id", :controller => "documents", :action => "redirect", :id => nil

  map.resources :missions, :has_many => :events

  map.games "/games", :controller => "missions"

  map.resource :session

  map.finalize_session 'session/finalize', :controller => 'sessions', :action => 'finalize'

  map.root :controller => "missions"
end
