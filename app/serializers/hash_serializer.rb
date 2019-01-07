# frozen_string_literal: true

require 'json'

class HashSerializer
  def self.dump(hash)
    hash.is_a?(String) ? hash : hash.to_json
  end

  def self.load(hash)
    case hash
    when nil
      {}
    when String
      JSON.parse(hash)
    when Hash
      hash
    else
      {}
    end.with_indifferent_access
  end
end
