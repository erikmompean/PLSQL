// SE USAN NUMBERS?

CREATE OR REPLACE TYPE alumno_t AS OBJECT(
DNI VARCHAR2(9),
nota_ev_1 NUMBER,
nota_ev_2 NUMBER,
nota_ev_3 NUMBER,
MEMBER FUNCTION calcMedia RETURN NUMBER,
MEMBER FUNCTION calcMediaPond(porcentaje1 NUMBER, porcentaje2 NUMBER, porcentaje3 NUMBER)
);

CREATE OR REPLACE TYPE BODY alumno_t AS
MEMBER FUNCTION calcMedia RETURN NUMBER IS
	media NUMBER;
	BEGIN
		media:=(nota_ev_3 + nota_ev_2 + nota_ev_1)/3;
		return TRUNC(media);
	END;
MEMBER FUNCTION calcMediaPond(porcentaje1 NUMBER, porcentaje2 NUMBER, porcentaje3 NUMBER) RETURN NUMBER IS
	media NUMBER;
	porcentajeDecimal1 NUMBER;
	porcentajeDecimal2 NUMBER;
	porcentajeDecimal3 NUMBER;
	BEGIN
		porcentajeDecimal1:= porcentaje1/100;
		porcentajeDecimal2:= porcentaje2/100;
		porcentajeDecimal3:= porcentaje3/100;
		return ((nota_ev_1 * porcentajeDecimal1) + (nota_ev_2 * porcentajeDecimal2) + (nota_ev_2 * porcentajeDecimal2));

	END;
END;
