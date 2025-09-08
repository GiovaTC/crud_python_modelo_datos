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
