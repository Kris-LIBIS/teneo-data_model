Rails.application.routes.draw do
  mount Teneo::DataModel::Engine => "/data"
end
