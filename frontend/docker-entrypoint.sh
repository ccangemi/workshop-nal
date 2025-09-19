#!/bin/sh

# Set default API URL if not provided
API_URL=${API_URL:-http://localhost:8000}

# Update config.js with the provided API URL
cat > /usr/share/nginx/html/config.js << EOF
// Runtime configuration that can be modified without rebuilding
window.APP_CONFIG = {
  API_URL: '${API_URL}'
};
EOF

echo "Frontend configured with API_URL: ${API_URL}"

# Start nginx
exec "$@"