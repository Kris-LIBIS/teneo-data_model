# frozen_string_literal: true

require_dependency 'teneo/data_model/application_record'

module Teneo::DataModel
  class IngestAgreement < ApplicationRecord

    self.table_name = 'ingest_agreements'

  end
end
