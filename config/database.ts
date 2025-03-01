export default ({ env }) => ({
  connection: {
    client: 'postgres',
    connection: {
      host: 'aws-0-ap-southeast-1.pooler.supabase.com',
      port: 6543,
      database: 'postgres',
      user: 'postgres.awblduzgygxcktsohjbk',
      password: 'DuwVQwZrQGK8xTga',
      ssl: {
        rejectUnauthorized: false,
      },
      pool: {
        min: 0,
        max: 1,
      },
    },
    settings: {
      client_encoding: 'utf8',
      searchPath: ['public'],
    },
    acquireConnectionTimeout: 60000,
    debug: true,
  },
})
