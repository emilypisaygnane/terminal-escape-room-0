/* eslint-disable no-console */
const dotenv = require('dotenv');
dotenv.config();
const inquirer = require('inquirer');
const {
  fetchPromptById,
  fetchStateByAction,
  insertState,
  deleteState,
  fetchUserState,
} = require('../lib/utils/fetch-utils.js');
 
const { ship, door, milk, keycard, grapple, crabtree } = require('../lib/utils/ascii');

const start = async () => {
  let currentPrompt = 0;
  let deathCount = 0;
  let displayMessage = '';
  console.clear();
  console.log(
    'The Intergalactic Space Escape is an escape room game. As a player you have traveled into space in search of (something)... The ship has been badly hit by (another thing)... You get knocked out only to wake up to having to fight for your life.', ship
  );
  while (currentPrompt >= 0) {
    if (currentPrompt === 0) {
      await deleteState();
      if (deathCount > 0) console.log(`You have died ${deathCount} times.`);
      currentPrompt = 1;
    }

    if (currentPrompt === 7) {
      console.log(milk);
    } else if (currentPrompt === 12) {
      console.log(door);
    } else if (currentPrompt === 8) {
      console.log(keycard);
    } else if (currentPrompt === 9) {
      console.log(grapple);
    } else if (currentPrompt === 19) {
      console.log(crabtree);
    }
    const response = await fetchPromptById(currentPrompt);

    const answers = await inquirer.prompt({
      prefix: '',
      type: 'list',
      message: response.description,
      name: `prompt ${response.id}`,
      choices: response.actions.map((action) => ({
        name: action.description,
        value: action.id,
      })),
    });
    const chosenAction = response.actions.find((action) => {
      return action.id === answers[`prompt ${response.id}`];
    });
    const state = await fetchStateByAction(chosenAction.id);

    if (state.actionCount === 0 || state.actionCount === state.stateCount) {
      displayMessage = '';
      // Check if the chosen action has a state ID and insert it into the user_state table if not already present
      if (chosenAction.state_id !== null) {
        // Check if the item is already in the user's inventory
        if (await fetchUserState(chosenAction.state_id)) {
          displayMessage = 'You already have this item in your inventory!!';
        } else {
          // Insert the item into the user's inventory
          insertState(chosenAction.state_id);
        }
      }
      currentPrompt = chosenAction.next_prompt_id;
    } else {
      displayMessage =
        'Hmm, you can`t seem to do that yet. Maybe turn back and check around more?? :)';
    }
    if (currentPrompt === 0) {
      deathCount++;
    }
    console.clear();
    console.log(displayMessage);
  }
  console.log(`You died ${deathCount} times.`);
  console.log('Thank you for playing!');
  console.log(`Developed by
  Erik Baxstrom: https://www.linkedin.com/in/erik-baxstrom/
  Eddie Kuo: https://www.linkedin.com/in/eddie-kuo17/
  Emily Pisaygnane: https://www.linkedin.com/in/emily-pisaygnane/
  Tanner Richards: https://www.linkedin.com/in/tannerrichards/
  `);
};
start();
