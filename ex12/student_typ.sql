Crea un subtipo de person_t denominado student_t que permita la definición de subtipos y
pueda almacenar:
• college: carácter(30)
• averageScore: integer
Debe sobre-escribir el método get_datos mostrando name, surname, phone, college y
averageScore

CREATE OR REPLACE TYPE student_typ UNDER person_typ (
  college VARCHAR2(30),
  averageScore NUMBER,
  OVERRIDING MEMBER FUNCTION get_datos RETURN VARCHAR2
)NOT FINAL;

CREATE OR REPLACE TYPE BODY student_typ AS
  OVERRIDING MEMBER FUNCTION get_datos RETURN VARCHAR2 IS
    BEGIN
      RETURN SELF.name || ' ' || SELF.surname || ' ' || SELF.phone || ' ' || TO_CHAR(SELF.averageScore) || ' '  || SELF.college;
    END;
END;

set serveroutput on;
DECLARE
    student student_typ;
BEGIN
    student:= NEW student_typ(1, 'toni', 'Albarez', SYSDATE, '673261200', 'lasalle', 6);
    dbms_output.put_line('Person data: '|| student.get_datos());
END;
