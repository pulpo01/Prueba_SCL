CREATE OR REPLACE PROCEDURE al_asigna_numero_pr(

-----------------------------------------------------

/*
<NOMBRE>       : AL_ASIGNA_NUMERO_PR </NOMBRE>
<FECHACREA>    : 14-11-2004 </FECHACREA>
<MODULO >      : ADMINISTRACION DE INVENTARIO </MODULO >
<AUTOR >       : LOGISTICA </AUTOR>
<VERSION >     : 1.1 </VERSION>
<DESCRIPCION>  : RUTINAS DE NUMERACION DE SERIES MASIVA</DESCRIPCION>
<FECHAMOD >    : 04-12-2006 </FECHAMOD >
<DESCMOD >     : REQ_35796, SE INCORPORA VERIFICACION DEL NUMERO QUE NO EXISTA EN LAS TABLAS DE ABONADOS CON SITUACION <> 'BAA' y 'BAP'</DESCMOD >
<ParamEntr>    : </ParamEntr>
<ParamSal >    : </ParamEntr>
*/

-----------------------------------------------------



  v_numeracion IN al_ser_numeracion.num_numeracion%TYPE ,
  v_linea IN al_ser_numeracion.lin_numeracion%TYPE ,
  v_subalm IN ge_subalms.cod_subalm%TYPE ,
  v_central IN icg_central.cod_central%TYPE ,
  v_uso IN al_usos.cod_uso%TYPE ,
  v_nro_reutil IN OUT NUMBER ,
  v_cat IN ga_catnumer.cod_cat%TYPE ,
  v_error IN OUT PLS_INTEGER )
  IS
    v_ind_equipado ga_celnum_reutil.ind_equipado%TYPE;
    v_rownum       NUMBER(4);
    v_producto     ge_datosgener.prod_celular%TYPE;
    v_dias         al_usos.num_dias_hibernacion%TYPE;
        v_uso_sin_uso al_celnum_reutil.cod_uso%TYPE;


    CURSOR c_sernumera (p_orden al_ser_numeracion.num_numeracion%TYPE,
                                                                        p_linea al_ser_numeracion.lin_numeracion%TYPE,
                                               p_subalm al_series.cod_subalm%TYPE,
                                               p_central al_series.cod_central%TYPE,
                                               p_cat al_series.cod_cat%TYPE)
        IS
           SELECT num_numeracion, lin_numeracion,num_serie
                   FROM al_ser_numeracion
           WHERE num_numeracion = p_orden
           AND lin_numeracion = p_linea
           AND ind_numerado > 0
           AND cod_subalm  = p_subalm
           AND cod_central = p_central
           AND cod_cat     = p_cat
           AND num_telefono IS NULL
           FOR UPDATE OF num_telefono NOWAIT;


          CURSOR c_tel_libres(p_subalm al_series.cod_subalm%TYPE,
                                                   p_producto al_series.cod_producto%TYPE,
                                           p_central al_series.cod_central%TYPE,
                                           p_cat al_series.cod_cat%TYPE,
                                                                                   p_uso al_series.cod_uso%TYPE,
                                                                                   p_dias al_usos.num_dias_hibernacion%TYPE)
                  IS
            SELECT num_celular
            FROM al_celnum_reutil a
            WHERE cod_subalm       = p_subalm
            AND cod_producto       = p_producto
            AND cod_central        = p_central
            AND cod_cat            = p_cat
            AND cod_uso            = p_uso
            AND (fec_baja + p_dias <= TRUNC(SYSDATE) OR p_dias = 0)
            AND a.ind_equipado     = 1
--          C.A.A.D. 04-12-2006 REQ_35796 INICIO MODIFICACION
                  AND NOT EXISTS (SELECT 1 FROM al_series b WHERE b.num_telefono = a.num_celular)
            AND NOT EXISTS (SELECT 1 FROM ga_abocel c WHERE c.num_celular = a.num_celular AND c.cod_situacion NOT IN ('BAA', 'BAP'))
            AND NOT EXISTS (SELECT 1 FROM ga_aboamist d WHERE d.num_celular = a.num_celular AND d.cod_situacion  NOT IN ('BAA', 'BAP'))
--          C.A.A.D. 04-12-2006 REQ_35796 TERMINO MODIFICACION
            AND ROWNUM < v_rownum;



    v_sernumera   c_sernumera%ROWTYPE;
    v_celular     al_celnum_reutil.num_celular%TYPE;
    v_numero      al_ser_numeracion.num_telefono%TYPE;
    v_zero        NUMBER := 0;
    BEGIN
        v_ind_equipado := 1;
        v_rownum       := 11;
        al_pac_numeracion.p_select_celular (v_producto,
                          v_error);
        BEGIN
           v_dias := ge_fn_dias_hibernacion(v_uso);
           v_uso_sin_uso := NVL(ge_fn_uso_sin_uso,v_uso);
           EXCEPTION
                     WHEN OTHERS THEN
                        v_error := 1;
        END;



        IF v_error = 0 THEN

           OPEN c_sernumera(v_numeracion, v_linea,v_subalm, v_central, v_cat);
           LOOP
           FETCH c_sernumera INTO v_sernumera;
           EXIT WHEN c_sernumera%NOTFOUND;
           -- Nos han quitado un numero, y ademas este era el ultimo reutilizable,
           -- mientras estabamos procesando!!
           v_numero := NULL;

           IF v_nro_reutil > 0 THEN

              OPEN c_tel_libres(v_subalm,v_producto,v_central,v_cat,v_uso,v_dias);
              LOOP

              FETCH c_tel_libres INTO v_celular;
              EXIT WHEN c_tel_libres%NOTFOUND;

              BEGIN
                     v_numero := NULL;
                     SELECT num_celular
                     INTO v_numero
                     FROM al_celnum_reutil
                     WHERE num_celular = v_celular
                     FOR UPDATE NOWAIT;

                        -- si estaba bloqueado salta la excepcion y busca otro numero
                     v_nro_reutil := v_nro_reutil -1;
                     DELETE al_celnum_reutil
                     WHERE num_celular = v_celular;
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
                          IF c_tel_libres%NOTFOUND THEN
                     v_nro_reutil := 0;
                     CLOSE c_tel_libres;
              END IF;
           END IF;
     -- ahora update al_ser_numeracion y activacion
           IF v_numero IS NOT NULL THEN
              UPDATE al_ser_numeracion
              SET num_telefono = v_numero
              WHERE num_numeracion=v_sernumera.num_numeracion
                          AND lin_numeracion=v_sernumera.lin_numeracion
                          AND num_serie=v_sernumera.num_serie;
           ELSE
              v_error:=1;
              EXIT;  -- del LOOP principal
           END IF;

           IF c_tel_libres%ISOPEN  THEN
              CLOSE c_tel_libres;
           END IF;

           IF v_error = 7 THEN
              RAISE_APPLICATION_ERROR (-20175,' ');
           END IF;
           END LOOP;
           CLOSE c_sernumera;
        END IF;

    EXCEPTION
        WHEN OTHERS THEN
             IF v_error = 7 THEN
                   RAISE_APPLICATION_ERROR (-20175, 'Error Creacion Mvto. Activacion');
                 ELSE
                        v_error := 1;
              END IF;
    END al_asigna_numero_pr;
/
SHOW ERRORS
