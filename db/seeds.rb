# frozen_string_literal: true

require 'tty-prompt'
require 'tty-spinner'

class SeedLoader
  attr_reader :base_dir, :prompt

  def initialize(base_dir)
    @base_dir = base_dir
    @prompt = TTY::Prompt.new
    load
  end

  protected

  def load
    load_data :access_right, namespace: Teneo::DataModel
    load_data :retention_policy, namespace: Teneo::DataModel
    load_data :producer, namespace: Teneo::DataModel
    load_data :material_flow, namespace: Teneo::DataModel
    load_data :representation_type, namespace: Teneo::DataModel
    load_data :role, namespace: Teneo::DataModel
    load_data :organization, namespace: Teneo::DataModel
    load_data :user, namespace: Teneo::DataModel
    load_data :ingest_model, namespace: Teneo::DataModel
    load_data :format, namespace: Teneo::DataModel
  end

  private

  def load_data(klass_name, klass: nil, namespace: nil)
    namespaces = namespace.to_s.split('::')
    namespaces << klass_name.to_s.classify
    klass ||= "#{namespaces.join('::')}".constantize
    spinner = TTY::Spinner::new("[:spinner] Loading #{klass_name}(s) :file :name", interval: 4)
    spinner.auto_spin
    spinner.update(file: '...', name: '')
    spinner.start
    Dir.children(base_dir).select {|f| f =~ /\.#{klass_name}\.yml$/}.sort.each do |filename|
      spinner.update(file: "from '#{filename}'")
      path = File.join(base_dir, filename)
      data = YAML.load_file(path)
      case data
      when Array
        data.each do |x|
          (n = x[:name] || x['name']) && spinner.update(name: "object '#{n}'")
          klass.from_hash(x)
          spinner.update(name: '')
        end
      when Hash
        klass.from_hash(data)
      else
        prompt.error "Illegal file content: 'path' - either Array or Hash expected."
      end
      spinner.update(file: '...')
    end
    spinner.update(file: '- Done', name: '!')
    spinner.success
  end

end

# dir = File.dirname __FILE__
# SeedLoader.new(dir)
