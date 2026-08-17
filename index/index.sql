USE gaseosas_valle;

CREATE INDEX indx_clientes_nombre ON clientes(nombre_compelto);
CREATE INDEX indx_producto_nombre ON productos(nombre);

CREATE INDEX indx_sede_nombre ON sedes(nombre);

CREATE INDEX indx_detalle_pedido_fecha ON detalle_pedidos (fecha);
