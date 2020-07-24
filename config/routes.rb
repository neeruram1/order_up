Rails.application.routes.draw do
  get "/dishes", to: "dishes#index"
  get "/dishes/:id", to: "dishes#show"
end
