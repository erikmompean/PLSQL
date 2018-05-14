UPDATE TABLE (SELECT p.BLUEPRINTS
              FROM PROJECTS_TAB p
              WHERE p.PROJECT_NAME LIKE 'Proyecto Uno')
       e
SET e.title = 'SERVICIOS AFECTADOS EN RED DE TELEFONIA'
WHERE e.blueprint_id = 2
