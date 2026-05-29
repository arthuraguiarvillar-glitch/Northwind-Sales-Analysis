
-- ------------------------------------------------
-- 1. PEDIDOS POR CLIENTE
-- Objetivo: identificar os clientes mais ativos
-- ------------------------------------------------
SELECT 
    c.first_name,
    c.last_name,
    COUNT(o.id) AS orders_quantity
FROM customers c
LEFT JOIN orders o ON c.id = o.customer_id
GROUP BY c.id, c.first_name, c.last_name
ORDER BY orders_quantity DESC;


-- ------------------------------------------------
-- 2. TOP 10 PRODUTOS MAIS VENDIDOS (EM QUANTIDADE)
-- Objetivo: identificar os produtos com maior volume de vendas
-- ------------------------------------------------
SELECT 
    p.product_name,
    SUM(d.quantity) AS total_quantity
FROM products p
INNER JOIN order_details d ON p.id = d.product_id
GROUP BY p.product_name
ORDER BY total_quantity DESC
LIMIT 10;


-- ------------------------------------------------
-- 3. RECEITA TOTAL POR MÊS
-- Objetivo: entender a evolução da receita ao longo do tempo
-- ------------------------------------------------
SELECT 
    DATE_FORMAT(o.`order_date`, '%Y-%m') AS `year_month`,
    SUM(d.`quantity` * d.`unit_price`) AS total_revenue
FROM `orders` o
LEFT JOIN `order_details` d ON o.`id` = d.`order_id`
GROUP BY DATE_FORMAT(o.`order_date`, '%Y-%m`)
ORDER BY `year_month`;


-- ------------------------------------------------
-- 4. MARGEM DE LUCRO POR PRODUTO
-- Objetivo: identificar os produtos mais rentáveis
-- Fórmula: (preco_venda - custo) / preco_venda * 100
-- ------------------------------------------------
SELECT 
    product_name,
    standard_cost,
    list_price,
    ((list_price - standard_cost) / list_price) * 100 AS margin_pct
FROM products
ORDER BY margin_pct DESC;


-- ------------------------------------------------
-- 5. FUNCIONÁRIO QUE GEROU MAIS RECEITA
-- Objetivo: avaliar a performance individual da equipe de vendas
-- ------------------------------------------------
SELECT 
    e.first_name,
    e.last_name,
    SUM(d.quantity * d.unit_price) AS total_revenue
FROM employees e
LEFT JOIN orders o ON o.employee_id = e.id
JOIN order_details d ON d.order_id = o.id
GROUP BY e.first_name, e.last_name
ORDER BY total_revenue DESC;
