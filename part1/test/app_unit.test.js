import { expect } from 'chai';
import fetch from 'node-fetch';

it('Main page content', async function() {
    const response = await fetch('http://localhost:3000');
    const body = await response.text();
    expect(body).to.equal('fff');
});
