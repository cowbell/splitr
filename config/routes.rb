Splitr::Application.routes.draw do
  resource :user, only: %w[new create]
  resource :session, only: %w[new create destroy]
  root to: "welcome#index"
end
