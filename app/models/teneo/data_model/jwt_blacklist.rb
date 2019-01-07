# frozen_string_literal: true

require_dependency 'teneo/data_model/application_record'

module Teneo::DataModel
  class JwtBlacklist < ApplicationRecord

    include Devise::JWT::RevocationStrategies::Blacklist

    self.table_name = 'jwt_blacklist'

  end
end
