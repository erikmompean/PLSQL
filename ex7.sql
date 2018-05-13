CREATE OR REPLACE TYPE rectangle_t AS OBJECT (
  longitud NUMBER,
  anchura NUMBER,
  area NUMBER,
  CONSTRUCTOR FUNCTION rectangle_t(longitud NUMBER, anchura NUMBER) RETURN SELF AS RESULT
);

CREATE OR REPLACE TYPE BODY rectangle_t AS
  CONSTRUCTOR FUNCTION rectangle_t(longitud NUMBER, anchura NUMBER) RETURN SELF AS RESULT IS
  BEGIN
    SELF.longitud:=longitud;
    SELF.anchura:=anchura;
    SELF.area:=longitud*anchura;
    END;
END;

set serveroutput on;
DECLARE
  r1 rectangle_t;
  r2 rectangle_t;
BEGIN
  r1:= NEW rectangle_t(20, 30);
  r2:= NEW rectangle_t(10, 20);
  dbms_output.put_line('Area 1: '|| r1.area);
  dbms_output.put_line('Area 2: '|| r2.area);
END;
