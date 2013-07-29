Splitr::Application.routes.draw do
  resource :user, only: %w[new create]
  resource :session, only: %w[new create destroy]
  resources :budgets, only: %w[new create]
  root to: "welcome#index"
end
