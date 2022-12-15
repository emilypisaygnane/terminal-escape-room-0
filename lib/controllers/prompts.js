const { Router } = require('express');
const Prompt = require('../models/Prompt.js');

module.exports = Router().get('/:id', async (req, res, next) => {
  try {
    const prompt = await Prompt.getById(req.params.id);
    if (!prompt) return next();
    res.json(prompt);
  } catch (e) {
    next(e);
  }
});
