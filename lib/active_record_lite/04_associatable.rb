require_relative '03_searchable'
require 'active_support/inflector'

class AssocOptions
  attr_accessor(
    :foreign_key,
    :class_name,
    :primary_key,
  )

  def model_class
    @class_name.constantize
  end

  def table_name
    model_class.table_name
  end

end

class BelongsToOptions < AssocOptions
  def initialize(name, options = {})
    defaults = {
      :class_name => name.to_s.camelcase,
      :foreign_key => "#{name}_id".to_sym,
      :primary_key => :id
    }

    defaults.keys.each do |key|
      self.send("#{key}=", options[key] || defaults[key])
    end
  end
end

class HasManyOptions < AssocOptions
  def initialize(name, self_class_name, options = {})
    defaults = {
      :class_name => name.to_s.singularize.camelcase,
      :foreign_key => "#{self_class_name.underscore}_id".to_sym,
      :primary_key => :id
    }

    defaults.keys.each do |key|
      self.send("#{key}=", options[key] || defaults[key])
    end
  end
end

module Associatable

  def belongs_to(name, options = {})
    options = BelongsToOptions.new(name, options)
    self.assoc_options[name] = options

    define_method(name) do
      key_val = self.send(options.foreign_key)
      options
      .model_class
      .where(options.primary_key => key_val)
      .first
    end
  end

  def has_many(name, options = {})

  end

  def assoc_options

  end
end

class SQLObject
  extend Associatable
end
