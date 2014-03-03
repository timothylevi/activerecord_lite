require_relative 'db_connection'
require_relative '01_mass_object'
require 'active_support/inflector'

class MassObject
  def self.parse_all(results)
    results.map do |hash|
      self.new(hash)
    end
  end
end

class SQLObject < MassObject
  def self.table_name=(table_name)
    @table_name = table_name
  end

  def self.table_name
    @table_name ||= self.name.underscore.pluralize
  end

  def self.columns
    # ...
  end

  def self.all
    results = DBConnection.execute(<<-SQL)
    SELECT #{table_name}.*
    FROM #{table_name}
    SQL

    parse_all(results)
  end

  def self.find(id)
    # ...
  end

  def attributes
    # ...
  end

  def insert
    # ...
  end

  def initialize
    # ...
  end

  def save
    # ...
  end

  def update
    # ...
  end

  def attribute_values
    # ...
  end
end
