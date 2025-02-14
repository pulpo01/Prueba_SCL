CREATE OR REPLACE PACKAGE BODY ve_tipificacion_pg AS
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   FUNCTION ve_val_numero_fn (
      ev_numero        IN  VARCHAR2,
      sn_cod_retorno    OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno   OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
      sn_num_evento     OUT NOCOPY ge_errores_pg.evento
   )RETURN BOOLEAN
   IS
      lv_des_error    VARCHAR2(300);
      lv_sql          VARCHAR2(1000);
      validaNumber    NUMBER;
   BEGIN

      sn_cod_retorno := 0;
      sv_mens_retorno := '';
      sn_num_evento := 0;

      lv_sql := 'TO_NUMBER('||ev_numero||')';
        validaNumber := TO_NUMBER(ev_numero);

      RETURN TRUE;

      EXCEPTION
    WHEN OTHERS THEN
         sn_cod_retorno  := 302000;
         sv_mens_retorno := 'Error al validar numero';
         lv_des_error      := 've_tipificacion_pg.ve_tipificacion_pg() - ' || SQLERRM;
           sn_num_evento      := ge_errores_pg.grabarpl (sn_num_evento, cv_modulove, sv_mens_retorno, cv_version, USER, 've_tipificacion_pg.ve_tipificacion_pg()', lv_sql, SQLCODE, SQLERRM);
         RETURN FALSE;
END ve_val_numero_fn;

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   FUNCTION ve_val_serie_kit_fn (
      ev_num_serie      IN  al_series.num_serie%TYPE,
      ev_num_venta      IN  ga_ventas.num_venta%TYPE,
      sv_num_celular    OUT NOCOPY ga_aboamist.num_celular%TYPE,
      sn_cod_retorno    OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno   OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
      sn_num_evento     OUT NOCOPY ge_errores_pg.evento
   )RETURN BOOLEAN
   IS
      lv_des_error    VARCHAR2(300);
      lv_sql          VARCHAR2(1000);
   BEGIN

      sn_cod_retorno := 0;
      sv_mens_retorno := '';
      sn_num_evento := 0;

      SELECT c.num_telefono
          INTO sv_num_celular
        FROM al_movimientos a, al_articulos b, al_componente_kit c
       WHERE num_transaccion = ev_num_venta
         AND tip_movimiento = 3
         AND a.num_serie = ev_num_serie
         AND b.cod_articulo = a.cod_articulo
         AND b.tip_articulo = 20
         AND c.num_kit = a.num_serie
         AND c.num_telefono is not null;

      RETURN TRUE;

      EXCEPTION
    WHEN NO_DATA_FOUND THEN
         sv_num_celular := '';
         RETURN FALSE;

    WHEN OTHERS THEN
         sn_cod_retorno  := 30000;
         sv_mens_retorno := 'Error al intentar recuperar impuestos';
         lv_des_error      := 've_tipificacion_pg.ve_tipificacion_pg() - ' || SQLERRM;
           sn_num_evento      := ge_errores_pg.grabarpl (sn_num_evento, cv_modulove, sv_mens_retorno, cv_version, USER, 've_tipificacion_pg.ve_tipificacion_pg()', lv_sql, SQLCODE, SQLERRM);
         RETURN FALSE;
END ve_val_serie_kit_fn;

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   FUNCTION ve_verificarAccesorio_fn (
      ev_cod_articulo      IN  al_articulos.COD_ARTICULO%TYPE,
      sn_cod_retorno    OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno   OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
      sn_num_evento     OUT NOCOPY ge_errores_pg.evento
   )RETURN BOOLEAN
   IS
      lv_des_error    VARCHAR2(300);
      lv_sql          VARCHAR2(1000);
      ln_count        NUMBER;
   BEGIN

      sn_cod_retorno := 0;
      sv_mens_retorno := '';
      sn_num_evento := 0;

        lv_sql:= 'SELECT des_articulo,ind_equiacc '
      ||'FROM    al_articulos '
      ||'WHERE     cod_articulo = '||ev_cod_articulo||'';

     SELECT count(1) into ln_count
     FROM    al_articulos a
     WHERE     cod_articulo = ev_cod_articulo
     AND UPPER(a.IND_EQUIACC) = 'A';

     IF ln_count > 0 THEN
         RETURN TRUE;
     ELSE
        RETURN FALSE;
     END IF;

      EXCEPTION
    WHEN OTHERS THEN
         sn_cod_retorno  := 30000;
         sv_mens_retorno := 'Error al intentar verificar accesorio';
         lv_des_error      := 've_tipificacion_pg.ve_tipificacion_pg() - ' || SQLERRM;
           sn_num_evento      := ge_errores_pg.grabarpl (sn_num_evento, cv_modulove, sv_mens_retorno, cv_version, USER, 've_tipificacion_pg.ve_tipificacion_pg()', lv_sql, SQLCODE, SQLERRM);
         RETURN FALSE;
END ve_verificarAccesorio_fn ;
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   FUNCTION ve_val_serie_sim_fn (
      ev_num_serie      IN  al_series.num_serie%TYPE,
      ev_num_venta      IN  ga_ventas.num_venta%TYPE,
      sv_num_celular    OUT NOCOPY ga_aboamist.num_celular%TYPE,
      sn_cod_retorno    OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno   OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
      sn_num_evento     OUT NOCOPY ge_errores_pg.evento
   )RETURN BOOLEAN
   IS
      lv_des_error    VARCHAR2(300);
      lv_sql          VARCHAR2(1000);
   BEGIN

      sn_cod_retorno := 0;
      sv_mens_retorno := '';
      sn_num_evento := 0;

      SELECT num_celular
        INTO sv_num_celular
        FROM ga_aboamist a
       WHERE a.num_serie = ev_num_serie
         AND a.num_venta = ev_num_venta;

      RETURN TRUE;

      EXCEPTION
    WHEN NO_DATA_FOUND THEN
         sv_num_celular := '';
         RETURN FALSE;


    WHEN OTHERS THEN
         sn_cod_retorno  := 30001;
         sv_mens_retorno := 'Error al intentar recuperar impuestos';
         lv_des_error      := 've_tipificacion_pg.ve_tipificacion_pg() - ' || SQLERRM;
           sn_num_evento      := ge_errores_pg.grabarpl (sn_num_evento, cv_modulove, sv_mens_retorno, cv_version, USER, 've_tipificacion_pg.ve_tipificacion_pg()', lv_sql, SQLCODE, SQLERRM);
         RETURN FALSE;
END ve_val_serie_sim_fn;
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

FUNCTION ve_rec_impuesto_art_fn (en_cod_articulo   IN al_articulos.cod_articulo%TYPE,
                                 sn_imp_itbm       OUT NOCOPY NUMBER,
                                 sn_imp_isc        OUT NOCOPY NUMBER,
                                  sn_cod_retorno    OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                                   sv_mens_retorno   OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                                    sn_num_evento     OUT NOCOPY ge_errores_pg.evento)RETURN BOOLEAN
IS

   lv_des_error    VARCHAR2(300);
   lv_sql          VARCHAR2(1000);

BEGIN

     sn_cod_retorno := 0;
     sv_mens_retorno := '';
     sn_num_evento := 0;

     lv_sql := 'SELECT sum(decode(cod_tipimpues,1,prc_impuesto,0))/100 as ITBM, sum(decode(cod_tipimpues,2,prc_impuesto,0))/100 as ISC FROM al_articulos a, fa_grpserconc b, ge_impuestos c'
            || ' WHERE b.cod_concepto = a.cod_conceptoart AND SYSDATE BETWEEN c.fec_desde AND c.fec_hasta AND sysdate between b.fec_desde and b.fec_hasta AND c.cod_grpservi = b.cod_grpservi'
            || ' AND c.cod_catimpos = 1'
            || ' AND a.cod_articulo = '||en_cod_articulo;

     SELECT sum(decode(cod_tipimpues,1,prc_impuesto,0))/100 as ITBM, sum(decode(cod_tipimpues,2,prc_impuesto,0))/100 as ISC
      INTO sn_imp_itbm, sn_imp_isc
      FROM al_articulos a, fa_grpserconc b, ge_impuestos c
     WHERE b.cod_concepto = a.cod_conceptoart
       AND SYSDATE BETWEEN c.fec_desde AND c.fec_hasta
       AND sysdate between b.fec_desde and b.fec_hasta
       AND c.cod_grpservi = b.cod_grpservi
       AND c.cod_catimpos = 1
       AND a.cod_articulo = en_cod_articulo;

     RETURN TRUE;


EXCEPTION
    WHEN NO_DATA_FOUND THEN
         sn_cod_retorno  := 30002;
         sv_mens_retorno := 'No se encontraron impuestos para el articulo';
         lv_des_error      := 've_tipificacion_pg.ve_tipificacion_pg() - ' || SQLERRM;
           sn_num_evento      := ge_errores_pg.grabarpl (sn_num_evento, cv_modulove, sv_mens_retorno, cv_version, USER, 've_tipificacion_pg.ve_tipificacion_pg()', lv_sql, SQLCODE, SQLERRM);
         RETURN FALSE;

    WHEN OTHERS THEN
         sn_cod_retorno  := 30003;
         sv_mens_retorno := 'Error al intentar recuperar impuestos';
         lv_des_error      := 've_tipificacion_pg.ve_tipificacion_pg() - ' || SQLERRM;
           sn_num_evento      := ge_errores_pg.grabarpl (sn_num_evento, cv_modulove, sv_mens_retorno, cv_version, USER, 've_tipificacion_pg.ve_tipificacion_pg()', lv_sql, SQLCODE, SQLERRM);
         RETURN FALSE;
END ve_rec_impuesto_art_fn;
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
FUNCTION ve_rec_tipificacion_fn (
                                  ev_dato_ingresado IN VARCHAR2,
                                 sn_cod_articulo   OUT NOCOPY ga_tipificacion_td.cod_articulo%TYPE,
                                  sn_cod_retorno    OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                                   sv_mens_retorno   OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                                    sn_num_evento     OUT NOCOPY ge_errores_pg.evento
)RETURN BOOLEAN
IS

lv_des_error    VARCHAR2(300);
lv_sql          VARCHAR2(1000);

BEGIN

     sn_cod_retorno := 0;
     sv_mens_retorno := '';
     sn_num_evento := 0;

     lv_sql := 'SELECT cod_articulo '
              ||'FROM     ga_tipificacion_td '
              ||'WHERE     cod_tipificacion = '||ev_dato_ingresado||''
              ||'AND SYSDATE BETWEEN fecha_desde AND fecha_hasta';

     SELECT cod_articulo
     INTO     sn_cod_articulo
     FROM     ga_tipificacion_td
     WHERE     cod_tipificacion = ev_dato_ingresado;

     RETURN TRUE;


EXCEPTION
    WHEN NO_DATA_FOUND THEN
         sn_cod_articulo := NULL;
         RETURN TRUE;

    WHEN OTHERS THEN
         sn_cod_retorno  := 30004;
         sv_mens_retorno := 'No es posible ejecutar este servicio';
         lv_des_error      := 've_tipificacion_pg.ve_tipificacion_pg() - ' || SQLERRM;
           sn_num_evento      := ge_errores_pg.grabarpl (sn_num_evento, cv_modulove, sv_mens_retorno, cv_version, USER, 've_tipificacion_pg.ve_tipificacion_pg()', lv_sql, SQLCODE, SQLERRM);
         RETURN FALSE;
END ve_rec_tipificacion_fn;
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
FUNCTION ve_rec_articulo_fn (
                             en_cod_articulo   IN  ga_tipificacion_td.cod_articulo%TYPE,
                             sv_des_articulo   OUT NOCOPY al_articulos.des_articulo%TYPE,
                             sv_equiacc           OUT NOCOPY al_articulos.ind_equiacc%TYPE,
                             sv_tip_terminal   OUT NOCOPY al_articulos.tip_terminal%TYPE,
                              sn_cod_retorno    OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                               sv_mens_retorno   OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                                sn_num_evento     OUT NOCOPY ge_errores_pg.evento
)RETURN BOOLEAN
IS

lv_des_error    VARCHAR2(300);
lv_sql          VARCHAR2(1000);
--lv_equiacc        al_articulos.ind_equiacc%TYPE;

BEGIN

     sn_cod_retorno := 0;
     sv_mens_retorno := '';
     sn_num_evento := 0;

     lv_sql:= 'SELECT des_articulo,ind_equiacc '
             ||'FROM    al_articulos '
             ||'WHERE     cod_articulo = '||en_cod_articulo||'';

     SELECT des_articulo,ind_equiacc,tip_terminal
     INTO    sv_des_articulo,sv_equiacc ,sv_tip_terminal
     FROM    al_articulos
     WHERE     cod_articulo = en_cod_articulo;

      RETURN TRUE;

EXCEPTION
    WHEN OTHERS THEN
         sn_cod_retorno  := 30005;
         sv_mens_retorno := 'No es posible ejecutar este servicio';
         lv_des_error      := 've_tipificacion_pg.ve_rec_articulo_fn() - ' || SQLERRM;
           sn_num_evento      := ge_errores_pg.grabarpl (sn_num_evento, cv_modulove, sv_mens_retorno, cv_version, USER, 've_tipificacion_pg.ve_rec_articulo_fn()', lv_sql, SQLCODE, SQLERRM);
         RETURN FALSE;
END ve_rec_articulo_fn;
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
FUNCTION ve_rec_serie_fn (
                          ev_dato_ingresado IN VARCHAR2,
                          sv_num_serie        OUT NOCOPY al_series.num_serie%TYPE,
                          sn_num_telefono    OUT NOCOPY al_series.num_telefono%TYPE,
                          sn_cod_articulo    OUT NOCOPY al_series.cod_articulo%TYPE,
                          sn_tip_stock        OUT NOCOPY al_series.tip_stock%TYPE,
                          sn_cod_uso        OUT NOCOPY al_series.cod_uso%TYPE,
                          sv_tip_terminal   OUT NOCOPY al_articulos.TIP_TERMINAL%TYPE,
                          sv_equi_acc        OUT NOCOPY al_articulos.IND_EQUIACC%TYPE,
                           sv_descripccion    OUT NOCOPY al_articulos.DES_ARTICULO%TYPE,
                           sn_cod_retorno    OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                            sv_mens_retorno   OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                             sn_num_evento     OUT NOCOPY ge_errores_pg.evento
)RETURN BOOLEAN
IS

lv_des_error    VARCHAR2(300);
lv_sql          VARCHAR2(1000);

BEGIN

     sn_cod_retorno := 0;
     sv_mens_retorno := '';
     sn_num_evento := 0;

     lv_sql := 'SELECT num_serie,num_telefono, cod_articulo,tip_stock,cod_uso '
              ||'FROM    al_series '
              ||'WHERE  num_serie = '||ev_dato_ingresado||'';

     DBMS_OUTPUT.Put_Line(lv_sql);


     SELECT a.num_serie,a.num_telefono,a.cod_articulo,a.tip_stock,a.cod_uso ,b.TIP_TERMINAL, b.IND_EQUIACC, b.DES_ARTICULO
     INTO     sv_num_serie,sn_num_telefono,sn_cod_articulo,sn_tip_stock,sn_cod_uso,  sv_tip_terminal, sv_equi_acc,sv_descripccion
     FROM    al_series a, al_articulos b
     WHERE  a.num_serie = ev_dato_ingresado
     AND    a.COD_ARTICULO = b.COD_ARTICULO
     AND    a.TIP_STOCK = 2;

     DBMS_OUTPUT.Put_Line('ve_rec_serie_fn -- num_serie ['||sv_num_serie||']');
     DBMS_OUTPUT.Put_Line('ve_rec_serie_fn -- num_telefono ['||sn_num_telefono||']');
     DBMS_OUTPUT.Put_Line('ve_rec_serie_fn -- cod_articulo ['||sn_cod_articulo||']');
     DBMS_OUTPUT.Put_Line('ve_rec_serie_fn -- tip_stock ['||sn_tip_stock||']');
     DBMS_OUTPUT.Put_Line('ve_rec_serie_fn -- cod_uso ['||sn_cod_uso||']');
     
     
     --Cuando Es un Terminal que no es prepago hay que hacerle el cambio de uso a Prepago HOM
     IF sv_tip_terminal = 'T' AND sv_equi_acc ='E' AND sn_cod_uso <> 3 THEN
     
        VE_PARAMETROS_COMERCIALES_PG.ve_cambio_uso_series_pr(sv_num_serie,user,3,sn_cod_retorno,sv_mens_retorno,sn_num_evento);
     
     END IF;

     RETURN TRUE;


EXCEPTION
    WHEN NO_DATA_FOUND THEN
          sv_num_serie := NULL;
         sn_num_telefono := NULL;
         sn_cod_articulo := NULL;
         RETURN TRUE;
    WHEN OTHERS THEN
         sn_cod_retorno  := 30006;
         sv_mens_retorno := 'No es posible ejecutar este servicio';
         lv_des_error      := 've_tipificacion_pg.ve_rec_serie_fn() - ' || SQLERRM;
           sn_num_evento      := ge_errores_pg.grabarpl (sn_num_evento, cv_modulove, sv_mens_retorno, cv_version, USER, 've_tipificacion_pg.ve_rec_serie_fn()', lv_sql, SQLCODE, SQLERRM);
         RETURN FALSE;
END ve_rec_serie_fn;
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
FUNCTION ve_rec_prc_venta_fn (
                              en_cod_articulo   IN  ga_tipificacion_td.cod_articulo%TYPE,
                              en_tip_stock        IN  al_series.tip_stock%TYPE,
                                en_cod_uso        IN  al_series.cod_uso%TYPE,
                              sn_prc_venta        OUT NOCOPY al_precios_venta.prc_venta%TYPE,
                              sn_prc_itbm       OUT NOCOPY NUMBER,
                              sn_prc_isc        OUT NOCOPY NUMBER,
                              sn_des_art        OUT NOCOPY NUMBER,
                               sn_cod_retorno    OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                                sv_mens_retorno   OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                                 sn_num_evento     OUT NOCOPY ge_errores_pg.evento
)RETURN BOOLEAN
IS

lv_des_error    VARCHAR2(300);
lv_sql          VARCHAR2(1000);
sn_imp_itbm     NUMBER;
sn_imp_isc      NUMBER;
error_ejecucion EXCEPTION;
ln_count        NUMBER;

BEGIN

     sn_cod_retorno := 0;
     sv_mens_retorno := '';
     sn_num_evento := 0;

     sn_des_art  := 0;

     --VALIDAR CORRECTA CONFIGURACIÓN DE PRECIOS

      lv_sql:= 'SELECT count(1) '
             ||'FROM   al_precios_venta '
             ||'WHERE  cod_articulo = '||en_cod_articulo||' '
            ||'AND       tip_stock = '||en_tip_stock||' '
             ||'AND       cod_uso = '||en_cod_uso||' '
             ||'AND    ind_recambio = '||cn_ind_recambio||' '
             ||' AND    cod_categoria = ' ||cv_categoria|| ' '
             ||' AND cod_estado=1 '
             ||' and num_meses=0 '
             ||' and cod_promedio=0 '
             ||' and cod_antiguedad=0 '
             ||' and cod_modventa=1 '
             ||' and ind_renova=0 '
             ||' and ind_priseg_lin=0 '
             ||' and cod_calificacion = ' || cv_cod_calificacion
             ||' AND    SYSDATE BETWEEN fec_desde AND fec_hasta';


     SELECT count(1)
     INTO    ln_count
     FROM   al_precios_venta
     WHERE  cod_articulo = en_cod_articulo
     AND     tip_stock = en_tip_stock
     AND     cod_uso = en_cod_uso
     AND    ind_recambio = cn_ind_recambio
     AND    cod_categoria = cv_categoria
     AND cod_estado=1
     and num_meses=0
     and cod_promedio=0
     and cod_antiguedad=0
     and cod_modventa=1 -- precio contado
     and ind_renova=0
     and ind_priseg_lin=0
     and cod_calificacion=cv_cod_calificacion
     AND    SYSDATE BETWEEN fec_desde AND fec_hasta;


     IF ln_count != 1 THEN
           sn_cod_retorno  := 30008;
         sv_mens_retorno := 'Problemas con la configuración de precio del artículo';
         RETURN FALSE;
     END IF;


     lv_sql:= 'SELECT prc_venta '
             ||'FROM   al_precios_venta '
             ||'WHERE  cod_articulo = '||en_cod_articulo||' '
            ||'AND       tip_stock = '||en_tip_stock||' '
             ||'AND       cod_uso = '||en_cod_uso||' '
             ||'AND    ind_recambio = '||cn_ind_recambio||' '
             ||' AND    cod_categoria = '|| cv_categoria ||''
             ||' AND cod_estado=1 '
             ||' and num_meses=0 '
             ||' and cod_promedio=0 '
             ||' and cod_antiguedad=0 '
             ||' and cod_modventa=1 '
             ||' and ind_renova=0 '
             ||' and ind_priseg_lin=0 '
             ||' and cod_calificacion = ' || cv_cod_calificacion || ''
             ||'AND    SYSDATE BETWEEN fec_desde AND fec_hasta';


     SELECT prc_venta
     INTO    sn_prc_venta
     FROM   al_precios_venta
     WHERE  cod_articulo = en_cod_articulo
     AND     tip_stock = en_tip_stock
     AND     cod_uso = en_cod_uso
     AND    ind_recambio = cn_ind_recambio
     AND    cod_categoria = cv_categoria
     AND cod_estado=1
     and num_meses=0
     and cod_promedio=0
     and cod_antiguedad=0
     and cod_modventa=1 -- precio contado
     and ind_renova=0
     and ind_priseg_lin=0
     and cod_calificacion=cv_cod_calificacion
     AND    SYSDATE BETWEEN fec_desde AND fec_hasta;

    
    --Se solicita solo recuperar el neto si calcular impuesto


    --IF NOT (ve_rec_impuesto_art_fn (en_cod_articulo,sn_imp_itbm,sn_imp_isc,sn_cod_retorno,sv_mens_retorno,sn_num_evento)) THEN
      --  RAISE error_ejecucion;
     --END IF;

     --if sn_imp_isc > 0 then
        -- sn_des_art  := round(sn_prc_venta * (0.0446) ,4);  -- P-CSR-11002
       --    sn_des_art  := round(sn_prc_venta  ,4); --P-CSR-11002        
     --else
      --sn_des_art  := 0;
     --end if;
     --sn_prc_itbm := round(sn_imp_itbm * (sn_prc_venta-sn_des_art),4);
     --sn_prc_isc  := round(sn_imp_isc * (sn_prc_venta-sn_des_art),4);
      sn_prc_itbm:=0;
      sn_prc_isc:=0;
      
     RETURN TRUE;

EXCEPTION
        WHEN error_ejecucion THEN
             RETURN FALSE;
        WHEN OTHERS THEN
          sn_cod_retorno  := 30007;
         sv_mens_retorno := 'No es posible ejecutar este servicio';
         lv_des_error      := 've_tipificacion_pg.ve_rec_prc_venta_fn() - ' || SQLERRM;
           sn_num_evento      := ge_errores_pg.grabarpl (sn_num_evento, cv_modulove, sv_mens_retorno, cv_version, USER, 've_tipificacion_pg.ve_rec_prc_venta_fn()', lv_sql, SQLCODE, SQLERRM);
         RETURN FALSE;

END ve_rec_prc_venta_fn;
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
FUNCTION ve_rec_artic_prc_fn (
                             ev_dato_ingresado IN  ga_tipificacion_td.cod_articulo%TYPE,
                             sn_cod_articulo   OUT NOCOPY al_articulos.cod_articulo%TYPE,
                             sv_des_articulo   OUT NOCOPY al_articulos.des_articulo%TYPE,
                             sn_prc_venta       OUT NOCOPY al_precios_venta.prc_venta%TYPE,
                             sv_equiacc           OUT NOCOPY al_articulos.ind_equiacc%TYPE,
                             sv_tip_terminal   OUT NOCOPY al_articulos.tip_terminal%TYPE,
                             sn_prc_itbm       OUT NOCOPY NUMBER,
                             sn_prc_isc        OUT NOCOPY NUMBER,
                             sn_des_art        OUT NOCOPY NUMBER,
                              sn_cod_retorno    OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                               sv_mens_retorno   OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                                sn_num_evento     OUT NOCOPY ge_errores_pg.evento
)RETURN BOOLEAN
IS

   lv_des_error    VARCHAR2(300);
   lv_sql          VARCHAR2(1000);
   sn_imp_itbm     NUMBER;
   sn_imp_isc      NUMBER;
   error_ejecucion EXCEPTION;

BEGIN

     sn_cod_retorno := 0;
     sv_mens_retorno := '';
     sn_num_evento := 0;

     sn_des_art  := 0;

     lv_sql := 'SELECT a.cod_articulo,a.des_articulo,b.prc_venta,a.ind_equiacc '
              ||' FROM    al_articulos a, al_precios_venta b '
              ||' WHERE     a.cod_articulo = '||ev_dato_ingresado
              ||' AND     a.cod_articulo = b.cod_articulo'
             ||' AND     b.cod_categoria = '||cv_categoria
              ||' AND    ind_recambio = '||cn_ind_recambio
             ||' AND    ind_equiacc <> '||cv_otro
             ||' AND    b.cod_uso = 3'
             ||' AND    b.tip_stock = 2'
             ||' AND cod_estado=1'
             ||' and num_meses=0'
             ||' and cod_promedio=0'
             ||' and cod_antiguedad=0'
             ||' and cod_modventa=1'
             ||' and ind_renova=0'
             ||' and ind_priseg_lin=0'
             ||' and cod_calificacion=cv_cod_calificacion'
              ||' AND    SYSDATE BETWEEN fec_desde AND fec_hasta';

     SELECT a.cod_articulo,a.des_articulo,b.prc_venta,a.ind_equiacc,a.tip_terminal
     INTO    sn_cod_articulo,sv_des_articulo,sn_prc_venta,sv_equiacc,sv_tip_terminal
     FROM    al_articulos a, al_precios_venta b
     WHERE     a.cod_articulo = ev_dato_ingresado
     AND     a.cod_articulo = b.cod_articulo
     AND    ind_recambio = cn_ind_recambio
     AND    b.cod_categoria = cv_categoria
     AND    ind_equiacc <> cv_otro
     AND    b.cod_uso = 3
     AND    b.tip_stock = 2
     AND cod_estado=1 --INICIO CSR-11002
     and num_meses=0
     and cod_promedio=0
     and cod_antiguedad=0
     and cod_modventa=1
     and ind_renova=0
     and ind_priseg_lin=0
     and cod_calificacion=cv_cod_calificacion --FIN CSR-11002
     AND    SYSDATE BETWEEN fec_desde AND fec_hasta;


     --Se solicita solo recuperar el neto si calcular impuesto


    --IF NOT (ve_rec_impuesto_art_fn (en_cod_articulo,sn_imp_itbm,sn_imp_isc,sn_cod_retorno,sv_mens_retorno,sn_num_evento)) THEN
      --  RAISE error_ejecucion;
     --END IF;

     --if sn_imp_isc > 0 then
        -- sn_des_art  := round(sn_prc_venta * (0.0446) ,4);  -- P-CSR-11002
       --    sn_des_art  := round(sn_prc_venta  ,4); --P-CSR-11002        
     --else
      --sn_des_art  := 0;
     --end if;
     --sn_prc_itbm := round(sn_imp_itbm * (sn_prc_venta-sn_des_art),4);
     --sn_prc_isc  := round(sn_imp_isc * (sn_prc_venta-sn_des_art),4);
      sn_prc_itbm:=0;
      sn_prc_isc:=0;

     RETURN TRUE;

EXCEPTION
    WHEN error_ejecucion THEN
         lv_des_error      := 've_tipificacion_pg.ve_rec_artic_prc_fn() - ' || SQLERRM;
         sn_num_evento      := ge_errores_pg.grabarpl (sn_num_evento, cv_modulove, sv_mens_retorno, cv_version, USER, 've_tipificacion_pg.ve_rec_artic_prc_fn()', lv_sql, SQLCODE, SQLERRM);
         RETURN FALSE;
    WHEN NO_DATA_FOUND THEN
          sn_cod_retorno  := 30008;
         sv_mens_retorno := 'No existe Serie';
         lv_des_error      := 've_tipificacion_pg.ve_rec_artic_prc_fn() - ' || SQLERRM;
         sn_num_evento      := ge_errores_pg.grabarpl (sn_num_evento, cv_modulove, sv_mens_retorno, cv_version, USER, 've_tipificacion_pg.ve_rec_artic_prc_fn()', lv_sql, SQLCODE, SQLERRM);
         RETURN FALSE;
    WHEN OTHERS THEN
         sn_cod_retorno  := 30009;
         sv_mens_retorno := 'No es posible ejecutar este servicio';
         lv_des_error      := 've_tipificacion_pg.ve_rec_artic_prc_fn() - ' || SQLERRM;
         DBMS_OUTPUT.Put_Line('lv_des_error ['||lv_des_error||']');
         DBMS_OUTPUT.Put_Line('lv_sql ['||lv_sql||']');
           sn_num_evento      := ge_errores_pg.grabarpl (sn_num_evento, cv_modulove, sv_mens_retorno, cv_version, USER, 've_tipificacion_pg.ve_rec_artic_prc_fn()', lv_sql, SQLCODE, SQLERRM);
         RETURN FALSE;

END ve_rec_artic_prc_fn;
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
FUNCTION ve_recuperaAccesorio_fn (
                             en_cod_articulo   IN  al_articulos.cod_articulo%TYPE,
                             en_cod_vendedor   IN  ve_vendedores.cod_vendedor%TYPE,
                             sv_num_serie      OUT NOCOPY al_series.NUM_SERIE%TYPE,
                             sv_des_articulo   OUT NOCOPY al_articulos.des_articulo%TYPE,
                             sv_equiacc           OUT NOCOPY al_articulos.ind_equiacc%TYPE,
                             sv_tip_terminal   OUT NOCOPY al_articulos.tip_terminal%TYPE,
                              sn_cod_retorno    OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                               sv_mens_retorno   OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                                sn_num_evento     OUT NOCOPY ge_errores_pg.evento
)RETURN BOOLEAN
IS

lv_des_error    VARCHAR2(300);
lv_sql          VARCHAR2(1000);
sn_imp_itbm     NUMBER;
sn_imp_isc      NUMBER;
error_ejecucion EXCEPTION;
ln_ind_seriado NUMBER;
ln_count NUMBER;
ln_cod_uso al_series.cod_uso%type;

BEGIN

     sn_cod_retorno := 0;
     sv_mens_retorno := '';
     sn_num_evento := 0;


       --VALIDO SI EL ARTICULO ES SERIADO

     select a.IND_SERIADO into ln_ind_seriado from al_Articulos a where a.cod_articulo = en_cod_articulo ;



     IF ln_ind_seriado = 1 THEN

              --SI ES SERIADO VALIDO QUE EXISTAN SERIES


     lv_sql := 'SELECT count(1) al_series where cod_articulo ='||en_cod_articulo;



      SELECT COUNT (1)
        INTO ln_count
        FROM al_series a
       WHERE a.cod_articulo = en_cod_articulo;


     IF ln_count>0 THEN


             lv_sql := 'SELECT a.des_articulo,a.NUM_SERIE, a.ind_equiacc, a.tip_terminal '
                      ||'FROM    ( select a.des_articulo,c.NUM_SERIE, b.prc_venta,a.ind_equiacc, a.tip_terminal  '
                      ||'from al_articulos a,  al_series c'
                      ||'WHERE     a.cod_articulo = '||en_cod_articulo||' '
                     ||'AND    ind_recambio = '||cn_ind_recambio||' '
                      ||'AND    b.cod_categoria = '||cv_categoria||' '
                       ||'AND    ind_equiacc <> '''||cv_otro||''''
                     ||'AND    SYSDATE BETWEEN fec_desde AND fec_hasta '
                     ||'AND    a.COD_ARTICULO=c.COD_ARTICULO '
                     ||'order by  c.FEC_ENTRADA, num_serie ASC) a'
                     ||'WHERE ROWNUM = 1';

            SELECT a.des_articulo, a.num_serie, a.ind_equiacc, a.tip_terminal, a.cod_uso
              INTO sv_des_articulo, sv_num_serie, sv_equiacc, sv_tip_terminal, ln_cod_uso
              FROM (SELECT   a.des_articulo, c.num_serie, a.ind_equiacc, a.tip_terminal, c.cod_uso
                      FROM al_articulos a, al_series c, ve_vendalmac d
                     WHERE a.cod_articulo = en_cod_articulo
                       AND a.cod_articulo = c.cod_articulo
                       AND d.cod_vendedor = en_cod_vendedor
                       AND d.fec_desasignac IS NULL
                       AND c.cod_bodega = d.cod_bodega
                       AND ROWNUM <= 5
                       ORDER BY DBMS_RANDOM.value , c.fec_entrada ASC) a
             WHERE ROWNUM <2;
             
             
              --Cuando Es un Terminal que no es prepago hay que hacerle el cambio de uso a Prepago HOM
             IF sv_tip_terminal = 'T' AND sv_equiacc ='E' AND ln_cod_uso <> 3 THEN
     
                VE_PARAMETROS_COMERCIALES_PG.ve_cambio_uso_series_pr(sv_num_serie,user,3,sn_cod_retorno,sv_mens_retorno,sn_num_evento);
     
             END IF;            
             
       ELSE
           sn_cod_retorno  := 30011;
         sv_mens_retorno := 'Accesorio ingresado seriado, pero no existen series disponibles';
        lv_des_error     := 've_tipificacion_pg.ve_artic_prc_fn() - ' || SQLERRM;
         RETURN FALSE;
       END IF;

       ELSE

        -- Si no es seriado valido que exista en stock

        select COUNT (1)
        INTO ln_count from al_stock a, ve_vendalmac  b
        where a.cod_articulo=en_cod_articulo
        and b.COD_VENDEDOR=en_cod_vendedor
        AND b.fec_desasignac IS NULL
        and a.COD_BODEGA=b.COD_BODEGA
        and cod_estado =1 and tip_stock = 2;

                   IF ln_count>0 THEN

                    lv_sql := 'SELECT a.des_articulo,b.prc_venta,a.ind_equiacc '
                      ||'FROM    al_articulos a, al_precios_venta b '
                      ||'WHERE     a.cod_articulo = '||en_cod_articulo||' '
                      ||'AND     a.cod_articulo = b.cod_articulo '
                      ||'AND    ind_recambio = '||cn_ind_recambio||' '
                     ||'AND       AND    ind_equiacc <> '||cv_otro||' '
                      ||'AND    SYSDATE BETWEEN fec_desde AND fec_hasta';

                     SELECT a.des_articulo,a.ind_equiacc, a.tip_terminal
                     INTO    sv_des_articulo,sv_equiacc,sv_tip_terminal
                     FROM    al_articulos a     WHERE     a.cod_articulo = en_cod_articulo;

                   ELSE

                      sn_cod_retorno  := 30012;
                      sv_mens_retorno := 'Accesorio ingresado no existe en la bodega';
                     lv_des_error     := 've_tipificacion_pg.ve_artic_prc_fn() - ' || SQLERRM;
                      RETURN FALSE;

                  END IF;

        END IF;


     /*IF sv_equiacc = 'A' THEN    CSR-11002 Se solicita que los equipos y simcard tambien puedan ser tipificados
         RETURN TRUE;
     ELSE
         sn_cod_retorno  := 30010;
         sv_mens_retorno := 'Articulo ingresado no es de tipo accesorio';
        lv_des_error     := 've_tipificacion_pg.ve_artic_prc_fn() - ' || SQLERRM;
         RETURN FALSE;
     END IF;*/
     
     RETURN TRUE;

EXCEPTION
    WHEN OTHERS THEN
         sn_cod_retorno  := 30011;
         sv_mens_retorno := 'No es posible ejecutar este servicio';
         lv_des_error      := 've_tipificacion_pg.ve_artic_prc_fn() - ' || SQLERRM;
           sn_num_evento      := ge_errores_pg.grabarpl (sn_num_evento, cv_modulove, sv_mens_retorno, cv_version, USER, 've_tipificacion_pg.ve_artic_prc_fn()', lv_sql, SQLCODE, SQLERRM);
         RETURN FALSE;
END ve_recuperaAccesorio_fn;

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
/*PROCEDURE ve_recupera_tipificacion_pr(
                                        ev_dato_ingresado IN VARCHAR2,
                                      en_cod_vendedor   IN ve_vendalmac.COD_VENDEDOR%TYPE,
                                      sn_cod_articulo   OUT NOCOPY al_articulos.cod_articulo%TYPE,
                                      sv_serie            OUT NOCOPY al_series.num_serie%TYPE,
                                      sv_descripccion    OUT NOCOPY al_articulos.des_articulo%TYPE,
                                      sv_precio            OUT NOCOPY al_precios_venta.prc_venta%TYPE,
                                      sn_num_celular    OUT NOCOPY al_series.num_telefono%TYPE,
                                      sv_equiacc        OUT NOCOPY al_articulos.ind_equiacc%TYPE,
                                      sv_tip_terminal   OUT NOCOPY al_articulos.tip_terminal%TYPE,
                                      sn_prc_itbm       OUT NOCOPY NUMBER,
                                      sn_prc_isc        OUT NOCOPY NUMBER,
                                      sn_des_prc        OUT NOCOPY NUMBER,
                                      sn_cod_retorno    OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                                        sv_mens_retorno   OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                                        sn_num_evento     OUT NOCOPY ge_errores_pg.evento)
IS

lv_des_error    VARCHAR2(300);
lv_sql          VARCHAR2(1000);
lv_ind_equiacc  VARCHAR2(40);
ln_tip_stock    al_series.tip_stock%TYPE;
ln_cod_uso        al_series.cod_uso%TYPE;
ln_cod_articulo al_articulos.cod_articulo%TYPE;
ln_count_ser    NUMBER;
ln_count_bod    NUMBER;

error_ejecucion EXCEPTION;
error_bodega EXCEPTION;


BEGIN

     sn_cod_retorno := 0;
     sv_mens_retorno := '';
     sn_num_evento := 0;


     lv_sql := '1';
     IF NOT (ve_rec_tipificacion_fn(ev_dato_ingresado,sn_cod_articulo,sn_cod_retorno,sv_mens_retorno,sn_num_evento)) THEN
        RAISE error_ejecucion;
     END IF;

    lv_sql := '2';
     IF sn_cod_articulo IS NOT NULL THEN
        lv_sql := '3';
         IF NOT(ve_artic_prc_fn(sn_cod_articulo,sv_serie,sv_descripccion,sv_precio,sv_equiacc,sv_tip_terminal, sn_prc_itbm, sn_prc_isc, sn_des_prc, sn_cod_retorno,sv_mens_retorno,sn_num_evento)) THEN
           RAISE error_ejecucion;
        END IF;
        sv_serie := NULL;
        sn_num_celular := NULL;
     ELSE
        lv_sql := '4';
        IF NOT(ve_rec_serie_fn(ev_dato_ingresado,sv_serie,sn_num_celular,sn_cod_articulo,ln_tip_stock,ln_cod_uso,sn_cod_retorno,sv_mens_retorno,sn_num_evento)) THEN
           RAISE error_ejecucion;
           END IF;

            IF sv_serie IS NOT NULL THEN
                lv_sql := '5';
                IF NOT (ve_rec_articulo_fn(sn_cod_articulo,sv_descripccion,sv_equiacc,sv_tip_terminal,sn_cod_retorno,sv_mens_retorno,sn_num_evento)) THEN
                   RAISE error_ejecucion;
                END IF;

                DBMS_OUTPUT.Put_Line('ve_recupera_tipificacion_pr -- cod_articulo ['||sn_cod_articulo||']');

                lv_sql := '6';
                IF NOT(ve_rec_artic_prc_fn(sn_cod_articulo,ln_cod_articulo,sv_descripccion,sv_precio,sv_equiacc,sv_tip_terminal,sn_prc_itbm, sn_prc_isc, sn_des_prc, sn_cod_retorno,sv_mens_retorno,sn_num_evento)) THEN
                   RAISE error_ejecucion;
                   END IF;

                SELECT count(1) into ln_count_bod
                FROM     ve_vendalmac a, al_series b
                WHERE b.num_serie=sv_serie
                AND a.COD_BODEGA = b.COD_BODEGA
                AND a.COD_VENDEDOR = en_cod_vendedor
                AND a.FEC_DESASIGNAC is NULL;

               IF ln_count_bod < 1THEN
                   RAISE error_bodega;
               END IF;


            ELSE
                lv_sql := '7';
                IF NOT(ve_rec_artic_prc_fn(to_number(ev_dato_ingresado),sn_cod_articulo,sv_descripccion,sv_precio,sv_equiacc,sv_tip_terminal,sn_prc_itbm, sn_prc_isc, sn_des_prc, sn_cod_retorno,sv_mens_retorno,sn_num_evento)) THEN
                   RAISE error_ejecucion;
                   END IF;
                sv_serie := NULL;
                sn_num_celular := NULL;
            END IF;
     END IF;

EXCEPTION
    WHEN error_bodega THEN
         sn_cod_retorno  := 30025;
         sv_mens_retorno := 'El vendedor no tiene acceso a la bodega de la serie';
         lv_des_error      := 've_tipificacion_pg.ve_recupera_tipificacion_pr() - ' || SQLERRM;
           sn_num_evento      := ge_errores_pg.grabarpl (sn_num_evento, cv_modulove, sv_mens_retorno, cv_version, USER, 've_tipificacion_pg.ve_recupera_tipificacion_pr()', lv_sql, SQLCODE, SQLERRM);

    WHEN error_ejecucion THEN
         lv_des_error    := 've_tipificacion_pg.ve_recupera_tipificacion_pr() - ' || SQLERRM;
         sn_num_evento   := ge_errores_pg.grabarpl(sn_num_evento,cv_modulove,sv_mens_retorno,cv_version , USER, 've_tipificacion_pg.ve_recupera_tipificacion_pr()', lv_sql, SQLCODE, lv_des_error );

    WHEN OTHERS THEN
         sn_cod_retorno  := 30012;
         sv_mens_retorno := 'No es posible ejecutar este servicio';
         lv_des_error      := 've_tipificacion_pg.ve_recupera_tipificacion_pr() - ' || SQLERRM;
           sn_num_evento      := ge_errores_pg.grabarpl (sn_num_evento, cv_modulove, sv_mens_retorno, cv_version, USER, 've_tipificacion_pg.ve_recupera_tipificacion_pr()', lv_sql, SQLCODE, SQLERRM);

END ve_recupera_tipificacion_pr;*/
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

PROCEDURE ve_recupera_articulo_pr(
                                        ev_dato_ingresado IN VARCHAR2,
                                      en_cod_vendedor   IN ve_vendalmac.COD_VENDEDOR%TYPE,
                                      sn_cod_articulo   OUT NOCOPY al_articulos.cod_articulo%TYPE,
                                      sv_serie            OUT NOCOPY al_series.num_serie%TYPE,
                                      sv_descripccion    OUT NOCOPY al_articulos.des_articulo%TYPE,
                                      sv_precio            OUT NOCOPY al_precios_venta.prc_venta%TYPE,
                                      sn_num_celular    OUT NOCOPY al_series.num_telefono%TYPE,
                                      sv_equiacc        OUT NOCOPY al_articulos.ind_equiacc%TYPE,
                                      sv_tip_terminal   OUT NOCOPY al_articulos.tip_terminal%TYPE,
                                      sn_prc_itbm       OUT NOCOPY NUMBER,
                                      sn_prc_isc        OUT NOCOPY NUMBER,
                                      sn_des_prc        OUT NOCOPY NUMBER,
                                      sn_cod_retorno    OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                                        sv_mens_retorno   OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                                        sn_num_evento     OUT NOCOPY ge_errores_pg.evento)




IS

lv_des_error    VARCHAR2(300);
lv_sql          VARCHAR2(1000);
ln_tip_stock    al_series.tip_stock%TYPE;
ln_cod_uso        al_series.cod_uso%TYPE;
ln_count_bod    NUMBER;
lb_esAccesorio  BOOLEAN;
lb_esSerie  BOOLEAN;
error_ejecucion EXCEPTION;
error_bodega   EXCEPTION;
error_noExiste EXCEPTION;
validanumero   NUMBER;
error_numero   EXCEPTION;
BEGIN

     sn_cod_retorno := 0;
     sv_mens_retorno := '';
     sn_num_evento := 0;
     lb_esAccesorio :=FALSE;
     lb_esSerie:=FALSE;


     -- VERIFICAR SI ES UN CODGO DE TIPIFICACIÓN
     lv_sql := 've_rec_tipificacion_fn';
     IF NOT (ve_rec_tipificacion_fn(ev_dato_ingresado,sn_cod_articulo,sn_cod_retorno,sv_mens_retorno,sn_num_evento)) THEN
        RAISE error_ejecucion;
     END IF;


     IF sn_cod_articulo IS NULL THEN

        --VERIFICAR SI ES UN CODIGO DE ARTICULO

        IF NOT (ve_val_numero_fn (ev_dato_ingresado,sn_cod_retorno,sv_mens_retorno,sn_num_evento)) THEN
           RAISE error_numero;
        END IF ;

        lv_sql := 've_verificarAccesorio_fn A';
        IF ve_verificarAccesorio_fn (ev_dato_ingresado,sn_cod_retorno,sv_mens_retorno,sn_num_evento) THEN
        lv_sql := 've_verificarAccesorio_fn B';
               --RECUPERAR DATOS DEL ACCESORIO
            sn_cod_articulo:=ev_dato_ingresado;
            lb_esAccesorio := TRUE;

            lv_sql := 've_recuperaAccesorio_fn';
            IF NOT (ve_recuperaAccesorio_fn (sn_cod_articulo,en_cod_vendedor,sv_serie,sv_descripccion,sv_equiacc,sv_tip_terminal,sn_cod_retorno,sv_mens_retorno,sn_num_evento)) THEN
               RAISE error_numero;
            END IF;

        END IF;

     ELSE
           
           -- RECUPERAR DATOS DEL ACCESORIO TIPIFICADO
            lb_esAccesorio := TRUE;
            IF NOT (ve_recuperaAccesorio_fn (sn_cod_articulo, en_cod_vendedor,sv_serie,sv_descripccion,sv_equiacc,sv_tip_terminal,sn_cod_retorno,sv_mens_retorno,sn_num_evento)) THEN
                 RAISE error_ejecucion;
            END IF;
                       
     END IF;

     IF NOT lb_esAccesorio THEN
         -- RECUPEREAR SERIE (SIMCARD - IMEI)
         lv_sql := 've_rec_serie_fn';
         IF NOT (ve_rec_serie_fn(ev_dato_ingresado,sv_serie,sn_num_celular,sn_cod_articulo,ln_tip_stock,ln_cod_uso,sv_tip_terminal,sv_equiacc,sv_descripccion,sn_cod_retorno,sv_mens_retorno,sn_num_evento)) THEN
            RAISE error_ejecucion;
         END IF;

        IF sn_cod_articulo IS NOT NULL THEN
             lb_esSerie:= TRUE;
        END IF;

     END IF;

     IF NOT lb_esAccesorio AND NOT lb_esSerie THEN
          RAISE error_noExiste;
     END IF;

     --VALIDAR BODEGA
     IF sv_serie IS NOT NULL THEN

                lv_sql := 'SELECT count(1) FROM ve_vendalmac a, al_series b'
                       || ' WHERE b.num_serie= '||sv_serie
                       || ' AND a.COD_BODEGA = b.COD_BODEGA'
                       || ' AND a.COD_VENDEDOR = '||en_cod_vendedor
                       || ' AND a.FEC_DESASIGNAC is NULL';

                 SELECT count(1) into ln_count_bod
                FROM     ve_vendalmac a, al_series b
                WHERE b.num_serie=sv_serie
                AND a.COD_BODEGA = b.COD_BODEGA
                AND a.COD_VENDEDOR = en_cod_vendedor
                AND a.FEC_DESASIGNAC is NULL;

                IF ln_count_bod < 1 THEN
                   RAISE error_bodega;
                END IF;

     END IF;

     --RECUPERAR PRECIO

     --VALIDAR
      ln_tip_stock:=2;
     ln_cod_uso    :=3;
      lv_sql := 've_rec_prc_venta_fn';
      IF NOT (ve_rec_prc_venta_fn (sn_cod_articulo,ln_tip_stock,ln_cod_uso, sv_precio,sn_prc_itbm,sn_prc_isc,sn_des_prc,sn_cod_retorno,sv_mens_retorno,sn_num_evento))THEN
            RAISE error_ejecucion;
      END IF;


     DBMS_OUTPUT.PUT_LINE('itbm: '||sn_prc_itbm||' isc: '||sn_prc_isc);

EXCEPTION
    WHEN error_numero THEN
         sn_cod_retorno  := 33025;
         sv_mens_retorno := 'No existen datos con el criterio de busqueda';
         lv_des_error    := 've_tipificacion_pg.ve_recupera_tipificacion_pr() - ' || SQLERRM;
         sn_num_evento   := ge_errores_pg.grabarpl(sn_num_evento,cv_modulove,sv_mens_retorno,cv_version , USER, 've_tipificacion_pg.ve_recupera_tipificacion_pr()', lv_sql, SQLCODE, lv_des_error );
    WHEN error_noExiste THEN
         sn_cod_retorno  := 30025;
         sv_mens_retorno := 'Serie Ingresada No Existe';
         lv_des_error      := 've_tipificacion_pg.ve_recupera_tipificacion_pr() - ' || SQLERRM;
           sn_num_evento      := ge_errores_pg.grabarpl (sn_num_evento, cv_modulove, sv_mens_retorno, cv_version, USER, 've_tipificacion_pg.ve_recupera_tipificacion_pr()', lv_sql, SQLCODE, SQLERRM);

    WHEN error_bodega THEN
         sn_cod_retorno  := 30026;
         sv_mens_retorno := 'El vendedor no tiene acceso a la bodega de la serie';
         lv_des_error      := 've_tipificacion_pg.ve_recupera_tipificacion_pr() - ' || SQLERRM;
           sn_num_evento      := ge_errores_pg.grabarpl (sn_num_evento, cv_modulove, sv_mens_retorno, cv_version, USER, 've_tipificacion_pg.ve_recupera_tipificacion_pr()', lv_sql, SQLCODE, SQLERRM);

    WHEN error_ejecucion THEN
         lv_des_error    := 've_tipificacion_pg.ve_recupera_tipificacion_pr() - ' || SQLERRM;
         sn_num_evento   := ge_errores_pg.grabarpl(sn_num_evento,cv_modulove,sv_mens_retorno,cv_version , USER, 've_tipificacion_pg.ve_recupera_tipificacion_pr()', lv_sql, SQLCODE, lv_des_error );

    WHEN OTHERS THEN
         sn_cod_retorno  := 30012;
         sv_mens_retorno := 'No es posible ejecutar este servicio';
         lv_des_error      := 've_tipificacion_pg.ve_recupera_tipificacion_pr() - ' || SQLERRM;
           sn_num_evento      := ge_errores_pg.grabarpl (sn_num_evento, cv_modulove, sv_mens_retorno, cv_version, USER, 've_tipificacion_pg.ve_recupera_tipificacion_pr()', lv_sql, SQLCODE, SQLERRM);

END ve_recupera_articulo_pr;


PROCEDURE ve_selc_kit_pr(
                         ev_dato_ingresado IN VARCHAR2,
                         sv_equiacc           OUT NOCOPY al_articulos.ind_equiacc%TYPE,
                         sn_cod_retorno    OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                           sv_mens_retorno   OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                           sn_num_evento     OUT NOCOPY ge_errores_pg.evento)
IS

lv_des_error    VARCHAR2(300);
lv_sql          VARCHAR2(1000);
lv_cont         NUMBER;

BEGIN

     sn_cod_retorno := 0;
     sv_mens_retorno := '';
     sn_num_evento := 0;

     lv_sql := 'SELECT COUNT(1)'
             ||'FROM   al_componente_kit '
             ||'WHERE  num_kit = '||ev_dato_ingresado||'';

     SELECT COUNT(1)
     INTO   lv_cont
     FROM   al_componente_kit
     WHERE  num_kit = ev_dato_ingresado;

     IF lv_cont > 0 THEN
        sv_equiacc := 'K';
     ELSE
        sv_equiacc := 'N';
     END IF;


EXCEPTION
    WHEN OTHERS THEN
         sn_cod_retorno  := 30013;
         sv_mens_retorno := 'No es posible ejecutar este servicio';
         lv_des_error      := 've_tipificacion_pg.ve_recupera_tipificacion_pr() - ' || SQLERRM;
           sn_num_evento      := ge_errores_pg.grabarpl (sn_num_evento, cv_modulove, sv_mens_retorno, cv_version, USER, 've_tipificacion_pg.ve_recupera_tipificacion_pr()', lv_sql, SQLCODE, SQLERRM);


END ve_selc_kit_pr;
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE ve_recupera_kit_pr(
                               ev_dato_ingresado IN VARCHAR2,
                                en_cod_vendedor   IN ve_vendalmac.COD_VENDEDOR%TYPE,
                             sc_datos_kit      OUT NOCOPY refcursor,
                             sn_cod_retorno    OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                               sv_mens_retorno   OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                               sn_num_evento     OUT NOCOPY ge_errores_pg.evento)
IS

lv_des_error    VARCHAR2(300);
lv_sql          VARCHAR2(1000);
error_bodega    EXCEPTION;
ln_count_bod    NUMBER;
ln_cod_articulo NUMBER;


v_num_serie     al_series.num_serie%TYPE;
n_num_telefono  al_series.num_telefono%TYPE;
n_cod_articulo  al_series.cod_articulo%TYPE;
n_tip_stock     al_series.tip_stock%TYPE;
n_cod_uso       al_series.cod_uso%TYPE;
v_tip_terminal  al_articulos.tip_terminal%TYPE;
v_equi_acc      al_articulos.ind_equiacc%TYPE;
v_descripccion  al_articulos.des_articulo%TYPE;
n_cod_articulo2 al_articulos.cod_articulo%TYPE;

n_prc_venta    NUMBER;
n_prc_itbm     NUMBER;
n_prc_isc      NUMBER;
n_des_art      NUMBER;

error_ejecucion EXCEPTION;

BEGIN

     sn_cod_retorno := 0;
     sv_mens_retorno := '';
     sn_num_evento := 0;

     --VAlidar BODEGA
       SELECT count(1) into ln_count_bod
                FROM     ve_vendalmac a, al_series b
                WHERE b.num_serie =ev_dato_ingresado
                AND a.COD_BODEGA = b.COD_BODEGA
                AND a.COD_VENDEDOR = en_cod_vendedor
                AND a.FEC_DESASIGNAC is NULL;

               IF ln_count_bod < 1 THEN
                   RAISE error_bodega;
               END IF;

      IF NOT (ve_rec_serie_fn (ev_dato_ingresado,v_num_serie,n_num_telefono,n_cod_articulo,n_tip_stock,n_cod_uso,v_tip_terminal,v_equi_acc,v_descripccion,sn_cod_retorno,sv_mens_retorno,sn_num_evento)) THEN
         RAISE error_ejecucion;
      END IF;

      IF NOT (ve_rec_artic_prc_fn (n_cod_articulo,n_cod_articulo2,v_descripccion,n_prc_venta,v_equi_acc,v_tip_terminal,n_prc_itbm,n_prc_isc,n_des_art,sn_cod_retorno,sv_mens_retorno,sn_num_evento)) THEN
         RAISE error_ejecucion;
      END IF;


     lv_sql := 'SELECT ak.cod_articulo, ak.num_serie, ak.num_telefono, aa.des_articulo, av.prc_venta, aa.ind_equiacc, aa.tip_terminal '
             ||'FROM   al_componente_kit ak, al_articulos aa, al_precios_venta av '
             ||'WHERE  num_kit = '||ev_dato_ingresado||' '
             ||'AND    ak.cod_articulo = aa.cod_articulo '
             ||'AND    ak.cod_articulo = av.cod_articulo '
             ||'AND    aa.cod_articulo = av.cod_articulo '
             ||'AND    av.ind_recambio = '||cn_ind_recambio||' '
             ||'AND    aa.ind_equiacc <> '||cv_otro||' '
             ||'AND    ak.tip_stock = av.tip_stock '
             ||'AND    ak.cod_uso = av.cod_uso '
             ||'AND    av.cod_categoria = '||cv_categoria
             ||'AND    av.cod_estado=1 '
             ||'and    av.num_meses=0 '
             ||'and    av.cod_promedio=0 '
             ||'and    av.cod_antiguedad=0 '
             ||'and    av.cod_modventa=1 '
             ||'and    av.ind_renova=0 '
             ||'and    av.ind_priseg_lin=0 '
             ||'and    av.cod_calificacion= ' ||cv_cod_calificacion
             ||'AND    SYSDATE BETWEEN av.fec_desde AND av.fec_hasta';


     OPEN sc_datos_kit FOR
     SELECT ak.cod_articulo, ak.num_serie, ak.num_telefono, aa.des_articulo, n_prc_venta, aa.ind_equiacc, ba.tip_terminal, n_prc_itbm,n_prc_isc,n_des_art
     FROM   al_componente_kit ak, al_articulos aa, al_precios_venta av , al_articulos ba
     WHERE  num_kit = ev_dato_ingresado
     AND    ak.cod_kit = aa.cod_articulo
     AND    ak.cod_kit = av.cod_articulo
     AND    ak.cod_articulo = ba.cod_articulo
     AND    aa.cod_articulo = av.cod_articulo
     AND    av.ind_recambio = cn_ind_recambio
     AND    aa.ind_equiacc <> cv_otro
     AND    ak.tip_stock = av.tip_stock
     AND    ak.cod_uso = av.cod_uso
     AND    av.cod_categoria = cv_categoria
     AND    av.cod_estado=1 --INICIO CSR-11002
     and    av.num_meses=0
     and    av.cod_promedio=0
     and    av.cod_antiguedad=0
     and    av.cod_modventa=1
     and    av.ind_renova=0
     and    av.ind_priseg_lin=0
     and    av.cod_calificacion=cv_cod_calificacion --FIN CSR-11002
     AND    SYSDATE BETWEEN av.fec_desde AND av.fec_hasta;




EXCEPTION
    WHEN error_bodega THEN
         sn_cod_retorno  := 30027;
         sv_mens_retorno := 'Kit No existe en bodegas del Quiosco';
         lv_des_error      := 've_tipificacion_pg.ve_recupera_tipificacion_pr() - ' || SQLERRM;
           sn_num_evento      := ge_errores_pg.grabarpl (sn_num_evento, cv_modulove, sv_mens_retorno, cv_version, USER, 've_tipificacion_pg.ve_recupera_tipificacion_pr()', lv_sql, SQLCODE, SQLERRM);
    WHEN error_ejecucion THEN
         lv_des_error      := 've_tipificacion_pg.ve_recupera_tipificacion_pr() - ' || SQLERRM;
           sn_num_evento      := ge_errores_pg.grabarpl (sn_num_evento, cv_modulove, sv_mens_retorno, cv_version, USER, 've_tipificacion_pg.ve_recupera_tipificacion_pr()', lv_sql, SQLCODE, SQLERRM);
    WHEN OTHERS THEN
         sn_cod_retorno  := 30014;
         sv_mens_retorno := 'No es posible ejecutar este servicio';
         lv_des_error      := 've_tipificacion_pg.ve_recupera_tipificacion_pr() - ' || SQLERRM;
         DBMS_OUTPUT.Put_Line('lv_sql ['||lv_sql||']');
           sn_num_evento      := ge_errores_pg.grabarpl (sn_num_evento, cv_modulove, sv_mens_retorno, cv_version, USER, 've_tipificacion_pg.ve_recupera_tipificacion_pr()', lv_sql, SQLCODE, SQLERRM);
END ve_recupera_kit_pr;
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE ve_insert_tipificacion_pr(
                                    ev_cod_tipificacion  IN ga_tipificacion_td.cod_tipificacion%TYPE,
                                    en_cod_articulo      IN ga_tipificacion_td.cod_articulo%TYPE,
                                    en_flag_clientizable IN ga_tipificacion_td.flag_clientizable%TYPE,
                                    en_nom_usuario       IN ga_tipificacion_td.nom_usuario%TYPE,
                                    ev_des_tipificacion  IN ga_tipificacion_td.DES_TIPIFICACION%TYPE,
                                    sn_cod_retorno       OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                                    sv_mens_retorno      OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                                    sn_num_evento        OUT NOCOPY ge_errores_pg.evento)
IS

lv_des_error    VARCHAR2(300);
lv_sql          VARCHAR2(1000);
lv_cont         NUMBER;

error_articulo EXCEPTION;
error_articulo_tipificacion EXCEPTION;
error_tipificacion EXCEPTION;

BEGIN

     sn_cod_retorno := 0;
     sv_mens_retorno := '';
     sn_num_evento := 0;

     --Validaciones
     --Validar Existencia del articulo
     lv_cont:=0;

     select count(1) into lv_cont from al_articulos where cod_articulo= en_cod_articulo;

     if lv_cont = 0 then
         raise error_articulo;
     end if;


      --Validar NO Existencia del articulo con la tipificacion
     lv_cont:=0;

     select count(1) into lv_cont from ga_tipificacion_td s where cod_articulo= en_cod_articulo and cod_tipificacion =ev_cod_tipificacion;

     if lv_cont > 0 then
         raise error_articulo_tipificacion;
     end if;

      --Validar NO Existencia de la tipificacion
     lv_cont:=0;

     select count(1) into lv_cont from ga_tipificacion_td s where cod_tipificacion =ev_cod_tipificacion;

     if lv_cont > 0 then
         raise error_tipificacion;
     end if;


     lv_sql := 'INSERT INTO ga_tipificacion_td (cod_tipificacion, cod_articulo, flag_clientizable, cod_usuario, des_tipificacion) '
             ||'VALUES   ('||ev_cod_tipificacion||','||en_cod_articulo||','||en_flag_clientizable||','||en_nom_usuario||','''||ev_des_tipificacion||''')';

     INSERT INTO ga_tipificacion_td (cod_tipificacion, cod_articulo, flag_clientizable, nom_usuario, des_tipificacion)
     VALUES   (ev_cod_tipificacion,en_cod_articulo,en_flag_clientizable, en_nom_usuario,ev_des_tipificacion);

EXCEPTION
    WHEN error_articulo THEN
         sn_cod_retorno  := 30015;
         sv_mens_retorno := 'Código De Articulo No Existe';
         lv_des_error      := 've_tipificacion_pg.ve_insert_tipificacion_pr() - ' || SQLERRM;
           sn_num_evento      := ge_errores_pg.grabarpl (sn_num_evento, cv_modulove, sv_mens_retorno, cv_version, USER, 've_tipificacion_pg.ve_insert_tipificacion_pr()', lv_sql, SQLCODE, SQLERRM);

    WHEN error_articulo_tipificacion THEN
         sn_cod_retorno  := 30016;
         sv_mens_retorno := 'Articulo ya se encuentra tipificado con este código';
         lv_des_error      := 've_tipificacion_pg.ve_insert_tipificacion_pr() - ' || SQLERRM;
           sn_num_evento      := ge_errores_pg.grabarpl (sn_num_evento, cv_modulove, sv_mens_retorno, cv_version, USER, 've_tipificacion_pg.ve_insert_tipificacion_pr()', lv_sql, SQLCODE, SQLERRM);

    WHEN error_tipificacion THEN
         sn_cod_retorno  := 33336;
         sv_mens_retorno := 'Código de Tipificación Ya Existe';
         lv_des_error      := 've_tipificacion_pg.ve_insert_tipificacion_pr() - ' || SQLERRM;
           sn_num_evento      := ge_errores_pg.grabarpl (sn_num_evento, cv_modulove, sv_mens_retorno, cv_version, USER, 've_tipificacion_pg.ve_insert_tipificacion_pr()', lv_sql, SQLCODE, SQLERRM);

    WHEN OTHERS THEN
         sn_cod_retorno  := 33333;
         sv_mens_retorno := 'No es posible ejecutar este servicio';
         lv_des_error      := 've_tipificacion_pg.ve_insert_tipificacion_pr() - ' || SQLERRM;
           sn_num_evento      := ge_errores_pg.grabarpl (sn_num_evento, cv_modulove, sv_mens_retorno, cv_version, USER, 've_tipificacion_pg.ve_insert_tipificacion_pr()', lv_sql, SQLCODE, SQLERRM);
END ve_insert_tipificacion_pr;
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE ve_selec_curs_tipifica_pr(
                                    sc_tipificacion      OUT NOCOPY refcursor,
                                    sn_cod_retorno       OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                                    sv_mens_retorno      OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                                    sn_num_evento        OUT NOCOPY ge_errores_pg.evento)
IS

lv_des_error    VARCHAR2(300);
lv_sql          VARCHAR2(1000);
lv_cont         NUMBER;

BEGIN

     sn_cod_retorno := 0;
     sv_mens_retorno := '';
     sn_num_evento := 0;

     lv_sql := 'select cod_tipificacion,cod_articulo,flag_clientizable,nom_usuario, des_tipificacion from ga_tipificacion_td';

     OPEN sc_tipificacion FOR
     SELECT cod_tipificacion,cod_articulo,flag_clientizable,nom_usuario, des_tipificacion
     FROM ga_tipificacion_td;

EXCEPTION
    WHEN OTHERS THEN
         sn_cod_retorno  := 30017;
         sv_mens_retorno := 'No es posible ejecutar este servicio';
         lv_des_error      := 've_tipificacion_pg.ve_insert_tipificacion_pr() - ' || SQLERRM;
           sn_num_evento      := ge_errores_pg.grabarpl (sn_num_evento, cv_modulove, sv_mens_retorno, cv_version, USER, 've_tipificacion_pg.ve_insert_tipificacion_pr()', lv_sql, SQLCODE, SQLERRM);
END ve_selec_curs_tipifica_pr;
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE ve_selec_tipifica_pr(
                               en_cod_articulo      IN ga_tipificacion_td.cod_articulo%TYPE,
                               sv_cod_tipificacion  OUT NOCOPY ga_tipificacion_td.cod_tipificacion%TYPE,
                               sn_flag_clientizable OUT NOCOPY ga_tipificacion_td.flag_clientizable%TYPE,
                               sn_nom_usuario       OUT NOCOPY ga_tipificacion_td.nom_usuario%TYPE,
                               sn_cod_retorno       OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                               sv_mens_retorno      OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                               sn_num_evento        OUT NOCOPY ge_errores_pg.evento)
IS

lv_des_error    VARCHAR2(300);
lv_sql          VARCHAR2(1000);
lv_cont         NUMBER;

BEGIN

     sn_cod_retorno := 0;
     sv_mens_retorno := '';
     sn_num_evento := 0;

     lv_sql := 'select cod_tipificacion,cod_articulo,flag_clientizable,nom_usuario from ga_tipificacion_td WHERE  cod_articulo = '||en_cod_articulo||'';

     SELECT cod_tipificacion,flag_clientizable,nom_usuario
     INTO   sv_cod_tipificacion,sn_flag_clientizable,sn_nom_usuario
     FROM   ga_tipificacion_td
     WHERE  cod_articulo = en_cod_articulo;

EXCEPTION
    WHEN NO_DATA_FOUND THEN
          sn_cod_retorno  := 30018;
         sv_mens_retorno := 'No existe dato en la tabla ga_tipificacion_td';
         lv_des_error      := 've_tipificacion_pg.ve_rec_artic_prc_fn() - ' || SQLERRM;
         sn_num_evento      := ge_errores_pg.grabarpl (sn_num_evento, cv_modulove, sv_mens_retorno, cv_version, USER, 've_tipificacion_pg.ve_rec_artic_prc_fn()', lv_sql, SQLCODE, SQLERRM);
    WHEN OTHERS THEN
         sn_cod_retorno  := 30019;
         sv_mens_retorno := 'No es posible ejecutar este servicio';
         lv_des_error      := 've_tipificacion_pg.ve_insert_tipificacion_pr() - ' || SQLERRM;
           sn_num_evento      := ge_errores_pg.grabarpl (sn_num_evento, cv_modulove, sv_mens_retorno, cv_version, USER, 've_tipificacion_pg.ve_insert_tipificacion_pr()', lv_sql, SQLCODE, SQLERRM);
END ve_selec_tipifica_pr;
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE ve_update_tipifica_pr(
                                en_cod_articulo      IN ga_tipificacion_td.cod_articulo%TYPE,
                                ev_cod_tipificacion  IN ga_tipificacion_td.cod_tipificacion%TYPE,
                                en_flag_clientizable IN ga_tipificacion_td.flag_clientizable%TYPE,
                                sn_nom_usuario       IN ga_tipificacion_td.nom_usuario%TYPE,
                                en_des_tipificacion  IN ga_tipificacion_td.DES_TIPIFICACION%TYPE,
                                sn_cod_retorno       OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                                sv_mens_retorno      OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                                sn_num_evento        OUT NOCOPY ge_errores_pg.evento)
IS

   /* Modificacion
    * Descripcion:Se agrega parametro de entrada sn_nom_usuario
    * Developer: Gabriel Moraga L.
    * Fecha: 10/06/2010
    */

lv_des_error    VARCHAR2(300);
lv_sql          VARCHAR2(1000);
lv_cont         NUMBER;

BEGIN

     sn_cod_retorno := 0;
     sv_mens_retorno := '';
     sn_num_evento := 0;

     lv_sql := 'UPDATE ga_tipificacion_td SET '
             ||'cod_tipificacion = '||ev_cod_tipificacion||','
             ||'flag_clientizable = '||en_flag_clientizable||','
             ||'nom_usuario = '||sn_nom_usuario||' '
             ||'WHERE cod_articulo = '||en_cod_articulo||'';

     UPDATE ga_tipificacion_td SET
     cod_tipificacion = ev_cod_tipificacion,
     flag_clientizable = en_flag_clientizable,
     nom_usuario = sn_nom_usuario,
     des_tipificacion = en_des_tipificacion
     WHERE cod_articulo = en_cod_articulo;

EXCEPTION
    WHEN OTHERS THEN
         sn_cod_retorno  := 30020;
         sv_mens_retorno := 'No es posible ejecutar este servicio';
         lv_des_error      := 've_tipificacion_pg.ve_insert_tipificacion_pr() - ' || SQLERRM;
           sn_num_evento      := ge_errores_pg.grabarpl (sn_num_evento, cv_modulove, sv_mens_retorno, cv_version, USER, 've_tipificacion_pg.ve_insert_tipificacion_pr()', lv_sql, SQLCODE, SQLERRM);
END ve_update_tipifica_pr;
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE ve_delete_tipifica_pr(
                                en_cod_articulo      IN ga_tipificacion_td.cod_articulo%TYPE,
                                sn_cod_retorno       OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                                sv_mens_retorno      OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                                sn_num_evento        OUT NOCOPY ge_errores_pg.evento)
IS

/*
<Documentación
Tipodoc = "PROCEDIMIENTO">
<Elemento Nombre = "ve_delete_tipifica_pr"
Lenguaje="PL/SQL" Fecha="10-06-2010" Versión="1.0.0"
Diseñador="Gabriel Moraga L."
Programador="Gabriel Moraga L."
Ambiente="BD">
<Retorno></Retorno>
<Descripción>Elimina una tipificacion</Descripción>
<Parámetros>
<Entrada>
<param nom="en_cod_articulo " Tipo="ga_tipificacion_td.cod_articulo%TYPE"> Numero del articulo </param>
</Entrada>
<Salida>
<param nom="sn_cod_retorno" Tipo="NUMBER"> Codigo de error </param>
<param nom="sv_mens_retorno" Tipo="STRING"> Mensaje de error </param>
<param nom="sn_num_evento" Tipo="NUMBER"> Numero de evento </param>
</Salida>
</Parámetros>
</Elemento>
</Documentación>
*/


lv_des_error    VARCHAR2(300);
lv_sql          VARCHAR2(1000);
lv_cont         NUMBER;

BEGIN

     sn_cod_retorno := 0;
     sv_mens_retorno := '';
     sn_num_evento := 0;

     lv_sql :=   'DELETE ga_tipificacion_td'
               ||'WHERE COD_ARTICULO ='||en_cod_articulo||'';

     DELETE FROM ga_tipificacion_td
     WHERE COD_ARTICULO = en_cod_articulo;

EXCEPTION
    WHEN OTHERS THEN
         sn_cod_retorno  := 30021;
         sv_mens_retorno := 'No es posible ejecutar este servicio';
         lv_des_error      := 've_tipificacion_pg.ve_delete_tipifica_pr() - ' || SQLERRM;
           sn_num_evento      := ge_errores_pg.grabarpl (sn_num_evento, cv_modulove, sv_mens_retorno, cv_version, USER, 've_tipificacion_pg.ve_delete_tipifica_pr', lv_sql, SQLCODE, SQLERRM);
END ve_delete_tipifica_pr;
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE ve_recupera_zip_pr(
                             ev_cod_region      IN ge_ciucom.cod_region%TYPE,
                             ev_cod_provincia   IN ge_ciucom.cod_provincia%TYPE,
                             ev_cod_ciudad      IN ge_ciucom.cod_ciudad%TYPE,
                             ev_cod_comuna      IN ge_ciucom.cod_comuna%TYPE,
                             sv_zip             OUT NOCOPY ge_zipcode_td.zip%TYPE,
                             sn_cod_retorno     OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                             sv_mens_retorno    OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                             sn_num_evento      OUT NOCOPY ge_errores_pg.evento)
IS

lv_des_error    VARCHAR2(300);
lv_sql          VARCHAR2(1000);
lv_cont         NUMBER;

BEGIN

     sn_cod_retorno := 0;
     sv_mens_retorno := '';
     sn_num_evento := 0;

     lv_sql := 'SELECT zip FROM ge_zipcode_td WHERE cod_zona IN ( '
               ||'SELECT cod_comuna FROM ge_ciucom WHERE cod_region = '||ev_cod_region||' '
               ||'AND cod_provincia = '||ev_cod_provincia||' AND cod_ciudad = '||ev_cod_ciudad||' '
               ||'AND cod_comuna = '||ev_cod_comuna||')';

     SELECT zip
     INTO   sv_zip
     FROM   ge_zipcode_td
     WHERE  cod_zona IN (
                SELECT cod_comuna
                FROM   ge_ciucom
                WHERE  cod_region = ev_cod_region
                AND    cod_provincia = ev_cod_provincia
                AND    cod_ciudad = ev_cod_ciudad
                AND    cod_comuna = ev_cod_comuna);

EXCEPTION
    WHEN NO_DATA_FOUND THEN
          sn_cod_retorno  := 30022;
         sv_mens_retorno := 'No existe dato en la tabla ge_zipcode_td';
         lv_des_error      := 've_tipificacion_pg.ve_recupera_zip_pr() - ' || SQLERRM;
         sn_num_evento      := ge_errores_pg.grabarpl (sn_num_evento, cv_modulove, sv_mens_retorno, cv_version, USER, 've_tipificacion_pg.ve_recupera_zip_pr()', lv_sql, SQLCODE, SQLERRM);
    WHEN OTHERS THEN
         sn_cod_retorno  := 30023;
         sv_mens_retorno := 'No es posible ejecutar este servicio';
         lv_des_error      := 've_tipificacion_pg.ve_recupera_zip_pr() - ' || SQLERRM;
           sn_num_evento      := ge_errores_pg.grabarpl (sn_num_evento, cv_modulove, sv_mens_retorno, cv_version, USER, 've_tipificacion_pg.ve_recupera_zip_pr()', lv_sql, SQLCODE, SQLERRM);
END ve_recupera_zip_pr;

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   PROCEDURE ve_rec_celular_serie_pr(
      ev_num_serie       IN  al_series.num_serie%TYPE,
      ev_num_venta       IN  ga_ventas.num_venta%TYPE,
      sv_num_celular     OUT NOCOPY ga_aboamist.num_celular%TYPE,
      sn_cod_retorno     OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno    OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
      sn_num_evento      OUT NOCOPY ge_errores_pg.evento)
   IS

      lv_des_error    VARCHAR2(300);
      lv_sql          VARCHAR2(1000);
   BEGIN

      sn_cod_retorno := 0;
      sv_mens_retorno := '';
      sn_num_evento := 0;


      IF NOT (ve_val_serie_kit_fn (ev_num_serie,ev_num_venta,sv_num_celular,sn_cod_retorno,sv_mens_retorno,sn_num_evento)) THEN

         IF NOT (ve_val_serie_sim_fn (ev_num_serie,ev_num_venta,sv_num_celular,sn_cod_retorno,sv_mens_retorno,sn_num_evento)) THEN
            sv_num_celular := null;
         END IF;

      END IF;


      EXCEPTION
         WHEN NO_DATA_FOUND THEN
             sn_cod_retorno  := 30024;
            sv_mens_retorno := 'No existe dato en la tabla ge_zipcode_td';
            lv_des_error      := 've_tipificacion_pg.ve_recupera_zip_pr() - ' || SQLERRM;
            sn_num_evento      := ge_errores_pg.grabarpl (sn_num_evento, cv_modulove, sv_mens_retorno, cv_version, USER, 've_tipificacion_pg.ve_recupera_zip_pr()', lv_sql, SQLCODE, SQLERRM);
         WHEN OTHERS THEN
            sn_cod_retorno  := 30025;
            sv_mens_retorno := 'No es posible ejecutar este servicio';
            lv_des_error      := 've_tipificacion_pg.ve_recupera_zip_pr() - ' || SQLERRM;
              sn_num_evento      := ge_errores_pg.grabarpl (sn_num_evento, cv_modulove, sv_mens_retorno, cv_version, USER, 've_tipificacion_pg.ve_recupera_zip_pr()', lv_sql, SQLCODE, SQLERRM);
   END ve_rec_celular_serie_pr;

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
END ve_tipificacion_pg;
/
SHOW ERRORS