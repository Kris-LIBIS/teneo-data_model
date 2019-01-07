module Teneo::DataModel
  class ApplicationRecord < ActiveRecord::Base
    self.abstract_class = true
  end

  def self.from_hash(hash, id_tags = [:name], &block)
    self.create_from_hash(hash.cleanup, id_tags, &block)
  end

  def self.create_from_hash(hash, id_tags, &block)
    hash = hash.key_strings_to_symbols(recursive: true)
    id_tags = id_tags.map(&:to_sym)
    unless id_tags.empty? || id_tags.any? { |k| hash.include?(k) }
      error "Could not create '#{self.name}' object from Hash since none of the id tags '#{id_tags.join(',')}' are present"
      return nil
    end
    tags = id_tags.inject({}) do |h, k|
      v = hash.delete(k)
      h[k] = v if v
      h
    end
    item = tags.empty? ? self.new : self.find_or_initialize_by(tags)
    # item.attributes.clear
    block.call(item, hash) if block unless hash.empty?
    item.assign_attributes(hash)
    item.save!
    item
  end

  def to_hash
    result = self.attributes.reject { |k, v| v.blank? || volatile_attributes.include?(k) }
    result = result.to_yaml
    # noinspection RubyResolve
    result = YAML.load(result)
    result.key_strings_to_symbols!(recursive: true)
  end

  def to_s
    (self.name rescue nil) || "#{self.class.name}_#{self.id}"
  end

  protected

  def volatile_attributes
    %w'id created_at updated_at'
  end

  def copy_attributes(other)
    self.set(
        other.attributes.reject do |k, _|
          volatile_attributes.include? k.to_s
        end.each_with_object({}) do |(k, v), h|
          h[k] = v.duplicable? ? v.dup : v
        end
    )
    self
  end

end
