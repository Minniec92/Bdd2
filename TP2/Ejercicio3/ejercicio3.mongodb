db = db.getSiblingDB("empresa");

const empleadosProyectados = db.empleados.find(
{}, 
{ _id: 0, nombre: 1, puesto: 1 } 
);

print("Nombres y puestos de empleados:");
empleadosProyectados.forEach(printjson);
