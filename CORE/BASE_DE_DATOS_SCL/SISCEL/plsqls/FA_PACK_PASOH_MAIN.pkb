CREATE OR REPLACE PACKAGE BODY        fa_pack_pasoh_main IS
  --
  -- Retrofitted
  PROCEDURE p_main(
  v_proceso IN Fa_HistDocu.Num_Proceso%TYPE ,
  v_tipdocum IN Ge_TipDocumen.Cod_Tipdocum%TYPE )
  IS
    rec_fa_datosgener Fa_DatosGener%ROWTYPE;
    vsqlcode          number := 0;
    vsqlerrm          varchar2(100) := null;
    Begin
      fa_pack_pasoh_get.p_getfadatosgener(rec_fa_datosgener);
      if v_tipdocum = rec_fa_datosgener.cod_ciclo then
         dbms_output.put_line('De ciclo');
         dbms_output.put_line('Proceso ='||to_char(v_proceso));
         fa_pack_pasoh_main.p_pasohist_ciclo(v_proceso);
         Delete /*+ index (FA_FACTDOCU NUK_FA_FACTDOCU_PROCESO) */
                Fa_FactDocu
         Where num_proceso = v_proceso;
      end if;
      Commit;
    exception
      when others then
           raise_application_error(-20558,sqlerrm);
           rollback;
    End p_main;
  --
  -- Retrofitted
  PROCEDURE p_pasohist_ciclo(
  v_proceso IN Fa_HistDocu.Num_Proceso%TYPE )
  IS
    Cursor Cur_OrdenCiclo is
           Select /*+ index (FA_FACTDOCU NUK_FA_FACTDOCU_PROCESO) */
  ind_ordentotal
           From Fa_FactDocu
           Where num_proceso = v_proceso;
    vordentotal Fa_HistDocu.Ind_OrdenTotal%TYPE;
    Begin
      dbms_output.put_line('PasoHist_Ciclo');
      dbms_output.put_line('N.Proceso ='||to_char(v_proceso));
      fa_pack_pasoh_get.p_insdociclo(v_proceso);
      Open Cur_OrdenCiclo;
      Loop
        Fetch Cur_OrdenCiclo into vordentotal;
        Exit when Cur_OrdenCiclo%NOTFOUND;
        fa_pack_pasoh_get.p_inscliciclo(vordentotal);
        fa_pack_pasoh_get.p_insabociclo(vordentotal);
      End Loop;
      Close Cur_OrdenCiclo;
    End p_pasohist_ciclo;
END fa_pack_pasoh_main;
/
SHOW ERRORS
