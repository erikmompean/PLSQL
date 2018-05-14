DELETE FROM TABLE (SELECT p.BLUEPRINTS
                   FROM PROJECTS_TAB p
                   WHERE p.PROJECT_NAME LIKE 'Proyecto Uno')
            e
WHERE e.title = 'SEGURIDAD Y SALUD'
