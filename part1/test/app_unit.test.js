import { expect } from 'chai';
import supertest from 'supertest';
import server from '../app.js'; // Adjust the path as needed

describe('Server', () => {
  after(() => {
    server.close(); // Close the server after all tests are done
  });

  it('should return the default message', async () => {
    const res = await supertest(server)
      .get('/')
      .expect(200);
      
    expect(res.text).to.equal('Hello World');
  });


});
