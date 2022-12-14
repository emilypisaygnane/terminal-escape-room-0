const pool = require('../utils/pool');

module.exports = class actionState {
  id;
  actionId;
  stateId;

  constructor(row) {
    this.id = row.id;
    this.actionId = row.action_id;
    this.stateId = row.state_id;

  }
  static async getAll() {
    const { rows } = await pool.query(
      'SELECT * FROM action_state'
    );
    return rows.map((row) => new actionState(row));
  } 
};
