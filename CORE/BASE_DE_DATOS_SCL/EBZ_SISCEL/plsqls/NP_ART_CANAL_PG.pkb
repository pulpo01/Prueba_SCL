CREATE OR REPLACE PACKAGE BODY EBZ_SISCEL.NP_ART_CANAL_PG IS
/*
<NOMBRE>           : NP_ART_CANAL_PG </NOMBRE>
<FECHACREA>      : 16-07-2013<FECHACREA/>
<MODULO >          : Logistica </MODULO >
<AUTOR >            : IGOR SANCHEZ - ROBINSON SOTO T. </AUTOR >
<VERSION >         : 1.0</VERSION >
<DESCRIPCION>   : Mantención de Sobre Stock y Consultas por Tipo Canal </DESCRIPCION>
*/

    FUNCTION SPLIT_PARAMETRO_MULTIPLE (
        p_param_list    VARCHAR2,
        p_param_del    VARCHAR2
    ) RETURN NP_SPLIT_PARAM pipelined

    IS
    LI_indice pls_integer;
    LV_param_list VARCHAR2(5000);

    BEGIN
        LV_param_list := p_param_list;
        LOOP
            LI_indice := instr(LV_param_list, p_param_del);

            IF LI_indice > 0 THEN
                pipe row (substr(LV_param_list,1, LI_indice-1));
                LV_param_list := substr(LV_param_list,LI_indice+LENGTH(p_param_del));
            ELSE
                pipe row (LV_param_list);
                EXIT;
            END IF;
        END LOOP;
        RETURN;
    END;

   PROCEDURE NP_INSERTA_CANAL_ART_PR  (
      v_cod_tipo_canal in npt_limite_Art_canal_td.COD_TIPO_CANAL%TYPE,
      v_cod_usuario     in  npt_limite_Art_canal_td.COD_USUARIO%TYPE,
      v_cod_articulo     in  npt_limite_Art_canal_td.COD_ARTICULO%TYPE,
      v_tip_stock          in  npt_limite_Art_canal_td.TIP_STOCK%TYPE,
      v_cod_uso           in  npt_limite_Art_canal_td.COD_USO%TYPE,
      v_cantidad           in  npt_limite_Art_canal_td.CANTIDAD%TYPE,
      v_operacion         in  varchar2,
      v_fec_desde         in  varchar2,
      v_fec_hasta          in  varchar2,
      v_fec_desde_new  in  varchar2,
      v_fec_hasta_new   in  varchar2,
      strError                 out varchar2
   ) IS
         BEGIN

            IF v_operacion = 'I' THEN
                BEGIN
                       INSERT INTO npt_limite_Art_canal_td (COD_TIPO_CANAL,
                                                            COD_USUARIO,
                                                            COD_ARTICULO,
                                                            TIP_STOCK,
                                                            COD_USO,
                                                            CANTIDAD,
                                                            USU_CREACION,
                                                            FEC_CREACION,
                                                            FEC_DESDE,
                                                            FEC_HASTA)
                         VALUES (v_cod_tipo_canal,
                                  v_cod_usuario,
                                   v_cod_articulo,
                                   v_tip_stock,
                                   v_cod_uso,
                                   v_cantidad,
                                   USER,
                                   SYSDATE,
                                   to_date(v_fec_desde,'dd-mm-yyyy'),
                                   to_date(v_fec_hasta,'dd-mm-yyyy')
                                   );



                EXCEPTION
                   WHEN OTHERS THEN
                   strError:='ERROR AL INSERTAR LIMITE, COD_CLIENTE:' || v_cod_usuario || ', COD_ARTICULO:' || v_cod_articulo ;
                 END;

            ELSIF v_operacion = 'M' THEN
                BEGIN
                    UPDATE npt_limite_Art_canal_td
                     SET CANTIDAD=v_cantidad,
                         FEC_DESDE=TO_DATE(v_fec_desde_new,'DD-MM-YYYY'),
                         FEC_HASTA=TO_DATE(v_fec_hasta_new,'DD-MM-YYYY')
                     WHERE COD_TIPO_CANAL= V_COD_TIPO_CANAL AND
                            COD_USUARIO=v_cod_usuario AND
                           COD_ARTICULO=v_cod_articulo AND
                           TIP_STOCK=v_tip_stock AND
                           COD_USO=v_cod_uso AND
                           FEC_DESDE=TO_DATE(v_fec_desde,'DD-MM-YYYY') AND
                           FEC_HASTA=TO_DATE(v_fec_hasta,'DD-MM-YYYY');
                EXCEPTION
                   WHEN OTHERS THEN
                   strError:='ERROR AL ACTUALIZAR LIMITE, COD_CLIENTE:' || v_cod_usuario || ', COD_ARTICULO:' || v_cod_articulo ;
                 END;


            ELSE

                BEGIN
                  DELETE npt_limite_Art_canal_td
                 WHERE COD_TIPO_CANAL= V_COD_TIPO_CANAL AND
                        COD_USUARIO=v_cod_usuario AND
                       COD_ARTICULO=v_cod_articulo AND
                       TIP_STOCK=v_tip_stock AND
                       COD_USO=v_cod_uso AND
                       FEC_DESDE=TO_DATE(v_fec_desde,'DD-MM-YYYY') AND
                       FEC_HASTA=TO_DATE(v_fec_hasta,'DD-MM-YYYY');
                   --strError:='ELIMINADO';
                EXCEPTION
                   WHEN OTHERS THEN
                   strError:='ERROR AL ELIMINAR LIMITE, COD_CLIENTE:' || v_cod_usuario || ', COD_ARTICULO:' || v_cod_articulo;
                 END;


            END IF;

            COMMIT;

   END NP_INSERTA_CANAL_ART_PR;

   PROCEDURE NP_VALIDA_CANTIDAD_LIMITE  (
      v_cod_tipo_canal in npt_limite_Art_canal_td.COD_TIPO_CANAL%TYPE,
      v_cod_usuario     in npt_limite_articulo_td.COD_USUARIO%TYPE,
      v_cod_articulo     in npt_limite_articulo_td.COD_ARTICULO%TYPE,
      v_tip_stock          in npt_limite_articulo_td.TIP_STOCK%TYPE,
      v_cod_uso           in npt_limite_articulo_td.COD_USO%TYPE,
      v_cantidad           out npt_limite_articulo_td.CANTIDAD%TYPE,
      strError               out varchar2
   ) IS

          v_cantidad_lim  npt_limite_articulo_td.CANTIDAD%TYPE ;
          v_cantidad_ped  npt_limite_articulo_td.CANTIDAD%TYPE ;
          v_count_limite  number;
          v_count_detalle number;
          v_count_parametro  number;
          v_comando_sql        VARCHAR2(3000) := '';
          LV_parametro         VARCHAR2(100) := '';
          LV_FEC_DESDE       npt_limite_articulo_td.FEC_DESDE%TYPE ;
          LV_FEC_HASTA       npt_limite_articulo_td.FEC_HASTA%TYPE ;

         BEGIN

             --- Buscar si existe proyección individual  
             SELECT
                count(1)
             INTO
                v_count_limite
             FROM
                NPT_LIMITE_ARTICULO_TD
             WHERE
                cod_uso        = v_cod_uso
                AND tip_stock = v_tip_stock
                AND cod_articulo = v_cod_articulo
                AND cod_usuario = v_cod_usuario
                AND TRUNC(SYSDATE) BETWEEN FEC_DESDE AND FEC_HASTA;

                 if v_count_limite >0  then

                  --- Suma la proyección individual existente para el articulo y uso del pedido
                  SELECT
                     SUM(cantidad), MIN(fec_desde), MAX(fec_hasta)
                  INTO
                     v_cantidad_lim,LV_FEC_DESDE,LV_FEC_HASTA
                  FROM
                     NPT_LIMITE_ARTICULO_TD
                  WHERE
                     cod_uso        = v_cod_uso
                     AND tip_stock = v_tip_stock
                     AND cod_articulo = v_cod_articulo
                     AND cod_usuario = v_cod_usuario
                     AND TRUNC(SYSDATE) BETWEEN FEC_DESDE AND FEC_HASTA;

                   SELECT
                      COUNT(*)
                   INTO
                      v_count_parametro
                   FROM
                      NPT_PARAMETRO
                   WHERE
                      ALIAS_PARAMETRO = 'ESTADO_LIM';

                   IF v_count_parametro >0  then

                      SELECT
                         VALOR_PARAMETRO
                      INTO
                         LV_parametro
                      FROM
                         NPT_PARAMETRO
                      WHERE
                         ALIAS_PARAMETRO = 'ESTADO_LIM';

                           IF LENGTH(TRIM (LV_parametro))>0 THEN
                                ---Revisa si existen consumos durante el periodo vigente de las proyeccion individual 
                                v_comando_sql := 'SELECT NVL(SUM (can_detalle_pedido),0) ';
                                v_comando_sql := v_comando_sql || '  FROM npt_detalle_pedido a, ';
                                v_comando_sql := v_comando_sql || '       (SELECT   cod_pedido, MAX (cod_estado_flujo) ';
                                v_comando_sql := v_comando_sql || '           FROM npt_estado_pedido';
                                v_comando_sql := v_comando_sql || '       GROUP BY cod_pedido ';
                                v_comando_sql := v_comando_sql || '          HAVING MAX (cod_estado_flujo) IN ('||LV_parametro||')) b, ';
                                v_comando_sql := v_comando_sql || '       npt_pedido c ';
                                v_comando_sql := v_comando_sql || ' WHERE a.cod_pedido = b.cod_pedido ';
                                v_comando_sql := v_comando_sql || '   AND a.cod_pedido = c.cod_pedido ';
                                v_comando_sql := v_comando_sql || '   AND c.cod_cliente =' || v_cod_usuario;
                                v_comando_sql := v_comando_sql || '   AND a.cod_articulo =' ||  v_cod_articulo ;
                                v_comando_sql := v_comando_sql || '   AND tip_stock =' || v_tip_stock ;
                                v_comando_sql := v_comando_sql || '   AND cod_uso =' || v_cod_uso ;
                                v_comando_sql := v_comando_sql || '   AND TRUNC(c.fec_cre_pedido) between TO_DATE('''|| TO_CHAR(LV_FEC_DESDE,'DD-MM-YYYY') || ''',''DD-MM-YYYY'') AND TO_DATE(''' || TO_CHAR(LV_FEC_HASTA,'DD-MM-YYYY') || ''',''DD-MM-YYYY'')' ;

                                EXECUTE IMMEDIATE v_comando_sql INTO  v_cantidad_ped;

                                      if  v_cantidad_ped >0 then
                                            v_cantidad:=v_cantidad_lim - v_cantidad_ped;
                                      else
                                            v_cantidad:= v_cantidad_lim;
                                          --  v_cantidad_ped:=0; --
                                      end if;
                          else
                                v_cantidad:= v_cantidad_lim;
                             ---   v_cantidad_ped:=0;--
                           END IF  ;
                    else
                     v_cantidad:= v_cantidad_lim;
                   ---  v_cantidad_ped:=0;
                   END IF;
                 else
                    v_cantidad:= NULL;
                  ---  v_cantidad_lim:=0;--
                 end if;

            if v_cantidad<0 then
                v_cantidad:=0;
             end if ;

         END NP_VALIDA_CANTIDAD_LIMITE;

   PROCEDURE NP_INSERTA_ERRORES (
      v_cod_retorno           in ge_errores_pg.CodError,
      v_componente_error  in  ge_errores_pg.DesEvent,
      v_error_desc             in VARCHAR2
   ) IS

   SN_cod_retorno  ge_errores_pg.CodError;
   SV_mens_retorno ge_errores_pg.MsgError;
   SN_num_evento   ge_errores_pg.Evento;

   BEGIN
        SN_num_evento :=0;

        SN_cod_retorno := v_cod_retorno;
        IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
           SV_mens_retorno := CV_error_no_clasif;
        END IF;
        SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'AL', SN_cod_retorno||' -- '||SV_mens_retorno, '1.0', USER, v_componente_error, '', '', v_error_desc );

   END NP_INSERTA_ERRORES;

   PROCEDURE NP_GET_LIMITE_ARTICULO  (
      v_cod_tipo_canal in npt_limite_Art_canal_td.COD_TIPO_CANAL%TYPE,
      v_cod_usuario     in npt_limite_articulo_td.COD_USUARIO%TYPE,
      v_cod_articulo     in npt_limite_articulo_td.COD_ARTICULO%TYPE,
      v_tip_stock          in npt_limite_articulo_td.TIP_STOCK%TYPE,
      v_cod_uso          in npt_limite_articulo_td.COD_USO%TYPE,
      v_cantidad          out npt_limite_articulo_td.CANTIDAD%TYPE,
      strError              out varchar2
   ) IS

    v_count_limite  number;

    BEGIN
                 SELECT
                    count(1)
                 INTO
                    v_count_limite
                 FROM
                    NPT_LIMITE_ARTICULO_TD
                 WHERE
                    cod_uso         = v_cod_uso
                    AND tip_stock   = v_tip_stock
                    AND cod_articulo= v_cod_articulo
                    AND cod_usuario = v_cod_usuario;

                     IF v_count_limite >0  THEN

                        SELECT
                           cantidad
                        INTO
                           v_cantidad
                        FROM
                           NPT_LIMITE_ARTICULO_TD
                        WHERE
                           cod_uso         = v_cod_uso
                           AND tip_stock   = v_tip_stock
                           AND cod_articulo= v_cod_articulo
                           AND cod_usuario = v_cod_usuario;

                     ELSE

                        v_cantidad :=0;

                     END IF;

   END NP_GET_LIMITE_ARTICULO;

   PROCEDURE NP_VALIDA_SOBRE_STOCK  (
      V_COD_TIPO_CANAL IN NPT_LIMITE_ART_CANAL_TD.COD_TIPO_CANAL%TYPE,
      V_COD_ARTICULO IN NPT_LIMITE_ART_CANAL_TD.COD_ARTICULO%TYPE,
      V_CANTIDAD OUT NPT_LIMITE_ART_CANAL_TD.CANTIDAD%TYPE,
      STRERROR  OUT VARCHAR2
   ) IS

   CUENTASTOCK_A NUMBER;
   CTADISTRI_B   NUMBER;

    BEGIN
          BEGIN
             SELECT
                NVL(SUM(CANTIDAD),0) AS CUENTASTOCK_A
             INTO
                CUENTASTOCK_A
             FROM
                NPT_LIMITE_ART_CANAL_TD
             WHERE
                COD_TIPO_CANAL = V_COD_TIPO_CANAL
                AND COD_ARTICULO = V_COD_ARTICULO
                AND FEC_HASTA > SYSDATE;

             IF CUENTASTOCK_A >0  THEN
                SELECT
                   COUNT(COD_USUARIO) AS CTADISTRI_B
                INTO
                   CTADISTRI_B
                FROM
                   NPT_USUARIO_TIPO_CANAL
                WHERE
                   COD_TIPO_CANAL = V_COD_TIPO_CANAL;

             ELSE
                CUENTASTOCK_A :=0;

             END IF ;

             IF CTADISTRI_B > 0 THEN
                SELECT
                   ROUND((CUENTASTOCK_A) / (CTADISTRI_B),2)
                INTO
                   V_CANTIDAD
                FROM
                   DUAL;
             ELSE
                V_CANTIDAD:=0;
             END IF;

             EXCEPTION
             WHEN OTHERS THEN
                strError:='ERROR EN NP_VALIDA_SOBRE_STOCK PARA CANAL:' || V_COD_TIPO_CANAL || ', COD_ARTICULO:' || V_COD_ARTICULO;
          END;

    END NP_VALIDA_SOBRE_STOCK;

   PROCEDURE NP_VALIDA_SOBRE_STOCK_VAL  (
      V_COD_TIPO_CANAL      IN NPT_LIMITE_ART_CANAL_TD.COD_TIPO_CANAL%TYPE,
      V_COD_ARTICULO         IN NPT_LIMITE_ART_CANAL_TD.COD_ARTICULO%TYPE,
      V_TIP_STOCK                IN NPT_LIMITE_ART_CANAL_TD.TIP_STOCK%TYPE,
      V_COD_USO                  IN NPT_LIMITE_ART_CANAL_TD.COD_USO%TYPE,
      V_CANTIDAD                 OUT NPT_LIMITE_ART_CANAL_TD.CANTIDAD%TYPE,
      STRERROR                    OUT VARCHAR2
   ) IS

   LN_cnt_stock       NUMBER:=0;
   LN_cnt_distr        NUMBER:=0;
   LN_ind_tipventa   NUMBER:=0;
   LN_cod_estado    NUMBER:=0;

    BEGIN
          BEGIN
             SELECT
                NVL(SUM(CANTIDAD),0) AS CUENTASTOCK_A
             INTO
                LN_cnt_stock
             FROM
                NPT_LIMITE_ART_CANAL_TD
             WHERE
                COD_USO                   = v_cod_uso
                AND TIP_STOCK          = v_tip_stock
                AND COD_ARTICULO    = v_cod_articulo
                AND COD_TIPO_CANAL = v_cod_tipo_canal
                AND FEC_HASTA > SYSDATE;

             IF LN_cnt_stock >0  THEN
                SELECT
                   COUNT(T.COD_USUARIO) AS CTADISTRI_B
                INTO
                   LN_cnt_distr
                FROM
                   VE_VENDEDORES                 V,
                   NPT_USUARIO_TIPO_CANAL T
                WHERE
                   T.COD_USUARIO          = V.COD_VENDEDOR
                   AND COD_TIPO_CANAL = v_cod_tipo_canal
                   AND IND_TIPVENTA      = LN_ind_tipventa
                   AND COD_ESTADO       = LN_cod_estado;
             ELSE
                LN_cnt_stock :=0;
             END IF ;

             IF LN_cnt_distr > 0 THEN
                V_CANTIDAD := ROUND((LN_cnt_stock) / (LN_cnt_distr),2);
             ELSE
                V_CANTIDAD := 0;
             END IF;

             EXCEPTION
             WHEN OTHERS THEN
                strError:='ERROR EN NP_VALIDA_SOBRE_STOCK_VAL PARA CANAL:' || V_COD_TIPO_CANAL || ', COD_ARTICULO:' || V_COD_ARTICULO;
          END;

    END NP_VALIDA_SOBRE_STOCK_VAL;

    PROCEDURE NP_VALIDA_SOBRE_STOCK_INT (
        V_COD_TIPO_CANAL    IN NPT_LIMITE_ART_CANAL_TD.COD_TIPO_CANAL%TYPE,
        V_COD_USUARIO            IN NPT_LIMITE_ART_CANAL_TD.COD_USUARIO%TYPE,
        V_COD_ARTICULO        IN NPT_LIMITE_ART_CANAL_TD.COD_ARTICULO%TYPE,
        V_TIP_STOCK                IN NPT_LIMITE_ART_CANAL_TD.TIP_STOCK%TYPE,
        V_COD_USO                    IN NPT_LIMITE_ART_CANAL_TD.COD_USO%TYPE,
        V_CANTIDAD                OUT NPT_LIMITE_ART_CANAL_TD.CANTIDAD%TYPE,
        STRERROR                     OUT VARCHAR2
    ) IS

        LN_stock_individual       NUMBER:=0;
        LN_stock_canal             NUMBER:=0;
        LN_stock_porcanal        NUMBER:=0;
        LN_cantidad_dist          NUMBER:=0;
        LN_ind_tipventa            NUMBER:=0;
        LN_cod_estado             NUMBER:=0;
        LN_cnt_consumida        NUMBER:=0;
        LV_parametro              VARCHAR2(50) := '1,2,3,8,9,23,14';
        LV_alias_parametro      VARCHAR2(10) := 'ESTADO_LIM';
        LD_fec_consulta            DATE:=TRUNC(SYSDATE);
        LD_fec_desde                DATE:=TRUNC(SYSDATE);
        LD_fec_hasta                DATE:=TRUNC(SYSDATE);

    BEGIN
        BEGIN

            BEGIN
                ---Verifica la proyección individual  del articulo para el cliente, uso y stock
                SELECT
                    NVL(MIN(fec_desde), LD_fec_consulta), NVL(MAX(fec_hasta), LD_fec_consulta), NVL(SUM(CANTIDAD),0)
                INTO
                    LD_fec_desde, LD_fec_hasta, LN_stock_individual
                FROM
                    NPT_LIMITE_ARTICULO_TD
                WHERE
                    COD_USO                = V_COD_USO
                    AND TIP_STOCK       = V_TIP_STOCK
                    AND COD_ARTICULO = V_COD_ARTICULO
                    AND COD_USUARIO   = V_COD_USUARIO
                    AND LD_fec_consulta BETWEEN FEC_DESDE AND FEC_HASTA;
            END;

            IF (LD_fec_desde = LD_fec_consulta  AND LD_fec_hasta = LD_fec_consulta AND LN_stock_individual = 0)
            THEN
                BEGIN
                    ---Si no existe proyeccion individual vigente, buscará si existe alguna proyeccion para el articulo por canal, uso y tipo de stock
                    SELECT
                        NVL(MIN(fec_desde), LD_fec_consulta), NVL(MAX(fec_hasta), LD_fec_consulta), NVL(SUM(CANTIDAD),0)
                    INTO
                        LD_fec_desde, LD_fec_hasta, LN_stock_individual
                    FROM
                        NPT_LIMITE_ART_CANAL_TD
                    WHERE
                        COD_USO                    = V_COD_USO
                        AND TIP_STOCK           = V_TIP_STOCK
                        AND COD_ARTICULO     = V_COD_ARTICULO
                        AND COD_TIPO_CANAL = V_COD_TIPO_CANAL
                        AND LD_fec_consulta BETWEEN FEC_DESDE AND FEC_HASTA;
                END;
            ELSE
                BEGIN
                    ---Si existia proyeccion individual vigente, buscará la proyeccion para el articulo por canal, uso y tipo de stock
                    ---En el rango de fechas de la proyeccion individual
                    SELECT
                        NVL(SUM(CANTIDAD),0)
                    INTO
                        LN_stock_canal
                    FROM
                        NPT_LIMITE_ART_CANAL_TD
                    WHERE
                        COD_USO                    = V_COD_USO
                        AND TIP_STOCK           = V_TIP_STOCK
                        AND COD_ARTICULO     = V_COD_ARTICULO
                        AND COD_TIPO_CANAL = V_COD_TIPO_CANAL
                        AND LD_fec_consulta BETWEEN FEC_DESDE AND FEC_HASTA;
                END;
            END IF;

            BEGIN
                SELECT
                   COUNT(T.COD_USUARIO) AS cantidad_dist
                INTO
                   LN_cantidad_dist
                FROM
                   VE_VENDEDORES                 V,
                   NPT_USUARIO_TIPO_CANAL T
                WHERE
                   T.COD_USUARIO          = V.COD_VENDEDOR
                   AND COD_TIPO_CANAL = v_cod_tipo_canal
                   AND IND_TIPVENTA      = LN_ind_tipventa
                   AND COD_ESTADO       = LN_cod_estado;
            END;

            BEGIN
                SELECT
                    valor_parametro
                INTO
                    LV_parametro
                FROM
                    npt_parametro
                WHERE
                    ALIAS_PARAMETRO = LV_alias_parametro;
            END;

            BEGIN
                ---Busca los consumos realizados durante el periodo de busqueda de las proyecciones vigentes.
                SELECT
                    NVL(SUM(NDP.CAN_DETALLE_PEDIDO), 0)
                INTO
                    LN_cnt_consumida
                FROM
                    NPT_PEDIDO NPP
                JOIN
                    NPT_DETALLE_PEDIDO NDP
                ON
                    NPP.COD_PEDIDO = NDP.COD_PEDIDO
                JOIN
                    (
                    SELECT
                        COD_PEDIDO, MAX (COD_ESTADO_FLUJO)
                    FROM
                        NPT_ESTADO_PEDIDO
                    GROUP BY
                        COD_PEDIDO
                    HAVING
                        MAX(COD_ESTADO_FLUJO) IN (SELECT * FROM TABLE (SPLIT_PARAMETRO_MULTIPLE(LV_parametro, ',')))
                    ) NEP
                ON
                    NDP.COD_PEDIDO = NEP.COD_PEDIDO
                WHERE
                    NPP.COD_CLIENTE             = V_COD_USUARIO
                    AND NDP.COD_ARTICULO   = V_COD_ARTICULO
                    AND NDP.TIP_STOCK          = V_TIP_STOCK
                    AND NDP.COD_USO            = V_COD_USO
                    AND TRUNC(NPP.FEC_CRE_PEDIDO) BETWEEN LD_fec_desde AND LD_fec_hasta;
            END;

            IF LN_cantidad_dist > 0 THEN
                LN_stock_porcanal := ROUND((LN_stock_canal / LN_cantidad_dist),0);
            ELSE
                LN_stock_porcanal := LN_stock_canal;
            END IF;

            V_CANTIDAD := (LN_stock_individual - LN_cnt_consumida) + LN_stock_porcanal;

            EXCEPTION
            WHEN OTHERS THEN
                strError:='ERROR EN NP_VALIDA_SOBRE_STOCK_INT PARA CANAL:' || V_COD_TIPO_CANAL || ', COD_ARTICULO:' || V_COD_ARTICULO;
        END;

    END NP_VALIDA_SOBRE_STOCK_INT;

   PROCEDURE NP_CANTIDAD_SOBRE_STOCK  (
      V_COD_TIPO_CANAL IN NPT_LIMITE_ART_CANAL_TD.COD_TIPO_CANAL%TYPE,
      V_COD_ARTICULO    IN NPT_LIMITE_ART_CANAL_TD.COD_ARTICULO%TYPE,
      V_CANTIDAD            OUT NPT_LIMITE_ART_CANAL_TD.CANTIDAD%TYPE,
      STRERROR               OUT VARCHAR2
   ) IS

   CUENTASTOCK_A NUMBER;

    BEGIN
          BEGIN

             SELECT
                NVL(SUM(CANTIDAD),0) AS CANTIDAD
             INTO
                CUENTASTOCK_A
             FROM
                NPT_LIMITE_ART_CANAL_TD
             WHERE
                COD_TIPO_CANAL = V_COD_TIPO_CANAL
                AND COD_ARTICULO = V_COD_ARTICULO
                AND FEC_HASTA > SYSDATE;

             IF CUENTASTOCK_A >0  THEN
                V_CANTIDAD:=CUENTASTOCK_A;
             ELSE
                V_CANTIDAD :=0;
             END IF ;

          EXCEPTION
               WHEN OTHERS THEN
                   strError:='ERROR EN NP_CANTIDAD_SOBRE_STOCK PARA CANAL:' || V_COD_TIPO_CANAL || ', COD_ARTICULO:' || V_COD_ARTICULO;
          END;

    END NP_CANTIDAD_SOBRE_STOCK;

   PROCEDURE NP_CANTIDAD_SOBRE_STOCK_INT  (
      V_COD_TIPO_CANAL      IN NPT_LIMITE_ART_CANAL_TD.COD_TIPO_CANAL%TYPE,
      V_COD_ARTICULO         IN NPT_LIMITE_ART_CANAL_TD.COD_ARTICULO%TYPE,
      V_TIP_STOCK                IN NPT_LIMITE_ART_CANAL_TD.TIP_STOCK%TYPE,
      V_COD_USO                  IN NPT_LIMITE_ART_CANAL_TD.COD_USO%TYPE,
      V_CANTIDAD                 OUT NPT_LIMITE_ART_CANAL_TD.CANTIDAD%TYPE,
      STRERROR                    OUT VARCHAR2
   ) IS

    LN_cnt_stock             NUMBER:=0;

    BEGIN
          BEGIN
             SELECT
                NVL(SUM(CANTIDAD),0) AS CANTIDAD
             INTO
                LN_cnt_stock
             FROM
                NPT_LIMITE_ART_CANAL_TD
             WHERE
                COD_USO                   = v_cod_uso
                AND TIP_STOCK          = v_tip_stock
                AND COD_ARTICULO    = v_cod_articulo
                AND COD_TIPO_CANAL = v_cod_tipo_canal
                AND FEC_HASTA > SYSDATE;

          v_cantidad := LN_cnt_stock;

          EXCEPTION
               WHEN OTHERS THEN
                   strError:='ERROR EN NP_CANTIDAD_SOBRE_STOCK_INT PARA CANAL:' || V_COD_TIPO_CANAL || ', COD_ARTICULO:' || V_COD_ARTICULO;
          END;

    END NP_CANTIDAD_SOBRE_STOCK_INT;

   PROCEDURE NP_GET_ARTICULO_TRANSITO  (
      v_cod_tipo_canal in npt_limite_Art_canal_td.COD_TIPO_CANAL%TYPE,
      v_cod_usuario in npt_limite_articulo_td.COD_USUARIO%TYPE,
      v_cod_articulo in npt_limite_articulo_td.COD_ARTICULO%TYPE,
      v_tip_stock in npt_limite_articulo_td.TIP_STOCK%TYPE,
      v_cod_uso in npt_limite_articulo_td.COD_USO%TYPE,
      v_cantidad out npt_limite_articulo_td.CANTIDAD%TYPE,
      strError  out varchar2
   ) IS

   v_count_parametro  number;
   LV_parametro       VARCHAR2(100) := '';
   v_cantidad_ped  number;
   v_comando_sql        VARCHAR2(3000) := '';
   LV_FEC_DESDE      NPT_LIMITE_ARTICULO_TD.FEC_DESDE%TYPE ;
   LV_FEC_HASTA      NPT_LIMITE_ARTICULO_TD.FEC_HASTA%TYPE ;

   BEGIN
      SELECT
         COUNT(*)
      INTO
         v_count_parametro
      FROM
         NPT_PARAMETRO
      WHERE
         ALIAS_PARAMETRO = 'ESTADO_LIM';

      IF v_count_parametro >0  then

         SELECT
            VALOR_PARAMETRO
         INTO
            LV_parametro
         FROM
            NPT_PARAMETRO
         WHERE
            ALIAS_PARAMETRO = 'ESTADO_LIM';

         SELECT
            FEC_DESDE, FEC_HASTA
         INTO
            LV_FEC_DESDE, LV_FEC_HASTA
         FROM
            NPT_LIMITE_ARTICULO_TD
         WHERE
            cod_uso              = v_cod_uso
            AND tip_stock       = v_tip_stock
            AND cod_articulo  = v_cod_articulo
            AND cod_usuario  = v_cod_usuario
            AND TRUNC(SYSDATE) BETWEEN FEC_DESDE AND FEC_HASTA;

            IF LENGTH(TRIM (LV_parametro))>0 THEN
               v_comando_sql := 'SELECT NVL(SUM (can_detalle_pedido),0) ';
               v_comando_sql := v_comando_sql || '  FROM npt_detalle_pedido a, ';
               v_comando_sql := v_comando_sql || '       (SELECT   cod_pedido, MAX (cod_estado_flujo) ';
               v_comando_sql := v_comando_sql || '           FROM npt_estado_pedido';
               v_comando_sql := v_comando_sql || '       GROUP BY cod_pedido ';
               v_comando_sql := v_comando_sql || '          HAVING MAX (cod_estado_flujo) IN ('||LV_parametro||')) b, ';
               v_comando_sql := v_comando_sql || '       npt_pedido c ';
               v_comando_sql := v_comando_sql || ' WHERE a.cod_pedido = b.cod_pedido ';
               v_comando_sql := v_comando_sql || '   AND a.cod_pedido = c.cod_pedido ';
               v_comando_sql := v_comando_sql || '   AND c.cod_cliente =' || v_cod_usuario;
               v_comando_sql := v_comando_sql || '   AND a.cod_articulo =' ||  v_cod_articulo ;
               v_comando_sql := v_comando_sql || '   AND tip_stock =' || v_tip_stock ;
               v_comando_sql := v_comando_sql || '   AND cod_uso =' || v_cod_uso ;
               v_comando_sql := v_comando_sql || '   AND TRUNC(c.fec_cre_pedido) between TO_DATE('''|| TO_CHAR(LV_FEC_DESDE,'DD-MM-YYYY') || ''',''DD-MM-YYYY'') AND TO_DATE(''' || TO_CHAR(LV_FEC_HASTA,'DD-MM-YYYY') || ''',''DD-MM-YYYY'')' ;

               EXECUTE IMMEDIATE v_comando_sql INTO  v_cantidad_ped;

               IF v_cantidad_ped is null then
                  v_cantidad_ped:=0;
               END IF;

           END IF  ;

      END IF;

      v_cantidad :=v_cantidad_ped;

   END  NP_GET_ARTICULO_TRANSITO;

   PROCEDURE NP_INSERTA_EXCEDENTE_STOCK_PR (
      v_cod_tipo_canal in NPT_REGISTRO_EXCEDENTE_TD.COD_DISTRIBUIDOR%TYPE,
      v_cod_articulo IN NPT_REGISTRO_EXCEDENTE_TD.COD_ARTICULO%TYPE,
      v_can_proyectada IN NPT_REGISTRO_EXCEDENTE_TD.CANTIDAD_PROYECTADA%TYPE ,
      v_can_consumida IN NPT_REGISTRO_EXCEDENTE_TD.CANTIDAD_CONSUMIDA%TYPE ,
      v_can_proyectada_c IN NPT_REGISTRO_EXCEDENTE_TD.CANTIDAD_PROYECTADA%TYPE ,
      v_can_proy_ind_c IN NPT_REGISTRO_EXCEDENTE_TD.CANTIDAD_PROYECTADA_CANAL%TYPE ,
      v_cantidad_sol IN NPT_REGISTRO_EXCEDENTE_TD.CANTIDAD_SOLICITADA%TYPE ,
      v_saldo_individual IN NPT_REGISTRO_EXCEDENTE_TD.SALDO_INDIVIDUAL%TYPE,
      v_saldo_sobre_stock IN NPT_REGISTRO_EXCEDENTE_TD.SALDO_SOBRESTOCK%tYPE,
      strError         out varchar2
   ) IS

   BEGIN

      BEGIN
         INSERT INTO NPT_REGISTRO_EXCEDENTE_TD
         (
            COD_DISTRIBUIDOR,
            COD_ARTICULO,
            CANTIDAD_PROYECTADA,
            CANTIDAD_CONSUMIDA,
            CANTIDAD_PROYECTADA_CANAL,
            CANTIDAD_PROY_IND_CANAL,
            CANTIDAD_SOLICITADA,
            SALDO_INDIVIDUAL,
            SALDO_SOBRESTOCK,
            USU_CREACION,
            FEC_CREACION
         )
         VALUES
         (
            v_cod_tipo_canal,
            v_cod_articulo,
            v_can_proyectada,
            v_can_consumida,
            v_can_proyectada_c,
            v_can_proy_ind_c,
            v_cantidad_sol,
            v_saldo_individual,
            v_saldo_sobre_stock,
            USER,
            SYSDATE
         );

         EXCEPTION
         WHEN OTHERS THEN
            strError:='ERROR AL INSERTAR SOBRE STOCK, COD_DISTRIBUIDOR:' || v_cod_tipo_canal || ', COD_ARTICULO:' || v_cod_articulo ;
      END;

      COMMIT;

   END NP_INSERTA_EXCEDENTE_STOCK_PR;

END;
/

