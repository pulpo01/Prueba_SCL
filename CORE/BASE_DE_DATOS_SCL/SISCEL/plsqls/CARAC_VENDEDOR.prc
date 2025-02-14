CREATE OR REPLACE PROCEDURE carac_vendedor IS
  v_cod_vendedor  ve_vendedores.cod_vendedor%TYPE;
  v_num_vendedor1 ve_vendedores.cod_vendedor%TYPE;
  v_num_vendedor2 ve_vendedores.cod_vendedor%TYPE;
   CURSOR vendedores is
          select cod_vendedor from ve_vendedores where cod_vendedor >= v_num_vendedor1 and cod_vendedor <= v_num_vendedor2;
Begin
    v_num_vendedor1 := 107500;
    v_num_vendedor2 := 107758;
    Open vendedores;
    Loop
          Fetch vendedores INTO v_cod_vendedor;
          EXIT WHEN vendedores%NOTFOUND;
         INSERT INTO VE_VENDPROD(cod_vendedor,cod_producto,FEC_ASIGNACION, NOM_USUARIO, FEC_DESASIGNAC)
         VALUES(v_cod_vendedor,1,SYSDATE, 'ONOVOA', NULL);
         INSERT INTO VE_VENDPERFIL (COD_VENDEDOR, COD_PERFIL,  FEC_ASIGNACION, NOM_USUARIO)
         VALUES  (v_cod_vendedor,'1' , SYSDATE,'ONOVOA');
         INSERT INTO VE_VENDALMAC(COD_BODEGA, COD_VENDEDOR, FEC_ASIGNACION, NOM_USUARIO, FEC_DESASIGNAC)
         VALUES(1,v_cod_vendedor, SYSDATE,'ONOVOA', NULL);
         INSERT INTO VE_VENDALMAC(COD_BODEGA, COD_VENDEDOR, FEC_ASIGNACION, NOM_USUARIO, FEC_DESASIGNAC)
         VALUES(9999,v_cod_vendedor, SYSDATE,'ONOVOA', NULL);
         INSERT INTO VE_VENDALMAC(COD_BODEGA, COD_VENDEDOR, FEC_ASIGNACION, NOM_USUARIO, FEC_DESASIGNAC)
         VALUES(164,v_cod_vendedor, SYSDATE,'ONOVOA', NULL);
         commit;
    End Loop;
   Close vendedores;
End ;
/
SHOW ERRORS
