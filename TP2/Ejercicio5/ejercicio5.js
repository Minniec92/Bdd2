db = db.getSiblingDB("empresa");

db.ventas.insertMany([
  { producto: "Espejo", cantidad: 2, precio_unitario: 7550 },
  { producto: "Escritorio", cantidad: 10, precio_unitario: 25800 },
  { producto: "Notebook", cantidad: 1, precio_unitario: 10000 },
  { producto: "Teclado", cantidad: 5, precio_unitario: 50500 },
  { producto: "Camara web", cantidad: 2, precio_unitario: 20000 }
]);

const totalVentas = db.ventas.aggregate([
  {
    $group: {
      _id: "$producto",
      total_ventas: { 
        $sum: { $multiply: ["$cantidad", "$precio_unitario"] } 
      }
    }
  }
]);

print("Total de ventas por producto:");
totalVentas.forEach(printjson);