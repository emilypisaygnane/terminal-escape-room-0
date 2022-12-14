#!/usr/bin/env node
/* eslint-disable no-console */
const dotenv = require('dotenv');
dotenv.config();
const inquirer = require('inquirer');
const Prompt = require('../lib/models/Prompt.js');
const actionState = require('../lib/models/actionState.js');







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
    // 
    
    currentPrompt = chosenAction.next_prompt_id;
    
  
    console.log(currentPrompt);

  }

};
start();

// SQL QUERY FOR JOINING ACTION_STATE AND USER_STATE
// SELECT COUNT (action_state.state_id) as action_count, COUNT (user_state.state_id) as user_count 
// FROM action_state LEFT JOIN user_state ON action_state.state_id = user_state.state_id
// WHERE action_state.action_id = 11
