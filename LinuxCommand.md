## Linux Command Collection

# Find PID using Port 3000

- $ lsof -wni tcp:3000

# Kill PID

- kill -9 [PID]

# Ensure the ssh-agent is enabled

- $ eval "$(ssh-agent -s)"

# Add your SSH key to the ssh-agent

- $ ssh-add ~/.ssh/id_rsa

# Create PostgreSQL User with Password

- psql -c "CREATE USER kainos WITH PASSWORD 'shema';"

# Change PostgreSQL Setting

- nano /etc/postgresql/9.5/main/pg_hba.conf
- change peer to md5
- service postgresql restart
