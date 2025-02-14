CREATE OR REPLACE PACKAGE BODY ve_validaciones_clientes_pg
/*
<Documentación
TipoDoc = "Package">
 <Elemento
    Nombre = "GA_CONS_PG."
    Lenguaje="PL/SQL"
    Fecha="02-05-2005"
    Versión="1.0"
    Diseñador="AAA"
    Programador="SSSS"
    Ambiente Desarrollo="BD">
    <Retorno>NA</Retorno>
    <Descripción>Consulta de abonados....</Descripción>
    <Parámetros>
       <Entrada>NA</Entrada>
    </Parámetros>
 </Elemento>
</Documentación>
*/
IS

           /* -------------------------------------------------------------------------------------------- */

FUNCTION VE_valida_lista_negras_FN(EV_num_serie     IN  ga_aboamist.num_serie%TYPE,
                                   EN_largo_icc     IN  NUMBER,
                                   EN_largo_imei    IN  NUMBER,
                                      SN_cod_retorno   OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                                   SV_mens_retorno  OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                                   SN_num_evento    OUT NOCOPY ge_errores_pg.Evento) RETURN BOOLEAN IS

   error_ejecucion     EXCEPTION;
   LV_sql              ge_errores_pg.vQuery;
   LV_des_error        ge_errores_pg.DesEvent;
   LV_iccaux           ga_aboamist.num_serie%TYPE;
   LN_record           NUMBER(3);

BEGIN

     SN_cod_retorno := '0';
     SN_num_evento  :=  0;
     SV_mens_retorno:= '0';

     LV_sql:='SELECT COUNT(1) ';
     LV_sql:=LV_sql || 'FROM   ga_lncelu c ';
     LV_sql:=LV_sql || 'WHERE  c.num_serie=' || EV_num_serie;

     SELECT COUNT(1)
     INTO   LN_record
     FROM   ga_lncelu c
     WHERE  c.num_serie=EV_num_serie;

     IF LN_record>0 THEN
        IF LENGTH(EV_num_serie)=EN_largo_icc THEN
           SN_cod_retorno := 461; --ERROR_LISTA_NEGRA_ICC
        ELSIF LENGTH(EV_num_serie)=EN_largo_imei THEN
           SN_cod_retorno := 473; --ERROR_LISTA_NEGRA_IMEI
        ELSE
           SN_cod_retorno := 156; --ERROR_GENERAL
        END IF;
        RAISE error_ejecucion;
     ELSE
        RETURN(TRUE);
     END IF;

EXCEPTION
      WHEN error_ejecucion THEN
           IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
              SV_mens_retorno := CV_error_no_clasif;
           END IF;
           LV_des_error  := 've_validaciones_clientes_pg.VE_valida_lista_negras_FN(' || EV_num_serie || ',' || EN_largo_icc || ',' || EN_largo_imei || '); - '|| SQLERRM;
           SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'GA', SV_mens_retorno, '1.1', USER,'ve_validaciones_clientes_pg.ve_valida_pr', LV_sql,SQLCODE, LV_des_error );
           RETURN(FALSE);

      WHEN OTHERS THEN
           SN_cod_retorno := 156;  -- ERROR General
           IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
              SV_mens_retorno := CV_error_no_clasif;
           END IF;
           LV_des_error  := 've_validaciones_clientes_pg.VE_valida_lista_negras_FN(' || EV_num_serie || ',' || EN_largo_icc || ',' || EN_largo_imei || '); - '|| SQLERRM;
           SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'GA', SV_mens_retorno, '1.1', USER,'ve_validaciones_clientes_pg.ve_valida_pr', LV_sql,SQLCODE, LV_des_error );
           RETURN(FALSE);

END VE_valida_lista_negras_FN;

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

FUNCTION ve_valida_formato_simcard_fn(EV_num_serie    IN AL_SERIES.NUM_SERIE%TYPE,
                                      SN_cod_retorno  OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                                      SV_mens_retorno OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                                      SN_num_evento   OUT NOCOPY ge_errores_pg.Evento)
RETURN BOOLEAN IS
/*
<Documentación
  TipoDoc = "Funcion">
   <Elemento
      Nombre = "ve_valida_formato_simcard_fn"
      Lenguaje="PL/SQL"
      Fecha="13-05-2008"
      Versión="1.0"
      Diseñador="wjrc"
      Programador="wjrc"
      Ambiente Desarrollo="DEIMOS_ANDINA">
      <Retorno>NA</Retorno>
     <Descripción>Procedimiento que permite validar parametros ged_codigos</Descripción>
      <Parámetros>
         <Entrada>
            <param nom="EV_num_serie"      Tipo="CARACTER">imei</param>
         </Entrada>
         <Salida>
            <param nom="SN_cod_retorno"     Tipo="NUMERICO">Codigo de Retorno</param>
            <param nom="SV_mens_retorno"    Tipo="CARACTER">Mensaje de Retorno</param>
            <param nom="SN_num_evento"      Tipo="ge_errores_pg.Evento">Detalle de eventos</param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
    error_formato EXCEPTION;
    LV_sql       ge_errores_pg.vQuery;
    LV_des_error ge_errores_pg.DesEvent;
        LB_resp      BOOLEAN;
        v_respuesta  VARCHAR2(100);
BEGIN
    SN_num_evento   := 0;
    SN_cod_retorno  := 0;
    SV_mens_retorno := '';

        LB_resp := TRUE;
        v_respuesta := Ge_Vluhn_Fn (EV_num_serie);
        IF v_respuesta = '0' THEN
           raise error_formato;
        END IF;

    RETURN LB_resp;

EXCEPTION
     WHEN error_formato THEN
          SN_cod_retorno := 800;
          SV_mens_retorno := 'Error en el formato del IMEI';
          LV_des_error := 've_validaciones_clientes_pg.ve_valida_formato_simcard_fn('||EV_num_serie||'); - ' ||SQLERRM;
          SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'GA', SV_mens_retorno,'1.0', USER, 've_validaciones_clientes_pg.ve_valid_imei',LV_sql, SN_cod_retorno, LV_des_error);
          RETURN FALSE;
     WHEN OTHERS THEN
          SN_cod_retorno := 529;
          IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
             SV_mens_retorno := CV_error_no_clasif;
          END IF;
          LV_des_error := 've_validaciones_clientes_pg.ve_valida_formato_simcard_fn('||EV_num_serie||'); - ' ||SQLERRM;
          SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'GA', SV_mens_retorno,'1.0', USER, 've_validaciones_clientes_pg.ve_valid_imei',LV_sql, SN_cod_retorno, LV_des_error);
          RETURN FALSE;
END ve_valida_formato_simcard_fn;

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
FUNCTION ve_valid_imei( EV_cod_serie     IN AL_SERIES.NUM_SERIE%TYPE,
                               SN_cod_retorno    OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                               SV_mens_retorno   OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                               SN_num_evento     OUT NOCOPY ge_errores_pg.Evento)
RETURN BOOLEAN IS
/*
<Documentación
  TipoDoc = "Funcion">
   <Elemento
      Nombre = "ve_valid_imei"
      Lenguaje="PL/SQL"
      Fecha="06-11-2007"
      Versión="1.0"
      Diseñador=""
      Programador=""
      Ambiente Desarrollo="DEIMOS_ANDINA">
      <Retorno>NA</Retorno>
     <Descripción>Procedimiento que permite validar parametros ged_codigos</Descripción>
      <Parámetros>
         <Entrada>
            <param nom="EV_cod_serie"      Tipo="CARACTER">imei</param>
         </Entrada>
         <Salida>
            <param nom="SN_cod_retorno"     Tipo="NUMERICO">Codigo de Retorno</param>
            <param nom="SV_mens_retorno"    Tipo="CARACTER">Mensaje de Retorno</param>
            <param nom="SN_num_evento"      Tipo="ge_errores_pg.Evento">Detalle de eventos</param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
error_1          EXCEPTION;
error_ejecucion  EXCEPTION;
LV_des_error     ge_errores_pg.DesEvent;
LV_sSql          ge_errores_pg.vQuery;
TN_count         NUMBER;
CN_cero          CONSTANT NUMBER(1) := 0;
P_CODERROR       NUMBER(3);
P_DESERROR       VARCHAR2(100);
v_es_negativo    boolean;
NUM_ABONADO_DATO NUMBER;
P_NSRELECTRONICO VARCHAR2(20);
BEGIN
        SN_num_evento   := 0;
        SN_cod_retorno  := 0;
        SV_mens_retorno := '';
        P_NSRELECTRONICO:= EV_cod_serie;

                IF NOT ve_valida_formato_simcard_fn(EV_cod_serie,
                                                    SN_cod_retorno,
                                            SV_mens_retorno,
                                            SN_num_evento) THEN
            RAISE error_ejecucion;
        END IF;

        LV_sSql := 'PAC_NSR_NEG.P_CONS_NSR_NEG('|| P_NSRELECTRONICO || ',v_es_negativo ,P_CODERROR ,P_DESERROR)';
        PAC_NSR_NEG.P_CONS_NSR_NEG(P_NSRELECTRONICO,v_es_negativo,P_CODERROR,P_DESERROR);

        if v_es_negativo then
           SN_cod_retorno := 473; --IMEI se encuentra en seriales negativos
           RAISE error_1;
        end if;

        RETURN TRUE;

EXCEPTION
        WHEN error_ejecucion THEN
             LV_des_error := 've_validaciones_clientes_pg.ve_valid_imei('||EV_cod_serie||'); - ' ||SQLERRM;
             SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'GA', SV_mens_retorno,'1.0', USER, 've_validaciones_clientes_pg.ve_valid_imei',LV_sSql, SN_cod_retorno, LV_des_error);
             RETURN FALSE;
        WHEN error_1 THEN
             IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                     SV_mens_retorno := CV_error_no_clasif;
             END IF;
             LV_des_error := 've_validaciones_clientes_pg.ve_valid_imei('||EV_cod_serie||'); - ' ||SQLERRM;
             SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'GA', SV_mens_retorno,'1.0', USER, 've_validaciones_clientes_pg.ve_valid_imei',LV_sSql, SN_cod_retorno, LV_des_error);
             RETURN FALSE;
        WHEN OTHERS THEN
             SN_cod_retorno := 529;
             IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                     SV_mens_retorno := CV_error_no_clasif;
             END IF;
             LV_des_error := 've_validaciones_clientes_pg.ve_valid_imei('||EV_cod_serie||'); - ' ||SQLERRM;
             SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'GA', SV_mens_retorno,'1.0', USER, 've_validaciones_clientes_pg.ve_valid_imei',LV_sSql, SN_cod_retorno, LV_des_error);
             RETURN FALSE;
END ve_valid_imei;

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
           FUNCTION VE_valida_numcelular_FN(EV_numcelular    IN ga_aboamist.num_celular%TYPE,
                                               EV_situalta      IN ga_situabo.cod_situacion%TYPE,
                                            EV_num_serie     IN ga_aboamist.num_serie%TYPE,
                                            EV_tip_serie     IN CHAR,
                                            SN_cod_retorno   OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                                            SV_mens_retorno  OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                                            SN_num_evento    OUT NOCOPY ge_errores_pg.Evento) RETURN BOOLEAN IS

              error_ejecucion     EXCEPTION;
              LV_sql              ge_errores_pg.vQuery;
              LV_des_error        ge_errores_pg.DesEvent;
              LV_serieaux         ga_aboamist.num_serie%TYPE;

              BEGIN

                SN_cod_retorno := '0';
                SN_num_evento  :=  0;
                SV_mens_retorno:= '0';

                IF TRIM(EV_tip_serie)='S' THEN
                    LV_sql:='SELECT s.num_serie ';
                    LV_sql:=LV_sql || 'FROM   ga_aboamist s ';
                    LV_sql:=LV_sql || 'WHERE  s.num_celular=' || EV_numcelular;
                    LV_sql:=LV_sql || ' AND s.cod_situacion=' || EV_situalta;
                    LV_sql:=LV_sql || ' UNION ';
                    LV_sql:=LV_sql || 'SELECT s.num_serie ';
                    LV_sql:=LV_sql || 'FROM   ga_abocel s ';
                    LV_sql:=LV_sql || 'WHERE  s.num_celular=' || EV_numcelular;
                    LV_sql:=LV_sql || ' AND s.cod_situacion=' || EV_situalta;

                    SELECT s.num_serie
                    INTO   LV_serieaux
                    FROM   ga_aboamist s
                    WHERE  s.num_celular=EV_numcelular
                             AND s.cod_situacion=EV_situalta
                    UNION
                    SELECT s.num_serie
                    FROM   ga_abocel s
                    WHERE  s.num_celular=EV_numcelular
                           AND s.cod_situacion=EV_situalta;

                    IF LV_serieaux<>EV_num_serie THEN
                       SN_cod_retorno := 156; --ERROR_NUM_CELULAR_DUPLICADO
                       RAISE error_ejecucion;
                    END IF;

                    RETURN(TRUE);
                ELSIF TRIM(EV_tip_serie)='T' THEN
                    LV_sql:='SELECT s.num_imei ';
                    LV_sql:=LV_sql || 'FROM   ga_aboamist s ';
                    LV_sql:=LV_sql || 'WHERE  s.num_celular=' || EV_numcelular;
                    LV_sql:=LV_sql || ' AND s.cod_situacion=' || EV_situalta;
                    LV_sql:=LV_sql || ' UNION ';
                    LV_sql:=LV_sql || 'SELECT s.num_imei ';
                    LV_sql:=LV_sql || 'FROM   ga_abocel s ';
                    LV_sql:=LV_sql || 'WHERE  s.num_celular=' || EV_numcelular;
                    LV_sql:=LV_sql || ' AND s.cod_situacion=' || EV_situalta;

                    SELECT s.num_imei
                    INTO   LV_serieaux
                    FROM   ga_aboamist s
                    WHERE  s.num_celular=EV_numcelular
                             AND s.cod_situacion=EV_situalta
                    UNION
                    SELECT s.num_imei
                    FROM   ga_abocel s
                    WHERE  s.num_celular=EV_numcelular
                           AND s.cod_situacion=EV_situalta;

                    IF LV_serieaux<>EV_num_serie THEN
                       SN_cod_retorno := 156; --ERROR_NUM_CELULAR_DUPLICADO
                       RAISE error_ejecucion;
                    END IF;

                    RETURN(TRUE);
                 END IF;

                EXCEPTION
                 WHEN error_ejecucion THEN
                      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                         SV_mens_retorno := CV_error_no_clasif;
                      END IF;
                      LV_des_error  := 've_validaciones_clientes_pg.VE_valida_numcelular_FN(' || EV_numcelular || ',' || EV_situalta || ',' || EV_num_serie || ',' ||EV_tip_serie || '); - ' || SQLERRM;
                      SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'GA', SV_mens_retorno, '1.1', USER,'ve_validaciones_clientes_pg.ve_valida_pr', LV_sql,SQLCODE, LV_des_error );
                      RETURN(FALSE);
                 WHEN NO_DATA_FOUND THEN
                     SN_cod_retorno := 156; --ERROR_NUM_CELULAR_NO_EXISTE
                     IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                         SV_mens_retorno := CV_error_no_clasif;
                      END IF;
                      LV_des_error  := 've_validaciones_clientes_pg.VE_valida_numcelular_FN(' || EV_numcelular || ',' || EV_situalta || ',' || EV_num_serie || ',' ||EV_tip_serie || '); - ' || SQLERRM;
                      SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'GA', SV_mens_retorno, '1.1', USER,'ve_validaciones_clientes_pg.ve_valida_pr', LV_sql,SQLCODE, LV_des_error );
                      RETURN(FALSE);

                 WHEN TOO_MANY_ROWS THEN
                     SN_cod_retorno := 156; --ERROR_NUM_CELULAR_DUPLICADO
                     IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                         SV_mens_retorno := CV_error_no_clasif;
                      END IF;
                      LV_des_error  := 've_validaciones_clientes_pg.VE_valida_numcelular_FN(' || EV_numcelular || ',' || EV_situalta || ',' || EV_num_serie || ',' ||EV_tip_serie || '); - ' || SQLERRM;
                      SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'GA', SV_mens_retorno, '1.1', USER,'ve_validaciones_clientes_pg.ve_valida_pr', LV_sql,SQLCODE, LV_des_error );
                      RETURN(FALSE);

                WHEN OTHERS THEN
                      SN_cod_retorno := 156;  -- ERROR General
                      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                         SV_mens_retorno := CV_error_no_clasif;
                      END IF;
                      LV_des_error  := 've_validaciones_clientes_pg.VE_valida_numcelular_FN(' || EV_numcelular || ',' || EV_situalta || ',' || EV_num_serie || ',' ||EV_tip_serie || '); - ' || SQLERRM;
                      SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'GA', SV_mens_retorno, '1.1', USER,'ve_validaciones_clientes_pg.ve_valida_pr', LV_sql,SQLCODE, LV_des_error );
                      RETURN(FALSE);

           END VE_valida_numcelular_FN;

           /* -------------------------------------------------------------------------------------------- */


FUNCTION VE_valida_existe_imei2_FN(EV_imei          IN ga_aboamist.num_imei%TYPE,
                                                EV_situabaja      IN ga_situabo.cod_situacion%TYPE,
                                             SN_cod_retorno   OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                                             SV_mens_retorno  OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                                             SN_num_evento    OUT NOCOPY ge_errores_pg.Evento) RETURN BOOLEAN IS

              error_ejecucion     EXCEPTION;
              error_scl              EXCEPTION;
              LV_sql              ge_errores_pg.vQuery;
              LV_des_error        ge_errores_pg.DesEvent;
              LV_iccaux           ga_aboamist.num_serie%TYPE;
              LN_record              NUMBER(3);
              SN_EXISTE_EN_SCL    NUMBER;
              V_ERROR             NUMBER;

              BEGIN

                SN_cod_retorno := '0';
                SN_num_evento  :=  0;
                SV_mens_retorno:= '0';

                --Llamar a PL que verifica repeticion de series...


                                VE_VALIDA_REPETICION_GSM_PR(EV_imei,V_ERROR);

                                IF V_ERROR=2 THEN
                                   SN_cod_retorno := 760; --ERROR_EXISTEN_MUCHAS REPETICIONES
                   RAISE error_ejecucion;
                                END IF;

                --INICIO:XO-200510140878 ; USER: JEIM; 17/10/2005
                SELECT COUNT(1) --COMPRUEBA LA EXISTENCIA EN SCL
                INTO SN_EXISTE_EN_SCL
                FROM AL_SERIES
                WHERE NUM_SERIE=TO_CHAR(EV_imei);

                IF SN_EXISTE_EN_SCL > 0 THEN
                   SN_cod_retorno := 523; --ERROR DE EXISTENCIA EN SCL
                   SV_mens_retorno:='Imei, se encuentra en Bodegas';
                   RAISE error_scl;

                END IF;
                --FIM:XO-200510140878 ; USER: JEIM; 17/10/2005

                RETURN(TRUE);

                EXCEPTION
                 WHEN error_scl THEN
                      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                         SV_mens_retorno := CV_error_no_clasif;
                      END IF;
                      LV_des_error  := 've_validaciones_clientes_pg.VE_valida_existe_imei_FN(' || EV_imei || ',' || EV_situabaja || '); - ' || SQLERRM;
                      SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'GA', SV_mens_retorno, '1.1', USER,'ve_validaciones_clientes_pg.ve_valida_pr', LV_sql,SQLCODE, LV_des_error );
                      RETURN(FALSE);

                 WHEN error_ejecucion THEN
                      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                         SV_mens_retorno := CV_error_no_clasif;
                      END IF;
                      LV_des_error  := 've_validaciones_clientes_pg.VE_valida_existe_imei_FN(' || EV_imei || ',' || EV_situabaja || '); - ' || SQLERRM;
                      SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'GA', SV_mens_retorno, '1.1', USER,'ve_validaciones_clientes_pg.ve_valida_pr', LV_sql,SQLCODE, LV_des_error );
                      RETURN(FALSE);

                 WHEN OTHERS THEN
                      SN_cod_retorno := 156;  -- ERROR General
                      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                         SV_mens_retorno := CV_error_no_clasif;
                      END IF;
                      LV_des_error  := 've_validaciones_clientes_pg.VE_valida_existe_imei_FN(' || EV_imei || ',' || EV_situabaja || ')--' || SQLERRM;
                      SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'GA', SV_mens_retorno, '1.1', USER,'ve_validaciones_clientes_pg.ve_valida_pr', LV_sql,SQLCODE, LV_des_error );
                      RETURN(FALSE);

END VE_valida_existe_imei2_FN;
-----------------------------------------------------------------------------------------------------------------------------------

           FUNCTION VE_obtiene_numcelular_FN(EV_situalta      IN  ga_situabo.cod_situacion%TYPE,
                                                EV_serie         IN  ga_aboamist.num_serie%TYPE,
                                             EV_tipo_serie    IN  CHAR,
                                                SV_numcelular    OUT NOCOPY ga_abocel.num_celular%TYPE,
                                                SN_cod_retorno   OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                                             SV_mens_retorno  OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                                             SN_num_evento    OUT NOCOPY ge_errores_pg.Evento) RETURN BOOLEAN IS

              LV_sql              ge_errores_pg.vQuery;
              LV_des_error        ge_errores_pg.DesEvent;

              BEGIN

                SN_cod_retorno := '0';
                SN_num_evento  :=  0;
                SV_mens_retorno:= '0';

                IF TRIM(EV_tipo_serie)='S' THEN
                    LV_sql:='SELECT j.num_celular ';
                    LV_sql:= LV_sql || 'FROM   ga_aboamist j ';
                    LV_sql:= LV_sql || 'WHERE  j.num_serie=' || EV_serie;
                    LV_sql:= LV_sql || ' AND j.cod_situacion=' || EV_situalta;
                    LV_sql:= LV_sql || ' UNION ';
                    LV_sql:= LV_sql || 'SELECT j.num_celular ';
                    LV_sql:= LV_sql || 'FROM   ga_abocel j ';
                    LV_sql:= LV_sql || 'WHERE  j.num_serie=' || EV_serie;
                    LV_sql:= LV_sql || ' AND j.cod_situacion=' || EV_situalta;

                    SELECT j.num_celular
                    INTO   SV_numcelular
                    FROM   ga_aboamist j
                    WHERE  j.num_serie=EV_serie
                             AND j.cod_situacion=EV_situalta
                    UNION
                    SELECT j.num_celular
                    FROM   ga_abocel j
                    WHERE  j.num_serie=EV_serie
                             AND j.cod_situacion=EV_situalta;

                    RETURN(TRUE);
                ELSIF TRIM(EV_tipo_serie)='T' THEN
                    LV_sql:='SELECT j.num_celular ';
                    LV_sql:= LV_sql || 'FROM   ga_aboamist j ';
                    LV_sql:= LV_sql || 'WHERE  j.num_imei=' || EV_serie;
                    LV_sql:= LV_sql || ' AND j.cod_situacion=' || EV_situalta;
                    LV_sql:= LV_sql || ' UNION ';
                    LV_sql:= LV_sql || 'SELECT j.num_celular ';
                    LV_sql:= LV_sql || 'FROM   ga_abocel j ';
                    LV_sql:= LV_sql || 'WHERE  j.num_imei=' || EV_serie;
                    LV_sql:= LV_sql || ' AND j.cod_situacion=' || EV_situalta;

                    SELECT j.num_celular
                    INTO   SV_numcelular
                    FROM   ga_aboamist j
                    WHERE  j.num_imei=EV_serie
                             AND j.cod_situacion=EV_situalta
                    UNION
                    SELECT j.num_celular
                    FROM   ga_abocel j
                    WHERE  j.num_imei=EV_serie
                             AND j.cod_situacion=EV_situalta;

                    RETURN(TRUE);
                END IF;

                EXCEPTION
                    WHEN NO_DATA_FOUND THEN
                          IF TRIM(EV_tipo_serie)='T' THEN
                              RETURN(TRUE);
                          ELSE
                              SN_cod_retorno := 470; --ERROR_ICC_NO_EXISTE
                              IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                                 SV_mens_retorno := CV_error_no_clasif;
                              END IF;

                              LV_des_error  := 've_validaciones_clientes_pg.VE_obtiene_numcelular_FN(' || EV_situalta || ',' || EV_serie || ',' || EV_tipo_serie || '); -' || SQLERRM;
                              SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'GA', SV_mens_retorno, '1.1', USER,'ve_validaciones_clientes_pg.ve_valida_pr',LV_sql, SQLCODE, LV_des_error );
                              RETURN(FALSE);
                          END IF;
                     WHEN TOO_MANY_ROWS THEN
                         SN_cod_retorno := 156; --ERROR_ICC_DUPLICADA
                         IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                             SV_mens_retorno := CV_error_no_clasif;
                          END IF;

                          LV_des_error  := 've_validaciones_clientes_pg.VE_obtiene_numcelular_FN(' || EV_situalta || ',' || EV_serie || ',' || EV_tipo_serie || '); - '|| SQLERRM;
                          SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'GA', SV_mens_retorno, '1.1', USER,'ve_validaciones_clientes_pg.ve_valida_pr', LV_sql,SQLCODE, LV_des_error );
                          RETURN(FALSE);

                     WHEN OTHERS THEN
                          SN_cod_retorno := 156;  -- ERROR General
                          IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                             SV_mens_retorno := CV_error_no_clasif;
                          END IF;

                          LV_des_error  := 've_validaciones_clientes_pg.VE_obtiene_numcelular_FN(' || EV_situalta || ',' || EV_serie || ',' || EV_tipo_serie || '); - '|| SQLERRM;
                          SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'GA', SV_mens_retorno, '1.1', USER,'ve_validaciones_clientes_pg.ve_valida_pr', LV_sql,SQLCODE, LV_des_error );
                          RETURN(FALSE);

              END VE_obtiene_numcelular_FN;
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
FUNCTION VE_obtiene_situacion_FN(EV_des_situacion IN  ga_situabo.des_situacion%TYPE,
                                               SV_cod_situacion OUT NOCOPY ga_situabo.cod_situacion%TYPE,
                                            SN_cod_retorno   OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                                            SV_mens_retorno  OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                                            SN_num_evento    OUT NOCOPY ge_errores_pg.Evento) RETURN BOOLEAN IS

              LV_sql              ge_errores_pg.vQuery;
              LV_des_error        ge_errores_pg.DesEvent;

              BEGIN

                SN_cod_retorno := '0';
                SN_num_evento  :=  0;
                SV_mens_retorno:= '0';

                LV_sql:= 'SELECT j.cod_situacion ';
                LV_sql:= LV_sql || 'FROM   ga_situabo j ';
                LV_sql:= LV_sql || 'WHERE  j.des_situacion=' || EV_des_situacion;

                SELECT j.cod_situacion
                INTO   SV_cod_situacion
                FROM   ga_situabo j
                WHERE  j.des_situacion=EV_des_situacion;

                RETURN(TRUE);

                EXCEPTION
                     WHEN NO_DATA_FOUND THEN
                          SN_cod_retorno := 156; --ERROR_NO_DATA_GA_SITUABO
                          IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                             SV_mens_retorno := CV_error_no_clasif;
                          END IF;
                          LV_des_error  := 've_validaciones_clientes_pg.VE_obtiene_situacion_FN(' || EV_des_situacion || '); - ' || SQLERRM;
                          SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'GA', SV_mens_retorno, '1.1', USER,'ve_validaciones_clientes_pg.ve_valida_pr', LV_sql,SQLCODE, LV_des_error );
                          RETURN(FALSE);

                     WHEN TOO_MANY_ROWS THEN
                          SN_cod_retorno := 156; --ERROR_SITUACION_REPETIDA
                          IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                             SV_mens_retorno := CV_error_no_clasif;
                          END IF;
                          LV_des_error  := 've_validaciones_clientes_pg.VE_obtiene_situacion_FN(' || EV_des_situacion || '); - ' || SQLERRM;
                          SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'GA', SV_mens_retorno, '1.1', USER,'ve_validaciones_clientes_pg.ve_valida_pr', LV_sql, SQLCODE, LV_des_error );
                          RETURN(FALSE);

                     WHEN OTHERS THEN
                          SN_cod_retorno := 156;  -- ERROR General
                          IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                             SV_mens_retorno := CV_error_no_clasif;
                          END IF;
                          LV_des_error  := 've_validaciones_clientes_pg.VE_obtiene_situacion_FN(' || EV_des_situacion || '); - ' || SQLERRM;
                          SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'GA', SV_mens_retorno, '1.1', USER,'ve_validaciones_clientes_pg.ve_valida_pr', LV_sql, SQLCODE, LV_des_error );
                          RETURN(FALSE);

           END VE_obtiene_situacion_FN;

----------------------------------------------------------------------------------------------------------------------------------------------------------------

FUNCTION ve_valida_bodega_fn(EN_cod_vendedor    IN ve_vendealer.cod_vendealer%TYPE,
                             EN_cod_bodega       IN al_series.cod_bodega%TYPE,
                             SN_cod_retorno      OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                             SV_mens_retorno     OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                             SN_num_evento       OUT NOCOPY ge_errores_pg.Evento)
RETURN BOOLEAN AS
/* <Documentación TipoDoc = "FUNCTION">
     <Elemento
       Nombre = "ve_valida_bodega_fn"
       Lenguaje="PL/SQL"
       Fecha="11-11-2005"
       Versión="1.0"
       Diseñador="Rayen Ceballos"
       Programador="Vladimir Maureira"
       Ambiente="DEIMOS_ANDINA">
      <Retorno>BOOLEAN</Retorno>
      <Descripción> Validacion del IMEI</Descripción>
      <Parámetros>
         <Entrada>
            <param nom="EN_cod_vendedor"  Tipo="CARACTER">numero del imei</param>
            <param nom="EN_cod_bodega"    Tipo="NUMERICO">Codigo bodega </param>
         </Entrada>
         <Salida>
            <param nom="SN_cod_retorno"   Tipo="NUMERICO">Codigo error de negocio Retornado</param>
            <param nom="SV_mens_retorno"  Tipo="CARACTER">Mensaje error de negocio Retornado</param>
            <param nom="SN_num_evento"    Tipo="NUMERICO">Numero del Evento</param>
         </Salida>
      </Parámetros>
     </Elemento>
</Documentación> */

error_              EXCEPTION;
LV_sql              ge_errores_pg.vQuery;
LV_des_error        ge_errores_pg.DesEvent;
CN_cero             CONSTANT NUMBER(1) := 0;
TN_count            NUMBER;
BEGIN
           SN_cod_retorno := '0';
           SN_num_evento  :=  0;
           SV_mens_retorno:= '0';

                 LV_sql := 'SELECT count(1) ';
                 LV_sql := LV_sql || 'FROM ve_vendalmac ve ';
                 LV_sql := LV_sql || 'WHERE ve.cod_vendedor = ' || EN_cod_vendedor;
                 LV_sql := LV_sql || ' AND  ve.cod_bodega   = ' || EN_cod_bodega;
                 LV_sql := LV_sql || ' AND  ve.fec_asignacion < SYSDATE ';
                 LV_sql := LV_sql || ' AND (ve.fec_desasignac > SYSDATE OR ve.fec_desasignac IS NULL)';

           IF EN_cod_vendedor IS NOT NULL AND EN_cod_bodega IS NOT NULL THEN
                 SELECT count(1)
                 INTO   TN_count
                 FROM ve_vendalmac ve
                 WHERE ve.cod_vendedor = EN_cod_vendedor
                 AND   ve.cod_bodega   = EN_cod_bodega
                 AND   ve.fec_asignacion <= SYSDATE
                 AND   ( ve.fec_desasignac > SYSDATE OR ve.fec_desasignac IS NULL);

                 IF TN_count = CN_cero THEN
                     SN_cod_retorno:= 548;
                     RAISE error_;
                  END IF;
           ELSE
             SN_cod_retorno:= 300003; --El parametro no puede ser NULL
             RAISE error_;
           END IF;

           RETURN TRUE;
EXCEPTION
   WHEN error_  THEN
       IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
              SV_mens_retorno := CV_error_no_clasif;
       END IF;
       LV_des_error  := 've_validaciones_clientes_pg.ve_valida_bodega_fn(' || EN_cod_vendedor ||','||EN_cod_bodega|| '); - ' || SQLERRM;
       SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'GA', SV_mens_retorno, '1.1', USER,'ve_validaciones_clientes_pg.ve_valida_bodega_fn', LV_sql, SQLCODE,
LV_des_error );
       RETURN FALSE;

   WHEN OTHERS THEN
       SN_cod_retorno:= 302; --No fue posible ejecutar el servicio. Intente nuevamente
       IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
              SV_mens_retorno := CV_error_no_clasif;
       END IF;

       LV_des_error  := 've_validaciones_clientes_pg.ve_valida_bodega_fn(' || EN_cod_vendedor ||','||EN_cod_bodega|| '); - ' || SQLERRM;
       SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'GA', SV_mens_retorno, '1.1', USER,'ve_validaciones_clientes_pg.ve_valida_bodega_fn', LV_sql, SQLCODE,
LV_des_error );
       RETURN FALSE;
END ve_valida_bodega_fn;
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

FUNCTION ve_obtiene_vendedor_fn(EN_cod_vendealer    IN ve_vendealer.cod_vendealer%TYPE,
                                SN_cod_vendedor     OUT NOCOPY ve_vendealer.cod_vendedor%TYPE,
                                SN_cod_retorno      OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                                SV_mens_retorno     OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                                SN_num_evento       OUT NOCOPY ge_errores_pg.Evento)
RETURN BOOLEAN AS
/* <Documentación TipoDoc = "FUNCTION">
     <Elemento
       Nombre = "ve_obtiene_vendedor_fn"
       Lenguaje="PL/SQL"
       Fecha="11-11-2005"
       Versión="1.0"
       Diseñador="Rayen Ceballos"
       Programador="Vladimir Maureira"
       Ambiente="DEIMOS_ANDINA">
      <Retorno>BOOLEAN</Retorno>
      <Descripción> Validacion del IMEI</Descripción>
      <Parámetros>
         <Entrada>
            <param nom="EN_cod_vendealer"  Tipo="CARACTER">codigo vendedor dealer</param>
         </Entrada>
         <Salida>
            <param nom="SN_cod_vendedor"    Tipo="NUMERICO">codigo vendedor  </param>
            <param nom="SN_cod_retorno"   Tipo="NUMERICO">Codigo error de negocio Retornado</param>
            <param nom="SV_mens_retorno"  Tipo="CARACTER">Mensaje error de negocio Retornado</param>
            <param nom="SN_num_evento"    Tipo="NUMERICO">Numero del Evento</param>
         </Salida>
      </Parámetros>
     </Elemento>
</Documentación> */

error_              EXCEPTION;
LV_sql              ge_errores_pg.vQuery;
LV_des_error        ge_errores_pg.DesEvent;
BEGIN
           SN_cod_retorno := '0';
           SN_num_evento  :=  0;
           SV_mens_retorno:= '0';

           LV_sql :='SELECT ve.cod_vendedor ';
           LV_sql :=LV_sql || 'FROM ve_vendealer ve  ';
           LV_sql :=LV_sql || 'WHERE ve.cod_vendealer = ' || EN_cod_vendealer;

           IF EN_cod_vendealer IS NOT NULL THEN
                 SELECT ve.cod_vendedor
                 INTO   SN_cod_vendedor
                 FROM ve_vendealer ve
                 WHERE ve.cod_vendealer = EN_cod_vendealer;
           ELSE
             RAISE error_;
           END IF;

           RETURN TRUE;
EXCEPTION
   WHEN error_ THEN
       SN_cod_retorno:= 300003; --El parametro no puede ser NULL
       IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
              SV_mens_retorno := CV_error_no_clasif;
       END IF;

       LV_des_error  := 've_validaciones_clientes_pg.ve_obtiene_vendedor_fn(' || EN_cod_vendealer ||','||SN_cod_vendedor|| '); - ' || SQLERRM;
       SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'GA', SV_mens_retorno, '1.1', USER,'ve_validaciones_clientes_pg.ve_obtiene_vendedor_fn', LV_sql, SQLCODE,
LV_des_error );
       RETURN FALSE;

   WHEN NO_DATA_FOUND THEN
      SN_cod_retorno:= 476; --Vendedor no existe
       IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
              SV_mens_retorno := CV_error_no_clasif;
       END IF;

       LV_des_error  := 've_validaciones_clientes_pg.ve_obtiene_vendedor_fn(' || EN_cod_vendealer ||','||SN_cod_vendedor|| '); - ' || SQLERRM;
       SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'GA', SV_mens_retorno, '1.1', USER,'ve_validaciones_clientes_pg.ve_obtiene_vendedor_fn', LV_sql, SQLCODE,
LV_des_error );
       RETURN FALSE;
   WHEN OTHERS THEN
       SN_cod_retorno:= 302; --No fue posible ejecutar el servicio. Intente nuevamente
       IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
              SV_mens_retorno := CV_error_no_clasif;
       END IF;

       LV_des_error  := 've_validaciones_clientes_pg.ve_obtiene_vendedor_fn(' || EN_cod_vendealer ||','||SN_cod_vendedor|| '); - ' || SQLERRM;
       SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'GA', SV_mens_retorno, '1.1', USER,'ve_validaciones_clientes_pg.ve_obtiene_vendedor_fn', LV_sql, SQLCODE,
LV_des_error );
       RETURN FALSE;
END ve_obtiene_vendedor_fn;

----------------------------------------------------------------------------------------------------------------------------------------------------------------

FUNCTION ve_obtiene_codigo_fn( EV_cod_modulo     IN ged_codigos.cod_modulo%TYPE,
                               EV_nom_tabla      IN ged_codigos.nom_tabla%TYPE,
                               EV_nom_columna    IN ged_codigos.nom_columna%TYPE,
                               EV_cod_valor      IN ged_codigos.cod_valor%TYPE,
                               SN_cod_retorno    OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                               SV_mens_retorno   OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                               SN_num_evento     OUT NOCOPY ge_errores_pg.Evento)
RETURN BOOLEAN IS
/*
<Documentación
  TipoDoc = "Funcion">
   <Elemento
      Nombre = "VE_OBTIENE_CODIGO_FN"
      Lenguaje="PL/SQL"
      Fecha="11-11-2005"
      Versión="1.0"
      Diseñador="rayen ceballos"
      Programador="Vladimir Maureira"
      Ambiente Desarrollo="DEIMOS_ANDINA">
      <Retorno>NA</Retorno>
     <Descripción>Procedimiento que permite validar parametros ged_codigos</Descripción>
      <Parámetros>
         <Entrada>
            <param nom="EV_cod_modulo"      Tipo="CARACTER">Modulo</param>
            <param nom="EV_nom_tabla"       Tipo="CARACTER">Tabla</param>
            <param nom="EV_nom_columna"     Tipo="CARACTER">Columna</param>
            <param nom="EV_cod_valor"       Tipo="CARACTER">Columna</param>
         </Entrada>
         <Salida>
            <param nom="SN_cod_retorno"     Tipo="NUMERICO">Codigo de Retorno</param>
            <param nom="SV_mens_retorno"    Tipo="CARACTER">Mensaje de Retorno</param>
            <param nom="SN_num_evento"      Tipo="ge_errores_pg.Evento">Detalle de eventos</param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
error_               EXCEPTION;
LV_des_error         ge_errores_pg.DesEvent;
LV_sSql              ge_errores_pg.vQuery;
TN_count             NUMBER;
CN_cero              CONSTANT NUMBER(1) := 0;
BEGIN
        SN_num_evento   := 0;
        SN_cod_retorno  := 0;
        SV_mens_retorno := '';

        LV_sSql := '   SELECT 1 ';
        LV_sSql := LV_sSql||' FROM ged_codigos gc ';
        LV_sSql := LV_sSql||' WHERE gc.cod_modulo = '||EV_cod_modulo;
        LV_sSql := LV_sSql||'   AND gc.nom_tabla  = '||EV_nom_tabla;
        LV_sSql := LV_sSql||'   AND gc.nom_columna= '||EV_nom_columna;
        LV_sSql := LV_sSql||'   AND gc.cod_valor  = '||EV_cod_valor;

        BEGIN
                SELECT 1
                INTO TN_count
                FROM ged_codigos gc
                WHERE gc.cod_modulo  = EV_cod_modulo
                AND gc.nom_tabla   = EV_nom_tabla
                AND gc.nom_columna = EV_nom_columna
                AND gc.cod_valor   = EV_cod_valor;

                IF TN_count = CN_cero THEN
                        SN_cod_retorno := 529; --Tipo de stock inválido para la operación
                        RAISE error_;
                END IF;
        END;

   RETURN TRUE;

        EXCEPTION
                WHEN error_ THEN
                        IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                                SV_mens_retorno := CV_error_no_clasif;
                        END IF;
                        LV_des_error := 've_validaciones_clientes_pg.ve_obtiene_codigo_fn('||EV_cod_modulo||','||EV_nom_tabla||','||EV_nom_columna||','||EV_cod_valor||'); - ' ||SQLERRM;
                        SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, EV_cod_modulo, SV_mens_retorno,'1.0', USER, 've_validaciones_clientes_pg.ve_obtiene_codigo_fn',LV_sSql, SN_cod_retorno, LV_des_error);
                        RETURN FALSE;
                WHEN OTHERS THEN
                        SN_cod_retorno := 529;
                        IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                                SV_mens_retorno := CV_error_no_clasif;
                        END IF;
                        LV_des_error := 've_validaciones_clientes_pg.ve_obtiene_codigo_fn('||EV_cod_modulo||','||EV_nom_tabla||','||EV_nom_columna||','||EV_cod_valor||'); - ' ||SQLERRM;
                        SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, EV_cod_modulo, SV_mens_retorno,'1.0', USER, 've_validaciones_clientes_pg.ve_obtiene_codigo_fn',LV_sSql, SN_cod_retorno, LV_des_error);
                        RETURN FALSE;
END ve_obtiene_codigo_fn;

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
FUNCTION ve_valida_serie_fn(EV_num_imei         IN ga_aboamist.num_serie%TYPE,
                            SN_cod_bodega       OUT NOCOPY al_series.cod_bodega%TYPE,
                            SN_tip_stock        OUT NOCOPY al_series.tip_stock%TYPE,
                            SN_cod_retorno      OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                            SV_mens_retorno     OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                            SN_num_evento       OUT NOCOPY ge_errores_pg.Evento)
RETURN BOOLEAN AS
/* <Documentación TipoDoc = "FUNCTION">
     <Elemento
       Nombre = "ve_valida_serie_fn"
       Lenguaje="PL/SQL"
       Fecha="11-11-2005"
       Versión="1.0"
       Diseñador="Rayen Ceballos"
       Programador="Vladimir Maureira"
       Ambiente="DEIMOS_ANDINA">
      <Retorno>BOOLEAN</Retorno>
      <Descripción> Validacion del IMEI</Descripción>
      <Parámetros>
         <Entrada>
            <param nom="EV_num_imei        " Tipo="CARACTER">numero del imei</param>
         </Entrada>
         <Salida>
            <param nom="SN_cod_bodega"     Tipo="NUMERICO">Codigo bodega </param>
            <param nom="SN_tip_stock"      Tipo="NUMERICO">Codigo tipo stock</param>
            <param nom="SN_cod_retorno"    Tipo="NUMERICO">Codigo error de negocio Retornado</param>
            <param nom="SV_mens_retorno"   Tipo="CARACTER">Mensaje error de negocio Retornado</param>
            <param nom="SN_num_evento"     Tipo="NUMERICO">Numero del Evento</param>
         </Salida>
      </Parámetros>
     </Elemento>
</Documentación> */

error_              EXCEPTION;
LV_sql              ge_errores_pg.vQuery;
LV_des_error        ge_errores_pg.DesEvent;
BEGIN
           SN_cod_retorno := '0';
           SN_num_evento  :=  0;
           SV_mens_retorno:= '0';

           LV_sql := 'SELECT al.cod_bodega,al.tip_stock ';
           LV_sql := LV_sql || 'FROM al_series al  ';
           LV_sql := LV_sql || 'WHERE al.num_serie = ' || EV_num_imei;

           IF EV_num_imei IS NOT NULL THEN
                 SELECT al.cod_bodega,
                        al.tip_stock
                 INTO   SN_cod_bodega,
                        SN_tip_stock
                 FROM al_series al
                 WHERE al.num_serie = EV_num_imei;
           ELSE
             RAISE error_;
           END IF;

           RETURN TRUE;
EXCEPTION
   WHEN error_  THEN
       SN_cod_retorno:= 300003; --El parametro no puede ser NULL
       IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
              SV_mens_retorno := CV_error_no_clasif;
       END IF;

       LV_des_error  := 've_validaciones_clientes_pg.ve_valida_serie_fn(' || EV_num_imei || '); - ' || SQLERRM;
       SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'GA', SV_mens_retorno, '1.1', USER,'ve_validaciones_clientes_pg.ve_valida_serie_fn', LV_sql, SQLCODE,
LV_des_error );
       RETURN FALSE;
   WHEN NO_DATA_FOUND THEN
       SN_cod_retorno:= 549; --IMEI, no es de procedencia interna
       IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
              SV_mens_retorno := CV_error_no_clasif;
       END IF;

       LV_des_error  := 've_validaciones_clientes_pg.ve_valida_serie_fn(' || EV_num_imei || '); - ' || SQLERRM;
       SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'GA', SV_mens_retorno, '1.1', USER,'ve_validaciones_clientes_pg.ve_valida_serie_fn', LV_sql, SQLCODE,
LV_des_error );
       RETURN FALSE;
   WHEN OTHERS THEN
       SN_cod_retorno:= 302; --No fue posible ejecutar el servicio. Intente nuevamente
       IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
              SV_mens_retorno := CV_error_no_clasif;
       END IF;

       LV_des_error  := 've_validaciones_clientes_pg.ve_valida_serie_fn(' || EV_num_imei || '); - ' || SQLERRM;
       SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'GA', SV_mens_retorno, '1.1', USER,'ve_validaciones_clientes_pg.ve_valida_serie_fn', LV_sql, SQLCODE,
LV_des_error );
       RETURN FALSE;
END ve_valida_serie_fn;

----------------------------------------------------------------------------------------------------------------------------------------------------------------

FUNCTION VE_validaClienteVetado_FN(EV_numident      IN  ge_clientes.num_ident%TYPE,
                                   EV_tipident      IN  ge_clientes.cod_tipident%TYPE,
                                   SN_cod_retorno   OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                                   SV_mens_retorno  OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                                   SN_num_evento    OUT NOCOPY ge_errores_pg.Evento)
RETURN BOOLEAN IS
/*
<Documentación TipoDoc = "function">
 <Elemento Nombre = "VE_validaClienteVetado_FN"
           Lenguaje="PL/SQL"
           Fecha="31-08-2005"
           Versión="1.0.0"
           Diseñador="Vladimir Maureira"
           Programador="Vladimir Maureira"
           Ambiente="DEIMOS_ANDINA">
  <Retorno>NA/Retorno>
   <Descripción> Determina si el cliente esta en lista negra /Descripción>
    <Parámetros>
     <Entrada>
      <param nom="EV_tipident" Tipo="STRING">Tipo identidad del cliente a verificar</param>
      <param nom="EV_numident" Tipo="STRING">Numero de identidad del cliente a verificar</param>
     </Entrada>
     <Salida>
      <param nom="SV_val_parametro" Tipo="CARACTER">Codigo de Retorno</param>
      <param nom="SV_mens_retorno"  Tipo="CARACTER">Mensaje de Retorno</param>
      <param nom="SN_num_evento"    Tipo="NUMERICO">Numero de Evento</param>
     </Salida>
    </Parámetros>
 </Elemento>
</Documentación>
*/
regla_ejecucion  EXCEPTION;
LN_count         NUMBER;
LV_des_error     ge_errores_pg.DesEvent;
LV_sql           ge_errores_pg.vQuery;
BEGIN
            SN_cod_retorno := 0;
            SN_num_evento  := 0;
            SV_mens_retorno:= '0';

            LV_sql := 'SELECT COUNT(1)';
            LV_sql := LV_sql || ' FROM   erd_clientes_vetados ve';
            LV_sql := LV_sql || ' WHERE  ve.num_ident_cliente =' || EV_numident;
            LV_sql := LV_sql || ' AND ve.cod_tipident =' || EV_tipident;
            LV_sql := LV_sql || ' AND SYSDATE BETWEEN ve.fec_modi_h AND NVL(ve.fec_hasta,SYSDATE)';

            SELECT COUNT(1)
            INTO   LN_count
            FROM   erd_clientes_vetados ve
            WHERE  ve.num_ident_cliente = EV_numident
              AND  ve.cod_tipident      = EV_tipident
              AND  SYSDATE BETWEEN ve.fec_modi_h AND NVL(ve.fec_hasta,SYSDATE);

            IF LN_count > 0 THEN
               SN_cod_retorno := 467; --ERROR_CLIENTE_VETADO
               RAISE regla_ejecucion;
            ELSE
               RETURN TRUE;
            END IF;
EXCEPTION
  WHEN regla_ejecucion THEN
     IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
        SV_mens_retorno := CV_error_no_clasif;
     END IF;

     LV_des_error  := 'VE_validaClienteVetado_FN(' || EV_tipident || ',' || EV_numident || '); - ' || SQLERRM;
     SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'GA', SV_mens_retorno, '1.1', USER,'VE_VALIDACLIENTE_PG.VE_validaClienteVetado_FN', LV_sql, SQLCODE, LV_des_error );

     RETURN FALSE;
  WHEN OTHERS THEN
     SN_cod_retorno := 156; --ERROR_GENERAL
     IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
        SV_mens_retorno := CV_error_no_clasif;
     END IF;

     LV_des_error  := 'VE_validaClienteVetado_FN(' || EV_tipident || ',' || EV_numident || '); - ' || SQLERRM;
     SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'GA', 'Error no clasificado', '1.1', USER,'VE_VALIDACLIENTE_PG.VE_validaClienteVetado_FN', LV_sql, SQLCODE, LV_des_error );

    RETURN FALSE;
END VE_validaClienteVetado_FN;

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
FUNCTION VE_validaClienteMoroso2_FN(EV_cod_cliente   IN ge_clientes.cod_cliente%TYPE,
                                   SN_cod_retorno   OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                                   SV_mens_retorno  OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                                   SN_num_evento    OUT NOCOPY ge_errores_pg.Evento)
RETURN NUMBER IS
/*
<Documentación TipoDoc = "function">
 <Elemento Nombre = "VE_validaClienteMoroso_FN"
           Lenguaje="PL/SQL"
           Fecha="31-08-2005"
           Versión="1.0.0"
           Diseñador="Vladimir Maureira"
           Programador="Vladimir Maureira"
           Ambiente="DEIMOS_ANDINA">
  <Retorno>NA/Retorno>
   <Descripción> Determina si el cliente es Moroso /Descripción>
    <Parámetros>
     <Entrada>
      <param nom="EV_cod_cliente" Tipo="STRING">Codigo cliente</param>
     </Entrada>
     <Salida>
      <param nom="SV_val_parametro" Tipo="CARACTER">Codigo de Retorno</param>
      <param nom="SV_mens_retorno"  Tipo="CARACTER">Mensaje de Retorno</param>
      <param nom="SN_num_evento"    Tipo="NUMERICO">Numero de Evento</param>
     </Salida>
    </Parámetros>
 </Elemento>
</Documentación>
*/
        regla_ejecucion  EXCEPTION;
        LN_total         NUMBER(14,4);
        LN_total1        NUMBER(14,4);
        LN_total2        NUMBER(14,4);
        LV_des_error     ge_errores_pg.DesEvent;
        LV_sql           ge_errores_pg.vQuery;
BEGIN
      SN_cod_retorno := 0;
      SN_num_evento  := 0;
      SV_mens_retorno:= '0';

          LV_sql := 'SELECT NVL(SUM(ca.importe_debe - ca.importe_haber),0) total ';
      LV_sql := LV_sql || 'FROM  co_cartera c, , ge_tipdocumen t, fa_histdocu h ';
      LV_sql := LV_sql || 'WHERE c.cod_cliente = ' || EV_cod_cliente;
      LV_sql := LV_sql || 'AND c.ind_facturado = 1';
      LV_sql := LV_sql || 'AND c.cod_tipdocum <> 39 ';
      LV_sql := LV_sql || 'AND c.importe_debe > c.importe_haber ';
      LV_sql := LV_sql || 'AND c.cod_tipdocum = t.cod_tipdocum ';
          LV_sql := LV_sql || 'AND h.cod_tipdocum = c.cod_tipdocum ';
          LV_sql := LV_sql || 'AND h.num_secuenci = c.num_secuenci ';
          LV_sql := LV_sql || 'AND h.cod_vendedor_agente = c.cod_vendedor_agente ';
          LV_sql := LV_sql || 'AND h.letra = c.letra ';
          LV_sql := LV_sql || 'AND h.cod_centremi = c.cod_centremi ';
          LV_sql := LV_sql || 'AND trunc(c.fec_vencimie) < trunc(sysdate -(select val_parametro1 from erd_parametros where cod_codigo = 1 and cod_subcodigo = 16 and cod_parametro = 1 ))';

          -- DEUDA
      LN_total1 := 0;
          SELECT NVL(SUM(c.importe_debe - c.importe_haber),0)
      INTO  LN_total1
      FROM  co_cartera c, ge_tipdocumen t, fa_histdocu h
          WHERE c.cod_cliente = EV_cod_cliente
        AND c.ind_facturado = 1
        AND c.cod_tipdocum <> 39
                AND c.importe_debe > c.importe_haber
        AND c.cod_tipdocum = t.cod_tipdocum
                AND h.cod_tipdocum = c.cod_tipdocum
                AND h.num_secuenci = c.num_secuenci
                AND h.cod_vendedor_agente = c.cod_vendedor_agente
                AND h.letra = c.letra
                AND h.cod_centremi = c.cod_centremi
        AND TRUNC(c.fec_vencimie) < TRUNC(SYSDATE -(SELECT p.val_parametro1
                                                            FROM erd_parametros p
                                                                                                        WHERE p.cod_codigo = 1
                                                                                                          AND p.cod_subcodigo = 16
                                                                                                          AND p.cod_parametro = 1 ));

      LV_sql := 'SELECT NVL(SUM(c.importe_debe - c.importe_haber),0) total';
          LV_sql := LV_sql || 'FROM co_cartera c';
          LV_sql := LV_sql || 'WHERE c.cod_cliente = ' || EV_cod_cliente;
          LV_sql := LV_sql || 'AND c.cod_tipdocum = 39';

          -- DEUDA CASTIGADA
      LN_total2 := 0;
      SELECT NVL(SUM(c.importe_debe - c.importe_haber),0)
      INTO  LN_total2
          FROM co_cartera c
      WHERE c.cod_cliente = EV_cod_cliente
        AND c.cod_tipdocum = 39;

      LN_total := LN_total1 + LN_total2;

      IF (LN_total > 0 ) THEN
         SN_cod_retorno := 466; --ERROR_CLIENTE_MOROSO
         RAISE regla_ejecucion;
      ELSE
         RETURN 0;
      END IF;
EXCEPTION
  WHEN regla_ejecucion THEN
     IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
        SV_mens_retorno := CV_error_no_clasif;
     END IF;
     LV_des_error  := 'VE_validaClienteMoroso_FN(' || EV_cod_cliente || '); - ' || SQLERRM;
     SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'GA', SV_mens_retorno, '1.1', USER,'VE_VALIDACLIENTE_PG.VE_validaClienteMoroso_FN', LV_sql, SQLCODE, LV_des_error );
     RETURN LN_TOTAL;
  WHEN OTHERS THEN
     SN_cod_retorno := 156; --ERROR_GENERAL
     IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
        SV_mens_retorno := CV_error_no_clasif;
     END IF;
     LV_des_error  := 'VE_validaClienteMoroso_FN(' || EV_cod_cliente || '); - ' || SQLERRM;
     SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'GA', 'Error no clasificado', '1.1', USER,'VE_VALIDACLIENTE_PG.VE_validaClienteMoroso_FN', LV_sql, SQLCODE, LV_des_error );
     RETURN 0;
END VE_validaClienteMoroso2_FN;


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

Procedure ve_valida_cliente_moroso_pr(EV_tipident      IN  ge_clientes.cod_tipident%TYPE,
                                      EV_numident      IN  ge_clientes.num_ident%TYPE,
                                      SN_Monto         OUT NOCOPY NUMBER,
                                      SN_cod_retorno   OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                                      SV_mens_retorno  OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                                      SN_num_evento    OUT NOCOPY ge_errores_pg.Evento)
IS
/*
<Documentación TipoDoc = "procedure">
 <Elemento Nombre = "VE_valida_PR"
           Lenguaje="PL/SQL"
           Fecha="14-04-2008"
           Versión="1.1.0"
           Diseñador="NRCA"
           Programador="NRCA"
           Ambiente="DEIMOS_ANDINA">
  <Retorno>NA/Retorno>
   <Descripción> Determina si un cliente existe en la tabla de clientes ventas o lista negra /Descripción>
    <Parámetros>
     <Entrada>
      <param nom="EV_tipident" Tipo="STRING">Tipo identidad del cliente a verificar</param>
      <param nom="EV_numident" Tipo="STRING">Numero de identidad del cliente a verificar</param>
     </Entrada>
     <Salida>
      <param nom="SN_MONTO" Tipo="NUMBER">Codigo de Retorno</param>
          <param nom="SV_val_parametro" Tipo="CARACTER">Codigo de Retorno</param>
      <param nom="SV_mens_retorno"  Tipo="CARACTER">Mensaje de Retorno</param>
      <param nom="SN_num_evento"    Tipo="NUMERICO">Numero de Evento</param>
     </Salida>
    </Parámetros>
 </Elemento>
</Documentación>
*/
    LV_DESC_ERROR    VARCHAR2(3000);
    SN_ERROR         NUMBER(6);
    LN_MONTO         NUMBER;
    error_num_ident  EXCEPTION;
    error_ejecucion  EXCEPTION;
    LV_codcliente    ge_clientes.cod_cliente%TYPE;
    LV_sql           ge_errores_pg.vQuery;
    LV_des_error     ge_errores_pg.DesEvent;
    LV_valnit        VARCHAR2(200):='';
    TYPE TYP_cliente IS TABLE OF ge_clientes.cod_cliente%TYPE INDEX BY BINARY_INTEGER;
    C_clientes       TYP_cliente;

    CURSOR clientes_cu (EV_numident IN ge_clientes.num_ident%TYPE,EV_tipident IN ge_clientes.cod_tipident%TYPE)
    IS
    SELECT c.cod_cliente
    FROM   ge_clientes c
    WHERE  c.num_ident   = EV_numident
      AND  c.cod_tipident = EV_tipident;
BEGIN
      SN_cod_retorno :=  0;
      SN_num_evento  :=  0;
      SV_mens_retorno:= '0';

      LV_sql := 'VE_validacion_PG.VE_validanit_FN( ' || EV_numident || ',' || EV_tipident || ')';
      LV_valnit:=VE_validacion_PG.VE_validanit_FN(EV_numident, EV_tipident);
      IF SUBSTR(TRIM(UPPER(LV_valnit)), 1, 5)='ERROR' OR LV_valnit IS NULL THEN
         SN_cod_retorno := 469; -- ERROR_NUM_IDENT
         LV_sql :=LV_valnit;
         RAISE error_num_ident;
      END IF;

      IF NOT VE_validaClienteVetado_FN(EV_numident,EV_tipident,SN_cod_retorno,SV_mens_retorno,SN_num_evento) THEN
         RAISE error_ejecucion;
      END IF;

      LV_sql := 'SELECT c.cod_cliente';
      LV_sql := LV_sql || ' FROM   ge_clientes c';
      LV_sql := LV_sql || ' WHERE  c.num_ident =''' || EV_numident || '''';
      LV_sql := LV_sql || ' AND  c.cod_tipident=''' || EV_tipident || '''';

      LN_MONTO:=0;
      SN_MONTO:=0;

      FOR C_clientes IN clientes_cu (EV_numident,EV_tipident) LOOP

                   LN_MONTO := VE_validaClienteMoroso2_FN(C_clientes.cod_cliente,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
                   SN_MONTO := SN_MONTO + LN_MONTO;

           IF SN_COD_RETORNO>0 THEN
              SN_ERROR:=SN_COD_RETORNO;
           END IF;
           IF SV_MENS_RETORNO <> '0' THEN
              LV_DESC_ERROR:=SV_MENS_RETORNO;
           END IF;
      END LOOP;

      IF SN_MONTO > 0 THEN
         SN_COD_RETORNO := SN_ERROR;
         SV_MENS_RETORNO := LV_DESC_ERROR;
         RAISE error_ejecucion;
      END IF;

      LV_sql:='VE_RecuperaParametros_Sms_PG.VE_recupera_glosa_FN(' || CV_codmodulo || ',' || CV_nom_tabla || ',' || CV_nom_columna ||')';
      IF NOT Ve_Recuperaparametros_Sms_Pg.VE_recupera_glosa_FN(CV_codmodulo,CV_nom_tabla,CV_nom_columna,SV_mens_retorno,SN_cod_retorno,SV_mens_retorno,SN_num_evento) THEN
         SN_cod_retorno:=0;
         SV_mens_retorno:=NULL;
         RAISE error_ejecucion;
      END IF;

EXCEPTION
   WHEN error_num_ident THEN
        IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
           SV_mens_retorno := CV_error_no_clasif;
        END IF;
        LV_des_error  := 'VE_valida_PR(' || EV_tipident || ',' || EV_numident || '); - ' || SQLERRM;
        SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'GA', SV_mens_retorno, '1.1', USER,'VE_VALIDACLIENTE_PG.VE_valida_PR', LV_sql, SQLCODE, LV_des_error );
   WHEN error_ejecucion THEN
        LV_des_error  := 'VE_valida_PR(' || EV_tipident || ',' || EV_numident || '); - ' || SQLERRM;
        SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'GA', SV_mens_retorno, '1.1', USER,'VE_VALIDACLIENTE_PG.VE_valida_PR', LV_sql, SQLCODE, LV_des_error );
   WHEN OTHERS THEN
        SN_cod_retorno := 156;  -- ERROR General
        IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
           SV_mens_retorno := CV_error_no_clasif;
        END IF;
        LV_des_error  := 'VE_valida_PR(' || EV_tipident || ',' || EV_numident || '); - ' || SQLERRM;
        SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'GA', 'Error no clasificado', '1.1', USER,'VE_VALIDACLIENTE_PG.VE_valida_PR', LV_sql, SQLCODE, LV_des_error );
END ve_valida_cliente_moroso_pr;

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

PROCEDURE ve_valida_imei_pr(EV_num_imei         IN ga_aboamist.num_serie%TYPE,
                            EN_cod_vendedor     IN ve_vendealer.cod_vendealer%TYPE,
                            EV_cod_canal        IN CHAR,
                            EV_cod_procediencia IN CHAR,
                            SN_cod_retorno      OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                            SV_mens_retorno     OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                            SN_num_evento       OUT NOCOPY ge_errores_pg.Evento) IS

/* <Documentación TipoDoc = "PROCEDURE">
     <Elemento
       Nombre = "VE_valida_imei_PR
       Lenguaje="PL/SQL"
       Fecha="15-06-2005"
       Versión="1.0"
       Diseñador="Rayen Ceballos"
       Programador="Roberto Perez"
       Ambiente="DEIMOS_ANDINA">
      <Retorno>N/A</Retorno>
      <Descripción> Validacion del IMEI</Descripción>
      <Parámetros>
         <Entrada>
            <param nom="EV_num_imei        " Tipo="CARACTER">numero del imei</param>
            <param nom="EN_cod_vendedor    " Tipo="NUMERICO">Código del vendedor</param
            <param nom="EV_cod_canal       " Tipo="CARACTER">Canal del vendedor</param>
            <param nom="EV_cod_procediencia" Tipo="CARACTER">procedencia equipo</param>
         </Entrada>
         <Salida>
            <param nom="SN_cod_retorno"    Tipo="NUMERICO">Codigo error de negocio Retornado</param>
            <param nom="SV_mens_retorno"   Tipo="CARACTER">Mensaje error de negocio Retornado</param>
            <param nom="SN_num_evento"     Tipo="NUMERICO">Numero del Evento</param>
         </Salida>
      </Parámetros>
     </Elemento>
</Documentación> */

    LE_funcion          EXCEPTION;
    error_ejecucion     EXCEPTION;

    LB_retorno          BOOLEAN;
    LV_codterminal      ged_parametros.val_parametro%TYPE;
    LV_numcelular       ga_abocel.num_celular%TYPE;
    LV_situalta         ga_situabo.cod_situacion%TYPE;
    LV_sql              ge_errores_pg.vQuery;
    LV_des_error        ge_errores_pg.DesEvent;
    LN_largoimei        ga_aboamist.num_imei%TYPE;
    LV_situabaja        ga_situabo.cod_situacion%TYPE;
    LV_glosa_exito      ged_codigos.des_valor%TYPE;
    CV_procedencia      CONSTANT  CHAR:='I';
    CV_cod_canal        CONSTANT  CHAR:='I';
    SN_cod_bodega       al_series.cod_bodega%TYPE;
    SN_tip_stock        al_series.tip_stock%TYPE;
    SN_cod_vendedor     ve_vendealer.cod_vendedor%TYPE;
    TN_cod_vendedor     ve_vendealer.cod_vendedor%TYPE;
    LV_PARAMETRO VARCHAR2(1);

    -- + Requerimiento Adicional 05.06.2008
    LN_tipoStock           NUMBER;
        LN_codUso              NUMBER;
    LV_aplicaMayorista     VARCHAR2(100);
    LV_codigoUso           VARCHAR2(100);
    LV_descripcionUso      VARCHAR2(100);
    LV_codigoArticulo      VARCHAR2(100);
    LV_descripcionArticulo VARCHAR2(100);
    -- - Requerimiento Adicional 05.06.2008
    LV_existe_serie        VARCHAR2(10);



BEGIN
    SN_cod_retorno := '0';
    SN_num_evento  :=  0;
    SV_mens_retorno:= '0';

    LB_retorno:= ve_recuperaparametros_sms_pg.ve_recupera_parametros_fn('LARGO_SERIE_TGSM', 'AL', 1, LN_largoimei, SN_cod_retorno, SV_mens_retorno,SN_num_evento);
    IF NOT LB_retorno THEN
            RAISE LE_funcion;
    END IF;

    IF LENGTH(TRIM(EV_num_imei))<>TO_NUMBER(LN_largoimei) THEN
            SN_cod_retorno := 472; --ERROR_LARGO_IMSI
            RAISE error_ejecucion;
    END IF;

    IF TRIM(UPPER(EV_cod_procediencia))<>'I' AND TRIM(UPPER(EV_cod_procediencia))<>'E' THEN
            SN_cod_retorno := 156;--PROCEDENCIA INVALIDA
            RAISE error_ejecucion;
    END IF;

    IF TRIM(UPPER(EV_cod_canal))<>'I' AND TRIM(UPPER(EV_cod_canal))<>'D' THEN
            SN_cod_retorno := 156;--CANAL INVALIDO
            RAISE error_ejecucion;
    END IF;

    IF TRIM(UPPER(EV_cod_procediencia)) = CV_procedencia THEN

       LB_retorno :=ve_valida_serie_fn(EV_num_imei,SN_cod_bodega,SN_tip_stock,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
       IF NOT LB_retorno THEN
               RAISE LE_funcion;
       END IF;
       LB_retorno :=ve_obtiene_codigo_fn( 'GA','AL_TIPOS_STOCK','TIP_STOCK',SN_tip_stock,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
       IF NOT LB_retorno THEN
               RAISE LE_funcion;
       END IF;
       TN_cod_vendedor := TRIM(EN_cod_vendedor);
       IF EV_cod_canal = CV_cod_canal THEN
               LB_retorno :=ve_obtiene_vendedor_fn(EN_cod_vendedor,SN_cod_vendedor,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
               IF NOT LB_retorno THEN
                       RAISE LE_funcion;
               END IF;
               TN_cod_vendedor := SN_cod_vendedor;
       END IF;

       LB_retorno :=ve_valida_bodega_fn(TN_cod_vendedor,SN_cod_bodega,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
       IF NOT LB_retorno THEN
               RAISE LE_funcion;
       END IF;
    END IF;

    LB_retorno:=ve_obtiene_situacion_fn('ALTA ACTIVA DE ABONADO', LV_situalta, SN_cod_retorno, SV_mens_retorno, SN_num_evento);
    IF NOT LB_retorno THEN
            RAISE LE_funcion;
    END IF;

    IF TRIM(UPPER(EV_cod_procediencia)) = CV_procedencia THEN

       LB_retorno:=ve_obtiene_numcelular_fn(LV_situalta, EV_num_imei, 'T', LV_numcelular, SN_cod_retorno, SV_mens_retorno, SN_num_evento);
       IF NOT LB_retorno THEN
               RAISE LE_funcion;
       END IF;

       IF TRIM(LV_numcelular) IS NOT NULL THEN
               LB_retorno:=ve_valida_numcelular_fn(LV_numcelular,LV_situalta,EV_num_imei,'T',SN_cod_retorno,SV_mens_retorno,SN_num_evento);
               IF NOT LB_retorno THEN
                       RAISE LE_funcion;
               END IF;
       END IF;

    END IF;

    LB_retorno:=ve_obtiene_situacion_fn('BAJA ABONADO ACTIVA', LV_situabaja, SN_cod_retorno, SV_mens_retorno, SN_num_evento);
    IF NOT LB_retorno THEN
            RAISE LE_funcion;
    END IF;

    LV_sql := 'SELECT VALOR_NUMERICO ';
    LV_sql := LV_sql||' FROM   PV_PARAMETROS_SIMPLES_VW';
    LV_sql := LV_sql||' WHERE  NOM_PARAMETRO = "FLAG_SERIE_NEGATIVA"';

    SELECT VALOR_NUMERICO
            INTO LV_PARAMETRO
    FROM   PV_PARAMETROS_SIMPLES_VW
    WHERE  NOM_PARAMETRO = 'FLAG_SERIE_NEGATIVA';

    IF LV_PARAMETRO = '1' THEN -- 1: llamada nueva; 0 llamada actual
            LB_retorno:=ve_valid_imei(EV_num_imei, SN_cod_retorno, SV_mens_retorno, SN_num_evento);
            IF NOT LB_retorno THEN
                    RAISE LE_funcion;
            END IF;
    ELSE
            LB_retorno:=ve_valida_lista_negras_fn(EV_num_imei, '0', LN_largoimei, SN_cod_retorno, SV_mens_retorno, SN_num_evento);
            IF NOT LB_retorno THEN
                    RAISE LE_funcion;
            END IF;
    END IF;

    IF TRIM(UPPER(EV_cod_procediencia)) = 'E' THEN
            LB_retorno:=ve_valida_existe_imei2_fn(EV_num_imei, LV_situabaja, SN_cod_retorno, SV_mens_retorno, SN_num_evento);
            IF NOT LB_retorno THEN
                    RAISE LE_funcion;
            END IF;
    END IF;

    LB_retorno:=ve_recuperaparametros_sms_pg.ve_recupera_glosa_fn('GA', 'DESBLOQUEO_PREPAGO','PROCESO_EXITOSO', LV_glosa_exito,SN_cod_retorno,SV_mens_retorno, SN_num_evento);
    IF NOT LB_retorno THEN
       SN_cod_retorno:=0;
       SV_mens_retorno:=NULL;
    ELSE
       SV_mens_retorno:= LV_glosa_exito;
    END IF;


    -- + Requerimiento Adicional 05.06.2008 - 11.06.2008
    IF (TRIM(UPPER(EV_cod_procediencia)) = 'I') THEN

        -- OBTIENE TIPO DE STOCK Y USO
                BEGIN
                LN_tipoStock := 0;
                        LN_codUso := 0;
                SELECT a.tip_stock,a.cod_uso
                INTO LN_tipoStock,LN_codUso
                FROM al_series a
                WHERE a.num_serie = EV_num_imei;

                        EXCEPTION
                                WHEN NO_DATA_FOUND THEN
                                        SN_cod_retorno  := CN_ERRORNOFOUNDALSERIES;
                                        SV_mens_retorno := CV_ERRORNOFOUNDALSERIES;
                                        RAISE LE_funcion;
                END;

        BEGIN

             --Validar que IMEI este en estado 1
             SELECT 1
             INTO LV_existe_serie
             FROM AL_SERIES
             WHERE NUM_SERIE=EV_num_imei
             AND COD_ESTADO=CN_ESTADOSERIEOK;

        EXCEPTION
                        WHEN NO_DATA_FOUND THEN
                                 SN_cod_retorno  := CN_SERIERESERVADA;
                                 SV_mens_retorno := CV_SERIERESERVADA;
                                 RAISE LE_funcion;
                END;


                -- VALIDAR QUE ARTICULO ASOCIADO A LA SERIE SEA COMERCIALIZABLE VIA WEB
                BEGIN

                        SELECT a.cod_articulo
                        INTO LV_codigoArticulo
                        FROM al_series a , al_articulos b
                        WHERE a.num_serie = EV_num_imei
                          AND a.cod_articulo = b.cod_articulo
                          AND b.ind_comer_web = CN_ARTCOMERCIALIZABLE_WEB;

                        EXCEPTION
                                WHEN NO_DATA_FOUND THEN
                                        SN_cod_retorno  := CN_ERRORARTICULONOCOMERC;
                                        SV_mens_retorno := CV_ERRORARTICULONOCOMERC;
                                        RAISE LE_funcion;
                END;

            -- OBTIENE PARAMETRO APLICA MAYORISTA
            VE_intermediario_PG.VE_obtiene_valor_parametro_PR('APLICA_MODCRED_MAYOR',
                                                              CV_codmodulo,
                                                              CN_PRODUCTO,
                                                              LV_aplicaMayorista,
                                                              SN_cod_retorno,
                                                              SV_mens_retorno,
                                                              SN_num_evento);

            IF SN_cod_retorno <> 0 THEN
                SN_cod_retorno  := CN_ERRORLEERPARAMETROS;
                SV_mens_retorno := CV_ERRORLEERPARAMETROS;
                RAISE LE_funcion;
            END IF;

        -- APLICA MAYORISTA ?
        IF (UPPER(TRIM(LV_AplicaMayorista)) = 'TRUE') THEN

                -- ES MERCADERIA DEALER ?
                IF (LN_tipoStock = CN_TIPOSTOCKMERCDEALER) THEN

                                    VE_intermediario_PG.VE_getOrigenVenta_PR(EV_num_imei,
                                                             LV_codigoUso,
                                                             LV_descripcionUso,
                                                             LV_codigoArticulo,
                                                             LV_descripcionArticulo,
                                                             SN_cod_retorno,
                                                             SV_mens_retorno,
                                                             SN_num_evento);

                    IF SN_cod_retorno <> 0 THEN
                       SN_cod_retorno  := CN_ERRORNOTAPEDIDOWEB;
                       SV_mens_retorno := CV_ERRORNOTAPEDIDOWEB;
                       RAISE LE_funcion;
                    END IF;

                ELSE
                                -- VALIDAR USO
                                   IF (LN_codUso = CN_USOPREPAGO) THEN
                       SN_cod_retorno  := CN_ERRORUSOPREPAGO;
                       SV_mens_retorno := CV_ERRORUSOPREPAGO;
                       RAISE LE_funcion;
                                   END IF;
                                END IF;

        ELSE
                -- VALIDAR USO
                        IF (LN_codUso = CN_USOPREPAGO) THEN
                            SN_cod_retorno  := CN_ERRORUSOPREPAGO;
                            SV_mens_retorno := CV_ERRORUSOPREPAGO;
                            RAISE LE_funcion;
                        END IF;
                END IF;

        END IF;
    -- - Requerimiento Adicional 05.06.2008 - 11.06.2008

EXCEPTION
      WHEN error_ejecucion THEN
           IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
              SV_mens_retorno := CV_error_no_clasif;
           END IF;
           LV_des_error  := 'ERROR_EJECUCION:ve_validaciones_clientes_pg.VE_valida_imei_PR(' || EV_num_imei || '); - ' || SQLERRM;
           SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'GA', SV_mens_retorno, '1.1', USER,'ve_validaciones_clientes_pg.VE_valida_imei_PR', LV_sql, SQLCODE,LV_des_error );
      WHEN LE_funcion THEN
           LV_des_error  := 'LE_FUNCION:ve_validaciones_clientes_pg.VE_valida_imei_PR(' || EV_num_imei || '); - ' || SQLERRM;
           SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'GA', SV_mens_retorno, '1.1', USER,'ve_validaciones_clientes_pg.VE_valida_imei_PR', LV_sql, SQLCODE,LV_des_error );
      WHEN OTHERS THEN
           SN_cod_retorno := 156;  -- ERROR General
           IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                  SV_mens_retorno := CV_error_no_clasif;
           END IF;
           LV_des_error  := 'OTHERS:ve_validaciones_clientes_pg.VE_valida_imei_PR(' || EV_num_imei || '); - ' || SQLERRM;
           SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'GA', SV_mens_retorno, '1.1', USER,'ve_validaciones_clientes_pg.VE_valida_imei_PR', LV_sql, SQLCODE,LV_des_error );
END ve_valida_imei_pr;
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
END ve_validaciones_clientes_pg;
/
SHOW ERRORS
