-- a. Crea una tabla de objetos noticia_t que se llame noticias_obj. La clave primaria debe
-- ser el código. Inserta 3 valores y comprueba que los valores se han insertado
-- correctamente. Realiza un SELECT de la tabla noticias_obj para verificar que las
-- noticias se han insertado correctamente.
-- b. Crea una tabla que contenga un objeto noticia_t y un varchar2 que se llame sección. La
-- clave primaria de la tabla debe ser el atributo código del objeto noticia. Inserta 3
-- valores y comprueba que se han insertado correctamente.

CREATE TYPE noticia_t AS OBJECT (
    codigo_noticia NUMBER,
    fecha_publicacion DATE,
    numero_dias NUMBER,
    texto VARCHAR2(3000)
);

CREATE TABLE noticias_obj(
	noticia noticia_t,
	CONSTRAINT pk_noticia PRIMARY KEY (noticia.codigo_noticia)
);

INSERT INTO noticias_obj (noticia) VALUES (noticia_t(1, SYSDATE, 2, 'pene flacido'));
