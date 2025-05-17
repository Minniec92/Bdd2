db = db.getSiblingDB("empresa");

const empleadosEncontrados = db.empleados.find({
edad: { $gte: 25, $lte: 40 }
});

print("Empleados entre 25 y 40 años:");
empleadosEncontrados.forEach(printjson);
