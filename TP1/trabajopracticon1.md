# Ejercicio 1: Reglas de Integridad

Tenemos una base de datos universitaria con las tablas `estudiantes` y `matriculas`
Una posible violación a la integridad referencial ocurre si se elimina un estudiante que tiene cursos inscriptos. Por ese motivo usamos " On delete restrict"

CREATE DATABASE IF NOT EXISTS universidad;
USE universidad;

CREATE TABLE IF NOT EXISTS estudiantes (
	id INT PRIMARY KEY,
    nombre VARCHAR(100)
);

CREATE TABLE IF NOT EXISTS matriculas (
    id INT PRIMARY KEY,
    id_estudiante INT,
    curso VARCHAR(100),
    FOREIGN KEY (id_estudiante) REFERENCES Estudiantes(id)
    ON DELETE RESTRICT
);

# Ejercicio 2: Implementación de Restricciones

Crear una tabla `matriculas` con claves foráneas hacia `estudiantes` y `cursos`. Luego insertar datos inválidos:

```sql
CREATE TABLE matriculas (
    id INT AUTO_INCREMENT PRIMARY KEY,
    id_estudiante INT,
    id_curso INT,
    FOREIGN KEY (id_estudiante) REFERENCES estudiantes(id),
    FOREIGN KEY (id_curso) REFERENCES cursos(id)
);
```

Intentamos insertar un registro con un `id_estudiante` que no existe:

```sql
INSERT INTO matriculas (id_estudiante, id_curso)
VALUES (235, 1);
```

**Resultado esperado**:  
Se genera un error de integridad referencial como:
> ERROR 1452 (23000): Cannot add or update a child row: a foreign key constraint fails

---

# Ejercicio 3: Concurrencia

Supongamos que dos usuarios intentan actualizar el saldo de una cuenta al mismo tiempo.

```sql
-- Usuario A
START TRANSACTION;
SELECT saldo FROM cuentas WHERE id = 1;

-- Usuario B
START TRANSACTION;
SELECT saldo FROM cuentas WHERE id = 1;
```

Ambos intentan actualizar:

```sql
UPDATE cuentas SET saldo = saldo - 100 WHERE id = 1;
```

### Análisis:

- **READ COMMITTED**: puede causar condiciones de carrera .Los cambios de un usuario no se ven hasta que se confirman, pero puede haber problemas de escritura simultánea.
- **SERIALIZABLE**: bloquea la fila y asegura que las transacciones se ejecuten de forma secuencial, evitando inconsistencias.

```sql
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;
```

---

Ejercicio 4:


CREATE TABLE productos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(255),
    categoria VARCHAR(100),
    precio DECIMAL(10,2) 
);
-- Insertar 100,000 registros de ejemplo (puede hacerse con un script o generador de datos)

INSERT INTO productos (nombre, categoria, precio)
VALUES ('Iphone', 'Electronica', 1290.00);
-- (repetido o generado automáticamente hasta llegar a 100.000 filas)

Consulta sin indice:

-- Ejecutar EXPLAIN para ver el plan de ejecución

EXPLAIN SELECT * FROM productos WHERE categoria = 'Electronica';
OBSERVACIÓN: Sin índice, recorre toda la tabla , esto genera un alto costo de lectura cuando son muchos datos.

CREAMOS UN ÍNDICE:

CREATE INDEX idx_categoria ON productos(categoria);
Consultamos con el índice:

-- Volver a ejecutar el EXPLAIN

EXPLAIN SELECT * FROM productos WHERE categoria = 'Electronica';
OBSERVACIÓN: Al usar el índice (idx_categoria) mejora el tiempo de búsqueda
La creación de índices en campos utilizados frecuentemente en cláusulas WHERE mejora significativamente el desempeño de consultas en bases de datos grandes.


# Ejercicio 5: Creación de Índices

Consulta que filtra por múltiples campos:

```sql
SELECT * FROM ventas WHERE producto_id = 10 AND fecha BETWEEN '2024-01-01' AND '2024-12-31';
```

Creamos diferentes índices:

```sql
-- Índice solo por producto
CREATE INDEX idx_producto ON ventas(producto_id);

-- Índice compuesto por producto y fecha
CREATE INDEX idx_producto_fecha ON ventas(producto_id, fecha);
```

Usar `EXPLAIN` para comparar:

```sql
EXPLAIN SELECT * FROM ventas WHERE producto_id = 10 AND fecha BETWEEN '2024-01-01' AND '2024-12-31';
```

El índice compuesto suele ofrecer mejor rendimiento cuando ambos campos se usan en el `WHERE`.

---

# Ejercicio 6: Vistas

Creamos la vista de ventas mensuales:

```sql
CREATE VIEW resumen_ventas AS
SELECT producto_id, MONTH(fecha) AS mes, SUM(cantidad) AS total_vendido
FROM ventas
GROUP BY producto_id, MONTH(fecha);
```

Consulta para los 5 productos más vendidos:

```sql
SELECT producto_id, SUM(total_vendido) AS total_anual
FROM resumen_ventas
GROUP BY producto_id
ORDER BY total_anual DESC
LIMIT 5;
```

---

# Ejercicio 7: Gestión de Permisos

Creamos un usuario:

```sql
CREATE USER 'analista'@'localhost' IDENTIFIED BY 'password453';
```

Le damos permiso solo de lectura:

```sql
GRANT SELECT ON base_datos.ventas TO 'analista'@'localhost';
```

Intentamos una inserción como ese usuario:

```sql
-- Conectado como analista
INSERT INTO ventas (producto_id, cantidad) VALUES (1, 5);
```

**Resultado esperado**:  
> ERROR 1142 (42000): INSERT command denied to user 'analista'@'localhost' for table 'ventas'

Esto demuestra que el usuario solo tiene permisos de lectura.

Ejercicio 8: Seguridad y Auditoría
Armamos la tabla:
-- Crear tabla clientes

CREATE TABLE clientes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(255),
    email VARCHAR(255)
);
-- Crear tabla de auditoría

CREATE TABLE auditoria_clientes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    cliente_id INT,
    accion VARCHAR(50),
    fecha TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
OBS: Agregamos trigger para la auditoría ( Cada vez que se inserta, actualiza o borra un cliente, se registra automáticamente en la tabla auditoria_clientes.)

-- Trigger para INSERT

CREATE TRIGGER auditoria_insert
AFTER INSERT ON clientes
FOR EACH ROW
INSERT INTO auditoria_clientes (cliente_id, accion)
VALUES (NEW.id, 'INSERT');
-- Trigger para registrar UPDATES

CREATE TRIGGER auditoria_update
AFTER UPDATE ON clientes
FOR EACH ROW
INSERT INTO auditoria_clientes (cliente_id, accion)
VALUES (NEW.id, 'UPDATE');
-- Trigger para DELETE/borrar

CREATE TRIGGER auditoria_delete
AFTER DELETE ON clientes
FOR EACH ROW
INSERT INTO auditoria_clientes (cliente_id, accion)
VALUES (OLD.id, 'DELETE');
Ejemplo de uso:

Conclusión:
Los triggers nos permiten registrar automáticamente las modificaciones sin necesidad de intervención manual. Esto es fundamental para mantener la trazabilidad y seguridad de la información en bases de datos críticas.
También se recomienda aplicar también restricciones o políticas de acceso sobre las tablas de auditoría para evitar manipulaciones no deseadas.

Ejercicio 9: Backup y Restore
Creación del backup en MySQL :

mysqldump -u usuario -p basededatos > backup.sql
Explicación de cada parte:

mysqldump: herramienta de línea de comandos para exportar bases de datos.
-u usuario: nombre del usuario de MySQL que tiene permisos de lectura.
-p: solicita la contraseña del usuario.
basededatos: nombre de la base de datos a respaldar.
: redirige la salida al archivo backup.sql.

En resumen esto: Crea un archivo llamado backup.sql que contiene todas las instrucciones SQL necesarias para recrear la base de datos.

Simulamos perdida de datos :

DROP DATABASE basededatos;
Restauramos de la base de datos:
Primero, se debe volver a crear la base de datos.

mysql -u usuario -p
Una vez dentro ejecutamos lo siguiente:

CREATE DATABASE basededatos; 
EXIT; 
Observación: Si la base ya existiera, debería eliminarse antes (DROP DATABASE basededatos;).

Restaurar el contenido del backup:

mysql -u usuario -p basededatos < backup.sql
Acá lo que hacemos es conectarnos a MySQL con el usuario especificado, le indicamos que la base de datos destino es basededatos y cargamos el contenido de backup.sql en esa base.
La base de datos basededatos es recreada con todas sus tablas, registros, índices y relaciones.