Splitr::Application.routes.draw do
  resource :user, only: %i[new create]
  resource :session, only: %i[new create destroy]
  resources :budgets do
    resources :members, only: %i[new create]
    resources :transactions, only: %i[new create edit update destroy]
  end
  root to: "welcome#index"
end
