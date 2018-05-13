Crea un tipo de objeto person_t que permita la definición de subtipos y pueda almacenar:
• Idno: entero
• name caracter(30)
• surname caracter(30)
• Birth: fecha
• phone caracter
Y los siguientes métodos.
• get_datos: método que devuelve una string con el name, surname y phone
• get_fecha: método que permita la ordenación de personas por su birth (MAP).


CREATE OR REPLACE TYPE person_typ AS OBJECT (
    idno NUMBER,
    name VARCHAR2(50),
    surname VARCHAR2(50),
    birth DATE,
    phone VARCHAR2(10),
    MEMBER FUNCTION get_datos RETURN VARCHAR2,
    MAP MEMBER FUNCTION get_fecha RETURN DATE
) NOT FINAL;

CREATE OR REPLACE TYPE BODY person_typ AS
  MEMBER FUNCTION get_datos RETURN VARCHAR2 IS
    BEGIN
      RETURN SELF.name || ' ' || SELF.surname || ' ' || SELF.phone;
    END;
  MAP MEMBER FUNCTION get_fecha RETURN DATE IS
    BEGIN
      return SELF.birth;
    END;
END;

set serveroutput on;
DECLARE
    persona person_typ;
BEGIN
    persona:= NEW PERSON_TYP(1, 'toni', 'Albarez', SYSDATE, '673261200');
    dbms_output.put_line('Person data: '|| persona.get_datos());
END;
