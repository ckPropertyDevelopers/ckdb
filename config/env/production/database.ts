module.exports = ({ env }) => {
  const dbUrl = env('DATABASE_URL')
  console.log('Database URL in config:', dbUrl)

  return {
    connection: {
      client: 'postgres',
      connection: {
        host: env('DATABASE_HOST', 'shortline.proxy.rlwy.net'),
        port: env.int('DATABASE_PORT', 51244),
        database: env('DATABASE_NAME', 'railway'),
        user: env('DATABASE_USERNAME', 'postgres'),
        password: env('DATABASE_PASSWORD', 'yHSaGLwIafhPlVfqRlmRzfEdKzEgqwgt'),
        ssl: {
          rejectUnauthorized: false,
        },
      },
      pool: {
        min: 0,
        max: 5,
      },
      acquireConnectionTimeout: 5000,
    },
  }
}
