const pool = require('../utils/pool');

module.exports = class userState {
  id;
  userId;
  stateId;

  constructor(row) {
    this.id = row.id;
    this.userId = row.user_id;
    this.stateId = row.state_id;

  }
  static async getAll() {
    const { rows } = await pool.query(
      'SELECT * FROM user_state'
    );
    return rows.map((row) => new userState(row));
  } 
};
