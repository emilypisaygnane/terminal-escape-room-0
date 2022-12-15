const pool = require('../lib/utils/pool');
const setup = require('../data/setup');
const request = require('supertest');
const app = require('../lib/app');
const UserService = require('../lib/services/UserService');

// Dummy user for testing
const mockUser = {
  username: 'exampleUser',
  password: '12345',
};

const registerAndLogin = async (userProps = {}) => {
  const password = userProps.password ?? mockUser.password;

  // Create an "agent" that gives us the ability
  // to store cookies between requests in a test
  const agent = request.agent(app);

  // Create a user to sign in with
  const user = await UserService.create({ ...mockUser, ...userProps });

  // ...then sign in
  const { username } = user;
  await agent.post('/api/v1/users/sessions').send({ username, password });
  return [agent, user];
};

describe('user routes', () => {
  beforeEach(() => {
    return setup(pool);
  });
  afterAll(() => {
    pool.end();
  });

  it('creates a new user', async () => {
    const res = await request(app).post('/api/v1/users').send(mockUser);
    const { username } = mockUser;

    expect(res.body).toEqual({
      id: expect.any(String),
      username,
    });
  });

  it('signs in an existing user', async () => {
    await request(app).post('/api/v1/users').send(mockUser);
    const res = await request(app)
      .post('/api/v1/users/sessions')
      .send({ username: 'exampleUser', password: '12345' });
    expect(res.status).toEqual(200);
  });

  it('/protected should return a 401 if not authenticated', async () => {
    const res = await request(app).get('/api/v1/users/protected');
    expect(res.status).toEqual(401);
  });

  it('/protected should return the current user if authenticated', async () => {
    const [agent] = await registerAndLogin();
    const res = await agent.get('/api/v1/users/protected');
    expect(res.status).toEqual(200);
  });

  it('/users should return 401 if user not admin', async () => {
    const [agent] = await registerAndLogin();
    const res = await agent.get('/api/v1/users/');
    expect(res.status).toEqual(403);
  });

  it('/users should return 200 if user is admin', async () => {
    const agent = request.agent(app);

    // create a new user
    await agent.post('/api/v1/users').send({
      username: 'admin',
      password: '1234',
    });
    // sign in the user
    await agent
      .post('/api/v1/users/sessions')
      .send({ username: 'admin', password: '1234' });

    // const [agent] = await registerAndLogin({ username: 'admin' });
    const res = await agent.get('/api/v1/users/');
    expect(res.status).toEqual(200);
  });

  it('/users should return a 200 if user is admin', async () => {
    const [agent] = await registerAndLogin({ username: 'admin' });
    const res = await agent.get('/api/v1/users/');
    expect(res.status).toEqual(200);
  });

  it('DELETE /sessions deletes the user session', async () => {
    const [agent] = await registerAndLogin();
    const resp = await agent.delete('/api/v1/users/sessions');
    expect(resp.status).toBe(204);
  });

  it('POST /users/state should add new state for a user', async () => {
    const resp = await request(app).post('/api/v1/users/state').send({
      actionStateId: 1,
    });
    expect(resp.status).toBe(200);
    expect(resp.body).toMatchInlineSnapshot(`
      Object {
        "stateId": "1",
        "userId": "1",
      }
    `);
  });
});
