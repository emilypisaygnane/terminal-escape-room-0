#!/usr/bin/env node
/* eslint-disable no-console */
const dotenv = require('dotenv');
dotenv.config();
const inquirer = require('inquirer');
const Prompt = require('../lib/models/Prompt.js');
const { getPromptById } = require('./utils/fetch-utils');

console.log('hello world!');
// getPromptById(1);

// const something = await getPromptById(1);
// console.log(something);

const start = async () => {
  let currentPrompt = 1;
  while (currentPrompt) {
    // const response = await getPromptById(currentPrompt);
    const response = await Prompt.getById(currentPrompt);
    //display the prompt and options, get the user input
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

// const response = {
//   description: 'you look around...',
//   actions: [
//     { description: 'examine window', nextPrompt: 2 },
//     { description: 'examine desk', nextPrompt: 4 },
//   ],
// };

// let stage = [1];
// const story = async (stage) => {
//   const { description, actions } = await getPromptById(stage[0]);
//   return { description, actions };
// };
// story();
