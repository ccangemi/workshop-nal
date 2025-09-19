# Orders Management API

A RESTful API for managing orders with CRUD operations, built with FastAPI and SQLAlchemy.

## Features

- Create, Read, Update, Delete (CRUD) operations for orders
- Support for multiple database types (MSSQL, MariaDB/MySQL)
- RESTful API endpoints
- Database connection via environment variables
- Docker containerization

## Setup

1. Install dependencies:
```bash
pip install -r requirements.txt
```

2. Configure environment variables:
Copy `.env.example` to `.env` and update the database connection string:
```bash
cp .env.example .env
```

3. Set your database connection string in `.env`:
```
DATABASE_CONNECTION_STRING=your_actual_connection_string
```

## Database Connection String Examples

### MSSQL Server
```
DATABASE_CONNECTION_STRING=mssql+pymssql://username:password@server:port/database
```

### MariaDB/MySQL
```
DATABASE_CONNECTION_STRING=mysql+pymysql://username:password@server:port/database
```

## Running the Application

### Local Development
```bash
python main.py
```

### Using Docker
```bash
docker build -t orders-api .
docker run -p 8000:8000 --env-file .env orders-api
```

## API Endpoints

- `GET /` - Root endpoint
- `GET /health` - Health check
- `POST /api/v1/orders/` - Create a new order
- `GET /api/v1/orders/` - Get all orders (with pagination)
- `GET /api/v1/orders/{order_id}` - Get a specific order
- `PUT /api/v1/orders/{order_id}` - Update an order
- `DELETE /api/v1/orders/{order_id}` - Delete an order

## Local Development with MariaDB

### Quick Start with Docker Compose Alternative

For local development, you can set up a MariaDB container with initialized data:

#### 1. Launch MariaDB Container
```bash
docker run -d \
  --name mariadb-workshop \
  -e MYSQL_ROOT_PASSWORD=workshop123 \
  -e MYSQL_DATABASE=orders_db \
  -e MYSQL_USER=workshop \
  -e MYSQL_PASSWORD=workshop123 \
  -p 3306:3306 \
  mariadb:latest
```

#### 2. Initialize Database with Orders Table
Wait a few seconds for MariaDB to start, then create the orders table:

```bash
docker exec -i mariadb-workshop mariadb -u root -pworkshop123 orders_db << 'EOF'
CREATE TABLE ORDERS (
    OrderId INT AUTO_INCREMENT PRIMARY KEY,
    OrderData TEXT NOT NULL,
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO ORDERS (OrderData) VALUES
('Sample order 1'),
('Sample order 2');
EOF
```

#### 3. Run Application Container Connected to MariaDB
```bash
# Build the application image
docker build -t workshop-backend .

# Run with MariaDB connection
docker run -d \
  -p 8000:8000 \
  -e DATABASE_CONNECTION_STRING="mysql+pymysql://workshop:workshop123@host.docker.internal:3306/orders_db" \
  --name workshop-app \
  workshop-backend
```

#### 4. Test the Setup
```bash
# Test API endpoints
curl http://localhost:8000/api/v1/orders/
curl -X POST "http://localhost:8000/api/v1/orders/" \
  -H "Content-Type: application/json" \
  -d '{"OrderData": "New test order"}'
```

#### 5. Cleanup
```bash
docker stop workshop-app mariadb-workshop
docker rm workshop-app mariadb-workshop
```

## CORS Configuration

The backend includes CORS middleware configured to allow browser requests from the frontend:

```python
from fastapi.middleware.cors import CORSMiddleware

app.add_middleware(
    CORSMiddleware,
    allow_origins=["http://localhost:3000", "http://127.0.0.1:3000"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)
```

This enables the React frontend to make API calls without cross-origin restrictions.

## Database Schema

The application expects an existing `ORDERS` table with the following structure:

```sql
CREATE TABLE ORDERS (
    OrderId INT AUTO_INCREMENT PRIMARY KEY,
    OrderData TEXT NOT NULL,
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
```

## API Documentation

Once running, visit `http://localhost:8000/docs` for interactive API documentation powered by Swagger UI.

### Available Endpoints

- `GET /` - Root endpoint with API information
- `GET /health` - Health check endpoint
- `GET /api/v1/orders/` - List all orders (supports pagination with `skip` and `limit` parameters)
- `POST /api/v1/orders/` - Create a new order
- `GET /api/v1/orders/{order_id}` - Get a specific order by ID
- `PUT /api/v1/orders/{order_id}` - Update an existing order
- `DELETE /api/v1/orders/{order_id}` - Delete an order

### Request/Response Examples

**Create Order:**
```bash
curl -X POST "http://localhost:8000/api/v1/orders/" \
  -H "Content-Type: application/json" \
  -d '{"OrderData": "New order description"}'
```

**Get All Orders:**
```bash
curl "http://localhost:8000/api/v1/orders/"
```

**Update Order:**
```bash
curl -X PUT "http://localhost:8000/api/v1/orders/1" \
  -H "Content-Type: application/json" \
  -d '{"OrderData": "Updated order description"}'
```

## Integration with Frontend

The backend is designed to work seamlessly with the React frontend located in the `../frontend` directory. The frontend communicates with this API to provide a complete order management interface.

Ensure both services are running for full application functionality:
- Backend: http://localhost:8000
- Frontend: http://localhost:3000