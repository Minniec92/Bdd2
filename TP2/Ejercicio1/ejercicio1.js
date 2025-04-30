db = db.getSiblingDB("empresa"); 

db.empleados.insertMany([
{ nombre: "Martin Gimenez", edad: 30, puesto: "desarrollador" },
{ nombre: "Juana Lopez", edad: 22, puesto: "pasante" },
{ nombre: "Luis Rodríguez", edad: 40, puesto: "gerente" },
{ nombre: "Juan Pérez", edad: 28, puesto: "analista" },
{ nombre: "Ana Torres", edad: 35, puesto: "diseñadora" },
{ nombre: "Pedro González", edad: 45, puesto: "director" },
{ nombre: "María Fernández", edad: 29, puesto: "administrativa" },
{ nombre: "Carlos Sánchez", edad: 50, puesto: "consultor" },
{ nombre: "Laura Martínez", edad: 32, puesto: "recursos humanos" },
{ nombre: "Javier Díaz", edad: 38, puesto: "ingeniero" }
]);

db.empleados.updateOne(
{ nombre: "Juan Pérez" },
{ $set: { edad: 35 } }
);

db.empleados.deleteOne(
{ puesto: "pasante" }
);

print("Empleados restantes:");
printjson(db.empleados.find().toArray());
