# frozen_string_literal: true

require_dependency 'teneo/data_model/application_record'

module Teneo::DataModel
  class Membership < ApplicationRecord

    self.table_name = 'memberships'

    belongs_to :user
    belongs_to :organization

    enum role: {admin: 'admin', uploader: 'uploader', ingester: 'ingester'}

    def self.from_hash(hash)
      super(hash, []) do |item, h|
        email = h.delete(:user)
        _user = User.find_by(email: email)
        puts "Could not find user '#{email}'" unless _user
        item.user = _user

        organization_name = h.delete(:organization)
        _organization = Organization.find_by(name: organization_name)
        puts "Could not find organization '#{organization_name}'" unless _organization
        item.organization = _organization
      end
    end

  end
end
