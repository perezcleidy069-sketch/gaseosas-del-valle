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
