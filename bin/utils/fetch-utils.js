const fetch = require('cross-fetch');

const url = 'http://localhost:7890';

const getPromptById = async (id) => {
  const response = await fetch(`${url}/api/v1/prompts/${id}`);
  const data = await response.json();
  //   console.log('fetch-utils got response::', data);
  return data;
};

module.exports = { getPromptById };
