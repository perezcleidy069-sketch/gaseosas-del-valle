CREATE DATABASE gaseosas_valle;
USE gaseosas_valle;

SET FOREIGN_KEY_CHECKS = 0;
DROP TABLE IF EXISTS detalle_pedidos;
DROP TABLE IF EXISTS alertas_stock;
DROP TABLE IF EXISTS auditoria_precios;
DROP TABLE IF EXISTS pedidos;
DROP TABLE IF EXISTS productos;
DROP TABLE IF EXISTS categoria;
DROP TABLE IF EXISTS sedes;
DROP TABLE IF EXISTS encargados;
DROP TABLE IF EXISTS clientes;
DROP TABLE IF EXISTS municipios;
DROP TABLE IF EXISTS departamentos;
SET FOREIGN_KEY_CHECKS = 1;

-- Tablas primarias (Independientes)
CREATE TABLE departamentos (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(90) NOT NULL
) ENGINE=InnoDB;

CREATE TABLE municipios (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(80) NOT NULL,
    id_departamento INT NOT NULL,
    FOREIGN KEY (id_departamento) REFERENCES departamentos(id)
) ENGINE=InnoDB;

CREATE TABLE categoria (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL
) ENGINE=InnoDB;

CREATE TABLE encargados (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL,
    rol VARCHAR(90) NOT NULL
) ENGINE=InnoDB;

-- Tablas secundarias
CREATE TABLE clientes(
    id INT PRIMARY KEY AUTO_INCREMENT,
    nombre_completo VARCHAR(200) NOT NULL,
    identificacion CHAR(10) UNIQUE,
    direccion VARCHAR(60) NOT NULL,
    id_municipio INT NOT NULL,
    telefono CHAR(12) NOT NULL,
    correo VARCHAR(50) NOT NULL UNIQUE,
    FOREIGN KEY (id_municipio) REFERENCES municipios(id)
) ENGINE=InnoDB;

CREATE TABLE sedes (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL,
    ubicacion VARCHAR(100) NOT NULL,
    id_municipio INT NOT NULL,
    capacidad_almacenamiento INT NOT NULL,
    id_encargado INT NOT NULL,
    FOREIGN KEY (id_municipio) REFERENCES municipios(id),
    FOREIGN KEY (id_encargado) REFERENCES encargados(id)
) ENGINE=InnoDB;

CREATE TABLE productos (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL,
    id_categoria INT NOT NULL,
    precio DECIMAL(10,2) CHECK(precio > 0),
    volumen_ml VARCHAR(100) NOT NULL,
    stock_actual INT NOT NULL,
    stock_minimo INT NOT NULL,
    FOREIGN KEY (id_categoria) REFERENCES categoria(id)
) ENGINE=InnoDB;

-- Tablas transaccionales y de auditoría
CREATE TABLE pedidos (
    id INT PRIMARY KEY AUTO_INCREMENT,
    fecha DATETIME NOT NULL,
    id_cliente INT NOT NULL,
    id_sede INT NOT NULL,
    total_sin_iva DECIMAL(10,2) CHECK(total_sin_iva >= 0),
    total_con_iva DECIMAL(10,2) CHECK(total_con_iva >= 0),
    FOREIGN KEY (id_cliente) REFERENCES clientes(id),
    FOREIGN KEY (id_sede) REFERENCES sedes(id)
) ENGINE=InnoDB;

CREATE TABLE detalle_pedidos (
    id_pedido INT NOT NULL,
    id_producto INT NOT NULL,
    cantidad INT NOT NULL,
    subtotal DECIMAL(10,2) CHECK(subtotal > 0),
    PRIMARY KEY (id_pedido, id_producto),
    FOREIGN KEY (id_pedido) REFERENCES pedidos(id),
    FOREIGN KEY (id_producto) REFERENCES productos(id)
) ENGINE=InnoDB;

CREATE TABLE auditoria_precios (
    id INT PRIMARY KEY AUTO_INCREMENT,
    id_producto INT NOT NULL,
    precio_anterior DECIMAL(10,2),
    precio_nuevo DECIMAL(10,2),
    fecha_cambio DATETIME NOT NULL,
    FOREIGN KEY (id_producto) REFERENCES productos(id)
) ENGINE=InnoDB;

CREATE TABLE alertas_stock (
    id INT PRIMARY KEY AUTO_INCREMENT,
    id_producto INT NOT NULL,
    mensaje VARCHAR(255) NOT NULL,
    fecha_alerta DATETIME NOT NULL,
    FOREIGN KEY (id_producto) REFERENCES productos(id)
) ENGINE=InnoDB;