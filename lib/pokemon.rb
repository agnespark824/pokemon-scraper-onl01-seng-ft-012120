require 'pry'

class Pokemon
  attr_accessor :name, :type, :db
  attr_reader :id
  
  def initialize(id:, name:, type:, db:)
    @id = id
    @name = name
    @type = type
    @db = db
  end

  def self.save(name, type, db)
    sql = <<-SQL
        INSERT INTO pokemon (name, type)
        VALUES (?, ?)
        SQL
    db.execute(sql, name, type)
    @id = db.execute("SELECT last_insert_rowid() FROM pokemon")[0][0]
  end
  
  def self.find(id, db)
    sql = <<-SQL
      SELECT * 
      FROM pokemon
      WHERE id = ?
      SQL

    attributes = db.execute(sql, id)[0]
    Pokemon.new(id: attributes[0], name: attributes[1], type: attributes[2], db: attributes[3])
  end
end

