const pool = require('../utils/pool');

module.exports = class Prompt {
  id;
  description;

  constructor(row) {
    this.id = row.id;
    this.description = row.description;
  }

  static async getById(id) {
    const { rows } = await pool.query(
      `
    SELECT * FROM prompts WHERE id=$1
    `,
      [id]
    );
    if (!rows) return null;
    return new Prompt(rows[0]);
  }
};
