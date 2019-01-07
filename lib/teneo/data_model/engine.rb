require 'rack/cors'

module Teneo
  module DataModel
    class Engine < ::Rails::Engine
      isolate_namespace Teneo::DataModel
      config.generators.api_only = true

      config.middleware.insert_before 0, Rack::Cors do
        allow do
          origins '*'

          resource '*',
                   headers: %w(Authorization),
                   methods: [:get, :post, :put, :patch, :delete, :options, :head],
                   expose: %w(Authorization),
                   max_age: 600
        end
      end

      initializer :append_migrations do |app|
        # This prevents mirations from being loaded twice from the inside of the gem itself (dummy test app)
        if app.root.to_s !~ /#root/
          config.paths['db/migrate'].expanded.each do |migration_path|
            app.config.paths['db/migrate'] << migration_path
          end
        end
      end

    end
  end
end
