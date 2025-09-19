-- Database initialization script for Orders Management System
-- This script will be automatically executed when the MariaDB container starts

USE orders_db;

-- Create ORDERS table
CREATE TABLE IF NOT EXISTS ORDERS (
    OrderId INT AUTO_INCREMENT PRIMARY KEY,
    OrderData VARCHAR(500) NOT NULL,
    CreatedAt DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- Insert sample data
INSERT INTO ORDERS (OrderData) VALUES
    ('Sample Order 1 - Initial laptop purchase'),
    ('Sample Order 2 - Office supplies bundle'),
    ('Sample Order 3 - Software licensing renewal'),
    ('Sample Order 4 - Hardware maintenance kit'),
    ('Sample Order 5 - Training materials package');

-- Verify table creation
SELECT COUNT(*) as initial_order_count FROM ORDERS;