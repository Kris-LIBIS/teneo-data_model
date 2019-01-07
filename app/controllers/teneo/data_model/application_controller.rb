module Teneo
  module DataModel
    class ApplicationController < ActionController::API
      # protect_from_forgery with: :exception

      def render_resource(resource)
        if resource.errors.empty?
          render json: resource
        else
          validation_error(resource)
        end
      end

      def validation_error(resource)
        render json: {
            errors: [
                {
                    status: '400',
                    title: 'Bad Request',
                    detail: resource.errors,
                    code: '100'
                }
            ]
        }, status: :bad_request
      end

    end
  end
end
