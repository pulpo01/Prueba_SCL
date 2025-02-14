CREATE OR REPLACE PACKAGE PR_MONTO_ESCRITO IS
function mto_escrito (x number,y number) return varchar2;
function arreglo(a number, b number) return varchar2;
END;
/
SHOW ERRORS
