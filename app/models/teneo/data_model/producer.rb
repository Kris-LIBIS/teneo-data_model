# frozen_string_literal: true

require_dependency 'teneo/data_model/application_record'

module Teneo::DataModel
  class Producer < ApplicationRecord

    self.table_name = 'producers'

  end
end
