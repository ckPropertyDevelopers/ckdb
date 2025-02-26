const config = {
  connection: {
    client: 'postgres',
    connection: {
      host: process.env.DATABASE_HOST || '127.0.0.1',
      port: Number(process.env.DATABASE_PORT) || 5432,
      database: process.env.DATABASE_NAME || 'darwinStrapi',
      user: process.env.DATABASE_USERNAME || 'admin',
      password: process.env.DATABASE_PASSWORD || 'Password123',
      ssl: false,
    },
  },
}

export default ({ env }) => config
