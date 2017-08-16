require_relative 'questions_database'

class QuestionFollows

  def self.all
    data = QuestionsDatabase.instance.execute(<<-SQL)
      SELECT
        *
      FROM
        question_follows
    SQL

    data.map { |datum| QuestionFollows.new(datum) }
  end

  def self.find_by_id(id)
    question_follows = QuestionsDatabase.instance.execute(<<-SQL,id)
      SELECT
        *
      FROM
        question_follows
      WHERE
        question_follows.id = ?
    SQL
    QuestionFollows.new(question_follows.first)
  end

  def initialize(options)
    @question_id = options['question_id']
    @user_id = options['user_id']
  end

end
