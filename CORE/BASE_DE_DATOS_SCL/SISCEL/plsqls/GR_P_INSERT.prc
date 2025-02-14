CREATE OR REPLACE PROCEDURE        GR_P_INSERT
(num in number, V_TRANSACCION in varchar2, codigo_reporte in varchar2, nombre_usuario in VARCHAR2, tipo_ejecucion in char, codigo_estado in char) IS
codigo    gr_auditoria.cod_reporte%type;
usuario   gr_auditoria.nom_usuario%type;
tipo      gr_auditoria.ind_modo%type;
estado    gr_auditoria.cod_estado%type;
numero    gr_auditoria.num_ejecucion%type;
VP_TRANSACCION GA_TRANSACABO.NUM_TRANSACCION%TYPE;
v_estado ga_transacabo.cod_retorno%type;
des_cadena ga_transacabo.des_cadena%type;
BEGIN
codigo:=codigo_reporte;
usuario:=nombre_usuario;
VP_TRANSACCION:=V_TRANSACCION;
numero:=num;
estado:=codigo_estado;
tipo:=tipo_ejecucion;
Insert into Gr_auditoria (num_ejecucion, cod_reporte, nom_usuario, ind_modo, cod_estado) values (numero ,codigo, usuario , tipo, estado);
v_estado:=0;
des_cadena:='SIN PROBLEMA';
INSERT INTO GA_TRANSACABO
VALUES (VP_TRANSACCION,V_ESTADO,DES_CADENA);
COMMIT;
EXCEPTION
when no_data_found then
ROLLBACK;
v_estado:=4;
des_cadena:='CON PROBLEMAS';
INSERT INTO GA_TRANSACABO
VALUES (VP_TRANSACCION,V_ESTADO,DES_CADENA);
COMMIT;
null;
END;
/
SHOW ERRORS
