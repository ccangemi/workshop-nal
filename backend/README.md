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

## Database Schema

The application expects an existing `ORDERS` table with the following structure:

```sql
CREATE TABLE ORDERS (
    OrderId INTEGER PRIMARY KEY,
    OrderData VARCHAR(500) NOT NULL,
    CreatedAt DATETIME DEFAULT CURRENT_TIMESTAMP
);
```

## API Documentation

Once running, visit `http://localhost:8000/docs` for interactive API documentation.