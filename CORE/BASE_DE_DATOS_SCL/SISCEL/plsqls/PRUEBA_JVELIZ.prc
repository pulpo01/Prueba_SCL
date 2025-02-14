CREATE OR REPLACE PROCEDURE        Prueba_JVELIZ( nom varchar2) IS
texto varchar2(40):= nom;
begin

 dbms_output.put_line('Hola : '||texto);

END Prueba_JVELIZ;
/
SHOW ERRORS
