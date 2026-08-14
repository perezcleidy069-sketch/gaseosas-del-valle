-- CONSULTAS SQL --
-- 1. Consultar los productos con stock por debajo del mínimo.

USE gaseosas_valle;

UPDATE  productos SET stock_actual = CASE id
	WHEN 1 THEN 20
    WHEN 6 THEN 10
    WHEN 3 THEN 40
END
WHERE id IN (1,6, 3);

SELECT id, nombre, stock_minimo, stock_actual
	FROM productos
    Where stock_actual< stock_minimo
    ORDER BY stock_actual;

    -- 2.Consultar los pedidos realizados entre dos fechas (BETWEEN).
SELECT id, fecha, id_cliente, id_sede
	FROM pedidos
    WHERE fecha BETWEEN '2026-07-16 14:55:00'  AND '2026-07-25 09:51:00'
    AND id_sede= 3
    ORDER BY fecha DESC;

    -- Prueba sin especifica el id.
SELECT id, fecha, id_cliente, id_sede
	FROM pedidos
    WHERE fecha BETWEEN '2026-07-16 14:55:00'  AND '2026-07-25 09:51:00'
    ORDER BY fecha DESC;