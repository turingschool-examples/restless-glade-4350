Rails.application.routes.draw do

  resources :doctors, only: [:show] do
    resources :patients, only: [:destroy], controller: 'doctor_patients'
  end
  resources :patients, only: [:index]
  resources :hospitals, only: [:show]
end
