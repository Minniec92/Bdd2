db.createCollection("cursos")
db.createCollection("alumnos")

db.cursos.insertMany([
  { _id: 1, nombre: "Base de datos" },
  { _id: 2, nombre: "Programación" },
  { _id: 3, nombre: "Metodología de sistemas" },
  { _id: 4, nombre: "Redes" },
  { _id: 5, nombre: "Seguridad informática" },
  { _id: 6, nombre: "Desarrollo web" },
  { _id: 7, nombre: "Inteligencia artificial" },
  { _id: 8, nombre: "Ciberseguridad" },
  { _id: 9, nombre: "Análisis de datos" },
  { _id: 10, nombre: "Machine Learning" },
])

db.alumnos.insertMany([
  { nombre: "Sergio", id_curso: [1, 2] },
  { nombre: "Mariano", id_curso: [2, 3] },
  { nombre: "Gian Franco", id_curso: [1] },
  { nombre: "Joaquín", id_curso: [2, 3] },
  { nombre: "Belén", id_curso: [1, 2, 9] },
  { nombre: "Franco", id_curso: [10, 7, 5] },
])
