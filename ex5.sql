CREATE TYPE NOTICIA_T AS OBJECT (
    codigo_noticia NUMBER,
    fecha_publicacion DATE,
    numero_dias NUMBER,
    texto VARCHAR2(3000),
    MEMBER FUNCTION publicada RETURN BOOLEAN
);

CREATE OR REPLACE TYPE BODY NOTICIA_T AS
  MEMBER FUNCTION publicada RETURN BOOLEAN IS
  is_publicada BOOLEAN;
  fecha_actual DATE;
  BEGIN
    fecha_actual:=SYSDATE;
    is_publicada:=FALSE;
    IF (fecha_publicacion>fecha_actual)
    THEN RETURN TRUE;
    END IF;
    RETURN FALSE;
  END;
END;
