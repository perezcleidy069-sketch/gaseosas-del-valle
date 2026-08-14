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