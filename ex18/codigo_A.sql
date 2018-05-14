INSERT INTO PROJECTS_TAB VALUES ('Proyecto Uno', TO_DATE('13-SEP-2020'), BOSS_T(1, 'Erik', '669669669'),
                                 BLUEPRINTS_NT(BLUEPRINT_T(1, 'SITUACION Y EMPLAZAMIENTO',
                                                           ENGINEER_T('Ingeniero A', 'Ingeniero B'))));

INSERT INTO TABLE (SELECT P.BLUEPRINTS
                   FROM PROJECTS_TAB P
                   WHERE P.PROJECT_NAME LIKE 'Proyecto Uno')
VALUES (BLUEPRINT_T(2, 'SERVICIOS Y AFECTADOS', ENGINEER_T('Ingeniero C', 'Ingeniero D')));

INSERT INTO TABLE (SELECT P.BLUEPRINTS
                   FROM PROJECTS_TAB P
                   WHERE P.PROJECT_NAME LIKE 'Proyecto Uno')
VALUES (BLUEPRINT_T(3, 'SEGURIDAD Y SALUD', ENGINEER_T('Ingeniero E', 'Ingeniero F')));
