# crud_python_modelo_datos
📌 Sistema de Ventas – Modelo de Datos + Procedimientos + Backend en Python

Este ejemplo muestra cómo construir un sistema de ventas con:

Modelo de datos con 8 tablas en MySQL

Procedimientos almacenados para CRUD

Backend en Python para conectarse y ejecutar operaciones

🗄️ 1. Modelo de Datos (8 Tablas en MySQL)
CREATE DATABASE IF NOT EXISTS SistemaVentas;
USE SistemaVentas;

-- Tabla Clientes
CREATE TABLE Clientes (
    id_cliente INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100),
    email VARCHAR(100),
    telefono VARCHAR(20)
);

-- Tabla Categorias
CREATE TABLE Categorias (
    id_categoria INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100)
);

-- Tabla Productos
CREATE TABLE Productos (
    id_producto INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100),
    precio DECIMAL(10,2),
    id_categoria INT,
    FOREIGN KEY (id_categoria) REFERENCES Categorias(id_categoria)
);

-- Tabla Proveedores
CREATE TABLE Proveedores (
    id_proveedor INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100),
    telefono VARCHAR(20)
);

-- Tabla Inventario
CREATE TABLE Inventario (
    id_inventario INT AUTO_INCREMENT PRIMARY KEY,
    id_producto INT,
    cantidad INT,
    FOREIGN KEY (id_producto) REFERENCES Productos(id_producto)
);

-- Tabla Ventas
CREATE TABLE Ventas (
    id_venta INT AUTO_INCREMENT PRIMARY KEY,
    id_cliente INT,
    fecha DATE,
    total DECIMAL(10,2),
    FOREIGN KEY (id_cliente) REFERENCES Clientes(id_cliente)
);

-- Tabla DetalleVentas
CREATE TABLE DetalleVentas (
    id_detalle INT AUTO_INCREMENT PRIMARY KEY,
    id_venta INT,
    id_producto INT,
    cantidad INT,
    precio DECIMAL(10,2),
    FOREIGN KEY (id_venta) REFERENCES Ventas(id_venta),
    FOREIGN KEY (id_producto) REFERENCES Productos(id_producto)
);

-- Tabla Empleados
CREATE TABLE Empleados (
    id_empleado INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100),
    cargo VARCHAR(50),
    salario DECIMAL(10,2)
);

⚙️ 2. Procedimientos Almacenados (CRUD)

Ejemplo para la tabla Clientes:

-- Insertar Cliente
DELIMITER //
CREATE PROCEDURE InsertarCliente(IN p_nombre VARCHAR(100), IN p_email VARCHAR(100), IN p_telefono VARCHAR(20))
BEGIN
    INSERT INTO Clientes(nombre, email, telefono) VALUES (p_nombre, p_email, p_telefono);
END //
DELIMITER ;

-- Consultar Clientes
DELIMITER //
CREATE PROCEDURE ConsultarClientes()
BEGIN
    SELECT * FROM Clientes;
END //
DELIMITER ;

-- Actualizar Cliente
DELIMITER //
CREATE PROCEDURE ActualizarCliente(IN p_id INT, IN p_nombre VARCHAR(100), IN p_email VARCHAR(100), IN p_telefono VARCHAR(20))
BEGIN
    UPDATE Clientes 
    SET nombre = p_nombre, email = p_email, telefono = p_telefono 
    WHERE id_cliente = p_id;
END //
DELIMITER ;

-- Eliminar Cliente
DELIMITER //
CREATE PROCEDURE EliminarCliente(IN p_id INT)
BEGIN
    DELETE FROM Clientes WHERE id_cliente = p_id;
END //
DELIMITER ;

👉 Esta misma lógica se puede replicar para las demás tablas (Productos, Categorias, Proveedores, etc.).
🐍 3. Backend en Python (CRUD con Stored Procedures)
Instalación del conector:
pip install mysql-connector-python

Código Python:
import mysql.connector

# ---- Conexión ----
def get_connection():
    return mysql.connector.connect(
        host="localhost",
        user="root",
        password="tu_password",
        database="SistemaVentas"
    )

# ---- Insertar Cliente ----
def insertar_cliente(nombre, email, telefono):
    conn = get_connection()
    cursor = conn.cursor()
    cursor.callproc("InsertarCliente", (nombre, email, telefono))
    conn.commit()
    conn.close()
    print("✅ Cliente insertado con éxito")

# ---- Consultar Clientes ----
def consultar_clientes():
    conn = get_connection()
    cursor = conn.cursor()
    cursor.callproc("ConsultarClientes")
    for result in cursor.stored_results():
        for row in result.fetchall():
            print(row)
    conn.close()

# ---- Actualizar Cliente ----
def actualizar_cliente(id_cliente, nombre, email, telefono):
    conn = get_connection()
    cursor = conn.cursor()
    cursor.callproc("ActualizarCliente", (id_cliente, nombre, email, telefono))
    conn.commit()
    conn.close()
    print("✅ Cliente actualizado")

# ---- Eliminar Cliente ----
def eliminar_cliente(id_cliente):
    conn = get_connection()
    cursor = conn.cursor()
    cursor.callproc("EliminarCliente", (id_cliente,))
    conn.commit()
    conn.close()
    print("✅ Cliente eliminado")


# ---- Ejemplo de uso ----
if __name__ == "__main__":
    insertar_cliente("Carlos Pérez", "carlos@mail.com", "3001234567")
    consultar_clientes()
    actualizar_cliente(1, "Carlos P. Tapiero", "carlos_tapiero@mail.com", "3019876543")
    consultar_clientes()
    eliminar_cliente(1)
    consultar_clientes()

✅ Conclusión
Con este ejemplo tienes:
Modelo de datos con 8 tablas.
Procedimientos almacenados CRUD (ejemplo en Clientes, aplicable a las demás).
Backend en Python conectado a MySQL ejecutando las operaciones de Insertar, Consultar, Actualizar y Eliminar.
