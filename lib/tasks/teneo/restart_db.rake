task 'db:restart' => %w(db:drop db:create db:schema:cache:clear db:migrate db:seed) do
end
