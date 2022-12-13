const { Router } = require('express');
const Prompt = require('../models/Prompt');

module.exports = Router().get('/:id', async (req, res, next) => {
  console.log('in controller trying id::', req.params.id);
  try {
    const prompt = await Prompt.getById(req.params.id);
    res.json(prompt);
  } catch (err) {
    next(err);
  }
});
