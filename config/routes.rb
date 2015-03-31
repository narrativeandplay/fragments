Fragments::Application.routes.draw do
  devise_for :users, path_names: { sign_in: 'login', sign_out: 'logout', sign_up: 'register'}
  root 'static_pages#home'

  get 'help' => 'static_pages#help'
  get 'about' => 'static_pages#about'
  get 'contact' => 'static_pages#contact'
  
  resources :users, only: [:show] do
    resource :profile, only: [:edit, :update]
  end
  resources :stories, only: [:index, :new, :create, :show] do
    get 'page/:page', action: :index, on: :collection

    resources :comments, only: [:create]

    resources :fragments, only: [:show, :create, :update] do
      get 'read' => 'stories#read'
    end
  end

  namespace :admin do
    root 'dashboard#dashboard'
    get 'dashboard'

    resources :users do
      get 'page/:page', action: :index, on: :collection
    end

    resources :fragments do
      get 'page/:page', action: :index, on: :collection
    end

    resources :stories do
      get 'page/:page', action: :index, on: :collection
    end

    resources :profiles do
      get 'page/:page', action: :index, on: :collection
    end

    resources :comments do
      get 'page/:page', action: :index, on: :collection
    end
  end
  
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
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
