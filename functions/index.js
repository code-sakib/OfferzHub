const functions = require("firebase-functions");

// Simple function to respond with "Hello, World!"
exports.helloWorld = functions.https.onRequest((req, res) => {
  res.send("Hello, World!");
});
