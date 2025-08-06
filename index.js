const express = require('express');
const app = express();
const port = 80;

app.get('/', (req, res) => res.send('Hello, world! (from EC2)'));
app.listen(port, () => console.log(`Listening on port ${port}`));

