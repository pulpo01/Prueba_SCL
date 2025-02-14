CREATE OR REPLACE PROCEDURE crea_cajeros IS
  v_cajeros varchar2(30);
   v_cod_caja number;
  CURSOR cajeros is
         select username from all_users where username like 'TRAIN%' and username <> 'TRAIN01';
Begin
 Open cajeros;                                                                      
 v_cod_caja := 52;
 Loop 
          Fetch cajeros INTO v_cajeros;
          EXIT WHEN cajeros%NOTFOUND;
         insert into CO_CAJEROS(COD_OFICINA,COD_CAJA,NOM_USUARORA,FEC_ALTA,NOM_USUALTA)
         values('01',v_cod_caja,v_cajeros,sysdate,v_cajeros);
          v_cod_caja := v_cod_caja + 1;
 End Loop;
   Close cajeros;
   commit;
 End ;
/
SHOW ERRORS
