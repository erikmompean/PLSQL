CREATE TYPE mascota_typ AS OBJECT(
  id INTEGER,
  fecha_nacimiento DATE,
  raza VARCHAR2(30),
  veterinario REF veterinario_typ
);

CREATE TABLE mascota_table OF mascota_typ;
