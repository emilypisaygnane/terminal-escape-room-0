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
  ('You look around in a dark room, dim lights outline a door, and a few other objects you should check out. But be diligent, your oxygen levels are low and every move matters.'),
  ('At the corner of the room is a window looking out into the vastness of space. A small crack appears to be in the middle of the window.'),
  ('You see a desk with some items that may be of use.'),
  ('A control panel is within reach with lots of buttons and knobs.'),
  ('You see a door, it seems to be locked'),
  ('You lightly tap on the window, the window cracks further sucking you into space. As your body floats into infinity, you feel cold as death takes you. GAME OVER!'),
  ('GROSS! Spoiled milk but this may come in handy later, I should pick it up.'),
  ('A key card! Maybe it could be used to open the door?'),
  ('A large pipe, this could be useful later!'),
  ('The control panel sparks, it seems to have some power'),
  ('ALERT! Oxygen levels are running low, proceed to the next room to assess the damage.'),
  ('You have succesfully restored the ship to habitable conditions, consider your duties complete. YOU WON!');
  

CREATE TABLE actions (
  id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  prompt_id BIGINT,
  description VARCHAR NOT NULL,
  next_prompt_id BIGINT
);

INSERT INTO 
  actions (prompt_id, description, next_prompt_id)
VALUES
  (1, 'Examine Window', 2),
  (1, 'Examine Desk', 3),
  (1, 'Examine Control Panel', 4),
  (1, 'Examine Door', 5),
  (2, 'Examine Crack', 6),
  (3, 'Examine Milk', 7),
  (3, 'Examine Key Card', 8),
  (3, 'Examine Pipe', 9),
  (4, 'Pour milk on Control Panel', 10),
  (4, 'Push Big Red Button', 11),
  (5, 'Use Key Card', 12),
  (7, 'Pick up Milk', 3),
  (8, 'Pick up Key Card', 3),
  (9, 'Pick up Pipe', 3);

CREATE TABLE state (
  id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  description VARCHAR NOT NULL
);

INSERT INTO
  state (description)
VALUES
  ('Spoiled Milk'),
  ('Blue Key Card'),
  ('Pipe'),
  ('Power Is On');

CREATE TABLE action_state (
  action_id BIGINT,
  state_id BIGINT,
  default_display BOOLEAN,
  FOREIGN KEY (action_id) REFERENCES actions(id),
  FOREIGN KEY (state_id) REFERENCES state(id)
);

INSERT INTO 
  action_state (action_id, state_id, default_display)
VALUES
  (6, 1, TRUE),
  (7, 2, TRUE),
  (8, 3, TRUE),
  (10, 4, TRUE),
  (11, 2, FALSE),
  (12, 1, TRUE),
  (13, 2, TRUE),
  (14, 3, TRUE);

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

