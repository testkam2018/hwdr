import http from 'http';
const port = process.env.PORT || 3000; // Use environment variable for port if available
const message = process.env.MESSAGE || "Hello World";

const requestHandler = (request, response) => {
  response.end(message);
}

const server = http.createServer(requestHandler);

server.listen(port, '0.0.0.0', (err) => {
  if (err) {
    return console.log('something bad happened', err);
  }

  console.log(`Server is listening on http://0.0.0.0:${port}`);
});
