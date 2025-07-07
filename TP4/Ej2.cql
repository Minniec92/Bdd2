CREATE (:Carrera {nombre: 'Programación'}), 
       (:Carrera {nombre: 'Base de datos'}), 
       (:Carrera {nombre: 'Metodología'});

CREATE (s1:Estudiante {nombre: 'Iván'}), 
       (s2:Estudiante {nombre: 'Angel'}), 
       (s3:Estudiante {nombre: 'Sergio'});

MATCH (s:Estudiante {nombre: 'Iván'}), (c:Carrera {nombre: 'Programación'})
CREATE (s)-[:PERTENECE_A]->(c);

MATCH (s:Estudiante {nombre: 'Sergio'}), (c:Carrera {nombre: 'Base de datos'})
CREATE (s)-[:PERTENECE_A]->(c);

MATCH (s:Estudiante {nombre: 'Angel'}), (c:Carrera {nombre: 'Metodología'})
CREATE (s)-[:PERTENECE_A]->(c);

CREATE (:Libro {titulo: 'Fundamentos de Bases de Datos', categoria: 'Base de datos'}),
       (:Libro {titulo: 'Diseño de Bases de datos relacionales', categoria: 'Base de datos'}),
       (:Libro {titulo: 'Scrum', categoria: 'Metodología'}),
       (:Libro {titulo: 'Python para todos', categoria: 'Programación'});

MATCH (s:Estudiante {nombre: 'Iván'}), (l:Libro {titulo: 'Fundamentos de Bases de Datos'})
CREATE (s)-[:PIDIO_PRESTADO {fecha: date('2025-07-01'), estado: 'Activo'}]->(l);

MATCH (s:Estudiante {nombre: 'Sergio'}), (l:Libro {titulo: 'Scrum'})
CREATE (s)-[:PIDIO_PRESTADO {fecha: date('2025-06-15'), estado: 'Devuelto'}]->(l);

MATCH (s:Estudiante {nombre: 'Iván'}), (l:Libro {titulo: 'Python para todos'})
CREATE (s)-[:PIDIO_PRESTADO {fecha: date('2025-07-02'), estado: 'Activo'}]->(l);

MATCH (s:Estudiante {nombre: 'Angel'}), (l:Libro {titulo: 'Diseño de Bases de datos relacionales'})
CREATE (s)-[:PIDIO_PRESTADO {fecha: date('2025-07-03'), estado: 'Activo'}]->(l);

MATCH (s:Estudiante {nombre: 'Sergio'}), (l:Libro {titulo: 'Diseño de Bases de datos relacionales'})
CREATE (s)-[:PIDIO_PRESTADO {fecha: date('2025-06-20'), estado: 'Devuelto'}]->(l);

// Consultas

MATCH (e:Estudiante)-[r:PIDIO_PRESTADO {estado: 'Activo'}]->(l:Libro)
RETURN l.titulo AS Libro, e.nombre AS PrestadoA, r.fecha AS Fecha;

MATCH (e:Estudiante)-[r:PIDIO_PRESTADO]->(l:Libro)
RETURN e.nombre AS Estudiante, COUNT(r) AS TotalPrestamos;

MATCH (e:Estudiante)-[r:PIDIO_PRESTADO {estado: 'Activo'}]->(l:Libro)
RETURN l.categoria AS Categoria, COUNT(r) AS PrestamosActivos
ORDER BY PrestamosActivos DESC;

MATCH (e:Estudiante)
WHERE NOT (e)-[:PIDIO_PRESTADO {estado: 'Activo'}]->(:Libro)
RETURN e.nombre AS EstudianteSinPrestamosActivos;
