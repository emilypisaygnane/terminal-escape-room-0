-- Use this file to define your SQL tables
-- The SQL in this file will be executed when you run `npm run setup-db`
DROP TABLE IF EXISTS users CASCADE;
DROP TABLE IF EXISTS prompts CASCADE;
DROP TABLE IF EXISTS actions CASCADE;
DROP TABLE IF EXISTS state CASCADE;
DROP TABLE IF EXISTS action_state CASCADE;
DROP TABLE IF EXISTS user_state CASCADE;


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
  ('You have succesfully accessed the room with the oxygen generator. You fix it, restoring the ship to habitable conditions, consider your duties complete. YOU WON!'),
  ('It sounds like the oxygen stabilizer is damaged in the next room, I should look around in case it needs fixing.');
  
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

CREATE TABLE actions (
  id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  prompt_id BIGINT,
  description VARCHAR NOT NULL,
  next_prompt_id BIGINT,
  state_id BIGINT,
  FOREIGN KEY (state_id) REFERENCES state(id)
);

INSERT INTO 
  actions (prompt_id, description, next_prompt_id, state_id)
VALUES
  (1, 'Examine window', 2, null),
  (1, 'Examine desk', 3, null),
  (1, 'Examine control panel', 4, null),
  (1, 'Examine door', 5, null),
  (2, 'Examine crack', 6, null),
  (2, 'Go back', 1, null),
  (3, 'Examine milk', 7, null),
  (3, 'Examine key card', 8, null),
  (3, 'Examine pipe', 9, null),
  (3, 'Go back', 1, null),
  (4, 'Pour milk on control panel', 10, null),
  (4, 'Push big red button', 11, 4),
  (4, 'Go back', 1, null),
  (5, 'Use key card', 12, null),
  (5, 'Go back', 1, null),
  (7, 'Pick up milk', 3, 1),
  (7, 'Go back', 3, null),
  (8, 'Pick up key card', 3, 2),
  (8, 'Go back', 3, null),
  (9, 'Pick up pipe', 3, 3),
  (9, 'Go back', 3, null),
  (6, 'Play Again', 1, null),
  (10, 'Next', 4, null),
  (11, 'Next', 13, null),
  (13, 'Next', 4, null),
  (12, 'Play Again', 1, null);

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
  (11, 1, TRUE),
  (14, 2, TRUE);

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

