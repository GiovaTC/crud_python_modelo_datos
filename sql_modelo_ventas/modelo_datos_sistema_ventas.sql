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
--Procedimientos Almacenados (CRUD para 8 tablas)
--Clientes
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

--Categorias
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

--Productos
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

--Proveedores
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

--Inventario
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

--Ventas
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

--DetalleVentas
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

--Empleados
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
