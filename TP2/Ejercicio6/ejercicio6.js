db = db.getSiblingDB("empresa") 

db.createCollection("clientes");
db.clientes.insertMany([
  { apellido: "Matarazzo", nombre: "Gimena", edad: 35 },
  { apellido: "Luchetti", nombre: "Juan Pablo", edad: 45 },
  { apellido: "Baez", nombre: "Juliana", edad: 28 }
])

db.clientes.createIndex({ apellido: 1, nombre: 1 })
