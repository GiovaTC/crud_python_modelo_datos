import pyodbc

def get_connection():
    return pyodbc.connect(
        "DRIVER={ODBC Driver 17 for SQL server}"
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