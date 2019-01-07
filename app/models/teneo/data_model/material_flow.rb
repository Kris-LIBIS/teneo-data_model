# frozen_string_literal: true

require_dependency 'teneo/data_model/application_record'

module Teneo::DataModel
  class MaterialFlow < ApplicationRecord

    self.table_name = 'material_flow'

  end
end
