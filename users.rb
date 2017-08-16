require_relative 'questions_database'
class User

  def self.all
    data = QuestionsDatabase.instance.execute("SELECT * FROM users")
    data.map {|datum| User.new(datum) }
  end

  def self.find_by_name(fname,lname)
    data = QuestionsDatabase.instance.execute(<<-SQL,fname,lname)
      SELECT
        *
      FROM
        users
      WHERE
        users.fname = ? AND
        users.lname = ?
    SQL
    User.new(data.first)

    data.map { |user| User.new(user) }
  end

  def self.find_by_id(id)
    data = QuestionsDatabase.instance.execute(<<-SQL,id)
      SELECT
        *
      FROM
        users
      WHERE
        users.id = ?
    SQL
    User.new(data.first)
  end

  attr_accessor :lname, :fname, :id
  def initialize(options)
    @id = options['id']
    @fname = options['fname']
    @lname = options['lname']
  end

  def authored_questions(id)
    Question.find_by_author_id(id)
  end

  def authored_replies(id)
    Reply.find_by_user_id(id)
  end








end
