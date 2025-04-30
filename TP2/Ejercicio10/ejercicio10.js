/*
Para crear un usuario con permisos de lectura y escritura usariamos el sig comando:

db.createUser({
user: "NuevoUser",
pwd: "123456",
roles: [{ role: "readWrite", db: "nombreDeLaBasedeDatosquevaAUsar" }]
})

- "NuevoUser" es el nombre que le estamos dando al usuario.
- "123456" es la contraseña que va a usar.
- "readWrite" le da permiso para leer y escribir.
- "nombreDeLaBasedeDatosquevaAUsar" es la base de datos a la cuál tendrá permisos de lectura y escritura.

Para hacer el backup usamos:
mongodump --db nombreDeLaBase

Para restaurarla:
mongorestore --db nombreDeLaBase carpetaDelBackup
Esto recupera la base desde la copia guardada.

En resumen:
Para crear el usuario usamos "(db.createUser())"".
Para hacer el backup "(mongodump)".
Para restaurarlo "(mongorestore)".


*/
