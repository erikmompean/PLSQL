-- Crea un subtipo de student_t denominado student_parcial_t que pueda almacenar:
-- • numHours: integer
-- Debe sobre-escribir el método get_datos mostrando name, surname, phone, college y
-- averageScore y numHours


CREATE OR REPLACE TYPE student_parcial_t UNDER student_typ (
  numHours INTEGER,
  OVERRIDING MEMBER FUNCTION get_datos RETURN VARCHAR2
);

CREATE OR REPLACE TYPE BODY student_parcial_t AS
  OVERRIDING MEMBER FUNCTION get_datos RETURN VARCHAR2 IS
    BEGIN
      RETURN SELF.name || ' ' || SELF.surname || ' ' || SELF.phone || ' '
      || TO_CHAR(SELF.averageScore) || ' '  || SELF.college || ' ' || TO_CHAR(SELF.numHours);
    END;
END;

set serveroutput on;
DECLARE
  student student_parcial_t;
BEGIN
  student:= NEW student_parcial_t(1, 'toni', 'Albarez', SYSDATE, '673261300', 'lasalle', 6, 7);
  dbms_output.put_line('Person data: '|| student.get_datos());
END;
