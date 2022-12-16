-- The SQL in this file will be executed when you run `npm run setup-db`
DROP TABLE IF EXISTS users CASCADE;
DROP TABLE IF EXISTS prompts CASCADE;
DROP TABLE IF EXISTS actions CASCADE;
DROP TABLE IF EXISTS state CASCADE;
DROP TABLE IF EXISTS action_state CASCADE;
DROP TABLE IF EXISTS user_state CASCADE;


CREATE TABLE users (
  id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  username VARCHAR,
  password_hash VARCHAR NOT NULL
);

INSERT INTO 
  users (username, password_hash)
VALUES
  ('default', 'default');

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
  ('Oh snap! A Grapple Hook, this could be useful later!'),
  ('The control panel sparks, it seems to have some power'),
  ('ALERT! Oxygen levels are running low, proceed to the next room to assess the damage.'),
  ('You have successfully gained access to the captains quarters. A loud noise is coming from the back of the room near all the generators.'),
  ('It sounds like the oxygen stabilizer is damaged in the next room, I should look around in case it needs fixing.'),
  ('The captains locker at the far side of the quarters may be worth checking out, The bedroom next to you could contain a few essentials, and the pilots room may help you restore power.'),
  ('The captains locker seems to be full of junk, but maybe you can make use of some of these items in the future'),
  ('Hey, this large hosing tube may be useful for fixing the oxygen stabalizer, I should pick this up!'),
  ('The adminstrators hyperpad, I wonder what priveleges this gives me?'),
  ('The bedroom has been destroyed, something or someone has been in here. You hear something behind you.' 'It is a Crabtree Alien! The Alien reaches down and grabs you, hugging and crushing you from sheer force.'),
  ('"The Crabtree Alien has killed you. What luck. GAME OVER SCRUB!"');
  ('The pilots room is locked, but you can see the oxygen generator inside'),
  ('*AI Voice* "Access Granted! Welcome Captain!" *AI Voice*'),
  ('*AI Voice* "The oxygen stabalizer needs immediate repair, oxygen levels are at 2%" *AI Voice*'),
  ('*AI Voice* "Congratulations Captain, The Oxygen Stabalizer has been repaired. "You have escaped impending doom! Give yourself a pat on the back, because tomorrow will be full of new surpirses." YOU WIN! *AI Voice*'),
  ('You die the most lonliest of deaths, GAME OVER SCRUB!'),
  ('Quick, Hurry! Use the grapple hook to get back to the ship.')
  ('Whew! That was a close one, good thing we had batmans powers for a moment.');
  
CREATE TABLE state (
  id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  description VARCHAR NOT NULL
);

INSERT INTO
  state (description)
VALUES
  ('Spoiled Milk'),
  ('Key Card'),
  ('Grapple Hook'),
  ('Power Is On'),
  ('Large Hosing Tube'),
  ('Adminstrators Hyperpad');
  

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
  (3, 'Examine Grapple Hook', 9, null),
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
  (6, 'Play Again', 0, null),
  (10, 'Next', 4, null),
  (11, 'Next', 13, null),
  (13, 'Next', 4, null),
  (12, 'Exit', -1, null);


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
