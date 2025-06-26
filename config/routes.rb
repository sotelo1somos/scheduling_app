Rails.application.routes.draw do
  root "home#index"

  # Devise
  devise_for :admin_users, path: '', path_names: {
    sign_in: 'login',
    sign_out: 'logout',
    sign_up: 'sign_up'
  }

  # Dashboard
  resource :dashboard, only: [:show]  

  # Técnicos
  resources :technicians, only: [:index, :show]
  get "technicians/:id/timetable", to: "technicians#timetable", as: "technician_timetable"

  # Instalaciones
  resources :installations
end