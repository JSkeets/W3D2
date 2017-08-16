  CREATE TABLE users (
    id INTEGER PRIMARY KEY ,
    fname TEXT NOT NULL ,
    lname TEXT NOT NULL
  );

  CREATE TABLE questions (
    id INTEGER PRIMARY KEY ,
    title TEXT NOT NULL ,
    body TEXT NOT NULL ,
    author_id INTEGER NOT NULL ,
    FOREIGN KEY (author_id) REFERENCES users(id)
  );

  CREATE TABLE question_follows (
    id INTEGER PRIMARY KEY ,
    question_id INTEGER NOT NULL,
    user_id INTEGER NOT NULL ,

    FOREIGN KEY (question_id) REFERENCES questions(id),
    FOREIGN KEY (user_id) REFERENCES users(id)
  );

  CREATE TABLE replies (
    id INTEGER PRIMARY KEY ,
    question_id INTEGER NOT NULL ,
    parent_reply_id INTEGER ,
    author_id INTEGER NOT NULL ,
    body TEXT NOT NULL ,
    FOREIGN KEY (parent_reply_id) REFERENCES replies(id),
    FOREIGN KEY (question_id) REFERENCES questions(id),
    FOREIGN KEY (author_id) REFERENCES users(id)
  );

  CREATE TABLE question_likes (
    id INTEGER PRIMARY KEY ,
    question_id INTEGER NOT NULL,
    user_id INTEGER NOT NULL ,
    FOREIGN KEY (question_id) REFERENCES questions(id),
    FOREIGN KEY (user_id) REFERENCES users(id)
  );

  INSERT INTO
    users (fname, lname)
  VALUES
    ('Jesse', 'Skeets'),
    ('Nixon', 'Yiu'),
    ('John', 'Doe');

  INSERT INTO
    questions (title, body, author_id)
  VALUES
    ('What is SQL', 'huh', (SELECT id FROM users WHERE fname = 'Nixon')),
    ('What is Ruby', 'huh', (SELECT id FROM users WHERE fname = 'Nixon')),
    ('What is Java', 'huh', (SELECT id FROM users WHERE fname = 'Jesse')),
    ('What is Life', 'huh', (SELECT id FROM users WHERE fname = 'John'));

  INSERT INTO
    question_follows(question_id, user_id)
  VALUES
    (1,1),
    (2,1),
    (3,2),
    (4,3);

  INSERT INTO
    replies (question_id, parent_reply_id, author_id, body)
  VALUES
    (1, null, 1, 'sql is lame'),
    (1, 1,3,'sql suck ~ JOHN'),
    (2,null,2,'I KNOW WHAT RUBY IS');

  INSERT INTO
    question_likes(question_id,user_id)
  VALUES
    (4,1),
    (4,2),
    (4,3),
    (1,1),
    (2,3);
