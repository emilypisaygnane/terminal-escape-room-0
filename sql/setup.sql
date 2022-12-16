DROP TABLE
  IF EXISTS users CASCADE;

DROP TABLE
  IF EXISTS prompts CASCADE;

DROP TABLE
  IF EXISTS actions CASCADE;

DROP TABLE
  IF EXISTS state CASCADE;

DROP TABLE
  IF EXISTS action_state CASCADE;

DROP TABLE
  IF EXISTS user_state CASCADE;

CREATE TABLE
  users (
    id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    username VARCHAR,
    password_hash VARCHAR NOT NULL
  );

INSERT INTO
  users (username, password_hash)
VALUES
  ('default', 'default');

CREATE TABLE
  prompts (
    id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    description VARCHAR NOT NULL
  );

INSERT INTO
  prompts (description)
VALUES
  (
    'You look around in a dark room, dim lights outline a door, and a few other objects you should check out. But be diligent, your oxygen levels are low and every move matters.'
  ),
  (
    'At the corner of the room is a window looking out into the vastness of space. A small crack appears to be in the middle of the window.'
  ),
  (
    'You see a desk with some items that may be of use.'
  ),
  (
    'A control panel is within reach with lots of buttons and knobs.'
  ),
  ('You see a door, it seems to be locked'),
  (
    'You lightly tap on the window, the window cracks further sucking you into space. As your body floats into infinity, you feel the cold grip of death approaching you. Quick use the Grappling Hook!'
  ),
  (
    'GROSS! Spoiled milk but this may come in handy later, I should pick it up.'
  ),
  (
    'A key card! Maybe it could be used to open the door?'
  ),
  (
    'Oh snap! A Grapple Hook, this could be useful later!'
  ),
  (
    'The control panel sparks, it seems to have some power'
  ),
  (
    'ALERT! Oxygen levels are running low, proceed to the next room to assess the damage.'
  ),
  (
    'You have successfully gained access to the captains quarters. A loud noise is coming from the back of the room near all the generators.'
  ),
  (
    'It sounds like the oxygen stabilizer is damaged in the next room, I should look around in case it needs fixing.'
  ),
  (
    'The captains locker at the far side of the quarters may be worth checking out, The bedroom next to you could contain a few essentials, and the pilots room may help you restore power.'
  ),
  (
    'The captains locker seems to be full of junk, but maybe you can make use of some of these items in the future'
  ),
  (
    'Hey, this large hosing tube may be useful for fixing the oxygen stabalizer, I should pick this up!'
  ),
  (
    'The adminstrators hyperpad, I wonder what priveleges this gives me?'
  ),
  (
    'The bunkroom has been destroyed, something or someone has been in here. You hear something behind you. It is a Crabtree Alien! The Alien reaches down and grabs you, hugging and crushing you from sheer force.'
  ),
  (
    'The Crabtree Alien has killed you. What luck. GAME OVER SCRUB!'
  ),
  (
    'The pilots room is locked, but you can see the oxygen generator inside'
  ),
  (
    '*AI Voice* "Access Granted! Welcome Captain!" *AI Voice*'
  ),
  (
    '*AI Voice* "The oxygen stabalizer needs immediate repair, oxygen levels are at 2%" *AI Voice*'
  ),
  (
    'The oxygen stabalizer has a blown tube on the spline reticulator'
  ),
  (
    '*AI Voice* "Congratulations Captain, The Oxygen Stabalizer has been repaired. You have escaped impending doom! Give yourself a pat on the back, because tomorrow will be full of new surpirses." *AI Voice*'
  ),
  (
    'You die the most lonliest of deaths, GAME OVER SCRUB!'
  ),
  (
    'Whew! That was a close one, good thing we had batmans powers for a moment.'
  ),
  (
    'You have succesfully accessed the room with the oxygen generator. You fix it, restoring the ship to habitable conditions, consider your duties complete. YOU WON!'
  ),
  (
    'It sounds like the oxygen stabilizer is damaged in the next room, I should look around in case it needs fixing.'
  );
  
  CREATE TABLE
  state (
    id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    description VARCHAR NOT NULL
  );

INSERT INTO
  state (description)
VALUES
  ('Spoiled Milk'),
  ('Key Card'),
  ('Grapple Hook'),
  ('Large Hosing Tube'),
  ('Adminstrators Hyperpad');

CREATE TABLE
  actions (
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
  (1, 'Examine Window', 2, null),
  (1, 'Examine Desk', 3, null),
  (1, 'Examine Control Panel', 4, null),
  (1, 'Examine Door', 5, null),
  (2, 'Examine Crack', 6, null),
  (2, 'Go Back', 1, null),
  (3, 'Examine Milk', 7, null),
  (3, 'Examine Key Card', 8, null),
  (3, 'Examine Grapple Hook', 9, null),
  (3, 'Go Back', 1, null),
  (4, 'Pour Milk on Control Panel', 10, null),
  (4, 'Push Big Red Button', 11, 4),
  (4, 'Go Back', 1, null),
  (5, 'Use Key Card', 12, null),
  (5, 'Go Back', 1, null),
  (6, 'Use Grapple Hook', 26, null),
  (6, 'Float off into space...', 0, null),
  (7, 'Pick Up Milk', 3, 1),
  (7, 'Go Back', 3, null),
  (8, 'Pick Up Key Card', 3, 2),
  (8, 'Go Back', 3, null),
  (9, 'Pick Up Grapple Hook', 3, 3),
  (9, 'Go Back', 3, null),
  (10, 'Next', 4, null),
  (11, 'Next', 13, null),
  (13, 'Next', 4, null),
  (12, 'Enter Room', 14, null),
  (12, 'Go Back', 1, null),
  (14, 'Examine Captains Locker', 15, null),
  (14, 'Examine Bedroom', 18, null),
  (14, 'Examine Pilots Room', 20, null),
  (14, 'Go Back To First Room', 1, null),
  (15, 'Examine Large Hosing Tube', 16, null),
  (15, 'Examine Administrator Hyperpad', 17, null),
  (15, 'Go Back', 14, null),
  (16, 'Pickup Large Hosing Tube', 15, 4),
  (16, 'Go Back', 15, null),
  (17, 'Pickup Adminstrator Hyperpad', 15, 5),
  (17, 'Go Back', 15, null),
  (18, 'Next', 19, null),
  (19, 'Play Again', 0, null),
  (20, 'Unlock Door', 21, null),
  (20, 'Go Back', 14, null),
  (21, 'Next', 22, null),
  (22, 'Examine Oxygen Generator', 23, null),
  (23, 'Use Large Hosing Tube', 24, null),
  (24, 'Next', -1, null),
  (25, 'Next', 0, null),
  (26, 'Next', 1, null);

CREATE TABLE
  action_state (
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
  (14, 2, TRUE),
  (16, 3, TRUE),
  (42, 5, TRUE),
  (46, 4, TRUE);

CREATE TABLE
  user_state (
    user_id BIGINT,
    state_id BIGINT,
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (state_id) REFERENCES state(id)
  );
