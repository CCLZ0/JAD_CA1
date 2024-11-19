# User passwords
```
1. K - K1234
2. CCLZ - 1234
3. u111 - p111
4. u112 - p112
5. u113 - p113
6. liltay - liltay
```

# Data insertion
```
-- Insert data into `service_category`
INSERT INTO `service_category` (id, category_name, description)
VALUES 
(1, 'Toilet Cleaning', 'Cleaning and sanitization of toilets'),
(2, 'Room Cleaning', 'General and deep cleaning of rooms'),
(3, 'Furniture Cleaning', 'Upholstery and furniture maintenance');

-- Insert data into `service`
INSERT INTO `service` (id, category_id, service_name, description, price)
VALUES 
-- Toilet Cleaning Services
(1, 1, 'Deep Toilet Scrubbing', 'Thorough cleaning to remove stains and limescale', 25.00),
(2, 1, 'Sanitization Service', 'Disinfection of all surfaces and fixtures', 30.00),
(3, 1, 'Exhaust Vent Cleaning', 'Cleaning and maintenance of toilet exhaust fans', 20.00),

-- Room Cleaning Services
(4, 2, 'General Dusting and Mopping', 'Dusting and mopping of room surfaces', 15.00),
(5, 2, 'Carpet Vacuuming', 'Vacuuming and stain removal from carpets', 40.00),
(6, 2, 'Ceiling Spot Cleaning', 'Cleaning of visible spots and cobwebs', 20.00),

-- Furniture Cleaning Services
(7, 3, 'Upholstery Cleaning', 'Cleaning and shampooing of sofas and chairs', 50.00),
(8, 3, 'Wood Polishing', 'Polishing of wooden furniture to restore shine', 35.00),
(9, 3, 'Leather Care', 'Conditioning and cleaning of leather furniture', 45.00);

-- Insert data into `status`
INSERT INTO `status` (id, status_name)
VALUES 
(1, 'Incomplete'),
(2, 'Completed'),
(3, 'Cancelled');


-- Insert data into `booking`
INSERT INTO `booking` (id, member_id, service_id, booking_date, remarks, status)
VALUES 
-- Bookings for Member 3
(1, 3, 1, '2024-11-16 10:00:00', 'Regular monthly cleaning', 1),
(2, 3, 5, '2024-11-17 15:30:00', 'Urgent carpet cleaning', 2),
(3, 3, 7, '2024-11-18 09:00:00', 'First-time upholstery service', 3),

-- Bookings for Member 4
(4, 4, 2, '2024-11-16 12:00:00', 'Sanitization after party', 1),
(5, 4, 6, '2024-11-17 08:00:00', 'Spot cleaning request', 3),
(6, 4, 9, '2024-11-18 14:00:00', 'Leather couch cleaning', 2),

-- Bookings for Member 5
(7, 5, 3, '2024-11-16 11:00:00', 'Exhaust cleaning maintenance', 3),
(8, 5, 4, '2024-11-17 13:00:00', 'General room cleaning', 2),
(9, 5, 8, '2024-11-18 10:30:00', 'Wood polishing service', 1);

-- Insert User data
INSERT INTO `user` (id, email, name, password, role) VALUES
(1, 'K@gmail.com', 'K', '$2a$10$j5Ei75J13da18coWP1PENeA1AZkTvPD2boeH0rnmLt7xU7qmA3e3q', 'admin'),
(2, 'CCLZ@gmail.com', 'CCLZ', '$2a$10$4rNeRhqW/5YTYX0SEMNnVejNXZpOQFf/FJrZqYNqBzSHOqRkq8ZBC', 'admin'),
(3, 'u111@gmail.com', 'u111', '$2a$10$GL2xL2VtFUeej/trYmgY0e.tOvXVTmYLMuplqVren/ZIUPdSpcW1m', 'member'),
(4, 'u112@gmail.com', 'u112', '$2a$10$/WuhWNdCH7VH3dlqvR9eI.QbiKk1ZPC/bqzgHwzHdX.SbsxthgxHa', 'member'),
(5, 'u113@gmail.com', 'u113', '$2a$10$jH/Qa/eO2fVqadWaROSq4uXpo3M9PXEw5uB0oNGx44KHoWDnATgUu', 'member'),
(6, 'liltay@gmail.com', 'liltay', '$2a$10$9Wd1oUPjW/m/1PnkgJBP0e87pP3v1lGSBYhDN8iSgoQAe7GZX6X9q', 'member');
```
