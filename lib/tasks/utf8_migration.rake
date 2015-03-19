namespace :utf8_migration do
  desc "Database migration to UTF-8"

  task(:run => :environment) do
    # This task is for converting the database to the utf8mb4 character set.
    # However, it assumes that the existing state of the database is
    # UTF-8 data stored (falsely) in the latin1 charset in MySQL.
    # This was how inventario installations funtioned by default before v0.6.0.

    connection = ActiveRecord::Base.connection
    connection.execute "ALTER DATABASE #{connection.current_database} CHARACTER SET utf8mb4"

    connection.execute "SET foreign_key_checks = 0;"
    tables = connection.tables.each { |table|
      puts "Examine table #{table}"
      connection.execute "ALTER TABLE #{table} CHARACTER SET utf8mb4"

      connection.columns(table).each{ |column|
        next if ![:string, :text].include?(column.type)
        name = column.name
        if column.type == :text
          tmptype = "blob"
        else
          tmptype = column.sql_type.gsub("varchar", "varbinary")
        end
        puts "Migrating #{column.sql_type} column #{name}"
        connection.execute "ALTER TABLE #{table} MODIFY `#{name}` #{tmptype};"
        connection.execute "ALTER TABLE #{table} MODIFY `#{name}` #{column.sql_type} CHARACTER SET utf8mb4;"
      }
    }

    connection.execute "SET foreign_key_checks = 1;"
  end
end
