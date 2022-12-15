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

  it('GET /api/v1/prompts/:id returns a prompt by its id', async () => {
    const response = await request(app).get('/api/v1/prompts/1');
    expect(response.status).toBe(200);
    expect(response.body).toMatchInlineSnapshot(`
      Object {
        "actions": Array [
          Object {
            "description": "Examine window",
            "id": 1,
            "next_prompt_id": 2,
            "prompt_id": 1,
            "state_id": null,
          },
          Object {
            "description": "Examine desk",
            "id": 2,
            "next_prompt_id": 3,
            "prompt_id": 1,
            "state_id": null,
          },
          Object {
            "description": "Examine control panel",
            "id": 3,
            "next_prompt_id": 4,
            "prompt_id": 1,
            "state_id": null,
          },
          Object {
            "description": "Examine door",
            "id": 4,
            "next_prompt_id": 5,
            "prompt_id": 1,
            "state_id": null,
          },
        ],
        "description": "You look around in a dark room, dim lights outline a door, and a few other objects you should check out. But be diligent, your oxygen levels are low and every move matters.",
        "id": "1",
      }
    `);
  });
});
