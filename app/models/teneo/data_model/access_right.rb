# frozen_string_literal: true

require_dependency 'teneo/data_model/application_record'

module Teneo::DataModel
  class AccessRight < ApplicationRecord

    self.table_name = 'access_rights'

  end
end
