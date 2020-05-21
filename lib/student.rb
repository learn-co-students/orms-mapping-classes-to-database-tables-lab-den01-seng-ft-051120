class Student
  attr_reader :name, :grade, :id

  def initialize(name, grade, id = nil)
    @id = id
    @name = name
    @grade = grade
  end

  def self.create_table
    sql = <<-SQL 
      CREATE TABLE IF NOT EXISTS students (
        id INTEGER PRIMARY KEY,
        name TEXT,
        grade INTEGER
      );
    SQL
    DB[:conn].execute(sql)
  end

  def self.drop_table
    sql = <<-SQL
      DROP TABLE students;
    SQL
    DB[:conn].execute(sql)
  end

  def save 
    sql = <<-SQL
      INSERT INTO students (name, grade) 
      VALUES ( ?, ?);
    SQL
    DB[:conn].execute(sql, name, grade)
    @id = DB[:conn].execute("SELECT students.id
                             FROM students
                             GROUP BY students.id
                             HAVING MAX(students.id);
                             ").first.first
  end

  def self.create (name:, grade: ) 
    student = Student.new(name, grade)
    student.save
    student
  end
end
