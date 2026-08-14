USE gaseosas_valle;
-- Función 1: Calcular total con IVA (19%) a partir de subtotales
DELIMITER //


CREATE FUNCTION fn_calcular_total_con_iva(p_id_pedido INT)
RETURNS DECIMAL(10,2)
DETERMINISTIC
READS SQL DATA
BEGIN
    DECLARE v_total_sin_iva DECIMAL(10,2);
    DECLARE v_total_con_iva DECIMAL(10,2);
    
    SELECT IFNULL(SUM(subtotal), 0) INTO v_total_sin_iva
    FROM detalle_pedidos
    WHERE id_pedido = p_id_pedido;
    
    SET v_total_con_iva = v_total_sin_iva * 1.19;
    RETURN v_total_con_iva;
END //

-- Función 2: Validar disponibilidad de stock
CREATE FUNCTION fn_validar_stock(p_id_producto INT, p_cantidad INT)
RETURNS VARCHAR(100)
DETERMINISTIC
READS SQL DATA
BEGIN
    DECLARE v_stock_actual INT;
    
    SELECT stock_actual INTO v_stock_actual
    FROM productos
    WHERE id = p_id_producto;
    
    IF v_stock_actual IS NULL THEN
        RETURN 'Error: Producto no existe';
    ELSEIF v_stock_actual >= p_cantidad THEN
        RETURN 'Stock suficiente';
    ELSE
        RETURN 'Stock insuficiente';
    END IF;
END //

DELIMITER ;