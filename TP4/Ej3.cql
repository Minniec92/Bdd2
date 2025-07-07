CREATE
    (u1:Usuario {nombre: 'Miguel'}),
    (u2:Usuario {nombre: 'Mónica'}),
    (u3:Usuario {nombre: 'Gustavo'}),
    (u4:Usuario {nombre: 'Mariano'});


MATCH (u1:Usuario {nombre: 'Miguel'}), (u2:Usuario {nombre: ' Mónica'})
CREATE (u1)-[:CONOCE]->(u2);

MATCH (u2:Usuario {nombre: ' Mónica'}), (u3:Usuario {nombre: 'Gustavo'})
CREATE (u2)-[:CONOCE]->(u3);

MATCH (u3:Usuario {nombre: 'Gustavo'}), (u4:Usuario {nombre: 'Mariano'})
CREATE (u3)-[:CONOCE]->(u4);

MATCH (u4:Usuario {nombre: 'Mariano'}), (u1:Usuario {nombre: 'Miguel'})
CREATE (u4)-[:CONOCE]->(u1);


CREATE
    (p1:Post {titulo: 'Aprendiendo a cocinar con mamá', fecha: date('2025-07-10')}),
    (p2:Post {titulo: 'Leyendo mi libro favorito', fecha: date('2025-07-11')}),
    (p3:Post {titulo: 'Viajecito express por Iguazú', fecha: date('2025-07-12')});


MATCH (u1:Usuario {nombre: 'Miguel'}), (p1:Post {titulo: 'Viajecito express por Iguazú'})
CREATE (u1)-[:PUBLICA]->(p1);

MATCH (u2:Usuario {nombre: ' Mónica'}), (p2:Post {titulo: 'Aprendiendo a cocinar con mamá'})
CREATE (u2)-[:PUBLICA]->(p2);

MATCH (u3:Usuario {nombre: 'Gustavo'}), (p3:Post {titulo: 'Leyendo mi libro favorito'})
CREATE (u3)-[:PUBLICA]->(p3);

CREATE
    (h1:Habilidad {nombre: 'MongodB'}),
    (h2:Habilidad {nombre: 'Python'}),
    (h3:Habilidad {nombre: 'My SQL'}),
    (h4:Habilidad {nombre: 'Node.js'});


MATCH (u1:Usuario {nombre: 'Miguel'}), (h1:Habilidad {nombre: 'MongodB'})
CREATE (u1)-[:TIENE_HABILIDAD]->(h1);

MATCH (u1:Usuario {nombre: 'Miguel'}), (h2:Habilidad {nombre: 'Python'})
CREATE (u1)-[:TIENE_HABILIDAD]->(h2);

MATCH (u2:Usuario {nombre: ' Mónica'}), (h2:Habilidad {nombre: 'Python'})
CREATE (u2)-[:TIENE_HABILIDAD]->(h2);

MATCH (u2:Usuario {nombre: ' Mónica'}), (h3:Habilidad {nombre: 'My SQL'})
CREATE (u2)-[:TIENE_HABILIDAD]->(h3);

MATCH (u3:Usuario {nombre: 'Gustavo'}), (h1:Habilidad {nombre: 'MongodB'})
CREATE (u3)-[:TIENE_HABILIDAD]->(h1);

MATCH (u3:Usuario {nombre: 'Gustavo'}), (h4:Habilidad {nombre: 'Node.js'});
CREATE (u3)-[:TIENE_HABILIDAD]->(h4);

MATCH (u4:Usuario {nombre: 'Mariano'}), (h3:Habilidad {nombre: 'My SQL'})
CREATE (u4)-[:TIENE_HABILIDAD]->(h3);

MATCH (u4:Usuario {nombre: 'Mariano'}), (h4:Habilidad {nombre: 'Node.js'});
CREATE (u4)-[:TIENE_HABILIDAD]->(h4);

MATCH (u2:Usuario {nombre: ' Mónica'}), (h1:Habilidad {nombre: 'MongodB'})
CREATE (u2)-[:ENDOSA]->(h1);

MATCH (u3:Usuario {nombre: 'Gustavo'}), (h4:Habilidad {nombre: 'Node.js'});
CREATE (u3)-[:ENDOSA]->(h4);


MATCH (u:Usuario)-[:CONOCE]->(c:Usuario)
RETURN u.nombre AS Usuario, COUNT(c) AS Conexiones
ORDER BY Conexiones DESC;


MATCH (u:Usuario)-[:PUBLICA]->(p:Post)
RETURN u.nombre AS Usuario, COUNT(p) AS Publicaciones
ORDER BY Publicaciones DESC
LIMIT 2;

MATCH (u:Usuario)-[:ENDOSA]->(h:Habilidad)
RETURN h.nombre AS Habilidad, COUNT(u) AS Endosos
ORDER BY Endosos DESC;

MATCH (u:Usuario {nombre: 'Miguel'}), (h:Habilidad)
WHERE NOT (u)-[:ENDOSA]->(h)
RETURN h.nombre AS HabilidadNoEndosada;
