Rails.application.routes.draw do



  get 'cart/show'

  get 'cart/edit'

  get 'cart/confirmation'

  namespace :admin do
    root to:  'products#index'       # i taki zapis spowoduje ze wejscie do akcji /admin przekieruje nas na root glowny-strone glowna
    resources :products
    resources :categories
  end
  # gdy wpiszemy adres /admin/products  - to wejdziemy na products
  # a co jezeli wpiszemy /admin - to tu takze powinien nas skierowac w odpowiednia akcje
  # wiec dajemy root to: 'products#index'


  # Te adresy takze usowamy i zastapimy je innym rozwiazaniem
  #get 'static/terms'
  #get 'static/privacy'
  #get 'static/shipping'
  #get 'static/about'

  get 'regulamin', to: "static#terms", as: :terms                # Czyli wchodzac do akcji (slesh regulamin) /regulamin,
                                                                 # bedziemy kierowac do kotrollera static i akcji terms i url nazwiemy terms (termss_path)
  get 'polityka-prywatnosci', to: "static#privacy", as: :privacy
  get 'dostawa', to: "static#shipping", as: :shipping
  get 'o-sklepie', to: "static#about", as: :about







  #usowamy ale je zastapimy je resources
  #get 'categories/show'
  #get 'products/index'
  #get 'products/show'

  resources :products, only: [:show, :index], path: "produkt"       # nasz resources products bedzie posiadal tylko dwie akcje   SPOLSZCZMY NASZA NAZWE W PASKU
  resources :categories, only: [:show] , path: "kategoria"          # dodatkowo zadeklarujemy kategorie  I TU TAKZE SPOLSZCZMY
  root to: 'products#index'                      #nasz glowny adres




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
