# frozen_string_literal: true

require_dependency 'teneo/data_model/application_record'

module Teneo::DataModel
  class Format < ApplicationRecord

    self.table_name = 'formats'

  end
end
