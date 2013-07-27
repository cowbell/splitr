Splitr::Application.routes.draw do
  resource :user, only: %w[new create]
  root to: "welcome#index"
end
