Rails.application.routes.draw do
  get 'errors/not_found'
  get 'errors/internal_server_error'
  get 'errors/unprocessable'
  get "navbar", to:'navigation#index'
  
  
  ############ Courses  ###############
  resources :courses, only:[:show] do
    resources :exercises, only:[:new, :create, :destroy, :edit, :update]
  end
  
  ############ Exercises  ###############
  resources :exercises, only:[:show, :index] do
    resources :results, only: [:new, :create]
  end



  get "feed", to:"courses#index"
  get "show-course", to:"courses#show"
  get "new-course", to:"courses#new"
  
  
  
  resources :courses, except:[:index, :new, :show]
  resources :citytowns, except:[:new]
  resources :schools, except:[:new]
  resources :materials, except:[:new]
  resources :levels, except:[:new]
  resources :results, except:[:new, :create]
  
  

  #Dashboard
  get "dashboard", to:'dashboard#index'
  get "setting", to:'dashboard#home'
  get "new-materials", to:"materials#new"
  get "new-levels", to:"levels#new"
  get "new-city", to:"citytowns#new"
  get "new-school", to:"schools#new"


  ##################### START Membership #####################
  get "teacher-sign-up" , to:'membership#teacherUp'
  get "teacher-sign-in" , to:'membership#teacherIn'
  get "ambassadeur-sign-up" , to:'membership#ambassadorUp'
  get "ambassadeur-sign-in" , to:'membership#ambassadorIn'
  get "team-sign-up" , to:'membership#teamUp'
  get "team-sign-in" , to:'membership#teamIn'
  
  devise_scope :user do
    get 'student-sign-in', to: 'devise/sessions#new'
    get 'student-sign-up', to: 'devise/registrations#new', as: "new_user_registration"
    delete 'deconnecter',  to: "devise/sessions#destroy", as: "destroy_user_session_path"
  end
  devise_for :users
  ##################### END Membership #######################

  
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "homepage#index"


  ###### Errors #############
  get '/404', to: 'errors#not_found'
  get '/500', to: 'errors#internal_server'
  get '/422', to: 'errors#unprocessable'

end
