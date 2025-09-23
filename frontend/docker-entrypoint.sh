#!/bin/sh

# Set default API URL if not provided
API_URL=${API_URL:-http://localhost:8000}

# Create config.js in /tmp where we have write permissions
cat > /tmp/config.js << EOF
// Runtime configuration that can be modified without rebuilding
window.APP_CONFIG = {
  API_URL: '${API_URL}'
};
EOF

echo "Frontend starting with API_URL: ${API_URL}"
echo "Created dynamic config.js with API_URL: ${API_URL}"

# Start nginx
exec "$@"