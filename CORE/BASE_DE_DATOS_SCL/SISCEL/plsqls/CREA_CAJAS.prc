CREATE OR REPLACE PROCEDURE crea_cajas IS
   v_des_caja co_cajas.des_caja%TYPE;
   v_cod_caja number;
Begin  
 v_cod_caja := 52;                                                                 
 For I In 2..277 Loop
  v_des_caja := 'CAJA-TRAIN-TMM'||to_char(v_cod_caja);   
  insert into CO_CAJAS (COD_OFICINA,COD_CAJA,DES_CAJA,FEC_ALTA,NOM_USUALTA,NUM_SECUMOV,IND_ABIERTA,
                                   FEC_EFECTIVIDAD,NOM_USUARORA,MAX_REINTEGRO,DIR_IP,IND_PASSWORD, COD_OPERADORA_SCL, COD_PLAZA)
  values ('01',v_cod_caja,v_des_caja,sysdate,'ONOVOA',1,0,
             sysdate,'ONOVOA',100000,'172.28.9.190',0,'TMM','1');
  v_cod_caja := v_cod_caja + 1;
  commit;
 End Loop;
End ;
/
SHOW ERRORS
