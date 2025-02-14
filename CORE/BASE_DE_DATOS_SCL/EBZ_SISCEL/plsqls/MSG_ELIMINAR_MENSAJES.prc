CREATE OR REPLACE PROCEDURE            MSG_ELIMINAR_MENSAJES (
pr_NUM_IDENT_O   in WGED_MENSAJERIA.NUM_IDENT_O%TYPE,
pr_FECHA         varchar2
)
as
BEGIN
delete WGED_MENSAJERIA
where NUM_IDENT_O = pr_NUM_IDENT_O
and fecha = to_date(pr_FECHA, 'dd-mm-yyyy hh24:mi:ss');
END;
/
SHOW ERRORS
