CREATE (:Departamento {nombre: 'Ventas'}),
       (:Departamento {nombre: 'Ingeniería'}),
       (:Departamento {nombre: 'RRHH'});

CREATE (e1:Empleado {nombre: 'Estefania'}),
       (e2:Empleado {nombre: 'Fernando'}),
       (e3:Empleado {nombre: 'GianLuca'});

MATCH (e:Empleado {nombre: 'Estefania'}), (d:Departamento {nombre: 'Ventas'})
CREATE (e)-[:PERTENECE_A]->(d);

MATCH (e:Empleado {nombre: 'Fernando'}), (d:Departamento {nombre: 'Ingeniería'})
CREATE (e)-[:PERTENECE_A]->(d);

MATCH (e:Empleado {nombre: 'GianLuca'}), (d:Departamento {nombre: 'RRHH'})
CREATE (e)-[:PERTENECE_A]->(d);

CREATE (p1:Proyecto {nombre: 'Proyecto 1'}),
       (p2:Proyecto {nombre: 'Proyecto 2'});

MATCH (e:Empleado {nombre: 'Estefania'}), (p:Proyecto {nombre: 'Proyecto 1'})
CREATE (e)-[:TRABAJA_EN {horas: 24}]->(p);

MATCH (e:Empleado {nombre: 'Fernando'}), (p:Proyecto {nombre: 'Proyecto 1'})
CREATE (e)-[:TRABAJA_EN {horas: 5}]->(p);

MATCH (e:Empleado {nombre: 'GianLuca'}), (p:Proyecto {nombre: 'Proyecto 2'})
CREATE (e)-[:TRABAJA_EN {horas: 3}]->(p);

MATCH (e:Empleado {nombre: 'Fernando'}), (p:Proyecto {nombre: 'Proyecto 2'})
CREATE (e)-[:TRABAJA_EN {horas: 8}]->(p);

MATCH (e:Empleado {nombre: 'Estefania'}), (p:Proyecto {nombre: 'Proyecto 1'})
CREATE (e)-[:LIDERA]->(p);

MATCH (e:Empleado {nombre: 'GianLuca'}), (p:Proyecto {nombre: 'Proyecto 2'})
CREATE (e)-[:LIDERA]->(p);

// Consultas

MATCH (lider:Empleado)-[:LIDERA]->(p:Proyecto)
OPTIONAL MATCH (e:Empleado)-[:TRABAJA_EN]->(p)
RETURN p.nombre AS Proyecto, 
       lider.nombre AS Lider, 
       collect(e.nombre) AS EmpleadosAsignados;

MATCH (e:Empleado)-[r:TRABAJA_EN]->(p:Proyecto)
RETURN p.nombre AS Proyecto, 
       SUM(r.horas) AS TotalHoras;

MATCH (e:Empleado)-[:TRABAJA_EN]->(p:Proyecto)
WITH e, COUNT(DISTINCT p) AS numProyectos
WHERE numProyectos > 1
RETURN e.nombre AS Empleado, numProyectos;
