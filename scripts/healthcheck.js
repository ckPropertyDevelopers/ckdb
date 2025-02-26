const http = require("http");

const options = {
  host: "0.0.0.0",
  port: process.env.PORT || 3001,
  timeout: 5000,
  path: "/",
};

const request = http.request(options, (res) => {
  console.log("Status:", res.statusCode);
  process.exit(res.statusCode === 200 ? 0 : 1);
});

request.on("error", function (err) {
  console.error("Health check error:", err);
  process.exit(1);
});

request.end();
