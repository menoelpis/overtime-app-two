## Linux Command Collection

# Find PID using Port 3000

- $ lsof -wni tcp:3000

# Kill PID

- kill -9 [PID]

# Ensure the ssh-agent is enabled

- $ eval "$(ssh-agent -s)"

# Add your SSH key to the ssh-agent

- $ ssh-add ~/.ssh/id_rsa

# Disable configuration on boot(/etc/default/networking)

- CONFIGURE_INTERFACES=no


