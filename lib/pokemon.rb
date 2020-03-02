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
        INSERT INTO pokemon (name, type, db)
        VALUES (?, ?, ?)
        SQL
    @db.execute(sql, self.name, self.type, self.db)
    @id = @db.execute("SELECT last_insert_rowid() FROM pokemon")[0][0]
  end
  
  def self.find(id)
    sql = <<-SQL
      SELECT * 
      FROM pokemon
      WHERE id = ?
      LIMIT 1
      SQL
    @db.execute(sql).map do | row |
      id = row[0]
      name = row[1]
      type = row[2]
      db = row[3]
      pokemon = Pokemon.new(id, name, type, db)
      pokemon
    end
  end
  
end

