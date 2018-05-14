UPDATE TABLE (SELECT p.BLUEPRINTS
              FROM PROJECTS_TAB p
              WHERE p.PROJECT_NAME LIKE 'Proyecto Uno')
       e
SET e.engineers = ENGINEER_T('Ingeniero C')
WHERE e.blueprint_id = 2
