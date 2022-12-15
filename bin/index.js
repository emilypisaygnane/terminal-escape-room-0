#!/usr/bin/env node
/* eslint-disable no-console */
// const dotenv = require('dotenv');
// dotenv.config();
// const inquirer = require('inquirer');
// const Prompt = require('../lib/models/Prompt.js');
// const actionState = require('../lib/models/actionState.js');
// const userState = require('../lib/models/userState.js');

// const start = async () => {
//   let currentPrompt = 1;
//   while (currentPrompt) {
//     const response = await Prompt.getById(currentPrompt);

//     const answers = await inquirer.prompt({
//       prefix: '*',
//       type: 'list',
//       message: response.description,
//       name: `prompt ${response.id}`,
//       choices: response.actions.map((action) => ({
//         name: action.description,
//         value: action.id,
//       })),
//     });
//     const chosenAction = response.actions.find((action) => {
//       return action.id === answers[`prompt ${response.id}`];
//     });
//     const state = await actionState.checkActionState(chosenAction.id);
//     // const inventoryList = await userState.getAll();
//     // console.log('inventoryList', inventoryList);
//     // const inventory = inventoryList.map((item) => item.state_id);

//     // console.log('inventory', inventory);

//     if (state.actionCount === 0 || state.actionCount === state.stateCount) {
//       // if (action.state_id not null)
//       // if (chosenAction.state_id !== null && !inventory.includes(chosenAction.state_id)) {
//       if (chosenAction.state_id !== null && ! (await userState.getById(chosenAction.state_id))) {
//       // console.log('inserting into user_state:', chosenAction.state_id);
//         //insert the state_id into the user_state table
//         userState.insert(chosenAction.state_id);
//       } else {
//         console.log('You already have this item in your inventory!!');
//       }
//       currentPrompt = chosenAction.next_prompt_id;
//     } else {
//       console.log(
//         'Hmm, you can`t seem to do that yet. Maybe turn back and check around more?? :)'
//       );
//     }

//     console.log(currentPrompt);
//   }
// };
// start();

const dotenv = require('dotenv');
dotenv.config();
const inquirer = require('inquirer');
const userState = require('../lib/models/userState.js');
const {
  fetchPromptById,
  fetchStateByAction,
  insertState,
} = require('../lib/utils/fetch-utils.js');

const start = async () => {
  let currentPrompt = 0;
  console.log('Welcome to our game for the first time.');
  while (currentPrompt >= 0) {
    if (currentPrompt === 0) {
      await userState.deleteUserState();
      currentPrompt = 1;
    }
    const response = await fetchPromptById(currentPrompt);

    const answers = await inquirer.prompt({
      prefix: '*',
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
      // Check if the chosen action has a state ID and insert it into the user_state table if not already present
      if (chosenAction.state_id !== null) {
        // Check if the item is already in the user's inventory
        if (await userState.getById(chosenAction.state_id)) {
          console.log('You already have this item in your inventory!!');
        } else {
          // Insert the item into the user's inventory
          insertState(chosenAction.state_id);
        }
      }
      currentPrompt = chosenAction.next_prompt_id;
    } else {
      console.log(
        'Hmm, you can`t seem to do that yet. Maybe turn back and check around more?? :)'
      );
    }

    console.log(currentPrompt);
  }
};
start();
