# frozen_string_literal: true

require_dependency 'teneo/data_model/application_record'

module Teneo::DataModel
  class StatusLog < ApplicationRecord

    self.table_name = 'status_logs'

  end
end
