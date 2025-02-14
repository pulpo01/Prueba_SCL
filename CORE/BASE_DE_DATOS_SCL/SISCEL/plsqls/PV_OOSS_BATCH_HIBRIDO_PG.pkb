CREATE OR REPLACE PACKAGE BODY PV_OOSS_BATCH_HIBRIDO_PG IS


FUNCTION PV_VAL_OOSSBATCH_PEND_FN(
      EV_cod_Os            IN PV_IORSERV.COD_OS%TYPE,
          EN_cod_cliente       IN PV_CAMCOM.COD_CLIENTE%TYPE,
      SN_p_filasafectas   OUT NOCOPY  NUMBER,
          SN_p_retornora      OUT NOCOPY  NUMBER,
          SN_p_nroevento      OUT NOCOPY  NUMBER,
      SV_p_vcod_retorno   OUT NOCOPY  VARCHAR2
) RETURN BOOLEAN
/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "PV_VAL_OOSSBATCH_PEND_FN"
      Lenguaje="PL/SQL"
      Fecha="03-07-2006"
      Versión="1.0"
      Diseñador="Ricardo Rocco"
      Programador="Orlando Cabezas B"
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
              <Descripción></Descripción>
       <Parámetros>
         <Entrada>
                        <param nom="EV_cod_Os"   Tipo="VARCHAR2">Código OOSS</param>
                        <param nom="EN_cod_cliente"        Tipo="NUMERICO">Código Cliente</param>
             </Entrada>
         <Salida>
            <param nom="SN_p_filasafectas     Tipo="NUMERICO">FILASAFESTADAS</param>
            <param nom="SN_p_retornora"     Tipo="NUMERICO">RETORNO ORACLE</param>
                    <param nom="SN_p_nroevento"     Tipo="NUMERICO">EVENTO</param>
                        <param nom="SV_p_vcod_retorno "     Tipo="varchar2">Codigo error</param>
         </Salida>
      </Parámetros>
  </Elemento>
</Documentación>
*/

IS
LV_sSql          ge_errores_pg.vQuery;
LN_v_nerror      NUMBER;
LN_num_os        PV_IORSERV.NUM_OS%TYPE;

LV_Evento        VARCHAR2(1500);
LV_v_verror      VARCHAR2(255);
LV_cod_glosa     VARCHAR2(255);


BEGIN

    SN_p_nroevento   := CN_0;
    SN_p_filasafectas:= CN_0;
    SV_p_vcod_retorno:= CV_0;
        SN_p_retornora   := CN_0;

    BEGIN

                LV_sSql:=' SELECT DISTINCT  A.NUM_OS';
                LV_sSql:=LV_sSql ||' INTO ' || LN_num_os;
            LV_sSql:=LV_sSql ||' FROM PV_IORSERV A, PV_CAMCOM B, PV_ERECORRIDO C';
            LV_sSql:=LV_sSql ||' WHERE A.NUM_OS    = B.NUM_OS';
            LV_sSql:=LV_sSql ||' AND A.NUM_OS      = C.NUM_OS';
            LV_sSql:=LV_sSql ||' AND B.NUM_OS      = C.NUM_OS';
            LV_sSql:=LV_sSql ||' AND B.COD_CLIENTE = ' || EN_cod_cliente;
            LV_sSql:=LV_sSql ||' AND A.COD_OS      = ' || EV_cod_Os;
            LV_sSql:=LV_sSql ||' AND A.COD_ESTADO  = ' || CN_10;
            LV_sSql:=LV_sSql ||' AND A.COD_ESTADO <> ' || CN_3;
            LV_sSql:=LV_sSql ||' AND A.COD_ESTADO = C.COD_ESTADO';
                LV_sSql:=LV_sSql ||' AND (C.TIP_ESTADO = ' || CN_3 || ' OR C.TIP_ESTADO = ' || CN_1||')';

                SELECT DISTINCT  A.NUM_OS
                INTO  LN_num_os
            FROM PV_IORSERV A, PV_CAMCOM B, PV_ERECORRIDO C
            WHERE A.NUM_OS    = B.NUM_OS
            AND A.NUM_OS      = C.NUM_OS
            AND B.NUM_OS      = C.NUM_OS
            AND B.COD_CLIENTE = EN_cod_cliente
            AND A.COD_OS      = EV_cod_Os
            AND A.COD_ESTADO  = CN_10
            AND A.COD_ESTADO <> CN_3
            AND A.COD_ESTADO = C.COD_ESTADO
                AND (C.TIP_ESTADO = CN_3 OR C.TIP_ESTADO = CN_1);

    EXCEPTION
        WHEN NO_DATA_FOUND THEN
                         RETURN TRUE;
    END;

        LV_sSql:='DELETE FROM pv_param_abocel  WHERE num_os = ' || LN_num_os;
        DELETE FROM pv_param_abocel WHERE num_os = LN_num_os;

    LV_sSql:='DELETE FROM pv_erecorrido  WHERE num_os = ' || LN_num_os;
        DELETE FROM pv_erecorrido  WHERE num_os = LN_num_os;

        LV_sSql:='DELETE FROM pv_prog        WHERE num_os = ' ||LN_num_os;
        DELETE FROM pv_prog        WHERE num_os = LN_num_os;

        LV_sSql:='DELETE FROM pv_movimientos WHERE num_os = ' ||LN_num_os;
        DELETE FROM pv_movimientos WHERE num_os = LN_num_os;

    LV_sSql:='DELETE FROM pv_camcom      WHERE num_os = ' ||LN_num_os;
    DELETE FROM pv_camcom      WHERE num_os = LN_num_os;

    LV_sSql:='DELETE FROM pv_iorserv     WHERE num_os = ' ||LN_num_os;
    DELETE FROM pv_iorserv     WHERE num_os = LN_num_os;


    RETURN TRUE;

EXCEPTION
  WHEN OTHERS THEN
       SV_p_vcod_retorno   :=CN_4;
           LV_cod_glosa     :=CV_error_no_clasif ;
           GN_EVENTO        :=GE_ERRORES_PG.GRABARPL(CN_0,CV_PV,LV_cod_glosa,CV_1, USER, CV_PACKAGE11, LV_sSql, sqlcode, SQLERRM);
           RETURN FALSE;
END PV_VAL_OOSSBATCH_PEND_FN;


---------------------------------------------------------------------------------------

FUNCTION PV_INS_IORSERV_FN(
      EN_secuencia         IN PV_IORSERV.NUM_OS%TYPE,
      EV_cod_Os            IN PV_IORSERV.COD_OS%TYPE,
      EV_descripcion       IN PV_IORSERV.DESCRIPCION%TYPE,
      EN_producto          IN PV_IORSERV.PRODUCTO%TYPE,
      EV_usuario           IN PV_IORSERV.USUARIO%TYPE,
      EN_tip_Procesa       IN PV_IORSERV.TIP_PROCESA%TYPE,
      EV_cod_Modgener      IN PV_IORSERV.COD_MODGENER%TYPE,
          ED_FECPROG           IN PV_IORSERV.FH_EJECUCION%TYPE,
          EV_TSUBJETO          IN PV_IORSERV.TIP_SUBSUJETO%TYPE,
          EV_SUJETO            IN PV_IORSERV.TIP_SUJETO%TYPE,
          EV_PATHF             IN PV_IORSERV.PATH_FILE%TYPE,
          EV_NFILE             IN PV_IORSERV.NFILE%TYPE,
          EV_MODULO            IN PV_IORSERV.COD_MODULO%TYPE,
          EN_NumTar            IN PV_IORSERV.ID_GESTOR%TYPE,
     SN_p_filasafectas   OUT NOCOPY  NUMBER,
          SN_p_retornora      OUT NOCOPY  NUMBER,
          SN_p_nroevento      OUT NOCOPY  NUMBER,
      SV_p_vcod_retorno   OUT NOCOPY  VARCHAR2
) RETURN BOOLEAN
/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "PV_INS_IORSERV_FN"
      Lenguaje="PL/SQL"
      Fecha="03-07-2006"
      Versión="1.0"
      Diseñador="Ricardo Rocco"
      Programador="Orlando Cabezas B"
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
              <Descripción></Descripción>
       <Parámetros>
         <Entrada>
                        <param nom="EN_secuencia   "   Tipo="NUMERICO">NUMERO OOSS</param>
                        <param nom="EV_cod_Os"         Tipo="VARCHAR2">Código OOSS</param>
                        <param nom="EV_descripcion"        Tipo="VARCHAR2">DESCRIPCIÓN</param>
                        <param nom="EN_producto "          Tipo="NUMERICO">PRODUCTO</param>
                        <param nom="EV_usuario         Tipo="VARCHAR2">USUARIO</param>
                        <param nom="EN_tip_Procesa"        Tipo="NUMERICO">tIPO PROCESAMIENTO</param>
                        <param nom="EV_cod_Modgener"   Tipo="VARCHAR2">MODO GENERACION</param>
                        <param nom="ED_FECPROG"  Tipo="DATE">FECHA PROGRAMACION</param>
                        <param nom="EV_TSUBJETO" Tipo="VARCHAR2">TIPO SUBSUJETO</param>
                        <param nom="EV_SUJETO "  Tipo="VARCHAR2">TIPO SUJETO</param>
                        <param nom="EV_PATHF"    Tipo="VARCHAR2">PATH FILE</param>
                        <param nom="EV_NFILE"    Tipo="VARCHAR2">NUMERO ARCHIVOS</param>
                        <param nom="EV_MODULO"   Tipo="VARCHAR2">MODULO GESTOR</param>
                        <param nom="EN_NumTar"   Tipo="VARCHAR2">NUMERO TAREA</param>
             </Entrada>
         <Salida>
            <param nom="SN_p_filasafectas     Tipo="NUMERICO">FILASAFESTADAS</param>
            <param nom="SN_p_retornora"     Tipo="NUMERICO">RETORNO ORACLE</param>
                    <param nom="SN_p_nroevento"     Tipo="NUMERICO">EVENTO</param>
                        <param nom="SV_p_vcod_retorno "     Tipo="varchar2">Codigo error</param>
         </Salida>
      </Parámetros>
  </Elemento>
</Documentación>
*/


IS
LV_sSql          ge_errores_pg.vQuery;
LN_v_nerror      NUMBER;

LV_Evento        VARCHAR2(1500);
LV_v_verror      VARCHAR2(255);
LV_cod_glosa     VARCHAR2(255);



BEGIN

    SN_p_nroevento   := CN_0;
    SN_p_filasafectas:= CN_0;
    SV_p_vcod_retorno:= CV_0;
        SN_p_retornora   := CN_0;

    If EN_NumTar = 0 Then
       LV_sSql:= 'INSERT INTO pv_iorserv(num_os,cod_os,num_ospadre,descripcion,fecha_ing,producto,usuario,status,tip_procesa,fh_ejecucion,cod_estado,cod_modgener,num_osf,tip_subsujeto,tip_sujeto,path_file,nfile)';
           LV_sSql:= LV_sSql || 'VALUES( ' ||EN_secuencia||','||EV_cod_Os||','||NULL||','||EV_descripcion||','||SYSDATE||','||EN_producto||','||EV_usuario||','||CV_ENPROCESO||','||EN_tip_Procesa||','||ED_FECPROG||','||CN_10||','||EV_cod_Modgener||','||CN_0||','||EV_TSUBJETO||','||EV_SUJETO||','||EV_PATHF||','||EV_NFILE||')';

       INSERT INTO pv_iorserv(num_os,cod_os,num_ospadre,descripcion,fecha_ing,producto,usuario,status,tip_procesa,fh_ejecucion,cod_estado,cod_modgener,num_osf,tip_subsujeto,tip_sujeto,path_file,nfile)
           VALUES(EN_secuencia,EV_cod_Os,NULL,EV_descripcion,SYSDATE,EN_producto,EV_usuario,CV_ENPROCESO,EN_tip_Procesa ,ED_FECPROG,CN_10,EV_cod_Modgener ,CN_0,EV_TSUBJETO,EV_SUJETO,EV_PATHF,EV_NFILE);

        ELSE
       LV_sSql:= 'INSERT INTO pv_iorserv(num_os,cod_os,num_ospadre,descripcion,fecha_ing,producto,usuario,status,tip_procesa,fh_ejecucion,cod_estado,cod_modgener,num_osf,tip_subsujeto,tip_sujeto,path_file,nfile,cod_modulo,id_gestor)';
           LV_sSql:= LV_sSql || 'VALUES( ' ||EN_secuencia||','||EV_cod_Os||','||NULL||','||EV_descripcion||','||SYSDATE||','||EN_producto||','||EV_usuario||','||CV_ENPROCESO||','||EN_tip_Procesa||',' ||ED_FECPROG||','||CN_10||','||EV_cod_Modgener|| ','||CN_0||','||EV_TSUBJETO||','||EV_SUJETO||','||EV_PATHF||','||EV_NFILE||','||EV_MODULO||','||EN_NumTar||')';

       INSERT INTO pv_iorserv(num_os,cod_os,num_ospadre,descripcion,fecha_ing,producto,usuario,status,tip_procesa,fh_ejecucion,cod_estado,cod_modgener,num_osf,tip_subsujeto,tip_sujeto,path_file,nfile,cod_modulo,id_gestor)
           VALUES(EN_secuencia,EV_cod_Os,NULL,EV_descripcion,SYSDATE,EN_producto,EV_usuario,CV_ENPROCESO,EN_tip_Procesa ,ED_FECPROG,CN_10,EV_cod_Modgener ,CN_0,EV_TSUBJETO,EV_SUJETO,EV_PATHF,EV_NFILE,EV_MODULO,EN_NumTar);
    End If;

    RETURN TRUE;

EXCEPTION
  WHEN OTHERS THEN
       SV_p_vcod_retorno   :=CN_4;
           LV_cod_glosa     :=CV_error_no_clasif ;
           GN_EVENTO        :=GE_ERRORES_PG.GRABARPL(CN_0,CV_PV,LV_cod_glosa,CV_1, USER, CV_PACKAGE2, LV_sSql, sqlcode, SQLERRM);
           RETURN FALSE;
END PV_INS_IORSERV_FN;

-------------------------------------------------------------------

FUNCTION PV_INS_ERECORRIDO_FN(
      EN_secuencia         IN PV_IORSERV.NUM_OS%TYPE,
      EV_descripcion       IN PV_ERECORRIDO.DESCRIPCION%TYPE,
      SN_p_filasafectas   OUT NOCOPY  NUMBER,
          SN_p_retornora      OUT NOCOPY  NUMBER,
          SN_p_nroevento      OUT NOCOPY  NUMBER,
      SV_p_vcod_retorno   OUT NOCOPY VARCHAR2
) RETURN BOOLEAN
/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "PV_INS_ERECORRIDO_FN"
      Lenguaje="PL/SQL"
      Fecha="03-07-2006"
      Versión="1.0"
      Diseñador="Ricardo Rocco"
      Programador="Orlando Cabezas B"
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
              <Descripción></Descripción>
       <Parámetros>
         <Entrada>
                        <param nom="EN_secuencia   "   Tipo="NUMERICO">NUMERO OOSS</param>
                        <param nom="EV_descripcion"        Tipo="VARCHAR2">DESCRIPCIÓN</param>

                 </Entrada>
         <Salida>
            <param nom="SN_p_filasafectas     Tipo="NUMERICO">FILASAFESTADAS</param>
            <param nom="SN_p_retornora"     Tipo="NUMERICO">RETORNO ORACLE</param>
                    <param nom="SN_p_nroevento"     Tipo="NUMERICO">EVENTO</param>
                        <param nom="SV_p_vcod_retorno "     Tipo="varchar2">Codigo error</param>
         </Salida>
      </Parámetros>
  </Elemento>
</Documentación>
*/


IS
LV_sSql          ge_errores_pg.vQuery;
LN_v_nerror      NUMBER;

LV_Evento        VARCHAR2(1500);
LV_v_verror      VARCHAR2(255);
LV_cod_glosa     VARCHAR2(255);


BEGIN

    SN_p_nroevento   := CN_0;
    SN_p_filasafectas:= CN_0;
    SV_p_vcod_retorno:= CV_0;
        SN_p_retornora   := CN_0;


    LV_sSql:= 'INSERT INTO PV_ERECORRIDO(num_os,cod_estado,descripcion,tip_estado,fec_ingestado) ';
        LV_sSql:= LV_sSql || 'VALUES( ' || EN_secuencia||','||CN_10||','||EV_descripcion||','||CV_1||','||SYSDATE||')';


    INSERT INTO PV_ERECORRIDO(num_os,cod_estado,descripcion,tip_estado,fec_ingestado)
        VALUES(EN_secuencia,CN_10,EV_descripcion,CV_1,SYSDATE);



    RETURN TRUE;

EXCEPTION
  WHEN OTHERS THEN
       SV_p_vcod_retorno   :=CN_4;
           LV_cod_glosa     :=CV_error_no_clasif ;
           GN_EVENTO        :=GE_ERRORES_PG.GRABARPL(CN_0,CV_PV,LV_cod_glosa,CV_1, USER, CV_PACKAGE7, LV_sSql, sqlcode, SQLERRM);
           RETURN FALSE;
END PV_INS_ERECORRIDO_FN;

----------------------------------------------------------------------------

FUNCTION PV_INS_PROG_FN(
      EN_secuencia         IN PV_IORSERV.NUM_OS%TYPE,
      ED_FECPROG           IN PV_IORSERV.FH_EJECUCION%TYPE,
          EV_usuario           IN PV_IORSERV.USUARIO%TYPE,
      SN_p_filasafectas   OUT NOCOPY  NUMBER,
          SN_p_retornora      OUT NOCOPY  NUMBER,
          SN_p_nroevento      OUT NOCOPY  NUMBER,
      SV_p_vcod_retorno   OUT NOCOPY VARCHAR2
) RETURN BOOLEAN
/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "PV_INS_PROG_FN"
      Lenguaje="PL/SQL"
      Fecha="03-07-2006"
      Versión="1.0"
      Diseñador="Ricardo Rocco"
      Programador="Orlando Cabezas B"
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
              <Descripción></Descripción>
       <Parámetros>
         <Entrada>
                        <param nom="EN_secuencia   "   Tipo="NUMERICO">NUMERO OOSS</param>
                        <param nom="ED_FECPROG"    Tipo="DATE">FECHA PROGRAMACION</param>
                        <param nom="EV_usuario"    Tipo="VARCHAR2">USUARIO</param>
                 </Entrada>
         <Salida>
            <param nom="SN_p_filasafectas     Tipo="NUMERICO">FILASAFESTADAS</param>
            <param nom="SN_p_retornora"     Tipo="NUMERICO">RETORNO ORACLE</param>
                    <param nom="SN_p_nroevento"     Tipo="NUMERICO">EVENTO</param>
                        <param nom="SV_p_vcod_retorno "     Tipo="varchar2">Codigo error</param>
         </Salida>
      </Parámetros>
  </Elemento>
</Documentación>
*/


IS
LV_sSql          ge_errores_pg.vQuery;
LN_v_nerror      NUMBER;

LV_Evento        VARCHAR2(1500);
LV_v_verror      VARCHAR2(255);
LV_cod_glosa     VARCHAR2(255);


BEGIN

    SN_p_nroevento   := CN_0;
    SN_p_filasafectas:= CN_0;
    SV_p_vcod_retorno:= CV_0;
        SN_p_retornora   := CN_0;


    LV_sSql:= 'INSERT INTO PV_PROG(num_os,f_prorroga,usuario)';
        LV_sSql:= LV_sSql || 'VALUES( ' || EN_secuencia||','||ED_FECPROG||','||EV_usuario||')';


    INSERT INTO PV_PROG(num_os,f_prorroga,usuario)
        VALUES(EN_secuencia,ED_FECPROG,EV_usuario );

    RETURN TRUE;

EXCEPTION
  WHEN OTHERS THEN
       SV_p_vcod_retorno   :=CN_4;
           LV_cod_glosa     :=CV_error_no_clasif ;
           GN_EVENTO        :=GE_ERRORES_PG.GRABARPL(CN_0,CV_PV,LV_cod_glosa,CV_1, USER, CV_PACKAGE8, LV_sSql, sqlcode, SQLERRM);
           RETURN FALSE;
END PV_INS_PROG_FN;

--------------------------------------------------------------------------


FUNCTION PV_INS_MOVIMIENTOS_FN(
      EN_secuencia         IN PV_MOVIMIENTOS.NUM_OS%TYPE,
      EN_actabo            IN PV_MOVIMIENTOS.COD_ACTABO%TYPE,
      EN_ind_estado        IN PV_MOVIMIENTOS.IND_ESTADO%TYPE,
          EN_carga                         IN pv_movimientos.carga%TYPE,
      SN_p_filasafectas   OUT NOCOPY  NUMBER,
          SN_p_retornora      OUT NOCOPY  NUMBER,
          SN_p_nroevento      OUT NOCOPY  NUMBER,
      SV_p_vcod_retorno   OUT NOCOPY  VARCHAR2
) RETURN BOOLEAN
/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "PV_INS_MOVIMIENTOS_FN"
      Lenguaje="PL/SQL"
      Fecha="03-07-2006"
      Versión="1.0"
      Diseñador="Ricardo Rocco"
      Programador="Orlando Cabezas B"
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
              <Descripción></Descripción>
       <Parámetros>
         <Entrada>
                        <param nom="EN_secuencia   "   Tipo="NUMERICO">NUMERO OOSS</param>
                        <param nom="EN_actabo"     Tipo="VARCHAR2">ACTABO</param>
                        <param nom="EN_ind_estado"         Tipo="VARCHAR2">INDICADOR DE ESTADO</param>
                 </Entrada>
         <Salida>
            <param nom="SN_p_filasafectas     Tipo="NUMERICO">FILASAFESTADAS</param>
            <param nom="SN_p_retornora"     Tipo="NUMERICO">RETORNO ORACLE</param>
                    <param nom="SN_p_nroevento"     Tipo="NUMERICO">EVENTO</param>
                        <param nom="SV_p_vcod_retorno "     Tipo="varchar2">Codigo error</param>
         </Salida>
      </Parámetros>
  </Elemento>
</Documentación>
*/


IS
LV_sSql          ge_errores_pg.vQuery;
LN_v_nerror      NUMBER;

LV_Evento        VARCHAR2(1500);
LV_v_verror      VARCHAR2(255);
LV_cod_glosa     VARCHAR2(255);


BEGIN

    SN_p_nroevento   := CN_0;
    SN_p_filasafectas:= CN_0;
    SV_p_vcod_retorno:= CV_0;
        SN_p_retornora   := CN_0;


    LV_sSql:= 'INSERT INTO PV_MOVIMIENTOS(num_os,ord_comando,cod_actabo,ind_estado,carga)';
        LV_sSql:= LV_sSql || 'VALUES( ' || EN_secuencia||','||CN_1||','||EN_actabo||','||EN_ind_estado||')';


    INSERT INTO PV_MOVIMIENTOS(num_os,ord_comando,cod_actabo,ind_estado,carga)
        VALUES(EN_secuencia,CN_1,EN_actabo,EN_ind_estado,EN_carga);

    RETURN TRUE;

EXCEPTION
  WHEN OTHERS THEN
       SV_p_vcod_retorno   :=CN_4;
           LV_cod_glosa     :=CV_error_no_clasif ;
           GN_EVENTO        :=GE_ERRORES_PG.GRABARPL(CN_0,CV_PV,LV_cod_glosa,CV_1, USER, CV_PACKAGE3, LV_sSql, sqlcode, SQLERRM);
           RETURN FALSE;
END PV_INS_MOVIMIENTOS_FN;

--------------------------------------------------------------------------


FUNCTION PV_INS_PARAM_ABOCEL_FN(
      EN_secuencia         IN PV_PARAM_ABOCEL.NUM_OS%TYPE,
      EV_num_abonado       IN PV_PARAM_ABOCEL.NUM_ABONADO%TYPE,
      EV_actabo            IN PV_PARAM_ABOCEL.COD_TIPMODI%TYPE,
      EV_usuario           IN PV_PARAM_ABOCEL.NUOM_USUARORA%TYPE,
      EN_celular           IN PV_PARAM_ABOCEL.NUM_CELULAR%TYPE,
      EV_tip_plantarif     IN PV_PARAM_ABOCEL.TIP_PLANTARIF%TYPE,
      EV_cod_plantarif     IN PV_PARAM_ABOCEL.COD_PLANTARIF%TYPE,
--        EV_tip_plantarif_nue IN PV_PARAM_ABOCEL.TIP_PLANTARIF_NUE%TYPE,
--      EV_cod_plantarif_nue IN PV_PARAM_ABOCEL.COD_PLANTARIF_NUE%TYPE,
          ED_FECPROG           IN PV_IORSERV.FH_EJECUCION%TYPE,
      SN_p_filasafectas   OUT NOCOPY  NUMBER,
          SN_p_retornora      OUT NOCOPY  NUMBER,
          SN_p_nroevento      OUT NOCOPY  NUMBER,
      SV_p_vcod_retorno   OUT NOCOPY  VARCHAR2
) RETURN BOOLEAN
/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "PV_INS_PARAM_ABOCEL_FN
      Lenguaje="PL/SQL"
      Fecha="03-07-2006"
      Versión="1.0"
      Diseñador="Ricardo Rocco"
      Programador="Orlando Cabezas B"
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
              <Descripción></Descripción>
       <Parámetros>
         <Entrada>
                        <param nom="EN_secuencia"   Tipo="NUMERICO">NUMERO OOSS</param>
                        <param nom="EV_num_abonado"   Tipo="NUMERICO">NUMERO ABONADO</param>
                        <param nom="EN_actabo"     Tipo="VARCHAR2">ACTABO</param>
                        <param nom="EV_usuario"    Tipo="VARCHAR2">USUARIO</param>
                        <param nom="EN_celular"    Tipo="NUMERICO">NUMERO CELULAR</param>
                        <param nom="EV_tip_plantarif"      Tipo="VARCHAR2">TIPO PLAN </param>
                        <param nom="EV_cod_plantarif"      Tipo="VARCHAR2">PLAN ACTUAL</param>
                        <param nom="EV_tip_plantarif_nue"          Tipo="VARCHAR2">TIPO PLAN nuevo</param>
                        <param nom="EV_cod_plantarif_nue"          Tipo="VARCHAR2">PLAN nuevo</param>
                        <param nom="ED_FECPROG "           Tipo="DATE">fECHA MODIFICACION</param>
                 </Entrada>
         <Salida>
            <param nom="SN_p_filasafectas     Tipo="NUMERICO">FILASAFESTADAS</param>
            <param nom="SN_p_retornora"     Tipo="NUMERICO">RETORNO ORACLE</param>
                    <param nom="SN_p_nroevento"     Tipo="NUMERICO">EVENTO</param>
                        <param nom="SV_p_vcod_retorno "     Tipo="varchar2">Codigo error</param>
         </Salida>
      </Parámetros>
  </Elemento>
</Documentación>
*/


IS
LV_sSql          ge_errores_pg.vQuery;
LN_v_nerror      NUMBER;

LV_Evento        VARCHAR2(1500);
LV_v_verror      VARCHAR2(255);
LV_cod_glosa     VARCHAR2(255);


BEGIN

    SN_p_nroevento   := CN_0;
    SN_p_filasafectas:= CN_0;
    SV_p_vcod_retorno:= CV_0;
        SN_p_retornora   := CN_0;


    LV_sSql:= 'INSERT INTO PV_PARAM_ABOCEL(num_os,num_abonado,cod_tipmodi,nuom_usuarora,num_celular,tip_plantarif,cod_plantarif,FEC_MODIFICA)';
        LV_sSql:= LV_sSql || 'VALUES( ' || EN_secuencia||','||EV_num_abonado||','||EV_actabo||','||EV_usuario||','||EN_celular||','||EV_tip_plantarif||','||EV_cod_plantarif||','||ED_FECPROG ||')';


    INSERT INTO PV_PARAM_ABOCEL(num_os,num_abonado,cod_tipmodi,nuom_usuarora,num_celular,tip_plantarif,cod_plantarif,FEC_MODIFICA)
        VALUES(EN_secuencia,EV_num_abonado,EV_actabo,EV_usuario,EN_celular,EV_tip_plantarif,EV_cod_plantarif,ED_FECPROG);

    RETURN TRUE;

EXCEPTION
  WHEN OTHERS THEN
       SV_p_vcod_retorno   :=CN_4;
           LV_cod_glosa     :=CV_error_no_clasif ;
           GN_EVENTO        :=GE_ERRORES_PG.GRABARPL(CN_0,CV_PV,LV_cod_glosa,CV_1, USER, CV_PACKAGE4, LV_sSql, sqlcode, SQLERRM);
           RETURN FALSE;
END PV_INS_PARAM_ABOCEL_FN;

------------------------------------------------------------------------


FUNCTION PV_INS_CAMCOM_FN (
      EN_secuencia          IN PV_CAMCOM.NUM_OS%TYPE,
      EN_celular            IN PV_CAMCOM.NUM_CELULAR%TYPE,
      EN_cod_cliente        IN PV_CAMCOM.COD_CLIENTE%TYPE,
      EN_cod_cuenta         IN PV_CAMCOM.COD_CUENTA%TYPE,
      EV_bdatos             IN PV_CAMCOM.BDATOS%TYPE,
      EN_num_venta          IN PV_CAMCOM.NUM_VENTA%TYPE,
      EV_cod_actabo         IN PV_CAMCOM.COD_ACTABO%TYPE,
      ED_FECPROG            IN PV_IORSERV.FH_EJECUCION%TYPE,
          EN_num_abonado                IN pv_camcom.num_abonado%TYPE,
      SN_p_filasafectas    OUT NOCOPY  NUMBER,
          SN_p_retornora       OUT NOCOPY  NUMBER,
          SN_p_nroevento       OUT NOCOPY  NUMBER,
      SV_p_vcod_retorno    OUT NOCOPY  VARCHAR2
)RETURN BOOLEAN
/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "PV_INS_CAMCOM_FN
      Lenguaje="PL/SQL"
      Fecha="03-07-2006"
      Versión="1.0"
      Diseñador="Ricardo Rocco"
      Programador="Orlando Cabezas B"
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
              <Descripción></Descripción>
       <Parámetros>
         <Entrada>
                        <param nom="EN_secuencia"    Tipo="NUMERICO">NUMERO OOSS</param>
                        <param nom="EN_celular"      Tipo="NUMERICO">NUMERO CELULAR</param>
                        <param nom="EN_cod_cliente"  Tipo="NUMERICO">codigo cliente</param>
                        <param nom="EN_cod_cuenta"   Tipo="NUMERICO">codigo cuenta</param>
                        <param nom="EV_bdatos"       Tipo="varchar2">base de datos</param>
                        <param nom="EN_num_venta"    Tipo="NUMERICO">numero de venta</param>
                        <param nom="EN_actabo"       Tipo="VARCHAR2">ACTABO</param>
                        <param nom="ED_FECPROG "         Tipo="VARCHAR2">fecha programacion</param>
                 </Entrada>
         <Salida>
            <param nom="SN_p_filasafectas     Tipo="NUMERICO">FILASAFESTADAS</param>
            <param nom="SN_p_retornora"     Tipo="NUMERICO">RETORNO ORACLE</param>
                    <param nom="SN_p_nroevento"     Tipo="NUMERICO">EVENTO</param>
                        <param nom="SV_p_vcod_retorno "     Tipo="varchar2">Codigo error</param>
         </Salida>
      </Parámetros>
  </Elemento>
</Documentación>
*/


IS
LV_sSql          ge_errores_pg.vQuery;
LN_v_nerror      NUMBER;

LV_Evento        VARCHAR2(1500);
LV_v_verror      VARCHAR2(255);
LV_cod_glosa     VARCHAR2(255);


BEGIN

    SN_p_nroevento   := CN_0;
    SN_p_filasafectas:= CN_0;
    SV_p_vcod_retorno:= CV_0;
        SN_p_retornora   := CN_0;


    LV_sSql:= 'INSERT INTO PV_CAMCOM(num_os,num_abonado,num_celular,cod_cliente,cod_cuenta,cod_producto,bdatos,num_venta,num_transaccion,num_folio,num_cuotas,num_proceso,cod_actabo,fh_anula,cat_tribut,cod_estadoc,cod_causaelim,fec_vencimiento,clase_servicio_act,clase_servicio_des,ind_central_ss,ind_portable,tip_terminal,tip_susp_avsinie,pref_plaza) ';
        LV_sSql:= LV_sSql || 'VALUES( ' || EN_secuencia||','||CN_0||','||EN_celular||','||EN_cod_cliente||','||EN_cod_cuenta||','||CN_1||','||EV_bdatos ||','||EN_num_venta||','||NULL||','||NULL||','||NULL||','||CN_0||','||EV_cod_actabo||','||NULL||','||NULL||','||CN_0||','||NULL||','||ED_FECPROG||','||NULL||','||NULL||','||CN_0||','||CN_0||','||NULL||','||NULL||','||NULL||')';


    INSERT INTO PV_CAMCOM(num_os,num_abonado,num_celular,cod_cliente,cod_cuenta,cod_producto,bdatos,num_venta,num_transaccion,num_folio,num_cuotas,num_proceso,cod_actabo,fh_anula,cat_tribut,cod_estadoc,cod_causaelim,fec_vencimiento,clase_servicio_act,clase_servicio_des,ind_central_ss,ind_portable,tip_terminal,tip_susp_avsinie,pref_plaza)
        VALUES(EN_secuencia,EN_num_abonado,EN_celular,EN_cod_cliente,EN_cod_cuenta,CN_1,EV_bdatos ,EN_num_venta,NULL,NULL,NULL,CN_0,EV_cod_actabo,NULL,NULL,CN_0,NULL,ED_FECPROG,NULL,NULL,1,CN_0,NULL,NULL,NULL);

    RETURN TRUE;

EXCEPTION
  WHEN OTHERS THEN
       SV_p_vcod_retorno   :=CN_4;
           LV_cod_glosa     :=CV_error_no_clasif ;
           GN_EVENTO        :=GE_ERRORES_PG.GRABARPL(CN_0,CV_PV,LV_cod_glosa,CV_1, USER, CV_PACKAGE5, LV_sSql, sqlcode, SQLERRM);
           RETURN FALSE;
END PV_INS_CAMCOM_FN;

--------------------------------------------------------------------------------------


FUNCTION PV_UPD_IORSERV_FN(
      EN_secuencia          IN PV_CAMCOM.NUM_OS%TYPE,
          EV_descripcion                IN  VARCHAR2,
      SN_p_filasafectas    OUT NOCOPY  NUMBER,
          SN_p_retornora       OUT NOCOPY  NUMBER,
          SN_p_nroevento       OUT NOCOPY  NUMBER,
      SV_p_vcod_retorno    OUT NOCOPY  VARCHAR2
) RETURN BOOLEAN
/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "PV_UPD_IORSERV_FN
      Lenguaje="PL/SQL"
      Fecha="03-07-2006"
      Versión="1.0"
      Diseñador="Ricardo Rocco"
      Programador="Orlando Cabezas B"
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
              <Descripción></Descripción>
       <Parámetros>
         <Entrada>
                        <param nom="EN_secuencia"    Tipo="NUMERICO">NUMERO OOSS</param>
                        <param nom="EV_descripcion"          Tipo="varchar2">descripcion</param>
                 </Entrada>
         <Salida>
            <param nom="SN_p_filasafectas     Tipo="NUMERICO">FILASAFESTADAS</param>
            <param nom="SN_p_retornora"     Tipo="NUMERICO">RETORNO ORACLE</param>
                    <param nom="SN_p_nroevento"     Tipo="NUMERICO">EVENTO</param>
                        <param nom="SV_p_vcod_retorno "     Tipo="varchar2">Codigo error</param>
         </Salida>
      </Parámetros>
  </Elemento>
</Documentación>
*/


IS
LV_sSql          ge_errores_pg.vQuery;
LN_v_nerror      NUMBER;

LV_Evento        VARCHAR2(1500);
LV_v_verror      VARCHAR2(255);
LV_cod_glosa     VARCHAR2(255);


BEGIN

    SN_p_nroevento   := CN_0;
    SN_p_filasafectas:= CN_0;
    SV_p_vcod_retorno:= CV_0;
        SN_p_retornora   := CN_0;

        UPDATE PV_IORSERV
        SET STATUS = EV_descripcion
        WHERE  NUM_OS = EN_secuencia;

    RETURN TRUE;

EXCEPTION
  WHEN OTHERS THEN
       SV_p_vcod_retorno   :=CN_4;
           LV_cod_glosa     :=CV_error_no_clasif ;
           GN_EVENTO        :=GE_ERRORES_PG.GRABARPL(CN_0,CV_PV,LV_cod_glosa,CV_1, USER, CV_PACKAGE9, LV_sSql, sqlcode, SQLERRM);
           RETURN FALSE;
END PV_UPD_IORSERV_FN;


--------------------------------------------------------------------------------------

FUNCTION PV_UPD_ERECORRIDO_FN(
      EN_secuencia          IN PV_CAMCOM.NUM_OS%TYPE,
      EV_descripcion            IN  VARCHAR2,
      SN_p_filasafectas    OUT NOCOPY  NUMBER,
          SN_p_retornora       OUT NOCOPY  NUMBER,
          SN_p_nroevento       OUT NOCOPY  NUMBER,
      SV_p_vcod_retorno    OUT NOCOPY  VARCHAR2
) RETURN BOOLEAN
/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "PV_UPD_ERECORRIDO_FN
      Lenguaje="PL/SQL"
      Fecha="03-07-2006"
      Versión="1.0"
      Diseñador="Ricardo Rocco"
      Programador="Orlando Cabezas B"
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
              <Descripción></Descripción>
       <Parámetros>
         <Entrada>
                        <param nom="EN_secuencia"    Tipo="NUMERICO">NUMERO OOSS</param>
                        <param nom="EV_descripcion"          Tipo="varchar2">descripcion</param>
                 </Entrada>
         <Salida>
            <param nom="SN_p_filasafectas     Tipo="NUMERICO">FILASAFESTADAS</param>
            <param nom="SN_p_retornora"     Tipo="NUMERICO">RETORNO ORACLE</param>
                    <param nom="SN_p_nroevento"     Tipo="NUMERICO">EVENTO</param>
                        <param nom="SV_p_vcod_retorno "     Tipo="varchar2">Codigo error</param>
         </Salida>
      </Parámetros>
  </Elemento>
</Documentación>
*/

IS
LV_sSql          ge_errores_pg.vQuery;
LN_v_nerror      NUMBER;

LV_Evento        VARCHAR2(1500);
LV_v_verror      VARCHAR2(255);
LV_cod_glosa     VARCHAR2(255);


BEGIN

    SN_p_nroevento   := CN_0;
    SN_p_filasafectas:= CN_0;
    SV_p_vcod_retorno:= CV_0;
        SN_p_retornora   := CN_0;

        UPDATE PV_ERECORRIDO
        SET DESCRIPCION = EV_descripcion , TIP_ESTADO= CV_3
        WHERE  NUM_OS = EN_secuencia;

    RETURN TRUE;

EXCEPTION
  WHEN OTHERS THEN
       SV_p_vcod_retorno   :=CN_4;
           LV_cod_glosa     :=CV_error_no_clasif ;
           GN_EVENTO        :=GE_ERRORES_PG.GRABARPL(CN_0,CV_PV,LV_cod_glosa,CV_1, USER, CV_PACKAGE10, LV_sSql, sqlcode, SQLERRM);
           RETURN FALSE;
END PV_UPD_ERECORRIDO_FN;


--------------------------------------------------------------------------------------



PROCEDURE PV_INSCRIBE_OOSS_PR(
       EN_TRANSACABO         IN  GA_TRANSACABO.NUM_TRANSACCION%TYPE,
       EN_num_celular        IN  NUMBER,
       EV_cod_ooss           IN  VARCHAR2,
       EV_usuario            IN  VARCHAR2,
       EN_num_abonado        IN  NUMBER,
           EN_cod_cliente        IN  NUMBER,
           EV_cod_actabo                 IN  ga_actabo.cod_actabo%TYPE,
           EV_BDATOS             IN  VARCHAR2,
           EV_TIP_PLANTARIF      IN  PV_PARAM_ABOCEL.TIP_PLANTARIF%TYPE,
           EV_COD_PLANTARIF      IN  PV_PARAM_ABOCEL.COD_PLANTARIF%TYPE,
--         EV_TIP_PLANTARIF_NUE  IN  PV_PARAM_ABOCEL.TIP_PLANTARIF_NUE%TYPE,
--         EV_COD_PLANTARIF_NUE  IN  PV_PARAM_ABOCEL.COD_PLANTARIF_NUE%TYPE,
           EN_num_venta          IN  PV_CAMCOM.NUM_VENTA%TYPE,
       EN_cod_cuenta         IN  PV_CAMCOM.COD_CUENTA%TYPE,
       ED_FECPROG            IN  VARCHAR2,
           EN_carga                              IN  pv_movimientos.carga%TYPE,
           EV_TSUBJETO           IN  PV_IORSERV.TIP_SUBSUJETO%TYPE,
           EV_SUJETO             IN  PV_IORSERV.TIP_SUJETO%TYPE,
           EV_MODULO             IN  PV_IORSERV.COD_MODULO%TYPE,
           EN_NumTar             IN  PV_IORSERV.ID_GESTOR%TYPE
         )
/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "PV_INS_IORSERV_FN"
      Lenguaje="PL/SQL"
      Fecha="03-07-2006"
      Versión="1.0"
      Diseñador="Ricardo Rocco"
      Programador="Orlando Cabezas B"
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
              <Descripción></Descripción>
       <Parámetros>
         <Entrada>
                 <param nom="EN_NumTar"            Tipo="NUMERICO">NUMERO TAREA</param>

                        <param nom="EN_num_celular"         Tipo="NUMERICO">NUMERO CELULAR</param>
                        <param nom="EV_cod_ooss"            Tipo="VARCHAR2">CODIGO OOSS</param>
                        <param nom="EV_usuario"             Tipo="VARCHAR2">USUARIO</param>
                        <param nom="EN_secuencia"           Tipo="NUMERICO">NUMERO OOSS</param>
                        <param nom="EV_modgener"            Tipo="VARCHAR2">MODO GENERACION</param>
                        <param nom="EN_actabo"              Tipo="VARCHAR2">ACTABO</param>
                        <param nom="EN_num_abonado"         Tipo="NUMERICO">NUMERO ABONADO</param>
                        <param nom="EN_cod_cliente"         Tipo="NUMERICO">CLIENTE</param>
                        <param nom="EV_descripcion"         Tipo="VARCHAR2">DESCRIPCIÓN</param>
                        <param nom="EN_producto"            Tipo="NUMERICO">PRODUCTO</param>
                        <param nom="EN_tip_Procesa"         Tipo="NUMERICO">TIPO PROCESAMIENTO</param>
                        <param nom="EV_BDATOS"              Tipo="VARCHAR2">BASE DE DATOS</param>
                        <param nom="EV_TIP_PLANTARIF"       Tipo="VARCHAR2">TIPO PLAN ACTUAL</param>
                        <param nom="EV_COD_PLANTARIF"       Tipo="VARCHAR2">PLAN ACTUAL</param>
                        <param nom="EV_TIP_PLANTARIF_NUE"   Tipo="VARCHAR2">TIPO PLAN NUEVO</param>
                        <param nom="EV_COD_PLANTARIF_NUE"   Tipo="VARCHAR2">PLAN NUEVO</param>
                        <param nom="EN_num_venta"           Tipo="NUMERICO">NUMERO VENTA</param>
                        <param nom="EN_cod_cuenta"         Tipo="NUMERICO">CUENTA</param>
                        <param nom="EN_ind_estado"         Tipo="NUMERICO">INDICADOR ESTADO</param>
                        <param nom="ED_FECPROG"            Tipo="VARCHAR2"">FECHA PROGRAMACION</param>
                        <param nom="EV_TSUBJETO"           Tipo="VARCHAR2">TIPO SUJETO</param>
                        <param nom="EV_SUJETO"             Tipo="VARCHAR2">SUJETO</param>
                        <param nom="EV_PATHF"              Tipo="VARCHAR2">PATH FILE</param>
                        <param nom="EV_NFILE"              Tipo="VARCHAR2">NUMERO FILE</param>
                        <param nom="EV_MODULO"             Tipo="VARCHAR2">MODULO GESTOR</param>

             </Entrada>
         <Salida>
                  </Salida>
      </Parámetros>
  </Elemento>
</Documentación>
*/

IS

LV_sSql          ge_errores_pg.vQuery;
LN_v_nerror      NUMBER;

LV_Evento        VARCHAR2(1500);
LV_v_verror      VARCHAR2(255);

LV_DESCRIPCION   CI_TIPORSERV.DESCRIPCION%TYPE;
LN_tip_procesa   CI_TIPORSERV.TIP_PROCESA%TYPE;
LV_cod_modgener  CI_TIPORSERV.COD_MODGENER%TYPE;
LV_cod_tipmodi   CI_TIPORSERV.COD_TIPMODI%TYPE;

LV_des_estadoc   FA_INTESTADOC.DES_ESTADOC%TYPE;
LN_secuencia     PV_IORSERV.NUM_OS%TYPE;

LV_cod_glosa     VARCHAR2(255);

LV_FechProg      DATE;


SN_p_filasafectas      NUMBER;
SN_p_retornora         NUMBER;
SN_p_nroevento         NUMBER;
SV_p_vcod_retorno      VARCHAR2(2);
LV_CADENA              VARCHAR(255);

ERROR_PROCESO    EXCEPTION;

BEGIN

    SN_p_nroevento   := CN_0;
    SN_p_filasafectas:= CN_0;
    SV_p_vcod_retorno:= CV_0;
        SN_p_retornora   := CN_0;
        LV_FechProg := to_date(ED_FECPROG,'DD-MM-YYYY HH24:MI:SS');

        LV_sSql:='SELECT CI_SEQ_NUMOS.NEXTVAL INTO ' ||  LN_secuencia || ' FROM DUAL';
    SELECT CI_SEQ_NUMOS.NEXTVAL INTO LN_secuencia FROM   DUAL;

        LV_sSql:='PV_OOSS_BATCH_HIBRIDO_PG.PV_VAL_OOSSBATCH_PEND_FN(EV_cod_ooss,EN_cod_cliente,SN_p_filasafectas,SN_p_retornora,SN_p_nroevento,SV_p_vcod_retorno)';
        IF NOT PV_OOSS_BATCH_HIBRIDO_PG.PV_VAL_OOSSBATCH_PEND_FN(EV_cod_ooss,EN_cod_cliente,SN_p_filasafectas,SN_p_retornora,SN_p_nroevento,SV_p_vcod_retorno) THEN
                LV_cod_glosa:=CV_error_no_clasif||'-'|| CV_PACKAGE11;
                RAISE ERROR_PROCESO;
        END IF;


    BEGIN

      LV_sSql:='SELECT descripcion,tip_procesa,cod_modgener FROM ci_tiporserv ';
      LV_sSql:= LV_sSql || 'WHERE cod_os = ' || EV_cod_ooss ;

      SELECT substr(descripcion,1,30),nvl(tip_procesa,1),cod_modgener , NVL(EV_cod_actabo,cod_tipmodi)
          INTO LV_DESCRIPCION,LN_tip_procesa,LV_cod_modgener , LV_cod_tipmodi
          FROM ci_tiporserv
      WHERE cod_os =  EV_cod_ooss ;

        EXCEPTION
           WHEN NO_DATA_FOUND THEN
                LV_cod_glosa:=CV_TIPOSERV;
                RAISE ERROR_PROCESO;
        END;


    BEGIN
       LV_sSql:='SELECT des_estadoc FROM fa_intestadoc';
       LV_sSql:= LV_sSql || 'WHERE cod_aplic= ' || CV_PVA || ' and cod_estadoc = ' || CN_10;

       SELECT des_estadoc
           INTO LV_des_estadoc
           FROM fa_intestadoc
      WHERE cod_aplic=CV_PVA  and cod_estadoc = CN_10;

        EXCEPTION
           WHEN NO_DATA_FOUND THEN
                LV_cod_glosa:=CV_INTESTADOC;
                RAISE ERROR_PROCESO;
        END;


  LV_sSql:='PV_OOSS_BATCH_HIBRIDO_PG.PV_INS_IORSERV_FN(LN_secuencia,EV_cod_ooss,LV_DESCRIPCION,CN_1,EV_usuario,LN_tip_procesa,LV_cod_modgener,LV_FechProg,EV_TSUBJETO,EV_SUJETO,NULL,NULL,EV_MODULO,EN_NumTar,SN_p_filasafectas,SN_p_retornora,SN_p_nroevento,SV_p_vcod_retorno)';
  IF PV_OOSS_BATCH_HIBRIDO_PG.PV_INS_IORSERV_FN(LN_secuencia,EV_cod_ooss,LV_DESCRIPCION,CN_1,EV_usuario,LN_tip_procesa,LV_cod_modgener,LV_FechProg,EV_TSUBJETO,EV_SUJETO,NULL,NULL,EV_MODULO,EN_NumTar,SN_p_filasafectas,SN_p_retornora,SN_p_nroevento,SV_p_vcod_retorno) THEN

     LV_sSql:= 'PV_OOSS_BATCH_HIBRIDO_PG.PV_INS_ERECORRIDO_FN(LN_secuencia,LV_DESCRIPCION,SN_p_filasafectas,SN_p_retornora,SN_p_nroevento,SV_p_vcod_retorno)';
     IF PV_OOSS_BATCH_HIBRIDO_PG.PV_INS_ERECORRIDO_FN(LN_secuencia,LV_DESCRIPCION,SN_p_filasafectas,SN_p_retornora,SN_p_nroevento,SV_p_vcod_retorno) THEN

        LV_sSql:= 'PV_OOSS_BATCH_HIBRIDO_PG.PV_INS_MOVIMIENTOS_FN(LN_secuencia,LV_cod_tipmodi,CN_1 ,SN_p_filasafectas,SN_p_retornora,SN_p_nroevento,SV_p_vcod_retorno)';
        IF PV_OOSS_BATCH_HIBRIDO_PG.PV_INS_MOVIMIENTOS_FN(LN_secuencia,LV_cod_tipmodi,CN_1 ,EN_carga,SN_p_filasafectas,SN_p_retornora,SN_p_nroevento,SV_p_vcod_retorno) THEN

               LV_sSql:= 'PV_OOSS_BATCH_HIBRIDO_PG.PV_INS_CAMCOM_FN(LN_secuencia,EN_num_celular ,EN_cod_cliente,EN_cod_cuenta,EV_bdatos,EN_num_venta,LV_cod_tipmodi,LV_FechProg,SN_p_filasafectas,SN_p_retornora,SN_p_nroevento,SV_p_vcod_retorno)';
           IF PV_OOSS_BATCH_HIBRIDO_PG.PV_INS_CAMCOM_FN(LN_secuencia,EN_num_celular ,EN_cod_cliente,EN_cod_cuenta,EV_bdatos,EN_num_venta,LV_cod_tipmodi,LV_FechProg,EN_num_abonado,SN_p_filasafectas,SN_p_retornora,SN_p_nroevento,SV_p_vcod_retorno) THEN

                      LV_sSql:= 'PV_OOSS_BATCH_HIBRIDO_PG.PV_INS_PARAM_ABOCEL_FN(LN_secuencia,EN_num_abonado,LV_cod_tipmodi,EV_usuario,EN_num_celular,EV_tip_plantarif,EV_cod_plantarif,EV_tip_plantarif_nue,EV_cod_plantarif_nue,LV_FechProg,SN_p_filasafectas,SN_p_retornora,SN_p_nroevento,SV_p_vcod_retorno)';
              IF NOT PV_OOSS_BATCH_HIBRIDO_PG.PV_INS_PARAM_ABOCEL_FN(LN_secuencia,EN_num_abonado,LV_cod_tipmodi,EV_usuario,EN_num_celular,EV_tip_plantarif,EV_cod_plantarif,LV_FechProg,SN_p_filasafectas,SN_p_retornora,SN_p_nroevento,SV_p_vcod_retorno) THEN
                             LV_cod_glosa:=CV_INS_PARAM_ABO;
                             RAISE ERROR_PROCESO;
                          ELSE
                              LV_sSql:= 'PV_OOSS_BATCH_HIBRIDO_PG.PV_INS_PROG_FN(LN_secuencia,LV_FechProg,EV_usuario,SN_p_filasafectas,SN_p_retornora,SN_p_nroevento,SV_p_vcod_retorno)';
                              IF NOT PV_OOSS_BATCH_HIBRIDO_PG.PV_INS_PROG_FN(LN_secuencia,LV_FechProg,EV_usuario,SN_p_filasafectas,SN_p_retornora,SN_p_nroevento,SV_p_vcod_retorno) THEN
                                 LV_cod_glosa:= CV_INS_PROG;
                                 RAISE ERROR_PROCESO;
                          ELSE
                                 LV_sSql:= 'PV_OOSS_BATCH_HIBRIDO_PG.PV_UPD_IORSERV_FN(LN_secuencia,CV_PROCESOEXI,SN_p_filasafectas,SN_p_retornora,SN_p_nroevento,SV_p_vcod_retorno)';
                                 IF NOT PV_OOSS_BATCH_HIBRIDO_PG.PV_UPD_IORSERV_FN(LN_secuencia,CV_PROCESOEXI,SN_p_filasafectas,SN_p_retornora,SN_p_nroevento,SV_p_vcod_retorno) THEN
                                        LV_cod_glosa:=CV_UPD_IORSERV;
                                    RAISE ERROR_PROCESO;
                                     ELSE
                                        LV_sSql:= 'PV_OOSS_BATCH_HIBRIDO_PG.PV_UPD_ERECORRIDO_FN(LN_secuencia,LV_des_estadoc,SN_p_filasafectas,SN_p_retornora,SN_p_nroevento,SV_p_vcod_retorno)';
                                        IF NOT PV_OOSS_BATCH_HIBRIDO_PG.PV_UPD_ERECORRIDO_FN(LN_secuencia,LV_des_estadoc,SN_p_filasafectas,SN_p_retornora,SN_p_nroevento,SV_p_vcod_retorno)  THEN
                                               LV_cod_glosa:=CV_UPD_ERECORRIDO;
                                       RAISE ERROR_PROCESO;
                                            END IF;
                                     END IF;
                                   END IF;
                          END IF;
                   ELSE
                      LV_cod_glosa:=CV_INS_CAMCOM;
                      RAISE ERROR_PROCESO;
                   END IF;
                ELSE
                   LV_cod_glosa:=CV_INS_MOVI;
                   RAISE ERROR_PROCESO;
                END IF;
        ELSE
            LV_cod_glosa:=CV_INS_ERECO;
                RAISE ERROR_PROCESO;
        END IF;
  ELSE
      LV_cod_glosa:=CV_INS_IORSERV;
      RAISE ERROR_PROCESO;
  END IF;

   INSERT INTO GA_TRANSACABO
   (NUM_TRANSACCION, COD_RETORNO,DES_CADENA)
   VALUES
   (EN_TRANSACABO ,CN_0 ,'existoso');

EXCEPTION

  WHEN ERROR_PROCESO THEN
           SV_p_vcod_retorno:= CN_4;
           lv_cadena :=SUBSTR(SQLERRM,1,255);
           INSERT INTO GA_TRANSACABO
       (NUM_TRANSACCION, COD_RETORNO,DES_CADENA)
       VALUES
       (EN_TRANSACABO ,CN_4 , lv_cadena );


           GN_EVENTO        := GE_ERRORES_PG.GRABARPL(CN_0,CV_PV,LV_cod_glosa,CV_1, USER, CV_PACKAGE, LV_sSql, sqlcode, SQLERRM);

  WHEN OTHERS THEN
           SV_p_vcod_retorno:=CN_4;
              lv_cadena :=LV_cod_glosa;
           INSERT INTO GA_TRANSACABO
       (NUM_TRANSACCION, COD_RETORNO, DES_CADENA)
       VALUES
       (EN_TRANSACABO ,CN_4 ,lv_cadena);

           LV_cod_glosa:=CV_error_no_clasif ;
           GN_EVENTO        := GE_ERRORES_PG.GRABARPL(CN_0,CV_PV,LV_cod_glosa,CV_1, USER, CV_PACKAGE, LV_sSql, sqlcode, SQLERRM);


END PV_INSCRIBE_OOSS_PR;


END PV_OOSS_BATCH_HIBRIDO_PG;
/
SHOW ERRORS
