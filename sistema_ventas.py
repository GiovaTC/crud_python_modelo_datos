import pyodbc

def get_connection():
    return pyodbc.connect(
        "DRIVER={ODBC Driver 17 for SQL Server};"
        "SERVER=GTAPIERO-POLI;"          # Cambia si usas otro servidor
        "DATABASE=SistemaVentas;"
        "UID=sa;"                    # Usuario de SQL Server
        "PWD=tapiero;"
        "TrustServerCertificate=Yes;"
    )

# ---- ejemplo con clientes ----
def insertar_cliente(nombre, email, telefono):
    conn = get_connection()
    cursor = conn.cursor()
    cursor.execute("{CALL InsertarCliente(? , ?, ?)}", (nombre, email, telefono))
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

# ---- uso de prueba ----
if __name__ == "__main__":
    insertar_cliente("Carlos Pérez", "carlos@mail.com", "3001234567")
    consultar_clientes()
    actualizar_cliente(1, "Carlos Tapiero", "ctapiero@mail.com", "3019876543")
    consultar_clientes()
    eliminar_cliente(1)
    consultar_clientes()