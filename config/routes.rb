ActionController::Routing::Routes.draw do |map|
  map.resources :sheets

  map.resources :comet, :only => :index

  map.connect 'documents/:year/:month/:day', :controller => 'documents',
     :month => nil, :day=> nil, :requirements => { :year => /\d{4}/ }

  map.resources :documents, :only => [:create, :index, :new, :show]
  map.resources :pages, :only => :show

  map.resources :written_questions, :only => [:index, :show], :collection => {:rss => :get}

  map.connect "budget-pages/:id", :controller => "documents", :action => "redirect", :id => nil

  map.resources :missions, :except => [:destroy] do |mission|
    mission.resources :events, :only => [:create]
  end

  map.games "/games", :controller => "missions"
end
