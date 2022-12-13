#!/usr/bin/env node
/* eslint-disable no-console */
// const inquirer = require('inquirer');
const { getPromptById } = require('./utils/fetch-utils');

console.log('hello world!');
getPromptById(1);

const response = {
  description: 'you look around...',
  actions: [
    { description: 'examine window', nextPrompt: 2 },
    { description: 'examine desk', nextPrompt: 4 },
  ],
};
