const pool = require('../utils/pool');

module.exports = class Prompt {
  id;
  description;
  actions;

  constructor(row) {
    this.id = row.id;
    this.description = row.description;
    this.actions = row.actions;
  }

  static async getById(id) {
    const { rows } = await pool.query(
      `
  SELECT prompts.*, coalesce(
      json_agg(to_jsonb(actions))
      filter (WHERE actions.id IS NOT NULL), '[]') as actions
      FROM prompts
      LEFT JOIN actions on actions.prompt_id = prompts.id
      WHERE prompts.id=$1
      group by prompts.id;
    `,
      [id]
    );
    if (!rows) return null;
    return new Prompt(rows[0]);
  }
};
