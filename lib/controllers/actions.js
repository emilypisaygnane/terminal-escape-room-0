const { Router } = require('express');
const actionState = require('../models/actionState.js');

module.exports = Router().get('/:id/state', async (req, res, next) => {
  try {
    const state = await actionState.checkActionState(req.params.id);
    res.json(state);
  } catch (e) {
    next(e);
  }
});
