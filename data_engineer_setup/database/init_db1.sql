
CREATE TABLE customers (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(150) UNIQUE NOT NULL,
    registration_date TIMESTAMP NOT NULL,
    country VARCHAR(50) NOT NULL
);

CREATE TABLE orders (
    id SERIAL PRIMARY KEY,
    customer_id INTEGER NOT NULL REFERENCES customers(id),
    order_date TIMESTAMP NOT NULL,
    total_amount DECIMAL(10,2) NOT NULL,
    currency VARCHAR(3) NOT NULL,
    status VARCHAR(20) NOT NULL DEFAULT 'completed'
);

CREATE TABLE order_items (
    id SERIAL PRIMARY KEY,
    order_id INTEGER NOT NULL REFERENCES orders(id),
    product_id INTEGER NOT NULL,
    quantity INTEGER NOT NULL,
    unit_price DECIMAL(10,2) NOT NULL,
    currency VARCHAR(3) NOT NULL
);

INSERT INTO customers (name, email, registration_date, country) VALUES
('John Smith', 'john.smith@email.com', '2024-01-15 10:30:00', 'USA'),
('Emma Johnson', 'emma.johnson@email.com', '2024-01-20 14:15:00', 'UK'),
('Pierre Dubois', 'pierre.dubois@email.com', '2024-01-25 09:45:00', 'France'),
('Maria Garcia', 'maria.garcia@email.com', '2024-02-01 16:20:00', 'Spain'),
('Hans Mueller', 'hans.mueller@email.com', '2024-02-05 11:10:00', 'Germany'),
('Anna Kowalski', 'anna.kowalski@email.com', '2024-02-10 13:30:00', 'Poland'),
('Yuki Tanaka', 'yuki.tanaka@email.com', '2024-02-15 08:45:00', 'Japan'),
('Sarah Wilson', 'sarah.wilson@email.com', '2024-02-20 15:25:00', 'Canada'),
('Marco Rossi', 'marco.rossi@email.com', '2024-02-25 12:40:00', 'Italy'),
('Lars Andersen', 'lars.andersen@email.com', '2024-03-01 10:15:00', 'Denmark'),
('Sophie Martin', 'sophie.martin@email.com', '2024-03-05 14:50:00', 'France'),
('David Brown', 'david.brown@email.com', '2024-03-10 09:20:00', 'USA'),
('Lisa Chen', 'lisa.chen@email.com', '2024-03-15 16:35:00', 'Singapore'),
('Carlos Rodriguez', 'carlos.rodriguez@email.com', '2024-03-20 11:45:00', 'Mexico'),
('Nina Petrov', 'nina.petrov@email.com', '2024-03-25 13:15:00', 'Russia'),
('Ahmed Hassan', 'ahmed.hassan@email.com', '2024-04-01 08:30:00', 'Egypt'),
('Isabella Silva', 'isabella.silva@email.com', '2024-04-05 15:10:00', 'Brazil'),
('Oliver Taylor', 'oliver.taylor@email.com', '2024-04-10 12:25:00', 'Australia'),
('Fatima Al-Zahra', 'fatima.alzahra@email.com', '2024-04-15 10:40:00', 'UAE'),
('Erik Johansson', 'erik.johansson@email.com', '2024-04-20 14:55:00', 'Sweden'),
('Priya Sharma', 'priya.sharma@email.com', '2024-04-25 09:35:00', 'India'),
('Michael O''Connor', 'michael.oconnor@email.com', '2024-05-01 16:20:00', 'Ireland'),
('Anastasia Volkov', 'anastasia.volkov@email.com', '2024-05-05 11:30:00', 'Russia'),
('Jin Park', 'jin.park@email.com', '2024-05-10 13:45:00', 'South Korea'),
('Elena Popov', 'elena.popov@email.com', '2024-05-15 08:15:00', 'Bulgaria'),
('Thomas Anderson', 'thomas.anderson@email.com', '2024-05-20 15:40:00', 'Norway'),
('Camila Santos', 'camila.santos@email.com', '2024-05-25 12:10:00', 'Brazil'),
('Robert Johnson', 'robert.johnson@email.com', '2024-06-01 10:25:00', 'USA'),
('Mei Wong', 'mei.wong@email.com', '2024-06-05 14:35:00', 'Hong Kong'),
('Francesco Bianchi', 'francesco.bianchi@email.com', '2024-06-10 09:50:00', 'Italy'),
('Ingrid Hansen', 'ingrid.hansen@email.com', '2024-06-15 16:15:00', 'Denmark'),
('Raj Patel', 'raj.patel@email.com', '2024-06-20 11:40:00', 'India'),
('Natalie Dubois', 'natalie.dubois@email.com', '2024-06-25 13:20:00', 'Belgium'),
('Alex Kim', 'alex.kim@email.com', '2024-07-01 08:55:00', 'South Korea'),
('Victoria Smith', 'victoria.smith@email.com', '2024-07-05 15:30:00', 'UK'),
('Diego Martinez', 'diego.martinez@email.com', '2024-07-10 12:45:00', 'Argentina'),
('Olga Ivanova', 'olga.ivanova@email.com', '2024-07-15 10:05:00', 'Russia'),
('James Wilson', 'james.wilson@email.com', '2024-07-20 14:20:00', 'Canada'),
('Sakura Yamamoto', 'sakura.yamamoto@email.com', '2024-07-25 09:15:00', 'Japan'),
('Lucas Silva', 'lucas.silva@email.com', '2024-08-01 16:40:00', 'Portugal'),
('Zara Ahmed', 'zara.ahmed@email.com', '2024-08-05 11:25:00', 'Pakistan'),
('Gustav Larsson', 'gustav.larsson@email.com', '2024-08-10 13:50:00', 'Sweden'),
('Chiara Romano', 'chiara.romano@email.com', '2024-08-15 08:35:00', 'Italy'),
('Ryan Murphy', 'ryan.murphy@email.com', '2024-08-20 15:05:00', 'Ireland'),
('Lila Gupta', 'lila.gupta@email.com', '2024-08-25 12:30:00', 'India'),
('Anton Petrov', 'anton.petrov@email.com', '2024-09-01 10:45:00', 'Czech Republic'),
('Grace Lee', 'grace.lee@email.com', '2024-09-05 14:10:00', 'USA'),
('Pablo Hernandez', 'pablo.hernandez@email.com', '2024-09-10 09:25:00', 'Spain'),
('Astrid Nielsen', 'astrid.nielsen@email.com', '2024-09-15 16:55:00', 'Norway'),
('Ravi Kumar', 'ravi.kumar@email.com', '2024-09-20 11:15:00', 'India');

INSERT INTO orders (customer_id, order_date, total_amount, currency, status) VALUES
(1, '2024-01-16 14:30:00', 89.99, 'USD', 'completed'),
(2, '2024-01-21 10:15:00', 156.50, 'GBP', 'completed'),
(3, '2024-01-26 16:45:00', 234.75, 'EUR', 'completed'),
(4, '2024-01-28 11:20:00', 67.25, 'EUR', 'completed'),
(5, '2024-01-30 13:40:00', 445.80, 'EUR', 'completed'),

(6, '2024-02-02 09:15:00', 123.45, 'EUR', 'completed'),
(7, '2024-02-04 15:30:00', 78.90, 'USD', 'completed'),
(8, '2024-02-06 12:25:00', 298.75, 'USD', 'completed'),
(9, '2024-02-08 14:50:00', 189.60, 'EUR', 'completed'),
(10, '2024-02-10 10:35:00', 356.25, 'EUR', 'completed'),
(11, '2024-02-12 16:20:00', 145.80, 'EUR', 'completed'),
(12, '2024-02-14 11:45:00', 267.30, 'USD', 'completed'),
(13, '2024-02-16 13:15:00', 89.95, 'USD', 'completed'),
(14, '2024-02-18 15:40:00', 178.50, 'USD', 'completed'),
(15, '2024-02-20 09:55:00', 423.75, 'USD', 'completed'),

(16, '2024-03-01 14:25:00', 156.80, 'USD', 'completed'),
(17, '2024-03-03 10:40:00', 289.45, 'USD', 'completed'),
(18, '2024-03-05 16:15:00', 134.70, 'USD', 'completed'),
(19, '2024-03-07 12:30:00', 245.90, 'USD', 'completed'),
(20, '2024-03-09 14:55:00', 367.25, 'EUR', 'completed'),
(21, '2024-03-11 11:20:00', 198.60, 'USD', 'completed'),
(22, '2024-03-13 15:45:00', 456.80, 'USD', 'completed'),
(23, '2024-03-15 09:35:00', 123.75, 'USD', 'completed'),
(24, '2024-03-17 13:50:00', 278.90, 'USD', 'completed'),
(25, '2024-03-19 16:10:00', 189.45, 'EUR', 'completed'),
(26, '2024-03-21 10:25:00', 345.60, 'EUR', 'completed'),
(27, '2024-03-23 14:40:00', 167.85, 'USD', 'completed'),
(28, '2024-03-25 12:15:00', 234.50, 'USD', 'completed'),
(29, '2024-03-27 15:30:00', 298.75, 'USD', 'completed'),
(30, '2024-03-29 11:45:00', 156.90, 'EUR', 'completed'),

(31, '2024-04-02 14:20:00', 445.80, 'EUR', 'completed'),
(32, '2024-04-04 10:35:00', 189.65, 'USD', 'completed'),
(33, '2024-04-06 16:50:00', 267.40, 'USD', 'completed'),
(34, '2024-04-08 12:15:00', 356.75, 'USD', 'completed'),
(35, '2024-04-10 14:30:00', 178.90, 'EUR', 'completed'),
(36, '2024-04-12 09:45:00', 423.55, 'USD', 'completed'),
(37, '2024-04-14 15:25:00', 234.80, 'USD', 'completed'),
(38, '2024-04-16 11:40:00', 145.70, 'USD', 'completed'),
(39, '2024-04-18 13:55:00', 298.45, 'USD', 'completed'),
(40, '2024-04-20 16:10:00', 189.90, 'EUR', 'completed'),
(41, '2024-04-22 10:25:00', 367.25, 'EUR', 'completed'),
(42, '2024-04-24 14:40:00', 156.85, 'USD', 'completed'),
(43, '2024-04-26 12:55:00', 278.60, 'USD', 'completed'),
(44, '2024-04-28 15:15:00', 445.90, 'USD', 'completed'),
(45, '2024-04-30 11:30:00', 123.75, 'EUR', 'completed'),

(46, '2024-05-02 14:45:00', 234.85, 'USD', 'completed'),
(47, '2024-05-04 10:20:00', 189.70, 'USD', 'completed'),
(48, '2024-05-06 16:35:00', 356.45, 'USD', 'completed'),
(49, '2024-05-08 12:50:00', 167.90, 'USD', 'completed'),
(50, '2024-05-10 14:15:00', 298.55, 'EUR', 'completed'),
(1, '2024-05-12 09:30:00', 145.80, 'USD', 'completed'),
(2, '2024-05-14 15:45:00', 423.65, 'GBP', 'completed'),
(3, '2024-05-16 11:25:00', 278.40, 'EUR', 'completed'),
(4, '2024-05-18 13:40:00', 189.95, 'EUR', 'completed'),
(5, '2024-05-20 16:55:00', 367.20, 'EUR', 'completed'),

(6, '2024-06-01 14:10:00', 156.75, 'EUR', 'completed'),
(7, '2024-06-03 10:25:00', 234.90, 'USD', 'completed'),
(8, '2024-06-05 16:40:00', 445.55, 'USD', 'completed'),
(9, '2024-06-07 12:15:00', 123.85, 'EUR', 'completed'),
(10, '2024-06-09 14:30:00', 298.70, 'EUR', 'completed'),
(11, '2024-06-11 09:45:00', 189.45, 'EUR', 'completed'),
(12, '2024-06-13 15:20:00', 356.80, 'USD', 'completed'),
(13, '2024-06-15 11:35:00', 167.65, 'USD', 'completed'),
(14, '2024-06-17 13:50:00', 278.95, 'USD', 'completed'),
(15, '2024-06-19 16:05:00', 423.40, 'USD', 'completed'),
(16, '2024-06-21 10:20:00', 145.90, 'USD', 'completed'),
(17, '2024-06-23 14:35:00', 234.75, 'USD', 'completed'),
(18, '2024-06-25 12:50:00', 189.80, 'USD', 'completed'),
(19, '2024-06-27 15:15:00', 367.45, 'USD', 'completed'),
(20, '2024-06-29 11:30:00', 298.60, 'USD', 'completed'),

(21, '2024-07-01 14:25:00', 156.85, 'USD', 'completed'),
(22, '2024-07-03 10:40:00', 445.70, 'USD', 'completed'),
(23, '2024-07-05 16:15:00', 123.95, 'USD', 'completed'),
(24, '2024-07-07 12:30:00', 278.50, 'USD', 'completed'),
(25, '2024-07-09 14:45:00', 189.75, 'EUR', 'completed'),
(26, '2024-07-11 09:20:00', 356.90, 'EUR', 'completed'),
(27, '2024-07-13 15:35:00', 234.65, 'USD', 'completed'),
(28, '2024-07-15 11:50:00', 167.80, 'USD', 'completed'),
(29, '2024-07-17 13:15:00', 423.55, 'USD', 'completed'),
(30, '2024-07-19 16:30:00', 298.85, 'USD', 'completed'),
(31, '2024-07-21 10:45:00', 145.70, 'EUR', 'completed'),
(32, '2024-07-23 14:20:00', 367.40, 'USD', 'completed'),
(33, '2024-07-25 12:35:00', 189.90, 'USD', 'completed');

INSERT INTO order_items (order_id, product_id, quantity, unit_price, currency) VALUES
(1, 1, 1, 89.99, 'USD'),

(2, 15, 2, 78.25, 'GBP'),

(3, 23, 1, 234.75, 'EUR'),

(4, 45, 3, 22.42, 'EUR'),

(5, 8, 1, 299.99, 'EUR'),
(5, 12, 2, 72.91, 'EUR'),

(6, 34, 1, 123.45, 'EUR'),

(7, 67, 4, 19.73, 'USD'),

(8, 19, 1, 199.99, 'USD'),
(8, 28, 1, 98.76, 'USD'),

(9, 56, 2, 94.80, 'EUR'),

(10, 3, 1, 356.25, 'EUR'),

(11, 41, 3, 48.60, 'EUR'),

(12, 7, 1, 189.99, 'USD'),
(12, 22, 1, 77.31, 'USD'),

(13, 89, 5, 17.99, 'USD'),

(14, 14, 2, 89.25, 'USD'),

(15, 5, 1, 423.75, 'USD'),

(16, 33, 1, 156.80, 'USD'),

(17, 11, 1, 289.45, 'USD'),

(18, 76, 6, 22.45, 'USD'),

(19, 29, 1, 245.90, 'USD'),

(20, 4, 1, 367.25, 'EUR'),

(21, 58, 2, 99.30, 'USD'),

(22, 9, 1, 456.80, 'USD'),

(23, 82, 7, 17.68, 'USD'),

(24, 16, 1, 278.90, 'USD'),

(25, 47, 3, 63.15, 'EUR'),

(26, 6, 1, 345.60, 'EUR'),

(27, 71, 4, 41.96, 'USD'),

(28, 25, 1, 234.50, 'USD'),

(29, 13, 1, 298.75, 'USD'),

(30, 39, 2, 78.45, 'EUR'),

(31, 2, 1, 445.80, 'EUR'),
(32, 64, 8, 23.71, 'USD'),
(33, 18, 1, 267.40, 'USD'),
(34, 52, 1, 356.75, 'USD'),
(35, 27, 2, 89.45, 'EUR'),
(36, 10, 1, 423.55, 'USD'),
(37, 73, 5, 46.96, 'USD'),
(38, 36, 3, 48.57, 'USD'),
(39, 21, 1, 298.45, 'USD'),
(40, 49, 2, 94.95, 'EUR'),
(41, 17, 1, 367.25, 'EUR'),
(42, 85, 9, 17.43, 'USD'),
(43, 31, 1, 278.60, 'USD'),
(44, 1, 1, 445.90, 'USD'),
(45, 68, 6, 20.63, 'EUR'),
(46, 24, 1, 234.85, 'USD'),
(47, 55, 2, 94.85, 'USD'),
(48, 8, 1, 356.45, 'USD'),
(49, 77, 4, 41.98, 'USD'),
(50, 32, 1, 298.55, 'EUR'),
(51, 43, 3, 48.60, 'USD'),
(52, 15, 2, 211.83, 'GBP'),
(53, 59, 2, 139.20, 'EUR'),
(54, 26, 1, 189.95, 'EUR'),
(55, 4, 1, 367.20, 'EUR'),
(56, 81, 8, 19.59, 'EUR'),
(57, 35, 1, 234.90, 'USD'),
(58, 12, 1, 445.55, 'USD'),
(59, 74, 7, 17.69, 'EUR'),
(60, 20, 1, 298.70, 'EUR'),
(61, 48, 3, 63.15, 'EUR'),
(62, 7, 1, 356.80, 'USD'),
(63, 86, 10, 16.77, 'USD'),
(64, 30, 1, 278.95, 'USD'),
(65, 53, 1, 423.40, 'USD'),
(66, 37, 2, 72.95, 'USD'),
(67, 14, 1, 234.75, 'USD'),
(68, 69, 5, 37.96, 'USD'),
(69, 22, 1, 367.45, 'USD'),
(70, 44, 3, 99.53, 'USD'),
(71, 78, 4, 39.21, 'USD'),
(72, 11, 1, 445.70, 'USD'),
(73, 87, 8, 15.49, 'USD'),
(74, 33, 1, 278.50, 'USD'),
(75, 50, 2, 94.88, 'EUR'),
(76, 6, 1, 356.90, 'EUR'),
(77, 75, 6, 39.11, 'USD'),
(78, 28, 1, 167.80, 'USD'),
(79, 9, 1, 423.55, 'USD'),
(80, 41, 3, 99.62, 'USD'),
(81, 83, 9, 16.19, 'EUR'),
(82, 16, 1, 367.40, 'USD'),
(83, 60, 2, 94.95, 'USD');

CREATE INDEX idx_orders_customer_id ON orders(customer_id);
CREATE INDEX idx_orders_order_date ON orders(order_date);
CREATE INDEX idx_order_items_order_id ON order_items(order_id);
CREATE INDEX idx_order_items_product_id ON order_items(product_id);
CREATE INDEX idx_customers_country ON customers(country);
