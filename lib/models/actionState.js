const pool = require('../utils/pool');

module.exports = class actionState {
  actionCount;
  stateCount;

  constructor(row) {
    this.id = row.id;
    this.actionCount = row.action_count;
    this.stateCount = row.state_count;

  }
  static async checkActionState(id) {
    const { rows } = await pool.query(
      `SELECT COUNT (action_state.state_id) as action_count,
      COUNT (user_state.state_id) as state_count 
      FROM action_state 
      LEFT JOIN user_state ON action_state.state_id = user_state.state_id
      WHERE action_state.action_id = $1`, [id]
    );
    return new actionState(rows[0]);
  } 
};
