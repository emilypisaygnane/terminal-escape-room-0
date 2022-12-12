-- Use this file to define your SQL tables
-- The SQL in this file will be executed when you run `npm run setup-db`
DROP TABLE IF EXISTS users CASCADE;
DROP TABLE IF EXISTS prompts CASCADE;
DROP TABLE IF EXISTS actions CASCADE;
DROP TABLE IF EXISTS state CASCADE;
DROP TABLE IF EXISTS action_state;
DROP TABLE IF EXISTS user_state;

CREATE TABLE users (
  id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  email VARCHAR,
  password_hash VARCHAR NOT NULL,
  first_name VARCHAR NOT NULL,
  last_name VARCHAR NOT NULL
);

INSERT INTO 
  users (email, password_hash, first_name, last_name)
VALUES
  ('default', 'default', 'default', 'default');

CREATE TABLE prompts (
  id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  description VARCHAR NOT NULL
);

INSERT INTO
  prompts (description)
VALUES
  ('default');

CREATE TABLE actions (
  id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  prompt_id BIGINT,
  description VARCHAR NOT NULL,
  next_prompt_id BIGINT
);

INSERT INTO 
  actions (prompt_id, description, next_prompt_id)
VALUES
  (1, 'default', 2);

CREATE TABLE state (
  id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  description VARCHAR NOT NULL
);

INSERT INTO
  state (description)
VALUES
  ('default');

CREATE TABLE action_state (
  action_id BIGINT,
  state_id BIGINT,
  FOREIGN KEY (action_id) REFERENCES actions(id),
  FOREIGN KEY (state_id) REFERENCES state(id)
);

INSERT INTO 
  action_state (action_id, state_id)
VALUES
  (1, 1);

CREATE TABLE user_state (
  user_id BIGINT,
  state_id BIGINT,
  FOREIGN KEY (user_id) REFERENCES users(id),
  FOREIGN KEY (state_id) REFERENCES state(id)
);

INSERT INTO 
  user_state (user_id, state_id)
VALUES
  (1, 1);
  
