
-- SELECT con cursor
set serveroutput on
DECLARE
	person person_typ;
	CURSOR person_cursor IS
		SELECT person FROM person_table;
BEGIN
	OPEN person_cursor;
	LOOP
		FETCH person_cursor INTO person;
		EXIT WHEN person_cursor%NOTFOUND;

		DBMS_OUTPUT.PUT_LINE(person.get_datos());
	END LOOP;
END;
