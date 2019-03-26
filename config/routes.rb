Rails.application.routes.draw do

  scope :admin, module: 'edu/admin', as: 'admin' do
    resources :course_taxons
    resources :courses do
      get :all, on: :collection
      get :meet, on: :member
      resources :course_crowds, only: [:index, :create, :destroy] do

      end
      resources :course_students do
        post :check, on: :collection
        post :attend, on: :collection
        patch :quit, on: :member
      end
      resources :lessons do
      end
    end
    resources :lessons, only: [] do
      resources :lesson_students
    end
    resources :crowds do
      resources :crowd_students
    end
    resources :course_papers do
      get :add, on: :member
      resources :exams do
        put :refer, on: :member
        patch :score, on: :member
      end
    end
    resources :teachers do
      get :search, on: :collection
    end
    resources :exams, only: [] do
      get :todo, on: :collection
      get :cert, on: :collection
    end
    resources :sm_settings
  end

  scope :my, module: 'edu/my', as: 'my' do
    resources :exams, only: [] do
      post :add, on: :collection
      get :certification, on: :collection
    end
    resources :courses, only: [:index, :show] do
      resources :exams, shallow: true do
        match :finish, on: :member, via: [:get, :put]
      end
    end
    resources :course_students do
      get 'quit' => :edit_quit, on: :member
      patch 'quit' => :update_quit, on: :member
    end
    resource :teacher

  end

end
