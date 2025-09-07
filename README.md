# crud_python_modelo_datos
# 📌 Sistema de Ventas – SQL Server + Python

## 🗄️ 1. Modelo de Datos en SQL Server

```sql
CREATE DATABASE SistemaVentas;
GO
USE SistemaVentas;
GO

-- Tabla Clientes
CREATE TABLE Clientes (
    id_cliente INT IDENTITY(1,1) PRIMARY KEY,
    nombre NVARCHAR(100),
    email NVARCHAR(100),
    telefono NVARCHAR(20)
);

-- Tabla Categorias
CREATE TABLE Categorias (
    id_categoria INT IDENTITY(1,1) PRIMARY KEY,
    nombre NVARCHAR(100)
);

-- Tabla Productos
CREATE TABLE Productos (
    id_producto INT IDENTITY(1,1) PRIMARY KEY,
    nombre NVARCHAR(100),
    precio DECIMAL(10,2),
    id_categoria INT FOREIGN KEY REFERENCES Categorias(id_categoria)
);

-- Tabla Proveedores
CREATE TABLE Proveedores (
    id_proveedor INT IDENTITY(1,1) PRIMARY KEY,
    nombre NVARCHAR(100),
    telefono NVARCHAR(20)
);

-- Tabla Inventario
CREATE TABLE Inventario (
    id_inventario INT IDENTITY(1,1) PRIMARY KEY,
    id_producto INT FOREIGN KEY REFERENCES Productos(id_producto),
    cantidad INT
);

-- Tabla Ventas
CREATE TABLE Ventas (
    id_venta INT IDENTITY(1,1) PRIMARY KEY,
    id_cliente INT FOREIGN KEY REFERENCES Clientes(id_cliente),
    fecha DATE,
    total DECIMAL(10,2)
);

-- Tabla DetalleVentas
CREATE TABLE DetalleVentas (
    id_detalle INT IDENTITY(1,1) PRIMARY KEY,
    id_venta INT FOREIGN KEY REFERENCES Ventas(id_venta),
    id_producto INT FOREIGN KEY REFERENCES Productos(id_producto),
    cantidad INT,
    precio DECIMAL(10,2)
);

-- Tabla Empleados
CREATE TABLE Empleados (
    id_empleado INT IDENTITY(1,1) PRIMARY KEY,
    nombre NVARCHAR(100),
    cargo NVARCHAR(50),
    salario DECIMAL(10,2)
);

⚙️ 2. Procedimientos Almacenados (CRUD para 8 tablas)
🔹 Clientes
sql

CREATE OR ALTER PROCEDURE InsertarCliente
    @nombre NVARCHAR(100), @email NVARCHAR(100), @telefono NVARCHAR(20)
AS
BEGIN
    INSERT INTO Clientes(nombre, email, telefono) VALUES (@nombre, @email, @telefono);
END
GO

CREATE OR ALTER PROCEDURE ConsultarClientes
AS
BEGIN
    SELECT * FROM Clientes;
END
GO

CREATE OR ALTER PROCEDURE ActualizarCliente
    @id_cliente INT, @nombre NVARCHAR(100), @email NVARCHAR(100), @telefono NVARCHAR(20)
AS
BEGIN
    UPDATE Clientes SET nombre=@nombre, email=@email, telefono=@telefono WHERE id_cliente=@id_cliente;
END
GO

CREATE OR ALTER PROCEDURE EliminarCliente
    @id_cliente INT
AS
BEGIN
    DELETE FROM Clientes WHERE id_cliente=@id_cliente;
END
GO

🔹 Categorias
sql

CREATE OR ALTER PROCEDURE InsertarCategoria
    @nombre NVARCHAR(100)
AS
BEGIN
    INSERT INTO Categorias(nombre) VALUES (@nombre);
END
GO

CREATE OR ALTER PROCEDURE ConsultarCategorias
AS
BEGIN
    SELECT * FROM Categorias;
END
GO

CREATE OR ALTER PROCEDURE ActualizarCategoria
    @id_categoria INT, @nombre NVARCHAR(100)
AS
BEGIN
    UPDATE Categorias SET nombre=@nombre WHERE id_categoria=@id_categoria;
END
GO

CREATE OR ALTER PROCEDURE EliminarCategoria
    @id_categoria INT
AS
BEGIN
    DELETE FROM Categorias WHERE id_categoria=@id_categoria;
END
GO

🔹 Productos
sql

CREATE OR ALTER PROCEDURE InsertarProducto
    @nombre NVARCHAR(100), @precio DECIMAL(10,2), @id_categoria INT
AS
BEGIN
    INSERT INTO Productos(nombre, precio, id_categoria) VALUES (@nombre, @precio, @id_categoria);
END
GO

CREATE OR ALTER PROCEDURE ConsultarProductos
AS
BEGIN
    SELECT * FROM Productos;
END
GO

CREATE OR ALTER PROCEDURE ActualizarProducto
    @id_producto INT, @nombre NVARCHAR(100), @precio DECIMAL(10,2), @id_categoria INT
AS
BEGIN
    UPDATE Productos SET nombre=@nombre, precio=@precio, id_categoria=@id_categoria WHERE id_producto=@id_producto;
END
GO

CREATE OR ALTER PROCEDURE EliminarProducto
    @id_producto INT
AS
BEGIN
    DELETE FROM Productos WHERE id_producto=@id_producto;
END
GO

🔹 Proveedores
sql

CREATE OR ALTER PROCEDURE InsertarProveedor
    @nombre NVARCHAR(100), @telefono NVARCHAR(20)
AS
BEGIN
    INSERT INTO Proveedores(nombre, telefono) VALUES (@nombre, @telefono);
END
GO

CREATE OR ALTER PROCEDURE ConsultarProveedores
AS
BEGIN
    SELECT * FROM Proveedores;
END
GO

CREATE OR ALTER PROCEDURE ActualizarProveedor
    @id_proveedor INT, @nombre NVARCHAR(100), @telefono NVARCHAR(20)
AS
BEGIN
    UPDATE Proveedores SET nombre=@nombre, telefono=@telefono WHERE id_proveedor=@id_proveedor;
END
GO

CREATE OR ALTER PROCEDURE EliminarProveedor
    @id_proveedor INT
AS
BEGIN
    DELETE FROM Proveedores WHERE id_proveedor=@id_proveedor;
END
GO

🔹 Inventario
sql

CREATE OR ALTER PROCEDURE InsertarInventario
    @id_producto INT, @cantidad INT
AS
BEGIN
    INSERT INTO Inventario(id_producto, cantidad) VALUES (@id_producto, @cantidad);
END
GO

CREATE OR ALTER PROCEDURE ConsultarInventario
AS
BEGIN
    SELECT * FROM Inventario;
END
GO

CREATE OR ALTER PROCEDURE ActualizarInventario
    @id_inventario INT, @id_producto INT, @cantidad INT
AS
BEGIN
    UPDATE Inventario SET id_producto=@id_producto, cantidad=@cantidad WHERE id_inventario=@id_inventario;
END
GO

CREATE OR ALTER PROCEDURE EliminarInventario
    @id_inventario INT
AS
BEGIN
    DELETE FROM Inventario WHERE id_inventario=@id_inventario;
END
GO

🔹 Ventas
sql

CREATE OR ALTER PROCEDURE InsertarVenta
    @id_cliente INT, @fecha DATE, @total DECIMAL(10,2)
AS
BEGIN
    INSERT INTO Ventas(id_cliente, fecha, total) VALUES (@id_cliente, @fecha, @total);
END
GO

CREATE OR ALTER PROCEDURE ConsultarVentas
AS
BEGIN
    SELECT * FROM Ventas;
END
GO

CREATE OR ALTER PROCEDURE ActualizarVenta
    @id_venta INT, @id_cliente INT, @fecha DATE, @total DECIMAL(10,2)
AS
BEGIN
    UPDATE Ventas SET id_cliente=@id_cliente, fecha=@fecha, total=@total WHERE id_venta=@id_venta;
END
GO

CREATE OR ALTER PROCEDURE EliminarVenta
    @id_venta INT
AS
BEGIN
    DELETE FROM Ventas WHERE id_venta=@id_venta;
END
GO

🔹 DetalleVentas
sql

CREATE OR ALTER PROCEDURE InsertarDetalleVenta
    @id_venta INT, @id_producto INT, @cantidad INT, @precio DECIMAL(10,2)
AS
BEGIN
    INSERT INTO DetalleVentas(id_venta, id_producto, cantidad, precio) VALUES (@id_venta, @id_producto, @cantidad, @precio);
END
GO

CREATE OR ALTER PROCEDURE ConsultarDetalleVentas
AS
BEGIN
    SELECT * FROM DetalleVentas;
END
GO

CREATE OR ALTER PROCEDURE ActualizarDetalleVenta
    @id_detalle INT, @id_venta INT, @id_producto INT, @cantidad INT, @precio DECIMAL(10,2)
AS
BEGIN
    UPDATE DetalleVentas SET id_venta=@id_venta, id_producto=@id_producto, cantidad=@cantidad, precio=@precio WHERE id_detalle=@id_detalle;
END
GO

CREATE OR ALTER PROCEDURE EliminarDetalleVenta
    @id_detalle INT
AS
BEGIN
    DELETE FROM DetalleVentas WHERE id_detalle=@id_detalle;
END
GO

🔹 Empleados
sql

CREATE OR ALTER PROCEDURE InsertarEmpleado
    @nombre NVARCHAR(100), @cargo NVARCHAR(50), @salario DECIMAL(10,2)
AS
BEGIN
    INSERT INTO Empleados(nombre, cargo, salario) VALUES (@nombre, @cargo, @salario);
END
GO

CREATE OR ALTER PROCEDURE ConsultarEmpleados
AS
BEGIN
    SELECT * FROM Empleados;
END
GO

CREATE OR ALTER PROCEDURE ActualizarEmpleado
    @id_empleado INT, @nombre NVARCHAR(100), @cargo NVARCHAR(50), @salario DECIMAL(10,2)
AS
BEGIN
    UPDATE Empleados SET nombre=@nombre, cargo=@cargo, salario=@salario WHERE id_empleado=@id_empleado;
END
GO

CREATE OR ALTER PROCEDURE EliminarEmpleado
    @id_empleado INT
AS
BEGIN
    DELETE FROM Empleados WHERE id_empleado=@id_empleado;
END
GO

🐍 3. Backend en Python (conexión a SQL Server)

python
import pyodbc

def get_connection():
    return pyodbc.connect(
        "DRIVER={ODBC Driver 17 for SQL Server};"
        "SERVER=localhost;"          # Cambia si usas otro servidor
        "DATABASE=SistemaVentas;"
        "UID=sa;"                    # Usuario de SQL Server
        "PWD=tu_password;"
        "TrustServerCertificate=Yes;"
    )

# ---- Ejemplo con Clientes ----
def insertar_cliente(nombre, email, telefono):
    conn = get_connection()
    cursor = conn.cursor()
    cursor.execute("{CALL InsertarCliente(?, ?, ?)}", (nombre, email, telefono))
    conn.commit()
    conn.close()

def consultar_clientes():
    conn = get_connection()
    cursor = conn.cursor()
    cursor.execute("{CALL ConsultarClientes}")
    for row in cursor.fetchall():
        print(row)
    conn.close()

def actualizar_cliente(id_cliente, nombre, email, telefono):
    conn = get_connection()
    cursor = conn.cursor()
    cursor.execute("{CALL ActualizarCliente(?, ?, ?, ?)}", (id_cliente, nombre, email, telefono))
    conn.commit()
    conn.close()

def eliminar_cliente(id_cliente):
    conn = get_connection()
    cursor = conn.cursor()
    cursor.execute("{CALL EliminarCliente(?)}", (id_cliente,))
    conn.commit()
    conn.close()

# ---- Uso de prueba ----
if __name__ == "__main__":
    insertar_cliente("Carlos Pérez", "carlos@mail.com", "3001234567")
    consultar_clientes()
    actualizar_cliente(1, "Carlos Tapiero", "ctapiero@mail.com", "3019876543")
    consultar_clientes()
    eliminar_cliente(1)
    consultar_clientes()

✅ Conclusión

Con esta implementación tienes:
📊 Modelo de datos en SQL Server con 8 tablas.
⚙️ 32 procedimientos almacenados (CRUD para cada tabla).
🐍 Backend en Python con pyodbc para conectarse y manipular datos.
-- ===============================
# 📌 Script de Datos Iniciales – Sistema de Ventas (SQL Server)
## 🗄️ Script SQL

```sql
USE SistemaVentas;
GO

-- ===============================
-- Poblar Categorías
-- ===============================
INSERT INTO Categorias (nombre) VALUES
('Electrónica'),
('Hogar'),
('Ropa'),
('Alimentos'),
('Juguetes');

-- ===============================
-- Poblar Proveedores
-- ===============================
INSERT INTO Proveedores (nombre, telefono) VALUES
('Proveedor Tech', '3101111111'),
('Proveedor Hogar', '3102222222'),
('Proveedor Moda', '3103333333'),
('Proveedor Market', '3104444444');

-- ===============================
-- Poblar Productos
-- ===============================
INSERT INTO Productos (nombre, precio, id_categoria) VALUES
('Televisor', 1200.00, 1),
('Celular', 900.00, 1),
('Sofá', 1500.00, 2),
('Camiseta', 50.00, 3),
('Arroz 5kg', 20.00, 4),
('Muñeca', 35.00, 5);

-- ===============================
-- Poblar Inventario
-- ===============================
INSERT INTO Inventario (id_producto, cantidad) VALUES
(1, 10),
(2, 25),
(3, 5),
(4, 100),
(5, 200),
(6, 50);

-- ===============================
-- Poblar Clientes
-- ===============================
INSERT INTO Clientes (nombre, email, telefono) VALUES
('Carlos Pérez', 'carlos@mail.com', '3001111111'),
('Ana Torres', 'ana@mail.com', '3002222222'),
('Luis Gómez', 'luis@mail.com', '3003333333');

-- ===============================
-- Poblar Ventas
-- ===============================
INSERT INTO Ventas (id_cliente, fecha, total) VALUES
(1, '2025-09-01', 1220.00),
(2, '2025-09-02', 70.00);

-- ===============================
-- Poblar DetalleVentas
-- ===============================
INSERT INTO DetalleVentas (id_venta, id_producto, cantidad, precio) VALUES
(1, 1, 1, 1200.00),
(1, 5, 1, 20.00),
(2, 4, 1, 50.00),
(2, 6, 1, 20.00);

-- ===============================
-- Poblar Empleados
-- ===============================
INSERT INTO Empleados (nombre, cargo, salario) VALUES
('Pedro López', 'Vendedor', 1200.00),
('María Ruiz', 'Cajera', 1100.00),
('Jorge Castro', 'Administrador', 2000.00);

🐍 Ejemplo rápido en Python
python

if __name__ == "__main__":
    print("=== Clientes ===")
    consultar_clientes()

    print("\n=== Productos ===")
    conn = get_connection()
    cursor = conn.cursor()
    cursor.execute("{CALL ConsultarProductos}")
    for row in cursor.fetchall():
        print(row)
    conn.close()

    print("\n=== Ventas ===")
    conn = get_connection()
    cursor = conn.cursor()
    cursor.execute("{CALL ConsultarVentas}")
    for row in cursor.fetchall():
        print(row)
    conn.close()

✅ Con este dataset inicial ya puedes:
✔ Probar consultas.
✔ Actualizar registros.
✔ Insertar nuevos datos desde Python.
✔ Eliminar registros de prueba.
