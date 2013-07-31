Splitr::Application.routes.draw do
  resource :user, only: %i[new create]
  resource :session, only: %i[new create destroy]
  resources :budgets, only: %i[index new create]
  root to: "welcome#index"
end
