CREATE OR REPLACE PACKAGE BODY NP_LIMITE_ARTICULOS_PG IS
/*
<NOMBRE>           : NP_LIMITE_ARTICULOS_PG  .</NOMBRE>
<FECHACREA>        : 22-11-2011<FECHACREA/>
<MODULO >          : Logistica </MODULO >
<AUTOR >       :  ANGELO FLORES</AUTOR >
<VERSION >     : 1.0</VERSION >
<DESCRIPCION>  : Inserta registro en tabla de limite de articulos para ventas al distribuidor</DESCRIPCION>
*/
        PROCEDURE NP_INSERTA_LIMITE_ARTICULO_PR    (v_cod_usuario   in  NPT_LIMITE_ARTICULO_TD.COD_USUARIO%TYPE,
                                                   v_cod_articulo   in  NPT_LIMITE_ARTICULO_TD.COD_ARTICULO%TYPE,
                                                   v_tip_stock      in  NPT_LIMITE_ARTICULO_TD.TIP_STOCK%TYPE,
                                                   v_cod_uso        in  NPT_LIMITE_ARTICULO_TD.COD_USO%TYPE,
                                                   v_cantidad       in  NPT_LIMITE_ARTICULO_TD.CANTIDAD%TYPE,
                                                   v_operacion      in  varchar2,
                                                   v_fec_desde      in  varchar2,
                                                   v_fec_hasta      in  varchar2,
                                                   v_fec_desde_new  in  varchar2,
                                                   v_fec_hasta_new  in  varchar2,
                                                   strError         out varchar2) IS


         BEGIN

            IF v_operacion = 'I' THEN
                BEGIN
                       INSERT INTO NPT_LIMITE_ARTICULO_TD (COD_USUARIO,
                                                            COD_ARTICULO,
                                                            TIP_STOCK,
                                                            COD_USO,
                                                            CANTIDAD,
                                                            USU_CREACION,
                                                            FEC_CREACION,
                                                            FEC_DESDE, --CSR--11017
                                                            FEC_HASTA)
                         VALUES (v_cod_usuario,
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
                    UPDATE NPT_LIMITE_ARTICULO_TD
                     SET CANTIDAD=v_cantidad,
                         FEC_DESDE=TO_DATE(v_fec_desde_new,'DD-MM-YYYY'),
                         FEC_HASTA=TO_DATE(v_fec_hasta_new,'DD-MM-YYYY')
                     WHERE COD_USUARIO=v_cod_usuario AND
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
                  DELETE NPT_LIMITE_ARTICULO_TD
                 WHERE COD_USUARIO=v_cod_usuario AND
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




         END NP_INSERTA_LIMITE_ARTICULO_PR;


 PROCEDURE NP_VALIDA_CANTIDAD_LIMITE  (v_cod_usuario in NPT_LIMITE_ARTICULO_TD.COD_USUARIO%TYPE,
                                                   v_cod_articulo in NPT_LIMITE_ARTICULO_TD.COD_ARTICULO%TYPE,
                                                   v_tip_stock in NPT_LIMITE_ARTICULO_TD.TIP_STOCK%TYPE,
                                                   v_cod_uso in NPT_LIMITE_ARTICULO_TD.COD_USO%TYPE,
                                                   v_cantidad out NPT_LIMITE_ARTICULO_TD.CANTIDAD%TYPE,
                                                   strError  out varchar2) IS



          v_cantidad_lim  NPT_LIMITE_ARTICULO_TD.CANTIDAD%TYPE ;
          v_cantidad_ped  NPT_LIMITE_ARTICULO_TD.CANTIDAD%TYPE ;
          v_count_limite  number;
          v_count_detalle number;
          v_count_parametro  number;
          v_comando_sql        VARCHAR2(3000) := '';
          LV_parametro         VARCHAR2(100) := '';
          LV_FEC_DESDE      NPT_LIMITE_ARTICULO_TD.FEC_DESDE%TYPE ;
          LV_FEC_HASTA      NPT_LIMITE_ARTICULO_TD.FEC_HASTA%TYPE ;
          
          

         BEGIN


             SELECT count(*) into v_count_limite
              FROM npt_limite_articulo_td
             WHERE cod_articulo = v_cod_articulo
               AND tip_stock = v_tip_stock
               AND cod_uso = v_cod_uso
               AND cod_usuario = v_cod_usuario
               AND TRUNC(SYSDATE) BETWEEN FEC_DESDE AND FEC_HASTA;


                 if v_count_limite >0  then


                  SELECT cantidad,fec_desde,fec_hasta
                  INTO v_cantidad_lim,LV_FEC_DESDE,LV_FEC_HASTA
                  FROM npt_limite_articulo_td
                  WHERE cod_articulo = v_cod_articulo
                   AND tip_stock = v_tip_stock
                   AND cod_uso = v_cod_uso
                   AND cod_usuario = v_cod_usuario
                    AND TRUNC(SYSDATE) BETWEEN FEC_DESDE AND FEC_HASTA;

                   SELECT count(*)
                   into v_count_parametro
                    FROM npt_parametro
                    WHERE ALIAS_PARAMETRO = 'ESTADO_LIM';

                   IF v_count_parametro >0  then

                      SELECT VALOR_PARAMETRO
                        into LV_parametro
                        FROM npt_parametro
                      WHERE ALIAS_PARAMETRO = 'ESTADO_LIM';

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


PROCEDURE NP_INSERTA_ERRORES(v_cod_retorno in ge_errores_pg.CodError,
                             v_componente_error in  ge_errores_pg.DesEvent,
                             v_error_desc            in VARCHAR2
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



    PROCEDURE NP_GET_LIMITE_ARTICULO  (v_cod_usuario in NPT_LIMITE_ARTICULO_TD.COD_USUARIO%TYPE,
                                                       v_cod_articulo in NPT_LIMITE_ARTICULO_TD.COD_ARTICULO%TYPE,
                                                       v_tip_stock in NPT_LIMITE_ARTICULO_TD.TIP_STOCK%TYPE,
                                                       v_cod_uso in NPT_LIMITE_ARTICULO_TD.COD_USO%TYPE,
                                                       v_cantidad out NPT_LIMITE_ARTICULO_TD.CANTIDAD%TYPE,
                                                       strError  out varchar2) IS

              v_count_limite  number;


    BEGIN

               SELECT count(*) into v_count_limite
                  FROM npt_limite_articulo_td
                 WHERE cod_articulo = v_cod_articulo
                   AND tip_stock = v_tip_stock
                   AND cod_uso = v_cod_uso
                   AND cod_usuario = v_cod_usuario;



                     if v_count_limite >0  then


                      SELECT cantidad
                      INTO v_cantidad
                      FROM npt_limite_articulo_td
                      WHERE cod_articulo = v_cod_articulo
                       AND tip_stock = v_tip_stock
                       AND cod_uso = v_cod_uso
                       AND cod_usuario = v_cod_usuario;

                     Else

                      v_cantidad :=0;

                     end if ;


    END NP_GET_LIMITE_ARTICULO;



    PROCEDURE NP_GET_ARTICULO_TRANSITO  (v_cod_usuario in NPT_LIMITE_ARTICULO_TD.COD_USUARIO%TYPE,
                                                       v_cod_articulo in NPT_LIMITE_ARTICULO_TD.COD_ARTICULO%TYPE,
                                                       v_tip_stock in NPT_LIMITE_ARTICULO_TD.TIP_STOCK%TYPE,
                                                       v_cod_uso in NPT_LIMITE_ARTICULO_TD.COD_USO%TYPE,
                                                       v_cantidad out NPT_LIMITE_ARTICULO_TD.CANTIDAD%TYPE,
                                                       strError  out varchar2) IS

             v_count_parametro  number;
             LV_parametro       VARCHAR2(100) := '';
             v_cantidad_ped  number;
             v_comando_sql        VARCHAR2(3000) := '';
             LV_FEC_DESDE      NPT_LIMITE_ARTICULO_TD.FEC_DESDE%TYPE ;
             LV_FEC_HASTA      NPT_LIMITE_ARTICULO_TD.FEC_HASTA%TYPE ;



    BEGIN


                              SELECT count(*)
                   into v_count_parametro
                    FROM npt_parametro
                    WHERE ALIAS_PARAMETRO = 'ESTADO_LIM';

                   IF v_count_parametro >0  then

                      SELECT VALOR_PARAMETRO
                        into LV_parametro
                        FROM npt_parametro
                      WHERE ALIAS_PARAMETRO = 'ESTADO_LIM';
                      
                      
                          SELECT fec_desde,fec_hasta
                          INTO LV_FEC_DESDE,LV_FEC_HASTA
                          FROM npt_limite_articulo_td
                          WHERE cod_articulo = v_cod_articulo
                          AND tip_stock = v_tip_stock
                          AND cod_uso = v_cod_uso
                          AND cod_usuario = v_cod_usuario
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

                end if;


                v_cantidad :=v_cantidad_ped;

    END  NP_GET_ARTICULO_TRANSITO;



END;
/
