db = db.getSiblingDB("empresa");

db.empleados.updateMany(
  {},
  {
    $set: {
      direccion: {
        calle: "",
        ciudad: "",
        codigo_postal: ""
      }
    }
  }
);

print("Empleados con campo direccion agregado (vacío):");
printjson(db.empleados.find().toArray());