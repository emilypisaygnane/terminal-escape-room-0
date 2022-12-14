#!/usr/bin/env node
/* eslint-disable no-console */
const dotenv = require('dotenv');
dotenv.config();
const inquirer = require('inquirer');
const Prompt = require('../lib/models/Prompt.js');
const actionState = require('../lib/models/actionState.js');
const userState = require('../lib/models/userState.js');

const start = async () => {
  let currentPrompt = 1;
  while (currentPrompt) {
    
    const response = await Prompt.getById(currentPrompt);
    
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
    // set current action to false
    
    // This would allow you to specify actions of type update_state in the conversation tree, which would update the user's state 
    //with the new values provided in the action's state property. This could be useful for tracking information about the user's 
    //progress through the conversation, or for storing information that the user has provided in previous prompts.
    if (chosenAction.type === 'update_state') {
      // update the user's state with the new values provided in chosenAction.state
      userState = { ...userState, ...chosenAction.state };
    }
    
    currentPrompt = chosenAction.next_prompt_id;
    
  
    console.log(currentPrompt);

  }

};
start();


