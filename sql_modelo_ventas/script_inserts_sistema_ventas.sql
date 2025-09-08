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