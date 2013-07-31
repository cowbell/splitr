Splitr::Application.routes.draw do
  resource :user, only: %i[new create]
  resource :session, only: %i[new create destroy]
  resources :budgets, only: %i[index show new create] do
    resources :members, only: %i[new create]
  end
  root to: "welcome#index"
end
