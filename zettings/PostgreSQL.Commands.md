## PostgreSQL Commands Collection

# Create PostgreSQL User with Password

- $ psql -c "CREATE USER kainos WITH PASSWORD 'shema';"

# Change PostgreSQL Setting

- $ nano /etc/postgresql/9.5/main/pg_hba.conf
- [change peer to md5]
- $ service postgresql restart