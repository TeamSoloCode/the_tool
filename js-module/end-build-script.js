const fs = require("fs");

fs.copyFile("./dist/app.js", "../web/app.js", (err) => {
  if (err) throw err;
  console.log("./dist/app.js was copied to ../web/app.js");
});

fs.copyFile("./dist/vendors.js", "../web/vendors.js", (err) => {
  if (err) throw err;
  console.log("./dist/vendors.js was copied to ../web/vendors.js");
});
