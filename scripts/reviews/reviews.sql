USE gaseosas_valle;
-- VISTAS
-- 1. Resumen de pedidos y ventas por sede
CREATE VIEW vista_resumen_pedidos_por_sede AS
SELECT 
    s.id AS id_sede,
    s.nombre AS nombre_sede,
    COUNT(p.id) AS total_pedidos,
    IFNULL(SUM(p.total_con_iva), 0) AS total_ventas
FROM sedes s
LEFT JOIN pedidos p ON s.id = p.id_sede
GROUP BY s.id, s.nombre;

-- 2. Productos con stock bajo
CREATE VIEW vista_productos_bajo_stock AS
SELECT id, nombre, stock_actual, stock_minimo
FROM productos
WHERE stock_actual <= stock_minimo;