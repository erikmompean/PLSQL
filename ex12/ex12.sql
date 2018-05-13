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
