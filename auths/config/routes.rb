Rails.application.routes.draw do
  namespace :api do
  namespace :v1 do
    post '/register', to: 'authentication#register'
    post '/login', to: 'authentication#login'
    end
  end  
end
