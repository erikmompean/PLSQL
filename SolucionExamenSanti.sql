CREATE OR REPLACE TYPE sdp_asignatura_type AS OBJECT(
	code CHAR(7),
	name VARCHAR2(50)
);

CREATE OR REPLACE TYPE sdp_address AS OBJECT(
	street VARCHAR2(50),
	postal_code CHAR(5),
	poblacion VARCHAR2(50),
	province VARCHAR2(50)
);

CREATE OR REPLACE TYPE sdp_phone_numbers AS VARRAY(2) OF CHAR(14);

CREATE OR REPLACE TYPE sdp_subjects AS TABLE OF sdp_asignatura_type;

CREATE OR REPLACE TYPE sdp_profesor_type AS OBJECT(
	id CHAR(9),
	name VARCHAR2(50),
	lastname_1 VARCHAR2(50),
	lastname_2 VARCHAR2(50),
	email VARCHAR2(21),
	address sdp_address,
	phones sdp_phone_numbers,
	subjects sdp_subjects,
	CONSTRUCTOR FUNCTION sdp_profesor_type(id CHAR, name VARCHAR2, lastname_1 VARCHAR2, lastname_2 VARCHAR2) RETURN SELF AS RESULT,
	FINAL MAP MEMBER FUNCTION getDni RETURN CHAR,
	MEMBER FUNCTION imprimir RETURN VARCHAR2
) NOT FINAL;

CREATE OR REPLACE TYPE BODY sdp_profesor_type AS
CONSTRUCTOR FUNCTION sdp_profesor_type(id CHAR, name VARCHAR2, lastname_1 VARCHAR2, lastname_2 VARCHAR2) RETURN SELF AS RESULT IS
	BEGIN
		SELF.id := id;
		SELF.name := name;
		SELF.lastname_1 := lastname_1;
		SELF.lastname_2 := lastname_2;
		SELF.email := id || '@lasalle.cat';
		RETURN;
	END;
FINAL MAP MEMBER FUNCTION getDni RETURN CHAR IS
	BEGIN
		RETURN id;
	END;
MEMBER FUNCTION imprimir RETURN VARCHAR2 IS
	BEGIN
		RETURN 'name: ' || name || ' ' || lastname_1 || ' ' || lastname_2 || ' dni: ' || id || ' email: ' || email;
	END;
END;


CREATE OR REPLACE TYPE sdp_tutor_type UNDER sdp_profesor_type(
	class VARCHAR2(50),
	CONSTRUCTOR FUNCTION sdp_tutor_type(id CHAR, name VARCHAR2, lastname_1 VARCHAR2, lastname_2 VARCHAR2, class VARCHAR2) RETURN SELF AS RESULT,
	OVERRIDING MEMBER FUNCTION imprimir RETURN VARCHAR2
);

CREATE OR REPLACE TYPE BODY sdp_tutor_type AS
CONSTRUCTOR FUNCTION sdp_tutor_type(id CHAR, name VARCHAR2, lastname_1 VARCHAR2, lastname_2 VARCHAR2, class VARCHAR2) RETURN SELF AS RESULT IS
	BEGIN
		SELF.id := id;
		SELF.name := name;
		SELF.lastname_1 := lastname_1;
		SELF.lastname_2 := lastname_2;
		SELF.class := class;
		SELF.email := id || '@lasalle.cat'
		RETURN;
	END;
OVERRIDING MEMBER FUNCTION imprimir RETURN VARCHAR2 IS
	BEGIN
		RETURN 'name: ' || name || ' ' || lastname_1 || ' ' || lastname_2 || ' dni: ' || id || ' email: ' || email || ' class: ' || class;
	END;
END;

CREATE TABLE sdp_profesores_table(
	profesor sdp_profesor_type,
	start_date DATE,
	CONSTRAINT pk_profesor PRIMARY KEY (profesor.id),
	CONSTRAINT nn_profesor_name CHECK (profesor.name IS NOT NULL),
	CONSTRAINT nn_profesor_lastname_1 CHECK (profesor.lastname_1 IS NOT NULL),
	CONSTRAINT nn_profesor_lastname_2 CHECK (profesor.lastname_2 IS NOT NULL)
)NESTED TABLE profesor.subjects STORE AS subjects_table;

INSERT INTO sdp_profesores_table (profesor) VALUES (sdp_tutor_type('22446688B', 'Profesor1', 'Perez', 'Sanchez', 'ICB1'));
INSERT INTO sdp_profesores_table (profesor) VALUES (sdp_tutor_type('22446688A', 'Profesor2', 'Vazquez', 'Jimenez', 'ICB2'));
INSERT INTO sdp_profesores_table (profesor) VALUES (sdp_profesor_type('22446688C', 'Profesor3', 'Terrasa', 'Gazquez'));

**
set serveroutput on
DECLARE
	profesor sdp_profesor_type;
	CURSOR profesor_cursor IS
		SELECT profesor FROM sdp_profesor_type p ORDER BY p.profesor;
BEGIN
	OPEN profesor_cursor;
	LOOP
		FETCH profesor_cursor INTO profesor;
		EXIT WHEN profesor_cursor%NOTFOUND;

		DBMS_OUTPUT.PUT_LINE(profesor.imprimir())
	END LOOP;
END;

UPDATE sdp_profesores_table p SET p.profesor.address = sdp_address('Calle 2nº2', '08032', 'Barcelona', 'Barcelona') WHERE p.profesor.id = '22446688B';
UPDATE sdp_profesores_table p SET p.profesor.phones = sdp_phone_numbers('999999999', '666666666') WHERE p.profesor.id = '22446688B';

UPDATE sdp_profesores_table p SET p.profesor.subjects = sdp_subjects(sdp_asignatura_type('ICB0001', 'Implantación de sistemas operativos'), 
	sdp_asignatura_type('ICB0002', 'Bases de datos'), sdp_asignatura_type('ICB0003', 'Programación básica')) WHERE p.profesor.id = '22446688B';
UPDATE sdp_profesores_table p SET p.profesor.subjects = sdp_subjects(sdp_asignatura_type('ICB0004', 'Lenguajes de marcas'), 
	sdp_asignatura_type('ICB0005', 'Entornos de desarollo'), sdp_asignatura_type('ICB0006', 'Acceso a bases de datos'), sdp_asignatura_type('ICB0007', 'Interfaces gráficas')) WHERE p.profesor.id = '22446688A';
UPDATE sdp_profesores_table p SET p.profesor.subjects = sdp_subjects(sdp_asignatura_type('ICB0008', 'Aplicaciones móviles'), 
	sdp_asignatura_type('ICB0009', 'Servicios y procesos'), sdp_asignatura_type('ICB0010', 'ERP')) WHERE p.profesor.id = '22446688C';

**
set serveroutput on
DECLARE
	profesor sdp_profesor_type;
	subjects sdp_subjects;
	CURSOR profesor_cursor IS
		SELECT profesor FROM sdp_profesor_type p ORDER BY p.profesor;
BEGIN
	OPEN profesor_cursor;
	LOOP
		FETCH profesor_cursor INTO profesor;
		EXIT WHEN profesor_cursor%NOTFOUND;

		DBMS_OUTPUT.PUT_LINE(profesor.imprimir());
		subjects := profesor.subjects;
		FOR l_row IN 1..subjects.COUNT
		LOOP
			DBMS_OUTPUT.PUT(subjects(l_row).name || '     ');
		END LOOP;
		DBMS_OUTPUT.NEW_LINE();
	END LOOP;
END;


INSERT INTO TABLE(SELECT p.profesor.subjects FROM sdp_profesores_table p WHERE p.profesor.id='22446688B') VALUES ('ICB0011', 'Formación y orientación laboral');
INSERT INTO TABLE(SELECT p.profesor.subjects FROM sdp_profesores_table p WHERE p.profesor.id='22446688B') VALUES ('ICB0012', 'Proyecto de síntesis'); 
SELECT s.* FROM sdp_profesores_table p, TABLE(p.profesor.subjects) s WHERE p.profesor.id='22446688B';


UPDATE TABLE (SELECT p.profesor.subjects FROM sdp_profesores_table p WHERE p.profesor.id='22446688C') s SET VALUE(s) = sdp_asignatura_type('ICB0010', 'Sistemas de gestión empresarial') WHERE s.code='ICB0010';
SELECT s.* FROM TABLE(SELECT p.profesor.subjects FROM sdp_profesores_table p WHERE p.profesor.id='22446688C') s WHERE s.code='ICB0010';
SELECT * FROM TABLE(SELECT p.profesor.subjects FROM sdp_profesores_table p WHERE p.profesor.id='22446688C') s WHERE s.code='ICB0010';


DELETE FROM TABLE(SELECT p.profesor.subjects FROM sdp_profesores_table p WHERE p.profesor.id='22446688C') s WHERE s.code='ICB0008';
SELECT COUNT(*) FROM TABLE(SELECT p.profesor.subjects FROM sdp_profesores_table p WHERE p.profesor.id='22446688C') s WHERE s.code='ICB0008';


INSERT INTO sdp_profesores_table (profesor) VALUES (sdp_profesor_type('22446688D', 'Profesor4', 'Gutierrez', 'Perez'));
UPDATE sdp_profesores_table p SET p.profesor.address = sdp_address('Calle 3nº3', '08032', 'Barcelona', 'Barcelona') WHERE p.profesor.id = '22446688D';
UPDATE sdp_profesores_table p SET p.profesor.phones = sdp_phone_numbers('666777888', '998887766') WHERE p.profesor.id = '22446688D';
UPDATE sdp_profesores_table p SET p.profesor.subjects = sdp_subjects(sdp_asignatura_type('ICB0013', 'Formación de centros de trabajo')) WHERE p.profesor.id = '22446688D';

SELECT p.profesor FROM sdp_profesores_table p WHERE p.profesor.id='22446688D';


UPDATE sdp_profesores_table p SET p.profesor.phones=sdp_phone_numbers('666777888', '933334456') WHERE p.profesor.id='22446688D';
SELECT p.profesor.phones FROM sdp_profesores_table p WHERE p.profesor.id='22446688D';