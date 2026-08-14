CREATE DATABASE gaseosas_valle;
USE gaseosas_valle;

CREATE TABLE clientes(
	id INT PRIMARY KEY AUTO_INCREMENT,
    nombre_completo VARCHAR(200) NOT NULL,
    identificacion CHAR(10) UNIQUE,
    direccion VARCHAR(60) NOT NULL,
    id_municipio INT NOT NULL,
    telefono CHAR(12) NOT NULL,
    correo_electronico varchar(50) NOT NULL UNIQUE,
    
    FOREIGN KEY (id_municipio) REFERENCES municipios(id)
)ENGINE=InnoDB;

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