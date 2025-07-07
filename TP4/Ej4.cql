CREATE (e1:Estudiante {id:1, nombre: "Jose Luis", apellido: "Martinez", edad: 23, carrera: "Ingenieria de Sistemas"}),
       (e2: Estudiante {id:2, nombre: "Maria", apellido: "Gomez", edad: 22, carrera: "Profesorado de Matematicas"}),
       (e3: Estudiante {id:3, nombre: "Carlos", apellido: "Perez", edad: 24, carrera: "Ingenieria Civil"});

CREATE (m1: Materia {id:1, nombre: "Matematicas I"}),
       (m2: Materia {id:2, nombre: "Programacion I"}),
       (m3: Materia {id:3, nombre: "Calculo I"});

MATCH (m1:Materia {nombre: "Matematicas I"}), (m3:Materia {nombre: "Calculo I"})
CREATE (m1)-[:REQUISITO]->(m3);

CREATE (c1: Curso {id:1, nombre: "C-Matematicas I", semestre: 1}),
       (c2: Curso {id:2, nombre: "C-Programacion I", semestre: 1}),
       (c3: Curso {id:3, nombre: "C-Curso de Calculo I", semestre: 2}),
       (c4: Curso {id:4, nombre: "C2-Curso de Matematicas I", semestre: 2});

MATCH (c1:Curso {nombre: "C-Matematicas I"}), (m1:Materia {nombre: "Matematicas I"})
CREATE (c1)-[:CORRESPONDE_A]->(m1);
MATCH (c2:Curso {nombre: "C-Programacion I"}), (m2:Materia {nombre: "Programacion I"})
CREATE (c2)-[:CORRESPONDE_A]->(m2);
MATCH (c3:Curso {nombre: "C-Curso de Calculo I"}), (m3:Materia {nombre: "Calculo I"})
CREATE (c3)-[:CORRESPONDE_A]->(m3);
MATCH (c4:Curso {nombre: "C2-Curso de Matematicas I"}), (m1:Materia {nombre: "Matematicas I"})
CREATE (c4)-[:CORRESPONDE_A]->(m1);

MATCH (e1:Estudiante {id: 1}), (c1:Curso {id: 1})
CREATE (e1)-[:INSCRITO_EN]->(c1),
 (e1)-[:OBTUVO {nota: 8}]->(c1);

MATCH (e1:Estudiante {id:1}), (c2:Curso {id:2})
CREATE (e1)-[:INSCRITO_EN]->(c2),
       (e1)-[:OBTUVO {nota: 9}]->(c2);

MATCH (e2:Estudiante {id:2}), (c1:Curso {id:1})
CREATE (e2)-[:INSCRITO_EN]->(c1),
       (e2)-[:OBTUVO {nota: 6}]->(c1);

MATCH (e2:Estudiante {id:2}), (c3:Curso {id:3})
CREATE (e2)-[:INSCRITO_EN]->(c3),
       (e2)-[:OBTUVO {nota: 7}]->(c3);


MATCH (e3:Estudiante {id:3}), (c2:Curso {id:2})
CREATE (e3)-[:INSCRITO_EN]->(c2),
       (e3)-[:OBTUVO {nota: 5}]->(c2);

MATCH (e3:Estudiante {id:3}), (c4:Curso {id:4})
CREATE (e3)-[:INSCRITO_EN]->(c4),
       (e3)-[:OBTUVO {nota: 8}]->(c4);

MATCH (e:Estudiante {id:1})-[r:OBTUVO]->(c:Curso)-[:CORRESPONDE_A]->(m:Materia)
RETURN m.nombre AS Materia, c.nombre AS Curso, r.nota AS Nota;

MATCH (pre:Materia)-[:REQUISITO]->(m:Materia {nombre: "Calculo I"})
MATCH (c:Curso)-[:CORRESPONDE_A]->(pre)
MATCH (e:Estudiante {id:2})-[r:OBTUVO]->(c)
RETURN pre.nombre AS Requisito, r.nota AS Nota,
  CASE WHEN r.nota >= 6 THEN "Cumple" ELSE "No cumple" END AS Estado;

MATCH (e:Estudiante)-[r:OBTUVO]->()
RETURN e.nombre AS Estudiante, ROUND(AVG(r.nota),2) AS Promedio;

MATCH (c:Curso)-[:CORRESPONDE_A]->(m:Materia)
MATCH ()-[r:OBTUVO]->(c)
WITH m.nombre AS Materia, AVG(r.nota) AS Promedio
WHERE Promedio < 7
RETURN Materia, ROUND(Promedio,2) AS Promedio;
