--1. Crear una función MySQL llamada calcular_descuento_cliente que:
--Reciba dos parámetros: el total del pedido y el tipo de cliente ('Minorista' o 'Mayorista').
--Retorne el total con descuento aplicado:
--Si es Mayorista, aplica un 10% de descuento.
--Si es Minorista, aplica un 5% de descuento.
DELIMITER //

CREATE FUNCTION calcular_descuento_cliente(
    p_total DECIMAL(10,2), 
    p_tipo_cliente VARCHAR(20)
)
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE v_total_con_descuento DECIMAL(10,2);

    IF p_tipo_cliente = 'Mayorista' THEN
        SET v_total_con_descuento = p_total * 0.90;
    ELSEIF p_tipo_cliente = 'Minorista' THEN
        SET v_total_con_descuento = p_total * 0.95;
    ELSE
        SET v_total_con_descuento = p_total;
    END IF;

    RETURN v_total_con_descuento;
END //

DELIMITER ;

-- Ejemplo de uso:
SELECT calcular_descuento_cliente(1000.00, 'Mayorista');





-- 2. Realizar una consulta que muestre:
-- El nombre del producto, el precio unitario, la categoría y el precio promedio de todos los productos dentro de la misma categoría.
-- Solo mostrar categorías cuyo promedio de precios sea mayor a 2500.
-- Ordenar los resultados por precio promedio descendente.
SELECT 
    p.nombre AS producto,
    p.precio AS precio_unitario,
    c.nombre AS categoria,
    promedios.precio_promedio_categoria
FROM productos p
JOIN categoria c ON p.id_categoria = c.id
JOIN (
    SELECT id_categoria, AVG(precio) AS precio_promedio_categoria
    FROM productos
    GROUP BY id_categoria
    HAVING AVG(precio) > 2500
) promedios ON p.id_categoria = promedios.id_categoria
ORDER BY promedios.precio_promedio_categoria DESC;


--3. Crear una vista llamada vista_auditoria_precios que muestre:
--El nombre del producto, precio anterior, precio nuevo, fecha de cambio, y el usuario que realizó la modificación.
--Esta vista debe basarse en una tabla auditoria_precios con relación a la tabla productos.

CREATE VIEW vista_auditoria_precios AS
SELECT 
    p.nombre AS producto,
    a.precio_anterior,
    a.precio_nuevo,
    a.fecha_cambio,
    CURRENT_USER() AS usuario
FROM auditoria_precios a
JOIN productos p ON a.id_producto = p.id;

-- Ejemplo de consulta a la vista:
SELECT * FROM vista_auditoria_precios;


--4. Crear un trigger llamado registrar_cambio_precio_trigger que:
--Se ejecute después de actualizar el precio de un producto.
--Inserte automáticamente un registro en la tabla auditoria_precios con:
--ID del producto, precio anterior, nuevo precio, fecha actual (NOW()), y usuario (CURRENT_USER()).
DELIMITER //

CREATE TRIGGER registrar_cambio_precio_trigger
AFTER UPDATE ON productos
FOR EACH ROW
BEGIN
    IF OLD.precio <> NEW.precio THEN
        INSERT INTO auditoria_precios (
            id_producto, 
            precio_anterior, 
            precio_nuevo, 
            fecha_cambio
        )
        VALUES (
            OLD.id, 
            OLD.precio, 
            NEW.precio, 
            NOW()
        );
    END IF;
END //

DELIMITER ;


SELECT registrar_cambio_precio_trigger
