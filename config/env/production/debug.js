module.exports = ({ env }) => {
  console.log("Current Environment:", process.env.NODE_ENV);
  console.log("Database URL:", process.env.DATABASE_URL);
  console.log("Loading production database config...");
  return {};
};
