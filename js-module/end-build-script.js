const fs = require("fs");

fs.copyFile("./dist/app.js", "../web/app.js", (err) => {
  if (err) throw err;
  console.log("source.txt was copied to destination.txt");
});

fs.copyFile("./dist/vendors.js", "../web/vendors.js", (err) => {
  if (err) throw err;
  console.log("source.txt was copied to destination.txt");
});
