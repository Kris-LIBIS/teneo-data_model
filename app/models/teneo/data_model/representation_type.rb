# frozen_string_literal: true

require_dependency 'teneo/data_model/application_record'

module Teneo::DataModel
  class RepresentationType < ApplicationRecord

    self.table_name = 'representation_types'

  end
end
