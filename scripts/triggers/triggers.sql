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