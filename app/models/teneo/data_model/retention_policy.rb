# frozen_string_literal: true

require_dependency 'teneo/data_model/application_record'

module Teneo::DataModel
  class RetentionPolicy < ApplicationRecord

    self.table_name = 'retention_policies'

  end
end
