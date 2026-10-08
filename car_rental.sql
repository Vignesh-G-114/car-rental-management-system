-- Enable foreign key constraints
PRAGMA foreign_keys = ON;

-- ========================================================
-- 1. SCHEMA DEFINITION
-- ========================================================

-- Table: Cars
CREATE TABLE IF NOT EXISTS cars (
    car_id INTEGER PRIMARY KEY AUTOINCREMENT,
    make TEXT NOT NULL,
    model TEXT NOT NULL,
    year INTEGER NOT NULL,
    daily_rate REAL NOT NULL,
    status TEXT DEFAULT 'available' CHECK (status IN ('available', 'rented', 'maintenance'))
);

-- Table: Customers
CREATE TABLE IF NOT EXISTS customers (
    customer_id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    email TEXT UNIQUE NOT NULL,
    phone TEXT NOT NULL,
    driver_license TEXT UNIQUE NOT NULL
);

-- Table: Rentals
CREATE TABLE IF NOT EXISTS rentals (
    rental_id INTEGER PRIMARY KEY AUTOINCREMENT,
    car_id INTEGER NOT NULL,
    customer_id INTEGER NOT NULL,
    rent_date DATE NOT NULL,
    return_date DATE,
    total_cost REAL DEFAULT 0.0,
    status TEXT DEFAULT 'active' CHECK (status IN ('active', 'completed', 'cancelled')),
    FOREIGN KEY (car_id) REFERENCES cars (car_id) ON DELETE CASCADE,
    FOREIGN KEY (customer_id) REFERENCES customers (customer_id) ON DELETE CASCADE
);

-- ========================================================
-- 2. SAMPLE DATA INSERTION
-- ========================================================

-- Insert Sample Cars
INSERT INTO cars (make, model, year, daily_rate, status) VALUES 
('Toyota', 'Camry', 2023, 50.00, 'available'),
('Honda', 'Civic', 2022, 45.00, 'available'),
('Ford', 'Mustang', 2024, 90.00, 'available');

-- Insert Sample Customers
INSERT INTO customers (name, email, phone, driver_license) VALUES 
('Alice Smith', 'alice@example.com', '555-0192', 'DL-99281'),
('Bob Jones', 'bob@example.com', '555-0143', 'DL-88123');

-- Insert Sample Rental Transaction
INSERT INTO rentals (car_id, customer_id, rent_date, total_cost, status) VALUES
(1, 1, '2026-10-01', 200.00, 'active');

-- Update Car Status for Active Rental
UPDATE cars SET status = 'rented' WHERE car_id = 1;