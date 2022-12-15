const pool = require('../lib/utils/pool');
const setup = require('../data/setup');
const request = require('supertest');
const app = require('../lib/app');

describe('user routes', () => {
  beforeEach(() => {
    return setup(pool);
  });
  afterAll(() => {
    pool.end();
  });

  it('GET /api/v1/actions/:id/state returns the state of the action', async () => {
    const response = await request(app).get('/api/v1/actions/1/state');
    expect(response.status).toBe(200);
    expect(response.body).toMatchInlineSnapshot(`
      Object {
        "actionCount": "0",
        "stateCount": "0",
      }
    `);
  });
});
