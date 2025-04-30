db.alumnos.aggregate([
  {
    $lookup: {
      from: "cursos",
      localField: "id_curso",
      foreignField: "_id",
      as: "Alumnos_Cursos"
    }
  }
])
.forEach(printjson);