
En una clínica veterinaria, se desea disponer de los datos asociados a las mascotas que son
atendidas, así como de los veterinarios que las atienden.
Cada mascota tiene un veterinario asignado.
Un veterinario se identifica de forma única por su número de colegiado, almacenándose
además su nombre y dirección. De cada mascota se quiere almacenar su identificador (único),
fecha de nacimiento, raza y el veterinario asignado.
Se desea disponer de 2 tablas en la base de datos para las mascotas y para los veterinarios.

CREATE OR REPLACE TYPE veterinario_typ AS OBJECT (
  num_colegiado INTEGER,
  nombre VARCHAR2(30),
  direccion VARCHAR2(80)
);

CREATE TABLE veterinario_table(
	veterinario veterinario_typ,
	CONSTRAINT pk_veterinario PRIMARY KEY (veterinario.num_colegiado)
);

INSERT INTO veterinario_table VALUES (veterinario_typ(1, 'Erik', 'Av pla del vent'));

INSERT INTO mascota_table VALUES (1, TO_DATE('10/12/1996', 'dd/MM/yyyy'), 'casterly', (SELECT REF(v) from veterinario_table v where v.num_colegiado = 1));

-- SELECT person FROM person_table where person is of (student_parcial_t) ORDER BY person.birth;
