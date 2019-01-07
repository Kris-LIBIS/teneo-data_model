# frozen_string_literal: true

require_dependency 'teneo/data_model/application_record'

module Teneo::DataModel
  class Role < ApplicationRecord

    self.table_name = 'roles'

    def self.from_hash(hash)
      super(hash, [:code])
    end

  end
end
