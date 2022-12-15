const pool = require('../utils/pool');

module.exports = class userState {
  userId;
  stateId;

  constructor(row) {
    this.userId = row.user_id;
    this.stateId = row.state_id;
  }

  // Insert a new user state with the specified action state id
  static async insert(actionStateId) {
    const userId = 1;
    const { rows } = await pool.query(
      'INSERT INTO user_state (user_id, state_id) VALUES ($1, $2) RETURNING *',
      [userId, actionStateId]
    );
    return new userState(rows[0]);
  }

  static async getById(state_id) {
    const { rows } = await pool.query(
      `SELECT * 
      FROM user_state 
      WHERE state_id=$1`,
      [state_id]
    );
    if (!rows[0]) return null;
    return rows[0];
  }

  static async deleteUserState() {
    const { rows } = await pool.query(
      `
      DELETE FROM user_state
      RETURNING *;
      `
    );
    if (!rows[0]) return null;
    return true;
  }
};
