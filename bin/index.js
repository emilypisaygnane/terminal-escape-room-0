#!/usr/bin/env node
/* eslint-disable no-console */
const dotenv = require('dotenv');
dotenv.config();
const inquirer = require('inquirer');
const Prompt = require('../lib/models/Prompt.js');






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
    currentPrompt = chosenAction.next_prompt_id;
    console.log(currentPrompt);
  }
};
start();


