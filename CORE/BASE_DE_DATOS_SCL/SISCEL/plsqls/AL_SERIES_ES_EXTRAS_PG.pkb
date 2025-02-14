CREATE OR REPLACE PACKAGE BODY AL_SERIES_ES_EXTRAS_PG  IS



PROCEDURE AL_LIBERA_NUMERO_ORDEN_PR (EN_num_extra IN al_ser_es_extras.num_extra%TYPE)
IS
/*
<Documentación TipoDoc = "Procedimiento">
<Elemento Nombre = "AL_LIBERA_NUMERO_ORDEN_PR " Lenguaje="PL/SQL" Fecha="16-03-2006" Versión="1.1.0"
  Diseñador="" Programador=" Ambiente="BD">
<Retorno>NA</Retorno>
<Descripción> Libera numeros </Descripción>
<Parámetros>
<Entrada>
<param nom="EN_num_extra" Tipo="Number">Descripción Número de Entrada extra</param>
</Entrada>
<Salida>
</Salida>
</Parámetros>
</Elemento>
</Documentación>
*/
   CURSOR c_libera(EN_num_extra al_ser_es_extras.num_extra%type)
    IS
             SELECT a.num_serie,a.cod_cat, a.cod_subalm,a.cod_producto,a.cod_central,a.num_telefono,
                        b.cod_uso,b.num_linea
                 FROM al_ser_es_extras a, al_lin_es_extras b
                 WHERE a.num_extra = EN_num_extra
                   AND a.num_extra=b.num_extra
                   AND a.num_linea=b.num_linea;

    LN_actuacion_des          ga_actabo.cod_actcen%type;
    LN_actuacion_des_gsm_ami  ga_actabo.cod_actcen%type;
    LN_actuacion_des_gsm      ga_actabo.cod_actcen%type;
    LN_actuacion_des_ami      ga_actabo.cod_actcen%type;
        LV_tecnologia             icg_central.cod_tecnologia%type;
        LR_reutil                 ga_celnum_reutil%rowtype;
        LN_series_numeradas       al_lin_es_extras.num_extra%type:=0;
        LV_terminal               al_articulos.tip_terminal%type;
        LV_terminalGSM
        al_articulos.tip_terminal%type;
        LN_UsoAmistar             al_usos.cod_uso%type;
        LN_actuacion              ga_actabo.cod_actcen%type;
        LV_serhexa                al_series.num_serie%type;
        LN_linea                  al_lin_es_extras.num_linea%type;

    CN_modulo      CONSTANT VARCHAR2(2):='AL';
    CN_prOducto    CONSTANT NUMBER(1):=1;
    LV_actabo_da             VARCHAR2(2):= 'DA';
    LV_actabo_mi             VARCHAR2(2 ):= 'MI';
    LV_actabo_gm             VARCHAR2(2):= 'GM';
    LV_actabo_dg             VARCHAR2(2):= 'DG';

        ERROR_LIBERACION         EXCEPTION;
        LN_NROERROR              NUMBER;
        LV_MSGERROR              VARCHAR2(100);


BEGIN

          SELECT count(CN_uno)
          INTO LN_series_numeradas
          FROM al_ser_es_extras
          WHERE num_extra = EN_num_extra
                AND num_telefono is not null;

          IF LN_series_numeradas > CN_cero THEN

          BEGIN
                   SELECT cod_uso_ami
               INTO LN_UsoAmistar
               FROM al_datos_generales;

          EXCEPTION
             WHEN OTHERS THEN
                  LN_UsoAmistar:=null;
                  LN_NROERROR:=-20101;
                  LV_MSGERROR:='Error al recuperar Uso Amistar de Datos Generales Logística';
                  RAISE ERROR_LIBERACION;
          END;

          BEGIN
                  SELECT distinct b.cod_tecnologia
                  INTO LV_tecnologia
                  FROM al_ser_es_extras a, icg_central b
                  WHERE a.num_extra=EN_num_extra
                AND a.cod_central=b.cod_central;
          EXCEPTION
             WHEN OTHERS THEN
                  LV_tecnologia:=null;
                  LN_NROERROR:=-20102;
                  LV_MSGERROR:='La Orden tiene distintas Tecnologías. Sólo se permite procesar una por Orden';
                  RAISE ERROR_LIBERACION;
          END;

          BEGIN
                SELECT val_parametro
            INTO LV_terminalGSM
            FROM ged_parametros
           WHERE nom_parametro = CV_paramGSM
             AND cod_modulo =CV_Modulo
             AND cod_producto = CN_uno;
          EXCEPTION
             WHEN OTHERS THEN
                  LV_terminal:=null;
                  LN_NROERROR:=-20104;
                  LV_MSGERROR:='Problemas al recuperar tipo de Terminal';
                  RAISE ERROR_LIBERACION;
          END;

          BEGIN
             SELECT cod_actcen
             INTO LN_actuacion_des_ami
             FROM ga_actabo
             WHERE cod_modulo     = CN_modulo
             AND cod_producto   = CN_producto
             AND cod_actabo     = LV_actabo_da
             AND cod_tecnologia = LV_tecnologia;
          EXCEPTION
              WHEN OTHERS THEN
                 LN_actuacion_des_ami :=null;
                  END;

                  BEGIN
             SELECT cod_actcen
             INTO LN_actuacion_des
             FROM ga_actabo
             WHERE cod_modulo     = CN_modulo
             AND cod_producto   = CN_producto
             AND cod_actabo     = LV_actabo_mi
             AND cod_tecnologia = LV_tecnologia;
                  EXCEPTION
              WHEN OTHERS THEN
                 LN_actuacion_des :=null;
                  END;

                  BEGIN
             SELECT cod_actcen
             INTO LN_actuacion_des_gsm_ami
             FROM ga_actabo
             WHERE cod_modulo     = CN_modulo
             AND cod_producto   = CN_producto
             AND cod_actabo     = LV_actabo_gm
             AND cod_tecnologia = LV_tecnologia;
                  EXCEPTION
              WHEN OTHERS THEN
                 LN_actuacion_des_gsm_ami :=null;
                  END;

                  BEGIN
             SELECT cod_actcen
             INTO LN_actuacion_des_gsm
             FROM ga_actabo
             WHERE cod_modulo     = CN_modulo
             AND cod_producto   = CN_producto
             AND cod_actabo     = LV_actabo_dg
             AND cod_tecnologia = LV_tecnologia;
          EXCEPTION
              WHEN OTHERS THEN
                 LN_actuacion_des_gsm :=null;
          END;



             FOR  v_reg IN c_libera(EN_num_extra) LOOP

                    IF LN_linea <> v_reg.num_linea THEN
                   BEGIN
                  SELECT tip_terminal
                  INTO LV_terminal
                  FROM al_lin_es_extras a, al_articulos b
                  WHERE a.num_extra=EN_num_extra
                    AND a.num_linea= v_reg.num_linea
                    AND a.cod_articulo=b.cod_articulo;
              EXCEPTION
                     WHEN OTHERS THEN
                          LV_terminal:=null;
                          LN_NROERROR:=-20103;
                          LV_MSGERROR:='Problemas al recuperar tipo de Terminal';
                          RAISE ERROR_LIBERACION;
                  END;
                          LN_linea:=v_reg.num_linea;
                    END IF;

                 LR_reutil.num_celular    := v_reg.num_telefono;
                         IF v_reg.num_telefono is not null THEN

                            LR_reutil.cod_subalm     := v_reg.cod_subalm;
                LR_reutil.cod_producto   := v_reg.cod_producto;
                LR_reutil.cod_central    := v_reg.cod_central;
                LR_reutil.cod_uso        := v_reg.cod_uso;
                LR_reutil.cod_cat        := v_reg.cod_cat;
                        BEGIN
                     --Al_Pac_Numeracion.p_libera_numero (LR_reutil);
                                         dbms_output.put_line('A');
                         EXCEPTION
                            WHEN OTHERS THEN
                                   LN_NROERROR:=-20106;
                           LV_MSGERROR:=substr(sqlcode ||' - '||sqlerrm,1,100);
                               RAISE ERROR_LIBERACION;
                    END;

                                IF v_reg.cod_uso = LN_UsoAmistar THEN
                   IF LV_terminal=LV_terminalGSM THEN
                      LN_actuacion := LN_actuacion_des_gsm_ami;
                   ELSE
                      LN_actuacion  := LN_actuacion_des_ami;
                   END IF ;
                ELSE
                    IF LV_terminal=LV_terminalGSM THEN
                        LN_actuacion  := LN_actuacion_des_gsm ;
                    ELSE
                       LN_actuacion  := LN_actuacion_des;
                    END IF;
               END IF;
                           BEGIN
                              IF  LV_terminal=LV_terminalGSM THEN
                                     LV_serhexa:=CN_cero;
                                  ELSE
                                     LV_serhexa:=al_conv_serhex_fn(v_reg.num_serie);
                                  END IF;

                  Al_Proc_Ingreso.p_desactiva_central (LN_actuacion , al_fn_prefijo_numero(v_reg.num_telefono),v_reg.cod_central,v_reg.num_telefono, LV_serhexa,LV_terminal, v_reg.num_serie);
               EXCEPTION
                            WHEN OTHERS THEN
                                   LN_NROERROR:=-20107;
                           LV_MSGERROR:=substr(sqlcode ||' - '||sqlerrm,1,100);
                               RAISE ERROR_LIBERACION;
                   END;


                 -- Updateamos la serie de AL_SERIES
                    UPDATE al_series
                    SET num_telefono = NULL,
                        cod_central  = NULL,
                        cod_subalm   = NULL,
                        cod_cat      = NULL,
                        PLAN         = NULL,
                        carga        = NULL,
                        ind_telefono = 0
                    WHERE num_serie = v_reg.num_serie;

                     END IF;
                 END LOOP;
          END IF;

EXCEPTION
  WHEN ERROR_LIBERACION THEN
       RAISE_APPLICATION_ERROR (LN_NROERROR,LV_MSGERROR);
  WHEN OTHERS THEN
       raise_application_error(-20102, sqlerrm);

END AL_LIBERA_NUMERO_ORDEN_PR;


PROCEDURE AL_LIBERA_NUMERO_SALIDA_PR (EN_num_extra IN al_ser_es_extras.num_extra%TYPE ,
                                                                   EN_num_linea IN al_ser_es_extras.num_linea%TYPE)
IS
/*
<Documentación TipoDoc = "Procedimiento">
<Elemento Nombre = "AL_LIBERA_NUMERO_SALIDA_PR" Lenguaje="PL/SQL" Fecha="16-03-2006" Versión="1.1.0"
  Diseñador="" Programador=" Ambiente="BD">
<Retorno>NA</Retorno>
<Descripción> Libera numeros </Descripción>
<Parámetros>
<Entrada>
<param nom="EN_num_extra" Tipo="Number">Descripción Número de Entrada extra</param>
</Entrada>
<Salida>
</Salida>
</Parámetros>
</Elemento>
</Documentación>
*/
   CURSOR c_libera(EN_num_extra al_ser_es_extras.num_extra%type,
                           EN_num_linea al_ser_es_extras.num_linea%type)
    IS
             SELECT a.num_serie,a.cod_cat, a.cod_subalm,a.cod_producto,a.cod_central,a.num_telefono,
                        b.cod_uso
                 FROM al_ser_es_extras a, al_lin_es_extras b
                 WHERE a.num_extra = EN_num_extra
                   AND a.num_linea = EN_num_linea
                   AND a.num_extra=b.num_extra
                   AND a.num_linea=b.num_linea;

    LN_actuacion_des          ga_actabo.cod_actcen%type;
    LN_actuacion_des_gsm_ami  ga_actabo.cod_actcen%type;
    LN_actuacion_des_gsm      ga_actabo.cod_actcen%type;
    LN_actuacion_des_ami      ga_actabo.cod_actcen%type;
        LV_tecnologia             icg_central.cod_tecnologia%type;
        LR_reutil                 ga_celnum_reutil%rowtype;
        LN_series_numeradas       al_lin_es_extras.num_extra%type:=0;
        LV_terminal               al_articulos.tip_terminal%type;
        LV_terminalGSM            al_articulos.tip_terminal%type;
        LN_UsoAmistar             al_usos.cod_uso%type;
        LN_actuacion              ga_actabo.cod_actcen%type;
        LV_serhexa                al_series.num_serie%type;

    CN_modulo      CONSTANT VARCHAR2(2):='AL';
    CN_prOducto    CONSTANT NUMBER(1):=1;
    LV_actabo_da             VARCHAR2(2):= 'DA';
    LV_actabo_mi             VARCHAR2(2 ):= 'MI';
    LV_actabo_gm             VARCHAR2(2):= 'GM';
    LV_actabo_dg             VARCHAR2(2):= 'DG';

        ERROR_LIBERACION         EXCEPTION;
        LN_NROERROR              NUMBER;
        LV_MSGERROR              VARCHAR2(100);


BEGIN

          SELECT count(CN_uno)
          INTO LN_series_numeradas
          FROM al_ser_es_extras
          WHERE num_extra = EN_num_extra
            AND num_linea = EN_num_linea
                AND num_telefono is not null;

          IF LN_series_numeradas > CN_cero THEN

          BEGIN
                   SELECT cod_uso_ami
               INTO LN_UsoAmistar
               FROM al_datos_generales;

          EXCEPTION
             WHEN OTHERS THEN
                  LN_UsoAmistar:=null;
                  LN_NROERROR:=-20101;
                  LV_MSGERROR:='Error al recuperar Uso Amistar de Datos Generales Logística';
                  RAISE ERROR_LIBERACION;
          END;

          BEGIN
                  SELECT distinct b.cod_tecnologia
                  INTO LV_tecnologia
                  FROM al_ser_es_extras a, icg_central b
                  WHERE a.num_extra=EN_num_extra
                    AND a.num_linea= EN_num_linea
                AND a.cod_central=b.cod_central;
          EXCEPTION
             WHEN OTHERS THEN
                  LV_tecnologia:=null;
                  LN_NROERROR:=-20102;
                  LV_MSGERROR:='La Orden tiene distintas Tecnologías. Sólo se permite procesar una por Orden';
                  RAISE ERROR_LIBERACION;
          END;

          BEGIN
                  SELECT tip_terminal
                  INTO LV_terminal
                  FROM al_lin_es_extras a, al_articulos b
                  WHERE a.num_extra=EN_num_extra
                    AND a.num_linea= EN_num_linea
                AND a.cod_articulo=b.cod_articulo;
          EXCEPTION
             WHEN OTHERS THEN
                  LV_terminal:=null;
                  LN_NROERROR:=-20103;
                  LV_MSGERROR:='Problemas al recuperar tipo de Terminal';
                  RAISE ERROR_LIBERACION;
          END;

          BEGIN
                SELECT val_parametro
            INTO LV_terminalGSM
            FROM ged_parametros
           WHERE nom_parametro = CV_paramGSM
             AND cod_modulo =CV_Modulo
             AND cod_producto = CN_uno;
          EXCEPTION
             WHEN OTHERS THEN
                  LV_terminal:=null;
                  LN_NROERROR:=-20104;
                  LV_MSGERROR:='Problemas al recuperar tipo de Terminal';
                  RAISE ERROR_LIBERACION;
          END;


          BEGIN
             SELECT cod_actcen
             INTO LN_actuacion_des_ami
             FROM ga_actabo
             WHERE cod_modulo     = CN_modulo
             AND cod_producto   = CN_producto
             AND cod_actabo     = LV_actabo_da
             AND cod_tecnologia = LV_tecnologia;
          EXCEPTION
              WHEN OTHERS THEN
                 LN_actuacion_des_ami :=null;
                  END;

                  BEGIN
             SELECT cod_actcen
             INTO LN_actuacion_des
             FROM ga_actabo
             WHERE cod_modulo     = CN_modulo
             AND cod_producto   = CN_producto
             AND cod_actabo     = LV_actabo_mi
             AND cod_tecnologia = LV_tecnologia;
                  EXCEPTION
              WHEN OTHERS THEN
                 LN_actuacion_des :=null;
                  END;

                  BEGIN
             SELECT cod_actcen
             INTO LN_actuacion_des_gsm_ami
             FROM ga_actabo
             WHERE cod_modulo     = CN_modulo
             AND cod_producto   = CN_producto
             AND cod_actabo     = LV_actabo_gm
             AND cod_tecnologia = LV_tecnologia;
                  EXCEPTION
              WHEN OTHERS THEN
                 LN_actuacion_des_gsm_ami :=null;
                  END;

                  BEGIN
             SELECT cod_actcen
             INTO LN_actuacion_des_gsm
             FROM ga_actabo
             WHERE cod_modulo     = CN_modulo
             AND cod_producto   = CN_producto
             AND cod_actabo     = LV_actabo_dg
             AND cod_tecnologia = LV_tecnologia;
          EXCEPTION
              WHEN OTHERS THEN
                 LN_actuacion_des_gsm :=null;
          END;



             FOR  v_reg IN c_libera(EN_num_extra,EN_num_linea) LOOP

                 LR_reutil.num_celular    := v_reg.num_telefono;
                         IF v_reg.num_telefono is not null THEN

                            LR_reutil.cod_subalm     := v_reg.cod_subalm;
                LR_reutil.cod_producto   := v_reg.cod_producto;
                LR_reutil.cod_central    := v_reg.cod_central;
                LR_reutil.cod_uso        := v_reg.cod_uso;
                LR_reutil.cod_cat        := v_reg.cod_cat;
                        BEGIN
                     Al_Pac_Numeracion.p_libera_numero (LR_reutil);
                         EXCEPTION
                            WHEN OTHERS THEN
                                   LN_NROERROR:=-20106;
                           LV_MSGERROR:=substr(sqlcode ||' - '||sqlerrm,1,100);
                               RAISE ERROR_LIBERACION;
                    END;

                                IF v_reg.cod_uso = LN_UsoAmistar THEN
                   IF LV_terminal=LV_terminalGSM THEN
                      LN_actuacion := LN_actuacion_des_gsm_ami;
                   ELSE
                      LN_actuacion  := LN_actuacion_des_ami;
                   END IF ;
                ELSE
                    IF LV_terminal=LV_terminalGSM THEN
                        LN_actuacion  := LN_actuacion_des_gsm ;
                    ELSE
                       LN_actuacion  := LN_actuacion_des;
                    END IF;
               END IF;
                           BEGIN
                              IF  LV_terminal=LV_terminalGSM THEN
                                     LV_serhexa:=CN_cero;
                                  ELSE
                                     LV_serhexa:=al_conv_serhex_fn(v_reg.num_serie);
                                  END IF;

                  Al_Proc_Ingreso.p_desactiva_central (LN_actuacion , al_fn_prefijo_numero(v_reg.num_telefono),v_reg.cod_central,v_reg.num_telefono, LV_serhexa,LV_terminal, v_reg.num_serie);
               EXCEPTION
                            WHEN OTHERS THEN
                                   LN_NROERROR:=-20107;
                           LV_MSGERROR:=substr(sqlcode ||' - '||sqlerrm,1,100);
                               RAISE ERROR_LIBERACION;
                   END;


                 -- Updateamos la serie de AL_SERIES
                    UPDATE al_series
                    SET num_telefono = NULL,
                        cod_central  = NULL,
                        cod_subalm   = NULL,
                        cod_cat      = NULL,
                        PLAN         = NULL,
                        carga        = NULL,
                        ind_telefono = 0
                    WHERE num_serie = v_reg.num_serie;

                     END IF;
                 END LOOP;
          END IF;

EXCEPTION
  WHEN ERROR_LIBERACION THEN
       RAISE_APPLICATION_ERROR (LN_NROERROR,LV_MSGERROR);
  WHEN OTHERS THEN
       raise_application_error(-20102, sqlerrm);

END AL_LIBERA_NUMERO_SALIDA_PR;

PROCEDURE AL_SER_ES_EXTRAS_PR( EN_num_extra IN AL_SER_ES_EXTRAS.NUM_EXTRA%TYPE ,
                                                           EN_num_linea IN AL_SER_ES_EXTRAS.NUM_LINEA%TYPE)
IS
/*
<Documentación TipoDoc = "Procedimiento">
<Elemento Nombre = "AL_SER_ES_EXTRAS_PR" Lenguaje="PL/SQL" Fecha="16-03-2006" Versión="1.1.0"
  Diseñador="Carlos Contreras Adasme" Programador="Carlos Contreras" Ambiente="BD">
<Retorno>NA</Retorno>
<Descripción> Recorre las series desde la tabla AL_SER_ES_EXTRAS,  y valida su existencia
              en almacen, Esto para poder cerra la orden sin inconvenientes.
                          (ES_EXTRAS = Entradas y Salidas Extras) </Descripción>
<Parámetros>
<Entrada>
<param nom="EN_num_extra" Tipo="Number">Descripción Número de Entrada extra</param>
<param nom="EN_num_linea" Tipo="Number">Descripción Número de Linea extra</param>
</Entrada>
<Salida>
</Salida>
</Parámetros>
</Elemento>
</Documentación>
*/

                CURSOR c_entradas(v_num_extra AL_SER_ES_EXTRAS.NUM_EXTRA%type,
                                  v_num_linea AL_SER_ES_EXTRAS.NUM_LINEA%type)
                IS
                     SELECT num_serie
                         FROM AL_SER_ES_EXTRAS
                         WHERE num_extra = v_num_extra
                           AND num_linea = v_num_linea ;

                EXCEPTION_SERIES exception;

                LV_sNumSerie  AL_SER_ES_EXTRAS.NUM_SERIE%type;
                LV_tip_terminal AL_ARTICULOS.TIP_TERMINAL%TYPE;

                LV_SQLCODE  ga_errores.cod_sqlcode%type;
                LV_SQLERRM  ga_errores.cod_sqlerrm%type;
                LV_ERROR    VARCHAR(10);
                LV_TABLA        ga_errores.nom_tabla%type;
                LN_ValidaEstadoSimcard NUMBER(1);

BEGIN

                FOR v_entradas IN c_entradas(EN_num_extra, EN_num_linea) LOOP
                      LV_sNumSerie:=v_entradas.num_serie;

                   LV_ERROR := '0';
                   LV_SQLERRM := 'OK';

                   BEGIN
                             p_al_compseries( LV_sNumSerie, 'FRMMANENTRADASEXTRAS');
                         EXCEPTION
                           WHEN OTHERS THEN
                                   LV_ERROR := '1';
                               LV_SQLCODE := SQLCODE;
                                   IF LV_SQLCODE = -20141 THEN
                                      LV_SQLERRM := 'Serie existe en AL_SERIES' ;
                                   ELSIF LV_SQLCODE = -20142 THEN
                                      LV_SQLERRM := 'Serie existe en AL_FIC_SERIES' ;
                                   ELSIF LV_SQLCODE = -20143 THEN
                                      LV_SQLERRM := 'Serie existe en GA_ABOAMIST' ;
                                   ELSIF LV_SQLCODE = -20144 THEN
                                      LV_SQLERRM := 'Serie existe en GA_ABOCEL' ;
                                   ELSIF LV_SQLCODE = -20148 THEN
                                      LV_SQLERRM := 'Serie existe en AL_COMPONENTE_KIT' ;
                                   ELSE
                                      LV_SQLERRM := SQLERRM;
                                   END IF ;
                           IF LV_ERROR <> '0' THEN
                             RAISE EXCEPTION_SERIES ;
                           END IF;
                        END ;


                        IF LV_ERROR = '0'  THEN
                           -- Validamos el estado de la simcard ...
                           SELECT tip_terminal
                             INTO LV_tip_terminal FROM AL_ARTICULOS
                           WHERE cod_articulo IN (SELECT cod_articulo FROM AL_LIN_ES_EXTRAS
                                                                   WHERE num_extra = EN_num_extra
                                                                           AND num_linea = EN_num_linea);

                                IF LV_tip_terminal = al_obtiene_parametro_fn('COD_SIMCARD_GSM','AL') THEN
                                   LN_ValidaEstadoSimcard := al_ValidaEstadoSimcard_fn(LV_sNumSerie) ;
                                   IF LN_ValidaEstadoSimcard =1 THEN
                                      LV_ERROR := '1';
                                          LV_SQLERRM := 'Número de Serie no registrada en Operadora' ;
                                   ELSIF LN_ValidaEstadoSimcard = 2 THEN
                                      LV_ERROR := '1';
                                          LV_SQLERRM := 'Estado de Serie no Valido para Entradas Extras' ;
                                   END IF;
                                END IF ;
                        END IF ;


                END LOOP;

                EXCEPTION
                    WHEN EXCEPTION_SERIES THEN
                           raise_application_error(-20103, sqlerrm);


END AL_SER_ES_EXTRAS_PR;

PROCEDURE AL_SER_SALIDAS_EXTRAS_PR( EN_num_extra IN AL_SER_ES_EXTRAS.NUM_EXTRA%TYPE ,
                                                                EN_num_linea IN AL_SER_ES_EXTRAS.NUM_LINEA%TYPE)
IS
/*
<Documentación TipoDoc = "Procedimiento">
<Elemento Nombre = "AL_SER_SALIDAS_EXTRAS_PR" Lenguaje="PL/SQL" Fecha="16-03-2006" Versión="1.1.0"
  Diseñador="Carlos Contreras Adasme" Programador="Carlos Contreras" Ambiente="BD">
<Retorno>NA</Retorno>
<Descripción> Recorre las series desde la tabla AL_SER_ES_EXTRAS,  y valida su existencia
              en almacen, Esto para poder cerra la orden sin inconvenientes.
                          (ES_EXTRAS = Entradas y Salidas Extras) </Descripción>
<Parámetros>
<Entrada>
<param nom="EN_num_extra" Tipo="Number">Descripción Número de Entrada extra</param>
<param nom="EN_num_linea" Tipo="Number">Descripción Número de Linea extra</param>
</Entrada>
<Salida>
</Salida>
</Parámetros>
</Elemento>
</Documentación>
*/

                CURSOR c_entradas(v_num_extra AL_SER_ES_EXTRAS.NUM_EXTRA%type,
                                  v_num_linea AL_SER_ES_EXTRAS.NUM_LINEA%type)
                IS
                     SELECT num_serie
                         FROM AL_SER_ES_EXTRAS
                         WHERE num_extra = v_num_extra
                           AND num_linea = v_num_linea ;

                EXCEPTION_SERIES exception;

                LV_sNumSerie  AL_SER_ES_EXTRAS.NUM_SERIE%type;
                LV_tip_terminal AL_ARTICULOS.TIP_TERMINAL%TYPE;

        LV_SQLCODE  ga_errores.cod_sqlcode%type;
        LV_SQLERRM  ga_errores.cod_sqlerrm%type;
        LV_ERROR    VARCHAR(10);
        LV_TABLA    ga_errores.nom_tabla%type;
                LN_ValidaEstadoSimcard NUMBER(1);

BEGIN

                FOR v_entradas IN c_entradas(EN_num_extra, EN_num_linea) LOOP
                      LV_sNumSerie:=v_entradas.num_serie;

                   LV_ERROR := '0';
                   LV_SQLERRM := 'OK';

                   BEGIN
                             p_al_compseries( LV_sNumSerie, 'FRMMANSALIDASEXTRAS');
                         EXCEPTION
                           WHEN OTHERS THEN
                                   LV_ERROR := '1';
                               LV_SQLCODE := SQLCODE;
                                   IF LV_SQLCODE = -20141 THEN
                                      LV_SQLERRM := 'Serie existe en AL_SERIES' ;
                                   ELSIF LV_SQLCODE = -20142 THEN
                                      LV_SQLERRM := 'Serie existe en AL_FIC_SERIES' ;
                                   ELSIF LV_SQLCODE = -20143 THEN
                                      LV_SQLERRM := 'Serie existe en GA_ABOAMIST' ;
                                   ELSIF LV_SQLCODE = -20144 THEN
                                      LV_SQLERRM := 'Serie existe en GA_ABOCEL' ;
                                   ELSIF LV_SQLCODE = -20148 THEN
                                      LV_SQLERRM := 'Serie existe en AL_COMPONENTE_KIT' ;
                                   ELSE
                                      LV_SQLERRM := SQLERRM;
                                   END IF ;
                           IF LV_ERROR <> '0' THEN
                             RAISE EXCEPTION_SERIES ;
                           END IF;
                        END ;



                END LOOP;

                EXCEPTION
                    WHEN EXCEPTION_SERIES THEN
                           raise_application_error(-20104, sqlerrm);


END AL_SER_SALIDAS_EXTRAS_PR;

PROCEDURE AL_VALIDA_ES_EXTRAS_PR( EN_num_extra  IN AL_SER_ES_EXTRAS.NUM_EXTRA%TYPE,
                                                           EN_num_linea  IN AL_SER_ES_EXTRAS.NUM_LINEA%TYPE)
IS
/*
<Documentación TipoDoc = "Procedimiento">
<Elemento Nombre = "AL_VALIDA_ES_EXTRAS_PR" Lenguaje="PL/SQL" Fecha="16-03-2006" Versión="1.1.0"
  Diseñador="Carlos Contreras Adasme" Programador="Carlos Contreras" Ambiente="BD">
<Retorno>NA</Retorno>
<Descripción> Recorre las series desde la tabla AL_SERIES_ES_EXTRAS_TT, y valida su existencia
              en almacen, registrando los errores dentro de la misma tabla.
                          (ES_EXTRAS = Entradas y Salidas Extras) </Descripción>
<Parámetros>
<Entrada>
<param nom="EN_num_extra" Tipo="Number">Descripción Número de Entrada extra</param>
<param nom="EN_num_linea" Tipo="Number">Descripción Número de Linea extra</param>
</Entrada>
<Salida>
</Salida>
</Parámetros>
</Elemento>
</Documentación>
*/

                CURSOR c_entradas(v_num_extra AL_SER_ES_EXTRAS.NUM_EXTRA%type,
                                  v_num_linea AL_SER_ES_EXTRAS.NUM_LINEA%type)
                IS
                       SELECT a.num_serie, c.cod_bodega, b.tip_stock,b.cod_articulo,b.cod_uso
                         FROM AL_SERIES_ES_EXTRAS_TT a, al_lin_es_extras b, al_cab_es_extras  c
                         WHERE a.num_extra = v_num_extra
                           AND a.num_linea = v_num_linea
                           and a.num_extra = b.num_extra
                           and a.num_linea = b.num_linea
                           and c.num_extra = b.num_extra;


                EXCEPTION_SERIES exception;

                LV_sNumSerie  AL_SER_ES_EXTRAS.NUM_SERIE%type;
                LV_tip_terminal AL_ARTICULOS.TIP_TERMINAL%TYPE;

        LV_SQLCODE      ga_errores.cod_sqlcode%type;
        LV_SQLERRM      ga_errores.cod_sqlerrm%type;
        LV_ERROR        VARCHAR(10);
        LV_TABLA        ga_errores.nom_tabla%type;
        LN_ValidaEstadoSimcard NUMBER(1);
        ln_maxmov       al_movimientos.num_movimiento%type;
        ln_cod_bodega   al_movimientos.cod_bodega%type;
        ln_cod_articulo al_movimientos.cod_articulo%type;
        ln_tip_stock    al_movimientos.tip_stock%type;
        ln_cod_uso      al_movimientos.cod_uso%type;
        lv_valparam     ged_parametros.val_parametro%type;

BEGIN


          lv_valparam:='N';
           begin 
              select trim(val_parametro) into lv_valparam 
                from ged_parametros 
                where nom_parametro='VALIDA_ATRIBEEMERC' and 
                      cod_modulo='AL' and cod_producto=1;
           exception
           when others then
                lv_valparam:='N';
           end;   
 

                FOR v_entradas IN c_entradas(EN_num_extra, EN_num_linea) LOOP
                        LV_sNumSerie:=v_entradas.num_serie;

                        LV_ERROR := '0';
                        LV_SQLERRM := 'OK';
                        LV_SQLCODE := '';

                        BEGIN

                               p_al_compseries( LV_sNumSerie, 'FRMMANENTRADASEXTRAS');
                        EXCEPTION
                           WHEN OTHERS THEN
                                   LV_ERROR := '1';
                               LV_SQLCODE := SQLCODE;
                                   IF LV_SQLCODE = -20141 THEN
                                      LV_SQLERRM := 'Serie existe en AL_SERIES' ;
                                   ELSIF LV_SQLCODE = -20142 THEN
                                      LV_SQLERRM := 'Serie existe en AL_FIC_SERIES' ;
                                   ELSIF LV_SQLCODE = -20143 THEN
                                      LV_SQLERRM := 'Serie existe en GA_ABOAMIST' ;
                                   ELSIF LV_SQLCODE = -20144 THEN
                                      LV_SQLERRM := 'Serie existe en GA_ABOCEL' ;
                                   ELSIF LV_SQLCODE = -20148 THEN
                                      LV_SQLERRM := 'Serie existe en AL_COMPONENTE_KIT' ;
                                           ELSIF LV_SQLCODE = -20153 THEN
                                              LV_SQLERRM := 'Serie NO existe en AL_SERIES' ;
                                   ELSE
                                      LV_SQLERRM := SQLERRM;
                                   END IF ;

                    END ;

                        IF LV_ERROR = '0'  THEN
                           -- Validamos el estado de la simcard ...
                           SELECT tip_terminal
                             INTO LV_tip_terminal FROM AL_ARTICULOS
                           WHERE cod_articulo IN (SELECT cod_articulo FROM AL_LIN_ES_EXTRAS
                                                                   WHERE num_extra = EN_num_extra
                                                                           AND num_linea = EN_num_linea);

                                IF LV_tip_terminal = al_obtiene_parametro_fn('COD_SIMCARD_GSM','AL') THEN
                                   LN_ValidaEstadoSimcard := al_ValidaEstadoSimcard_fn(LV_sNumSerie) ;
                                   IF LN_ValidaEstadoSimcard =1 THEN
                                      LV_ERROR := '1';
                                          LV_SQLERRM := 'Número de Serie no registrada en Operadora' ;
                                   ELSIF LN_ValidaEstadoSimcard = 2 THEN
                                      LV_ERROR := '1';
                                          LV_SQLERRM := 'Estado de Serie no Valido para Entradas Extras';
                                   END IF;
                                END IF ;
                        END IF ;

                        --Validar que  ingrese a la misma bodega, stock, articulo y uso
                        IF LV_ERROR = '0'  THEN
                          if lv_valparam='S' then
                           begin
                              ln_maxmov:=0;
                               select max(a.num_movimiento) into  ln_maxmov from al_movimientos a
                                where a.num_movimiento > 0  and
                                      a.num_serie = v_entradas.num_serie;

                               if ln_maxmov >0 then
                                  ln_cod_bodega:=NULL;
                                  ln_cod_articulo:=NULL;
                                  ln_tip_stock:=null;
                                  ln_cod_uso:=null;
                                  select a.cod_bodega, a.cod_articulo,a.tip_stock,a.cod_uso
                                    into ln_cod_bodega, ln_cod_articulo, ln_tip_stock, ln_cod_uso
                                    from al_movimientos a
                                   where a.num_movimiento = ln_maxmov;
                                  if ln_cod_bodega <> v_entradas.cod_bodega OR
                                     ln_cod_articulo <>  v_entradas.cod_articulo OR
                                     ln_tip_stock <> v_entradas.tip_stock OR
                                     ln_cod_uso <> v_entradas.cod_uso then
                                     LV_SQLERRM:=substr('Atributos <> al salir inv.(bo='||trim(ln_cod_bodega)||',art='||trim(ln_cod_articulo)||',st='||trim(ln_tip_stock)||',uso='||trim(ln_cod_uso)||')',1,60);
                                     LV_SQLCODE:= -20180;
                                     LV_ERROR:=1;


                                  end if;
                               end if;
                               exception
                           when others then
                                  null;
                           end;

                           end if;
                        END IF;

                 UPDATE AL_SERIES_ES_EXTRAS_TT SET
                           COD_ESTADO = LV_ERROR,
                           MSG_ERROR =  LV_SQLCODE||' '||LV_SQLERRM
                 WHERE NUM_SERIE = LV_sNumSerie;

                END LOOP;

                EXCEPTION
                    WHEN EXCEPTION_SERIES THEN
                                 raise_application_error(-20105, sqlerrm);

END AL_VALIDA_ES_EXTRAS_PR;

PROCEDURE AL_VALIDA_SALIDAS_EXTRAS_PR( EN_num_extra  IN AL_SER_ES_EXTRAS.num_extra%TYPE,
                                                                   EN_num_linea  IN AL_SER_ES_EXTRAS.num_linea%TYPE,
                                                                           EN_tip_stock IN AL_LIN_ES_EXTRAS.tip_stock%TYPE,
                                                                           EN_articulo  IN AL_LIN_ES_EXTRAS.cod_articulo%TYPE,
                                                                           EN_uso       IN AL_LIN_ES_EXTRAS.cod_uso%TYPE,
                                                                           EN_estado    IN AL_LIN_ES_EXTRAS.cod_estado%TYPE)
IS
/*
<Documentación TipoDoc = "Procedimiento">
<Elemento Nombre = "AL_VALIDA_SALIDAS_EXTRAS_PR" Lenguaje="PL/SQL" Fecha="16-03-2006" Versión="1.1.0"
  Diseñador="Carlos Contreras Adasme" Programador="Carlos Contreras" Ambiente="BD">
<Retorno>NA</Retorno>
<Descripción> Recorre las series desde la tabla AL_SERIES_ES_EXTRAS_TT, y valida su existencia
              en almacen, registrando los errores dentro de la misma tabla.
                          (ES_EXTRAS = Entradas y Salidas Extras) </Descripción>
<Parámetros>
<Entrada>
<param nom="EN_num_extra" Tipo="Number">Descripción Número de Entrada extra</param>
<param nom="EN_num_linea" Tipo="Number">Descripción Número de Linea extra</param>
</Entrada>
<Salida>
</Salida>
</Parámetros>
</Elemento>
</Documentación>
*/

                CURSOR c_salida(v_num_extra AL_SER_ES_EXTRAS.NUM_EXTRA%type,
                                v_num_linea AL_SER_ES_EXTRAS.NUM_LINEA%type)
                IS
                      SELECT a.num_serie serie_extra,
                     c.num_serie serie, c.cod_bodega bodega,b.cod_bodega bodega_extra,
                     c.tip_stock stock, c.cod_articulo art_serie,
                                         c.cod_uso uso_serie, c.cod_estado estado_serie,
                                         c.cod_bodega bodega_serie,c.num_telefono
              FROM AL_SERIES c, AL_SERIES_ES_EXTRAS_TT a, AL_CAB_ES_EXTRAS b
              WHERE a.num_extra = v_num_extra
                            AND a.num_linea = v_num_linea
                                ANd a.num_extra = b.num_extra
                AND c.num_serie(+) = a.num_serie ;

                EXCEPTION_SERIES exception;

                LV_sNumSerie  AL_SER_ES_EXTRAS.NUM_SERIE%type;
                LV_tip_terminal AL_ARTICULOS.TIP_TERMINAL%TYPE;

        LV_SQLCODE  ga_errores.cod_sqlcode%type;
        LV_SQLERRM  ga_errores.cod_sqlerrm%type;
        LV_ERROR    VARCHAR(10);
        LV_TABLA    ga_errores.nom_tabla%type;
                LN_ValidaEstadoSimcard NUMBER(1);

BEGIN

                FOR salida IN c_salida(EN_num_extra, EN_num_linea) LOOP


                        LV_ERROR := '0';
                        LV_SQLERRM := 'OK';
                        LV_SQLCODE := '';
            IF salida.serie is null THEN
                            LV_ERROR := '1';
                            LV_SQLERRM := 'Serie No existe en AL_SERIES' ;
                        ELSIF EN_tip_stock<>salida.stock THEN
                        LV_ERROR := '2';
                            LV_SQLERRM := 'No corresponde el Stock' ;
                        ELSIF EN_articulo<>salida.art_serie THEN
                LV_ERROR := '3';
                                LV_SQLERRM := 'No corresponde el Artículo' ;
                        ELSIF  EN_uso<>salida.uso_serie THEN
                            LV_ERROR := '4';
                                LV_SQLERRM := 'No corresponde el Uso' ;
                        ELSIF EN_estado<>salida.estado_serie THEN
                     LV_ERROR := '5';
                                LV_SQLERRM := 'No corresponde el Estado' ;
                        ELSIF salida.bodega_extra <>salida.bodega_serie THEN
                        LV_ERROR := '6';
                                LV_SQLERRM := 'Serie se encuentra en otra Bodega' ;
                        --ELSIF  (salida.num_telefono is not null) THEN
                        --    LV_ERROR := '7';
                        --    LV_SQLERRM := 'Serie se encuentra Numerada' ;
                    END IF;

                UPDATE AL_SERIES_ES_EXTRAS_TT SET
                           COD_ESTADO = LV_ERROR,
                           MSG_ERROR =  LV_SQLCODE||' '||LV_SQLERRM
                    WHERE NUM_SERIE = salida.serie_extra;

                END LOOP;

EXCEPTION
   WHEN EXCEPTION_SERIES THEN
         raise_application_error(-20106, sqlerrm);

END AL_VALIDA_SALIDAS_EXTRAS_PR;



PROCEDURE AL_INSERTA_SERIES_ES_EXTRAS_PR( EN_num_extra IN AL_SER_ES_EXTRAS.NUM_EXTRA%TYPE ,
                                                                                  EN_num_linea IN AL_SER_ES_EXTRAS.NUM_LINEA%TYPE)
IS
/*
<Documentación TipoDoc = "Procedimiento">
<Elemento Nombre = "AL_INSERTA_SERIES_ES_EXTRAS_PR" Lenguaje="PL/SQL" Fecha="16-03-2006" Versión="1.1.0"
  Diseñador="Carlos Contreras Adasme" Programador="Carlos Contreras" Ambiente="BD">
<Retorno>NA</Retorno>
<Descripción> Recorre las series desde la tabla AL_SERIES_ES_EXTRAS_TT, Insertando y creando
              las series validas de una orden de entradas extras.
                          (ES_EXTRAS = Entradas y Salidas Extras) </Descripción>
<Parámetros>
<Entrada>
<param nom="EN_num_extra" Tipo="Number">Descripción Número de Entrada extra</param>
<param nom="EN_num_linea" Tipo="Number">Descripción Número de Linea extra</param>
</Entrada>
<Salida>
</Salida>
</Parámetros>
</Elemento>
</Documentación>
*/

                CURSOR c_entradas(v_num_extra AL_SER_ES_EXTRAS.NUM_EXTRA%type,
                                                  v_num_linea AL_SER_ES_EXTRAS.NUM_LINEA%type)
                IS
                     SELECT num_serie
                         FROM AL_SERIES_ES_EXTRAS_TT
                         WHERE num_extra = v_num_extra
                           AND num_linea = v_num_linea ;

                EXCEPTION_SERIES exception;

                LV_num_serie  al_ser_es_extras.num_serie%type;
        LV_SQLCODE  ga_errores.cod_sqlcode%type;
        LV_SQLERRM  ga_errores.cod_sqlerrm%type;
        LV_ERROR    VARCHAR(10);
        LV_TABLA    ga_errores.nom_tabla%type;
                LN_telefono al_series.num_telefono%type;
                LV_subalm al_series.cod_subalm%type;
                LN_central al_series.cod_central%type;
                LN_cat al_series.cod_cat%type;

BEGIN

                FOR v_entradas IN c_entradas(EN_num_extra, EN_num_linea) LOOP
                    LV_num_serie:=v_entradas.num_serie;

                        BEGIN
                        SELECT num_telefono,cod_subalm,cod_central,cod_cat
                        INTO LN_telefono,LV_subalm,LN_central,LN_cat
                        FROM AL_SERIES
                        WHERE num_serie =LV_num_serie;
            EXCEPTION
                           WHEN OTHERS THEN
                             LN_telefono:=null;
                                 LV_subalm:=null;
                                 LN_central:=null;
                                 LN_cat:=null;
                        END;
                    INSERT INTO AL_SER_ES_EXTRAS (NUM_EXTRA, NUM_LINEA, NUM_SERIE, COD_PRODUCTO,COD_HLR, NUM_TELEFONO,COD_CENTRAL,COD_SUBALM,COD_CAT)
                    VALUES(EN_num_extra, EN_num_linea, LV_num_serie, 1, AL_OBTIENE_HLR_FN(LV_num_serie),  LN_telefono,LN_central,LV_subalm,LN_cat);

                    IF SQLCODE <> 0 THEN
                               LV_ERROR := '1';
                                   LV_SQLERRM := substr(SQLERRM,1,60);
                                   LV_SQLCODE := SQLCODE;
                                   RAISE EXCEPTION_SERIES;
                    END IF;

                END LOOP;

                EXCEPTION
                    WHEN EXCEPTION_SERIES THEN
                   raise_application_error(-20107, sqlerrm);
END AL_INSERTA_SERIES_ES_EXTRAS_PR;

PROCEDURE AL_INSERTA_SALIDAS_EXTRAS_PR( EN_num_extra IN AL_SER_ES_EXTRAS.NUM_EXTRA%TYPE ,
                                                                                       EN_num_linea IN AL_SER_ES_EXTRAS.NUM_LINEA%TYPE,
                                                                                           EN_tip_stock IN AL_LIN_ES_EXTRAS.TIP_STOCK%TYPE,
                                                                                           EN_articulo  IN AL_LIN_ES_EXTRAS.COD_ARTICULO%TYPE,
                                                                                           EN_uso       IN AL_LIN_ES_EXTRAS.cod_uso%TYPE,
                                                                                           EN_estado    IN AL_LIN_ES_EXTRAS.cod_estado%TYPE,
                                                                                           EN_nro       IN AL_LIN_ES_EXTRAS.can_extra%TYPE)
IS
/*
<Documentación TipoDoc = "Procedimiento">
<Elemento Nombre = "AL_INSERTA_SERIES_SALIDAS_EXTRAS_PR" Lenguaje="PL/SQL" Fecha="16-03-2006" Versión="1.1.0"
  Diseñador="Carlos Contreras Adasme" Programador="Carlos Contreras" Ambiente="BD">
<Retorno>NA</Retorno>
<Descripción> Recorre las series desde la tabla , Insertando y creando
              las series validas de una orden de entradas extras.
                          (ES_EXTRAS = Entradas y Salidas Extras) </Descripción>
<Parámetros>
<Entrada>
<param nom="EN_num_extra" Tipo="Number">Descripción Número de Entrada extra</param>
<param nom="EN_num_linea" Tipo="Number">Descripción Número de Linea extra</param>
</Entrada>
<Salida>
</Salida>
</Parámetros>
</Elemento>
</Documentación>
*/

                CURSOR c_entradas(v_num_extra AL_SER_ES_EXTRAS.NUM_EXTRA%type,
                                                  v_num_linea AL_SER_ES_EXTRAS.NUM_LINEA%type)
                IS
                     SELECT num_serie
                         FROM AL_SERIES_ES_EXTRAS_TT
                         WHERE num_extra = v_num_extra
                           AND num_linea = v_num_linea ;

                EXCEPTION_SERIES exception;

                LV_num_serie  AL_SER_ES_EXTRAS.NUM_SERIE%type;
        LV_SQLCODE  ga_errores.cod_sqlcode%type;
        LV_SQLERRM  ga_errores.cod_sqlerrm%type;
        LV_ERROR    VARCHAR(10);
        LV_TABLA    ga_errores.nom_tabla%type;
                LN_telefono al_series.num_telefono%type;
                LV_subalm al_series.cod_subalm%type;
                LN_central al_series.cod_central%type;
                LN_cat al_series.cod_cat%type;

BEGIN
        INSERT INTO AL_LIN_ES_EXTRAS(num_extra, num_linea, tip_stock, cod_articulo, cod_uso, cod_estado, can_extra, prc_unidad, num_desde, num_hasta, num_sec_loca, cod_plaza)
                VALUES(EN_num_extra, EN_num_linea,EN_tip_stock,EN_articulo,En_uso,EN_estado,EN_nro,null,null,null,null,null);


                FOR v_entradas IN c_entradas(EN_num_extra, EN_num_linea) LOOP
                    LV_num_serie:=v_entradas.num_serie;
            BEGIN
                        SELECT num_telefono,cod_subalm,cod_central,cod_cat
                        INTO LN_telefono,LV_subalm,LN_central,LN_cat
                        FROM AL_SERIES
                        WHERE num_serie =LV_num_serie;
            EXCEPTION
                           WHEN OTHERS THEN
                             LN_telefono:=null;
                                 LV_subalm:=null;
                                 LN_central:=null;
                                 LN_cat:=null;
                        END;


                    INSERT INTO AL_SER_ES_EXTRAS (NUM_EXTRA, NUM_LINEA, NUM_SERIE, COD_PRODUCTO,COD_HLR,NUM_TELEFONO,COD_CENTRAL,COD_SUBALM,COD_CAT)
                         VALUES(EN_num_extra, EN_num_linea, LV_num_serie, 1, AL_OBTIENE_HLR_FN(LV_num_serie),  LN_telefono,LN_central,LV_subalm,LN_cat);

                    IF SQLCODE <> 0  THEN
                               LV_ERROR := '1';
                                   LV_SQLERRM := substr(SQLERRM,1,60);
                                   LV_SQLCODE := SQLCODE;
                                   RAISE EXCEPTION_SERIES;
                    END IF;

                END LOOP;

                EXCEPTION
                    WHEN EXCEPTION_SERIES THEN
                  raise_application_error(-20108, sqlerrm);
END AL_INSERTA_SALIDAS_EXTRAS_PR;


FUNCTION AL_OBTIENE_HLR_FN( EV_num_serie  IN AL_SERIES.NUM_SERIE%TYPE)
          RETURN al_series.cod_hlr%TYPE

IS
/*
<Documentación TipoDoc = "Función">
<Elemento Nombre = "AL_OBTIENE_HLR_FN" Lenguaje="PL/SQL" Fecha="16-03-2006" Versión="1.1.0"
  Diseñador="Carlos Contreras Adasme" Programador="Carlos Contreras" Ambiente="BD">
<Retorno>Varchar</Retorno>
<Descripción> Obtiene desde las tablas de gestión de Simcard el halr correspondiente </Descripción>
<Parámetros>
<Entrada>
 <param nom="EV_num_serie" Tipo="Varchar2">Descripción Serie a procesar... </param>
</Entrada>
<Salida>
 <param nom="Hlr" Tipo="Varchar2">Descripción HLR de la serie ... </param>
</Salida>
</Parámetros>
</Elemento>
</Documentación>
*/

                                SV_cod_hlr       al_series.cod_hlr%TYPE;
BEGIN

                   BEGIN
                                SELECT COD_HLR  INTO SV_cod_hlr
                                 FROM GSM_SIMCARD_TO
                                 WHERE  NUM_SIMCARD = EV_num_serie ;

                                EXCEPTION
                                           WHEN NO_DATA_FOUND THEN
                                          SV_cod_hlr := '';
                                           WHEN OTHERS THEN
                                              SV_cod_hlr := '';
                   END ;

                   RETURN SV_cod_hlr;

END AL_OBTIENE_HLR_FN;

FUNCTION AL_OBTIENE_PARAMETRO_FN( EV_nom_parametro  IN GED_PARAMETROS.NOM_PARAMETRO%TYPE,
                                                                  EV_cod_modulo         IN GED_PARAMETROS.COD_MODULO%TYPE)
          RETURN GED_PARAMETROS.VAL_PARAMETRO%TYPE
IS
/*
<Documentación TipoDoc = "Función">
<Elemento Nombre = "AL_OBTIENE_PARAMETRO_FN" Lenguaje="PL/SQL" Fecha="20-03-2006" Versión="1.1.0"
  Diseñador="Carlos Contreras Adasme" Programador="Carlos Contreras" Ambiente="BD">
<Retorno>Varchar</Retorno>
<Descripción> Obtiene desde las tabla de ged_parametro el valor del parametro </Descripción>
<Parámetros>
<Entrada>
 <param nom="EV_nom_parametro" Tipo="Varchar2">Nombre del parametro... </param>
 <param nom="EV_cod_modulo" Tipo="Varchar2">codigo modulo scl ... </param>
</Entrada>
<Salida>
 <param nom="val_parametro" Tipo="Varchar2">Valor del parametro... </param>
</Salida>
</Parámetros>
</Elemento>
</Documentación>
*/

                                LV_val_parametro       GED_PARAMETROS.VAL_PARAMETRO%TYPE;
BEGIN

                   BEGIN
                                SELECT VAL_PARAMETRO  INTO LV_val_parametro
                                 FROM GED_PARAMETROS
                                 WHERE  NOM_PARAMETRO = EV_nom_parametro
                                   AND  COD_MODULO = EV_cod_modulo ;

                                EXCEPTION
                                           WHEN NO_DATA_FOUND THEN
                                          LV_val_parametro := '';
                                           WHEN OTHERS THEN
                                              LV_val_parametro := '';
                   END ;

                   RETURN LV_val_parametro;

END AL_OBTIENE_PARAMETRO_FN;



FUNCTION AL_VALIDAESTADOSIMCARD_FN( EV_num_serie  IN AL_SERIES.NUM_SERIE%TYPE)
                  RETURN AL_SERIES.COD_PRODUCTO%TYPE
IS
/*
<Documentación TipoDoc = "Función">
<Elemento Nombre = "AL_VALIDAESTADOSIMCARD_FN" Lenguaje="PL/SQL" Fecha="20-03-2006" Versión="1.1.0"
  Diseñador="Carlos Contreras Adasme" Programador="Carlos Contreras" Ambiente="BD">
<Retorno>Varchar</Retorno>
<Descripción> Obtiene estado de Simcard desde modulo gestion de simcard </Descripción>
<Parámetros>
<Entrada>
 <param nom="EV_num_serie" Tipo="Varchar2">Descripción Serie a procesar... </param>
</Entrada>
<Salida>
 <param nom="estado" Tipo="Varchar2">Estado de la serie Simcard ... </param>
</Salida>
</Parámetros>
</Elemento>
</Documentación>
*/

                                LN_retorno              NUMBER(1);
                                LV_estado       VARCHAR(10);
BEGIN

                   BEGIN
                        LV_estado := Al_FN_EstadoICC(EV_num_serie);
                                IF LV_estado = 'EI' THEN
                                   LN_retorno := 0;
                                ELSIF LV_estado = 'FALSE' THEN  --NOT FOUND
                                   LN_retorno := 1 ;
                                ELSE
                                   LN_retorno := 2;
                                END IF;
                   END ;

                   RETURN LN_retorno;

END AL_VALIDAESTADOSIMCARD_FN;


PROCEDURE AL_INSERTA_EXTRAS_PR( EN_num_extra IN AL_SER_ES_EXTRAS.NUM_EXTRA%TYPE ,
                                                                EN_num_linea IN AL_SER_ES_EXTRAS.NUM_LINEA%TYPE,
                                                                EN_tip_stock IN AL_LIN_ES_EXTRAS.TIP_STOCK%TYPE,
                                                                EN_articulo  IN AL_LIN_ES_EXTRAS.COD_ARTICULO%TYPE,
                                                                EN_uso       IN AL_LIN_ES_EXTRAS.cod_uso%TYPE,
                                                                EN_estado    IN AL_LIN_ES_EXTRAS.cod_estado%TYPE,
                                                                EN_nro       IN AL_LIN_ES_EXTRAS.can_extra%TYPE,
                                                                EN_precio       IN AL_LIN_ES_EXTRAS.prc_unidad%TYPE)
IS
/*
<Documentación TipoDoc = "Procedimiento">
<Elemento Nombre = "AL_INSERTA_SERIES_SALIDAS_EXTRAS_PR" Lenguaje="PL/SQL" Fecha="16-03-2006" Versión="1.1.0"
  Diseñador="Carlos Contreras Adasme" Programador="Carlos Contreras" Ambiente="BD">
<Retorno>NA</Retorno>
<Descripción> Recorre las series desde la tabla , Insertando y creando
              las series validas de una orden de entradas extras.
                          (ES_EXTRAS = Entradas y Salidas Extras) </Descripción>
<Parámetros>
<Entrada>
<param nom="EN_num_extra" Tipo="Number">Descripción Número de Entrada extra</param>
<param nom="EN_num_linea" Tipo="Number">Descripción Número de Linea extra</param>
</Entrada>
<Salida>
</Salida>
</Parámetros>
</Elemento>
</Documentación>
*/

                CURSOR c_entradas(v_num_extra AL_SER_ES_EXTRAS.NUM_EXTRA%type,
                                                  v_num_linea AL_SER_ES_EXTRAS.NUM_LINEA%type)
                IS
                     SELECT num_serie
                         FROM AL_SERIES_ES_EXTRAS_TT
                         WHERE cod_estado=CN_cero
                           AND num_extra = v_num_extra
                           AND num_linea = v_num_linea ;

                EXCEPTION_SERIES exception;

                LV_num_serie  AL_SER_ES_EXTRAS.NUM_SERIE%type;
        LV_SQLCODE  ga_errores.cod_sqlcode%type;
        LV_SQLERRM  ga_errores.cod_sqlerrm%type;
        LV_ERROR    VARCHAR(10);
        LV_TABLA    ga_errores.nom_tabla%type;
                LN_telefono al_series.num_telefono%type;
                LV_subalm al_series.cod_subalm%type;
                LN_central al_series.cod_central%type;
                LN_cat al_series.cod_cat%type;

BEGIN
        INSERT INTO AL_LIN_ES_EXTRAS(num_extra, num_linea, tip_stock, cod_articulo, cod_uso, cod_estado, can_extra, prc_unidad, num_desde, num_hasta, num_sec_loca, cod_plaza)
                VALUES(EN_num_extra, EN_num_linea,EN_tip_stock,EN_articulo,En_uso,EN_estado,EN_nro,EN_precio,null,null,null,null);


                FOR v_entradas IN c_entradas(EN_num_extra, EN_num_linea) LOOP
                    LV_num_serie:=v_entradas.num_serie;
            BEGIN
                        SELECT num_telefono,cod_subalm,cod_central,cod_cat
                        INTO LN_telefono,LV_subalm,LN_central,LN_cat
                        FROM AL_SERIES
                        WHERE num_serie =LV_num_serie;
            EXCEPTION
                           WHEN OTHERS THEN
                             LN_telefono:=null;
                                 LV_subalm:=null;
                                 LN_central:=null;
                                 LN_cat:=null;
                        END;


                    INSERT INTO AL_SER_ES_EXTRAS (NUM_EXTRA, NUM_LINEA, NUM_SERIE, COD_PRODUCTO,COD_HLR, NUM_TELEFONO,COD_CENTRAL,COD_SUBALM,COD_CAT)
                    VALUES(EN_num_extra, EN_num_linea, LV_num_serie, 1, AL_OBTIENE_HLR_FN(LV_num_serie),LN_telefono,LN_central,LV_subalm,LN_cat);

                    IF SQLCODE <> 0  THEN
                               LV_ERROR := '1';
                                   LV_SQLERRM := substr(SQLERRM,1,60);
                                   LV_SQLCODE := SQLCODE;
                                   RAISE EXCEPTION_SERIES;
                    END IF;

                END LOOP;

                EXCEPTION
                    WHEN EXCEPTION_SERIES THEN
                                 raise_application_error(-20108, sqlerrm);

END AL_INSERTA_EXTRAS_PR;


PROCEDURE AL_INSERTA_SIMULTANEO_PR( EN_num_extra IN AL_SER_ES_EXTRAS.NUM_EXTRA%TYPE ,
                                                                EN_num_linea IN AL_SER_ES_EXTRAS.NUM_LINEA%TYPE,
                                                                EN_tip_stock IN AL_LIN_ES_EXTRAS.TIP_STOCK%TYPE,
                                                                EN_articulo  IN AL_LIN_ES_EXTRAS.COD_ARTICULO%TYPE,
                                                                EN_uso       IN AL_LIN_ES_EXTRAS.cod_uso%TYPE,
                                                                EN_estado    IN AL_LIN_ES_EXTRAS.cod_estado%TYPE,
                                                                EN_nro       IN AL_LIN_ES_EXTRAS.can_extra%TYPE,
                                                                EN_precio       IN AL_LIN_ES_EXTRAS.prc_unidad%TYPE,
                                                                EN_proceso IN al_series_es_extras_tt.ind_proceso%TYPE)
IS
/*
<Documentación TipoDoc = "Procedimiento">
<Elemento Nombre = "AL_INSERTA_SERIES_SALIDAS_EXTRAS_PR" Lenguaje="PL/SQL" Fecha="16-03-2006" Versión="1.1.0"
  Diseñador="Carlos Contreras Adasme" Programador="Carlos Contreras" Ambiente="BD">
<Retorno>NA</Retorno>
<Descripción> Recorre las series desde la tabla , Insertando y creando
              las series validas de una orden de entradas extras.
                          (ES_EXTRAS = Entradas y Salidas Extras) </Descripción>
<Parámetros>
<Entrada>
<param nom="EN_num_extra" Tipo="Number">Descripción Número de Entrada extra</param>
<param nom="EN_num_linea" Tipo="Number">Descripción Número de Linea extra</param>
</Entrada>
<Salida>
</Salida>
</Parámetros>
</Elemento>
</Documentación>
*/

                CURSOR c_entradas(v_num_extra AL_SER_ES_EXTRAS.NUM_EXTRA%type,
                                                  v_num_linea AL_SER_ES_EXTRAS.NUM_LINEA%type)
                IS
                     SELECT num_serie, ind_proceso
                         FROM AL_SERIES_ES_EXTRAS_TT
                         WHERE cod_estado=CN_cero
                           AND num_extra = v_num_extra
                           AND num_linea = v_num_linea ;

                EXCEPTION_SERIES exception;

                LV_num_serie  AL_SER_ES_EXTRAS.NUM_SERIE%type;
        LV_SQLCODE  ga_errores.cod_sqlcode%type;
        LV_SQLERRM  ga_errores.cod_sqlerrm%type;
        LV_ERROR    VARCHAR(10);
        LV_TABLA    ga_errores.nom_tabla%type;
                LN_telefono al_series.num_telefono%type;
                LV_subalm al_series.cod_subalm%type;
                LN_central al_series.cod_central%type;
                LN_cat al_series.cod_cat%type;

BEGIN
        INSERT INTO AL_LIN_ES_EXTRAS(num_extra, num_linea, tip_stock, cod_articulo, cod_uso, cod_estado, can_extra, prc_unidad, num_desde, num_hasta, num_sec_loca, cod_plaza)
                VALUES(EN_num_extra, EN_num_linea,EN_tip_stock,EN_articulo,En_uso,EN_estado,EN_nro,EN_precio,null,null,null,null);


                FOR v_entradas IN c_entradas(EN_num_extra, EN_num_linea) LOOP
                    LV_num_serie:=v_entradas.num_serie;
            BEGIN
                        SELECT num_telefono,cod_subalm,cod_central,cod_cat
                        INTO LN_telefono,LV_subalm,LN_central,LN_cat
                        FROM AL_SERIES
                        WHERE num_serie =LV_num_serie;
            EXCEPTION
                           WHEN OTHERS THEN
                             LN_telefono:=null;
                                 LV_subalm:=null;
                                 LN_central:=null;
                                 LN_cat:=null;
                        END;


                    INSERT INTO AL_SER_ES_EXTRAS (NUM_EXTRA, NUM_LINEA, NUM_SERIE, IND_PROCESO,COD_PRODUCTO,COD_HLR, NUM_TELEFONO,COD_CENTRAL,COD_SUBALM,COD_CAT)
                    VALUES(EN_num_extra, EN_num_linea, LV_num_serie, v_entradas.ind_proceso,1, AL_OBTIENE_HLR_FN(LV_num_serie),LN_telefono,LN_central,LV_subalm,LN_cat);

                    IF SQLCODE <> 0  THEN
                               LV_ERROR := '1';
                                   LV_SQLERRM := substr(SQLERRM,1,60);
                                   LV_SQLCODE := SQLCODE;
                                   RAISE EXCEPTION_SERIES;
                    END IF;

                END LOOP;

                EXCEPTION
                    WHEN EXCEPTION_SERIES THEN
                                 raise_application_error(-20108, sqlerrm);

END AL_INSERTA_SIMULTANEO_PR;

PROCEDURE AL_VALIDA_ENTRADAS_EXTRAS_PR( EN_num_extra  IN al_ser_es_extras.num_extra%type,
                                                                    EN_num_linea  IN al_ser_es_extras.num_linea%type,
                                                                                EN_articulo   IN al_lin_es_extras.cod_articulo%type)
IS
/*
<Documentación TipoDoc = "Procedimiento">
<Elemento Nombre = "AL_VALIDA_ES_EXTRAS_PR" Lenguaje="PL/SQL" Fecha="16-03-2006" Versión="1.1.0"
  Diseñador="Carlos Contreras Adasme" Programador="Carlos Contreras" Ambiente="BD">
<Retorno>NA</Retorno>
<Descripción> Recorre las series desde la tabla AL_SERIES_ES_EXTRAS_TT, y valida su existencia
              en almacen, registrando los errores dentro de la misma tabla.
                          (ES_EXTRAS = Entradas y Salidas Extras) </Descripción>
<Parámetros>
<Entrada>
<param nom="EN_num_extra" Tipo="Number">Descripción Número de Entrada extra</param>
<param nom="EN_num_linea" Tipo="Number">Descripción Número de Linea extra</param>
</Entrada>
<Salida>
</Salida>
</Parámetros>
</Elemento>
</Documentación>
*/

              CURSOR c_entradas(v_num_extra AL_SER_ES_EXTRAS.NUM_EXTRA%type,
                                  v_num_linea AL_SER_ES_EXTRAS.NUM_LINEA%type)  IS
               SELECT a.num_serie, c.cod_bodega, b.tip_stock,b.cod_articulo,b.cod_uso
                         FROM AL_SERIES_ES_EXTRAS_TT a, al_lin_es_extras b, al_cab_es_extras  c
                         WHERE a.num_extra = v_num_extra
                           AND a.num_linea = v_num_linea
                           and a.num_extra = b.num_extra
                           and a.num_linea = b.num_linea
                           and c.num_extra = b.num_extra;

                EXCEPTION_SERIES exception;

                LV_sNumSerie  AL_SER_ES_EXTRAS.NUM_SERIE%type;
                LV_tip_terminal AL_ARTICULOS.TIP_TERMINAL%TYPE;

        LV_SQLCODE  ga_errores.cod_sqlcode%type;
        LV_SQLERRM  ga_errores.cod_sqlerrm%type;
        LV_ERROR    VARCHAR(10);
        LV_TABLA    ga_errores.nom_tabla%type;
        LN_ValidaEstadoSimcard NUMBER(1);
        ln_maxmov       al_movimientos.num_movimiento%type;
        ln_cod_bodega   al_movimientos.cod_bodega%type;
        ln_cod_articulo al_movimientos.cod_articulo%type;
        ln_tip_stock    al_movimientos.tip_stock%type;
        ln_cod_uso      al_movimientos.cod_uso%type;
        lv_valparam     ged_parametros.val_parametro%type;

BEGIN
          lv_valparam:='N';
           begin 
              select trim(val_parametro) into lv_valparam 
                from ged_parametros 
                where nom_parametro='VALIDA_ATRIBEEMERC' and 
                      cod_modulo='AL' and cod_producto=1;
           exception
           when others then
                lv_valparam:='N';
           end;   
 

                FOR v_entradas IN c_entradas(EN_num_extra, EN_num_linea) LOOP
                        LV_sNumSerie:=v_entradas.num_serie;

                        LV_ERROR := '0';
                        LV_SQLERRM := 'OK';
                        LV_SQLCODE := '';

                        BEGIN

                               p_al_compseries( LV_sNumSerie, 'FRMMANENTRADASEXTRAS');
                        EXCEPTION
                           WHEN OTHERS THEN
                                   LV_ERROR := '1';
                               LV_SQLCODE := SQLCODE;
                                   IF LV_SQLCODE = -20141 THEN
                                      LV_SQLERRM := 'Serie existe en AL_SERIES' ;
                                   ELSIF LV_SQLCODE = -20142 THEN
                                      LV_SQLERRM := 'Serie existe en AL_FIC_SERIES' ;
                                   ELSIF LV_SQLCODE = -20143 THEN
                                      LV_SQLERRM := 'Serie existe en GA_ABOAMIST' ;
                                   ELSIF LV_SQLCODE = -20144 THEN
                                      LV_SQLERRM := 'Serie existe en GA_ABOCEL' ;
                                   ELSIF LV_SQLCODE = -20148 THEN
                                      LV_SQLERRM := 'Serie existe en AL_COMPONENTE_KIT' ;
                                           ELSIF LV_SQLCODE = -20153 THEN
                                              LV_SQLERRM := 'Serie NO existe en AL_SERIES' ;
                                   ELSE
                                      LV_SQLERRM := SQLERRM;
                                   END IF ;

                    END ;

                        IF LV_ERROR = '0'  THEN
                           -- Validamos el estado de la simcard ...
                           SELECT tip_terminal
                             INTO LV_tip_terminal FROM AL_ARTICULOS
                           WHERE cod_articulo =EN_articulo;

                                IF LV_tip_terminal = al_obtiene_parametro_fn('COD_SIMCARD_GSM','AL') THEN
                                   LN_ValidaEstadoSimcard := al_ValidaEstadoSimcard_fn(LV_sNumSerie) ;
                                   IF LN_ValidaEstadoSimcard =1 THEN
                                      LV_ERROR := '1';
                                          LV_SQLERRM := 'Número de Serie no registrada en Operadora' ;
                                   ELSIF LN_ValidaEstadoSimcard = 2 THEN
                                      LV_ERROR := '1';
                                          LV_SQLERRM := 'Estado de Serie no Valido para Entradas Extras';
                                   END IF;
                                END IF ;
                        END IF ;

                     --Validar que  ingrese a la misma bodega, stock, articulo y uso
                        IF LV_ERROR = '0'  THEN
                          if lv_valparam='S' then
                           begin
                              ln_maxmov:=0;
                               select max(a.num_movimiento) into  ln_maxmov from al_movimientos a
                                where a.num_movimiento > 0  and
                                      a.num_serie = v_entradas.num_serie;

                               if ln_maxmov >0 then
                                  ln_cod_bodega:=NULL;
                                  ln_cod_articulo:=NULL;
                                  ln_tip_stock:=null;
                                  ln_cod_uso:=null;
                                  select a.cod_bodega, a.cod_articulo,a.tip_stock,a.cod_uso
                                    into ln_cod_bodega, ln_cod_articulo, ln_tip_stock, ln_cod_uso
                                    from al_movimientos a
                                   where a.num_movimiento = ln_maxmov;

                                  if ln_cod_bodega <> v_entradas.cod_bodega OR
                                     ln_cod_articulo <>  v_entradas.cod_articulo OR ---aki
                                     ln_tip_stock <> v_entradas.tip_stock OR
                                     ln_cod_uso <> v_entradas.cod_uso then
                                       LV_SQLERRM:=substr('Atributos <> al salir inv.(bo='||trim(ln_cod_bodega)||',art='||trim(ln_cod_articulo)||',st='||trim(ln_tip_stock)||',uso='||trim(ln_cod_uso)||')',1,60);
                                       LV_SQLCODE:= -20180;
                                       LV_ERROR:=1;
                                  end if;
                               end if;
                               exception
                           when others then
                                  null;
                           end;
                           end if;

                        END IF;


                 UPDATE AL_SERIES_ES_EXTRAS_TT SET
                           COD_ESTADO = LV_ERROR,
                           MSG_ERROR =  LV_SQLCODE||' '||LV_SQLERRM
                 WHERE NUM_SERIE = LV_sNumSerie;

                END LOOP;

                EXCEPTION
                    WHEN EXCEPTION_SERIES THEN
                                raise_application_error(-20100, 'Error ' || LV_SQLCODE || ': ' || LV_SQLERRM);
                        WHEN OTHERS THEN
                                raise_application_error(-20100, 'Error ' || SQLCODE || ': ' || SQLERRM);

END AL_VALIDA_ENTRADAS_EXTRAS_PR;


PROCEDURE AL_MOVIMIENTO_EXTRA_PR (EN_num_extra IN al_ser_es_extras.num_extra%TYPE ,
                                                                  EN_num_linea IN al_ser_es_extras.num_linea%TYPE,
                                                          EN_bodega IN al_cab_es_extras.cod_bodega%TYPE,
                                                                  EN_motivo IN al_cab_es_extras.cod_motivo%TYPE,
                                                          EN_articulo  IN al_lin_es_extras.cod_articulo%TYPE,
                                                          EN_uso     IN al_lin_es_extras.cod_uso%TYPE,
                                                          EN_estado  IN al_lin_es_extras.cod_estado%TYPE,
                                                          EN_stock   IN al_lin_es_extras.tip_stock%TYPE,
                                                                  EV_mov     IN al_cab_es_extras.ind_entsal%TYPE)
IS
/*
<Documentación TipoDoc = "Procedimiento">
<Elemento Nombre = "AL_MOVIMIENTO_EXTRA_PR" Lenguaje="PL/SQL" Fecha="16-03-2006" Versión="1.1.0"
  Diseñador="Carlos Contreras Adasme" Programador="Carlos Contreras" Ambiente="BD">
<Retorno>NA</Retorno>
<Descripción>  </Descripción>
<Parámetros>
<Entrada>
<param nom="EN_num_extra" Tipo="Number">Descripción Número de Entrada extra</param>
<param nom="EN_num_linea" Tipo="Number">Descripción Número de Linea extra</param>
<param nom="EN_bodega" Tipo="Number">Codigo Bodega</param>
<param nom="EN_motivo " Tipo="Number">Codigo Motivo</param>
<param nom="EN_articulo" Tipo="Number">codigo Articulo</param>
<param nom="EN_uso" Tipo="Number">Codigo Uso</param>
<param nom="EN_estado" Tipo="Number">Codigo Estado</param>
<param nom="EN_stock" Tipo="Number">Tipo Stock</param>
<param nom="EV_mov" Tipo="Number">Tipo d eMovimiento</param>
</Entrada>
<Salida>
</Salida>
</Parámetros>
</Elemento>
</Documentación>
*/
  LV_SQLCODE  ga_errores.cod_sqlcode%type;
  LV_SQLERRM  ga_errores.cod_sqlerrm%type;
  LV_ERROR    VARCHAR(10);
  LV_TABLA    ga_errores.nom_tabla%type;
  LN_SerErr  al_lin_es_extras.can_extra%TYPE;
  LN_precio  al_lin_es_extras.prc_unidad%TYPE:=null;
  LV_Simcard  al_articulos.tip_terminal%type;
  LV_TipTerminal  al_articulos.tip_terminal%type;
  LV_EstadoSim   gsm_estados_td.cod_estado%type;

BEGIN


  INSERT INTO AL_CAB_ES_EXTRAS (num_extra,cod_bodega,fec_extra,cod_motivo,cod_estado,des_observacion,nom_usuario,ind_entsal,tip_docu,num_docu)
  VALUES(EN_num_extra,EN_bodega,sysdate,EN_motivo,CV_EstadoNU,CV_OBS,USER,EV_mov,null,null);

  IF EV_mov =CV_Salidas THEN
       AL_VALIDA_SALIDAS_EXTRAS_PR(EN_num_extra,EN_num_linea,EN_stock,EN_articulo,EN_uso,EN_estado);
  ELSIF EV_mov =CV_Entradas THEN
           AL_VALIDA_ENTRADAS_EXTRAS_PR(EN_num_extra,EN_num_linea,EN_articulo);
           LN_precio:=AL_OBTIENE_PMP_ARTICULO_FN(EN_articulo);
  END IF;

  SELECT count(CN_uno)
  INTO LN_SerErr
  FROM al_series_es_extras_tt
  WHERE cod_estado >CN_cero;

  IF LN_SerErr = CN_cero THEN --Sigo con el proceso
     SELECT count(CN_uno)
     INTO LN_SerErr
     FROM al_series_es_extras_tt
     WHERE cod_estado = CN_cero;
         AL_INSERTA_EXTRAS_PR(EN_num_extra,EN_num_linea,EN_stock,EN_articulo,EN_uso,EN_estado,LN_SerErr,LN_precio);
     BEGIN
         SELECT tip_terminal
         INTO LV_TipTerminal
         FROM AL_ARTICULOS
         WHERE cod_articulo =EN_articulo;
     EXCEPTION
            WHEN NO_DATA_FOUND THEN
                    LV_TipTerminal:=null;
         END;

     LV_Simcard:=al_obtiene_parametro_fn('COD_SIMCARD_GSM',CV_Modulo);

         IF LV_TipTerminal= LV_Simcard THEN
            --Actualizar Estado de la Simcard
            IF EV_mov =CV_Salidas THEN
                   LV_EstadoSim:=al_obtiene_parametro_fn('ESTADO_BAJA_INVENTAR',CV_Modulo);
                ELSIF EV_mov =CV_Entradas THEN
                   LV_EstadoSim:=al_obtiene_parametro_fn('ESTADO_ENTRADA_EXTRA',CV_Modulo);
                END IF;


                UPDATE gsm_simcard_to
          SET cod_modulo=CV_Modulo,
              cod_estado=LV_EstadoSim,
              fec_actualizacion = SYSDATE,
              cod_usuario= USER
        WHERE num_simcard IN (SELECT e.num_serie
                              FROM al_lin_es_extras a, al_ser_es_extras e
                              WHERE a.num_extra= EN_num_extra AND
                                    a.num_extra=e.num_extra AND
                                    a.num_linea=e.num_linea);
         END IF;

         --Cierre de la Orden
         UPDATE al_cab_es_extras
            SET cod_estado=CV_EstadoCE
         WHERE num_extra=EN_num_extra;

----------------------------------------------------------------
--       IF EV_mov =CV_Salidas THEN
--          AL_LIBERA_NUMERO_SALIDA_PR(EN_num_extra,EN_num_linea);
---      END IF;
--------------------------------------------------------------

  END IF;
EXCEPTION
  WHEN OTHERS THEN
       raise_application_error(-20109, sqlerrm);
END AL_MOVIMIENTO_EXTRA_PR;

FUNCTION AL_VALIDA_BODEGAS_FN (EN_bodegaOrig IN al_bodegas.cod_bodega%type,
                               EN_BodegaDest IN al_bodegas.cod_bodega%type)
RETURN BOOLEAN
IS
/*
<Documentación TipoDoc = "Procedimiento">
<Elemento Nombre = "AL_VALIDA_ES_EXTRAS_PR" Lenguaje="PL/SQL" Fecha="16-03-2006" Versión="1.1.0"
  Diseñador="Carlos Contreras Adasme" Programador="Carlos Contreras" Ambiente="BD">
<Retorno>NA</Retorno>
<Descripción> Recorre las series desde la tabla AL_SERIES_ES_EXTRAS_TT, y valida su existencia
              en almacen, registrando los errores dentro de la misma tabla.
                          (ES_EXTRAS = Entradas y Salidas Extras) </Descripción>
<Parámetros>
<Entrada>
<param nom="EN_num_extra" Tipo="Number">Descripción Número de Entrada extra</param>
<param nom="EN_num_linea" Tipo="Number">Descripción Número de Linea extra</param>
</Entrada>
<Salida>
</Salida>
</Parámetros>
</Elemento>
</Documentación>
*/
  LB_retorno BOOLEAN:=FALSE;
  LN_resultado PLS_INTEGER:=CN_cero;
BEGIN
     SELECT count(CN_uno)
         INTO LN_resultado
     FROM AL_PERMISOS_TRASPASO a
     WHERE ((a.cod_bodega_1 = EN_bodegaOrig
       AND a.cod_bodega_2 = EN_BodegaDest) OR
          (a.cod_bodega_1 = EN_BodegaDest
       AND a.cod_bodega_2 = EN_bodegaOrig));

           IF LN_resultado > CN_cero THEN
             LB_retorno:=TRUE;
           END IF;

  RETURN LB_retorno;
END AL_VALIDA_BODEGAS_FN;

FUNCTION AL_VALIDA_STOCKDEST_FN (EN_StockDest IN al_series.tip_stock%type,
                                                                 EN_TipMov    IN al_tipos_movimientos.tip_movimiento%type)
RETURN BOOLEAN
IS
/*
<Documentación TipoDoc = "Procedimiento">
<Elemento Nombre = "AL_VALIDA_ES_EXTRAS_PR" Lenguaje="PL/SQL" Fecha="16-03-2006" Versión="1.1.0"
  Diseñador="Carlos Contreras Adasme" Programador="Carlos Contreras" Ambiente="BD">
<Retorno>NA</Retorno>
<Descripción> Recorre las series desde la tabla AL_SERIES_ES_EXTRAS_TT, y valida su existencia
              en almacen, registrando los errores dentro de la misma tabla.
                          (ES_EXTRAS = Entradas y Salidas Extras) </Descripción>
<Parámetros>
<Entrada>
<param nom="EN_num_extra" Tipo="Number">Descripción Número de Entrada extra</param>
<param nom="EN_num_linea" Tipo="Number">Descripción Número de Linea extra</param>
</Entrada>
<Salida>
</Salida>
</Parámetros>
</Elemento>
</Documentación>
*/
  LB_retorno BOOLEAN:=FALSE;
  LN_stock  al_stock.tip_stock%type;
BEGIN

         BEGIN
         SELECT tip_stock
         INTO LN_stock
         FROM AL_TIPOS_MOVIMIENTOS a
         WHERE a.tip_movimiento=En_TipMov;
         EXCEPTION
            WHEN OTHERS THEN
             LB_retorno:=FALSE;
         END;

         IF LN_stock is null THEN
           LB_retorno:=TRUE;
         ELSIF LN_stock=EN_StockDest THEN
           LB_retorno:=TRUE;
         ELSE
           LB_retorno:=FALSE;
         END IF;


  RETURN LB_retorno;
END AL_VALIDA_STOCKDEST_FN;

FUNCTION AL_VALIDA_STOCKVALORADO_FN (EN_StockOrig IN al_series.tip_stock%type,
                                     EN_StockDest IN al_series.tip_stock%type)
RETURN BOOLEAN
IS
/*
<Documentación TipoDoc = "Procedimiento">
<Elemento Nombre = "AL_VALIDA_ES_EXTRAS_PR" Lenguaje="PL/SQL" Fecha="16-03-2006" Versión="1.1.0"
  Diseñador="Carlos Contreras Adasme" Programador="Carlos Contreras" Ambiente="BD">
<Retorno>NA</Retorno>
<Descripción> Recorre las series desde la tabla AL_SERIES_ES_EXTRAS_TT, y valida su existencia
              en almacen, registrando los errores dentro de la misma tabla.
                          (ES_EXTRAS = Entradas y Salidas Extras) </Descripción>
<Parámetros>
<Entrada>
<param nom="EN_num_extra" Tipo="Number">Descripción Número de Entrada extra</param>
<param nom="EN_num_linea" Tipo="Number">Descripción Número de Linea extra</param>
</Entrada>
<Salida>
</Salida>
</Parámetros>
</Elemento>
</Documentación>
*/
  LB_retorno BOOLEAN:=TRUE;
  LN_stkvaloradoOri  al_tipos_stock.ind_valorar%type;
  LN_stkvaloradoDes  al_tipos_stock.ind_valorar%type;
BEGIN

         BEGIN

           SELECT a.ind_valorar
           INTO   LN_stkvaloradoOri
           FROM   AL_TIPOS_STOCK a
           WHERE  a.tip_stock = EN_StockOrig;

           SELECT a.ind_valorar
           INTO   LN_stkvaloradoDes
           FROM   AL_TIPOS_STOCK a
           WHERE  a.tip_stock = EN_StockDest;

           IF   LN_stkvaloradoOri = CN_cero THEN
                IF      LN_stkvaloradoDes = CN_uno THEN
                        LB_retorno:=FALSE;
                END IF;
                IF      LN_stkvaloradoDes = CN_dos THEN
                        LB_retorno:=FALSE;
                END IF;
           END IF;

         EXCEPTION
            WHEN OTHERS THEN
             LB_retorno:=FALSE;
         END;

  RETURN LB_retorno;
END AL_VALIDA_STOCKVALORADO_FN;

FUNCTION AL_VALIDA_STOCKTIPBODEGA_FN (EN_StockDest IN al_series.tip_stock%type,
                                      EN_BodegaDest IN al_series.cod_bodega%type)
RETURN BOOLEAN
IS
/*
<Documentación TipoDoc = "Procedimiento">
<Elemento Nombre = "AL_VALIDA_ES_EXTRAS_PR" Lenguaje="PL/SQL" Fecha="16-03-2006" Versión="1.1.0"
  Diseñador="Carlos Contreras Adasme" Programador="Carlos Contreras" Ambiente="BD">
<Retorno>NA</Retorno>
<Descripción> Recorre las series desde la tabla AL_SERIES_ES_EXTRAS_TT, y valida su existencia
              en almacen, registrando los errores dentro de la misma tabla.
                          (ES_EXTRAS = Entradas y Salidas Extras) </Descripción>
<Parámetros>
<Entrada>
<param nom="EN_num_extra" Tipo="Number">Descripción Número de Entrada extra</param>
<param nom="EN_num_linea" Tipo="Number">Descripción Número de Linea extra</param>
</Entrada>
<Salida>
</Salida>
</Parámetros>
</Elemento>
</Documentación>
*/
  LB_retorno BOOLEAN:=FALSE;
  LN_resultado PLS_INTEGER;
BEGIN
      SELECT COUNT(CN_uno)
      INTO LN_resultado
      FROM AL_BODEGAS a, AL_TIPOSTOCK_TIPBODEGA b
      WHERE a.cod_bodega=EN_BodegaDest
        AND b.tip_stock=EN_StockDest
        AND a.tip_bodega=b.tip_bodega;

          IF LN_resultado > CN_cero THEN
            LB_retorno:=TRUE;
          END IF;


  RETURN LB_retorno;
END AL_VALIDA_STOCKTIPBODEGA_FN;


FUNCTION AL_VALIDA_ESTADO_FN (EN_Estado IN al_series.cod_estado%type)
RETURN BOOLEAN
IS
/*
<Documentación TipoDoc = "Procedimiento">
<Elemento Nombre = "AL_VALIDA_ES_EXTRAS_PR" Lenguaje="PL/SQL" Fecha="16-03-2006" Versión="1.1.0"
  Diseñador="Carlos Contreras Adasme" Programador="Carlos Contreras" Ambiente="BD">
<Retorno>NA</Retorno>
<Descripción> Recorre las series desde la tabla AL_SERIES_ES_EXTRAS_TT, y valida su existencia
              en almacen, registrando los errores dentro de la misma tabla.
                          (ES_EXTRAS = Entradas y Salidas Extras) </Descripción>
<Parámetros>
<Entrada>
<param nom="EN_num_extra" Tipo="Number">Descripción Número de Entrada extra</param>
<param nom="EN_num_linea" Tipo="Number">Descripción Número de Linea extra</param>
</Entrada>
<Salida>
</Salida>
</Parámetros>
</Elemento>
</Documentación>
*/
  LB_retorno BOOLEAN:=FALSE;
  LN_indice al_estados.ind_disponibilidad%type;
BEGIN
    BEGIN
      SELECT ind_disponibilidad
      INTO LN_indice
      FROM AL_ESTADOS
      WHERE cod_estado=EN_Estado;
    EXCEPTION
          WHEN OTHERS THEN
              LB_retorno:=FALSE;
        END;

        IF LN_indice = CN_uno THEN
            LB_retorno:=TRUE;
        END IF;


  RETURN LB_retorno;
END AL_VALIDA_ESTADO_FN;


PROCEDURE AL_VALIDA_SIMULTANEO_PR(EN_num_extra IN al_ser_es_extras.num_extra%TYPE ,
                                                                  EN_num_linea IN al_ser_es_extras.num_linea%TYPE,
                                                          EN_bodegaDest IN al_cab_es_extras.cod_bodega%TYPE,
                                                          EN_articulo IN al_lin_es_extras.cod_articulo%TYPE,
                                                          EN_usoDest IN al_lin_es_extras.cod_uso%TYPE,
                                                          EN_estadoDest IN al_lin_es_extras.cod_estado%TYPE,
                                                          EN_stockDest IN al_lin_es_extras.tip_stock%TYPE,
                                                                  EN_Movim IN al_tipos_movimientos.tip_movimiento%TYPE)
IS
/*
<Documentación TipoDoc = "Procedimiento">
<Elemento Nombre = "AL_VALIDA_ES_EXTRAS_PR" Lenguaje="PL/SQL" Fecha="16-03-2006" Versión="1.1.0"
  Diseñador="Carlos Contreras Adasme" Programador="Carlos Contreras" Ambiente="BD">
<Retorno>NA</Retorno>
<Descripción> Recorre las series desde la tabla AL_SERIES_ES_EXTRAS_TT, y valida su existencia
              en almacen, registrando los errores dentro de la misma tabla.
                          (ES_EXTRAS = Entradas y Salidas Extras) </Descripción>
<Parámetros>
<Entrada>
<param nom="EN_num_extra" Tipo="Number">Descripción Número de Entrada extra</param>
<param nom="EN_num_linea" Tipo="Number">Descripción Número de Linea extra</param>
</Entrada>
<Salida>
</Salida>
</Parámetros>
</Elemento>
</Documentación>
*/
   CURSOR LC_AJUSTE (LN_NroExtra al_ser_es_extras.num_extra%TYPE ,
                     LN_NroLinea al_ser_es_extras.num_linea%TYPE,
                                         LN_Articulo al_lin_es_extras.cod_articulo%TYPE)
   IS
         SELECT b.num_serie,b.num_extra, b.num_linea, a.cod_bodega,a.cod_uso, a.cod_estado,
                a.tip_stock, a.cod_articulo, a.num_telefono
         FROM AL_SERIES a, AL_SERIES_ES_EXTRAS_TT b
         WHERE a.cod_articulo(+)=LN_Articulo
           AND b.num_extra= LN_NroExtra
           AND b.num_linea= LN_NroLinea
           AND a.num_serie(+)= b.num_serie;

   LV_SQLERRM  AL_SERIES_ES_EXTRAS_TT.msg_error%type;
   LV_ERROR    VARCHAR(10);
   EXCEPTION_SERIES exception;
BEGIN

         FOR LR_Ajuste IN LC_AJUSTE(EN_num_extra,EN_num_linea,EN_articulo) LOOP

             LV_ERROR := '0';
                 LV_SQLERRM := 'OK';

                         IF LR_Ajuste.cod_bodega is null AND LR_Ajuste.cod_uso  is null AND
                            LR_Ajuste.cod_estado is null AND LR_Ajuste.tip_stock  is null AND LR_Ajuste.cod_articulo is null THEN
                                  LV_ERROR := '1';
                                  LV_SQLERRM := 'Serie no Existe en Inventario' ;
                         ELSE
                  IF LR_Ajuste.cod_articulo <>  EN_articulo THEN
                                     LV_ERROR := '1';
                                     LV_SQLERRM := 'Articulo No Corresponde al Escogido';
                              ELSE
                     IF EN_bodegaDest is not null THEN
                                      IF EN_bodegaDest <> LR_Ajuste.cod_bodega THEN
                                          IF NOT AL_VALIDA_BODEGAS_FN(LR_Ajuste.cod_bodega,EN_bodegaDest) THEN
                                                 LV_ERROR := '1';
                                                 LV_SQLERRM := 'No Existe permiso entre Las Bodegas ';
                                                  ELSE
                                                      IF EN_stockDest is not null THEN
                                                          IF NOT AL_VALIDA_STOCKDEST_FN(EN_Movim,EN_stockDest) THEN
                                                     LV_ERROR := '1';
                                                 LV_SQLERRM := 'Stock Destino no Concuerda con Movimiento a Realizar';
                                              ELSE
                                                  IF NOT AL_VALIDA_STOCKVALORADO_FN(LR_Ajuste.tip_stock,EN_stockDest) THEN
                                                     LV_ERROR := '1';
                                                         LV_SQLERRM := 'No se permite realizar un cambio de articulo no valorado a mercaderia';
                                                      ELSE
                                                         IF      EN_stockDest is not null AND EN_bodegaDest is not null THEN
                                                             IF NOT AL_VALIDA_STOCKTIPBODEGA_FN(EN_stockDest,EN_bodegaDest) THEN
                                                                LV_ERROR := '1';
                                                            LV_SQLERRM := 'Problemas con relacion Tipo Bodega y Tipo Stock ';
                                                         ELSE
                                                            IF NOT AL_VALIDA_ESTADO_FN(LR_Ajuste.cod_estado) THEN
                                                                   LV_ERROR := '1';
                                                               LV_SQLERRM := 'La Serie esta en un Estado no Disponible para este proceso ';
                                                            ELSE
                                                               IF EN_usoDest is not null AND LR_Ajuste.num_telefono is not null THEN
                                                                  LV_ERROR := '1';
                                                                  LV_SQLERRM := 'La Serie esta Numerada.NO es posible procesarla ';
                                                               END IF;
                                                            END IF;
                                                         END IF;
                                                     END IF;
                                                  END IF;
                                      END IF;
                                                      END IF;
                                                          END IF;
                                      ELSE
                                          LV_ERROR := '1';
                                          LV_SQLERRM := 'Serie ya se encuentra en la Bodega de Destino';
                                          END IF;
                                 END IF;
                          END IF;
                           END IF;


               IF EN_bodegaDest is  null THEN
                                  IF EN_stockDest is not null THEN
                                     IF NOT AL_VALIDA_STOCKDEST_FN(EN_Movim,EN_stockDest) THEN
                                    LV_ERROR := '1';
                                LV_SQLERRM := 'Stock Destino no Concuerda con Movimiento a Realizar';
                             ELSE
                                IF NOT AL_VALIDA_STOCKVALORADO_FN(LR_Ajuste.tip_stock,EN_stockDest) THEN
                                   LV_ERROR := '1';
                                   LV_SQLERRM := 'No esta permitido realizar un cambio de un articulo no valorado a mercaderia';

                                                ELSE
                                   IF NOT AL_VALIDA_ESTADO_FN(LR_Ajuste.cod_estado) THEN
                                          LV_ERROR := '1';
                                      LV_SQLERRM := 'La Serie esta en un Estado no Disponible para este proceso ';
                                   ELSE
                                      IF EN_usoDest is not null AND LR_Ajuste.num_telefono is not null THEN
                                         LV_ERROR := '1';
                                         LV_SQLERRM := 'La Serie esta Numerada.NO es posible procesarla ';
                                      END IF;
                                                   END IF;
                                                END IF;
                                        END IF;
                                  END IF;
                          END IF;


                          IF EN_stockDest is  null THEN
                  IF NOT AL_VALIDA_ESTADO_FN(LR_Ajuste.cod_estado) THEN
                                 LV_ERROR := '1';
                             LV_SQLERRM := 'La Serie esta en un Estado no Disponible para este proceso ';
                          ELSE
                             IF EN_usoDest is not null AND LR_Ajuste.num_telefono is not null THEN
                                LV_ERROR := '1';
                                LV_SQLERRM := 'La Serie esta Numerada.NO es posible procesarla ';
                              END IF;
                                  END IF;
                          END IF;

             UPDATE AL_SERIES_ES_EXTRAS_TT SET
                           cod_estado = LV_ERROR,
                           msg_error =  LV_SQLERRM
                 WHERE num_serie = LR_Ajuste.num_serie
                       AND num_extra= LR_Ajuste.num_extra
                   AND num_linea= LR_Ajuste.num_linea;

         END LOOP;

EXCEPTION
    WHEN EXCEPTION_SERIES THEN
                raise_application_error(-20100, 'Error: ' || LV_SQLERRM);
        WHEN OTHERS THEN
                raise_application_error(-20100, 'Error: ' || SQLERRM);
END AL_VALIDA_SIMULTANEO_PR;

PROCEDURE AL_MOVIMIENTO_SIMULTANEO_PR (EN_num_extra IN al_ser_es_extras.num_extra%TYPE ,
                                                                  EN_num_linea IN al_ser_es_extras.num_linea%TYPE,
                                                          EN_bodega IN al_cab_es_extras.cod_bodega%TYPE,
                                                                  EN_motivo IN al_cab_es_extras.cod_motivo%TYPE,
                                                          EN_articulo  IN al_lin_es_extras.cod_articulo%TYPE,
                                                          EN_uso     IN al_lin_es_extras.cod_uso%TYPE,
                                                          EN_estado  IN al_lin_es_extras.cod_estado%TYPE,
                                                          EN_stock   IN al_lin_es_extras.tip_stock%TYPE,
                                                                  EN_proceso IN al_series_es_extras_tt.ind_proceso%TYPE)
IS
/*
<Documentación TipoDoc = "Procedimiento">
<Elemento Nombre = "AL_VALIDA_ES_EXTRAS_PR" Lenguaje="PL/SQL" Fecha="16-03-2006" Versión="1.1.0"
  Diseñador="Carlos Contreras Adasme" Programador="Carlos Contreras" Ambiente="BD">
<Retorno>NA</Retorno>
<Descripción> Recorre las series desde la tabla AL_SERIES_ES_EXTRAS_TT, y valida su existencia
              en almacen, registrando los errores dentro de la misma tabla.
                          (ES_EXTRAS = Entradas y Salidas Extras) </Descripción>
<Parámetros>
<Entrada>
<param nom="EN_num_extra" Tipo="Number">Descripción Número de Entrada extra</param>
<param nom="EN_num_linea" Tipo="Number">Descripción Número de Linea extra</param>
</Entrada>
<Salida>
</Salida>
</Parámetros>
</Elemento>
</Documentación>
*/
  LV_SQLCODE  ga_errores.cod_sqlcode%type;
  LV_SQLERRM  ga_errores.cod_sqlerrm%type;
  LV_ERROR    VARCHAR(10);
  LV_TABLA    ga_errores.nom_tabla%type;
  LN_SerErr  al_lin_es_extras.can_extra%TYPE;
  LN_SerBue  al_lin_es_extras.can_extra%TYPE;
  LN_precio  al_lin_es_extras.prc_unidad%TYPE:=null;
  LV_Simcard  al_articulos.tip_terminal%type;
  LV_TipTerminal  al_articulos.tip_terminal%type;
  LV_EstadoSim   gsm_estados_td.cod_estado%type;
  LR_cabecera   al_cab_es_extras%rowtype;

BEGIN


  INSERT INTO AL_CAB_ES_EXTRAS (num_extra,cod_bodega,fec_extra,cod_motivo,cod_estado,des_observacion,nom_usuario,ind_entsal,tip_docu,num_docu)
  VALUES(EN_num_extra,EN_bodega,sysdate,EN_motivo,CV_EstadoNU,CV_OBS,USER,CV_MovSimultaneo,null,null);

  SELECT SUM(DECODE(cod_estado,CN_cero,CN_uno,CN_cero)) buenas
  INTO   LN_SerBue
  FROM al_series_es_extras_tt
  WHERE cod_estado=CN_cero
    AND num_extra=EN_num_extra
        AND num_linea=EN_num_linea;


  IF LN_SerBue > CN_cero THEN --Sigo con el proceso
     SELECT count(CN_uno)
     INTO LN_SerErr
     FROM al_series_es_extras_tt
     WHERE cod_estado = CN_cero
            AND num_extra=EN_num_extra
                AND num_linea=EN_num_linea;
        AL_INSERTA_SIMULTANEO_PR(EN_num_extra,EN_num_linea,EN_stock,EN_articulo,EN_uso,EN_estado,LN_SerErr,LN_precio, EN_proceso);


         --Cierre de la Orden
         UPDATE al_cab_es_extras
            SET cod_estado=CV_EstadoCE
         WHERE num_extra=EN_num_extra;

         LR_cabecera.num_extra       :=EN_num_extra;
   LR_cabecera.cod_bodega      := EN_bodega;
   LR_cabecera.fec_extra       := sysdate;
   LR_cabecera.cod_motivo      := EN_motivo;
   LR_cabecera.cod_estado      := CV_EstadoCE;
   LR_cabecera.des_observacion := CV_OBS;
   LR_cabecera.nom_usuario     := user;
   LR_cabecera.ind_entsal      := CV_MovSimultaneo;

         IF EN_proceso= CN_cero THEN
        AL_INSERTA_MOVSIMULTANEO_PR(LR_cabecera);
         ELSE
            AL_INSERTA_MOVSIMULTANEO_D_PR(EN_num_extra,EN_num_linea,EN_motivo);
         END IF;


  END IF;
EXCEPTION
  WHEN OTHERS THEN
       raise_application_error(-20101, sqlerrm);
END AL_MOVIMIENTO_SIMULTANEO_PR;

PROCEDURE AL_INFO_SERIE_PR(EV_NumSerie IN al_series.num_serie%type,
                        EN_CodEstado OUT al_series.cod_estado%type,
                        EN_TipStock OUT al_series.tip_stock%type,
                                                EN_CodUso OUT al_series.cod_uso%type,
                                                EN_CodBodega OUT al_series.cod_bodega%type,
                                                EN_Prc OUT al_series.prc_compra%type,
                                                EN_IndTelefono OUT al_series.ind_telefono%type,
                                                EN_plan OUT al_series.plan%type,
                                                EN_carga OUT al_series.carga%type,
                                                EV_plaza OUT al_series.cod_plaza%type)
IS
/*
<Documentación TipoDoc = "Procedimiento">
<Elemento Nombre = "AL_VALIDA_ES_EXTRAS_PR" Lenguaje="PL/SQL" Fecha="16-03-2006" Versión="1.1.0"
  Diseñador="Carlos Contreras Adasme" Programador="Carlos Contreras" Ambiente="BD">
<Retorno>NA</Retorno>
<Descripción> Recorre las series desde la tabla AL_SERIES_ES_EXTRAS_TT, y valida su existencia
              en almacen, registrando los errores dentro de la misma tabla.
                          (ES_EXTRAS = Entradas y Salidas Extras) </Descripción>
<Parámetros>
<Entrada>
<param nom="EN_num_extra" Tipo="Number">Descripción Número de Entrada extra</param>
<param nom="EN_num_linea" Tipo="Number">Descripción Número de Linea extra</param>
</Entrada>
<Salida>
</Salida>
</Parámetros>
</Elemento>
</Documentación>
*/
BEGIN
    SELECT cod_estado,tip_stock, cod_uso, cod_bodega, prc_compra, ind_telefono,plan, carga, cod_plaza
        INTO EN_CodEstado, EN_TipStock, EN_CodUso, EN_CodBodega,EN_Prc,EN_IndTelefono,EN_plan,EN_carga,EV_plaza
        FROM al_series
        WHERE num_serie=EV_NumSerie;
EXCEPTION
 WHEN OTHERS THEN
     raise_application_error(-20110, sqlerrm);
END AL_INFO_SERIE_PR;

PROCEDURE AL_INFO_SERIE_DESTINO_PR(EN_NumExtra IN al_cab_es_extras.num_extra%type,
                                EN_CodEstado OUT al_series.cod_estado%type,
                                EN_TipStock OUT al_series.tip_stock%type,
                                                        EN_CodUso OUT al_series.cod_uso%type,
                                                        EN_CodBodega OUT al_series.cod_bodega%type,
                                                                EN_CodMotivo OUT al_cab_es_extras.cod_motivo%type,
                                                                EN_CodArticulo OUT al_lin_es_extras.cod_articulo%type)
IS
/*
<Documentación TipoDoc = "Procedimiento">
<Elemento Nombre = "AL_VALIDA_ES_EXTRAS_PR" Lenguaje="PL/SQL" Fecha="16-03-2006" Versión="1.1.0"
  Diseñador="Carlos Contreras Adasme" Programador="Carlos Contreras" Ambiente="BD">
<Retorno>NA</Retorno>
<Descripción> Recorre las series desde la tabla AL_SERIES_ES_EXTRAS_TT, y valida su existencia
              en almacen, registrando los errores dentro de la misma tabla.
                          (ES_EXTRAS = Entradas y Salidas Extras) </Descripción>
<Parámetros>
<Entrada>
<param nom="EN_num_extra" Tipo="Number">Descripción Número de Entrada extra</param>
<param nom="EN_num_linea" Tipo="Number">Descripción Número de Linea extra</param>
</Entrada>
<Salida>
</Salida>
</Parámetros>
</Elemento>
</Documentación>
*/
BEGIN
    SELECT b.cod_motivo,b.cod_bodega, a.cod_uso, a.cod_estado,a.tip_stock,a.cod_articulo
        INTO EN_CodMotivo, EN_CodBodega, EN_CodUso, EN_CodEstado,EN_TipStock, EN_CodArticulo
        FROM al_lin_es_extras a, al_cab_es_extras b
        WHERE a.num_linea=CN_uno
          AND b.num_extra=EN_NumExtra
      AND a.num_extra=b.num_extra;
EXCEPTION
 WHEN OTHERS THEN
     raise_application_error(-20112, sqlerrm);
END AL_INFO_SERIE_DESTINO_PR;

PROCEDURE AL_TIPO_MOVIMIENTO_PR(EN_CodMotivo IN al_cab_es_extras.cod_motivo%type,
                                EN_EntSal IN al_tipos_movimientos.ind_entsal%type,
                                EN_TipMovi  OUT NOCOPY al_tipos_movimientos.tip_movimiento%type)
IS
/*
<Documentación TipoDoc = "Procedimiento">
<Elemento Nombre = "AL_VALIDA_ES_EXTRAS_PR" Lenguaje="PL/SQL" Fecha="16-03-2006" Versión="1.1.0"
  Diseñador="Carlos Contreras Adasme" Programador="Carlos Contreras" Ambiente="BD">
<Retorno>NA</Retorno>
<Descripción> Recorre las series desde la tabla AL_SERIES_ES_EXTRAS_TT, y valida su existencia
              en almacen, registrando los errores dentro de la misma tabla.
                          (ES_EXTRAS = Entradas y Salidas Extras) </Descripción>
<Parámetros>
<Entrada>
<param nom="EN_num_extra" Tipo="Number">Descripción Número de Entrada extra</param>
<param nom="EN_num_linea" Tipo="Number">Descripción Número de Linea extra</param>
</Entrada>
<Salida>
</Salida>
</Parámetros>
</Elemento>
</Documentación>
*/

BEGIN

   IF  EN_EntSal IS NOT NULL THEN
     SELECT b.tip_movimiento
         INTO EN_TipMovi
     FROM AL_MOTIVOS_ES_EXTRAS A,
              AL_MOTIVOS_TIPMOVIMIENTO_TD B,
              AL_TIPOS_MOVIMIENTOS C
         WHERE a.cod_motivo     = EN_CodMotivo
           and a.cod_motivo     = b.cod_motivo
           and b.tip_movimiento = c.TIP_MOVIMIENTO
           and  c.IND_ENTSAL    = EN_EntSal
           and rownum = 1;
   ELSE
      SELECT b.tip_movimiento
         INTO EN_TipMovi
     FROM AL_MOTIVOS_ES_EXTRAS A,
              AL_MOTIVOS_TIPMOVIMIENTO_TD B,
              AL_TIPOS_MOVIMIENTOS C
         WHERE a.cod_motivo     = EN_CodMotivo
           and a.cod_motivo     = b.cod_motivo
           and b.tip_movimiento = c.TIP_MOVIMIENTO
           and rownum = 1;
   END IF;

   dbms_output.put_line('Movimiento('||EN_EntSal||'):'||EN_TipMovi);

EXCEPTION
  WHEN OTHERS THEN
      raise_application_error(-20114, sqlerrm);
END AL_TIPO_MOVIMIENTO_PR;


PROCEDURE AL_ASIGNA_NUMERACION_PR(EN_orden IN al_lin_es_extras.num_extra%type ,
                                  EN_linea IN al_lin_es_extras.num_linea%type ,
                                  EV_subalm IN ge_subalms.cod_subalm%type ,
                                  EN_central IN icg_central.cod_central%type ,
                                  EN_uso IN al_usos.cod_uso%type ,
                                  EN_nro_reutil IN al_lin_es_extras.num_extra%type ,
                                  EN_cat IN ga_catnumer.cod_cat%type)
  IS

      CURSOR C_SerExtras (LN_orden al_lin_es_extras.num_extra%type ,
                        LN_linea al_lin_es_extras.num_linea%type)
        IS
      SELECT num_serie, cap_code, num_telefono, num_seriemec, cod_central, cod_producto, cod_subalm, cod_cat, carga, a_key, chk_digits, num_sec_loca, num_sublock, cod_hlr
      FROM al_ser_es_extras
      WHERE num_extra   = LN_orden
      AND num_linea   = LN_linea
      AND num_telefono IS NULL
      FOR UPDATE OF num_telefono NOWAIT;

    CURSOR C_TelLibres(LN_sin_uso al_usos.cod_uso%type,
                           LV_subalm ge_subalms.cod_subalm%type ,
                       LN_central icg_central.cod_central%type ,
                       LN_uso  al_usos.cod_uso%type,
                                       LN_cat  ga_catnumer.cod_cat%type,
                                           LN_dias al_usos.num_dias_hibernacion%type,
                                           LN_rownum NUMBER)
        IS
       SELECT num_celular
       FROM al_celnum_reutil
       WHERE cod_subalm        = LV_subalm
         AND cod_producto      = CN_uno
         AND cod_central       = LN_central
         AND cod_cat           = LN_cat
         AND cod_uso      IN (LN_uso, LN_sin_uso)
         AND (fec_baja + LN_dias <= TRUNC(SYSDATE)
              OR LN_dias = CN_cero)
         AND ind_equipado      = CN_uno
         AND ROWNUM < LN_rownum;

     LN_rownum             NUMBER(4);
     LN_dias              al_usos.num_dias_hibernacion%type;
     LN_sin_uso        al_celnum_reutil.cod_uso%TYPE;
     LN_telefono           al_series.num_telefono%TYPE;
     LN_celular            GA_CELNUM_REUTIL.num_celular%TYPE;
     LN_numero             AL_SERIES.num_telefono%TYPE;
         LN_central_tecno      ICG_CENTRAL.cod_central%TYPE;
     LV_prefijo                   AL_USOS_MIN.num_min%TYPE;
     LV_CodSimCard        AL_TIPOS_TERMINALES.tip_terminal%TYPE;
         LV_codtecnologia         ICG_CENTRAL.COD_TECNOLOGIA%TYPE;
         LV_nom_parametro         GED_PARAMETROS.nom_parametro%TYPE;
     CN_tecnologiagsm     CONSTANT VARCHAR(3):='GSM';
         LN_cantnros          al_lin_es_extras.num_extra%type;
     LC_Ser      C_SerExtras%rowtype;
     LN_error    NUMBER(2);


BEGIN
        LN_rownum       := 11;
                LN_error:=CN_cero;
        LN_sin_uso := NVL(ge_fn_uso_sin_uso,EN_uso);
                LV_nom_parametro := 'COD_SIMCARD_GSM';
                LN_cantnros:=EN_nro_reutil;


         SELECT val_parametro
         INTO LV_CodSimCard
         FROM GED_PARAMETROS
         WHERE cod_producto=CN_uno AND
               cod_modulo= CV_Modulo AND
               nom_parametro= LV_nom_parametro;
       BEGIN
         LN_dias := ge_fn_dias_hibernacion(EN_uso);
         EXCEPTION
            WHEN OTHERS THEN
                      LN_error := CN_uno;
                                          LN_dias:=CN_cero;
            END;

        IF LN_error = CN_cero THEN
           OPEN C_SerExtras(EN_orden,EN_linea);
           LOOP
           FETCH C_SerExtras INTO LC_Ser;
           EXIT WHEN C_SerExtras%NOTFOUND;
           LN_numero := NULL;
           IF LN_cantnros> CN_cero THEN
              OPEN C_TelLibres(LN_sin_uso,EV_subalm,EN_central,EN_uso,EN_cat,LN_dias,LN_rownum);
              LOOP
              FETCH C_TelLibres INTO LN_celular;
                IF C_TelLibres%NOTFOUND THEN
                     LN_cantnros := CN_cero;
                     CLOSE C_TelLibres;
                END IF;
              BEGIN
                 LN_numero        := NULL;
                                 LN_central_tecno := NULL;
                 SELECT num_celular, cod_central
                 INTO LN_numero, LN_central_tecno
                 FROM al_celnum_reutil
                 WHERE num_celular = LN_celular
                 FOR UPDATE NOWAIT;
                 LN_cantnros := LN_cantnros -1;

                 DELETE al_celnum_reutil
                 WHERE num_celular = LN_celular;
                 EXIT;
                 EXCEPTION
                    WHEN NO_DATA_FOUND THEN
                         NULL;
                    WHEN OTHERS THEN
                         IF (SQLCODE=-54 OR SQLCODE=-60) THEN
                         -- Vamos a por otro numero de telefono
                            NULL;
                         ELSE
                            RAISE;
                         END IF;
              END;
              END LOOP;
           END IF;
     -- ahora update al_fic_series y activacion
           IF LN_numero IS NOT NULL THEN

              UPDATE AL_SER_ES_EXTRAS
              SET num_telefono = LN_numero,
                  cod_central=EN_central,
                                  cod_subalm=EV_subalm,
                                  cod_cat=EN_cat
              WHERE CURRENT OF C_SerExtras;
           ELSE
              EXIT;  -- del LOOP principal
           END IF;

           IF C_TelLibres%ISOPEN  THEN
              CLOSE C_TelLibres;
           END IF;


        END LOOP;
        CLOSE C_SerExtras;
     END IF;
    EXCEPTION
        WHEN OTHERS THEN
             RAISE_APPLICATION_ERROR (-20175, 'AL_ASIGNA_NUMERACION_PR:'||sqlerrm);

END AL_ASIGNA_NUMERACION_PR;

FUNCTION AL_OBTIENE_SIMULTANEO_FN( EN_CodMotivo IN al_cab_es_extras.cod_motivo%type)
RETURN BOOLEAN
IS
/*
<Documentación TipoDoc = "Función">
<Elemento Nombre = "AL_OBTIENE_HLR_FN" Lenguaje="PL/SQL" Fecha="16-03-2006" Versión="1.1.0"
  Diseñador="Carlos Contreras Adasme" Programador="Carlos Contreras" Ambiente="BD">
<Retorno>Varchar</Retorno>
<Descripción> Obtiene desde las tablas de gestión de Simcard el halr correspondiente </Descripción>
<Parámetros>
<Entrada>
 <param nom="EV_num_serie" Tipo="Varchar2">Descripción Serie a procesar... </param>
</Entrada>
<Salida>
 <param nom="Hlr" Tipo="Varchar2">Descripción HLR de la serie ... </param>
</Salida>
</Parámetros>
</Elemento>
</Documentación>
*/

LN_conta            NUMBER(4);
BEGIN
      LN_conta  := 0;
          BEGIN
                SELECT COUNT(1)  INTO LN_conta
            FROM AL_MOTIVOS_TIPMOVIMIENTO_TD
            WHERE  COD_MOTIVO = EN_CodMotivo;

           EXCEPTION
                   WHEN NO_DATA_FOUND THEN
                        RETURN FALSE;
                   WHEN OTHERS THEN
                        RETURN FALSE;
           END ;

       IF LN_conta  = 2 THEN
              RETURN TRUE;
           ELSE
             RETURN FALSE;
           END IF;

END AL_OBTIENE_SIMULTANEO_FN;


PROCEDURE AL_INSERTA_MOVSIMULTANEO_PR (ER_cabextra al_cab_es_extras%rowtype)
IS
/*
<Documentación TipoDoc = "Procedimiento">
<Elemento Nombre = "AL_VALIDA_ES_EXTRAS_PR" Lenguaje="PL/SQL" Fecha="16-03-2006" Versión="1.1.0"
  Diseñador="" Programador="" Ambiente="BD">
<Retorno>NA</Retorno>
<Descripción> R </Descripción>
<Parámetros>
<Entrada>
<param nom="ER_cabextra" Tipo="Number"></param>
</Entrada>
<Salida>
</Salida>
</Parámetros>
</Elemento>
</Documentación>
*/
  CURSOR C_series (LN_num_extra al_cab_es_extras.num_extra%type)
  IS
    SELECT num_extra, num_linea, num_serie, cap_code, num_telefono, num_seriemec, cod_central, cod_producto, cod_subalm, cod_cat, carga, a_key, chk_digits, num_sec_loca, num_sublock, cod_hlr
        FROM al_ser_es_extras
        WHERE num_extra=LN_num_extra;

  LN_NroMov al_movimientos.num_movimiento%type;
  LR_Mov    al_movimientos%rowtype;
  LN_CodEstado al_series.cod_estado%type;
  LN_TipStock al_series.tip_stock%type;
  LN_CodUso al_series.cod_uso%type;
  LN_CodBodega al_series.cod_bodega%type;
  LN_CodArticulo al_series.cod_articulo%type;
  LN_EstadoDest al_series.cod_estado%type;
  LN_StockDest  al_series.tip_stock%type;
  LN_UsoDest al_series.cod_uso%type;
  LN_BodegaDest al_series.cod_bodega%type;
  LN_CodMotivo al_cab_es_extras.cod_motivo%type;
  LN_TipMov1    al_movimientos.tip_movimiento%type;
  LN_TipMov2    al_movimientos.tip_movimiento%type;
  LN_Prc    al_series.prc_compra%type;
  LN_IndTelefono al_series.ind_telefono%type;
  LN_plan        al_series.plan%type;
  LN_carga       al_series.carga%type;
  LV_plaza       al_series.cod_plaza%type;

BEGIN

    AL_INFO_SERIE_DESTINO_PR(ER_cabextra.num_extra,LN_EstadoDest,LN_StockDest,LN_UsoDest,LN_BodegaDest,LN_CodMotivo,LN_CodArticulo);

        ---Ojo. Como es SIMULTANEO buscamos 2 veces los Tipos de Movimientos

        --Rescatamos todos los tipos de movimientos para el motivo
        IF AL_OBTIENE_SIMULTANEO_FN(LN_CodMotivo) = TRUE THEN

          AL_TIPO_MOVIMIENTO_PR(LN_CodMotivo,'E',LN_TipMov1);
          AL_TIPO_MOVIMIENTO_PR(LN_CodMotivo,'S',LN_TipMov2);

        END IF;


    FOR LC_series IN C_series(ER_cabextra.num_extra) LOOP
       SELECT al_seq_mvto.NEXTVAL
       INTO LN_NroMov
       FROM DUAL;


           AL_INFO_SERIE_PR(LC_series.num_serie,LN_CodEstado,LN_TipStock,LN_CodUso,LN_CodBodega,LN_Prc,LN_IndTelefono,LN_plan,LN_carga,LV_plaza );


                ---Movimieto Salida
               LR_Mov.num_movimiento := LN_NroMov;
               LR_Mov.tip_movimiento := LN_TipMov2;
               LR_Mov.fec_movimiento := sysdate;
               LR_Mov.tip_stock := LN_TipStock;
               LR_Mov.cod_bodega := LN_CodBodega;
               LR_Mov.cod_articulo := LN_CodArticulo;
               LR_Mov.cod_uso := LN_CodUso;
               LR_Mov.cod_estado := LN_CodEstado;
               LR_Mov.num_cantidad := CN_uno;
               LR_Mov.cod_estadomov := 'SO';
               LR_Mov.nom_usuarora := user;
               LR_Mov.tip_stock_dest := null;
               LR_Mov.cod_bodega_dest := null;
               LR_Mov.cod_uso_dest := null;
               LR_Mov.cod_estado_dest := null;
               LR_Mov.num_serie := LC_series.num_serie;
               LR_Mov.num_desde := 0;
               LR_Mov.num_hasta := null;
               LR_Mov.num_guia := null;
               LR_Mov.prc_unidad := null;
               LR_Mov.cod_transaccion := 5;
               LR_Mov.num_transaccion := ER_cabextra.num_extra;
               LR_Mov.num_seriemec := null;
               LR_Mov.num_telefono := LC_series.num_telefono;
               LR_Mov.cap_code := null;
               LR_Mov.cod_producto := CN_uno;
               LR_Mov.cod_central := LC_series.cod_central;
               LR_Mov.cod_moneda := null;
               LR_Mov.cod_subalm := LC_series.cod_Subalm;
               LR_Mov.cod_central_dest := null;
               LR_Mov.cod_subalm_dest := null;
               LR_Mov.num_telefono_dest := null;
               LR_Mov.cod_cat := LC_series.cod_cat;
               LR_Mov.cod_cat_dest := null;
               LR_Mov.ind_telefono := LN_IndTelefono;
               LR_Mov.plan := LN_plan;
               LR_Mov.carga := LN_carga;
               LR_Mov.num_sec_loca := null;
               LR_Mov.cod_hlr := LC_series.cod_HLR;
               LR_Mov.cod_plaza := LV_plaza;

               al_pac_validaciones.p_inserta_movim(LR_Mov);

                   SELECT al_seq_mvto.NEXTVAL
           INTO LN_NroMov
           FROM DUAL;

        --         Entrada
               LR_Mov.num_movimiento := LN_NroMov;
               LR_Mov.tip_movimiento := LN_TipMov1;
               LR_Mov.fec_movimiento := sysdate;
               LR_Mov.tip_stock := nvl(LN_StockDest,LN_TipStock);
               LR_Mov.cod_bodega := nvl(LN_BodegaDest,LN_CodBodega);
               LR_Mov.cod_articulo := LN_CodArticulo;
               LR_Mov.cod_uso := nvl(LN_UsoDest,LN_CodUso);
               LR_Mov.cod_estado :=nvl(LN_EstadoDest, LN_CodEstado);
               LR_Mov.num_cantidad := CN_uno;
               LR_Mov.cod_estadomov := 'SO';
               LR_Mov.nom_usuarora := user;
               LR_Mov.tip_stock_dest := null;
               LR_Mov.cod_bodega_dest := null;
               LR_Mov.cod_uso_dest := null;
               LR_Mov.cod_estado_dest := null;
               LR_Mov.num_serie := LC_series.num_serie;
               LR_Mov.num_desde := 0;
               LR_Mov.num_hasta := null;
               LR_Mov.num_guia := null;
               LR_Mov.prc_unidad := AL_OBTIENE_PMP_ARTICULO_FN(LN_CodArticulo);
               LR_Mov.cod_transaccion := 5;
               LR_Mov.num_transaccion := ER_cabextra.num_extra;
               LR_Mov.num_seriemec := null;
               LR_Mov.num_telefono := LC_series.num_telefono;
               LR_Mov.cap_code := null;
               LR_Mov.cod_producto := CN_uno;
               LR_Mov.cod_central := LC_series.cod_central;
               LR_Mov.cod_moneda := null;
               LR_Mov.cod_subalm := LC_series.cod_Subalm;
               LR_Mov.cod_central_dest := null;
               LR_Mov.cod_subalm_dest := null;
               LR_Mov.num_telefono_dest := null;
               LR_Mov.cod_cat := LC_series.cod_cat;
               LR_Mov.cod_cat_dest := null;
               LR_Mov.ind_telefono := LN_IndTelefono;
               LR_Mov.plan := LN_plan;
               LR_Mov.carga := LN_carga;
               LR_Mov.num_sec_loca := null;
               LR_Mov.cod_hlr := LC_series.cod_HLR;
               LR_Mov.cod_plaza := LV_plaza;

               al_pac_validaciones.p_inserta_movim(LR_Mov);


        END LOOP;

EXCEPTION
 WHEN OTHERS THEN
       raise_application_error(-20116, sqlerrm);
END AL_INSERTA_MOVSIMULTANEO_PR;

PROCEDURE AL_INSERTA_MOVSIMULTANEO_D_PR (EN_num_extra   IN al_ser_es_extras.num_extra%TYPE ,
                                                                         EN_num_linea   IN al_ser_es_extras.num_linea%TYPE,
                                                                                 EN_motivo IN al_cab_es_extras.cod_motivo%TYPE)
IS
/*
<Documentación TipoDoc = "Procedimiento">
<Elemento Nombre = "AL_VALIDA_ES_EXTRAS_PR" Lenguaje="PL/SQL" Fecha="16-03-2006" Versión="1.1.0"
  Diseñador="" Programador="" Ambiente="BD">
<Retorno>NA</Retorno>
<Descripción> R </Descripción>
<Parámetros>
<Entrada>
<param nom="ER_cabextra" Tipo="Number"></param>
</Entrada>
<Salida>
</Salida>
</Parámetros>
</Elemento>
</Documentación>
*/
  CURSOR C_SerSal (LN_num_extra al_ser_es_extras.num_extra%type,
                   LN_num_linea al_ser_es_extras.num_linea%TYPE)
  IS
    SELECT b.num_serie, a.cod_articulo, a.cod_bodega, a.cod_estado, a.cod_uso,a.tip_stock,
               a.num_telefono,a.cod_subalm, a.cod_cat, a.cod_central, a.cod_hlr, a.cod_plaza,
                   a.ind_telefono, a.plan, a.carga
        FROM al_series a, al_series_es_extras_tt b
        WHERE b.num_extra=LN_num_extra
      AND b.num_linea=LN_num_linea
          AND b.ind_proceso=CN_uno
          AND a.num_serie=b.num_serie;


  CURSOR C_SerEnt (LN_num_extra al_ser_es_extras.num_extra%type,
                   LN_num_linea al_ser_es_extras.num_linea%TYPE)
  IS
         SELECT c.num_serie,c.cod_articulo,a.cod_bodega,b.cod_estado, b.tip_stock, b.cod_uso
         FROM AL_CAB_ES_EXTRAS a, AL_LIN_ES_EXTRAS b, AL_SERIES_ES_EXTRAS_TT c
         WHERE c.num_extra= LN_num_extra
           AND c.num_linea= LN_num_linea
           AND c.ind_proceso=CN_dos
           AND a.num_extra=b.num_extra
           AND b.num_extra=c.num_extra
           AND b.num_linea=c.num_linea;

  LN_NroMov al_movimientos.num_movimiento%type;
  LR_Mov    al_movimientos%rowtype;
  LN_CodEstado al_series.cod_estado%type;
  LN_TipStock al_series.tip_stock%type;
  LN_CodUso al_series.cod_uso%type;
  LN_CodBodega al_series.cod_bodega%type;
  LN_CodArticulo al_series.cod_articulo%type;
  LN_EstadoDest al_series.cod_estado%type;
  LN_StockDest  al_series.tip_stock%type;
  LN_UsoDest al_series.cod_uso%type;
  LN_BodegaDest al_series.cod_bodega%type;
  LN_TipMov1    al_movimientos.tip_movimiento%type;
  LN_TipMov2    al_movimientos.tip_movimiento%type;
  LN_Prc    al_series.prc_compra%type;
  LN_IndTelefono al_series.ind_telefono%type;
  LN_plan        al_series.plan%type;
  LN_carga       al_series.carga%type;
  LV_plaza       al_series.cod_plaza%type;

   LN_ArticuloSal al_series.cod_articulo%type;
   LN_BodegaSal al_series.cod_bodega%type;
   LN_EstadoSal al_series.cod_estado%type;
   LN_StockSal  al_series.tip_Stock%type;
   LN_UsoSal    al_series.cod_uso%type;
   LN_ArticuloEnt al_series.cod_articulo%type;
   LN_BodegaEnt al_series.cod_bodega%type;
   LN_EstadoEnt al_series.cod_estado%type;
   LN_StockEnt  al_series.tip_Stock%type;
   LN_UsoEnt    al_series.cod_uso%type;
   LN_PrcEnt    al_precios_venta.prc_venta%type;
   LN_PrcSal    al_precios_venta.prc_venta%type;
   LN_Plaza     al_series.cod_plaza%type:=null;

BEGIN

        IF AL_OBTIENE_SIMULTANEO_FN(EN_motivo) = TRUE THEN

          AL_TIPO_MOVIMIENTO_PR(EN_motivo,'E',LN_TipMov1);
          AL_TIPO_MOVIMIENTO_PR(EN_motivo,'S',LN_TipMov2);

        END IF;

        al_proc_movto.p_obtener_oficina_default (LN_Plaza);

--    dbms_output.put_line('Salida');
    FOR LC_SerS IN C_SerSal(EN_num_extra,EN_num_linea) LOOP
       SELECT al_seq_mvto.NEXTVAL
       INTO LN_NroMov
       FROM DUAL;

           LN_ArticuloSal:=LC_SerS.cod_articulo;
           LN_UsoSal:=LC_SerS.cod_uso;
           LN_EstadoSal:=LC_SerS.cod_estado;
           LN_StockSal:=LC_SerS.tip_stock;
           LN_BodegaSal:=LC_SerS.cod_bodega;


                ---Movimieto Salida
               LR_Mov.num_movimiento := LN_NroMov;
        --         dbms_output.put_line('NRoMov: '||LN_NroMov);
               LR_Mov.tip_movimiento := LN_TipMov2;
                --   dbms_output.put_line('TipMov: '||LN_TipMov2);
               LR_Mov.fec_movimiento := sysdate;
               LR_Mov.tip_stock := LN_StockSal;
                  -- dbms_output.put_line('TipStock: '||LN_StockSal);
               LR_Mov.cod_bodega := LN_BodegaSal;
                   --dbms_output.put_line('Bodega: '||LN_BodegaSal);
               LR_Mov.cod_articulo := LN_ArticuloSal;
                   --dbms_output.put_line('Articulo: '||LN_ArticuloSal);
               LR_Mov.cod_uso := LN_UsoSal;
                   --dbms_output.put_line('Uso: '||LN_UsoSal);
               LR_Mov.cod_estado := LN_EstadoSal;
                   --dbms_output.put_line('Estado: '||LN_EstadoSal);
               LR_Mov.num_cantidad := CN_uno;
               LR_Mov.cod_estadomov := 'SO';
               LR_Mov.nom_usuarora := user;
               LR_Mov.tip_stock_dest := null;
               LR_Mov.cod_bodega_dest := null;
               LR_Mov.cod_uso_dest := null;
               LR_Mov.cod_estado_dest := null;
               LR_Mov.num_serie := LC_SerS.num_serie;
                   --dbms_output.put_line('Serie: '||LC_SerS.num_serie);
               LR_Mov.num_desde := 0;
               LR_Mov.num_hasta := null;
               LR_Mov.num_guia := null;
               LR_Mov.prc_unidad := null ;
               LR_Mov.cod_transaccion := 5;
               LR_Mov.num_transaccion := EN_num_extra;
               LR_Mov.num_seriemec := null;
               LR_Mov.num_telefono := null;
               LR_Mov.cap_code := null;
               LR_Mov.cod_producto := CN_uno;
               LR_Mov.cod_central := null;
               LR_Mov.cod_moneda := null;
               LR_Mov.cod_subalm := null;
               LR_Mov.cod_central_dest := null;
               LR_Mov.cod_subalm_dest := null;
               LR_Mov.num_telefono_dest := null;
               LR_Mov.cod_cat := null;
               LR_Mov.cod_cat_dest := null;
               LR_Mov.ind_telefono := 0;
               LR_Mov.plan := null;
               LR_Mov.carga := null;
               LR_Mov.num_sec_loca := null;
               LR_Mov.cod_hlr := null;
               LR_Mov.cod_plaza := LN_Plaza;

               al_pac_validaciones.p_inserta_movim(LR_Mov);

        END LOOP;

            --dbms_output.put_line('Entrada');
    FOR LC_SerE IN C_SerEnt(EN_num_extra,EN_num_linea) LOOP
           SELECT al_seq_mvto.NEXTVAL
           INTO LN_NroMov
           FROM DUAL;

           LN_ArticuloEnt:=LC_SerE.cod_articulo;
           LN_UsoEnt:=LC_SerE.cod_uso;
           LN_EstadoEnt:=LC_SerE.cod_estado;
           LN_StockEnt:=LC_SerE.tip_stock;
           LN_BodegaEnt:=LC_SerE.cod_bodega;

        --         Entrada
               LR_Mov.num_movimiento := LN_NroMov;
               LR_Mov.tip_movimiento := LN_TipMov1;
               LR_Mov.fec_movimiento := sysdate;
               LR_Mov.tip_stock := nvl(LN_StockEnt,LN_StockSal);
               LR_Mov.cod_bodega := nvl(LN_BodegaEnt,LN_BodegaSal);
               LR_Mov.cod_articulo := LN_ArticuloEnt;
               LR_Mov.cod_uso := nvl(LN_UsoEnt,LN_UsoSal);
               LR_Mov.cod_estado :=nvl(LN_EstadoEnt, LN_EstadoSal);
               LR_Mov.num_cantidad := CN_uno;
               LR_Mov.cod_estadomov := 'SO';
               LR_Mov.nom_usuarora := user;
               LR_Mov.tip_stock_dest := null;
               LR_Mov.cod_bodega_dest := null;
               LR_Mov.cod_uso_dest := null;
               LR_Mov.cod_estado_dest := null;
               LR_Mov.num_serie := LC_SerE.num_serie;
               LR_Mov.num_desde := 0;
               LR_Mov.num_hasta := null;
               LR_Mov.num_guia := null;
               LR_Mov.prc_unidad := AL_OBTIENE_PMP_ARTICULO_FN(LN_ArticuloEnt) ;
               LR_Mov.cod_transaccion := 5;
               LR_Mov.num_transaccion := EN_num_extra;
               LR_Mov.num_seriemec := null;
               LR_Mov.num_telefono := null;
               LR_Mov.cap_code := null;
               LR_Mov.cod_producto := CN_uno;
               LR_Mov.cod_central := null;
               LR_Mov.cod_moneda := null;
               LR_Mov.cod_subalm := null;
               LR_Mov.cod_central_dest := null;
               LR_Mov.cod_subalm_dest := null;
               LR_Mov.num_telefono_dest := null;
               LR_Mov.cod_cat := null;
               LR_Mov.cod_cat_dest := null;
               LR_Mov.ind_telefono := 0;
               LR_Mov.plan := null;
               LR_Mov.carga := null;
               LR_Mov.num_sec_loca := null;
               LR_Mov.cod_hlr := null;
               LR_Mov.cod_plaza := LN_Plaza;

               al_pac_validaciones.p_inserta_movim(LR_Mov);


        END LOOP;




EXCEPTION
 WHEN OTHERS THEN
       raise_application_error(-20116, sqlerrm);
END AL_INSERTA_MOVSIMULTANEO_D_PR;


PROCEDURE AL_VALIDA_SIMULTANEO_DOBLE_PR(EN_num_extra    IN al_ser_es_extras.num_extra%TYPE ,
                                                                        EN_num_linea    IN al_ser_es_extras.num_linea%TYPE,
                                                                EN_bodegaDest   IN al_cab_es_extras.cod_bodega%TYPE,
                                                                EN_articulo     IN al_lin_es_extras.cod_articulo%TYPE,
                                                                EN_usoDest      IN al_lin_es_extras.cod_uso%TYPE,
                                                                EN_estadoDest   IN al_lin_es_extras.cod_estado%TYPE,
                                                                EN_stockDest    IN al_lin_es_extras.tip_stock%TYPE,
                                                                        EN_Movim        IN al_tipos_movimientos.tip_movimiento%TYPE,
                                                                                EN_SwValoArt    IN NUMBER)
IS
/*
<Documentación TipoDoc = "Procedimiento">
<Elemento Nombre = "AL_VALIDA_SIMULTANEO_DOBLE_PR" Lenguaje="PL/SQL" Fecha="16-03-2006" Versión="1.1.0"
  Diseñador="Carlos Contreras Adasme" Programador="Carlos Contreras" Ambiente="BD">
<Retorno>NA</Retorno>
<Descripción> Recorre las series desde la bla AL_SERIES_ES_EXTRAS_TT, y valida su existencia
              en almacen, registrando los errores dentro de la misma tabla.
                          (ES_EXTRAS = Entradas y Salidas Extras) </Descripción>
<Parámetros>
<Entrada>
<param nom="EN_num_extra" Tipo="Number">Descripción Número de Entrada extra</param>
<param nom="EN_num_linea" Tipo="Number">Descripción Número de Linea extra</param>
<param nom="EN_bodegaDest" Tipo="Number">Descripción Número de Linea extra</param>
<param nom="EN_articuloDest" Tipo="Number">Descripción Número de Linea extra</param>
<param nom="EN_usoDest" Tipo="Number">Descripción Número de Linea extra</param>
<param nom="EN_estadoDest" Tipo="Number">Descripción Número de Linea extra</param>
<param nom="EN_stockDest" Tipo="Number">Descripción Número de Linea extra</param>
<param nom="EN_Movim" Tipo="Number">Descripción Número de Linea extra</param>
<param nom="EN_SwValoArt Tipo="Number">Indicador de valorización 1=SiValoriza,0=NoValoriza</param>
</Entrada>
<Salida>
</Salida>
</Parámetros>
</Elemento>
</Documentación>
*/
   CURSOR LC_SerSal (LN_NroExtra al_ser_es_extras.num_extra%TYPE ,
                     LN_NroLinea al_ser_es_extras.num_linea%TYPE,
                                         LN_articulo al_lin_es_extras.cod_articulo%TYPE)
   IS
         SELECT b.num_serie,b.num_extra, b.num_linea, a.cod_bodega,a.cod_uso, a.cod_estado,
                a.tip_stock, a.cod_articulo, a.num_telefono
         FROM AL_SERIES a, AL_SERIES_ES_EXTRAS_TT b
         WHERE a.cod_articulo(+)=LN_articulo
       AND b.num_extra= LN_NroExtra
           AND b.num_linea= LN_NroLinea
           AND b.ind_proceso=CN_uno
           AND a.num_serie(+)= b.num_serie;

    CURSOR LC_SerEnt (LN_NroExtra al_ser_es_extras.num_extra%TYPE ,
                      LN_NroLinea al_ser_es_extras.num_linea%TYPE)
   IS
         SELECT c.num_serie,c.cod_articulo
         FROM AL_SERIES_ES_EXTRAS_TT c
         WHERE c.num_extra= LN_NroExtra
           AND c.num_linea= LN_NroLinea
           AND c.ind_proceso=CN_dos;


   LV_SQLERRM  AL_SERIES_ES_EXTRAS_TT.msg_error%type;
   LV_ERROR    VARCHAR(10);
   LN_ArticuloAnt al_lin_es_extras.cod_articulo%TYPE;
   LN_CantArt PLS_INTEGER;
   LV_tip_terminal al_articulos.tip_terminal%type;
   LV_ind_equiacc al_articulos.ind_equiacc%type;
   LN_ValidaEstadoSimcard  gsm_simcard_to.cod_estado%type;
   LN_BodegaSal al_series.cod_bodega%type;
   LN_EstadoSal al_series.cod_estado%type;
   LN_StockSal  al_series.tip_Stock%type;
   LN_UsoSal    al_series.cod_uso%type;
   LN_BodegaEnt al_series.cod_bodega%type;
   LN_EstadoEnt al_series.cod_estado%type;
   LN_StockEnt  al_series.tip_Stock%type;
   LN_UsoEnt    al_series.cod_uso%type;
   LN_PrcEnt    al_precios_venta.prc_venta%type;
   LN_PrcSal    al_precios_venta.prc_venta%type;
   LN_IndProceso al_series_es_extras_tt.ind_proceso%type;
   LN_ESerie   PLS_INTEGER;
BEGIN
                 --Archivo Salida
         FOR LR_Ajuste IN LC_SerSal(EN_num_extra,EN_num_linea,EN_articulo) LOOP

             LV_ERROR := '0';
                 LV_SQLERRM := 'OK';
             LN_BodegaSal:=LR_Ajuste.cod_bodega;
             LN_EstadoSal:=LR_Ajuste.cod_estado;
             LN_StockSal :=LR_Ajuste.tip_stock;
             LN_UsoSal :=LR_Ajuste.cod_uso;
                         IF LR_Ajuste.cod_bodega is null AND LR_Ajuste.cod_uso  is null AND
                            LR_Ajuste.cod_estado is null AND LR_Ajuste.tip_stock  is null AND LR_Ajuste.cod_articulo is null THEN
                                  LV_ERROR := '1';
                                  LV_SQLERRM := 'Serie no Existe en Inventario' ;
                         ELSE
                          IF LR_Ajuste.cod_articulo <>  EN_articulo THEN
                                     LV_ERROR := '1';
                                     LV_SQLERRM := 'Articulo No Corresponde al Escogido';
                              ELSE
                     IF EN_bodegaDest is not null THEN
                                      IF EN_bodegaDest <> LR_Ajuste.cod_bodega THEN
                                          IF NOT AL_VALIDA_BODEGAS_FN(LR_Ajuste.cod_bodega,EN_bodegaDest) THEN
                                                 LV_ERROR := '1';
                                                 LV_SQLERRM := 'No Existe permiso entre Las Bodegas ';
                                                  ELSE
                                                      IF EN_stockDest is not null THEN
                                                          IF NOT AL_VALIDA_STOCKDEST_FN(EN_Movim,EN_stockDest) THEN
                                                     LV_ERROR := '1';
                                                 LV_SQLERRM := 'Stock Destino no Concuerda con Movimiento a Realizar';
                                              ELSE
                                                  IF NOT AL_VALIDA_STOCKVALORADO_FN(LR_Ajuste.tip_stock,EN_stockDest) THEN
                                                     LV_ERROR := '1';
                                                         LV_SQLERRM := 'No se permite realizar un cambio de articulo no valorado a mercaderia';
                                                      ELSE
                                                         IF      EN_stockDest is not null AND EN_bodegaDest is not null THEN
                                                             IF NOT AL_VALIDA_STOCKTIPBODEGA_FN(EN_stockDest,EN_bodegaDest) THEN
                                                                LV_ERROR := '1';
                                                            LV_SQLERRM := 'Problemas con relacion Tipo Bodega y Tipo Stock ';
                                                         ELSE
                                                            IF NOT AL_VALIDA_ESTADO_FN(LR_Ajuste.cod_estado) THEN
                                                                   LV_ERROR := '1';
                                                               LV_SQLERRM := 'La Serie esta en un Estado no Disponible para este proceso ';
                                                            ELSE
                                                               IF EN_usoDest is not null AND LR_Ajuste.num_telefono is not null THEN
                                                                  LV_ERROR := '1';
                                                                  LV_SQLERRM := 'La Serie esta Numerada.NO es posible procesarla ';
                                                               END IF;
                                                            END IF;
                                                         END IF;
                                                     END IF;
                                                  END IF;
                                      END IF;
                                                      END IF;
                                                          END IF;
                                      ELSE
                                          LV_ERROR := '1';
                                          LV_SQLERRM := 'Serie ya se encuentra en la Bodega de Destino';
                                          END IF;
                                 END IF;
                                        END IF;
                           END IF;


               IF EN_bodegaDest is  null THEN
                                  IF EN_stockDest is not null THEN
                                     IF NOT AL_VALIDA_STOCKDEST_FN(EN_Movim,EN_stockDest) THEN
                                    LV_ERROR := '1';
                                LV_SQLERRM := 'Stock Destino no Concuerda con Movimiento a Realizar';
                             ELSE
                                IF NOT AL_VALIDA_STOCKVALORADO_FN(LR_Ajuste.tip_stock,EN_stockDest) THEN
                                   LV_ERROR := '1';
                                   LV_SQLERRM := 'No esta permitido realizar un cambio de un articulo no valorado a mercaderia';

                                                ELSE
                                   IF NOT AL_VALIDA_ESTADO_FN(LR_Ajuste.cod_estado) THEN
                                          LV_ERROR := '1';
                                      LV_SQLERRM := 'La Serie esta en un Estado no Disponible para este proceso ';
                                   ELSE
                                      IF EN_usoDest is not null AND LR_Ajuste.num_telefono is not null THEN
                                         LV_ERROR := '1';
                                         LV_SQLERRM := 'La Serie esta Numerada.NO es posible procesarla ';
                                      END IF;
                                                   END IF;
                                                END IF;
                                        END IF;
                                  END IF;
                          END IF;


                          IF EN_stockDest is  null THEN
                  IF NOT AL_VALIDA_ESTADO_FN(LR_Ajuste.cod_estado) THEN
                                 LV_ERROR := '1';
                             LV_SQLERRM := 'La Serie esta en un Estado no Disponible para este proceso ';
                          ELSE
                             IF EN_usoDest is not null AND LR_Ajuste.num_telefono is not null THEN
                                LV_ERROR := '1';
                                LV_SQLERRM := 'La Serie esta Numerada.NO es posible procesarla ';
                              END IF;
                                  END IF;
                          END IF;

             UPDATE AL_SERIES_ES_EXTRAS_TT SET
                           cod_estado = LV_ERROR,
                           msg_error =  LV_SQLERRM
                 WHERE num_serie = LR_Ajuste.num_serie
                       AND num_extra= LR_Ajuste.num_extra
                   AND num_linea= LR_Ajuste.num_linea
                           AND ind_proceso=CN_uno;

         END LOOP;

                 --Archivo de Entrada

                 FOR LR_Entra IN LC_SerEnt(EN_num_extra, EN_num_linea) LOOP

                        LV_ERROR := '0';
                        LV_SQLERRM := 'OK';
                        LN_ESerie:=0;

                        SELECT count(num_serie)
                        INTO LN_ESerie
                        FROM AL_SERIES_ES_EXTRAS_TT
                        WHERE num_extra=EN_num_extra
                          AND num_linea=EN_num_linea
                          AND ind_proceso=CN_uno
                          AND num_serie=LR_Entra.num_serie;

                        IF LN_ESerie =CN_cero THEN
                        BEGIN
                               p_al_compseries( LR_Entra.num_serie, 'FRMMANENTRADASEXTRAS');
                        EXCEPTION
                           WHEN OTHERS THEN
                                   LV_ERROR := '1';
                                   IF SQLCODE = -20141 THEN
                                      LV_SQLERRM := 'Serie existe en AL_SERIES' ;
                                   ELSIF SQLCODE = -20142 THEN
                                      LV_SQLERRM := 'Serie existe en AL_FIC_SERIES' ;
                                   ELSIF SQLCODE = -20143 THEN
                                      LV_SQLERRM := 'Serie existe en GA_ABOAMIST' ;
                                   ELSIF SQLCODE = -20144 THEN
                                      LV_SQLERRM := 'Serie existe en GA_ABOCEL' ;
                                   ELSIF SQLCODE = -20148 THEN
                                      LV_SQLERRM := 'Serie existe en AL_COMPONENTE_KIT' ;
                                   ELSIF SQLCODE = -20153 THEN
                                          LV_SQLERRM := 'Serie NO existe en AL_SERIES' ;
                                   ELSE
                                      LV_SQLERRM := substr(SQLERRM,1,100);
                                   END IF ;
                            END ;
                        END IF;

                        IF LV_ERROR = '0' AND EN_SwValoArt = CN_uno THEN

                           SELECT ind_Equiacc
                           INTO LV_ind_equiacc
                           FROM AL_ARTICULOS
                           WHERE cod_articulo =LR_Entra.cod_articulo;

                                IF NOT (LV_ind_equiacc  = CV_Accesorio )  THEN
                                   LV_ERROR := '1';
                                   LV_SQLERRM := 'Articulo de la serie debe ser un Accesorio' ;
                                END IF;
                        END IF ;


                UPDATE AL_SERIES_ES_EXTRAS_TT SET
                           cod_estado = lv_error,
                           msg_error =  lv_sqlerrm
                WHERE num_serie =  LR_entra.num_serie
              AND num_extra= EN_num_extra
              AND num_linea= EN_num_linea
                  AND ind_proceso=CN_dos;

                END LOOP;


                IF LV_ERROR = CN_cero AND EN_SwValoArt = CN_uno THEN


                IF EN_bodegaDest is null then
                   LN_BodegaEnt:=LN_BodegaSal;
                ELSE
                   LN_BodegaEnt:=EN_bodegaDest;
                END IF;

                IF EN_usoDest  is null then
                   LN_UsoEnt:=LN_UsoSal;
                ELSE
                   LN_UsoEnt:=EN_usoDest;
                END IF;

                IF EN_estadoDest is null THEN
               LN_EstadoEnt:=LN_EstadoSal;
                ELSE
               LN_EstadoEnt:=EN_estadoDest;
                END IF;

            IF EN_stockDest is null THEN
                  LN_StockEnt :=LN_StockSal;
                ELSE
                  LN_StockEnt :=EN_stockDest;
                END IF;


            --Valorización Articulos de Salida
                BEGIN
                        SELECT (a.prc_venta * b.cantidad)
                        INTO LN_PrcSal
                FROM al_precios_venta a,
                    (SELECT count(CN_uno) cantidad
                                 FROM al_series_es_extras_tt
                                 WHERE  num_extra=EN_num_extra
                                    AND num_linea=EN_num_linea
                                        AND ind_proceso=CN_uno) b
                WHERE tip_stock=LN_StockSal
                AND cod_articulo=EN_articulo
                AND cod_uso=LN_UsoSal
                AND cod_estado=LN_EstadoSal
                AND sysdate >= fec_desde
                AND sysdate <= fec_hasta
                AND ind_recambio=CN_IndRecambio
                AND cod_categoria=CN_Categoria
                AND num_meses=CN_num_meses
                AND cod_promedio=CN_cod_promedio
                AND cod_antiguedad=CN_cod_antiguedad
                AND cod_modventa=CN_cod_modventa;
            EXCEPTION
                    WHEN OTHERS THEN
                           LN_PrcSal:=null;
                           LV_ERROR := '1';
                           LV_SQLERRM := 'No Existe Valorización para esta serie' ;
                           LN_IndProceso:=CN_uno;
                END ;



                    IF LV_ERROR <> CN_cero THEN
                           UPDATE AL_SERIES_ES_EXTRAS_TT SET
                           cod_estado = lv_error,
                           msg_error =  lv_sqlerrm
                       WHERE num_extra= EN_num_extra
                 AND num_linea= EN_num_linea
                         AND ind_proceso=LN_IndProceso;
                        ELSE
                            --Valorización Articulos de Salida
                        BEGIN
                           SELECT SUM(a.prc_venta)
                                           INTO LN_PrcEnt
                       FROM al_precios_venta a,al_series_es_extras_tt b
                       WHERE b.num_extra=EN_num_extra
                         AND b.num_linea=EN_num_linea
                         AND b.ind_proceso=CN_dos
                         AND a.tip_stock=LN_StockSal
                         AND a.cod_uso=LN_UsoSal
                         AND a.cod_estado=LN_EstadoSal
                         AND sysdate >= a.fec_desde
                         AND sysdate <= a.fec_hasta
                         AND a.ind_recambio=CN_IndRecambio
                         AND a.cod_categoria=CN_Categoria
                         AND a.num_meses=CN_num_meses
                         AND a.cod_promedio=CN_cod_promedio
                         AND a.cod_antiguedad=CN_cod_antiguedad
                         AND a.cod_modventa=CN_cod_modventa
                                                 AND a.cod_articulo=b.cod_articulo;
                   EXCEPTION
                            WHEN OTHERS THEN
                                   LN_PrcSal:=null;
                                   LV_ERROR := '1';
                                   LV_SQLERRM := 'No Existe Valorización para esta serie' ;
                                   LN_IndProceso:=CN_dos;
                        END ;

                                IF LV_ERROR <> CN_cero THEN
                               UPDATE AL_SERIES_ES_EXTRAS_TT SET
                           cod_estado = lv_error,
                           msg_error =  lv_sqlerrm
                       WHERE num_extra= EN_num_extra
                     AND num_linea= EN_num_linea
                         AND ind_proceso=LN_IndProceso;
                            END IF;

                        END IF;

                END IF;

                IF LV_ERROR = CN_cero AND EN_SwValoArt = CN_uno THEN
                   IF round(LN_PrcSal,0)<>round(LN_PrcEnt,0) THEN
                      LV_ERROR := '1';
                  LV_SQLERRM := 'Valorización Series Archivo Salida no es igual a Archivo Entrada' ;
                          UPDATE AL_SERIES_ES_EXTRAS_TT SET
                           cod_estado = lv_error,
                           msg_error =  lv_sqlerrm
                  WHERE num_extra= EN_num_extra
                AND num_linea= EN_num_linea;
                   END IF;
                END IF;



EXCEPTION
        WHEN OTHERS THEN
                raise_application_error(-20100, 'Error: ' || SQLERRM);
END AL_VALIDA_SIMULTANEO_DOBLE_PR;





-- fin packagge
END AL_SERIES_ES_EXTRAS_PG ;
/
SHOW ERRORS