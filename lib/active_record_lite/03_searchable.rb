require_relative 'db_connection'
require_relative '02_sql_object'

module Searchable
  def where(params)
    col_names = params.keys.map { |key| "#{key} = ?"}.join(" AND ")
    row_values = params.values

    results = DBConnection.execute(<<-SQL, *row_values)
    SELECT *
    FROM #{table_name}
    WHERE #{col_names}
    SQL

    parse_all(results)
  end
end

class SQLObject
  # Mixin Searchable here...
end
