-- a. Crea un objeto tipo student_t y otro student_parcial_t. Usa el método
-- get_datos para mostrar en pantalla los datos de cada uno de ellos. Muestra
-- por pantalla también cual de ellos es más joven.

set serveroutput on;
DECLARE
  student student_parcial_t;
  student_n student_typ;
BEGIN
  student_n:= NEW student_typ(1, 'Erik', 'Mompeans', TO_DATE('10-05-2018', 'dd-MM-yyyy'), '673261200', 'lasalle', 6);
  student:= NEW student_parcial_t(1, 'toni', 'Albarez',  SYSDATE, '673261300', 'lasalle', 6, 7);

  dbms_output.put_line('Person data: '|| student.get_datos());
  dbms_output.put_line('Person data: '|| student_n.get_datos());

  IF student_n.get_fecha() > student.get_fecha() THEN
    dbms_output.put_line(student_n.name || ' es mas joven');
    ELSE
    dbms_output.put_line(student.name || ' es mas joven');
    END IF;
END;

-- b. Crea una tabla de objetos del tipo person_t (PK idno) con los siguientes
-- registros

CREATE TABLE person_table(
	person person_typ,
	CONSTRAINT pk_student PRIMARY KEY (person.idno)
);

INSERT INTO person_table (person) VALUES (PERSON_TYP(12, 'ISMAEL', 'BELTRAN', TO_DATE('15/02/1995', 'dd/MM/yyyy'), '22446688'));
INSERT INTO person_table (person) VALUES (PERSON_TYP(27, 'BERTA', 'MATEO', TO_DATE('23/09/1991', 'dd/MM/yyyy'), '22446688'));
INSERT INTO person_table (person) VALUES (PERSON_TYP(29, 'GONZALO', 'CASANOVA', TO_DATE('06/05/1993', 'dd/MM/yyyy'), '22446688'));

INSERT INTO person_table (person) VALUES (student_typ(15, 'FRANCISCO', 'SUAREZ', TO_DATE('15/02/1990', 'dd/MM/yyyy'), '22446688', 'LA SALLE GRACIA', 9.0));
INSERT INTO person_table (person) VALUES (student_typ(20, 'JOSE', 'PEREZ', TO_DATE('23/09/1992', 'dd/MM/yyyy'), '22446688', 'LA SALLE GRACIA', 7.5));

INSERT INTO person_table (person) VALUES (student_parcial_t(24, 'JAVIER', 'GARCIA', TO_DATE('20/05/1990', 'dd/MM/yyyy'), '22446688', 'LA SALLE GRACIA', 9.0, 317));
INSERT INTO person_table (person) VALUES (student_parcial_t(25, 'ELENA', 'CASTELLANOS', TO_DATE('23/10/1990', 'dd/MM/yyyy'), '22446688', 'LA SALLE GRACIA', 7.5, 317));

-- c. Muestra por pantalla los datos (get_datos) de los estudiantes (sólo
-- estudiantes) ordenados por fecha de nacimiento (birth)

set serveroutput on;
DECLARE
	person person_typ;
	CURSOR person_cursor IS
		SELECT person FROM person_table where person is of (student_typ) ORDER BY person.birth;
BEGIN
	OPEN person_cursor;
	LOOP
		FETCH person_cursor INTO person;
		EXIT WHEN person_cursor%NOTFOUND;

		DBMS_OUTPUT.PUT_LINE(person.get_datos());
	END LOOP;
END;

-- Muestra por pantalla los datos (get_datos) de los estudiantes a tiempo parcial
-- ordenados por fecha de nacimiento (birth)

set serveroutput on;
DECLARE
	person person_typ;
	CURSOR person_cursor IS
		SELECT person FROM person_table where person is of (student_parcial_t) ORDER BY person.birth;
BEGIN
	OPEN person_cursor;
	LOOP
		FETCH person_cursor INTO person;
		EXIT WHEN person_cursor%NOTFOUND;

		DBMS_OUTPUT.PUT_LINE(person.get_datos());
	END LOOP;
END;
