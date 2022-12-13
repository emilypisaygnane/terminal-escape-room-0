const fetch = require('cross-fetch');

// const app = require('../../lib/app');
const url = 'http://localhost:7890';

const getPromptById = async (id) => {
  console.log('fetch-utils trying id::', id);
  const response = await fetch(`${url}/api/v1/prompts/${id}`);
  console.log('got response::', response);
  const data = await response.json();
  console.log('fetch-utils got response::', data);
  //   return response.body;
};

module.exports = { getPromptById };
