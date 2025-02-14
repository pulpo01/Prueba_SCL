CREATE OR REPLACE PACKAGE BODY PV_DATOS_ABONADO_PG AS

------------------------------------------------------------------------------------------------------
FUNCTION PV_VALIDA_NUMERO_ABONADO_FN(EN_NUM_ABONADO   IN     GA_ABOCEL.NUM_ABONADO%TYPE,
         SN_cod_retorno      OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
         SV_mens_retorno     OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
         SN_num_evento       OUT NOCOPY  ge_errores_pg.evento)
RETURN BOOLEAN
IS
--V1.1 INC 157087 GUA JRCH 31-12-2010 se modifica proc PV_GENERA_SOLICMIGRAR_PR
/*
 <Documentación
   TipoDoc = "Procedure">>
    <Elemento
       Nombre = "PV_VALIDA_NUMERO_ABONADO_FN"
           Lenguaje="PL/SQL"
       Fecha="13-06-2007"
       Versión="La del package"
       Diseñador="Andrés Osorio"
       Programador="Andrés Osorio"
       Ambiente Desarrollo="BD">
       <Retorno>N/A</Retorno>>
       <Descripción></Descripción>>
       <Parámetros>
          <Entrada>
             <param nom="EO_ABOAMIST.NUM_ABONADO" Tipo="estructura">Estructura de datos Numero Abonado </param>>
          </Entrada>
          <Salida>
             <param nom="SN_cod_retorno" Tipo="NUMERICO">Codigo de Retorno</param>>
             <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>>
             <param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>>
          </Salida>
       </Parámetros>
    </Elemento>
 </Documentación>
*/
        LV_des_error    ge_errores_pg.DesEvent;
        LV_sSql      ge_errores_pg.vQuery;
        LN_ABOCEL        NUMBER;
        LN_ABOAMIST      NUMBER;

BEGIN
        sn_cod_retorno  := 0;
        sv_mens_retorno := NULL;
        sn_num_evento  := 0;

        LV_sSql := 'SELECT COUNT(0) FROM GA_ABOCEL WHERE NUM_ABONADO = '||EN_NUM_ABONADO;

        SELECT COUNT(0)
        INTO   LN_ABOCEL
        FROM GA_ABOCEL
        WHERE NUM_ABONADO = EN_NUM_ABONADO;

        LV_sSql := 'SELECT COUNT(0) FROM GA_ABOAMIST WHERE NUM_ABONADO = '||EN_NUM_ABONADO;

        SELECT COUNT(0)
        INTO   LN_ABOAMIST
        FROM GA_ABOAMIST
        WHERE NUM_ABONADO = EN_NUM_ABONADO;

        IF ((LN_ABOCEL + LN_ABOAMIST) >= 1) THEN
           RETURN TRUE;
        ELSE
                RETURN FALSE;
        END IF;

EXCEPTION
   WHEN OTHERS THEN
       SN_cod_retorno := 156;
       IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := CV_error_no_clasif;
       END IF;
       LV_des_error   := ' PV_VALIDA_NUMERO_ABONADO_FN('||EN_NUM_ABONADO||'); '||SQLERRM;
       SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_DATOS_ABONADO_PG.PV_VALIDA_NUMERO_ABONADO_FN', LV_sSQL, SN_cod_retorno, LV_des_error );
           RETURN FALSE;

END PV_VALIDA_NUMERO_ABONADO_FN;
------------------------------------------------------------------------------------------------------
PROCEDURE PV_ACTUAL_GA_ABOAMIST_PR (EO_ABOAMIST   IN     GA_ABOAMIST_QT,
         SN_cod_retorno      OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
         SV_mens_retorno     OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
         SN_num_evento       OUT NOCOPY  ge_errores_pg.evento)
IS
/*
 <Documentación
   TipoDoc = "Procedure">>
    <Elemento
       Nombre = "PV_ACTUAL_GA_ABOAMIST_PR "
       Lenguaje="PL/SQL"
       Fecha="13-06-2007"
       Versión="La del package"
       Diseñador=""
       Programador="cec "
       Ambiente Desarrollo="BD">
       <Retorno>N/A</Retorno>>
       <Descripción></Descripción>>
       <Parámetros>
          <Entrada>
             <param nom="EO_ABOAMIST.NUM_ABONADO" Tipo="estructura">Estructura de datos Numero Abonado </param>>
          </Entrada>
          <Salida>
             <param nom="SN_cod_retorno" Tipo="NUMERICO">Codigo de Retorno</param>>
             <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>>
             <param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>>
          </Salida>
       </Parámetros>
    </Elemento>
 </Documentación>
*/
  LV_des_error    ge_errores_pg.DesEvent;
  LV_sSql      ge_errores_pg.vQuery;
 BEGIN
  sn_cod_retorno  := 0;
     sv_mens_retorno := NULL;
     sn_num_evento  := 0;

  LV_sSql:= 'UPDATE GA_ABOAMIST SET COD_SITUACION = '||EO_ABOAMIST.COD_SITUACION||' ,';
  LV_sSql:= LV_sSql || '            FEC_ULTMOD =  '||EO_ABOAMIST.FEC_ULTMOD ||' ';
  LV_sSql:= LV_sSql || ' WHERE NUM_ABONADO = '||EO_ABOAMIST.NUM_ABONADO||'; ';

  UPDATE GA_ABOAMIST
  SET  COD_SITUACION = EO_ABOAMIST.COD_SITUACION,
           FEC_ULTMOD    = EO_ABOAMIST.FEC_ULTMOD
  WHERE NUM_ABONADO  = EO_ABOAMIST.NUM_ABONADO;

 EXCEPTION
   WHEN OTHERS THEN
       SN_cod_retorno := 156;
       IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := CV_error_no_clasif;
       END IF;
    LV_des_error   := ' PV_ACTUAL_GA_ABOAMIST_PR ('||EO_ABOAMIST.NUM_ABONADO||'); '||SQLERRM;
       SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_DATOS_ABONADO_PG.PV_ACTUAL_GA_ABOAMIST_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

END PV_ACTUAL_GA_ABOAMIST_PR;

------------------------------------------------------------------------------------------------------
PROCEDURE PV_ACTUALIZA_SITUA_ABONADO_PR(EO_ABOAMIST   IN     GA_ABOAMIST_QT,
             SN_cod_retorno      OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
             SV_mens_retorno     OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
             SN_num_evento       OUT NOCOPY  ge_errores_pg.evento)

IS
/*
 <Documentación
   TipoDoc = "Procedure">>
    <Elemento
       Nombre = "PV_ACTUALIZA_SITUA_ABONADO_PR "
       Lenguaje="PL/SQL"
       Fecha="13-06-2007"
       Versión="La del package"
       Diseñador=""
       Programador="Elizabeth Vera"
       Ambiente Desarrollo="BD">
       <Retorno>N/A</Retorno>>
       <Descripción></Descripción>>
       <Parámetros>
          <Entrada>
             <param nom="EO_ABONADO.NUM:ABONADO" Tipo="estructura">Estructura de datos Numero del Abonado             </param>>
          </Entrada>
          <Salida>
             <param nom="SN_cod_retorno" Tipo="NUMERICO">Codigo de Retorno</param>>
             <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>>
             <param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>>
          </Salida>
       </Parámetros>
    </Elemento>
 </Documentación>
 */
  LV_des_error    ge_errores_pg.DesEvent;
  LV_sSql      ge_errores_pg.vQuery;
  ERROR_EJECUCION    EXCEPTION;
 BEGIN
  sn_cod_retorno  := 0;
     sv_mens_retorno := NULL;
     sn_num_evento  := 0;

  PV_DATOS_ABONADO_PG.PV_ACTUAL_GA_ABOAMIST_PR (EO_ABOAMIST, SN_cod_retorno, SV_mens_retorno, SN_num_evento);
  IF SN_cod_retorno>0 THEN
          RAISE ERROR_EJECUCION;
  END IF;

 EXCEPTION
 WHEN ERROR_EJECUCION THEN
    LV_des_error   := ' PV_ACTUALIZA_SITUA_ABONADO_PR('||to_char(EO_ABOAMIST.NUM_ABONADO)||'); '||SQLERRM;
       SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_DATOS_ABONADO_PG.PV_ACTUALIZA_SITUA_ABONADO_PR', LV_sSQL, SN_cod_retorno, LV_des_error );
   WHEN OTHERS THEN
       SN_cod_retorno := 156;
       IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := CV_error_no_clasif;
       END IF;
    LV_des_error   := ' PV_ACTUALIZA_SITUA_ABONADO_PR('||to_char(EO_ABOAMIST.NUM_ABONADO)||'); '||SQLERRM;
       SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_DATOS_ABONADO_PG.PV_ACTUALIZA_SITUA_ABONADO_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

END PV_ACTUALIZA_SITUA_ABONADO_PR;

------------------------------------------------------------------------------------------------------
PROCEDURE PV_CNT_GA_INTARCEL_ACCI_PR(EO_GA_INTARCEL    IN OUT  NOCOPY PV_GA_INTARCEL_QT,
                SN_cod_retorno       OUT  NOCOPY   ge_errores_td.cod_msgerror%TYPE,
                SV_mens_retorno      OUT  NOCOPY   ge_errores_td.det_msgerror%TYPE,
                SN_num_evento        OUT  NOCOPY ge_errores_pg.evento)
IS
/*
 <Documentación
   TipoDoc = "Procedure">>
    <Elemento
       Nombre = "PV_CNT_GA_INTARCEL_ACCI_PR "
       Lenguaje="PL/SQL"
       Fecha="13-06-2007"
       Versión="La del package"
       Diseñador=""
       Programador="cec "
       Ambiente Desarrollo="BD">
       <Retorno>N/A</Retorno>>
       <Descripción></Descripción>>
       <Parámetros>
          <Entrada>
             <param nom="EO_GA_INTARCEL.NUM:COD_CLIENTE" Tipo="estructura">Estructura de datos Numero del Abonado  </param>>
             <param nom="EO_GA_INTARCEL.NUM:ABONADO"    Tipo="estructura">Estructura de datos Numero del Abonado   </param>>
          </Entrada>
          <Salida>
             <param nom="SN_cod_retorno" Tipo="NUMERICO">Codigo de Retorno</param>>
             <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>>
             <param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>>
          </Salida>
       </Parámetros>
    </Elemento>
 </Documentación>
*/
  LV_des_error       ge_errores_pg.DesEvent;
  LV_sSql         ge_errores_pg.vQuery;
  EO_GED_PARAMETROS     PV_GED_PARAMETROS_QT;
  BEGIN
   SN_cod_retorno  := 0;
   SN_num_evento   := 0;
      SV_mens_retorno := NULL;

   LV_sSql:= 'SELECT COUNT(1) INTO '|| EO_GA_INTARCEL.CNT_GA_INTARCEL_ACC ||' ';
   LV_sSql:= LV_sSql || '  FROM GA_INTARCEL_ACCIONES_TO  ';
   LV_sSql:= LV_sSql || '  WHERE  COD_CLIENTE =' || EO_GA_INTARCEL.COD_CLIENTE || ' ';
   LV_sSql:= LV_sSql || '  AND    NUM_ABONADO =' || EO_GA_INTARCEL.NUM_ABONADO || ' ';
   LV_sSql:= LV_sSql || '  AND     COD_ACTABO  = DECODE(COD_ACTABO,'||Chr(39)||'IH'||chr(39)||','||chr(39)||'BA'||chr(39)||','||chr(39)||'CT'||chr(39)||' ) ';

   SELECT COUNT(1) INTO   EO_GA_INTARCEL.CNT_GA_INTARCEL_ACC
   FROM GA_INTARCEL_ACCIONES_TO
   WHERE  COD_CLIENTE = EO_GA_INTARCEL.COD_CLIENTE
      AND    NUM_ABONADO = EO_GA_INTARCEL.NUM_ABONADO
   AND   COD_ACTABO = DECODE(COD_ACTABO,'IH','BA','CT');

 EXCEPTION
   WHEN OTHERS THEN
       SN_cod_retorno := 156;
       IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := CV_error_no_clasif;
       END IF;
    LV_des_error   := ' PV_CNT_GA_INTARCEL_ACCI_PR('||EO_GA_INTARCEL.COD_CLIENTE||'); '||SQLERRM;
       SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_DATOS_ABONADO_PG.PV_CNT_GA_INTARCEL_ACCI_PR', LV_sSQL, SN_cod_retorno, LV_des_error );
END  PV_CNT_GA_INTARCEL_ACCI_PR;

-----------------------------------------------------------------------------------------------------
PROCEDURE PV_INSERT_GA_INTARCEL_ACC_PR (EO_GA_INTARCEL        IN OUT NOCOPY   PV_GA_INTARCEL_QT,
               Reg_ga_intarcel_acciones_to  IN OUT NOCOPY    PV_TIPOS_PG.R_GA_INTARCEL_ACCIONES_TO,
             SN_cod_retorno            OUT NOCOPY    ge_errores_td.cod_msgerror%TYPE,
             SV_mens_retorno           OUT NOCOPY    ge_errores_td.det_msgerror%TYPE,
             SN_num_evento             OUT NOCOPY   ge_errores_pg.evento)
IS
/*
 <Documentación
   TipoDoc = "Procedure">>
    <Elemento
       Nombre = "PV_INSERT_GA_INTARCEL_ACC_PR "
       Lenguaje="PL/SQL"
       Fecha="13-06-2007"
       Versión="La del package"
       Diseñador=""
       Programador="cec "
       Ambiente Desarrollo="BD">
       <Retorno>N/A</Retorno>>
       <Descripción></Descripción>>
       <Parámetros>
          <Entrada>
             <param nom="Reg_ga_intarcel_acciones_to(1) " Tipo="estructura">Estructura de datos Numero  </param>>
          </Entrada>
          <Salida>
             <param nom="SN_cod_retorno" Tipo="NUMERICO">Codigo de Retorno</param>>
             <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>>
             <param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>>
          </Salida>
       </Parámetros>
    </Elemento>
 </Documentación>
*/
  LV_des_error    ge_errores_pg.DesEvent;
  LV_sSql      ge_errores_pg.vQuery;
    BEGIN
  sn_cod_retorno  := 0;
     sv_mens_retorno := NULL;
     sn_num_evento  := 0;

  Reg_ga_intarcel_acciones_to(1).COD_CLIENTE   := EO_GA_INTARCEL.COD_CLIENTE;
  Reg_ga_intarcel_acciones_to(1).NUM_ABONADO   := EO_GA_INTARCEL.NUM_ABONADO;
  Reg_ga_intarcel_acciones_to(1).IND_NUMERO    := 0;
  Reg_ga_intarcel_acciones_to(1).FEC_DESDE     := SYSDATE;

  Select Decode(EO_GA_INTARCEL.COD_ACTABO,'IH','BA','CT') into Reg_ga_intarcel_acciones_to(1).COD_ACTABO from dual;
  Reg_ga_intarcel_acciones_to(1).NOM_USUARORA  := USER;
  Reg_ga_intarcel_acciones_to(1).FEC_INGRESO   := SYSDATE;

     LV_sSql:=LV_sSql||'INSERT INTO ga_intarcel_acciones_to  VALUES (';
  LV_sSql:=LV_sSql|| Reg_ga_intarcel_acciones_to(1).COD_CLIENTE||', ';
  LV_sSql:=LV_sSql|| Reg_ga_intarcel_acciones_to(1).NUM_ABONADO||', ';
  LV_sSql:=LV_sSql|| Reg_ga_intarcel_acciones_to(1).IND_NUMERO ||', ';
  LV_sSql:=LV_sSql|| Reg_ga_intarcel_acciones_to(1).FEC_DESDE   ||',';
  LV_sSql:=LV_sSql|| Reg_ga_intarcel_acciones_to(1).COD_ACTABO  ||',';
  LV_sSql:=LV_sSql|| Reg_ga_intarcel_acciones_to(1).NOM_USUARORA||',';
  LV_sSql:=LV_sSql|| Reg_ga_intarcel_acciones_to(1).FEC_INGRESO ||') ';

  FORALL I IN Reg_ga_intarcel_acciones_to.FIRST .. Reg_ga_intarcel_acciones_to.LAST
  INSERT INTO ga_intarcel_acciones_to  VALUES Reg_ga_intarcel_acciones_to(i);

 EXCEPTION
   WHEN OTHERS THEN
       SN_cod_retorno := 4;
       IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := CV_error_no_clasif;
       END IF;
    LV_des_error   := ' PV_INSERT_GA_INTARCEL_ACC_PR(''); '||SQLERRM;
       SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_DATOS_ABONADO_PG.PV_INSERT_GA_INTARCEL_ACC_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

END PV_INSERT_GA_INTARCEL_ACC_PR;

------------------------------------------------------------------------------------------------------
PROCEDURE PV_ACTUALIZA_INTARCEL_ACC_PR(EO_GA_INTARCEL     IN  OUT NOCOPY  PV_GA_INTARCEL_QT,
            SN_cod_retorno        OUT NOCOPY   ge_errores_td.cod_msgerror%TYPE,
            SV_mens_retorno       OUT NOCOPY   ge_errores_td.det_msgerror%TYPE,
            SN_num_evento         OUT NOCOPY  ge_errores_pg.evento)
IS
/*
 <Documentación
   TipoDoc = "Procedure">>
    <Elemento
       Nombre = "PV_ACTUALIZA_INTARCEL_ACC_PR  "
       Lenguaje="PL/SQL"
       Fecha="13-06-2007"
       Versión="La del package"
       Diseñador=""
       Programador="cec "
       Ambiente Desarrollo="BD">
       <Retorno>N/A</Retorno>>
       <Descripción></Descripción>>
       <Parámetros>
          <Entrada>
             <param nom="REO_GA_INTARCEL" Tipo="estructura">Estructura de datos Numero  </param>>
          </Entrada>
          <Salida>
             <param nom="SN_cod_retorno" Tipo="NUMERICO">Codigo de Retorno</param>>
             <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>>
             <param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>>
          </Salida>
       </Parámetros>
    </Elemento>
 </Documentación>
*/
  LV_des_error             ge_errores_pg.DesEvent;
  LV_sSql            ge_errores_pg.vQuery;
  ERROR_EJECUCION            EXCEPTION;
  Reg_ga_intarcel_acciones_to     PV_TIPOS_PG.R_GA_INTARCEL_ACCIONES_TO;
 BEGIN
  sn_cod_retorno  := 0;
     sv_mens_retorno := NULL;
     sn_num_evento  := 0;

  EO_GA_INTARCEL.NUM_ABONADO        := EO_GA_INTARCEL.NUM_ABONADO;
  EO_GA_INTARCEL.COD_CLIENTE        := EO_GA_INTARCEL.COD_CLIENTE;
  EO_GA_INTARCEL.CNT_GA_INTARCEL_ACC:= 0;
  PV_DATOS_ABONADO_PG.PV_CNT_GA_INTARCEL_ACCI_PR (EO_GA_INTARCEL,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
  IF SN_cod_retorno > 0 THEN
     RAISE ERROR_EJECUCION;
  END IF;

  IF  EO_GA_INTARCEL.CNT_GA_INTARCEL_ACC = 0 THEN
    EO_GA_INTARCEL.NUM_ABONADO        := EO_GA_INTARCEL.NUM_ABONADO;
    EO_GA_INTARCEL.COD_CLIENTE        := EO_GA_INTARCEL.COD_CLIENTE;
    PV_DATOS_ABONADO_PG.PV_INSERT_GA_INTARCEL_ACC_PR (EO_GA_INTARCEL,Reg_ga_intarcel_acciones_to,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
    IF SN_cod_retorno > 0 THEN
      RAISE ERROR_EJECUCION;
    END IF;
  END IF;
 EXCEPTION
 WHEN ERROR_EJECUCION THEN
    LV_des_error   := 'PV_ACTUALIZA_INTARCEL_ACC_PR('||TO_CHAR(EO_GA_INTARCEL.NUM_ABONADO)||'.'||EO_GA_INTARCEL.COD_CLIENTE||'); '||SQLERRM;
       SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_DATOS_ABONADO_PG.PV_ACTUALIZA_INTARCEL_ACC_PR', LV_sSQL, SN_cod_retorno, LV_des_error );
 WHEN NO_DATA_FOUND THEN
       SN_cod_retorno := 149;
       IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := CV_error_no_clasif;
       END IF;
    LV_des_error   := 'PV_ACTUALIZA_INTARCEL_ACC_PR('||TO_CHAR(EO_GA_INTARCEL.NUM_ABONADO)||'.'||EO_GA_INTARCEL.COD_CLIENTE||'); '||SQLERRM;
       SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_DATOS_ABONADO_PG.PV_ACTUALIZA_INTARCEL_ACC_PR', LV_sSQL, SN_cod_retorno, LV_des_error );
   WHEN OTHERS THEN
       SN_cod_retorno := 156;
       IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := CV_error_no_clasif;
       END IF;
    LV_des_error   := 'PV_ACTUALIZA_INTARCEL_ACC_PR('||TO_CHAR(EO_GA_INTARCEL.NUM_ABONADO)||'.'||EO_GA_INTARCEL.COD_CLIENTE||'); '||SQLERRM;
       SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_DATOS_ABONADO_PG.PV_ACTUALIZA_INTARCEL_ACC_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

END PV_ACTUALIZA_INTARCEL_ACC_PR;

------------------------------------------------------------------------------------------------------
PROCEDURE PV_GA_INTARCEL_DEL_PR (EO_GA_INTARCEL   IN OUT     PV_GA_INTARCEL_QT,
         Reg_ga_intarcel  IN       PV_TIPOS_PG.R_GA_INTARCEL,
         SN_cod_retorno      OUT NOCOPY    ge_errores_td.cod_msgerror%TYPE,
         SV_mens_retorno     OUT NOCOPY    ge_errores_td.det_msgerror%TYPE,
         SN_num_evento       OUT NOCOPY    ge_errores_pg.evento)
IS
/*
 <Documentación
   TipoDoc = "Procedure">>
    <Elemento
       Nombre = "PV_GA_INTARCEL_DEL_PR   "
       Lenguaje="PL/SQL"
       Fecha="13-06-2007"
       Versión="La del package"
       Diseñador=""
       Programador="cec "
       Ambiente Desarrollo="BD">
       <Retorno>N/A</Retorno>>
       <Descripción></Descripción>>
       <Parámetros>
          <Entrada>
             <param nom="EO_GA_INTARCEL"   Tipo="estructura">Estructura de datos Type                   </param>>
             <param nom="Reg_ga_intarcel"  Tipo="estructura">Estructura de datos Record : PV_TIPOS_PG.R_GA_INTARCEL  </param>>
          </Entrada>
          <Salida>
             <param nom="SN_cod_retorno" Tipo="NUMERICO">Codigo de Retorno</param>>
             <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>>
             <param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>>
          </Salida>
       </Parámetros>
    </Elemento>
 </Documentación>
*/
  LV_des_error    ge_errores_pg.DesEvent;
  LV_sSql      ge_errores_pg.vQuery;
    BEGIN
    LV_sSql:='FOR i IN Reg_ga_intarcel.FIRST .. Reg_ga_intarcel.LAST LOOP  ';
    LV_sSql:=LV_sSql||'DELETE ga_intarcel    ';
    LV_sSql:=LV_sSql||'WHERE                 ';
    LV_sSql:=LV_sSql||'    COD_CLIENTE = '||to_char(Reg_ga_intarcel(1).COD_CLIENTE)||'    ';
    LV_sSql:=LV_sSql||'AND NUM_ABONADO = '||to_char(Reg_ga_intarcel(1).NUM_ABONADO)||'    ';
    LV_sSql:=LV_sSql||'AND IND_NUMERO  = '||to_char(Reg_ga_intarcel(1).IND_NUMERO) ||'    ';
    LV_sSql:=LV_sSql||'AND FEC_DESDE   = '||Reg_ga_intarcel(1).FEC_DESDE           ||';   ';

   FOR i IN Reg_ga_intarcel.FIRST .. Reg_ga_intarcel.LAST LOOP
    DELETE ga_intarcel
    WHERE
    COD_CLIENTE = Reg_ga_intarcel(i).COD_CLIENTE
    AND    NUM_ABONADO = Reg_ga_intarcel(i).NUM_ABONADO
    AND    IND_NUMERO  = Reg_ga_intarcel(i).IND_NUMERO
    AND    FEC_DESDE   = Reg_ga_intarcel(i).FEC_DESDE;
   END LOOP;

 EXCEPTION
   WHEN OTHERS THEN
       SN_cod_retorno := 4;
       IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := CV_error_no_clasif;
       END IF;
    LV_des_error   := ' PV_GA_INTARCEL_DEL_PR('||Reg_ga_intarcel(1).NUM_ABONADO||'); '||SQLERRM;
       SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_DATOS_ABONADO_PG.PV_GA_INTARCEL_DEL_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

END PV_GA_INTARCEL_DEL_PR;

------------------------------------------------------------------------------------------------------
PROCEDURE PV_GA_INTARCEL_ACT_PR (EO_GA_INTARCEL   IN OUT      PV_GA_INTARCEL_QT,
         Reg_ga_intarcel  IN        PV_TIPOS_PG.R_GA_INTARCEL,
         SN_cod_retorno      OUT NOCOPY     ge_errores_td.cod_msgerror%TYPE,
         SV_mens_retorno     OUT NOCOPY     ge_errores_td.det_msgerror%TYPE,
         SN_num_evento       OUT NOCOPY  ge_errores_pg.evento)
IS
/*
 <Documentación
   TipoDoc = "Procedure">>
    <Elemento
       Nombre = "PV_GA_INTARCEL_ACT_PR   "
       Lenguaje="PL/SQL"
       Fecha="13-06-2007"
       Versión="La del package"
       Diseñador=""
       Programador="cec "
       Ambiente Desarrollo="BD">
       <Retorno>N/A</Retorno>>
       <Descripción></Descripción>>
       <Parámetros>
          <Entrada>
             <param nom="EO_GA_INTARCEL"   Tipo="estructura">Estructura de datos Type                   </param>>
             <param nom="Reg_ga_intarcel"  Tipo="estructura">Estructura de datos Record : PV_TIPOS_PG.R_GA_INTARCEL  </param>>
          </Entrada>
          <Salida>
             <param nom="SN_cod_retorno" Tipo="NUMERICO">Codigo de Retorno</param>>
             <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>>
             <param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>>
          </Salida>
       </Parámetros>
    </Elemento>
 </Documentación>
*/
  LV_des_error    ge_errores_pg.DesEvent;
  LV_sSql      ge_errores_pg.vQuery;
    BEGIN
   LV_sSql:='UPDATE   ga_intarcel  SET FEC_HASTA= '||Reg_ga_intarcel(1).FEC_HASTA||' ';
   LV_sSql:=LV_sSql||' WHERE  ';
   LV_sSql:=LV_sSql||'   COD_CLIENTE = '||to_char(Reg_ga_intarcel(1).COD_CLIENTE)||' ';
   LV_sSql:=LV_sSql||' AND  NUM_ABONADO = '||to_char(Reg_ga_intarcel(1).NUM_ABONADO)||' ';
   LV_sSql:=LV_sSql||' AND  SYSDATE BETWEEN FEC_DESDE AND FEC_HASTA; ';

   FOR i IN Reg_ga_intarcel.FIRST .. Reg_ga_intarcel.LAST LOOP
    UPDATE   ga_intarcel  SET FEC_HASTA= Reg_ga_intarcel(i).FEC_HASTA
    WHERE
       COD_CLIENTE = Reg_ga_intarcel(i).COD_CLIENTE
    AND   NUM_ABONADO = Reg_ga_intarcel(i).NUM_ABONADO
    AND   SYSDATE BETWEEN FEC_DESDE AND FEC_HASTA;
   END LOOP;

 EXCEPTION
   WHEN OTHERS THEN
       SN_cod_retorno := 4;
       IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := CV_error_no_clasif;
       END IF;
    LV_des_error   := ' PV_GA_INTARCEL_ACT_PR('||Reg_ga_intarcel(1).COD_CLIENTE||'); '||SQLERRM;
       SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_DATOS_ABONADO_PG.PV_GA_INTARCEL_ACT_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

END PV_GA_INTARCEL_ACT_PR;

------------------------------------------------------------------------------------------------------
PROCEDURE PV_REG_ELIM_INTARCEL_PR(EO_GA_INTARCEL     IN OUT      PV_GA_INTARCEL_QT,
             SN_cod_retorno           OUT NOCOPY       ge_errores_td.cod_msgerror%TYPE,
             SV_mens_retorno          OUT NOCOPY       ge_errores_td.det_msgerror%TYPE,
             SN_num_evento            OUT NOCOPY  ge_errores_pg.evento)
IS
  LV_des_error       ge_errores_pg.DesEvent;
  LV_sSql         ge_errores_pg.vQuery;
  ERROR_EJECUCION         EXCEPTION;
  EO_GED_PARAMETROS     PV_GED_PARAMETROS_QT;
  Reg_ga_intarcel     PV_TIPOS_PG.R_GA_INTARCEL;

 BEGIN
  sn_cod_retorno  := 0;
     sv_mens_retorno := NULL;
     sn_num_evento  := 0;


  IF EO_GA_INTARCEL.FEC_DESDE IS NOT NULL OR EO_GA_INTARCEL.FEC_DESDE <> '' THEN
   LV_sSql:='PV_INICIA_ESTRUCTURAS_PG.PV_GED_PARAMETROS_QT_FN';
         EO_GED_PARAMETROS := PV_INICIA_ESTRUCTURAS_PG.PV_GED_PARAMETROS_QT_FN;

       EO_GED_PARAMETROS.NOM_PARAMETRO := CV_gsFormato2;
    EO_GED_PARAMETROS.COD_MODULO    := 'GE';
    EO_GED_PARAMETROS.COD_PRODUCTO  := EO_GA_INTARCEL.COD_PRODUCTO;

    LV_sSql:='PV_GENERALES_PG.PV_OBTIENE_GED_PARAMETROS_PR ('||EO_GED_PARAMETROS.NOM_PARAMETRO||','||EO_GED_PARAMETROS.COD_MODULO||','||EO_GED_PARAMETROS.COD_PRODUCTO||','||SN_cod_retorno||','||SV_mens_retorno||','||SN_num_evento||')';
    PV_GENERALES_PG.PV_OBTIENE_GED_PARAMETROS_PR (EO_GED_PARAMETROS,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
    IF SN_cod_retorno>0 THEN
           RAISE ERROR_EJECUCION;
    END IF;

    Reg_ga_intarcel(1).NUM_ABONADO  := EO_GA_INTARCEL.NUM_ABONADO;
    Reg_ga_intarcel(1).COD_CLIENTE  := EO_GA_INTARCEL.COD_CLIENTE;
    Reg_ga_intarcel(1).IND_NUMERO := 0;
    Reg_ga_intarcel(1).FEC_DESDE    := EO_GA_INTARCEL.FEC_DESDE;
    EO_GA_INTARCEL.FORMATO2   :=EO_GED_PARAMETROS.VAL_PARAMETRO;

    LV_sSql:='PV_DATOS_ABONADO_PG.PV_GA_INTARCEL_DEL_PR ('||EO_GA_INTARCEL.FORMATO2||','||Reg_ga_intarcel(1).NUM_ABONADO||','||Reg_ga_intarcel(1).COD_CLIENTE||','||Reg_ga_intarcel(1).IND_NUMERO||','||Reg_ga_intarcel(1).FEC_DESDE||','||SN_cod_retorno||','||SV_mens_retorno||','||SN_num_evento||')';
    PV_DATOS_ABONADO_PG.PV_GA_INTARCEL_DEL_PR (EO_GA_INTARCEL,Reg_ga_intarcel,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
    IF SN_cod_retorno>0 THEN
     RAISE ERROR_EJECUCION;
    END IF;

       EO_GED_PARAMETROS.NOM_PARAMETRO := CV_gsFormato4;
    EO_GED_PARAMETROS.COD_MODULO    := 'GE';
    EO_GED_PARAMETROS.COD_PRODUCTO  := EO_GA_INTARCEL.COD_PRODUCTO;

    LV_sSql:='PV_GENERALES_PG.PV_OBTIENE_GED_PARAMETROS_PR ('||EO_GED_PARAMETROS.NOM_PARAMETRO||','||EO_GED_PARAMETROS.COD_MODULO||','||EO_GED_PARAMETROS.COD_PRODUCTO||','||SN_cod_retorno||','||SV_mens_retorno||','||SN_num_evento||')';
    PV_GENERALES_PG.PV_OBTIENE_GED_PARAMETROS_PR (EO_GED_PARAMETROS,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
    IF SN_cod_retorno>0 THEN
           RAISE ERROR_EJECUCION;
    END IF;

    EO_GA_INTARCEL.FEC_HASTA:=to_date('31-DEC-3000',EO_GED_PARAMETROS.VAL_PARAMETRO);
    Reg_ga_intarcel(1).NUM_ABONADO  := EO_GA_INTARCEL.NUM_ABONADO;
    Reg_ga_intarcel(1).COD_CLIENTE  := EO_GA_INTARCEL.COD_CLIENTE;
    Reg_ga_intarcel(1).FEC_DESDE    := EO_GA_INTARCEL.FEC_DESDE;
    Reg_ga_intarcel(1).FEC_HASTA := EO_GA_INTARCEL.FEC_HASTA;
    EO_GA_INTARCEL.FORMATO4   := EO_GED_PARAMETROS.VAL_PARAMETRO;

    LV_sSql:='PV_DATOS_ABONADO_PG.PV_GA_INTARCEL_ACT_PR ('||EO_GA_INTARCEL.FORMATO4||','||Reg_ga_intarcel(1).NUM_ABONADO||','||Reg_ga_intarcel(1).COD_CLIENTE||','||Reg_ga_intarcel(1).FEC_DESDE||','||Reg_ga_intarcel(1).FEC_HASTA||','||SN_cod_retorno||','||SV_mens_retorno||','||SN_num_evento||')';
    PV_DATOS_ABONADO_PG.PV_GA_INTARCEL_ACT_PR (EO_GA_INTARCEL,Reg_ga_intarcel,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
    IF SN_cod_retorno>0 THEN
     RAISE ERROR_EJECUCION;
    END IF;
   END IF;

 EXCEPTION
 WHEN ERROR_EJECUCION THEN
    LV_des_error   := 'PV_REG_ELIM_INTARCEL_PR('||EO_GA_INTARCEL.COD_CLIENTE||'.'||EO_GA_INTARCEL.COD_CLIENTE||'); '||SQLERRM;
       SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_DATOS_ABONADO_PG.PV_REG_ELIM_INTARCEL_PR', LV_sSQL, SN_cod_retorno, LV_des_error );
 WHEN NO_DATA_FOUND THEN
       SN_cod_retorno := 149;
       IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := CV_error_no_clasif;
       END IF;
    LV_des_error   := 'PV_REG_ELIM_INTARCEL_PR('||EO_GA_INTARCEL.COD_CLIENTE||'); '||SQLERRM;
       SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_DATOS_ABONADO_PG.PV_REG_ELIM_INTARCEL_PR', LV_sSQL, SN_cod_retorno, LV_des_error );
 WHEN OTHERS THEN
       SN_cod_retorno := 156;
       IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := CV_error_no_clasif;
       END IF;
    LV_des_error   := 'PV_REG_ELIM_INTARCEL_PR('||EO_GA_INTARCEL.COD_CLIENTE||'); '||SQLERRM;
       SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_DATOS_ABONADO_PG.PV_REG_ELIM_INTARCEL_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

END PV_REG_ELIM_INTARCEL_PR;

------------------------------------------------------------------------------------------------------
PROCEDURE PV_OBTIENE_FEC_DESDELLAM_PR(EO_GA_INTARCEL IN OUT NOCOPY PV_GA_INTARCEL_QT,
              SN_cod_retorno    OUT    NOCOPY   ge_errores_td.cod_msgerror%TYPE,
              SV_mens_retorno   OUT    NOCOPY   ge_errores_td.det_msgerror%TYPE,
              SN_num_evento     OUT    NOCOPY ge_errores_pg.evento)
IS
/*
 <Documentación
   TipoDoc = "Procedure">>
    <Elemento
       Nombre = "PV_OBTIENE_FEC_DESDELLAM_PR"
       Lenguaje="PL/SQL"
       Fecha="27-06-2007"
       Versión="La del package"
       Diseñador=""
       Programador="Carlos Elizondo"
       Ambiente Desarrollo="BD">
       <Retorno>N/A</Retorno>>
       <Descripción></Descripción>>
       <Parámetros>
          <Entrada>
             <param nom="GA_abonado" Tipo="estructura">estructura de los datos de un abonado</param>>
             <param nom="GA_cod_cliente" Tipo="estructura">estructura del Cod_Cliente</param>>
          </Entrada>
          <Salida>
             <param nom="SN_cod_retorno" Tipo="NUMERICO">Codigo de Retorno</param>>
             <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>>
             <param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>>
          </Salida>
       </Parámetros>
    </Elemento>
 </Documentación>
*/
  LV_des_error       ge_errores_pg.DesEvent;
  LV_sSql         ge_errores_pg.vQuery;
  EO_GED_PARAMETROS     PV_GED_PARAMETROS_QT;
  BEGIN
   SN_cod_retorno  := 0;
   SN_num_evento   := 0;
      SV_mens_retorno := NULL;

   LV_sSql:= 'SELECT  FEC_DESDELLAM ';
   LV_sSql:= LV_sSql||'INTO    EO_GA_INTARCEL.FEC_DESDE ';
   LV_sSql:= LV_sSql||'FROM    GA_FINCICLO  ';
   LV_sSql:= LV_sSql||'WHERE  COD_CLIENTE ='||EO_GA_INTARCEL.COD_CLIENTE||' ';
   LV_sSql:= LV_sSql||'AND    NUM_ABONADO ='||EO_GA_INTARCEL.NUM_ABONADO||' ';
   LV_sSql:= LV_sSql||'AND    COD_PLANTARIF IS NOT NULL; ';

   SELECT  FEC_DESDELLAM
   INTO    EO_GA_INTARCEL.FEC_DESDE
   FROM    GA_FINCICLO
   WHERE  COD_CLIENTE = EO_GA_INTARCEL.COD_CLIENTE
   AND    NUM_ABONADO = EO_GA_INTARCEL.NUM_ABONADO
   AND    COD_PLANTARIF IS NOT NULL;

 EXCEPTION
 WHEN NO_DATA_FOUND THEN
       SN_cod_retorno := null;
    EO_GA_INTARCEL.FEC_DESDE:= null;
       SV_mens_retorno:= null;
   WHEN OTHERS THEN
       SN_cod_retorno := 156;
       IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := CV_error_no_clasif;
       END IF;
    LV_des_error   := ' PV_OBTIENE_FEC_DESDELLAM_PR('||' Tabla GA_DATOSGENER'||'); '||SQLERRM;
       SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_DATOS_ABONADO_PG.PV_OBTIENE_FEC_DESDELLAM_PR', LV_sSQL, SN_cod_retorno, LV_des_error );
    EO_GA_INTARCEL.FEC_DESDE:= null;
END  PV_OBTIENE_FEC_DESDELLAM_PR;

------------------------------------------------------------------------------------------------------
PROCEDURE PV_FEC_DESDELLAM_INTARCEL_PR(EO_GA_INTARCEL   IN OUT NOCOPY     PV_GA_INTARCEL_QT,
               SN_cod_retorno           OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
               SV_mens_retorno          OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
               SN_num_evento            OUT NOCOPY  ge_errores_pg.evento)
IS
/*
 <Documentación
   TipoDoc = "Procedure">>
    <Elemento
       Nombre = "PV_FEC_DESDELLAM_INTARCEL_PR"
       Lenguaje="PL/SQL"
       Fecha="27-06-2007"
       Versión="La del package"
       Diseñador=""
       Programador="Carlos Elizondo"
       Ambiente Desarrollo="BD">
       <Retorno>N/A</Retorno>>
       <Descripción></Descripción>>
       <Parámetros>
          <Entrada>
             <param nom="EO_GA_INTARCEL"      Tipo="estructura">estructura de los datos        </param>>
             <param nom="EO_GA_INTARCEL.NUM_ABONADO"  Tipo="estructura">estructura de los datos codigo Abonado  </param>>
             <param nom="EO_GA_INTARCEL.COD_CLIENTE"  Tipo="estructura">estructura de los datos codigo Cliente  </param>>
             <param nom="EO_GA_INTARCEL.COD_PRODUCTO" Tipo="estructura">estructura de los datos Codigo Producto </param>>
          </Entrada>
          <Salida>
             <param nom="SN_cod_retorno"  Tipo="NUMERICO">Codigo de Retorno</param>>
             <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>>
             <param nom="SN_num_evento"   Tipo="NUMERICO">Numero de Evento</param>>
          </Salida>
       </Parámetros>
    </Elemento>
 </Documentación>
*/
  LV_des_error       ge_errores_pg.DesEvent;
  LV_sSql         ge_errores_pg.vQuery;
  ERROR_EJECUCION         EXCEPTION;
  EO_GED_PARAMETROS     PV_GED_PARAMETROS_QT;
 BEGIN
  sn_cod_retorno  := 0;
     sv_mens_retorno := NULL;
     sn_num_evento  := 0;
        EO_GED_PARAMETROS := PV_INICIA_ESTRUCTURAS_PG.PV_GED_PARAMETROS_QT_FN;

  LV_sSql:='EO_GA_INTARCEL.NUM_ABONADO:='||EO_GA_INTARCEL.NUM_ABONADO||';';
  LV_sSql:=LV_sSql||'EO_GA_INTARCEL.COD_CLIENTE:='||EO_GA_INTARCEL.COD_CLIENTE||';';
  LV_sSql:=LV_sSql||'PV_DATOS_ABONADO_PG.PV_OBTIENE_FEC_DESDELLAM_PR (EO_GA_INTARCEL,'||SN_cod_retorno||','||SV_mens_retorno||','||SN_num_evento||');';

     EO_GA_INTARCEL.NUM_ABONADO:= EO_GA_INTARCEL.NUM_ABONADO;
     EO_GA_INTARCEL.COD_CLIENTE:= EO_GA_INTARCEL.COD_CLIENTE;
  PV_DATOS_ABONADO_PG.PV_OBTIENE_FEC_DESDELLAM_PR (EO_GA_INTARCEL,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
  IF SN_cod_retorno>0 THEN
   RAISE ERROR_EJECUCION;
  END IF;

 EXCEPTION
 WHEN ERROR_EJECUCION THEN
    LV_des_error   := 'PV_FEC_DESDELLAM_INTARCEL_PR('||EO_GA_INTARCEL.NUM_ABONADO||'); '||SQLERRM;
       SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_DATOS_ABONADO_PG.PV_FEC_DESDELLAM_INTARCEL_PR', LV_sSQL, SN_cod_retorno, LV_des_error );
 WHEN NO_DATA_FOUND THEN
       SN_cod_retorno := null;
    EO_GA_INTARCEL.FEC_DESDE:= null;
       SV_mens_retorno:= null;
 WHEN OTHERS THEN
       SN_cod_retorno := 156;
       IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := CV_error_no_clasif;
       END IF;
    LV_des_error   := 'PV_FEC_DESDELLAM_INTARCEL_PR('||EO_GA_INTARCEL.NUM_ABONADO||'); '||SQLERRM;
       SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_DATOS_ABONADO_PG.PV_FEC_DESDELLAM_INTARCEL_PR', LV_sSQL, SN_cod_retorno, LV_des_error );
    EO_GA_INTARCEL.FEC_DESDE:= null;

END PV_FEC_DESDELLAM_INTARCEL_PR;

------------------------------------------------------------------------------------------------------
PROCEDURE PV_OBTIENE_LISTA_ABONADOS_PR(EO_Abonado              IN       GA_ABONADO_QT,
             SO_Lista_Abonado         OUT    NOCOPY  refCursor,
               SN_cod_retorno           OUT    NOCOPY    ge_errores_td.cod_msgerror%TYPE,
               SV_mens_retorno          OUT    NOCOPY    ge_errores_td.det_msgerror%TYPE,
               SN_num_evento            OUT    NOCOPY  ge_errores_pg.evento)
IS
/*
 <Documentación
   TipoDoc = "Procedure">>
    <Elemento
       Nombre = "PV_OBTIENE_LISTA_ABONADOS_PR
       Lenguaje="PL/SQL"
       Fecha="01-06-2007"
       Versión="La del package"
       Diseñador="Matías Guajardo"
       Programador="Matías Guajardo"
       Ambiente Desarrollo="BD">
       <Retorno>N/A</Retorno>>
       <Descripción></Descripción>>
       <Parámetros>
          <Entrada>
             <param nom="EO_Abonado" Tipo="estructura">estructura de una lista de abonados</param>>
          </Entrada>
          <Salida>
             <param Cursor="SO_Lista_Abonado"   Tipo="Cursor refCursor">        </param>>
             <param nom="SN_cod_retorno"     Tipo="NUMERICO">Codigo de Retorno  </param>>
             <param nom="SV_mens_retorno"     Tipo="CARACTER">Mensaje de Retorno </param>>
             <param nom="SN_num_evento"      Tipo="NUMERICO">Numero de Evento   </param>>
          </Salida>
       </Parámetros>
    </Elemento>
 </Documentación>
*/
 LV_des_error    ge_errores_pg.DesEvent;
 LV_sSql      ge_errores_pg.vQuery;
 v_contador     number(9);
 LN_cantAbocel    NUMBER(15);
 LN_cantAboamist    NUMBER(15);
 ERROR_CONTROLADO   EXCEPTION;

  BEGIN
         SN_cod_retorno  := 0;
         SV_mens_retorno := ' ';
         SN_num_evento  := 0;

   LV_sSql:='SELECT NULL cod_cliente,NULL num_abonado ';
   LV_sSql:=LV_sSql||' NULL num_celular,NULL num_serie,NULL num_imei,NULL cod_tecnologia,NULL cod_situacion,NULL des_situacion ,NULL tip_plantarif ,NULL des_tipplantarif ,NULL cod_plantarif ,NULL des_plantarif ,NULL cod_ciclo,NULL cod_limconsumo, NULL des_limconsumo,NULL cod_tiplan ,NULL des_tiplan ,NULL cod_cargobasico,NULL cod_tipcontrato,NULL cod_modventa,NULL num_contrato,NULL cod_planserv,NULL cod_central,NULL num_venta,NULL cod_uso ,NULL fec_acepventa , NULL fec_alta,NULL fec_prorroga, NULL num_anexo,NULL cod_usuario, NULL tip_terminal,NULL num_venta,NULL imp_cargobasico,NULL cod_cuenta ,NULL cod_subcuenta ,NULL cod_vendedor,NULL cod_causa_venta,NULL fec_baja,NULL fec_bajacen,NULL fec_ultmod ,NULL cod_empresa,NULL fec_fincontra ,null ind_eqprestado,NULL flg_rango';
   LV_sSql:=LV_sSql||'  FROM DUAL WHERE ROWNUM = 0';

   OPEN SO_Lista_Abonado FOR
   SELECT NULL cod_cliente,NULL num_abonado      ,
       NULL num_celular      , NULL num_serie        ,
       NULL num_imei         , NULL cod_tecnologia   , NULL cod_situacion,
       NULL des_situacion    , NULL tip_plantarif    ,
       NULL des_tipplantarif , NULL cod_plantarif    ,
       NULL des_plantarif    , NULL cod_ciclo        ,
       NULL cod_limconsumo   , NULL des_limconsumo   ,
     NULL cod_tiplan       , NULL des_tiplan       ,
     NULL cod_cargobasico  , NULL cod_tipcontrato  ,
     NULL cod_modventa     , NULL num_contrato     ,
     NULL cod_planserv     , NULL cod_central      ,
     NULL num_venta        , NULL cod_uso          ,
     NULL fec_acepventa    , NULL fec_alta         ,
     NULL fec_prorroga     , NULL num_anexo        ,
     NULL cod_usuario      , NULL tip_terminal     ,
     NULL num_venta        , NULL imp_cargobasico  ,
     NULL cod_cuenta       , NULL cod_subcuenta    ,
     NULL cod_vendedor     , NULL cod_causa_venta  ,
     NULL fec_baja         , NULL fec_bajacen      ,
     NULL fec_ultmod       , NULL cod_empresa      ,
     NULL fec_fincontra    , NULL ind_eqprestado   ,
         NULL flg_rango            , NULL ind_disp, NULL nombre_abonado
   FROM DUAL
    WHERE ROWNUM = 0;

   LV_sSql:='SELECT  count(1) ';
   LV_sSql:=LV_sSql||' FROM ga_abocel';
   LV_sSql:=LV_sSql||' WHERE cod_cliente = '||EO_Abonado.cod_cliente;

   SELECT count(1)
   INTO LN_cantAbocel
    FROM ga_abocel
     WHERE cod_cliente = EO_Abonado.cod_cliente;

   LV_sSql:='SELECT  count(1) ';
   LV_sSql:=LV_sSql||' FROM ga_abocel';
   LV_sSql:=LV_sSql||' WHERE cod_cliente = '||EO_Abonado.cod_cliente;

   SELECT count(1)
   INTO LN_cantAboamist
    FROM ga_aboamist
     WHERE cod_cliente = EO_Abonado.cod_cliente;

   --IF LN_cantAbocel= 0 AND LN_cantAboamist= 0 THEN
     -- RAISE ERROR_CONTROLADO;
   --END IF;

   IF LN_cantAbocel > 0 THEN
    LV_sSql:='SELECT  b.cod_cliente,b.num_abonado,b.num_celular,b.num_serie,b.num_imei,b.cod_tecnologia,';
    LV_sSql:=LV_sSql||' b.cod_situacion,d.des_situacion,b.tip_plantarif,';
    LV_sSql:=LV_sSql||' DECODE(b.tip_plantarif,'||chr(39)||'E'||chr(39)||','||chr(39)||'EMPRESA'||chr(39)||','||chr(39)||'I'||chr(39)||','||chr(39)||'INDIVIDUAL'||chr(39)||') AS des_tipplantarif,';
    LV_sSql:=LV_sSql||' b.cod_plantarif,c.des_plantarif,b.cod_ciclo,c.cod_limconsumo,f.des_limconsumo,';
    LV_sSql:=LV_sSql||' c.cod_tiplan,e.des_valor AS des_tiplan,';
    LV_sSql:=LV_sSql||' c.cod_cargobasico,b.cod_tipcontrato,b.cod_modventa,';
    LV_sSql:=LV_sSql||' b.num_contrato, b.cod_planserv,b.cod_central,';
    LV_sSql:=LV_sSql||' b.num_venta,b.cod_uso,b.fec_acepventa,b.fec_alta,b.fec_prorroga,b.num_anexo,b.cod_usuario,b.tip_terminal,b.num_venta';
    LV_sSql:=LV_sSql||'  FROM ';
    LV_sSql:=LV_sSql||' ga_abocel     b, ';
    LV_sSql:=LV_sSql||' ta_plantarif  c, ';
    LV_sSql:=LV_sSql||' ga_situabo    d, ';
    LV_sSql:=LV_sSql||' ged_codigos   e, ';
    LV_sSql:=LV_sSql||' ta_limconsumo f ';
    LV_sSql:=LV_sSql||'  WHERE  b.cod_cliente      ='||EO_Abonado.cod_cliente;
    LV_sSql:=LV_sSql||'  AND b.cod_plantarif = c.cod_plantarif';
        LV_sSql:=LV_sSql||'  AND c.cod_cargobasico = g.cod_cargobasico';
        LV_sSql:=LV_sSql||'  AND g.cod_producto = '||CN_producto;
    LV_sSql:=LV_sSql||'  AND b.cod_situacion = d.cod_situacion';
    LV_sSql:=LV_sSql||'  AND e.cod_modulo = '''||CV_cod_modulo_GE||'''';
    LV_sSql:=LV_sSql||'  AND e.nom_columna   = ''COD_TIPLAN''';
    LV_sSql:=LV_sSql||'  AND e.nom_tabla     = ''TA_PLANTARIF'' ';
    LV_sSql:=LV_sSql||'  AND e.cod_valor     = c.COD_TIPLAN ';
    LV_sSql:=LV_sSql||'  AND f.cod_limconsumo = c.cod_limconsumo  ';
        LV_sSql:=LV_sSql||'  AND f.COD_PRODUCTO = '||CN_producto;
    LV_sSql:=LV_sSql||'  AND b.cod_situacion NOT IN ('||chr(39)||'BAA'||chr(39)||','||chr(39)||'BAP'||chr(39)||') ';
        LV_sSql:=LV_sSql||'  AND b.cod_usuario = u.cod_usuario';
    LV_sSql:=LV_sSql||'  AND SYSDATE BETWEEN g.fec_desde AND g.fec_hasta';
LV_sSql:=LV_sSql||'  ORDER BY b.cod_prestacion ASC'; -- CRS_197307|24-07-2013|JHA

    OPEN SO_Lista_Abonado FOR
    SELECT  b.cod_cliente,
      b.num_abonado,
      b.num_celular,
      b.num_serie,
      b.num_imei,
      b.cod_tecnologia,
      b.cod_situacion,
      d.des_situacion,
      b.tip_plantarif,
      DECODE(b.tip_plantarif,'E','EMPRESA', 'I', 'INDIVIDUAL') AS des_tipplantarif,
      b.cod_plantarif,
      c.des_plantarif,
      b.cod_ciclo,
      c.cod_limconsumo,
      f.des_limconsumo,
      c.cod_tiplan,
      DECODE(c.cod_tiplan,'1','PREPAGO', '2', 'POSPAGO', '3', 'HIBRIDO') AS des_tiplan,
      c.cod_cargobasico,
      b.cod_tipcontrato,
      b.cod_modventa,
      b.num_contrato,
      b.cod_planserv,
      b.cod_central,
      b.num_venta,
      b.cod_uso,
      b.fec_acepventa,
      b.fec_alta,
      b.fec_prorroga,
      b.num_anexo,
      b.cod_usuario,
      b.tip_terminal,
      b.num_venta,
      g.imp_cargobasico,
      b.cod_cuenta,
      b.cod_subcuenta,
      b.cod_vendedor,
      b.cod_causa_venta,
      b.fec_baja,
      b.fec_bajacen,
      b.fec_ultmod,
      b.cod_empresa,
      b.fec_fincontra,
      b.ind_eqprestado,
      c.flg_rango,
          --DECODE(b.ind_disp, NULL, -1), COL-72499|AVC|04-11-2008
                  NVL(b.ind_disp, 1),   --COL-72499|AVC|04-11-2008
          u.nom_usuario||' '||u.nom_apellido1||' '||u.nom_apellido2 as nombre_abonado
      FROM ga_abocel b,
        ta_plantarif c,
        ga_situabo d,
        ged_codigos e,
        ta_limconsumo f,
        ta_cargosbasico g,
                ga_usuarios u
      WHERE  b.cod_cliente      = EO_Abonado.cod_cliente
         AND b.cod_plantarif = c.cod_plantarif
         AND c.cod_cargobasico = g.cod_cargobasico
                 AND g.cod_producto = CN_producto
         AND b.cod_situacion = d.cod_situacion
         AND e.cod_modulo = CV_cod_modulo_GE
            AND e.nom_columna = 'COD_TIPLAN'
         AND e.nom_tabla = 'TA_PLANTARIF'
         AND e.cod_valor   = c.COD_TIPLAN
         AND f.cod_limconsumo = c.cod_limconsumo
                 AND f.COD_PRODUCTO = CN_producto
         AND b.cod_situacion NOT IN ('BAA','BAP')
                 AND b.cod_usuario = u.cod_usuario
         AND SYSDATE BETWEEN g.fec_desde AND g.fec_hasta
            ORDER BY b.cod_prestacion ASC; -- -- CRS_197307|24-07-2013|JHA
ELSE
    IF LN_cantAboamist > 0 THEN
     LV_sSql:=LV_sSql||'  SELECT b.cod_cliente,b.num_abonado,b.num_celular,b.num_serie,b.num_imei,b.cod_tecnologia,b.cod_situacion, ';
     LV_sSql:=LV_sSql||'  d.des_situacion,b.tip_plantarif, ';
     LV_sSql:=LV_sSql||'  DECODE(b.tip_plantarif,''E'',''EMPRESA'', ''I'', ''INDIVIDUAL'') AS des_tipplantarif, ';
     LV_sSql:=LV_sSql||'  b.cod_plantarif,c.des_plantarif, b.cod_ciclo, c.cod_limconsumo, f.des_limconsumo, ';
     LV_sSql:=LV_sSql||'  c.cod_tiplan,DECODE(c.cod_tiplan,''1'',''PREPAGO'', ''2'', ''POSPAGO'', ''3'', ''HIBRIDO'') AS des_tiplan,c.cod_cargobasico,b.cod_tipcontrato,b.cod_modventa, ';
     LV_sSql:=LV_sSql||'  b.num_contrato,b.cod_planserv,b.cod_central,b.num_venta,b.cod_uso, ';
     LV_sSql:=LV_sSql||'  b.fec_acepventa, b.fec_alta, null fec_prorroga,b.num_anexo,b.cod_usuario,b.tip_terminal,b.num_venta ';
         LV_sSql:=LV_sSql||'  g.imp_cargobasico,b.cod_cuenta,b.cod_subcuenta,b.cod_vendedor,b.cod_causa_venta,b.fec_baja,';
     LV_sSql:=LV_sSql||'  b.fec_bajacen,b.fec_ultmod,b.cod_empresa,b.fec_fincontra, null ind_eqprestado,c.flg_rango,DECODE(b.ind_disp, NULL, -1)';
     LV_sSql:=LV_sSql||'  FROM ';
     LV_sSql:=LV_sSql||' ga_aboamist   b, ';
     LV_sSql:=LV_sSql||' ta_plantarif  c, ';
     LV_sSql:=LV_sSql||' ga_situabo    d, ';
     LV_sSql:=LV_sSql||' ged_codigos   e, ';
     LV_sSql:=LV_sSql||' ta_limconsumo f, ta_cargosbasico g ';
     LV_sSql:=LV_sSql||' WHERE b.cod_cliente ='||EO_Abonado.cod_cliente||'';
     LV_sSql:=LV_sSql||' AND b.cod_plantarif  = c.cod_plantarif';
         LV_sSql:=LV_sSql||' AND c.cod_cargobasico = g.cod_cargobasico';
         LV_sSql:=LV_sSql||' AND g.cod_producto = '||CN_producto;
     LV_sSql:=LV_sSql||' AND b.cod_situacion  = d.cod_situacion';
     LV_sSql:=LV_sSql||' AND e.cod_modulo = '''||CV_cod_modulo_GE||'''';
     LV_sSql:=LV_sSql||'     AND e.nom_columna    = ''COD_TIPLAN''';
     LV_sSql:=LV_sSql||'     AND e.nom_tabla      = ''TA_PLANTARIF''';
     LV_sSql:=LV_sSql||'     AND e.cod_valor      = c.cod_tiplan';
     LV_sSql:=LV_sSql||' AND f.cod_limconsumo = c.cod_limconsumo';
         LV_sSql:=LV_sSql||' AND f.COD_PRODUCTO = '||CN_producto;
     LV_sSql:=LV_sSql||'     AND b.cod_situacion NOT IN (''BAA'',''BAP''); ';
     LV_sSql:=LV_sSql||' AND b.cod_usuario = u.cod_usuario';
         LV_sSql:=LV_sSql||'     AND SYSDATE BETWEEN g.fec_desde AND g.fec_hasta';

      OPEN SO_Lista_Abonado FOR
      SELECT b.cod_cliente,
       b.num_abonado,
       b.num_celular,
       b.num_serie,
       b.num_imei,
       b.cod_tecnologia,
       b.cod_situacion,
       d.des_situacion,
       b.tip_plantarif,
       DECODE(b.tip_plantarif,'E','EMPRESA', 'I', 'INDIVIDUAL') AS des_tipplantarif,
       b.cod_plantarif,
       c.des_plantarif,
       b.cod_ciclo,
       c.cod_limconsumo,
       f.des_limconsumo,
       c.cod_tiplan,
       DECODE(c.cod_tiplan,'1','PREPAGO', '2', 'POSPAGO', '3', 'HIBRIDO') AS des_tiplan,
       c.cod_cargobasico,
       b.cod_tipcontrato,
       b.cod_modventa,
       b.num_contrato,
       b.cod_planserv,
       b.cod_central,
       b.num_venta,
       b.cod_uso,
       b.fec_acepventa,
       b.fec_alta,
       NULL fec_prorroga,
       b.num_anexo,
       b.cod_usuario,
       b.tip_terminal,
       b.num_venta,
       g.imp_cargobasico,
       b.cod_cuenta,
       b.cod_subcuenta,
       b.cod_vendedor,
       b.cod_causa_venta,
       b.fec_baja,
       b.fec_bajacen,
       b.fec_ultmod,
       b.cod_empresa,
       b.fec_fincontra,
       NULL ind_eqprestado,
       c.flg_rango,
           DECODE(b.ind_disp, NULL, -1),
           u.nom_usuario||' '||u.nom_apellido1||' '||u.nom_apellido2 as nombre_abonado
      FROM ga_aboamist b,
        ta_plantarif c,
        ga_situabo d,
        ged_codigos e,
        ta_limconsumo f,
        ta_cargosbasico g,
                ga_usuamist u
      WHERE b.cod_cliente   = EO_Abonado.cod_cliente
         AND b.cod_plantarif = c.cod_plantarif
         AND c.cod_cargobasico = g.cod_cargobasico
                 AND g.cod_producto = CN_producto
         AND b.cod_situacion = d.cod_situacion
         AND e.cod_modulo = CV_cod_modulo_GE
         AND e.nom_columna = 'COD_TIPLAN'
         AND e.nom_tabla = 'TA_PLANTARIF'
         AND e.cod_valor   = c.cod_tiplan
         AND f.cod_limconsumo = c.cod_limconsumo
                 AND f.COD_PRODUCTO = CN_producto
         AND b.cod_situacion NOT IN ('BAA','BAP')
                 AND b.cod_usuario = u.cod_usuario
         AND SYSDATE BETWEEN g.fec_desde AND g.fec_hasta;
    END IF;
   END IF;

EXCEPTION
 WHEN ERROR_CONTROLADO THEN
      SN_cod_retorno := 1;
      SV_mens_retorno := 'Cliente no posee Abonados';
      LV_des_error   := ' PV_OBTIENE_LISTA_ABONADOS_PR('||EO_Abonado.cod_cliente||'); '||SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_DATOS_ABONADO_PG.PV_OBTIENE_LISTA_ABONADOS_PR', LV_sSQL, SN_cod_retorno, LV_des_error );
 WHEN NO_DATA_FOUND THEN
      SN_cod_retorno := 203;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := CV_error_no_clasif;
      END IF;
      LV_des_error   := ' PV_OBTIENE_LISTA_ABONADOS_PR('||EO_Abonado.cod_cliente||'); '||SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_DATOS_ABONADO_PG.PV_OBTIENE_LISTA_ABONADOS_PR', LV_sSQL, SN_cod_retorno, LV_des_error );
 WHEN OTHERS THEN
      SN_cod_retorno := 156;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := CV_error_no_clasif;
      END IF;
      LV_des_error   := ' PV_OBTIENE_LISTA_ABONADOS_PR('||EO_Abonado.cod_cliente||'); '||SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_DATOS_ABONADO_PG.PV_OBTIENE_LISTA_ABONADOS_PR', LV_sSQL, SN_cod_retorno, LV_des_error );
END PV_OBTIENE_LISTA_ABONADOS_PR;

------------------------------------------------------------------------------------------------------
PROCEDURE PV_OBTIENE_DATOS_ABONADO_PR(SO_Abonado          IN OUT NOCOPY GA_Abonado_QT,
              SN_cod_retorno           OUT NOCOPY   ge_errores_td.cod_msgerror%TYPE,
              SV_mens_retorno          OUT NOCOPY   ge_errores_td.det_msgerror%TYPE,
              SN_num_evento            OUT NOCOPY ge_errores_pg.evento)
IS
/*
 <Documentación
   TipoDoc = "Procedure">>
    <Elemento
       Nombre = "PV_OBTIENE_DATOS_ABONADO_PR
       Lenguaje="PL/SQL"
       Fecha="04-06-2007"
       Versión="La del package"
       Diseñador="Matías Guajardo"
       Programador="Matías Guajardo"
       Ambiente Desarrollo="BD">
       <Retorno>N/A</Retorno>>
       <Descripción></Descripción>>
       <Parámetros>
          <Entrada>
             <param nom="SO_Abonado" Tipo="estructura">estructura de los datos de un abonado</param>>
          </Entrada>
          <Salida>
             <param nom="SO_Abonado" Tipo="estructura">estructura de los datos de un abonado</param>>
             <param nom="SN_cod_retorno" Tipo="NUMERICO">Codigo de Retorno</param>>
             <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>>
             <param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>>
          </Salida>
       </Parámetros>
    </Elemento>
 </Documentación>
*/
 LV_des_error    ge_errores_pg.DesEvent;
 LV_sSql      ge_errores_pg.vQuery;
 ERROR_NUM_ABONADO EXCEPTION;

 BEGIN
  sn_cod_retorno  := 0;
     sv_mens_retorno := ' ';
     sn_num_evento  := 0;

         LV_sSql := 'PV_VALIDA_NUMERO_ABONADO_FN('||SO_Abonado.num_abonado||')';

         IF (NOT PV_VALIDA_NUMERO_ABONADO_FN(SO_Abonado.num_abonado, SN_cod_retorno, SV_mens_retorno, SN_num_evento)) THEN
                RAISE ERROR_NUM_ABONADO;
         END IF;

LV_sSql:= LV_sSql||'SELECT a.cod_cliente,b.num_abonado,b.num_celular,b.num_serie,b.num_imei,b.cod_tecnologia,b.cod_situacion,';
LV_sSql:= LV_sSql||'   d.des_situacion,';
LV_sSql:= LV_sSql||'   b.tip_plantarif,';
LV_sSql:= LV_sSql||'   DECODE(b.tip_plantarif,''E'',''EMPRESA'', ''I'', ''INDIVIDUAL'') AS des_tipplantarif,';
LV_sSql:= LV_sSql||'   b.cod_plantarif,';
LV_sSql:= LV_sSql||'   c.des_plantarif,';
LV_sSql:= LV_sSql||'   b.cod_ciclo,';
LV_sSql:= LV_sSql||'   c.cod_limconsumo,';
LV_sSql:= LV_sSql||'   e.des_limconsumo,';
LV_sSql:= LV_sSql||'   b.cod_planserv,';
LV_sSql:= LV_sSql||'   b.cod_uso,';
LV_sSql:= LV_sSql||'   c.cod_tiplan,';
LV_sSql:= LV_sSql||'   DECODE(c.cod_tiplan,''1'',''PREPAGO'', ''2'', ''POSPAGO'', ''3'', ''HIBRIDO'') AS des_tiplan,';
LV_sSql:= LV_sSql||'   b.cod_tipcontrato,b.fec_alta,b.fec_fincontra,b.ind_eqprestado,b.fec_prorroga,c.flg_rango,f.imp_cargobasico,';
LV_sSql:= LV_sSql||'   b.num_anexo,';
LV_sSql:= LV_sSql||'   b.cod_usuario,';
LV_sSql:= LV_sSql||'   b.tip_terminal,';
LV_sSql:= LV_sSql||'   g.des_terminal,';
LV_sSql:= LV_sSql||'   b.num_venta';
LV_sSql:= LV_sSql||' FROM ge_clientes a,';
LV_sSql:= LV_sSql||'   ga_abocel b,';
LV_sSql:= LV_sSql||'   ta_plantarif c,';
LV_sSql:= LV_sSql||'   ga_situabo d,';
LV_sSql:= LV_sSql||'   ta_limconsumo e,';
LV_sSql:= LV_sSql||'   ta_cargosbasico f';
LV_sSql:= LV_sSql||'   al_tipos_terminales g';
LV_sSql:= LV_sSql||' WHERE b.num_abonado = '||SO_Abonado.num_abonado;
LV_sSql:= LV_sSql||'   AND a.cod_cliente   = b.cod_cliente';
LV_sSql:= LV_sSql||'   AND b.cod_plantarif = c.cod_plantarif';
LV_sSql:= LV_sSql||'   AND b.cod_situacion = d.cod_situacion';
LV_sSql:= LV_sSql||'   AND e.cod_limconsumo = c.cod_limconsumo';
LV_sSql:= LV_sSql||'   AND c.cod_cargobasico = f.cod_cargobasico';
LV_sSql:= LV_sSql||'   AND b.cod_situacion NOT IN (''BAA'',''BAP'')';
LV_sSql:= LV_sSql||'   AND SYSDATE BETWEEN f.fec_desde AND f.fec_hasta';
LV_sSql:= LV_sSql||'   AND g.cod_producto = b.cod_producto';
LV_sSql:= LV_sSql||'   AND g.tip_terminal = b.tip_terminal';
LV_sSql:= LV_sSql||'   AND rownum=1';
LV_sSql:= LV_sSql||' UNION';
LV_sSql:= LV_sSql||' SELECT a.cod_cliente,';
LV_sSql:= LV_sSql||'   b.num_abonado,';
LV_sSql:= LV_sSql||'   b.num_celular,';
LV_sSql:= LV_sSql||'   b.num_serie,';
LV_sSql:= LV_sSql||'   b.num_imei,';
LV_sSql:= LV_sSql||'   b.cod_tecnologia,';
LV_sSql:= LV_sSql||'   b.cod_situacion,';
LV_sSql:= LV_sSql||'   d.des_situacion,';
LV_sSql:= LV_sSql||'   b.tip_plantarif,';
LV_sSql:= LV_sSql||'   DECODE(b.tip_plantarif,''E'',''EMPRESA'', ''I'', ''INDIVIDUAL'') AS des_tipplantarif,';
LV_sSql:= LV_sSql||'   b.cod_plantarif,';
LV_sSql:= LV_sSql||'   c.des_plantarif,';
LV_sSql:= LV_sSql||'   b.cod_ciclo,';
LV_sSql:= LV_sSql||'   c.cod_limconsumo,';
LV_sSql:= LV_sSql||'   e.des_limconsumo,';
LV_sSql:= LV_sSql||'   b.cod_planserv,';
LV_sSql:= LV_sSql||'   b.cod_uso,';
LV_sSql:= LV_sSql||'   c.cod_tiplan,';
LV_sSql:= LV_sSql||'   DECODE(c.cod_tiplan,''1'',''PREPAGO'', ''2'', ''POSPAGO'', ''3'', ''HIBRIDO'') AS des_tiplan,';
LV_sSql:= LV_sSql||'   b.cod_tipcontrato,';
LV_sSql:= LV_sSql||'   b.fec_alta,';
LV_sSql:= LV_sSql||'   b.fec_fincontra,';
LV_sSql:= LV_sSql||'   null ind_eqprestado,';
LV_sSql:= LV_sSql||'   null fec_prorroga,';
LV_sSql:= LV_sSql||'   c.flg_rango,';
LV_sSql:= LV_sSql||'   f.imp_cargobasico,';
LV_sSql:= LV_sSql||'   b.num_anexo,';
LV_sSql:= LV_sSql||'   b.cod_usuario,';
LV_sSql:= LV_sSql||'   b.tip_terminal,';
LV_sSql:= LV_sSql||'   g.des_terminal,';
LV_sSql:= LV_sSql||'   b.num_venta';
LV_sSql:= LV_sSql||' FROM ge_clientes a,';
LV_sSql:= LV_sSql||'   ga_aboamist b,';
LV_sSql:= LV_sSql||'   ta_plantarif c,';
LV_sSql:= LV_sSql||'   ga_situabo d,';
LV_sSql:= LV_sSql||'   ta_limconsumo e,';
LV_sSql:= LV_sSql||'   ta_cargosbasico f,';
LV_sSql:= LV_sSql||'   al_tipos_terminales g';
LV_sSql:= LV_sSql||' WHERE b.num_abonado = '||SO_Abonado.num_abonado;
LV_sSql:= LV_sSql||'  AND a.cod_cliente   = b.cod_cliente';
LV_sSql:= LV_sSql||'  AND b.cod_plantarif = c.cod_plantarif';
LV_sSql:= LV_sSql||'  AND b.cod_situacion = d.cod_situacion';
LV_sSql:= LV_sSql||'  AND e.cod_limconsumo = c.cod_limconsumo';
LV_sSql:= LV_sSql||'  AND c.cod_cargobasico = f.cod_cargobasico';
LV_sSql:= LV_sSql||'  AND b.cod_situacion NOT IN (''BAA'',''BAP'')';
LV_sSql:= LV_sSql||'  AND SYSDATE BETWEEN f.fec_desde AND f.fec_hasta';
LV_sSql:= LV_sSql||'  AND g.cod_producto = b.cod_producto';
LV_sSql:= LV_sSql||'  AND g.tip_terminal = b.tip_terminal';
LV_sSql:= LV_sSql||'  AND rownum=1';

  SELECT a.cod_cliente,
      b.num_abonado,
      b.num_celular,
      b.num_serie,
      b.num_imei,
      b.cod_tecnologia,
      b.cod_situacion,
      d.des_situacion,
      b.tip_plantarif,
      DECODE(b.tip_plantarif,'E','EMPRESA', 'I', 'INDIVIDUAL') AS des_tipplantarif,
      b.cod_plantarif,
      c.des_plantarif,
      b.cod_ciclo,
      c.cod_limconsumo,
      e.des_limconsumo,
      b.cod_planserv,
      b.cod_uso,
      c.cod_tiplan,
      DECODE(c.cod_tiplan,'1','PREPAGO', '2', 'POSPAGO', '3', 'HIBRIDO') AS des_tiplan,
      b.cod_tipcontrato,
      b.fec_alta,
      b.fec_fincontra,
      b.ind_eqprestado,
      b.fec_prorroga,
      c.flg_rango,
      f.imp_cargobasico,
      b.num_anexo,
      b.cod_usuario,
      b.tip_terminal,
      g.des_terminal,
      b.num_venta,
      b.cod_cuenta,
      b.cod_subcuenta,
      b.cod_vendedor,
      b.cod_causa_venta,
      b.fec_baja,
      b.fec_bajacen,
      b.fec_ultmod,
      b.cod_empresa,
      b.fec_acepventa,
      b.num_contrato,
      b.cod_modventa,
      b.cod_cargobasico,
      b.cod_central,
      nvl(b.ind_disp,-1),
          u.nom_usuario||' '||u.nom_apellido1||' '||u.nom_apellido2
  INTO   SO_Abonado.cod_cliente,
      SO_Abonado.num_abonado,
      SO_Abonado.num_celular,
      SO_Abonado.num_serie,
      SO_Abonado.num_simcard,
      SO_Abonado.cod_tecnologia,
      SO_Abonado.cod_situacion,
      SO_Abonado.des_situacion,
       SO_Abonado.tip_plantarif,
      SO_Abonado.des_tipplantarif,
      SO_Abonado.cod_plantarif,
      SO_Abonado.des_plantarif,
      SO_Abonado.cod_ciclo,
       SO_Abonado.cod_limconsumo,
      SO_Abonado.des_limconsumo,
      SO_Abonado.cod_planserv,
      SO_Abonado.cod_uso,
      SO_Abonado.cod_tiplan,
      SO_Abonado.des_tiplan,
      SO_Abonado.cod_tipcontrato,
      SO_Abonado.fecha_alta,
      SO_Abonado.fec_fincontra,
      SO_Abonado.ind_eqprestado,
      SO_Abonado.fecha_prorroga,
      SO_Abonado.flg_rango,
      SO_Abonado.imp_cargobasico,
      SO_Abonado.num_anexo,
      SO_Abonado.cod_usuario,
      SO_Abonado.tip_terminal,
      SO_Abonado.des_terminal,
      SO_Abonado.num_venta,
      SO_Abonado.cod_cuenta,
      SO_Abonado.cod_subcuenta,
      SO_Abonado.cod_vendedor,
      SO_Abonado.cod_causa_venta,
      SO_Abonado.fecha_baja,
      SO_Abonado.fecha_bajacen,
      SO_Abonado.fecha_ultmod,
      SO_Abonado.cod_empresa,
      SO_Abonado.fecha_acepventa,
      SO_Abonado.num_contrato,
      SO_Abonado.modalidad_de_pago,
      SO_Abonado.cod_cargobasico,
      SO_Abonado.cod_central,
      SO_Abonado.ind_disp,
          SO_ABONADO.nombre_abonado
   FROM ge_clientes a,
      ga_abocel b,
      ta_plantarif c,
      ga_situabo d,
      ta_limconsumo e,
      ta_cargosbasico f,
      al_tipos_terminales g,
          ga_usuarios u
   WHERE b.num_abonado = SO_Abonado.num_abonado
     AND a.cod_cliente   = b.cod_cliente
     AND b.cod_plantarif = c.cod_plantarif
     AND b.cod_situacion = d.cod_situacion
     AND b.tip_terminal = g.tip_terminal
         AND g.cod_producto = CN_producto
     AND e.cod_limconsumo = c.cod_limconsumo
         AND e.cod_producto = CN_producto
     AND c.cod_cargobasico = f.cod_cargobasico
         AND f.COD_PRODUCTO = CN_producto
     AND b.cod_situacion NOT IN ('BAA','BAP')
         and b.cod_usuario = u.cod_usuario
     AND SYSDATE BETWEEN f.fec_desde AND f.fec_hasta
     AND rownum=1
   UNION
     SELECT a.cod_cliente,
      b.num_abonado,
      b.num_celular,
      b.num_serie,
      b.num_imei,
      b.cod_tecnologia,
      b.cod_situacion,
      d.des_situacion,
      b.tip_plantarif,
      DECODE(b.tip_plantarif,'E','EMPRESA', 'I', 'INDIVIDUAL') AS des_tipplantarif,
      b.cod_plantarif,
      c.des_plantarif,
      b.cod_ciclo,
      c.cod_limconsumo,
      e.des_limconsumo,
      b.cod_planserv,
      b.cod_uso,
      c.cod_tiplan,
      DECODE(c.cod_tiplan,'1','PREPAGO', '2', 'POSPAGO', '3', 'HIBRIDO') AS des_tiplan,
      b.cod_tipcontrato,
      b.fec_alta,
      b.fec_fincontra,
      null ind_eqprestado,
      null fec_prorroga,
      c.flg_rango,
      f.imp_cargobasico,
      b.num_anexo,
      b.cod_usuario,
      b.tip_terminal,
      g.des_terminal,
      b.num_venta,
      b.cod_cuenta,
      b.cod_subcuenta,
      b.cod_vendedor,
      b.cod_causa_venta,
      b.fec_baja,
      b.fec_bajacen,
      b.fec_ultmod,
      b.cod_empresa,
      b.fec_acepventa,
      b.num_contrato,
      b.cod_modventa,
      b.cod_cargobasico,
      b.cod_central,
      nvl(b.ind_disp,-1),
          u.nom_usuario||' '||u.nom_apellido1||' '||u.nom_apellido2
   FROM ge_clientes a,
      ga_aboamist b,
      ta_plantarif c,
      ga_situabo d,
      ta_limconsumo e,
      ta_cargosbasico f,
      al_tipos_terminales g,
          ga_usuamist u
   WHERE b.num_abonado = SO_Abonado.num_abonado
     AND a.cod_cliente   = b.cod_cliente
     AND b.cod_plantarif = c.cod_plantarif
     AND b.cod_situacion = d.cod_situacion
     AND b.tip_terminal = g.tip_terminal
         AND g.cod_producto = CN_producto
     AND e.cod_limconsumo = c.cod_limconsumo
         AND e.cod_producto = CN_producto
     AND c.cod_cargobasico = f.cod_cargobasico
         AND f.COD_PRODUCTO = CN_producto
     AND b.cod_situacion NOT IN ('BAA','BAP')
         and b.cod_usuario = u.cod_usuario
     AND SYSDATE BETWEEN f.fec_desde AND f.fec_hasta
     AND ROWNUM=1;

 EXCEPTION
 WHEN ERROR_NUM_ABONADO THEN
       SN_cod_retorno := 1616;
       IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := CV_error_no_clasif;
       END IF;
       LV_des_error   := ' PV_OBTIENE_DATOS_ABONADO_PR('||SO_Abonado.num_abonado||'); '||SQLERRM;
       SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_DATOS_ABONADO_PG.PV_OBTIENE_DATOS_ABONADO_PR', LV_sSQL, SN_cod_retorno, LV_des_error );
 WHEN NO_DATA_FOUND THEN
       SN_cod_retorno := 146;
       IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := CV_error_no_clasif;
       END IF;
    LV_des_error   := ' PV_OBTIENE_DATOS_ABONADO_PR('||SO_Abonado.num_abonado||'); '||SQLERRM;
       SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_DATOS_ABONADO_PG.PV_OBTIENE_DATOS_ABONADO_PR', LV_sSQL, SN_cod_retorno, LV_des_error );
   WHEN OTHERS THEN
       SN_cod_retorno := 156;
       IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := CV_error_no_clasif;
       END IF;
    LV_des_error   := ' PV_OBTIENE_DATOS_ABONADO_PR('||SO_Abonado.num_abonado||'); '||SQLERRM;
       SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_DATOS_ABONADO_PG.PV_OBTIENE_DATOS_ABONADO_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

END PV_OBTIENE_DATOS_ABONADO_PR;

------------------------------------------------------------------------------------------------------
PROCEDURE PV_OBTENER_CAUSA_BAJA_PR(EO_Abonado              IN       GA_Abonado_QT,
           SO_Lista_Abonado         OUT    NOCOPY  refCursor,
           SN_cod_retorno           OUT    NOCOPY    ge_errores_td.cod_msgerror%TYPE,
           SV_mens_retorno          OUT    NOCOPY    ge_errores_td.det_msgerror%TYPE,
           SN_num_evento            OUT    NOCOPY  ge_errores_pg.evento)
IS
/*
 <Documentación
   TipoDoc = "Procedure">>
    <Elemento
       Nombre = "PV_OBTENER_CAUSA_BAJA_PR
       Lenguaje="PL/SQL"
       Fecha="01-06-2007"
       Versión="La del package"
       Diseñador="Matías Guajardo"
       Programador="Matías Guajardo"
       Ambiente Desarrollo="BD">
       <Retorno>N/A</Retorno>>
       <Descripción></Descripción>>
       <Parámetros>
          <Entrada>
             <param nom="GA_abonado" Tipo="estructura">estructura de una lista de abonados</param>>
          </Entrada>
          <Salida>
             <param nom="" Tipo=""></param>>
             <param nom="SN_cod_retorno" Tipo="NUMERICO">Codigo de Retorno</param>>
             <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>>
             <param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>>
          </Salida>
       </Parámetros>
    </Elemento>
 </Documentación>
*/
 LV_des_error       GE_ERRORES_PG.DesEvent;
 LV_sSql         GE_ERRORES_PG.vQuery;
 en_causa_vigente            GA_CAUSABAJA.IND_VIGENCIA%TYPE;
 en_causa_parametro_amistar  GA_CAUSABAJA.COD_CAUSABAJA%TYPE;
 en_cod_causa          GA_CAUSABAJA.COD_CAUSABAJA%TYPE;
 ev_cod_ooss                 VARCHAR2(100);
 ev_ooss_parametro     VARCHAR2(100);
 v_contador        NUMBER(9);

 BEGIN
        SN_cod_retorno  := 0;
        SV_mens_retorno := ' ';
        SN_num_evento  := 0;

  EN_causa_vigente         := EO_Abonado.IND_VIGENCIA;
  EN_causa_parametro_amistar  := EO_Abonado.COD_CAUSABAJA;
  EN_cod_causa          := EO_Abonado.COD_CAUSABAJA;
  EV_cod_ooss     := EO_Abonado.COD_OS;
  EV_ooss_parametro   := EO_Abonado.OSS_PARAMETRO;

       IF EN_cod_causa <> '' THEN
          LV_sSql:='SELECT DES_CAUSABAJA,COD_CAUSABAJA,IND_LN,IND_COBRO,IND_PORTABLE ';
          LV_sSql:=LV_sSql||' FROM GA_CAUSABAJA ';
          LV_sSql:=LV_sSql||' WHERE COD_PRODUCTO ='||CN_producto||' ';
          LV_sSql:=LV_sSql||' AND IND_VIGENCIA   ='||EN_causa_vigente||' ';
          LV_sSql:=LV_sSql||' AND COD_CAUSABAJA  ='||EN_cod_causa||'; ';
          OPEN SO_Lista_Abonado FOR
          SELECT DES_CAUSABAJA,COD_CAUSABAJA,IND_LN,IND_COBRO,IND_PORTABLE
     FROM GA_CAUSABAJA
      WHERE COD_PRODUCTO = CN_producto
                 AND IND_VIGENCIA = EN_causa_vigente
                 AND COD_CAUSABAJA = EN_cod_causa;
       ELSIF EV_cod_ooss = EV_ooss_parametro THEN
          LV_sSql:='SELECT DES_CAUSABAJA,COD_CAUSABAJA,IND_LN,IND_COBRO,IND_PORTABLE ';
          LV_sSql:=LV_sSql||' FROM GA_CAUSABAJA ';
          LV_sSql:=LV_sSql||' WHERE COD_PRODUCTO='||CN_producto||' ';
          LV_sSql:=LV_sSql||' AND IND_VIGENCIA  ='||EN_causa_vigente||' ';
          LV_sSql:=LV_sSql||' AND COD_CAUSABAJA IN ('||EN_causa_parametro_amistar||'); ';
         OPEN SO_Lista_Abonado FOR
          SELECT DES_CAUSABAJA,COD_CAUSABAJA,IND_LN,IND_COBRO,IND_PORTABLE
     FROM GA_CAUSABAJA
               WHERE COD_PRODUCTO = CN_producto
                 AND IND_VIGENCIA = EN_causa_vigente
               AND COD_CAUSABAJA IN (EN_causa_parametro_amistar );
       ELSE
          LV_sSql:='SELECT DES_CAUSABAJA,COD_CAUSABAJA,IND_LN,IND_COBRO,IND_PORTABLE ';
          LV_sSql:=LV_sSql||' FROM GA_CAUSABAJA ';
          LV_sSql:=LV_sSql||' WHERE COD_PRODUCTO='||CN_producto||' ';
          LV_sSql:=LV_sSql||' AND IND_VIGENCIA  ='||EN_causa_vigente||' ';
          LV_sSql:=LV_sSql||' AND COD_CAUSABAJA ='||EN_causa_parametro_amistar||';';
         OPEN SO_Lista_Abonado FOR
         SELECT DES_CAUSABAJA,COD_CAUSABAJA,IND_LN,IND_COBRO,IND_PORTABLE
    FROM GA_CAUSABAJA
              WHERE COD_PRODUCTO = CN_producto
                AND IND_VIGENCIA = EN_causa_vigente
           AND COD_CAUSABAJA = EN_causa_parametro_amistar ;
    END IF;

EXCEPTION
 WHEN NO_DATA_FOUND THEN
       SN_cod_retorno := 149;
       IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := CV_error_no_clasif;
       END IF;
    LV_des_error   := 'PV_OBTENER_CAUSA_BAJA_PR('||EO_Abonado.cod_cliente||'); '||SQLERRM;
       SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_DATOS_ABONADO_PG.PV_OBTENER_CAUSA_BAJA_PR', LV_sSQL, SN_cod_retorno, LV_des_error );
 WHEN OTHERS THEN
       SN_cod_retorno := 156;
       IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := CV_error_no_clasif;
       END IF;
    LV_des_error   := ' PV_OBTENER_CAUSA_BAJA_PR('||EO_Abonado.cod_cliente||'); '||SQLERRM;
       SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_DATOS_ABONADO_PG.PV_OBTENER_CAUSA_BAJA_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

END PV_OBTENER_CAUSA_BAJA_PR;

------------------------------------------------------------------------------------------------------
PROCEDURE PV_ELIMINA_CUENTA_PERSONAL_PR(EO_NUMCEL_PERS   IN       PV_NUMCEL_PERS_QT,
             SN_cod_retorno       OUT NOCOPY     ge_errores_td.cod_msgerror%TYPE,
             SV_mens_retorno      OUT NOCOPY     ge_errores_td.det_msgerror%TYPE,
             SN_num_evento        OUT NOCOPY  ge_errores_pg.evento)
IS
/*
 <Documentación
   TipoDoc = "Procedure">>
    <Elemento
       Nombre = "PV_ELIMINA_CUENTA_PERSONAL_PR"
       Lenguaje="PL/SQL"
       Fecha="05-07-2007"
       Versión="La del package"
       Diseñador="Juan Gonzalez C."
       Programador="Juan Gonzalez C."
       Ambiente Desarrollo="BD">
       <Retorno>N/A</Retorno>>
       <Descripción></Descripción>>
       <Parámetros>
          <Entrada>
             <param nom="EO_NUMCEL_PERS" Tipo="estructura">estructura para datos de cuenta personal</param>>
          </Entrada>
          <Salida>
             <param nom="" Tipo=""></param>>
             <param nom="SN_cod_retorno" Tipo="NUMERICO">Codigo de Retorno</param>>
             <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>>
             <param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>>
          </Salida>
       </Parámetros>
    </Elemento>
 </Documentación>
 */
        LN_p_correlativo         NUMBER;
  LV_des_error       ge_errores_pg.DesEvent;
  LV_sSql         ge_errores_pg.vQuery;
  ERROR_EJECUCION         EXCEPTION;
  Reg_ga_numcel_personal_to   PV_TIPOS_PG.R_GA_NUMCEL_PERSONAL_TO;
  LN_cod_retorno    NUMBER;

 BEGIN
  SN_cod_retorno  := 0;
     SV_mens_retorno := NULL;
     SN_num_evento  := 0;
        LN_p_correlativo := 0;
  LN_cod_retorno  := 0;

     Reg_ga_numcel_personal_to(1).num_cel_pers  := EO_NUMCEL_PERS.NUM_CELULAR_PERS;
     Reg_ga_numcel_personal_to(1).num_cel_corp  := EO_NUMCEL_PERS.NUM_CELULAR_CORP;

        LV_sSql := 'LN_cod_retorno := GA_NUMCEL_PERSONAL_PG. GA_EXISTE_NUMPERSONAL_FN ('||Reg_ga_numcel_personal_to(1).num_cel_pers||')';

        LN_cod_retorno := GA_NUMCEL_PERSONAL_PG.GA_EXISTE_NUMPERSONAL_FN (Reg_ga_numcel_personal_to(1).num_cel_pers);

            IF LN_cod_retorno > 0 THEN
       LV_sSql := 'GA_NUMCEL_PERSONAL_PG.GA_DESACTIVA_NUMPERSONAL_PR ('||Reg_ga_numcel_personal_to(1).num_cel_pers||', '''||CV_cod_modulo||''', '||LN_p_correlativo||', '||SN_cod_retorno||', '||SN_num_evento||', '||SV_mens_retorno||')';
          GA_NUMCEL_PERSONAL_PG.GA_DESACTIVA_NUMPERSONAL_PR (Reg_ga_numcel_personal_to(1).num_cel_pers, CV_cod_modulo, LN_p_correlativo, SN_cod_retorno, SN_num_evento, SV_mens_retorno);
          IF SN_cod_retorno <> 0 THEN
                  RAISE ERROR_EJECUCION;
    END IF;

          LV_sSql := 'GA_NUMCEL_PERSONAL_PG.GA_ACTLZA_NUMCEL_PERSONAL_PR ('||Reg_ga_numcel_personal_to(1).num_cel_pers||', '||Reg_ga_numcel_personal_to(1).num_cel_corp||', '''||CV_cod_actabo||''')';
          GA_NUMCEL_PERSONAL_PG.GA_ACTLZA_NUMCEL_PERSONAL_PR (Reg_ga_numcel_personal_to(1).num_cel_pers, Reg_ga_numcel_personal_to(1).num_cel_corp, CV_cod_actabo);
          IF SN_cod_retorno <> 0 THEN
                  RAISE ERROR_EJECUCION;
    END IF;
            END IF;



 EXCEPTION
    WHEN ERROR_EJECUCION THEN
          LV_des_error   := 'PV_ELIMINA_CUENTA_PERSONAL_PR('||EO_NUMCEL_PERS.NUM_CELULAR_PERS||', '||EO_NUMCEL_PERS.NUM_CELULAR_CORP||'); '||SQLERRM;
          SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_DATOS_ABONADO_PG.PV_ELIMINA_CUENTA_PERSONAL_PR', LV_sSQL, SN_cod_retorno, LV_des_error );
 WHEN OTHERS THEN
       SN_cod_retorno := 156;
       IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := CV_error_no_clasif;
       END IF;
    LV_des_error   := 'PV_ELIMINA_CUENTA_PERSONAL_PR('||EO_NUMCEL_PERS.NUM_CELULAR_PERS||', '||EO_NUMCEL_PERS.NUM_CELULAR_CORP||'); '||SQLERRM;
       SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_DATOS_ABONADO_PG.PV_ELIMINA_CUENTA_PERSONAL_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

END PV_ELIMINA_CUENTA_PERSONAL_PR;

------------------------------------------------------------------------------------------------------
PROCEDURE PV_VALIDAOOSS_PENDPLAN_PR(EO_VALIDAOOSS_PENDPLAN IN OUT NOCOPY    PV_VALIDAOOSS_PENDPLAN_QT,
            SN_cod_retorno            OUT NOCOPY       ge_errores_td.cod_msgerror%TYPE,
            SV_mens_retorno           OUT NOCOPY       ge_errores_td.det_msgerror%TYPE,
            SN_num_evento             OUT NOCOPY    ge_errores_pg.evento)
IS
/*
 <Documentación
   TipoDoc = "Procedure">>
    <Elemento
       Nombre = "PV_VALIDAOOSS_PENDPLAN_PR"
       Lenguaje="PL/SQL"
       Fecha="07-07-2007"
       Versión="La del package"
       Diseñador="Juan Gonzalez C."
       Programador="Juan Gonzalez C."
       Ambiente Desarrollo="BD">
       <Retorno>N/A</Retorno>>
       <Descripción></Descripción>>
       <Parámetros>
          <Entrada>
             <param nom="EO_VALIDAOOSS_PENDPLAN" Tipo="estructura">estructura para datos de abonado y ooss</param>>
          </Entrada>
          <Salida>
             <param nom="" Tipo=""></param>>
             <param nom="SN_cod_retorno" Tipo="NUMERICO">Codigo de Retorno</param>>
             <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>>
             <param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>>
          </Salida>
       </Parámetros>
    </Elemento>
 </Documentación>
*/
  LV_des_error      ge_errores_pg.DesEvent;
  LV_sSql        ge_errores_pg.vQuery;
  LN_cod_estado     pv_erecorrido.cod_estado%TYPE;
  LN_num_intentos     pv_iorserv.num_intentos%TYPE;
  EO_GED_PARAMETROS      PV_GED_PARAMETROS_QT;

 BEGIN
  SN_cod_retorno  := 0;
     SV_mens_retorno := NULL;
     SN_num_evento  := 0;
  EO_VALIDAOOSS_PENDPLAN.NUM_OS := 0;
  EO_VALIDAOOSS_PENDPLAN.FECHA_EJECUCION := NULL;

  EO_GED_PARAMETROS := PV_INICIA_ESTRUCTURAS_PG.PV_GED_PARAMETROS_QT_FN;
  EO_GED_PARAMETROS.COD_MODULO := CV_cod_modulo;
  EO_GED_PARAMETROS.COD_PRODUCTO := CN_producto;
     EO_GED_PARAMETROS.NOM_PARAMETRO := CV_val_prm_estado;

  LV_sSql := 'PV_GENERALES_PG.PV_OBTIENE_GED_PARAMETROS_PR ('||EO_GED_PARAMETROS.NOM_PARAMETRO||','||EO_GED_PARAMETROS.COD_MODULO||','||EO_GED_PARAMETROS.COD_PRODUCTO||')';
  PV_GENERALES_PG.PV_OBTIENE_GED_PARAMETROS_PR (EO_GED_PARAMETROS,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
  LN_cod_estado :=EO_GED_PARAMETROS.VAL_PARAMETRO;

  EO_GED_PARAMETROS := PV_INICIA_ESTRUCTURAS_PG.PV_GED_PARAMETROS_QT_FN;
  EO_GED_PARAMETROS.COD_MODULO := CV_cod_modulo;
  EO_GED_PARAMETROS.COD_PRODUCTO := 1;
     EO_GED_PARAMETROS.NOM_PARAMETRO := CV_val_prm_maxint;

  LV_sSql := 'PV_GENERALES_PG.PV_OBTIENE_GED_PARAMETROS_PR ('||EO_GED_PARAMETROS.NOM_PARAMETRO||','||EO_GED_PARAMETROS.COD_MODULO||','||EO_GED_PARAMETROS.COD_PRODUCTO||')';
  PV_GENERALES_PG.PV_OBTIENE_GED_PARAMETROS_PR (EO_GED_PARAMETROS,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
  LN_num_intentos :=EO_GED_PARAMETROS.VAL_PARAMETRO;

     LV_sSql := 'SELECT  e.num_os, TO_CHAR(e.fh_ejecucion, CV_formato_fecha)';
     LV_sSql := LV_sSql || ' FROM   pv_iorserv e, pv_erecorrido f, pv_camcom g';
     LV_sSql := LV_sSql || ' WHERE e.num_os = f.num_os';
     LV_sSql := LV_sSql || ' AND     e.num_os = g.num_os';
     LV_sSql := LV_sSql || ' AND     g.num_abonado = EO_VALIDAOOSS_PENDPLAN.NUM_ABONADO';
     LV_sSql := LV_sSql || ' AND     e.cod_os = EO_VALIDAOOSS_PENDPLAN.COD_OS';
     LV_sSql := LV_sSql || ' AND     e.num_os NOT IN ( SELECT  a.num_os FROM pv_iorserv a, pv_erecorrido b, pv_camcom c, pv_arcos d';
     LV_sSql := LV_sSql || ' WHERE a.num_os = b.num_os';
     LV_sSql := LV_sSql || ' AND     a.cod_os = EO_VALIDAOOSS_PENDPLAN.COD_OS';
     LV_sSql := LV_sSql || ' AND     a.num_os = c.num_os';
     LV_sSql := LV_sSql || ' AND     c.num_abonado = EO_VALIDAOOSS_PENDPLAN.NUM_ABONADO';
     LV_sSql := LV_sSql || ' AND     a.cod_modgener = d.cod_modgener';
     LV_sSql := LV_sSql || ' AND     d.atrib_estado IN ( 2, 3 )';
     LV_sSql := LV_sSql || ' AND     d.cod_aplic = CV_cod_aplic';
     LV_sSql := LV_sSql || ' AND   ((b.cod_estado = d.est_final) OR (b.cod_estado = LN_cod_estado))';
     LV_sSql := LV_sSql || ' AND     b.tip_estado = 3';
     LV_sSql := LV_sSql || ' AND     NVL(a.num_intentos, 0) < LN_num_intentos';
     LV_sSql := LV_sSql || ' UNION ALL';
     LV_sSql := LV_sSql || ' SELECT  a.num_os FROM pv_iorserv a, pv_erecorrido b, pv_camcom c, pv_arcos d';
     LV_sSql := LV_sSql || ' WHERE a.num_os = b.num_os';
     LV_sSql := LV_sSql || ' AND     a.cod_os = EO_VALIDAOOSS_PENDPLAN.COD_OS';
     LV_sSql := LV_sSql || ' AND     a.num_os = c.num_os';
     LV_sSql := LV_sSql || ' AND     c.num_abonado = EO_VALIDAOOSS_PENDPLAN.NUM_ABONADO';
     LV_sSql := LV_sSql || ' AND     a.cod_modgener = d.cod_modgener';
     LV_sSql := LV_sSql || ' AND     D.atrib_estado IN ( 2, 3 )';
     LV_sSql := LV_sSql || ' AND     d.cod_aplic = CV_cod_aplic';
     LV_sSql := LV_sSql || ' AND     b.tip_estado = 4';
     LV_sSql := LV_sSql || ' AND     NVL(a.num_intentos, 0) < LN_num_intentos)';

     SELECT  e.num_os, TO_CHAR(e.fh_ejecucion, CV_formato_fecha)
     INTO    EO_VALIDAOOSS_PENDPLAN.NUM_OS, EO_VALIDAOOSS_PENDPLAN.FECHA_EJECUCION
     FROM   pv_iorserv e, pv_erecorrido f, pv_camcom g
     WHERE e.num_os = f.num_os
     AND     e.num_os = g.num_os
     AND     g.num_abonado = EO_VALIDAOOSS_PENDPLAN.NUM_ABONADO
     AND     e.cod_os = EO_VALIDAOOSS_PENDPLAN.COD_OS
     AND     e.num_os NOT IN ( SELECT  a.num_os FROM pv_iorserv a, pv_erecorrido b, pv_camcom c, pv_arcos d
                                                WHERE a.num_os = b.num_os
                                                AND     a.cod_os = EO_VALIDAOOSS_PENDPLAN.COD_OS
                                                AND     a.num_os = c.num_os
                                                AND     c.num_abonado = EO_VALIDAOOSS_PENDPLAN.NUM_ABONADO
                                                AND     a.cod_modgener = d.cod_modgener
                                                AND     d.atrib_estado IN ( 2, 3 )
                                                AND     d.cod_aplic = CV_cod_aplic
                                                AND   ((b.cod_estado = d.est_final) OR (b.cod_estado = LN_cod_estado))
                                                AND     b.tip_estado = 3
                                                AND     NVL(a.num_intentos, 0) < LN_num_intentos
                                                UNION ALL
                                                SELECT  a.num_os FROM pv_iorserv a, pv_erecorrido b, pv_camcom c, pv_arcos d
                                                WHERE a.num_os = b.num_os
                                                AND     a.cod_os = EO_VALIDAOOSS_PENDPLAN.COD_OS
                                                AND     a.num_os = c.num_os
                                                AND     c.num_abonado = EO_VALIDAOOSS_PENDPLAN.NUM_ABONADO
                                                AND     a.cod_modgener = d.cod_modgener
                                                AND     D.atrib_estado IN ( 2, 3 )
                                                AND     d.cod_aplic = CV_cod_aplic
                                                AND     b.tip_estado = 4
                                                AND     NVL(a.num_intentos, 0) < LN_num_intentos);

 EXCEPTION
    WHEN NO_DATA_FOUND THEN
       SN_cod_retorno := 149;
       IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := CV_error_no_clasif;
       END IF;
    LV_des_error   := 'PV_VALIDAOOSS_PENDPLAN_PR('||EO_VALIDAOOSS_PENDPLAN.NUM_ABONADO||', '||EO_VALIDAOOSS_PENDPLAN.COD_OS||'); '||SQLERRM;
       SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_DATOS_ABONADO_PG.PV_VALIDAOOSS_PENDPLAN_PR', LV_sSQL, SN_cod_retorno, LV_des_error );
 WHEN OTHERS THEN
       SN_cod_retorno := 156;
       IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := CV_error_no_clasif;
       END IF;
    LV_des_error   := 'PV_VALIDAOOSS_PENDPLAN_PR('||EO_VALIDAOOSS_PENDPLAN.NUM_ABONADO||', '||EO_VALIDAOOSS_PENDPLAN.COD_OS||'); '||SQLERRM;
       SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_DATOS_ABONADO_PG.PV_VALIDAOOSS_PENDPLAN_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

END PV_VALIDAOOSS_PENDPLAN_PR;

------------------------------------------------------------------------------------------------------
FUNCTION  PV_OBT_Limconsumo_CargBas_FN (EO_PlanesTarifarios IN          PV_PLANES_TARIFARIOS_QT,
               Reg_TA_PLANTARIF IN OUT      PV_TIPOS_PG.TIP_TA_PLANTARIF,
               SN_cod_retorno       OUT NOCOPY   ge_errores_td.cod_msgerror%TYPE,
                SV_mens_retorno        OUT NOCOPY   ge_errores_td.det_msgerror%TYPE,
                SN_num_evento        OUT NOCOPY ge_errores_pg.evento)
RETURN BOOLEAN
IS
  LV_des_error    ge_errores_pg.DesEvent;
  LV_sSql      ge_errores_pg.vQuery;
    BEGIN
  LV_sSql:='SELECT COD_CARGOBASICO,COD_LIMCONSUMO,TIP_PLANTARIF ';
  LV_sSql:=LV_sSql||' FROM TA_PLANTARIF ';
  LV_sSql:=LV_sSql||' WHERE              ';
  LV_sSql:=LV_sSql||' COD_PLANTARIF = '||EO_PlanesTarifarios.COD_PLANTARIF_NUEVO||' ';

  FOR i IN Reg_TA_PLANTARIF.FIRST .. Reg_TA_PLANTARIF.LAST LOOP
   SELECT COD_CARGOBASICO,
       COD_LIMCONSUMO,
       TIP_PLANTARIF
   INTO  Reg_TA_PLANTARIF(i).COD_CARGOBASICO,
      Reg_TA_PLANTARIF(i).COD_LIMCONSUMO,
      Reg_TA_PLANTARIF(i).TIP_PLANTARIF
   FROM  TA_PLANTARIF
   WHERE
        COD_PLANTARIF = EO_PlanesTarifarios.COD_PLANTARIF_NUEVO;
  END LOOP;
  RETURN TRUE;

 EXCEPTION
 WHEN NO_DATA_FOUND THEN
       SN_cod_retorno := 1374;
       IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := CV_error_no_clasif;
       END IF;
    LV_des_error   := 'PV_OBT_Limconsumo_CargBas_FN('||EO_PlanesTarifarios.COD_PLANTARIF_NUEVO||'); Dato no encontrado (Ta_Plantarif)'||SQLERRM;
       SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_DATOS_ABONADO_PG.PV_OBT_Limconsumo_CargBas_FN', LV_sSQL, SN_cod_retorno, LV_des_error );
    RETURN FALSE;
   WHEN OTHERS THEN
       SN_cod_retorno := 156;
       IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := CV_error_no_clasif;
       END IF;
    LV_des_error   := 'PV_OBT_Limconsumo_CargBas_FN('||EO_PlanesTarifarios.COD_PLANTARIF_NUEVO||'); Problemas al Leer  (Ta_Plantarif)'||SQLERRM;
       SN_num_evento  := Ge_Errores_Pg.Grabarpl(SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_DATOS_ABONADO_PG.PV_OBT_Limconsumo_CargBas_FN', LV_sSQL, SN_cod_retorno, LV_des_error );
       RETURN FALSE;
END PV_OBT_Limconsumo_CargBas_FN;

------------------------------------------------------------------------------------------------------
FUNCTION  PV_ActualizaHibrido_FN (EO_PlanesTarifarios IN       PV_PLANES_TARIFARIOS_QT,
            Reg_TA_PLANTARIF IN         PV_TIPOS_PG.TIP_TA_PLANTARIF,
            SN_cod_retorno    OUT NOCOPY    ge_errores_td.cod_msgerror%TYPE,
             SV_mens_retorno   OUT NOCOPY    ge_errores_td.det_msgerror%TYPE,
             SN_num_evento     OUT NOCOPY   ge_errores_pg.evento)
RETURN BOOLEAN
IS
  LV_des_error    ge_errores_pg.DesEvent;
  LV_sSql      ge_errores_pg.vQuery;

    BEGIN
  LV_sSql:='UPDATE GA_ABOCEL SET COD_PLANTARIF = '||Reg_TA_PLANTARIF(1).COD_PLANTARIF||',   ';
  LV_sSql:=LV_sSql||' TIP_PLANTARIF  = '||Reg_TA_PLANTARIF(1).TIP_PLANTARIF||',   ';
  LV_sSql:=LV_sSql||' COD_CARGOBASICO= '||Reg_TA_PLANTARIF(1).COD_CARGOBASICO||', ';
  LV_sSql:=LV_sSql||' COD_LIMCONSUMO = '||Reg_TA_PLANTARIF(1).COD_LIMCONSUMO||',  ';
  LV_sSql:=LV_sSql||' FEC_ULTMOD     = '||SYSDATE||' ';
  LV_sSql:=LV_sSql||' WHERE ';
  LV_sSql:=LV_sSql||' NUM_ABONADO = '||EO_PlanesTarifarios.NUM_ABONADO ||'; ';

  FOR i IN Reg_TA_PLANTARIF.FIRST .. Reg_TA_PLANTARIF.LAST LOOP
   UPDATE GA_ABOCEL SET
     COD_PLANTARIF   = EO_PlanesTarifarios.COD_PLANTARIF_NUEVO,
     TIP_PLANTARIF   = Reg_TA_PLANTARIF(i).TIP_PLANTARIF,
     COD_CARGOBASICO = Reg_TA_PLANTARIF(i).COD_CARGOBASICO,
     COD_LIMCONSUMO  = Reg_TA_PLANTARIF(i).COD_LIMCONSUMO,
     FEC_ULTMOD      = SYSDATE
   WHERE
     NUM_ABONADO = EO_PlanesTarifarios.NUM_ABONADO;
  END LOOP;
  RETURN TRUE;

    EXCEPTION
    WHEN OTHERS THEN
       SN_cod_retorno := 156;
       IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := CV_error_no_clasif;
       END IF;
    LV_des_error   :=SQLERRM|| ' PV_ActualizaHibrido_FN('||EO_PlanesTarifarios.NUM_ABONADO||'); Problemas al actualizar Abonado';
       SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_DATOS_ABONADO_PG.PV_ActualizaHibrido_FN', LV_sSQL, SN_cod_retorno, LV_des_error );
    RETURN FALSE;

END PV_ActualizaHibrido_FN;

------------------------------------------------------------------------------------------------------
FUNCTION  PV_Ins_GA_ABOCEL_FN (EO_PlanesTarifarios  IN           PV_PLANES_TARIFARIOS_QT,
          SN_COD_CLIENTE  IN      ga_intarcel.cod_cliente%TYPE,
          SN_NUM_ABONADO  IN      ga_intarcel.num_abonado%TYPE,
          Reg_TA_PLANTARIF     IN         PV_TIPOS_PG.TIP_TA_PLANTARIF,
          SN_cod_retorno    OUT NOCOPY    ge_errores_td.cod_msgerror%TYPE,
          SV_mens_retorno   OUT NOCOPY    ge_errores_td.det_msgerror%TYPE,
          SN_num_evento        OUT NOCOPY   ge_errores_pg.evento)
RETURN BOOLEAN
IS
  LV_des_error          ge_errores_pg.DesEvent;
  LV_sSql            ge_errores_pg.vQuery;

  LV_ROWID           ga_intarcel.num_imsi%TYPE;
  LN_COD_CLIENTE           NUMBER(8);
  LN_NUM_ABONADO           NUMBER(8);
  LN_IND_NUMERO            NUMBER(1);
  LD_FEC_DESDE             DATE;
  LD_FEC_HASTA             DATE;
  LN_IMP_LIMCONSUMO        NUMBER(14,4);
  LN_IND_FRIENDS           NUMBER(1);
  LN_IND_DIASESP           NUMBER(1);
  LV_COD_CELDA             VARCHAR2(7);
  LV_TIP_PLANTARIF         VARCHAR2(1);
  LV_COD_PLANTARIF         VARCHAR2(3);
  LV_NUM_SERIE             VARCHAR2(25);
  LN_NUM_CELULAR           NUMBER(15);
  LV_COD_CARGOBASICO       VARCHAR2(3);
  LN_COD_CICLO             NUMBER(2);
  LN_COD_PLANCOM           NUMBER(6);
  LV_COD_PLANSERV          VARCHAR2(3);
  LV_COD_GRPSERV           VARCHAR2(2);
  LN_COD_GRUPO             NUMBER(8);
  LN_COD_PORTADOR          NUMBER(5);
  LN_COD_USO               NUMBER(2);
  LV_NUM_IMSI              VARCHAR2(25);
  LV_NUM_MIN_MDN           VARCHAR2(15);
  LN_ROW         NUMBER(1);

    BEGIN
  SN_cod_retorno := 0;
     SV_mens_retorno:= NULL;
     SN_num_evento:= 0;
  LN_ROW := 0;

   LV_sSql:='SELECT ROWID COD_CLIENTE,NUM_ABONADO,IND_NUMERO,FEC_DESDE,FEC_HASTA,IMP_LIMCONSUMO,IND_FRIENDS,  ';
   LV_sSql:=LV_sSql||' IND_DIASESP,COD_CELDA,TIP_PLANTARIF,COD_PLANTARIF,NUM_SERIE,NUM_CELULAR,COD_CARGOBASICO,         ';
   LV_sSql:=LV_sSql||' COD_CICLO,COD_PLANCOM,COD_PLANSERV,COD_GRPSERV, ';
   LV_sSql:=LV_sSql||' Decode(COD_GRUPO,'||' '||',null,COD_GRUPO),       ';
   LV_sSql:=LV_sSql||' Decode(COD_PORTADOR,'||' '||',null,COD_PORTADOR), ';
   LV_sSql:=LV_sSql||' COD_USO,    ';
   LV_sSql:=LV_sSql||' Decode(NUM_IMSI,'||' '||',null,NUM_IMSI),  ';
   LV_sSql:=LV_sSql||' NUM_MIN_MDN   ';
   LV_sSql:=LV_sSql||' FROM GA_INTARCEL                                    ';
   LV_sSql:=LV_sSql||' WHERE COD_CLIENTE = '||to_char(SN_COD_CLIENTE)||'   ';
   LV_sSql:=LV_sSql||' AND   NUM_ABONADO = '||to_char(SN_NUM_ABONADO)||';  ';
   LV_sSql:=LV_sSql||' AND SYSDATE BETWEEN FEC_DESDE AND FEC_HASTA;  ';

   BEGIN
   SELECT     ROWID,
        COD_CLIENTE,
        NUM_ABONADO,
        IND_NUMERO,
        FEC_DESDE,
        FEC_HASTA,
        IMP_LIMCONSUMO,
        IND_FRIENDS,
        IND_DIASESP,
        COD_CELDA,
        TIP_PLANTARIF,
        COD_PLANTARIF,
        NUM_SERIE,
        NUM_CELULAR,
        COD_CARGOBASICO,
        COD_CICLO,
        COD_PLANCOM,
        COD_PLANSERV,
        COD_GRPSERV,
        Decode(COD_GRUPO,' ',null,COD_GRUPO),
        Decode(COD_PORTADOR,' ',null,COD_PORTADOR),
        COD_USO,
        Decode(NUM_IMSI,' ',null,NUM_IMSI)
    INTO
      LV_ROWID,
         LN_COD_CLIENTE,
      LN_NUM_ABONADO,
      LN_IND_NUMERO,
      LD_FEC_DESDE,
      LD_FEC_HASTA,
      LN_IMP_LIMCONSUMO,
      LN_IND_FRIENDS,
      LN_IND_DIASESP,
      LV_COD_CELDA,
      LV_TIP_PLANTARIF,
      LV_COD_PLANTARIF,
      LV_NUM_SERIE,
      LN_NUM_CELULAR,
      LV_COD_CARGOBASICO,
      LN_COD_CICLO,
      LN_COD_PLANCOM,
      LV_COD_PLANSERV,
      LV_COD_GRPSERV,
      LN_COD_GRUPO,
      LN_COD_PORTADOR,
      LN_COD_USO,
      LV_NUM_IMSI
    FROM GA_INTARCEL
    WHERE COD_CLIENTE = SN_COD_CLIENTE
    AND   NUM_ABONADO = SN_NUM_ABONADO
    AND SYSDATE BETWEEN FEC_DESDE AND FEC_HASTA;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
       LN_ROW := 1;
    END;

    IF  LN_ROW = 0 THEN
      LV_sSql:='UPDATE GA_INTARCEL SET FEC_HASTA = TO_DATE(sysdate,''DD-MM-YYYY  HH24:MI:SS'') - (1 / (24 * 60 * 60))';
      LV_sSql:=LV_sSql||'WHERE ROWID = '||LV_ROWID||';  ';
      UPDATE GA_INTARCEL
           SET FEC_HASTA = TO_DATE(SYSDATE,'DD-MM-YYYY  HH24:MI:SS') - (1 / (24 * 60 * 60))
      WHERE ROWID = LV_ROWID;

    LV_sSql:='INSERT INTO GA_INTARCEL (COD_CLIENTE,NUM_ABONADO,IND_NUMERO,FEC_DESDE,FEC_HASTA,IMP_LIMCONSUMO,IND_FRIENDS,IND_DIASESP,COD_CELDA,TIP_PLANTARIF,COD_PLANTARIF,NUM_SERIE,NUM_CELULAR,COD_CARGOBASICO,COD_CICLO,COD_PLANCOM,COD_PLANSERV,COD_GRPSERV,COD_GRUPO,COD_PORTADOR,COD_USO,NUM_IMSI,NUM_MIN_MDN) ';
    LV_sSql:=LV_sSql||' VALUES ('||to_char(LN_COD_CLIENTE)||', ';
    LV_sSql:=LV_sSql||' '||to_char(LN_NUM_ABONADO)||',         ';
    LV_sSql:=LV_sSql||' '||to_char(LN_IND_NUMERO)||',          ';
    LV_sSql:=LV_sSql||' TO_DATE(TO_CHAR('||SYSDATE||','||CHR(39)||'DD-MM-YYYY HH24:MI:SS'||CHR(39)||'),'||chr(39)||'DD-MM-YYYY HH24:MI:SS'||chr(39)||'), ';
    LV_sSql:=LV_sSql||' TO_DATE('||chr(39)||'31-12-3000 23:59:59'||chr(39)||','||chr(39)||'DD-MM-YYYY HH24:MI:SS'||chr(39)||'), ';
    LV_sSql:=LV_sSql||' '||to_char(LN_IMP_LIMCONSUMO)||',      ';
    LV_sSql:=LV_sSql||' '||to_char(LN_IND_FRIENDS)||',         ';
    LV_sSql:=LV_sSql||' '||to_char(LN_IND_DIASESP)||',         ';
    LV_sSql:=LV_sSql||' '||LV_COD_CELDA||',                    ';
    LV_sSql:=LV_sSql||' '||Reg_TA_PLANTARIF(1).TIP_PLANTARIF||',                ';
    LV_sSql:=LV_sSql||' '||EO_PlanesTarifarios.COD_PLANTARIF_NUEVO||',                ';
    LV_sSql:=LV_sSql||' '||LV_NUM_SERIE||',                    ';
    LV_sSql:=LV_sSql||' '||to_char(LN_NUM_CELULAR)||',         ';
    LV_sSql:=LV_sSql||' '||Reg_TA_PLANTARIF(1).COD_CARGOBASICO||',              ';
    LV_sSql:=LV_sSql||' '||to_char(LN_COD_CICLO)||',           ';
    LV_sSql:=LV_sSql||' '||to_char(LN_COD_PLANCOM)||',         ';
    LV_sSql:=LV_sSql||' '||LV_COD_PLANSERV||',                 ';
    LV_sSql:=LV_sSql||' '||LV_COD_GRPSERV||',                  ';
    LV_sSql:=LV_sSql||' '||to_char(LN_COD_GRUPO)||',           ';
    LV_sSql:=LV_sSql||' '||to_char(LN_COD_PORTADOR)||',        ';
    LV_sSql:=LV_sSql||' '||to_char(LN_COD_USO)||',             ';
    LV_sSql:=LV_sSql||' '||LV_NUM_IMSI||');                 ';

    INSERT INTO GA_INTARCEL (COD_CLIENTE,NUM_ABONADO,IND_NUMERO,FEC_DESDE,FEC_HASTA,IMP_LIMCONSUMO,IND_FRIENDS,IND_DIASESP,COD_CELDA,TIP_PLANTARIF,COD_PLANTARIF,NUM_SERIE,NUM_CELULAR,COD_CARGOBASICO,COD_CICLO,COD_PLANCOM,COD_PLANSERV,COD_GRPSERV,COD_GRUPO,COD_PORTADOR,COD_USO,NUM_IMSI)
    VALUES (SN_COD_CLIENTE,
      SN_NUM_ABONADO,
      LN_IND_NUMERO,
      TO_DATE(TO_CHAR(SYSDATE,'DD-MM-YYYY HH24:MI:SS'),'DD-MM-YYYY HH24:MI:SS'),
      TO_DATE('31-12-3000 23:59:59','DD-MM-YYYY HH24:MI:SS'),
      LN_IMP_LIMCONSUMO,
      LN_IND_FRIENDS,
      LN_IND_DIASESP,
      LV_COD_CELDA,
      Reg_TA_PLANTARIF(1).TIP_PLANTARIF,
      EO_PlanesTarifarios.COD_PLANTARIF_NUEVO,
      LV_NUM_SERIE,
      LN_NUM_CELULAR,
      Reg_TA_PLANTARIF(1).COD_CARGOBASICO,
      LN_COD_CICLO,
      LN_COD_PLANCOM,
      LV_COD_PLANSERV,
      LV_COD_GRPSERV,
      LN_COD_GRUPO,
      LN_COD_PORTADOR,
      LN_COD_USO,
      LV_NUM_IMSI);
  END IF;
  RETURN TRUE;

    EXCEPTION
    WHEN OTHERS THEN
       SN_cod_retorno := 1375;
       IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := CV_error_no_clasif;
       END IF;
    LV_des_error   := SQLERRM||' PV_Ins_GA_ABOCEL_FN('||to_char(LN_NUM_ABONADO)||'); Problemas al Insertar en Interfase Abonados/Tarificacion GA_INTARCEL ' || SQLERRM;
       SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_DATOS_ABONADO_PG.PV_Ins_GA_ABOCEL_FN', LV_sSQL, SN_cod_retorno, LV_des_error );
    RETURN FALSE;

END PV_Ins_GA_ABOCEL_FN;

------------------------------------------------------------------------------------------------------
FUNCTION PV_EsHibrido_FN(EO_PlanesTarifarios IN         PV_PLANES_TARIFARIOS_QT,
        SN_cod_retorno       OUT NOCOPY  ge_errores_td.cod_msgerror%TYPE,
               SV_mens_retorno      OUT NOCOPY  ge_errores_td.det_msgerror%TYPE,
               SN_num_evento        OUT NOCOPY  ge_errores_pg.evento)
RETURN BOOLEAN
IS
/*
 <Documentacion TipoDoc = "Funcion">
 <Elemento Nombre = " FUNCION   PV_EsHibrido_FN "
  Lenguaje="PL/SQL" Fecha="23-07-2007"
  Versión"1.0.0" Diseñador"****"
  Programador="" Ambiente="BD">
 <Retorno>NA</Retorno>
 <Descripcion>  Funcion Booleana que rescata Codigo Tipo PlanTarifario    </Descripcion>
 <Parametros>
 <Entrada>
   <param Registro="Reg_TA_PLANTARIF"       Tipo=" PV_TIPOS_PG.TIP_TA_PLANTARIF  "> </param>>
   <param Registro="EO_PlanesTarifarios"    Tipo=" gPV_PlanesTarifarios_QT "> </param>>

 </Entrada>
 <Salida>
           <param nom="Reg_TA_PLANTARIF" Tipo="VARCHAR2(5)">Retorna Registro   </param>>
           <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno </param>>
           <param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento     </param>>
 </Salida>
 </Parametros>
 </Elemento>
 </Documentacion>
*/
 LV_des_error      ge_errores_pg.DesEvent;
 LV_sSql        ge_errores_pg.vQuery;
 ERROR_EJECUCION   EXCEPTION;
 LN_COD_CLIENTE       ga_intarcel.cod_cliente%TYPE;
 LN_NUM_ABONADO       ga_intarcel.num_abonado%TYPE;
 EO_GED_PARAMETROS    PV_GED_PARAMETROS_QT;
 Reg_TA_PLANTARIF  PV_TIPOS_PG.TIP_TA_PLANTARIF;

 BEGIN
     SN_cod_retorno := 0;
     SV_mens_retorno:= NULL;
     SN_num_evento:= 0;

  Reg_TA_PLANTARIF(1).COD_TIPLAN      := EO_PlanesTarifarios.COD_TIPLAN;
  Reg_TA_PLANTARIF(1).COD_CARGOBASICO := null;
  Reg_TA_PLANTARIF(1).COD_LIMCONSUMO  := null;
  Reg_TA_PLANTARIF(1).TIP_PLANTARIF := null;
  Reg_TA_PLANTARIF(1).COD_PLANTARIF   := EO_PlanesTarifarios.COD_PLANTARIF;

  LV_sSql:=' EO_GED_PARAMETROS.NOM_PARAMETRO :='|| CV_tip_plan_hibrido||';';
  LV_sSql:=LV_sSql||' EO_GED_PARAMETROS.COD_MODULO    :='|| CV_cod_modulo||';';
  LV_sSql:=LV_sSql||' PV_GENERALES_PG.PV_OBTIENE_GED_PARAMETROS_PR (EO_GED_PARAMETROS,SN_cod_retorno,SV_mens_retorno,SN_num_evento);';

  EO_GED_PARAMETROS:= PV_INICIA_ESTRUCTURAS_PG.PV_GED_PARAMETROS_QT_FN;
  EO_GED_PARAMETROS.NOM_PARAMETRO := CV_tip_plan_hibrido;
  EO_GED_PARAMETROS.COD_MODULO    := CV_cod_modulo;
  EO_GED_PARAMETROS.COD_PRODUCTO  := CN_producto;
  PV_GENERALES_PG.PV_OBTIENE_GED_PARAMETROS_PR (EO_GED_PARAMETROS, SN_cod_retorno, SV_mens_retorno, SN_num_evento);
     IF SN_cod_retorno>0 THEN
        RAISE ERROR_EJECUCION;
  END IF;

  IF  Reg_TA_PLANTARIF(1).COD_TIPLAN  = EO_GED_PARAMETROS.VAL_PARAMETRO THEN
   IF PV_OBT_Limconsumo_CargBas_FN (EO_PlanesTarifarios, Reg_TA_PLANTARIF, SN_cod_retorno, SV_mens_retorno, SN_num_evento) = FALSE THEN
    RAISE  ERROR_EJECUCION;
   END IF;

   LN_NUM_ABONADO := EO_PlanesTarifarios.NUM_ABONADO;
   LN_COD_CLIENTE := EO_PlanesTarifarios.COD_CLIENTE;

   IF PV_ActualizaHibrido_FN (EO_PlanesTarifarios, Reg_TA_PLANTARIF, SN_cod_retorno, SV_mens_retorno, SN_num_evento) = FALSE THEN
    RAISE  ERROR_EJECUCION;
   END IF;
   IF PV_Ins_GA_ABOCEL_FN (EO_PlanesTarifarios, LN_COD_CLIENTE, LN_NUM_ABONADO, Reg_TA_PLANTARIF, SN_cod_retorno, SV_mens_retorno, SN_num_evento) = FALSE THEN
    RAISE  ERROR_EJECUCION;
   END IF;

  END IF;
  RETURN TRUE;

    EXCEPTION
 WHEN ERROR_EJECUCION THEN
    LV_des_error   := 'PV_EsHibrido_FN('||EO_PlanesTarifarios.COD_PLANTARIF||','||EO_PlanesTarifarios.COD_TIPLAN||'); '||SQLERRM;
       SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_DATOS_ABONADO_PG.PV_EsHibrido_FN', LV_sSQL, SN_cod_retorno, LV_des_error );
    RETURN FALSE;
    WHEN OTHERS THEN
       SN_cod_retorno := 156;
       IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := CV_error_no_clasif;
       END IF;
    LV_des_error   := 'PV_EsHibrido_FN('||EO_PlanesTarifarios.COD_PLANTARIF||','||EO_PlanesTarifarios.COD_TIPLAN||'); - ' || SQLERRM;
       SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_DATOS_ABONADO_PG.PV_EsHibrido_FN', LV_sSQL, SN_cod_retorno, LV_des_error );
    RETURN FALSE;

END PV_EsHibrido_FN;

------------------------------------------------------------------------------------------------------
PROCEDURE PV_CONSULTA_HIBRIDO_PR(EO_PlanesTarifarios   IN             PV_PLANES_TARIFARIOS_QT,
         SN_cod_retorno          OUT NOCOPY     ge_errores_td.cod_msgerror%TYPE,
         SV_mens_retorno         OUT NOCOPY     ge_errores_td.det_msgerror%TYPE,
         SN_num_evento           OUT NOCOPY  ge_errores_pg.evento)
IS
/*
 <Documentación
   TipoDoc = "Procedure">>
    <Elemento
       Nombre = "PV_CONSULTA_HIBRIDO_PR"
       Lenguaje="PL/SQL"
       Fecha="23-07-2007"
       Versión="La del package"
       Diseñador=" Maricel "
       Programador=" CEC  "
       Ambiente Desarrollo="BD">
       <Retorno>N/A</Retorno>>
       <Descripción></Descripción>>
       <Parámetros>
          <Entrada>
             <param nom="EO_PLANESTARIFARIOS" Tipo="estructura">estructura para datos de plantarifario </param>>
          </Entrada>
          <Salida>
             <param nom="" Tipo=""></param>>
             <param nom="SN_cod_retorno" Tipo="NUMERICO">Codigo de Retorno</param>>
             <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>>
             <param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>>
          </Salida>
       </Parámetros>
    </Elemento>
 </Documentación>
 */
  LV_des_error            ge_errores_pg.DesEvent;
  LV_sSql           ge_errores_pg.vQuery;
  ERROR_EJECUCION           EXCEPTION;
  ERROR_GENERICO           EXCEPTION;
 BEGIN
  SN_cod_retorno  := 0;
  SV_mens_retorno := NULL;
  SN_num_evento  := 0;

  LV_sSql:='PV_EsHibrido_FN('||EO_PlanesTarifarios.COD_PLANTARIF||','||EO_PlanesTarifarios.COD_TIPLAN||','||EO_PlanesTarifarios.NUM_ABONADO||','|| EO_PlanesTarifarios.COD_CLIENTE||',SN_cod_retorno,SV_mens_retorno, SN_num_evento)';
  IF  PV_EsHibrido_FN(EO_PlanesTarifarios,SN_cod_retorno,SV_mens_retorno, SN_num_evento) = FALSE THEN
   RAISE ERROR_EJECUCION;
  END IF;

 EXCEPTION
    WHEN ERROR_EJECUCION THEN
          LV_des_error   := 'PV_CONSULTA_HIBRIDO_PR('||EO_PlanesTarifarios.COD_PLANTARIF||','||EO_PlanesTarifarios.COD_TIPLAN||','||EO_PlanesTarifarios.NUM_ABONADO||','|| EO_PlanesTarifarios.COD_CLIENTE||'); '||SQLERRM;
          SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_DATOS_ABONADO_PG.PV_CONSULTA_HIBRIDO_PR', LV_sSQL, SN_cod_retorno, LV_des_error );
 WHEN OTHERS THEN
       SN_cod_retorno := 156;
       IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := CV_error_no_clasif;
       END IF;
    LV_des_error   := 'PV_CONSULTA_HIBRIDO_PR('||EO_PlanesTarifarios.COD_PLANTARIF||','||EO_PlanesTarifarios.COD_TIPLAN||','||EO_PlanesTarifarios.NUM_ABONADO||','|| EO_PlanesTarifarios.COD_CLIENTE||'); '||SQLERRM;
       SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_DATOS_ABONADO_PG.PV_CONSULTA_HIBRIDO_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

END PV_CONSULTA_HIBRIDO_PR;

------------------------------------------------------------------------------------------------------
PROCEDURE PV_ACTUAL_PLANSERV_PR (EO_SERVDEFAULT_PLAN IN OUT NOCOPY  PV_SERVDEFAULT_PLAN_QT,
            SN_cod_retorno         OUT NOCOPY   ge_errores_td.cod_msgerror%TYPE,
            SV_mens_retorno        OUT NOCOPY   ge_errores_td.det_msgerror%TYPE,
            SN_num_evento          OUT NOCOPY   ge_errores_pg.evento)
IS
/*
 <Documentación
   TipoDoc = "Procedure">>
    <Elemento
       Nombre = "PV_ACTUAL_PLANSERV_PR  "
       Lenguaje="PL/SQL"
       Fecha="02-08-2007"
       Versión="La del package"
       Diseñador=""
       Programador="Carlos Elizondo"
       Ambiente Desarrollo="BD">
       <Retorno>N/A</Retorno>>
       <Descripción>Metodo  :  Obterner cambio de Plantarifario Servicio    </Descripción>>
       <Parámetros>
          <Entrada>
             <param nom="EO_SERVDEFAULT_PLAN"        Tipo="estructura">estructura Type de Datos  </param>>
          </Entrada>
          <Salida>
             <param nom="SN_cod_retorno"      Tipo="NUMERICO">Codigo de Retorno     </param>>
             <param nom="SV_mens_retorno"      Tipo="CARACTER">Mensaje de Retorno     </param>>
             <param nom="SN_num_evento" T     ipo="NUMERICO">Numero de Evento      </param>>
          </Salida>
       </Parámetros>
    </Elemento>
 </Documentación>
 */
  LV_des_error  ge_errores_pg.DesEvent;
  LV_sSql    ge_errores_pg.vQuery;
 BEGIN
     sn_cod_retorno  := 0;
     sv_mens_retorno := NULL;
     sn_num_evento   := 0;

   LV_sSql:='';
  LV_sSql:=LV_sSql||'UPDATE GA_ABOAMIST  SET  COD_PLANSERV = '||EO_SERVDEFAULT_PLAN.COD_PLANTARIF_NUEVO||' ';
  LV_sSql:=LV_sSql||' WHERE NUM_ABONADO  = '||to_char(EO_SERVDEFAULT_PLAN.NUM_ABONADO)||'; ';

  UPDATE GA_ABOAMIST SET  COD_PLANSERV  = EO_SERVDEFAULT_PLAN.COD_PLANTARIF_NUEVO
  WHERE NUM_ABONADO  = EO_SERVDEFAULT_PLAN.NUM_ABONADO;

 EXCEPTION
   WHEN OTHERS THEN
       SN_cod_retorno := 156;
       IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := CV_error_no_clasif;
       END IF;
       LV_des_error   := 'PV_ACTUAL_PLANSERV_PR ('||to_char(EO_SERVDEFAULT_PLAN.NUM_ABONADO)||'); '||SQLERRM;
       SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_DATOS_ABONADO_PG.PV_ACTUAL_PLANSERV_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

END PV_ACTUAL_PLANSERV_PR;


--------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE PR_VENTA_S_PR(EO_Venta_Abonado    IN     GA_VENTA_QT,
         SO_Lista_Abonado    OUT NOCOPY refCursor,
         SN_cod_retorno      OUT NOCOPY   ge_errores_td.cod_msgerror%TYPE,
         SV_mens_retorno     OUT NOCOPY   ge_errores_td.det_msgerror%TYPE,
         SN_num_evento       OUT NOCOPY ge_errores_pg.evento)
IS
/*
 <Documentación
   TipoDoc = "Procedure">>
    <Elemento
       Nombre = "PR_VENTA_S_PR
       Lenguaje="PL/SQL"
       Fecha="18-07-2007"
       Versión="La del package"
       Diseñador="Andrés Osorio"
       Programador="Hilda Quezada"
       Ambiente Desarrollo="BD">
       <Retorno>N/A</Retorno>>
       <Descripción></Descripción>>
       <Parámetros>
          <Entrada>
             <param nom="EN_num_venta" Tipo="estructura">Numero de Venta</param>>
          </Entrada>
          <Salida>
             <param nom="SO_Lista_Abonado" Tipo="Cursor">Lista de Abonados</param>>
             <param nom="SN_cod_retorno" Tipo="NUMERICO">Codigo de Retorno</param>>
             <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>>
             <param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>>
          </Salida>
       </Parámetros>
    </Elemento>
 </Documentación>
*/
 LV_des_error    ge_errores_pg.DesEvent;
 LV_sSql      ge_errores_pg.vQuery;
 v_contador     number(9);

  BEGIN
         SN_cod_retorno  := 0;
         SV_mens_retorno := ' ';
         SN_num_evento  := 0;

   LV_sSql:='SELECT  a.num_abonado, a.num_celular,d.nom_usuario || '||chr(39)||' '||chr(39)||'|| d.nom_apellido1 || '||chr(39)||' '||chr(39)||' || nvl(d.nom_apellido2,'||chr(39)||''||chr(39)||') AS nombre, ';
   LV_sSql:=LV_sSql||'a.cod_plantarif, ';
   LV_sSql:=LV_sSql||'b.des_plantarif, ';
   LV_sSql:=LV_sSql||'DECODE(a.tip_plantarif,'||chr(39)||'E'||chr(39)||','||chr(39)||'EMPRESA'||chr(39)||','||chr(39)||'I'||chr(39)||','||chr(39)||'INDIVIDUAL'||chr(39)||') AS des_tipplantarif, ';
   LV_sSql:=LV_sSql||'a.tip_terminal,';
   LV_sSql:=LV_sSql||'a.cod_central,';
   LV_sSql:=LV_sSql||'a.num_serie,';
   LV_sSql:=LV_sSql||'a.num_imei,';
   LV_sSql:=LV_sSql||'a.cod_tecnologia,';
   LV_sSql:=LV_sSql||'a.cod_situacion,';
   LV_sSql:=LV_sSql||'c.des_situacion,';
   LV_sSql:=LV_sSql||'b.cod_cargobasico,';
   LV_sSql:=LV_sSql||'e.des_cargobasico,';
   LV_sSql:=LV_sSql||'e.imp_cargobasico,';
   LV_sSql:=LV_sSql||'b.cod_prod_padre,';
   LV_sSql:=LV_sSql||'b.cod_tiplan, ';
   LV_sSql:=LV_sSql||'a.cod_prestacion ';
   LV_sSql:=LV_sSql||'FROM ga_abocel  a,';
   LV_sSql:=LV_sSql||'ta_plantarif    b,';
   LV_sSql:=LV_sSql||'ga_situabo      c,';
   LV_sSql:=LV_sSql||'ga_usuarios     d,';
   LV_sSql:=LV_sSql||'ta_cargosbasico e ';
   LV_sSql:=LV_sSql||'WHERE  a.num_venta ='||EO_Venta_Abonado.NUM_VENTA||' ';
   LV_sSql:=LV_sSql||'and a.cod_plantarif = b.cod_plantarif ';
   LV_sSql:=LV_sSql||'AND a.cod_situacion = c.cod_situacion ';
   LV_sSql:=LV_sSql||'AND a.cod_situacion NOT IN ('||chr(39)||'BAA'||chr(39)||','||chr(39)||'BAP'||chr(39)||') ';
   LV_sSql:=LV_sSql||'AND d.cod_usuario =  a.cod_usuario ';
   LV_sSql:=LV_sSql||'AND a.cod_producto = e.cod_producto ';
   LV_sSql:=LV_sSql||'AND e.cod_cargobasico = b.cod_cargobasico ';
   LV_sSql:=LV_sSql||'AND SYSDATE BETWEEN e.fec_desde AND e.fec_hasta ';
   LV_sSql:=LV_sSql||' UNION ';
   LV_sSql:=LV_sSql||' SELECT  a.num_abonado, ';
   LV_sSql:=LV_sSql||'a.num_celular,';
   LV_sSql:=LV_sSql||'d.nom_usuario ||'||chr(39)||' '||chr(39)||'|| d.nom_apellido1 ||'||chr(39)||' '||chr(39)||' || nvl(d.nom_apellido2,'||chr(39)||''||chr(39)||') AS nombre, ';
   LV_sSql:=LV_sSql||'a.cod_plantarif,';
   LV_sSql:=LV_sSql||'b.des_plantarif,';
   LV_sSql:=LV_sSql||'DECODE(a.tip_plantarif,'||chr(39)||'E'||chr(39)||','||chr(39)||'EMPRESA'||chr(39)||','||chr(39)||'I'||chr(39)||','||chr(39)||'INDIVIDUAL'||chr(39)||') AS des_tipplantarif,';
   LV_sSql:=LV_sSql||'a.tip_terminal,';
   LV_sSql:=LV_sSql||'a.cod_central,';
   LV_sSql:=LV_sSql||'a.num_serie,';
   LV_sSql:=LV_sSql||'a.num_imei,';
   LV_sSql:=LV_sSql||'a.cod_tecnologia,';
   LV_sSql:=LV_sSql||'a.cod_situacion,';
   LV_sSql:=LV_sSql||'c.des_situacion,';
   LV_sSql:=LV_sSql||'b.cod_cargobasico,';
   LV_sSql:=LV_sSql||'e.des_cargobasico,';
   LV_sSql:=LV_sSql||'e.imp_cargobasico,';
   LV_sSql:=LV_sSql||'b.cod_prod_padre, ';
   LV_sSql:=LV_sSql||'b.cod_tiplan, ';
   LV_sSql:=LV_sSql||'a.cod_prestacion ';
   LV_sSql:=LV_sSql||'FROM ga_aboamist a, ';
   LV_sSql:=LV_sSql||'ta_plantarif b, ';
   LV_sSql:=LV_sSql||'ga_situabo c, ';
   LV_sSql:=LV_sSql||'ga_usuarios d, ';
   LV_sSql:=LV_sSql||'ta_cargosbasico e ';
   LV_sSql:=LV_sSql||'WHERE  a.num_venta ='||EO_Venta_Abonado.num_venta||' ';
   LV_sSql:=LV_sSql||'AND a.cod_plantarif = b.cod_plantarif ';
   LV_sSql:=LV_sSql||'AND a.cod_situacion = c.cod_situacion ';
   LV_sSql:=LV_sSql||'AND a.cod_situacion NOT IN ('||chr(39)||'BAA'||chr(39)||','||chr(39)||'BAP'||chr(39)||') ';
   LV_sSql:=LV_sSql||' AND d.cod_usuario = a.cod_usuario ';
   LV_sSql:=LV_sSql||'AND a.cod_producto = e.cod_producto ';
   LV_sSql:=LV_sSql||'AND e.cod_cargobasico = b.cod_cargobasico ';
   LV_sSql:=LV_sSql||'AND SYSDATE BETWEEN e.fec_desde AND e.fec_hasta; ';

   OPEN SO_Lista_Abonado FOR
   SELECT  a.num_abonado,
     a.num_celular,
     d.nom_usuario || ' ' || d.nom_apellido1 || ' ' || nvl(d.nom_apellido2,'') AS nombre,
     a.cod_plantarif,
     b.des_plantarif,
     DECODE(a.tip_plantarif,'E','EMPRESA', 'I', 'INDIVIDUAL') AS des_tipplantarif,
     a.tip_terminal,
     a.cod_central,
     a.num_serie,
     a.num_imei,
     a.cod_tecnologia,
     a.cod_situacion,
     c.des_situacion,
     b.cod_cargobasico,
     e.des_cargobasico,
     e.imp_cargobasico,
     b.cod_prod_padre,
     b.cod_tiplan,
     a.cod_prestacion
     FROM ga_abocel a,
       ta_plantarif b,
       ga_situabo c,
       ga_usuarios d,
       ta_cargosbasico e
     WHERE  a.num_venta = EO_Venta_Abonado.NUM_VENTA
        and a.cod_plantarif = b.cod_plantarif
        and a.cod_situacion = c.cod_situacion
        AND a.cod_situacion NOT IN ('BAA','BAP')
        AND d.cod_usuario = a.cod_usuario
        AND a.cod_producto = e.cod_producto
        AND e.cod_cargobasico = b.cod_cargobasico
        AND SYSDATE BETWEEN e.fec_desde AND e.fec_hasta
   UNION
   SELECT  a.num_abonado,
     a.num_celular,
     d.nom_usuario || ' ' || d.nom_apellido1 || ' ' || nvl(d.nom_apellido2,'') AS nombre,
     a.cod_plantarif,
     b.des_plantarif,
     DECODE(a.tip_plantarif,'E','EMPRESA', 'I', 'INDIVIDUAL') AS des_tipplantarif,
     a.tip_terminal,
     a.cod_central,
     a.num_serie,
     a.num_imei,
     a.cod_tecnologia,
     a.cod_situacion,
     c.des_situacion,
     b.cod_cargobasico,
     e.des_cargobasico,
     e.imp_cargobasico,
     b.cod_prod_padre,
     b.cod_tiplan,
     a.cod_prestacion
     FROM ga_aboamist a,
       ta_plantarif b,
       ga_situabo c,
       ga_usuarios d,
       ta_cargosbasico e
     WHERE  a.num_venta = EO_Venta_Abonado.num_venta
        and a.cod_plantarif = b.cod_plantarif
        and a.cod_situacion = c.cod_situacion
        AND a.cod_situacion NOT IN ('BAA','BAP')
        AND d.cod_usuario = a.cod_usuario
        AND a.cod_producto = e.cod_producto
        AND e.cod_cargobasico = b.cod_cargobasico
        AND SYSDATE BETWEEN e.fec_desde AND e.fec_hasta;

EXCEPTION
 WHEN NO_DATA_FOUND THEN
       SN_cod_retorno := 149;
       IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := CV_error_no_clasif;
       END IF;
    LV_des_error   := 'PR_VENTA_S_PR('||EO_Venta_Abonado.num_venta ||'); '||SQLERRM;
       SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_DATOS_ABONADO_PG.PR_VENTA_S_PR', LV_sSQL, SN_cod_retorno, LV_des_error );
 WHEN OTHERS THEN
       SN_cod_retorno := 156;
       IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := CV_error_no_clasif;
       END IF;
    LV_des_error   := 'PR_VENTA_S_PR('||EO_Venta_Abonado.num_venta ||'); '||SQLERRM;
       SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_DATOS_ABONADO_PG.PR_VENTA_S_PR', LV_sSQL, SN_cod_retorno, LV_des_error );
END PR_VENTA_S_PR;

-----------------------------------------------------------------------------------------------------
PROCEDURE PV_OBTENER_FEC_CUMPLAN_PR (SO_GA_ABOCEL    IN OUT NOCOPY  PV_GA_ABOCEL_QT,
          SN_cod_retorno     OUT NOCOPY   ge_errores_td.cod_msgerror%TYPE,
          SV_mens_retorno    OUT NOCOPY   ge_errores_td.det_msgerror%TYPE,
          SN_num_evento      OUT NOCOPY   ge_errores_pg.evento)
IS
/*
 <Documentación
   TipoDoc = "Procedure">>
    <Elemento
       Nombre = "PV_OBTENER_FEC_CUMPLAN_PR"
       Lenguaje="PL/SQL"
       Fecha="10-08-2008"
       Versión="La del package"
       Diseñador=""
       Programador="Carlos Elizondo"
       Ambiente Desarrollo="BD">
       <Retorno>N/A</Retorno>>
       <Descripción></Descripción>>
       <Parámetros>
          <Entrada>
             <param nom=" SO_GA_ABOCEL.COD_CLIENTE " Tipo="estructura">estructura de datos  Type       </param>>
          </Entrada>
          <Salida>
             <param nom=" SO_GA_ABOCEL.FEC_CUMPLIMEN "    Tipo="estructura">estructura de datos  Type       </param>>
             <param nom="SN_cod_retorno"         Tipo="NUMERICO">Codigo de Retorno</param>>
             <param nom="SV_mens_retorno"        Tipo="CARACTER">Mensaje de Retorno</param>>
             <param nom="SN_num_evento"          Tipo="NUMERICO">Numero de Evento</param>>
          </Salida>
       </Parámetros>
    </Elemento>
 </Documentación>
*/
  LV_des_error       ge_errores_pg.DesEvent;
  LV_sSql         ge_errores_pg.vQuery;
 BEGIN
  sn_cod_retorno  := 0;
     sv_mens_retorno := NULL;
     sn_num_evento  := 0;
     SO_GA_ABOCEL.FEC_CUMPLIMEN:=NULL;

  LV_sSql:='SELECT FEC_CUMPLAN INTO SO_GA_ABOCEL.FEC_CUMPLIMEN FROM GA_ABOCEL ';
  LV_sSql:=' WHERE COD_CLIENTE = '||SO_GA_ABOCEL.COD_CLIENTE||' ';
  LV_sSql:=' AND ROWNUM = 1; ';

  SELECT FEC_CUMPLAN
  INTO SO_GA_ABOCEL.FEC_CUMPLAN
  FROM GA_ABOCEL
  WHERE COD_CLIENTE = SO_GA_ABOCEL.COD_CLIENTE
  AND ROWNUM = 1;

 EXCEPTION
 WHEN NO_DATA_FOUND THEN
   SO_GA_ABOCEL.FEC_CUMPLAN:=null;
   WHEN OTHERS THEN
       SN_cod_retorno := 156;
       IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := CV_error_no_clasif;
       END IF;
    LV_des_error   := 'PV_OBTENER_FEC_CUMPLAN_PR('||SO_GA_ABOCEL.COD_CLIENTE||'); '||SQLERRM;
       SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_DATOS_ABONADO_PG.PV_OBTENER_FEC_CUMPLAN_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

END PV_OBTENER_FEC_CUMPLAN_PR;

-----------------------------------------------------------------------------------------------------
PROCEDURE PV_MIGRAR_ABONADO_PR (SO_GA_ABOCEL   IN     PV_GA_ABOCEL_QT,
           SN_cod_retorno      OUT NOCOPY   ge_errores_td.cod_msgerror%TYPE,
           SV_mens_retorno     OUT NOCOPY   ge_errores_td.det_msgerror%TYPE,
           SN_num_evento       OUT NOCOPY   ge_errores_pg.evento)
IS
/*
 <Documentación
   TipoDoc = "Procedure">>
    <Elemento
       Nombre = "PV_MIGRAR_ABONADO_PR   "
       Lenguaje="PL/SQL"
       Fecha="08-08-2007"
       Versión="La del package"
       Diseñador=""
       Programador="Carlos Elizondo"
       Ambiente Desarrollo="BD">
       <Retorno>N/A</Retorno>>
       <Descripción>Metodo  :  Insertar  datos en Abocel    </Descripción>>
       <Parámetros>
          <Entrada>
             <param nom="SO_ABONADO "    Tipo="Estructura de Type ">   Datos de Estructura Type   </param>>
          </Entrada>
          <Salida>
             <param nom="SN_cod_retorno"    Tipo="NUMERICO">Codigo de Retorno     </param>>
             <param nom="SV_mens_retorno"    Tipo="CARACTER">Mensaje de Retorno     </param>>
             <param nom="SN_num_evento"     Tipo="NUMERICO">Numero de Evento     </param>>
          </Salida>
       </Parámetros>
    </Elemento>
 </Documentación>
*/
  LV_des_error            ge_errores_pg.DesEvent;
  LV_sSql                 ge_errores_pg.vQuery;
  ERROR_EJECUCION         EXCEPTION;
  LD_FEC_PRORROGA         ga_abocel.FEC_PRORROGA%TYPE;
  LV_IND_EQPRESTADO       ga_abocel.IND_EQPRESTADO%TYPE;
  LV_FLG_CONTDIGI         ga_abocel.FLG_CONTDIGI%TYPE;
  LD_FEC_ALTANTRAS        ga_abocel.FEC_ALTANTRAS%TYPE;
  LN_COD_INDEMNIZACION    ga_abocel.COD_INDEMNIZACION%TYPE;
  EO_GED_PARAMETROS       PV_GED_PARAMETROS_QT;
  lv_situacion_altaEnProceso varchar2(3);
  ln_uso_seg                      number(2);
  LN_usuario_aux          ga_abocel.COD_USUARIO%type;
  ln_seq_usuario          ga_abocel.COD_USUARIO%type;
  ln_seq_usuario_aux      ga_abocel.COD_USUARIO%type;
  LN_COD_CUENTA_AUX       GA_ABOCEL.COD_CUENTA%TYPE;
  LV_COD_SUBCUENTA_AUX    GA_ABOCEL.COD_SUBCUENTA%TYPE;
  LV_DES_CUENTA_AUX       GA_CUENTAS.DES_CUENTA%TYPE;
  LN_COD_DIRECCION_AUX    GA_CUENTAS.COD_DIRECCION%TYPE;
  LV_codoficina                   VE_VENDEDORES.COD_OFICINA%TYPE;
  LV_codregion                    GE_DIRECCIONES.COD_REGION%TYPE;
  LV_codprovincia         GE_DIRECCIONES.COD_PROVINCIA%TYPE;
  LV_codciudad                    GE_DIRECCIONES.COD_CIUDAD%TYPE;
  LV_celda                        GE_CELDAS.COD_CELDA%TYPE;
  LN_CANT_COD_USUARIO     NUMBER(2);
  LN_CodDireccion                 ga_direccli.COD_DIRECCION%TYPE;
  LV_nomcliente                   ge_clientes.NOM_CLIENTE%TYPE;
  LV_nomApell1                    ge_clientes.NOM_APECLIEN1%TYPE;
  LV_nomApell2                    ge_clientes.NOM_APECLIEN2%TYPE;
  LV_CodCalClien                  ge_clientes.COD_CALCLIEN%TYPE;
  LN_CreMor                               co_limcreditos.COD_CREDMOR%TYPE;
  LN_CreCon                               co_limconsumo.COD_CREDCON%TYPE;
  LN_COTIPLAN                     ta_plantarif.COD_TIPLAN%TYPE;
  LV_PlanServ                     ga_abocel.COD_PLANSERV%TYPE;
  LN_CodLimCons                   tol_limite_td.COD_LIMCONS%TYPE;
  LV_OfPrincipal                  ge_ciudades.COD_OFICINA_PRINCIPAL%TYPE;
  LV_COD_OPERACION                ga_abocel.COD_OPERACION%TYPE;
  LV_COD_CAUSA_VENTA      ga_abocel.COD_CAUSA_VENTA%TYPE;
  LN_IND_SUPERTEL                 ga_abocel.IND_SUPERTEL%TYPE;
  LV_NUMSERIE                     ga_aboamist.NUM_SERIE%TYPE;
  LV_NUMIMEI                      ga_aboamist.NUM_IMEI%TYPE;
  LN_COD_BODEGA                   ga_equipaboser.COD_BODEGA%TYPE;
  LN_TIP_STOCK                    ga_equipaboser.TIP_STOCK%TYPE;
  LV_INDPROCEQUI          ga_equipaboser.IND_PROCEQUI%TYPE;
  LN_COD_MODVENTA                 ga_equipaboser.COD_MODVENTA%TYPE;
  LN_COD_USO                      ga_equipaboser.COD_USO%TYPE;
  LN_IND_EQPRESTADO       ga_equipaboser.IND_EQPRESTADO%TYPE;
  LN_COD_ESTADO                   ga_equipaboser.COD_ESTADO%TYPE;
  LN_NUM_MOVIMIENTO               ga_equipaboser.NUM_MOVIMIENTO%TYPE;
  LV_VendeRaiz                    ve_vendedores.COD_VENDE_RAIZ%TYPE;
  LV_CountGrpServ                 NUMBER;
  LV_GrpServ                      ga_abocel.COD_GRPSERV%TYPE;
  LN_NumMeses                     NUMBER;
  LN_NumDias                      NUMBER;
  LV_Formato2                     VARCHAR2(50);
  LV_Formato7                     VARCHAR2(50);
  LD_FecFinContrato               ga_Abocel.FEC_FINCONTRA%TYPE;
  LD_FechaAlta                    DATE;
  LN_COD_EMPRESA              ga_empresa.COD_EMPRESA%TYPE;
   LD_FEC_ALTA_EQUIPA             DATE;

   LV_CodTecnologia               ga_aboamist.cod_tecnologia%TYPE;--COL-86751|23-04-2009|GEZ
   LV_NumSerieAux                 ga_equipaboser.num_serie%TYPE;  --COL-86751|23-04-2009|GEZ
   LV_DestalleError                  VARCHAR2(1000);                         --COL-86751|23-04-2009|GEZ

   -- INI COL|85969|10-04-2009|SAQL
   LN_NUM_CELULAR             GA_ABOCEL.NUM_CELULAR%TYPE;
   LN_COD_CICLFACT            FA_CICLFACT.COD_CICLFACT%TYPE;
   D_FEC_BAJA                 DATE := TO_DATE('31-12-3000','DD-MM-YYYY');
   N_IND_ACTUAC               NUMBER := 1;
   N_IND_ALTA                 NUMBER := 1;
   N_IND_DETALLE              NUMBER := 0;
   N_IND_FACTUR               NUMBER := 1;
   N_IND_CUOTAS               NUMBER := 0;
   N_IND_ARRIENDO             NUMBER := 0;
   N_IND_CARGOS               NUMBER := 0;
   N_IND_PENALIZA             NUMBER := 0;
   N_IND_SUPERTEL             NUMBER := 0;
   V_COD_CALCLIE              GE_CLIENTES.COD_CALCLIEN%TYPE;
   V_NOM_USUARIO              FA_CICLOCLI.NOM_USUARIO%TYPE;
   V_NOM_APELLIDO1            FA_CICLOCLI.NOM_APELLIDO1%TYPE;
   V_NOM_APELLIDO2            FA_CICLOCLI.NOM_APELLIDO2%TYPE;
   N_MESES                    NUMBER;
   D_FEC_FINCONTRA            DATE;
   n_cod_uso                  number;
   LV_codPrestacion           GE_PRESTACIONES_TD.COD_PRESTACION%TYPE;
   -- FIN COL|85969|10-04-2009|SAQL
 BEGIN
  sn_cod_retorno                 := 0;
  sv_mens_retorno                := NULL;
  sn_num_evento                  := 0;
  LD_FEC_PRORROGA                :=null;
  LV_IND_EQPRESTADO              :=null;
  LV_FLG_CONTDIGI                :=null;
  LD_FEC_ALTANTRAS               :=null;
  LN_COD_INDEMNIZACION   :=null;
  LV_COD_OPERACION               :=null;
  LV_COD_CAUSA_VENTA     :=null;
  LN_IND_SUPERTEL                :=0;
  LN_COD_BODEGA                  :=null;
  LV_INDPROCEQUI         := 'E';
  LN_COD_ESTADO              :=NULL;
  LN_COD_EMPRESA                 :=NULL;

                   LV_DestalleError := NULL; --COL-86751|23-04-2009|GEZ

                   LV_sSql := 'INICIO'; -- COL-86751|23-04-2009|RRG

   LD_FechaAlta:= TO_DATE(SO_GA_ABOCEL.FEC_ALTA,'DD-MM-YY HH24:MI:SS');

   LV_sSql:='SELECT COD_TIPLAN';
   LV_sSql:=LV_sSql||' FROM TA_PLANTARIF WHERE COD_PLANTARIF='||SO_GA_ABOCEL.COD_PLANTARIF;

   SELECT COD_TIPLAN
   INTO LN_COTIPLAN
   FROM TA_PLANTARIF
   WHERE COD_PLANTARIF =SO_GA_ABOCEL.COD_PLANTARIF;

   IF LN_COTIPLAN = 2 THEN
      ln_uso_seg  := 2;
          LV_PlanServ := '01';
   ELSE
     IF LN_COTIPLAN = 3 THEN
       ln_uso_seg  := 10;
           LV_PlanServ := '02';
         END IF;
   END IF;

  lv_situacion_altaEnProceso := 'AOP';

        BEGIN
          LV_sSql:='SELECT A.COD_LIMCONS';
          LV_sSql:=LV_sSql||' FROM TOL_LIMITE_TD A , TOL_LIMITE_PLAN_TD B';
          LV_sSql:=LV_sSql||' WHERE A.COD_LIMCONS = B.COD_LIMCONS';
          LV_sSql:=LV_sSql||' AND SYSDATE BETWEEN B.FEC_DESDE AND NVL(B.FEC_HASTA, SYSDATE)';
          LV_sSql:=LV_sSql||' AND B.COD_PLANTARIF = '||SO_GA_ABOCEL.COD_PLANTARIF;
          LV_sSql:=LV_sSql||' AND B.IND_DEFAULT = ''S''';

          SELECT A.COD_LIMCONS
           INTO LN_CodLimCons
        FROM TOL_LIMITE_TD A , TOL_LIMITE_PLAN_TD B
        WHERE A.COD_LIMCONS = B.COD_LIMCONS
        AND SYSDATE BETWEEN B.FEC_DESDE AND NVL(B.FEC_HASTA, SYSDATE)
        AND B.COD_PLANTARIF = SO_GA_ABOCEL.COD_PLANTARIF
            AND B.IND_DEFAULT = 'S';
         EXCEPTION
                WHEN NO_DATA_FOUND THEN
                  LN_CodLimCons := -1;
        END;

  --ADAPTACIÓN TEMA USUARIO OCB

                   --LV_sSql := 'SELECT COD_CUENTA, NVL(COD_SUBCUENTA,0), NUM_SERIE, NUM_IMEI';   --COL-86751|23-04-2009|GEZ
                   LV_sSql := 'SELECT cod_cuenta, NVL(cod_subcuenta,0), num_serie, num_imei,cod_tecnologia'; --COL-86751|23-04-2009|GEZ

    LV_sSql:=LV_sSql||' FROM GA_ABOAMIST WHERE NUM_ABONADO = '||SO_GA_ABOCEL.NUM_ABONADO||' AND ROWNUM = 1';

                   --INI COL-86751|23-04-2009|GEZ
                   --SELECT COD_CUENTA, NVL(COD_SUBCUENTA,0), NUM_SERIE, NUM_IMEI
                   --INTO LN_COD_CUENTA_AUX,LV_COD_SUBCUENTA_AUX, LV_NUMSERIE, LV_NUMIMEI
                   SELECT cod_cuenta, NVL(cod_subcuenta,0), num_serie, num_imei,cod_tecnologia
                   INTO LN_COD_CUENTA_AUX,LV_COD_SUBCUENTA_AUX, LV_NUMSERIE, LV_NUMIMEI,LV_CodTecnologia
                   --FIN COL-86751|23-04-2009|GEZ
         FROM  GA_ABOAMIST
          WHERE NUM_ABONADO = SO_GA_ABOCEL.NUM_ABONADO AND ROWNUM = 1;

                   -- INICIO RRG 02-03-2009 COL 77303
                   /*
        LV_sSql:=' SELECT COD_USUARIO';
        LV_sSql:=LV_sSql||'  FROM GA_USUAMIST WHERE NUM_ABONADO = '||SO_GA_ABOCEL.NUM_ABONADO;

        SELECT COD_USUARIO
        INTO LN_SEQ_USUARIO_AUX
        FROM GA_USUAMIST
         WHERE NUM_ABONADO = SO_GA_ABOCEL.NUM_ABONADO;
                   */

                   LV_sSql := ' SELECT COD_USUARIO';
                   LV_sSql := LV_sSql || '  FROM GA_ABOAMIST WHERE NUM_ABONADO = '||SO_GA_ABOCEL.NUM_ABONADO;

                   SELECT COD_USUARIO
                   INTO LN_SEQ_USUARIO_AUX
                   FROM GA_ABOAMIST
                   WHERE NUM_ABONADO = SO_GA_ABOCEL.NUM_ABONADO;

                   -- COL RRG 02-03-2009 COL 77303

        LV_sSql:=' SELECT NOM_CLIENTE, NVL(NOM_APECLIEN1,NOM_CLIENTE), NOM_APECLIEN2, COD_CALCLIEN';
        LV_sSql:=LV_sSql||' FROM GE_CLIENTES WHERE COD_CLIENTE = '||SO_GA_ABOCEL.COD_CLIENTE_NUE;

        SELECT NOM_CLIENTE, NVL(NOM_APECLIEN1,substr(NOM_CLIENTE,1,20)), NOM_APECLIEN2, COD_CALCLIEN
        INTO LV_NOMCLIENTE, LV_NOMAPELL1, LV_NOMAPELL2, LV_CodCalClien
        FROM GE_CLIENTES
        WHERE COD_CLIENTE = SO_GA_ABOCEL.COD_CLIENTE_NUE;

        BEGIN
                LV_sSql:=' SELECT COD_CREDMOR';
                LV_sSql:=LV_sSql||' FROM CO_LIMCREDITOS WHERE COD_CALCLIEN = '''||LV_CodCalClien||'''';
                LV_sSql:=LV_sSql||' AND COD_PRODUCTO = 1 AND ROWNUM = 1';

                SELECT COD_CREDMOR
                INTO LN_CreMor
                FROM CO_LIMCREDITOS WHERE COD_CALCLIEN = LV_CodCalClien
                 AND COD_PRODUCTO = 1
                 AND ROWNUM = 1;
        EXCEPTION
                   WHEN NO_DATA_FOUND THEN
                            LN_CreMor := null;
        END;

        BEGIN
                LV_sSql:=' SELECT COD_CREDCON';
                LV_sSql:=LV_sSql||' FROM CO_LIMCONSUMO WHERE COD_CALCLIEN = '''||LV_CodCalClien||'''';
                LV_sSql:=LV_sSql||' AND COD_PRODUCTO = 1 AND ROWNUM = 1';

                SELECT COD_CREDCON
                 INTO LN_CreCon
                 FROM CO_LIMCONSUMO WHERE COD_CALCLIEN =  LV_CodCalClien
                 AND COD_PRODUCTO = 1
                         AND ROWNUM = 1;
        EXCEPTION
                   WHEN NO_DATA_FOUND THEN
                            LN_CreCon := 0;


                   when others then
                     LV_sSql:=sqlerrm;
        END;

   LV_sSql:='LV_COD_SUBCUENTA_AUX :'||LV_COD_SUBCUENTA_AUX ;
   IF (trim(LV_COD_SUBCUENTA_AUX) = '0' or trim(LV_COD_SUBCUENTA_AUX)  is null)  THEN
                          BEGIN
                          lV_sSql:='SELECT  MIN(COD_SUBCUENTA)';
                                  LV_sSql:=LV_sSql||' FROM  GA_SUBCUENTAS';
                                  LV_sSql:=LV_sSql||' WHERE COD_CUENTA ='|| SO_GA_ABOCEL.COD_CUENTA;

                                  SELECT  MIN(COD_SUBCUENTA)
                              INTO LV_COD_SUBCUENTA_AUX
                               FROM  GA_SUBCUENTAS
                               WHERE COD_CUENTA = SO_GA_ABOCEL.COD_CUENTA;

                              EXCEPTION
                          WHEN NO_DATA_FOUND THEN
                                     IF LV_COD_SUBCUENTA_AUX IS NULL OR LV_COD_SUBCUENTA_AUX = 0 THEN
                                                LV_sSql:='SELECT DES_CUENTA, COD_DIRECCION ';
                                                LV_sSql:=LV_sSql||' FROM GA_CUENTAS WHERE COD_CUENTA = '||SO_GA_ABOCEL.COD_CUENTA;

                                                SELECT DES_CUENTA, COD_DIRECCION
                                                INTO LV_DES_CUENTA_AUX, LN_COD_DIRECCION_AUX
                                                FROM GA_CUENTAS
                                                WHERE COD_CUENTA = SO_GA_ABOCEL.COD_CUENTA;

                                                LV_sSql:='VE_alta_cuenta_PG.VE_insSubCuenta_PR( '||LN_COD_CUENTA_AUX||','||LN_COD_CUENTA_AUX||' + .1, '||LV_DES_CUENTA_AUX||','||LN_COD_DIRECCION_AUX||','||SN_COD_RETORNO||','||SV_MENS_RETORNO||','||SN_NUM_EVENTO||')';
                                                VE_alta_cuenta_PG.VE_insSubCuenta_PR( LN_COD_CUENTA_AUX,LN_COD_CUENTA_AUX + '.1', LV_DES_CUENTA_AUX, LN_COD_DIRECCION_AUX, SN_COD_RETORNO, SV_MENS_RETORNO, SN_NUM_EVENTO);

                                                LV_sSql:='SELECT  MIN(COD_SUBCUENTA)';
                                                LV_sSql:=LV_sSql||'  FROM  GA_SUBCUENTAS WHERE COD_CUENTA ='||SO_GA_ABOCEL.COD_CUENTA;

                                                SELECT  MIN(COD_SUBCUENTA)
                                                INTO LV_COD_SUBCUENTA_AUX
                                                FROM  GA_SUBCUENTAS
                                                WHERE COD_CUENTA = SO_GA_ABOCEL.COD_CUENTA;
                                     END IF;
                          END;
    END IF;

                LV_sSql:='SELECT GA_SEQ_USUARIOS.NEXTVAL FROM DUAL';
                SELECT GA_SEQ_USUARIOS.NEXTVAL INTO ln_seq_usuario FROM DUAL ;--crea secuencia usuario
            LN_USUARIO_AUX :=ln_seq_usuario;


         --*****MAL***----
         --Obtener el nombre y apellido del cliente pospago de la ge_clientes para insertarlos en la ga_usuarios
         --*****MAL***----

     LV_sSql:='INSERT INTO GA_USUARIOS';
     LV_sSql:=LV_sSql||' SELECT ' ||  LN_usuario_aux||','|| SO_GA_ABOCEL.COD_CUENTA||',';
     LV_sSql:=LV_sSql||LV_COD_SUBCUENTA_AUX ||','||LV_nomcliente||',';
     LV_sSql:=LV_sSql||''||LV_nomApell1||', FEC_ALTA ,';
     LV_sSql:=LV_sSql||'COD_TIPIDENT, NUM_IDENT ,';
     LV_sSql:=LV_sSql||'IND_ESTADO, '||LV_nomApell2||',';
     LV_sSql:=LV_sSql||'FEC_NACIMIEN, COD_ESTCIVIL   ,';
     LV_sSql:=LV_sSql||'IND_SEXO, IND_TIPOTRAB,';
     LV_sSql:=LV_sSql||'NOM_EMPRESA, COD_ACTEMP ,';
     LV_sSql:=LV_sSql||'COD_OCUPACION, NUM_PERCARGO,';
     LV_sSql:=LV_sSql||'IMP_BRUTO, IND_PROCOPER,';
     LV_sSql:=LV_sSql||'COD_OPERADOR, NOM_CONYUGE,';
     LV_sSql:=LV_sSql||'COD_PINUSUAR, COD_ESTRATO, EMAIL';
     LV_sSql:=LV_sSql||' FROM GA_USUAMIST WHERE cod_usuario ='|| ln_seq_usuario_AUX;

     LV_sSql:='paso 2:';

     INSERT INTO GA_USUARIOS
                   SELECT LN_usuario_aux, SO_GA_ABOCEL.COD_CUENTA, LV_COD_SUBCUENTA_AUX, LV_nomcliente, LV_nomApell1,
                   FEC_ALTA, COD_TIPIDENT, NUM_IDENT, IND_ESTADO, LV_nomApell2,
                   FEC_NACIMIEN, COD_ESTCIVIL, IND_SEXO, IND_TIPOTRAB, NOM_EMPRESA,
                   COD_ACTEMP, COD_OCUPACION, NUM_PERCARGO, IMP_BRUTO, IND_PROCOPER,
                   COD_OPERADOR, NOM_CONYUGE, COD_PINUSUAR, COD_ESTRATO, EMAIL,NULL
     FROM GA_USUAMIST
     WHERE cod_usuario =ln_seq_usuario_AUX;


  LV_sSql:='SELECT COD_DIRECCION';
  LV_sSql:=LV_sSql||' FROM GA_DIRECCLI WHERE cod_cliente = '||SO_GA_ABOCEL.COD_CLIENTE_NUE;
  LV_sSql:=LV_sSql||'  AND COD_TIPDIRECCION = 1';

  SELECT COD_DIRECCION
  INTO LN_CodDireccion
  FROM GA_DIRECCLI
  WHERE cod_cliente = SO_GA_ABOCEL.COD_CLIENTE_NUE
  AND COD_TIPDIRECCION = 1;


  --LV_sSql:='INSERT INTO GA_DIRECUSUAR (COD_USUARIO,COD_TIPDIRECCION,COD_DIRECCION)';
  --LV_sSql:=LV_sSql||' VALUES ('||LN_USUARIO_AUX||',1, '||LN_CodDireccion||')';

  LV_sSql:='INSERT INTO GA_DIRECUSUAR (COD_USUARIO,COD_TIPDIRECCION,COD_DIRECCION)';
  LV_sSql:=LV_sSql||' VALUES ('||LN_USUARIO_AUX||',2, '||LN_CodDireccion||')';

  LV_sSql:='INSERT INTO GA_DIRECUSUAR (COD_USUARIO,COD_TIPDIRECCION,COD_DIRECCION)';
  LV_sSql:=LV_sSql||' VALUES ('||LN_USUARIO_AUX||',3, '||LN_CodDireccion||')';


  INSERT INTO GA_DIRECUSUAR (COD_USUARIO,COD_TIPDIRECCION,COD_DIRECCION)
  VALUES (LN_USUARIO_AUX, 2, LN_CodDireccion);

  INSERT INTO GA_DIRECUSUAR (COD_USUARIO,COD_TIPDIRECCION,COD_DIRECCION)
  VALUES (LN_USUARIO_AUX, 3, LN_CodDireccion);

  --NOTA SI NO EXISTE EL REGISTRO EN LA GA_USUAMIST ES INCOSISTENCIA EN LA VENTA
   LV_sSql:=' SELECT COD_OFICINA, COD_VENDE_RAIZ FROM VE_VENDEDORES';
   LV_sSql:=LV_sSql||' WHERE COD_VENDEDOR= '||SO_GA_ABOCEL.COD_VENDEDOR;

    SELECT COD_OFICINA, COD_VENDE_RAIZ
    INTO LV_codoficina, LV_VendeRaiz
     FROM VE_VENDEDORES
      WHERE COD_VENDEDOR= SO_GA_ABOCEL.COD_VENDEDOR;

   LV_sSql:=' SELECT B.COD_REGION, B.COD_PROVINCIA, B.COD_CIUDAD FROM GE_OFICINAS A, GE_DIRECCIONES B ';
   LV_sSql:=LV_sSql||' WHERE A.COD_OFICINA = '||LV_codoficina||' AND B.COD_DIRECCION = A.COD_DIRECCION';

     SELECT B.COD_REGION, B.COD_PROVINCIA, B.COD_CIUDAD
     INTO LV_codregion, LV_codprovincia, LV_codciudad
      FROM GE_OFICINAS A, GE_DIRECCIONES B
       WHERE A.COD_OFICINA = LV_codoficina
             AND B.COD_DIRECCION = A.COD_DIRECCION;

   LV_sSql:=' SELECT A.COD_CELDA  FROM GE_CELDAS A, GE_CIUDADES B ';
   LV_sSql:=LV_sSql||' WHERE A.COD_CELDA = B.COD_CELDA AND B.COD_REGION = '||LV_codregion;
   LV_sSql:=LV_sSql||' AND B.COD_PROVINCIA = '||LV_codprovincia||' AND B.COD_CIUDAD    = '||LV_codciudad;

   SELECT A.COD_CELDA
   INTO LV_celda
    FROM GE_CELDAS A, GE_CIUDADES B
     WHERE A.COD_CELDA = B.COD_CELDA
           AND B.COD_REGION    = LV_codregion
           AND B.COD_PROVINCIA = LV_codprovincia
           AND B.COD_CIUDAD    = LV_codciudad;

   LV_sSql:='SELECT PV_OBTENER_OFIPRINC_FN('||LV_codregion||','||LV_codprovincia||','||LV_codciudad||')';
   LV_sSql:=LV_sSql||' FROM DUAL';

   SELECT PV_OBTENER_OFIPRINC_FN(LV_codregion,LV_codprovincia, LV_codciudad)
   INTO LV_OfPrincipal
    FROM DUAL;

        LV_sSql:=' SELECT COUNT(1)  FROM GA_GRPSERV ';
        LV_sSql:=LV_sSql||'WHERE COD_PRODUCTO = 1 AND COD_GRUPO = ''01''';

   SELECT COUNT(1)
   INTO LV_CountGrpServ
    FROM GA_GRPSERV
     WHERE COD_PRODUCTO = 1
                   AND COD_GRUPO = '01';

   IF LV_CountGrpServ > 0 THEN
          LV_GrpServ := '01';
   END IF ;





   IF UPPER(SO_GA_ABOCEL.TIP_PLANTARIF) = 'E' THEN
      LV_sSql:='  SELECT COD_EMPRESA FROM GA_EMPRESA WHERE COD_CLIENTE := '||SO_GA_ABOCEL.COD_CLIENTE_NUE;
      SELECT COD_EMPRESA
       INTO LN_COD_EMPRESA
            FROM GA_EMPRESA
             WHERE COD_CLIENTE = SO_GA_ABOCEL.COD_CLIENTE_NUE;
   ELSE
      LN_COD_EMPRESA := NULL;
   END IF;

   LV_sSql:='SELECT NUM_MESES FROM ga_percontrato';
   LV_sSql:=LV_sSql||' WHERE COD_TIPCONTRATO = ''82''';

   SELECT NUM_MESES
   INTO LN_NumMeses
     FROM ga_percontrato
       WHERE COD_TIPCONTRATO = '82';

   LN_NumDias := (365 * (LN_NumMeses) / 12);

   LV_sSql:='PV_INICIA_ESTRUCTURAS_PG.PV_GED_PARAMETROS_QT_FN';
   EO_GED_PARAMETROS := PV_INICIA_ESTRUCTURAS_PG.PV_GED_PARAMETROS_QT_FN;

    EO_GED_PARAMETROS.NOM_PARAMETRO := CV_gsFormato2;
    EO_GED_PARAMETROS.COD_MODULO    := 'GE';
    EO_GED_PARAMETROS.COD_PRODUCTO  := CN_producto;

    LV_sSql:='PV_GENERALES_PG.PV_OBTIENE_GED_PARAMETROS_PR ('||EO_GED_PARAMETROS.NOM_PARAMETRO||','||EO_GED_PARAMETROS.COD_MODULO||','||EO_GED_PARAMETROS.COD_PRODUCTO||','||SN_cod_retorno||','||SV_mens_retorno||','||SN_num_evento||')';
    PV_GENERALES_PG.PV_OBTIENE_GED_PARAMETROS_PR (EO_GED_PARAMETROS,SN_cod_retorno,SV_mens_retorno,SN_num_evento);

    IF SN_cod_retorno>0 THEN
           RAISE ERROR_EJECUCION;
    END IF;

    LV_Formato2   :=EO_GED_PARAMETROS.VAL_PARAMETRO;

        LV_sSql:='PV_INICIA_ESTRUCTURAS_PG.PV_GED_PARAMETROS_QT_FN';
    EO_GED_PARAMETROS := PV_INICIA_ESTRUCTURAS_PG.PV_GED_PARAMETROS_QT_FN;

    EO_GED_PARAMETROS.NOM_PARAMETRO := CV_gsFormato7;
    EO_GED_PARAMETROS.COD_MODULO    := 'GE';
    EO_GED_PARAMETROS.COD_PRODUCTO  := CN_producto;

    LV_sSql:='PV_GENERALES_PG.PV_OBTIENE_GED_PARAMETROS_PR ('||EO_GED_PARAMETROS.NOM_PARAMETRO||','||EO_GED_PARAMETROS.COD_MODULO||','||EO_GED_PARAMETROS.COD_PRODUCTO||','||SN_cod_retorno||','||SV_mens_retorno||','||SN_num_evento||')';

    PV_GENERALES_PG.PV_OBTIENE_GED_PARAMETROS_PR (EO_GED_PARAMETROS,SN_cod_retorno,SV_mens_retorno,SN_num_evento);

    IF SN_cod_retorno>0 THEN
           RAISE ERROR_EJECUCION;
    END IF;

    LV_Formato7   :=EO_GED_PARAMETROS.VAL_PARAMETRO;

                   /* INI COL 84509|31-03-2009|SAQL
    LV_sSql:='SELECT TO_DATE(TO_CHAR('''||LD_FechaAlta||' + '||LN_NumDias||','''|| LV_Formato2 || ' '  ||LV_Formato7||'''),'''|| LV_Formato2 || ' '  ||LV_Formato7||''') FROM dual';

        SELECT TO_DATE(TO_CHAR(LD_FechaAlta + LN_NumDias, LV_Formato2 || ' '  ||LV_Formato7), LV_Formato2 || ' ' ||LV_Formato7)
         INTO LD_FecFinContrato
          FROM dual;
                   */

                   ---LD_FechaAlta := LD_FechaAlta + LN_NumDias;

                   LD_FecFinContrato := LD_FechaAlta + LN_NumDias;  --- 11-05-2009 COL 88564

                   /* FIN COL 84509|31-03-2009|SAQL */

   LV_sSql:=' INSERT INTO GA_ABOCEL SELECT '||SO_GA_ABOCEL.ID_SECUENCIA||', ';
   LV_sSql:=LV_sSql||' GA_ABOAMIST.NUM_CELULAR,GA_ABOAMIST.COD_PRODUCTO,'||SO_GA_ABOCEL.COD_CLIENTE_NUE||','||SO_GA_ABOCEL.COD_CUENTA||',';
   LV_sSql:=LV_sSql||' '||LV_COD_SUBCUENTA_AUX||','||LN_usuario_aux||',DECODE(GA_ABOAMIST.COD_REGION,NULL,'||LV_codregion||',GA_ABOAMIST.COD_REGION),DECODE(GA_ABOAMIST.COD_PROVINCIA,NULL,'||LV_codprovincia||',GA_ABOAMIST.COD_PROVINCIA),';
   LV_sSql:=LV_sSql||' GA_ABOAMIST.COD_CIUDAD,DECODE(GA_ABOAMIST.COD_CELDA, NULL,'||LV_celda||', GA_ABOAMIST.COD_CELDA),GA_ABOAMIST.COD_CENTRAL,'||ln_uso_seg||','||lv_situacion_altaEnProceso||',';
   LV_sSql:=LV_sSql||' GA_ABOAMIST.IND_PROCALTA,GA_ABOAMIST.IND_PROCEQUI,'||SO_GA_ABOCEL.COD_VENDEDOR||','||LV_VendeRaiz||','||SO_GA_ABOCEL.TIP_PLANTARIF||',';
   LV_sSql:=LV_sSql||' GA_ABOAMIST.TIP_TERMINAL,'||SO_GA_ABOCEL.COD_PLANTARIF||','||SO_GA_ABOCEL.COD_CARGOBASICO||','||LV_PlanServ||','||LN_CodLimCons||',';
   LV_sSql:=LV_sSql||' GA_ABOAMIST.NUM_SERIE,GA_ABOAMIST.NUM_SERIEHEX,GA_ABOAMIST.NOM_USUARORA,'||SO_GA_ABOCEL.FEC_ALTA||',';
   LV_sSql:=LV_sSql||' '||CN_NUM_PERCONTRATO||',GA_ABOAMIST.COD_ESTADO,GA_ABOAMIST.NUM_SERIEMEC,GA_ABOAMIST.COD_HOLDING,';
   LV_sSql:=LV_sSql||' '||LN_COD_EMPRESA||',DECODE(GA_ABOAMIST.COD_GRPSERV, NULL, '||LV_GrpServ||', GA_ABOAMIST.COD_GRPSERV),'||LN_IND_SUPERTEL||',GA_ABOAMIST.NUM_TELEFIJA,GA_ABOAMIST.COD_OPREDFIJA,';
   LV_sSql:=LV_sSql||' GA_ABOAMIST.COD_CARRIER,0,GA_ABOAMIST.IND_PLEXSYS,GA_ABOAMIST.COD_CENTRAL_PLEX,';
   LV_sSql:=LV_sSql||' GA_ABOAMIST.NUM_CELULAR_PLEX,'||SO_GA_ABOCEL.NUM_VENTA||',';
   LV_sSql:=LV_sSql||' GA_ABOAMIST.COD_MODVENTA,'||CN_COD_TIPCONTRATO||','||SO_GA_ABOCEL.NUM_CONTRATO||','||SO_GA_ABOCEL.NUM_ANEXO||',';
                   -- LV_sSql := LV_sSql || ' SYSDATE,DECODE(GA_ABOAMIST.COD_CREDMOR,NULL, '||LN_CreMor||', GA_ABOAMIST.COD_CREDMOR),DECODE(GA_ABOAMIST.COD_CREDCON,NULL,'||LN_CreCon||', GA_ABOAMIST.COD_CREDCON),'||SO_GA_ABOCEL.COD_CICLO||','; -- COL 84509|31-03-2009|SAQL
                   LV_sSql := LV_sSql || ' SYSDATE,'||LN_CreMor||','||LN_CreCon||','||SO_GA_ABOCEL.COD_CICLO||','; -- COL 84509|31-03-2009|SAQL
   LV_sSql:=LV_sSql||' GA_ABOAMIST.IND_FACTUR,GA_ABOAMIST.IND_SUSPEN,GA_ABOAMIST.IND_REHABI,GA_ABOAMIST.IND_INSGUIAS,DECODE('||SO_GA_ABOCEL.FEC_FINCONTRA||',NULL, '||LD_FecFinContrato||','||SO_GA_ABOCEL.FEC_FINCONTRA||'),';
   LV_sSql:=LV_sSql||' GA_ABOAMIST.FEC_RECDOCUM,GA_ABOAMIST.FEC_CUMPLIMEN,GA_ABOAMIST.FEC_ACEPVENTA,GA_ABOAMIST.FEC_ACTCEN,';
   LV_sSql:=LV_sSql||' NULL,NULL,';
   LV_sSql:=LV_sSql||' GA_ABOAMIST.FEC_ULTMOD,GA_ABOAMIST.COD_CAUSABAJA,GA_ABOAMIST.NUM_PERSONAL,GA_ABOAMIST.IND_SEGURO,';
   LV_sSql:=LV_sSql||' NULL,NULL,GA_ABOAMIST.NUM_MIN,GA_ABOAMIST.COD_VENDEALER,';
   LV_sSql:=LV_sSql||' GA_ABOAMIST.IND_DISP,GA_ABOAMIST.COD_PASSWORD, GA_ABOAMIST.IND_PASSWORD, GA_ABOAMIST.COD_AFINIDAD,';
   LV_sSql:=LV_sSql||' '||LD_FEC_PRORROGA||','||LV_IND_EQPRESTADO||','||LV_FLG_CONTDIGI||','||LD_FEC_ALTANTRAS||','||LN_COD_INDEMNIZACION||',';
   LV_sSql:=LV_sSql||' GA_ABOAMIST.NUM_IMEI,GA_ABOAMIST.COD_TECNOLOGIA,GA_ABOAMIST.NUM_MIN_MDN,GA_ABOAMIST.FEC_ACTIVACION,GA_ABOAMIST.IND_TELEFONO,';
   LV_sSql:=LV_sSql||' '||LV_OfPrincipal||','||LV_COD_CAUSA_VENTA||','||LV_COD_OPERACION;
   LV_sSql:=LV_sSql||' FROM GA_ABOAMIST ';
   LV_sSql:=LV_sSql||' WHERE NUM_ABONADO = '||SO_GA_ABOCEL.NUM_ABONADO||' ';
   LV_sSql:=LV_sSql||' AND   COD_CLIENTE = '||SO_GA_ABOCEL.COD_CLIENTE||' ';
   LV_sSql:=LV_sSql||' AND   COD_CUENTA  = '||SO_GA_ABOCEL.COD_CUENTA||'; ';


                   INSERT INTO GA_ABOCEL
                   (NUM_ABONADO,NUM_CELULAR,COD_PRODUCTO,COD_CLIENTE,COD_CUENTA,
                   COD_SUBCUENTA,COD_USUARIO,COD_REGION,COD_PROVINCIA,COD_CIUDAD,
                   COD_CELDA,COD_CENTRAL,COD_USO,COD_SITUACION,IND_PROCALTA,
                   IND_PROCEQUI,COD_VENDEDOR,COD_VENDEDOR_AGENTE,TIP_PLANTARIF,TIP_TERMINAL,
                   COD_PLANTARIF,COD_CARGOBASICO,COD_PLANSERV,COD_LIMCONSUMO,NUM_SERIE,
                   NUM_SERIEHEX,NOM_USUARORA,FEC_ALTA,NUM_PERCONTRATO,COD_ESTADO,
                   NUM_SERIEMEC,COD_HOLDING,COD_EMPRESA,COD_GRPSERV,IND_SUPERTEL,
                   NUM_TELEFIJA,COD_OPREDFIJA,COD_CARRIER,IND_PREPAGO,IND_PLEXSYS,
                   COD_CENTRAL_PLEX,NUM_CELULAR_PLEX,NUM_VENTA,COD_MODVENTA,COD_TIPCONTRATO,
                   NUM_CONTRATO,NUM_ANEXO,FEC_CUMPLAN,COD_CREDMOR,COD_CREDCON,
                   COD_CICLO,IND_FACTUR,IND_SUSPEN,IND_REHABI,IND_INSGUIAS,
                   FEC_FINCONTRA,FEC_RECDOCUM,FEC_CUMPLIMEN,FEC_ACEPVENTA,FEC_ACTCEN,
                   FEC_BAJA,FEC_BAJACEN,FEC_ULTMOD,COD_CAUSABAJA,NUM_PERSONAL,
                   IND_SEGURO,CLASE_SERVICIO,PERFIL_ABONADO,NUM_MIN,COD_VENDEALER,
                   IND_DISP,COD_PASSWORD,IND_PASSWORD,COD_AFINIDAD,FEC_PRORROGA,
                   IND_EQPRESTADO,FLG_CONTDIGI,FEC_ALTANTRAS,COD_INDEMNIZACION,NUM_IMEI,
                   COD_TECNOLOGIA,NUM_MIN_MDN,FEC_ACTIVACION,IND_TELEFONO,COD_OFICINA_PRINCIPAL,
                   COD_CAUSA_VENTA,COD_OPERACION)
                   SELECT SO_GA_ABOCEL.ID_SECUENCIA, GA_ABOAMIST.NUM_CELULAR, GA_ABOAMIST.COD_PRODUCTO, SO_GA_ABOCEL.COD_CLIENTE_NUE, SO_GA_ABOCEL.COD_CUENTA,
                   LV_COD_SUBCUENTA_AUX, LN_usuario_aux, DECODE(GA_ABOAMIST.COD_REGION, NULL,LV_codregion, GA_ABOAMIST.COD_REGION), DECODE(GA_ABOAMIST.COD_PROVINCIA, NULL,LV_codprovincia, GA_ABOAMIST.COD_PROVINCIA), DECODE(GA_ABOAMIST.COD_CIUDAD, NULL,LV_codciudad, GA_ABOAMIST.COD_CIUDAD),
                   DECODE(GA_ABOAMIST.COD_CELDA, NULL,LV_celda, GA_ABOAMIST.COD_CELDA), GA_ABOAMIST.COD_CENTRAL, ln_uso_seg, lv_situacion_altaEnProceso, GA_ABOAMIST.IND_PROCALTA,
                   GA_ABOAMIST.IND_PROCEQUI, SO_GA_ABOCEL.COD_VENDEDOR, LV_VendeRaiz, SO_GA_ABOCEL.TIP_PLANTARIF, GA_ABOAMIST.TIP_TERMINAL,
                   SO_GA_ABOCEL.COD_PLANTARIF, SO_GA_ABOCEL.COD_CARGOBASICO, LV_PlanServ, LN_CodLimCons, GA_ABOAMIST.NUM_SERIE,
                   GA_ABOAMIST.NUM_SERIEHEX, GA_ABOAMIST.NOM_USUARORA, LD_FechaAlta, CN_NUM_PERCONTRATO, GA_ABOAMIST.COD_ESTADO,
                   GA_ABOAMIST.NUM_SERIEMEC, GA_ABOAMIST.COD_HOLDING, LN_COD_EMPRESA, DECODE(GA_ABOAMIST.COD_GRPSERV, NULL, LV_GrpServ, GA_ABOAMIST.COD_GRPSERV), LN_IND_SUPERTEL, --dejar como variable con valor en 0
                   GA_ABOAMIST.NUM_TELEFIJA, GA_ABOAMIST.COD_OPREDFIJA, GA_ABOAMIST.COD_CARRIER, 0, GA_ABOAMIST.IND_PLEXSYS,
                   GA_ABOAMIST.COD_CENTRAL_PLEX, GA_ABOAMIST.NUM_CELULAR_PLEX, SO_GA_ABOCEL.NUM_VENTA, GA_ABOAMIST.COD_MODVENTA, CN_COD_TIPCONTRATO,
                   SO_GA_ABOCEL.NUM_CONTRATO, SO_GA_ABOCEL.NUM_ANEXO, SYSDATE,
                   -- DECODE(GA_ABOAMIST.COD_CREDMOR,NULL, LN_CreMor, GA_ABOAMIST.COD_CREDMOR), --revidar ok -- COL 84509|31-03-2009|SAQL
                   -- DECODE(GA_ABOAMIST.COD_CREDCON,NULL,LN_CreCon, GA_ABOAMIST.COD_CREDCON),  --revidar ok -- COL 84509|31-03-2009|SAQL
                   LN_CreMor, LN_CreCon, -- COL 84509|31-03-2009|SAQL
                   SO_GA_ABOCEL.COD_CICLO, GA_ABOAMIST.IND_FACTUR, GA_ABOAMIST.IND_SUSPEN, GA_ABOAMIST.IND_REHABI, GA_ABOAMIST.IND_INSGUIAS,
                   --DECODE(SO_GA_ABOCEL.FEC_FINCONTRA,NULL, LD_FecFinContrato,SO_GA_ABOCEL.FEC_FINCONTRA),
                   nvl(SO_GA_ABOCEL.FEC_FINCONTRA,LD_FecFinContrato), -- RRG 11-05-2009 COL 88564
                   GA_ABOAMIST.FEC_RECDOCUM, GA_ABOAMIST.FEC_CUMPLIMEN, GA_ABOAMIST.FEC_ACEPVENTA, GA_ABOAMIST.FEC_ACTCEN,
                   NULL, NULL, GA_ABOAMIST.FEC_ULTMOD, NULL, GA_ABOAMIST.NUM_PERSONAL,
                   GA_ABOAMIST.IND_SEGURO, NULL, NULL, GA_ABOAMIST.NUM_MIN, GA_ABOAMIST.COD_VENDEALER,
                   GA_ABOAMIST.IND_DISP, GA_ABOAMIST.COD_PASSWORD, GA_ABOAMIST.IND_PASSWORD, GA_ABOAMIST.COD_AFINIDAD, LD_FEC_PRORROGA,
                   LV_IND_EQPRESTADO, LV_FLG_CONTDIGI, LD_FEC_ALTANTRAS, LN_COD_INDEMNIZACION, GA_ABOAMIST.NUM_IMEI,
                   GA_ABOAMIST.COD_TECNOLOGIA, GA_ABOAMIST.NUM_MIN_MDN, GA_ABOAMIST.FEC_ACTIVACION, GA_ABOAMIST.IND_TELEFONO, LV_OfPrincipal,
                   LV_COD_CAUSA_VENTA, LV_COD_OPERACION
    FROM  GA_ABOAMIST
    WHERE NUM_ABONADO = SO_GA_ABOCEL.NUM_ABONADO
    AND COD_CLIENTE = SO_GA_ABOCEL.COD_CLIENTE
    AND COD_CUENTA  = SO_GA_ABOCEL.COD_CUENTA;

    SELECT COD_PRESTACION
    INTO LV_codPrestacion
    FROM TA_PLANTARIF
    WHERE COD_PLANTARIF=SO_GA_ABOCEL.COD_PLANTARIF;


    UPDATE GA_ABOCEL SET COD_PRESTACION=LV_codPrestacion
    WHERE NUM_ABONADO= SO_GA_ABOCEL.ID_SECUENCIA;


--algunos campos de este insert van a tener variaciones dependiendo del destino Hibrido o Pospago,
-- estas variables serán tratadas en un IF  LN_COTIPLAN

    IF LN_COTIPLAN = 2 THEN
          LN_TIP_STOCK      :=2;
          LN_COD_USO            := ln_uso_seg;
          LN_COD_MODVENTA       :=1;
          LN_IND_EQPRESTADO :=0;
      LN_NUM_MOVIMIENTO :=NULL;
        ELSE
          LN_TIP_STOCK      :=NULL;
          LN_COD_USO        := ln_uso_seg;
          LN_COD_MODVENTA   :=1;
          LN_IND_EQPRESTADO :=0;
          LN_NUM_MOVIMIENTO := '99';
        END IF;

                   --INI COL-86751|22-04-2009|GEZ
                   IF LV_CodTecnologia='GSM' THEN

                                   --VALIDO SI EL ULTIMO EQUIPO EN GA_EQUIPABOSER ES EL QUE TIENE EN GA_ABOAMIST
                                   LV_sSql:= ' SELECT num_serie FROM   ga_equipaboser';
                                   LV_sSql:= LV_sSql || ' WHERE num_abonado ='|| SO_GA_ABOCEL.NUM_ABONADO;
                                   LV_sSql:= LV_sSql || ' AND     tip_terminal     = ''T''';
                                   LV_sSql:= LV_sSql || ' AND     fec_alta           = (SELECT MAX(fec_alta) FROM    ga_equipaboser';
                                                                        LV_sSql:= LV_sSql || ' WHERE  num_abonado = '||SO_GA_ABOCEL.NUM_ABONADO;
                                                                        LV_sSql:= LV_sSql || ' AND      tip_terminal=''T'')';

                                   EXECUTE IMMEDIATE LV_sSql INTO LV_NumSerieAux;

                                   IF  LV_NumSerieAux <> LV_NUMIMEI THEN
                                           LV_DestalleError:='EL ULTIMO EQUIPO REGISTRADO EN GA_EQUIPABOSER['||LV_NumSerieAux||'] ES DISTINTO AL DE LA GA_ABOAMIT['||LV_NUMIMEI||']';
                                                   RAISE ERROR_EJECUCION;
                                   END IF;

                                   --VALIDO SI LA ULTIMA SIMCARD EN GA_EQUIPABOSER ES EL QUE TIENE EN GA_ABOAMIST
                                   LV_sSql:= ' SELECT num_serie FROM   ga_equipaboser';
                                   LV_sSql:= LV_sSql || ' WHERE num_abonado ='|| SO_GA_ABOCEL.NUM_ABONADO;
                                   LV_sSql:= LV_sSql || ' AND     tip_terminal     = ''G''';
                                   LV_sSql:= LV_sSql || ' AND     fec_alta           = (SELECT MAX(fec_alta) FROM    ga_equipaboser';
                                                                        LV_sSql:= LV_sSql || ' WHERE  num_abonado = '||SO_GA_ABOCEL.NUM_ABONADO;
                                                                        LV_sSql:= LV_sSql || ' AND      tip_terminal=''G'')';

                                   EXECUTE IMMEDIATE LV_sSql INTO LV_NumSerieAux;

                                   IF  LV_NumSerieAux <> LV_NUMSERIE THEN
                                           LV_DestalleError:='LA ULTIMA SIMCARD REGISTRADA EN GA_EQUIPABOSER['||LV_NumSerieAux||'] ES DISTINTA AL DE LA GA_ABOAMIT['||LV_NUMSERIE||']';
                                                   RAISE ERROR_EJECUCION;
                                   END IF;

                   END IF;

                   --FIN COL-86751|22-04-2009|GEZ

       SELECT MAX(FEC_ALTA) INTO LD_FEC_ALTA_EQUIPA
       FROM   GA_EQUIPABOSER
       WHERE  NUM_ABONADO = SO_GA_ABOCEL.NUM_ABONADO
       AND    NUM_SERIE   = LV_NUMSERIE;

        LV_sSql:=' INSERT INTO GA_EQUIPABOSER SELECT ';
        LV_sSql:=LV_sSql||' '||SO_GA_ABOCEL.ID_SECUENCIA||', EQUIP.NUM_SERIE, EQUIP.COD_PRODUCTO, EQUIP.IND_PROCEQUI,SYSDATE,';
        LV_sSql:=LV_sSql||' EQUIP.IND_PROPIEDAD, EQUIP.COD_BODEGA,DECODE('||LN_TIP_STOCK||',NULL, EQUIP.TIP_STOCK),EQUIP.COD_ARTICULO,EQUIP.IND_EQUIACC,';
        LV_sSql:=LV_sSql||' '||LN_COD_MODVENTA||', EQUIP.TIP_TERMINAL,EQUIP.COD_USO,EQUIP.COD_CUOTA,EQUIP.COD_ESTADO,';
        LV_sSql:=LV_sSql||' EQUIP.CAP_CODE, EQUIP.COD_PROTOCOLO,EQUIP.NUM_VELOCIDAD,EQUIP.COD_FRECUENCIA,EQUIP.COD_VERSION,';
        LV_sSql:=LV_sSql||' EQUIP.NUM_SERIEMEC, EQUIP.DES_EQUIPO,EQUIP.COD_PAQUETE,     EQUIP.NUM_MOVIMIENTO,EQUIP.COD_CAUSA,';
        LV_sSql:=LV_sSql||' '||LN_IND_EQPRESTADO||',EQUIP.NUM_IMEI,     EQUIP.COD_TECNOLOGIA,EQUIP.IMP_CARGO,EQUIP.TIP_DTO,EQUIP.VAL_DTO,PRC_VENTA';
        LV_sSql:=LV_sSql||' FROM GA_EQUIPABOSER EQUIP';
        LV_sSql:=LV_sSql||' WHERE NUM_ABONADO = '||SO_GA_ABOCEL.NUM_ABONADO;
        LV_sSql:=LV_sSql||'  AND NUM_SERIE = '||LV_NUMSERIE;
        LV_sSql:=LV_sSql||'  AND FEC_ALTA = '||LD_FEC_ALTA_EQUIPA;

                   INSERT INTO GA_EQUIPABOSER
                   SELECT SO_GA_ABOCEL.ID_SECUENCIA, EQUIP.NUM_SERIE, EQUIP.COD_PRODUCTO, EQUIP.IND_PROCEQUI, SYSDATE,
                   EQUIP.IND_PROPIEDAD, EQUIP.COD_BODEGA, DECODE(LN_TIP_STOCK,NULL, EQUIP.TIP_STOCK, LN_TIP_STOCK), EQUIP.COD_ARTICULO, EQUIP.IND_EQUIACC, LN_COD_MODVENTA,
                   EQUIP.TIP_TERMINAL, EQUIP.COD_USO, EQUIP.COD_CUOTA, EQUIP.COD_ESTADO, EQUIP.CAP_CODE,
                   EQUIP.COD_PROTOCOLO, EQUIP.NUM_VELOCIDAD, EQUIP.COD_FRECUENCIA, EQUIP.COD_VERSION, EQUIP.NUM_SERIEMEC,
                   EQUIP.DES_EQUIPO, EQUIP.COD_PAQUETE, EQUIP.NUM_MOVIMIENTO, EQUIP.COD_CAUSA, LN_IND_EQPRESTADO,
                   EQUIP.NUM_IMEI, EQUIP.COD_TECNOLOGIA, EQUIP.IMP_CARGO, EQUIP.TIP_DTO, EQUIP.VAL_DTO,PRC_VENTA
          FROM GA_EQUIPABOSER EQUIP
           WHERE NUM_ABONADO = SO_GA_ABOCEL.NUM_ABONADO
                         AND NUM_SERIE = LV_NUMSERIE
                         AND FEC_ALTA = LD_FEC_ALTA_EQUIPA;

                   --INI COL-86751|22-04-2009|GEZ
                   LV_sSql := ' SELECT MAX(fec_alta) FROM    ga_equipaboser';
                   LV_sSql := LV_sSql || ' WHERE  num_abonado = '||SO_GA_ABOCEL.NUM_ABONADO;
                   LV_sSql := LV_sSql || ' AND      num_serie       = '''||LV_NUMIMEI||'''';

                   EXECUTE IMMEDIATE  LV_sSql INTO LD_FEC_ALTA_EQUIPA;

                   --FIN COL-86751|22-04-2009|GEZ

                LV_sSql:=' INSERT INTO GA_EQUIPABOSER SELECT ';
                LV_sSql:=LV_sSql||' '||SO_GA_ABOCEL.ID_SECUENCIA||', EQUIP.NUM_SERIE, EQUIP.COD_PRODUCTO, EQUIP.IND_PROCEQUI,SYSDATE,';
                LV_sSql:=LV_sSql||' EQUIP.IND_PROPIEDAD, '||LN_COD_BODEGA||',DECODE('||LN_TIP_STOCK||',NULL, EQUIP.TIP_STOCK),EQUIP.COD_ARTICULO,EQUIP.IND_EQUIACC,';
                LV_sSql:=LV_sSql||' EQUIP.COD_MODVENTA, EQUIP.TIP_TERMINAL,'||LN_COD_USO||',EQUIP.COD_CUOTA,'||LN_COD_ESTADO;
                LV_sSql:=LV_sSql||' EQUIP.CAP_CODE, EQUIP.COD_PROTOCOLO,EQUIP.NUM_VELOCIDAD,EQUIP.COD_FRECUENCIA,EQUIP.COD_VERSION,';
                LV_sSql:=LV_sSql||' EQUIP.NUM_SERIEMEC, EQUIP.DES_EQUIPO,EQUIP.COD_PAQUETE,     DECODE('||LN_NUM_MOVIMIENTO||',NULL, NULL,''MM'',EQUIP.NUM_MOVIMIENTO),EQUIP.COD_CAUSA,';
                LV_sSql:=LV_sSql||' '||LN_IND_EQPRESTADO||',EQUIP.NUM_IMEI,     EQUIP.COD_TECNOLOGIA,EQUIP.IMP_CARGO,EQUIP.TIP_DTO,EQUIP.VAL_DTO,PRC_VENTA';
                LV_sSql:=LV_sSql||' FROM GA_EQUIPABOSER EQUIP';
                LV_sSql:=LV_sSql||' WHERE NUM_ABONADO = '||SO_GA_ABOCEL.NUM_ABONADO;
                LV_sSql:=LV_sSql||'  AND NUM_SERIE = '||LV_NUMIMEI;

                   INSERT INTO GA_EQUIPABOSER
                   SELECT SO_GA_ABOCEL.ID_SECUENCIA, EQUIP.NUM_SERIE, EQUIP.COD_PRODUCTO, EQUIP.IND_PROCEQUI, SYSDATE,
                   EQUIP.IND_PROPIEDAD, LN_COD_BODEGA, DECODE(LN_TIP_STOCK,NULL, EQUIP.TIP_STOCK, LN_TIP_STOCK), EQUIP.COD_ARTICULO, EQUIP.IND_EQUIACC,
                   EQUIP.COD_MODVENTA, EQUIP.TIP_TERMINAL, LN_COD_USO, EQUIP.COD_CUOTA, LN_COD_ESTADO,
                   EQUIP.CAP_CODE, EQUIP.COD_PROTOCOLO, EQUIP.NUM_VELOCIDAD, EQUIP.COD_FRECUENCIA, EQUIP.COD_VERSION,
                   EQUIP.NUM_SERIEMEC, EQUIP.DES_EQUIPO, EQUIP.COD_PAQUETE, DECODE(LN_NUM_MOVIMIENTO,NULL, NULL,'99',EQUIP.NUM_MOVIMIENTO), EQUIP.COD_CAUSA, LN_IND_EQPRESTADO,
                   EQUIP.NUM_IMEI, EQUIP.COD_TECNOLOGIA, EQUIP.IMP_CARGO, EQUIP.TIP_DTO, EQUIP.VAL_DTO,PRC_VENTA
          FROM GA_EQUIPABOSER EQUIP
          WHERE NUM_ABONADO = SO_GA_ABOCEL.NUM_ABONADO
          AND NUM_SERIE = LV_NUMIMEI
          AND FEC_ALTA = LD_FEC_ALTA_EQUIPA;

                   -- INI COL|85969|10-04-2009|SAQL


                   IF ln_uso_seg = 10 THEN -- RRG 11-05-2009 COL 88564

                           LV_sSql := 'SELECT NUM_CELULAR ';
                           LV_sSql := LV_sSql || 'FROM GA_ABOAMIST ';
                           LV_sSql := LV_sSql || 'WHERE NUM_ABONADO = '||SO_GA_ABOCEL.NUM_ABONADO;

                           SELECT NUM_CELULAR INTO LN_NUM_CELULAR
                           FROM GA_ABOAMIST
                           WHERE NUM_ABONADO = SO_GA_ABOCEL.NUM_ABONADO;

                           LV_sSql := 'SELECT COD_CICLFACT ';
                           LV_sSql := LV_sSql || 'FROM FA_CICLFACT ';
                           LV_sSql := LV_sSql || 'WHERE COD_CICLO = '||SO_GA_ABOCEL.COD_CICLO;
                           LV_sSql := LV_sSql || ' AND SYSDATE BETWEEN FEC_DESDELLAM AND FEC_HASTALLAM';

                           SELECT COD_CICLFACT INTO LN_COD_CICLFACT
                           FROM FA_CICLFACT
                           WHERE COD_CICLO = SO_GA_ABOCEL.COD_CICLO
                           AND SYSDATE BETWEEN FEC_DESDELLAM AND FEC_HASTALLAM;

                           IF SO_GA_ABOCEL.FEC_FINCONTRA IS NULL THEN

                                      LV_sSql := 'SELECT MESES_MINIMO ';
                                      LV_sSql := LV_sSql || 'FROM GA_TIPCONTRATO ';
                                      LV_sSql := LV_sSql || 'WHERE COD_TIPCONTRATO = '||CN_COD_TIPCONTRATO;

                                      SELECT MESES_MINIMO INTO N_MESES
                                      FROM GA_TIPCONTRATO
                                      WHERE COD_TIPCONTRATO = CN_COD_TIPCONTRATO;

                                      D_FEC_FINCONTRA := ADD_MONTHS(LD_FechaAlta,N_MESES);
                           ELSE
                                  D_FEC_FINCONTRA := SO_GA_ABOCEL.FEC_FINCONTRA;
                           END IF;

                           select DECODE(SO_GA_ABOCEL.COD_USO, 10,1,0) into n_cod_uso from dual;

                           -- CREO REGISTRO EN GA_INFACCEL
                           LV_sSql := 'INSERT INTO GA_INFACCEL ( ';
                           LV_sSql := LV_sSql || 'COD_CLIENTE, NUM_ABONADO, COD_CICLFACT, FEC_ALTA, FEC_BAJA, ';
                           LV_sSql := LV_sSql || 'NUM_CELULAR, IND_ACTUAC, FEC_FINCONTRA, IND_ALTA, IND_DETALLE, ';
                           LV_sSql := LV_sSql || 'IND_FACTUR, IND_CUOTAS, IND_ARRIENDO, IND_CARGOS, IND_PENALIZA, ';
                           LV_sSql := LV_sSql || 'IND_SUPERTEL, NUM_TELEFIJA, COD_SUPERTEL, IND_CARGOPRO, IND_CUENCONTROLADA, ';
                           LV_sSql := LV_sSql || 'IND_BLOQUEO, FEC_RECARGA, IND_COBRODETLLAM ';
                           LV_sSql := LV_sSql || ') VALUES (';
                           LV_sSql := LV_sSql || SO_GA_ABOCEL.COD_CLIENTE_NUE||','|| SO_GA_ABOCEL.ID_SECUENCIA||','||LN_COD_CICLFACT||','||LD_FechaAlta||','||D_FEC_BAJA||',';
                           LV_sSql := LV_sSql || LN_NUM_CELULAR||','||N_IND_ACTUAC||','||D_FEC_FINCONTRA||','||N_IND_ALTA||','||N_IND_DETALLE||',';
                           LV_sSql := LV_sSql || N_IND_FACTUR||','||N_IND_CUOTAS||','||N_IND_ARRIENDO||','||N_IND_CARGOS||','||N_IND_PENALIZA||',';
                           LV_sSql := LV_sSql || N_IND_SUPERTEL||','||NULL||','||NULL||','||0||','|| n_cod_uso ||',';
                           LV_sSql := LV_sSql || 0||','||NULL||','||NULL;
                           LV_sSql := LV_sSql || ');';

                           INSERT INTO GA_INFACCEL (
                              COD_CLIENTE, NUM_ABONADO, COD_CICLFACT, FEC_ALTA, FEC_BAJA,
                              NUM_CELULAR, IND_ACTUAC, FEC_FINCONTRA, IND_ALTA, IND_DETALLE,
                              IND_FACTUR, IND_CUOTAS, IND_ARRIENDO, IND_CARGOS, IND_PENALIZA,
                              IND_SUPERTEL, NUM_TELEFIJA, COD_SUPERTEL, IND_CARGOPRO, IND_CUENCONTROLADA,
                              IND_BLOQUEO, FEC_RECARGA, IND_COBRODETLLAM
                           ) VALUES (
                              SO_GA_ABOCEL.COD_CLIENTE_NUE, SO_GA_ABOCEL.ID_SECUENCIA, LN_COD_CICLFACT, LD_FechaAlta, D_FEC_BAJA,
                              LN_NUM_CELULAR, N_IND_ACTUAC, D_FEC_FINCONTRA, N_IND_ALTA, N_IND_DETALLE,
                              N_IND_FACTUR, N_IND_CUOTAS, N_IND_ARRIENDO, N_IND_CARGOS, N_IND_PENALIZA,
                              N_IND_SUPERTEL, NULL, NULL, 0, n_cod_uso,
                              0, NULL, NULL
                           );

                           -- CREO REGISTRO EN FA_CICLOCLI
                           LV_sSql := 'SELECT COD_CALCLIEN, SUBSTR(NOM_CLIENTE,1,20) NOM_CLIENTE, NOM_APECLIEN1, NOM_APECLIEN2 ';
                           LV_sSql := LV_sSql || 'FROM GE_CLIENTES ';
                           LV_sSql := LV_sSql || 'WHERE COD_CLIENTE = '||SO_GA_ABOCEL.COD_CLIENTE;

                         --  SELECT COD_CALCLIEN, SUBSTR(NOM_CLIENTE,1,20) NOM_CLIENTE, NOM_APECLIEN1, NOM_APECLIEN2 --inc. 83594|25/04/2009|jjr.-
                           SELECT COD_CALCLIEN, SUBSTR(NOM_CLIENTE,1,20) NOM_CLIENTE,NVL(NOM_APECLIEN1,substr(NOM_CLIENTE,1,20)), NOM_APECLIEN2
                           INTO V_COD_CALCLIE, V_NOM_USUARIO, V_NOM_APELLIDO1, V_NOM_APELLIDO2
                           FROM GE_CLIENTES
                           WHERE COD_CLIENTE = SO_GA_ABOCEL.COD_CLIENTE;

                           LV_sSql := 'INSERT INTO FA_CICLOCLI ( ';
                           LV_sSql := LV_sSql || 'COD_CLIENTE, COD_CICLO, COD_PRODUCTO, NUM_ABONADO, NUM_PROCESO, ';
                           LV_sSql := LV_sSql || 'COD_CALCLIEN, IND_CAMBIO, NOM_USUARIO, NOM_APELLIDO1, NOM_APELLIDO2, ';
                           LV_sSql := LV_sSql || 'COD_CREDMOR, IND_DEBITO, COD_CICLONUE, FEC_ALTA, NUM_TERMINAL, ';
                           LV_sSql := LV_sSql || 'FEC_ULTFACT, IND_MASCARA, COD_DESPACHO, COD_PRIORIDAD ';
                           LV_sSql := LV_sSql || ') VALUES ( ';
                           LV_sSql := LV_sSql || SO_GA_ABOCEL.COD_CLIENTE_NUE||','||SO_GA_ABOCEL.COD_CICLO||','||1||','||SO_GA_ABOCEL.ID_SECUENCIA||','||0||',';
                           LV_sSql := LV_sSql || V_COD_CALCLIE||','||0||','||V_NOM_USUARIO||','||V_NOM_APELLIDO1||','||V_NOM_APELLIDO2||',';
                           LV_sSql := LV_sSql || 0||','||'1'||','||NULL||','||LD_FechaAlta||','||LN_NUM_CELULAR||',';
                           LV_sSql := LV_sSql || NULL||','||1||','||NULL||','||NULL;
                           LV_sSql := LV_sSql || ');';

                           INSERT INTO FA_CICLOCLI (
                              COD_CLIENTE, COD_CICLO, COD_PRODUCTO, NUM_ABONADO, NUM_PROCESO,
                              COD_CALCLIEN, IND_CAMBIO, NOM_USUARIO, NOM_APELLIDO1, NOM_APELLIDO2,
                              COD_CREDMOR, IND_DEBITO, COD_CICLONUE, FEC_ALTA, NUM_TERMINAL,
                              FEC_ULTFACT, IND_MASCARA, COD_DESPACHO, COD_PRIORIDAD
                           ) VALUES (
                              SO_GA_ABOCEL.COD_CLIENTE_NUE, SO_GA_ABOCEL.COD_CICLO, 1, SO_GA_ABOCEL.ID_SECUENCIA, 0,
                              V_COD_CALCLIE, 0, V_NOM_USUARIO, V_NOM_APELLIDO1, V_NOM_APELLIDO2,
                              0, '1', NULL, LD_FechaAlta, LN_NUM_CELULAR,
                              NULL, 1, NULL, NULL
                           );

                   end if;-- FIN RRG 88564 11-05-2009

                   -- FIN COL|85969|10-04-2009|SAQL

 EXCEPTION
    WHEN ERROR_EJECUCION THEN

      SN_cod_retorno := 156;  -- COL-86751|23-04-2009|RRG

          --LV_des_error   := 'PV_MIGRAR_ABONADO_PR('||SO_GA_ABOCEL.NUM_ABONADO||','||SO_GA_ABOCEL.COD_CLIENTE||','||SO_GA_ABOCEL.COD_CUENTA||'); PV_DATOS_ABONADO_PG.PV_MIGRAR_ABONADO_PR ';  --COL-86751|22-04-2009|GEZ
      LV_des_error   := 'PV_DATOS_ABONADO_PG.PV_MIGRAR_ABONADO_PR('||SO_GA_ABOCEL.NUM_ABONADO||','||SO_GA_ABOCEL.COD_CLIENTE||','||SO_GA_ABOCEL.COD_CUENTA||')'||LV_DestalleError;                                          --COL-86751|22-04-2009|GEZ

          SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_DATOS_ABONADO_PG.PV_MIGRAR_ABONADO_PR', LV_sSQL, SN_cod_retorno, LV_des_error);

   WHEN OTHERS THEN
       SN_cod_retorno := 156;

       IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := CV_error_no_clasif;
       END IF;

    LV_des_error   := 'PV_MIGRAR_ABONADO_PR ('||SO_GA_ABOCEL.NUM_ABONADO||','||SO_GA_ABOCEL.COD_CLIENTE||','||SO_GA_ABOCEL.COD_CUENTA||'); '||SQLERRM;
       SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_DATOS_ABONADO_PG.PV_MIGRAR_ABONADO_PR', LV_sSQL, SN_cod_retorno, LV_des_error );
END PV_MIGRAR_ABONADO_PR;

------------------------------------------------------------------------------------------------------
FUNCTION PV_ACT_ABO_CTASEG_FN (SO_GA_ABOCEL   IN    PV_GA_ABOCEL_QT,
                 SN_cod_retorno      OUT NOCOPY  ge_errores_td.cod_msgerror%TYPE,
                 SV_mens_retorno     OUT NOCOPY  ge_errores_td.det_msgerror%TYPE,
                 SN_num_evento       OUT NOCOPY ge_errores_pg.evento)
 RETURN VARCHAR
 AS
/*
 <Documentación
   TipoDoc = "Procedure">>
    <Elemento
       Nombre = "PV_ACT_ABO_CTASEG_FN   "
       Lenguaje="PL/SQL"
       Fecha="08-08-2007"
       Versión="La del package"
       Diseñador=""
       Programador="Carlos Elizondo"
       Ambiente Desarrollo="BD">
       <Retorno>N/A</Retorno>>
       <Descripción>Metodo  :  Acrualizar ga_abocel     </Descripción>>
       <Parámetros>
          <Entrada>
             <param nom="SO_GA_ABOCEL "    Tipo="Estructura de Type ">   Datos de Estructura Type   </param>>
          </Entrada>
          <Salida>
             <param nom="SN_cod_retorno"    Tipo="NUMERICO">Codigo de Retorno     </param>>
             <param nom="SV_mens_retorno"    Tipo="CARACTER">Mensaje de Retorno     </param>>
             <param nom="SN_num_evento"     Tipo="NUMERICO">Numero de Evento     </param>>
          </Salida>
       </Parámetros>
    </Elemento>
 </Documentación>
*/
  LV_des_error     ge_errores_pg.DesEvent;
  LV_sSql       ge_errores_pg.vQuery;
  ERROR_EJECUCION      EXCEPTION;
  ERROR_CONTROLADO  EXCEPTION;
  LV_cod_planserv   ga_plantecplserv.COD_PLANSERV%TYPE;
  LV_cod_limcons   tol_limite_plan_td.COD_LIMCONS%TYPE;
  LV_Msg     varchar(255);

 BEGIN
     sn_cod_retorno  := 0;
     sv_mens_retorno := NULL;
     sn_num_evento   := 0;

   BEGIN
  LV_sSql:='SELECT nvl(cod_planserv,null)  INTO  LV_cod_planserv ';
  LV_sSql:=LV_sSql||' FROM ga_plantecplserv ';
  LV_sSql:=LV_sSql||' WHERE cod_producto ='||SO_GA_ABOCEL.COD_PRODUCTO||' ';
  LV_sSql:=LV_sSql||' AND cod_tecnologia ='||SO_GA_ABOCEL.COD_TECNOLOGIA||' ';
  LV_sSql:=LV_sSql||' AND cod_plantarif ='||SO_GA_ABOCEL.COD_CARGOBASICO|| ' ';
  LV_sSql:=LV_sSql||' AND SYSDATE BETWEEN FEC_DESDE AND NVL(FEC_HASTA, SYSDATE)';


  SELECT nvl(cod_planserv,null)  INTO  LV_cod_planserv
  FROM ga_plantecplserv
  WHERE cod_producto = SO_GA_ABOCEL.COD_PRODUCTO
  AND cod_tecnologia = SO_GA_ABOCEL.COD_TECNOLOGIA
  AND cod_plantarif =  SO_GA_ABOCEL.COD_CARGOBASICO
  AND SYSDATE BETWEEN FEC_DESDE AND NVL(FEC_HASTA, SYSDATE);

 EXCEPTION
 WHEN NO_DATA_FOUND THEN
    SN_cod_retorno := 283;
    RAISE ERROR_CONTROLADO;
 END;

 BEGIN
  LV_sSql:='SELECT COD_LIMCONS INTO  LV_cod_limcons ';
  LV_sSql:=LV_sSql||' FROM  TOL_LIMITE_PLAN_TD      ';
  LV_sSql:=LV_sSql||' WHERE COD_PLANTARIF ='||SO_GA_ABOCEL.COD_PLANTARIF||' ';
  LV_sSql:=LV_sSql||' AND   IND_DEFAULT = '||Chr(39)||'S'||Chr(39);
  LV_sSql:=LV_sSql||' AND SYSDATE BETWEEN FEC_DESDE AND NVL(FEC_HASTA, SYSDATE)';


  SELECT COD_LIMCONS
  INTO  LV_cod_limcons
  FROM  TOL_LIMITE_PLAN_TD
  WHERE COD_PLANTARIF = SO_GA_ABOCEL.COD_PLANTARIF
  AND   IND_DEFAULT = 'S'
  AND SYSDATE BETWEEN FEC_DESDE AND NVL(FEC_HASTA, SYSDATE);

 EXCEPTION
 WHEN NO_DATA_FOUND THEN
    LV_cod_limcons:='-1';
 END;

  LV_sSql:='UPDATE GA_ABOCEL  SET COD_PLANTARIF = '||SO_GA_ABOCEL.COD_PLANTARIF||', ';
 LV_sSql:=LV_sSql||' COD_PLANSERV  ='||LV_cod_planserv||', ';
 LV_sSql:=LV_sSql||' COD_LIMCONSUMO = '||LV_cod_limcons||', ';
 LV_sSql:=LV_sSql||' COD_CARGOBASICO ='||SO_GA_ABOCEL.COD_CARGOBASICO||', ';
 LV_sSql:=LV_sSql||' FEC_CUMPLAN = TRUNC(SYSDATE + '||SO_GA_ABOCEL.NUM_DIA||'), ';
 LV_sSql:=LV_sSql||' FEC_ULTMOD = SYSDATE,';
 LV_sSql:=LV_sSql||' COD_USO ='||SO_GA_ABOCEL.COD_USO;
 LV_sSql:=LV_sSql||' WHERE ';
 LV_sSql:=LV_sSql||' NUM_ABONADO ='||SO_GA_ABOCEL.NUM_ABONADO||';';


 UPDATE GA_ABOCEL  SET COD_PLANTARIF  = SO_GA_ABOCEL.COD_PLANTARIF,
           COD_PLANSERV    = LV_cod_planserv,
           COD_LIMCONSUMO  = LV_cod_limcons,
        COD_CARGOBASICO = SO_GA_ABOCEL.COD_CARGOBASICO,
        FEC_CUMPLAN     = TRUNC(SYSDATE + SO_GA_ABOCEL.NUM_DIA),
        FEC_ULTMOD      = SYSDATE,
        COD_USO         = SO_GA_ABOCEL.COD_USO  --corresponde al uso destino ver metodo validaportabildad()
 WHERE
    NUM_ABONADO   = SO_GA_ABOCEL.NUM_ABONADO;

 RETURN 'TRUE';

 EXCEPTION
    WHEN ERROR_CONTROLADO THEN
    IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := CV_error_no_clasif;
       END IF;
       LV_des_error   := 'PV_ACT_ABO_CTASEG_FN ('||SO_GA_ABOCEL.NUM_ABONADO||'); '||SQLERRM;
       SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_DATOS_ABONADO_PG.PV_ACT_ABO_CTASEG_FN', LV_sSQL, SN_cod_retorno, LV_des_error );
   RETURN 'FALSE';
   WHEN OTHERS THEN
       SN_cod_retorno := 156;
       IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := CV_error_no_clasif;
       END IF;
       LV_des_error   := 'PV_ACT_ABO_CTASEG_FN ('||SO_GA_ABOCEL.NUM_ABONADO||'); '||SQLERRM;
       SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_DATOS_ABONADO_PG.PV_ACT_ABO_CTASEG_FN', LV_sSQL, SN_cod_retorno, LV_des_error );
   RETURN 'FALSE';
END PV_ACT_ABO_CTASEG_FN;

------------------------------------------------------------------------------------------------------
FUNCTION PV_VALIDA_PERMANENCIA_FN(EO_permanencia  IN  PV_VALIDA_PERM_QT,
         SN_cod_retorno      OUT NOCOPY   ge_errores_td.cod_msgerror%TYPE,
         SV_mens_retorno     OUT NOCOPY   ge_errores_td.det_msgerror%TYPE,
         SN_num_evento       OUT NOCOPY ge_errores_pg.evento)
RETURN VARCHAR2
 IS
/*
 <Documentación
   TipoDoc = "Procedure">>
    <Elemento
       Nombre = "PV_VALIDA_PERMANENCIA_FN"
       Lenguaje="PL/SQL"
       Fecha="20-08-2007"
       Versión="La del package"
       Diseñador="Orlando Cabezas"
       Programador="Elizabeth Vera"
       Ambiente Desarrollo="BD">
       <Retorno>N/A</Retorno>>
       <Descripción></Descripción>>
       <Parámetros>
          <Entrada>
             <param nom="EO_permanencia" Tipo="estructura"><param>>
          </Entrada>
          <Salida>
             <param nom="SN_cod_retorno" Tipo="NUMERICO">Codigo de Retorno</param>>
             <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>>
             <param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>>
          </Salida>
       </Parámetros>
    </Elemento>
 </Documentación>
 */

 LV_des_error    ge_errores_pg.DesEvent;
 LV_sSql      ge_errores_pg.vQuery;
 LV_cod_opta     NUMBER(38);
 LN_diferencia    NUMBER(38);

  BEGIN
         SN_cod_retorno  := 0;
         SV_mens_retorno := ' ';
         SN_num_evento  := 0;

           LV_sSql:='SELECT trunc((sysdate - (ADD_MONTHS(FEC_ACEPVENTA,'||EO_permanencia.TIEMPO_MIN||'))))';
     LV_sSql:=LV_sSql||' FROM GA_ABOCEL ';
     LV_sSql:=LV_sSql||' WHERE NUM_ABONADO = '||EO_permanencia.NUM_ABONADO;

     SELECT trunc((sysdate - (ADD_MONTHS(FEC_ACEPVENTA,EO_permanencia.TIEMPO_MIN))))
     INTO LN_diferencia
     FROM GA_ABOCEL
     WHERE NUM_ABONADO = EO_permanencia.NUM_ABONADO;

      IF (LN_diferencia >= 0) And (EO_permanencia.COD_CAUSA_BAJA = EO_permanencia.COD_CAUSA_BAJA_PARAM) THEN
       RETURN 'TRUE';
         ELSE
    RETURN 'FALSE';
   END IF;

  EXCEPTION
   WHEN NO_DATA_FOUND THEN
    RETURN 'FALSE';
   WHEN OTHERS THEN
         SN_cod_retorno := 156;
         IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
            SV_mens_retorno := CV_error_no_clasif;
         END IF;
      LV_des_error   := 'PV_VALIDA_PERMANENCIA_FN('||EO_permanencia.NUM_ABONADO  ||'); '||SQLERRM;
         SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_DATOS_ABONADO_PG.PV_VALIDA_PERMANENCIA_FN', LV_sSQL, SN_cod_retorno, LV_des_error );
      RETURN 'FALSE';
END PV_VALIDA_PERMANENCIA_FN;

------------------------------------------------------------------------------------------------------------------------
--Metodo : reservaAmist
PROCEDURE PV_RESERVA_AMIST_PR(EO_celular  IN  PV_NUMCEL_PERS_QT,
         SN_cod_retorno      OUT NOCOPY   ge_errores_td.cod_msgerror%TYPE,
         SV_mens_retorno     OUT NOCOPY   ge_errores_td.det_msgerror%TYPE,
         SN_num_evento       OUT NOCOPY ge_errores_pg.evento)
IS
  /*
 <Documentación
   TipoDoc = "Procedure">>
    <Elemento
       Nombre = "PV_RESERVA_AMIST_PR
       Lenguaje="PL/SQL"
       Fecha="22-08-2007"
       Versión="La del package"
       Diseñador="Orlando Cabezas
       Programador="Elizabeth Vera"
       Ambiente Desarrollo="BD">
       <Retorno>N/A</Retorno>>
       <Descripción></Descripción>>
       <Parámetros>
          <Entrada>
             <param nom="EO_NUMCEL_PERS" Tipo="estructura">estructura para datos de cuenta personal</param>>
          </Entrada>
          <Salida>
             <param nom="SN_cod_retorno" Tipo="NUMERICO">Codigo de Retorno</param>>
             <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>>
             <param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>>
          </Salida>
       </Parámetros>
    </Elemento>
 </Documentación>
 */

  LV_des_error       ge_errores_pg.DesEvent;
  LV_sSql         ge_errores_pg.vQuery;

 BEGIN

  SN_cod_retorno  := 0;
     SV_mens_retorno := NULL;
     SN_num_evento  := 0;

     LV_sSql:='DELETE RE_SERVAMIST';
  LV_sSql:=LV_sSql||' WHERE NUM_CELULAR = '||EO_celular.NUM_CELULAR_PERS;

  DELETE RE_SERVAMIST
  WHERE NUM_CELULAR = EO_celular.NUM_CELULAR_PERS;

 EXCEPTION
 WHEN OTHERS THEN
       SN_cod_retorno := 156;
       IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := CV_error_no_clasif;
       END IF;
    LV_des_error   := 'PV_RESERVA_AMIST_PR('||EO_celular.NUM_CELULAR_PERS || '); '||SQLERRM;
       SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_DATOS_ABONADO_PG.PV_RESERVA_AMIST_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

END PV_RESERVA_AMIST_PR;

------------------------------------------------------------------------------------------------------
PROCEDURE PV_ACTUALIZA_SITUPERFIL_PR(EO_Abonado        IN          GA_ABONADO_QT,
             SN_cod_retorno    OUT NOCOPY   ge_errores_td.cod_msgerror%TYPE,
             SV_mens_retorno   OUT NOCOPY   ge_errores_td.det_msgerror%TYPE,
             SN_num_evento     OUT NOCOPY ge_errores_pg.evento)
IS
  /*
 <Documentación
   TipoDoc = "Procedure">>
    <Elemento
       Nombre = "PV_RESERVA_AMIST_PR
       Lenguaje="PL/SQL"
       Fecha="22-08-2007"
       Versión="La del package"
       Diseñador="Orlando Cabezas
       Programador="Elizabeth Vera"
       Ambiente Desarrollo="BD">
       <Retorno>N/A</Retorno>>
       <Descripción></Descripción>>
       <Parámetros>
          <Entrada>
             <param nom="EO_Abonado " Tipo="estructura">estructura para datos del abonado</param>>
          </Entrada>
          <Salida>
             <param nom="SN_cod_retorno" Tipo="NUMERICO">Codigo de Retorno</param>>
             <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>>
             <param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>>
          </Salida>
       </Parámetros>
    </Elemento>
 </Documentación>
 */

  LV_des_error       ge_errores_pg.DesEvent;
  LV_sSql         ge_errores_pg.vQuery;

 BEGIN

  SN_cod_retorno  := 0;
     SV_mens_retorno := '';
     SN_num_evento  := 0;

  IF EO_Abonado.COD_ACTABO = 'IH' OR EO_Abonado.COD_ACTABO = 'OH' THEN

      LV_sSql:=LV_sSql||' UPDATE GA_ABOCEL SET';
   LV_sSql:=LV_sSql||' PERFIL_ABONADO = ( SELECT B.COD_SERVICIOS ';
   LV_sSql:=LV_sSql||' FROM GA_ACTABO A, ICG_ACTUACIONTERCEN B ';
   LV_sSql:=LV_sSql||' WHERE A.COD_ACTABO =  '||EO_Abonado.COD_ACTABO ;
   LV_sSql:=LV_sSql||' AND A.COD_TECNOLOGIA = '||EO_Abonado.COD_TECNOLOGIA;
   LV_sSql:=LV_sSql||' AND A.COD_ACTCEN = B.COD_ACTUACION ),';
   LV_sSql:=LV_sSql||' COD_SITUACION  = '||CV_situacion||',';
   LV_sSql:=LV_sSql||' CLASE_SERVICIO = '||EO_Abonado.CLASE_SERVICIO;
   LV_sSql:=LV_sSql||' WHERE ';
   LV_sSql:=LV_sSql||' NUM_ABONADO     = '||EO_Abonado.NUM_ABONADO;
   LV_sSql:=LV_sSql||' AND COD_CLIENTE = '||EO_Abonado.COD_CLIENTE;

   UPDATE GA_ABOCEL SET
            PERFIL_ABONADO = ( SELECT B.COD_SERVICIOS
                                FROM GA_ACTABO A, ICG_ACTUACIONTERCEN B
                                 WHERE A.COD_ACTABO =  EO_Abonado.COD_ACTABO
                                   AND A.COD_TECNOLOGIA = EO_Abonado.COD_TECNOLOGIA
                                   AND A.COD_ACTCEN = B.COD_ACTUACION ) ,
            COD_SITUACION  = CV_situacion,
            CLASE_SERVICIO = EO_Abonado.CLASE_SERVICIO
         WHERE
            NUM_ABONADO     = EO_Abonado.NUM_ABONADO
            AND COD_CLIENTE = EO_Abonado.COD_CLIENTE;

  END IF;

 EXCEPTION
 WHEN OTHERS THEN
       SN_cod_retorno := 156;
       IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := CV_error_no_clasif;
       END IF;
    LV_des_error   := 'PV_ACTUALIZA_SITUPERFIL_PR('||EO_Abonado.NUM_ABONADO|| '); '||SQLERRM;
       SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_DATOS_ABONADO_PG.PV_ACTUALIZA_SITUPERFIL_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

END PV_ACTUALIZA_SITUPERFIL_PR;

------------------------------------------------------------------------------------------------------
PROCEDURE PV_OBTENER_ABONADO_CELULAR_PR (ESO_Abonado              IN OUT NOCOPY GA_Abonado_QT,
                  SN_cod_retorno           OUT NOCOPY   ge_errores_td.cod_msgerror%TYPE,
                 SV_mens_retorno          OUT NOCOPY   ge_errores_td.det_msgerror%TYPE,
                 SN_num_evento            OUT NOCOPY ge_errores_pg.evento)
 IS
 /*
 <Documentación
   TipoDoc = "Procedure">>
    <Elemento
       Nombre = "PV_OBTENER_NUM_ABONADO_FN"
       Lenguaje="PL/SQL"
       Fecha="06-11-2007"
       Versión="La del package"
       Diseñador="FERNANDO MATELUNA"
       Programador="FERNANDO MATELUNA"
       Ambiente Desarrollo="BD">
       <Retorno>N/A</Retorno>>
       <Descripción></Descripción>>
       <Parámetros>
          <Entrada>
             <param nom="EO_permanencia" Tipo="estructura"><param>>
          </Entrada>
          <Salida>
             <param nom="SN_cod_retorno" Tipo="NUMERICO">Codigo de Retorno</param>>
             <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>>
             <param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>>
          </Salida>
       </Parámetros>
    </Elemento>
 </Documentación>
 */

 LV_des_error    ge_errores_pg.DesEvent;
 LV_sSql      ge_errores_pg.vQuery;
 LV_cod_opta     NUMBER(38);
 LN_diferencia    NUMBER(38);
 ERROR_EJECUCION    EXCEPTION;

BEGIN
 SN_cod_retorno  := 0;
 SV_mens_retorno := ' ';
 SN_num_evento  := 0;

 LV_sSql:=' SELECT num_abonado  FROM ga_abocel';
 LV_sSql:=LV_sSql||' WHERE num_celular='||ESO_Abonado.num_celular;
 LV_sSql:=LV_sSql||' UNION';
 LV_sSql:=LV_sSql||' SELECT num_abonado FROM ga_aboamist';
 LV_sSql:=LV_sSql||' WHERE num_celular='||ESO_Abonado.num_celular;

 SELECT num_abonado
 INTO ESO_Abonado.num_abonado
 FROM ga_abocel
 WHERE num_celular=ESO_Abonado.num_celular
 AND COD_SITUACION != 'BAA'
 UNION
 SELECT num_abonado
 FROM ga_aboamist
 WHERE num_celular=ESO_Abonado.num_celular
 AND COD_SITUACION !=  'BAA';

 LV_sSql:='pv_obtiene_datos_abonado_pr('||ESO_Abonado.num_abonado||')';

 pv_obtiene_datos_abonado_pr(ESO_Abonado, SN_cod_retorno, SV_mens_retorno, SN_num_evento);
 IF SN_cod_retorno>0 THEN
    RAISE ERROR_EJECUCION;
 END IF;

EXCEPTION
 WHEN NO_DATA_FOUND THEN
  SN_cod_retorno := 144;
  IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
   SV_mens_retorno := CV_error_no_clasif;
  END IF;
  LV_des_error   := 'PV_OBTENER_ABONADO_CELULAR_PR('||ESO_Abonado.num_celular||') '||SQLERRM;
  SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_DATOS_ABONADO_PG.PV_OBTENER_ABONADO_CELULAR_PR', LV_sSQL, SN_cod_retorno, LV_des_error );
 WHEN ERROR_EJECUCION THEN
  LV_des_error   := 'PV_OBTENER_ABONADO_CELULAR_PR('||ESO_Abonado.num_celular||') '||SQLERRM;
  SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_DATOS_ABONADO_PG.PV_OBTENER_ABONADO_CELULAR_PR', LV_sSQL, SN_cod_retorno, LV_des_error);
 WHEN OTHERS THEN
  SN_cod_retorno := 156;
  IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
   SV_mens_retorno := CV_error_no_clasif;
  END IF;
  LV_des_error   := 'PV_OBTENER_ABONADO_CELULAR_PR('||ESO_Abonado.num_celular||') '||SQLERRM;
  SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_DATOS_ABONADO_PG.PV_OBTENER_ABONADO_CELULAR_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

END PV_OBTENER_ABONADO_CELULAR_PR;

------------------------------------------------------------------------------------------------------
PROCEDURE PV_OBTENER_MOVIMIENTO_PR (EO_Abonado      IN         GA_Abonado_QT,
              SO_movimientos OUT NOCOPY refcursor,
             SN_cod_retorno  OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
            SV_mens_retorno OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
            SN_num_evento   OUT NOCOPY ge_errores_pg.evento)
 IS
 /*
 <Documentación
   TipoDoc = "Procedure">>
    <Elemento
       Nombre = "PV_OBTENER_NUM_ABONADO_FN"
       Lenguaje="PL/SQL"
       Fecha="06-11-2007"
       Versión="La del package"
       Diseñador="FERNANDO MATELUNA"
       Programador="FERNANDO MATELUNA"
       Ambiente Desarrollo="BD">
       <Retorno>N/A</Retorno>>
       <Descripción></Descripción>>
       <Parámetros>
          <Entrada>
             <param nom="EO_permanencia" Tipo="estructura"><param>>
          </Entrada>
          <Salida>
             <param nom="SN_cod_retorno" Tipo="NUMERICO">Codigo de Retorno</param>>
             <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>>
             <param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>>
          </Salida>
       </Parámetros>
    </Elemento>
 </Documentación>
 */

 LV_des_error    ge_errores_pg.DesEvent;
 LV_sSql      ge_errores_pg.vQuery;
 LV_cod_opta     NUMBER(38);
 LN_diferencia    NUMBER(38);
 ERROR_EJECUCION    EXCEPTION;

BEGIN
         SN_cod_retorno  := 0;
         SV_mens_retorno := ' ';
         SN_num_evento  := 0;

  LV_sSql := 'SELECT NUM_MOVIMIENTO FROM ICC_MOVIMIENTO ';
  LV_sSql := LV_sSql || 'WHERE  NUM_ABONADO = '|| EO_Abonado.num_abonado;
  LV_sSql := LV_sSql || ' AND COD_ACTABO IN ('||CV_ACTABO_TERRENO;
  LV_sSql := LV_sSql || ', ' ||CV_ACTABO_OFICINA;
  LV_sSql := LV_sSql || ', ' ||CV_ACTABO_HIBRIDO ||')';

     OPEN SO_MOVIMIENTOS FOR
  SELECT NUM_MOVIMIENTO FROM ICC_MOVIMIENTO
  WHERE  NUM_ABONADO =  EO_Abonado.num_abonado
  AND COD_ACTABO IN (CV_ACTABO_TERRENO,
            CV_ACTABO_OFICINA,
         CV_ACTABO_HIBRIDO);

EXCEPTION
 WHEN NO_DATA_FOUND THEN
  SN_cod_retorno := 765;
  IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
   SV_mens_retorno := CV_error_no_clasif;
  END IF;
  LV_des_error   := 'PV_OBTENER_MOVIMIENTO_PR('||EO_Abonado.num_abonado||') '||SQLERRM;
  SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_DATOS_ABONADO_PG.PV_OBTENER_MOVIMIENTO_PR', LV_sSQL, SN_cod_retorno, LV_des_error );
 WHEN OTHERS THEN
  SN_cod_retorno := 69;
  IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
   SV_mens_retorno := CV_error_no_clasif;
  END IF;
  LV_des_error   := 'PV_OBTENER_MOVIMIENTO_PR('||EO_Abonado.num_abonado||') '||SQLERRM;
  SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_DATOS_ABONADO_PG.PV_OBTENER_MOVIMIENTO_PR', LV_sSQL, SN_cod_retorno, LV_des_error );
END PV_OBTENER_MOVIMIENTO_PR;

-----------------------------------------------------------------------------------------------------
FUNCTION PV_OBTIENE_ROL_USUARIO_FN (
              SO_Cliente       IN     PV_GA_ABOCEL_QT,
          SN_cod_retorno   OUT NOCOPY       ge_errores_td.cod_msgerror%TYPE,
          SV_mens_retorno  OUT NOCOPY       ge_errores_td.det_msgerror%TYPE,
          SN_num_evento    OUT NOCOPY  ge_errores_pg.evento)
 RETURN NUMBER
 AS
 /*
 <Documentación
   TipoDoc = "Function">>
    <Elemento
       Nombre = "PV_OBTENER_VALOR_CALC_PR"
       Lenguaje="PL/SQL"
       Fecha="17-08-2007"
       Versión="La del package"
       Diseñador=""
       Programador="Daniel Sagredo"
       Ambiente Desarrollo="BD">
       <Retorno>Varchar2</Retorno>>
       <Descripción>Obtiene el límite de líneas</Descripción>>
       <Parámetros>
          <Entrada>
             <param nom="SO_Cliente" Tipo="estructura">estructura de cliente</param>>
          </Entrada>
          <Salida>
             <param nom="SN_cod_retorno" Tipo="NUMERICO">Codigo de Retorno</param>>
             <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>>
             <param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>>
          </Salida>
       </Parámetros>
    </Elemento>
 </Documentación>
 */
   LV_sSql         ge_errores_pg.vQuery;
   LV_des_error       ge_errores_pg.DesEvent;
   RetVal NUMBER;


   BEGIN
     LV_sSql := 'VE_CTRL_LINEAS_PREPAGO_PG.VE_BUSCA_ROL_FN ('||SO_Cliente.NOM_USUARORA||')';

     RetVal := VE_CTRL_LINEAS_PREPAGO_PG.VE_BUSCA_ROL_FN ( SO_Cliente.NOM_USUARORA);

     RETURN RetVal;

      EXCEPTION
   WHEN OTHERS THEN
   SN_cod_retorno := 156;
       IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := CV_error_no_clasif;
       END IF;
     LV_des_error   := 'PV_OBTIENE_ROL_USUARIO_FN('||SO_Cliente.NOM_USUARORA||'); - ' || SQLERRM;
       SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_DATOS_CLIENTES_PG.PV_OBTIENE_ROL_USUARIO_FN', LV_sSQL, SN_cod_retorno, LV_des_error );

END PV_OBTIENE_ROL_USUARIO_FN;

------------------------------------------------------------------------------------------------------
PROCEDURE PV_BUSCA_ABONADOS_FILTRADOS_PR(EN_Cod_Cliente                 IN ge_clientes.cod_cliente%TYPE,
                                          EV_cod_tiplan                 IN ta_plantarif.cod_tiplan%TYPE,
                                          EN_num_abonado                        IN ga_abocel.num_abonado%TYPE,
                                          EN_num_celular                        IN ga_abocel.num_celular%TYPE,
                                          EV_num_rut                            IN ge_clientes.num_ident%TYPE,
                                          EN_max_filas                          IN NUMBER,
                                          EN_ultimo_reg                         IN NUMBER,
                                          EV_COD_PRESTACION             IN  GE_PRESTACIONES_TD.COD_PRESTACION%TYPE,
                                          SC_abonados         OUT NOCOPY  refCursor,
                                          SN_cod_retorno           OUT NOCOPY   ge_errores_td.cod_msgerror%TYPE,
                                          SV_mens_retorno          OUT NOCOPY   ge_errores_td.det_msgerror%TYPE,
                                          SN_num_evento            OUT NOCOPY   ge_errores_pg.evento)
IS
/*
 <Documentación
   TipoDoc = "Procedure">>
    <Elemento
       Nombre = "PV_BUSCA_ABONADOS_FILTRADOS_PR
       Lenguaje="PL/SQL"
       Fecha="Ene-2008"
       Versión="La del package"
       Diseñador="Juan Gonzalez C."
       Programador="Juan Gonzalez C."
       Ambiente Desarrollo="BD">
       <Retorno>N/A</Retorno>>
       <Descripción></Descripción>>
       <Parámetros>
          <Entrada>
             <param nom="EN_Cod_Cliente" Tipo="NUMERICO">Codigo de Clienteo</param>>
             <param nom="EV_cod_tiplan" Tipo="CARACTER">Tipo de Plan Tarifario</param>>
             <param nom="EN_num_abonado" Tipo="NUMERICO">Numero de Abonado</param>>
             <param nom="EN_num_celular" Tipo="NUMERICO">Numero de Celular</param>>
             <param nom="EV_num_rut" Tipo="CARACTER">Numero de RUT</param>>
             <param nom="EN_max_filas" Tipo="NUMERICO">Maximo de Filas a Retornar</param>>
             <param nom="EN_ultimo_reg" Tipo="NUMERICO">Rowid de ultimo registro retornado</param>>
          </Entrada>
          <Salida>
             <param nom="SC_Abonado" Tipo="CURSOR">Cursor con datos de un abonado</param>>
             <param nom="SN_cod_retorno" Tipo="NUMERICO">Codigo de Retorno</param>>
             <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>>
             <param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>>
          </Salida>
       </Parámetros>
    </Elemento>
 </Documentación>
*/
        LV_des_error    ge_errores_pg.DesEvent;
        LV_sSql      ge_errores_pg.vQuery;
        ERROR_DE_PROCESO exception;

 BEGIN
        SN_cod_retorno  := 0;
        SV_mens_retorno := ' ';
        SN_num_evento  := 0;

        IF TRIM(EN_Cod_Cliente) IS NULL THEN
                SN_cod_retorno := 1001;
                LV_des_error := 'Falta Parámetro Codigo de Cliente';
                                RAISE ERROR_DE_PROCESO;
        END IF;

        IF TRIM(EV_cod_tiplan) IS NULL THEN
                SN_cod_retorno := 1002;
                LV_des_error := 'Falta Parámetro Tipo Plan Tarifario';
                                RAISE ERROR_DE_PROCESO;
        END IF;


        LV_sSql:= LV_sSql||' SELECT DISTINCT a.nom_cliente||'''||'  '||'''||a.nom_apeclien1||'''||'  '||'''||a.nom_apeclien2 nom_usuario,';
        LV_sSql:= LV_sSql||' a.cod_cliente, b.num_abonado, b.num_celular, b.num_serie, b.num_imei, b.cod_tecnologia, b.cod_situacion,';
        LV_sSql:= LV_sSql||' d.des_situacion, b.tip_plantarif, DECODE(b.tip_plantarif,''E'',''EMPRESA'', ''I'', ''INDIVIDUAL'') AS des_tipplantarif,';
        LV_sSql:= LV_sSql||' b.cod_plantarif, c.des_plantarif, b.cod_ciclo, c.cod_limconsumo, e.des_limconsumo, b.cod_planserv, b.cod_uso,';
        LV_sSql:= LV_sSql||' c.cod_tiplan, DECODE(c.cod_tiplan,''1'',''PREPAGO'', ''2'', ''POSPAGO'', ''3'', ''HIBRIDO'') AS des_tiplan,';
        LV_sSql:= LV_sSql||' b.cod_tipcontrato, b.fec_alta, b.fec_fincontra, b.ind_eqprestado, b.fec_prorroga, c.flg_rango, f.imp_cargobasico,';
        LV_sSql:= LV_sSql||' b.num_anexo, b.cod_usuario, b.tip_terminal, g.des_terminal, b.num_venta, b.cod_cuenta, b.cod_subcuenta,';
        --LV_sSql:= LV_sSql||' b.cod_vendedor, b.cod_causa_venta, b.fec_baja, b.fec_bajacen, b.fec_ultmod, DECODE(b.ind_disp, NULL, -1), b.COD_CENTRAL'; -- FPP COL 84180, 30-03-2009
                          LV_sSql:= LV_sSql||' b.cod_vendedor, b.cod_causa_venta, b.fec_baja, b.fec_bajacen, b.fec_ultmod, NVL(b.ind_disp, -1), b.COD_CENTRAL'; -- FPP COL 84180, 30-03-2009
        LV_sSql:= LV_sSql||' FROM ge_clientes a, ga_abocel b, ta_plantarif c, ga_situabo d, ta_limconsumo e, ta_cargosbasico f, al_tipos_terminales g';
        LV_sSql:= LV_sSql||' WHERE b.cod_cliente = '||EN_cod_cliente;
        LV_sSql:= LV_sSql||' AND c.cod_tiplan = '''||EV_cod_tiplan||'''';

        IF TRIM(EN_num_abonado) IS NOT NULL THEN
                LV_sSql:= LV_sSql||' AND TO_CHAR(b.num_abonado) LIKE '''||EN_num_abonado||'%''';
        END IF;

        IF TRIM(EN_num_celular) IS NOT NULL THEN
                LV_sSql:= LV_sSql||' AND TO_CHAR(b.num_celular) LIKE '''||EN_num_celular||'%''';
        END IF;

        IF TRIM(EV_num_rut) IS NOT NULL THEN
                LV_sSql:= LV_sSql||' AND a.num_ident = '''||EV_num_rut||'''';
                LV_sSql:= LV_sSql||' AND a.cod_tipident = '''||'02'||'''';
        END IF;

        LV_sSql:= LV_sSql||' AND a.cod_cliente   = b.cod_cliente';
        LV_sSql:= LV_sSql||' AND b.cod_plantarif = c.cod_plantarif';
        LV_sSql:= LV_sSql||' AND b.cod_PRESTACION = ' || EV_COD_PRESTACION;
        LV_sSql:= LV_sSql||' AND b.cod_situacion = d.cod_situacion';
        LV_sSql:= LV_sSql||' AND e.cod_limconsumo = c.cod_limconsumo';
        LV_sSql:= LV_sSql||' AND c.cod_cargobasico = f.cod_cargobasico';
        LV_sSql:= LV_sSql||' AND b.cod_situacion NOT IN (''BAA'',''BAP'')';
        LV_sSql:= LV_sSql||' AND SYSDATE BETWEEN f.fec_desde AND f.fec_hasta';
        LV_sSql:= LV_sSql||' AND g.cod_producto = b.cod_producto';
        LV_sSql:= LV_sSql||' AND g.tip_terminal = b.tip_terminal';
        --LV_sSql:= LV_sSql||' AND u.cod_usuario = b.cod_usuario';

        LV_sSql:= LV_sSql||' UNION';

        LV_sSql:= LV_sSql||' SELECT DISTINCT a.nom_cliente||'''||'  '||'''||a.nom_apeclien1||'''||'  '||'''||a.nom_apeclien2 nom_usuario,';
        LV_sSql:= LV_sSql||' a.cod_cliente, b.num_abonado, b.num_celular, b.num_serie, b.num_imei, b.cod_tecnologia, b.cod_situacion,';
        LV_sSql:= LV_sSql||' d.des_situacion, b.tip_plantarif, DECODE(b.tip_plantarif,''E'',''EMPRESA'', ''I'', ''INDIVIDUAL'') AS des_tipplantarif,';
        LV_sSql:= LV_sSql||' b.cod_plantarif, c.des_plantarif, b.cod_ciclo, c.cod_limconsumo, e.des_limconsumo, b.cod_planserv, b.cod_uso,';
        LV_sSql:= LV_sSql||' c.cod_tiplan, DECODE(c.cod_tiplan,''1'',''PREPAGO'', ''2'', ''POSPAGO'', ''3'', ''HIBRIDO'') AS des_tiplan,';
        LV_sSql:= LV_sSql||' b.cod_tipcontrato, b.fec_alta, b.fec_fincontra, null ind_eqprestado, null fec_prorroga, c.flg_rango, f.imp_cargobasico,';
        LV_sSql:= LV_sSql||' b.num_anexo, b.cod_usuario, b.tip_terminal, g.des_terminal, b.num_venta, b.cod_cuenta, b.cod_subcuenta,';
                                -- LV_sSql:= LV_sSql||' b.cod_vendedor, b.cod_causa_venta, b.fec_baja, b.fec_bajacen, b.fec_ultmod, DECODE(b.ind_disp, NULL, -1), b.COD_CENTRAL';  -- FPP COL 84180, 30-03-2009
        LV_sSql:= LV_sSql||' b.cod_vendedor, b.cod_causa_venta, b.fec_baja, b.fec_bajacen, b.fec_ultmod, NVL(b.ind_disp, -1), b.COD_CENTRAL';  -- FPP COL 84180, 30-03-2009

        LV_sSql:= LV_sSql||' FROM ge_clientes a, ga_aboamist b, ta_plantarif c, ga_situabo d, ta_limconsumo e, ta_cargosbasico f, al_tipos_terminales g ';
        LV_sSql:= LV_sSql||' WHERE b.cod_cliente = '||EN_cod_cliente;
        LV_sSql:= LV_sSql||' AND c.cod_tiplan = '''||EV_cod_tiplan||'''';

        IF TRIM(EN_num_abonado) IS NOT NULL THEN
                LV_sSql:= LV_sSql||' AND TO_CHAR(b.num_abonado) LIKE '''||EN_num_abonado||'%''';
        END IF;

        IF TRIM(EN_num_celular) IS NOT NULL THEN
                LV_sSql:= LV_sSql||' AND TO_CHAR(b.num_celular) LIKE '''||EN_num_celular||'%''';
        END IF;

        IF TRIM(EV_num_rut) IS NOT NULL THEN
                LV_sSql:= LV_sSql||' AND a.num_ident = '''||EV_num_rut||'''';
                LV_sSql:= LV_sSql||' AND a.cod_tipident = '''||'02'||'''';
        END IF;

        LV_sSql:= LV_sSql||' AND a.cod_cliente   = b.cod_cliente';
        LV_sSql:= LV_sSql||' AND b.cod_plantarif = c.cod_plantarif';
        LV_sSql:= LV_sSql||' AND b.cod_PRESTACION = ' || EV_COD_PRESTACION;
        LV_sSql:= LV_sSql||' AND b.cod_situacion = d.cod_situacion';
        LV_sSql:= LV_sSql||' AND e.cod_limconsumo = c.cod_limconsumo';
        LV_sSql:= LV_sSql||' AND c.cod_cargobasico = f.cod_cargobasico';
        LV_sSql:= LV_sSql||' AND b.cod_situacion NOT IN (''BAA'',''BAP'')';
        LV_sSql:= LV_sSql||' AND SYSDATE BETWEEN f.fec_desde AND f.fec_hasta';
        LV_sSql:= LV_sSql||' AND g.cod_producto = b.cod_producto';
        LV_sSql:= LV_sSql||' AND g.tip_terminal = b.tip_terminal';
--        LV_sSql:= LV_sSql||' AND u.cod_usuario = b.cod_usuario';

        OPEN SC_abonados FOR LV_sSql;

EXCEPTION
        WHEN ERROR_DE_PROCESO THEN
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                        SV_mens_retorno := LV_des_error;
                END IF;
                LV_des_error   := ' PV_BUSCA_ABONADOS_FILTRADOS_PR('||LV_des_error||'); ';
                SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_DATOS_ABONADO_PG.PV_BUSCA_ABONADOS_FILTRADOS_PR', LV_sSQL, SN_cod_retorno, LV_des_error );
        WHEN NO_DATA_FOUND THEN
                SN_cod_retorno := 203;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                        SV_mens_retorno := CV_error_no_clasif;
                END IF;
                LV_des_error   := ' PV_BUSCA_ABONADOS_FILTRADOS_PR('||EN_cod_cliente||'); '||SQLERRM;
                SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_DATOS_ABONADO_PG.PV_BUSCA_ABONADOS_FILTRADOS_PR', LV_sSQL, SN_cod_retorno, LV_des_error );
        WHEN OTHERS THEN
                SN_cod_retorno := 156;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                        SV_mens_retorno := CV_error_no_clasif;
                END IF;
                LV_des_error   := ' PV_BUSCA_ABONADOS_FILTRADOS_PR('||EN_cod_cliente||'); '||SQLERRM;
                SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_DATOS_ABONADO_PG.PV_BUSCA_ABONADOS_FILTRADOS_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

END PV_BUSCA_ABONADOS_FILTRADOS_PR;

------------------------------------------------------------------------------------------------------
PROCEDURE PV_VALIDA_FILTRO_ABONADOS_PR(EN_Cod_Cliente           IN ge_clientes.cod_cliente%TYPE,
                                          EV_cod_os                     IN pv_iorserv.cod_os%TYPE,
                                          EN_max_abonados                               IN NUMBER,
                                          SV_respuesta         OUT NOCOPY  VARCHAR2,
                                          SN_cod_retorno           OUT NOCOPY   ge_errores_td.cod_msgerror%TYPE,
                                          SV_mens_retorno          OUT NOCOPY   ge_errores_td.det_msgerror%TYPE,
                                          SN_num_evento            OUT NOCOPY   ge_errores_pg.evento)
IS
/*
 <Documentación
   TipoDoc = "Procedure">>
    <Elemento
       Nombre = "PV_VALIDA_FILTRO_ABONADOS_PR
       Lenguaje="PL/SQL"
       Fecha="Ene-2008"
       Versión="La del package"
       Diseñador="Juan Gonzalez C."
       Programador="Juan Gonzalez C."
       Ambiente Desarrollo="BD">
       <Retorno>N/A</Retorno>>
       <Descripción></Descripción>>
       <Parámetros>
          <Entrada>
             <param nom="EN_Cod_Cliente" Tipo="NUMERICO">Codigo de Clienteo</param>>
             <param nom="EV_Cod_Os" Tipo="CARACTER">Codigo de Orden de Servicio</param>>
             <param nom="EN_Max_Abonados" Tipo="NUMERICO">Numero Maximo de Abonados por Cliente</param>>
          </Entrada>
          <Salida>
             <param nom="SV_Respuesta" Tipo="CARACTER">Texto de Respuesta (TRUE o FALSE)</param>>
             <param nom="SN_cod_retorno" Tipo="NUMERICO">Codigo de Retorno</param>>
             <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>>
             <param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>>
          </Salida>
       </Parámetros>
    </Elemento>
 </Documentación>
*/
        LV_des_error    ge_errores_pg.DesEvent;
        LV_sSql      ge_errores_pg.vQuery;

        LN_Cant_Abo NUMBER;
        LN_Cant_Plan NUMBER;
        LN_Cant_TEC  NUMBER;
        LN_Cant_Calif  NUMBER;

        ERROR_DE_PROCESO exception;

BEGIN
        SV_Respuesta := 'TRUE';
        SN_cod_retorno  := 0;
        SV_mens_retorno := ' ';
        SN_num_evento  := 0;

        IF TRIM(EN_Cod_Cliente) IS NULL THEN
                SN_cod_retorno := 1001;
                LV_des_error := 'Falta Parametro Codigo de Cliente';
                                RAISE ERROR_DE_PROCESO;
        END IF;

        IF TRIM(EV_Cod_Os) IS NULL THEN
                SN_cod_retorno := 1002;
                LV_des_error := 'Falta Parametro Codigo OOSS';
                                RAISE ERROR_DE_PROCESO;
        END IF;

        IF TRIM(EN_Max_Abonados) IS NULL THEN
                SN_cod_retorno := 1003;
                LV_des_error := 'Falta Parametro Maximo de Abonados por Cliente';
                                RAISE ERROR_DE_PROCESO;
        END IF;

        IF TRIM(EV_cod_os) = CV_Cod_OOSS_Emp OR TRIM(EV_cod_os) = CV_Cod_OOSS_Reord THEN
                LV_sSql := ' SELECT SUM(cant) FROM (SELECT COUNT(1) cant';
                LV_sSql := LV_sSql || ' FROM ge_clientes a, ga_abocel b, ta_plantarif c, ga_situabo d, ta_limconsumo e, ta_cargosbasico f, al_tipos_terminales g, ga_usuarios u';
                LV_sSql := LV_sSql || ' WHERE b.cod_cliente = '||EN_cod_cliente;
                LV_sSql := LV_sSql || ' AND a.cod_cliente   = b.cod_cliente';
                LV_sSql := LV_sSql || ' AND b.cod_plantarif = c.cod_plantarif';
                LV_sSql := LV_sSql || ' AND b.cod_situacion = d.cod_situacion';
                LV_sSql := LV_sSql || ' AND e.cod_limconsumo = c.cod_limconsumo';
                LV_sSql := LV_sSql || ' AND c.cod_cargobasico = f.cod_cargobasico';
                LV_sSql := LV_sSql || ' AND b.cod_situacion NOT IN (''BAA'',''BAP'')';
                LV_sSql := LV_sSql || ' AND SYSDATE BETWEEN f.fec_desde AND f.fec_hasta';
                LV_sSql := LV_sSql || ' AND g.cod_producto = b.cod_producto';
                LV_sSql := LV_sSql || ' AND g.tip_terminal = b.tip_terminal';
                LV_sSql := LV_sSql || ' AND u.cod_usuario = b.cod_usuario';
                LV_sSql := LV_sSql || ' UNION ';
                LV_sSql := LV_sSql || ' SELECT COUNT(1) cant';
                LV_sSql := LV_sSql || ' FROM ge_clientes a, ga_aboamist b, ta_plantarif c, ga_situabo d, ta_limconsumo e, ta_cargosbasico f, al_tipos_terminales g, ga_usuarios u';
                LV_sSql := LV_sSql || ' WHERE b.cod_cliente = '||EN_cod_cliente;
                LV_sSql := LV_sSql || ' AND a.cod_cliente   = b.cod_cliente';
                LV_sSql := LV_sSql || ' AND b.cod_plantarif = c.cod_plantarif';
                LV_sSql := LV_sSql || ' AND b.cod_situacion = d.cod_situacion';
                LV_sSql := LV_sSql || ' AND e.cod_limconsumo = c.cod_limconsumo';
                LV_sSql := LV_sSql || ' AND c.cod_cargobasico = f.cod_cargobasico';
                LV_sSql := LV_sSql || ' AND b.cod_situacion NOT IN (''BAA'',''BAP'')';
                LV_sSql := LV_sSql || ' AND SYSDATE BETWEEN f.fec_desde AND f.fec_hasta';
                LV_sSql := LV_sSql || ' AND g.cod_producto = b.cod_producto';
                LV_sSql := LV_sSql || ' AND g.tip_terminal = b.tip_terminal';
                LV_sSql := LV_sSql || ' AND u.cod_usuario = b.cod_usuario)';

                SELECT SUM(cant)
                                INTO   LN_Cant_Abo
                                FROM (SELECT COUNT(1) AS cant
                           FROM ge_clientes a, ga_abocel b, ta_plantarif c, ga_situabo d,
                                                   ta_limconsumo e, ta_cargosbasico f, al_tipos_terminales g --, ga_usuarios u
                           WHERE b.cod_cliente = EN_cod_cliente
                           AND a.cod_cliente   = b.cod_cliente
                           AND b.cod_plantarif = c.cod_plantarif
                           AND b.cod_situacion = d.cod_situacion
                           AND e.cod_limconsumo = c.cod_limconsumo
                           AND c.cod_cargobasico = f.cod_cargobasico
                           AND b.cod_situacion NOT IN ('BAA','BAP')
                           AND SYSDATE BETWEEN f.fec_desde AND f.fec_hasta
                           AND g.cod_producto = b.cod_producto
                           AND g.tip_terminal = b.tip_terminal
                         --  AND u.cod_usuario = b.cod_usuario
                           UNION
                           SELECT COUNT(1) AS cant
                           FROM ge_clientes a, ga_aboamist b, ta_plantarif c, ga_situabo d,
                                                   ta_limconsumo e, ta_cargosbasico f, al_tipos_terminales g --, ga_usuarios u
                           WHERE b.cod_cliente = EN_cod_cliente
                           AND a.cod_cliente   = b.cod_cliente
                           AND b.cod_plantarif = c.cod_plantarif
                           AND b.cod_situacion = d.cod_situacion
                           AND e.cod_limconsumo = c.cod_limconsumo
                           AND c.cod_cargobasico = f.cod_cargobasico
                           AND b.cod_situacion NOT IN ('BAA','BAP')
                           AND SYSDATE BETWEEN f.fec_desde AND f.fec_hasta
                           AND g.cod_producto = b.cod_producto
                           AND g.tip_terminal = b.tip_terminal
                           --AND u.cod_usuario = b.cod_usuario
                                                   );

                                IF LN_Cant_Abo >= EN_Max_Abonados THEN -- Numero de Abonados >= Maximo de Abonados permitido sin Filtro --
                        SV_Respuesta := 'TRUE';
                ELSE
                        LV_sSql := ' SELECT COUNT(DISTINCT cod_tiplan) FROM (SELECT c.cod_tiplan';
                        LV_sSql := LV_sSql || ' FROM ge_clientes a, ga_abocel b, ta_plantarif c, ga_situabo d, ta_limconsumo e, ta_cargosbasico f, al_tipos_terminales g, ga_usuarios u';
                        LV_sSql := LV_sSql || ' WHERE b.cod_cliente = '|| EN_cod_cliente;
                        LV_sSql := LV_sSql || ' AND a.cod_cliente   = b.cod_cliente';
                        LV_sSql := LV_sSql || ' AND b.cod_plantarif = c.cod_plantarif';
                        LV_sSql := LV_sSql || ' AND b.cod_situacion = d.cod_situacion';
                        LV_sSql := LV_sSql || ' AND e.cod_limconsumo = c.cod_limconsumo';
                        LV_sSql := LV_sSql || ' AND c.cod_cargobasico = f.cod_cargobasico';
                        LV_sSql := LV_sSql || ' AND b.cod_situacion NOT IN (''BAA'',''BAP'')';
                        LV_sSql := LV_sSql || ' AND SYSDATE BETWEEN f.fec_desde AND f.fec_hasta';
                        LV_sSql := LV_sSql || ' AND g.cod_producto = b.cod_producto';
                        LV_sSql := LV_sSql || ' AND g.tip_terminal = b.tip_terminal';
                        LV_sSql := LV_sSql || ' AND u.cod_usuario = b.cod_usuario';
                        LV_sSql := LV_sSql || ' UNION';
                        LV_sSql := LV_sSql || ' SELECT c.cod_tiplan';
                        LV_sSql := LV_sSql || ' FROM ge_clientes a, ga_aboamist b, ta_plantarif c, ga_situabo d, ta_limconsumo e, ta_cargosbasico f, al_tipos_terminales g, ga_usuarios u';
                        LV_sSql := LV_sSql || ' WHERE b.cod_cliente = '|| EN_cod_cliente;
                        LV_sSql := LV_sSql || ' AND a.cod_cliente   = b.cod_cliente';
                        LV_sSql := LV_sSql || ' AND b.cod_plantarif = c.cod_plantarif';
                        LV_sSql := LV_sSql || ' AND b.cod_situacion = d.cod_situacion';
                        LV_sSql := LV_sSql || ' AND e.cod_limconsumo = c.cod_limconsumo';
                        LV_sSql := LV_sSql || ' AND c.cod_cargobasico = f.cod_cargobasico';
                        LV_sSql := LV_sSql || ' AND b.cod_situacion NOT IN (''BAA'',''BAP'')';
                        LV_sSql := LV_sSql || ' AND SYSDATE BETWEEN f.fec_desde AND f.fec_hasta';
                        LV_sSql := LV_sSql || ' AND g.cod_producto = b.cod_producto';
                        LV_sSql := LV_sSql || ' AND g.tip_terminal = b.tip_terminal';
                        LV_sSql := LV_sSql || ' AND u.cod_usuario = b.cod_usuario)';

                        SELECT COUNT(DISTINCT cod_tiplan)
                        INTO   LN_Cant_Plan
                        FROM (SELECT c.cod_tiplan
                                   FROM ge_clientes a, ga_abocel b, ta_plantarif c, ga_situabo d,
                                                                   ta_limconsumo e, ta_cargosbasico f, al_tipos_terminales g --, ga_usuarios u
                                   WHERE b.cod_cliente = EN_cod_cliente
                                   AND a.cod_cliente   = b.cod_cliente
                                   AND b.cod_plantarif = c.cod_plantarif
                                   AND b.cod_situacion = d.cod_situacion
                                   AND e.cod_limconsumo = c.cod_limconsumo
                                   AND c.cod_cargobasico = f.cod_cargobasico
                                   AND b.cod_situacion NOT IN ('BAA','BAP')
                                   AND SYSDATE BETWEEN f.fec_desde AND f.fec_hasta
                                   AND g.cod_producto = b.cod_producto
                                   AND g.tip_terminal = b.tip_terminal
                                   --AND u.cod_usuario = b.cod_usuario
                                   UNION
                                   SELECT c.cod_tiplan
                                   FROM ge_clientes a, ga_aboamist b, ta_plantarif c, ga_situabo d,
                                                                   ta_limconsumo e, ta_cargosbasico f, al_tipos_terminales g --, ga_usuarios u
                                   WHERE b.cod_cliente = EN_cod_cliente
                                   AND a.cod_cliente   = b.cod_cliente
                                   AND b.cod_plantarif = c.cod_plantarif
                                   AND b.cod_situacion = d.cod_situacion
                                   AND e.cod_limconsumo = c.cod_limconsumo
                                   AND c.cod_cargobasico = f.cod_cargobasico
                                   AND b.cod_situacion NOT IN ('BAA','BAP')
                                   AND SYSDATE BETWEEN f.fec_desde AND f.fec_hasta
                                   AND g.cod_producto = b.cod_producto
                                   AND g.tip_terminal = b.tip_terminal
                                   --AND u.cod_usuario = b.cod_usuario
                                                                   );

                        IF LN_Cant_Plan > 1 THEN -- Abonados Tienen mas de un Plan --
                                SV_Respuesta := 'TRUE';
                        ELSE
                                SV_Respuesta := 'FALSE';
                        END IF;

                        -- (+) EV 08/10/08     validacion de tecnologia

                        IF (SV_Respuesta = 'FALSE') THEN
                            SELECT COUNT(DISTINCT cod_tecnologia)
                            INTO   LN_Cant_TEC
                            FROM (SELECT b.cod_tecnologia
                                       FROM ge_clientes a, ga_abocel b, ta_plantarif c, ga_situabo d,
                                                                       ta_limconsumo e, ta_cargosbasico f, al_tipos_terminales g --, ga_usuarios u
                                       WHERE b.cod_cliente = EN_cod_cliente
                                       AND a.cod_cliente   = b.cod_cliente
                                       AND b.cod_plantarif = c.cod_plantarif
                                       AND b.cod_situacion = d.cod_situacion
                                       AND e.cod_limconsumo = c.cod_limconsumo
                                       AND c.cod_cargobasico = f.cod_cargobasico
                                       AND b.cod_situacion NOT IN ('BAA','BAP')
                                       AND SYSDATE BETWEEN f.fec_desde AND f.fec_hasta
                                       AND g.cod_producto = b.cod_producto
                                       AND g.tip_terminal = b.tip_terminal
                                       --AND u.cod_usuario = b.cod_usuario
                                       UNION
                                       SELECT b.cod_tecnologia
                                       FROM ge_clientes a, ga_aboamist b, ta_plantarif c, ga_situabo d,
                                                                       ta_limconsumo e, ta_cargosbasico f, al_tipos_terminales g --, ga_usuarios u
                                       WHERE b.cod_cliente = EN_cod_cliente
                                       AND a.cod_cliente   = b.cod_cliente
                                       AND b.cod_plantarif = c.cod_plantarif
                                       AND b.cod_situacion = d.cod_situacion
                                       AND e.cod_limconsumo = c.cod_limconsumo
                                       AND c.cod_cargobasico = f.cod_cargobasico
                                       AND b.cod_situacion NOT IN ('BAA','BAP')
                                       AND SYSDATE BETWEEN f.fec_desde AND f.fec_hasta
                                       AND g.cod_producto = b.cod_producto
                                       AND g.tip_terminal = b.tip_terminal
                                       --AND u.cod_usuario = b.cod_usuario
                                                                       );

                            IF LN_Cant_TEC > 1 THEN -- Abonados Tienen mas de una tecnologia --
                                    SV_Respuesta := 'TRUE';
                            ELSE
                                    SV_Respuesta := 'FALSE';
                            END IF;

                           -- (+) EV 03/06/2010    validacion de calificacion abonados prepago
                            IF (SV_Respuesta = 'FALSE') THEN

                                SELECT COUNT(DISTINCT cod_califica)
                                INTO   LN_Cant_Calif
                                FROM ( SELECT NVL(h.cod_califica,' ') AS cod_califica
                                           FROM ge_clientes a, ga_aboamist b, ta_plantarif c, ga_situabo d,
                                                ta_limconsumo e, ta_cargosbasico f, al_tipos_terminales g,
                                                pv_califica_celular_to h
                                           WHERE b.cod_cliente = EN_cod_cliente
                                           AND a.cod_cliente   = b.cod_cliente
                                           AND b.cod_plantarif = c.cod_plantarif
                                           AND b.cod_situacion = d.cod_situacion
                                           AND e.cod_limconsumo = c.cod_limconsumo
                                           AND c.cod_cargobasico = f.cod_cargobasico
                                           AND b.cod_situacion NOT IN ('BAA','BAP')
                                           AND SYSDATE BETWEEN f.fec_desde AND f.fec_hasta
                                           AND g.cod_producto = b.cod_producto
                                           AND g.tip_terminal = b.tip_terminal
                                           AND b.num_abonado = h.num_abonado(+)
                                           AND b.num_celular = h.num_celular(+)
                                           AND h.vigencia(+) = 1
                                      );

                                IF LN_Cant_Calif > 1 THEN -- Abonados Tienen mas de una calificacion --
                                        SV_Respuesta := 'TRUE';
                                ELSE
                                        SV_Respuesta := 'FALSE';
                                END IF;

                            END IF;
                            -- (-) EV 03/06/2010    validacion de calificacion abonados prepago


                        END IF; --fin IF (SV_Respuesta = 'FALSE')

                        -- (-)
                END IF;
        ELSE
                SV_Respuesta := 'FALSE';
        END IF;

EXCEPTION
        WHEN ERROR_DE_PROCESO THEN
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                        SV_mens_retorno := LV_des_error;
                END IF;
                LV_des_error   := ' PV_VALIDA_FILTRO_ABONADOS_PR('||LV_des_error||'); ';
                SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_DATOS_ABONADO_PG.PV_VALIDA_FILTRO_ABONADOS_PR', LV_sSQL, SN_cod_retorno, LV_des_error );
        WHEN NO_DATA_FOUND THEN
                SN_cod_retorno := 203;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                        SV_mens_retorno := CV_error_no_clasif;
                END IF;
                LV_des_error   := ' PV_VALIDA_FILTRO_ABONADOS_PR('||EN_cod_cliente||'); '||SQLERRM;
                SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_DATOS_ABONADO_PG.PV_VALIDA_FILTRO_ABONADOS_PR', LV_sSQL, SN_cod_retorno, LV_des_error );
        WHEN OTHERS THEN
                SN_cod_retorno := 156;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                        SV_mens_retorno := CV_error_no_clasif;
                END IF;
                LV_des_error   := ' PV_VALIDA_FILTRO_ABONADOS_PR('||EN_cod_cliente||'); '||SQLERRM;
                SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_DATOS_ABONADO_PG.PV_VALIDA_FILTRO_ABONADOS_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

END PV_VALIDA_FILTRO_ABONADOS_PR;
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE PV_OBTIENE_NUMPERSONAL_PR (EO_GA_NUM_PERSONAL IN OUT        PV_VAL_BAJA_ATLANTIDA_QT,
                                                         SN_cod_retorno     OUT NOCOPY    ge_errores_td.cod_msgerror%TYPE,
                                                                 SV_mens_retorno    OUT NOCOPY    ge_errores_td.det_msgerror%TYPE,
                                                                 SN_num_evento      OUT NOCOPY    ge_errores_pg.evento)

 IS
 /*
 <Documentación
   TipoDoc = "Procedure">>
    <Elemento
       Nombre = "PV_OBTIENE_NUMPERSONAL_PR"
       Lenguaje="PL/SQL"
       Fecha="09-01-2008"
       Versión="La del package"
       Diseñador="YESENIA OSSES"
       Programador="YESENIA OSSES"
       Ambiente Desarrollo="BD">
       <Retorno>N/A</Retorno>>
       <Descripción></Descripción>>
       <Parámetros>
          <Entrada>
             <param nom="EO_GA_NUM_PERSONAL" Tipo="estructura"><param>>
          </Entrada>
          <Salida>
             <param nom="SN_cod_retorno" Tipo="NUMERICO">Codigo de Retorno</param>>
             <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>>
             <param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>>
          </Salida>
       </Parámetros>
    </Elemento>
 </Documentación>
 */

 LV_des_error    ge_errores_pg.DesEvent;
 LV_sSql      ge_errores_pg.vQuery;

BEGIN
        SN_cod_retorno  := 0;
        SV_mens_retorno := ' ';
        SN_num_evento  := 0;

                LV_sSql := 'SELECT NUM_CEL_PERS FROM GA_NUMCEL_PERSONAL_TO';
                LV_sSql := LV_sSql || 'WHERE NUM_CEL_CORP = '|| EO_GA_NUM_PERSONAL.NUM_CELULAR ;


        SELECT NUM_CEL_PERS INTO EO_GA_NUM_PERSONAL.NUM_CELULAR_NUE
                FROM GA_NUMCEL_PERSONAL_TO WHERE NUM_CEL_CORP = EO_GA_NUM_PERSONAL.NUM_CELULAR;


EXCEPTION
                 WHEN NO_DATA_FOUND THEN
                          EO_GA_NUM_PERSONAL.NUM_CELULAR_NUE := 0;

                WHEN OTHERS THEN
                 SN_cod_retorno := 156;
                         IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                                SV_mens_retorno := CV_error_no_clasif;
                         END IF;

                         LV_des_error   := 'PV_DATOS_ABONADO_PG.PV_OBTIENE_NUMPERSONAL_PR('||EO_GA_NUM_PERSONAL.NUM_CELULAR ||') '||SQLERRM;
                         SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_DATOS_ABONADO_PG.PV_OBTIENE_NUMPERSONAL_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

END PV_OBTIENE_NUMPERSONAL_PR;
--------------------------------------------------------------------------------------------------------

PROCEDURE PV_MASCARA_NUMPERSONAL_PR(EO_GA_NUM_PERSONAL IN OUT        PV_VAL_BAJA_ATLANTIDA_QT,
                                                                SN_cod_retorno     OUT NOCOPY    ge_errores_td.cod_msgerror%TYPE,
                                                                SV_mens_retorno    OUT NOCOPY    ge_errores_td.det_msgerror%TYPE,
                                                                SN_num_evento      OUT NOCOPY    ge_errores_pg.evento)

 IS
 /*
 <Documentación
   TipoDoc = "Procedure">>
    <Elemento
       Nombre = "PV_OBTIENE_NUMPERSONAL_PR"
       Lenguaje="PL/SQL"
       Fecha="09-01-2008"
       Versión="La del package"
       Diseñador="YESENIA OSSES"
       Programador="YESENIA OSSES"
       Ambiente Desarrollo="BD">
       <Retorno>N/A</Retorno>>
       <Descripción></Descripción>>
       <Parámetros>
          <Entrada>
             <param nom="EO_GA_NUM_PERSONAL" Tipo="estructura"><param>>
          </Entrada>
          <Salida>
             <param nom="SN_cod_retorno" Tipo="NUMERICO">Codigo de Retorno</param>>
             <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>>
             <param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>>
          </Salida>
       </Parámetros>
    </Elemento>
 </Documentación>
 */

 LV_des_error    ge_errores_pg.DesEvent;
 LV_sSql      ge_errores_pg.vQuery;
 LN_valor  NUMBER(1);

BEGIN
        SN_cod_retorno  := 0;
        SV_mens_retorno := ' ';
        SN_num_evento  := 0;

                LV_sSql := 'GA_NUMCEL_PERSONAL_PG.GA_EXISTE_NUMCORPORATIVO2_FN(';
                LV_sSql := LV_sSql || EO_GA_NUM_PERSONAL.NUM_CELULAR || ')' ;

        LN_valor := GA_NUMCEL_PERSONAL_PG.GA_EXISTE_NUMCORPORATIVO2_FN(EO_GA_NUM_PERSONAL.NUM_CELULAR);

                IF LN_valor  = 0 THEN
           EO_GA_NUM_PERSONAL.COD_ESTADO := 0; --no es corporativo
        ELSE
           EO_GA_NUM_PERSONAL.COD_ESTADO := 1; --es corporativo
        END IF;

EXCEPTION
                 WHEN OTHERS THEN
                           SN_cod_retorno := 156;
                           IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                                   SV_mens_retorno := CV_error_no_clasif;
                           END IF;
                           LV_des_error   := 'PV_DATOS_ABONADO_PG.PV_MASCARA_NUMPERSONAL_PR('||EO_GA_NUM_PERSONAL.NUM_CELULAR_NUE  ||') '||SQLERRM;
                           SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_DATOS_ABONADO_PG.PV_MASCARA_NUMPERSONAL_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

END PV_MASCARA_NUMPERSONAL_PR;

--------------------------------------------------------------------------------------------------------
PROCEDURE PV_MASCARA_CORPORATIVO_PR(EO_GA_CORPORATIVO  IN OUT        PV_OBT_CAMB_PLAN_SERV_QT,
                                                                        SN_cod_retorno     OUT NOCOPY    ge_errores_td.cod_msgerror%TYPE,
                                                                        SV_mens_retorno    OUT NOCOPY    ge_errores_td.det_msgerror%TYPE,
                                                                        SN_num_evento      OUT NOCOPY    ge_errores_pg.evento)
IS
 /*
 <Documentación
   TipoDoc = "Procedure">>
    <Elemento
       Nombre = "PV_OBTIENE_NUMPERSONAL_PR"
       Lenguaje="PL/SQL"
       Fecha="09-01-2008"
       Versión="La del package"
       Diseñador="YESENIA OSSES"
       Programador="YESENIA OSSES"
       Ambiente Desarrollo="BD">
       <Retorno>N/A</Retorno>>
       <Descripción></Descripción>>
       <Parámetros>
          <Entrada>
             <param nom="EO_GA_NUM_PERSONAL" Tipo="estructura"><param>>
          </Entrada>
          <Salida>
             <param nom="SN_cod_retorno" Tipo="NUMERICO">Codigo de Retorno</param>>
             <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>>
             <param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>>
          </Salida>
       </Parámetros>
    </Elemento>
 </Documentación>
 */

 LV_des_error              ge_errores_pg.DesEvent;
 LV_sSql                   ge_errores_pg.vQuery;
 LV_valor                          VARCHAR2(6);
 ERROR_EJECUCION           EXCEPTION;

BEGIN
        SN_cod_retorno  := 0;
        SV_mens_retorno := ' ';
        SN_num_evento  := 0;


                LV_sSql := 'PV_OBTIENEINFO_ATLANTIDA_PG.PV_OBTIENESERVICIO_ATL_PR(';
                LV_sSql := LV_sSql || EO_GA_CORPORATIVO.COD_PLANTARIF_NUEVO || ',' ;
                LV_sSql := LV_sSql || LV_valor || ',' ;
                LV_sSql := LV_sSql || SN_cod_retorno || ',' ;
                LV_sSql := LV_sSql || SV_mens_retorno || ',' ;
                LV_sSql := LV_sSql || SN_num_evento || ')' ;

        PV_OBTIENEINFO_ATLANTIDA_PG.PV_OBTIENESERVICIO_ATL_PR(EO_GA_CORPORATIVO.COD_PLANTARIF_NUEVO,LV_valor,SN_cod_retorno,SV_mens_retorno,SN_num_evento);

                IF(SV_mens_retorno = CV_error_no_clasif)THEN
                   RAISE ERROR_EJECUCION;
                END IF;

                IF TRIM(LV_valor) = '' OR LV_valor is null THEN
                   EO_GA_CORPORATIVO.COD_TECNOLOGIA := 0; --no es Atlántida
            ELSE
                   EO_GA_CORPORATIVO.COD_TECNOLOGIA := 1; --es Atlántida
            END IF;


EXCEPTION
                 WHEN ERROR_EJECUCION THEN
                           LV_des_error   := 'PV_DATOS_ABONADO_PG.PV_MASCARA_CORPORATIVO_PR('||EO_GA_CORPORATIVO.COD_PLANTARIF_NUEVO  ||') '||SQLERRM;
                           SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_DATOS_ABONADO_PG.PV_MASCARA_CORPORATIVO_PR', LV_sSQL, SN_cod_retorno, LV_des_error );
                           EO_GA_CORPORATIVO.COD_TECNOLOGIA := 0; --no es Atlántida
                 WHEN OTHERS THEN
                           SN_cod_retorno := 156;
                           IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                                   SV_mens_retorno := CV_error_no_clasif;
                           END IF;

                           LV_des_error   := 'PV_DATOS_ABONADO_PG.PV_MASCARA_CORPORATIVO_PR('||EO_GA_CORPORATIVO.COD_PLANTARIF_NUEVO  ||') '||SQLERRM;
                           SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_DATOS_ABONADO_PG.PV_MASCARA_CORPORATIVO_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

END PV_MASCARA_CORPORATIVO_PR;
--------------------------------------------------------------------------------------------------------

PROCEDURE PV_MASCARA_PERSONAL_PR(EO_GA_NUM_PERSONAL IN OUT             PV_VAL_BAJA_ATLANTIDA_QT,
                                                                 SN_cod_retorno     OUT NOCOPY    ge_errores_td.cod_msgerror%TYPE,
                                                                 SV_mens_retorno    OUT NOCOPY    ge_errores_td.det_msgerror%TYPE,
                                                                 SN_num_evento      OUT NOCOPY    ge_errores_pg.evento)
IS
 /*
 <Documentación
   TipoDoc = "Procedure">>
    <Elemento
       Nombre = "PV_OBTIENE_NUMPERSONAL_PR"
       Lenguaje="PL/SQL"
       Fecha="09-01-2008"
       Versión="La del package"
       Diseñador="YESENIA OSSES"
       Programador="YESENIA OSSES"
       Ambiente Desarrollo="BD">
       <Retorno>N/A</Retorno>>
       <Descripción></Descripción>>
       <Parámetros>
          <Entrada>
             <param nom="EO_GA_NUM_PERSONAL" Tipo="estructura"><param>>
          </Entrada>
          <Salida>
             <param nom="SN_cod_retorno" Tipo="NUMERICO">Codigo de Retorno</param>>
             <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>>
             <param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>>
          </Salida>
       </Parámetros>
    </Elemento>
 </Documentación>
 */

 LV_des_error    ge_errores_pg.DesEvent;
 LV_sSql      ge_errores_pg.vQuery;
 LN_valor               NUMBER(1);

BEGIN
        SN_cod_retorno  := 0;
        SV_mens_retorno := ' ';
        SN_num_evento  := 0;


                LV_sSql := 'GA_NUMCEL_PERSONAL_PG.GA_EXISTE_NUMPERSONAL2_FN(';
                LV_sSql := LV_sSql || EO_GA_NUM_PERSONAL.NUM_CELULAR || ')' ;


        LN_valor := GA_NUMCEL_PERSONAL_PG.GA_EXISTE_NUMPERSONAL2_FN(EO_GA_NUM_PERSONAL.NUM_CELULAR);

                EO_GA_NUM_PERSONAL.COD_ESTADO := LN_valor;


EXCEPTION
                 WHEN OTHERS THEN
                           SN_cod_retorno := 156;
                           IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                                   SV_mens_retorno := CV_error_no_clasif;
                           END IF;

                           LV_des_error   := 'PV_DATOS_ABONADO_PG.PV_MASCARA_PERSONAL_PR('||EO_GA_NUM_PERSONAL.NUM_CELULAR  ||') '||SQLERRM;
                           SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_DATOS_ABONADO_PG.PV_MASCARA_PERSONAL_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

END PV_MASCARA_PERSONAL_PR;

--------------------------------------------------------------------------------------------------------
PROCEDURE PV_MASCARA_ATLANTIDA_PR(EO_GA_COD_CLIENTE  IN OUT            PV_cliente_QT,
                                                                  SN_cod_retorno     OUT NOCOPY    ge_errores_td.cod_msgerror%TYPE,
                                                                  SV_mens_retorno    OUT NOCOPY    ge_errores_td.det_msgerror%TYPE,
                                                                  SN_num_evento      OUT NOCOPY    ge_errores_pg.evento)

IS
 /*
 <Documentación
   TipoDoc = "Procedure">>
    <Elemento
       Nombre = "PV_OBTIENE_NUMPERSONAL_PR"
       Lenguaje="PL/SQL"
       Fecha="09-01-2008"
       Versión="La del package"
       Diseñador="YESENIA OSSES"
       Programador="YESENIA OSSES"
       Ambiente Desarrollo="BD">
       <Retorno>N/A</Retorno>>
       <Descripción></Descripción>>
       <Parámetros>
          <Entrada>
             <param nom="EO_GA_NUM_PERSONAL" Tipo="estructura"><param>>
          </Entrada>
          <Salida>
             <param nom="SN_cod_retorno" Tipo="NUMERICO">Codigo de Retorno</param>>
             <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>>
             <param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>>
          </Salida>
       </Parámetros>
    </Elemento>
 </Documentación>
 */

 LV_des_error    ge_errores_pg.DesEvent;
 LV_sSql         ge_errores_pg.vQuery;
 ln_existe       VARCHAR2(1);

BEGIN
        SN_cod_retorno  := 0;
        SV_mens_retorno := ' ';
        SN_num_evento  := 0;


                LV_sSql := 'PV_OBTIENEINFO_ATLANTIDA_PG.PV_CLIENTEESATLANTIDA_FN(';
                LV_sSql := LV_sSql || EO_GA_COD_CLIENTE.COD_CLIENTE || ')' ;


        ln_existe := PV_OBTIENEINFO_ATLANTIDA_PG.PV_CLIENTEESATLANTIDA_FN(EO_GA_COD_CLIENTE.COD_CLIENTE);

                EO_GA_COD_CLIENTE.COD_VALOR := ln_existe;


EXCEPTION
                 WHEN OTHERS THEN
                           SN_cod_retorno := 156;
                           IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                                   SV_mens_retorno := CV_error_no_clasif;
                           END IF;

                           LV_des_error   := 'PV_DATOS_ABONADO_PG.PV_MASCARA_ATLANTIDA_PR('||EO_GA_COD_CLIENTE.COD_CLIENTE  ||') '||SQLERRM;
                           SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_DATOS_ABONADO_PG.PV_MASCARA_ATLANTIDA_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

END PV_MASCARA_ATLANTIDA_PR;
--------------------------------------------------------------------------------------------------------
PROCEDURE PV_MASCARA_DESACTIVAPER_PR(EO_GA_NUM_PERSONAL IN OUT        PV_GA_ABOCEL_QT,
                                                                         SN_cod_retorno     OUT NOCOPY    ge_errores_td.cod_msgerror%TYPE,
                                                                         SV_mens_retorno    OUT NOCOPY    ge_errores_td.det_msgerror%TYPE,
                                                                         SN_num_evento      OUT NOCOPY    ge_errores_pg.evento)

IS
 /*
 <Documentación
   TipoDoc = "Procedure">>
    <Elemento
       Nombre = "PV_OBTIENE_NUMPERSONAL_PR"
       Lenguaje="PL/SQL"
       Fecha="09-01-2008"
       Versión="La del package"
       Diseñador="YESENIA OSSES"
       Programador="YESENIA OSSES"
       Ambiente Desarrollo="BD">
       <Retorno>N/A</Retorno>>
       <Descripción></Descripción>>
       <Parámetros>
          <Entrada>
             <param nom="EO_GA_NUM_PERSONAL" Tipo="estructura"><param>>
          </Entrada>
          <Salida>
             <param nom="SN_cod_retorno" Tipo="NUMERICO">Codigo de Retorno</param>>
             <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>>
             <param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>>
          </Salida>
       </Parámetros>
    </Elemento>
 </Documentación>
 */

 LV_des_error      ge_errores_pg.DesEvent;
 LV_sSql           ge_errores_pg.vQuery;
 ERROR_EJECUCION   EXCEPTION;

BEGIN
        SN_cod_retorno  := 0;
        SV_mens_retorno := ' ';
        SN_num_evento  := 0;

                LV_sSql := 'GA_NUMCEL_PERSONAL_PG.GA_DESACTIVA_NUMPERSONAL_PR(';
                LV_sSql := LV_sSql || EO_GA_NUM_PERSONAL.NUM_CELULAR || ',' ;
                LV_sSql := LV_sSql || EO_GA_NUM_PERSONAL.COD_SITUACION || ',' ;
                LV_sSql := LV_sSql || EO_GA_NUM_PERSONAL.ID_SECUENCIA || ',' ;
                LV_sSql := LV_sSql || SN_cod_retorno || ',' ;
                LV_sSql := LV_sSql || SN_num_evento || ',' ;
                LV_sSql := LV_sSql || SV_mens_retorno || ')' ;

        GA_NUMCEL_PERSONAL_PG.GA_DESACTIVA_NUMPERSONAL_PR(EO_GA_NUM_PERSONAL.NUM_CELULAR,
                                                                                                                  EO_GA_NUM_PERSONAL.COD_SITUACION, --codigo programa
                                                                                                                  EO_GA_NUM_PERSONAL.ID_SECUENCIA,
                                                                                                                  SN_cod_retorno,
                                                                                                                  SN_num_evento,
                                                                                                                  SV_mens_retorno);

                IF(SN_cod_retorno <> 0)THEN
                   RAISE ERROR_EJECUCION;
                END IF;

EXCEPTION
                 WHEN ERROR_EJECUCION THEN
                           LV_des_error   := 'PV_DATOS_ABONADO_PG.PV_MASCARA_DESACTIVAPER_PR('||EO_GA_NUM_PERSONAL.NUM_CELULAR  || ',' || EO_GA_NUM_PERSONAL.COD_SITUACION ||') '||SQLERRM;
                           SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_DATOS_ABONADO_PG.PV_MASCARA_DESACTIVAPER_PR', LV_sSQL, SN_cod_retorno, LV_des_error );
                 WHEN OTHERS THEN
                           SN_cod_retorno := 156;
                           IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                                   SV_mens_retorno := CV_error_no_clasif;
                           END IF;

                           LV_des_error   := 'PV_DATOS_ABONADO_PG.PV_MASCARA_DESACTIVAPER_PR('||EO_GA_NUM_PERSONAL.NUM_CELULAR  || ',' || EO_GA_NUM_PERSONAL.COD_SITUACION ||') '||SQLERRM;
                           SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_DATOS_ABONADO_PG.PV_MASCARA_DESACTIVAPER_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

END PV_MASCARA_DESACTIVAPER_PR;

-----------------------------------------------------------------------------------------------------
PROCEDURE GA_ACTUALIZA_NUMPERSONAL_PR(EO_GA_NUM_PERSONAL IN OUT        PV_GA_ABOCEL_QT,
                                                                          SN_cod_retorno     OUT NOCOPY    ge_errores_td.cod_msgerror%TYPE,
                                                                          SV_mens_retorno    OUT NOCOPY    ge_errores_td.det_msgerror%TYPE,
                                                                          SN_num_evento      OUT NOCOPY    ge_errores_pg.evento)

IS
 /*
 <Documentación
   TipoDoc = "Procedure">>
    <Elemento
       Nombre = "PV_OBTIENE_NUMPERSONAL_PR"
       Lenguaje="PL/SQL"
       Fecha="09-01-2008"
       Versión="La del package"
       Diseñador="YESENIA OSSES"
       Programador="YESENIA OSSES"
       Ambiente Desarrollo="BD">
       <Retorno>N/A</Retorno>>
       <Descripción></Descripción>>
       <Parámetros>
          <Entrada>
             <param nom="EO_GA_NUM_PERSONAL" Tipo="estructura"><param>>
          </Entrada>
          <Salida>
             <param nom="SN_cod_retorno" Tipo="NUMERICO">Codigo de Retorno</param>>
             <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>>
             <param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>>
          </Salida>
       </Parámetros>
    </Elemento>
 </Documentación>
 */

 LV_des_error    ge_errores_pg.DesEvent;
 LV_sSql      ge_errores_pg.vQuery;

BEGIN
        SN_cod_retorno  := 0;
        SV_mens_retorno := ' ';
        SN_num_evento  := 0;

                LV_sSql := 'UPDATE GA_NUMCEL_PERSONAL_TO SET COD_ESTADO = '|| EO_GA_NUM_PERSONAL.COD_ESTADO;
                LV_sSql := LV_sSql || 'WHERE NUM_CEL_PERS = '|| EO_GA_NUM_PERSONAL.NUM_CELULAR ;

                UPDATE GA_NUMCEL_PERSONAL_TO SET COD_ESTADO = EO_GA_NUM_PERSONAL.COD_ESTADO
                WHERE NUM_CEL_PERS = EO_GA_NUM_PERSONAL.NUM_CELULAR;


EXCEPTION
                WHEN OTHERS THEN
                 SN_cod_retorno := 156;
                         IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                                SV_mens_retorno := CV_error_no_clasif;
                         END IF;

                         LV_des_error   := 'PV_DATOS_ABONADO_PG.GA_ACTUALIZA_NUMPERSONAL_PR('||EO_GA_NUM_PERSONAL.NUM_CELULAR  ||') '||SQLERRM;
                         SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_DATOS_ABONADO_PG.GA_ACTUALIZA_NUMPERSONAL_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

END GA_ACTUALIZA_NUMPERSONAL_PR;

-----------------------------------------------------------------------------------------------------

PROCEDURE PV_MASCARA_VALACTIV_PER_PR(EO_GA_NUM_PERSONAL IN OUT        PV_GA_ABOCEL_QT,
                                                                         SN_cod_retorno     OUT NOCOPY    ge_errores_td.cod_msgerror%TYPE,
                                                                         SV_mens_retorno    OUT NOCOPY    ge_errores_td.det_msgerror%TYPE,
                                                                         SN_num_evento      OUT NOCOPY    ge_errores_pg.evento)

IS
 /*
 <Documentación
   TipoDoc = "Procedure">>
    <Elemento
       Nombre = "PV_OBTIENE_NUMPERSONAL_PR"
       Lenguaje="PL/SQL"
       Fecha="09-01-2008"
       Versión="La del package"
       Diseñador="YESENIA OSSES"
       Programador="YESENIA OSSES"
       Ambiente Desarrollo="BD">
       <Retorno>N/A</Retorno>>
       <Descripción></Descripción>>
       <Parámetros>
          <Entrada>
             <param nom="EO_GA_NUM_PERSONAL" Tipo="estructura"><param>>
          </Entrada>
          <Salida>
             <param nom="SN_cod_retorno" Tipo="NUMERICO">Codigo de Retorno</param>>
             <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>>
             <param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>>
          </Salida>
       </Parámetros>
    </Elemento>
 </Documentación>
 */

 LV_des_error      ge_errores_pg.DesEvent;
 LV_sSql           ge_errores_pg.vQuery;
 ERROR_EJECUCION   EXCEPTION;

BEGIN
        SN_cod_retorno  := 0;
        SV_mens_retorno := ' ';
        SN_num_evento  := 0;


                LV_sSql := 'GA_NUMCEL_PERSONAL_PG.GA_VAL_ACTIV_NUMPERS_PR(';
                LV_sSql := LV_sSql || EO_GA_NUM_PERSONAL.NUM_CELULAR || ',' ;
                LV_sSql := LV_sSql || EO_GA_NUM_PERSONAL.COD_SITUACION || ',' ;
                LV_sSql := LV_sSql || SN_cod_retorno || ',' ;
                LV_sSql := LV_sSql || SN_num_evento || ',' ;
                LV_sSql := LV_sSql || SV_mens_retorno || ')' ;

        GA_NUMCEL_PERSONAL_PG.GA_VAL_ACTIV_NUMPERS_PR(EO_GA_NUM_PERSONAL.NUM_CELULAR,
                                                                                                          EO_GA_NUM_PERSONAL.COD_SITUACION, --codigo programa
                                                                                                          SN_cod_retorno,
                                                                                                          SN_num_evento,
                                                                                                          SV_mens_retorno);
                IF(SN_cod_retorno <> 0)THEN
                   RAISE ERROR_EJECUCION;
                END IF;

EXCEPTION
         WHEN ERROR_EJECUCION THEN
                           LV_des_error   := 'PV_DATOS_ABONADO_PG.PV_MASCARA_VALACTIV_PER_PR('||EO_GA_NUM_PERSONAL.NUM_CELULAR  || ',' || EO_GA_NUM_PERSONAL.COD_SITUACION ||') '||SQLERRM;
                           SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_DATOS_ABONADO_PG.PV_MASCARA_VALACTIV_PER_PR', LV_sSQL, SN_cod_retorno, LV_des_error );
                 WHEN OTHERS THEN
                           SN_cod_retorno := 156;
                           IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                                   SV_mens_retorno := CV_error_no_clasif;
                           END IF;
                           LV_des_error   := 'PV_DATOS_ABONADO_PG.PV_MASCARA_VALACTIV_PER_PR('||EO_GA_NUM_PERSONAL.NUM_CELULAR  || ',' || EO_GA_NUM_PERSONAL.COD_SITUACION ||') '||SQLERRM;
                           SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_DATOS_ABONADO_PG.PV_MASCARA_VALACTIV_PER_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

END PV_MASCARA_VALACTIV_PER_PR;

-----------------------------------------------------------------------------------------------------

PROCEDURE PV_MASCARA_REG_PERS_PR(EO_GA_NUM_PERSONAL   IN OUT      PV_VAL_BAJA_ATLANTIDA_QT,
                                                                 SN_cod_retorno       OUT NOCOPY  ge_errores_td.cod_msgerror%TYPE,
                                                                 SV_mens_retorno      OUT NOCOPY  ge_errores_td.det_msgerror%TYPE,
                                                                 SN_num_evento        OUT NOCOPY  ge_errores_pg.evento)

IS
 /*
 <Documentación
   TipoDoc = "Procedure">>
    <Elemento
       Nombre = "PV_OBTIENE_NUMPERSONAL_PR"
       Lenguaje="PL/SQL"
       Fecha="09-01-2008"
       Versión="La del package"
       Diseñador="YESENIA OSSES"
       Programador="YESENIA OSSES"
       Ambiente Desarrollo="BD">
       <Retorno>N/A</Retorno>>
       <Descripción></Descripción>>
       <Parámetros>
          <Entrada>
             <param nom="EO_GA_NUM_PERSONAL" Tipo="estructura"><param>>
          </Entrada>
          <Salida>
             <param nom="SN_cod_retorno" Tipo="NUMERICO">Codigo de Retorno</param>>
             <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>>
             <param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>>
          </Salida>
       </Parámetros>
    </Elemento>
 </Documentación>
 */

 LV_des_error       ge_errores_pg.DesEvent;
 LV_sSql            ge_errores_pg.vQuery;
 SN_p_correlativo       VARCHAR2(5);
 ERROR_EJECUCION    EXCEPTION;

BEGIN
        SN_cod_retorno  := 0;
        SV_mens_retorno := ' ';
        SN_num_evento  := 0;


                LV_sSql := 'GA_ACTIVA_NUMPERSONAL2_PR(';
                LV_sSql := LV_sSql || EO_GA_NUM_PERSONAL.NUM_CELULAR  || ',';
                LV_sSql := LV_sSql || EO_GA_NUM_PERSONAL.NUM_CELULAR_NUE || ',';
                LV_sSql := LV_sSql || EO_GA_NUM_PERSONAL.NUM_MOVIMIENTO || ',';
                LV_sSql := LV_sSql || EO_GA_NUM_PERSONAL.COD_MODULO || ',' ;
                LV_sSql := LV_sSql || EO_GA_NUM_PERSONAL.NUM_MOVANT || ',';
                LV_sSql := LV_sSql || SN_cod_retorno || ',';
                LV_sSql := LV_sSql || SN_num_evento || ',';
                LV_sSql := LV_sSql || SV_mens_retorno || ')';

        GA_ACTIVA_NUMPERSONAL2_PR(EO_GA_NUM_PERSONAL.NUM_CELULAR, -- celular PERSONAL
                                                                  EO_GA_NUM_PERSONAL.NUM_CELULAR_NUE,  -- celular corp
                                                                  EO_GA_NUM_PERSONAL.NUM_MOVIMIENTO,
                                                                  EO_GA_NUM_PERSONAL.COD_MODULO, --cod_programa
                                                                  EO_GA_NUM_PERSONAL.NUM_MOVANT, --correlativo
                                                                  SN_cod_retorno,
                                                                  SN_num_evento,
                                                                  SV_mens_retorno);
                IF(SN_cod_retorno <> 0)THEN
                   RAISE ERROR_EJECUCION;
                END IF;

EXCEPTION
                 WHEN ERROR_EJECUCION THEN
                           LV_des_error   := 'PV_DATOS_ABONADO_PG.PV_MASCARA_REG_PERS_PR('||EO_GA_NUM_PERSONAL.NUM_CELULAR  || ',' || EO_GA_NUM_PERSONAL.NUM_CELULAR_NUE ||') '||SQLERRM;
                           SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_DATOS_ABONADO_PG.PV_MASCARA_REG_PERS_PR', LV_sSQL, SN_cod_retorno, LV_des_error );
                 WHEN OTHERS THEN
                           SN_cod_retorno := 156;
                           IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                                   SV_mens_retorno := CV_error_no_clasif;
                           END IF;
                           LV_des_error   := 'PV_DATOS_ABONADO_PG.PV_MASCARA_REG_PERS_PR('||EO_GA_NUM_PERSONAL.NUM_CELULAR  || ',' || EO_GA_NUM_PERSONAL.NUM_CELULAR_NUE ||') '||SQLERRM;
                           SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_DATOS_ABONADO_PG.PV_MASCARA_REG_PERS_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

END PV_MASCARA_REG_PERS_PR;

-----------------------------------------------------------------------------------------------------
PROCEDURE PV_MASCARA_REG_CLIENTE_PR( EO_GA_NUM_CELULAR    IN OUT      PV_CLIENTE_QT,
                                                                         SN_cod_retorno       OUT NOCOPY  ge_errores_td.cod_msgerror%TYPE,
                                                                         SV_mens_retorno      OUT NOCOPY  ge_errores_td.det_msgerror%TYPE,
                                                                         SN_num_evento        OUT NOCOPY  ge_errores_pg.evento)

IS
 /*
 <Documentación
   TipoDoc = "Procedure">>
    <Elemento
       Nombre = "PV_OBTIENE_NUMPERSONAL_PR"
       Lenguaje="PL/SQL"
       Fecha="09-01-2008"
       Versión="La del package"
       Diseñador="YESENIA OSSES"
       Programador="YESENIA OSSES"
       Ambiente Desarrollo="BD">
       <Retorno>N/A</Retorno>>
       <Descripción></Descripción>>
       <Parámetros>
          <Entrada>
             <param nom="EO_GA_NUM_PERSONAL" Tipo="estructura"><param>>
          </Entrada>
          <Salida>
             <param nom="SN_cod_retorno" Tipo="NUMERICO">Codigo de Retorno</param>>
             <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>>
             <param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>>
          </Salida>
       </Parámetros>
    </Elemento>
 </Documentación>
 */

 LV_des_error       ge_errores_pg.DesEvent;
 LV_sSql            ge_errores_pg.vQuery;
 LN_COD_CLIENTE     ga_abocel.COD_CLIENTE%type;

BEGIN
        SN_cod_retorno  := 0;
        SV_mens_retorno := ' ';
        SN_num_evento  := 0;

                LN_COD_CLIENTE := 0;


                LV_sSql := 'SELECT COD_CLIENTE INTO LN_COD_CLIENTE FROM GA_ABOCEL';
                LV_sSql := LV_sSql || ' WHERE NUM_CELULAR =' || EO_GA_NUM_CELULAR.NUM_CELULAR;
                LV_sSql := LV_sSql || ' AND COD_SITUACION = AAA ';
                LV_sSql := LV_sSql || ' UNION ';
                LV_sSql := LV_sSql || ' SELECT COD_CLIENTE FROM GA_ABOAMIST ';
                LV_sSql := LV_sSql || ' WHERE NUM_CELULAR =' || EO_GA_NUM_CELULAR.NUM_CELULAR;
                LV_sSql := LV_sSql || ' AND COD_SITUACION = AAA ';


        SELECT COD_CLIENTE INTO LN_COD_CLIENTE
                FROM GA_ABOCEL
                WHERE NUM_CELULAR = EO_GA_NUM_CELULAR.NUM_CELULAR
                AND COD_SITUACION = 'AAA'
                UNION
                SELECT COD_CLIENTE
                FROM GA_ABOAMIST
                WHERE NUM_CELULAR = EO_GA_NUM_CELULAR.NUM_CELULAR
                AND COD_SITUACION = 'AAA';

                EO_GA_NUM_CELULAR.COD_CLIENTE := LN_COD_CLIENTE;

EXCEPTION
                 WHEN NO_DATA_FOUND THEN
                          SN_cod_retorno := 142;
                          IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                                  SV_mens_retorno := CV_error_no_clasif;
                          END IF;
                          LV_des_error   := 'PV_DATOS_ABONADO_PG.PV_MASCARA_REG_CLIENTE_PR('||EO_GA_NUM_CELULAR.NUM_CELULAR ||') '||SQLERRM;
                          SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_DATOS_ABONADO_PG.PV_MASCARA_REG_CLIENTE_PR', LV_sSQL, SN_cod_retorno, LV_des_error );
                 WHEN OTHERS THEN
                           SN_cod_retorno := 156;
                           IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                                   SV_mens_retorno := CV_error_no_clasif;
                           END IF;

                           LV_des_error   := 'PV_DATOS_ABONADO_PG.PV_MASCARA_REG_CLIENTE_PR('||EO_GA_NUM_CELULAR.NUM_CELULAR ||') '||SQLERRM;
                           SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_DATOS_ABONADO_PG.PV_MASCARA_REG_CLIENTE_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

END PV_MASCARA_REG_CLIENTE_PR;
-----------------------------------------------------------------------------------------------------
PROCEDURE GA_ACTIVA_NUMPERSONAL2_PR (EV_num_cel_pers       IN VARCHAR2,
                                     EV_num_cel_corp       IN VARCHAR2,
                                     EN_num_movimiento     IN icc_movimiento.num_movant%TYPE,
                                     EV_cod_prog           IN VARCHAR2,
                                     SN_p_correlativo      OUT NOCOPY NUMBER,
                                     SN_cod_retorno        OUT NOCOPY INTEGER,
                                     SN_num_evento         OUT NOCOPY INTEGER,
                                     SV_msg_retorno        OUT NOCOPY VARCHAR2)

IS

/*

<Documentación
TipoDoc = "PROCEDURE">
 <Elemento
    Nombre = "GA_ACTIVA_NUMPERSONAL2_PR"
    Lenguaje="PL/SQL"
    Fecha="25-08-2006"
    Versión="1.0"
    Diseñador="Patricio Gallegos"
    Programador="Patricio Gallegos"
    Ambiente Desarrollo="BD">
    <Retorno>NA</Retorno>
    <Descripción> Procedimiento que valida y envia comando de central para la activación de un
      número celular como personal
    <Parámetros>
       <Entrada>
               <param nom="EN_num_cel_pers" Tipo="VARCHAR">Número celular personal</param>
               <param nom="EV_num_cel_corp" Tipo="VARCHAR">Número celular corporativo (Atlántida)</param>
               <param nom="EN_num_movimiento" Tipo="NUMBER">Número movimiento central que se desea que se ejecute primero</param>
               <param nom="EV_cod_prog" Tipo="VARCHAR">Modulo</param>
         </Entrada>
         <Salida>
         <param nom="SN_p_correlativo" Tipo="NUMBER">número movimiento ingresado (0 : sin error)</param>
         <param nom="SN_cod_retorno" Tipo="NUMBER">Código retorno de error (0 : sin error)</param>
         <param nom="SN_num_evento" Tipo="NUMBER">Número de evento</param>
         <param nom="SV_mens_retorno" Tipo="VARCHAR">Mensaje de error</param>
         </Salida>
    </Parámetros>
 </Elemento>
</Documentación>
*/





  LN_num_cel_pers                    ga_numcel_personal_to.num_cel_pers%TYPE;
  LN_num_cel_corp                    ga_numcel_personal_to.num_cel_corp%TYPE;

  fin_NoAtlantida                  EXCEPTION;
  fin_NoPersonal                   EXCEPTION;
  fin_noAgregarNumPer              EXCEPTION;
  fin_noICC                        EXCEPTION;


  LV_existe                        VARCHAR2(5);
  LN_cod_retorno                   ge_errores_td.cod_msgerror%TYPE;

  LN_filasafectas                  INTEGER;
  LV_vcod_retorno                  VARCHAR2(1);

  LV_cod_actabo                    ga_actabo.cod_actabo%TYPE;
  LN_num_celular                   ga_abocel.num_celular%TYPE;


  LN_num_abo_corp                  ga_abocel.num_abonado%TYPE;
  LN_num_abo_pers                  ga_abocel.num_abonado%TYPE;
  LN_cod_actuacion                 ga_actabo.cod_actcen%TYPE;
  LV_tip_terminal                  ga_abocel.tip_terminal%TYPE;
  LN_cod_central                   ga_abocel.cod_central%TYPE;
  LV_num_seriehex                  ga_abocel.num_seriehex%TYPE;

  LV_num_min                       ga_abocel.num_min%TYPE;
  LV_cod_tecnologia                ga_abocel.cod_tecnologia%TYPE;
  LV_imsi                          icc_movimiento.imsi%TYPE;
  LV_imei                          icc_movimiento.imei%TYPE;
  LV_icc                           icc_movimiento.icc%TYPE;
  LV_cod_grupo_tec                 al_grupo_tecnologia_td.cod_grupo%TYPE;
  LV_grupo_gsm                     al_grupo_tecnologia_td.cod_grupo%TYPE;
  LN_cod_producto                  ga_abocel.cod_producto%TYPE;
  LV_num_serie                     ga_abocel.num_serie%TYPE;
  LV_num_imei                      ga_abocel.num_imei%TYPE;
  LV_cod_plantarif                 ga_abocel.cod_plantarif%TYPE;


  LV_sSql          ge_errores_pg.vQuery;

  LN_p_retornora                   NUMBER(15);


BEGIN


       SN_p_correlativo := 0;
       SN_num_evento := 0;

       LN_num_cel_pers := TO_NUMBER(EV_num_cel_pers);
       LN_num_cel_corp := TO_NUMBER(EV_num_cel_corp);


       LV_sSql :=  'SELECT num_abonado from ga_abocel ';
           LV_sSql := LV_sSql || ' WHERE num_celular = '||LN_num_cel_corp||'  AND cod_situacion NOT IN (''BAA'',''BAP'')';
           LV_sSql := LV_sSql || ' UNION';
           LV_sSql := LV_sSql || ' SELECT num_abonado FROM GA_ABOAMIST';
           LV_sSql := LV_sSql || '  WHERE num_celular = '||LN_num_cel_corp;
           LV_sSql := LV_sSql || ' AND cod_situacion NOT IN (''BAA'',''BAP'')';

       SELECT num_abonado
       INTO LN_num_abo_corp
       FROM ga_abocel
       WHERE num_celular = LN_num_cel_corp
       AND cod_situacion NOT IN ('BAA','BAP')
           UNION
                SELECT num_abonado
                FROM GA_ABOAMIST
                WHERE NUM_CELULAR = LN_num_cel_corp
                AND cod_situacion NOT IN ('BAA','BAP');

       LV_sSql :=  'GA_NUMCEL_PERSONAL_PG.GA_VAL_ACTIV_NUMPERS_PR('||LN_num_cel_pers||','||EV_cod_prog||')';
       GA_NUMCEL_PERSONAL_PG.GA_VAL_ACTIV_NUMPERS_PR(LN_num_cel_pers,EV_cod_prog, LN_cod_retorno,SN_num_evento,SV_msg_retorno);
       IF NOT LN_cod_retorno = 0 THEN
            RAISE fin_NoPersonal;
       END IF;

       LV_sSql :=  'GA_NUMCEL_PERSONAL_TO_I_PG.AGREGAR_PR('||LN_num_cel_pers||','||LN_num_cel_corp||','||CN_ESTADO_PA||',USER,SYSDATE,'||EV_cod_prog||','||LN_filasafectas||')';
       GA_NUMCEL_PERSONAL_TO_I_PG.GA_AGREGAR_PR(LN_num_cel_pers, LN_num_cel_corp,CN_ESTADO_PA, USER, SYSDATE, EV_cod_prog,
                                                LN_filasafectas,  LN_p_retornora,  SN_num_evento,  LV_vcod_retorno );

       IF NOT (LV_vcod_retorno = '0' AND LN_filasafectas = 1)  THEN
            SV_msg_retorno := TO_CHAR(LN_p_retornora);
            RAISE fin_noAgregarNumPer;
       END IF;


       LV_sSql :=  'SELECT num_abonado,tip_terminal,cod_central,num_seriehex,al_fn_prefijo_numero(num_celular), cod_tecnologia,';
           LV_sSql:= LV_sSql || ' ga_aprovisionar_central_pg.pv_grupo_tecnologico_fn(cod_tecnologia),cod_producto,num_serie,num_imei,cod_plantarif ';
           LV_sSql:= LV_sSql || ' from ga_abocel WHERE num_celular = '||LN_num_cel_pers||' AND cod_situacion = ''AAA'' UNION ';
           LV_sSql:= LV_sSql || ' select num_abonado,tip_terminal,cod_central,num_seriehex,al_fn_prefijo_numero(num_celular),';
           LV_sSql:= LV_sSql || ' cod_tecnologia,ga_aprovisionar_central_pg.pv_grupo_tecnologico_fn(cod_tecnologia),cod_producto,num_serie,num_imei,cod_plantarif';
           LV_sSql:= LV_sSql || ' FROM ga_aboamist num_celular = '||LN_num_cel_pers||' AND cod_situacion = ''AAA''';

       SELECT num_abonado,tip_terminal,cod_central,num_seriehex,al_fn_prefijo_numero(num_celular),
       cod_tecnologia,ga_aprovisionar_central_pg.pv_grupo_tecnologico_fn(cod_tecnologia),cod_producto,num_serie,num_imei,cod_plantarif
       INTO LN_num_abo_pers, LV_tip_terminal, LN_cod_central,LV_num_seriehex, LV_num_min,
       LV_cod_tecnologia,LV_cod_grupo_tec,LN_cod_producto,LV_num_serie,LV_num_imei,LV_cod_plantarif
       FROM ga_abocel
       WHERE num_celular = LN_num_cel_pers AND cod_situacion = 'AAA'
       UNION
       SELECT num_abonado,tip_terminal,cod_central,num_seriehex,al_fn_prefijo_numero(num_celular),
       cod_tecnologia,ga_aprovisionar_central_pg.pv_grupo_tecnologico_fn(cod_tecnologia),cod_producto,num_serie,num_imei,cod_plantarif
       FROM ga_aboamist
       WHERE num_celular = LN_num_cel_pers AND cod_situacion = 'AAA';


       LV_sSql :=  'PV_PR_DEVVALPARAM('||GV_cod_modulo||','||LN_cod_producto||','||GV_param_grpgsm||','||LV_grupo_gsm||')';
       PV_PR_DEVVALPARAM(GV_cod_modulo, LN_cod_producto,GV_param_grpgsm,LV_grupo_gsm);

       IF LV_cod_grupo_tec = LV_grupo_gsm THEN
            LV_imsi := fn_recupera_imsi(LV_num_serie);
            LV_imei := LV_num_imei;
            LV_icc :=  LV_num_serie;
       END IF;

      BEGIN

             LV_sSql :=  'SELECT cod_actabo FROM ta_plantarif a , pv_actabo_tiplan b';
                         LV_sSql:= LV_sSql || ' WHERE a.cod_plantarif = '||LV_cod_plantarif;
                         LV_sSql:= LV_sSql || ' AND b.cod_tipmodi = '||GV_cod_actabo;
                         LV_sSql:= LV_sSql || ' AND a.cod_tiplan  = b.cod_tiplan';

             SELECT cod_actabo INTO LV_cod_actabo
             FROM ta_plantarif a , pv_actabo_tiplan b
             WHERE a.cod_plantarif = LV_cod_plantarif
             AND b.cod_tipmodi = GV_cod_actabo
             AND a.cod_tiplan  = b.cod_tiplan;

       EXCEPTION
                    WHEN NO_DATA_FOUND THEN
                           LV_cod_actabo :=  GV_cod_actabo;
       END;


       LV_sSql :=  'FN_CODACTCEN';
       LN_cod_actuacion := FN_CODACTCEN(LN_cod_producto,LV_cod_actabo,GV_cod_modulo,LV_cod_tecnologia);
       LN_filasafectas := 0;

       LV_sSql :=  'ICC_MOVIMIENTO_I_PG.AGREGAR_PR';
         ICC_MOVIMIENTO_I_PG.ICC_AGREGAR_PR(NULL,
              LN_num_abo_pers,  -- num_abonado,
              GN_cod_estado_icc,-- cod_estado
              LV_cod_actabo,
              GV_cod_modulo,
              GN_num_intentos,--num_intentos
              NULL,
              'PENDIENTE',--des_respuesta
              LN_cod_actuacion,
              USER,
              SYSDATE,
              LV_tip_terminal,
              LN_cod_central,
              NULL,
              GN_ind_bloqueo,--ind_bloqueo
              NULL,
              NULL,
              NULLIF(EN_num_movimiento,0),--- num_movant
              LN_num_cel_pers,
              NULL,
              LV_num_seriehex,
              NULL,
              NULL,
              NULL,
              NULL,
              NULL,
              NULL,
              NULL,
              NULL,
              LV_num_min,
              NULL,
              NULL,
              NULL,
              NULL,
              NULL,
              NULL,
              NULL,--PLAN
              NULL,--CARGA
              NULL,
              NULL,
              NULL,
              NULL,--des_mensaje,
              NULL,--cod_pin,
              NULL,--cod_idioma,
              NULL,--cod_enrutamiento,
              NULL,--tip_enrutamiento,
              NULL,--des_origen_pin,
              NULL,--num_lote_pin,
              NULL,--num_serie_pin,
              LV_cod_tecnologia,--tip_tecnologia,
              LV_imsi,--imsi,
              NULL,--imsi_nue,
              LV_imei,--imei,
              NULL,--imei_nue,
              LV_icc,--icc,
              NULL,--icc_nue
              EV_cod_prog,
              SN_p_correlativo,
              LN_filasafectas,
              SV_msg_retorno,  SN_num_evento,  LV_vcod_retorno
              );

       IF NOT (LV_vcod_retorno = '0' AND LN_filasafectas = 1)  THEN
                   RAISE fin_noICC;
       ELSE
             SN_cod_retorno := 0;
             SN_num_evento := 0;
             SV_msg_retorno := 'OK';
       END IF;

EXCEPTION
          WHEN fin_NoAtlantida THEN
                        SN_cod_retorno := 1;
          WHEN fin_NoPersonal THEN
                    SN_cod_retorno := 2;
          WHEN fin_noAgregarNumPer THEN
                    SN_cod_retorno := 3;
          WHEN fin_noICC THEN
                    SN_cod_retorno := 4;
          WHEN OTHERS THEN
                    SN_cod_retorno := 9;
                    SV_msg_retorno := SUBSTR(SQLERRM,1,255);
                    SN_num_evento := GE_ERRORES_PG.GRABARPL(CN_0,
                                                            EV_cod_prog,
                                                            CV_error_no_clasif,
                                                            CV_1,
                                                            USER,
                                                            'GA_ACTIVA_NUMPERSONAL2_PR',
                                                            LV_sSql,
                                                            sqlcode,
                                                            SQLERRM);
END GA_ACTIVA_NUMPERSONAL2_PR;

------------------------------------------------------------------------------------------------------
PROCEDURE VALIDAR_SITU_ABOEMP_PR (
              EO_Abonado                 IN GA_ABONADO_QT,
                  SN_cod_retorno   OUT NOCOPY       ge_errores_td.cod_msgerror%TYPE,
                  SV_mens_retorno  OUT NOCOPY       ge_errores_td.det_msgerror%TYPE,
                  SN_num_evento    OUT NOCOPY           ge_errores_pg.evento)
        AS
        /*
        <Documentacion TipoDoc = "Procedure">
        <Elemento Nombre = "VALIDAR_SITU_ABOEMP_PR"
         Lenguaje="PL/SQL" Fecha="30-01-2008"
         Versión"1.0.0" Diseñador"****"
         Programador="" Ambiente="BD">
        <Retorno>NA</Retorno>
        <Descripcion> PL que valida si existe un cliente con situacion distinta a los estados ['AAA'],['AOP'],['ATP']y si es cliente empresa</Descripcion>
        <Parametros>
        <Entrada>
                        <param nom="EO_Abonado" Tipo="estructura">estructura de abonado</param>>
        </Entrada>
        <Salida>
           <param nom="SN_cod_retorno" Tipo="NUMERICO">Codigo de Retorno</param>>
           <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>>
           <param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>>
        </Salida>
        </Parametros>
        </Elemento>
        </Documentacion>
        */

        LV_des_error       ge_errores_pg.DesEvent;
        LV_sSql                    ge_errores_pg.vQuery;
        LN_COUNT                   NUMBER;

        ABONADO_EN_PROCESO EXCEPTION;

        BEGIN
            SN_cod_retorno       := 0;
            SV_mens_retorno  := '';
            SN_num_evento        := 0;

                   LV_sSQL := 'SELECT COUNT(1) FROM GA_ABOCEL A' ;
                   LV_sSQL := LV_sSQL || ' WHERE A.COD_SITUACION = ''TVP''';
                   LV_sSQL := LV_sSQL || ' AND A.NUM_ABONADO ='|| EO_Abonado.num_Abonado;

           SELECT COUNT(1)
                   INTO LN_COUNT
                   FROM GA_ABOCEL A
           WHERE A.COD_SITUACION= 'TVP'
                   AND A.NUM_ABONADO = EO_Abonado.num_Abonado;

                   IF LN_COUNT > 0 THEN
                          SN_cod_retorno := 1;
                          RAISE ABONADO_EN_PROCESO;
                   END IF;

    EXCEPTION
        WHEN ABONADO_EN_PROCESO THEN
                 SN_cod_retorno:=1703;
         IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                SV_mens_retorno:=CV_error_no_clasif;
         END IF;
         LV_des_error   := 'VALIDAR_SITU_ABOEMP_PR('||EO_Abonado.num_Abonado||'); - ' || SQLERRM;
             SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_DATOS_CLIENTES_PG.VALIDAR_SITU_ABOEMP_PR', LV_sSQL, SN_cod_retorno, LV_des_error );
        WHEN NO_DATA_FOUND THEN
                 SN_cod_retorno:=149;
         IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                SV_mens_retorno:=CV_error_no_clasif;
         END IF;
         LV_des_error   := 'VALIDAR_SITU_ABOEMP_PR('||EO_Abonado.num_Abonado||'); - ' || SQLERRM;
              SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_DATOS_CLIENTES_PG.VALIDAR_SITU_ABOEMP_PR', LV_sSQL, SN_cod_retorno, LV_des_error );
    WHEN OTHERS THEN
              SN_cod_retorno := 156;
              IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                 SV_mens_retorno := CV_error_no_clasif;
              END IF;
                  LV_des_error   := 'VALIDAR_SITU_ABOEMP_PR('||EO_Abonado.num_Abonado||'); - ' || SQLERRM;
              SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_DATOS_CLIENTES_PG.VALIDAR_SITU_ABOEMP_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

END VALIDAR_SITU_ABOEMP_PR ;

------------------------------------------------------------------------------------------------------
PROCEDURE VALIDAR_ORIDESUSO_PR(
                                  EO_Abonado              IN       GA_ABONADO_QT,
                  SN_cod_retorno           OUT    NOCOPY    ge_errores_td.cod_msgerror%TYPE,
                  SV_mens_retorno          OUT    NOCOPY    ge_errores_td.det_msgerror%TYPE,
                  SN_num_evento            OUT    NOCOPY  ge_errores_pg.evento)
IS
/*
 <Documentación
   TipoDoc = "Procedure">>
    <Elemento
       Nombre = "VALIDAR_ORIDESUSO_PR"
       Lenguaje="PL/SQL"
       Fecha="01-02-2008"
       Versión="1.0"
       Diseñador="*"
       Programador="*"
       Ambiente Desarrollo="BD">
       <Retorno>N/A</Retorno>>
       <Descripción></Descripción>>
       <Parámetros>
          <Entrada>
             <param nom="EO_Abonado" Tipo="estructura">estructura de una lista de abonados</param>>
          </Entrada>
          <Salida>
              <param nom="SN_cod_retorno"     Tipo="NUMERICO">Codigo de Retorno  </param>>
             <param nom="SV_mens_retorno"     Tipo="CARACTER">Mensaje de Retorno </param>>
             <param nom="SN_num_evento"      Tipo="NUMERICO">Numero de Evento   </param>>
          </Salida>
       </Parámetros>
    </Elemento>
 </Documentación>
*/
 LV_des_error    ge_errores_pg.DesEvent;
 LV_sSql         ge_errores_pg.vQuery;
 LN_uso                  NUMBER;
-- LV_ACTABO             GA_ACTABO.COD_ACTABO%TYPE:='VO';

 NO_EXISTE_CONFIGURACION   EXCEPTION;

  BEGIN
       SN_cod_retorno  := 0;
       SV_mens_retorno := ' ';
       SN_num_evento  := 0;

           LV_sSql:='SELECT coun(1) from GAD_ORIDESUSO';
           LV_sSql:=LV_sSql||' where cod_actabo ='||EO_Abonado.COD_ACTABO;
           LV_sSql:=LV_sSql||' and uso_origen = ' ||EO_Abonado.COD_USO;
           LV_sSql:=LV_sSql||' and uso_destino = '||EO_Abonado.COD_USO_DESTINO;
           LV_sSql:=LV_sSql||' and tec_origen = '||EO_Abonado.COD_TECNOLOGIA;
           LV_sSql:=LV_sSql||' and tec_origen = tec_destino';

           select count(1)
           INTO LN_uso
           from GAD_ORIDESUSO
           where cod_actabo = EO_Abonado.COD_ACTABO
           and uso_origen  = EO_Abonado.COD_USO--uso origen
           and uso_destino = EO_Abonado.COD_USO_DESTINO  --uso destino
           and tec_origen  = EO_Abonado.COD_TECNOLOGIA -- tecnologia del cliente origen
           and tec_origen  = tec_destino;

           IF LN_uso = 0 THEN
                          RAISE NO_EXISTE_CONFIGURACION;
           END IF;


   EXCEPTION
 WHEN NO_EXISTE_CONFIGURACION THEN
          SN_cod_retorno := 1704;
       IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := CV_error_no_clasif;
       END IF;
          LV_des_error   := ' VALIDAR_ORIDESUSO_PR('||EO_Abonado.num_Abonado||'); '||SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_DATOS_ABONADO_PG.VALIDAR_ORIDESUSO_PR', LV_sSQL, SN_cod_retorno, LV_des_error );
 WHEN NO_DATA_FOUND THEN
       SN_cod_retorno := 203;
       IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := CV_error_no_clasif;
       END IF;
       LV_des_error   := ' VALIDAR_ORIDESUSO_PR('||EO_Abonado.num_Abonado||'); '||SQLERRM;
       SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_DATOS_ABONADO_PG.VALIDAR_ORIDESUSO_PR', LV_sSQL, SN_cod_retorno, LV_des_error );
 WHEN OTHERS THEN
       SN_cod_retorno := 156;
       IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := CV_error_no_clasif;
       END IF;
    LV_des_error   := ' VALIDAR_ORIDESUSO_PR('||EO_Abonado.num_Abonado||'); '||SQLERRM;
       SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_DATOS_ABONADO_PG.VALIDAR_ORIDESUSO_PR', LV_sSQL, SN_cod_retorno, LV_des_error );
END VALIDAR_ORIDESUSO_PR;

-----------------------------------------------------------------------------------------------------
PROCEDURE PV_INSERT_GA_VENTA (EO_venta          IN GA_VENTA_QT,
                                         SN_cod_retorno     OUT NOCOPY    ge_errores_td.cod_msgerror%TYPE,
                                                 SV_mens_retorno    OUT NOCOPY    ge_errores_td.det_msgerror%TYPE,
                                                 SN_num_evento      OUT NOCOPY    ge_errores_pg.evento)

 IS
 /*
 <Documentación
   TipoDoc = "Procedure">>
    <Elemento
       Nombre = "PV_OBTIENE_NUMPERSONAL_PR"
       Lenguaje="PL/SQL"
       Fecha="09-01-2008"
       Versión="La del package"
       Diseñador="YESENIA OSSES"
       Programador="YESENIA OSSES"
       Ambiente Desarrollo="BD">
       <Retorno>N/A</Retorno>>
       <Descripción></Descripción>>
       <Parámetros>
          <Entrada>
             <param nom="EO_GA_NUM_PERSONAL" Tipo="estructura"><param>>
          </Entrada>
          <Salida>
             <param nom="SN_cod_retorno" Tipo="NUMERICO">Codigo de Retorno</param>>
             <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>>
             <param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>>
          </Salida>
       </Parámetros>
    </Elemento>
 </Documentación>
 */

 LV_des_error         ge_errores_pg.DesEvent;
 LV_sSql              ge_errores_pg.vQuery;
 SN_p_correlativo     VARCHAR2(5);
 LV_CODMOD                        FA_DATOSGENER.COD_MONEFACT%TYPE;
 LN_CodVendedor           GA_ABOCEL.COD_VENDEDOR%TYPE;
 LN_CodVendedorAgente GA_ABOCEL.COD_VENDEDOR_AGENTE%TYPE;
 LV_CodRegion             GA_ABOCEL.COD_REGION%TYPE;
 LV_CodProvincia          GA_ABOCEL.COD_PROVINCIA%TYPE;
 LV_CodCiudad             GA_ABOCEL.COD_CIUDAD%TYPE;
 LV_NomUsuaora            GA_ABOCEL.NOM_USUARORA%TYPE;
 LV_NumContrato           GA_ABOCEL.NUM_CONTRATO%TYPE;
 LV_CodMoneFact           FA_DATOSGENER.COD_MONEFACT%TYPE;
 LN_CodOficina            VE_VENDEDORES.COD_OFICINA%TYPE;
 LN_CodTipComis           VE_VENDEDORES.COD_TIPCOMIS%TYPE;
 LV_CodPlaza              ga_ventas.COD_PLAZA%TYPE;
 LV_CodOper                       ga_ventas.COD_OPERADORA%TYPE;
 LN_CodTipDocum       GE_TIPDOCUMEN.COD_TIPDOCUM%TYPE;
 LV_TipFoliacion          GE_TIPDOCUMEN.TIP_FOLIACION%TYPE;


BEGIN
        SN_cod_retorno  := 0;
        SV_mens_retorno := ' ';
        SN_num_evento  := 0;

   LV_sSql :=  'SELECT COD_VENDEDOR, COD_VENDEDOR_AGENTE, ';
   LV_sSql:= LV_sSql || ' COD_REGION, COD_PROVINCIA, COD_CIUDAD, NOM_USUARORA,NUM_CONTRATO';
   LV_sSql:= LV_sSql || ' FROM GA_ABOCEL';
   LV_sSql:= LV_sSql || ' WHERE COD_CLIENTE= '||EO_venta.cod_cliente;
   LV_sSql:= LV_sSql || ' AND NUM_VENTA = '||EO_venta.num_venta;

   SELECT COD_VENDEDOR, COD_VENDEDOR_AGENTE,
          COD_REGION, COD_PROVINCIA, COD_CIUDAD, NOM_USUARORA,
                  NUM_CONTRATO
   INTO LN_CodVendedor, LN_CodVendedorAgente,
        LV_CodRegion, LV_CodProvincia, LV_CodCiudad, LV_NomUsuaora,
                LV_NumContrato
    FROM GA_ABOCEL
        WHERE COD_CLIENTE= EO_venta.cod_cliente
             AND NUM_VENTA = EO_venta.num_venta;

   LV_sSql :=  ' SELECT fa.COD_MONEFACT';
   LV_sSql:= LV_sSql || ' FROM FA_DATOSGENER fa ';

   SELECT fa.COD_MONEFACT
   INTO LV_CodMoneFact
    FROM FA_DATOSGENER fa;

        LV_sSql :=  ' SELECT cod_oficina ,COD_TIPCOMIS ';
        LV_sSql:= LV_sSql || ' FROM VE_VENDEDORES WHERE cod_vendedor = '||LN_CodVendedor;

        SELECT cod_oficina ,COD_TIPCOMIS
        INTO LN_CodOficina, LN_CodTipComis
     FROM VE_VENDEDORES
     WHERE cod_vendedor = LN_CodVendedor;

         LV_sSql :=  ' SELECT B.COD_TIPDOCUM,  B.TIP_FOLIACION';
         LV_sSql:= LV_sSql || '  FROM GE_CATRIBDOCUM A, GE_TIPDOCUMEN B';
         LV_sSql:= LV_sSql || '  WHERE A.COD_CATRIBUT = ''F''';
         LV_sSql:= LV_sSql || '  AND SYSDATE BETWEEN A.FEC_DESDE AND A.FEC_HASTA';
         LV_sSql:= LV_sSql || '   AND A.COD_TIPDOCUM = B.COD_TIPDOCUM';

         SELECT B.COD_TIPDOCUM,  B.TIP_FOLIACION
         INTO LN_CodTipDocum,  LV_TipFoliacion
     FROM GE_CATRIBDOCUM A, GE_TIPDOCUMEN B
      WHERE A.COD_CATRIBUT = 'F'
            AND SYSDATE BETWEEN A.FEC_DESDE AND A.FEC_HASTA
        AND A.COD_TIPDOCUM = B.COD_TIPDOCUM;

    LV_sSql :=  ' SELECT FN_OBTIENE_PLAZACLIENTE ('||EO_venta.cod_cliente||') FROM DUAL';
        SELECT FN_OBTIENE_PLAZACLIENTE (EO_venta.cod_cliente)
        INTO LV_CodPlaza
        FROM DUAL;

        LV_sSql :=  ' SELECT fn_obtiene_opercliente('||EO_venta.cod_cliente||') FROM DUAL';
        SELECT fn_obtiene_opercliente(EO_venta.cod_cliente)
        INTO LV_CodOper
        FROM DUAL;

        LV_sSql :=  ' INSERT INTO ga_ventas (NUM_VENTA, COD_PRODUCTO, COD_OFICINA, COD_TIPCOMIS,  COD_VENDEDOR, COD_VENDEDOR_AGENTE, NUM_UNIDADES, FEC_VENTA,';
        LV_sSql:= LV_sSql || ' COD_REGION, COD_PROVINCIA, COD_CIUDAD, IND_ESTVENTA, NUM_TRANSACCION, IND_PASOCOB, NOM_USUAR_VTA, IND_VENTA,';
        LV_sSql:= LV_sSql || ' COD_MONEDA, COD_CAUSAREC, IMP_VENTA, COD_TIPCONTRATO,NUM_CONTRATO, IND_TIPVENTA, COD_CLIENTE, COD_MODVENTA, ';
        LV_sSql:= LV_sSql || ' TIP_VALOR, COD_CUOTA, COD_TIPTARJETA, NUM_TARJETA, COD_AUTTARJ, FEC_VENCITARJ, COD_BANCOTARJ, NUM_CTACORR, ';
        LV_sSql:= LV_sSql || ' NUM_CHEQUE, COD_BANCO, COD_SUCURSAL, FEC_CUMPLIMENTA, FEC_RECDOCUM, FEC_ACEPREC, NOM_USUAR_ACEREC, NOM_USUAR_RECDOC, ';
        LV_sSql:= LV_sSql || ' NOM_USUAR_CUMPL, IND_OFITER, IND_CHKDICOM, NUM_CONSULTA, COD_VENDEALER, NUM_FOLDEALER, COD_DOCDEALER, IND_DOCCOMP, ';
        LV_sSql:= LV_sSql || ' OBS_INCUMP, COD_CAUSAREP, FEC_RECPROV, NOM_USUAR_RECPROV, NUM_DIAS, OBS_RECPROV, IMP_ABONO, IND_ABONO, ';
        LV_sSql:= LV_sSql || ' FEC_RECEP_ADMVTAS, USU_RECEP_ADMVTAS, OBS_GRALCUMPL, IND_CONT_TELEF, FECHA_CONT_TELEF, USUARIO_CONT_TELEF, MTO_GARANTIA, TIP_FOLIACION, ';
        LV_sSql:= LV_sSql || ' COD_TIPDOCUM, COD_PLAZA, COD_OPERADORA, NUM_PROCESO)  VALUES (';
        LV_sSql:= LV_sSql || ' eo_venta.num_venta, eo_venta.cod_producto, '||LN_CodOficina||','||LN_CodTipComis||',';
        LV_sSql:= LV_sSql || ' '||LN_CodVendedor||',' ||LN_CodVendedorAgente||', eo_venta.num_unidades, SYSDATE,';
        LV_sSql:= LV_sSql || ' '||LV_CodRegion||',' ||LV_CodProvincia||',' ||LV_CodCiudad||', eo_venta.ind_estventa,';
    LV_sSql:= LV_sSql || ' eo_venta.num_transaccion, eo_venta.ind_pasocob, '||LV_NomUsuaora||', eo_venta.ind_venta,';
        LV_sSql:= LV_sSql || ' '||LV_CodMoneFact||', eo_venta.cod_causarec,eo_venta.imp_venta, eo_venta.cod_tipcontrato,';
        LV_sSql:= LV_sSql || ' '||LV_NumContrato||', eo_venta.ind_tipventa, eo_venta.cod_cliente, eo_venta.cod_modventa,';
        LV_sSql:= LV_sSql || ' eo_venta.tip_valor, eo_venta.cod_cuota, eo_venta.cod_tiptarjeta, eo_venta.num_tarjeta, ';
    LV_sSql:= LV_sSql || ' eo_venta.cod_auttarj, eo_venta.fec_vencitarj, eo_venta.cod_bancotarj, eo_venta.num_ctacorr,';

        -- LV_sSql:= LV_sSql || ' eo_venta.num_cheque, eo_venta.cod_banco, eo_venta.cod_sucursal, eo_venta.fec_cumplimenta,'; -- COL 82954|16-03-2009|SAQL
        LV_sSql:= LV_sSql || ' eo_venta.num_cheque, eo_venta.cod_banco, eo_venta.cod_sucursal, SYSDATE, '; -- COL 82954|16-03-2009|SAQL
        -- LV_sSql:= LV_sSql || ' eo_venta.fec_recdocum, eo_venta.fec_aceprec, eo_venta.nom_usuar_acerec, eo_venta.nom_usuar_recdoc,'; -- COL 82954|16-03-1009|SAQL
        LV_sSql:= LV_sSql || ' SYSDATE, eo_venta.fec_aceprec, eo_venta.nom_usuar_acerec, eo_venta.nom_usuar_recdoc,'; -- COL 82954|16-03-1009|SAQL

        LV_sSql:= LV_sSql || ' eo_venta.nom_usuar_cumpl, eo_venta.ind_ofiter, eo_venta.ind_chkdicom, eo_venta.num_consulta,';
        LV_sSql:= LV_sSql || ' eo_venta.cod_vendealer, eo_venta.num_foldealer, eo_venta.cod_docdealer, eo_venta.ind_doccomp, ';
        LV_sSql:= LV_sSql || ' eo_venta.obs_incump, eo_venta.cod_causarep, eo_venta.fec_recprov, eo_venta.nom_usuar_recprov, ';
        LV_sSql:= LV_sSql || ' eo_venta.num_dias, eo_venta.obs_recprov, eo_venta.imp_abono, eo_venta.ind_abono, ';
        LV_sSql:= LV_sSql || ' eo_venta.fec_recep_admvtas, eo_venta.usu_recep_admvtas, eo_venta.obs_gralcumpl, eo_venta.ind_cont_telef, ';
        LV_sSql:= LV_sSql || ' eo_venta.fecha_cont_telef, eo_venta.usuario_cont_telef, eo_venta.mto_garantia, '||LV_TipFoliacion||',';
        LV_sSql:= LV_sSql || ' '||LN_CodTipDocum||',''' ||LV_CodPlaza||''',''' ||LV_CodOper||''', eo_venta.num_proceso)';

        INSERT INTO ga_ventas
                    (NUM_VENTA, COD_PRODUCTO, COD_OFICINA, COD_TIPCOMIS,
                                         COD_VENDEDOR, COD_VENDEDOR_AGENTE, NUM_UNIDADES, FEC_VENTA,
                                         COD_REGION, COD_PROVINCIA, COD_CIUDAD, IND_ESTVENTA,
                                         NUM_TRANSACCION, IND_PASOCOB, NOM_USUAR_VTA, IND_VENTA,
                                         COD_MONEDA, COD_CAUSAREC, IMP_VENTA, COD_TIPCONTRATO,
                                         NUM_CONTRATO, IND_TIPVENTA, COD_CLIENTE, COD_MODVENTA,
                                         TIP_VALOR, COD_CUOTA, COD_TIPTARJETA, NUM_TARJETA,
                                         COD_AUTTARJ, FEC_VENCITARJ, COD_BANCOTARJ, NUM_CTACORR,
                                         NUM_CHEQUE, COD_BANCO, COD_SUCURSAL,
                                         FEC_CUMPLIMENTA,
                                         FEC_RECDOCUM,
                                         FEC_ACEPREC,
                                         NOM_USUAR_CUMPL,  -- COL 14-05-2009 RRG 87478
                                         NOM_USUAR_ACEREC,
                                         NOM_USUAR_RECDOC,
                                         --NOM_USUAR_CUMPL, -- COL 14-05-2009 RRG 87478
                                         IND_OFITER, IND_CHKDICOM, NUM_CONSULTA,
                                         COD_VENDEALER, NUM_FOLDEALER, COD_DOCDEALER, IND_DOCCOMP,
                                         OBS_INCUMP, COD_CAUSAREP, FEC_RECPROV, NOM_USUAR_RECPROV,
                                         NUM_DIAS, OBS_RECPROV, IMP_ABONO, IND_ABONO,
                                         FEC_RECEP_ADMVTAS, USU_RECEP_ADMVTAS, OBS_GRALCUMPL, IND_CONT_TELEF,
                                         FECHA_CONT_TELEF, USUARIO_CONT_TELEF, MTO_GARANTIA, TIP_FOLIACION,
                                         COD_TIPDOCUM, COD_PLAZA, COD_OPERADORA, NUM_PROCESO
                    )
             VALUES (eo_venta.num_venta, eo_venta.cod_producto, LN_CodOficina,LN_CodTipComis,
                     LN_CodVendedor, LN_CodVendedorAgente, eo_venta.num_unidades, SYSDATE,
                                         LV_CodRegion, LV_CodProvincia, LV_CodCiudad, eo_venta.ind_estventa,
                     eo_venta.num_transaccion, eo_venta.ind_pasocob, LV_NomUsuaora, eo_venta.ind_venta,
                                         LV_CodMoneFact, eo_venta.cod_causarec,eo_venta.imp_venta, eo_venta.cod_tipcontrato,
                                         LV_NumContrato, eo_venta.ind_tipventa, eo_venta.cod_cliente, eo_venta.cod_modventa,
                                         eo_venta.tip_valor, eo_venta.cod_cuota, eo_venta.cod_tiptarjeta, eo_venta.num_tarjeta,
                     eo_venta.cod_auttarj, eo_venta.fec_vencitarj, eo_venta.cod_bancotarj, eo_venta.num_ctacorr,
                                         -- eo_venta.num_cheque, eo_venta.cod_banco, eo_venta.cod_sucursal, eo_venta.fec_cumplimenta, -- COL 82954|16-03-2009|SAQL
                                         -- eo_venta.fec_recdocum, eo_venta.fec_aceprec, eo_venta.nom_usuar_acerec, eo_venta.nom_usuar_recdoc, -- COL 82954|16-03-2009|SAQL
                                         eo_venta.num_cheque, eo_venta.cod_banco, eo_venta.cod_sucursal,
                                         --eo_venta.fec_cumplimenta, -- COL 14-05-2009 RRG 87478
                                         NVL(eo_venta.fec_cumplimenta,SYSDATE),     -- COL 14-05-2009 RRG 87478
                                         SYSDATE, -- COL 82954|16-03-2009|SAQL
                                         SYSDATE,
                                         --eo_venta.fec_aceprec,
                                         decode(NVL(eo_venta.fec_cumplimenta,SYSDATE),null,eo_venta.nom_usuar_cumpl,LV_NomUsuaora), -- COL 14-05-2009 RRG 87478
                                         LV_NomUsuaora, -- COL 14-05-2009 RRG 87478
                                         LV_NomUsuaora, -- COL 14-05-2009 RRG 87478
                                         --eo_venta.nom_usuar_acerec,
                                         --eo_venta.nom_usuar_recdoc, -- COL 82954|16-03-2009|SAQL
                                         eo_venta.ind_ofiter, eo_venta.ind_chkdicom, eo_venta.num_consulta,
                                         eo_venta.cod_vendealer, eo_venta.num_foldealer, eo_venta.cod_docdealer, eo_venta.ind_doccomp,
                                         eo_venta.obs_incump, eo_venta.cod_causarep, eo_venta.fec_recprov, eo_venta.nom_usuar_recprov,
                                         eo_venta.num_dias, eo_venta.obs_recprov, eo_venta.imp_abono, eo_venta.ind_abono,
                                         eo_venta.fec_recep_admvtas, eo_venta.usu_recep_admvtas, eo_venta.obs_gralcumpl, eo_venta.ind_cont_telef,
                                         eo_venta.fecha_cont_telef, eo_venta.usuario_cont_telef, eo_venta.mto_garantia, LV_TipFoliacion,
                                         LN_CodTipDocum, LV_CodPlaza, LV_CodOper, eo_venta.num_proceso
                    );





EXCEPTION
     WHEN NO_DATA_FOUND THEN
       SN_cod_retorno := 149;
       IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := CV_error_no_clasif;
       END IF;
                  LV_des_error   := 'PV_INSERT_GA_VENTA_PR('||eo_venta.num_venta||','||eo_venta.cod_cliente||'); '||SQLERRM;
              SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_DATOS_ABONADO_PG.PV_INSERT_GA_VENTA_PR', LV_sSQL, SN_cod_retorno, LV_des_error );
         WHEN OTHERS THEN
              SN_cod_retorno := 156;
              IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                 SV_mens_retorno := CV_error_no_clasif;
              END IF;
                  LV_des_error   := 'PV_INSERT_GA_VENTA_PR('||eo_venta.num_venta||','||eo_venta.cod_cliente||'); '||SQLERRM;
              SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_DATOS_ABONADO_PG.PV_INSERT_GA_VENTA_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

END PV_INSERT_GA_VENTA;

--------------------------------------------------------------------------------------------------------

PROCEDURE PV_VALIDA_SOLICITUDES_BAJA_PR(SO_Abonado     IN            GA_Abonado_QT,
                                                                SN_cod_retorno     OUT NOCOPY    ge_errores_td.cod_msgerror%TYPE,
                                                                SV_mens_retorno    OUT NOCOPY    ge_errores_td.det_msgerror%TYPE,
                                                                SN_num_evento      OUT NOCOPY    ge_errores_pg.evento)

 IS
 /*
 <Documentación
   TipoDoc = "Procedure">>
    <Elemento
       Nombre = "PV_OBTIENE_NUMPERSONAL_PR"
       Lenguaje="PL/SQL"
       Fecha="09-01-2008"
       Versión="La del package"
       Diseñador="Maricel Avalos"
       Programador="Maricel Avalos"
       Ambiente Desarrollo="BD">
       <Retorno>N/A</Retorno>>
       <Descripción></Descripción>>
       <Parámetros>
          <Entrada>
             <param nom="SO_Abonado" Tipo="estructura"><param>>
          </Entrada>
          <Salida>
             <param nom="SN_cod_retorno" Tipo="NUMERICO">Codigo de Retorno</param>>
             <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>>
             <param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>>
          </Salida>
       </Parámetros>
    </Elemento>
 </Documentación>
 */

 LV_des_error                   ge_errores_pg.DesEvent;
 LV_sSql                        ge_errores_pg.vQuery;
 LN_Count                               NUMBER;
 ERROR_CONTROLADO               EXCEPTION;

BEGIN
        SN_cod_retorno  := 0;
        SV_mens_retorno := ' ';
        SN_num_evento  := 0;


                LV_sSql := 'SELECT COUNT(1) FROM PV_SOLICITUD_BAJAS_TO ';
                LV_sSql := LV_sSql || 'WHERE COD_ESTADO = 1  AND NUM_ABONADO = '||SO_Abonado.NUM_ABONADO;

                SELECT COUNT(1)
                INTO LN_Count
                 FROM PV_SOLICITUD_BAJAS_TO
                  WHERE COD_ESTADO = 1
                        AND NUM_ABONADO = SO_Abonado.NUM_ABONADO;

                        IF LN_Count > 0 THEN
                           SN_cod_retorno  :=  149;
                           RAISE ERROR_CONTROLADO;
                        END IF;


EXCEPTION
     WHEN ERROR_CONTROLADO THEN
              SV_mens_retorno := 'Abonado ya cuenta con una Solicitud de Baja por lo que no se considerará para Baja directa';
                  LV_des_error   := 'PV_VALIDA_SOLICITUDES_BAJA_PR('|| SO_Abonado.NUM_ABONADO||'); '||SQLERRM;
              SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_DATOS_ABONADO_PG.PV_VALIDA_SOLICITUDES_BAJA_PR', LV_sSQL, SN_cod_retorno, LV_des_error );
     WHEN NO_DATA_FOUND THEN
       SN_cod_retorno := 149;
       IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := CV_error_no_clasif;
       END IF;
                  LV_des_error   := 'PV_VALIDA_SOLICITUDES_BAJA_PR('|| SO_Abonado.NUM_ABONADO||'); '||SQLERRM;
              SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_DATOS_ABONADO_PG.PV_VALIDA_SOLICITUDES_BAJA_PR', LV_sSQL, SN_cod_retorno, LV_des_error );
         WHEN OTHERS THEN
              SN_cod_retorno := 156;
              IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                 SV_mens_retorno := CV_error_no_clasif;
              END IF;
                  LV_des_error   := 'PV_VALIDA_SOLICITUDES_BAJA_PR('|| SO_Abonado.NUM_ABONADO||'); '||SQLERRM;
              SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_DATOS_ABONADO_PG.PV_VALIDA_SOLICITUDES_BAJA_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

END PV_VALIDA_SOLICITUDES_BAJA_PR;

---------------------------------------------------------------------------------------------------
PROCEDURE PV_OBTIENE_USUARIO_PR(SO_Abonado     IN            GA_Abonado_QT,
                                                                SN_cod_retorno     OUT NOCOPY    ge_errores_td.cod_msgerror%TYPE,
                                                                SV_mens_retorno    OUT NOCOPY    ge_errores_td.det_msgerror%TYPE,
                                                                SN_num_evento      OUT NOCOPY    ge_errores_pg.evento)

 IS
 /*
 <Documentación
   TipoDoc = "Procedure">>
    <Elemento
       Nombre = "PV_OBTIENE_NUMPERSONAL_PR"
       Lenguaje="PL/SQL"
       Fecha="09-01-2008"
       Versión="La del package"
       Diseñador="Maricel Avalos"
       Programador="Maricel Avalos"
       Ambiente Desarrollo="BD">
       <Retorno>N/A</Retorno>>
       <Descripción></Descripción>>
       <Parámetros>
          <Entrada>
             <param nom="SO_Abonado" Tipo="estructura"><param>>
          </Entrada>
          <Salida>
             <param nom="SN_cod_retorno" Tipo="NUMERICO">Codigo de Retorno</param>>
             <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>>
             <param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>>
          </Salida>
       </Parámetros>
    </Elemento>
 </Documentación>
 */

 LV_des_error                   ge_errores_pg.DesEvent;
 LV_sSql                        ge_errores_pg.vQuery;
 LV_USUARIO                             VARCHAR2(15);
 ERROR_CONTROLADO               EXCEPTION;

BEGIN
        SN_cod_retorno  := 0;
        SV_mens_retorno := ' ';
        SN_num_evento  := 0;

                SELECT DISTINCT NOM_USUARORA
                INTO LV_USUARIO
                FROM GA_ABOCEL
                WHERE COD_CLIENTE = SO_Abonado.cod_cliente
                          AND NUM_VENTA = SO_Abonado.num_venta;

EXCEPTION
     WHEN NO_DATA_FOUND THEN
       SN_cod_retorno := 149;
       IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := CV_error_no_clasif;
       END IF;
                  LV_des_error   := 'PV_OBTIENE_USUARIO_PR('|| SO_Abonado.cod_cliente||', '||SO_Abonado.num_venta||'); '||SQLERRM;
              SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_DATOS_ABONADO_PG.PV_OBTIENE_USUARIO_PR', LV_sSQL, SN_cod_retorno, LV_des_error );
         WHEN OTHERS THEN
              SN_cod_retorno := 156;
              IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                 SV_mens_retorno := CV_error_no_clasif;
              END IF;
                  LV_des_error   := 'PV_OBTIENE_USUARIO_PR('|| SO_Abonado.cod_cliente||', '||SO_Abonado.num_venta||'); '||SQLERRM;
              SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_DATOS_ABONADO_PG.PV_OBTIENE_USUARIO_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

END PV_OBTIENE_USUARIO_PR;

---------------------------------------------------------------------------------------------------
PROCEDURE PV_OBTIENE_USUARIO_PR( SO_Abonado     IN            GA_Abonado_QT,
                                                                 c_Usuario              OUT NOCOPY refcursor,
                                                         SN_cod_retorno     OUT NOCOPY    ge_errores_td.cod_msgerror%TYPE,
                                                         SV_mens_retorno    OUT NOCOPY    ge_errores_td.det_msgerror%TYPE,
                                                         SN_num_evento      OUT NOCOPY    ge_errores_pg.evento)

 IS
 /*
 <Documentación
   TipoDoc = "Procedure">>
    <Elemento
       Nombre = "PV_OBTIENE_NUMPERSONAL_PR"
       Lenguaje="PL/SQL"
       Fecha="09-01-2008"
       Versión="La del package"
       Diseñador="Maricel Avalos"
       Programador="Maricel Avalos"
       Ambiente Desarrollo="BD">
       <Retorno>N/A</Retorno>>
       <Descripción></Descripción>>
       <Parámetros>
          <Entrada>
             <param nom="SO_Abonado" Tipo="estructura"><param>>
          </Entrada>
          <Salida>
             <param nom="SN_cod_retorno" Tipo="NUMERICO">Codigo de Retorno</param>>
             <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>>
             <param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>>
          </Salida>
       </Parámetros>
    </Elemento>
 </Documentación>
 */

 LV_des_error                   ge_errores_pg.DesEvent;
 LV_sSql                        ge_errores_pg.vQuery;
 LV_USUARIO                             VARCHAR2(15);
 ERROR_CONTROLADO               EXCEPTION;

BEGIN
        SN_cod_retorno  := 0;
        SV_mens_retorno := ' ';
        SN_num_evento  := 0;

                LV_sSql := 'SELECT DISTINCT NOM_USUARORA FROM GA_ABOCEL ';
                LV_sSql :=      LV_sSql || ' WHERE COD_CLIENTE = '||SO_Abonado.cod_cliente;
                LV_sSql :=      LV_sSql || ' AND NUM_VENTA = '||SO_Abonado.num_venta;

                OPEN c_Usuario for
                SELECT DISTINCT NOM_USUAR_VTA
                FROM GA_VENTAS
                WHERE COD_CLIENTE = SO_Abonado.cod_cliente
                AND NUM_VENTA = SO_Abonado.num_venta;

EXCEPTION
     WHEN NO_DATA_FOUND THEN
       SN_cod_retorno := 761;
       IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := CV_error_no_clasif;
       END IF;
                  LV_des_error   := 'PV_OBTIENE_USUARIO_PR('|| SO_Abonado.cod_cliente||', '||SO_Abonado.num_venta||'); '||SQLERRM;
              SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_DATOS_ABONADO_PG_AROG.PV_OBTIENE_USUARIO_PR', LV_sSQL, SN_cod_retorno, LV_des_error );
         WHEN OTHERS THEN
              SN_cod_retorno := 156;
              IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                 SV_mens_retorno := CV_error_no_clasif;
              END IF;
                  LV_des_error   := 'PV_OBTIENE_USUARIO_PR('|| SO_Abonado.cod_cliente||', '||SO_Abonado.num_venta||'); '||SQLERRM;
              SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_DATOS_ABONADO_PG_AROG.PV_OBTIENE_USUARIO_PR', LV_sSQL, SN_cod_retorno, LV_des_error );
END PV_OBTIENE_USUARIO_PR;

---------------------------------------------------------------------------------------------------
PROCEDURE PV_INSERT_GA_FINCICLO (SO_Abonado        IN            PV_GA_ABOCEL_QT,
                                            SN_cod_retorno     OUT NOCOPY    ge_errores_td.cod_msgerror%TYPE,
                                                    SV_mens_retorno    OUT NOCOPY    ge_errores_td.det_msgerror%TYPE,
                                                    SN_num_evento      OUT NOCOPY    ge_errores_pg.evento)
IS
 /*
 <Documentación
   TipoDoc = "Procedure">>
    <Elemento
       Nombre = "PV_INSERT_GA_FINCICLO"
       Lenguaje="PL/SQL"
       Fecha="06-03-2008"
       Versión="La del package"
       Diseñador="Orlando Cabezas"
       Programador="Orlando Cabezas"
       Ambiente Desarrollo="BD">
       <Retorno>N/A</Retorno>>
       <Descripción></Descripción>>
       <Parámetros>
          <Entrada>
             <param nom="SO_Abonado" Tipo="estructura"><param>>
          </Entrada>
          <Salida>
             <param nom="SN_cod_retorno" Tipo="NUMERICO">Codigo de Retorno</param>>
             <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>>
             <param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>>
          </Salida>
       </Parámetros>
    </Elemento>
 </Documentación>
 */

 LV_des_error                   ge_errores_pg.DesEvent;
 LV_sSql                        ge_errores_pg.vQuery;
 LV_USUARIO                     VARCHAR2(15);
 LN_PRODUCTO                    NUMBER(1):=1;
 LN_CICLO                               ga_Abocel.COD_CICLO%type;
 LN_CO_CICLFACT                 fa_ciclfact.COD_CICLFACT%type;
BEGIN
        SN_cod_retorno  := 0;
        SV_mens_retorno := ' ';
        SN_num_evento   := 0;

                IF SO_ABONADO.COD_VENDEDOR=0 THEN
                        SELECT  COD_CICLO INTO LN_CICLO
                        FROM GA_ABOCEL
                        WHERE NUM_ABONADO =SO_Abonado.num_abonado;

                        SELECT  COD_CICLFACT INTO LN_CO_CICLFACT
                        FROM FA_CICLFACT
                        WHERE COD_CICLO = LN_CICLO AND
                        SYSDATE BETWEEN FEC_DESDELLAM AND FEC_HASTALLAM;
                ELSE
                         LN_CO_CICLFACT:=SO_ABONADO.COD_VENDEDOR;
                END IF;

            LV_sSql := 'INSERT INTO GA_FINCICLO (COD_CLIENTE,COD_CICLFACT,NUM_ABONADO,';
                LV_sSql :=      LV_sSql || ' COD_PRODUCTO,TIP_PLANTARIF,COD_PLANTARIF,';
                LV_sSql :=      LV_sSql || ' COD_CARGOBASICO,FEC_DESDELLAM)';
                LV_sSql :=      LV_sSql || ' VALUES ('||SO_Abonado.cod_cliente    ||','||LN_CO_CICLFACT   ||','||
                                            SO_Abonado.num_abonado    ||','|| LN_PRODUCTO                  ||','||
                                            SO_Abonado.TIP_PLANTARIF  ||','|| SO_Abonado.COD_PLANTARIF ||','||
                                            SO_Abonado.COD_CARGOBASICO    ||','|| SO_Abonado.FEC_CUMPLIMEN ||')';

                INSERT INTO GA_FINCICLO (COD_CLIENTE,
                                            COD_CICLFACT,
                                            NUM_ABONADO,
                                            COD_PRODUCTO,
                                            TIP_PLANTARIF,
                                            COD_PLANTARIF,
                                            COD_CARGOBASICO,
                                            FEC_DESDELLAM
                                            )
                                    VALUES (SO_Abonado.cod_cliente       , LN_CO_CICLFACT ,
                                            SO_Abonado.num_abonado       , LN_PRODUCTO              ,
                                            SO_Abonado.TIP_PLANTARIF     , SO_Abonado.COD_PLANTARIF ,
                                            SO_Abonado.COD_CARGOBASICO   , SO_Abonado.FEC_CUMPLIMEN );

EXCEPTION
     WHEN NO_DATA_FOUND THEN
       SN_cod_retorno := 149;
       IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := CV_error_no_clasif;
       END IF;
                  LV_des_error   := 'PV_INSERT_GA_FINCICLO('||SO_Abonado.cod_cliente    ||','||SO_Abonado.COD_VENDEDOR   ||','||
          SO_Abonado.num_abonado    ||','|| LN_PRODUCTO            ||','||
          SO_Abonado.TIP_PLANTARIF  ||','|| SO_Abonado.COD_PLANTARIF ||','||
                  SO_Abonado.COD_CARGOBASICO    ||','|| SO_Abonado.FEC_CUMPLIMEN ||'); '||SQLERRM;
              SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_DATOS_ABONADO_PG.PV_INSERT_GA_FINCICLO', LV_sSQL, SN_cod_retorno, LV_des_error );
         WHEN OTHERS THEN
              SN_cod_retorno := 156;
              IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                 SV_mens_retorno := CV_error_no_clasif;
              END IF;
                  LV_des_error   := 'PV_INSERT_GA_FINCICLO('|| SO_Abonado.cod_cliente    ||','||SO_Abonado.COD_VENDEDOR   ||','||
          SO_Abonado.num_abonado    ||','|| LN_PRODUCTO            ||','||
          SO_Abonado.TIP_PLANTARIF  ||','|| SO_Abonado.COD_PLANTARIF ||','||
                  SO_Abonado.COD_CARGOBASICO    ||','|| SO_Abonado.FEC_CUMPLIMEN ||'); '||SQLERRM;
              SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER,'PV_DATOS_ABONADO_PG.PV_INSERT_GA_FINCICLO', LV_sSQL, SN_cod_retorno, LV_des_error );

END PV_INSERT_GA_FINCICLO;

------------------------------------------------------------------------------------------------------
FUNCTION PV_OBT_DATOS_PLATARIF_FN(EN_COD_PLANTARIF   IN          TA_PLANTARIF.COD_PLANTARIF%TYPE,
                                  SV_CARGOBASICO     OUT         TA_PLANTARIF.COD_CARGOBASICO%TYPE,
                                  SV_TIPPLANTARIF    OUT         TA_PLANTARIF.TIP_PLANTARIF%TYPE,
                                  SN_IMPLIMCONSUMO   OUT         GA_INTARCEL.IMP_LIMCONSUMO%TYPE,
                                  SN_cod_retorno     OUT NOCOPY  ge_errores_td.cod_msgerror%TYPE,
                                  SV_mens_retorno    OUT NOCOPY  ge_errores_td.det_msgerror%TYPE,
                                  SN_num_evento      OUT NOCOPY  ge_errores_pg.evento)
RETURN BOOLEAN
IS
/*
 <Documentación
   TipoDoc = "Procedure">>
    <Elemento
       Nombre = "PV_OBT_DATOS_PLATARIF_FN"
           Lenguaje="PL/SQL"
       Fecha="05-03-2008"
       Versión="La del package"
       Diseñador="German Saavedra"
       Programador="German Saavedra"
       Ambiente Desarrollo="BD">
       <Retorno>N/A</Retorno>>
       <Descripción></Descripción>>
       <Parámetros>
          <Entrada>
             <param nom="TA_PLANTARIF.COD_PLANTARIF Tipo="estructura">Estructura de datos Numero Abonado </param>>
          </Entrada>
          <Salida>
             <param nom="SN_cod_retorno" Tipo="NUMERICO">Codigo de Retorno</param>>
             <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>>
             <param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>>
          </Salida>
       </Parámetros>
    </Elemento>
 </Documentación>
*/
        LV_des_error        ge_errores_pg.DesEvent;
        LV_sSql                 ge_errores_pg.vQuery;
                SN_CODLIMCONSUMO        tol_limite_plan_td.COD_LIMCONS%TYPE;

BEGIN
        sn_cod_retorno  := 0;
        sv_mens_retorno := NULL;
        sn_num_evento  := 0;
        SN_IMPLIMCONSUMO := 0;

    LV_sSql:= 'SELECT cod_cargobasico, tip_plantarif ';
    LV_sSql:= LV_sSql || ' FROM TA_PLANTARIF  ';
    LV_sSql:= LV_sSql || ' WHERE  COD_PLANTARIF =' || EN_COD_PLANTARIF || ' ';
    LV_sSql:= LV_sSql || ' AND    NUM_ABONADO = 1';


        SELECT cod_cargobasico, tip_plantarif
        INTO SV_CARGOBASICO , SV_TIPPLANTARIF
         FROM ta_plantarif
          WHERE cod_plantarif = EN_COD_PLANTARIF
                        AND cod_producto = 1;

        BEGIN

                LV_sSql:= 'SELECT COD_LIMCONS FROM tol_limite_plan_td ';
                LV_sSql:= LV_sSql || ' WHERE cod_plantarif = '||EN_COD_PLANTARIF;
                LV_sSql:= LV_sSql || ' AND SYSDATE BETWEEN FEC_DESDE AND NVL(FEC_HASTA, SYSDATE)';
                LV_sSql:= LV_sSql || ' AND IND_DEFAULT = ''S''';

            SELECT COD_LIMCONS
              INTO SN_CODLIMCONSUMO
              FROM tol_limite_plan_td
              WHERE cod_plantarif = EN_COD_PLANTARIF
                            AND SYSDATE BETWEEN FEC_DESDE AND NVL(FEC_HASTA, SYSDATE)
                        AND IND_DEFAULT = 'S';

            EXCEPTION
                 WHEN NO_DATA_FOUND THEN
                      SN_CODLIMCONSUMO := '-1';
        END;

                LV_sSql:= 'SELECT imp_limite FROM tol_limite_td WHERE COD_LIMCONS = '||SN_CODLIMCONSUMO;

              SELECT imp_limite
              INTO SN_IMPLIMCONSUMO
               FROM tol_limite_td
                WHERE COD_LIMCONS = SN_CODLIMCONSUMO;

    RETURN TRUE;

EXCEPTION
   WHEN NO_DATA_FOUND THEN
       SN_cod_retorno := 1374;
       IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := CV_error_no_clasif;
       END IF;
       LV_des_error   := ' PV_OBT_DATOS_PLATARIF_FN('||EN_COD_PLANTARIF||'); '||SQLERRM;
       SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_DATOS_ABONADO_PG.PV_OBT_DATOS_PLATARIF_FN', LV_sSQL, SN_cod_retorno, LV_des_error );
       RETURN FALSE;

END PV_OBT_DATOS_PLATARIF_FN;
---------------------------------------------------------------------------------------------------

PROCEDURE PV_ACTUA_INTARCEL_ABONADO_PR(EO_Abonado             IN            GA_Abonado_QT,
                                                               SN_cod_retorno     OUT NOCOPY    ge_errores_td.cod_msgerror%TYPE,
                                                               SV_mens_retorno    OUT NOCOPY    ge_errores_td.det_msgerror%TYPE,
                                                               SN_num_evento      OUT NOCOPY    ge_errores_pg.evento)
IS
 /*
 <Documentación
   TipoDoc = "Procedure">>
    <Elemento
       Nombre = "PV_ACTUA_INTARCEL_ABONADO_PR"
       Lenguaje="PL/SQL"
       Fecha="05-03-2008"
       Versión="La del package"
       Diseñador="Ricardo Rocco"
       Programador="German Saavedra"
       Ambiente Desarrollo="BD">
       <Retorno>N/A</Retorno>>
       <Descripción></Descripción>>
       <Parámetros>
          <Entrada>
             <param nom="EO_Abonado" Tipo="estructura"><param>>
          </Entrada>
          <Salida>
             <param nom="SN_cod_retorno" Tipo="NUMERICO">Codigo de Retorno</param>>
             <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>>
             <param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>>
          </Salida>
       </Parámetros>
    </Elemento>
 </Documentación>
 */

 LV_des_error                   ge_errores_pg.DesEvent;
 LV_sSql                        ge_errores_pg.vQuery;
 LV_CARGOBASICO                         VARCHAR2(3);
 LV_TIPPLANTARIF                        VARCHAR2(1);
 LN_GRUPO                               NUMBER;
 LN_COD_USO                     GA_INTARCEL.COD_USO%TYPE;
 LN_IMPLIMCONSUMO                               GA_INTARCEL.IMP_LIMCONSUMO%TYPE;
 ERROR_PLANTARIF                EXCEPTION;

BEGIN
        SN_cod_retorno  := 0;
        SV_mens_retorno := ' ';
        SN_num_evento  := 0;

            LV_sSql := 'PV_OBT_DATOS_PLATARIF_FN('||EO_Abonado.cod_plantarif||')';

            IF (NOT PV_OBT_DATOS_PLATARIF_FN(EO_Abonado.cod_plantarif, LV_CARGOBASICO, LV_TIPPLANTARIF, LN_IMPLIMCONSUMO, SN_cod_retorno, SV_mens_retorno, SN_num_evento)) THEN
                   RAISE ERROR_PLANTARIF;
            END IF;

                LV_sSql:= ' SELECT DECODE(COD_TIPLAN,2,2,3,10) ';
                LV_sSql:=  LV_sSql  || ' FROM TA_PLANTARIF ';
                LV_sSql:=  LV_sSql || ' WHERE COD_PLANTARIF = ' || EO_Abonado.cod_plantarif ;
                LV_sSql:=  LV_sSql  || ' AND COD_PRODUCTO= 1 ';

                SELECT DECODE(COD_TIPLAN,2,2,3,10)
                INTO LN_COD_USO
                FROM TA_PLANTARIF
                WHERE COD_PLANTARIF = EO_Abonado.cod_plantarif
                AND COD_PRODUCTO= 1;

                IF LV_TIPPLANTARIF = 'E' THEN
                   BEGIN

                           LV_sSql:= 'SELECT cod_empresa';
                           LV_sSql:= LV_sSql || '  FROM ga_empresa  ';
                           LV_sSql:= LV_sSql || '  WHERE  cod_cliente =' || EO_Abonado.cod_cliente || ' ';
                           LV_sSql:= LV_sSql || '  AND    ROWNUM = 1';

                           SELECT cod_empresa
                           INTO LN_GRUPO
                           FROM ga_empresa
                           WHERE cod_cliente = EO_Abonado.cod_cliente
                           AND ROWNUM = 1;

                           EXCEPTION
                           WHEN NO_DATA_FOUND THEN
                             IF LN_GRUPO = NULL THEN
                                LN_GRUPO := 0;
                             END IF;
                   END;

                   LV_sSql := 'UPDATE ga_intarcel';
                   LV_sSql := LV_sSql || ' SET cod_plantarif =' || EO_Abonado.cod_plantarif || ',';
                   LV_sSql := LV_sSql || ' tip_plantarif =' || LV_TIPPLANTARIF || ',';
                   LV_sSql := LV_sSql || ' cod_cargobasico =' || LV_CARGOBASICO || ',';
                   LV_sSql := LV_sSql || ' cod_ciclo =' || EO_Abonado.cod_ciclo || ',';
                   LV_sSql := LV_sSql || ' cod_grupo =' || LN_GRUPO || ',';
                   LV_sSql := LV_sSql || ' cod_USO =' || LN_COD_USO   || ',';
                                   LV_sSql := LV_sSql || ' IMP_LIMCONSUMO = '||LN_IMPLIMCONSUMO;
                   LV_sSql := LV_sSql || ' WHERE num_abonado IN ( 0,' || EO_Abonado.num_abonado || ')';
                   LV_sSql := LV_sSql || ' AND cod_cliente =' || EO_Abonado.cod_cliente || ' ';
                   LV_sSql := LV_sSql || ' SYSDATE BETWEEN fec_desde AND fec_hasta';

                   UPDATE ga_intarcel
                   SET cod_plantarif = EO_Abonado.cod_plantarif,
                       tip_plantarif = LV_TIPPLANTARIF,
                           cod_cargobasico = LV_CARGOBASICO,
                           cod_ciclo = EO_Abonado.cod_ciclo,
                           cod_grupo = LN_GRUPO,
                           cod_uso = LN_COD_USO,
                                                   IMP_LIMCONSUMO = LN_IMPLIMCONSUMO
                   WHERE num_abonado IN (0, EO_Abonado.num_abonado)
                   AND   cod_cliente = EO_Abonado.cod_cliente
                   AND   SYSDATE BETWEEN fec_desde AND fec_hasta;
                ELSE
                   LV_sSql := 'UPDATE ga_intarcel';
                   LV_sSql := LV_sSql || 'SET cod_plantarif =' || EO_Abonado.cod_plantarif || ',';
                   LV_sSql := LV_sSql || 'tip_plantarif =' || LV_TIPPLANTARIF || ',';
                   LV_sSql := LV_sSql || 'cod_cargobasico =' || LV_CARGOBASICO || ',';
                   LV_sSql := LV_sSql || 'cod_ciclo =' || EO_Abonado.cod_ciclo || ',';
                   LV_sSql := LV_sSql || 'cod_USO =' || LN_COD_USO   || ',';
                   LV_sSql := LV_sSql || 'cod_GRUPO = NULL ,';
                                   LV_sSql := LV_sSql || ' IMP_LIMCONSUMO = '||LN_IMPLIMCONSUMO;
                   LV_sSql := LV_sSql || ' WHERE num_abonado IN ( 0,' || EO_Abonado.num_abonado || ')';
                   LV_sSql := LV_sSql || ' AND cod_cliente =' || EO_Abonado.cod_cliente || ' ';
                   LV_sSql := LV_sSql || ' SYSDATE BETWEEN fec_desde AND fec_hasta';

                   UPDATE ga_intarcel
                   SET cod_plantarif = EO_Abonado.cod_plantarif,
                       tip_plantarif = LV_TIPPLANTARIF,
                       cod_cargobasico = LV_CARGOBASICO,
                       cod_ciclo = EO_Abonado.cod_ciclo,
                       cod_uso = LN_COD_USO,
                                           cod_grupo = NULL,
                                           IMP_LIMCONSUMO = LN_IMPLIMCONSUMO
                   WHERE num_abonado IN (0, EO_Abonado.num_abonado)
                   AND   cod_cliente = EO_Abonado.cod_cliente
                   AND   SYSDATE BETWEEN fec_desde AND fec_hasta;
                 eND IF;

         LV_sSql :=' UPDATE GA_ABOCEL SET ';
         LV_sSql := LV_sSql ||' cod_ciclo = ' || EO_Abonado.cod_ciclo || ',';
         LV_sSql := LV_sSql ||' cod_uso = ' || LN_COD_USO   || ' ';
         LV_sSql := LV_sSql ||' WHERE num_abonado = ' || EO_Abonado.num_abonado|| '';

                 Update GA_ABOCEL SET
         cod_ciclo = EO_Abonado.cod_ciclo ,
         cod_uso   = LN_COD_USO
                 Where num_abonado = EO_Abonado.num_abonado;

EXCEPTION
     WHEN  ERROR_PLANTARIF THEN
           IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := CV_error_no_clasif;
       END IF;
           LV_des_error   := 'PV_ACTUA_INTARCEL_ABONADO_PR('|| EO_Abonado.cod_cliente||', '||EO_Abonado.num_abonado||', '||EO_Abonado.cod_plantarif||', '||EO_Abonado.cod_ciclo||'  ); '||SQLERRM;
           SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_DATOS_ABONADO_PG.PV_ACTUA_INTARCEL_ABONADO_PR', LV_sSQL, SN_cod_retorno, LV_des_error );
     WHEN NO_DATA_FOUND THEN
       SN_cod_retorno := 149;
       IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := CV_error_no_clasif;
       END IF;
                  LV_des_error   := 'PV_ACTUA_INTARCEL_ABONADO_PR('|| EO_Abonado.cod_cliente||', '||EO_Abonado.num_abonado||', '||EO_Abonado.cod_plantarif||', '||EO_Abonado.cod_ciclo||'  ); '||SQLERRM;
              SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_DATOS_ABONADO_PG.PV_ACTUA_INTARCEL_ABONADO_PR', LV_sSQL, SN_cod_retorno, LV_des_error );
     WHEN OTHERS THEN
              SN_cod_retorno := 156;
              IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                 SV_mens_retorno := CV_error_no_clasif;
              END IF;
                  LV_des_error   := 'PV_ACTUA_INTARCEL_ABONADO_PR('|| EO_Abonado.cod_cliente||', '||EO_Abonado.num_abonado||', '||EO_Abonado.cod_plantarif||', '||EO_Abonado.cod_ciclo||'  ); '||SQLERRM;
              SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_DATOS_ABONADO_PG.PV_ACTUA_INTARCEL_ABONADO_PR', LV_sSQL, SN_cod_retorno, LV_des_error );
END PV_ACTUA_INTARCEL_ABONADO_PR;

---------------------------------------------------------------------------------------------------
PROCEDURE PV_OBTIENE_ABONADO_EMPRESA_PR(EO_Abonado           IN         GA_ABONADO_QT,
                                                                SO_Lista_Abonado     OUT NOCOPY refCursor,
                                                                                SN_cod_retorno       OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                                                                                SV_mens_retorno      OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                                                                                SN_num_evento        OUT NOCOPY ge_errores_pg.evento)
IS
 /*
 <Documentación
   TipoDoc = "Procedure">>
    <Elemento
       Nombre = "PV_ACTUA_INTARCEL_ABONADO_PR"
       Lenguaje="PL/SQL"
       Fecha="05-03-2008"
       Versión="La del package"
       Diseñador="Ricardo Rocco"
       Programador="German Saavedra"
       Ambiente Desarrollo="BD">
       <Retorno>N/A</Retorno>>
       <Descripción></Descripción>>
       <Parámetros>
          <Entrada>
             <param nom="EO_Abonado" Tipo="estructura"><param>>
          </Entrada>
          <Salida>
             <param nom="SN_cod_retorno" Tipo="NUMERICO">Codigo de Retorno</param>>
             <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>>
             <param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>>
          </Salida>
       </Parámetros>
    </Elemento>
 </Documentación>
 */

 LV_des_error        ge_errores_pg.DesEvent;
 LV_sSql                 ge_errores_pg.vQuery;
 v_contador          NUMBER(9);
 LV_CountAbonados    NUMBER(15);
 ERROR_CONTROLADO    EXCEPTION;

  BEGIN
         SN_cod_retorno  := 0;
         SV_mens_retorno := ' ';
         SN_num_evento  := 0;

         LV_sSql:='SELECT COUNT(1) FROM ge_clientes a,';
         LV_sSql:=LV_sSql||' ga_abocel b,ta_plantarif c,';
         LV_sSql:=LV_sSql||' ga_situabo d,ta_limconsumo e,';
         LV_sSql:=LV_sSql||' ta_cargosbasico f, al_tipos_terminales g';
         LV_sSql:=LV_sSql||' WHERE a.cod_cliente = '||EO_Abonado.COD_CLIENTE;
         LV_sSql:=LV_sSql||' AND a.cod_cliente   = b.cod_cliente';
         LV_sSql:=LV_sSql||' AND b.cod_plantarif = c.cod_plantarif';
         LV_sSql:=LV_sSql||' AND b.cod_situacion = d.cod_situacion';
         LV_sSql:=LV_sSql||' AND b.tip_terminal = g.tip_terminal';
         LV_sSql:=LV_sSql||' AND g.cod_producto = '||CN_producto;
         LV_sSql:=LV_sSql||' AND e.cod_limconsumo = c.cod_limconsumo';
         LV_sSql:=LV_sSql||' AND e.cod_producto = '||CN_producto;
         LV_sSql:=LV_sSql||' AND c.cod_cargobasico = f.cod_cargobasico';
         LV_sSql:=LV_sSql||' AND f.cod_producto = '||CN_producto;
         LV_sSql:=LV_sSql||' AND b.cod_situacion NOT IN (''BAA'',''BAP'')';
         LV_sSql:=LV_sSql||' AND SYSDATE BETWEEN f.fec_desde AND f.fec_hasta';

         SELECT COUNT(1)
         INTO LV_CountAbonados
         FROM ge_clientes a,
                              ga_abocel b,
                              ta_plantarif c,
                              ga_situabo d,
                              ta_limconsumo e,
                              ta_cargosbasico f,
                              al_tipos_terminales g
                         WHERE a.cod_cliente = EO_Abonado.COD_CLIENTE
                          AND a.cod_cliente   = b.cod_cliente
                          AND b.cod_plantarif = c.cod_plantarif
                          AND b.cod_situacion = d.cod_situacion
                          AND b.tip_terminal = g.tip_terminal
                          AND g.cod_producto = CN_producto
                          AND e.cod_limconsumo = c.cod_limconsumo
                          AND e.cod_producto = CN_producto
                          AND c.cod_cargobasico = f.cod_cargobasico
                          AND f.cod_producto = CN_producto
                          AND b.cod_situacion NOT IN ('BAA','BAP')
                          AND SYSDATE BETWEEN f.fec_desde AND f.fec_hasta;

         IF LV_CountAbonados= 0 THEN
         RAISE ERROR_CONTROLADO;
     END IF;

         IF LV_CountAbonados > 0 THEN
                        LV_sSql:='SELECT  a.cod_cliente,b.num_abonado,b.num_celular,b.num_serie,b.num_imei,b.cod_tecnologia,';
                    LV_sSql:=LV_sSql||' b.cod_situacion,d.des_situacion,b.tip_plantarif,';
                    LV_sSql:=LV_sSql||' DECODE(b.tip_plantarif,'||chr(39)||'E'||chr(39)||','||chr(39)||'EMPRESA'||chr(39)||','||chr(39)||'I'||chr(39)||','||chr(39)||'INDIVIDUAL'||chr(39)||') AS des_tipplantarif,';
                    LV_sSql:=LV_sSql||' b.cod_plantarif,c.des_plantarif,b.cod_ciclo,c.cod_limconsumo,e.des_limconsumo,';
                    LV_sSql:=LV_sSql||' c.cod_tiplan,c.cod_tiplan AS des_tiplan,';
                    LV_sSql:=LV_sSql||' c.cod_cargobasico,b.cod_tipcontrato,b.cod_modventa,';
                    LV_sSql:=LV_sSql||' b.num_contrato, b.cod_planserv,b.cod_central,';
                    LV_sSql:=LV_sSql||' b.num_venta,b.cod_uso,b.fec_acepventa,b.fec_alta,b.fec_prorroga,b.num_anexo,b.cod_usuario,b.tip_terminal,';
                        LV_sSql:=LV_sSql||' f.imp_cargobasico,b.cod_cuenta,b.cod_subcuenta,     b.cod_vendedor,b.cod_causa_venta,b.fec_baja,b.fec_bajacen,b.fec_ultmod,';
                        LV_sSql:=LV_sSql||'     b.cod_empresa,b.fec_fincontra,b.ind_eqprestado,c.flg_rango,b.ind_disp, ' ||LV_CountAbonados ;
                        LV_sSql:=LV_sSql||' FROM ge_clientes   a, ';
                    LV_sSql:=LV_sSql||' ga_abocel     b, ';
                    LV_sSql:=LV_sSql||' ta_plantarif  c, ';
                    LV_sSql:=LV_sSql||' ga_situabo    d, ';
                    LV_sSql:=LV_sSql||' ta_limconsumo e ';
                    LV_sSql:=LV_sSql||' ta_cargosbasico f ';
                        LV_sSql:=LV_sSql||' al_tipos_terminales g';
                    LV_sSql:=LV_sSql||'  WHERE  a.cod_cliente      ='||EO_Abonado.cod_cliente;
                    LV_sSql:=LV_sSql||'  AND a.cod_cliente   = b.cod_cliente';
                    LV_sSql:=LV_sSql||'  AND b.cod_plantarif = c.cod_plantarif';
                    LV_sSql:=LV_sSql||'  AND b.cod_situacion = d.cod_situacion';
                        LV_sSql:=LV_sSql||'  AND b.tip_terminal = g.tip_terminal';
                    LV_sSql:=LV_sSql||'  AND g.cod_producto = '||CN_producto;
                        LV_sSql:=LV_sSql||'  AND e.cod_limconsumo = c.cod_limconsumo';
                        LV_sSql:=LV_sSql||'  AND e.cod_producto = '||CN_producto;
                        LV_sSql:=LV_sSql||'  AND c.cod_cargobasico = f.cod_cargobasico';
                        LV_sSql:=LV_sSql||'  AND f.cod_producto = '||CN_producto;
                        LV_sSql:=LV_sSql||'  AND b.cod_situacion NOT IN ('||chr(39)||'BAA'||chr(39)||','||chr(39)||'BAP'||chr(39)||') ';
                        LV_sSql:=LV_sSql||'  AND SYSDATE BETWEEN f.fec_desde AND f.fec_hasta';
                        LV_sSql:=LV_sSql||'  AND ROWNUM=1 ';

                         OPEN SO_Lista_Abonado FOR
                         SELECT a.cod_cliente,
                                b.num_abonado,
                                        b.num_celular,
                                        b.num_serie,
                                        b.num_imei,
                                        b.cod_tecnologia,
                                        b.cod_situacion,
                                        d.des_situacion,
                                b.tip_plantarif,
                                        DECODE(b.tip_plantarif,'E','EMPRESA', 'I', 'INDIVIDUAL') AS des_tipplantarif,
                                b.cod_plantarif,
                                        c.des_plantarif,
                                        b.cod_ciclo,
                                        c.cod_limconsumo,
                                        e.des_limconsumo,
                                        c.cod_tiplan,
                                    DECODE(c.cod_tiplan,'1','PREPAGO', '2', 'POSPAGO', '3', 'HIBRIDO') AS des_tiplan,
                                    b.cod_cargobasico,
                                        b.cod_tipcontrato,
                                        b.cod_modventa,
                                        b.num_contrato,
                                        b.cod_planserv,
                                        b.cod_central,
                                        b.num_venta,
                                        b.cod_uso,
                                    b.fec_acepventa,
                                        b.fec_alta,
                                        b.fec_prorroga,
                                        b.num_anexo,
                                        b.cod_usuario,
                                        b.tip_terminal,
                                        f.imp_cargobasico,
                                    b.cod_cuenta,
                                        b.cod_subcuenta,
                                        b.cod_vendedor,
                                        b.cod_causa_venta,
                                        b.fec_baja,
                                        b.fec_bajacen,
                                        b.fec_ultmod,
                                        b.cod_empresa,
                                b.fec_fincontra,
                                        b.ind_eqprestado,
                                        c.flg_rango,
                                        b.ind_disp,
                                        LV_CountAbonados
                         FROM ge_clientes a,
                              ga_abocel b,
                              ta_plantarif c,
                              ga_situabo d,
                              ta_limconsumo e,
                              ta_cargosbasico f,
                              al_tipos_terminales g
                         WHERE a.cod_cliente = EO_Abonado.COD_CLIENTE
                          AND a.cod_cliente   = b.cod_cliente
                          AND b.cod_plantarif = c.cod_plantarif
                          AND b.cod_situacion = d.cod_situacion
                          AND b.tip_terminal = g.tip_terminal
                          AND g.cod_producto = CN_producto
                          AND e.cod_limconsumo = c.cod_limconsumo
                          AND e.cod_producto = CN_producto
                          AND c.cod_cargobasico = f.cod_cargobasico
                          AND f.cod_producto = CN_producto
                          AND b.cod_situacion NOT IN ('BAA','BAP')
                          AND SYSDATE BETWEEN f.fec_desde AND f.fec_hasta
                          AND ROWNUM=1;
        END IF;

EXCEPTION
 WHEN ERROR_CONTROLADO THEN
   SN_cod_retorno := 1;
   SV_mens_retorno := 'Cliente no posee Abonados';
   LV_des_error   := ' PV_OBTIENE_ABONADO_EMPRESA_PR('||EO_Abonado.cod_cliente||'); '||SQLERRM;
   SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_DATOS_ABONADO_PG.PV_OBTIENE_ABONADO_EMPRESA_PR', LV_sSQL, SN_cod_retorno, LV_des_error );
 WHEN NO_DATA_FOUND THEN
       SN_cod_retorno := 203;
       IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := CV_error_no_clasif;
       END IF;
       LV_des_error   := ' PV_OBTIENE_ABONADO_EMPRESA_PR('||EO_Abonado.cod_cliente||'); '||SQLERRM;
       SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_DATOS_ABONADO_PG.PV_OBTIENE_ABONADO_EMPRESA_PR', LV_sSQL, SN_cod_retorno, LV_des_error );
 WHEN OTHERS THEN
       SN_cod_retorno := 156;
       IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := CV_error_no_clasif;
       END IF;
       LV_des_error   := ' PV_OBTIENE_ABONADO_EMPRESA_PR('||EO_Abonado.cod_cliente||'); '||SQLERRM;
       SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_DATOS_ABONADO_PG.PV_OBTIENE_ABONADO_EMPRESA_PR', LV_sSQL, SN_cod_retorno, LV_des_error );
END PV_OBTIENE_ABONADO_EMPRESA_PR;

-----------------------------------------------------------------------------------------------------------------
PROCEDURE PV_OBTIENE_BLOQUE_ABONADOS_PR(SO_FILTRO                   IN OUT NOCOPY   PV_FILTRO_ABONADOS_QT,
                                                                                   SO_Lista_Abonado         OUT NOCOPY          refCursor,
                                                                                   SN_cod_retorno           OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
                                                                                   SV_mens_retorno          OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
                                                                                   SN_num_evento            OUT NOCOPY          ge_errores_pg.evento)
IS
/*
 <Documentación
   TipoDoc = "Procedure">>
    <Elemento
       Nombre = "PV_OBTIENE_BLOQUE_ABONADOS_PR
       Lenguaje="PL/SQL"
       Fecha="04-03-2008"
       Versión="La del package"
       Diseñador=""
       Programador="Elizabeth Vera"
       Ambiente Desarrollo="BD">
       <Retorno>N/A</Retorno>>
       <Descripción></Descripción>>
       <Parámetros>
          <Entrada>
             <param nom="SO_FILTRO" Tipo="estructura">estructura para filtro y manejo de bloques/param>>
          </Entrada>
          <Salida>
             <param Cursor="SO_Lista_Abonado"   Tipo="Cursor refCursor">        </param>>
             <param nom="SN_cod_retorno"     Tipo="NUMERICO">Codigo de Retorno  </param>>
             <param nom="SV_mens_retorno"     Tipo="CARACTER">Mensaje de Retorno </param>>
             <param nom="SN_num_evento"      Tipo="NUMERICO">Numero de Evento   </param>>
          </Salida>
       </Parámetros>
    </Elemento>
 </Documentación>
*/
 LV_des_error    ge_errores_pg.DesEvent;
 LV_sSql      ge_errores_pg.vQuery;
 v_contador     number(9);
 LN_cantAbocel    NUMBER(15);
 LN_cantAboamist    NUMBER(15);
 LN_registro_inicio NUMBER(6);
 LN_registro_fin        NUMBER(6);

 ERROR_CONTROLADO    EXCEPTION;

  BEGIN
         SN_cod_retorno  := 0;
         SV_mens_retorno := ' ';
         SN_num_evento  := 0;

                  LN_registro_inicio := SO_FILTRO.MAX_REG_BLOQUE * SO_FILTRO.NUM_BLOQUE  - SO_FILTRO.MAX_REG_BLOQUE + 1;
                  LN_registro_fin := SO_FILTRO.MAX_REG_BLOQUE * SO_FILTRO.NUM_BLOQUE;

   LV_sSql:='SELECT  count(1) ';
   LV_sSql:=LV_sSql||' FROM ga_abocel';
   LV_sSql:=LV_sSql||' WHERE cod_cliente = '||SO_FILTRO.cod_cliente;

   SELECT count(1)
   INTO LN_cantAbocel
    FROM ga_abocel
     WHERE cod_cliente = SO_FILTRO.cod_cliente;

   LV_sSql:='SELECT  count(1) ';
   LV_sSql:=LV_sSql||' FROM ga_abocel';
   LV_sSql:=LV_sSql||' WHERE cod_cliente = '||SO_FILTRO.cod_cliente;

   SELECT count(1)
   INTO LN_cantAboamist
    FROM ga_aboamist
     WHERE cod_cliente = SO_FILTRO.cod_cliente;

   IF LN_cantAbocel= 0 AND LN_cantAboamist= 0 THEN
      RAISE ERROR_CONTROLADO;
   END IF;

   IF LN_cantAbocel > 0 THEN
    LV_sSql:='SELECT  a.cod_cliente,b.num_abonado,b.num_celular,b.num_serie,b.num_imei,b.cod_tecnologia,';
    LV_sSql:=LV_sSql||' b.cod_situacion,d.des_situacion,b.tip_plantarif,';
    LV_sSql:=LV_sSql||' DECODE(b.tip_plantarif,'||chr(39)||'E'||chr(39)||','||chr(39)||'EMPRESA'||chr(39)||','||chr(39)||'I'||chr(39)||','||chr(39)||'INDIVIDUAL'||chr(39)||') AS des_tipplantarif,';
    LV_sSql:=LV_sSql||' b.cod_plantarif,c.des_plantarif,b.cod_ciclo,c.cod_limconsumo,f.des_limconsumo,';
    LV_sSql:=LV_sSql||' c.cod_tiplan,e.des_valor AS des_tiplan,';
    LV_sSql:=LV_sSql||' c.cod_cargobasico,b.cod_tipcontrato,b.cod_modventa,';
    LV_sSql:=LV_sSql||' b.num_contrato, b.cod_planserv,b.cod_central,';
    LV_sSql:=LV_sSql||' b.num_venta,b.cod_uso,b.fec_acepventa,b.fec_alta,b.fec_prorroga,b.num_anexo,b.cod_usuario,b.tip_terminal,b.num_venta';
    LV_sSql:=LV_sSql||'  FROM ge_clientes   a, ';
    LV_sSql:=LV_sSql||' ga_abocel     b, ';
    LV_sSql:=LV_sSql||' ta_plantarif  c, ';
    LV_sSql:=LV_sSql||' ga_situabo    d, ';
    LV_sSql:=LV_sSql||' ged_codigos   e, ';
    LV_sSql:=LV_sSql||' ta_limconsumo f ';
    LV_sSql:=LV_sSql||'  WHERE  a.cod_cliente      ='||SO_FILTRO.cod_cliente;
    LV_sSql:=LV_sSql||'  AND a.cod_cliente   = b.cod_cliente';
    LV_sSql:=LV_sSql||'  and b.cod_plantarif = c.cod_plantarif';
    LV_sSql:=LV_sSql||'  and b.cod_situacion = d.cod_situacion';
    LV_sSql:=LV_sSql||'  AND e.cod_modulo = '||CV_cod_modulo_GE;
    LV_sSql:=LV_sSql||'  AND e.nom_columna   = ''COD_TIPLAN''';
    LV_sSql:=LV_sSql||'  AND e.nom_tabla     = ''TA_PLANTARIF'' ';
    LV_sSql:=LV_sSql||'  AND e.cod_valor     = c.COD_TIPLAN ';
    LV_sSql:=LV_sSql||'  AND f.cod_limconsumo = c.cod_limconsumo  ';
    LV_sSql:=LV_sSql||'  AND b.cod_situacion NOT IN ('||chr(39)||'BAA'||chr(39)||','||chr(39)||'BAP'||chr(39)||') ';

    OPEN SO_Lista_Abonado FOR
        SELECT
                  cod_cliente,
              num_abonado,
              num_celular,
              num_serie,
              num_imei,
              cod_tecnologia,
              cod_situacion,
              des_situacion,
              tip_plantarif,
              des_tipplantarif,
              cod_plantarif,
              des_plantarif,
              cod_ciclo,
              cod_limconsumo,
              des_limconsumo,
              cod_tiplan,
              des_tiplan,
              cod_cargobasico,
              cod_tipcontrato,
              cod_modventa,
              num_contrato,
              cod_planserv,
              cod_central,
              num_venta,
              cod_uso,
              fec_acepventa,
              fec_alta,
              fec_prorroga,
              num_anexo,
              cod_usuario,
              tip_terminal,
              imp_cargobasico,
              cod_cuenta,
              cod_subcuenta,
              cod_vendedor,
              cod_causa_venta,
              fec_baja,
              fec_bajacen,
              fec_ultmod,
              cod_empresa,
              fec_fincontra,
              ind_eqprestado,
              flg_rango

        FROM (

            SELECT  a.cod_cliente,
              b.num_abonado,
              b.num_celular,
              b.num_serie,
              b.num_imei,
              b.cod_tecnologia,
              b.cod_situacion,
              d.des_situacion,
              b.tip_plantarif,
              DECODE(b.tip_plantarif,'E','EMPRESA', 'I', 'INDIVIDUAL') AS des_tipplantarif,
              b.cod_plantarif,
              c.des_plantarif,
              b.cod_ciclo,
              c.cod_limconsumo,
              f.des_limconsumo,
              c.cod_tiplan,
              DECODE(c.cod_tiplan,'1','PREPAGO', '2', 'POSPAGO', '3', 'HIBRIDO') AS des_tiplan,
              c.cod_cargobasico,
              b.cod_tipcontrato,
              b.cod_modventa,
              b.num_contrato,
              b.cod_planserv,
              b.cod_central,
              b.num_venta,
              b.cod_uso,
              b.fec_acepventa,
              b.fec_alta,
              b.fec_prorroga,
              b.num_anexo,
              b.cod_usuario,
              b.tip_terminal,
              g.imp_cargobasico,
              b.cod_cuenta,
              b.cod_subcuenta,
              b.cod_vendedor,
              b.cod_causa_venta,
              b.fec_baja,
              b.fec_bajacen,
              b.fec_ultmod,
              b.cod_empresa,
              b.fec_fincontra,
              b.ind_eqprestado,
              c.flg_rango,
                  rownum as filas

              FROM ge_clientes a,
                ga_abocel b,
                ta_plantarif c,
                ga_situabo d,
                ged_codigos e,
                ta_limconsumo f,
                ta_cargosbasico g

              WHERE  a.cod_cliente      = SO_FILTRO.cod_cliente
                 AND a.cod_cliente   = b.cod_cliente
                 and b.cod_plantarif = c.cod_plantarif
                 AND c.cod_cargobasico = g.cod_cargobasico
                 and b.cod_situacion = d.cod_situacion
                 AND e.cod_modulo = CV_cod_modulo_GE
                    AND e.nom_columna = 'COD_TIPLAN'
                 AND e.nom_tabla = 'TA_PLANTARIF'
                 AND e.cod_valor   = c.COD_TIPLAN
                 AND f.cod_limconsumo = c.cod_limconsumo
                 AND b.cod_situacion NOT IN ('BAA','BAP')
                 AND SYSDATE BETWEEN g.fec_desde AND g.fec_hasta
          )
          WHERE FILAS BETWEEN  LN_registro_inicio AND LN_registro_fin;

   ELSE
    IF LN_cantAboamist > 0 THEN
     LV_sSql:=LV_sSql||'  SELECT a.cod_cliente,b.num_abonado,b.num_celular,b.num_serie,b.num_imei,b.cod_tecnologia,b.cod_situacion, ';
     LV_sSql:=LV_sSql||'  d.des_situacion,b.tip_plantarif, ';
     LV_sSql:=LV_sSql||'  DECODE(b.tip_plantarif,''E'',''EMPRESA'', ''I'', ''INDIVIDUAL'') AS des_tipplantarif, ';
     LV_sSql:=LV_sSql||'  b.cod_plantarif,c.des_plantarif, b.cod_ciclo, c.cod_limconsumo, f.des_limconsumo, ';
     LV_sSql:=LV_sSql||'  c.cod_tiplan,e.des_valor AS des_tiplan,c.cod_cargobasico,b.cod_tipcontrato,b.cod_modventa, ';
     LV_sSql:=LV_sSql||'  b.num_contrato,b.cod_planserv,b.cod_central,b.num_venta,b.cod_uso, ';
     LV_sSql:=LV_sSql||'  b.fec_acepventa, b.fec_alta,b.fec_prorroga,b.num_anexo,b.cod_usuario,b.tip_terminal,b.num_venta ';
     LV_sSql:=LV_sSql||'  FROM ge_clientes   a, ';
     LV_sSql:=LV_sSql||'    ga_aboamist   b, ';
     LV_sSql:=LV_sSql||'    ta_plantarif  c, ';
     LV_sSql:=LV_sSql||'    ga_situabo    d, ';
     LV_sSql:=LV_sSql||'    ged_codigos   e, ';
     LV_sSql:=LV_sSql||'    ta_limconsumo f  ';
     LV_sSql:=LV_sSql||'  WHERE a.cod_cliente        ='||SO_FILTRO.cod_cliente||' ';
     LV_sSql:=LV_sSql||'     AND a.cod_cliente    = b.cod_cliente';
     LV_sSql:=LV_sSql||'     and b.cod_plantarif  = c.cod_plantarif';
     LV_sSql:=LV_sSql||'     and b.cod_situacion  = d.cod_situacion';
     LV_sSql:=LV_sSql||'  AND e.cod_modulo = '||CV_cod_modulo_GE;
     LV_sSql:=LV_sSql||'     AND e.nom_columna    = ''COD_TIPLAN''';
     LV_sSql:=LV_sSql||'     AND e.nom_tabla      = ''TA_PLANTARIF''';
     LV_sSql:=LV_sSql||'     AND e.cod_valor      = c.cod_tiplan';
     LV_sSql:=LV_sSql||'     and f.cod_limconsumo = c.cod_limconsumo';
     LV_sSql:=LV_sSql||'     AND b.cod_situacion NOT IN (''BAA'',''BAP''); ';

      OPEN SO_Lista_Abonado FOR

        SELECT
                  cod_cliente,
              num_abonado,
              num_celular,
              num_serie,
              num_imei,
              cod_tecnologia,
              cod_situacion,
              des_situacion,
              tip_plantarif,
              des_tipplantarif,
              cod_plantarif,
              des_plantarif,
              cod_ciclo,
              cod_limconsumo,
              des_limconsumo,
              cod_tiplan,
              des_tiplan,
              cod_cargobasico,
              cod_tipcontrato,
              cod_modventa,
              num_contrato,
              cod_planserv,
              cod_central,
              num_venta,
              cod_uso,
              fec_acepventa,
              fec_alta,
              fec_prorroga,
              num_anexo,
              cod_usuario,
              tip_terminal,
              imp_cargobasico,
              cod_cuenta,
              cod_subcuenta,
              cod_vendedor,
              cod_causa_venta,
              fec_baja,
              fec_bajacen,
              fec_ultmod,
              cod_empresa,
              fec_fincontra,
              ind_eqprestado,
              flg_rango

        FROM (

              SELECT a.cod_cliente,
               b.num_abonado,
               b.num_celular,
               b.num_serie,
               b.num_imei,
               b.cod_tecnologia,
               b.cod_situacion,
               d.des_situacion,
               b.tip_plantarif,
               DECODE(b.tip_plantarif,'E','EMPRESA', 'I', 'INDIVIDUAL') AS des_tipplantarif,
               b.cod_plantarif,
               c.des_plantarif,
               b.cod_ciclo,
               c.cod_limconsumo,
               f.des_limconsumo,
               c.cod_tiplan,
               DECODE(c.cod_tiplan,'1','PREPAGO', '2', 'POSPAGO', '3', 'HIBRIDO') AS des_tiplan,
               c.cod_cargobasico,
               b.cod_tipcontrato,
               b.cod_modventa,
               b.num_contrato,
               b.cod_planserv,
               b.cod_central,
               b.num_venta,
               b.cod_uso,
               b.fec_acepventa,
                  b.fec_alta,
                  NULL fec_prorroga,
                  b.num_anexo,
                  b.cod_usuario,
               b.tip_terminal,
               g.imp_cargobasico,
               b.cod_cuenta,
               b.cod_subcuenta,
               b.cod_vendedor,
               b.cod_causa_venta,
               b.fec_baja,
               b.fec_bajacen,
               b.fec_ultmod,
               b.cod_empresa,
               b.fec_fincontra,
               null ind_eqprestado,
               c.flg_rango,
                   rownum as filas
              FROM ge_clientes a,
                ga_aboamist b,
                ta_plantarif c,
                ga_situabo d,
                ged_codigos e,
                ta_limconsumo f,
                ta_cargosbasico g
              WHERE a.cod_cliente   = SO_FILTRO.cod_cliente
                 AND a.cod_cliente   = b.cod_cliente
                 and b.cod_plantarif = c.cod_plantarif
                 AND c.cod_cargobasico = g.cod_cargobasico
                 and b.cod_situacion = d.cod_situacion
                 AND e.cod_modulo = CV_cod_modulo_GE
                 AND e.nom_columna = 'COD_TIPLAN'
                 AND e.nom_tabla = 'TA_PLANTARIF'
                 AND e.cod_valor   = c.cod_tiplan
                 and f.cod_limconsumo = c.cod_limconsumo
                 AND b.cod_situacion NOT IN ('BAA','BAP')
                 AND SYSDATE BETWEEN g.fec_desde AND g.fec_hasta

                  )
          WHERE FILAS BETWEEN  LN_registro_inicio AND LN_registro_fin;


    END IF;
   END IF;

   SO_FILTRO.NUM_BLOQUE := SO_FILTRO.NUM_BLOQUE + 1;

EXCEPTION
 WHEN ERROR_CONTROLADO THEN
   SN_cod_retorno := 1;
   SV_mens_retorno := 'Cliente no posee Abonados';
   LV_des_error   := ' PV_OBTIENE_BLOQUE_ABONADOS_PR('||SO_FILTRO.cod_cliente||'); '||SQLERRM;
   SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_DATOS_ABONADO_PG.PV_OBTIENE_BLOQUE_ABONADOS_PR', LV_sSQL, SN_cod_retorno, LV_des_error );
 WHEN OTHERS THEN
       SN_cod_retorno := 156;
       IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := CV_error_no_clasif;
       END IF;
    LV_des_error   := ' PV_OBTIENE_BLOQUE_ABONADOS_PR('||SO_FILTRO.cod_cliente||'); '||SQLERRM;
    SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_DATOS_ABONADO_PG.PV_OBTIENE_BLOQUE_ABONADOS_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

END PV_OBTIENE_BLOQUE_ABONADOS_PR;
--------------------------------------------------------------------------------------------------------

PROCEDURE PV_OBTIENE_NUMCORPORATIVO_PR (EO_GA_NUM_PERSONAL IN OUT        PV_VAL_BAJA_ATLANTIDA_QT,
                                                         SN_cod_retorno     OUT NOCOPY    ge_errores_td.cod_msgerror%TYPE,
                                                                 SV_mens_retorno    OUT NOCOPY    ge_errores_td.det_msgerror%TYPE,
                                                                 SN_num_evento      OUT NOCOPY    ge_errores_pg.evento)

 IS
 /*
 <Documentación
   TipoDoc = "Procedure">>
    <Elemento
       Nombre = "PV_OBTIENE_NUMCORPORATIVO_PR"
       Lenguaje="PL/SQL"
       Fecha="09-01-2008"
       Versión="La del package"
       Diseñador="YESENIA OSSES"
       Programador="YESENIA OSSES"
       Ambiente Desarrollo="BD">
       <Retorno>N/A</Retorno>>
       <Descripción></Descripción>>
       <Parámetros>
          <Entrada>
             <param nom="EO_GA_NUM_PERSONAL" Tipo="estructura"><param>>
          </Entrada>
          <Salida>
             <param nom="SN_cod_retorno" Tipo="NUMERICO">Codigo de Retorno</param>>
             <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>>
             <param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>>
          </Salida>
       </Parámetros>
    </Elemento>
 </Documentación>
 */

 LV_des_error    ge_errores_pg.DesEvent;
 LV_sSql      ge_errores_pg.vQuery;

BEGIN
        SN_cod_retorno  := 0;
        SV_mens_retorno := ' ';
        SN_num_evento  := 0;

                LV_sSql := 'SELECT NUM_CEL_CORP FROM GA_NUMCEL_PERSONAL_TO';
                LV_sSql := LV_sSql || 'WHERE NUM_CEL_PERS = '|| EO_GA_NUM_PERSONAL.NUM_CELULAR ;


        SELECT NUM_CEL_CORP INTO EO_GA_NUM_PERSONAL.NUM_CELULAR_NUE
                FROM GA_NUMCEL_PERSONAL_TO WHERE NUM_CEL_PERS = EO_GA_NUM_PERSONAL.NUM_CELULAR;


EXCEPTION
                 WHEN NO_DATA_FOUND THEN
                          EO_GA_NUM_PERSONAL.NUM_CELULAR_NUE := 0;

                WHEN OTHERS THEN
                 SN_cod_retorno := 156;
                         IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                                SV_mens_retorno := CV_error_no_clasif;
                         END IF;

                         LV_des_error   := 'PV_DATOS_ABONADO_PG.PV_OBTIENE_NUMCORPORATIVO_PR('||EO_GA_NUM_PERSONAL.NUM_CELULAR ||') '||SQLERRM;
                         SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_DATOS_ABONADO_PG.PV_OBTIENE_NUMCORPORATIVO_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

END PV_OBTIENE_NUMCORPORATIVO_PR;
--------------------------------------------------------------------------------------------------------

PROCEDURE PV_MASCARA_MODIFICAR_PR (EO_GA_NUM_PERSONAL IN OUT PV_GA_ABOCEL_QT,
                                                                          SN_cod_retorno     OUT NOCOPY    ge_errores_td.cod_msgerror%TYPE,
                                                                          SV_mens_retorno    OUT NOCOPY    ge_errores_td.det_msgerror%TYPE,
                                                                          SN_num_evento      OUT NOCOPY    ge_errores_pg.evento)

IS
 /*
 <Documentación
   TipoDoc = "Procedure">>
    <Elemento
       Nombre = " PV_MASCARA_MODIFICAR_PR "
       Lenguaje="PL/SQL"
       Fecha="07-05-2008"
       Versión="La del package"
       Diseñador="Orlando Cabezas"
       Programador="Orlando Cabezas"
       Ambiente Desarrollo="BD">
       <Retorno>N/A</Retorno>>
       <Descripción></Descripción>>
       <Parámetros>
          <Entrada>
             <param nom="EO_GA_NUM_PERSONAL" Tipo="estructura"><param>>
          </Entrada>
          <Salida>
             <param nom="SN_cod_retorno" Tipo="NUMERICO">Codigo de Retorno</param>>
             <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>>
             <param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>>
          </Salida>
       </Parámetros>
    </Elemento>
 </Documentación>
 */

 LV_des_error      ge_errores_pg.DesEvent;
 LV_sSql           ge_errores_pg.vQuery;
 ERROR_EJECUCION   EXCEPTION;

BEGIN
        SN_cod_retorno  := 0;
        SV_mens_retorno := ' ';
        SN_num_evento  := 0;

        LV_sSql := 'GA_NUMCEL_PERSONAL_PG.GA_MODIFICA_NUMPERSONAL_PR (';
        LV_sSql := LV_sSql || EO_GA_NUM_PERSONAL.NUM_CELULAR || ',' ;
        LV_sSql := LV_sSql || EO_GA_NUM_PERSONAL.NUM_CELULAR || ',' ;
        LV_sSql := LV_sSql || EO_GA_NUM_PERSONAL.COD_SITUACION || ',' ;
        LV_sSql := LV_sSql || EO_GA_NUM_PERSONAL.ID_SECUENCIA || ',' ;
        LV_sSql := LV_sSql || SN_cod_retorno || ',' ;
        LV_sSql := LV_sSql || SN_num_evento || ',' ;
        LV_sSql := LV_sSql || SV_mens_retorno || ')' ;

       GA_NUMCEL_PERSONAL_PG.GA_MODIFICA_NUMPERSONAL_PR(EO_GA_NUM_PERSONAL.NUM_CELULAR,
                                                                  EO_GA_NUM_PERSONAL.NUM_CELULAR,
                                                                 EO_GA_NUM_PERSONAL.COD_SITUACION,
                                                         EO_GA_NUM_PERSONAL.ID_SECUENCIA,
                                                          SN_cod_retorno,
                                                          SN_num_evento,
                                                          SV_mens_retorno);

     IF(SN_cod_retorno <> 0)THEN
        RAISE ERROR_EJECUCION;
     END IF;

EXCEPTION
 WHEN ERROR_EJECUCION THEN

   LV_des_error   := 'PV_DATOS_ABONADO_PG.PV_MASCARA_MODIFICAR_PR ('||EO_GA_NUM_PERSONAL.NUM_CELULAR  || ',' || EO_GA_NUM_PERSONAL.COD_SITUACION ||') '||SQLERRM;
   SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_DATOS_ABONADO_PG.PV_MASCARA_MODIFICAR_PR ', LV_sSQL,
   SN_cod_retorno, LV_des_error );

 WHEN OTHERS THEN
           SN_cod_retorno := 156;
           IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                           SV_mens_retorno := CV_error_no_clasif;
           END IF;

   LV_des_error   := 'PV_DATOS_ABONADO_PG.PV_MASCARA_MODIFICAR_PR ('||EO_GA_NUM_PERSONAL.NUM_CELULAR  || ',' || EO_GA_NUM_PERSONAL.COD_SITUACION ||') '||SQLERRM;
   SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_DATOS_ABONADO_PG.PV_MASCARA_MODIFICAR_PR ', LV_sSQL,
   SN_cod_retorno, LV_des_error );

END PV_MASCARA_MODIFICAR_PR;

--------------------------------------------------------------------------------------------------------

PROCEDURE PV_VALBAJAATL_EMP_PR( EO_CLIENTE    IN OUT      PV_CLIENTE_QT,
                                SN_cod_retorno       OUT NOCOPY  ge_errores_td.cod_msgerror%TYPE,
                                SV_mens_retorno      OUT NOCOPY  ge_errores_td.det_msgerror%TYPE,
                                SN_num_evento        OUT NOCOPY  ge_errores_pg.evento)

IS
 /*
 <Documentación
   TipoDoc = "Procedure">>
    <Elemento
       Nombre = "PV_VALBAJAATL_EMP_PR"
       Lenguaje="PL/SQL"
       Fecha="11-06-2008"
       Versión="La del package"
       Diseñador="oRLANDO cABEZAS"
       Programador="oRLANDO cABEZAS"
       Ambiente Desarrollo="BD">
       <Retorno>N/A</Retorno>>
       <Descripción></Descripción>>
       <Parámetros>
          <Entrada>
             <param nom="EO_CLIENTE " Tipo="estructura"><param>>
          </Entrada>
          <Salida>
             <param nom="SN_cod_retorno" Tipo="NUMERICO">Codigo de Retorno</param>>
             <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>>
             <param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>>
          </Salida>
       </Parámetros>
    </Elemento>
 </Documentación>
 */

 LV_des_error       ge_errores_pg.DesEvent;
 LV_sSql            ge_errores_pg.vQuery;
 LV_COD_PLANTARIF   ga_abocel.COD_PLANTARIF%type;
 LN_PLAN_ATLANTIDAD NUMBER;
 LN_PERSONAL        NUMBER;
 LN_ABONADO         GA_ABOCEL.NUM_ABONADO%TYPE;

BEGIN
    SN_cod_retorno  := 0;
    SV_mens_retorno := 'OK';
    SN_num_evento   := 0;
    EO_CLIENTE.COD_VALOR := 'FALSE';

    LV_sSql:='  SELECT COD_EMPRESA FROM GA_EMPRESA WHERE COD_CLIENTE := '||EO_CLIENTE.COD_CLIENTE;

    SELECT COD_PLANTARIF
    INTO   LV_COD_PLANTARIF
    FROM   GA_EMPRESA
    WHERE  COD_CLIENTE = EO_CLIENTE.COD_CLIENTE;

    LN_PLAN_ATLANTIDAD:=0;

    BEGIN
        SELECT COUNT(1)
        INTO   LN_PLAN_ATLANTIDAD
        FROM   GA_SERVSUPL
        WHERE  COD_PRODUCTO  = 1
        AND    COD_SERVICIO IN (SELECT B.COD_SERVICIO
                                FROM   GAD_SERVSUP_PLAN B
                                WHERE  B.COD_PRODUCTO   = 1
                                AND    B.COD_PLANTARIF  = LV_COD_PLANTARIF
                                AND    B.COD_SERVICIO  IN (SELECT COD_VALOR
                                                           FROM   GED_CODIGOS
                                                           WHERE  COD_MODULO  = 'GA'
                                                           AND    NOM_TABLA   = 'GAD_SERVSUP_PLAN'
                                                           AND    NOM_COLUMNA = 'COD_SERVICIO')
                               );
        EXCEPTION
            when OTHERS THEN
                 LN_PLAN_ATLANTIDAD:=0;
    END;

    LN_ABONADO:=0;

    BEGIN
        SELECT COUNT(1)
        INTO   LN_ABONADO
        FROM   GA_ABOCEL
        WHERE  COD_CLIENTE        = EO_CLIENTE.COD_CLIENTE
        AND    COD_SITUACION NOT IN ('BAA','BAP')
        AND    NUM_ABONADO       IN (SELECT A.NUM_ABONADO
                                             FROM   GA_SERVSUPLABO A
                                     WHERE  A.COD_SERVICIO IN (SELECT cod_valor
                                                               FROM   GED_CODIGOS
                                                               WHERE  cod_modulo = 'GA'
                                                               AND    nom_tabla  = 'GAD_SERVSUP_PLAN'
                                                               AND    nom_columna = 'COD_SERVICIO')
                                     AND    A.IND_ESTADO < 3
                                                                        );
        EXCEPTION
            WHEN OTHERS THEN
                 LN_ABONADO:=0;
    END;

    LN_PERSONAL:=0;

    BEGIN
        SELECT COUNT(1)
        INTO   LN_PERSONAL
        FROM   GA_ABOCEL
        WHERE  COD_CLIENTE        = EO_CLIENTE.COD_CLIENTE
        AND    COD_SITUACION NOT IN ('BAA','BAP')
        AND    NUM_CELULAR       IN (SELECT A.NUM_CEL_CORP
                                     FROM   GA_NUMCEL_PERSONAL_TO A
                                     WHERE  A.NUM_CEL_CORP=NUM_CELULAR
                                                                        );
        EXCEPTION
            WHEN OTHERS THEN
                 LN_PERSONAL:=0;
    END;

    IF (LN_ABONADO > 0 AND  LN_PLAN_ATLANTIDAD > 0 AND LN_PERSONAL > 0)  THEN
        EO_CLIENTE.COD_VALOR := 'TRUE';
    ELSE
        EO_CLIENTE.COD_VALOR := 'FALSE';
    END IF;


EXCEPTION
    WHEN OTHERS THEN
         SN_cod_retorno := 156;
         IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
            SV_mens_retorno := CV_error_no_clasif;
         END IF;
         LV_des_error   := 'PV_DATOS_ABONADO_PG.PV_VALBAJAATL_EMP_PR('||EO_CLIENTE.COD_CLIENTE ||') '||SQLERRM;
         SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_DATOS_ABONADO_PG.PV_VALBAJAATL_EMP_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

END PV_VALBAJAATL_EMP_PR;

--OCB

PROCEDURE PV_CANT_PERSONAL_EMPRESA_PR( EO_GA_NUM_PERSONAL IN OUT        pv_cliente_qt,
                                       SN_cod_retorno     OUT NOCOPY    ge_errores_td.cod_msgerror%TYPE,
                                       SV_mens_retorno    OUT NOCOPY    ge_errores_td.det_msgerror%TYPE,
                                       SN_num_evento      OUT NOCOPY    ge_errores_pg.evento)

IS
 /*
 <Documentación
   TipoDoc = "Procedure">>
    <Elemento
       Nombre = "PV_CANT_PERSONAL_EMPRESA_PR"
       Lenguaje="PL/SQL"
       Fecha="06-08-2008"
       Versión="La del package"
       Diseñador="Orlando Cabezas"
       Programador="Orlando Cabezas"
       Ambiente Desarrollo="BD">
       <Retorno>N/A</Retorno>>
       <Descripción></Descripción>>
       <Parámetros>
          <Entrada>
             <param nom="EO_GA_NUM_PERSONAL" Tipo="estructura"><param>>
          </Entrada>
          <Salida>
             <param nom="SN_cod_retorno" Tipo="NUMERICO">Codigo de Retorno</param>>
             <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>>
             <param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>>
          </Salida>
       </Parámetros>
    </Elemento>
 </Documentación>
 */

 LV_des_error    ge_errores_pg.DesEvent;
 LV_sSql      ge_errores_pg.vQuery;
 LN_COUNT     GA_EMPRESA.COD_CLIENTE%TYPE;

BEGIN
        SN_cod_retorno  := 0;
        SV_mens_retorno := 'OK';
        SN_num_evento  := 0;
        LN_COUNT:=0;
        EO_GA_NUM_PERSONAL.TOT_ABOSERV_ATLANT:=0;
        EO_GA_NUM_PERSONAL.TOT_PERSONAL:=0;
        EO_GA_NUM_PERSONAL.TOT_CORPORATIVO:=0;


        SELECT  COUNT(1)
                INTO LN_COUNT
        FROM GA_EMPRESA
        WHERE COD_CLIENTE  =EO_GA_NUM_PERSONAL.COD_CLIENTE ;

        IF (LN_COUNT > 0) THEN

                LV_sSql:= 'SELECT COUNT(1) ';
                LV_sSql:= LV_sSql || ' INTO EO_GA_NUM_PERSONAL.TOT_PERSONAL';
                LV_sSql:= LV_sSql || ' FROM  GA_NUMCEL_PERSONAL_TO ';
                LV_sSql:= LV_sSql || ' WHERE NUM_CEL_PERS IN (SELECT  NUM_CELULAR FROM  GA_ABOCEL ';
                LV_sSql:= LV_sSql ||  '                        WHERE  COD_CLIENTE =' ||EO_GA_NUM_PERSONAL.COD_CLIENTE;
                                LV_sSql:= LV_sSql ||  '                        AND COD_SITUACION NOT IN (BAA,BAP))';

                SELECT COUNT(1)
                INTO EO_GA_NUM_PERSONAL.TOT_PERSONAL
                FROM  GA_NUMCEL_PERSONAL_TO
                WHERE NUM_CEL_PERS IN (SELECT  NUM_CELULAR FROM  GA_ABOCEL
                                       WHERE  COD_CLIENTE =EO_GA_NUM_PERSONAL.COD_CLIENTE AND COD_SITUACION NOT IN ('BAA','BAP'));


               LV_sSql:='SELECT COUNT(1) ';
               LV_sSql:=LV_sSql || 'INTO EO_GA_NUM_PERSONAL.TOT_CORPORATIVO';
               LV_sSql:=LV_sSql || 'FROM  GA_NUMCEL_PERSONAL_TO ';
               LV_sSql:=LV_sSql || 'WHERE NUM_CEL_CORP IN (SELECT  NUM_CELULAR FROM  GA_ABOCEL ';
               LV_sSql:=LV_sSql || '                       WHERE  COD_CLIENTE =' ||EO_GA_NUM_PERSONAL.COD_CLIENTE ||' AND COD_SITUACION NOT IN (BAA,BAP))';
               LV_sSql:=LV_sSql || '                       AND COD_ESTADO<>4';

               SELECT COUNT(1)
               INTO EO_GA_NUM_PERSONAL.TOT_CORPORATIVO
               FROM  GA_NUMCEL_PERSONAL_TO
               WHERE NUM_CEL_CORP IN (SELECT  NUM_CELULAR FROM  GA_ABOCEL
                                      WHERE  COD_CLIENTE =EO_GA_NUM_PERSONAL.COD_CLIENTE AND COD_SITUACION NOT IN ('BAA','BAP'))
                                      AND COD_ESTADO<>4;

               LV_sSql:='SELECT COUNT(1)';
               LV_sSql:=LV_sSql || ' INTO   EO_GA_NUM_PERSONAL.TOT_ABOSERV_ATLANT';
               LV_sSql:=LV_sSql || ' FROM   GA_ABOCEL';
               LV_sSql:=LV_sSql || ' WHERE  COD_CLIENTE        = ' ||EO_GA_NUM_PERSONAL.COD_CLIENTE;
               LV_sSql:=LV_sSql || ' AND    COD_SITUACION NOT IN (BAA,BAP)';
               LV_sSql:=LV_sSql || ' AND    NUM_ABONADO       IN (SELECT A.NUM_ABONADO';
               LV_sSql:=LV_sSql || '                               FROM   GA_SERVSUPLABO A';
               LV_sSql:=LV_sSql || '                               WHERE  A.COD_SERVICIO IN ( SELECT cod_valor';
               LV_sSql:=LV_sSql || '                                                            FROM   GED_CODIGOS';
               LV_sSql:=LV_sSql || '                                                            WHERE  cod_modulo = GA';
               LV_sSql:=LV_sSql || '                                                            AND  nom_tabla = GAD_SERVSUP_PLAN';
               LV_sSql:=LV_sSql || '                                                            AND  nom_columna = COD_SERVICIO)';
               LV_sSql:=LV_sSql || '                                 )';

                SELECT COUNT(1)
                INTO   EO_GA_NUM_PERSONAL.TOT_ABOSERV_ATLANT
                FROM   GA_ABOCEL
                WHERE  COD_CLIENTE        = EO_GA_NUM_PERSONAL.COD_CLIENTE
                AND    COD_SITUACION NOT IN ('BAA','BAP')
                AND    NUM_ABONADO       IN (SELECT A.NUM_ABONADO
                                             FROM   GA_SERVSUPLABO A
                                             WHERE  A.COD_SERVICIO IN ( SELECT cod_valor
                                                                        FROM   GED_CODIGOS
                                                                        WHERE  cod_modulo = 'GA'
                                                                        AND  nom_tabla = 'GAD_SERVSUP_PLAN'
                                                                        AND  nom_columna = 'COD_SERVICIO')
                                             AND A.IND_ESTADO = 2
                                             );

        END IF;

EXCEPTION
                WHEN OTHERS THEN
                 SN_cod_retorno := 156;
                         IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                                SV_mens_retorno := CV_error_no_clasif;
                         END IF;

                         LV_des_error   := 'PV_DATOS_ABONADO_PG.PV_CANT_PERSONAL_EMPRESA_PR('||EO_GA_NUM_PERSONAL.COD_CLIENTE  ||') '||SQLERRM;
                         SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_DATOS_ABONADO_PG.PV_CANT_PERSONAL_EMPRESA_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

END PV_CANT_PERSONAL_EMPRESA_PR;
-------------------------------------------------------------------------------

PROCEDURE PV_INS_INTARCEL_ACCIONES_PR (EO_INTARCEL IN PV_ORDEN_SERVICIO_QT,
             SN_cod_retorno            OUT NOCOPY    ge_errores_td.cod_msgerror%TYPE,
             SV_mens_retorno           OUT NOCOPY    ge_errores_td.det_msgerror%TYPE,
             SN_num_evento             OUT NOCOPY   ge_errores_pg.evento)
IS
/*
 <Documentación
   TipoDoc = "Procedure">>
    <Elemento
       Nombre = "PV_INS_INTARCEL_ACCIONES_PR"
       Lenguaje="PL/SQL"
       Fecha="19-08-2008"
       Versión="La del package"
       Diseñador=""
       Programador=" "
       Ambiente Desarrollo="BD">
       <Retorno>N/A</Retorno>>
       <Descripción></Descripción>>
       <Parámetros>
          <Entrada>
             <param nom="EO_GA_INTARCEL" Tipo="Type">Estructura</param>>
          </Entrada>
          <Salida>
             <param nom="SN_cod_retorno" Tipo="NUMERICO">Codigo de Retorno</param>>
             <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>>
             <param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>>
          </Salida>
       </Parámetros>
    </Elemento>
 </Documentación>
*/

  LV_des_error    ge_errores_pg.DesEvent;
  LV_sSql         ge_errores_pg.vQuery;

  LD_FEC_DESDE        GA_INTARCEL_ACCIONES_TO.FEC_DESDE%TYPE;
  LN_IND_NUMERO           GA_INTARCEL_ACCIONES_TO.IND_NUMERO%TYPE;
  LN_COD_CLIENTE          GA_INTARCEL_ACCIONES_TO.COD_CLIENTE%TYPE;
  LN_NUM_ABONADO          GA_INTARCEL_ACCIONES_TO.NUM_ABONADO%TYPE;
  LN_COD_ACTABO           GA_INTARCEL_ACCIONES_TO.COD_ACTABO%TYPE;
  LN_COD_CLIENTE_NUE  GA_INTARCEL_ACCIONES_TO.COD_CLIENTE%TYPE;
  LN_COUNT                        NUMBER;
  LN_MAX_NUMERO           NUMBER;

  BEGIN
  sn_cod_retorno  := 0;
  sv_mens_retorno := NULL;
  sn_num_evento   := 0;
  LN_MAX_NUMERO   := 0;

  LN_COD_CLIENTE   := EO_INTARCEL.COD_CLIENTE;
  LN_NUM_ABONADO   := EO_INTARCEL.NUM_ABONADO;
  LN_COD_ACTABO    := EO_INTARCEL.COD_ACTABO;
  LN_COD_CLIENTE_NUE  := EO_INTARCEL.COD_CLIENTE_NUE;

IF (GE_FN_DEVVALPARAM('GA', 1, 'IND_TOL') = 'S') THEN

 LV_sSql:= ' SELECT IND_NUMERO, FEC_DESDE FROM GA_INTARCEL';
 LV_sSql:= LV_sSql|| ' WHERE COD_CLIENTE     = '||LN_COD_CLIENTE;
 LV_sSql:= LV_sSql|| ' AND NUM_ABONADO = '||LN_NUM_ABONADO||' AND TRUNC(SYSDATE) BETWEEN TRUNC(FEC_DESDE) AND FEC_HASTA';

   SELECT IND_NUMERO, FEC_DESDE
   INTO LN_IND_NUMERO, LD_FEC_DESDE
   FROM GA_INTARCEL
   WHERE COD_CLIENTE     = LN_COD_CLIENTE
         AND NUM_ABONADO = LN_NUM_ABONADO
         AND TRUNC(SYSDATE) BETWEEN TRUNC(FEC_DESDE) AND FEC_HASTA;


   IF LN_COD_ACTABO = 'AE' THEN
      LD_FEC_DESDE := SYSDATE;
   END IF;

   IF LN_COD_CLIENTE_NUE = 0 OR LN_COD_CLIENTE_NUE = NULL THEN
           LN_COD_CLIENTE := EO_INTARCEL.COD_CLIENTE;
   ELSE
           LN_COD_CLIENTE := EO_INTARCEL.COD_CLIENTE_NUE;
   END IF;

   IF LN_COD_ACTABO = 'BA' THEN

         LV_sSql:= ' SELECT COUNT(1) FROM GA_INTARCEL_ACCIONES_TO';
                 LV_sSql:= LV_sSql|| ' WHERE COD_CLIENTE = '||LN_COD_CLIENTE;
                 LV_sSql:= LV_sSql|| ' AND NUM_ABONADO = '||LN_NUM_ABONADO||' AND IND_NUMERO = '||LN_IND_NUMERO;
                 LV_sSql:= LV_sSql|| ' AND FEC_DESDE = '||LD_FEC_DESDE;

             SELECT COUNT(1)
                    INTO LN_COUNT
                 FROM GA_INTARCEL_ACCIONES_TO
                 WHERE COD_CLIENTE     = LN_COD_CLIENTE
                       AND NUM_ABONADO = LN_NUM_ABONADO
                       AND IND_NUMERO = LN_IND_NUMERO
                           AND FEC_DESDE = LD_FEC_DESDE;

                 IF LN_COUNT > 0 THEN

                 LV_sSql:= ' SELECT MAX(IND_NUMERO) FROM GA_INTARCEL_ACCIONES_TO';
                 LV_sSql:= LV_sSql|| ' WHERE COD_CLIENTE = '||LN_COD_CLIENTE;
                 LV_sSql:= LV_sSql|| ' AND NUM_ABONADO = '||LN_NUM_ABONADO||' AND IND_NUMERO = '||LN_IND_NUMERO;
                 LV_sSql:= LV_sSql|| ' AND FEC_DESDE = '||LD_FEC_DESDE;

                        SELECT MAX(IND_NUMERO)
                    INTO LN_MAX_NUMERO
                        FROM GA_INTARCEL_ACCIONES_TO
                        WHERE COD_CLIENTE     = LN_COD_CLIENTE
                       AND NUM_ABONADO = LN_NUM_ABONADO
                       AND IND_NUMERO = LN_IND_NUMERO
                           AND FEC_DESDE = LD_FEC_DESDE;

                           LN_IND_NUMERO := LN_MAX_NUMERO+1;

                 END IF;
   END IF;

  LV_sSql:= 'INSERT INTO GA_INTARCEL_ACCIONES_TO (';
  LV_sSql:=LV_sSql|| ' COD_CLIENTE,NUM_ABONADO,IND_NUMERO,FEC_DESDE,COD_ACTABO,NOM_USUARORA,FEC_INGRESO)';
  LV_sSql:=LV_sSql|| ' VALUES ('||LN_COD_CLIENTE||','||LN_NUM_ABONADO||','||LN_IND_NUMERO||',';
  LV_sSql:=LV_sSql|| LD_FEC_DESDE||','||LN_COD_ACTABO||',USER, SYSDATE)';

  INSERT INTO GA_INTARCEL_ACCIONES_TO (COD_CLIENTE,NUM_ABONADO,IND_NUMERO,FEC_DESDE,COD_ACTABO,NOM_USUARORA,FEC_INGRESO)
    VALUES (LN_COD_CLIENTE, LN_NUM_ABONADO, LN_IND_NUMERO, LD_FEC_DESDE, LN_COD_ACTABO, USER, SYSDATE);

 END IF;

 EXCEPTION
   WHEN OTHERS THEN
       SN_cod_retorno := 4;
       IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := CV_error_no_clasif;
       END IF;
       LV_des_error   := ' PV_INS_INTARCEL_ACCIONES_PR('||LN_COD_CLIENTE||','||LN_NUM_ABONADO||','||LN_COD_ACTABO||','||LN_COD_CLIENTE_NUE||'); '||SQLERRM;
       SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_DATOS_ABONADO_PG.PV_INS_INTARCEL_ACCIONES_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

END PV_INS_INTARCEL_ACCIONES_PR;
------------------------------------------------------------------------
PROCEDURE PV_OBTIENE_USUA_VENTA_PR( EN_NUM_VENTA    IN ga_abocel.num_venta%TYPE,
                                      SV_NOM_USUARORA OUT NOCOPY ga_abocel.nom_usuarora%TYPE,
                                    SN_COD_RETORNO      OUT NOCOPY  ge_errores_td.cod_msgerror%TYPE,
                                    SV_MENS_RETORNO     OUT NOCOPY  ge_errores_td.det_msgerror%TYPE,
                                    SN_NUM_EVENTO       OUT NOCOPY  ge_errores_pg.evento)
IS
/*
 <Documentación
   TipoDoc = "Procedure">>
    <Elemento
       Nombre = "PV_OBTIENE_USUA_VENTA_PR"
       Lenguaje="PL/SQL"
       Fecha="19-08-2008"
       Versión="La del package"
       Diseñador=""
       Programador=" "
       Ambiente Desarrollo="BD">
       <Retorno>N/A</Retorno>>
       <Descripción></Descripción>>
       <Parámetros>
          <Entrada>
             <param nom="NUM_VENTA" Tipo="Type">NUMERICO</param>>
          </Entrada>
          <Salida>
             <param nom="SV_NOM_USUARORA" Tipo="CARACTER">Nombre Usuario Oracle</param>>
             <param nom="SN_cod_retorno" Tipo="NUMERICO">Codigo de Retorno</param>>
             <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>>
             <param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>>
          </Salida>
       </Parámetros>
    </Elemento>
 </Documentación>
*/
LV_des_error    ge_errores_pg.DesEvent;
LV_sSql         ge_errores_pg.vQuery;
BEGIN

    LV_sSql := 'SELECT DISTINCT nom_usuarora';
    LV_sSql := LV_sSql || ' FROM ga_abocel';
    LV_sSql := LV_sSql || ' WHERE num_venta = '||EN_NUM_VENTA;

    SELECT DISTINCT nom_usuarora
    INTO SV_NOM_USUARORA
    FROM ga_abocel
    WHERE num_venta = EN_NUM_VENTA;

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        SN_cod_retorno := 761;
        IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
           SV_mens_retorno := CV_error_no_clasif;
        END IF;
        LV_des_error   := ' PV_OBTIENE_USUA_VENTA_PR('||EN_NUM_VENTA||'); '||SQLERRM;
        SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_DATOS_ABONADO_PG.PV_OBTIENE_USUA_VENTA_PR', LV_sSQL, SN_cod_retorno, LV_des_error );
    WHEN OTHERS THEN
        SN_cod_retorno := 156;
        IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
           SV_mens_retorno := CV_error_no_clasif;
        END IF;
        LV_des_error   := ' PV_OBTIENE_USUA_VENTA_PR('||EN_NUM_VENTA||'); '||SQLERRM;
        SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_DATOS_ABONADO_PG.PV_OBTIENE_USUA_VENTA_PR', LV_sSQL, SN_cod_retorno, LV_des_error );
END PV_OBTIENE_USUA_VENTA_PR;

--- RRG 17-02-2009 COL 78551
PROCEDURE PV_VALIDAOOSS_PENDBAJA_PR(LN_NUM_ABONADO GA_ABOCEL.NUM_ABONADO%TYPE,
                    LN_TIENE_ORDEN_BAJA                   OUT NOCOPY            NUMBER,
            SN_cod_retorno            OUT NOCOPY       ge_errores_td.cod_msgerror%TYPE,
            SV_mens_retorno           OUT NOCOPY       ge_errores_td.det_msgerror%TYPE,
            SN_num_evento             OUT NOCOPY    ge_errores_pg.evento)
IS
/*
 <Documentación
   TipoDoc = "Procedure">>
    <Elemento
       Nombre =  "PV_VALIDAOOSS_PENDBAJA"
           Lenguaje="PL/SQL"
       Fecha="17-02-2009"
       Versión="La del package"
       Diseñador="Roberto Rodriguez G."
       Programador="Roberto Rodriguez G."
       Ambiente Desarrollo="BD">
       <Retorno>N/A</Retorno>>
       <Descripción></Descripción>>

    </Elemento>
 </Documentación>
*/
  LV_des_error      ge_errores_pg.DesEvent;
  LV_sSql        ge_errores_pg.vQuery;
  LN_cod_estado     pv_erecorrido.cod_estado%TYPE;
  LN_num_intentos     pv_iorserv.num_intentos%TYPE;
  EO_GED_PARAMETROS      PV_GED_PARAMETROS_QT;

 BEGIN
  SN_cod_retorno  := 0;
  SV_mens_retorno := NULL;
  SN_num_evento  := 0;


  LV_sSql := 'SELECT COUNT(1) ';
  LV_sSql :=  LV_sSql ||  ' INTO LN_TIENE_ORDEN_BAJA';
  LV_sSql :=  LV_sSql || ' FROM PV_CAMCOM A, PV_IORSERV B';
  LV_sSql :=  LV_sSql || ' WHERE';
  LV_sSql :=  LV_sSql || ' B.NUM_OS= A.NUM_OS';
  LV_sSql :=  LV_sSql || ' AND STATUS NOT IN (ERROR,CANCELADA)';
  LV_sSql :=  LV_sSql || ' AND COD_ESTADO NOT IN (3,6)';
  LV_sSql :=  LV_sSql || ' AND A.NUM_ABONADO = LN_NUM_ABONADO ';
  LV_sSql :=  LV_sSql || ' AND b.COD_OS = 10323 ';
  LV_sSql :=  LV_sSql || ' AND A.FEC_VENCIMIENTO > SYSDATE;';



  SELECT COUNT(1)
  INTO LN_TIENE_ORDEN_BAJA
  FROM PV_CAMCOM A, PV_IORSERV B
  WHERE
  B.NUM_OS= A.NUM_OS
  AND STATUS NOT IN ('ERROR','CANCELADA')
  AND COD_ESTADO NOT IN (3,6)
  AND A.NUM_ABONADO = LN_NUM_ABONADO
  AND b.COD_OS = 10232
  AND trunc(A.FEC_VENCIMIENTO) >= trunc(SYSDATE);

 EXCEPTION
    WHEN NO_DATA_FOUND THEN
       SN_cod_retorno := 149;
       IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := CV_error_no_clasif;
       END IF;
    LV_des_error   := 'PV_VALIDAOOSS_PENDBAJA_PR('|| LN_NUM_ABONADO  ||'); '||SQLERRM;
       SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_DATOS_ABONADO_PG.PV_VALIDAOOSS_PENDBAJA_PR', LV_sSQL, SN_cod_retorno, LV_des_error );
 WHEN OTHERS THEN
       SN_cod_retorno := 156;
       IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := CV_error_no_clasif;
       END IF;
    LV_des_error   := 'PV_VALIDAOOSS_PENDBAJA_PR('|| LN_NUM_ABONADO  || '); '||SQLERRM;
       SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_DATOS_ABONADO_PG.PV_VALIDAOOSS_PENDBAJA_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

END PV_VALIDAOOSS_PENDBAJA_PR;

PROCEDURE PV_OBTIENE_CALIFICA_ABONADO_PR(EN_NUM_ABONADO  IN PV_CALIFICA_CELULAR_TO.NUM_ABONADO%TYPE,
                                         EN_NUM_CELULAR  IN PV_CALIFICA_CELULAR_TO.NUM_CELULAR%TYPE,
                                         SV_COD_CALIFICA OUT NOCOPY   PV_CALIFICA_CELULAR_TO.COD_CALIFICA%TYPE,
                                         SN_cod_retorno  OUT NOCOPY   ge_errores_td.cod_msgerror%TYPE,
                                         SV_mens_retorno OUT NOCOPY   ge_errores_td.det_msgerror%TYPE,
                                         SN_num_evento   OUT NOCOPY   ge_errores_pg.evento)
IS
/*
 <Documentación
   TipoDoc = "Procedure">>
    <Elemento
       Nombre =  "PV_OBTIENE_CALIFICA_ABONADO_PR
           Lenguaje="PL/SQL"
       Fecha="01-06-2010
       Versión="La del package"
       Diseñador="Elizabeth Vera"
       Programador="Elizabeth Vera"
       Ambiente Desarrollo="BD">
       <Retorno>N/A</Retorno>>
       <Descripción>Obtiene calificacion para abonado prepago</Descripción>>
       <Parámetros>
          <Entrada>
             <param nom="EN_NUM_ABONADO" Tipo="Type">NUMERICO</param>>
             <param nom="EN_NUM_CELULAR" Tipo="Type">NUMERICO</param>>
          </Entrada>
          <Salida>
             <param nom="SV_COD_CALIFICA" Tipo="CARACTER">Codigo calificacion abonado</param>>
             <param nom="SN_cod_retorno" Tipo="NUMERICO">Codigo de Retorno</param>>
             <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>>
             <param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>>
          </Salida>
       </Parámetros>
    </Elemento>
 </Documentación>
*/
  LV_des_error   ge_errores_pg.DesEvent;
  LV_sSql        ge_errores_pg.vQuery;

 BEGIN
        SN_cod_retorno  := 0;
        SV_mens_retorno := NULL;
        SN_num_evento  := 0;
        SV_COD_CALIFICA := '';

        LV_sSql := 'SELECT COD_CALIFICA ';
        LV_sSql :=  LV_sSql ||  ' FROM PV_CALIFICA_CELULAR_TO';
        LV_sSql :=  LV_sSql ||  ' WHERE NUM_ABONADO = '|| EN_NUM_ABONADO;
        lV_sSql :=  LV_sSql ||  ' AND   NUM_CELULAR = '|| EN_NUM_CELULAR;
        lV_sSql :=  LV_sSql ||  ' AND   VIGENCIA    = 1';

        SELECT COD_CALIFICA INTO SV_COD_CALIFICA
        FROM PV_CALIFICA_CELULAR_TO
        WHERE NUM_ABONADO =  EN_NUM_ABONADO
        AND   NUM_CELULAR =  EN_NUM_CELULAR
        AND   VIGENCIA    = 1;


 EXCEPTION
    WHEN NO_DATA_FOUND THEN
      SV_COD_CALIFICA := '';
    WHEN OTHERS THEN
       SN_cod_retorno := 156;
       IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := CV_error_no_clasif;
       END IF;
       LV_des_error   := 'PV_OBTIENE_CALIFICA_ABONADO_PR('|| EN_NUM_ABONADO || ',' || EN_NUM_CELULAR ||'); '||SQLERRM;
       SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_DATOS_ABONADO_PG.PV_OBTIENE_CALIFICA_ABONADO_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

END PV_OBTIENE_CALIFICA_ABONADO_PR;

PROCEDURE PV_CERRAR_VIGENCIA_PRECAL_PR(EN_NUM_ABONADO  IN PV_CALIFICA_CELULAR_TO.NUM_ABONADO%TYPE,
                                       EN_NUM_CELULAR  IN PV_CALIFICA_CELULAR_TO.NUM_CELULAR%TYPE,
                                       EN_ACCION       IN PV_CALIFICA_CELULAR_TH.COD_ACCIONCAL%TYPE,
                                       EV_USER         IN PV_CALIFICA_CELULAR_TH.NOM_USUARIO%TYPE,
                                       SN_cod_retorno  OUT NOCOPY   ge_errores_td.cod_msgerror%TYPE,
                                       SV_mens_retorno OUT NOCOPY   ge_errores_td.det_msgerror%TYPE,
                                       SN_num_evento   OUT NOCOPY   ge_errores_pg.evento)
IS
/*
 <Documentación
   TipoDoc = "Procedure">>
    <Elemento
       Nombre =  "PV_CERRAR_VIGENCIA_PRECAL_PR
           Lenguaje="PL/SQL"
       Fecha="04-06-2010
       Versión="La del package"
       Diseñador="Elizabeth Vera"
       Programador="Elizabeth Vera"
       Ambiente Desarrollo="BD">
       <Retorno>N/A</Retorno>>
       <Descripción>Cierra vigencia de precalificacion abonado</Descripción>>
       <Parámetros>
          <Entrada>
             <param nom="EN_NUM_ABONADO" Tipo="Type">NUMERICO</param>>
             <param nom="EN_NUM_CELULAR" Tipo="Type">NUMERICO</param>>
             <param nom="EN_ACCION" Tipo="Type">NUMERICO</param>>
             <param nom="EV_USER" Tipo="Type">CARACTER</param>>
          </Entrada>
          <Salida>
             <param nom="SN_cod_retorno" Tipo="NUMERICO">Codigo de Retorno</param>>
             <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>>
             <param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>>
          </Salida>
       </Parámetros>
    </Elemento>
 </Documentación>
*/
  LV_des_error   ge_errores_pg.DesEvent;
  LV_sSql        ge_errores_pg.vQuery;

 BEGIN
        SN_cod_retorno  := 0;
        SV_mens_retorno := NULL;
        SN_num_evento  := 0;


        LV_sSql := 'INSERT INTO PV_CALIFICA_CELULAR_TH ';
        LV_sSql :=  LV_sSql ||  ' COD_CALIFICA, NUM_CELULAR, NUM_ABONADO, FEC_HISTORICO, COD_VENDEDOR,';
        LV_sSql :=  LV_sSql ||  ' VIGENCIA, NOM_USUARIO, COD_ACCIONCAL, FECHA_CARGA)';
        lV_sSql :=  LV_sSql ||  '   SELECT COD_CALIFICA, NUM_CELULAR, NUM_ABONADO, SYSDATE, COD_VENDEDOR,';
        lV_sSql :=  LV_sSql ||  '   VIGENCIA, '||EV_USER||','|| EN_ACCION||', FECHA_CARGA';
        lV_sSql :=  LV_sSql ||  '   FROM PV_CALIFICA_CELULAR_TO';
        lV_sSql :=  LV_sSql ||  '   WHERE NUM_ABONADO='||EN_NUM_ABONADO||' AND '|| 'NUM_CELULAR='||EN_NUM_CELULAR;

        --pasa a historico
        INSERT INTO PV_CALIFICA_CELULAR_TH
        (COD_CALIFICA, NUM_CELULAR, NUM_ABONADO, FEC_HISTORICO, COD_VENDEDOR,
          VIGENCIA, NOM_USUARIO, COD_ACCIONCAL, FECHA_CARGA)
        SELECT COD_CALIFICA, NUM_CELULAR, NUM_ABONADO, SYSDATE, COD_VENDEDOR,
         0, EV_USER, EN_ACCION, FECHA_CARGA
        FROM PV_CALIFICA_CELULAR_TO
        WHERE NUM_ABONADO=EN_NUM_ABONADO AND NUM_CELULAR=EN_NUM_CELULAR;

        LV_sSql := 'DELETE FROM PV_CALIFICA_CELULAR_TO ';
        LV_sSql :=  LV_sSql ||  ' WHERE NUM_ABONADO='||EN_NUM_ABONADO||' AND NUM_CELULAR='||EN_NUM_CELULAR;

        DELETE FROM PV_CALIFICA_CELULAR_TO
        WHERE NUM_ABONADO=EN_NUM_ABONADO AND NUM_CELULAR=EN_NUM_CELULAR;

 EXCEPTION
    WHEN NO_DATA_FOUND THEN
       SN_cod_retorno := 1;
       IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := CV_error_no_clasif;
       END IF;
       LV_des_error   := 'PV_CERRAR_VIGENCIA_PRECAL_PR('|| EN_NUM_ABONADO || ',' || EN_NUM_CELULAR ||'); '||SQLERRM;
       SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_DATOS_ABONADO_PG.PV_CERRAR_VIGENCIA_PRECAL_PR', LV_sSQL, SN_cod_retorno, LV_des_error );
    WHEN OTHERS THEN
       SN_cod_retorno := 156;
       IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := CV_error_no_clasif;
       END IF;
       LV_des_error   := 'PV_CERRAR_VIGENCIA_PRECAL_PR('|| EN_NUM_ABONADO || ',' || EN_NUM_CELULAR ||'); '||SQLERRM;
       SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_DATOS_ABONADO_PG.PV_CERRAR_VIGENCIA_PRECAL_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

END PV_CERRAR_VIGENCIA_PRECAL_PR;

PROCEDURE PV_ACTUALIZA_CADENASALDO_PR(EN_NUM_ABONADO  IN GA_DATABONADO_TO.NUM_ABONADO%TYPE,
                                      EV_CADENA       IN GA_DATABONADO_TO.CADENA%TYPE,
                                      SN_cod_retorno  OUT NOCOPY   ge_errores_td.cod_msgerror%TYPE,
                                      SV_mens_retorno OUT NOCOPY   ge_errores_td.det_msgerror%TYPE,
                                      SN_num_evento   OUT NOCOPY   ge_errores_pg.evento)
IS
/*
 <Documentación
   TipoDoc = "Procedure">>
    <Elemento
       Nombre =  "PV_ACTUALIZA_CADENASALDO_PR"
           Lenguaje="PL/SQL"
       Fecha="04-06-2010
       Versión="La del package"
       Diseñador="Elizabeth Vera"
       Programador="Elizabeth Vera"
       Ambiente Desarrollo="BD">
       <Retorno>N/A</Retorno>>
       <Descripción>Actualiza cadena con informacion del saldo de abonado prepago</Descripción>>
       <Parámetros>
          <Entrada>
             <param nom="EN_NUM_ABONADO" Tipo="Type">NUMERICO</param>>
             <param nom="EV_CADENA" Tipo="Type">CARACTER</param>>
          </Entrada>
          <Salida>
             <param nom="SN_cod_retorno" Tipo="NUMERICO">Codigo de Retorno</param>>
             <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>>
             <param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>>
          </Salida>
       </Parámetros>
    </Elemento>
 </Documentación>
*/
  LV_des_error   ge_errores_pg.DesEvent;
  LV_sSql        ge_errores_pg.vQuery;
  ln_cantidad    number(1);

 BEGIN
        SN_cod_retorno  := 0;
        SV_mens_retorno := NULL;
        SN_num_evento  := 0;

        ln_cantidad:=0;


        select  count(1) into ln_cantidad
        from  GA_DATABONADO_TO
        WHERE NUM_ABONADO = EN_NUM_ABONADO;

        if ln_cantidad =0 then
               LV_sSql := 'insert into GA_DATABONADO_TO(NUM_ABONADO,IND_RENOVA,MAC_ADDRESS,NUM_FAX,COD_CALIFICACION,CADENA)';
               LV_sSql := LV_sSql || 'values ('||EN_NUM_ABONADO||',0,null,0,null,null);';

               insert into GA_DATABONADO_TO(NUM_ABONADO,IND_RENOVA,MAC_ADDRESS,NUM_FAX,COD_CALIFICACION,CADENA)
               values (EN_NUM_ABONADO,0,null,0,null,null);
        end if;

        LV_sSql := 'UPDATE GA_DATABONADO_TO SET CADENA ='||EV_CADENA||' WHERE NUM_ABONADO = '||EN_NUM_ABONADO;

        UPDATE GA_DATABONADO_TO
        SET CADENA = EV_CADENA
        WHERE NUM_ABONADO = EN_NUM_ABONADO;

 EXCEPTION
    WHEN NO_DATA_FOUND THEN
       SN_cod_retorno := 1;
       IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := CV_error_no_clasif;
       END IF;
       LV_des_error   := 'PV_ACTUALIZA_CADENASALDO_PR('|| EN_NUM_ABONADO || '); '||SQLERRM;
       SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_DATOS_ABONADO_PG.PV_CERRAR_VIGENCIA_PRECAL_PR', LV_sSQL, SN_cod_retorno, LV_des_error );
    WHEN OTHERS THEN
       SN_cod_retorno := 156;
       IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := CV_error_no_clasif;
       END IF;
       LV_des_error   := 'PV_ACTUALIZA_CADENASALDO_PR('|| EN_NUM_ABONADO || '); '||SQLERRM;
       SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_DATOS_ABONADO_PG.PV_CERRAR_VIGENCIA_PRECAL_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

END PV_ACTUALIZA_CADENASALDO_PR;





PROCEDURE PV_GENERA_SOLICMIGRAR_PR(     EN_COD_CLIENTE      IN  GA_ABOCEL.COD_CLIENTE%TYPE,
                                         EV_COD_PLANTARIF    IN  GA_ABOCEL.COD_PLANTARIF%TYPE,
                                         EV_NUM_CELULAR      IN  GA_ABOCEL.NUM_CELULAR%TYPE,
                                         EV_USER             IN  GA_ABOCEL.NOM_USUARORA%TYPE,
                                         EV_SERIE            IN  AL_SERIES.NUM_SERIE%TYPE,
                                         EV_PROCEDENCIA      IN  GA_ABOCEL.IND_PROCEQUI%TYPE,
                                         EV_SALDO            IN  GA_DATABONADO_TO.CADENA %TYPE,
                                         SN_cod_retorno      OUT NOCOPY   ge_errores_td.cod_msgerror%TYPE,
                                         SV_mens_retorno     OUT NOCOPY   ge_errores_td.det_msgerror%TYPE,
                                         SN_num_evento       OUT NOCOPY   ge_errores_pg.evento)
IS
/*
 <Documentación
   TipoDoc = "Procedure">>
    <Elemento
       Nombre =  "PV_GENERA_SOLICMIGRAR_PR"
           Lenguaje="PL/SQL"
       Fecha="26-10-2010
       Versión="La del package"
       Diseñador="Orlando C"
       Programador="Orlando C"
       Ambiente Desarrollo="BD">
       <Retorno>N/A</Retorno>>
       <Descripción>Genera solicitud de migracion</Descripción>>
       <Parámetros>
          <Entrada>
             <param nom="EN_COD_CLIENTE"  Tipo="Type">NUMERICO</param>>
             <param nom="EV_COD_PLANTARIF" Tipo="Type">CARACTER</param>>
             <param nom="EV_NUM_CELULAR" Tipo="Type">numerico</param>>
             <param nom="EV_USER" Tipo="Type">CARACTER</param>>
             <param nom="EV_PROCEDENCIA Tipo="Type">CARACTER</param>>

          </Entrada>
          <Salida>
             <param nom="SN_NUM_VENTA" Tipo="NUMERICO">venta</param>>
             <param nom="SN_NUM_ABONADO"  Tipo="numerico">abonado</param>>
             <param nom="SN_cod_retorno" Tipo="NUMERICO">Codigo de Retorno</param>>
             <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>>
             <param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>>
          </Salida>
       </Parámetros>
    </Elemento>
 </Documentación>
--*/
  LV_des_error   ge_errores_pg.DesEvent;
  LV_sSql        ge_errores_pg.vQuery;
  LN_NUM_ABONADO ga_abocel.num_abonado%type;
  LN_CANTIDAD    NUMBER(5); --INC 157087 JRCH 31-12-2010

 BEGIN
        SN_cod_retorno  := 0;
        SV_mens_retorno := NULL;
        SN_num_evento  := 0;

        LV_sSql := 'select num_abonado into LN_NUM_ABONADO  from ga_aboamist where num_celular ='|| EV_NUM_CELULAR ||' and cod_situacion=AAA' ;

        select num_abonado
        into LN_NUM_ABONADO
        from ga_aboamist
        where num_celular = EV_NUM_CELULAR
        and cod_situacion='AAA';
        --and cod_cliente   = EN_COD_CLIENTE;


        --INI INC 157087 JRCH 31-12-2010
        LN_CANTIDAD:=0;

        LV_sSql := ' select  count(1)      INTO LN_CANTIDAD';
        LV_sSql := LV_sSql || 'from PV_INTERFAZ_MIGRA_TO ';
        LV_sSql := LV_sSql || 'where num_abonado ='||LN_NUM_ABONADO;
        LV_sSql := LV_sSql || 'and cod_actabo    = MI';
        LV_sSql := LV_sSql || 'AND COD_ESTADO IN (1,2)';


        select  count(1)
        INTO LN_CANTIDAD
        from PV_INTERFAZ_MIGRA_TO
        where num_abonado =LN_NUM_ABONADO
        and cod_actabo    = 'MI'
        AND COD_ESTADO IN (1,2);


        IF LN_CANTIDAD = 0 THEN

        --FIN INC 157087 JRCH 31-12-2010

            LV_sSql := 'insert into PV_INTERFAZ_MIGRA_TO (';
            LV_sSql := LV_sSql || 'NUM_CELULAR   ,         NUM_ABONADO   , ';
            LV_sSql := LV_sSql || 'COD_CLIENTE   ,         COD_PLANTARIF , ';
            LV_sSql := LV_sSql || 'IND_PROCEQUI  ,         NOM_USUARIO   , ';
            LV_sSql := LV_sSql || 'NUM_SERIE     ,         FEC_EJECUCION , ';
            LV_sSql := LV_sSql || 'COD_ESTADO    ,         COD_ACTABO    , ';
            LV_sSql := LV_sSql || 'FEC_PROCESO   ,         NUM_OS        , ';
            LV_sSql := LV_sSql || 'COD_OS        ,         NUM_EVENTO    , ';
            LV_sSql := LV_sSql || 'DESCRIPCION   ,IMP_SALDO)';
            LV_sSql := LV_sSql || 'values( ';
            LV_sSql := LV_sSql || EV_NUM_CELULAR ||','||LN_NUM_ABONADO   ||',';
            LV_sSql := LV_sSql || EN_COD_CLIENTE||','||EV_COD_PLANTARIF ||',';
            LV_sSql := LV_sSql || EV_PROCEDENCIA||','||EV_USER         || ',';
            LV_sSql := LV_sSql || EV_SERIE      ||' ,SYSDATE'||',';
            LV_sSql := LV_sSql || '1            , MI            ,';
            LV_sSql := LV_sSql || 'NULL           , NULL            ,';
            LV_sSql := LV_sSql || '10541  , NULL ,NULL ,'||EV_SALDO||' )';


            insert into PV_INTERFAZ_MIGRA_TO (
            NUM_CELULAR   ,         NUM_ABONADO   ,
            COD_CLIENTE   ,         COD_PLANTARIF ,
            IND_PROCEQUI  ,         NOM_USUARIO   ,
            NUM_SERIE     ,         FEC_EJECUCION ,
            COD_ESTADO    ,         COD_ACTABO    ,
            FEC_PROCESO   ,         NUM_OS        ,
            COD_OS        ,         NUM_EVENTO    ,
            DESCRIPCION   ,         IMP_SALDO)
            values(
            EV_NUM_CELULAR ,LN_NUM_ABONADO   ,
            EN_COD_CLIENTE ,EV_COD_PLANTARIF ,
            EV_PROCEDENCIA ,EV_USER          ,
            EV_SERIE       ,sysdate          ,
            '1'            , 'MI'            ,
            NULL           , NULL            ,
            '10541'        , NULL            ,
            NULL           , EV_SALDO);

        --INI INC 157087 JRCH 31-12-2010
        ELSE

         SN_num_evento   :=0;
         SN_cod_retorno := 1;
         --IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := 'Abonado ya se encuentra Inscrito para procesamiento en la tabla pv_interfaz_migra_to';
         --END IF;
         LV_des_error   := 'PV_GENERA_SOLICMIGRAR_PR('|| LN_NUM_ABONADO || '); '||SQLERRM;
         SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_DATOS_ABONADO_PG.PV_GENERA_SOLICMIGRAR_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

        END IF;
        --FIN INC 157087 JRCH 31-12-2010


 EXCEPTION
    WHEN NO_DATA_FOUND THEN
       SN_num_evento   :=0;
       SN_cod_retorno := 1;
       IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := CV_error_no_clasif;
       END IF;
       LV_des_error   := 'PV_GENERA_SOLICMIGRAR_PR('|| LN_NUM_ABONADO || '); '||SQLERRM;
       SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_DATOS_ABONADO_PG.PV_GENERA_SOLICMIGRAR_PR', LV_sSQL, SN_cod_retorno, LV_des_error );
    WHEN OTHERS THEN
       SN_num_evento   :=0;
       SN_cod_retorno := 156;
       IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := CV_error_no_clasif;
       END IF;
       LV_des_error   := 'PV_GENERA_SOLICMIGRAR_PR('|| LN_NUM_ABONADO || '); '||SQLERRM;
       SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_DATOS_ABONADO_PG.PV_GENERA_SOLICMIGRAR_PR', LV_sSQL, SN_cod_retorno, LV_des_error );


END PV_GENERA_SOLICMIGRAR_PR;





PROCEDURE PV_MIGRAR_MASIVO_PR            (  EV_COD_ACTABO    IN  GA_ACTABO.COD_ACTABO%TYPE,
                                         SN_cod_retorno      OUT NOCOPY   ge_errores_td.cod_msgerror%TYPE,
                                         SV_mens_retorno     OUT NOCOPY   ge_errores_td.det_msgerror%TYPE,
                                         SN_num_evento       OUT NOCOPY   ge_errores_pg.evento)
IS
/*
 <Documentación
   TipoDoc = "Procedure">>
    <Elemento
       Nombre =  "PV_MIGRAR_MASIVO_PR"
           Lenguaje="PL/SQL"
       Fecha="26-10-2010
       Versión="La del package"
       Diseñador="Orlando C"
       Programador="Orlando C"
       Ambiente Desarrollo="BD">
       <Retorno>N/A</Retorno>>
       <Descripción>Genera  migracion</Descripción>>
       <Parámetros>
          <Entrada>
             <param nom="EN_COD_ACTABO"  Tipo="Type">CARATER</param>>
          </Entrada>
          <Salida>
             <param nom="SN_NUM_VENTA" Tipo="NUMERICO">venta</param>>
             <param nom="SN_NUM_ABONADO"  Tipo="numerico">abonado</param>>
             <param nom="SN_cod_retorno" Tipo="NUMERICO">Codigo de Retorno</param>>
             <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>>
             <param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>>
          </Salida>
       </Parámetros>
    </Elemento>
 </Documentación>
*/

  CURSOR C1 IS
   SELECT  NUM_CELULAR   ,         NUM_ABONADO   ,
           COD_CLIENTE   ,         COD_PLANTARIF ,
           IND_PROCEQUI  ,         NOM_USUARIO   ,
           NUM_SERIE     ,         FEC_EJECUCION ,
           COD_ESTADO    ,         COD_ACTABO    ,
           FEC_PROCESO   ,         NUM_OS        ,
           COD_OS        ,         NUM_EVENTO    ,
           DESCRIPCION   ,         IMP_SALDO
   FROM PV_INTERFAZ_MIGRA_TO
   WHERE COD_ESTADO = 1
   AND COD_ACTABO = EV_COD_ACTABO ;


    LV_des_error   ge_errores_pg.DesEvent;
    LV_sSql        ge_errores_pg.vQuery;
    LN_NUM_ABONADO ga_abocel.num_abonado%type;
    V_NUM_CELULAR   PV_INTERFAZ_MIGRA_TO.NUM_CELULAR%TYPE;
    V_NUM_ABONADO   PV_INTERFAZ_MIGRA_TO.NUM_ABONADO%TYPE;
    V_COD_CLIENTE   PV_INTERFAZ_MIGRA_TO.COD_CLIENTE%TYPE;
    V_COD_PLANTARIF PV_INTERFAZ_MIGRA_TO.COD_PLANTARIF%TYPE;
    V_IND_PROCEQUI  PV_INTERFAZ_MIGRA_TO.IND_PROCEQUI%TYPE;
    V_NOM_USUARIO   PV_INTERFAZ_MIGRA_TO.NOM_USUARIO%TYPE;
    V_NUM_SERIE     PV_INTERFAZ_MIGRA_TO.NUM_SERIE%TYPE;
    V_FEC_EJECUCION PV_INTERFAZ_MIGRA_TO.FEC_EJECUCION%TYPE;
    V_COD_ESTADO    PV_INTERFAZ_MIGRA_TO.COD_ESTADO%TYPE;
    V_COD_ACTABO    PV_INTERFAZ_MIGRA_TO.COD_ACTABO%TYPE;
    V_FEC_PROCESO   PV_INTERFAZ_MIGRA_TO.FEC_PROCESO%TYPE;
    V_NUM_OS        PV_INTERFAZ_MIGRA_TO.NUM_OS%TYPE;
    V_COD_OS        PV_INTERFAZ_MIGRA_TO.COD_OS%TYPE;
    V_NUM_EVENTO    PV_INTERFAZ_MIGRA_TO.NUM_EVENTO%TYPE;
    V_DESCRIPCION   PV_INTERFAZ_MIGRA_TO.DESCRIPCION%TYPE;
    V_SALDO         PV_INTERFAZ_MIGRA_TO.IMP_SALDO%TYPE;
    SN_NUM_OS       CI_ORSERV.NUM_OS%TYPE;

    V_NUM_TRANSACCION      GA_TRANSACABO.NUM_TRANSACCION%TYPE;
    V_COD_RETORNO          GA_TRANSACABO.COD_RETORNO%TYPE;


begin

   SN_cod_retorno  := 0;
   SV_mens_retorno := NULL;
   SN_num_evento  := 0;

   OPEN C1;
   LOOP
      FETCH C1 INTO V_NUM_CELULAR   ,  V_NUM_ABONADO   ,
                    V_COD_CLIENTE   ,  V_COD_PLANTARIF ,
                    V_IND_PROCEQUI  ,  V_NOM_USUARIO   ,
                    V_NUM_SERIE     ,  V_FEC_EJECUCION ,
                    V_COD_ESTADO    ,  V_COD_ACTABO    ,
                    V_FEC_PROCESO   ,  V_NUM_OS        ,
                    V_COD_OS        ,  V_NUM_EVENTO    ,
                    V_DESCRIPCION   ,  V_SALDO;



          EXIT WHEN C1%NOTFOUND;



                        PV_DATOS_ABONADO_PG.PV_MIGRAR_COMERCIAL_PR  (  V_COD_ACTABO   ,
                                                                       V_NUM_ABONADO  ,
                                                                       V_SALDO    ,
                                                                       SN_NUM_OS      ,
                                                                       SN_cod_retorno ,
                                                                       SV_mens_retorno,
                                                                       SN_num_evento  );

               BEGIN


                        IF SN_cod_retorno = 0 THEN

                            LV_sSql := ' UPDATE PV_INTERFAZ_MIGRA_TO';
                            LV_sSql :=LV_sSql || ' SET COD_ESTADO = 2,';
                            LV_sSql :=LV_sSql || '    NUM_OS     = '||SN_NUM_OS||',';
                            LV_sSql :=LV_sSql || '    NUM_EVENTO = 0,';
                            LV_sSql :=LV_sSql || '    FEC_PROCESO= SYSDATE,';
                            LV_sSql :=LV_sSql || ' DESCRIPCION =MIGRACION CORRECTA';
                            LV_sSql :=LV_sSql || ' WHERE NUM_ABONADO   = '||V_NUM_ABONADO;
                            LV_sSql :=LV_sSql || ' AND FEC_EJECUCION = '||V_FEC_EJECUCION;
                            LV_sSql :=LV_sSql || ' AND COD_ACTABO    = '||V_COD_ACTABO;


                            UPDATE PV_INTERFAZ_MIGRA_TO
                            SET COD_ESTADO = 2,
                                NUM_OS     = SN_NUM_OS,
                                NUM_EVENTO = 0,
                                FEC_PROCESO= SYSDATE,
                                DESCRIPCION ='MIGRACION CORRECTA'
                            WHERE NUM_ABONADO   = V_NUM_ABONADO
                                   AND FEC_EJECUCION = V_FEC_EJECUCION
                                   AND COD_ACTABO    = V_COD_ACTABO;


                        ELSE
                            ROLLBACK;

                            LV_sSql :=' UPDATE PV_INTERFAZ_MIGRA_TO';
                            LV_sSql :=LV_sSql || '       SET COD_ESTADO = 3,';
                            LV_sSql :=LV_sSql || 'NUM_EVENTO = '|| SN_num_evento||',';
                            LV_sSql :=LV_sSql || '       FEC_PROCESO= SYSDATE,';
                            LV_sSql :=LV_sSql || '       DESCRIPCION ='||SV_mens_retorno;
                            LV_sSql :=LV_sSql || '     WHERE NUM_ABONADO   = '||V_NUM_ABONADO;
                            LV_sSql :=LV_sSql || '       AND FEC_EJECUCION = '||V_FEC_EJECUCION;
                            LV_sSql :=LV_sSql || '       AND COD_ACTABO    = '||V_COD_ACTABO;


                            UPDATE PV_INTERFAZ_MIGRA_TO
                                   SET COD_ESTADO = 3,
                                   NUM_EVENTO =  SN_num_evento,
                                   FEC_PROCESO= SYSDATE,
                                   DESCRIPCION =SV_mens_retorno
                                 WHERE NUM_ABONADO   = V_NUM_ABONADO
                                   AND FEC_EJECUCION = V_FEC_EJECUCION
                                   AND COD_ACTABO    = V_COD_ACTABO;

                        END IF;


                        COMMIT;
                EXCEPTION
                              WHEN NO_DATA_FOUND THEN
                                 NULL;
                              WHEN OTHERS THEN
                                 NULL;
                END;

   END LOOP;
   CLOSE C1;

 EXCEPTION
    WHEN NO_DATA_FOUND THEN
       SN_num_evento   :=0;
       SN_cod_retorno := 1;
       IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := CV_error_no_clasif;
       END IF;
       LV_des_error   := 'PV_MIGRAR_MASIVO_PR   ('|| LN_NUM_ABONADO || '); '||SQLERRM;
       SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_DATOS_ABONADO_PG.PV_MIGRAR_MASIVO_PR', LV_sSQL, SN_cod_retorno, LV_des_error );
    WHEN OTHERS THEN
       SN_cod_retorno := 156;
       SN_num_evento   :=0;
       IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := CV_error_no_clasif;
       END IF;
       LV_des_error   := 'PV_MIGRAR_MASIVO_PR   ('|| LN_NUM_ABONADO || '); '||SQLERRM;
       SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_DATOS_ABONADO_PG.PV_MIGRAR_MASIVO_PR', LV_sSQL, SN_cod_retorno, LV_des_error );



END PV_MIGRAR_MASIVO_PR;




PROCEDURE PV_MIGRAR_COMERCIAL_PR      (  EV_COD_ACTABO       IN           GA_ACTABO.COD_ACTABO%TYPE,
                                         EN_NUM_ABONADO      IN           GA_ABOCEL.NUM_ABONADO%TYPE,
                                         EV_SALDO            IN  GA_DATABONADO_TO.CADENA%TYPE,
                                         SN_NUM_OS           OUT NOCOPY   CI_ORSERV.NUM_OS%TYPE,
                                         SN_cod_retorno      OUT NOCOPY   ge_errores_td.cod_msgerror%TYPE,
                                         SV_mens_retorno     OUT NOCOPY   ge_errores_td.det_msgerror%TYPE,
                                         SN_num_evento       OUT NOCOPY   ge_errores_pg.evento)
IS
/*
 <Documentación
   TipoDoc = "Procedure">>
    <Elemento
       Nombre =  "PV_MIGRAR_COMERCIAL_PR
           Lenguaje="PL/SQL"
       Fecha="26-10-2010
       Versión="La del package"
       Diseñador="Orlando C"
       Programador="Orlando C"
       Ambiente Desarrollo="BD">
       <Retorno>N/A</Retorno>>
       <Descripción>Genera  migracion</Descripción>>
       <Parámetros>
          <Entrada>
             <param nom="EN_COD_ACTABO"  Tipo="Type">CARATER</param>>
          </Entrada>
          <Salida>
             <param nom="SN_NUM_VENTA" Tipo="NUMERICO">venta</param>>
             <param nom="SN_NUM_ABONADO"  Tipo="numerico">abonado</param>>
             <param nom="SN_cod_retorno" Tipo="NUMERICO">Codigo de Retorno</param>>
             <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>>
             <param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>>
          </Salida>
       </Parámetros>
    </Elemento>
 </Documentación>
*/
    LV_des_error   ge_errores_pg.DesEvent;
    LV_sSql        ge_errores_pg.vQuery;
    TYPE refCursor IS REF CURSOR;
    SV_record refcursor;

    LN_NUM_ABONADO          ga_abocel.num_abonado%type;
    LN_NUM_ABONADO_AUX      ga_abocel.num_abonado%type;
    V_NUM_CELULAR           PV_INTERFAZ_MIGRA_TO.NUM_CELULAR%TYPE;
    V_NUM_ABONADO           PV_INTERFAZ_MIGRA_TO.NUM_ABONADO%TYPE;
    V_COD_CLIENTE           PV_INTERFAZ_MIGRA_TO.COD_CLIENTE%TYPE;
    V_COD_PLANTARIF         PV_INTERFAZ_MIGRA_TO.COD_PLANTARIF%TYPE;
    V_IND_PROCEQUI          PV_INTERFAZ_MIGRA_TO.IND_PROCEQUI%TYPE;
    V_NOM_USUARIO           PV_INTERFAZ_MIGRA_TO.NOM_USUARIO%TYPE;
    V_NUM_SERIE             PV_INTERFAZ_MIGRA_TO.NUM_SERIE%TYPE;
    V_FEC_EJECUCION         PV_INTERFAZ_MIGRA_TO.FEC_EJECUCION%TYPE;
    V_COD_ESTADO            PV_INTERFAZ_MIGRA_TO.COD_ESTADO%TYPE;
    V_COD_ACTABO            PV_INTERFAZ_MIGRA_TO.COD_ACTABO%TYPE;
    V_FEC_PROCESO           PV_INTERFAZ_MIGRA_TO.FEC_PROCESO%TYPE;
    V_NUM_OS                PV_INTERFAZ_MIGRA_TO.NUM_OS%TYPE;
    V_COD_OS                PV_INTERFAZ_MIGRA_TO.COD_OS%TYPE;
    V_NUM_EVENTO            PV_INTERFAZ_MIGRA_TO.NUM_EVENTO%TYPE;
    V_DESCRIPCION           PV_INTERFAZ_MIGRA_TO.DESCRIPCION%TYPE;
    V_COD_CENTRAL           GA_ABOAMIST.COD_CENTRAL%TYPE;
    V_NUM_SERIE_AUX         GA_ABOAMIST.NUM_SERIE%TYPE;
    V_TIP_TERMINAL          GA_ABOAMIST.TIP_TERMINAL%TYPE;
    V_NUM_TRANSACCION       GA_TRANSACABO.NUM_TRANSACCION%TYPE;
    LN_NUM_SECUENCIA_AUX    ICC_MOVIMIENTO.NUM_MOVIMIENTO%TYPE;
    V_COD_RETORNO           GA_TRANSACABO.COD_RETORNO%TYPE;
    V_COD_SUBCUENTA         GA_ABOCEL.COD_SUBCUENTA%TYPE;
    V_ACCIONCAL             PV_CALIFICA_PLAN_TARIF_TO.COD_ACCIONCAL%type;
    v_calificacion          PV_CALIFICA_PLAN_TARIF_TO.COD_CALIFICA%type;
    v_CAL_DEFAULT_PRC       GED_PARAMETROS.VAL_PARAMETRO%type;
    V_COD_TIPLAN            TA_PLANTARIF.COD_TIPLAN%type;
    V_MontoLimCons          GA_LCABO_TO.IMP_LIMCONS%TYPE;
    LV_COD_USO              GA_EQUIPABOSER.COD_USO%TYPE;
    v_COD_COLOR             GE_CLIENTES.COD_COLOR%type;
    v_COD_SEGMENTO          GE_CLIENTES.COD_SEGMENTO%type;
    V_cod_limcons           tol_limite_td.COD_LIMCONS%type;
    V_MTO_CONS              tol_limite_plan_td.MTO_CONS%type;

    V_TIPTRASPASO          VARCHAR2(3);
    V_COD_CAUSA            VARCHAR2(3);
    LV_CLASE_SERVICIO_AUX1 varchar2(255);
    V_setCodError          NUMBER(1);
    v_COUNT                NUMBER(5);
    V_DES_ERROR            varchar2(255);
    V_param_entrada        VARCHAR2(500);
    v_APLICA_CAL_ABO       varchar2(5);
    SN_retorno             NUMBER;


    GV_Descripcion         VARCHAR2(255);
    GV_Secuencia           NUMBER;
    GN_codretorno          NUMBER;
    GV_ACTABO              VARCHAR2(2):='MI';



    EO_CELULAR              PV_NUMCEL_PERS_QT;
    EO_GE_CLIENTES          GE_CLIENTES_QT;
    SO_SERVSUPLABO_QT       GA_SERVSUPLABO_QT;
    SO_ABONADO_QT           GA_ABONADO_QT;
    EO_SECUENCIA            PV_SECUENCIA_QT;
    EO_PARAM                PV_GA_ABOCEL_QT;
    SO_GA_ABOCEL            PV_GA_ABOCEL_QT;
    EO_VENTA                GA_VENTA_QT;
    SO_ABONADO              GA_ABONADO_QT;
    EO_TRASPASO_PLAN        PV_TRASPASO_PLAN_QT;
    EO_APROVISIONAR         GA_APROVISIONAR_QT;
    SO_OOSS_ONLINE          GE_OOSS_EN_LINEA_QT;
    EO_VALIDA_SERV_ACTDEC   PV_VALIDA_SERV_ACTDEC_QT;


    ERROR_ACTUALIZASALDO    EXCEPTION;
    ERROR_ELIRESERVAMI      EXCEPTION;
    ERROR_ACTCANTABON       EXCEPTION;
    ERROR_OBTSSPREPAGO      EXCEPTION;
    ERROR_SECUENVENTA       EXCEPTION;
    ERROR_OBTIENESSPOS      EXCEPTION;
    ERROR_APROVIBAJAPRE     EXCEPTION;
    ERROR_BAJASSPREPA       EXCEPTION;
    ERROR_SECUENMOV         EXCEPTION;
    ERROR_SECUENABO         EXCEPTION;
    ERROR_ACTUALIZALIMITECONS EXCEPTION;
    ERROR_MIGRAABO            EXCEPTION;
    ERROR_REGISTRASS          EXCEPTION;
    ERROR_OBTENERSS           EXCEPTION;
    ERROR_SECUENMOVI          EXCEPTION;
    ERROR_ACTUALIZAGALIMITE   EXCEPTION;
    ERROR_REGISTRACONTRA      EXCEPTION;
    ERROR_REGISTRAVENTA       EXCEPTION;
    ERROR_REGISTRAOOSS        EXCEPTION;
    ERROR_CAUSACAMBIO         EXCEPTION;
    ERROR_PRECALIFICADOS      EXCEPTION;
    ERROR_PROVIABO              EXCEPTION;
    ERROR_VALPLANDEFECTO      EXCEPTION;
    ERROR_VALACTDESCLI        EXCEPTION;
    ERROR_BAJAPLANES          EXCEPTION;
    ERROR_NUMEROOSS           EXCEPTION;
    ERROR_VALIDASS            EXCEPTION;
    ERROR_SECUENNUMOS         EXCEPTION;
    ERROR_REGISTRATRASP       EXCEPTION;
    ERROR_APROVIABONADONUE    EXCEPTION;
    ERROR_APROVISS            EXCEPTION;
    ERROR_BAJINTARCEL         EXCEPTION;
    ERROR_RESTRICCION         EXCEPTION;

begin
        EO_CELULAR              :=PV_INICIA_ESTRUCTURAS_PG.PV_NUMCEL_PERS_QT_FN;
        EO_GE_CLIENTES          :=PV_INICIA_ESTRUCTURAS_PG.GE_CLIENTES_QT_FN;
        SO_SERVSUPLABO_QT       :=PV_INICIA_ESTRUCTURAS_PG.GA_SERVSUPLABO_QT_FN;
        SO_ABONADO_QT           :=PV_INICIA_ESTRUCTURAS_PG.PV_INICIA_GA_ABONADO_QT_FN;
        EO_SECUENCIA            :=PV_INICIA_ESTRUCTURAS_PG.PV_SECUENCIA_QT_FN;
        EO_PARAM                :=PV_INICIA_ESTRUCTURAS_PG.PV_GA_ABOCEL_QT_FN;
        SO_GA_ABOCEL            :=PV_INICIA_ESTRUCTURAS_PG.PV_GA_ABOCEL_QT_FN;
        EO_VENTA                :=PV_INICIA_ESTRUCTURAS_PG.GA_VENTA_QT_FN;
        SO_ABONADO              :=PV_INICIA_ESTRUCTURAS_PG.PV_INICIA_GA_ABONADO_QT_FN;
        EO_TRASPASO_PLAN        :=PV_INICIA_ESTRUCTURAS_PG.PV_TRASPASO_PLAN_QT_FN;
        EO_APROVISIONAR         :=PV_INICIA_ESTRUCTURAS_PG.GA_APROVISIONAR_QT_FN;
        SO_OOSS_ONLINE          :=PV_INICIA_ESTRUCTURAS_PG.GE_OOSS_EN_LINEA_QT_FN;
        EO_VALIDA_SERV_ACTDEC   :=PV_INICIA_ESTRUCTURAS_PG.PV_VALIDA_SERV_ACTDEC_QT_FN;

       SN_cod_retorno  := 0;
       SV_mens_retorno := NULL;
       SN_num_evento  := 0;


   -- OBTENION DATOS DE LA SOLICITUD DE MIGRACION

       LV_sSql:='  SELECT  NUM_CELULAR,NUM_ABONADO   , ';
       LV_sSql:= LV_sSql || ' COD_CLIENTE   ,         COD_PLANTARIF ,';
       LV_sSql:= LV_sSql || ' IND_PROCEQUI  ,         NOM_USUARIO   , ';
       LV_sSql:= LV_sSql || ' NUM_SERIE     ,         FEC_EJECUCION , ';
       LV_sSql:= LV_sSql || ' COD_ESTADO    ,         COD_ACTABO    , ';
       LV_sSql:= LV_sSql || ' FEC_PROCESO   ,         NUM_OS        , ';
       LV_sSql:= LV_sSql || ' COD_OS        ,         NUM_EVENTO    , ';
       LV_sSql:= LV_sSql || ' dESCRIPCION ';
       LV_sSql:= LV_sSql || '     FROM PV_INTERFAZ_MIGRA_TO';
       LV_sSql:= LV_sSql || '     WHERE COD_ESTADO = 1';
       LV_sSql:= LV_sSql || '     AND NUM_ABONADO = '||EN_NUM_ABONADO;

       SELECT  NUM_CELULAR   ,         NUM_ABONADO   ,
               COD_CLIENTE   ,         COD_PLANTARIF ,
               IND_PROCEQUI  ,         NOM_USUARIO   ,
               NUM_SERIE     ,         FEC_EJECUCION ,
               COD_ESTADO    ,         COD_ACTABO    ,
               FEC_PROCESO   ,         NUM_OS        ,
               COD_OS        ,         NUM_EVENTO    ,
               DESCRIPCION
       INTO             V_NUM_CELULAR   ,  V_NUM_ABONADO   ,
                        V_COD_CLIENTE   ,  V_COD_PLANTARIF ,
                        V_IND_PROCEQUI  ,  V_NOM_USUARIO   ,
                        V_NUM_SERIE     ,  V_FEC_EJECUCION ,
                        V_COD_ESTADO    ,  V_COD_ACTABO    ,
                        V_FEC_PROCESO   ,  V_NUM_OS        ,
                        V_COD_OS        ,  V_NUM_EVENTO    ,
                        V_DESCRIPCION
       FROM PV_INTERFAZ_MIGRA_TO
       WHERE COD_ESTADO = 1
       AND NUM_ABONADO = EN_NUM_ABONADO;


   --DATOS DEL ABONADO PREPAGO
       LV_sSql:= ' SELECT  COD_CLIENTE,COD_CUENTA,COD_SUBCUENTA,COD_USUARIO,COD_PLANTARIF,NUM_IMEI,';
       LV_sSql:= LV_sSql || '         COD_CENTRAL,NUM_SERIE,TIP_TERMINAL,COD_TECNOLOGIA,NUM_CONTRATO,NUM_ANEXO,';
       LV_sSql:= LV_sSql || '         COD_CICLO,FEC_FINCONTRA';
       LV_sSql:= LV_sSql || ' FROM GA_ABOAMIST';
       LV_sSql:= LV_sSql || ' WHERE NUM_ABONADO='||V_NUM_ABONADO;


       SELECT  COD_CLIENTE,COD_CUENTA,COD_SUBCUENTA,COD_USUARIO,COD_PLANTARIF,NUM_IMEI,
               COD_CENTRAL,NUM_SERIE,TIP_TERMINAL,COD_TECNOLOGIA,NVL(NUM_CONTRATO,0),NVL(NUM_ANEXO,0),
               COD_CICLO,FEC_FINCONTRA
       INTO
       EO_TRASPASO_PLAN.COD_CLIENANT      ,EO_TRASPASO_PLAN.COD_CUENTAANT ,
       EO_TRASPASO_PLAN.COD_SUBCTAANT     ,EO_TRASPASO_PLAN.COD_USUARANT  ,
       EO_TRASPASO_PLAN.COD_PLANTARIF_ORIG,V_NUM_SERIE,V_COD_CENTRAL      ,
       V_NUM_SERIE_AUX,V_TIP_TERMINAL ,EO_PARAM.COD_TECNOLOGIA            ,
       SO_GA_ABOCEL.NUM_CONTRATO      ,
       SO_GA_ABOCEL.NUM_ANEXO         ,
       SO_GA_ABOCEL.COD_CICLO         ,
       SO_GA_ABOCEL.FEC_FINCONTRA
       FROM GA_ABOAMIST
       WHERE NUM_ABONADO=V_NUM_ABONADO;



   -- OBTENER EL USO DEL PLAN

       LV_sSql:=  ' SELECT COD_TIPLAN ,COD_CARGOBASICO ';
       LV_sSql:= LV_sSql || ' FROM TA_PLANTARIF';
       LV_sSql:= LV_sSql || ' WHERE COD_PLANTARIF ='||V_COD_PLANTARIF ;


       SELECT COD_TIPLAN ,COD_CARGOBASICO INTO V_COD_TIPLAN,SO_GA_ABOCEL.COD_CARGOBASICO
       FROM TA_PLANTARIF
       WHERE COD_PLANTARIF =V_COD_PLANTARIF ;

   -- DEFINIR EL TIPO DE TRASPASO Y CAUSA DEL CAMBIO DE PLAN
       IF TRIM(V_COD_TIPLAN)= '2' THEN
           V_TIPTRASPASO:='PRP';
           V_COD_CAUSA  :='05';
           LV_COD_USO   := '2';
       ELSE
           V_TIPTRASPASO:='PRH';
           V_COD_CAUSA  :='03';
           LV_COD_USO   := '10';
       END IF;


       EO_celular.NUM_CELULAR_PERS   :=  V_NUM_CELULAR;
       EO_GE_CLIENTES.COD_CLIENTE    :=  V_COD_CLIENTE;
       EO_GE_CLIENTES.CANTIDAD       :=  1;
       SO_SERVSUPLABO_QT.NUM_ABONADO := V_NUM_ABONADO;
       SO_ABONADO_QT.NUM_ABONADO     := V_NUM_ABONADO;

    -- VALIDACIONES

            LV_SSQL:='SELECT GA_SEQ_TRANSACABO.NEXTVAL INTO GV_Secuencia FROM DUAL;';

            SELECT GA_SEQ_TRANSACABO.NEXTVAL INTO GV_SECUENCIA FROM DUAL;

            V_PARAM_ENTRADA  := '||||'||GV_ACTABO  ||'|' || V_NUM_ABONADO || '|' || EO_TRASPASO_PLAN.COD_CLIENANT ||'||||||||||||||';

            LV_SSQL:='PV_PR_EJECUTA_RESTRICCION (GV_Secuencia,GA,1,MI,SIGUIENTE,V_param_entrada);';
            PV_PR_EJECUTA_RESTRICCION (GV_SECUENCIA,'GA',1,'MI','SIGUIENTE',V_PARAM_ENTRADA);

            LV_SSQL:=' SELECT tran.cod_retorno,tran.des_cadena  FROM GA_TRANSACABO tran  WHERE tran.num_transaccion = GV_Secuencia;';

            SELECT TRAN.COD_RETORNO,TRAN.DES_CADENA
            INTO GN_CODRETORNO,GV_DESCRIPCION
            FROM GA_TRANSACABO TRAN
            WHERE TRAN.NUM_TRANSACCION = GV_SECUENCIA;

            IF GN_CODRETORNO <> 0 THEN
                IF TRIM(GV_DESCRIPCION) = 'OK' THEN
                     SN_cod_retorno  := 0;
                ELSE
                    SN_cod_retorno  := 1;
                    LV_SSQL:=GV_DESCRIPCION;
                    RAISE ERROR_RESTRICCION;
                END IF;
            END IF;


           /*V_COUNT   :=0;
           SELECT  COUNT(1) INTO V_COUNT
           FROM GA_ABOCEL
           WHERE COD_CLIENTE=V_COD_CLIENTE;

           IF V_COUNT > 0 THEN
              SN_cod_retorno  := 1;
              LV_SSQL:='Cliente Destino, se encuentra con abonados, se debe considerar que siempre es nuevo';
              RAISE ERROR_RESTRICCION;
           END IF;
           */

          IF TRIM(V_COD_TIPLAN)= '1' THEN
              SN_cod_retorno  := 1;
              LV_SSQL:='El plan tarifario destino no debe ser Prepago';
              RAISE ERROR_RESTRICCION;
          END IF;

          V_COUNT:=0;
          SELECT COUNT(1)
          INTO V_COUNT
          FROM TA_PLANTARIF
          WHERE COD_PLANTARIF  =V_COD_PLANTARIF  AND
          SYSDATE BETWEEN FEC_DESDE AND FEC_HASTA;

          IF V_COUNT = 0 THEN
              SN_cod_retorno  := 1;
              LV_SSQL:='El plan tarifario destino no se encuentra vigente';
              RAISE ERROR_RESTRICCION;
          END IF;


          -- OBTENER EL VENDEDOR

          LV_SSQL:=  ' SELECT COD_VENDEDOR';
          LV_SSQL:= LV_SSQL || ' FROM GE_SEG_USUARIO';
          LV_SSQL:= LV_SSQL || ' WHERE NOM_USUARIO ='|| V_NOM_USUARIO;

          BEGIN

              SELECT COD_VENDEDOR
              INTO EO_TRASPASO_PLAN.COD_VENDEDOR
              FROM GE_SEG_USUARIO
              WHERE NOM_USUARIO = V_NOM_USUARIO;

              IF (EO_TRASPASO_PLAN.COD_VENDEDOR IS NULL) OR (TRIM(EO_TRASPASO_PLAN.COD_VENDEDOR)= '') THEN
                      SN_cod_retorno  := 1;
                      LV_SSQL:='Usuario :'||V_NOM_USUARIO ||' No posee Vendedor en SCL';
                      RAISE ERROR_RESTRICCION;

              END IF;

          EXCEPTION
               WHEN NO_DATA_FOUND THEN
                      SN_cod_retorno  := 1;
                      LV_SSQL:='Usuario :'||V_NOM_USUARIO ||' Ingresado no existe en SCL';
                      RAISE ERROR_RESTRICCION;
          END;


   --ACTUALIZA SALDO
   --************ AVERIGUAR LA CADENA ***************
       LV_sSql:='PV_DATOS_ABONADO_PG.PV_ACTUALIZA_CADENASALDO_PR('||V_NUM_ABONADO||','||EV_SALDO||',SN_cod_retorno, SV_mens_retorno, SN_num_evento);';
       PV_DATOS_ABONADO_PG.PV_ACTUALIZA_CADENASALDO_PR(V_NUM_ABONADO,EV_SALDO,SN_cod_retorno, SV_mens_retorno, SN_num_evento);
       IF(SN_cod_retorno <> 0)THEN
        RAISE ERROR_ACTUALIZASALDO;
       END IF;

   --ELIMINA DE LA RESERVAMIST
       LV_sSql:='PV_DATOS_ABONADO_PG.PV_RESERVA_AMIST_PR(EO_celular,SN_cod_retorno, SV_mens_retorno, SN_num_evento );';
       PV_DATOS_ABONADO_PG.PV_RESERVA_AMIST_PR(EO_celular,SN_cod_retorno, SV_mens_retorno, SN_num_evento );
       IF(SN_cod_retorno <> 0)THEN
        RAISE ERROR_ELIRESERVAMI;
       END IF;

   --ACTUALIZA CANTIDAD DE ABONADOS
       LV_sSql:='PV_DATOS_CLIENTES_PG.PV_ACTUA_CANT_ABOCLIENTE_PR(EO_GE_CLIENTES,SN_cod_retorno, SV_mens_retorno, SN_num_evento);';
       PV_DATOS_CLIENTES_PG.PV_ACTUA_CANT_ABOCLIENTE_PR(EO_GE_CLIENTES,SN_cod_retorno, SV_mens_retorno, SN_num_evento);
       IF(SN_cod_retorno <> 0)THEN
        RAISE ERROR_ACTCANTABON;
       END IF;

   --OBTIENE LOS SERVICIOS SUPLEMENTARIOS DEL ABONADO PREPAGO
       LV_sSql:='PV_ORDEN_SERVICIO_PG.PV_OBT_GRUPO_NIVELCONT_PR(SO_SERVSUPLABO_QT,SN_cod_retorno, SV_mens_retorno, SN_num_evento);';
       PV_ORDEN_SERVICIO_PG.PV_OBT_GRUPO_NIVELCONT_PR(SO_SERVSUPLABO_QT,SN_cod_retorno, SV_mens_retorno, SN_num_evento);
       IF(SN_cod_retorno <> 0)THEN
        RAISE ERROR_OBTSSPREPAGO;
       END IF;



   --ACTUALIZA LA SITUACION Y DA DE BAJA EN LA GA_SERVSUPLABO
       LV_sSql:='PV_ORDEN_SERVICIO_PG.PV_BAJA_SS_PREPAGO_PR(SO_ABONADO_QT,SN_cod_retorno, SV_mens_retorno, SN_num_evento);';
       PV_ORDEN_SERVICIO_PG.PV_BAJA_SS_PREPAGO_PR(SO_ABONADO_QT,SN_cod_retorno, SV_mens_retorno, SN_num_evento);
       IF(SN_cod_retorno <> 0)THEN
        RAISE ERROR_BAJASSPREPA;
       END IF;

       EO_SECUENCIA.NOM_SECUENCIA    := 'ICC_SEQ_NUMMOV';
       LV_sSql:='PV_GENERALES_PG.PV_OBTIENE_SECUENCIA_PR(EO_SECUENCIA,SN_cod_retorno, SV_mens_retorno, SN_num_evento);';
       PV_GENERALES_PG.PV_OBTIENE_SECUENCIA_PR(EO_SECUENCIA,SN_cod_retorno, SV_mens_retorno, SN_num_evento);
       IF(SN_cod_retorno <> 0)THEN
        RAISE ERROR_SECUENMOVI;
       END IF;

       LN_NUM_SECUENCIA_AUX          :=EO_SECUENCIA.NUM_SECUENCIA;

       EO_SECUENCIA.NOM_SECUENCIA    := 'GA_SEQ_NUMABO';
       LV_sSql:='PV_GENERALES_PG.PV_OBTIENE_SECUENCIA_PR(EO_SECUENCIA,SN_cod_retorno, SV_mens_retorno, SN_num_evento);';
       PV_GENERALES_PG.PV_OBTIENE_SECUENCIA_PR(EO_SECUENCIA,SN_cod_retorno, SV_mens_retorno, SN_num_evento);
       IF(SN_cod_retorno <> 0)THEN
        RAISE ERROR_SECUENABO;
       END IF;

       LN_NUM_ABONADO_AUX            :=EO_SECUENCIA.NUM_SECUENCIA;

   --ENVIAR MOVIMIENTO A LA PLATAFORMA
       EO_APROVISIONAR.NUM_ABONADO     :=LN_NUM_ABONADO_AUX; --157087_3
        IF TRIM(V_COD_TIPLAN)= '2' THEN
           EO_APROVISIONAR.COD_ACTABO      :='BP';
       ELSE
       
           EO_APROVISIONAR.COD_ACTABO      :='HP';
       END IF;



       EO_APROVISIONAR.NOM_USUARORA    :=V_NOM_USUARIO ;
       EO_APROVISIONAR.TIP_TERMINAL    :=V_TIP_TERMINAL;
       EO_APROVISIONAR.COD_CENTRAL     :=V_COD_CENTRAL;
       EO_APROVISIONAR.NUM_CELULAR     :=V_NUM_CELULAR;
       EO_APROVISIONAR.NUM_SERIE       :=V_NUM_SERIE_AUX;
       EO_APROVISIONAR.TIP_TECNOLOGIA  :=EO_PARAM.COD_TECNOLOGIA;
       EO_APROVISIONAR.IMEI            :=V_NUM_SERIE;
       EO_APROVISIONAR.VAL_OOSS        :=0;
       EO_APROVISIONAR.COD_PLANTARIF_NUEVO:=V_COD_PLANTARIF ;
       EO_APROVISIONAR.NUN_OOSS        :=0;
       EO_APROVISIONAR.COD_OOSS        := V_COD_OS;
       EO_APROVISIONAR.SEQ_NUMMOV      :=LN_NUM_SECUENCIA_AUX   ;
       EO_APROVISIONAR.COD_TIPLAN      :=1;
       EO_APROVISIONAR.COD_SERVICIOS   :=so_servsuplabo_qt.grupo_nivel;
       EO_APROVISIONAR.COD_PLANTARIF   :=EO_TRASPASO_PLAN.COD_PLANTARIF_ORIG;
       EO_APROVISIONAR.VALOR_PLAN      :=0;
       EO_APROVISIONAR.NUM_MOVANT      :=0;
       LV_sSql:='PV_ESPEC_PROVISIONAMIENTO_PG.PV_APROVISIONAR_CENTRAL_PR('|| EO_APROVISIONAR.COD_ACTABO||',SN_cod_retorno, SV_mens_retorno, SN_num_evento);';
       PV_ESPEC_PROVISIONAMIENTO_PG.PV_APROVISIONAR_CENTRAL_PR(EO_APROVISIONAR,SN_cod_retorno, SV_mens_retorno, SN_num_evento);
       IF(SN_cod_retorno <> 0)THEN
        RAISE ERROR_APROVIBAJAPRE;
       END IF;



    --OBTENER CADENA
       so_abonado_qt.cod_cliente:=EO_TRASPASO_PLAN.COD_CLIENANT;
       so_abonado_qt.num_abonado:=V_NUM_ABONADO;
       LV_sSql:='PV_ORDEN_SERVICIO_PG.PV_BAJA_REG_TARIF_PR(so_abonado_qt,SN_cod_retorno, SV_mens_retorno, SN_num_evento);';
       PV_ORDEN_SERVICIO_PG.PV_BAJA_REG_TARIF_PR(so_abonado_qt,SN_cod_retorno, SV_mens_retorno, SN_num_evento);


       IF(SN_cod_retorno <> 0)THEN
        RAISE ERROR_BAJINTARCEL;
       END IF;

       EO_SECUENCIA.NOM_SECUENCIA      := 'GA_SEQ_VENTA';

       LV_sSql:='PV_GENERALES_PG.PV_OBTIENE_SECUENCIA_PR(EO_SECUENCIA,SN_cod_retorno, SV_mens_retorno, SN_num_evento);';
       PV_GENERALES_PG.PV_OBTIENE_SECUENCIA_PR(EO_SECUENCIA,SN_cod_retorno, SV_mens_retorno, SN_num_evento);
       iF(SN_cod_retorno <> 0)THEN
        RAISE ERROR_SECUENVENTA;
       END IF;
       EO_PARAM.NUM_VENTA              :=EO_SECUENCIA.NUM_SECUENCIA;


    --ACTUALIZA LIMITE CONSUMO PLAN
       IF TRIM(V_COD_TIPLAN)= '2' THEN

           LV_sSql:='SELECT COD_COLOR,COD_SEGMENTO';
           LV_sSql:=LV_sSql || ' From GE_CLIENTES';
           LV_sSql:=LV_sSql || ' Where cod_cliente = '||V_COD_CLIENTE;

           SELECT COD_COLOR,COD_SEGMENTO
           into
           v_COD_COLOR,v_COD_SEGMENTO
           From GE_CLIENTES
           Where cod_cliente = V_COD_CLIENTE;

           BEGIN

                   LV_sSql:=' SELECT a.cod_limcons ,nvl(b.MTO_CONS,0)';
                   LV_sSql:=LV_sSql || ' FROM tol_limite_td a,tol_limite_plan_td b';
                   LV_sSql:=LV_sSql || ' Where a.cod_limcons = b.cod_limcons ';
                   LV_sSql:=LV_sSql || ' AND SYSDATE BETWEEN b.fec_desde AND NVL(b.fec_hasta,SYSDATE)';
                   LV_sSql:=LV_sSql || ' aND b.cod_plantarif = '|| V_COD_PLANTARIF;
                   LV_sSql:=LV_sSql || ' AND b.ID_SUBSEGMENTO= '|| v_COD_SEGMENTO;
                   LV_sSql:=LV_sSql || ' AND b.IND_PRIORIDAD>= TO_NUMBER('||v_COD_COLOR||')';
                   LV_sSql:=LV_sSql || ' and rownum=1';
                   LV_sSql:=LV_sSql || ' ORDER BY b.IND_PRIORIDAD;';

                   SELECT a.cod_limcons ,nvl(b.MTO_CONS,0)
                   INTO V_cod_limcons,V_MTO_CONS
                   FROM tol_limite_td a,tol_limite_plan_td b
                   Where a.cod_limcons = b.cod_limcons
                   AND SYSDATE BETWEEN b.fec_desde AND NVL(b.fec_hasta,SYSDATE)
                   aND b.cod_plantarif = V_COD_PLANTARIF
                   AND b.ID_SUBSEGMENTO= v_COD_SEGMENTO
                   AND b.IND_PRIORIDAD>= TO_NUMBER(v_COD_COLOR)
                   and rownum=1
                   ORDER BY b.IND_PRIORIDAD;

                   V_MontoLimCons:= v_MTO_CONS;

           EXCEPTION
                   when no_data_found then
                      V_MontoLimCons:=0;

           END;


           LV_sSql:='VE_INTERMEDIARIO_PG.VE_ACTUALIZALIMABO_PR('||LN_NUM_ABONADO_AUX||','||V_MontoLimCons||',SN_cod_retorno, SV_mens_retorno, SN_num_evento);';
           VE_INTERMEDIARIO_PG.VE_ACTUALIZALIMABO_PR(LN_NUM_ABONADO_AUX,V_MontoLimCons,SN_cod_retorno, SV_mens_retorno, SN_num_evento);
           IF(SN_cod_retorno <> 0)THEN
            RAISE ERROR_ACTUALIZALIMITECONS;
           END IF;

       end if;

    --MIGRAR ABONADO

       SO_GA_ABOCEL.FEC_ALTA           :=SYSDATE;
       SO_GA_ABOCEL.COD_PLANTARIF      :=V_COD_PLANTARIF;
       SO_GA_ABOCEL.NUM_ABONADO        :=V_NUM_ABONADO;
       SO_GA_ABOCEL.COD_CLIENTE_NUE    :=V_COD_CLIENTE ;
       SO_GA_ABOCEL.COD_CUENTA         :=EO_TRASPASO_PLAN.COD_CUENTAANT;
       SO_GA_ABOCEL.COD_VENDEDOR       :=EO_TRASPASO_PLAN.COD_VENDEDOR;
       SO_GA_ABOCEL.TIP_PLANTARIF      :='I';
       SO_GA_ABOCEL.COD_CLIENTE        :=EO_TRASPASO_PLAN.COD_CLIENANT;
       SO_GA_ABOCEL.ID_SECUENCIA       :=LN_NUM_ABONADO_AUX;
       SO_GA_ABOCEL.NUM_VENTA          :=EO_PARAM.NUM_VENTA;
       SO_GA_ABOCEL.COD_USO            :=LV_COD_USO;
       SO_GA_ABOCEL.COD_SITUACION      :='AOP';
       LV_sSql:='PV_DATOS_ABONADO_PG.PV_MIGRAR_ABONADO_PR(SO_GA_ABOCEL,SN_cod_retorno, SV_mens_retorno, SN_num_evento);';
       PV_DATOS_ABONADO_PG.PV_MIGRAR_ABONADO_PR(SO_GA_ABOCEL,SN_cod_retorno, SV_mens_retorno, SN_num_evento);
       IF(SN_cod_retorno <> 0)THEN
            RAISE ERROR_MIGRAABO;
       END IF;




       IF TRIM(V_COD_TIPLAN)= '2' THEN
          -- ACTUALIZARLIMITECONSUMOFINAL
          LV_sSql:=' PV_SERVICIOS_POSVENTA_PG.PV_actualizaLimcons_PR(' ||LN_NUM_ABONADO_AUX||','||V_COD_CLIENTE ||','||V_cod_limcons||',sysdate ,SN_cod_retorno, SV_mens_retorno, SN_num_evento);';
          PV_SERVICIOS_POSVENTA_PG.PV_actualizaLimcons_PR(LN_NUM_ABONADO_AUX,V_COD_CLIENTE ,V_cod_limcons,sysdate ,SN_cod_retorno, SV_mens_retorno, SN_num_evento);
          IF(SN_cod_retorno <> 0)THEN
            RAISE ERROR_ACTUALIZAGALIMITE;
          END IF;
       END IF;

   -- REGISTRA EL NUEVO CONTRATO
       LV_sSql:='SELECT  COD_CUENTA,COD_TIPCONTRATO,NUM_ANEXO,COD_TECNOLOGIA,COD_CENTRAL,TIP_TERMINAL,COD_SUBCUENTA,COD_USUARIO';
       LV_sSql:=LV_sSql ||' FROM GA_ABOCEL ';
       LV_sSql:=LV_sSql ||' WHERE NUM_CELULAR = ' || V_NUM_CELULAR;

       SELECT  COD_CUENTA,COD_TIPCONTRATO,NUM_ANEXO,COD_TECNOLOGIA,COD_CENTRAL,TIP_TERMINAL,COD_SUBCUENTA,COD_USUARIO,num_contrato,TO_DATE(FEC_ALTA,'DD-MM-YYYY HH24:MI:SS')
       INTO EO_PARAM.COD_CUENTA,EO_PARAM.COD_TIPCONTRATO,EO_PARAM.NUM_ANEXO,
            EO_PARAM.COD_TECNOLOGIA,  SO_ABONADO.COD_CENTRAL,SO_ABONADO.TIP_TERMINAL,V_COD_SUBCUENTA,EO_TRASPASO_PLAN.COD_USUARNUE,
            EO_PARAM.NUM_CONTRATO,EO_PARAM.FEC_ALTA
       FROM GA_ABOCEL
       WHERE NUM_CELULAR =V_NUM_CELULAR;
       EO_PARAM.COD_PRODUCTO:=1;



       LV_sSql:=' SELECT NUM_MESES';
       LV_sSql:=LV_sSql ||' FROM ga_percontrato';
       LV_sSql:=LV_sSql ||' WHERE COD_TIPCONTRATO = '||EO_PARAM.COD_TIPCONTRATO;

       SELECT NUM_MESES
       INTO EO_PARAM.NUM_MESES
       FROM ga_percontrato
       WHERE COD_TIPCONTRATO = EO_PARAM.COD_TIPCONTRATO;


       LV_sSql:='PV_CUENTA_PG.PV_INS_CONTRATO_CUENTA_PR(EO_PARAM,SN_cod_retorno, SV_mens_retorno, SN_num_evento);';
       PV_CUENTA_PG.PV_INS_CONTRATO_CUENTA_PR(EO_PARAM,SN_cod_retorno, SV_mens_retorno, SN_num_evento);
       IF(SN_cod_retorno <> 0)THEN
            RAISE ERROR_REGISTRACONTRA;
       END IF;



   --REGISTRA LA VENTA
       EO_VENTA.NUM_VENTA          :=EO_PARAM.NUM_VENTA;
       EO_VENTA.COD_PRODUCTO       := 1;
       EO_VENTA.NUM_UNIDADES       := 1;
       EO_VENTA.IND_ESTVENTA       :='AC';
       EO_VENTA.NUM_TRANSACCION    :=0;
       EO_VENTA.IND_PASOCOB        :=0;
       EO_VENTA.IND_VENTA          :='V';
       EO_VENTA.IMP_VENTA          :=0;
       EO_VENTA.COD_TIPCONTRATO    :='82';
       EO_VENTA.IND_TIPVENTA       :=1;
       EO_VENTA.COD_CLIENTE        :=V_COD_CLIENTE;
       EO_VENTA.COD_MODVENTA       :=1;
       EO_VENTA.IND_OFITER         :='C';
       EO_VENTA.IND_CHKDICOM       :=0;
       LV_sSql:='PV_DATOS_ABONADO_PG.PV_INSERT_GA_VENTA(EO_VENTA,SN_cod_retorno, SV_mens_retorno, SN_num_evento);';
       PV_DATOS_ABONADO_PG.PV_INSERT_GA_VENTA(EO_VENTA,SN_cod_retorno, SV_mens_retorno, SN_num_evento);
       IF(SN_cod_retorno <> 0)THEN
            RAISE ERROR_REGISTRAVENTA;
       END IF;

   --OBTIENE LOS NUEVOS SS PARA ACTIVAR
       IF TRIM(V_COD_TIPLAN)= '2' then
            SO_ABONADO.COD_ACTABO    :='MH';
       else
            SO_ABONADO.COD_ACTABO    :='HP';
       end if;


       SO_ABONADO.COD_TECNOLOGIA     :=EO_PARAM.COD_TECNOLOGIA;
       SO_ABONADO.COD_CENTRAL        :=SO_ABONADO.COD_CENTRAL;
       SO_ABONADO.TIP_TERMINAL       :=SO_ABONADO.TIP_TERMINAL;
       SO_ABONADO.COD_PLANTARIF      :=V_COD_PLANTARIF;
       LV_sSql:='PV_ESPEC_PROVISIONAMIENTO_PG.PV_OBTENER_SERV_CONTRATO_PR(SO_ABONADO ,SN_cod_retorno, SV_mens_retorno, SN_num_evento);';
       PV_ESPEC_PROVISIONAMIENTO_PG.PV_OBTENER_SERV_CONTRATO_PR(SO_ABONADO ,SN_cod_retorno, SV_mens_retorno, SN_num_evento);
       IF(SN_cod_retorno <> 0)THEN
            RAISE ERROR_OBTENERSS;
       END IF;

       LV_CLASE_SERVICIO_AUX1        :=SO_ABONADO.CLASE_SERVICIO;


   --REGISTRA EN LA GA_SERVSUPLABO LOS NUEVOS SS PARA EL NUEVO ABONADO
       SO_GA_ABOCEL.CLASE_SERVICIO:=LV_CLASE_SERVICIO_AUX1;
       SO_GA_ABOCEL.NUM_ABONADO   :=LN_NUM_ABONADO_AUX   ;
       SO_GA_ABOCEL.NUM_CELULAR   :=V_NUM_CELULAR;
       SO_GA_ABOCEL.NOM_USUARORA  :=V_NOM_USUARIO;
       LV_sSql:='PV_ESPEC_PROVISIONAMIENTO_PG.PV_REGISTRAR_SERV_CONTRATO_PR(SO_GA_ABOCEL,SN_cod_retorno, SV_mens_retorno, SN_num_evento);';
       PV_ESPEC_PROVISIONAMIENTO_PG.PV_REGISTRAR_SERV_CONTRATO_PR(SO_GA_ABOCEL,SN_cod_retorno, SV_mens_retorno, SN_num_evento);
       IF(SN_cod_retorno <> 0) THEN
            RAISE ERROR_REGISTRASS;
       END IF;



       IF TRIM(V_COD_TIPLAN)= '2' THEN

                   EO_SECUENCIA.NOM_SECUENCIA    := 'ICC_SEQ_NUMMOV';
                   LV_sSql:='PV_GENERALES_PG.PV_OBTIENE_SECUENCIA_PR(EO_SECUENCIA,SN_cod_retorno, SV_mens_retorno, SN_num_evento);';
                   PV_GENERALES_PG.PV_OBTIENE_SECUENCIA_PR(EO_SECUENCIA,SN_cod_retorno, SV_mens_retorno, SN_num_evento);
                   IF(SN_cod_retorno <> 0)THEN
                       RAISE ERROR_SECUENMOVI;
                   END IF;

                   --ENVIAR MOVIMIENTO A LA PLATAFORMA
                   EO_APROVISIONAR.NUM_ABONADO     :=LN_NUM_ABONADO_AUX;
                   EO_APROVISIONAR.COD_ACTABO      :='MH';
                   EO_APROVISIONAR.NOM_USUARORA    :=V_NOM_USUARIO ;
                   EO_APROVISIONAR.TIP_TERMINAL    :=V_TIP_TERMINAL;
                   EO_APROVISIONAR.COD_CENTRAL     :=V_COD_CENTRAL;
                   EO_APROVISIONAR.NUM_CELULAR     :=V_NUM_CELULAR;
                   EO_APROVISIONAR.NUM_SERIE       :=V_NUM_SERIE_AUX;
                   EO_APROVISIONAR.TIP_TECNOLOGIA  :=EO_PARAM.COD_TECNOLOGIA;
                   EO_APROVISIONAR.IMEI            :=V_NUM_SERIE;
                   EO_APROVISIONAR.VAL_OOSS        :=0;
                   EO_APROVISIONAR.COD_PLANTARIF_NUEVO:=NULL ;
                   EO_APROVISIONAR.NUN_OOSS        :=0;
                   EO_APROVISIONAR.COD_OOSS        := V_COD_OS;
                   EO_APROVISIONAR.SEQ_NUMMOV      :=EO_SECUENCIA.NUM_SECUENCIA;
                   EO_APROVISIONAR.COD_TIPLAN      :=2;
                   EO_APROVISIONAR.COD_SERVICIOS   :=NULL;
                   EO_APROVISIONAR.COD_PLANTARIF   :=NULL;
                   EO_APROVISIONAR.VALOR_PLAN      :=0;
                   EO_APROVISIONAR.NUM_MOVANT      :=LN_NUM_SECUENCIA_AUX;
                   LV_sSql:='PV_ESPEC_PROVISIONAMIENTO_PG.PV_APROVISIONAR_CENTRAL_PR('||EO_APROVISIONAR.COD_ACTABO ||',SN_cod_retorno, SV_mens_retorno, SN_num_evento);';
                   PV_ESPEC_PROVISIONAMIENTO_PG.PV_APROVISIONAR_CENTRAL_PR(EO_APROVISIONAR,SN_cod_retorno, SV_mens_retorno, SN_num_evento);
                   IF(SN_cod_retorno <> 0)THEN
                      RAISE ERROR_APROVIABONADONUE;
                   END IF;



                   EO_SECUENCIA.NOM_SECUENCIA    := 'ICC_SEQ_NUMMOV';
                   LV_sSql:='PV_GENERALES_PG.PV_OBTIENE_SECUENCIA_PR(EO_SECUENCIA,SN_cod_retorno, SV_mens_retorno, SN_num_evento);';
                   PV_GENERALES_PG.PV_OBTIENE_SECUENCIA_PR(EO_SECUENCIA,SN_cod_retorno, SV_mens_retorno, SN_num_evento);
                   IF(SN_cod_retorno <> 0)THEN
                       RAISE ERROR_SECUENMOVI;
                   END IF;

                   --ENVIAR MOVIMIENTO A LA PLATAFORMA
                   EO_APROVISIONAR.NUM_ABONADO     :=LN_NUM_ABONADO_AUX;
                   EO_APROVISIONAR.COD_ACTABO      :='SS';
                   EO_APROVISIONAR.NOM_USUARORA    :=V_NOM_USUARIO ;
                   EO_APROVISIONAR.TIP_TERMINAL    :=V_TIP_TERMINAL;
                   EO_APROVISIONAR.COD_CENTRAL     :=V_COD_CENTRAL;
                   EO_APROVISIONAR.NUM_CELULAR     :=V_NUM_CELULAR;
                   EO_APROVISIONAR.NUM_SERIE       :=V_NUM_SERIE_AUX;
                   EO_APROVISIONAR.TIP_TECNOLOGIA  :=EO_PARAM.COD_TECNOLOGIA;
                   EO_APROVISIONAR.IMEI            :=V_NUM_SERIE;
                   EO_APROVISIONAR.VAL_OOSS        :=0;
                   EO_APROVISIONAR.COD_PLANTARIF_NUEVO:=NULL ;
                   EO_APROVISIONAR.NUN_OOSS        :=0;
                   EO_APROVISIONAR.COD_OOSS        := V_COD_OS;
                   EO_APROVISIONAR.SEQ_NUMMOV      :=EO_SECUENCIA.NUM_SECUENCIA;
                   EO_APROVISIONAR.COD_TIPLAN      :=1;
                   EO_APROVISIONAR.COD_SERVICIOS   :=LV_CLASE_SERVICIO_AUX1;
                   EO_APROVISIONAR.COD_PLANTARIF   :=NULL;
                   EO_APROVISIONAR.VALOR_PLAN      :=0;
                   EO_APROVISIONAR.NUM_MOVANT      :=NULL;
                   LV_sSql:='PV_ESPEC_PROVISIONAMIENTO_PG.PV_APROVISIONAR_CENTRAL_PR('||EO_APROVISIONAR.COD_ACTABO ||',SN_cod_retorno, SV_mens_retorno, SN_num_evento);';
                   PV_ESPEC_PROVISIONAMIENTO_PG.PV_APROVISIONAR_CENTRAL_PR(EO_APROVISIONAR,SN_cod_retorno, SV_mens_retorno, SN_num_evento);
                   LN_NUM_SECUENCIA_AUX            :=EO_SECUENCIA.NUM_SECUENCIA;
                   IF(SN_cod_retorno <> 0)THEN
                      RAISE ERROR_APROVISS;
                   END IF;


       end if;


   --REGISTRA EL TRASPASO
       EO_TRASPASO_PLAN.NUM_ABONADO            :=LN_NUM_ABONADO_AUX ;
       EO_TRASPASO_PLAN.COD_CLIENUE            :=V_COD_CLIENTE;
       EO_TRASPASO_PLAN.COD_CUENTANUE          :=EO_PARAM.COD_CUENTA;
       EO_TRASPASO_PLAN.COD_SUBCTANUE          :=V_COD_SUBCUENTA;
       EO_TRASPASO_PLAN.COD_PRODUCTO           :=1;
       EO_TRASPASO_PLAN.NUM_TERMINAL           :=V_NUM_CELULAR;
       EO_TRASPASO_PLAN.NUM_ABONADOANT         :=V_NUM_ABONADO;
       EO_TRASPASO_PLAN.IND_TRASDEUDA          :=0;
       EO_TRASPASO_PLAN.NOM_USUARORA           :=V_NOM_USUARIO;
       EO_TRASPASO_PLAN.IND_TRASPASO           :=V_TIPTRASPASO;
       EO_TRASPASO_PLAN.COD_PLANTARIF_DEST     :=V_COD_PLANTARIF;
       LV_sSql:='PV_PRODUCTO_CONTRATADO_PG.PV_REG_TRASPASO_PLAN_PR(EO_TRASPASO_PLAN,SN_cod_retorno, SV_mens_retorno, SN_num_evento);';
       PV_PRODUCTO_CONTRATADO_PG.PV_REG_TRASPASO_PLAN_PR(EO_TRASPASO_PLAN,SN_cod_retorno, SV_mens_retorno, SN_num_evento);
       IF(SN_cod_retorno <> 0) THEN
            RAISE ERROR_REGISTRATRASP;
       END IF;



   --VALIDA LOS SS
   /*
        EO_SECUENCIA.NOM_SECUENCIA              := 'PV_SEQ_NUMOS';
        LV_sSql:='PV_GENERALES_PG.PV_OBTIENE_SECUENCIA_PR(EO_SECUENCIA,SN_cod_retorno, SV_mens_retorno, SN_num_evento);';
        PV_GENERALES_PG.PV_OBTIENE_SECUENCIA_PR(EO_SECUENCIA,SN_cod_retorno, SV_mens_retorno, SN_num_evento);
        IF(SN_cod_retorno <> 0)THEN
            RAISE ERROR_SECUENNUMOS;
        END IF;


        EO_VALIDA_SERV_ACTDEC.NUM_MOVIMIENTO    :=EO_SECUENCIA.NUM_SECUENCIA;
        EO_VALIDA_SERV_ACTDEC.COD_ACTABO        :='SS';
        EO_VALIDA_SERV_ACTDEC.COD_PRODUCTO      :=1;
        EO_VALIDA_SERV_ACTDEC.COD_TECNOLOGIA    :=EO_PARAM.COD_TECNOLOGIA;
        EO_VALIDA_SERV_ACTDEC.TIP_PANTALLA      :=0;
        EO_VALIDA_SERV_ACTDEC.COD_CONCEPTO      :=0;
        EO_VALIDA_SERV_ACTDEC.COD_MODULO        :='XS';
        EO_VALIDA_SERV_ACTDEC.COD_PLANTARIF_NUE :=V_COD_PLANTARIF;
        EO_VALIDA_SERV_ACTDEC.COD_PLANTARIF_ANT :=EO_TRASPASO_PLAN.COD_PLANTARIF_ORIG;
        EO_VALIDA_SERV_ACTDEC.TIP_ABONADO       :=0;
        EO_VALIDA_SERV_ACTDEC.COD_OS            := V_COD_OS ;
        EO_VALIDA_SERV_ACTDEC.COD_CLIENTE       :=V_COD_CLIENTE;
        EO_VALIDA_SERV_ACTDEC.NUM_ABONADO       :=LN_NUM_ABONADO_AUX;
        EO_VALIDA_SERV_ACTDEC.IND_FACTUR        :=0;
        EO_VALIDA_SERV_ACTDEC.COD_PLANSERV      :=0;
        EO_VALIDA_SERV_ACTDEC.COD_OPERACION     :=0;
        EO_VALIDA_SERV_ACTDEC.COD_TIPCONTRATO   :=0;
        EO_VALIDA_SERV_ACTDEC.TIP_CELULAR       :=0;
        EO_VALIDA_SERV_ACTDEC.NUM_MESES         :=0;
        EO_VALIDA_SERV_ACTDEC.COD_ANTIGUEDAD    :=0;
        EO_VALIDA_SERV_ACTDEC.COD_CICLO         :=0;
        EO_VALIDA_SERV_ACTDEC.NUM_CELULAR       :=V_NUM_CELULAR    ;
        EO_VALIDA_SERV_ACTDEC.TIP_SERVICIO      :=0;
        EO_VALIDA_SERV_ACTDEC.COD_PLANCOM       :=0;
        EO_VALIDA_SERV_ACTDEC.PARAM1_MENS       :='NO';
        EO_VALIDA_SERV_ACTDEC.PARAM2_MENS       :=0;
        EO_VALIDA_SERV_ACTDEC.PARAM3_MENS       :=0;
        EO_VALIDA_SERV_ACTDEC.COD_ARTICULO      :=0;
        EO_VALIDA_SERV_ACTDEC.COD_CAUSA         :=0;
        EO_VALIDA_SERV_ACTDEC.COD_CAUSA_NUE     :=0;
        EO_VALIDA_SERV_ACTDEC.COD_VEND          :=0;
        EO_VALIDA_SERV_ACTDEC.COD_CATEGORIA     :=0;
        EO_VALIDA_SERV_ACTDEC.COD_MODVENTA      :=0;
        EO_VALIDA_SERV_ACTDEC.COD_CAUSINIE      :=0;
        LV_sSql:='PV_RESTRIC_VALIDACIONES_PG.PV_VALIDA_SERV_ACTDEC_PR(EO_VALIDA_SERV_ACTDEC,SV_record ,SN_cod_retorno, SV_mens_retorno, SN_num_evento);';
        PV_RESTRIC_VALIDACIONES_PG.PV_VALIDA_SERV_ACTDEC_PR(EO_VALIDA_SERV_ACTDEC,SV_record ,SN_cod_retorno, SV_mens_retorno, SN_num_evento);
        IF(SN_cod_retorno <> 0)THEN
            RAISE ERROR_VALIDASS;
        END IF;
   */



   -- REGISTRA LA CAUSA DEL CAMBIO DE PLAN
       EO_SECUENCIA.NOM_SECUENCIA    := 'CI_SEQ_NUMOS';
       LV_sSql:='PV_GENERALES_PG.PV_OBTIENE_SECUENCIA_PR(EO_SECUENCIA,SN_cod_retorno, SV_mens_retorno, SN_num_evento);';
       PV_GENERALES_PG.PV_OBTIENE_SECUENCIA_PR(EO_SECUENCIA,SN_cod_retorno, SV_mens_retorno, SN_num_evento);
       IF(SN_cod_retorno <> 0)THEN
            RAISE ERROR_NUMEROOSS;
       END IF;

       V_NUM_OS           :=EO_SECUENCIA.NUM_SECUENCIA;
       LV_sSql:='PV_ORDEN_SERVICIO_PG.PV_REG_CAUSACAMBIOPLAN_OS_PR(V_NUM_OS,V_COD_OS,V_COD_CAUSA,V_COD_PLANTARIF,V_NOM_USUARIO,LN_NUM_ABONADO_AUX,SN_cod_retorno, SV_mens_retorno, SN_num_evento);';
       PV_ORDEN_SERVICIO_PG.PV_REG_CAUSACAMBIOPLAN_OS_PR(V_NUM_OS,V_COD_OS,V_COD_CAUSA,V_COD_PLANTARIF,V_NOM_USUARIO,LN_NUM_ABONADO_AUX,SN_cod_retorno, SV_mens_retorno, SN_num_evento);
       IF(SN_cod_retorno <> 0)THEN
            RAISE ERROR_CAUSACAMBIO;
       END IF;



   -- REGISTRAR LA OOSS
       so_ooss_online.num_os              := V_NUM_OS;
       so_ooss_online.cod_os              := V_COD_OS;
       so_ooss_online.cod_producto        := 1;
       so_ooss_online.tip_inter           := 1;
       so_ooss_online.cod_inter           :=V_NUM_ABONADO;
       so_ooss_online.usuario             :=V_NOM_USUARIO;
       so_ooss_online.fecha               := to_char(sysdate,'dd-mm-yyyy hh24:mi:ss') ;
       so_ooss_online.comentario          :='Migración Masiva de Prepagos';
       so_ooss_online.num_movimiento      :=LN_NUM_SECUENCIA_AUX;
       so_ooss_online.cod_estado          :=1;
       so_ooss_online.cod_modulo          :='GA';
       so_ooss_online.id_gestor           :=0;
       LV_sSql:='PV_ORDEN_SERVICIO_PG.PV_REGISTRA_OOSS_ENLINEA_PR(so_ooss_online,SN_cod_retorno, SV_mens_retorno, SN_num_evento);';
       PV_ORDEN_SERVICIO_PG.PV_REGISTRA_OOSS_ENLINEA_PR(so_ooss_online,SN_cod_retorno, SV_mens_retorno, SN_num_evento);
       IF(SN_cod_retorno <> 0) THEN
            RAISE ERROR_REGISTRAOOSS;
       END IF;


    --*********************INICIO PLANES ADICIONALES*************************
     /*

    --BAJA DE PLANES ADICIONALES

      LV_sSql:='PV_PLANES_ADICIONALES_PG.PV_BAJA_PLANES_PR('||EO_TRASPASO_PLAN.COD_CLIENANT||','||V_NUM_ABONADO||',NULL,SYSDATE,'||LN_NUM_SECUENCIA_AUX||',0,'||'PV'||',SN_cod_retorno, SV_mens_retorno, SN_num_evento);';
      PV_PLANES_ADICIONALES_PG.PV_BAJA_PLANES_PR(EO_TRASPASO_PLAN.COD_CLIENANT,V_NUM_ABONADO,SYSDATE,null,LN_NUM_SECUENCIA_AUX,V_NUM_OS,'PV',SN_cod_retorno, SV_mens_retorno, SN_num_evento);
      IF(SN_cod_retorno <> 0)THEN
            RAISE ERROR_BAJAPLANES;
      END IF;



   -- ACTIVA PLANES ADICIONALES
       LV_sSql:='PV_DATOS_CLIENTES_PG.PV_VALIDA_ABOACTIVOCLIDEST_PR('||V_COD_CLIENTE||','||LN_NUM_ABONADO_AUX||','||' SN_retorno ,SN_cod_retorno, SV_mens_retorno, SN_num_evento);';
       PV_DATOS_CLIENTES_PG.PV_VALIDA_ABOACTIVOCLIDEST_PR(V_COD_CLIENTE,LN_NUM_ABONADO_AUX, SN_retorno ,SN_cod_retorno, SV_mens_retorno, SN_num_evento);
       IF(SN_cod_retorno <> 0)THEN
            RAISE ERROR_VALACTDESCLI;
       END IF;



       if SO_GA_ABOCEL.TIP_PLANTARIF ='I' THEN

              LV_sSql:='PV_PLANES_ADICIONALES_PG.PV_PLANES_DEFECTO_PR('||V_COD_CLIENTE||','||LN_NUM_ABONADO_AUX||','||V_COD_PLANTARIF||',SYSDATE, NULL,'||'PENDIENTE'||','|| V_NUM_OS||','||'PV'||',SN_cod_retorno, SV_mens_retorno, SN_num_evento);';
              PV_PLANES_ADICIONALES_PG.PV_PLANES_DEFECTO_PR(V_COD_CLIENTE,LN_NUM_ABONADO_AUX,V_COD_PLANTARIF,SYSDATE, NULL,0, V_NUM_OS,'PV',SN_cod_retorno, SV_mens_retorno, SN_num_evento);
              IF(SN_cod_retorno <> 0)THEN
                    RAISE ERROR_VALPLANDEFECTO;
              END IF;
       end if;

       if  SN_retorno = 0 then
           if SO_GA_ABOCEL.TIP_PLANTARIF ='E' THEN
             LV_sSql:='PV_PLANES_ADICIONALES_PG.PV_PLANES_DEFECTO_PR('||V_COD_CLIENTE||','||'0'||','||V_COD_PLANTARIF||',SYSDATE, NULL,'||'PENDIENTE'||','|| V_NUM_OS||','||'PV'||',SN_cod_retorno, SV_mens_retorno, SN_num_evento);';
             PV_PLANES_ADICIONALES_PG.PV_PLANES_DEFECTO_PR(V_COD_CLIENTE,0,V_COD_PLANTARIF,SYSDATE, NULL,0, V_NUM_OS,'PV',SN_cod_retorno, SV_mens_retorno, SN_num_evento);
             IF(SN_cod_retorno <> 0)THEN
                    RAISE ERROR_VALPLANDEFECTO;
             END IF;
           end if;
       else
           LV_sSql:='PV_PLANES_ADICIONALES_PG.PV_PROVISION_ABONADO_PR('||V_COD_CLIENTE||','||LN_NUM_ABONADO_AUX||',SYSDATE,'||'PENDIENTE'||','||V_NUM_OS||',SN_cod_retorno, SV_mens_retorno, SN_num_evento);';
           PV_PLANES_ADICIONALES_PG.PV_PROVISION_ABONADO_PR(V_COD_CLIENTE,LN_NUM_ABONADO_AUX,SYSDATE,null,V_NUM_OS,SN_cod_retorno, SV_mens_retorno, SN_num_evento);
           IF(SN_cod_retorno <> 0)THEN
               RAISE ERROR_PROVIABO;
           END IF;
       end if;


   -- APROVISIONA PLANES ADIC.

      LV_sSql:='PV_PLANES_ADICIONALES_PG.PV_PROVISION_ABONADO_PR('||V_COD_CLIENTE||','||LN_NUM_ABONADO_AUX||',SYSDATE,'||'PENDIENTE'||','||V_NUM_OS||',SN_cod_retorno, SV_mens_retorno, SN_num_evento);';
      PV_PLANES_ADICIONALES_PG.PV_PROVISION_ABONADO_PR(V_COD_CLIENTE,LN_NUM_ABONADO_AUX,SYSDATE,null,V_NUM_OS,SN_cod_retorno, SV_mens_retorno, SN_num_evento);
      IF(SN_cod_retorno <> 0)THEN
            RAISE ERROR_PROVIABO;
      END IF;


   --*********************FIN PLANES ADICIONALES*************************
      */

   --CIERRE DE LA VIGENCIA DE PRECALIFICADOS

       IF TRIM(V_COD_TIPLAN)= '2' THEN
            V_ACCIONCAL:= 1;
       else
            V_ACCIONCAL:= 2;
       end if;

       LV_sSql:='PV_DATOS_ABONADO_PG.PV_CERRAR_VIGENCIA_PRECAL_PR('||V_NUM_ABONADO||','||V_NUM_CELULAR||','|| V_ACCIONCAL||','||V_NOM_USUARIO||',SN_cod_retorno, SV_mens_retorno, SN_num_evento);';
       PV_DATOS_ABONADO_PG.PV_CERRAR_VIGENCIA_PRECAL_PR(V_NUM_ABONADO,V_NUM_CELULAR, V_ACCIONCAL,V_NOM_USUARIO,SN_cod_retorno, SV_mens_retorno, SN_num_evento);
       IF(SN_cod_retorno <> 0)THEN
            RAISE ERROR_PRECALIFICADOS;
       END IF;

       SN_NUM_OS       :=V_NUM_OS;

 EXCEPTION
     WHEN ERROR_RESTRICCION         THEN
       SN_num_evento   :=0;
       LV_des_error   := LV_sSQL || SQLERRM;
       SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'PV', SV_mens_retorno, '1', USER, 'PV_DATOS_ABONADO_PG.PV_MIGRAR_COMERCIAL_PR', LV_sSQL, SN_cod_retorno, LV_des_error );


    WHEN ERROR_ACTUALIZASALDO         THEN
       SN_num_evento   :=0;
       LV_des_error   := LV_sSQL || SQLERRM;
       SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'PV', SV_mens_retorno, '1', USER, 'PV_DATOS_ABONADO_PG.PV_ACTUALIZA_CADENASALDO_PR', LV_sSQL, SN_cod_retorno, LV_des_error );
    WHEN ERROR_ELIRESERVAMI           THEN
       SN_num_evento   :=0;
       LV_des_error   := LV_sSQL || SQLERRM;
       SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'PV', SV_mens_retorno, '1', USER, 'PV_DATOS_ABONADO_PG.PV_RESERVA_AMIST_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

    WHEN ERROR_ACTCANTABON            THEN
       SN_num_evento   :=0;
       LV_des_error   := LV_sSQL || SQLERRM;
       SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'PV', SV_mens_retorno, '1', USER, 'PV_DATOS_ABONADO_PG.PV_ACTUA_CANT_ABOCLIENTE_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

    WHEN ERROR_OBTSSPREPAGO           THEN
       SN_num_evento   :=0;
       LV_des_error   := LV_sSQL || SQLERRM;
       SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'PV', SV_mens_retorno, '1', USER, 'PV_ORDEN_SERVICIO_PG.PV_OBT_GRUPO_NIVELCONT_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

    WHEN ERROR_BAJASSPREPA            THEN
       SN_num_evento   :=0;
       LV_des_error   := LV_sSQL || SQLERRM;
       SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'PV', SV_mens_retorno, '1', USER, 'PV_ORDEN_SERVICIO_PG.PV_BAJA_SS_PREPAGO_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

    WHEN ERROR_SECUENMOVI             THEN
       SN_num_evento   :=0;
       LV_des_error   := LV_sSQL || SQLERRM;
       SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'PV', SV_mens_retorno, '1', USER, 'PV_GENERALES_PG.PV_OBTIENE_SECUENCIA_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

    WHEN ERROR_SECUENABO              THEN
       SN_num_evento   :=0;
       LV_des_error   := LV_sSQL || SQLERRM;
       SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'PV', SV_mens_retorno, '1', USER, 'PV_GENERALES_PG.PV_OBTIENE_SECUENCIA_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

    WHEN ERROR_APROVIBAJAPRE          THEN
       SN_num_evento   :=0;
       LV_des_error   := LV_sSQL || SQLERRM;
       SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'PV', SV_mens_retorno, '1', USER, 'PV_ESPEC_PROVISIONAMIENTO_PG.PV_APROVISIONAR_CENTRAL_PR', LV_sSQL, SN_cod_retorno, LV_des_error );


    WHEN ERROR_BAJINTARCEL           THEN
       SN_num_evento   :=0;
       LV_des_error   := LV_sSQL || SQLERRM;
       SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'PV', SV_mens_retorno, '1', USER, 'PV_ORDEN_SERVICIO_PG.PV_BAJA_REG_TARIF_PR', LV_sSQL, SN_cod_retorno, LV_des_error );


    WHEN ERROR_SECUENVENTA            THEN
       SN_num_evento   :=0;
       LV_des_error   := LV_sSQL || SQLERRM;
       SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'PV', SV_mens_retorno, '1', USER, 'PV_GENERALES_PG.PV_OBTIENE_SECUENCIA_PR' , LV_sSQL, SN_cod_retorno, LV_des_error );

    WHEN ERROR_ACTUALIZALIMITECONS    THEN
       SN_num_evento   :=0;
       LV_des_error   := LV_sSQL || SQLERRM;
       SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'PV', SV_mens_retorno, '1', USER, 'VE_INTERMEDIARIO_PG.VE_ACTUALIZALIMABO_PR' , LV_sSQL, SN_cod_retorno, LV_des_error );

    WHEN ERROR_MIGRAABO               THEN
       SN_num_evento:=0;
       LV_des_error   := LV_sSQL || SQLERRM;
       SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'PV', SV_mens_retorno, '1', USER, 'PV_DATOS_ABONADO_PG.PV_MIGRAR_ABONADO_PR' , LV_sSQL, SN_cod_retorno, LV_des_error );

    WHEN ERROR_ACTUALIZAGALIMITE      THEN
       SN_num_evento   :=0;
       LV_des_error   := LV_sSQL || SQLERRM;
       SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'PV', SV_mens_retorno, '1', USER, 'PV_SERVICIOS_POSVENTA_PG.PV_actualizaLimcons_PR' , LV_sSQL, SN_cod_retorno, LV_des_error );

    WHEN ERROR_REGISTRACONTRA         THEN
       SN_num_evento   :=0;
       LV_des_error   := LV_sSQL || SQLERRM;
       SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'PV', SV_mens_retorno, '1', USER, 'PV_CUENTA_PG.PV_INS_CONTRATO_CUENTA_PR' , LV_sSQL, SN_cod_retorno, LV_des_error );

    WHEN ERROR_REGISTRAVENTA          THEN
       SN_num_evento   :=0;
       LV_des_error   := LV_sSQL || SQLERRM;
       SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'PV', SV_mens_retorno, '1', USER, 'PV_DATOS_ABONADO_PG.PV_INSERT_GA_VENTA' , LV_sSQL, SN_cod_retorno, LV_des_error );

    WHEN ERROR_OBTENERSS              THEN
       SN_num_evento   :=0;
       LV_des_error   := LV_sSQL || SQLERRM;
       SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'PV', SV_mens_retorno, '1', USER, 'PV_ESPEC_PROVISIONAMIENTO_PG.PV_OBTENER_SERV_CONTRATO_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

    WHEN ERROR_REGISTRASS             THEN
       SN_num_evento   :=0;
       LV_des_error   := LV_sSQL || SQLERRM;
       SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'PV', SV_mens_retorno, '1', USER, 'PV_ESPEC_PROVISIONAMIENTO_PG.PV_REGISTRAR_SERV_CONTRATO_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

    WHEN ERROR_REGISTRATRASP          THEN
       SN_num_evento   :=0;
       LV_des_error   := LV_sSQL || SQLERRM;
       SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'PV', SV_mens_retorno, '1', USER, 'PV_PRODUCTO_CONTRATADO_PG.PV_REG_TRASPASO_PLAN_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

    WHEN ERROR_SECUENNUMOS            THEN
       SN_num_evento   :=0;
       LV_des_error   := LV_sSQL || SQLERRM;
       SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'PV', SV_mens_retorno, '1', USER, 'PV_GENERALES_PG.PV_OBTIENE_SECUENCIA_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

    WHEN ERROR_APROVIABONADONUE THEN
       SN_num_evento   :=0;
       LV_des_error   := LV_sSQL || SQLERRM;
       SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'PV', SV_mens_retorno, '1', USER, 'PV_ESPEC_PROVISIONAMIENTO_PG.PV_APROVISIONAR_CENTRAL_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

    WHEN ERROR_APROVISS          THEN
       SN_num_evento   :=0;
       LV_des_error   := LV_sSQL || SQLERRM;
       SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'PV', SV_mens_retorno, '1', USER, 'PV_GENERALES_PG.PV_OBTIENE_SECUENCIA_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

    WHEN ERROR_VALIDASS               THEN
       SN_num_evento   :=0;
       LV_des_error   := LV_sSQL || SQLERRM;
       SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'PV', SV_mens_retorno, '1', USER, 'PV_RESTRIC_VALIDACIONES_PG.PV_VALIDA_SERV_ACTDEC_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

    WHEN ERROR_NUMEROOSS              THEN
       SN_num_evento   :=0;
       LV_des_error   := LV_sSQL || SQLERRM;
       SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'PV', SV_mens_retorno, '1', USER, 'PV_GENERALES_PG.PV_OBTIENE_SECUENCIA_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

    WHEN ERROR_CAUSACAMBIO            THEN
       SN_num_evento   :=0;
       LV_des_error   := LV_sSQL || SQLERRM;
       SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'PV', SV_mens_retorno, '1', USER, 'PV_ORDEN_SERVICIO_PG.PV_REG_CAUSACAMBIOPLAN_OS_PR'  , LV_sSQL, SN_cod_retorno, LV_des_error );

    WHEN ERROR_REGISTRAOOSS           THEN
       SN_num_evento   :=0;
       LV_des_error   := LV_sSQL || SQLERRM;
       SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'PV', SV_mens_retorno, '1', USER, 'PV_ORDEN_SERVICIO_PG.PV_REGISTRA_OOSS_ENLINEA_PR' , LV_sSQL, SN_cod_retorno, LV_des_error );

    WHEN ERROR_BAJAPLANES             THEN
       SN_num_evento   :=0;
       LV_des_error   := LV_sSQL || SQLERRM;
       SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'PV', SV_mens_retorno, '1', USER, 'PV_PLANES_ADICIONALES_PG.PV_BAJA_PLANES_PR' , LV_sSQL, SN_cod_retorno, LV_des_error );

    WHEN ERROR_VALACTDESCLI           THEN
       SN_num_evento   :=0;
       LV_des_error   := LV_sSQL || SQLERRM;
       SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'PV', SV_mens_retorno, '1', USER, 'PV_DATOS_CLIENTES_PG.PV_VALIDA_ABOACTIVOCLIDEST_PR' , LV_sSQL, SN_cod_retorno, LV_des_error );

    WHEN ERROR_VALPLANDEFECTO         THEN
       SN_num_evento   :=0;
       LV_des_error   := LV_sSQL || SQLERRM;
       SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'PV', SV_mens_retorno, '1', USER,'PV_PLANES_ADICIONALES_PG.PV_PLANES_DEFECTO_PR' , LV_sSQL, SN_cod_retorno, LV_des_error );

    WHEN ERROR_PROVIABO               THEN
       SN_num_evento   :=0;
       LV_des_error   := LV_sSQL || SQLERRM;
       SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'PV', SV_mens_retorno, '1', USER,'PV_PLANES_ADICIONALES_PG.PV_PROVISION_ABONADO_PR' , LV_sSQL, SN_cod_retorno, LV_des_error );

    WHEN ERROR_PRECALIFICADOS         THEN
       SN_num_evento   :=0;
       LV_des_error   := LV_sSQL || SQLERRM;
       SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'PV', SV_mens_retorno, '1', USER,'PV_DATOS_ABONADO_PG.PV_CERRAR_VIGENCIA_PRECAL_PR', LV_sSQL, SN_cod_retorno, LV_des_error );


    WHEN NO_DATA_FOUND THEN
       SN_num_evento :=0;
       SN_cod_retorno := 1;
       IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := CV_error_no_clasif;
       END IF;
       LV_des_error   := 'PV_MIGRAR_COMERCIAL_PR   ('|| LN_NUM_ABONADO || '); '||SQLERRM;
       SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_DATOS_ABONADO_PG.PV_MIGRAR_COMERCIAL_PR', LV_sSQL, SN_cod_retorno, LV_des_error );
    WHEN OTHERS THEN
       SN_num_evento :=0;
       SN_cod_retorno := 156;
       IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := CV_error_no_clasif;
       END IF;
       LV_des_error   := 'PV_MIGRAR_COMERCIAL_PR   ('|| LN_NUM_ABONADO || '); '||SQLERRM;
       SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_DATOS_ABONADO_PG.PV_MIGRAR_COMERCIAL_PR', LV_sSQL, SN_cod_retorno, LV_des_error );
END PV_MIGRAR_COMERCIAL_PR;

------------------------------------------------------------------------------------------------------
PROCEDURE PV_UPDATE_INTARCEL_ACC_PR(EO_GA_INTARCEL     IN  OUT NOCOPY   PV_GA_INTARCEL_QT, --inc 147444
                                    SN_cod_retorno     OUT NOCOPY       ge_errores_td.cod_msgerror%TYPE,
                                    SV_mens_retorno    OUT NOCOPY       ge_errores_td.det_msgerror%TYPE,
                                    SN_num_evento      OUT NOCOPY       ge_errores_pg.evento)
IS
/*
 <Documentación
   TipoDoc = "Procedure">>
    <Elemento
       Nombre = "PV_UPDATE_INTARCEL_ACC_PR  "
       Lenguaje="PL/SQL"
       Fecha="11-11-2010"
       Versión="La del package"
       Diseñador=""
       Programador="ORLANDO CABEZAS B "
       Ambiente Desarrollo="BD">
       <Retorno>N/A</Retorno>>
       <Descripción></Descripción>>
       <Parámetros>
          <Entrada>
             <param nom="REO_GA_INTARCEL" Tipo="estructura">Estructura de datos Numero  </param>>
          </Entrada>
          <Salida>
             <param nom="SN_cod_retorno" Tipo="NUMERICO">Codigo de Retorno</param>>
             <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>>
             <param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>>
          </Salida>
       </Parámetros>
    </Elemento>
 </Documentación>
*/
  LV_des_error                  ge_errores_pg.DesEvent;
  LV_sSql                       ge_errores_pg.vQuery;
  ERROR_EJECUCION               EXCEPTION;
  Reg_ga_intarcel_acciones_to   PV_TIPOS_PG.R_GA_INTARCEL_ACCIONES_TO;
 BEGIN
   sn_cod_retorno  := 0;
   sv_mens_retorno := NULL;
   sn_num_evento  := 0;


    IF   EO_GA_INTARCEL.FEC_DESDE IS NULL OR EO_GA_INTARCEL.FEC_DESDE <=SYSDATE THEN

        LV_sSql:= 'update ga_intarcel_acciones_to'
        ||' set cod_actabo ='||chr(39)||'PI'||chr(39)
        ||' where cod_actabo = '||EO_GA_INTARCEL.COD_ACTABO
        ||' and num_abonado = '||EO_GA_INTARCEL.NUM_ABONADO
        ||' and fec_desde in (select max(fec_desde) from'
                          ||' ga_intarcel_acciones_to'
                          ||' where cod_actabo = '||EO_GA_INTARCEL.COD_ACTABO
                          ||' and num_abonado = '||EO_GA_INTARCEL.NUM_ABONADO||' )';

        update ga_intarcel_acciones_to
        set cod_actabo ='PI'
        where cod_actabo = EO_GA_INTARCEL.COD_ACTABO
        and num_abonado = EO_GA_INTARCEL.NUM_ABONADO
        and fec_desde in (select max(fec_desde) from
                          ga_intarcel_acciones_to
                          where cod_actabo = EO_GA_INTARCEL.COD_ACTABO
                          and num_abonado = EO_GA_INTARCEL.NUM_ABONADO );


    END IF;



EXCEPTION
 WHEN ERROR_EJECUCION THEN
    LV_des_error   := 'PV_UPDATE_INTARCEL_ACC_PR('||TO_CHAR(EO_GA_INTARCEL.NUM_ABONADO)||SQLERRM;
       SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_DATOS_ABONADO_PG.PV_UPDATE_INTARCEL_ACC_PR', LV_sSQL, SN_cod_retorno, LV_des_error );
 WHEN NO_DATA_FOUND THEN
       SN_cod_retorno := 149;
       IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := CV_error_no_clasif;
       END IF;
    LV_des_error   := 'PV_UPDATE_INTARCEL_ACC_PR('||TO_CHAR(EO_GA_INTARCEL.NUM_ABONADO)||SQLERRM;
       SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_DATOS_ABONADO_PG.PV_UPDATE_INTARCEL_ACC_PR', LV_sSQL, SN_cod_retorno, LV_des_error );
   WHEN OTHERS THEN
       SN_cod_retorno := 156;
       IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := CV_error_no_clasif;
       END IF;
    LV_des_error   := 'PV_UPDATE_INTARCEL_ACC_PR('||TO_CHAR(EO_GA_INTARCEL.NUM_ABONADO)|| SQLERRM;
       SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_DATOS_ABONADO_PG.PV_UPDATE_INTARCEL_ACC_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

END PV_UPDATE_INTARCEL_ACC_PR;
END PV_DATOS_ABONADO_PG;
/
SHOW ERROR
