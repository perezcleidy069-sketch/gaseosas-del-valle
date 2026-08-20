--1. Crear una función MySQL llamada calcular_descuento_cliente que:
--Reciba dos parámetros: el total del pedido y el tipo de cliente ('Minorista' o 'Mayorista').
--Retorne el total con descuento aplicado:
--Si es Mayorista, aplica un 10% de descuento.
--Si es Minorista, aplica un 5% de descuento.




DELIMITER //

ALTAR TABLE pedidos ADD tipo_de_cliente
    INSERT INTO pedidos VALUE(tipo_de_cliente)
    WHERE precio = 1
    IF precio >= 1000
    'Mayorista'
    ELIF
    'Minorista'

CREATE FUNCTION calcular_descuento_cliente(id INT, id_cliente INT)
RETURNS DECIMAL 
DETERMINISTIC
READS SQL DATA
	DECLARE total_con_iva DECIMAL(10,2)

BEGIN
	
	SELECT id, id_cliente
        FROM pedidos
        WHERE tipo_de_cliente
        IF tipo_de_cliente = 'Mayorista'
        SET total_con_iva = total_sin_iva * 1.10;

        ELSEIF
        SET total_con_iva = total_sin_iva * 1.5;
        RETURN v_total_con_iva;

END //
DELIMITER ;

SELECT calcular_descuento_cliente;


-- 2. Realizar una consulta que muestre:
-- El nombre del producto, el precio unitario, la categoría y el precio promedio de todos los productos dentro de la misma categoría.
-- Solo mostrar categorías cuyo promedio de precios sea mayor a 2500.
-- Ordenar los resultados por precio promedio descendente.
SELECT nombre, precio, id_categoria
    FROM productos;

SELECT id, nombre, AS promedioAVG(precio)
    FROM productos
    HAVING promedio >= 2500
    GROUP BY id, nombre
    ORDER BY promedio DESC;


--3. Crear una vista llamada vista_auditoria_precios que muestre:
--El nombre del producto, precio anterior, precio nuevo, fecha de cambio, y el usuario que realizó la modificación.
--Esta vista debe basarse en una tabla auditoria_precios con relación a la tabla productos.

CREATE VIEW vista_auditoria_precios
    SELECT  c.nombre, A.id_producto, A.precio_anterior, A.precio_nuevo, A.fecha_cambio
    FROM auditoria_precios A
    JOIN productos c = id 
    GROUP BY c.nombre, A.id_producto, A.precio_anterior, A.precio_nuevo, A.fecha_cambio;

SELECT vista_auditoria_precios


--4. Crear un trigger llamado registrar_cambio_precio_trigger que:
--Se ejecute después de actualizar el precio de un producto.
--Inserte automáticamente un registro en la tabla auditoria_precios con:
--ID del producto, precio anterior, nuevo precio, fecha actual (NOW()), y usuario (CURRENT_USER()).
DELIMITER //
CREATE TRIGGER registrar_cambio_precio_trigger
AFTER UPADTE ON productos
FOR EACH ROW
BEGIN
    IF OLD.precio <> NEW.precio THEN
        INSERT INTO auditoria_precios (id_producto, precio_anterior, precio_nuevo, fecha_cambio)
        VALUES (NEW.id, OLD.precio, NEW.precio, NOW());
    END IF;
END //
DELIMITER ;

SELECT registrar_cambio_precio_trigger
