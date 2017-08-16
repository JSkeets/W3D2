require_relative 'questions_database'
require_relative 'questions'

class Replies

  def self.all
    data = QuestionsDatabase.instance.execute(<<-SQL)
      SELECT
        *
      FROM
        replies
    SQL

    data.map { |datum| Replies.new(datum) }
  end

  def self.find_by_id(id)
    reply = QuestionsDatabase.instance.execute(<<-SQL,id)
      SELECT
        *
      FROM
        replies
      WHERE
        replies.id = ?
    SQL
    Replies.new(reply.first)
  end
  attr_accessor :question_id, :parent_reply_id, :author_id, :body

  def initialize(options)
    @question_id = options['question_id']
    @parent_reply_id = options['parent_reply_id']
    @author_id = options['author_id']
    @body = options['body']
  end

  def self.find_by_user_id(user_id)
    user_id = QuestionsDatabase.instance.execute(<<-SQL,user_id)
      SELECT
        *
      FROM
        replies
      WHERE
        replies.author_id = ?
    SQL
  end

  def self.find_by_question_id(question_id)
    questions_id = QuestionsDatabase.instance.execute(<<-SQL, question_id)
      SELECT
        *
      FROM
        replies
      WHERE
        replies.question_id = ?
    SQL
  end

  def author
    User.find_by_id(author_id)
  end

  def question
    Question.find_by_id(question_id)
  end

  def parent_reply
    Replies.find_by_id(parent_reply_id)
  end

  def child_reply
    Replies.all.each do |reply|
      return reply if parent_reply_id = question_id
    end
  end
end
