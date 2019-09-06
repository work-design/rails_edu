Rails.application.routes.draw do

  scope module: 'edu' do
    resources :courses
  end

  scope :admin, module: 'edu/admin', as: 'admin' do
    
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
