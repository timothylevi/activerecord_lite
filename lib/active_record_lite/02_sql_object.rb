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
    results = DBConnection.execute(<<-SQL, id)
    SELECT #{table_name}.*
    FROM #{table_name}
    WHERE #{table_name}.id = ?
    SQL

    parse_all(results).first
  end

  def insert
    col_names = self.class.attributes.join(", ")
    question_marks = (["?"] * self.class.attributes.count).join(", ")

    DBConnection.execute(<<-SQL, *attribute_values)
    INSERT INTO #{self.class.table_name} (#{col_names})
    VALUES (#{question_marks})
    SQL

    self.id = DBConnection.last_insert_row_id
  end


  def attributes
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
