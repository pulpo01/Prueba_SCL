CREATE OR REPLACE PROCEDURE        GR_P_UPDATE
(num in number, V_TRANSACCION in varchar2) IS
numero     gr_auditoria.num_ejecucion%type;
VP_TRANSACCION GA_TRANSACABO.NUM_TRANSACCION%TYPE;
v_estado ga_transacabo.cod_retorno%type;
des_cadena ga_transacabo.des_cadena%type;
BEGIN
VP_TRANSACCION:=V_TRANSACCION;
numero:=num;
update Gr_auditoria set cod_estado='F' where num_ejecucion=numero;
v_estado:=0;
des_cadena:='SIN PROBLEMA AL MODIFICAR';
INSERT INTO GA_TRANSACABO
VALUES (VP_TRANSACCION,V_ESTADO,DES_CADENA);
COMMIT;
EXCEPTION
when no_data_found then
ROLLBACK;
v_estado:=4;
des_cadena:='CON PROBLEMAS AL MODIFICAR';
INSERT INTO GA_TRANSACABO
VALUES (VP_TRANSACCION,V_ESTADO,DES_CADENA);
COMMIT;
null;
END;
/
SHOW ERRORS
