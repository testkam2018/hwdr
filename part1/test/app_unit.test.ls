import { expect } from 'chai';
import chaiHttp from 'chai-http';
import { createServer } from 'http';
import app from '../app.js'; // Adjust this path if necessary

chai.use(chaiHttp);

// Dummy server setup
let server;

before(done => {
  server = createServer(app);
  server.listen(3001, done); // Use a different port for testing
});

after(done => {
  server.close(done);
});

describe('GET /', () => {
  it('should return Hello World', done => {
    chai.request(server)
      .get('/')
      .end((err, res) => {
        expect(res).to.have.status(200);
        expect(res.text).to.equal('Hello World');
        done();
      });
  });
});
