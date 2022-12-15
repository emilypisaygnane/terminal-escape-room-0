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

  //   static async getAll() {
  //   const { rows } = await pool.query(
  //     'SELECT * FROM user_state'
  //   );
  //   // return rows.map((row) => new userState(row));
  //   // return [1,2,3,4,5];
  //   return rows.map((row) => parseInt(row.state_id));
  // }
};

// static async getById(id) {
//const { rows } = await pool.query('SELECT * FROM user_state WHERE stateId = $1', [id]);

// Filter rows to only include the one with the specified id
//const filteredRows = rows.filter((row) => row.stateId === id);

// Create userState object from the row and return it
//return filteredRows.map((row) => new userState(row))[0];

// Return the first row without filtering
// return rows[0];

// queries through the user_state table for rows with specified state_id's, filters
// the results to only include specified 'id's' and in return creates a userstate
// object from the row and returns it.
