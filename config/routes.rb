Teneo::DataModel::Engine.routes.draw do
  scope :session do
    devise_for :users,
               class_name: "Teneo::DataModel::User",
               path: '',
               path_names: {
                   sign_in: 'login',
                   sign_out: 'logout'
               },
               controllers: {
                   sessions: 'teneo/data_model/sessions'
               }
    get 'current', to: 'teneo/data_model/sessions#show'
  end

end
