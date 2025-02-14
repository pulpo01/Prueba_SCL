CREATE OR REPLACE PACKAGE BODY Al_Pac_Kit IS

Procedure P_AL_GENERACION_KIT(
   v_cab_kit IN  AL_CAB_AGREDES_KIT%ROWTYPE) IS

   v_sequence  AL_MOVIMIENTOS.num_movimiento%TYPE;
   v_num_linea AL_LIN_AGREDES_KIT.num_lin%TYPE;
   v_const_unidad         PLS_INTEGER;
   v_tip_movimiento10     PLS_INTEGER;
   v_tip_movimiento61     PLS_INTEGER;
   v_cod_trans_gen        PLS_INTEGER;


   GD_fecha         DATE;

   -- Datos de la cabecera de la orden Cerrada
   CURSOR Cabecera(TN_num_gen_kit AL_CAB_AGREDES_KIT.num_gen_kit%TYPE,
                   CN_cero PLS_INTEGER)
   IS
   SELECT num_serie_kit
   FROM   AL_LIN_AGREDES_KIT
   WHERE  num_gen_kit = TN_num_gen_kit
     AND (num_ingpar = (SELECT MAX(num_ingpar)
                  FROM AL_LIN_AGREDES_KIT
                     WHERE num_gen_kit = TN_num_gen_kit) OR num_ingpar = CN_cero);

   -- Datos de los componentes de la orden a traspasar
 CURSOR Componentes
 IS
 SELECT d.num_serie_kit, a.num_gen_kit,v_cab_kit.cod_kit, a.num_lin, a.cod_articulo, a.tip_stock,
        a.cod_uso, a.cod_estado, a.can_articulo, c.ind_seriado, v_cab_kit.cod_bodega
 FROM   AL_LIN_COMP_AGREDES_KIT a, AL_ARTICULOS c, AL_LIN_AGREDES_KIT d
 WHERE  a.num_gen_kit = v_cab_kit.num_gen_kit
 AND    a.num_gen_kit = d.num_gen_kit
 AND    a.num_lin = d.num_lin
 AND    a.cod_articulo = c.cod_articulo
 AND    (d.num_ingpar = (SELECT MAX(num_ingpar)
                      FROM AL_LIN_COMP_AGREDES_KIT
                   WHERE num_gen_kit = v_cab_kit.num_gen_kit) OR d.num_ingpar = CN_cero);

    CURSOR Componentes_y_series IS
 SELECT f.num_serie_kit,a.num_gen_kit,v_cab_kit.cod_kit cod_kit,a.num_lin, a.cod_articulo, a.tip_stock,
        a.cod_uso, a.cod_estado, 1 can_articulo, b.ind_seriado, c.num_serie ,v_cab_kit.cod_bodega cod_bodega,
        g.num_desde,g.cap_code, g.cod_cat, g.cod_central, g.cod_producto, g.cod_subalm, g.ind_telefono,
        g.num_sec_loca, g.num_seriemec, g.num_telefono, g.prc_compra,g.PLAN,g.carga, g.cod_hlr
 FROM   AL_LIN_COMP_AGREDES_KIT a, AL_ARTICULOS b,
        AL_SER_AGREDES_KIT c ,AL_LIN_AGREDES_KIT f, AL_SERIES g
 WHERE  a.num_gen_kit = v_cab_kit.num_gen_kit
 AND    a.num_gen_kit = f.num_gen_kit
 AND    a.num_lin = v_num_linea
 AND    a.cod_articulo = b.cod_articulo
 AND    b.cod_articulo = c.cod_articulo
 AND    c.num_serie = g.num_serie
 AND    a.num_gen_kit = c.num_gen_kit
 AND    a.num_lin = c.num_lin
 AND    a.num_lin = f.num_lin
 AND    b.ind_seriado = 1 ;


BEGIN
      v_const_unidad:=1;
      ----------------------------------------------------------------------------------------------------------------------------------
      -- PARAMETRO GENERAL ENTRADA MERCADERIA
      SELECT val_parametro
      INTO v_tip_movimiento10
      FROM   GED_PARAMETROS
      WHERE  cod_modulo= CV_modulo
      AND    cod_producto = CN_producto
      AND    nom_parametro = CV_paramENTMerc;

      -- PARAMETRO GENERAL SALIDA POR GEN KIT(v_tip_movimiento61)
      SELECT val_parametro
      INTO v_tip_movimiento61
      FROM   GED_PARAMETROS
      WHERE  cod_modulo= CV_modulo
      AND    cod_producto = CN_producto
      AND    nom_parametro = CV_paramSALGenKit;

   -- PARAMETRO GENERAL CODIGO DE TRANSACCION GENERACION
      SELECT val_parametro
      INTO   v_cod_trans_gen
      FROM GED_PARAMETROS
      WHERE   cod_modulo=CV_modulo
      AND    cod_producto = CN_producto
      AND    nom_parametro = CV_paramTransGenKit;

      FOR CC IN Cabecera(v_cab_kit.num_gen_kit,CN_cero) LOOP
        SELECT al_seq_mvto.NEXTVAL
        INTO v_sequence
        FROM dual;

   GD_fecha :=SYSDATE;
        -- insercion de Movimiento de ENTRADA , POR SERIESERIE KIT
        -- movimiento 61(Salida por Generacion de KIT)
        INSERT INTO AL_MOVIMIENTOS
   (num_movimiento,tip_movimiento,fec_movimiento,tip_stock,cod_bodega,cod_articulo,cod_uso,cod_estado,num_cantidad,
         cod_estadomov,nom_usuarora,num_serie,prc_unidad,num_transaccion,cod_producto,ind_telefono,cod_transaccion)
        VALUES(v_sequence,v_tip_movimiento10,GD_fecha,v_cab_kit.tip_stock,v_cab_kit.cod_bodega,v_cab_kit.cod_kit,
          v_cab_kit.cod_uso,v_cab_kit.cod_estado,v_const_unidad,CV_estado_movSO,USER,cc.num_serie_kit,v_cab_kit.prc_unidad,
    v_cab_kit.num_gen_kit,v_const_unidad,CN_cero,v_cod_trans_gen);

      END LOOP;
      ----------------------------------------------------------------------------------------------------------------------------------
        FOR CC1 IN Componentes LOOP
                v_num_linea:= CC1.num_lin;
          IF CC1.ind_seriado = 0 THEN
             SELECT al_seq_mvto.NEXTVAL
          INTO v_sequence
          FROM dual;
        -- insercion de Movimiento de salida de componentes 'NO SERIADOS' AGRUPADOS POR CANTIDAD
        -- movimiento 61(Salida por Generacion de KIT)
             INSERT INTO AL_MOVIMIENTOS(num_movimiento  , tip_movimiento    , fec_movimiento ,
                 tip_stock  , cod_bodega     , cod_articulo   ,
                 cod_uso   , cod_estado     ,  num_cantidad   ,
                 cod_estadomov  , nom_usuarora     , num_serie      ,
                 num_transaccion  , cod_producto     ,  ind_telefono,
                 cod_transaccion  )
           VALUES( v_sequence  , v_tip_movimiento61, SYSDATE  ,
                   CC1.tip_stock  ,CC1.cod_bodega     , CC1.cod_articulo,
                   CC1.cod_uso  ,CC1.cod_estado     ,  CC1.can_articulo,
                    CV_estado_movSO  ,     USER     ,  NULL ,
                   CC1.num_gen_kit  ,   v_const_unidad  ,  CN_cero ,
                   v_cod_trans_gen  );
        -- insercion de componentes NO SERIADOS  en  Al_componente_kit.
             INSERT INTO AL_COMPONENTE_KIT(num_kit  , cod_kit     ,  cod_Articulo ,
                    num_serie  , can_articulo     ,  cod_bodega ,
                    tip_stock  , cod_uso     ,  cod_estado ,
                    fec_entrada  , num_sec_loca     , num_desde ,
               cod_producto  , ind_telefono      )
           VALUES(CC1.num_serie_kit , CC1.cod_kit  ,  CC1.cod_Articulo,
               CN_cero   , CC1.can_articulo,  CC1.cod_bodega ,
               CC1.tip_stock , CC1.cod_uso  ,  CC1.cod_estado ,
               SYSDATE  , NULL   , CN_cero  ,
               v_const_unidad,CN_cero);
         ELSE
      ----------------------------------------------------------------------------------------------------------------------------------
           FOR CC2 IN Componentes_y_Series LOOP
              SELECT al_seq_mvto.NEXTVAL
             INTO v_sequence
                     FROM dual;
         -- insercion de Movimiento de salida de componentes SERIADOS POR SERIE,
             INSERT INTO AL_MOVIMIENTOS(  num_movimiento   ,tip_movimiento,     fec_movimiento     ,
                     tip_stock      ,cod_bodega     , cod_articulo  ,
                               cod_uso       ,cod_estado     , num_cantidad  ,
                               cod_estadomov    ,nom_usuarora     , num_serie          ,
                        num_transaccion  ,cod_producto     , ind_telefono  ,
                        cod_transaccion  ,cod_hlr,           num_telefono,
                  cod_subalm,       cod_central,        cod_cat)
             VALUES(v_sequence , v_tip_movimiento61, SYSDATE          ,
                     CC2.tip_stock ,CC2.cod_bodega     , CC2.cod_articulo   ,
                     CC2.cod_uso ,CC2.cod_estado     , v_const_unidad     ,
                      CV_estado_movSO , USER     ,CC2.num_serie  ,
                     CC2.num_gen_kit ,v_const_unidad     , CN_cero           ,
                     v_cod_trans_gen,CC2.cod_hlr,CC2.num_telefono,
               CC2.cod_subalm,CC2.cod_central,CC2.cod_cat);
         -- insercion de componentes SERIADOS  en  Al_componente_kit.
             INSERT INTO AL_COMPONENTE_KIT( num_kit ,cod_kit   ,cod_Articulo  ,
                   num_serie ,can_articulo   , cod_bodega  ,
                                 tip_stock ,cod_uso   , cod_estado  ,
                                 num_desde ,fec_entrada   ,ind_telefono  ,
                                 cap_code ,num_telefono   , num_seriemec ,
                       prc_compra ,cod_producto   ,cod_central  ,
                       cod_subalm ,cod_cat   , num_sec_loca ,
                       PLAN  ,carga , cod_hlr  )
             VALUES(CC2.num_serie_kit,CC2.cod_kit   ,CC2.cod_Articulo ,
                 CC2.num_serie ,CC2.can_articulo ,CC2.cod_bodega ,
                            CC2.tip_stock ,CC2.cod_uso   , CC2.cod_estado ,
                            CC2.num_desde ,SYSDATE   ,CC2.ind_telefono ,
                            CC2.cap_code ,CC2.num_telefono , CC2.num_seriemec ,
                       CC2.prc_compra,CC2.cod_producto, CC2.cod_central ,
                       CC2.cod_subalm,CC2.cod_cat   , CC2.num_sec_loca ,
                       CC2.PLAN ,CC2.carga ,CC2.cod_hlr);
          END LOOP;
      ----------------------------------------------------------------------------------------------------------------------------------
         END IF;
        END LOOP;
      ----------------------------------------------------------------------------------------------------------------------------------
EXCEPTION
          WHEN NO_DATA_FOUND THEN
         RAISE_APPLICATION_ERROR (-20003,'TMError:' || 'SIN DATOS TABLA' );
          WHEN OTHERS THEN
         RAISE_APPLICATION_ERROR (-20002,'TMError:' || TO_CHAR(SQLCODE) || SQLERRM || ' ERROR GENERICO KIT');
END P_AL_GENERACION_KIT;
--
Procedure P_AL_DESVINCULACION_KIT(
v_cab_kit IN  AL_CAB_AGREDES_KIT%ROWTYPE) IS
v_sequence  AL_MOVIMIENTOS.num_movimiento%TYPE;
v_const_unidad         PLS_INTEGER;
v_tip_movimiento62     PLS_INTEGER;
v_tip_movimiento63     PLS_INTEGER;
v_cod_trans_desv       PLS_INTEGER;
v_pmp_art              al_pmp_articulo.prec_pmp%type;
-- Datos de la cabecera de la orden Cerrada
CURSOR Cabecera IS
        SELECT  a.num_gen_kit,a.num_serie_kit, c.cod_uso, c.cod_estado, c.tip_stock, c.cod_articulo,
          c.num_telefono, c.cod_subalm
 FROM    AL_SERIES c, AL_LIN_AGREDES_KIT a
 WHERE   c.num_serie  = a.num_serie_kit
 AND     a.num_gen_kit =v_cab_kit.num_gen_kit
 AND (NUM_INGPAR = (SELECT MAX(NUM_INGPAR) FROM AL_LIN_AGREDES_KIT
    WHERE num_gen_kit = v_cab_kit.num_gen_kit) OR NUM_INGPAR = CN_cero);
-- Datos de los componentes de la orden a traspasar
CURSOR Componentes IS
        SELECT d.num_gen_kit,d.num_serie_kit,e.num_serie, c.ind_seriado,e.cod_kit, d.num_lin, e.cod_articulo, e.tip_stock,
               e.cod_uso, e.cod_estado, e.can_articulo, v_cab_kit.cod_bodega cod_bodega,
               e.num_telefono, e.num_sec_loca, e.PLAN, e.carga, e.cod_producto, e.ind_telefono,
      e.cod_central,e.cod_subalm,e.cod_cat,e.cod_hlr, e.prc_compra
 FROM   AL_ARTICULOS c, AL_LIN_AGREDES_KIT d, AL_COMPONENTE_KIT e
 WHERE  d.num_gen_kit = v_cab_kit.num_gen_kit
 AND    e.num_kit =  d.num_serie_kit
 AND    d.num_lin = d.num_lin
 AND    d.num_serie_kit = e.num_kit
 AND    e.cod_articulo = c.cod_articulo
 AND (d.NUM_INGPAR = (SELECT MAX(NUM_INGPAR) FROM AL_LIN_AGREDES_KIT
    WHERE num_gen_kit = v_cab_kit.num_gen_kit) OR NUM_INGPAR = CN_cero);
BEGIN
v_const_unidad:=1;
--PARAMETRO GENERAL TIPO DE MOVIMIENTO DESVINCULACION DE KIT
SELECT val_parametro
INTO v_tip_movimiento62
FROM   GED_PARAMETROS
WHERE  cod_modulo= CV_modulo
AND    cod_producto = CN_producto
AND    nom_parametro = CV_paramDesvinKit;
--PARAMETRO GENERAL TIPO DE MOVIMIENTO ENTRADA POR DESVINCULACION DE KIT(componente)
SELECT val_parametro
INTO v_tip_movimiento63
FROM   GED_PARAMETROS
WHERE  cod_modulo= CV_modulo
AND    cod_producto = CN_producto
AND    nom_parametro = CV_paramEntDesvKit;
-- PARAMETRO GENERAL CODIGO DE TRANSACCION DESVINCULACION
SELECT val_parametro
INTO   v_cod_trans_desv
FROM GED_PARAMETROS
WHERE   cod_modulo= CV_modulo
AND    cod_producto = CN_producto
AND    nom_parametro = CV_paramTransDesKit;
  FOR CC IN Cabecera LOOP
      SELECT al_seq_mvto.NEXTVAL
   INTO v_sequence
   FROM dual;
    INSERT INTO AL_MOVIMIENTOS(num_movimiento, tip_movimiento, fec_movimiento, tip_stock,cod_bodega,
          cod_articulo, cod_uso, cod_estado, num_cantidad, cod_estadomov, nom_usuarora,
          num_serie, num_transaccion,cod_producto,ind_telefono, cod_transaccion)
    VALUES(v_sequence,v_tip_movimiento62,SYSDATE,CC.tip_stock,v_cab_kit.cod_bodega,
     CC.cod_articulo, CC.cod_uso, CC.cod_estado,v_const_unidad,CV_estado_movSO,USER,
     cc.num_serie_kit,v_cab_kit.num_gen_kit,v_const_unidad,CN_cero,v_cod_trans_desv);
      END LOOP;
  FOR CC1 IN Componentes LOOP
              SELECT al_seq_mvto.NEXTVAL
    INTO v_sequence
    FROM dual;
    IF CC1.ind_seriado = CN_cero THEN
       -- Obtene el PMP del articulo no seriado.
        P_GET_PMP_ARTICULO(cc1.cod_articulo,v_pmp_art);
       INSERT INTO AL_MOVIMIENTOS(num_movimiento, tip_movimiento, fec_movimiento, tip_stock,cod_bodega,
       cod_articulo, cod_uso, cod_estado, num_cantidad, cod_estadomov, nom_usuarora,
      num_serie, num_transaccion, cod_transaccion, prc_unidad)
     VALUES( v_sequence, v_tip_movimiento63,SYSDATE, CC1.tip_stock,CC1.cod_bodega,
      CC1.cod_articulo, CC1.cod_uso, CC1.cod_estado, CC1.can_articulo, CV_estado_movSO, USER,
      NULL, CC1.num_gen_kit,v_cod_trans_desv, v_pmp_art);
   ELSE
       INSERT INTO AL_MOVIMIENTOS(num_movimiento, tip_movimiento, fec_movimiento, tip_stock,cod_bodega,
                   cod_articulo, cod_uso, cod_estado, num_cantidad, cod_estadomov, nom_usuarora,
           num_serie, num_transaccion,cod_producto, ind_telefono, num_telefono,
           num_sec_loca, PLAN, carga,cod_transaccion,cod_central,cod_subalm,cod_cat,cod_hlr, prc_unidad)
     VALUES(v_sequence, v_tip_movimiento63,SYSDATE, CC1.tip_stock,CC1.cod_bodega,
           CC1.cod_articulo, CC1.cod_uso, CC1.cod_estado, v_const_unidad, CV_estado_movSO, USER,
           CC1.num_serie, CC1.num_gen_kit,CC1.cod_producto,CC1.ind_telefono, CC1.num_telefono,
           CC1.num_sec_loca, CC1.PLAN, CC1.carga,v_cod_trans_desv,
        CC1.cod_central,CC1.cod_subalm,CC1.cod_cat,CC1.cod_hlr, CC1.prc_compra);
   END IF;
  END LOOP;
EXCEPTION
          WHEN NO_DATA_FOUND THEN
         RAISE_APPLICATION_ERROR (-20003,'TMError:' || 'SIN DATOS TABLA' );
          WHEN OTHERS THEN
         RAISE_APPLICATION_ERROR (-20002,'TMError:' || TO_CHAR(SQLCODE) || SQLERRM || ' ERROR GENERICO KIT');
END P_AL_DESVINCULACION_KIT;

Procedure P_GET_PMP_ARTICULO(
v_cod_articulo IN  AL_ARTICULOS.cod_articulo%TYPE,
v_precio OUT  al_pmp_articulo.prec_pmp%TYPE )
IS
sOperadora          al_pmp_articulo.cod_operadora_scl%TYPE;
v_cod_moneda        GE_MONEDAS.cod_moneda%TYPE;
v_cod_moneda_local  GE_MONEDAS.cod_moneda%TYPE;
v_precio_aux  AL_PDTE_CALCULO.prc_unidad%TYPE;
v_fecha             AL_PDTE_CALCULO.fec_movimiento%TYPE;
LN_cod_retorno      ge_errores_pg.CodError;
LV_mens_retorno     ge_errores_pg.MsgError;
LN_num_evento       ge_errores_pg.Evento;
BEGIN
-- Obtiene Operadora Local
LN_cod_retorno:=0;
LV_mens_retorno:=null;
LN_num_evento :=null;
sOperadora:=trim(GE_Obtiene_Operadora_Local_FN(LN_cod_retorno,LV_mens_retorno,LN_num_evento ));
-- Obtiene Csdigo de Moneda Local
Al_Pac_Validaciones.p_obtiene_moneda(v_cod_moneda_local);
-- Obtiene Precio del zltimo registro del PMP
SELECT  NVL(PREC_PMP,NULL)
INTO  v_precio
FROM al_pmp_articulo
WHERE  cod_articulo = v_cod_articulo
AND fec_periodo = (SELECT max(fec_periodo)  FROM al_pmp_articulo
                   WHERE  cod_articulo = v_cod_articulo
         AND cod_operadora_scl = sOperadora)
AND cod_operadora_scl = sOperadora;
-- Si el pmp es nulo se busca la orden de ingreso con fecha mayor de entrada para obtener el Precio
EXCEPTION
     WHEN NO_DATA_FOUND THEN
  BEGIN
      SELECT  NVL(SUM(PRC_UNIDAD + PRC_FF +PRC_ADIC),CN_cero),a.cod_moneda,a.fec_creacion
   INTO v_precio, v_cod_moneda , v_fecha
    FROM AL_CABECERA_ORDENES2 a, AL_LINEAS_ORDENES2 b
    WHERE a.num_orden = (SELECT MAX(c.num_orden) FROM AL_CABECERA_ORDENES2 c, AL_LINEAS_ORDENES2 d
                           WHERE c.num_orden = d.num_orden
                           AND d.cod_articulo = v_cod_articulo
                           AND c.cod_estado <> 'NU')
    AND a.num_orden = b.num_orden
    GROUP BY a.cod_moneda,a.fec_creacion;
      EXCEPTION
         WHEN OTHERS THEN
               BEGIN
        SELECT  NVL(SUM(PRC_UNIDAD + PRC_FF +PRC_ADIC),CN_cero),a.cod_moneda,a.fec_creacion
        INTO v_precio, v_cod_moneda , v_fecha
         FROM AL_HCABECERA_ORDENES2 a, AL_HLINEAS_ORDENES2 b
         WHERE a.num_orden = (SELECT MAX(c.num_orden) FROM AL_HCABECERA_ORDENES2 c, AL_HLINEAS_ORDENES2 d
                               WHERE c.num_orden = d.num_orden
                               AND d.cod_articulo = v_cod_articulo
                               AND c.cod_estado <> 'NU')
         AND a.num_orden = b.num_orden
         GROUP BY a.cod_moneda,a.fec_creacion;
                    EXCEPTION
              WHEN OTHERS THEN
            v_precio:=CN_cero;
           END;
     END;
   IF v_precio IS NULL  THEN
       v_precio:=CN_cero;
   ELSE
      IF v_precio <> CN_cero THEN
     IF v_cod_moneda_local <> v_cod_moneda THEN
    Al_Pac_Validaciones.P_Convertir_Precio(v_cod_moneda,v_cod_moneda_local,v_precio, v_precio_aux, v_fecha);
   v_precio := v_precio_aux;
   END IF;
      END IF;
 END IF;
END P_GET_PMP_ARTICULO;

Procedure P_AL_HISTORICO_KIT(
v_cab_kit IN  AL_CAB_AGREDES_KIT%ROWTYPE) IS
BEGIN
 INSERT INTO AL_CAB_AGREDES_KIT_TH
 (NUM_GEN_KIT,
 COD_KIT,
 COD_BODEGA,
 TIP_STOCK,
 COD_USO,
 COD_ESTADO,
 CAN_SOLI,
 PRC_UNIDAD,
 FEC_GENERA,
 COD_ESOL,
 DES_OBSERVACION,
 IND_AGREDES,
 NOM_USUARIO,
 IND_TELEFONO,
 COD_TECNOLOGIA,
 NUM_SERINICIAL,
 NUM_SERFINAL,
 USUARIO_CIERRE,
 FEC_CIERRE,
 ID_SECUENCIA,
 CAN_INGRESADA)
 VALUES
 (v_cab_kit.NUM_GEN_KIT,
 v_cab_kit.COD_KIT,
 v_cab_kit.COD_BODEGA,
 v_cab_kit.TIP_STOCK,
 v_cab_kit.COD_USO,
 v_cab_kit.COD_ESTADO,
 v_cab_kit.CAN_SOLI,
 v_cab_kit.PRC_UNIDAD,
 v_cab_kit.FEC_GENERA,
 v_cab_kit.COD_ESOL,
 v_cab_kit.DES_OBSERVACION,
 v_cab_kit.IND_AGREDES,
 v_cab_kit.NOM_USUARIO,
 v_cab_kit.IND_TELEFONO,
 v_cab_kit.COD_TECNOLOGIA,
 v_cab_kit.NUM_SERINICIAL,
 v_cab_kit.NUM_SERFINAL,
 v_cab_kit.USUARIO_CIERRE,
 v_cab_kit.FEC_CIERRE,
 v_cab_kit.ID_SECUENCIA,
 v_cab_kit.CAN_INGRESADA);

 INSERT INTO AL_LIN_AGREDES_KIT_TH
 SELECT * FROM AL_LIN_AGREDES_KIT
 WHERE  NUM_GEN_KIT = v_cab_kit.NUM_GEN_KIT;

 INSERT INTO AL_DETALLE_KIT_TH
 SELECT * FROM AL_DETALLE_KIT_TO
 WHERE  NUM_GEN_KIT = v_cab_kit.NUM_GEN_KIT;

 DELETE AL_LIN_AGREDES_KIT
 WHERE  NUM_GEN_KIT = v_cab_kit.NUM_GEN_KIT;

 DELETE AL_DETALLE_KIT_TO
 WHERE  NUM_GEN_KIT = v_cab_kit.NUM_GEN_KIT;

EXCEPTION
          WHEN NO_DATA_FOUND THEN
         RAISE_APPLICATION_ERROR (-20003,'TMError:' || 'SIN DATOS TABLA' );
          WHEN OTHERS THEN
         RAISE_APPLICATION_ERROR (-20002,'TMError:' || TO_CHAR(SQLCODE) || SQLERRM || ' ERROR GENERICO KIT');
END P_AL_HISTORICO_KIT;

FUNCTION AL_SERIE_KIT_FN (
  SV_serie  OUT AL_SERIES.num_serie%TYPE)
  RETURN PLS_INTEGER
/*
<NOMBRE> : AL_SERIE_KIT_FN.</NOMBRE>
<FECHACREA> : JUNIO 2004                                                                <FECHACREA/>
<MODULO > : ADMINISTRACION DE INVENTARIO.                                             </MODULO >
<AUTOR > : Marcela Lucero Rozas.                                                     </AUTOR >
<VERSION > : 01                                                                        </VERSION >
<DESCRIPCION>: Genera una nueva secuencia para un numero de serie de un Kit             </DESCRIPCION>
<FECHAMOD > : DD/MM/YYYY                                                                </FECHAMOD >
<DESCMOD > : Breve descripción de Modificación                                         </DESCMOD >
<ParamEntr> :                                                                           </ParamEntr>
<ParamSal > : SV_serie  Número de Serie de un Kit                                       </ParamEntr>
*/

IS
   PRAGMA AUTONOMOUS_TRANSACTION;

TF_actual AL_SERIES_KIT_TO.valor_actual%TYPE;
TF_maximo AL_SERIES_KIT_TO.valor_actual%TYPE;
SN_error PLS_INTEGER:=0;
CN_vigencia CONSTANT PLS_INTEGER:=0;
CN_uno CONSTANT PLS_INTEGER:=1;

BEGIN
     BEGIN
        SELECT valor_actual,
               valor_maximo,
               cod_prefijo || LTRIM(TO_CHAR(TO_NUMBER(valor_actual)+1,'00000000')) serie
        INTO TF_actual, TF_maximo, SV_serie
        FROM AL_SERIES_KIT_TO
        WHERE cod_vigencia = CN_vigencia
        FOR UPDATE;

  EXCEPTION
    WHEN OTHERS THEN
      SN_error:=5;
  END;

  IF SN_error=0 THEN
     IF (TF_actual + CN_uno <= TF_maximo) THEN
     BEGIN
              UPDATE AL_SERIES_KIT_TO
              SET valor_actual = valor_actual + CN_uno
              WHERE cod_vigencia =CN_vigencia ;
     COMMIT;
     EXCEPTION
            WHEN OTHERS THEN
            SN_error:=5; -- Error en generar serie de kit
     END;
  END IF;
  END IF;
RETURN SN_error;
END AL_SERIE_KIT_FN;


Procedure AL_GENERACION_AUTOMATICA_PR (
  EN_num_gen_kit IN AL_CAB_AGREDES_KIT.num_gen_kit%TYPE,
  EN_bodega  IN AL_SERIES.cod_bodega%TYPE,
  EN_kit  IN AL_SERIES.cod_articulo%TYPE,
  EN_stock  IN AL_SERIES.tip_stock%TYPE,
  EN_uso  IN AL_SERIES.cod_uso%TYPE,
  EN_estado  IN AL_SERIES.cod_estado%TYPE,
  EN_actuacion  IN AL_SERIES.ind_telefono%TYPE,
  EN_cantidad  IN AL_CAB_AGREDES_KIT.can_soli%TYPE,
  EN_precio IN AL_CAB_AGREDES_KIT.prc_unidad%TYPE,
  EV_obs IN AL_CAB_AGREDES_KIT.des_observacion%TYPE,
  EV_ind_agredes IN AL_CAB_AGREDES_KIT.ind_agredes%TYPE)
/*
<NOMBRE>  : AL_GENERACION_AUTOMATICA_FN.                                        </NOMBRE>
<FECHACREA>  : JUNIO 2004                                                          <FECHACREA/>
<MODULO > : ADMINISTRACION DE INVENTARIO.                                        </MODULO >
<AUTOR >  : Marcela Lucero Rozas.                                               </AUTOR >
<VERSION >  : 01                                                                  </VERSION >
<DESCRIPCION>: Realiza la Generación Kit, para la opción Generación Automática     </DESCRIPCION>
<FECHAMOD >  : DD/MM/YYYY                                                          </FECHAMOD >
<DESCMOD >  : Breve descripción de Modificación                                   </DESCMOD >
<ParamEntr>  : EN_num_gen_kit Número de la Orden                                   </ParamEntr>
<ParamEntr>  : EN_bodega Código de Bodega                                          </ParamEntr>
<ParamEntr>  : EN_Kit Código de Kit                                                </ParamEntr>
<ParamEntr>  : EN_stock  Tipo de Stock                                             </ParamEntr>
<ParamEntr>  : EN_uso  Código de Uso                                               </ParamEntr>
<ParamEntr>  : EN_estado  Código Estado                                            </ParamEntr>
<ParamEntr>  : EN_actuacion  Indicador de telefóno                                 </ParamEntr>
<ParamEntr>  : EN_cantidad  Cantidad de Kit a generar                              </ParamEntr>
<ParamEntr>  : EN_precio  Precio del Kit                                           </ParamEntr>
<ParamEntr>  : EV_obs  Observación de la generación                                </ParamEntr>
<ParamEntr>  : EV_ind_agredes  Indicador de Generación/Desvinculación              </ParamEntr>
<ParamSal >  :                                                                     </ParamEntr>
*/
IS
   CURSOR c_plantillaKit(TN_kit AL_PLANTILLAS_KIT.cod_kit%TYPE) IS
   SELECT a.cod_articulo, can_articulo,
          b.ind_seriado,b.ind_equiacc,b.tip_terminal, 0 stock
   FROM AL_PLANTILLAS_KIT a, AL_ARTICULOS b
   WHERE a.cod_articulo=b.cod_articulo
   AND cod_kit=TN_kit;
   TYPE ComponenteKit IS TABLE OF c_plantillaKit%ROWTYPE;
   ComponentesKit ComponenteKit:=ComponenteKit();

   TV_ind_proceso AL_PROCESOS_MASIVOS_TO.ind_proceso%TYPE:=0;
   TV_terminal AL_ARTICULOS.tip_terminal%TYPE;
   TN_nro_linea AL_LIN_AGREDES_KIT.num_lin%TYPE:=0;
   TN_can_kit AL_CAB_AGREDES_KIT.can_ingresada%TYPE;
   TN_canser AL_CAB_AGREDES_KIT.can_ingresada%TYPE;
   TN_contadorKit AL_CAB_AGREDES_KIT.can_soli%TYPE:=0;
   TN_serie_kit AL_LIN_AGREDES_KIT.num_serie_kit%TYPE;
   TN_num_orden AL_CAB_AGREDES_KIT.num_gen_kit%TYPE;
   GN_IndiceCK AL_CAB_AGREDES_KIT.can_soli%TYPE:=0;
   TN_CantSeriesLin AL_CAB_AGREDES_KIT.can_soli%TYPE:=0;
   TN_CantSeriesIng AL_CAB_AGREDES_KIT.can_soli%TYPE:=0;

   GN_error PLS_INTEGER:=0;
   GN_GrabaErr PLS_INTEGER:=0;
   GD_genera DATE;

   CN_estado_sol CONSTANT AL_CAB_AGREDES_KIT.cod_esol%TYPE:=0;
   CN_seriado CONSTANT PLS_INTEGER:=1;
   CN_noseriado CONSTANT PLS_INTEGER:=0;
   CN_sintelefono CONSTANT PLS_INTEGER:=0;
   CN_cero CONSTANT PLS_INTEGER:=0;
   CN_uno CONSTANT PLS_INTEGER:=1;
   CV_equipo CONSTANT VARCHAR2(1):='E';
   CV_accesorio CONSTANT VARCHAR2(1):='A';

BEGIN
     BEGIN
         SELECT val_parametro
      INTO TV_ind_proceso
      FROM GED_PARAMETROS
      WHERE nom_parametro=CV_paramGen
        AND cod_modulo=CV_modulo
        AND cod_producto=CN_producto;
  EXCEPTION
    WHEN OTHERS THEN
      GN_error:=1; --Problemas de Parametros
      al_proceso_erroreskit_pr(TV_ind_proceso,EN_num_gen_kit,EN_kit,EN_kit,CN_uno,GN_error,CV_paramGen,CN_cero);
  END;

  IF GN_error = CN_cero THEN
     al_valida_automatico_pr(TV_ind_proceso,EN_num_gen_kit,EN_bodega,EN_kit,EN_stock,EN_uso,EN_estado,EN_actuacion,EN_cantidad,GN_error);

        IF GN_error<>CN_cero THEN
    al_proceso_erroreskit_pr(TV_ind_proceso,EN_num_gen_kit,EN_kit,EN_kit,CN_uno,GN_error,NULL,CN_cero);
  ELSE
     BEGIN
             SELECT val_parametro
             INTO TV_terminal
             FROM GED_PARAMETROS
             WHERE nom_parametro=CV_paramTer
               AND cod_modulo=CV_modulo
               AND cod_producto=CN_producto;

       GD_genera:=SYSDATE;
        EXCEPTION
           WHEN OTHERS THEN
                GN_error:=1; --Problemas de Parametros
                   al_proceso_erroreskit_pr(TV_ind_proceso,EN_num_gen_kit,EN_kit,EN_kit,CN_uno,GN_error,CV_paramTer,CN_cero);
        END;

        IF GN_error = CN_cero THEN
           BEGIN
            INSERT INTO AL_CAB_AGREDES_KIT
            (num_gen_kit,cod_kit,cod_bodega,tip_stock,cod_uso,cod_estado,can_soli,prc_unidad,fec_genera,cod_esol,des_observacion,nom_usuario,ind_agredes,ind_telefono)
            VALUES
            (EN_num_gen_kit,EN_kit,EN_bodega,EN_stock,EN_uso,EN_estado,EN_cantidad,EN_precio,GD_genera,CN_estado_sol,EV_obs,USER,EV_ind_agredes,EN_actuacion);

         SELECT num_gen_kit
        INTO TN_num_orden
        FROM AL_CAB_AGREDES_KIT
        WHERE num_gen_kit=EN_num_gen_kit
       FOR UPDATE NOWAIT;

        EXCEPTION
              WHEN OTHERS THEN
                GN_error:=3; -- Error en generar cabecera de la Orden
                      al_proceso_erroreskit_pr(TV_ind_proceso,EN_num_gen_kit,EN_kit,EN_kit,CN_uno,GN_error,NULL,CN_cero);
        END;
           IF GN_error = CN_cero THEN
        BEGIN
            FOR RW_cur IN c_plantillaKit(EN_kit) LOOP
                         ComponentesKit.EXTEND;
                         ComponentesKit(ComponentesKit.COUNT):=RW_cur;
                     END LOOP;
       EXCEPTION
       WHEN OTHERS THEN
             GN_error:=4; --Recupero Plantilla
       al_proceso_erroreskit_pr(TV_ind_proceso,EN_num_gen_kit,EN_kit,EN_kit,CN_uno,GN_error,NULL,CN_cero);
                END;
    IF GN_error = CN_cero THEN

       FOR TN_contadorKit IN 1..EN_cantidad LOOP
              TN_nro_linea:=TN_nro_linea+1;
        GN_error:=AL_SERIE_KIT_FN(TN_serie_kit);

           IF GN_error <> CN_cero THEN
           al_proceso_erroreskit_pr(TV_ind_proceso,EN_num_gen_kit,EN_kit,EN_kit,CN_uno,GN_error,NULL,CN_cero);
        EXIT;
        ELSE
             BEGIN
                INSERT INTO AL_LIN_AGREDES_KIT
             (num_gen_kit, num_lin, num_serie_kit)
                VALUES
             (EN_num_gen_kit,TN_nro_linea,TN_serie_kit);
             EXCEPTION
           WHEN OTHERS THEN
             GN_error:=6; --Ingreso lineas de kit
       al_proceso_erroreskit_pr(TV_ind_proceso,EN_num_gen_kit,EN_kit,EN_kit,CN_uno,GN_error,NULL,CN_cero);
          EXIT;
             END;

          IF GN_error = CN_cero THEN
       BEGIN

           FOR GN_IndiceCK IN ComponentesKit.FIRST..ComponentesKit.LAST LOOP


           INSERT INTO AL_LIN_COMP_AGREDES_KIT
        (num_gen_kit,num_lin,cod_articulo,tip_stock,cod_uso,cod_estado,can_articulo)
        VALUES
        (EN_num_gen_kit,TN_nro_linea,ComponentesKit(GN_IndiceCK).cod_articulo,EN_stock,EN_uso,EN_estado,ComponentesKit(GN_IndiceCK).can_articulo);

            IF ComponentesKit(GN_IndiceCK).ind_seriado=CN_seriado THEN
               TN_canser:=ComponentesKit(GN_IndiceCK).can_articulo ;
         INSERT INTO AL_SER_AGREDES_KIT
              ( num_gen_kit,    num_lin,     cod_articulo,  num_serie,   num_sec_loca,   num_telefono,   PLAN,  carga,   ind_telefono)
         SELECT EN_num_gen_kit ,TN_nro_linea,c.cod_articulo,c.num_serie, c.num_sec_loca, c.num_telefono, c.PLAN,c.carga, c.ind_telefono
                                       FROM AL_SERIES c
                                       WHERE c.cod_articulo=ComponentesKit(GN_IndiceCK).cod_articulo
                                         AND c.cod_bodega=EN_bodega
                                         AND c.tip_stock=EN_stock
                                         AND c.cod_uso=EN_uso
                                         AND c.cod_estado=EN_estado
                                         AND c.ind_telefono=DECODE(ComponentesKit(GN_IndiceCK).ind_equiacc,CV_equipo,
                                                   DECODE(ComponentesKit(GN_IndiceCK).tip_terminal,TV_terminal,CN_sintelefono,
                                          DECODE(ind_telefono,EN_actuacion,ind_telefono,EN_actuacion)),CN_sintelefono)
                                         AND NOT EXISTS (SELECT 1 FROM AL_SER_AGREDES_KIT a , AL_CAB_AGREDES_KIT b
                                                   WHERE b.num_gen_kit=EN_num_gen_kit
               AND a.num_gen_kit = b.num_gen_kit
                                                         AND a.cod_articulo = c.cod_articulo
                                                         AND b.cod_esol = CN_cero
                                             AND a.num_serie=c.num_serie)
                                         AND ROWNUM <= TN_canser;
           TN_CantSeriesIng:=   TN_CantSeriesIng+TN_canser;
            END IF;
                            END LOOP;
       EXCEPTION
       WHEN OTHERS THEN
                   GN_error:=7; -- Ingreso de Componentes
          al_proceso_erroreskit_pr(TV_ind_proceso,EN_num_gen_kit,EN_kit,EN_kit,CN_uno,GN_error,NULL,CN_cero);
                EXIT;
       END ;
       ELSE
           EXIT;
          END IF;
        END IF;
       END LOOP;
       SELECT COUNT(num_serie)
       INTO TN_CantSeriesLin
       FROM AL_SER_AGREDES_KIT
       WHERE num_gen_kit=EN_num_gen_kit;

       IF TN_CantSeriesLin <> TN_CantSeriesIng THEN
          GN_error:=2;
       al_proceso_erroreskit_pr(TV_ind_proceso,EN_num_gen_kit,EN_kit,EN_kit,CN_uno,GN_error,NULL,CN_cero);
       END IF;
    END IF;
        END IF;
           END IF;
     END IF;
  END IF;


   --Libera espacio de memoria
   ComponentesKit.DELETE;
   DBMS_SESSION.FREE_UNUSED_USER_MEMORY;

END AL_GENERACION_AUTOMATICA_PR;

Procedure AL_VALIDA_AUTOMATICO_PR (
  EN_proceso IN AL_PROCESOS_MASIVOS_TO.ind_proceso%TYPE,
  EN_num_gen_kit IN AL_CAB_AGREDES_KIT.num_gen_kit%TYPE,
  EN_bodega  IN AL_SERIES.cod_bodega%TYPE,
  EN_kit  IN AL_SERIES.cod_articulo%TYPE,
  EN_stock  IN AL_SERIES.tip_stock%TYPE,
  EN_uso  IN AL_SERIES.cod_uso%TYPE,
  EN_estado  IN AL_SERIES.cod_estado%TYPE,
  EN_actuacion  IN AL_SERIES.ind_telefono%TYPE,
  EN_cantidad  IN AL_CAB_AGREDES_KIT.can_soli%TYPE,
  EN_error  IN OUT AL_PROCESOS_MASIVOS_TO.ind_error%TYPE)

/*
<NOMBRE> : AL_VALIDA_AUTOMATICO_FN.                                                  </NOMBRE>
<FECHACREA> : JUNIO 2004                                                                <FECHACREA/>
<MODULO > : ADMINISTRACION DE INVENTARIO.                                             </MODULO >
<AUTOR > : Marcela Lucero Rozas.                                                     </AUTOR >
<VERSION > : 01                                                                        </VERSION >
<DESCRIPCION>: Realiza la validación de datos para el proceso de Generación de Kit en   </DESCRIPCION>
<DESCRIPCION>: forma automática                                                         </DESCRIPCION>
<FECHAMOD > : DD/MM/YYYY                                                                </FECHAMOD >
<DESCMOD > : Breve descripción de Modificación                                         </DESCMOD >
<ParamEntr>  : EN_proceso Número asociado al proceso de Generación de Kit               </ParamEntr>
<ParamEntr>  : EN_num_gen_kit Número de la Orden                                        </ParamEntr>
<ParamEntr>  : EN_bodega Código de Bodega                                               </ParamEntr>
<ParamEntr>  : EN_Kit Código de Kit                                                     </ParamEntr>
<ParamEntr>  : EN_stock  Tipo de Stock                                                  </ParamEntr>
<ParamEntr>  : EN_uso  Código de Uso                                                    </ParamEntr>
<ParamEntr>  : EN_estado  Código Estado                                                 </ParamEntr>
<ParamEntr>  : EN_actuacion  Indicador de telefóno                                      </ParamEntr>
<ParamEntr>  : EN_cantidad  Cantidad de Kit a generar                                   </ParamEntr>
<ParamEntr> :  EN_error Número de Error encontrado                                      </ParamEntr>
*/

IS
   CURSOR c_stock(TN_kit AL_PLANTILLAS_KIT.cod_kit%TYPE) IS
   SELECT a.cod_articulo, can_articulo * EN_cantidad can_necesito,
          b.ind_seriado,b.ind_equiacc,b.tip_terminal, b.des_articulo
   FROM AL_PLANTILLAS_KIT a, AL_ARTICULOS b
   WHERE a.cod_articulo=b.cod_articulo
   AND cod_kit=TN_kit;
   RW_cur c_stock%ROWTYPE;

   TYPE StockKit IS TABLE OF c_stock%ROWTYPE;
   CompKit StockKit :=StockKit ();


   GN_retorno PLS_INTEGER:=0;
   GN_error PLS_INTEGER:=0;
   GN_GrabaErr PLS_INTEGER:=0;
   GN_Stock PLS_INTEGER:=1;
   GN_IndiceCK AL_CAB_AGREDES_KIT.can_soli%TYPE:=0;


   CN_seriado CONSTANT PLS_INTEGER:=1;
   CN_noseriado CONSTANT PLS_INTEGER:=0;
   CN_sintelefono CONSTANT PLS_INTEGER:=0;
   CN_cero CONSTANT PLS_INTEGER:=0;
   CN_uno CONSTANT PLS_INTEGER:=0;
   CV_accesorio CONSTANT VARCHAR2(1):='A';
   CV_equipo CONSTANT VARCHAR2(1):='E';


   TV_ofic AL_STOCK.cod_plaza%TYPE:='XX';
   TV_terminal AL_ARTICULOS.tip_terminal%TYPE;
   TN_can_articulos AL_STOCK.can_stock%TYPE;


BEGIN

     BEGIN
      FOR RW_cur1 IN c_stock(EN_kit) LOOP
           CompKit.EXTEND;
           CompKit(CompKit.COUNT):=RW_cur1;
         END LOOP;
  EXCEPTION
    WHEN OTHERS THEN
      GN_error:=4; --Recuperar Plantilla
     END;

     IF GN_error = CN_cero THEN
         BEGIN
        Al_Proc_Movto.p_obtener_oficina_default(TV_ofic);
           SELECT val_parametro
        INTO TV_terminal
        FROM GED_PARAMETROS
        WHERE nom_parametro=CV_paramTer
          AND cod_modulo=CV_modulo
          AND cod_producto=CN_producto;
      EXCEPTION
        WHEN OTHERS THEN
          GN_error:=1; --Problemas de Parametros
         END;
     END IF;

     IF GN_error = CN_cero THEN
    OPEN c_stock(EN_kit) ;
       LOOP
       FETCH c_stock INTO RW_cur;
          EXIT WHEN c_stock%NOTFOUND;
    GN_Stock:=CN_cero;

    IF GN_error = CN_cero THEN
        IF RW_cur.ind_seriado = CN_seriado THEN
           --Valida en al_series
           SELECT COUNT(num_serie)
           INTO TN_can_articulos
           FROM AL_SERIES
           WHERE cod_articulo=RW_cur.cod_articulo
             AND cod_bodega=EN_bodega
          AND tip_stock=EN_stock
          AND cod_uso=EN_uso
          AND cod_estado=EN_estado
          AND ind_telefono=DECODE(RW_cur.ind_equiacc,CV_equipo,
                           DECODE(RW_cur.tip_terminal,TV_terminal,CN_sintelefono,
                  DECODE(ind_telefono,EN_actuacion,ind_telefono,EN_actuacion)),CN_sintelefono);

          IF  TN_can_articulos < RW_cur.can_necesito THEN
             GN_error:=2; -- No hay suficiente stock
             EXIT;
          END IF;
        ELSE
            --Valida en al_stock
            BEGIN
                SELECT can_stock
                INTO TN_can_articulos
                FROM AL_STOCK
                WHERE cod_bodega=EN_bodega
                  AND tip_stock=EN_stock
               AND cod_articulo=RW_cur.cod_articulo
               AND cod_uso=EN_uso
               AND cod_estado=EN_estado
               AND cod_plaza=TV_ofic
               AND num_desde=CN_cero;
            EXCEPTION
               WHEN OTHERS THEN
               TN_can_articulos:=0;
            END;
                  IF TN_can_articulos < RW_cur.can_necesito THEN
               GN_error:=2; -- No hay suficiente stock
            EXIT;
            END IF;
        END IF;
    END IF;
    END LOOP;
    IF c_stock%isopen THEN
          CLOSE c_stock;
    END IF;

     END IF;
     EN_error:= GN_error;

   --Libera espacio de memoria
   CompKit.DELETE;
   DBMS_SESSION.FREE_UNUSED_USER_MEMORY;

END AL_VALIDA_AUTOMATICO_PR;


Procedure AL_GENKIT_DATA_PR(
  EN_proceso IN AL_PROCESOS_MASIVOS_TO.ind_proceso%TYPE,
  EN_num_gen_kit IN AL_CAB_AGREDES_KIT.num_gen_kit%TYPE,
  EN_bodega  IN AL_SERIES.cod_bodega%TYPE,
  EN_kit  IN AL_SERIES.cod_articulo%TYPE,
  EN_stock  IN AL_SERIES.tip_stock%TYPE,
  EN_uso  IN AL_SERIES.cod_uso%TYPE,
  EN_estado  IN AL_SERIES.cod_estado%TYPE)
/*
<NOMBRE> : AL_GENKIT_DATA_PR                                                         </NOMBRE>
<FECHACREA> : JUNIO 2004                                                                <FECHACREA/>
<MODULO > : ADMINISTRACION DE INVENTARIO.                                             </MODULO >
<AUTOR > : Marcela Lucero Rozas.                                                     </AUTOR >
<VERSION > : 01                                                                        </VERSION >
<DESCRIPCION>: Realiza la validación de los datos del archivo en el Proceso de          </DESCRIPCION>
<DESCRIPCION>: Generación de Kit a través de Carga Masiva                               </DESCRIPCION>
<FECHAMOD > : DD/MM/YYYY                                                                </FECHAMOD >
<DESCMOD > : Breve descripción de Modificación                                         </DESCMOD >
<ParamEntr>  : EN_proceso Número asociado al proceso de Generación de Kit               </ParamEntr>
<ParamEntr>  : EN_num_gen_kit Número de la Orden                                        </ParamEntr>
<ParamEntr>  : EN_bodega Código de Bodega                                               </ParamEntr>
<ParamEntr>  : EN_Kit Código de Kit                                                     </ParamEntr>
<ParamEntr>  : EN_stock  Tipo de Stock                                                  </ParamEntr>
<ParamEntr>  : EN_uso  Código de Uso                                                    </ParamEntr>
<ParamEntr>  : EN_estado  Código Estado                                                 </ParamEntr>
<ParamSal > :                                                                           </ParamEntr>
*/
IS

   CURSOR c_ArchKit (TN_proceso AL_PROCESOS_MASIVOS_TO.ind_proceso%TYPE,
                     TN_num_gen_kit AL_CAB_AGREDES_KIT.num_gen_kit%TYPE) IS
   SELECT num_proceso,nro_grupo,sec_reg,cod_articulo_ppal,can_solicitada,
          cod_articulo,num_serie,can_articulos,ind_telefono,ind_error,observaciones, 'N' repetida
   FROM AL_PROCESOS_MASIVOS_TO
   WHERE ind_proceso=TN_proceso
     AND num_proceso=TN_num_gen_kit
   ORDER BY sec_reg;

   CURSOR c_plantillaKit(TN_kit AL_PLANTILLAS_KIT.cod_kit%TYPE) IS
   SELECT a.cod_articulo, can_articulo,
          b.ind_seriado,b.ind_equiacc,b.tip_terminal,0 stock_acumulado
   FROM AL_PLANTILLAS_KIT a, AL_ARTICULOS b
   WHERE a.cod_articulo=b.cod_articulo
   AND cod_kit=TN_kit;

   TYPE ComponenteKit IS TABLE OF c_plantillaKit%ROWTYPE;
   CmptsKit ComponenteKit:=ComponenteKit();

   GN_error PLS_INTEGER:=0;
   GN_ret   PLS_INTEGER;
   GN_InPltK PLS_INTEGER:=0;


   CN_seriado CONSTANT PLS_INTEGER:=1;
   CN_sintelefono CONSTANT PLS_INTEGER:=0;
   CN_cero CONSTANT PLS_INTEGER:=0;
   CN_uno CONSTANT PLS_INTEGER:=1;
   CN_dos CONSTANT PLS_INTEGER:=2;
   CN_equipo CONSTANT VARCHAR2(1):='E';
   CN_repite CONSTANT VARCHAR2(1):='X';


   TN_ind_ser AL_ARTICULOS.ind_seriado%TYPE;
   TN_ind_equiacc AL_ARTICULOS.ind_equiacc%TYPE;
   TV_terminalKit    AL_ARTICULOS.tip_terminal%TYPE;
   TV_terminal    AL_ARTICULOS.tip_terminal%TYPE;
   TN_ind_telefono  AL_PROCESOS_MASIVOS_TO.ind_telefono%TYPE;
   TN_can_articulos AL_STOCK.can_stock%TYPE;
   TN_can_necesito  AL_STOCK.can_stock%TYPE;
   TN_stock_acum    AL_STOCK.can_stock%TYPE:=0;
   TV_serie  AL_SERIES.num_serie%TYPE;
   TV_ofic AL_STOCK.cod_plaza%TYPE:='XX';
   TN_serie_min AL_CAB_AGREDES_KIT.num_serinicial%TYPE;
   TN_serie_max AL_CAB_AGREDES_KIT.num_serfinal%TYPE;
   TN_serie_kit AL_LIN_AGREDES_KIT.num_serie_kit%TYPE:=NULL;
   TN_serie_num AL_LIN_AGREDES_KIT.num_serie_kit%TYPE;
   TN_telefono AL_SERIES.num_telefono%TYPE;


   FUNCTION AL_EXISTE_ART_FN (EC_Kit  ComponenteKit, TN_art AL_ARTICULOS.cod_articulo%TYPE)
   RETURN PLS_INTEGER
   IS
   GN_retorno PLS_INTEGER:=0;
   GN_indiceCK1 AL_PROCESOS_MASIVOS_TO.sec_reg%TYPE;
   BEGIN
       FOR GN_indiceCK1 IN EC_Kit.FIRST .. EC_Kit.LAST LOOP
         IF TN_art = EC_Kit(GN_indiceCK1).cod_articulo THEN
           GN_retorno:=GN_indiceCK1;
        EXIT;
         END IF;
       END LOOP;
   RETURN GN_retorno; -- 0:ERROR, <>0:OK
   END;
BEGIN

     BEGIN

      FOR RW_cur1 IN c_plantillaKit(EN_kit) LOOP
           CmptsKit.EXTEND;
           CmptsKit(CmptsKit.COUNT):=RW_cur1;
         END LOOP;

  EXCEPTION
    WHEN OTHERS THEN
        GN_error:=14; -- Recuperar Informacion Proceso
   al_proceso_erroreskit_pr(EN_proceso,EN_num_gen_kit,EN_kit,NULL,CN_uno,GN_error,NULL,CN_uno);
     END;

  BEGIN
      SELECT num_serinicial,num_serfinal
   INTO TN_serie_min,TN_serie_max
   FROM AL_CAB_AGREDES_KIT
   WHERE num_gen_kit=EN_num_gen_kit;
  EXCEPTION
     WHEN OTHERS THEN
     TN_serie_min:=CN_cero;
     TN_serie_max:=CN_cero;
  END;

     IF GN_error = CN_cero THEN
       BEGIN
            Al_Proc_Movto.p_obtener_oficina_default(TV_ofic);
              SELECT val_parametro
            INTO TV_terminal
            FROM GED_PARAMETROS
            WHERE nom_parametro=CV_paramTer
              AND cod_modulo=CV_modulo
              AND cod_producto=CN_producto;
       EXCEPTION
         WHEN OTHERS THEN
              GN_error:=1; --Problemas de Parametros
              al_proceso_erroreskit_pr(EN_proceso,EN_num_gen_kit,EN_kit,NULL,CN_uno,GN_error,CV_paramTer,CN_uno);
          END;

      IF GN_error = CN_cero THEN

   FOR RW_DatArch IN c_ArchKit(EN_proceso,EN_num_gen_kit) LOOP

        GN_error:=0;
     BEGIN
          TN_serie_num:=TO_NUMBER(RW_DatArch.num_serie);
     EXCEPTION
       WHEN OTHERS THEN
          GN_error:=25; -- Serie no numerica
                al_proceso_erroreskit_pr(EN_proceso,EN_num_gen_kit,EN_kit,RW_DatArch.cod_articulo,RW_DatArch.sec_reg,GN_error,NULL,CN_uno);
     END;

     IF GN_error = CN_cero THEN

            IF RW_DatArch.cod_articulo_ppal=RW_DatArch.cod_articulo THEN
            --Serie Kit
            IF NOT (TO_NUMBER(RW_DatArch.num_serie) >=TO_NUMBER(TN_serie_min) AND TO_NUMBER(RW_DatArch.num_serie) <=TO_NUMBER(TN_serie_max)) THEN
                  GN_error:=20; -- Serie de Kit No concuerda con Solcitud
                        al_proceso_erroreskit_pr(EN_proceso,EN_num_gen_kit,EN_kit,RW_DatArch.cod_articulo,RW_DatArch.sec_reg,GN_error,NULL,CN_uno);
               ELSE
                               TN_serie_kit:=NULL;
                   BEGIN

                        SELECT num_serie_kit
               INTO TN_serie_kit
                        FROM AL_LIN_AGREDES_KIT
                        WHERE num_gen_kit=EN_num_gen_kit
                           AND num_serie_kit=RW_DatArch.num_serie;

                       GN_error:=21; -- Serie de Kit ya fue ingresada en esta orden
                             al_proceso_erroreskit_pr(EN_proceso,EN_num_gen_kit,EN_kit,RW_DatArch.cod_articulo,RW_DatArch.sec_reg,GN_error,NULL,CN_uno);
                EXCEPTION
                  WHEN OTHERS THEN
                   NULL;
                END;

               END IF;
         ELSE
          --Componentes
                   GN_InPltK:=al_existe_art_fn(CmptsKit,RW_DatArch.cod_articulo);

          IF GN_InPltK= CN_cero THEN
                GN_error:=12;  --Articulo no esta en la plantilla
                      al_proceso_erroreskit_pr(EN_proceso,EN_num_gen_kit,EN_kit,RW_DatArch.cod_articulo,RW_DatArch.sec_reg,GN_error,NULL,CN_uno);
       ELSE
                    TN_ind_ser:=CmptsKit(GN_InPltK).ind_seriado;
                                TN_ind_equiacc:=CmptsKit(GN_InPltK).ind_equiacc ;
                                TV_terminalKit:=CmptsKit(GN_InPltK).tip_terminal;
                    TN_ind_telefono:=RW_DatArch.ind_telefono;

                    IF TN_ind_ser = CN_seriado THEN

                       BEGIN
              TV_serie:=NULL;
           TN_telefono :=NULL;
                                      SELECT c.num_serie,c.num_telefono
                       INTO  TV_serie, TN_telefono
                                      FROM AL_SERIES c
                                      WHERE c.num_serie=RW_DatArch.num_serie
                 AND c.cod_articulo=RW_DatArch.cod_articulo
                                      AND c.cod_bodega=EN_bodega
                                      AND c.tip_stock=EN_stock
                                      AND c.cod_uso=EN_uso
                                      AND c.cod_estado=EN_estado
                                      AND c.ind_telefono=DECODE(TN_ind_equiacc,CN_equipo,
                                                DECODE(TV_terminalKit,TV_terminal,CN_sintelefono,
                                       DECODE(ind_telefono,TN_ind_telefono,ind_telefono,TN_ind_telefono)),CN_sintelefono);

           IF (TN_ind_equiacc=CN_equipo) AND (TV_terminalKit<>TV_terminal) THEN
               IF (TN_ind_telefono > CN_cero) THEN
                 --Número de telefono debe existir
              IF NOT (TN_telefono<>CN_cero AND TN_telefono IS NOT NULL) THEN
                                            GN_error:=27;
                                      al_proceso_erroreskit_pr(EN_proceso,EN_num_gen_kit,EN_kit,RW_DatArch.cod_articulo,RW_DatArch.sec_reg,GN_error,NULL,CN_uno);
              END IF;
               END IF;
           END IF;

                                   EXCEPTION
                         WHEN OTHERS THEN
                                     GN_error:=16; -- No existe la serie  en Almacén
                               al_proceso_erroreskit_pr(EN_proceso,EN_num_gen_kit,EN_kit,RW_DatArch.cod_articulo,RW_DatArch.sec_reg,GN_error,NULL,CN_uno);
                       END ;

           IF GN_error = CN_cero THEN
                  BEGIN
             TV_serie:=NULL;
                                        SELECT num_serie
                INTO  TV_serie
                FROM AL_CAB_AGREDES_KIT b ,AL_SER_AGREDES_KIT a
                                        WHERE a.cod_articulo = RW_DatArch.cod_articulo
                                        AND a.num_gen_kit =EN_num_gen_kit
                                        AND b.cod_esol IN (CN_cero,  CN_dos)
                AND b.num_gen_kit = a.num_gen_kit  ;

                IF TV_serie IS NOT NULL THEN
                                         GN_error:=26; -- La serie ya fue ingresada en esta orden .
                                   al_proceso_erroreskit_pr(EN_proceso,EN_num_gen_kit,EN_kit,RW_DatArch.cod_articulo,RW_DatArch.sec_reg,GN_error,NULL,CN_uno);
                END IF;

                  EXCEPTION
                                         WHEN NO_DATA_FOUND THEN
                    NULL;
                  END;
           END IF;
                    ELSE
                              BEGIN
                                   SELECT can_stock
                                   INTO TN_can_articulos
                                   FROM AL_STOCK
                                   WHERE cod_bodega=EN_bodega
                                     AND tip_stock=EN_stock
                                  AND cod_articulo=RW_DatArch.cod_articulo
                                  AND cod_uso=EN_uso
                                  AND cod_estado=EN_estado
                                  AND cod_plaza=TV_ofic
                                  AND num_desde=CN_cero;
                              EXCEPTION
                                WHEN OTHERS THEN
                                 TN_can_articulos:=0;
                              END;
                     TN_can_necesito:=CmptsKit(GN_InPltK).can_articulo;
                     CmptsKit(GN_InPltK).stock_acumulado:=CmptsKit(GN_InPltK).stock_acumulado + TN_can_necesito;

                                    IF TN_can_articulos < TN_can_necesito THEN
                                     GN_error:=2; -- No hay suficiente stock
                               al_proceso_erroreskit_pr(EN_proceso,EN_num_gen_kit,EN_kit,RW_DatArch.cod_articulo,RW_DatArch.sec_reg,GN_error,NULL,CN_uno);
                                    ELSE
                         IF TN_can_articulos < CmptsKit(GN_InPltK).stock_acumulado THEN
                                        GN_error:=17; -- No alcanzó el stock
                                  al_proceso_erroreskit_pr(EN_proceso,EN_num_gen_kit,EN_kit,RW_DatArch.cod_articulo,RW_DatArch.sec_reg,GN_error,NULL,CN_uno);
                      END IF;
                        END IF;
                    END IF;
          END IF;
               END IF;
     END IF;
          END LOOP;
         END IF;
  END IF;
   --Libera espacio de memoria
   CmptsKit.DELETE;
   DBMS_SESSION.FREE_UNUSED_USER_MEMORY;
END AL_GENKIT_DATA_PR;

FUNCTION AL_GENKIT_FORMATO_FN(
  EN_proceso IN AL_PROCESOS_MASIVOS_TO.ind_proceso%TYPE,
  EN_num_gen_kit IN AL_CAB_AGREDES_KIT.num_gen_kit%TYPE,
  EN_kit AL_PLANTILLAS_KIT.cod_kit%TYPE,
  EN_tipo PLS_INTEGER)
  RETURN PLS_INTEGER
/*
<NOMBRE> : AL_GENKIT_FORMATO_PR                                                      </NOMBRE>
<FECHACREA> : JUNIO 2004                                                                <FECHACREA/>
<MODULO > : ADMINISTRACION DE INVENTARIO.                                             </MODULO >
<AUTOR > : Marcela Lucero Rozas.                                                     </AUTOR >
<VERSION > : 01                                                                        </VERSION >
<DESCRIPCION>: Realiza la validación de formato al archivo ingresado en el Proceso de   </DESCRIPCION>
<DESCRIPCION>: Generación de Kit a través de Carga Masiva                               </DESCRIPCION>
<FECHAMOD > : DD/MM/YYYY                                                                </FECHAMOD >
<DESCMOD > : Breve descripción de Modificación                                         </DESCMOD >
<ParamEntr>  : EN_proceso Número asociado al proceso de Generación de Kit               </ParamEntr>
<ParamEntr>  : EN_num_gen_kit Número de la Orden                                        </ParamEntr>
<ParamEntr>  : EN_Kit Código de Kit                                                     </ParamEntr>
<ParamEntr>  : EN_tipo  Indicador de Generación o Simulación y Carga                    </ParamEntr>
<ParamEntr>  : EN_tipo para la Generación toma valor cero (0)                           </ParamEntr>
<ParamEntr>  : EN_tipo para la Simulación y Carga toma valor cero (1)                   </ParamEntr>
<ParamSal > :                                                                           </ParamEntr>
*/
IS

   CURSOR c_plantillaKit(TN_kit AL_PLANTILLAS_KIT.cod_kit%TYPE) IS
   SELECT a.cod_articulo, can_articulo,
          b.ind_seriado,b.ind_equiacc,b.tip_terminal
   FROM AL_PLANTILLAS_KIT a, AL_ARTICULOS b
   WHERE a.cod_articulo=b.cod_articulo
   AND cod_kit=TN_kit;
   TYPE ComponenteKit IS TABLE OF c_plantillaKit%ROWTYPE;
   ComponentesKit ComponenteKit:=ComponenteKit();

   CURSOR c_ArchKit (TN_proceso AL_PROCESOS_MASIVOS_TO.ind_proceso%TYPE,
                     TN_num_gen_kit AL_CAB_AGREDES_KIT.num_gen_kit%TYPE) IS
   SELECT num_proceso,nro_grupo,sec_reg,can_solicitada,cod_articulo_ppal,cod_articulo,
          num_serie,can_articulos
   FROM AL_PROCESOS_MASIVOS_TO
   WHERE ind_proceso=TN_proceso
     AND num_proceso=TN_num_gen_kit
   ORDER BY sec_reg  ;

   TN_Grpkit AL_PROCESOS_MASIVOS_TO.nro_grupo%TYPE:=1;
   TN_RegLeidos AL_PROCESOS_MASIVOS_TO.sec_reg%TYPE:=0;
   TN_RegXGrp AL_PROCESOS_MASIVOS_TO.sec_reg%TYPE:=0;
   TN_IndGrp AL_PROCESOS_MASIVOS_TO.nro_grupo%TYPE:=1;
   TN_IndAnt AL_PROCESOS_MASIVOS_TO.nro_grupo%TYPE:=0;
   TN_Plantillakit AL_PROCESOS_MASIVOS_TO.can_articulos%TYPE:=0;
   TN_RegXKit AL_PROCESOS_MASIVOS_TO.sec_reg%TYPE:=0;

   GN_error PLS_INTEGER:=0;
   GN_IndiceCK PLS_INTEGER:=0;
   GN_FtoArch PLS_INTEGER:=0;
   GN_GrabaErr PLS_INTEGER:=0;

   CN_cero CONSTANT PLS_INTEGER:=0;
   CN_uno CONSTANT PLS_INTEGER:=1;
   CN_OK CONSTANT PLS_INTEGER:=0;
   CN_seriado CONSTANT PLS_INTEGER:=1;
   GN_FtoArchSim CONSTANT PLS_INTEGER:=1;

   FUNCTION AL_EXISTE_ART_FN (EC_Kit  ComponenteKit, TN_art AL_ARTICULOS.cod_articulo%TYPE)
   RETURN PLS_INTEGER
   IS
   GN_retorno PLS_INTEGER:=0;
   GN_indiceK  PLS_INTEGER:=0;
   BEGIN
       FOR GN_indiceK IN EC_Kit.FIRST .. EC_Kit.LAST LOOP
         IF TN_art = EC_Kit(GN_indiceK).cod_articulo THEN
           GN_retorno:=GN_indiceK;
        EXIT;
         END IF;
       END LOOP;
   RETURN GN_retorno; -- 0:ERROR, <>0:OK
   END;

BEGIN
     BEGIN
         FOR RW_cur IN c_plantillaKit(EN_kit) LOOP
           ComponentesKit.EXTEND;
           ComponentesKit(ComponentesKit.COUNT):=RW_cur;
     IF RW_cur.ind_seriado=CN_uno THEN
              TN_Plantillakit:= TN_Plantillakit + RW_cur.can_articulo; --Total de componentes que debe tener la plantilla
           ELSE
               TN_Plantillakit:= TN_Plantillakit + CN_uno  ;
           END IF;
         END LOOP;

     EXCEPTION
           WHEN OTHERS THEN
               GN_error:=4; --Recuperar Plantilla
          al_proceso_erroreskit_pr(EN_proceso,EN_num_gen_kit,EN_kit,EN_kit,CN_uno,GN_error,NULL,CN_uno);
     END;

     IF GN_error=CN_cero THEN

    FOR RW_DatArch IN c_ArchKit(EN_proceso,EN_num_gen_kit) LOOP

   TN_RegLeidos:=TN_RegLeidos+CN_uno;

         IF TN_IndGrp<>RW_DatArch.nro_grupo THEN
               TN_IndAnt:=(TN_RegLeidos - CN_uno);
      IF EN_tipo=CN_uno THEN
        TN_RegXKit:=TN_Plantillakit +1 ;
      ELSE
        TN_RegXKit:=TN_Plantillakit;
      END IF;
            IF MOD(TN_IndAnt,TN_RegXKit) = CN_cero THEN
            TN_IndGrp:=RW_DatArch.nro_grupo;
            TN_RegXGrp:=CN_cero;
            ELSE
            GN_error:=13; --Cantidad de registros por Kit no concuerda con registros de plantilla
            al_proceso_erroreskit_pr(EN_proceso,EN_num_gen_kit,EN_kit,RW_DatArch.cod_articulo,RW_DatArch.sec_reg,GN_error,NULL,CN_uno);
            EXIT;
            END IF;
         END IF;

            TN_RegXGrp:=TN_RegXGrp+CN_uno;

         IF RW_DatArch.cod_articulo_ppal<>EN_kit THEN
            GN_error:=9; --Codigo de Kit no concide
            al_proceso_erroreskit_pr(EN_proceso,EN_num_gen_kit,EN_kit,RW_DatArch.cod_articulo,RW_DatArch.sec_reg,GN_error,NULL,CN_uno);
               EXIT;
         END IF;

   IF EN_tipo=CN_uno AND TN_RegXGrp=CN_uno THEN

            IF RW_DatArch.cod_articulo_ppal=RW_DatArch.cod_articulo THEN
             GN_FtoArch:=GN_FtoArchSim;
      ELSE
       GN_error:=24;
             al_proceso_erroreskit_pr(EN_proceso,EN_num_gen_kit,EN_kit,RW_DatArch.cod_articulo,RW_DatArch.sec_reg,GN_error,NULL,CN_uno);
       EXIT;
      END IF;

   END IF;

         IF GN_FtoArch=GN_FtoArchSim AND TN_RegXGrp=CN_uno THEN

            IF RW_DatArch.cod_articulo_ppal=RW_DatArch.cod_articulo AND RW_DatArch.num_serie IS NULL THEN
            GN_error:=10; --Un seriado no tiene serie asociada
            al_proceso_erroreskit_pr(EN_proceso,EN_num_gen_kit,EN_kit,RW_DatArch.cod_articulo,RW_DatArch.sec_reg,GN_error,NULL,CN_uno);
            EXIT;
            END IF;

   ELSE

            GN_indiceCK:=al_existe_art_fn(ComponentesKit,RW_DatArch.cod_articulo);
            IF GN_indiceCK <> CN_OK THEN
                  IF ComponentesKit(GN_indiceCK).ind_seriado = CN_seriado THEN
               IF RW_DatArch.num_serie IS NULL THEN
                  GN_error:=10; --Un seriado no tiene serie asociada
            al_proceso_erroreskit_pr(EN_proceso,EN_num_gen_kit,EN_kit,RW_DatArch.cod_articulo,RW_DatArch.sec_reg,GN_error,NULL,CN_uno);
                  EXIT;
            END IF;
               ELSE
               IF RW_DatArch.num_serie IS NOT NULL THEN
                  GN_error:=11; --Un No seriado Tiene serie asociada
            al_proceso_erroreskit_pr(EN_proceso,EN_num_gen_kit,EN_kit,RW_DatArch.cod_articulo,RW_DatArch.sec_reg,GN_error,NULL,CN_uno);
                  EXIT;
            END IF;
            END IF;
          ELSE
             GN_error:=12; --Un articulo no concuerda con la plantilla
             al_proceso_erroreskit_pr(EN_proceso,EN_num_gen_kit,EN_kit,RW_DatArch.cod_articulo,RW_DatArch.sec_reg,GN_error,NULL,CN_uno);
             EXIT;
          END IF;

   END IF;

        END LOOP;
     END IF;
     IF GN_error<>CN_cero THEN
        --Se actualizan los Kit con errores
        al_errores_kit_pr( EN_proceso,EN_num_gen_kit,EN_kit,GN_error);
        --Se deja sólo los registros con errores.Error de Formato => se detiene el proceso
        DELETE  FROM AL_PROCESOS_MASIVOS_TO
        WHERE ind_proceso=EN_proceso
        AND num_proceso=EN_num_gen_kit
        AND ind_error =CN_cero;
     END IF;

   --Libera espacio de memoria
   ComponentesKit.DELETE;
   DBMS_SESSION.FREE_UNUSED_USER_MEMORY;

RETURN GN_error;
END AL_GENKIT_FORMATO_FN;

Procedure AL_PROCESO_ERRORESKIT_PR(
  EN_proceso IN AL_PROCESOS_MASIVOS_TO.ind_proceso%TYPE,
  EN_num_gen_kit IN AL_CAB_AGREDES_KIT.num_gen_kit%TYPE,
  EN_kit  IN AL_SERIES.cod_articulo%TYPE,
  EN_cod_art IN AL_PROCESOS_MASIVOS_TO.cod_articulo%TYPE,
  EN_sec_reg IN AL_PROCESOS_MASIVOS_TO.sec_reg%TYPE,
  EN_error IN AL_PROCESOS_MASIVOS_TO.ind_error%TYPE,
  EN_Obs   IN AL_PROCESOS_MASIVOS_TO.observaciones%TYPE,
  EN_tipo PLS_INTEGER,
  EN_serie IN AL_PROCESOS_MASIVOS_TO.num_serie%TYPE DEFAULT NULL,
  EN_cantidad IN AL_PROCESOS_MASIVOS_TO.can_solicitada%TYPE DEFAULT NULL)
/*
<NOMBRE> : AL_PROCESO_ERRORESKIT_PR                                                  </NOMBRE>
<FECHACREA> : JUNIO 2004                                                                <FECHACREA/>
<MODULO > : ADMINISTRACION DE INVENTARIO.                                             </MODULO >
<AUTOR > : Marcela Lucero Rozas.                                                     </AUTOR >
<VERSION > : 01                                                                        </VERSION >
<DESCRIPCION>: Modifica o inserta el indicador de error para los distintos procesos de  </DESCRIPCION>
<DESCRIPCION>: de Generación y/o Desvinculación                                         </DESCRIPCION>
<FECHAMOD > : DD/MM/YYYY                                                                </FECHAMOD >
<DESCMOD > : Breve descripción de Modificación                                         </DESCMOD >
<ParamEntr>  : EN_proceso Número asociado al proceso de Generación de Kit               </ParamEntr>
<ParamEntr>  : EN_num_gen_kit Número de la Orden                                        </ParamEntr>
<ParamEntr>  : EN_Kit Código de Kit                                                     </ParamEntr>
<ParamEntr>  : EN_cod_art Código de articulo de la componente del kit                   </ParamEntr>
<ParamEntr>  : EN_sec_reg Secuencia del registro para el error que se insertara         </ParamEntr>
<ParamEntr>  : EN_error Número de Error                                                 </ParamEntr>
<ParamEntr>  : EN_Obs Observación asoicada al Error                                     </ParamEntr>
<ParamEntr>  : EN_tipo  Indicador de Modificación o Inserción                           </ParamEntr>
<ParamEntr>  : EN_tipo para Insertar toma valor cero (0)                                </ParamEntr>
<ParamEntr>  : EN_tipo para Modiifcar toma valor cero (1)                               </ParamEntr>
<ParamEntr>  : EN_Serie Número de la Serie Erronea. Parámetro Opcional                  </ParamEntr>
<ParamEntr>  : EN_cantidad Cantidad solicitada. Parámetro Opcional                      </ParamEntr>
<ParamSal > :                                                                           </ParamEntr>
*/
IS
GN_error PLS_INTEGER:=0;
GV_FechaError VARCHAR2(15);
CN_cero CONSTANT PLS_INTEGER:=0;

BEGIN

     IF EN_tipo=CN_cero THEN
       IF  EN_Cantidad IS NULL THEN
       BEGIN
           INSERT INTO AL_PROCESOS_MASIVOS_TO
           (ind_proceso, num_proceso, sec_reg, cod_articulo_ppal, cod_articulo,num_serie,ind_error, observaciones)
           VALUES
           (EN_proceso,EN_num_gen_kit,EN_sec_reg,EN_kit,EN_cod_art,EN_serie,EN_error,EN_Obs);
           EXCEPTION
           WHEN OTHERS THEN
             NULL;
       END ;
  ELSE
    BEGIN
           INSERT INTO AL_PROCESOS_MASIVOS_TO
           (ind_proceso, num_proceso, sec_reg, cod_articulo_ppal,can_solicitada, cod_articulo,num_serie,ind_error, observaciones)
           VALUES
           (EN_proceso,EN_num_gen_kit,EN_sec_reg,EN_kit,EN_cantidad,EN_cod_art,EN_serie,EN_error,EN_Obs);
           EXCEPTION
           WHEN OTHERS THEN
             NULL;
       END ;
  END IF;
  ELSE
     BEGIN
       IF EN_kit IS NOT NULL THEN
           IF EN_cod_art IS NULL THEN
                     UPDATE AL_PROCESOS_MASIVOS_TO
            SET ind_error=EN_error
            WHERE ind_proceso=EN_proceso
              AND num_proceso=EN_num_gen_kit
              AND sec_reg=EN_sec_reg
              AND cod_articulo_ppal=EN_kit;
        ELSE
                     UPDATE AL_PROCESOS_MASIVOS_TO
            SET ind_error=EN_error
            WHERE ind_proceso=EN_proceso
              AND num_proceso=EN_num_gen_kit
              AND sec_reg=EN_sec_reg
              AND cod_articulo_ppal=EN_kit
              AND cod_articulo=EN_cod_art;
        END IF;
     ELSE
         UPDATE AL_PROCESOS_MASIVOS_TO
                   SET ind_error = EN_error
                WHERE ind_proceso = EN_proceso
                  AND num_proceso = EN_num_gen_kit
                  AND sec_reg   = EN_sec_reg
                     AND num_serie   = EN_serie;
     END IF;
  EXCEPTION
    WHEN OTHERS THEN
             NULL;
  END;
  END IF;
END AL_PROCESO_ERRORESKIT_PR;

Procedure AL_GENERACION_KIT_PR(
  EN_proceso IN AL_PROCESOS_MASIVOS_TO.ind_proceso%TYPE,
  EN_num_gen_kit IN AL_CAB_AGREDES_KIT.num_gen_kit%TYPE,
  EN_bodega  IN AL_SERIES.cod_bodega%TYPE,
  EN_kit  IN AL_SERIES.cod_articulo%TYPE,
  EN_stock  IN AL_SERIES.tip_stock%TYPE,
  EN_uso  IN AL_SERIES.cod_uso%TYPE,
  EN_estado  IN AL_SERIES.cod_estado%TYPE,
  EN_actuacion  IN AL_SERIES.ind_telefono%TYPE,
  EN_cantidad  IN AL_CAB_AGREDES_KIT.can_soli%TYPE,
  EN_precio IN AL_CAB_AGREDES_KIT.prc_unidad%TYPE,
  EV_obs IN AL_CAB_AGREDES_KIT.des_observacion%TYPE,
  EV_ind_agredes IN AL_CAB_AGREDES_KIT.ind_agredes%TYPE)
/*
<NOMBRE> : AL_GENERACION_KIT_PR                                                      </NOMBRE>
<FECHACREA> : JUNIO 2004                                                                <FECHACREA/>
<MODULO > : ADMINISTRACION DE INVENTARIO.                                             </MODULO >
<AUTOR > : Marcela Lucero Rozas.                                                     </AUTOR >
<VERSION > : 01                                                                        </VERSION >
<DESCRIPCION>: Realiza la Generación de Kit a través de la Carga Masiva                 </DESCRIPCION>
<FECHAMOD > : DD/MM/YYYY                                                                </FECHAMOD >
<DESCMOD > : Breve descripción de Modificación                                         </DESCMOD >
<ParamEntr>  : EN_proceso Número asociado al proceso de Generación de Kit               </ParamEntr>
<ParamEntr>  : EN_num_gen_kit Número de la Orden                                        </ParamEntr>
<ParamEntr>  : EN_bodega Código de Bodega                                               </ParamEntr>
<ParamEntr>  : EN_Kit Código de Kit                                                     </ParamEntr>
<ParamEntr>  : EN_stock  Tipo de Stock                                                  </ParamEntr>
<ParamEntr>  : EN_uso  Código de Uso                                                    </ParamEntr>
<ParamEntr>  : EN_estado  Código Estado                                                 </ParamEntr>
<ParamEntr>  : EN_actuacion  Indicador de telefóno                                      </ParamEntr>
<ParamEntr>  : EN_cantidad  Cantidad de Kit a generar                                   </ParamEntr>
<ParamEntr>  : EN_precio  Precio del Kit                                                </ParamEntr>
<ParamEntr>  : EV_obs  Observación de la generación                                     </ParamEntr>
<ParamEntr>  : EV_ind_agredes  Indicador de Generación/Desvinculación                   </ParamEntr>
<ParamSal > :                                                                           </ParamEntr>
*/
IS
   CURSOR c_ArchKit (TN_proceso AL_PROCESOS_MASIVOS_TO.ind_proceso%TYPE,
                     TN_num_gen_kit AL_CAB_AGREDES_KIT.num_gen_kit%TYPE,
      TN_ind_error AL_PROCESOS_MASIVOS_TO.ind_error%TYPE ) IS
   SELECT num_proceso,nro_grupo,sec_reg,cod_articulo_ppal,can_solicitada,
          cod_articulo,num_serie,can_articulos,ind_telefono,ind_error,observaciones
   FROM AL_PROCESOS_MASIVOS_TO
   WHERE ind_proceso=TN_proceso
     AND num_proceso=TN_num_gen_kit
  AND ind_error = TN_ind_error
   ORDER BY sec_reg;


   CURSOR c_plantillaKit(TN_kit AL_PLANTILLAS_KIT.cod_kit%TYPE) IS
   SELECT a.cod_articulo, can_articulo,
          b.ind_seriado,b.ind_equiacc,b.tip_terminal,0 stock_acumulado
   FROM AL_PLANTILLAS_KIT a, AL_ARTICULOS b
   WHERE a.cod_articulo=b.cod_articulo
   AND cod_kit=TN_kit;

   TYPE ComponenteKit IS TABLE OF c_plantillaKit%ROWTYPE;
   CmptsKit ComponenteKit:=ComponenteKit();

   CN_cero CONSTANT PLS_INTEGER:=0;
   CN_uno CONSTANT PLS_INTEGER:=1;
   CN_estado_sol CONSTANT AL_CAB_AGREDES_KIT.cod_esol%TYPE:=0;
   CV_serie CONSTANT VARCHAR2(1):='X';
   CN_producto CONSTANT PLS_INTEGER:=1;
   CN_equipo CONSTANT VARCHAR2(1):='E';

   TN_grp_act AL_PROCESOS_MASIVOS_TO.nro_grupo%TYPE:=1;
   TN_nro_linKit AL_LIN_AGREDES_KIT.num_lin%TYPE:=0;
   TN_serie_kit AL_LIN_AGREDES_KIT.num_serie_kit%TYPE;
   TN_serie_kitAnt AL_LIN_AGREDES_KIT.num_serie_kit%TYPE:=CV_serie;
   TN_sec_loca AL_SERIES.num_sec_loca%TYPE;
   TN_num_telefono AL_SERIES.num_telefono%TYPE;
   TN_plan AL_SERIES.PLAN%TYPE;
   TN_carga AL_SERIES.carga%TYPE;
   TN_ind_telefono AL_SERIES.ind_telefono%TYPE;
   TN_num_orden AL_CAB_AGREDES_KIT.num_gen_kit%TYPE;
   TN_nro_KitOK AL_CAB_AGREDES_KIT.can_soli%TYPE:=0;
   TN_sec_reg AL_PROCESOS_MASIVOS_TO.sec_reg%TYPE:=0;
   TN_ind_ser AL_ARTICULOS.ind_seriado%TYPE:=0;
   TN_can_articulo AL_PLANTILLAS_KIT.can_articulo%TYPE:=0;
   TV_terminal    AL_ARTICULOS.tip_terminal%TYPE;
   TV_terminalKit AL_ARTICULOS.tip_terminal%TYPE;
   TN_ind_equiacc AL_ARTICULOS.ind_equiacc%TYPE;

   GN_LinKit PLS_INTEGER:=0;
   GN_error PLS_INTEGER:=0;
   GN_KitOK PLS_INTEGER:=0;
   GN_ret   PLS_INTEGER;
   GD_genera DATE;
   GN_InPltK PLS_INTEGER:=0;
   GN_Cab  PLS_INTEGER:=0;

   CN_IndError PLS_INTEGER; --No se puede generar Kit por que hay un componente con error
   FUNCTION AL_EXISTE_ART_FN (EC_Kit  ComponenteKit, TN_art AL_ARTICULOS.cod_articulo%TYPE)
   RETURN PLS_INTEGER
   IS
   GN_retorno PLS_INTEGER:=0;
   TN_indiceCK1 AL_PROCESOS_MASIVOS_TO.sec_reg%TYPE;
   BEGIN
       FOR TN_indiceCK1 IN EC_Kit.FIRST .. EC_Kit.LAST LOOP
         IF TN_art = EC_Kit(TN_indiceCK1).cod_articulo THEN
           GN_retorno:=TN_indiceCK1;
        EXIT;
         END IF;
       END LOOP;
   RETURN GN_retorno; -- 0:ERROR, <>0:OK
   END;

BEGIN
     GN_error:=al_genkit_formato_fn(EN_proceso,EN_num_gen_kit,EN_kit,CN_cero);

     IF GN_error = CN_cero THEN
      BEGIN
              SELECT val_parametro
            INTO TV_terminal
            FROM GED_PARAMETROS
            WHERE nom_parametro=CV_paramTer
              AND cod_modulo=CV_modulo
              AND cod_producto=CN_producto;
       EXCEPTION
         WHEN OTHERS THEN
              GN_error:=1; --Problemas de Parametros
              al_proceso_erroreskit_pr(EN_proceso,EN_num_gen_kit,EN_kit,NULL,CN_uno,GN_error,CV_paramTer,CN_uno);
          END;
   END IF;


   IF GN_error = CN_cero THEN

    BEGIN
         al_genkit_data_pr(EN_proceso,EN_num_gen_kit,EN_bodega,EN_kit,EN_stock,EN_uso,EN_estado);
   --Se actualizan los Kit con errores
            al_errores_kit_pr( EN_proceso,EN_num_gen_kit,EN_kit,GN_error);
        EXCEPTION
    WHEN OTHERS THEN
        NULL;
  END;

  BEGIN
   FOR RW_cur1 IN c_plantillaKit(EN_kit) LOOP
               CmptsKit.EXTEND;
               CmptsKit(CmptsKit.COUNT):=RW_cur1;
            END LOOP;
        EXCEPTION
          WHEN OTHERS THEN
         GN_error:=14;
            al_proceso_erroreskit_pr(EN_proceso,EN_num_gen_kit,EN_kit,NULL,CN_uno,GN_error,NULL,CN_uno);
  END;

  IF GN_error = CN_cero THEN
         BEGIN

        SELECT COUNT(1)
     INTO GN_Cab
     FROM AL_CAB_AGREDES_KIT
     WHERE  num_gen_kit=EN_num_gen_kit;

        IF GN_Cab = 0 THEN

       GD_genera:=SYSDATE;
             INSERT INTO AL_CAB_AGREDES_KIT
             (num_gen_kit,cod_kit,cod_bodega,tip_stock,cod_uso,cod_estado,can_soli,prc_unidad,fec_genera,cod_esol,des_observacion,nom_usuario,ind_agredes,ind_telefono)
             VALUES
             (EN_num_gen_kit,EN_kit,EN_bodega,EN_stock,EN_uso,EN_estado,EN_cantidad,EN_precio,GD_genera,CN_estado_sol,EV_obs,USER,EV_ind_agredes,EN_actuacion);

                 END IF;

     SELECT num_gen_kit
     INTO TN_num_orden
     FROM AL_CAB_AGREDES_KIT
     WHERE num_gen_kit=EN_num_gen_kit
     FOR UPDATE NOWAIT;

         EXCEPTION
              WHEN OTHERS THEN
           GN_error:=3; -- Error en generar cabecera de la Orden
                 al_proceso_erroreskit_pr(EN_proceso,EN_num_gen_kit,EN_kit,NULL,CN_uno,GN_error,NULL,CN_uno);
         END;

         IF GN_error = CN_cero THEN

     FOR RW_DatArch IN c_ArchKit(EN_proceso,EN_num_gen_kit,CN_cero) LOOP
       TN_sec_reg:=RW_DatArch.sec_reg;

       IF TN_grp_act <> RW_DatArch.nro_grupo THEN
             TN_grp_act:=RW_DatArch.nro_grupo;
       GN_LinKit:=CN_cero;
       GN_KitOK:=CN_cero;
             END IF;

          IF (TN_grp_act=RW_DatArch.nro_grupo) AND (GN_KitOK=CN_cero) THEN

      IF GN_LinKit=CN_cero THEN
        IF TN_serie_kitAnt=CV_serie THEN
          GN_error:=AL_SERIE_KIT_FN(TN_serie_kit);
        ELSE
          TN_serie_kit:=TN_serie_kitAnt;
        END IF;
           IF GN_error <> CN_cero THEN
           GN_error:=5;
           al_proceso_erroreskit_pr(EN_proceso,EN_num_gen_kit,EN_kit,RW_DatArch.cod_articulo,RW_DatArch.sec_reg,GN_error,NULL,CN_uno);
        GN_KitOK:=CN_uno;
        TN_serie_kitAnt:=CV_serie;
        ELSE
             BEGIN
          TN_nro_linKit:=TN_nro_linKit + 1 ;
                INSERT INTO AL_LIN_AGREDES_KIT
             (num_gen_kit, num_lin, num_serie_kit)
                VALUES
             (EN_num_gen_kit,TN_nro_linKit,TN_serie_kit);

       GN_LinKit:=CN_uno;
       TN_serie_kitAnt:=CV_serie;
       TN_nro_KitOK:=TN_nro_KitOK+1;
             EXCEPTION
           WHEN OTHERS THEN
          TN_serie_kitAnt:=TN_serie_kit;
          GN_KitOK:=CN_uno;
          TN_nro_linKit:=TN_nro_linKit -1;
       TN_nro_KitOK:=TN_nro_KitOK-1;
             GN_error:=6; --Ingreso lineas de kit
       al_proceso_erroreskit_pr(EN_proceso,EN_num_gen_kit,EN_kit,RW_DatArch.cod_articulo,RW_DatArch.sec_reg,GN_error,NULL,CN_uno);
             END;
        END IF;
      END IF;

      IF GN_LinKit=CN_uno THEN
         BEGIN
          INSERT INTO AL_LIN_COMP_AGREDES_KIT
          (num_gen_kit,num_lin,cod_articulo,tip_stock,cod_uso,cod_estado,can_articulo)
          VALUES
          (EN_num_gen_kit,TN_nro_linKit,RW_DatArch.cod_articulo,EN_stock,EN_uso,EN_estado,RW_DatArch.can_articulos);

         EXCEPTION
           WHEN DUP_VAL_ON_INDEX THEN
                GN_InPltK:=al_existe_art_fn(CmptsKit,RW_DatArch.cod_articulo);
                   IF GN_InPltK<>CN_cero THEN
                   TN_ind_ser:=CmptsKit(GN_InPltK).ind_seriado;
                   TN_can_articulo:=CmptsKit(GN_InPltK).can_articulo;

                   IF (TN_ind_ser=CN_uno AND TN_can_articulo > CN_uno) THEN
                   UPDATE AL_LIN_COMP_AGREDES_KIT
                   SET can_articulo=can_articulo + CN_uno
                   WHERE num_gen_kit= EN_num_gen_kit
                   AND num_lin =TN_nro_linKit
                   AND cod_articulo=RW_DatArch.cod_articulo;
                   ELSE
                   GN_KitOK:=CN_uno;
                            GN_error:=7;
                         al_proceso_erroreskit_pr(EN_proceso,EN_num_gen_kit,EN_kit,RW_DatArch.cod_articulo,RW_DatArch.sec_reg,GN_error,NULL,CN_uno);
                   END IF;
                END IF;
         END;

      IF RW_DatArch.num_serie IS NOT NULL THEN
         BEGIN
              SELECT num_sec_loca, num_telefono, PLAN,carga,ind_telefono
              INTO TN_sec_loca,TN_num_telefono,TN_plan,TN_carga,TN_ind_telefono
              FROM AL_SERIES
              WHERE num_serie=RW_DatArch.num_serie
             AND cod_bodega=EN_bodega
          AND cod_uso=EN_uso
          AND cod_estado=EN_estado
          AND tip_stock=EN_stock;

           GN_InPltK:=al_existe_art_fn(CmptsKit,RW_DatArch.cod_articulo);
                          IF GN_InPltK<>CN_cero THEN
             TV_terminalKit:=CmptsKit(GN_InPltK).tip_terminal;
          TN_ind_equiacc:=CmptsKit(GN_InPltK).ind_equiacc;
              IF (TN_ind_equiacc = CN_equipo) AND (TV_terminalKit<>TV_terminal) THEN
             IF (TN_ind_telefono<>EN_actuacion) THEN
                    GN_KitOK:=CN_uno;
                             GN_error:=19; --La serie tiene un tipo de actuación diferente al solicitado
                       al_proceso_erroreskit_pr(EN_proceso,EN_num_gen_kit,EN_kit,RW_DatArch.cod_articulo,RW_DatArch.sec_reg,GN_error,NULL,CN_uno);
                 END IF;
          END IF;
           END IF;

         EXCEPTION
         WHEN OTHERS THEN
          GN_KitOK:=CN_uno;
                   GN_error:=18; --No Existe Serie en Almacén
             al_proceso_erroreskit_pr(EN_proceso,EN_num_gen_kit,EN_kit,RW_DatArch.cod_articulo,RW_DatArch.sec_reg,GN_error,NULL,CN_uno);
         END;
         IF GN_error = CN_cero AND GN_KitOK=CN_cero THEN
            BEGIN
                INSERT INTO AL_SER_AGREDES_KIT
             (num_gen_kit, num_lin, cod_articulo, num_serie, num_sec_loca, PLAN, carga, num_telefono, ind_telefono)
                VALUES
             (EN_num_gen_kit,TN_nro_linKit,RW_DatArch.cod_articulo,RW_DatArch.num_serie,TN_sec_loca,TN_plan,TN_carga,TN_num_telefono,TN_ind_telefono);
         EXCEPTION
           WHEN DUP_VAL_ON_INDEX THEN
                                     GN_KitOK:=CN_uno;
                               GN_error:=7;
                            al_proceso_erroreskit_pr(EN_proceso,EN_num_gen_kit,EN_kit,RW_DatArch.cod_articulo,RW_DatArch.sec_reg,GN_error,NULL,CN_uno);
            END;
         END IF;
      END IF;
      END IF;

      IF  GN_KitOK=CN_uno   THEN -- Si falla algún insert despues de linea
        BEGIN
      --1.-Eliminar todas las series asociadas al Kit (Identificado por el Número de Linea de Kit)
      DELETE FROM AL_SER_AGREDES_KIT
      WHERE num_gen_kit=EN_num_gen_kit
        AND num_lin=TN_nro_linKit ;

      --2.-Eliminar todos los componentes del Kit
      DELETE FROM AL_LIN_COMP_AGREDES_KIT
      WHERE num_gen_kit=EN_num_gen_kit
        AND num_lin=TN_nro_linKit ;

      --3.-Eliminar el Kit (Linea de Kit)
      DELETE FROM AL_LIN_AGREDES_KIT
      WHERE num_gen_kit=EN_num_gen_kit
        AND num_lin=TN_nro_linKit ;

      --4.- Devuelvo valores
         TN_serie_kitAnt:=TN_serie_kit;
      TN_nro_linKit:=TN_nro_linKit-1;
         TN_nro_KitOK:=TN_nro_KitOK-1;
        EXCEPTION
           WHEN OTHERS THEN
             GN_error:=23;
                   al_proceso_erroreskit_pr(EN_proceso,EN_num_gen_kit,EN_kit,RW_DatArch.cod_articulo,RW_DatArch.sec_reg,GN_error,NULL,CN_uno);
           END;
      END IF;
       END IF;
         END LOOP;
   END IF;

      --Se actualizan los Kit con errores
         al_errores_kit_pr(EN_proceso,EN_num_gen_kit,EN_kit,GN_error);

   SELECT COUNT(1)
   INTO  TN_nro_KitOK
   FROM AL_LIN_AGREDES_KIT
   WHERE num_gen_kit=EN_num_gen_kit;

   UPDATE AL_CAB_AGREDES_KIT
      SET can_ingresada= TN_nro_KitOK,
             can_soli=TN_nro_KitOK
      WHERE num_gen_kit=EN_num_gen_kit;

  END IF;
     END IF;


EXCEPTION
  WHEN OTHERS THEN
    GN_error:=14;
       al_proceso_erroreskit_pr(EN_proceso,EN_num_gen_kit,EN_kit,NULL,TN_sec_reg,GN_error,NULL,CN_uno);
END AL_GENERACION_KIT_PR;

Procedure AL_SIMULACIONYCARGA_KIT_PR(
  EN_proceso IN AL_PROCESOS_MASIVOS_TO.ind_proceso%TYPE,
  EN_num_gen_kit IN AL_CAB_AGREDES_KIT.num_gen_kit%TYPE,
  EN_bodega  IN AL_SERIES.cod_bodega%TYPE,
  EN_kit  IN AL_SERIES.cod_articulo%TYPE,
  EN_stock  IN AL_SERIES.tip_stock%TYPE,
  EN_uso  IN AL_SERIES.cod_uso%TYPE,
  EN_estado  IN AL_SERIES.cod_estado%TYPE,
  EN_actuacion  IN AL_SERIES.ind_telefono%TYPE,
  EN_cantidad  IN AL_CAB_AGREDES_KIT.can_soli%TYPE,
  EN_precio IN AL_CAB_AGREDES_KIT.prc_unidad%TYPE,
  EV_obs IN AL_CAB_AGREDES_KIT.des_observacion%TYPE,
  EV_ind_agredes IN AL_CAB_AGREDES_KIT.ind_agredes%TYPE,
  EN_num_ingpar IN AL_DETALLE_KIT_TO.num_ingpar%TYPE)
/*
<NOMBRE> : AL_SIMULACIONYCARGA_KIT_PR                                                </NOMBRE>
<FECHACREA> : JUNIO 2004                                                                <FECHACREA/>
<MODULO > : ADMINISTRACION DE INVENTARIO.                                             </MODULO >
<AUTOR > : Marcela Lucero Rozas.                                                     </AUTOR >
<VERSION > : 01                                                                        </VERSION >
<DESCRIPCION>: Realiza la Generación de Kit por el proceso de Simulación y Carga        </DESCRIPCION>
<FECHAMOD > : DD/MM/YYYY                                                                </FECHAMOD >
<DESCMOD > : Breve descripción de Modificación                                         </DESCMOD >
<ParamEntr>  : EN_proceso Número asociado al proceso de Generación de Kit               </ParamEntr>
<ParamEntr>  : EN_num_gen_kit Número de la Orden                                        </ParamEntr>
<ParamEntr>  : EN_bodega Código de Bodega                                               </ParamEntr>
<ParamEntr>  : EN_Kit Código de Kit                                                     </ParamEntr>
<ParamEntr>  : EN_stock  Tipo de Stock                                                  </ParamEntr>
<ParamEntr>  : EN_uso  Código de Uso                                                    </ParamEntr>
<ParamEntr>  : EN_estado  Código Estado                                                 </ParamEntr>
<ParamEntr>  : EN_actuacion  Indicador de telefóno                                      </ParamEntr>
<ParamEntr>  : EN_cantidad  Cantidad de Kit a generar                                   </ParamEntr>
<ParamEntr>  : EN_precio  Precio del Kit                                                </ParamEntr>
<ParamEntr>  : EV_obs  Observación de la generación                                     </ParamEntr>
<ParamEntr>  : EV_ind_agredes  Indicador de Generación/Desvinculación                   </ParamEntr>
<ParamSal > :                                                                           </ParamEntr>
*/
IS
   CURSOR c_ArchKit (TN_proceso AL_PROCESOS_MASIVOS_TO.ind_proceso%TYPE,
                     TN_num_gen_kit AL_CAB_AGREDES_KIT.num_gen_kit%TYPE,
      TN_ind_error AL_PROCESOS_MASIVOS_TO.ind_error%TYPE ) IS
   SELECT num_proceso,nro_grupo,sec_reg,cod_articulo_ppal,can_solicitada,
          cod_articulo,num_serie,can_articulos,ind_telefono,ind_error,observaciones
   FROM AL_PROCESOS_MASIVOS_TO
   WHERE ind_proceso=TN_proceso
     AND num_proceso=TN_num_gen_kit
  AND ind_error = TN_ind_error
   ORDER BY sec_reg;


   CURSOR c_plantillaKit(TN_kit AL_PLANTILLAS_KIT.cod_kit%TYPE) IS
   SELECT a.cod_articulo, can_articulo,
          b.ind_seriado,b.ind_equiacc,b.tip_terminal,0 stock_acumulado
   FROM AL_PLANTILLAS_KIT a, AL_ARTICULOS b
   WHERE a.cod_articulo=b.cod_articulo
   AND cod_kit=TN_kit;

   TYPE ComponenteKit IS TABLE OF c_plantillaKit%ROWTYPE;
   CmptsKit ComponenteKit:=ComponenteKit();

   TN_num_orden AL_CAB_AGREDES_KIT.num_gen_kit%TYPE;
   TN_grp_act AL_PROCESOS_MASIVOS_TO.nro_grupo%TYPE:=1;
   TN_nro_linKit AL_LIN_AGREDES_KIT.num_lin%TYPE:=0;
   TN_ult_linOK AL_LIN_AGREDES_KIT.num_lin%TYPE:=0;
   TN_sec_loca AL_SERIES.num_sec_loca%TYPE;
   TN_num_telefono AL_SERIES.num_telefono%TYPE;
   TN_plan AL_SERIES.PLAN%TYPE;
   TN_carga AL_SERIES.carga%TYPE;
   TN_ind_telefono AL_SERIES.ind_telefono%TYPE;
   TN_nro_KitOK AL_CAB_AGREDES_KIT.can_ingresada%TYPE:=0;
   TN_nro_KitIng AL_CAB_AGREDES_KIT.can_ingresada%TYPE:=0;
   TN_nro_KitSol AL_CAB_AGREDES_KIT.can_ingresada%TYPE:=0;
   TN_sec_reg AL_PROCESOS_MASIVOS_TO.sec_reg%TYPE:=0;
   TN_ind_ser AL_ARTICULOS.ind_seriado%TYPE:=0;
   TN_ind_equiacc AL_ARTICULOS.ind_equiacc%TYPE;
   TN_tip_terminal AL_ARTICULOS.tip_terminal%TYPE;
   TN_can_articulo AL_PLANTILLAS_KIT.can_articulo%TYPE:=0;
   TN_actuacion al_series.ind_telefono%TYPE:=0;
   TV_terminal AL_ARTICULOS.tip_terminal%TYPE;

   GN_error PLS_INTEGER:=0;
   GN_ret   PLS_INTEGER;
   GN_KitOK PLS_INTEGER:=0;
   GN_LinKit PLS_INTEGER:=0;
   GN_SerKit PLS_INTEGER:=0;
   GN_LinCompKit PLS_INTEGER:=0;
   GN_InPltK PLS_INTEGER:=0;

   CN_uno CONSTANT PLS_INTEGER:=1;
   CN_cero CONSTANT PLS_INTEGER:=0;
   CN_IndError CONSTANT PLS_INTEGER:=99; --No se puede generar Kit por que hay un componente con error
   CN_equipo CONSTANT VARCHAR2(1):='E';

   FUNCTION AL_EXISTE_ART_FN (EC_Kit  ComponenteKit, TN_art AL_ARTICULOS.cod_articulo%TYPE)
   RETURN PLS_INTEGER
   IS
   GN_retorno PLS_INTEGER:=0;
   TN_indiceCK1 AL_PROCESOS_MASIVOS_TO.sec_reg%TYPE;
   BEGIN
       FOR TN_indiceCK1 IN EC_Kit.FIRST .. EC_Kit.LAST LOOP
         IF TN_art = EC_Kit(TN_indiceCK1).cod_articulo THEN
           GN_retorno:=TN_indiceCK1;
        EXIT;
         END IF;
       END LOOP;
   RETURN GN_retorno; -- 0:ERROR, <>0:OK
   END;

BEGIN
     GN_error:=al_genkit_formato_fn(EN_proceso,EN_num_gen_kit,EN_kit,CN_uno);
  IF GN_error = CN_cero THEN
      BEGIN
              SELECT val_parametro
            INTO TV_terminal
            FROM ged_parametros
            WHERE nom_parametro=CV_paramTer
              AND cod_modulo=CV_modulo
              AND cod_producto=CN_producto;
       EXCEPTION
         WHEN OTHERS THEN
              GN_error:=1; --Problemas de Parametros
              al_proceso_erroreskit_pr(EN_proceso,EN_num_gen_kit,EN_kit,NULL,CN_uno,GN_error,CV_paramTer,CN_uno);
          END;
   END IF;
     IF GN_error = CN_cero THEN
    BEGIN
         al_genkit_data_pr(EN_proceso,EN_num_gen_kit,EN_bodega,EN_kit,EN_stock,EN_uso,EN_estado);
            --Se actualizan los Kit con errores
            al_errores_kit_pr( EN_proceso,EN_num_gen_kit,EN_kit,GN_error);
        EXCEPTION
    WHEN OTHERS THEN
        NULL;
  END;

  IF GN_error = CN_cero THEN
           BEGIN
      SELECT num_gen_kit
      INTO TN_num_orden
      FROM AL_CAB_AGREDES_KIT
      WHERE num_gen_kit=EN_num_gen_kit
      FOR UPDATE NOWAIT;

           EXCEPTION
              WHEN OTHERS THEN
           GN_error:=22; -- Orden de Armado no Existe o esta siendo utilizada por otro usuario
                 al_proceso_erroreskit_pr(EN_proceso,EN_num_gen_kit,EN_kit,NULL,CN_uno,GN_error,NULL,CN_uno);
           END;

     IF GN_error = CN_cero THEN
             BEGIN
     FOR RW_cur1 IN c_plantillaKit(EN_kit) LOOP
                    CmptsKit.EXTEND;
                    CmptsKit(CmptsKit.COUNT):=RW_cur1;
                 END LOOP;
          EXCEPTION
             WHEN OTHERS THEN
              GN_error:=14;
                    al_proceso_erroreskit_pr(EN_proceso,EN_num_gen_kit,EN_kit,NULL,CN_uno,GN_error,NULL,CN_uno);
    END;

    IF GN_error = CN_cero THEN

    SELECT NVL(MAX(num_lin),0)
    INTO  TN_nro_linKit
    FROM AL_LIN_AGREDES_KIT
    WHERE num_gen_kit=EN_num_gen_kit;


      FOR ArchDat IN c_ArchKit(EN_proceso,EN_num_gen_kit,CN_cero) LOOP

                  GN_error:=0;
      TN_nro_KitIng:=ArchDat.can_solicitada;
      TN_sec_reg:=ArchDat.sec_reg;

            IF TN_grp_act <> ArchDat.nro_grupo THEN
             TN_grp_act:=ArchDat.nro_grupo;
       GN_LinKit:=CN_cero;

       GN_KitOK:=CN_cero;
            END IF;

         IF (TN_grp_act=ArchDat.nro_grupo) AND (GN_KitOK=CN_cero) THEN

     IF GN_LinKit=CN_cero THEN
           BEGIN
       TN_nro_linKit:=TN_nro_linKit + 1;

                INSERT INTO AL_LIN_AGREDES_KIT
             (num_gen_kit, num_lin, num_serie_kit, num_ingpar)
                VALUES
             (EN_num_gen_kit,TN_nro_linKit,ArchDat.num_serie,EN_num_ingpar);

       GN_LinKit:=CN_uno;
       TN_nro_KitOK:=TN_nro_KitOK+1;

           EXCEPTION
           WHEN OTHERS THEN
          GN_KitOK:=CN_uno;
             GN_error:=6; --Ingreso lineas de kit
       al_proceso_erroreskit_pr(EN_proceso,EN_num_gen_kit,EN_kit,ArchDat.cod_articulo,ArchDat.sec_reg,GN_error,NULL,CN_uno);
           END;
     END IF;
      END IF;

      IF ArchDat.cod_articulo_ppal<> ArchDat.cod_articulo THEN

          IF GN_LinKit=CN_uno THEN
         BEGIN
             INSERT INTO AL_LIN_COMP_AGREDES_KIT
             (num_gen_kit,num_lin,cod_articulo,tip_stock,cod_uso,cod_estado,can_articulo)
             VALUES
             (EN_num_gen_kit,TN_nro_linKit,ArchDat.cod_articulo,EN_stock,EN_uso,EN_estado,ArchDat.can_articulos);

         EXCEPTION
           WHEN DUP_VAL_ON_INDEX THEN
                GN_InPltK:=al_existe_art_fn(CmptsKit,ArchDat.cod_articulo);
                   IF GN_InPltK<>CN_cero THEN
                   TN_ind_ser:=CmptsKit(GN_InPltK).ind_seriado;
                   TN_can_articulo:=CmptsKit(GN_InPltK).can_articulo;

                   IF (TN_ind_ser=CN_uno AND TN_can_articulo > CN_uno) THEN
                   UPDATE AL_LIN_COMP_AGREDES_KIT
                   SET can_articulo=can_articulo + CN_uno
                   WHERE num_gen_kit= EN_num_gen_kit
                   AND num_lin =TN_nro_linKit
                   AND cod_articulo=ArchDat.cod_articulo;
                   ELSE
                   GN_KitOK:=CN_uno;
                            GN_error:=7;
                         al_proceso_erroreskit_pr(EN_proceso,EN_num_gen_kit,EN_kit,ArchDat.cod_articulo,ArchDat.sec_reg,GN_error,NULL,CN_uno);
                   END IF;
                END IF;
         END;

         IF ArchDat.num_serie IS NOT NULL THEN

            BEGIN
              SELECT num_sec_loca, num_telefono, PLAN,carga,ind_telefono
              INTO TN_sec_loca,TN_num_telefono,TN_plan,TN_carga,TN_ind_telefono
              FROM al_series
              WHERE num_serie=ArchDat.num_serie
           AND cod_bodega=EN_bodega
           AND cod_uso=EN_uso
           AND cod_estado=EN_estado
           AND tip_stock=EN_stock;


        GN_InPltK:=al_existe_art_fn(CmptsKit,ArchDat.cod_articulo);
                       IF GN_InPltK<>CN_cero THEN
           TN_tip_terminal:=CmptsKit(GN_InPltK).tip_terminal;
           TN_ind_equiacc:=CmptsKit(GN_InPltK).ind_equiacc;
               IF (TN_ind_equiacc = CN_equipo) AND (TN_tip_terminal<>TV_terminal) THEN
           IF TN_ind_telefono<>EN_actuacion THEN
                    GN_KitOK:=CN_uno;
                             GN_error:=19; --La serie tiene un tipo de actuación diferente al solicitado
                       al_proceso_erroreskit_pr(EN_proceso,EN_num_gen_kit,EN_kit,ArchDat.cod_articulo,ArchDat.sec_reg,GN_error,NULL,CN_uno);
                 END IF;
          END IF;
        END IF;

          EXCEPTION
            WHEN OTHERS THEN
           GN_KitOK:=CN_uno;
                    GN_error:=18; --No Existe Serie en Almacén
              al_proceso_erroreskit_pr(EN_proceso,EN_num_gen_kit,EN_kit,ArchDat.cod_articulo,ArchDat.sec_reg,GN_error,NULL,CN_uno);
          END;

          IF GN_error = CN_cero AND GN_KitOK=CN_cero THEN
            BEGIN
                   INSERT INTO AL_SER_AGREDES_KIT
                (num_gen_kit, num_lin, cod_articulo, num_serie, num_sec_loca, PLAN, carga, num_telefono, ind_telefono)
                   VALUES
                (EN_num_gen_kit,TN_nro_linKit,ArchDat.cod_articulo,ArchDat.num_serie,TN_sec_loca,TN_plan,TN_carga,TN_num_telefono,TN_ind_telefono);
            EXCEPTION
              WHEN OTHERS THEN
                   GN_KitOK:=CN_uno;
                            GN_error:=7;
                         al_proceso_erroreskit_pr(EN_proceso,EN_num_gen_kit,EN_kit,ArchDat.cod_articulo,ArchDat.sec_reg,GN_error,NULL,CN_uno);
            END;
          END IF;
         END IF;
             END IF;
             IF GN_KitOK=CN_uno AND GN_LinKit<>CN_uno  THEN -- Si falla algún insert despues de linea
                        BEGIN
                --1.-Eliminar todas las series asociadas al Kit (Identificado por el Número de Linea de Kit)
                DELETE FROM AL_SER_AGREDES_KIT
                WHERE num_gen_kit=EN_num_gen_kit
                  AND num_lin=TN_nro_linKit ;

                --2.-Eliminar todos los componentes del Kit
                DELETE FROM AL_LIN_COMP_AGREDES_KIT
                WHERE num_gen_kit=EN_num_gen_kit
                  AND num_lin=TN_nro_linKit ;

                --3.-Eliminar el Kit (Linea de Kit)
                DELETE FROM AL_LIN_AGREDES_KIT
                WHERE num_gen_kit=EN_num_gen_kit
                  AND num_lin=TN_nro_linKit ;

             TN_nro_linKit:=TN_nro_linKit - 1;
             TN_nro_KitOK:=TN_nro_KitOK-1;
         EXCEPTION
           WHEN OTHERS THEN
             GN_error:=23;
                   al_proceso_erroreskit_pr(EN_proceso,EN_num_gen_kit,EN_kit,ArchDat.cod_articulo,ArchDat.sec_reg,GN_error,NULL,CN_uno);
         END;
             END IF;
      END IF;
    END LOOP;
       INSERT INTO AL_DETALLE_KIT_TO
       (num_gen_kit, num_ingpar, can_parcial)
       VALUES
       (EN_num_gen_kit,EN_num_ingpar,TN_nro_KitIng);


    IF TN_nro_KitOK > CN_cero THEN
       --Hay a lo menos un Kit bueno, por lo que hay que actualizar cantidades
          UPDATE AL_CAB_AGREDES_KIT
          SET can_ingresada=NVL(can_ingresada,0) + TN_nro_KitOK,
           cod_esol=CN_uno
          WHERE num_gen_kit=EN_num_gen_kit;
    END IF;


       --Se actualizan los Kit con errores
                al_errores_kit_pr( EN_proceso,EN_num_gen_kit,EN_kit,GN_error);

    END IF;
     END IF;
        END IF;
     END IF;

   --Libera espacio de memoria
   CmptsKit.DELETE;
   DBMS_SESSION.FREE_UNUSED_USER_MEMORY;


EXCEPTION
WHEN OTHERS THEN
   GN_error:=14;
   al_proceso_erroreskit_pr(EN_proceso,EN_num_gen_kit,EN_kit,NULL,TN_sec_reg,GN_error,NULL,CN_uno);
   --Se actualizan los Kit con errores
   al_errores_kit_pr( EN_proceso,EN_num_gen_kit,EN_kit,GN_error);
   --Libera espacio de memoria
   CmptsKit.DELETE;
   DBMS_SESSION.FREE_UNUSED_USER_MEMORY;
END AL_SIMULACIONYCARGA_KIT_PR;

FUNCTION AL_VALIDA_SERIE_FN(
   EN_articulo  IN AL_SERIES.cod_articulo%TYPE,
   EV_series IN AL_SERIES.num_serie%TYPE,
   EN_uso IN AL_SERIES.cod_uso%TYPE,
   EN_estado IN AL_SERIES.cod_estado%TYPE,
   EN_bodega  IN AL_SERIES.cod_bodega%TYPE)
  RETURN BOOLEAN
IS
/*
<NOMBRE> : AL_VALIDA_SERIE_FN</NOMBRE>
<FECHACREA> :  DD/MM/YYYY<FECHACREA/>
<MODULO > : Módulo al que pertenece PL; Script; trigger; cursor; función. </MODULO >
<AUTOR > : Maritza Tapia Alvarez. </AUTOR >
<VERSION > : 01</VERSION >
<DESCRIPCION> : Breve descripción explicativa </DESCRIPCION>
<FECHAMOD > : DD/MM/YYYY </FECHAMOD >
<DESCMOD > : Breve descripción de Modificación </DESCMOD >
<ParamEntr> : Parámetros de entrada de la función  (solo si es función o procedimiento) </ParamEntr>
<ParamSal > : Parámetros de salida de la función    (solo si es función o procedimiento) </ParamEntr>
*/

TV_serie       AL_SERIES.NUM_SERIE%TYPE;
TV_terminal      AL_ARTICULOS.TIP_TERMINAL%TYPE;
TN_producto      AL_ARTICULOS.COD_PRODUCTO%TYPE;
TV_equiacc       AL_ARTICULOS.IND_EQUIACC%TYPE;
TN_seriado       AL_ARTICULOS.IND_SERIADO%TYPE;

CN_esol CONSTANT AL_CAB_AGREDES_KIT.COD_ESOL%TYPE := '0';
CN_stock CONSTANT  AL_SERIES.TIP_STOCK%TYPE := 2;

BEGIN


   SELECT  ind_seriado
      ,tip_terminal
      ,cod_producto
      ,ind_equiacc
     INTO TN_seriado
      ,TV_terminal
      ,TN_producto
      ,TV_equiacc
        FROM AL_ARTICULOS
        WHERE cod_articulo = EN_articulo;


  SELECT  num_serie
  INTO    TV_serie
  FROM AL_SERIES
  WHERE num_Serie  = EV_series
  AND   cod_uso    = EN_uso
  AND   cod_estado = EN_estado
  AND   cod_bodega = EN_bodega
  AND   tip_stock  = CN_stock;



 RETURN TRUE;

 EXCEPTION
      WHEN NO_DATA_FOUND THEN
    RETURN FALSE;
   WHEN OTHERS THEN
    RETURN FALSE;

END AL_VALIDA_SERIE_FN;

Procedure AL_DESVINCULACION_NEW_PR(
    EN_indproceso   IN  AL_PROCESOS_MASIVOS_TO.IND_PROCESO%TYPE,
 EN_numproceso   IN  AL_PROCESOS_MASIVOS_TO.NUM_PROCESO%TYPE,
 EN_uso          IN  AL_SERIES.COD_USO%TYPE,
 EN_estado      IN  AL_SERIES.COD_ESTADO%TYPE,
 EN_bodega       IN  AL_SERIES.COD_BODEGA%TYPE,
 EN_precio      IN AL_CAB_AGREDES_KIT.PRC_UNIDAD%TYPE)


IS
/*
<NOMBRE> : AL_DESVINCULACION_PR                                                     </NOMBRE>
<FECHACREA> : JUNIO 2004                                                               <FECHACREA/>
<MODULO > : ADMINISTRACION DE INVENTARIO.                                            </MODULO >
<AUTOR > : Maritza Tapia A.                                                         </AUTOR >
<VERSION > : 01                                                                       </VERSION >
<DESCRIPCION>: Realiza la desvinculación de Kit             </DESCRIPCION>
<FECHAMOD > : DD/MM/YYYY                                                               </FECHAMOD >
<DESCMOD > : Breve descripción de Modificación                                        </DESCMOD >
<ParamEntr>  : EN_indproceso Número asociado al proceso de Generación de Kit           </ParamEntr>
<ParamEntr>  : EN_numproceso Número de la Orden                                        </ParamEntr>
<ParamEntr>  : EN_bodega Bodega de Kit                                                 </ParamEntr>
<ParamSal > :                                                                          </ParamEntr>
*/

GN_error PLS_INTEGER:=0;
GV_glosaerror VARCHAR2(50);
TN_numlin   AL_LIN_AGREDES_KIT.NUM_LIN%TYPE;
GN_numlim   AL_LIN_AGREDES_KIT.NUM_LIN%TYPE;
TN_ingpar   AL_DETALLE_KIT_TO.NUM_INGPAR%TYPE;
TB_serieKit AL_LIN_AGREDES_KIT.NUM_SERIE_KIT%TYPE;
TN_cod_articulo_ppal AL_PROCESOS_MASIVOS_TO.COD_ARTICULO_PPAL%TYPE;
GB_serieorden BOOLEAN;
GN_contador   PLS_INTEGER:=0;
GN_cantidadarestar PLS_INTEGER:=0;
GN_ingparcial PLS_INTEGER:=1;
CN_staordep CONSTANT NUMBER(1) := 1;
GN_ret   PLS_INTEGER;
CN_cero CONSTANT PLS_INTEGER:=0;
CN_uno  CONSTANT PLS_INTEGER:=1;
GN_existeserie PLS_INTEGER;
GV_serie    AL_PROCESOS_MASIVOS_TO.NUM_SERIE%TYPE;


exc_error   EXCEPTION;

CURSOR c_recup_traspaso IS
          SELECT  cod_articulo_ppal /*cod kit*/
       , num_serie
    , sec_reg
    , can_solicitada
       FROM   AL_PROCESOS_MASIVOS_TO
       WHERE  ind_proceso = EN_indproceso
       AND    num_proceso = EN_numproceso
      ORDER BY num_serie;


BEGIN
  /*Cantidad de Ingreso parcial*/
        BEGIN
          SELECT NVL(MAX(num_ingpar),0) + 1 lin
          INTO  TN_ingpar
          FROM  AL_DETALLE_KIT_TO
          WHERE num_gen_kit = EN_numproceso;
        EXCEPTION
          WHEN OTHERS THEN
          GN_error:=7;
          RAISE exc_error;
        END;

  /**Maximo numero de la linea de la carga parcial*/
        BEGIN
          SELECT NVL(MAX(num_lin),0)
          INTO   TN_numlin
          FROM AL_LIN_AGREDES_KIT
          WHERE num_gen_kit = EN_numproceso
          AND num_ingpar >= 1;
        EXCEPTION
          WHEN OTHERS THEN
          GN_error:=3;
          RAISE exc_error;
        END;

  FOR tras IN c_recup_traspaso LOOP
   GN_existeserie := 1;
   IF tras.num_serie IS NOT NULL OR tras.num_serie <> '' THEN
    IF GN_contador = 0 THEN
        GV_serie := tras.num_serie;
        GN_ingparcial := tras.can_solicitada;
        TN_cod_articulo_ppal := tras.cod_articulo_ppal;
        GN_contador := GN_contador + 1;
    ELSE
       IF GV_serie = tras.num_serie THEN
          GN_existeserie := 0;
          GN_error:=1;
          al_proceso_erroreskit_pr(EN_indproceso,EN_numproceso,tras.cod_articulo_ppal,NULL,tras.sec_reg,GN_error,NULL,CN_uno);
       ELSE
       GV_serie := tras.num_serie;
       GN_contador := GN_contador + 1;
          END IF;
    END IF;
           /** Verifico que existan las series **/
    IF GN_existeserie = 1 THEN
     --GN_ingparcial := GN_ingparcial +1;
     IF tras.num_serie IS NOT NULL OR tras.num_serie <> '' THEN
       IF AL_VALIDA_SERIE_FN(tras.cod_articulo_ppal, tras.num_serie, EN_uso, EN_estado, EN_bodega) THEN
        GN_error:= AL_DESKIT_COMPONENTES_FN(tras.num_serie);
       IF GN_error = CN_cero THEN
          GB_serieorden := TRUE;
          BEGIN
           SELECT num_serie_kit
           INTO  TB_serieKit
           FROM AL_LIN_AGREDES_KIT
           WHERE num_gen_kit = EN_numproceso
           AND num_serie_kit = tras.num_serie;

          EXCEPTION
               WHEN NO_DATA_FOUND THEN
           GB_serieorden := FALSE;
          END ;

          IF GB_serieorden =  FALSE THEN
             GN_numlim := (GN_contador +  TN_numlin) - GN_cantidadarestar;
             BEGIN
           INSERT INTO AL_LIN_AGREDES_KIT
              (num_gen_kit, num_lin, num_serie_kit, num_ingpar)
              VALUES (EN_numproceso, GN_numlim, tras.num_serie, TN_ingpar);
          EXCEPTION
                WHEN OTHERS THEN
                                           GN_error:=4;
                GN_cantidadarestar := GN_cantidadarestar + 1;
                 al_proceso_erroreskit_pr(EN_indproceso,EN_numproceso,tras.cod_articulo_ppal,NULL,tras.sec_reg,GN_error,NULL,CN_uno);
             END;
          ELSE
                    GN_error:=9;
           GN_cantidadarestar := GN_cantidadarestar + 1;
           al_proceso_erroreskit_pr(EN_indproceso,EN_numproceso,tras.cod_articulo_ppal,NULL,NULL,GN_error,NULL,CN_uno);
          END IF;
         ELSE
             IF GN_error = 2 THEN
              GN_error:=12;
           al_proceso_erroreskit_pr(EN_indproceso,EN_numproceso,tras.cod_articulo_ppal,NULL,NULL,GN_error,NULL,CN_uno);
          ELSE
              GN_error:=10;
           al_proceso_erroreskit_pr(EN_indproceso,EN_numproceso,tras.cod_articulo_ppal,NULL,NULL,GN_error,NULL,CN_uno);
          END IF;
         END IF;
      ELSE
          GN_error:=8;
       GN_cantidadarestar := GN_cantidadarestar + 1;
       al_proceso_erroreskit_pr(EN_indproceso,EN_numproceso,tras.cod_articulo_ppal,NULL,NULL,GN_error,NULL,CN_uno);
         END IF;
     END IF;
    END IF;
    END IF;
   EXIT WHEN c_recup_traspaso%NOTFOUND;
  END LOOP;

  IF GN_contador >= 1 THEN
     BEGIN
      INSERT INTO AL_DETALLE_KIT_TO
      (NUM_GEN_KIT, NUM_INGPAR, CAN_PARCIAL)
      VALUES (EN_numproceso,TN_ingpar, GN_ingparcial);
           EXCEPTION
              WHEN OTHERS THEN
                    GN_error:=11;
                    al_proceso_erroreskit_pr(EN_indproceso,EN_numproceso,TN_cod_articulo_ppal,NULL,NULL,GN_error,'Error en Insert AL_DETALLE_KIT_TO',CN_cero);
           END;
     BEGIN
     UPDATE AL_CAB_AGREDES_KIT
     SET   COD_ESOL = CN_staordep
       , PRC_UNIDAD  = EN_precio
       , CAN_INGRESADA  = GN_contador
     WHERE NUM_GEN_KIT = EN_numproceso;
   EXCEPTION
       WHEN OTHERS THEN
         GN_error:=10;
      al_proceso_erroreskit_pr(EN_indproceso,EN_numproceso,TN_cod_articulo_ppal,NULL,NULL,GN_error,'Error en Update AL_CAB_AGREDES_KIT',CN_cero);
   END;
  END IF;

EXCEPTION
  WHEN exc_error THEN
     al_proceso_erroreskit_pr(EN_indproceso, EN_numproceso,' ',NULL,NULL,GN_error,NULL,CN_cero);

END AL_DESVINCULACION_NEW_PR;

Procedure AL_DESVINCULACION_PR(
             EN_indproceso IN  AL_PROCESOS_MASIVOS_TO.IND_PROCESO%TYPE,
             EN_numproceso  IN AL_PROCESOS_MASIVOS_TO.NUM_PROCESO%TYPE,
      EN_bodega      IN AL_SERIES.COD_BODEGA%TYPE )

IS
/*
<NOMBRE> : AL_DESVINCULACION_PR                                                     </NOMBRE>
<FECHACREA> : JUNIO 2004                                                               <FECHACREA/>
<MODULO > : ADMINISTRACION DE INVENTARIO.                                            </MODULO >
<AUTOR > : Maritza Tapia A.                                                         </AUTOR >
<VERSION > : 01                                                                       </VERSION >
<DESCRIPCION>: Realiza la desvinculación de Kit             </DESCRIPCION>
<FECHAMOD > : DD/MM/YYYY                                                               </FECHAMOD >
<DESCMOD > : Breve descripción de Modificación                                        </DESCMOD >
<ParamEntr>  : EN_indproceso Número asociado al proceso de Generación de Kit           </ParamEntr>
<ParamEntr>  : EN_numproceso Número de la Orden                                        </ParamEntr>
<ParamEntr>  : EN_bodega Bodega de Kit                                                 </ParamEntr>
<ParamSal > :                                                                          </ParamEntr>
*/

GN_error PLS_INTEGER:=0;
GV_glosaerror VARCHAR2(50);
exc_error   EXCEPTION;
TN_numlin   AL_LIN_AGREDES_KIT.NUM_LIN%TYPE;
TN_ingpar   AL_DETALLE_KIT_TO.NUM_INGPAR%TYPE;
TB_serieKit AL_LIN_AGREDES_KIT.NUM_SERIE_KIT%TYPE;
GV_serie    AL_PROCESOS_MASIVOS_TO.NUM_SERIE%TYPE;
CN_StaOrdEP CONSTANT NUMBER(1) := 1;
GN_totalseries PLS_INTEGER:=0;
GN_existeserie PLS_INTEGER:=0;
GN_contador PLS_INTEGER:=1;
GN_ret   PLS_INTEGER;
CN_cero CONSTANT PLS_INTEGER:=0;
CN_uno  CONSTANT PLS_INTEGER:=1;
TV_num_series AL_SERIES.NUM_SERIE%TYPE;
TN_cod_bodega AL_SERIES.COD_BODEGA%TYPE;


CURSOR  c_recup_traspaso IS
      SELECT   num_serie
      , sec_reg
   FROM   AL_PROCESOS_MASIVOS_TO
   WHERE  ind_proceso = EN_indproceso
   AND    num_proceso = EN_numproceso
   ORDER BY num_serie;

BEGIN

  FOR tras IN c_recup_traspaso LOOP

   GN_existeserie := 1;
   IF tras.num_serie IS NOT NULL OR tras.num_serie <> '' THEN
    IF GN_contador = 1 THEN
        GV_serie := tras.num_serie;
        GN_contador := GN_contador + 1;
    ELSE
       IF GV_serie = tras.num_serie THEN
          GN_existeserie := 0;
          GN_error:=1;
       al_proceso_erroreskit_pr(EN_indproceso,EN_numproceso,NULL,NULL,tras.sec_reg,GN_error,NULL,CN_uno, tras.num_serie);
       ELSE
       GV_serie := tras.num_serie;
       GN_contador := GN_contador + 1;
          END IF;
    END IF;
           /** Verifico que existan las series **/
    IF GN_existeserie = 1 THEN

      BEGIN
       SELECT a.num_serie, a.cod_bodega
       INTO   TV_num_series, TN_cod_bodega
       FROM   AL_SERIES A
          WHERE  a.num_serie = tras.num_serie;

      EXCEPTION
            WHEN OTHERS THEN
               GN_error:=2;
         al_proceso_erroreskit_pr(EN_indproceso,EN_numproceso,NULL,NULL,tras.sec_reg,GN_error,NULL,CN_uno, tras.num_serie);
         END;
       /** Si existen series**/
      IF  TV_num_series IS NOT NULL THEN
        IF TN_cod_bodega = EN_bodega THEN
            GN_error:= AL_DESKIT_COMPONENTES_FN(tras.num_serie);
          IF GN_error = CN_cero THEN
          BEGIN
           SELECT (NVL(MAX(num_lin), 0)) + 1
           INTO   TN_numlin
           FROM   AL_LIN_AGREDES_KIT
           WHERE  num_gen_kit = EN_numproceso;
          EXCEPTION
                WHEN OTHERS THEN
                  GN_error:=3;
                        al_proceso_erroreskit_pr(EN_indproceso,EN_numproceso,NULL,NULL,tras.sec_reg,GN_error,NULL,CN_uno, tras.num_serie);

             END;

             BEGIN
           INSERT INTO AL_LIN_AGREDES_KIT
           (num_gen_kit, num_lin, num_serie_kit)
           VALUES (EN_numproceso, TN_numlin , tras.num_serie);
          EXCEPTION
               WHEN OTHERS THEN
                   GN_error:=4;
                            al_proceso_erroreskit_pr(EN_indproceso,EN_numproceso,NULL,NULL,tras.sec_reg,GN_error,NULL,CN_uno, tras.num_serie);
             END;

          BEGIN
           INSERT INTO AL_LIN_COMP_AGREDES_KIT(num_gen_kit, num_lin, cod_articulo, tip_stock, cod_uso, cod_estado, can_articulo)
           SELECT EN_numproceso
           , TN_numlin
           , a.cod_articulo
           , a.tip_stock
           , a.cod_uso
           , a.cod_estado
           , SUM(a.can_articulo)
           FROM  AL_COMPONENTE_KIT a
           WHERE a.num_kit = tras.num_serie
           AND   a.cod_bodega = EN_bodega
           GROUP BY EN_numproceso, TN_numlin, a.cod_articulo, tip_stock, cod_uso, cod_estado;

          EXCEPTION
               WHEN OTHERS THEN
                    GN_error:=5;
                  al_proceso_erroreskit_pr(EN_indproceso,EN_numproceso,NULL,NULL,tras.sec_reg,GN_error,NULL,CN_uno, tras.num_serie);


             END;

          BEGIN
           INSERT INTO AL_SER_AGREDES_KIT(num_gen_kit, num_lin, cod_articulo, num_serie, num_sec_loca,num_telefono,ind_telefono,PLAN,carga)
           SELECT EN_numproceso
           , TN_numlin
           , cod_articulo
           , num_serie
           , num_sec_loca
           , num_telefono
           , ind_telefono
           , PLAN
           , carga
             FROM  AL_COMPONENTE_KIT
             WHERE num_kit = tras.num_serie
             AND   num_serie IS NOT NULL;

          EXCEPTION
               WHEN OTHERS THEN
                    GN_error:=6;
                 al_proceso_erroreskit_pr(EN_indproceso,EN_numproceso,NULL,NULL,tras.sec_reg,GN_error,NULL,CN_uno, tras.num_serie);
             END;
        ELSE
            IF GN_error = 2 THEN
          GN_error:=12;
          al_proceso_erroreskit_pr(EN_indproceso,EN_numproceso,NULL,NULL,tras.sec_reg,GN_error,NULL,CN_uno, tras.num_serie);
         ELSE
          GN_error:=10;
          al_proceso_erroreskit_pr(EN_indproceso,EN_numproceso,NULL,NULL,tras.sec_reg,GN_error,NULL,CN_uno, tras.num_serie);
         END IF;
        END IF;
       ELSE
        GN_error:=11;
         al_proceso_erroreskit_pr(EN_indproceso,EN_numproceso,NULL,NULL,tras.sec_reg,GN_error,NULL,CN_uno, tras.num_serie);
       END IF;
         ELSE
                      GN_error:=2;
         al_proceso_erroreskit_pr(EN_indproceso,EN_numproceso,NULL,NULL,tras.sec_reg,GN_error,NULL,CN_uno, tras.num_serie);
         END IF;

    END IF;
   END IF;
   EXIT WHEN c_recup_traspaso%NOTFOUND;
  END LOOP;
END AL_DESVINCULACION_PR;

Procedure AL_ERRORES_KIT_PR(
  EN_proceso IN AL_PROCESOS_MASIVOS_TO.ind_proceso%TYPE,
  EN_num_gen_kit IN AL_CAB_AGREDES_KIT.num_gen_kit%TYPE,
  EN_kit  IN AL_SERIES.cod_articulo%TYPE,
  EN_error IN PLS_INTEGER)
/*
<NOMBRE> : AL_ERRORES_KIT_PR                                                         </NOMBRE>
<FECHACREA> : JUNIO 2004                                                                <FECHACREA/>
<MODULO > : ADMINISTRACION DE INVENTARIO.                                             </MODULO >
<AUTOR > : Marcela Lucero Rozas.                                                     </AUTOR >
<VERSION > : 01                                                                        </VERSION >
<DESCRIPCION>: Actualiza el indicador de Error de los Kit cuyas componentes han tenido  </DESCRIPCION>
<DESCRIPCION>: errores en las diferentes validaciones del proceso de generación         </DESCRIPCION>
<DESCRIPCION>: y/o desvinculacion                                                       </DESCRIPCION>
<FECHAMOD > : DD/MM/YYYY                                                                </FECHAMOD >
<DESCMOD > : Breve descripción de Modificación                                         </DESCMOD >
<ParamEntr>  : EN_proceso Número asociado al proceso de Generación de Kit               </ParamEntr>
<ParamEntr>  : EN_num_gen_kit Número de la Orden                                        </ParamEntr>
<ParamEntr>  : EN_Kit Código de Kit                                                     </ParamEntr>
<ParamEntr>  : EN_error Número de Error                                                 </ParamEntr>
<ParamSal > :                                                                           </ParamEntr>
*/
IS
  CURSOR c_kit (TN_proceso AL_PROCESOS_MASIVOS_TO.ind_proceso%TYPE,
                TN_num_gen_kit AL_CAB_AGREDES_KIT.num_gen_kit%TYPE,
    TN_ind_error AL_PROCESOS_MASIVOS_TO.ind_error%TYPE) IS
  SELECT DISTINCT nro_grupo nro_grupo
  FROM AL_PROCESOS_MASIVOS_TO
  WHERE ind_proceso=TN_proceso
    AND num_proceso=TN_num_gen_kit
 AND ind_error <> TN_ind_error;

CN_uno CONSTANT PLS_INTEGER:=1;
CN_cero CONSTANT PLS_INTEGER:=0;

GN_IndError PLS_INTEGER; --No se puede generar Kit por que hay un componente con error
GN_error PLS_INTEGER:=0;

BEGIN
     BEGIN
         SELECT TO_NUMBER(val_parametro)
      INTO GN_IndError
      FROM GED_PARAMETROS
      WHERE nom_parametro=CV_paramErrKit
        AND cod_modulo=CV_modulo
        AND cod_producto=CN_producto;
  EXCEPTION
    WHEN OTHERS THEN
       NULL;
  END;

     IF GN_error = CN_cero THEN
     FOR RW_cur IN c_kit(EN_proceso,EN_num_gen_kit,CN_cero) LOOP
           UPDATE AL_PROCESOS_MASIVOS_TO a
           SET a.ind_error=GN_IndError
           WHERE a.ind_proceso=EN_proceso
           AND a.num_proceso=EN_num_gen_kit
     AND a.nro_grupo=RW_cur.nro_grupo
     AND a.ind_error=CN_cero ;
        END LOOP;
  END IF;
END AL_ERRORES_KIT_PR;

Procedure AL_VALIDA_CIERRE_GENKIT_PR(
  EN_num_gen_kit IN AL_CAB_AGREDES_KIT.num_gen_kit%TYPE,
  EN_kit  IN AL_SERIES.cod_articulo%TYPE)
/*
<NOMBRE> : AL_VALIDA_CIERRE_GENKIT_PR.                                               </NOMBRE>
<FECHACREA> : JUNIO 2004                                                                <FECHACREA/>
<MODULO > : ADMINISTRACION DE INVENTARIO.                                             </MODULO >
<AUTOR > : Marcela Lucero Rozas.                                                     </AUTOR >
<VERSION > : 01                                                                        </VERSION >
<DESCRIPCION>: Realiza las validaciones necesarias para saber si la orden puede         </DESCRIPCION>
<DESCRIPCION>: cerrarse o no                                                            </DESCRIPCION>
<FECHAMOD > : DD/MM/YYYY                                                                </FECHAMOD >
<DESCMOD > : Breve descripción de Modificación                                         </DESCMOD >
<ParamEntr>  : EN_proceso Número asociado al proceso de Generación de Kit               </ParamEntr>
<ParamEntr>  : EN_num_gen_kit Número de la Orden                                        </ParamEntr>
<ParamSal > : Parámetros de salida de la función   (solo si es función o procedimiento) </ParamEntr>
*/
IS
   CURSOR c_plantillaKit(TN_kit AL_PLANTILLAS_KIT.cod_kit%TYPE) IS
   SELECT a.cod_articulo, can_articulo,
          b.ind_seriado,b.ind_equiacc,b.tip_terminal, 0 stock
   FROM AL_PLANTILLAS_KIT A, AL_ARTICULOS B
   WHERE a.cod_articulo=b.cod_articulo
   AND cod_kit=TN_kit;

   TYPE PlantillaKit IS TABLE OF c_plantillaKit%ROWTYPE;
   PlanKit PlantillaKit:=PlantillaKit();

   CURSOR c_CompKit(TN_num_gen_kit AL_CAB_AGREDES_KIT.num_gen_kit%TYPE) IS
   SELECT b.num_lin,b.num_serie_kit, b.num_ingpar,
       c.cod_articulo,c.can_articulo,
       d.num_serie, d.num_sec_loca, d.PLAN, d.carga, d.num_telefono,d.ind_telefono
   FROM AL_LIN_AGREDES_KIT b , AL_LIN_COMP_AGREDES_KIT c, AL_SER_AGREDES_KIT d
   WHERE b.num_gen_kit=c.num_gen_kit
   AND b.num_lin=c.num_lin
   AND c.num_gen_kit=d.num_gen_kit (+)
   AND c.num_lin=d.num_lin (+)
   AND c.cod_articulo=d.cod_articulo (+)
   AND c.num_gen_kit=TN_num_gen_kit;

   TYPE ComponenteKit IS TABLE OF c_CompKit%ROWTYPE;
   CompoKit ComponenteKit:=ComponenteKit();

   TN_kit  AL_CAB_AGREDES_KIT.cod_kit%TYPE;
   TN_bodega AL_CAB_AGREDES_KIT.cod_bodega%TYPE;
   TN_stock AL_CAB_AGREDES_KIT.tip_stock%TYPE;
   TN_uso AL_CAB_AGREDES_KIT.cod_uso%TYPE;
   TN_estado AL_CAB_AGREDES_KIT.cod_estado%TYPE;
   TN_can_soli AL_CAB_AGREDES_KIT.can_soli%TYPE;
   TN_cod_esol AL_CAB_AGREDES_KIT.cod_esol%TYPE;
   TN_ind_agredes AL_CAB_AGREDES_KIT.cod_esol%TYPE;
   TN_actuacion AL_CAB_AGREDES_KIT.ind_telefono%TYPE;
   TN_can_ingresada AL_CAB_AGREDES_KIT.can_ingresada%TYPE;
   TN_proceso   AL_PROCESOS_MASIVOS_TO.ind_proceso%TYPE:=0;
   TN_can_ArtPlan   AL_PROCESOS_MASIVOS_TO.can_articulos%TYPE:=0;
   TN_can_CompKit   AL_PROCESOS_MASIVOS_TO.can_articulos%TYPE:=0;
   TN_can_Kit       AL_PROCESOS_MASIVOS_TO.can_articulos%TYPE:=0;
   TN_CompKit    AL_PROCESOS_MASIVOS_TO.sec_reg%TYPE:=0;
   TN_ind_ser AL_ARTICULOS.ind_seriado%TYPE;
   TN_ind_equiacc AL_ARTICULOS.ind_equiacc%TYPE;
   TV_terminalKit    AL_ARTICULOS.tip_terminal%TYPE;
   TN_ind_telefono  AL_PROCESOS_MASIVOS_TO.ind_telefono%TYPE;
   TN_sec_reg AL_PROCESOS_MASIVOS_TO.sec_reg%TYPE:=0;
   TV_serie AL_SERIES.num_serie%TYPE;
   TN_can_articulos AL_STOCK.can_stock%TYPE:=0;
   TV_ofic AL_STOCK.cod_plaza%TYPE;
   TN_can_necesito AL_STOCK.can_stock%TYPE;

   GN_error PLS_INTEGER:=0;
   GN_ArtXPlan PLS_INTEGER:=0;
   GN_InPltK PLS_INTEGER:=0;

   CN_cero CONSTANT PLS_INTEGER:=0;
   CN_uno CONSTANT PLS_INTEGER:=0;
   CN_OrdenCerrada CONSTANT PLS_INTEGER:=4;
   CN_Agredes CONSTANT PLS_INTEGER:=0;
   CN_seriado CONSTANT PLS_INTEGER:=1;


   FUNCTION AL_EXISTE_ART_FN (EC_Kit  PlantillaKit, TN_art AL_ARTICULOS.cod_articulo%TYPE)
   RETURN PLS_INTEGER
   IS
   GN_retorno PLS_INTEGER:=0;
   TN_indiceCK1 AL_PROCESOS_MASIVOS_TO.sec_reg%TYPE;
   BEGIN
       FOR TN_indiceCK1 IN EC_Kit.FIRST .. EC_Kit.LAST LOOP
         IF TN_art = EC_Kit(TN_indiceCK1).cod_articulo THEN
           GN_retorno:=TN_indiceCK1;
        EXIT;
         END IF;
       END LOOP;
   RETURN GN_retorno; -- 0:ERROR, <>0:OK
   END;

   FUNCTION AL_SEC_REG_FN(TN_InProceso AL_PROCESOS_MASIVOS_TO.ind_proceso%TYPE,
                          TN_NumProceso AL_PROCESOS_MASIVOS_TO.num_proceso%TYPE)
   RETURN AL_PROCESOS_MASIVOS_TO.sec_reg%TYPE
   IS
    GN_retorno AL_PROCESOS_MASIVOS_TO.sec_reg%TYPE:=0;
   BEGIN
           SELECT NVL(MAX(sec_reg),0)
        INTO GN_retorno
        FROM AL_PROCESOS_MASIVOS_TO
        WHERE ind_proceso=TN_InProceso
          AND num_proceso=TN_NumProceso;
     GN_retorno:=GN_retorno+1;
   RETURN GN_retorno;
   END;

BEGIN
     BEGIN
      Al_Proc_Movto.p_obtener_oficina_default(TV_ofic);
         SELECT val_parametro
      INTO TN_proceso
      FROM GED_PARAMETROS
      WHERE nom_parametro=CV_paramCierreGenKit
        AND cod_modulo=CV_modulo
        AND cod_producto=CN_producto;
  EXCEPTION
    WHEN OTHERS THEN
      GN_error:=13; --Problemas de Parametros
         al_proceso_erroreskit_pr(TN_proceso,EN_num_gen_kit, EN_kit, NULL, CN_uno, GN_error, CV_paramCierreGenKit,CN_cero);
  END;

  IF GN_error=CN_cero THEN
        BEGIN
            SELECT cod_kit, cod_bodega, tip_stock, cod_uso, cod_estado, can_soli, cod_esol,
             ind_agredes,ind_telefono, can_ingresada
         INTO TN_kit,TN_bodega,TN_stock,TN_uso,TN_estado,TN_can_soli,TN_cod_esol,
           TN_ind_agredes, TN_actuacion,TN_can_ingresada
         FROM AL_CAB_AGREDES_KIT
         WHERE num_gen_kit=EN_num_gen_kit
      FOR UPDATE;
     EXCEPTION
      WHEN NO_DATA_FOUND THEN
        GN_error:=1; --Numero de Orden No existe
           al_proceso_erroreskit_pr(TN_proceso,EN_num_gen_kit, EN_kit, NULL, CN_uno, GN_error, NULL,CN_cero);
      WHEN OTHERS THEN
        GN_error:=2; --Problemas al recuperar información de la Orden
           al_proceso_erroreskit_pr(TN_proceso,EN_num_gen_kit, EN_kit, NULL, CN_uno, GN_error, NULL,CN_cero);
        END ;

     IF GN_error=CN_cero THEN
        IF TN_cod_esol=CN_OrdenCerrada THEN
           GN_error:=3; --Orden ya está cerrada
              al_proceso_erroreskit_pr(TN_proceso,EN_num_gen_kit, EN_kit, NULL, CN_uno, GN_error, NULL,CN_cero);
        ELSE
           IF TN_ind_agredes<>CN_Agredes THEN
              GN_error:=4; --Orden no corresponde a una generacion de Kit
                 al_proceso_erroreskit_pr(TN_proceso,EN_num_gen_kit, EN_kit, NULL, CN_uno, GN_error, NULL,CN_cero);
           ELSE
           IF TN_kit<>EN_kit THEN
                 GN_error:=5;
                    al_proceso_erroreskit_pr(TN_proceso,EN_num_gen_kit, EN_kit, NULL, CN_uno, GN_error, NULL,CN_cero);
        ELSE
                     BEGIN
                FOR RW_PlanKit IN c_plantillaKit(EN_kit) LOOP
                             PlanKit.EXTEND;
                             PlanKit(PlanKit.COUNT):=RW_PlanKit;
                         END LOOP;

          FOR RW_Comp IN c_CompKit(EN_num_gen_kit) LOOP
                             CompoKit.EXTEND;
                             CompoKit(CompoKit.COUNT):=RW_Comp;
                         END LOOP;

       TN_can_ArtPlan:=PlanKit.COUNT;
                         TN_can_CompKit:=CompoKit.COUNT;
            EXCEPTION
              WHEN OTHERS THEN
                GN_error:=6;
          al_proceso_erroreskit_pr(TN_proceso,EN_num_gen_kit, EN_kit, NULL, CN_uno, GN_error, NULL,CN_cero);
                     END;
            IF GN_error=CN_cero THEN
         IF TN_can_CompKit=CN_cero THEN
                  GN_error:=8;
            al_proceso_erroreskit_pr(TN_proceso,EN_num_gen_kit, EN_kit, NULL, CN_uno, GN_error, TO_CHAR((TN_can_soli-TN_can_Kit)),CN_cero);
      ELSE
             TN_can_Kit:= TRUNC((TN_can_CompKit/TN_can_ArtPlan));
             IF TN_can_Kit<>TN_can_soli THEN
                      GN_error:=7;
                al_proceso_erroreskit_pr(TN_proceso,EN_num_gen_kit, EN_kit, NULL, CN_uno, GN_error, TO_CHAR((TN_can_soli-TN_can_Kit)),CN_cero);
          ELSE
             FOR TN_CompKit IN CompoKit.FIRST..CompoKit.LAST LOOP
                          GN_InPltK:=al_existe_art_fn(PlanKit,CompoKit(TN_CompKit).cod_articulo);
          IF GN_InPltK<>CN_cero THEN
             TN_ind_ser:=PlanKit(GN_InPltK).ind_seriado;
                                     TN_ind_equiacc:=PlanKit(GN_InPltK).ind_equiacc ;
                                     TV_terminalKit:=PlanKit(GN_InPltK).tip_terminal;
                             IF TN_ind_ser = CN_seriado THEN
                             IF CompoKit(TN_CompKit).num_serie IS NULL THEN
                                  GN_error:=9;
                TN_sec_reg:=al_sec_reg_fn(TN_proceso,EN_num_gen_kit);
                            al_proceso_erroreskit_pr(TN_proceso,EN_num_gen_kit, EN_kit,CompoKit(TN_CompKit).cod_articulo , TN_sec_reg, GN_error, CompoKit(TN_CompKit).num_serie_kit,CN_cero,CompoKit(TN_CompKit).num_serie);
                ELSE
                                        BEGIN
                                               SELECT num_serie
                                 INTO  TV_serie
                                               FROM AL_SERIES
                                               WHERE num_serie=CompoKit(TN_CompKit).num_serie
              AND cod_articulo=CompoKit(TN_CompKit).cod_articulo
                                               AND cod_bodega=TN_bodega
                                               AND tip_stock= TN_stock
                                               AND cod_uso= TN_uso
                                               AND cod_estado= TN_estado
                                               AND ind_telefono=CompoKit(TN_CompKit).ind_telefono;
                                            EXCEPTION
                                  WHEN OTHERS THEN
               GN_error:=11;
                     TN_sec_reg:=al_sec_reg_fn(TN_proceso,EN_num_gen_kit);
                                 al_proceso_erroreskit_pr(TN_proceso,EN_num_gen_kit, EN_kit,CompoKit(TN_CompKit).cod_articulo , TN_sec_reg, GN_error, CompoKit(TN_CompKit).num_serie_kit,CN_cero,CompoKit(TN_CompKit).num_serie);
                                END ;
             END IF;
                   ELSE
                             IF CompoKit(TN_CompKit).num_serie IS NOT NULL THEN
                                  GN_error:=10;
                TN_sec_reg:=al_sec_reg_fn(TN_proceso,EN_num_gen_kit);
                            al_proceso_erroreskit_pr(TN_proceso,EN_num_gen_kit, EN_kit,CompoKit(TN_CompKit).cod_articulo , TN_sec_reg, GN_error, CompoKit(TN_CompKit).num_serie_kit,CN_cero,CompoKit(TN_CompKit).num_serie);
             ELSE
                                           BEGIN
                                        SELECT can_stock
                                        INTO TN_can_articulos
                                        FROM AL_STOCK
                                        WHERE cod_bodega=TN_bodega
                                          AND tip_stock=TN_stock
                                       AND cod_articulo=CompoKit(TN_CompKit).cod_articulo
                                       AND cod_uso=TN_uso
                                       AND cod_estado=TN_estado
                                       AND cod_plaza=TV_ofic
                                       AND num_desde=CN_cero;
                                      EXCEPTION
                                      WHEN OTHERS THEN
                                      TN_can_articulos:=0;
                                      END;

             TN_can_necesito:=PlanKit(GN_InPltK).can_articulo * TN_can_soli;
             IF TN_can_articulos < TN_can_necesito THEN
                                     GN_error:=12;
                   TN_sec_reg:=al_sec_reg_fn(TN_proceso,EN_num_gen_kit);
                               al_proceso_erroreskit_pr(TN_proceso,EN_num_gen_kit, EN_kit,CompoKit(TN_CompKit).cod_articulo , TN_sec_reg, GN_error, CompoKit(TN_CompKit).num_serie_kit,CN_cero,CompoKit(TN_CompKit).num_serie);
             END IF;
             END IF;
             END IF;
             END IF;
             END LOOP;
          END IF;
      END IF;
            END IF;
           END IF;
           END IF;
        END IF;
        END IF;
 END IF;
END AL_VALIDA_CIERRE_GENKIT_PR;

Procedure AL_CIERRE_DESVINCULACION_PR(
    EN_num_gen_kit IN  AL_CAB_AGREDES_KIT.NUM_GEN_KIT%TYPE)
IS
/*
<NOMBRE> : AL_CIERRE_DESVINCULACION_PR>
<FECHACREA> :  Junio 2004>
<MODULO > : ADMINISTRACION DE INVENTARIO. </MODULO >
<AUTOR > : Maritza Tapia Alvarez. </AUTOR >
<VERSION > : 01</VERSION >
<DESCRIPCION> : Proceso que realiza el cierre de desvinculación</DESCRIPCION>
<FECHAMOD > : DD/MM/YYYY </FECHAMOD >
<DESCMOD > : Breve descripción de Modificación </DESCMOD >
<ParamEntr> : Parámetros de entrada de la función  (solo si es función o procedimiento) </ParamEntr>
<ParamSal > : Parámetros de salida de la función    (solo si es función o procedimiento) </ParamEntr>
*/
CN_cero CONSTANT PLS_INTEGER:=0;
GN_error PLS_INTEGER:=0;
GN_count PLS_INTEGER:=0;
GN_contador PLS_INTEGER:=0;
GN_secreg  PLS_INTEGER:=1;
GN_total   PLS_INTEGER:=0;
GV_serie   AL_PROCESOS_MASIVOS_TO.NUM_SERIE%TYPE;
TV_estado  AL_CAB_AGREDES_KIT.COD_ESOL%TYPE;
GN_IndError AL_PROCESOS_MASIVOS_TO.IND_PROCESO%TYPE;
TN_cod_bodega AL_CAB_AGREDES_KIT.COD_BODEGA%TYPE;
CV_paramt CONSTANT VARCHAR2(20):='CIERRE_DESKIT';
TV_serie   AL_SERIES.NUM_SERIE%TYPE;
GN_cod_bodega AL_BODEGAS.COD_BODEGA%TYPE;


CURSOR c_recup_traspaso IS
    SELECT  num_serie_kit
        ,num_lin
    FROM AL_LIN_AGREDES_KIT
    WHERE num_gen_kit = EN_num_gen_kit
    ORDER BY num_serie_kit
    FOR UPDATE;

BEGIN
   BEGIN
          SELECT TO_NUMBER(val_parametro)
       INTO GN_IndError
       FROM GED_PARAMETROS
       WHERE nom_parametro= CV_paramt
          AND cod_modulo = CV_modulo
          AND cod_producto = CN_producto;
   EXCEPTION
       WHEN OTHERS THEN
             NULL;
   END;


         BEGIN
       SELECT  COUNT(num_serie_kit)
      INTO    GN_count
      FROM    AL_LIN_AGREDES_KIT
      WHERE   num_gen_kit = EN_num_gen_kit;

      EXCEPTION
          WHEN OTHERS THEN
          GN_error:=1;
       AL_PROCESO_ERRORESKIT_PR(GN_IndError ,EN_num_gen_kit, NULL, NULL, GN_secreg , GN_error , 'Error en rescatar la cantidad de AL_LIN_AGREDES_KIT', CN_cero );
       GN_secreg := GN_secreg + 1;
   END;

         BEGIN
      SELECT a.cod_bodega
      INTO  TN_cod_bodega
       FROM  AL_CAB_AGREDES_KIT a
               WHERE a.num_gen_kit = EN_num_gen_kit;

      EXCEPTION
          WHEN OTHERS THEN
          GN_error:=7;
       AL_PROCESO_ERRORESKIT_PR(GN_IndError ,EN_num_gen_kit, NULL, NULL, GN_secreg , GN_error , 'Error en rescatar la cantidad de AL_LIN_AGREDES_KIT', CN_cero );
       GN_secreg := GN_secreg + 1;
   END;

   FOR tras IN c_recup_traspaso LOOP

     GN_total    := GN_total + 1;
     /** Verifico que existan las series **/
     BEGIN
       SELECT  a.num_serie, a.cod_bodega
       INTO TV_serie, GN_cod_bodega
       FROM AL_SERIES a
       WHERE num_serie = tras.num_serie_kit;

     EXCEPTION
          WHEN OTHERS THEN
               GN_error:=2;
          AL_PROCESO_ERRORESKIT_PR(GN_IndError ,EN_num_gen_kit, NULL, NULL, GN_secreg, GN_error, 'Error al rescatar la cantidad de AL_SERIES', CN_cero, tras.num_serie_kit, GN_total );
           GN_contador := GN_contador - 1;
          GN_secreg := GN_secreg + 1;
     END;
     IF GN_cod_bodega = TN_cod_bodega THEN
       IF TV_serie IS NOT NULL AND GN_error = CN_cero THEN
           GN_error:= AL_DESKIT_COMPONENTES_FN(tras.num_serie_kit);
           IF GN_error <> CN_cero THEN
            BEGIN
              IF GN_error= 2 THEN
               GN_error:=10;
               AL_PROCESO_ERRORESKIT_PR(GN_IndError ,EN_num_gen_kit, NULL, NULL, GN_secreg , GN_error , 'Error en desvinculación',  CN_cero, tras.num_serie_kit, GN_total );
           ELSE
               GN_error:=6;
               AL_PROCESO_ERRORESKIT_PR(GN_IndError ,EN_num_gen_kit, NULL, NULL, GN_secreg , GN_error , 'Error en desvinculación',  CN_cero, tras.num_serie_kit, GN_total );
           END IF;
           GN_contador := GN_contador + 1;

             --1.-Eliminar todas las series asociadas al Kit (Identificado por el Número de Linea de Kit)
           DELETE AL_SER_AGREDES_KIT
           WHERE  num_gen_kit = EN_num_gen_kit
           AND    num_lin  =  tras.num_lin;

           --2.-Eliminar todos los componentes del Kit
           DELETE AL_LIN_COMP_AGREDES_KIT
           WHERE  num_gen_kit = EN_num_gen_kit
           AND    num_lin  = tras.num_lin;

           --3.-Eliminar el Kit (Linea de Kit)
              DELETE AL_LIN_AGREDES_KIT
              WHERE  num_gen_kit = EN_num_gen_kit
           AND    num_serie_kit = tras.num_serie_kit;

           EXCEPTION
             WHEN OTHERS THEN
               GN_error:=3;
               AL_PROCESO_ERRORESKIT_PR(GN_IndError ,EN_num_gen_kit, NULL, NULL, GN_secreg , GN_error , 'Error en eliminación de la desvinculación',  CN_cero, tras.num_serie_kit, GN_total );
            GN_contador := GN_contador - 1;
            GN_secreg := GN_secreg + 1;
           END;
           END IF;
       ELSE
           GN_error:=9;
           AL_PROCESO_ERRORESKIT_PR(GN_IndError ,EN_num_gen_kit, NULL, NULL, GN_secreg , GN_error , 'Error en eliminación de la desvinculación',  CN_cero, tras.num_serie_kit, GN_total );

          END IF;
     ELSE
         GN_error:=8;
         AL_PROCESO_ERRORESKIT_PR(GN_IndError ,EN_num_gen_kit, NULL, NULL, GN_secreg , GN_error , 'Error en eliminación de la desvinculación',  CN_cero, tras.num_serie_kit, GN_total );
     END IF;
  EXIT WHEN c_recup_traspaso%NOTFOUND;
  END LOOP;

  IF GN_count = GN_contador THEN
     BEGIN
      DELETE AL_CAB_AGREDES_KIT
      WHERE num_gen_kit =  EN_num_gen_kit;
           EXCEPTION
     WHEN OTHERS THEN
                GN_error:=4;
           AL_PROCESO_ERRORESKIT_PR(GN_IndError ,EN_num_gen_kit, NULL, NULL, GN_secreg , GN_error , 'Error update de AL_CAB_AGREDES_KIT',  CN_cero, EN_cantidad=>GN_total );
     END;
  ELSE
     BEGIN
      UPDATE AL_CAB_AGREDES_KIT
         SET cod_esol = 1
         WHERE num_gen_kit = EN_num_gen_kit;
           EXCEPTION
     WHEN OTHERS THEN
                GN_error:=5;
           AL_PROCESO_ERRORESKIT_PR(GN_IndError ,EN_num_gen_kit, NULL, NULL, GN_secreg , GN_error , 'Error insert de AL_CAB_AGREDES_KIT', CN_cero, EN_cantidad=>GN_total );
     END;

  END IF;

END AL_CIERRE_DESVINCULACION_PR;

FUNCTION AL_DESKIT_COMPONENTES_FN(
  EN_serie_kit  AL_SERIES.num_serie%TYPE)
RETURN PLS_INTEGER
/*
<NOMBRE> : AL_DESKIT_COMPONENTES_FN                                                     </NOMBRE>
<FECHACREA> : JUNIO 2004                                                                <FECHACREA/>
<MODULO > : ADMINISTRACION DE INVENTARIO.                                             </MODULO >
<AUTOR > : Maritza Tapia A                                                     </AUTOR >
<VERSION > : 01                                                                        </VERSION >
<DESCRIPCION>: Validacion de los componentes  del KIt                                   </DESCRIPCION>
<FECHAMOD > : DD/MM/YYYY                                                                </FECHAMOD >
<DESCMOD > : Breve descripción de Modificación                                         </DESCMOD >
<ParamEntr>  : EN_proceso Número asociado al proceso de Generación de Kit               </ParamEntr>
<ParamEntr>  : EN_Kit Código de Kit                                                     </ParamEntr>
<ParamSal > :                                                                           </ParamEntr>
*/
IS

   CURSOR c_plantillaKit(TN_kit AL_PLANTILLAS_KIT.cod_kit%TYPE) IS
   SELECT a.cod_articulo AS articulo
     , a.can_articulo AS cantidad
        , b.ind_seriado AS seriado
   FROM   AL_PLANTILLAS_KIT a, AL_ARTICULOS b
   WHERE  a.cod_articulo=b.cod_articulo
   AND    cod_kit=TN_kit;


   CURSOR c_Componentes(TN_cod_articulo AL_COMPONENTE_KIT.cod_articulo%TYPE) IS
   SELECT a.num_serie, a.can_articulo, a.num_telefono
   FROM   AL_COMPONENTE_KIT a
   WHERE  a.num_kit = EN_serie_kit
   AND    a.cod_articulo  = TN_cod_articulo;



   GN_error PLS_INTEGER:=0;
   CN_cero CONSTANT PLS_INTEGER:=0;
   GN_seriado PLS_INTEGER:=1;
   CN_uno CONSTANT PLS_INTEGER:=1;
   CN_OK CONSTANT PLS_INTEGER:=0;
   CN_seriado CONSTANT PLS_INTEGER:=1;
   TN_serie AL_COMPONENTE_KIT.num_serie%TYPE;
   TN_can_articulo AL_COMPONENTE_KIT.CAN_ARTICULO%TYPE;
   TN_kit  AL_SERIES.cod_articulo%TYPE;
   TN_telefono AL_SERIES.NUM_TELEFONO%TYPE;
   GN_count PLS_INTEGER:=0;


BEGIN
  /*validación en la al_serie y obtengo cod_articulo*/
  BEGIN
     SELECT DISTINCT a.cod_articulo
  INTO   TN_kit
  FROM AL_SERIES A,AL_COMPONENTE_KIT B
     WHERE a.num_serie = EN_serie_kit
     AND   a.num_serie = b.num_kit;

  EXCEPTION
        WHEN OTHERS THEN
     GN_error:=1;
     RETURN GN_error;

     END;

  IF GN_error = CN_cero THEN

   FOR plantilla IN c_plantillaKit(TN_kit)  LOOP
   GN_seriado := plantilla.seriado;
       FOR componentes IN c_Componentes(plantilla.articulo)  LOOP
     TN_serie := componentes.num_serie;
    TN_telefono := componentes.num_telefono;
        IF  TN_telefono IS NOT NULL THEN
        BEGIN
         SELECT COUNT(num_telefono)
         INTO   GN_count
         FROM AL_SERIES a
         WHERE num_telefono = TN_telefono;
        EXCEPTION
                WHEN OTHERS THEN
             GN_error:=2;
          RETURN GN_error;
        END;
        IF GN_count > 0 THEN
           GN_error:=1;
        EXIT;
        END IF;
     END IF;


     IF TN_serie >0 AND GN_seriado = CN_cero THEN -- o seriado Tiene serie asociada
         GN_error:=1;
         EXIT;
     ELSE
       IF TN_serie = 0 AND plantilla.seriado = CN_uno THEN -- Seriado no tiene serie asociada
         GN_error:=1;
         EXIT;
       END IF;
     END IF;

     TN_can_articulo := TN_can_articulo + componentes.can_articulo ;


     EXIT WHEN c_plantillaKit%NOTFOUND;
    END LOOP;

    IF TN_can_articulo <> plantilla.cantidad  THEN
     GN_error:=1;
     EXIT;
    END IF;
  EXIT WHEN c_plantillaKit%NOTFOUND;
  END LOOP;
 END IF;
RETURN GN_error;
END AL_DESKIT_COMPONENTES_FN;


Procedure AL_CONSULTA_KIT_PR(
    EN_indproceso IN  AL_PROCESOS_MASIVOS_TO.IND_PROCESO%TYPE,
       EN_numproceso IN  AL_PROCESOS_MASIVOS_TO.NUM_PROCESO%TYPE,
    EN_bodega   IN AL_BODEGAS.cod_bodega%TYPE,
    EN_tipo PLS_INTEGER
    )
IS
/*
<NOMBRE> : AL_VALIDA_SERIE_FN</NOMBRE>
<FECHACREA> : JUNIO 2004<FECHACREA/>
<MODULO > : ADMINISTRACION DE INVENTARIO </MODULO >
<AUTOR > : Maritza Tapia Alvarez. </AUTOR >
<VERSION > : 01</VERSION >
<DESCRIPCION> : consulta si las series ingresadas existen en activo o historicos </DESCRIPCION>
<FECHAMOD > : DD/MM/YYYY </FECHAMOD >
<DESCMOD > : Breve descripción de Modificación </DESCMOD >
<ParamEntr> : Parámetros de entrada de la función  (solo si es función o procedimiento) </ParamEntr>
<ParamSal > : Parámetros de salida de la función    (solo si es función o procedimiento) </ParamEntr>
*/

CN_uno CONSTANT PLS_INTEGER:=1;
CN_cero CONSTANT PLS_INTEGER:=0;
GN_error PLS_INTEGER:=0;
GN_count PLS_INTEGER:=0;
GN_existeserie PLS_INTEGER:=0;
GN_contador PLS_INTEGER:=1;
GV_serie    AL_PROCESOS_MASIVOS_TO.NUM_SERIE%TYPE;
TN_articulo AL_ARTICULOS.COD_ARTICULO%TYPE;
TN_codigo_kit AL_COMPONENTE_KIT.cod_kit%TYPE;
TN_codigo_bod AL_COMPONENTE_KIT.cod_bodega%TYPE;
TV_fecha AL_PROCESOS_MASIVOS_TO.observaciones%TYPE;
TV_precio AL_PROCESOS_MASIVOS_TO.observaciones%TYPE;
CV_formatofecha GED_PARAMETROS.val_parametro%TYPE;
CV_parametro GED_PARAMETROS.nom_parametro%TYPE:='FORMATO_SEL2';
CV_moduloGe GED_PARAMETROS.cod_modulo%TYPE:='GE';



CURSOR c_recup_traspaso IS
          SELECT  cod_articulo_ppal /*cod kit*/
       , num_serie
    , sec_reg
       FROM   AL_PROCESOS_MASIVOS_TO
       WHERE  ind_proceso = EN_indproceso
       AND    num_proceso = EN_numproceso
      ORDER BY num_serie;
BEGIN

        BEGIN
       SELECT val_parametro
    INTO CV_formatofecha
    FROM GED_PARAMETROS
    WHERE cod_modulo=CV_moduloGe
       AND cod_producto=CN_uno
            AND nom_parametro=CV_parametro;
    EXCEPTION
      WHEN OTHERS THEN
       GN_error:=1;
    AL_PROCESO_ERRORESKIT_PR(EN_indproceso ,EN_numproceso, NULL, NULL, 1 , GN_error , NULL,  CN_uno,CV_parametro  );
       END ;


  FOR tras IN c_recup_traspaso LOOP
  GN_existeserie := 1;
  IF tras.num_serie IS NOT NULL OR tras.num_serie <> '' THEN
     IF GN_contador = 1 THEN
     GV_serie := tras.num_serie;
     ELSE
     IF GV_serie = tras.num_serie THEN
     GN_existeserie := 0;
     GN_error:=1;
     AL_PROCESO_ERRORESKIT_PR(EN_indproceso ,EN_numproceso, NULL, NULL, tras.sec_reg , GN_error , NULL,  CN_uno,  tras.num_serie );
     ELSE
     GV_serie := tras.num_serie;
        END IF;
     END IF;

    GN_contador := GN_contador + 1;

  /** Verifico que existan las series **/
    IF GN_existeserie = 1 THEN
       IF EN_tipo = CN_cero THEN

     /*ACTIVOS*/
         BEGIN
                 SELECT cod_articulo, cod_bodega,TO_CHAR(fec_entrada,CV_formatofecha), TO_CHAR(prc_compra)
                          INTO TN_codigo_kit,TN_codigo_bod,TV_fecha,TV_precio
                    FROM AL_SERIES
                    WHERE num_serie=tras.num_serie;

               EXCEPTION
               WHEN OTHERS THEN
                GN_error:=3;
            AL_PROCESO_ERRORESKIT_PR(EN_indproceso ,EN_numproceso, NULL, NULL, tras.sec_reg , GN_error , NULL,  CN_uno,  tras.num_serie );
               END;

       BEGIN
           GN_count:=0;
            SELECT COUNT(a.num_serie)
        INTO   GN_count
           FROM AL_SERIES a
           WHERE a.cod_bodega = EN_bodega
             AND a.num_serie = tras.num_serie;

      IF GN_count = 0 THEN
        GN_error:=2;
        AL_PROCESO_ERRORESKIT_PR(EN_indproceso ,EN_numproceso, NULL, NULL, tras.sec_reg , GN_error , NULL,  CN_uno,  tras.num_serie );
      END IF;

      EXCEPTION
          WHEN OTHERS THEN
           GN_error:=3;
        AL_PROCESO_ERRORESKIT_PR(EN_indproceso ,EN_numproceso, NULL, NULL, tras.sec_reg , GN_error , NULL,  CN_uno,  tras.num_serie );
      END;

      ELSE
     /*HISTORICOS*/
         BEGIN
                 SELECT a.cod_kit, a.cod_bodega,TO_CHAR(a.fec_entrada,CV_formatofecha), TO_CHAR(SUM(a.prc_compra))
                          INTO TN_codigo_kit,TN_codigo_bod,TV_fecha,TV_precio
                    FROM AL_COMPONENTE_KIT a
                    WHERE a.num_kit=tras.num_serie
        --AND NOT EXISTS (SELECT 1 FROM AL_SERIES B WHERE b.num_serie = a.num_kit)
        GROUP BY a.cod_kit, a.cod_bodega,TO_CHAR(a.fec_entrada,CV_formatofecha);

               EXCEPTION
               WHEN OTHERS THEN
                GN_error:=3;
            AL_PROCESO_ERRORESKIT_PR(EN_indproceso ,EN_numproceso, NULL, NULL, tras.sec_reg , GN_error , NULL,  CN_uno,  tras.num_serie );
               END;
      BEGIN
           GN_count:=0;
        SELECT COUNT(a.num_kit)
        INTO   GN_count
        FROM AL_COMPONENTE_KIT a
        WHERE a.num_kit = tras.num_serie
       AND NOT EXISTS (SELECT 1 FROM AL_SERIES B WHERE b.num_serie = a.num_kit);

      IF GN_count = 0 THEN
        GN_error:=2;
        AL_PROCESO_ERRORESKIT_PR(EN_indproceso ,EN_numproceso, NULL, NULL, tras.sec_reg , GN_error , NULL,  CN_uno,  tras.num_serie );
      END IF;


      EXCEPTION
       WHEN OTHERS THEN
        GN_error:=5;
        AL_PROCESO_ERRORESKIT_PR(EN_indproceso ,EN_numproceso, NULL, NULL, tras.sec_reg , GN_error , NULL,  CN_uno,  tras.num_serie );
      END;
     END IF;


                 BEGIN
                    UPDATE AL_PROCESOS_MASIVOS_TO
                    SET cod_articulo_ppal=TN_codigo_kit,
               can_solicitada=TN_codigo_bod,
               observaciones=TV_fecha||'|'||TV_precio
                    WHERE ind_proceso=EN_indproceso
                    AND num_proceso=EN_numproceso
                    AND sec_reg=tras.sec_reg;

              EXCEPTION
              WHEN OTHERS THEN
               GN_error:=7;
               AL_PROCESO_ERRORESKIT_PR(EN_indproceso ,EN_numproceso, NULL, NULL, tras.sec_reg , GN_error , NULL,  CN_uno,  tras.num_serie );
              END;


    END IF;
     END IF;
 END LOOP;

END AL_CONSULTA_KIT_PR;

END Al_Pac_Kit; 
/
SHOW ERRORS