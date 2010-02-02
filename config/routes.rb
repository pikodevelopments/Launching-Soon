ActionController::Routing::Routes.draw do |map|
  map.resources :news_letter_subscribers, :only => [:create]
end
