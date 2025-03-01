import { Pool } from 'pg'

const pool = new Pool({
  connectionString:
    'postgresql://postgres.awblduzgygxcktsohjbk:DuwVQwZrQGK8xTga@aws-0-ap-southeast-1.pooler.supabase.com:6543/postgres?pgbouncer=true',
  ssl: {
    rejectUnauthorized: false,
  },
  max: 1,
})

async function testConnection() {
  try {
    console.log('Testing connection...')
    const client = await pool.connect()
    const result = await client.query('SELECT NOW()')
    console.log('Connection successful!', result.rows[0])
    client.release()
  } catch (error) {
    console.error('Connection error:', error)
  } finally {
    await pool.end()
  }
}

testConnection()
