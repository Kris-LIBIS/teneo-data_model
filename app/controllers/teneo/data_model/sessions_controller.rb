# freeze_string_literal: true

module Teneo::DataModel
  class SessionsController < Devise::SessionsController
    # protect_from_forgery with: :null_session
    respond_to :json

    def show
       if self.resource
         respond_with(resource, serialize_options(resource))
       else
         render json: {
             errors: [
                 {
                     status: '403',
                     title: 'Not logged in'
                 }
             ]
         }, status: :forbidden
       end
    end

    private

    def respond_with(resource, _opts = {})
      render json: resource
    end

    def respond_to_on_destroy
      head :no_content
    end

  end
end
