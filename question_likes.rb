require_relative 'questions_database'

class QuestionLikes

  def self.all
    data = QuestionsDatabase.instance.execute(<<-SQL)
      SELECT
        *
      FROM
        question_likes
    SQL

    data.map { |datum| QuestionLikes.new(datum) }
  end

  def self.find_by_id(id)
    question_likes = QuestionsDatabase.instance.execute(<<-SQL,id)
      SELECT
        *
      FROM
        question_likes
      WHERE
        question_likes.id = ?
    SQL
    QuestionLikes.new(question_likes.first)
  end

  def initialize(options)
    @question_id = options['question_id']
    @user_id = options['user_id']
  end


end
