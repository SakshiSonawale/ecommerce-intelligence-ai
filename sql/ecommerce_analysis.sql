
-- =====================================================
-- E-COMMERCE INTELLIGENCE & AI ANALYTICS PROJECT
-- SQL Analysis and Database Validation
-- Database: ecommerce_intelligence
-- =====================================================


-- 1. DATABASE SETUP
-- =====================================================

CREATE DATABASE IF NOT EXISTS ecommerce_intelligence;

SHOW DATABASES;

USE ecommerce_intelligence;


-- 2. TABLE STRUCTURE
-- =====================================================

SHOW TABLES;

SHOW CREATE TABLE products;

SHOW CREATE TABLE orders;

SHOW CREATE TABLE reviews;


-- 3. DATA VALIDATION
-- =====================================================

-- Total records in each table

SELECT
    (SELECT COUNT(*) FROM products) AS total_products,
    (SELECT COUNT(*) FROM orders) AS total_orders,
    (SELECT COUNT(*) FROM reviews) AS total_reviews;


-- Sample product records

SELECT *
FROM products
LIMIT 5;


-- Sample order records

SELECT *
FROM orders
LIMIT 5;


-- Sample review records

SELECT *
FROM reviews
LIMIT 5;


-- 4. DATA QUALITY CHECKS
-- =====================================================

-- Check for duplicate product IDs

SELECT
    product_id,
    COUNT(*) AS duplicate_count
FROM products
GROUP BY product_id
HAVING COUNT(*) > 1;


-- Check for duplicate order IDs

SELECT
    order_id,
    COUNT(*) AS duplicate_count
FROM orders
GROUP BY order_id
HAVING COUNT(*) > 1;


-- Check for duplicate review IDs

SELECT
    review_id,
    COUNT(*) AS duplicate_count
FROM reviews
GROUP BY review_id
HAVING COUNT(*) > 1;


-- Check product ratings distribution

SELECT
    rating,
    COUNT(*) AS review_count
FROM reviews
GROUP BY rating
ORDER BY rating;


-- 5. EXPLORATORY DATA ANALYSIS
-- =====================================================

-- Product count by category

SELECT
    category,
    COUNT(*) AS total_products
FROM products
GROUP BY category
ORDER BY total_products DESC;


-- Total orders by order status

SELECT
    order_status,
    COUNT(*) AS total_orders
FROM orders
GROUP BY order_status
ORDER BY total_orders DESC;


-- Average product rating

SELECT
    ROUND(AVG(rating), 2) AS overall_average_rating
FROM reviews;


-- 6. PRODUCT PERFORMANCE ANALYSIS
-- =====================================================

-- Top 10 products by number of reviews
-- Includes average customer rating

SELECT
    p.product_id,
    p.product_name,
    p.category,
    COUNT(r.review_id) AS total_reviews,
    ROUND(AVG(r.rating), 2) AS average_rating
FROM products p
JOIN reviews r
    ON p.product_id = r.product_id
GROUP BY
    p.product_id,
    p.product_name,
    p.category
ORDER BY
    total_reviews DESC,
    average_rating ASC
LIMIT 10;


-- 7. SALES ANALYSIS
-- =====================================================

-- Revenue by product

SELECT
    p.product_id,
    p.product_name,
    SUM(o.quantity * o.unit_price) AS total_revenue,
    SUM(o.quantity) AS total_units_sold
FROM products p
JOIN orders o
    ON p.product_id = o.product_id
WHERE o.order_status = 'Completed'
GROUP BY
    p.product_id,
    p.product_name
ORDER BY total_revenue DESC;


-- Revenue by order status

SELECT
    order_status,
    SUM(quantity * unit_price) AS total_order_value
FROM orders
GROUP BY order_status
ORDER BY total_order_value DESC;


-- =====================================================
-- END OF SQL ANALYSIS
-- =====================================================
