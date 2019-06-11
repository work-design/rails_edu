Rails.application.routes.draw do

  scope module: 'edu' do
    resources :courses
  end

  scope :admin, module: 'edu/admin', as: 'admin' do
    resources :crowds do
      resources :crowd_students
    end

    resources :course_taxons
    resources :courses do
      get :plan, on: :collection
      resources :course_crowds do
        delete '' => :destroy, on: :collection
      end
      resources :course_students do
        post :check, on: :collection
        post :attend, on: :collection
        patch :quit, on: :member
        delete '' => :destroy, on: :collection
      end
      resources :lessons do
      end
    end
    resources :lessons, only: [] do
      member do
        get 'plan' => :edit_plan
        patch 'plan' => :update_plan
        delete 'plan' => :destroy_plan
      end
    end
    resources :course_crowds, only: [] do
      get :plan, on: :member
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
  end

  scope :my, module: 'edu/my', as: 'my' do
    resources :exams, only: [] do
      post :add, on: :collection
      get :certification, on: :collection
    end
    resources :courses, only: [:index, :show] do
      collection do
        get :plan
      end
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
