# frozen_string_literal: true

require_dependency 'teneo/data_model/application_record'

module Teneo::DataModel

  class Organization < ApplicationRecord

    self.table_name = 'organizations'

    belongs_to :producer
    belongs_to :material_flow

    has_many :memberships, dependent: :destroy
    has_many :users, through: :memberships

    accepts_nested_attributes_for :memberships, allow_destroy: true

    serialize :upload_areas, HashSerializer

    def self.from_hash(hash)
      super(hash) do |item, h|
        if (producer_name = h.delete(:producer))
          producer = Producer.find_by(name: producer_name)
          item.producer = producer if producer
          puts "Could not find producer '#{producer_name}'" unless producer
        end
        if (material_flow_name = h.delete(:material_flow))
          material_flow = MaterialFlow.find_by(name: material_flow_name)
          item.material_flow = material_flow if material_flow
          puts "Could not find material flow '#{material_flow_name}'" unless material_flow
        end
      end
    end

  end
end
