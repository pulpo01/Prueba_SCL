CREATE OR REPLACE PACKAGE BODY VE_validaequipo_PG IS

CV_error_no_clasif  CONSTANT VARCHAR2(20) := 'Error no clasificado';
FUNCTION VE_VALIDA_VENTA_OTRODEALER_FN (EN_codvendealer  IN  ve_vendealer.cod_vendealer%TYPE,
                                        EV_icc           IN  ga_aboamist.num_serie%TYPE,
                                        EV_canalvendedor IN  VARCHAR2,
                                        SN_cod_retorno   OUT NOCOPY ge_errores_pg.CodError,
                                        SV_mens_retorno  OUT NOCOPY ge_errores_pg.MsgError,
                                        SN_num_evento    OUT NOCOPY ge_errores_pg.Evento)
/*
        <Documentación
          TipoDoc = "Funcion">
           <Elemento
              Nombre = "VE_VALIDA_VENTA_OTRODEALER_FN"
              Lenguaje="PL/SQL"
              Fecha="30-08-2005"
              Versión="1.0"
              Diseñador="Rayen Ceballos"
              Programador="Roberto Perez"
              Migración="Jubitza Villanueva G."
              Ambiente Desarrollo="BD">
              <Retorno>BOOLEAN</Retorno>
              <Descripción>Validar si la venta fue realizada por otro dealer</Descripción>
              <Parámetros>
                 <Entrada>
                       <param nom="EN_codvendealer"  Tipo="NUMERICO">Código del vendedor dealer</param>
                       <param nom="EV_imsi"          Tipo="CARACTER">Nro de la serie</param>
                 </Entrada>
                 <Salida>
                       <param nom="SN_cod_retorno"   Tipo="NUMERICO">Codigo de Retorno</param>
                       <param nom="SV_mens_retorno"  Tipo="CARACTER">Mensaje de Retorno</param>
                       <param nom="SN_num_evento"    Tipo="NUMERICO">Numero de Evento</param>
                 </Salida>
              </Parámetros>
           </Elemento>
        </Documentación>
*/
        RETURN  BOOLEAN
        AS
                LV_des_error          ge_errores_pg.DesEvent;
                LV_vQuery             ge_errores_pg.vQuery;
                LN_existeventa        NUMBER;
                                LV_exite_icc              NUMBER;
                LV_situalta           ga_situabo.cod_situacion%TYPE;
                                LB_retorno                        BOOLEAN;
                                LV_aplicmay                       ged_parametros.val_parametro%TYPE;
                                LV_coduso                         al_series.cod_uso%TYPE;
                                LV_desuso                         al_usos.des_uso%TYPE;
                                LV_codart                         al_articulos.cod_articulo%TYPE;
                                LV_desart                         al_articulos.des_articulo%TYPE;
                                LV_errserv                        VARCHAR2(100);
                error_datos           EXCEPTION;
                                icc_no_existe             EXCEPTION;
                CV_codmodulo          CHAR(2):='GA';
                CV_cod_canal          CONSTANT  VARCHAR2(1):='I';

        BEGIN
                SN_cod_retorno:=0;
                SN_num_evento:=0;
                LN_existeventa:=0;

                LV_vQuery:='SELECT s.cod_situacion FROM ga_situabo s WHERE  s.des_situacion=ALTA ACTIVA DE ABONADO';

                SELECT s.cod_situacion
                INTO   LV_situalta
                FROM   ga_situabo s
                WHERE  s.des_situacion='ALTA ACTIVA DE ABONADO';

                                -- MIX_06002 MAYORISTAS
                                IF TRIM(EV_canalvendedor) = CV_cod_canal THEN
                                        LB_retorno:= ve_recuperaparametros_sms_pg.ve_recupera_parametros_fn('APLICA_MODCRED_MAYOR', 'GA', 1, LV_aplicmay, SN_cod_retorno,
                                        SV_mens_retorno, SN_num_evento);
                                        IF NOT LB_retorno THEN
                                           RAISE error_datos;
                                        END IF;
                                END IF;
                            -- MIX_06002 MAYORISTAS

                LV_vQuery:= 'SELECT COUNT(1) ';
                LV_vQuery:= LV_vQuery || ' FROM ga_aboamist b ';
                IF TRIM(EV_canalvendedor) = CV_cod_canal THEN
                   LV_vQuery:= LV_vQuery || ' WHERE b.cod_cliente IN (SELECT d.cod_cliente FROM ve_vendedores d,ve_vendealer c ';
                   LV_vQuery:= LV_vQuery || '                         WHERE c.cod_vendealer= ' || EN_codvendealer;
                   LV_vQuery:= LV_vQuery || '                           AND c.cod_vendedor=d.cod_vendedor)';
                ELSE
                   LV_vQuery:= LV_vQuery || ' WHERE b.cod_cliente IN (SELECT d.cod_cliente FROM ve_vendedores d ';
                   LV_vQuery:= LV_vQuery || '                         WHERE d.cod_vendedor= ' || EN_codvendealer;
                END IF;
                LV_vQuery:= LV_vQuery || '  AND b.num_serie     = ' || EV_icc ;
                LV_vQuery:= LV_vQuery || '  AND b.cod_cliente   = b.cod_cliente_dist';
                LV_vQuery:= LV_vQuery || '  AND b.cod_situacion =' || LV_situalta;


                IF TRIM(EV_canalvendedor) = CV_cod_canal THEN
                   SELECT COUNT(1)
                   INTO   LN_existeventa
                   FROM   ga_aboamist b
                   WHERE /* Inicio incidencia 37929 NRCA LVL
                            b.cod_cliente IN (SELECT d.cod_cliente
                                            FROM   ve_vendedores d, ve_vendealer c
                                            WHERE  c.cod_vendealer=EN_codvendealer
                                            AND c.cod_vendedor=d.cod_vendedor)
                        Fin incidencia 37929 */
                   b.num_serie=EV_icc
                   AND b.cod_cliente=b.cod_cliente_dist
                   AND b.cod_situacion=LV_situalta;
                ELSE
                   SELECT COUNT(1)
                   INTO   LN_existeventa
                   FROM   ga_aboamist b
                   WHERE  b.cod_cliente IN (SELECT d.cod_cliente
                                            FROM   ve_vendedores d
                                            WHERE  d.cod_vendedor=EN_codvendealer)
                   AND b.num_serie    = EV_icc
                   AND b.cod_cliente  = b.cod_cliente_dist
                   AND b.cod_situacion= LV_situalta;
                END IF;

                IF LN_existeventa=0 THEN
                                   -- MIX_06002 MAYORISTAS
                                   IF TRIM(LV_aplicmay)='TRUE' AND TRIM(EV_canalvendedor) = CV_cod_canal THEN
                                      LV_coduso:=NULL;
                                          LV_desuso:=NULL;
                                          LV_codart:=NULL;
                                          LV_desart:=NULL;
                                          NP_TRANSACCIONES_WEB_PG.NP_ORIGENVENTA_PR(EV_icc, 2, LV_coduso, LV_desuso, LV_codart, LV_desart, LV_errserv);
                                          IF LV_coduso IS NOT NULL AND LV_desuso IS NOT NULL AND LV_codart IS NOT NULL AND LV_desart IS NOT NULL THEN
                                                 RETURN TRUE;
                                          ELSE
                                                 RAISE error_datos;
                                          END IF;
                                   ELSE
                                          RAISE error_datos;
                                   END IF;
                                   -- MIX_06002 MAYORISTAS
                END IF;
                RETURN TRUE;

        EXCEPTION
                 WHEN error_datos THEN
                        SN_cod_retorno:=468; --ERROR_EXISTE_VENTA
                        IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                             SV_mens_retorno:=CV_error_no_clasif;
                        END IF;
                        LV_des_error:='VE_desbloqueaprepago_sms_PG.VE_VALIDA_VENTA_OTRODEALER_FN('||EN_codvendealer||','||EV_icc||');- ' || SQLERRM;
                        SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0', USER,
                        'VE_desbloqueaprepago_sms_PG.VE_VALIDA_VENTA_OTRODEALER_FN', LV_vQuery, SQLCODE, LV_des_error );
                        RETURN FALSE;
                 WHEN OTHERS THEN
                        SN_cod_retorno:=156;
                        IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                             SV_mens_retorno:=CV_error_no_clasif;
                        END IF;
                        LV_des_error:='VE_desbloqueaprepago_sms_PG.VE_VALIDA_VENTA_OTRODEALER_FN('||EN_codvendealer||','||EV_icc||');- ' || SQLERRM;
                        SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0', USER,
                        'VE_desbloqueaprepago_sms_PG.VE_VALIDA_VENTA_OTRODEALER_FN', LV_vQuery, SQLCODE, LV_des_error );
                        RETURN FALSE;
END VE_VALIDA_VENTA_OTRODEALER_FN;

/************************************************************************************************************************************************************/

           FUNCTION VE_valida_existe_imei_FN(EV_imei          IN ga_aboamist.num_imei%TYPE,
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


              BEGIN

                SN_cod_retorno := '0';
                SN_num_evento  :=  0;
                SV_mens_retorno:= '0';

                LV_sql:='SELECT COUNT(1) ';
                LV_sql:=LV_sql || 'FROM ga_abocel a ';
                LV_sql:=LV_sql || 'WHERE  a.num_imei=' || EV_imei;
                LV_sql:=LV_sql || ' AND a.cod_situacion<>' || EV_situabaja;

                SELECT COUNT(1)
                INTO   LN_record
                FROM   ga_abocel a
                WHERE  a.num_imei=EV_imei
                       AND a.cod_situacion<>EV_situabaja;

                IF LN_record>0 THEN
                   SN_cod_retorno := 474; --ERROR_EXISTE_POSTPAGO
                   RAISE error_ejecucion;
                END IF;

                LV_sql:='SELECT COUNT(1) ';
                LV_sql:=LV_sql || 'FROM ga_aboamist b ';
                LV_sql:=LV_sql || 'WHERE  b.num_imei=' || EV_imei;
                LV_sql:=LV_sql || ' AND b.cod_cliente<>b.cod_cliente_dist';
                LV_sql:=LV_sql || ' AND a.cod_situacion<>' || EV_situabaja;

                SELECT COUNT(1)
                INTO   LN_record
                FROM   ga_aboamist b
                WHERE  b.num_imei=EV_imei
                       AND b.cod_cliente<>b.cod_cliente_dist
                       AND b.cod_situacion<>EV_situabaja;

                IF LN_record>0 THEN
                   SN_cod_retorno := 475; --ERROR_EXISTE_PREPAGO
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

                      LV_des_error  := 'VE_validaequipo_PG.VE_valida_existe_imei_FN(' || EV_imei || ',' || EV_situabaja || '); - ' || SQLERRM;
                      SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'GA', SV_mens_retorno, '1.1', USER,'VE_VALIDAEQUIPO_PG.ve_valida_pr', LV_sql,
SQLCODE, LV_des_error );
                      RETURN(FALSE);

                 WHEN error_ejecucion THEN
                      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                         SV_mens_retorno := CV_error_no_clasif;
                      END IF;

                      LV_des_error  := 'VE_validaequipo_PG.VE_valida_existe_imei_FN(' || EV_imei || ',' || EV_situabaja || '); - ' || SQLERRM;
                      SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'GA', SV_mens_retorno, '1.1', USER,'VE_VALIDAEQUIPO_PG.ve_valida_pr', LV_sql,
SQLCODE, LV_des_error );
                      RETURN(FALSE);

                 WHEN OTHERS THEN
                      SN_cod_retorno := 156;  -- ERROR General
                      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                         SV_mens_retorno := CV_error_no_clasif;
                      END IF;

                      LV_des_error  := 'VE_validaequipo_PG.VE_valida_existe_imei_FN(' || EV_imei || ',' || EV_situabaja || ')--' || SQLERRM;
                      SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'GA', SV_mens_retorno, '1.1', USER,'VE_VALIDAEQUIPO_PG.ve_valida_pr', LV_sql,
SQLCODE, LV_des_error );
                      RETURN(FALSE);

           END VE_valida_existe_imei_FN;

           /* -------------------------------------------------------------------------------------------- */

           FUNCTION VE_valida_existe_icc_FN(EV_icc           IN ga_aboamist.num_serie%TYPE,
                                            SN_cod_retorno   OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                                            SV_mens_retorno  OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                                            SN_num_evento    OUT NOCOPY ge_errores_pg.Evento) RETURN BOOLEAN IS

              error_ejecucion     EXCEPTION;
              LV_sql              ge_errores_pg.vQuery;
              LV_des_error        ge_errores_pg.DesEvent;
              LV_iccaux           ga_aboamist.num_serie%TYPE;
              LN_record              NUMBER(3);

              BEGIN

                SN_cod_retorno := '0';
                SN_num_evento  :=  0;
                SV_mens_retorno:= '0';

                LV_sql:='SELECT COUNT(1) ';
                LV_sql:=LV_sql || 'FROM ga_abocel a ';
                LV_sql:=LV_sql || 'WHERE  a.num_serie=' || EV_icc;

                SELECT COUNT(1)
                INTO   LN_record
                FROM   ga_abocel a
                WHERE  a.num_serie=EV_icc;

                IF LN_record>0 THEN
                   SN_cod_retorno := 462; --ERROR_EXISTE_POSTPAGO
                   RAISE error_ejecucion;
                END IF;

                LV_sql:='SELECT COUNT(1) ';
                LV_sql:=LV_sql || 'FROM ga_aboamist b ';
                LV_sql:=LV_sql || 'WHERE  b.num_serie=' || EV_icc;
                LV_sql:=LV_sql || ' AND b.cod_cliente<>b.cod_cliente_dist';

                SELECT COUNT(1)
                INTO   LN_record
                FROM   ga_aboamist b
                WHERE  b.num_serie=EV_icc
                       AND b.cod_cliente<>b.cod_cliente_dist;

                IF LN_record>0 THEN
                   SN_cod_retorno := 463; --ERROR_EXISTE_PREPAGO
                   RAISE error_ejecucion;
                END IF;

                RETURN(TRUE);

                EXCEPTION
                 WHEN error_ejecucion THEN
                      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                         SV_mens_retorno := CV_error_no_clasif;
                      END IF;

                      LV_des_error  := 'VE_validaequipo_PG.VE_valida_existe_icc_FN(' || EV_icc || '); - ' || SQLERRM;
                      SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'GA', SV_mens_retorno, '1.1', USER,'VE_VALIDAEQUIPO_PG.ve_valida_pr', LV_sql,
SQLCODE, LV_des_error );
                      RETURN(FALSE);

                 WHEN OTHERS THEN
                      SN_cod_retorno := 156;  -- ERROR General
                      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                         SV_mens_retorno := CV_error_no_clasif;
                      END IF;

                      LV_des_error  := 'VE_validaequipo_PG.VE_valida_existe_icc_FN(' || EV_icc || SQLERRM;
                      SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'GA', SV_mens_retorno, '1.1', USER,'VE_VALIDAEQUIPO_PG.ve_valida_pr', LV_sql,
SQLCODE, LV_des_error );
                      RETURN(FALSE);

           END VE_valida_existe_icc_FN;

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

                      LV_des_error  := 'VE_validaequipo_PG.VE_valida_lista_negras_FN(' || EV_num_serie || ',' || EN_largo_icc || ',' || EN_largo_imei || '); - '
|| SQLERRM;
                      SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'GA', SV_mens_retorno, '1.1', USER,'VE_VALIDAEQUIPO_PG.ve_valida_pr', LV_sql,
SQLCODE, LV_des_error );
                      RETURN(FALSE);

                 WHEN OTHERS THEN
                      SN_cod_retorno := 156;  -- ERROR General
                      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                         SV_mens_retorno := CV_error_no_clasif;
                      END IF;

                      LV_des_error  := 'VE_validaequipo_PG.VE_valida_lista_negras_FN(' || EV_num_serie || ',' || EN_largo_icc || ',' || EN_largo_imei || '); - '
|| SQLERRM;
                      SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'GA', SV_mens_retorno, '1.1', USER,'VE_VALIDAEQUIPO_PG.ve_valida_pr', LV_sql,
SQLCODE, LV_des_error );
                      RETURN(FALSE);

           END VE_valida_lista_negras_FN;

           /* -------------------------------------------------------------------------------------------- */

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

                      LV_des_error  := 'VE_validaequipo_PG.VE_valida_numcelular_FN(' || EV_numcelular || ',' || EV_situalta || ',' || EV_num_serie || ',' ||
EV_tip_serie || '); - ' || SQLERRM;
                      SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'GA', SV_mens_retorno, '1.1', USER,'VE_VALIDAEQUIPO_PG.ve_valida_pr', LV_sql,
SQLCODE, LV_des_error );
                      RETURN(FALSE);

                 WHEN NO_DATA_FOUND THEN
                     SN_cod_retorno := 156; --ERROR_NUM_CELULAR_NO_EXISTE
                     IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                         SV_mens_retorno := CV_error_no_clasif;
                      END IF;

                      LV_des_error  := 'VE_validaequipo_PG.VE_valida_numcelular_FN(' || EV_numcelular || ',' || EV_situalta || ',' || EV_num_serie || ',' ||
EV_tip_serie || '); - ' || SQLERRM;
                      SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'GA', SV_mens_retorno, '1.1', USER,'VE_VALIDAEQUIPO_PG.ve_valida_pr', LV_sql,
SQLCODE, LV_des_error );
                      RETURN(FALSE);

                 WHEN TOO_MANY_ROWS THEN
                     SN_cod_retorno := 156; --ERROR_NUM_CELULAR_DUPLICADO
                     IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                         SV_mens_retorno := CV_error_no_clasif;
                      END IF;

                      LV_des_error  := 'VE_validaequipo_PG.VE_valida_numcelular_FN(' || EV_numcelular || ',' || EV_situalta || ',' || EV_num_serie || ',' ||
EV_tip_serie || '); - ' || SQLERRM;
                      SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'GA', SV_mens_retorno, '1.1', USER,'VE_VALIDAEQUIPO_PG.ve_valida_pr', LV_sql,
SQLCODE, LV_des_error );
                      RETURN(FALSE);

                WHEN OTHERS THEN
                      SN_cod_retorno := 156;  -- ERROR General
                      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                         SV_mens_retorno := CV_error_no_clasif;
                      END IF;

                      LV_des_error  := 'VE_validaequipo_PG.VE_valida_numcelular_FN(' || EV_numcelular || ',' || EV_situalta || ',' || EV_num_serie || ',' ||
EV_tip_serie || '); - ' || SQLERRM;
                      SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'GA', SV_mens_retorno, '1.1', USER,'VE_VALIDAEQUIPO_PG.ve_valida_pr', LV_sql,
SQLCODE, LV_des_error );
                      RETURN(FALSE);

           END VE_valida_numcelular_FN;

           /* -------------------------------------------------------------------------------------------- */

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

                              LV_des_error  := 'VE_validaequipo_PG.VE_obtiene_numcelular_FN(' || EV_situalta || ',' || EV_serie || ',' || EV_tipo_serie || '); -
' || SQLERRM;
                              SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'GA', SV_mens_retorno, '1.1', USER,'VE_VALIDAEQUIPO_PG.ve_valida_pr',
LV_sql, SQLCODE, LV_des_error );
                              RETURN(FALSE);
                          END IF;
                     WHEN TOO_MANY_ROWS THEN
                         SN_cod_retorno := 156; --ERROR_ICC_DUPLICADA
                         IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                             SV_mens_retorno := CV_error_no_clasif;
                          END IF;

                          LV_des_error  := 'VE_validaequipo_PG.VE_obtiene_numcelular_FN(' || EV_situalta || ',' || EV_serie || ',' || EV_tipo_serie || '); - '
|| SQLERRM;
                          SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'GA', SV_mens_retorno, '1.1', USER,'VE_VALIDAEQUIPO_PG.ve_valida_pr', LV_sql,
SQLCODE, LV_des_error );
                          RETURN(FALSE);

                     WHEN OTHERS THEN
                          SN_cod_retorno := 156;  -- ERROR General
                          IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                             SV_mens_retorno := CV_error_no_clasif;
                          END IF;

                          LV_des_error  := 'VE_validaequipo_PG.VE_obtiene_numcelular_FN(' || EV_situalta || ',' || EV_serie || ',' || EV_tipo_serie || '); - '
|| SQLERRM;
                          SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'GA', SV_mens_retorno, '1.1', USER,'VE_VALIDAEQUIPO_PG.ve_valida_pr', LV_sql,
SQLCODE, LV_des_error );
                          RETURN(FALSE);

              END VE_obtiene_numcelular_FN;

        /* -------------------------------------------------------------------------------------------- */

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

                          LV_des_error  := 'VE_validaequipo_PG.VE_obtiene_situacion_FN(' || EV_des_situacion || '); - ' || SQLERRM;
                          SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'GA', SV_mens_retorno, '1.1', USER,'VE_VALIDAEQUIPO_PG.ve_valida_pr', LV_sql,
SQLCODE, LV_des_error );
                          RETURN(FALSE);

                     WHEN TOO_MANY_ROWS THEN
                          SN_cod_retorno := 156; --ERROR_SITUACION_REPETIDA
                          IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                             SV_mens_retorno := CV_error_no_clasif;
                          END IF;

                          LV_des_error  := 'VE_validaequipo_PG.VE_obtiene_situacion_FN(' || EV_des_situacion || '); - ' || SQLERRM;
                          SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'GA', SV_mens_retorno, '1.1', USER,'VE_VALIDAEQUIPO_PG.ve_valida_pr', LV_sql,
SQLCODE, LV_des_error );
                          RETURN(FALSE);


                     WHEN OTHERS THEN
                          SN_cod_retorno := 156;  -- ERROR General
                          IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                             SV_mens_retorno := CV_error_no_clasif;
                          END IF;

                          LV_des_error  := 'VE_validaequipo_PG.VE_obtiene_situacion_FN(' || EV_des_situacion || '); - ' || SQLERRM;
                          SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'GA', SV_mens_retorno, '1.1', USER,'VE_VALIDAEQUIPO_PG.ve_valida_pr', LV_sql,
SQLCODE, LV_des_error );
                          RETURN(FALSE);

           END VE_obtiene_situacion_FN;

----------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------

        PROCEDURE VE_VALIDA_ARTICULO_PR (
                    EV_CODARTICULO  IN   AL_ARTICULOS.COD_ARTICULO%TYPE,
                    SN_COD_RETORNO   OUT NOCOPY GE_ERRORES_PG.CODERROR,
                    SV_MENS_RETORNO  OUT NOCOPY GE_ERRORES_PG.MSGERROR,
                    SN_NUM_EVENTO    OUT NOCOPY GE_ERRORES_PG.EVENTO
        )
        /*
        <Documentación
          TipoDoc = "Procedimiento">
           <Elemento
              Nombre = "VE_VALIDA_ARTICULO_PR"
              Lenguaje="PL/SQL"
              Fecha="16-11-2005"
              Versión="1.0"
              Diseñador="Rayen Ceballos"
              Programador="Igor Gonzalez"
              Migración="""
              Ambiente Desarrollo="BD">
              <Retorno>BOOLEAN</Retorno>
              <Descripción>Validación si existe codigo articulo en SCL</Descripción>
              <Parámetros>
                 <Entrada>
                    <param nom="EV_CODARTICULO" Tipo="CARACTER">Código articulo</param>
                 </Entrada>
                 <Salida>
                    <param nom="SN_cod_retorno"       Tipo="NUMERICO">Codigo de Retorno</param>
                    <param nom="SV_mens_retorno"      Tipo="CARACTER">Mensaje de Retorno</param>
                    <param nom="SN_num_evento"        Tipo="NUMERICO">Numero de Evento</param>
                 </Salida>
              </Parámetros>
           </Elemento>
        </Documentación>
        */
        AS
                LV_DES_ERROR        GE_ERRORES_PG.DESEVENT;
                LV_SQL              GE_ERRORES_PG.VQUERY;
                LN_EXISTEART        NUMBER:=0;
                ERROR_DATOS            EXCEPTION;
                CV_codmodulo        CHAR(2):='GA';
                                LB_retorno          BOOLEAN;
                                LV_glosa_exito      ged_codigos.des_valor%TYPE;


        BEGIN
                SN_COD_RETORNO:=0;  --Código Artículo no definido en SCL  --
                SN_NUM_EVENTO:=0;

                LV_SQL:='SELECT COUNT(1)'||
                        '  FROM AL_ARTICULOS ARTICULOS'||
                        ' WHERE ARTICULOS.COD_ARTICULO = ''' ||  EV_CODARTICULO || '''';

                SELECT COUNT(1) INTO LN_EXISTEART
                  FROM AL_ARTICULOS ARTICULOS
                 WHERE ARTICULOS.COD_ARTICULO = EV_CODARTICULO;


                IF LN_EXISTEART=0 THEN
                   RAISE ERROR_DATOS;
                END IF;

                 LB_retorno:=ve_recuperaparametros_sms_pg.VE_RECUPERA_GLOSA_FN('GA', 'DESBLOQUEO_PREPAGO','PROCESO_EXITOSO', LV_glosa_exito,SN_cod_retorno,
SV_mens_retorno, SN_num_evento);
                 IF NOT LB_retorno THEN
                    SN_cod_retorno:=0;
                    SV_mens_retorno:=NULL;
                 ELSE
                    SV_mens_retorno:= LV_glosa_exito;
                 END IF;


        EXCEPTION
        WHEN  ERROR_DATOS THEN
                                                SN_COD_RETORNO:=300111;  --Código Artículo no definido en SCL  --
                        IF NOT GE_ERRORES_PG.MENSAJEERROR(SN_COD_RETORNO,SV_MENS_RETORNO) THEN
                             SV_MENS_RETORNO:=CV_ERROR_NO_CLASIF;
                        END IF;
                        LV_DES_ERROR:='error_datos: VE_validaequipo_PG.VE_VALIDA_ARTICULO_PR('|| EV_CODARTICULO || ');- ' || SQLERRM;
                        SN_NUM_EVENTO:=GE_ERRORES_PG.GRABARPL( SN_NUM_EVENTO, CV_CODMODULO,SV_MENS_RETORNO, '1.0',
USER,'VE_validaequipo_PG.VE_VALIDA_ARTICULO_PR', LV_SQL, SQLCODE, LV_DES_ERROR );
        WHEN  OTHERS THEN
                        SN_COD_RETORNO:=300111;  --Código Artículo no definido en SCL  --
                        IF NOT GE_ERRORES_PG.MENSAJEERROR(SN_COD_RETORNO,SV_MENS_RETORNO) THEN
                             SV_MENS_RETORNO := CV_ERROR_NO_CLASIF;
                        END IF;
                        LV_DES_ERROR:='Others VE_validaequipo_PG.VE_VALIDA_ARTICULO_PR('||EV_CODARTICULO||');- ' || SQLERRM;
                        SN_NUM_EVENTO := GE_ERRORES_PG.GRABARPL( SN_NUM_EVENTO, CV_CODMODULO,SV_MENS_RETORNO, '1.0',
USER,'VE_validaequipo_PG.VE_VALIDA_ARTICULO_PR', LV_SQL, SQLCODE, LV_DES_ERROR );
        END VE_VALIDA_ARTICULO_PR;


----------------------------------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------
PROCEDURE VE_valida_icc_PR(EV_icc           IN  ga_aboamist.num_serie%TYPE,
                EN_codvendealer  IN  ve_vendealer.cod_vendealer%TYPE,
                EV_canalvendedor IN  VARCHAR2,
                SN_cod_retorno   OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                SV_mens_retorno  OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                SN_num_evento    OUT NOCOPY ge_errores_pg.Evento) IS

/* <Documentación TipoDoc = "PROCEDURE">
<Elemento
Nombre = "VE_valida_icc_PR
Lenguaje="PL/SQL"
Fecha="15-06-2005"
Versión="1.0"
Diseñador="Rayen Ceballos"
Programador="Roberto Perez"
Ambiente="DEIMOS_ANDINA">
<Retorno>N/A</Retorno>
<Descripción>Función que determina si una venta fue hecha por un distribuidor o si el equipo est en listas negras o si el equipo esta asociado a
otro abonado</Descripción>
<Parámetros>
<Entrada>
<param nom="EV_icc" Tipo="STRING">Serie a buscar en listas negras</param>
</Entrada>
<Salida>
<param nom="SN_coderror" Tipo="NUMBER">Código de error parametrico</param>
<param nom="SV_error" Tipo="VARCHAR">Descripcion Error</param>
</Salida>
</Parámetros>
</Elemento>
</Documentación> */

        LE_funcion          EXCEPTION;
        error_ejecucion     EXCEPTION;
        LB_retorno          BOOLEAN;
        LN_largosimcard     ged_parametros.val_parametro%TYPE;
        LV_codterminal      ged_parametros.val_parametro%TYPE;
        LV_numcelular       ga_abocel.num_celular%TYPE;
        LV_situalta         ga_situabo.cod_situacion%TYPE;
        LV_iccaux           ga_abocel.num_serie%TYPE;
        LV_sql              ge_errores_pg.vQuery;
        LV_des_error        ge_errores_pg.DesEvent;
        LV_situabaja        ga_situabo.cod_situacion%TYPE;
        LV_glosa_exito      ged_codigos.des_valor%TYPE;

BEGIN
        SN_cod_retorno :=  0;
        SN_num_evento  :=  0;
        SV_mens_retorno:= '0';

--INICIO: RA-200512150321; USER:JEIM; FECHA 11/01/2006; COMENTARIO: SE CAMBIA EL ORDEN DE LAS VALIDACIONES
-------------------------------------------------------------------------------------------------------------------------------------------
   LB_retorno:= ve_recuperaparametros_sms_pg.ve_recupera_parametros_fn('LARGO_SERIE_GGSM', 'AL', 1, LN_largosimcard, SN_cod_retorno,
SV_mens_retorno, SN_num_evento);

   IF NOT LB_retorno THEN
      RAISE LE_funcion;
   END IF;

   IF NVL(LENGTH(EV_icc),0)<>TO_NUMBER(LN_largosimcard) THEN  --RA-200601140583
      SN_cod_retorno := 460; --ERROR_LARGO_ICC
      RAISE error_ejecucion;
   END IF;
-------------------------------------------------------------------------------------------------------------------------------------------
   LB_retorno:=VE_valida_lista_negras_FN(EV_icc, LN_largosimcard, '0', SN_cod_retorno, SV_mens_retorno, SN_num_evento);
   IF NOT LB_retorno THEN
      RAISE LE_funcion;
   END IF;

-------------------------------------------------------------------------------------------------------------------------------------------
   LB_retorno:=VE_obtiene_situacion_FN('ALTA ACTIVA DE ABONADO', LV_situalta, SN_cod_retorno, SV_mens_retorno, SN_num_evento);

   IF NOT LB_retorno THEN
      RAISE LE_funcion;
   END IF;
-------------------------------------------------------------------------------------------------------------------------------------------
   LB_retorno:=VE_valida_existe_icc_FN(EV_icc,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
   IF NOT LB_retorno THEN
      RAISE LE_funcion;
   END IF;

-------------------------------------------------------------------------------------------------------------------------------------------

   LB_retorno:=VE_obtiene_numcelular_FN(LV_situalta, EV_icc, 'S', LV_numcelular, SN_cod_retorno, SV_mens_retorno, SN_num_evento);

   IF NOT LB_retorno THEN
      RAISE LE_funcion;
   END IF;
-------------------------------------------------------------------------------------------------------------------------------------------

   LB_retorno:=VE_valida_numcelular_FN(LV_numcelular,LV_situalta,EV_icc,'S',SN_cod_retorno,SV_mens_retorno,SN_num_evento);
   IF NOT LB_retorno THEN
      RAISE LE_funcion;
   END IF;
-------------------------------------------------------------------------------------------------------------------------------------------
   LB_retorno := ve_valida_venta_otrodealer_fn (EN_codvendealer,EV_icc,EV_canalvendedor,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
   IF NOT LB_retorno THEN
      RAISE LE_funcion;
   END IF;
-------------------------------------------------------------------------------------------------------------------------------------------

   LB_retorno:=ve_recuperaparametros_sms_pg.VE_RECUPERA_GLOSA_FN('GA', 'DESBLOQUEO_PREPAGO','PROCESO_EXITOSO', LV_glosa_exito,SN_cod_retorno,
SV_mens_retorno, SN_num_evento);
   IF NOT LB_retorno THEN
      SN_cod_retorno:=0;
      SV_mens_retorno:=NULL;
   ELSE
      SV_mens_retorno:= LV_glosa_exito;
   END IF;
-------------------------------------------------------------------------------------------------------------------------------------------
--FIN: RA-200512150321; USER:JEIM; FECHA 11/01/2006; COMENTARIO: SE CAMBIA EL ORDEN DE LAS VALIDACIONES

EXCEPTION
        WHEN error_ejecucion THEN
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                SV_mens_retorno := CV_error_no_clasif;
                END IF;

                LV_des_error  := 'VE_validaequipo_PG.VE_valida_icc_PR(' || EV_icc || ',' || EN_codvendealer || ',' || EV_canalvendedor ||'); - ' ||
                SQLERRM;
                SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'GA', SV_mens_retorno, '1.1', USER,'VE_VALIDAEQUIPO_PG.VE_valida_icc_PR',
                LV_sql, SQLCODE, LV_des_error );

        WHEN LE_funcion THEN
                LV_des_error  := 'VE_validaequipo_PG.VE_valida_icc_PR(' || EV_icc || ',' || EN_codvendealer || ',' || EV_canalvendedor ||'); - ' ||
                SQLERRM;
                SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'GA', SV_mens_retorno, '1.1', USER,'VE_VALIDAEQUIPO_PG.VE_valida_icc_PR',
                LV_sql, SQLCODE, LV_des_error );

        WHEN OTHERS THEN
                SN_cod_retorno := 156;  -- ERROR General
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                SV_mens_retorno := CV_error_no_clasif;
                END IF;

                LV_des_error  := 'VE_validaequipo_PG.VE_valida_icc_PR(' || EV_icc || ',' || EN_codvendealer || ',' || EV_canalvendedor ||'); - ' ||
                SQLERRM;
                SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'GA', SV_mens_retorno, '1.1', USER,'VE_VALIDAEQUIPO_PG.VE_valida_icc_PR',
                LV_sql, SQLCODE, LV_des_error );
END VE_valida_icc_PR;
----------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------
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

       LV_des_error  := 've_validaequipo_pg.ve_obtiene_vendedor_fn(' || EN_cod_vendealer ||','||SN_cod_vendedor|| '); - ' || SQLERRM;
       SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'GA', SV_mens_retorno, '1.1', USER,'ve_validaequipo_pg.ve_obtiene_vendedor_fn', LV_sql, SQLCODE,
LV_des_error );
       RETURN FALSE;

   WHEN NO_DATA_FOUND THEN
      SN_cod_retorno:= 476; --Vendedor no existe
       IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
              SV_mens_retorno := CV_error_no_clasif;
       END IF;

       LV_des_error  := 've_validaequipo_pg.ve_obtiene_vendedor_fn(' || EN_cod_vendealer ||','||SN_cod_vendedor|| '); - ' || SQLERRM;
       SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'GA', SV_mens_retorno, '1.1', USER,'ve_validaequipo_pg.ve_obtiene_vendedor_fn', LV_sql, SQLCODE,
LV_des_error );
       RETURN FALSE;
   WHEN OTHERS THEN
       SN_cod_retorno:= 302; --No fue posible ejecutar el servicio. Intente nuevamente
       IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
              SV_mens_retorno := CV_error_no_clasif;
       END IF;

       LV_des_error  := 've_validaequipo_pg.ve_obtiene_vendedor_fn(' || EN_cod_vendealer ||','||SN_cod_vendedor|| '); - ' || SQLERRM;
       SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'GA', SV_mens_retorno, '1.1', USER,'ve_validaequipo_pg.ve_obtiene_vendedor_fn', LV_sql, SQLCODE,
LV_des_error );
       RETURN FALSE;
END ve_obtiene_vendedor_fn;
----------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------
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

       LV_des_error  := 've_validaequipo_pg.ve_valida_serie_fn(' || EV_num_imei || '); - ' || SQLERRM;
       SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'GA', SV_mens_retorno, '1.1', USER,'ve_validaequipo_pg.ve_valida_serie_fn', LV_sql, SQLCODE,
LV_des_error );
       RETURN FALSE;
   WHEN NO_DATA_FOUND THEN
       SN_cod_retorno:= 549; --IMEI, no es de procedencia interna
       IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
              SV_mens_retorno := CV_error_no_clasif;
       END IF;

       LV_des_error  := 've_validaequipo_pg.ve_valida_serie_fn(' || EV_num_imei || '); - ' || SQLERRM;
       SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'GA', SV_mens_retorno, '1.1', USER,'ve_validaequipo_pg.ve_valida_serie_fn', LV_sql, SQLCODE,
LV_des_error );
       RETURN FALSE;
   WHEN OTHERS THEN
       SN_cod_retorno:= 302; --No fue posible ejecutar el servicio. Intente nuevamente
       IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
              SV_mens_retorno := CV_error_no_clasif;
       END IF;

       LV_des_error  := 've_validaequipo_pg.ve_valida_serie_fn(' || EV_num_imei || '); - ' || SQLERRM;
       SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'GA', SV_mens_retorno, '1.1', USER,'ve_validaequipo_pg.ve_valida_serie_fn', LV_sql, SQLCODE,
LV_des_error );
       RETURN FALSE;
END ve_valida_serie_fn;
----------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------
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
       LV_des_error  := 've_validaequipo_pg.ve_valida_bodega_fn(' || EN_cod_vendedor ||','||EN_cod_bodega|| '); - ' || SQLERRM;
       SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'GA', SV_mens_retorno, '1.1', USER,'ve_validaequipo_pg.ve_valida_bodega_fn', LV_sql, SQLCODE,
LV_des_error );
       RETURN FALSE;

   WHEN OTHERS THEN
       SN_cod_retorno:= 302; --No fue posible ejecutar el servicio. Intente nuevamente
       IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
              SV_mens_retorno := CV_error_no_clasif;
       END IF;

       LV_des_error  := 've_validaequipo_pg.ve_valida_bodega_fn(' || EN_cod_vendedor ||','||EN_cod_bodega|| '); - ' || SQLERRM;
       SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'GA', SV_mens_retorno, '1.1', USER,'ve_validaequipo_pg.ve_valida_bodega_fn', LV_sql, SQLCODE,
LV_des_error );
       RETURN FALSE;
END ve_valida_bodega_fn;
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
error_1                         EXCEPTION;
LV_des_error                    ge_errores_pg.DesEvent;
LV_sSql                         ge_errores_pg.vQuery;
TN_count                        NUMBER;
CN_cero                         CONSTANT NUMBER(1) := 0;
P_CODERROR                      NUMBER(3);
P_DESERROR              VARCHAR2(100);
v_es_negativo                   boolean;
NUM_ABONADO_DATO NUMBER;
P_NSRELECTRONICO VARCHAR2(20);
BEGIN

        SN_num_evento   := 0;
        SN_cod_retorno  := 0;
        SV_mens_retorno := '';
        P_NSRELECTRONICO:= EV_cod_serie;

        LV_sSql := 'PAC_NSR_NEG.P_CONS_NSR_NEG('|| P_NSRELECTRONICO || ',v_es_negativo ,P_CODERROR ,P_DESERROR)';
        PAC_NSR_NEG.P_CONS_NSR_NEG(P_NSRELECTRONICO,v_es_negativo,P_CODERROR,P_DESERROR);

        if v_es_negativo then
                SN_cod_retorno := 473; --IMEI se encuentra en seriales negativos
                RAISE error_1;
        end if;

        RETURN TRUE;

        EXCEPTION
                WHEN error_1 THEN
                        IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                                SV_mens_retorno := CV_error_no_clasif;
                        END IF;
                        LV_des_error := 've_validaequipo_pg.ve_valid_imei('||EV_cod_serie||'); - ' ||SQLERRM;
                        SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'GA', SV_mens_retorno,'1.0', USER, 've_validaequipo_pg.ve_valid_imei',LV_sSql, SN_cod_retorno, LV_des_error);
                        RETURN FALSE;
                WHEN OTHERS THEN
                        SN_cod_retorno := 529;
                        IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                                SV_mens_retorno := CV_error_no_clasif;
                        END IF;
                        LV_des_error := 've_validaequipo_pg.ve_valid_imei('||EV_cod_serie||'); - ' ||SQLERRM;
                        SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'GA', SV_mens_retorno,'1.0', USER, 've_validaequipo_pg.ve_valid_imei',LV_sSql, SN_cod_retorno, LV_des_error);
                        RETURN FALSE;


END ve_valid_imei;

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
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
                        LV_des_error := 've_validaequipo_pg.ve_obtiene_codigo_fn('||EV_cod_modulo||','||EV_nom_tabla||','||EV_nom_columna||','||EV_cod_valor||'); - ' ||SQLERRM;
                        SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, EV_cod_modulo, SV_mens_retorno,'1.0', USER, 've_validaequipo_pg.ve_obtiene_codigo_fn',LV_sSql, SN_cod_retorno, LV_des_error);
                        RETURN FALSE;
                WHEN OTHERS THEN
                        SN_cod_retorno := 529;
                        IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                                SV_mens_retorno := CV_error_no_clasif;
                        END IF;
                        LV_des_error := 've_validaequipo_pg.ve_obtiene_codigo_fn('||EV_cod_modulo||','||EV_nom_tabla||','||EV_nom_columna||','||EV_cod_valor||'); - ' ||SQLERRM;
                        SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, EV_cod_modulo, SV_mens_retorno,'1.0', USER, 've_validaequipo_pg.ve_obtiene_codigo_fn',LV_sSql, SN_cod_retorno, LV_des_error);
                        RETURN FALSE;
END ve_obtiene_codigo_fn;
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
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

                LB_retorno:=ve_obtiene_situacion_fn('BAJA ABONADO ACTIVA', LV_situabaja, SN_cod_retorno, SV_mens_retorno, SN_num_evento);
                IF NOT LB_retorno THEN
                        RAISE LE_funcion;
                END IF;

                --inc.45730
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
                --inc.45730

                IF TRIM(UPPER(EV_cod_procediencia)) = 'E' THEN
                        LB_retorno:=ve_valida_existe_imei_fn(EV_num_imei, LV_situabaja, SN_cod_retorno, SV_mens_retorno, SN_num_evento);
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

EXCEPTION
      WHEN error_ejecucion THEN
           IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
              SV_mens_retorno := CV_error_no_clasif;
           END IF;

           LV_des_error  := 'VE_validaequipo_PG.VE_valida_imei_PR(' || EV_num_imei || '); - ' || SQLERRM;
           SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'GA', SV_mens_retorno, '1.1', USER,'VE_VALIDAEQUIPO_PG.VE_valida_imei_PR', LV_sql, SQLCODE,LV_des_error );

      WHEN LE_funcion THEN
           LV_des_error  := 'VE_validaequipo_PG.VE_valida_imei_PR(' || EV_num_imei || '); - ' || SQLERRM;
           SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'GA', SV_mens_retorno, '1.1', USER,'VE_VALIDAEQUIPO_PG.VE_valida_imei_PR', LV_sql, SQLCODE,LV_des_error );

      WHEN OTHERS THEN
           SN_cod_retorno := 156;  -- ERROR General
           IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                     SV_mens_retorno := CV_error_no_clasif;
           END IF;

           LV_des_error  := 'VE_validaequipo_PG.VE_valida_imei_PR(' || EV_num_imei || '); - ' || SQLERRM;
           SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'GA', SV_mens_retorno, '1.1', USER,'VE_VALIDAEQUIPO_PG.VE_valida_imei_PR', LV_sql, SQLCODE,LV_des_error );

END ve_valida_imei_pr;



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

                      LV_des_error  := 'VE_validaequipo_PG.VE_valida_existe_imei_FN(' || EV_imei || ',' || EV_situabaja || '); - ' || SQLERRM;
                      SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'GA', SV_mens_retorno, '1.1', USER,'VE_VALIDAEQUIPO_PG.ve_valida_pr', LV_sql,
SQLCODE, LV_des_error );
                      RETURN(FALSE);

                 WHEN error_ejecucion THEN
                      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                         SV_mens_retorno := CV_error_no_clasif;
                      END IF;

                      LV_des_error  := 'VE_validaequipo_PG.VE_valida_existe_imei_FN(' || EV_imei || ',' || EV_situabaja || '); - ' || SQLERRM;
                      SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'GA', SV_mens_retorno, '1.1', USER,'VE_VALIDAEQUIPO_PG.ve_valida_pr', LV_sql,
SQLCODE, LV_des_error );
                      RETURN(FALSE);

                 WHEN OTHERS THEN
                      SN_cod_retorno := 156;  -- ERROR General
                      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                         SV_mens_retorno := CV_error_no_clasif;
                      END IF;

                      LV_des_error  := 'VE_validaequipo_PG.VE_valida_existe_imei_FN(' || EV_imei || ',' || EV_situabaja || ')--' || SQLERRM;
                      SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'GA', SV_mens_retorno, '1.1', USER,'VE_VALIDAEQUIPO_PG.ve_valida_pr', LV_sql,
SQLCODE, LV_des_error );
                      RETURN(FALSE);

END VE_valida_existe_imei2_FN;

PROCEDURE ve_valida_imei2_pr(EV_num_imei         IN ga_aboamist.num_serie%TYPE,
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

                LB_retorno:=ve_obtiene_situacion_fn('BAJA ABONADO ACTIVA', LV_situabaja, SN_cod_retorno, SV_mens_retorno, SN_num_evento);
                IF NOT LB_retorno THEN
                        RAISE LE_funcion;
                END IF;

                --inc.45730
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
                --inc.45730

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

EXCEPTION
      WHEN error_ejecucion THEN
           IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
              SV_mens_retorno := CV_error_no_clasif;
           END IF;

           LV_des_error  := 'VE_validaequipo_PG.VE_valida_imei2_PR(' || EV_num_imei || '); - ' || SQLERRM;
           SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'GA', SV_mens_retorno, '1.1', USER,'VE_VALIDAEQUIPO_PG.VE_valida_imei_PR', LV_sql, SQLCODE,LV_des_error );

      WHEN LE_funcion THEN
           LV_des_error  := 'VE_validaequipo_PG.VE_valida_imei2_PR(' || EV_num_imei || '); - ' || SQLERRM;
           SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'GA', SV_mens_retorno, '1.1', USER,'VE_VALIDAEQUIPO_PG.VE_valida_imei_PR', LV_sql, SQLCODE,LV_des_error );

      WHEN OTHERS THEN
           SN_cod_retorno := 156;  -- ERROR General
           IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                     SV_mens_retorno := CV_error_no_clasif;
           END IF;

           LV_des_error  := 'VE_validaequipo_PG.VE_valida_imei2_PR(' || EV_num_imei || '); - ' || SQLERRM;
           SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'GA', SV_mens_retorno, '1.1', USER,'VE_VALIDAEQUIPO_PG.VE_valida_imei_PR', LV_sql, SQLCODE,LV_des_error );

END ve_valida_imei2_pr;

END VE_validaequipo_PG;
/
SHOW ERRORS
