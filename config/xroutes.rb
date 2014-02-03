KrubyRails4::Application.routes.draw do

  resources :preferences

  resources :vouchers

  resources :users

  resources :relations

  resources :hours, except: :edit
  get '/timeliste' => 'hours#timeliste', as: :timeliste
  get '/monthly' => 'hours#monthly', as: :monthly
  
  get 'hours/years_show/:relation_id' => 'hours#show_years', as: :show_years
  get 'hours/months_show/:relation_id/:year' => 'hours#show_months', as: :show_months
  get 'hours/months/days_show/:relation_id/:month' => 'hours#show_days', as: :show_days
  get 'hours/relations/:relation_id/edit/:id' => 'hours#edit', as: :edit_hour
  get 'hours/find_all/:id' => 'hours#find_all', as: :find_alle
  get 'hours/years_hide/:relation_id' => 'hours#hide_years', as: :hide_years
  get 'hours/months_hide/:relation_id' => 'hours#hide_months', as: :hide_months
  get 'hours/months/days_hide/:relation_id' => 'hours#hide_days', as: :hide_days
  
  # PUBLIC
  get 'hours/months_show_public/:relation_id/:year' => 'hours#show_months_public', as: :show_months_public
  get 'hours/months/days_show_public/:relation_id/:month' => 'hours#show_days_public', as: :show_days_public
  get 'hours/months_hide_public/:relation_id' => 'hours#hide_months_public', as: :hide_months_public
  get 'hours/months/days_hide_public/:relation_id' => 'hours#hide_days_public', as: :hide_days_public
  

  resources :attachments do
    collection do
      delete 'destroy_from_post'
    end
  end

  resources :assets do
    collection do
      post 'edit_multiple'
      put 'update_multiple'
      get 'add_to_post'
    end
  end

  resources :menus

  resources :posts

  resources :contents  
  get 'contents/active/:id' => 'contents#active', as: :content_active
  get 'contents/admin/:id' => 'contents#admin', as: :content_admin
  get 'contents/redirect/:id' => 'contents#redirect', as: :content_redirect
  get 'contents/change_category/:id' => 'contents#change_category', as: :change_category

  resources :pages
  get 'pages/active/:id' => 'pages#active', as: :page_active
  
  resource :sessions
  #Single resources map to plural controllers (/session => sessions_controller.rb)
  
  resources :viewer
  get 'projekter' => 'viewer#show', :as => :projekter, name: 'projekter'
  get 'produkter' => 'viewer#show', :as => :produkter, name: 'produkter'
  get 'kontakt' => 'viewer#show', :as => :kontakt, name: 'kontakt'
  
  get 'logoff' => 'sessions#destroy', as: 'logoff'
  get 'log_out' => 'sessions#destroy', as: 'log_out'
  get 'logout' => 'sessions#destroy', as: 'logout'
  get 'log_in' => 'sessions#new', as: 'log_in'
  get 'login' => 'sessions#new', as: 'login'
  get 'sign_up' => 'users#new', as: 'sign_up'

  get 'old_menus', to: 'menus#create_from_old'
  
  root 'viewer#forside'  

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with 'rake routes'.

  # You can have the root of your site routed with 'root'
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
