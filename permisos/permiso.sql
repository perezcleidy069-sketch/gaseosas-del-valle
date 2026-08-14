-- =============================================
-- 1. USUARIO ADMINISTRADOR (Acceso Total)
-- =============================================
CREATE USER IF NOT EXISTS 'admin_valle'@'localhost' IDENTIFIED BY 'AdminPassword123!';

-- Conceder todos los privilegios sobre la base de datos gaseosas_valle
GRANT ALL PRIVILEGES ON gaseosas_valle.* TO 'admin_valle'@'localhost' WITH GRANT OPTION;


-- =============================================
-- 2. USUARIO OPERATIVO / ENCARGADO DE SEDE
-- (Insertar, actualizar y consultar ventas/inventario)
-- =============================================
CREATE USER IF NOT EXISTS 'operador_sede'@'localhost' IDENTIFIED BY 'SedePassword123!';

-- Permisos de lectura y escritura en tablas operativas
GRANT SELECT, INSERT, UPDATE ON gaseosas_valle.pedidos TO 'operador_sede'@'localhost';
GRANT SELECT, INSERT, UPDATE ON gaseosas_valle.detalle_pedidos TO 'operador_sede'@'localhost';
GRANT SELECT, UPDATE ON gaseosas_valle.productos TO 'operador_sede'@'localhost';
GRANT SELECT ON gaseosas_valle.clientes TO 'operador_sede'@'localhost';
GRANT SELECT ON gaseosas_valle.sedes TO 'operador_sede'@'localhost';

-- Permisos para ejecutar las funciones personalizadas
GRANT EXECUTE ON FUNCTION gaseosas_valle.fn_calcular_total_con_iva TO 'operador_sede'@'localhost';
GRANT EXECUTE ON FUNCTION gaseosas_valle.fn_validar_stock TO 'operador_sede'@'localhost';


-- =============================================
-- 3. USUARIO DE CONSULTA / AUDITORÍA (Solo Lectura)
-- =============================================
CREATE USER IF NOT EXISTS 'auditor_valle'@'localhost' IDENTIFIED BY 'AuditorPassword123!';

-- Permiso de solo lectura en tablas y vistas
GRANT SELECT ON gaseosas_valle.* TO 'auditor_valle'@'localhost';


-- =============================================
-- APLICAR Y CONFIRMAR PERMISOS
-- =============================================
FLUSH PRIVILEGES;

-- Comando para verificar los permisos asignados a un usuario:
-- SHOW GRANTS FOR 'operador_sede'@'localhost';