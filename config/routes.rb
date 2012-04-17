Fstvl::Application.routes.draw do
  
  resources :countries

  resources :acts
  resources :prices
  resources :festivals

  root :to => 'festivals#index'

  match '/import' => "festivals#import"  
  match '/monthsums' => "festivals#monthsums"    

end
