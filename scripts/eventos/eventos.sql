
USE gaseosas_valle;

-- Evento 1: Revisa el stock crítico diariamente a las 06:00 AM
DELIMITER //

CREATE EVENT IF NOT EXISTS evt_alerta_stock_critico
ON SCHEDULE EVERY 1 DAY
STARTS '2026-08-14 06:00:00'
DO
BEGIN
    INSERT INTO alertas_stock (id_producto, mensaje, fecha_alerta)
    SELECT 
        id, 
        CONCAT('ALERTA: El producto "', nombre, '" requiere reabastecimiento. Stock actual: ', stock_actual),
        NOW()
    FROM productos
    WHERE stock_actual <= stock_minimo;
END //

DELIMITER ;