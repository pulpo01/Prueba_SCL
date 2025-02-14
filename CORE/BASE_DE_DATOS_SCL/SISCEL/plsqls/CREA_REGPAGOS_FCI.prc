CREATE OR REPLACE PROCEDURE crea_regpagos_fci IS
   v_cajeros  varchar2(30);
   v_cod_cliente ga_abocel.cod_cliente%TYPE;
   v_num_venta_fci number;
   v_num_folio co_cartera.num_folio%TYPE;
   v_debe_importe co_cartera.importe_debe%TYPE;
   v_imp_venta ga_ventas.imp_venta%TYPE;
   v_num_abonado co_cartera.num_abonado%TYPE;
   CURSOR cajeros is
         select username from all_users where username like 'TRAIN%' ;
    CURSOR clientes is
         select distinct(cod_cliente),num_abonado from ga_abocel where cod_situacion='AAA' ;
Begin
 v_num_venta_fci := 30000000;
 v_num_folio := 30000000;
 Open cajeros;
 Open clientes;
 Loop
          v_debe_importe := 1000;
          Fetch cajeros INTO v_cajeros;
          EXIT WHEN cajeros%NOTFOUND;
                 Fetch clientes INTO v_cod_cliente,v_num_abonado;
                 For I In 1..5 Loop
                 insert into CO_SECARTERA (COD_TIPDOCUM,COD_VENDEDOR_AGENTE,LETRA,COD_CENTREMI,NUM_SECUENCI,COD_CONCEPTO,COLUMNA)
                  Values(2,107500,'X',1,v_num_venta_fci,3,1);
                 insert into co_cartera(COD_CLIENTE,NUM_SECUENCI,COD_TIPDOCUM,COD_VENDEDOR_AGENTE,LETRA,COD_CENTREMI,
                 COD_CONCEPTO,COLUMNA,COD_PRODUCTO,IMPORTE_DEBE,IMPORTE_HABER,IND_CONTADO,IND_FACTURADO,FEC_EFECTIVIDAD,
                 FEC_VENCIMIE,FEC_CADUCIDA,FEC_ANTIGUEDAD,NUM_ABONADO,NUM_FOLIO,FEC_PAGO,NUM_CUOTA,SEC_CUOTA,NUM_TRANSACCION,
                 NUM_VENTA,NUM_FOLIOCTC,  COD_OPERADORA_SCL,COD_PLAZA,PREF_PLAZA)
                 Values(v_cod_cliente,v_num_venta_fci,2,107500,'X',1,3,1,1,v_debe_importe + I,0,1,1,sysdate-7,
sysdate-7,sysdate-7,sysdate-120,v_num_abonado,v_num_folio + I,sysdate+5,0,0,0,0,0,'TMM','00001','TMM');
                 v_num_venta_fci := v_num_venta_fci + 1;
                End Loop;
                commit;
  End Loop;
End ;
/
SHOW ERRORS
