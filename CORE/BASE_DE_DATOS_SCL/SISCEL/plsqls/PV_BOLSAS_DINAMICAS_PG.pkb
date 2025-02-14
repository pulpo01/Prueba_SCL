CREATE OR REPLACE PACKAGE BODY PV_BOLSAS_DINAMICAS_PG IS

FUNCTION PV_obtener_fecha_maxima_FN RETURN DATE

IS

  LV_Fechamaxima                                          ged_parametros.val_parametro%TYPE;
  LV_formatofec2                                          ged_parametros.val_parametro%TYPE;
  LV_formatofec7                                          ged_parametros.val_parametro%TYPE;

BEGIN
         --Obtener fecha maxima 31-12-3000
         SELECT val_parametro INTO LV_Fechamaxima
         FROM ged_parametros
         WHERE cod_producto = CN_cod_producto
         AND cod_modulo = 'GE'
         AND nom_parametro = 'FECHA_MAXIMA';

         SELECT val_parametro INTO LV_formatofec2
         FROM ged_parametros
         WHERE cod_producto = CN_cod_producto
         AND cod_modulo = 'GE'
         AND nom_parametro = 'FORMATO_SEL2';

         SELECT val_parametro INTO LV_formatofec7
         FROM ged_parametros
         WHERE cod_producto = CN_cod_producto
         AND cod_modulo = 'GE'
         AND nom_parametro = 'FORMATO_SEL7';

         RETURN TO_DATE(LV_Fechamaxima,LV_formatofec2 || ' ' || LV_formatofec7);

END;

PROCEDURE PV_RSTRCN_PLANBLSDNMCA_PR(
          EV_param_entrada IN  VARCHAR2,
          SV_RESULTADO     OUT VARCHAR2,
                  SV_MENSAJE       OUT GA_TRANSACABO.DES_CADENA%TYPE
) IS

     string GE_TABTYPE_VCH2ARRAY:= GE_TABTYPE_VCH2ARRAY('','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');

     LV_cod_plantarif    ta_plantarif.cod_plantarif%TYPE;
         LN_flg_rango            ta_plantarif.flg_rango%TYPE;

BEGIN

         SV_RESULTADO := 'FALSE';

     GE_PAC_ArregloPR.GE_PR_RetornaArreglo(EV_param_entrada, string);
     LV_cod_plantarif     := string(12);

         SELECT flg_rango INTO LN_flg_rango
         FROM ta_plantarif
         WHERE cod_producto = CN_cod_producto
         AND cod_plantarif = LV_cod_plantarif;

         IF LN_flg_rango = 1 THEN
                SV_RESULTADO := 'TRUE';
         ELSE
                 SV_MENSAJE := 'Plan tarifario sin bolsa dinamica.';
         END IF;

EXCEPTION
        WHEN NO_DATA_FOUND THEN
             SV_MENSAJE   := 'Plan tarifario no existe.';

        WHEN OTHERS THEN
             SV_MENSAJE   := 'ERROR EN PV_RSTRCN_PLANBLSDNMCA_PR: NO SE PUEDE VALIDAR PLAN.';
END PV_RSTRCN_PLANBLSDNMCA_PR;

PROCEDURE PV_RSTRCN_CAMPLAN_PNDNTE_PR(
          EV_param_entrada IN  VARCHAR2,
          SV_RESULTADO     OUT VARCHAR2,
                  SV_MENSAJE       OUT GA_TRANSACABO.DES_CADENA%TYPE
) IS

     string GE_TABTYPE_VCH2ARRAY:= GE_TABTYPE_VCH2ARRAY('','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');

         LV_cod_cliente          ge_clientes.cod_cliente%TYPE;
     --LV_cod_plantarif    ta_plantarif.cod_plantarif%TYPE;
         LN_valor                        NUMBER(1);

BEGIN
         GE_PAC_ArregloPR.GE_PR_RetornaArreglo(EV_param_entrada, string);

         LV_cod_cliente := TO_NUMBER(string(6));
         --LV_cod_plantarif     := string(11);

         SV_RESULTADO := 'FALSE';

         SELECT 1 INTO LN_valor
         FROM ga_finciclo
         WHERE cod_cliente = LV_cod_cliente
         AND tip_plantarif = CV_tipplanemp
         AND cod_plantarif IS NOT NULL;

         SV_MENSAJE := 'Cliente posee un cambio de plan pendiente.';

EXCEPTION
                 WHEN NO_DATA_FOUND THEN
                          SV_RESULTADO := 'TRUE';
END PV_RSTRCN_CAMPLAN_PNDNTE_PR;

PROCEDURE PV_ACTLZ_BLSDNMC_CAMCARBAS_PR(
                  EN_cod_cliente           IN ge_clientes.cod_cliente%TYPE,
                  EN_cod_ciclo                     IN fa_ciclfact.cod_ciclo%TYPE,
                  EV_cod_cargobasico       IN ta_plantarif.cod_cargobasico%TYPE,
                  EV_cod_plantarif                 IN ta_plantarif.cod_plantarif%TYPE,
                  EN_imp_cargo_basico      IN fa_dctos_serv_rec_td.imp_cargo_basico%TYPE,
                  EN_imp_final                     IN ta_rango_planes_td.imp_final%TYPE,
                  SN_cod_retorno           OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                  SN_num_evento            OUT NOCOPY ge_errores_pg.evento,
                  SV_mens_retorno          OUT NOCOPY ge_errores_td.det_msgerror%TYPE

) IS

  LD_fechaactual                        DATE;
--  LD_fechaproxcic                     DATE;
  LD_feccierrevig                       DATE;
  LD_fecabrevigprox                     DATE;
  LD_fecmaxima                          DATE;

  LV_cod_plantarif                      ta_plantarif.cod_plantarif%TYPE;
  LN_dcto_crgbsc1                       fa_dctos_serv_rec_td.imp_cargo_basico%TYPE;
  LN_dcto_crgbsc2                       fa_dctos_serv_rec_td.imp_cargo_basico%TYPE;

  LN_cod_retorno                        ge_errores_td.cod_msgerror%TYPE;
  LV_mens_retorno                       ge_errores_td.det_msgerror%TYPE;
  LN_num_evento                         ge_errores_pg.evento;

  fin_ejecucion                         exception;

  /*Para consulta de descuento */
  LD_fec_desdedcto                         DATE;
  LD_fec_hastadcto                         DATE;

  LN_imp_descuento                         fa_dctos_serv_rec_td.imp_cargo_basico%TYPE;

BEGIN

         LD_fechaactual := SYSDATE;
         LN_imp_descuento := EN_imp_final - EN_imp_cargo_basico;

                FA_DCTO_CLTE_SN_PG.FA_CONS_DCTO_CLTE_BLSDINAM_PR( EN_cod_cliente,
                                                                                                                  LD_fechaactual,
                                                                                                                  LV_cod_plantarif,
                                                                                                                  LN_dcto_crgbsc1,
                                                                                                                  LD_fec_desdedcto,
                                                                                                                  LD_fec_hastadcto,
                                                                                                                  LN_cod_retorno,
                                                                                                                  LV_mens_retorno,
                                                                                                                  LN_num_evento );

         IF NOT LN_cod_retorno=0 THEN
                SN_cod_retorno := LN_cod_retorno;
                SN_num_evento := LN_num_evento;
                SV_mens_retorno := CV_MSGERR_BLSDIN_CNSLT1 || LV_mens_retorno;
                RAISE fin_ejecucion;
         END IF;

         --Se obtiene fecha de cierre de ciclo actual y cuando se abre el ciclo siguiente ..
         SELECT fec_hastallam, fec_hastallam + (1/(24*60*60))
         INTO LD_feccierrevig, LD_fecabrevigprox
         FROM Fa_ciclfact
         WHERE cod_ciclo = EN_cod_ciclo
         AND LD_fechaactual BETWEEN fec_desdellam AND fec_hastallam;

         --Obtener importe cargo básico del periodo siguiente ---
                FA_DCTO_CLTE_SN_PG.FA_CONS_DCTO_CLTE_BLSDINAM_PR( EN_cod_cliente,
                                                                                                                  LD_fecabrevigprox,
                                                                                                                  LV_cod_plantarif,
                                                                                                                  LN_dcto_crgbsc2,
                                                                                                                  LD_fec_desdedcto,
                                                                                                                  LD_fec_hastadcto,
                                                                                                                  LN_cod_retorno,
                                                                                                                  LV_mens_retorno,
                                                                                                                  LN_num_evento );

         IF NOT LN_cod_retorno=0 THEN
                SN_cod_retorno := LN_cod_retorno;
                SN_num_evento := LN_num_evento;
                SV_mens_retorno := CV_MSGERR_BLSDIN_CNSLT2 || LV_mens_retorno;
                RAISE fin_ejecucion;
         END IF;

         LD_fecmaxima := PV_obtener_fecha_maxima_FN;

         IF LN_dcto_crgbsc1 = LN_dcto_crgbsc2 THEN
         -- Si el valor cargo básico actual es igual al del periodo siguiente
         -- quiere decir que no existe otro registro con
         -- valor básico diferente para el proximo periodo , por lo tanto, debemos
         -- cerrar vigencia a la fecha de vencimiento del periodo actual y abrir
         -- periodo con el nuevo valor del cargo básico cargo básico --


                -- Antes válido que el valor ingresado sea diferente al cargo basico existente
                IF  LN_imp_descuento = LN_dcto_crgbsc2 THEN
                        LN_cod_retorno := CN_valcarbas_existe;
                        LV_mens_retorno := CV_MSGERR_BLSDIN_EXISTE;
                        RAISE fin_ejecucion;
                END IF;

                 --Cerrar vigencia de periodo actual --
                 FA_DCTO_CLTE_SN_PG.FA_BORRA_DCTO_CLTE_BLSDINAM_PR( EN_cod_cliente,
                                                                                                                        LD_feccierrevig,
                                                                                                                        LN_cod_retorno,
                                                                                                                        LV_mens_retorno,
                                                                                                                        LN_num_evento );


                 IF NOT LN_cod_retorno = 0 THEN
                        SN_cod_retorno := LN_cod_retorno;
                        SN_num_evento := LN_num_evento;
                        SV_mens_retorno := CV_MSGERR_BLSDIN_UPVIG1 || LV_mens_retorno;
                        RAISE fin_ejecucion;
                 END IF;

                 --Ingresar registro con valor nuevo de cargo básico para el proximo periodo
             FA_DCTO_CLTE_SN_PG.FA_INS_DCTO_CLTE_BLSDINAM_PR( EN_cod_cliente,
                                                                                                                  EV_cod_cargobasico,
                                                                                                                  EV_cod_plantarif,
                                                                                                                  LN_imp_descuento,
                                                                                                                  LD_fecabrevigprox,
                                                                                                                  LD_fecmaxima,
                                                                                                                  LN_cod_retorno,
                                                                                                                  LV_mens_retorno,
                                                                                                                  LN_num_evento );

                 IF NOT LN_cod_retorno=0 THEN
                        SN_cod_retorno := LN_cod_retorno;
                        SN_num_evento := LN_num_evento;
                        SV_mens_retorno := CV_MSGERR_BLSDIN_INVIG2 || LV_mens_retorno;
                        RAISE fin_ejecucion;
                 END IF;

         ELSE
         -- Si el valor cargo básico actual es diferente al del periodo siguiente
         -- quiere decir que existe otro registro con
         -- valor básico diferente para el proximo periodo , por lo tanto, debemos
         -- actualizar el valor del cargo básico del periodo siguiente --



                        --Borrado fisico del periodo siguiente
                         FA_DCTO_CLTE_SN_PG.FA_BORRA_DCTO_CLTE_BLSDINAM_PR( EN_cod_cliente,
                                                                                                                                LD_fecabrevigprox,
                                                                                                                                LN_cod_retorno,
                                                                                                                                LV_mens_retorno,
                                                                                                                                LN_num_evento );
                         IF NOT LN_cod_retorno=0 THEN
                                SN_cod_retorno := LN_cod_retorno;
                                SN_num_evento := LN_num_evento;
                                SV_mens_retorno :=   CV_MSGERR_BLSDIN_DELVIG2 || LV_mens_retorno;
                                RAISE fin_ejecucion;
                         END IF;


                        IF LN_imp_descuento = LN_dcto_crgbsc1 THEN
                        --Si el cargo basico ingresado es igual al del periodo actual
                        -- quiere decir q el cliente desea seguir pagando el valor del cargo basico actual
                        -- por lo tanto debemos eliminar el registro con el periodo siguiente y extender
                        -- el periodo actual ...


                           -- Extender vigencia del periodo actual ...

                                --Se debe actualizar la vigencia del plan actual
                                FA_DCTO_CLTE_SN_PG.FA_MODIF_DCTO_CLTE_BLSDINAM_PR( EN_cod_cliente,
                                                                                                                                   LD_fechaactual,
                                                                                                                                   NULL,
                                                                                                                                   LD_fecmaxima,
                                                                                                                                   LN_cod_retorno,
                                                                                                                                   LV_mens_retorno,
                                                                                                                                   LN_num_evento );

                                 IF NOT LN_cod_retorno=0 THEN
                                        SN_cod_retorno := LN_cod_retorno;
                                        SN_num_evento := LN_num_evento;
                                        SV_mens_retorno := CV_MSGERR_BLSDIN_INVIG2 || LV_mens_retorno;
                                        RAISE fin_ejecucion;
                                 END IF;

                        ELSE


                                --Insertar nuevo cargo basico para el proximo periodo --
                             FA_DCTO_CLTE_SN_PG.FA_INS_DCTO_CLTE_BLSDINAM_PR( EN_cod_cliente,
                                                                                                                                  EV_cod_cargobasico,
                                                                                                                                  EV_cod_plantarif,
                                                                                                                                  EN_imp_final - EN_imp_cargo_basico,
                                                                                                                                  LD_fecabrevigprox,
                                                                                                                                  LD_fecmaxima,
                                                                                                                                  LN_cod_retorno,
                                                                                                                                  LV_mens_retorno,
                                                                                                                                  LN_num_evento );
                                 IF NOT LN_cod_retorno=0 THEN
                                        SN_cod_retorno := LN_cod_retorno;
                                        SN_num_evento := LN_num_evento;
                                        SV_mens_retorno := CV_MSGERR_BLSDIN_INVIG2 || LV_mens_retorno;
                                        RAISE fin_ejecucion;
                                 END IF;

                END IF; --IF EN_imp_cargo_basico = LN_imp_crgbsc1 THEN

         END IF;

        SN_cod_retorno := 0;
        SN_num_evento := 0;
        SV_mens_retorno := 'OK';

EXCEPTION
WHEN fin_ejecucion THEN
         NULL;
WHEN OTHERS THEN
         SN_cod_retorno := 4;
         SV_mens_retorno := SUBSTR(SQLERRM,1,255);
END PV_ACTLZ_BLSDNMC_CAMCARBAS_PR;

PROCEDURE PV_ACTLZ_BLSDNMC_CAMPLAN_PR(
                  EN_cod_cliente           IN ge_clientes.cod_cliente%TYPE,
                  EN_cod_ciclo                     IN fa_ciclfact.cod_ciclo%TYPE,
                  EV_cod_plantarif1                IN ta_plantarif.cod_plantarif%TYPE,
                  EV_cod_plantarif2                IN ta_plantarif.cod_plantarif%TYPE,
                  EV_cod_cargobasico2      IN ta_plantarif.cod_cargobasico%TYPE,
                  EN_imp_cargo_basico      IN fa_dctos_serv_rec_td.imp_cargo_basico%TYPE,
                  EN_imp_final                     IN ta_rango_planes_td.imp_final%TYPE,
                  SN_cod_retorno           OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                  SN_num_evento            OUT NOCOPY ge_errores_pg.evento,
                  SV_mens_retorno          OUT NOCOPY ge_errores_td.det_msgerror%TYPE

) IS

  LN_flg_rango1                                    ta_plantarif.flg_rango%TYPE;
  LN_flg_rango2                                    ta_plantarif.flg_rango%TYPE;

  LD_fechaactual                                   DATE;
  --LD_fechaproxcic                                DATE;
  LD_feccierrevig                                  DATE;
  LD_fecabrevigprox                                DATE;
  LD_fecmaxima                                     DATE;

  LN_cod_retorno                        ge_errores_td.cod_msgerror%TYPE;
  LV_mens_retorno                       ge_errores_td.det_msgerror%TYPE;
  LN_num_evento                         ge_errores_pg.evento;
  fin_ejecucion                         EXCEPTION;


BEGIN

         LD_fechaactual := SYSDATE;

         SELECT flg_rango INTO LN_flg_rango1
         FROM ta_plantarif
         WHERE cod_producto = CN_cod_producto
         AND cod_plantarif = EV_cod_plantarif1;

         -- Obtener fecha de cierre de ciclo
         -- Obtener fecha de apertura proximo ciclo
         SELECT  fec_hastallam, fec_hastallam + (1/(24*60*60))
         INTO LD_feccierrevig, LD_fecabrevigprox
         FROM Fa_ciclfact
         WHERE cod_ciclo = EN_cod_ciclo
         AND LD_fechaactual BETWEEN fec_desdellam AND fec_hastallam;

         IF LN_flg_rango1 = CN_flg_planblsdnmc THEN
                 -- Cerrar vigencia del plan actual hasta el final del periodo.
                 FA_DCTO_CLTE_SN_PG.FA_BORRA_DCTO_CLTE_BLSDINAM_PR( EN_cod_cliente,
                                                                                                                        LD_feccierrevig,
                                                                                                                        LN_cod_retorno,
                                                                                                                        LV_mens_retorno,
                                                                                                                        LN_num_evento );
                 IF NOT LN_cod_retorno = 0 THEN
                        SN_cod_retorno := LN_cod_retorno;
                        SN_num_evento := LN_num_evento;
                        SV_mens_retorno := CV_MSGERR_BLSDIN_UPVIG1 || LV_mens_retorno;
                        RAISE fin_ejecucion;
                 END IF;

         END IF;

         SELECT flg_rango INTO LN_flg_rango2
         FROM ta_plantarif
         WHERE cod_producto = CN_cod_producto
         AND cod_plantarif = EV_cod_plantarif2;

         IF LN_flg_rango2 = CN_flg_planblsdnmc THEN
         --Abrir registro con nuevo plan en el proximo periodo

                LD_fecmaxima := PV_obtener_fecha_maxima_FN;

                --Insertar nuevo cargo basico para el proximo periodo --
             FA_DCTO_CLTE_SN_PG.FA_INS_DCTO_CLTE_BLSDINAM_PR( EN_cod_cliente,
                                                                                                                  EV_cod_cargobasico2,
                                                                                                                  EV_cod_plantarif2,
                                                                                                                  EN_imp_final - EN_imp_cargo_basico,
                                                                                                                  LD_fecabrevigprox,
                                                                                                                  LD_fecmaxima,
                                                                                                                  LN_cod_retorno,
                                                                                                                  LV_mens_retorno,
                                                                                                                  LN_num_evento );

--FA_DCTO_CLTE_SN_PG.FA_INS_DCTO_CLTE_BLSDINAM_PR( EN_COD_CLIENTE, EN_COD_CARGOBASICO, EV_COD_PLANTARIF, EN_MTO_DESCUENTO, ED_FEC_DESDEDCTO, ED_FEC_HASTADCTO, SN_COD_RETORNO, SV_MENS_RETORNO, SN_NUM_EVENTO );

                 IF NOT LN_cod_retorno=0 THEN
                        SN_cod_retorno := LN_cod_retorno;
                        SN_num_evento := LN_num_evento;
                        SV_mens_retorno := CV_MSGERR_BLSDIN_INVIG2 || LV_mens_retorno;
                        RAISE fin_ejecucion;
                 END IF;

         END IF;

        SN_cod_retorno := 0;
        SN_num_evento := 0;
        SV_mens_retorno := 'OK';

EXCEPTION
                 WHEN fin_ejecucion THEN
                          NULL;
                 WHEN OTHERS THEN
                         SN_cod_retorno := 4;
                         SV_mens_retorno := SUBSTR(SQLERRM,1,255);
END PV_ACTLZ_BLSDNMC_CAMPLAN_PR;

PROCEDURE PV_ODBC_ACTLZBLSDNMCCAMPLAN_PR(
                  EN_num_transaccion       IN ga_transacabo.num_transaccion%TYPE,
                  EN_cod_cliente           IN ge_clientes.cod_cliente%TYPE,
                  EN_cod_ciclo                     IN fa_ciclfact.cod_ciclo%TYPE,
                  EV_cod_plantarif1                IN ta_plantarif.cod_plantarif%TYPE,
                  EV_cod_plantarif2                IN ta_plantarif.cod_plantarif%TYPE,
                  EV_cod_cargobasico2      IN ta_plantarif.cod_cargobasico%TYPE,
                  EN_imp_cargo_basico      IN fa_dctos_serv_rec_td.imp_cargo_basico%TYPE,
                  EN_imp_final                     IN ta_rango_planes_td.imp_final%TYPE
)

IS

  LN_cod_retorno                        ge_errores_td.cod_msgerror%TYPE;
  LV_mens_retorno                       ge_errores_td.det_msgerror%TYPE;
  LN_num_evento                         ge_errores_pg.evento;

BEGIN

         PV_BOLSAS_DINAMICAS_PG.PV_ACTLZ_BLSDNMC_CAMPLAN_PR(EN_cod_cliente,
                                                                                                                EN_cod_ciclo,
                                                                                                                EV_cod_plantarif1,
                                                                                                                EV_cod_plantarif2,
                                                                                                                EV_cod_cargobasico2,
                                                                                                                EN_imp_cargo_basico,
                                                                                                                EN_imp_final,
                                                                                                                LN_cod_retorno,
                                                                                                                LN_num_evento,
                                                                                                                LV_mens_retorno);

         IF LN_cod_retorno = 0 then

                 INSERT INTO ga_transacabo       (num_transaccion,cod_retorno,des_cadena)
                 VALUES (EN_num_transaccion, LN_cod_retorno, SUBSTR(LN_num_evento || '|' || LV_mens_retorno,1,255));

         ELSE

                 INSERT INTO ga_transacabo       (num_transaccion,cod_retorno,des_cadena)
                 VALUES (EN_num_transaccion, 4, SUBSTR(LN_num_evento || '|' || LN_cod_retorno || ';' || LV_mens_retorno,1,255));

         END IF;

EXCEPTION
                 WHEN OTHERS THEN
                          LV_mens_retorno := SUBSTR(SQLERRM,1,255);
                          INSERT INTO ga_transacabo      (num_transaccion,cod_retorno,des_cadena)
                          VALUES (EN_num_transaccion, 4, LV_mens_retorno);
END PV_ODBC_ACTLZBLSDNMCCAMPLAN_PR;

PROCEDURE PV_ANULCN_BLSDNMC_CAMPLAN_PR(
                  EN_cod_cliente           IN ge_clientes.cod_cliente%TYPE,
                  EN_cod_ciclo                     IN fa_ciclfact.cod_ciclo%TYPE,
                  EV_cod_plantarif                 IN ta_plantarif.cod_plantarif%TYPE,
                  SN_cod_retorno           OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                  SN_num_evento            OUT NOCOPY ge_errores_pg.evento,
                  SV_mens_retorno          OUT NOCOPY ge_errores_td.det_msgerror%TYPE

) IS

-- Procedimiento debe realizar la anulación de un cambio de plan por rango pendiente
-- un cambio de cargo básico pendiente

   LN_flg_rango           ta_plantarif.flg_rango%TYPE;
   LN_dcto_crgbsc1        fa_dctos_serv_rec_td.imp_descuento%TYPE;
   LN_dcto_crgbsc2        fa_dctos_serv_rec_td.imp_descuento%TYPE;

   LD_fechaactual                                                                                       DATE;
   LD_fecmaxima                                                                                         DATE;
   --LD_fechaproxcic      DATE;
   LD_feccierrevig                                                                                      DATE;
   LD_fecabrevigprox                                                                            DATE;

  LN_cod_retorno                        ge_errores_td.cod_msgerror%TYPE;
  LV_mens_retorno                       ge_errores_td.det_msgerror%TYPE;
  LN_num_evento                         ge_errores_pg.evento;
  fin_ejecucion                         EXCEPTION;
  error_anul_solic_os           EXCEPTION;

  /*Para consulta de descuento */
  LV_cod_plantarif1                        ta_plantarif.cod_plantarif%TYPE;
  LV_cod_plantarif2                        ta_plantarif.cod_plantarif%TYPE;

  LD_fec_desdedcto                         DATE;
  LD_fec_hastadcto                         DATE;

BEGIN
        LD_fechaactual := SYSDATE;

         SELECT flg_rango INTO LN_flg_rango
         FROM ta_plantarif
         WHERE cod_producto = CN_cod_producto
         AND cod_plantarif = EV_cod_plantarif;

         IF LN_flg_rango = CN_flg_planblsdnmc THEN

                LD_fecmaxima := PV_obtener_fecha_maxima_FN;

                FA_DCTO_CLTE_SN_PG.FA_CONS_DCTO_CLTE_BLSDINAM_PR( EN_cod_cliente,
                                                                                                                  LD_fechaactual,
                                                                                                                  LV_cod_plantarif1,
                                                                                                                  LN_dcto_crgbsc1,
                                                                                                                  LD_fec_desdedcto,
                                                                                                                  LD_fec_hastadcto,
                                                                                                                  LN_cod_retorno,
                                                                                                                  LV_mens_retorno,
                                                                                                                  LN_num_evento );

                 IF NOT LN_cod_retorno=0 THEN
                        SN_cod_retorno := LN_cod_retorno;
                        SN_num_evento := LN_num_evento;
                        SV_mens_retorno := CV_MSGERR_BLSDIN_CNSLT1 || LV_mens_retorno;
                        RAISE fin_ejecucion;
                 END IF;

                 --Obtener fecha de cierre periodo actual --
                 --Obterer fecha de apertura proximo periodo --
                 SELECT fec_hastallam, fec_hastallam + (1/(24*60*60))
                 INTO LD_feccierrevig, LD_fecabrevigprox
                 FROM Fa_ciclfact
                 WHERE cod_ciclo = EN_cod_ciclo
                 AND LD_fechaactual BETWEEN fec_desdellam AND fec_hastallam;

                 --Obtener importe cargo básico del periodo siguiente ---
                FA_DCTO_CLTE_SN_PG.FA_CONS_DCTO_CLTE_BLSDINAM_PR( EN_cod_cliente,
                                                                                                                  LD_fecabrevigprox,
                                                                                                                  LV_cod_plantarif2,
                                                                                                                  LN_dcto_crgbsc2,
                                                                                                                  LD_fec_desdedcto,
                                                                                                                  LD_fec_hastadcto,
                                                                                                                  LN_cod_retorno,
                                                                                                                  LV_mens_retorno,
                                                                                                                  LN_num_evento );

                 -- No se encontro registro con plan por rango vigente para el proximo periodo.
                 --El cliente tiene un plan por rango pero vigente solo hasta fin del periodo actual
                 -- por lo tanto tiene un cambio de plan tradicional vigente
                 --Se debe proceder a anular dejando vigente el plan por rango actual y su correspondiente
                 -- valor de cargo básico .
                 IF LN_cod_retorno = CN_cod_ret_no_found THEN

                        --Se debe actualizar la vigencia del plan actual
                        FA_DCTO_CLTE_SN_PG.FA_MODIF_DCTO_CLTE_BLSDINAM_PR( EN_cod_cliente,
                                                                                                                           LD_fechaactual,
                                                                                                                           NULL,
                                                                                                                           LD_fecmaxima,
                                                                                                                           LN_cod_retorno,
                                                                                                                           LV_mens_retorno,
                                                                                                                           LN_num_evento );

                 ELSIF NOT LN_cod_retorno = 0 THEN
                                SN_cod_retorno := LN_cod_retorno;
                                SN_num_evento := LN_num_evento;
                                SV_mens_retorno := CV_MSGERR_BLSDIN_CNSLT2 || LV_mens_retorno;
                                RAISE fin_ejecucion;
                 END IF;

                 IF LV_cod_plantarif1 = LV_cod_plantarif2 and LN_dcto_crgbsc1 = LN_dcto_crgbsc2 THEN
                        -- El periodo actual y siguiente tienen el mismo valor de cargo básico y plan
                        -- por lo tanto no hay anulación
                        SN_cod_retorno := 0;
                        SN_num_evento := 0;
                        SV_mens_retorno := 'OK';
                        RAISE fin_ejecucion;
                 ELSE

                        --Borrado fisico del periodo siguiente
                         FA_DCTO_CLTE_SN_PG.FA_BORRA_DCTO_CLTE_BLSDINAM_PR( EN_cod_cliente,
                                                                                                                                LD_fecabrevigprox,
                                                                                                                                LN_cod_retorno,
                                                                                                                                LV_mens_retorno,
                                                                                                                                LN_num_evento );
                         IF NOT LN_cod_retorno=0 THEN
                                SN_cod_retorno := LN_cod_retorno;
                                SN_num_evento := LN_num_evento;
                                SV_mens_retorno := CV_MSGERR_BLSDIN_DELVIG2 || LV_mens_retorno;
                                RAISE fin_ejecucion;
                         END IF;

                         --Anular solcitud de orden de servicio si existiese...
                         --O.S.: Cambio de cargo basico en la plataforma atlantida
                         PV_BOLSAS_DINAMICAS_PG.PV_ANULAR_SOLICOS_ATLTD_PR( EN_cod_cliente,
                                                                                                                                LD_fecabrevigprox,
                                                                                                                                CN_codos_camcarbas,
                                                                                                                                LN_cod_retorno );
                         IF NOT LN_cod_retorno=0 THEN
                                RAISE error_anul_solic_os;
                         END IF;

                        --Se debe actualizar la vigencia del plan actual
                        FA_DCTO_CLTE_SN_PG.FA_MODIF_DCTO_CLTE_BLSDINAM_PR( EN_cod_cliente,
                                                                                                                           LD_fechaactual,
                                                                                                                           NULL,
                                                                                                                           LD_fecmaxima,
                                                                                                                           LN_cod_retorno,
                                                                                                                           LV_mens_retorno,
                                                                                                                           LN_num_evento );
                         IF NOT LN_cod_retorno = 0 THEN
                                        SN_cod_retorno := LN_cod_retorno;
                                        SN_num_evento := LN_num_evento;
                                        SV_mens_retorno := CV_MSGERR_BLSDIN_UPVIG2 || LV_mens_retorno;
                                        RAISE fin_ejecucion;
                         END IF;

                         --Si el cliente es atlantida se debe

                 END IF;

         ELSE

                 --Se obtiene fecha del ciclo siguiente para obtener valor del cargo básico
                 -- en el proximo periodo para revizar si existe un valor diferente.
                 SELECT fec_hastallam + (1/(24*60*60))
                 INTO LD_fecabrevigprox
                 FROM Fa_ciclfact
                 WHERE cod_ciclo = EN_cod_ciclo
                 AND LD_fechaactual BETWEEN fec_desdellam AND fec_hastallam;

                 --Obtener importe cargo básico del periodo siguiente ---
                FA_DCTO_CLTE_SN_PG.FA_CONS_DCTO_CLTE_BLSDINAM_PR( EN_cod_cliente,
                                                                                                                  LD_fecabrevigprox,
                                                                                                                  LV_cod_plantarif1,
                                                                                                                  LN_dcto_crgbsc2,
                                                                                                                  LD_fec_desdedcto,
                                                                                                                  LD_fec_hastadcto,
                                                                                                                  LN_cod_retorno,
                                                                                                                  LV_mens_retorno,
                                                                                                                  LN_num_evento );


                 -- No se encontro registro con plan por rango vigente para el proximo periodo.
                 --El cliente tiene un plan tradicional
                 -- No aplica anulación.
                 IF LN_cod_retorno = CN_cod_ret_no_found THEN
                        SN_cod_retorno := 0;
                        SN_num_evento := 0;
                        SV_mens_retorno := 'OK';
                        RAISE fin_ejecucion;
                 ELSIF NOT LN_cod_retorno = 0 THEN
                        SN_cod_retorno := LN_cod_retorno;
                        SN_num_evento := LN_num_evento;
                        SV_mens_retorno := CV_MSGERR_BLSDIN_CNSLT2 || LV_mens_retorno;
                        RAISE fin_ejecucion;
                 END IF;

                 --Existe registro con plan por rango vigente
                 -- el cual debe ser anulado.
                --Borrado fisico del periodo siguiente
                 FA_DCTO_CLTE_SN_PG.FA_BORRA_DCTO_CLTE_BLSDINAM_PR( EN_cod_cliente,
                                                                                                                        LD_fecabrevigprox,
                                                                                                                        LN_cod_retorno,
                                                                                                                        LV_mens_retorno,
                                                                                                                        LN_num_evento );
                 IF NOT LN_cod_retorno=0 THEN
                        SN_cod_retorno := LN_cod_retorno;
                        SN_num_evento := LN_num_evento;
                        SV_mens_retorno := CV_MSGERR_BLSDIN_DELVIG2 || LV_mens_retorno;
                        RAISE fin_ejecucion;
                 END IF;

                 --Anular solcitud de orden de servicio si existiese...
                 --O.S.: Cambio de cargo basico en la plataforma atlantida
                 PV_BOLSAS_DINAMICAS_PG.PV_ANULAR_SOLICOS_ATLTD_PR( EN_cod_cliente,
                                                                                                                        LD_fecabrevigprox,
                                                                                                                        CN_codos_camcarbas,
                                                                                                                        LN_cod_retorno );
                 IF NOT LN_cod_retorno=0 THEN
                        RAISE error_anul_solic_os;
                 END IF;

         END IF;

        SN_cod_retorno := 0;
        SN_num_evento := 0;
        SV_mens_retorno := 'OK';


EXCEPTION
                 WHEN fin_ejecucion THEN
                          NULL;
                 WHEN error_anul_solic_os THEN
                   SN_cod_retorno := 4;
                   SN_num_evento := -1;
                   SV_mens_retorno := 'Error al intentar anular solicitud de orden de servicio: PV_BOLSAS_DINAMICAS_PG.PV_ANULAR_SOLICOS_ATLTD_PR.';
                 WHEN OTHERS THEN
                         SN_cod_retorno := 4;
                         SV_mens_retorno := SUBSTR(SQLERRM,1,255);
END PV_ANULCN_BLSDNMC_CAMPLAN_PR;

PROCEDURE PV_ODBC_ANULCBLSDNMCCAMPLAN_PR(
                  EN_num_transaccion       IN ga_transacabo.num_transaccion%TYPE,
                  EN_cod_cliente           IN ge_clientes.cod_cliente%TYPE,
                  EN_cod_ciclo                     IN fa_ciclfact.cod_ciclo%TYPE,
                  EV_cod_plantarif                 IN ta_plantarif.cod_plantarif%TYPE
)IS

  LN_cod_retorno                        ge_errores_td.cod_msgerror%TYPE;
  LV_mens_retorno                       ge_errores_td.det_msgerror%TYPE;
  LN_num_evento                         ge_errores_pg.evento;

BEGIN

         PV_BOLSAS_DINAMICAS_PG.PV_ANULCN_BLSDNMC_CAMPLAN_PR(EN_cod_cliente,
                                                                                                                EN_cod_ciclo,
                                                                                                                EV_cod_plantarif,
                                                                                                                LN_cod_retorno,
                                                                                                                LN_num_evento,
                                                                                                                LV_mens_retorno);

         IF LN_cod_retorno = 0 THEN

                 INSERT INTO ga_transacabo       (num_transaccion,cod_retorno,des_cadena)
                 VALUES (EN_num_transaccion, LN_cod_retorno, SUBSTR(LN_num_evento || '|' || LV_mens_retorno,1,255));

         ELSE

                 INSERT INTO ga_transacabo       (num_transaccion,cod_retorno,des_cadena)
                 VALUES (EN_num_transaccion, 4, SUBSTR(LN_num_evento || '|' || LN_cod_retorno || ';' || LV_mens_retorno,1,255));

         END IF;

EXCEPTION
                 WHEN OTHERS THEN
                          LV_mens_retorno := SUBSTR(SQLERRM,1,255);
                          INSERT INTO ga_transacabo      (num_transaccion,cod_retorno,des_cadena)
                          VALUES (EN_num_transaccion, 4, LV_mens_retorno);
END PV_ODBC_ANULCBLSDNMCCAMPLAN_PR;

PROCEDURE PV_INSCOS_CAMCARBASATLACICL_PR(
                                                                                   EN_cod_cliente         IN                       ga_abocel.cod_cliente%TYPE,
                                                                                   EV_cod_os              IN                       pv_iorserv.cod_os%TYPE,
                                                                                   EV_usuario             IN                       pv_iorserv.usuario%TYPE,
                                                                                   EV_bdatos              IN                       pv_camcom.bdatos%TYPE,
                                                                                   EV_cod_plantarif   IN                           ta_plantarif.cod_plantarif%TYPE,
                                                                                   EN_cod_ciclo       IN               ge_clientes.cod_ciclo%TYPE,
                                                                                   EV_modulo              IN                       VARCHAR2,
                                                                                   EN_numtar              IN                       VARCHAR2,
                                                                                   EV_cod_actabo          IN                       ga_actabo.cod_actabo%TYPE,
                                                                                   SN_cod_retorno          OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                                                                                   SN_num_evento           OUT NOCOPY ge_errores_pg.evento,
                                                                                   SV_mens_retorno         OUT NOCOPY ge_errores_td.det_msgerror%TYPE

) IS

  LN_num_transaccion                                       ga_transacabo.num_transaccion%TYPE;
  LN_num_celular                                                   ga_abocel.num_celular%TYPE;
  LN_num_abonado                                                   ga_abocel.num_abonado%TYPE;
  LV_cod_actabo                                                    ga_actabo.cod_actabo%TYPE;

  LN_cod_cuenta                                                    ge_clientes.cod_cuenta%TYPE;

  LV_formatofec2                                                   ged_parametros.val_parametro%TYPE;
  LV_formatofec7                                                   ged_parametros.val_parametro%TYPE;

  LD_fecIngresoMov                                                 DATE;
  LV_fecIngresoMov                                                 VARCHAR2(20);

  LN_cod_retorno                                                   ga_transacabo.cod_retorno%TYPE;
  LV_des_cadena                                                    ga_transacabo.des_cadena%TYPE;
  LN_num_os                                                        pv_iorserv.num_os%TYPE;
  LN_max_intentos                                                  pv_iorserv.num_intentos%TYPE;
  LD_fec_actual                                                    DATE;
  fin_sinerror                                                     EXCEPTION;
  error_anul_solic_os                                      EXCEPTION;

BEGIN

         IF PV_OBTIENEINFO_ATLANTIDA_PG.PV_CLIENTEESATLANTIDA_FN(EN_cod_cliente) = CN_NO_ATLNTD THEN
                RAISE fin_sinerror;
         END IF;

         LD_fec_actual := SYSDATE;

         SELECT fec_hastallam  + (1/(24*60*60))
         INTO LD_fecIngresoMov
         FROM Fa_ciclfact
         WHERE cod_ciclo = EN_cod_ciclo
         AND LD_fec_actual BETWEEN fec_desdellam AND fec_hastallam;

         --Anular solcitud de orden de servicio si existiese...
         PV_BOLSAS_DINAMICAS_PG.PV_ANULAR_SOLICOS_ATLTD_PR( EN_cod_cliente,
                                                                                                                LD_fecIngresoMov,
                                                                                                                EV_cod_os,
                                                                                                                LN_cod_retorno );
         IF NOT LN_cod_retorno=0 THEN
                RAISE error_anul_solic_os;
         END IF;


         SELECT  ga_seq_transacabo.nextval
         INTO LN_num_transaccion FROM DUAL;

         SELECT a.num_abonado, a.num_celular
         INTO LN_num_abonado, LN_num_celular FROM ga_abocel a
         WHERE cod_cliente = EN_cod_cliente
         AND NOT EXISTS (SELECT 1
                     FROM   pvd_actuacion_situacion b
                     WHERE  b.cod_producto  = a.cod_producto
                     AND    b.cod_actabo    = EV_cod_actabo
                     AND    b.cod_situacion = a.cod_situacion)
         AND ROWNUM=1;

         SELECT val_parametro INTO LV_formatofec2
         FROM ged_parametros
         WHERE cod_producto = CN_cod_producto
         AND cod_modulo = 'GE'
         AND nom_parametro = 'FORMATO_SEL2';

         SELECT val_parametro INTO LV_formatofec7
         FROM ged_parametros
         WHERE cod_producto = CN_cod_producto
         AND cod_modulo = 'GE'
         AND nom_parametro = 'FORMATO_SEL7';


         LV_fecIngresoMov := TO_CHAR(LD_fecIngresoMov ,LV_formatofec2 || ' ' || LV_formatofec7);

          SELECT VALOR_TEXTO INTO LV_cod_actabo
          FROM GA_PARAMETROS_SIMPLES_VW
          WHERE NOM_PARAMETRO = 'ACTABO_CAMCARBASATL';

         SELECT cod_cuenta INTO LN_cod_cuenta FROM ge_clientes
         WHERE cod_cliente = EN_cod_cliente;

         PV_OOSS_BATCH_HIBRIDO_PG.PV_INSCRIBE_OOSS_PR( LN_num_transaccion,
                                                                                                   LN_num_celular,
                                                                                                   EV_cod_os,
                                                                                                   NVL(EV_usuario,USER),--EV_USUARIO,
                                                                                                   LN_num_abonado,
                                                                                                   EN_cod_cliente,
                                                                                                   LV_cod_actabo,
                                                                                                   EV_bdatos,
                                                                                                   CV_tipplanemp,
                                                                                                   EV_cod_plantarif,
                                                                                                   0,
                                                                                                   LN_cod_cuenta,
                                                                                                   LV_fecIngresoMov,
                                                                                                   NULL,
                                                                                                   NULL, --EV_TSUBJETO,
                                                                                                   'A',--EV_SUJETO,
                                                                                                   EV_modulo,
                                                                                                   EN_numtar );

        SELECT cod_retorno, des_cadena
        INTO LN_cod_retorno, LV_des_cadena
        FROM ga_transacabo WHERE num_transaccion = LN_num_transaccion;

        IF LN_cod_retorno = 0 THEN
           SN_cod_retorno := 0;
           SN_num_evento := 0;
           SV_mens_retorno := 'OK';
        ELSE
           SN_cod_retorno := LN_cod_retorno;
           SN_num_evento := 1;
           SV_mens_retorno := 'Error en llamada de pl PV_OOSS_BATCH_HIBRIDO_PG.PV_INSCRIBE_OOSS_PR: ' || LV_des_cadena;
        END IF;

EXCEPTION
                 WHEN error_anul_solic_os THEN
                   SN_cod_retorno := 4;
                   SN_num_evento := -1;
                   SV_mens_retorno := 'Error al intentar anular solicitud de orden de servicio: PV_BOLSAS_DINAMICAS_PG.PV_ANULAR_SOLICOS_ATLTD_PR.';
                 WHEN fin_sinerror THEN
                   SN_cod_retorno := 0;
                   SN_num_evento := 0;
                   SV_mens_retorno := 'OK';
                 WHEN OTHERS THEN
                          SN_cod_retorno := 4;
                          SN_num_evento := 0;
                          SV_mens_retorno := SQLERRM;
END PV_INSCOS_CAMCARBASATLACICL_PR;

FUNCTION PV_CNSLTA_CARBASICOCLTE_FN(
                                                                                   EN_cod_cliente  IN                      ga_abocel.cod_cliente%TYPE,
                                                                                   ED_fecha                IN                      DATE
) RETURN fa_dctos_serv_rec_td.imp_cargo_basico%TYPE

IS

  LN_imp_cargo_basico                                                           fa_dctos_serv_rec_td.imp_cargo_basico%TYPE;
  LN_cod_retorno                        ge_errores_td.cod_msgerror%TYPE;
  LV_mens_retorno                       ge_errores_td.det_msgerror%TYPE;
  LN_num_evento                         ge_errores_pg.evento;

BEGIN
         FA_DCTO_CLTE_SN_PG.FA_CONS_CARGO_BASICO_CLTE(EN_cod_cliente,
                                                                                                NVL(ED_fecha,SYSDATE),
                                                                                                LN_imp_cargo_basico,
                                                                                                LN_cod_retorno,
                                                                                                LV_mens_retorno,
                                                                                                LN_num_evento );

        IF LN_cod_retorno = 0 THEN
           RETURN LN_imp_cargo_basico;
        ELSIF LN_cod_retorno = CN_cod_ret_no_found THEN
           RETURN -1;
        ELSE
                 RETURN -LN_num_evento;
        END IF;

END PV_CNSLTA_CARBASICOCLTE_FN;

PROCEDURE PV_ANULAR_SOLICOS_ATLTD_PR(EN_cod_cliente             IN ga_abocel.cod_cliente%TYPE,
                                                                        ED_fec_anul                     IN DATE,
                                                                        EV_cod_os                       IN pv_iorserv.cod_os%TYPE,
                                                                        SN_cod_retorno          OUT NOCOPY ge_errores_td.cod_msgerror%TYPE)
IS

LN_max_intentos                                                                         NUMBER;
LN_num_os                                                                                       pv_iorserv.num_os%TYPE;

--Anular solicitud de movimiento pendiente si existiese
BEGIN
        SELECT val_parametro
        INTO  LN_max_intentos
        FROM ged_parametros
        WHERE nom_parametro = 'MAX_INTENTOS'
        AND cod_producto = 1
        AND cod_modulo = 'GA';

          SELECT a.num_os INTO LN_num_os
          FROM pv_camcom a, pv_iorserv b, pv_prog c
                  WHERE a.cod_cliente = EN_cod_cliente
          AND b.cod_os = EV_cod_os
          AND a.num_os = b.num_os
          AND a.num_os = c.num_os
          AND c.f_prorroga = ED_fec_anul
          AND a.fec_vencimiento = ED_fec_anul
          AND b.fh_ejecucion = ED_fec_anul
          AND NVL(num_intentos,0) < LN_max_intentos;

        UPDATE pv_iorserv
        SET num_intentos = LN_max_intentos,
        status = 'ANULADA'
        WHERE num_os  = LN_num_os;

        UPDATE pv_erecorrido
        SET     tip_estado=4,
        fec_ingestado = sysdate
        WHERE num_os  = LN_num_os;

        SN_cod_retorno :=0;

EXCEPTION
                   WHEN NO_DATA_FOUND THEN
                                SN_cod_retorno := 0;
                   WHEN OTHERS THEN
                                SN_cod_retorno := 4;
END PV_ANULAR_SOLICOS_ATLTD_PR;

END PV_BOLSAS_DINAMICAS_PG;
/
SHOW ERRORS
