CREATE OR REPLACE PROCEDURE        fa_proc_concepto
IS
  vconcepto  Fa_NoACtivo.Cod_Concepto%TYPE;
  vcontador number:=0;
  Cursor Cur_NoActivo is
         Select cod_concepto,des_concepto,cod_producto,cod_tipconce
         From Fa_Conceptos
         Where ind_activo = 0;
  vreg_noactivo  Fa_NoActivo%ROWTYPE;
  Begin
    Open Cur_NoActivo;
    Loop
      Fetch Cur_NoActivo Into vreg_noactivo;
      Exit when Cur_NoActivo%NOTFOUND;
      Begin
        Select cod_concepto into vconcepto
        From Fa_NoActivo
        Where cod_concepto = vreg_noactivo.cod_concepto;
      exception
        when no_data_found then
             vcontador := vcontador +1;
             Insert into Fa_NoActivo
                   (cod_concepto,des_concepto,cod_producto,cod_tipconce)
             Values (vreg_noactivo.cod_concepto,vreg_noactivo.des_concepto,
                     vreg_noactivo.cod_producto,vreg_noactivo.cod_tipconce);
      End;
    End Loop;
    dbms_output.put_line('SQLCODE ='||to_char(sqlcode));
    Commit;
    Close Cur_NoActivo;
    dbms_output.put_line('Contador ='||to_char(vcontador));
  End fa_proc_concepto;
/
SHOW ERRORS
