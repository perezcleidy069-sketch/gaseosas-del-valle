USE gaseosas_valle;

-- Trigger 1: Descontar stock al insertar un detalle de pedido
DELIMITER //


CREATE TRIGGER tr_actualizar_stock
AFTER INSERT ON detalle_pedidos
FOR EACH ROW
BEGIN
    UPDATE productos
    SET stock_actual = stock_actual - NEW.cantidad
    WHERE id = NEW.id_producto;
END //

DELIMITER ;


-- Trigger 2: Registrar cambios de precio en auditoria_precios

DELIMITER //
CREATE TRIGGER tr_audit_cambio_precio
AFTER UPDATE ON productos
FOR EACH ROW
BEGIN
    IF OLD.precio <> NEW.precio THEN
        INSERT INTO auditoria_precios (id_producto, precio_anterior, precio_nuevo, fecha_cambio)
        VALUES (NEW.id, OLD.precio, NEW.precio, NOW());
    END IF;
END //

DELIMITER ;