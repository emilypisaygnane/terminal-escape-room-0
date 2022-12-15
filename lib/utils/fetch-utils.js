const fetch = require('cross-fetch');

const fetchPromptById = async (id) => {
  const resp = await fetch(`${process.env.API_URL}/api/v1/prompts/${id}`);
  const data = await resp.json();
  if (!resp.ok) {
    throw new Error(data.message);
  }
  return data;
};

const fetchStateByAction = async (id) => {
  const resp = await fetch(`${process.env.API_URL}/api/v1/actions/${id}/state`);
  const data = await resp.json();
  if (!resp.ok) {
    throw new Error(data.message);
  }
  return data;
};

module.exports = { fetchPromptById, fetchStateByAction };
