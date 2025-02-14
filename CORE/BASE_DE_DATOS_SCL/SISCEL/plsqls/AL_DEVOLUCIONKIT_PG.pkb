CREATE OR REPLACE PACKAGE BODY  AL_DEVOLUCIONKIT_PG IS
/*
<Documentación TipoDoc = "Package">
<Elemento Nombre = "AL_DEVOLUCIONKIT_PG" Lenguaje="PL/SQL" Fecha="21/04/2004" Versión="1.0" Diseñador="****" Programador="****" Ambiente="BD">
<Retorno>NA</Retorno>
<Descripción>PL, Inserta serie a inventario, o realiza traspaso según parametros en la cadena principal IV_cadenaparametro</Descripción>
<Parámetros>
    <Entrada>  </Entrada>
    <Salida>   </Salida>
</Parámetros>
</Elemento>
</Documentación>
 <FECHAMOD> 25-05-2007     </FECHAMOD>
 <AUTORMOD> Zenén Muñoz H. </AUTORMOD>
 <VERSIONMOD> 1.1  </VERSIONMOD>
 <DESCMOD>   Se modifica PL: P_INSERTASERIE_PR, donde se ingresa un movimiento que elimina de inventario, realizando una salida para la
             serie de mercaderia Dealer. Esta serie será re - ingresada por una devolución, o realiza traspaso según parametros en la
             cadena principal EV_cadenaparametro
             Incidencia: 40726.
 </DESCMOD>
*/

--
PROCEDURE P_INSERTASERIE_PR (
IV_cadenaparametro  IN  VARCHAR2,
OV_tabla            OUT VARCHAR2,
OV_accion           OUT VARCHAR2,
OV_sqlcode          OUT VARCHAR2,
OV_sqlerrm          OUT VARCHAR2) IS
/*
<Documentación TipoDoc = "Procedimiento">
<Elemento Nombre = "P_INSERTASERIE_PR" Lenguaje="PL/SQL" Fecha="21/04/2004" Versión="1.0" Diseñador="****" Programador="Ulises Patricio Uribe Flores" Ambiente="BD">
<Retorno>NA</Retorno>
<Descripción>PL, Inserta serie a inventario, o realiza traspaso según parametros en la cadena principal IV_cadenaparametro</Descripción>
<Parámetros>
    <Entrada>
        <param nom="IV_cadenaparametro" Tipo="NUMBER">Cadena de parámetros para el movimiento </param>
    </Entrada>
    <Salida>
        <param nom="OV_tabla" Tipo="NUMBER">Tabla ó PL, que se esta actualizando</param>
        <param nom="OV_accion" Tipo="NUMBER">Acción que se realiza en el PL</param>
        <param nom="OV_sqlcode" Tipo="LV_string">Código Error en el PL</param>
        <param nom="OV_sqlerrm" Tipo="LV_string">descripción Error en el PL</param>
    </Salida>
</Parámetros>
</Elemento>
</Documentación>
 <FECHAMOD> 25-05-2007     </FECHAMOD>
 <AUTORMOD> Zenén Muñoz H. </AUTORMOD>
 <VERSIONMOD> 1.1  </VERSIONMOD>
 <DESCMOD>   que elimina de inventario, realizando una salida para la serie de mercaderia Dealer. Esta serie será re - ingresada por una devolución, o realiza traspaso según parametros en la cadena principal EV_cadenaparametro
             Incidencia: 40726.
 </DESCMOD>
*/

        CI_uno            CONSTANT INTEGER :=1;
        CI_zero           CONSTANT INTEGER:=0;
        CI_cod_producto   CONSTANT INTEGER:=1;
        CV_cod_modulo     CONSTANT VARCHAR(2):='AL';
        TN_num_movim      al_movimientos.num_movimiento%TYPE;
        TN_preciounidad   al_movimientos.prc_unidad%TYPE;
        TV_nompara1       CONSTANT ged_parametros.nom_parametro%TYPE := 'TRANSCCIONDEVOLUCION';
        TV_nompara2       CONSTANT ged_parametros.nom_parametro%TYPE := 'TEMPORAL_DEVOLUCION';
        TV_nompara3       CONSTANT ged_parametros.nom_parametro%TYPE := 'ESTFINALSERWEB';
        TV_nompara4       CONSTANT ged_parametros.nom_parametro%TYPE := 'ENTRADA_DEV_KIT';
        TV_nompara5       CONSTANT ged_parametros.nom_parametro%TYPE := 'TRASPASO_DEV_KIT';
        TV_nompara6       CONSTANT ged_parametros.nom_parametro%TYPE := 'TIPO_MOVIM_CAM_EST';
        TV_trassaccion    ged_parametros.nom_parametro%TYPE;
        TV_temporal_dev   ged_parametros.nom_parametro%TYPE;
        TV_temporal_dev   ged_parametros.nom_parametro%TYPE;
        TV_tipmovim_E     ged_parametros.nom_parametro%TYPE;
        TV_tipmovimT      ged_parametros.nom_parametro%TYPE;
        TV_bod_ori        ged_parametros.nom_parametro%TYPE;
        TTV_num_trasM     al_traspasos_masivo.num_traspaso_masivo%TYPE;
        TV_num_tras       al_traspasos_masivo.num_traspaso%TYPE;
        TV_uso_tras       al_usos.cod_uso%TYPE;
        TV_est_tras       al_estados.cod_estado%TYPE;
        TV_cod_plaza      ge_operplaza_td.cod_plaza%TYPE;
        TV_valor_armado   al_datos_generales.valor_armado_kit%TYPE;
        RW_movim                  al_movimientos%ROWTYPE;
        RW_trasp                  al_traspasos_masivo%ROWTYPE;
        TV_bodega_origen  al_traspasos_masivo.cod_bodega_ori%TYPE;
        TV_est_trasp_ini  al_traspasos_masivo.cod_estado_tras%TYPE:='PD';
        TV_cod_estadomov  al_movimientos.cod_estadomov%TYPE:='SO';
        RW_movim_cam_esta al_estados.cod_estado%TYPE;
        v_tiparticulo     VARCHAR2(2);
        IV_tipterminal    al_articulos.tip_terminal%TYPE;
        IV_indequiacc     al_articulos.ind_equiacc%TYPE;
        ON_precio_entrada al_series.prc_compra%TYPE;
        v_ind_telefono    al_series.ind_telefono%TYPE;
        ST_cod_estado     al_estados.cod_estado%TYPE;
        v_valor_old       al_tipos_stock.ind_valorar%TYPE;
        v_valor_new               al_tipos_stock.ind_valorar%TYPE;
        v_precio          al_series.prc_compra%type;
        LN_Existe_Serie   number(01) :=0; -- Inc. 40726, para verificar que no exista la Serie, al momento de insertar una serie por Devolución.
    LN_TIP_STOCK      al_series.TIP_STOCK%TYPE;  -- Inc. 40726, para verificar que no exista la Serie, al momento de insertar una serie por Devolución.
        LN_COD_ARTICULO   al_series.COD_ARTICULO%TYPE;  -- Inc. 40726, para verificar que no exista la Serie, al momento de insertar una serie por Devolución.
        LN_COD_USO        al_series.COD_USO%TYPE;     -- Inc. 40726, para verificar que no exista la Serie, al momento de insertar una serie por Devolución.
        LN_COD_BODEGA     al_series.COD_BODEGA%TYPE;  -- Inc. 40726, para verificar que no exista la Serie, al momento de insertar una serie por Devolución.
        LN_COD_ESTADO     al_series.COD_ESTADO%type;  -- Inc. 40726, para verificar que no exista la Serie, al momento de insertar una serie por Devolución.
        LN_tip_movimiento VE_VENTA_MOVIMIENTO_TD.tip_movimiento%type; -- Inc. 40726, para verificar que no exista la Serie, al momento de insertar una serie por Devolución.


        string siscel.GE_TABTYPE_VCH2ARRAY := siscel.GE_TABTYPE_VCH2ARRAY('','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
BEGIN
        -- ********************************************************************
-- INICIO DESCOMPOSICIÓN DEL LA CADENA DE ENTRADA V_CADENAENTRADA
-- ********************************************************************

    siscel.Ge_Pac_Arreglopr.GE_PR_RetornaArreglo(IV_cadenaparametro, string);
-- Retorna la siguiente cadena
/*1:= cod_pedido
 2:=  cod_devolucion.
 3:=  cod_cliente.
 4:=  cod_uso.
 5:=  tip_doc_pedido.
 6:=  tip_movimiento.
 7:=  tip_articulo.
 8:=  cod_serie_pedido.
 9:=  cod_articulo.
 10:= ind_equiacc.
 11:= tip_terminal.
 12:= ind_seriado.
 13:= cod_transaccion.
 14:= cod_estado.
 15:= num_abonado.
 16:= num_celular.
 17:= num_serie.
 18:= cod_actabo.
 19:= cod_actuacion.
 20:= cod_causa.
 21:= num_usuarora.
 22:= cod_modulo.
 23:= saldo.
 24:= cod_tecnologia.
 25:= cod_bodega.
 26:= ind_entsal.
 27:= fec_modif.
 28:= tip_artkid.
 29:= ind_telefono -indicador telefonico.
 30:= cod_central
 31:= tip_stock_orig --indicador stock de origen.
 32:= cod_estado_dev
-- XO-200510050801 Inicio : Responsable cambio : Pablo Hernandez : fecha:07-10-2005 :  Desc: crea comentarios de descripción para campos Plan y Carga *
 33:= Tip Stock serie actual
 34:= plan
 35:= carga 
 36:= Línea detalle Pedido  
 */
-- Fin Cambio Incidencia XO-200510050801

-- ********************************************************************
-- FIN DESCOMPOSICIÓN DEL ARREGLO
-- ********************************************************************
    v_ind_telefono :=NVL(TO_NUMBER(string(29)),0);
        RW_movim.NUM_TELEFONO :=string(16);
    v_tiparticulo :=P_OBTIENECATARTICULO_FN(string(11),string(10));
/*
        IF TO_NUMBER(string(12)) = 0 THEN
                OV_tabla        :='ARTICULO NO SERIADO' ;
                OV_accion       := 'ARTICULO NO SERIADO';
                OV_sqlcode      := '-20101';
                OV_sqlerrm   := 'ARTICULO NO SERIADO-error en el proceso';
           RETURN;
        END IF ;
*/  
      -- OBTENGO plaza
    P_OBTIENEPLAZA_PR(string(15),TV_cod_plaza, OV_tabla, OV_accion, OV_sqlcode, OV_sqlerrm);
        IF OV_tabla IS NOT NULL THEN
                RETURN;-- Salgo del Procedimiento, EXISTIO ALGÚN ERROR ...
    END IF; --
        --*******************************************************************************************
        --  1) TODOS LOS NO NUMERADOS string(16) is  null INGRESAN SEGUN EL ESTADO DEL PEDIDO STRING(32)
        --  2) TODOS LOS NUMERADOS (string(16) is not null)   Y QUE SEAN NUMERO DESACTIVADO v_ind_telefono = 1
        --     TAMBIEN ENTRAN CON EL ESTADO DEL PEDIDO STRING(32)
        --  3)
        --*******************************************************************************************
        IF (v_ind_telefono = 1 AND string(16) IS NOT NULL)  OR (string(16) IS  NULL) THEN
                ST_cod_estado:=string(32);
        ELSE
                ST_cod_estado:=string(14);
        END IF;

    IF string(26) = 'E'  THEN
  --   dbms_output.put_line('entro entrada');
                --*************************************************************
                -- SE TRATA DE ENTRADA DE SERIE ...
                --*************************************************************
           ---  SI ES KIT
                IF string(7) = string(28) THEN
                --dbms_output.put_line('es kit');
                        RW_movim.NUM_TELEFONO:=NULL;
                        v_ind_telefono:=CI_zero;
                                --RW_movim.IND_TELEFONO :=0; -- para los kit es siempre 0
                                -- OBTIENE SUMA DE LOS COMPONENTE DEL KIT
                                P_OBTIENEPRECIOKIT_PR(ON_precio_entrada, string(8), OV_tabla, OV_accion, OV_sqlcode, OV_sqlerrm);
                                IF OV_tabla IS NOT NULL THEN
                                                                RETURN;-- Salgo del Procedimiento, EXISTIO ALGÚN ERROR ...
                        END IF;

                ELSE
--                   dbms_output.put_line('entro no kit');
                   -- NO ES KIT --
                   -- OBTIENE PRECIO DE ENTRADA
                    P_PMPARTICULO_PR(string(9),  ON_precio_entrada, OV_tabla, OV_accion, OV_sqlcode, OV_sqlerrm);
                    -- VEO SI ES NUMERADO
                    IF   string(11) = 'G' AND string(7) <> string(28) AND string(8) is not null  THEN
                           --OBTIENE HLR POR QUE ES SIMCARD
                             P_OBTIENEHLR_PR(RW_movim.cod_hlr, string(8), OV_tabla, OV_accion, OV_sqlcode, OV_sqlerrm);
                             IF OV_tabla IS NOT NULL THEN
                                            RETURN;-- Salgo del Procedimiento, EXISTIO ALGÚN ERROR ...
                             END IF;
                    END IF;
                    --dbms_output.put_line('hlr :'||RW_movim.cod_hlr);
                    IF string(16) IS NOT NULL and string(8) is not null  THEN
                      ---dbms_output.put_line('1numero telefonico :'||string(16));
                      -- OBTIENE CENTRAL, SUBALM Y CATEGORIA POR QUE ES NUMERADO
                      --dbms_output.put_line('numero : '||string(16));
                       P_ESNUMERADO_PR( string(16),RW_movim.cod_subalm,RW_movim.cod_central,RW_movim.cod_cat,OV_tabla, OV_accion, OV_sqlcode, OV_sqlerrm);
                       IF OV_tabla IS NOT NULL THEN
                                            RETURN;-- Salgo del Procedimiento, EXISTIO ALGÚN ERROR ...
                       END IF;
                    --dbms_output.put_line('3numero telefonico :'||string(16));
                    END IF;

                END IF;
                
                -- OBTENGO NÚMERO DE MOVIMIENTO PARA INGRESAR A AL _MOVIMIENTOS
                P_OBTIENEMOVIMIENTO_PR(TN_num_movim, OV_tabla, OV_accion, OV_sqlcode, OV_sqlerrm);
                IF OV_tabla IS NOT NULL THEN
                   RETURN;-- Salgo del Procedimiento, EXISTIO ALGÚN ERROR ...
                END IF; --
                RW_movim.NUM_MOVIMIENTO  := TN_num_movim;
                RW_movim.TIP_MOVIMIENTO  := string(6);
                RW_movim.FEC_MOVIMIENTO  := SYSDATE;
                RW_movim.TIP_STOCK       := string(31);
                RW_movim.COD_BODEGA              := string(25);
                RW_movim.COD_ARTICULO    := string(9);
                RW_movim.COD_USO                 := string(4);
                RW_movim.COD_ESTADO              := ST_cod_estado;--TV_temporal_dev;

                RW_movim.NUM_CANTIDAD    := CI_uno;   --es siempre uno 1
                IF TO_NUMBER(string(12)) = 0 THEN
                   BEGIN
                     Select CAN_DET_DEVOLUCION into RW_movim.NUM_CANTIDAD
                        From npt_detalle_devolucion
                       where cod_devolucion = string(2)
                         and   cod_pedido     = string(1)
                         and   lin_det_pedido = string(36);
                   EXCEPTION
                   WHEN OTHERS THEN
                        NULL;
                   END;
                End if; 
                        
                RW_movim.COD_ESTADOMOV   := TV_cod_estadomov;
                RW_movim.NOM_USUARORA    := USER;   --USER
                RW_movim.NUM_SERIE       := string(8);
                RW_movim.NUM_DESDE       := CI_zero; -- siempre es zero
                RW_movim.PRC_UNIDAD      := ON_precio_entrada;
                RW_movim.COD_TRANSACCION := string(13);
                RW_movim.NUM_TRANSACCION := string(2);
                RW_movim.COD_PRODUCTO    := CI_uno;
                RW_movim.IND_TELEFONO    := v_ind_telefono;
                RW_movim.COD_PLAZA               := TV_cod_plaza; -- Parametro internos
                RW_movim.PLAN                    := string(34);
                RW_movim.CARGA                   := string(35);

-- Incidencia: 40726, donde se busca que la serie exista en la tabla de series, lo que se hace es una salida (tipo de movimiento 3).
                IF string(8) is not null  THEN
                    Begin
                           LN_Existe_Serie := 0;
                           LN_TIP_STOCK  := string(31);
                           LN_COD_ARTICULO := string(9);
                           LN_COD_USO      := string(4);
                           LN_COD_BODEGA   := string(25);
                           LN_tip_movimiento := string(6);
    -- Datos que actualmente tiene la serie.
                           select TIP_STOCK, COD_ARTICULO, COD_USO, COD_BODEGA, COD_ESTADO, 1
                               into string(31), string(9), string(4), string(25), LN_COD_ESTADO, LN_Existe_Serie
                           from al_series
                           where num_serie = string(8);
                           Exception
                              When others then
                                 LN_Existe_Serie := 0;
                    End;
                    IF LN_Existe_Serie = 1 THEN
                               RW_movim.TIP_MOVIMIENTO := 3; -- Movimiento de salida de la serie que se encuentra en bodega del dealer.
                               RW_movim.COD_USO := string(4);
                               RW_movim.COD_BODEGA := string(25);
                               RW_movim.TIP_STOCK := string(31);
                               RW_movim.COD_ARTICULO := string(9);
                               RW_movim.cod_estado := LN_COD_ESTADO;

                               P_INSERTAMOVIMIENTO_PR(RW_movim,    OV_tabla, OV_accion, OV_sqlcode, OV_sqlerrm);
                               IF OV_tabla IS NOT NULL THEN
                                      RETURN;-- Salgo del Procedimiento, EXISTIO ALGÚN ERROR ...
                               END IF;
                               string(31) := LN_TIP_STOCK ;
                               string(9) := LN_COD_ARTICULO;
                               string(4) := LN_COD_USO;
                               string(25) := LN_COD_BODEGA;
                               string(6) := LN_tip_movimiento;
                               RW_movim.TIP_MOVIMIENTO := string(6);
                               RW_movim.COD_USO := string(4);
                               RW_movim.COD_BODEGA := string(25);
                               RW_movim.TIP_STOCK := string(31);
                               RW_movim.COD_ARTICULO := string(9);
                               RW_movim.COD_ESTADO := ST_cod_estado;--TV_temporal_dev;
    -- OBTENGO NÚMERO DE MOVIMIENTO PARA INGRESAR A AL _MOVIMIENTOS
                               P_OBTIENEMOVIMIENTO_PR(TN_num_movim, OV_tabla, OV_accion, OV_sqlcode, OV_sqlerrm);
                               IF OV_tabla IS NOT NULL THEN
                                    RETURN;-- Salgo del Procedimiento, EXISTIO ALGÚN ERROR ...
                               END IF; --
                               RW_movim.NUM_MOVIMIENTO := TN_num_movim;
                            END IF;
    -- Fin 40726
                END IF;       

    -- Fin Cambio Incidencia XO-200510050801
                            P_INSERTAMOVIMIENTO_PR(RW_movim,    OV_tabla, OV_accion, OV_sqlcode, OV_sqlerrm);
                            IF OV_tabla IS NOT NULL THEN
                                    RETURN;-- Salgo del Procedimiento, EXISTIO ALGÚN ERROR ...
                        END IF;
     ELSIF string(26)   = 'T' THEN
                --dbms_output.put_line('entro traspaso');
                IF string(7) = string(28) THEN
                   v_ind_telefono:=CI_zero;
                   RW_movim.NUM_TELEFONO:=NULL;
                END IF;
        -- ES TRASPASO, PRIMERO CAMBIO DE ESTADO Y DESPUES TRASPASO MASIVO CON LA SERIE
                IF   string(11) = 'G' AND string(7) <> string(28) THEN
                    --OBTIENE HLR POR QUE ES SIMCARD
                    P_OBTIENEHLR_PR(RW_movim.cod_hlr, string(8), OV_tabla, OV_accion, OV_sqlcode, OV_sqlerrm);
                    IF OV_tabla IS NOT NULL THEN
                            RETURN;-- Salgo del Procedimiento, EXISTIO ALGÚN ERROR ...
                     END IF;
                END IF;
            -- VEO SI ES NUMERADO, OBTENGO SUBALM, CENTRAL, CATEGORIA
           --dbms_output.put_line('numero telefonico :'||string(16));
               IF string(16) IS NOT NULL THEN
                    -- OBTIENE CENTRAL, SUBALM Y CATEGORIA POR QUE ES NUMERADO
                        P_ESNUMERADO_PR( string(16),RW_movim.cod_subalm,RW_movim.cod_central,RW_movim.cod_cat,OV_tabla, OV_accion, OV_sqlcode, OV_sqlerrm);
                        IF OV_tabla IS NOT NULL THEN
                           RETURN;-- Salgo del Procedimiento, EXISTIO ALGÚN ERROR ...
                        END IF;
                END IF;
               -- OBTIENE MOVIMIENTO PARA CAMBIO DE ESTADO
                P_MOVIMCAMESTA_PR(RW_movim_cam_esta ,TV_nompara6,CV_cod_modulo,CI_cod_producto,OV_tabla, OV_accion, OV_sqlcode, OV_sqlerrm);
                IF OV_tabla IS NOT NULL THEN
                     RETURN;-- Salgo del Procedimiento, EXISTIO ALGÚN ERROR ...
                END IF;
            -- OBTIENE BODEGA , US, ESTADO ORIGEN DE SERIE
                P_OBTIENEDATOSTRASPASO_PR( string(8), TV_bod_ori, TV_uso_tras, TV_est_tras,RW_movim.prc_unidad,OV_tabla, OV_accion, OV_sqlcode, OV_sqlerrm);
                IF OV_tabla IS NOT NULL THEN
                   RETURN;-- Salgo del Procedimiento, EXISTIO ALGÚN ERROR ...
                END IF;
                -- OBTIENE NUMERO TRASPASO MASIVO
                P_OBTIENENUMTRASPASOMASIVO_PR(TTV_num_trasM, OV_tabla, OV_accion, OV_sqlcode, OV_sqlerrm);
                -- OBTIENE NUMERO TRASPASO
                P_OBTIENENUMEROTRASPASO_PR(TV_num_tras,OV_tabla, OV_accion, OV_sqlcode, OV_sqlerrm);
                IF OV_tabla IS NOT NULL THEN
                   RETURN;-- Salgo del Procedimiento, EXISTIO ALGÚN ERROR ...
                END IF;

                --*************************************************************************
                -- SE TRATA DE TRASPASO  DE SERIE ...      PRIMERO HAGO CAMBIO DE ESTADO
                --*************************************************************************
                --****VALIDO TIPOS DE STOCK PARA VALIDAR SI REQUIERO E/S EXTRA O CAMBIO ESTADO Y TRASPASO***/
                Al_Pac_Validaciones.p_obtiene_valoracion (string(33), v_valor_old);
                Al_Pac_Validaciones.p_obtiene_valoracion (string(31), v_valor_new);
--                       dbms_output.put_line('v_valor_old      : '||v_valor_old);
--                       dbms_output.put_line('v_valor_new      : '||v_valor_new);
                IF v_valor_old = 0 AND
                  (v_valor_new = 1 OR
                   v_valor_new = 2) THEN
                       NULL; --GRABAR ENTRADA Y SALIDA EXTRA
        --            dbms_output.put_line('GRABAR ENTRADA Y SALIDA EXTRA ');
                        P_OBTIENEMOVIMIENTO_PR(TN_num_movim, OV_tabla, OV_accion, OV_sqlcode, OV_sqlerrm);
                        RW_movim.NUM_MOVIMIENTO  := TN_num_movim;
                        RW_movim.TIP_MOVIMIENTO  := 3;
                        RW_movim.FEC_MOVIMIENTO  := SYSDATE;
                        RW_movim.TIP_STOCK       := string(33);
                        RW_movim.COD_BODEGA              := TV_bod_ori;
                        RW_movim.COD_ARTICULO    := string(9);
                        RW_movim.COD_USO                 := TV_uso_tras;
                        RW_movim.COD_ESTADO              := TV_est_tras;
                        RW_movim.NUM_CANTIDAD    := CI_uno;   --es siempre uno 1
                        RW_movim.COD_ESTADOMOV   := TV_cod_estadomov;
                        RW_movim.NOM_USUARORA    := USER;   --USER
                        RW_movim.NUM_SERIE               := string(8);
                        RW_movim.NUM_DESDE               := CI_zero; -- siempre es zero
                        RW_movim.COD_TRANSACCION         := string(13); -- Parametros internos
                        RW_movim.NUM_TRANSACCION         := string(2); --  Parametros internos
                        RW_movim.COD_PRODUCTO    := CI_uno;
                        RW_movim.IND_TELEFONO    := v_ind_telefono;
                        RW_movim.COD_PLAZA               := TV_cod_plaza; -- Parametro internos
                        RW_movim.PLAN                    := string(34);
                        RW_movim.CARGA                   := string(35);
                         IF TO_NUMBER(string(12)) = 0 THEN
                               BEGIN
                                 Select CAN_DET_DEVOLUCION into RW_movim.NUM_CANTIDAD
                                    From npt_detalle_devolucion
                                   where cod_devolucion = string(2)
                                     and   cod_pedido     = string(1)
                                     and   lin_det_pedido = string(36);
                               EXCEPTION
                               WHEN OTHERS THEN
                                    NULL;
                              END;
                         End if; 

    --                      dbms_output.put_line('salida extra');
                        P_INSERTAMOVIMIENTO_PR(RW_movim, OV_tabla, OV_accion, OV_sqlcode, OV_sqlerrm);
                        IF OV_tabla IS NOT NULL THEN
                           RETURN;
                        END IF;
                        P_OBTIENEMOVIMIENTO_PR(TN_num_movim, OV_tabla, OV_accion, OV_sqlcode, OV_sqlerrm);
                        RW_movim.NUM_MOVIMIENTO  := TN_num_movim;
                        RW_movim.TIP_MOVIMIENTO  := 10;
                        RW_movim.FEC_MOVIMIENTO  := SYSDATE;
                        RW_movim.TIP_STOCK       := string(31);
                        RW_movim.COD_BODEGA              := string(25);
                        RW_movim.COD_ARTICULO    := string(9);
                        RW_movim.COD_USO                 := TV_uso_tras;
                        RW_movim.COD_ESTADO              := ST_cod_estado;
                        RW_movim.NUM_CANTIDAD    := CI_uno;   --es siempre uno 1
                        RW_movim.COD_ESTADOMOV   := TV_cod_estadomov;
                        RW_movim.NOM_USUARORA    := USER;   --USER
                        RW_movim.NUM_SERIE               := string(8);
                        RW_movim.NUM_DESDE               := CI_zero; -- siempre es zero
                        RW_movim.COD_TRANSACCION         := string(13); -- Parametros internos
                        RW_movim.NUM_TRANSACCION         := string(2); --  Parametros internos
                        RW_movim.COD_PRODUCTO    := CI_uno;
                        RW_movim.IND_TELEFONO    := v_ind_telefono;
                        RW_movim.COD_PLAZA               := TV_cod_plaza; -- Parametro internos
                        RW_movim.PLAN                    := string(34);
                        RW_movim.CARGA                   := string(35);
                        P_INSERTAMOVIMIENTO_PR(RW_movim, OV_tabla, OV_accion, OV_sqlcode, OV_sqlerrm);
                        IF OV_tabla IS NOT NULL THEN
                            RETURN;
                        END IF;
         ELSE
                      -- VALIDAR SI STOCK ES IGUAL AL OTRO
                IF (string(31) <> string(33) ) THEN
                        --dbms_output.put_line('stock diferentes');
                        -- STOCK ORIGEN Y DESTINO SON DIFERENTES, DEBO CAMBIAR STOCK  CON MOVIMIENTO 35
                        P_OBTIENEMOVIMIENTO_PR(TN_num_movim, OV_tabla, OV_accion, OV_sqlcode, OV_sqlerrm);
                        RW_movim.NUM_MOVIMIENTO  := TN_num_movim;
                        RW_movim.TIP_MOVIMIENTO  := 35;
                        RW_movim.FEC_MOVIMIENTO  := SYSDATE;
                        RW_movim.TIP_STOCK       := string(33);
                        RW_movim.TIP_STOCK_DEST  := string(31);
                        RW_movim.COD_BODEGA              := TV_bod_ori;
                        RW_movim.COD_ARTICULO    := string(9);
                        RW_movim.COD_USO                 := TV_uso_tras;
                        RW_movim.COD_ESTADO              := TV_est_tras;
                        RW_movim.NUM_CANTIDAD    := CI_uno;   --es siempre uno 1
                        RW_movim.COD_ESTADOMOV   := TV_cod_estadomov;
                        RW_movim.NOM_USUARORA    := USER;   --USER
                        RW_movim.NUM_SERIE               := string(8);
                        RW_movim.NUM_DESDE               := CI_zero; -- siempre es zero
                        RW_movim.COD_TRANSACCION         := string(13); -- Parametros internos
                        RW_movim.NUM_TRANSACCION         := string(2); --  Parametros internos
                        RW_movim.COD_PRODUCTO    := CI_uno;
                        RW_movim.IND_TELEFONO    := v_ind_telefono;
                        RW_movim.COD_PLAZA               := TV_cod_plaza; -- Parametro internos
                        RW_movim.PLAN                    := string(34);
                        RW_movim.CARGA                   := string(35);
--                                                                      dbms_output.put_line('cambio stock');
                        P_INSERTAMOVIMIENTO_PR(RW_movim, OV_tabla, OV_accion, OV_sqlcode, OV_sqlerrm);
                        IF OV_tabla IS NOT NULL THEN
                                 RETURN;
                        END IF;
--                                                                      dbms_output.put_line('hecho cambio stock');
                    END IF;
--                         dbms_output.put_line(string(31)||'|'||string(33));
                    IF TV_est_tras <> string(32) THEN
                        P_OBTIENEMOVIMIENTO_PR(TN_num_movim, OV_tabla, OV_accion, OV_sqlcode, OV_sqlerrm);
                        RW_movim.NUM_MOVIMIENTO  := TN_num_movim;
                        RW_movim.TIP_MOVIMIENTO  := RW_movim_cam_esta; -- Tipo Movimiento 19
                        RW_movim.FEC_MOVIMIENTO  := SYSDATE;
                        RW_movim.TIP_STOCK       := string(31);
                        RW_movim.COD_BODEGA              := TV_bod_ori;
                        RW_movim.COD_ARTICULO    := string(9);
                        RW_movim.COD_USO                 := TV_uso_tras;
                        RW_movim.COD_ESTADO              := TV_est_tras;
                        RW_movim.NUM_CANTIDAD    := CI_uno;   --es siempre uno 1
                        RW_movim.COD_ESTADOMOV   := TV_cod_estadomov;
                        RW_movim.NOM_USUARORA    := USER;   --USER
                        RW_movim.COD_ESTADO_DEST := ST_cod_estado;
                        RW_movim.NUM_SERIE               := string(8);
                        RW_movim.NUM_DESDE               := CI_zero; -- siempre es zero
                        RW_movim.COD_TRANSACCION := string(13); -- Parametros internos
                        RW_movim.NUM_TRANSACCION := string(2);
                        RW_movim.COD_PRODUCTO    := CI_uno;
                        RW_movim.IND_TELEFONO    := v_ind_telefono;
                        RW_movim.COD_PLAZA               := TV_cod_plaza; -- Parametro internos
                        RW_movim.PLAN                    := string(34);
                        RW_movim.CARGA                   := string(35);
--                                                                      dbms_output.put_line('estado orig :' ||TV_est_tras);
--                                                                      dbms_output.put_line('estado dest :' ||ST_cod_estado);
                        P_INSERTAMOVIMIENTO_PR(RW_movim, OV_tabla, OV_accion, OV_sqlcode, OV_sqlerrm);
                        IF OV_tabla IS NOT NULL THEN
                                 RETURN;
                        END IF;
                    END IF;
                --**********************************************************
                -- DESPUES INSERTO EL TRASPASO
                --**********************************************************
                   IF string(16) IS NOT NULL THEN
                      -- OBTIENE CENTRAL, SUBALM Y CATEGORIA POR QUE ES NUMERADO
                      P_ESNUMERADO_PR( string(16),RW_trasp.cod_subalm,RW_trasp.cod_central,RW_trasp.cod_cat,OV_tabla, OV_accion, OV_sqlcode, OV_sqlerrm);
                      IF OV_tabla IS NOT NULL THEN
                          RETURN;-- Salgo del Procedimiento, EXISTIO ALGÚN ERROR ...
                      END IF;

                   END IF;

                   IF  TV_bod_ori <>  string(25) THEN
                                RW_trasp.NUM_TRASPASO_MASIVO       :=TTV_num_trasM ;
                                RW_trasp.COD_ESTADO_TRAS                   :=TV_est_trasp_ini ;
                                RW_trasp.NUM_TRASPASO                      :=TV_num_tras ;
                                RW_trasp.COD_BODEGA_ORI                    :=TV_bod_ori ;
                                RW_trasp.COD_BODEGA_DEST                   :=string(25) ;
                                RW_trasp.TIP_STOCK                                 :=string(31) ;
                                RW_trasp.TIP_STOCK_DEST                    :=string(31) ;
                                RW_trasp.COD_ARTICULO                      :=TO_NUMBER(string(9)) ;
                                RW_trasp.COD_USO                                   :=TV_uso_tras ;
                                RW_trasp.COD_ESTADO                                :=ST_cod_estado ;
                                RW_trasp.NUM_SERIE                                 :=string(8) ;
                                RW_trasp.NUM_PETICION                      :=string(2) ;
                                RW_trasp.FEC_TRASPASO_MASIVO       :=TRUNC(SYSDATE) ;
                                RW_trasp.TIP_MOVIM_AUT                     :=NULL ;
                                RW_trasp.TIP_MOVIM_ENV                     :=NULL ;
                                RW_trasp.TIP_MOVIM_REC                     :=NULL ;
                                RW_trasp.USU_TRASPASO_MASIVO       :=USER ;
                                RW_trasp.DES_OBSERVACION                   :=NULL ;
                                RW_trasp.CAP_CODE                                  :=NULL ;
                                RW_trasp.NUM_TELEFONO                      :=string(16) ;
                                RW_trasp.NUM_SERIEMEC                      :=NULL ;
                                RW_trasp.NOM_USUAPROC                      :=NULL ;
                                RW_trasp.FEC_PROCESO                            :=NULL ;
                                RW_trasp.SQLCODE                                   :=NULL ;
                                RW_trasp.SQLERRM                                           :=NULL ;
                                RW_trasp.NUM_CANTIDAD                      :=CI_uno;
                                RW_trasp.COD_PEDIDO                                :=string(1);
                                RW_trasp.NUM_SEC_LOCA_ORI                  :=NULL ;
                                RW_trasp.NUM_SEC_LOCA_DEST                 :=NULL ;
                                P_INSERTATRASPASO_PR(RW_trasp, OV_tabla, OV_accion, OV_sqlcode, OV_sqlerrm);
                                IF OV_tabla IS NOT NULL THEN
                                   RETURN;-- Salgo del Procedimiento, EXISTIO ALGÚN ERROR ...
                                END IF;
                  END IF;
                END IF;

        ELSE
           -- error, movimiento no corresponde a entrada ni traspaso   ...
                 RETURN;
        END IF;
END P_INSERTASERIE_PR;
--
PROCEDURE   P_INSERTAMOVIMIENTO_PR(
RW_movim IN al_movimientos%ROWTYPE,
OV_tabla                IN OUT VARCHAR2,
OV_accion                       IN OUT VARCHAR2,
OV_sqlcode                      IN OUT VARCHAR2,
OV_sqlerrm                      IN OUT VARCHAR2) IS
/*
<NOMBRE>          : P_INSERTAMOVIMIENTO_PR
<FECHACREA>       : 21/04/2004
<MODULO >         : AL
<AUTOR >      : Ulises Patricio Uribe Flores
<VERSION >    : 1.0
<DESCRIPCION> : Inserta registro de entrada a al_movimientos
<FECHAMOD >   :
<DESCMOD >    :
<ParamEntr>   : RW_movim
<ParamSal >   : OV_tabla, OV_accion, OV_sqlcode, OV_sqlerrm
*/
BEGIN

--                      dbms_output.put_line('RW_movim : '||RW_movim.num_movimiento);
--            dbms_output.put_line('tip_movim : '||RW_movim.tip_movimiento);
--              dbms_output.put_line('stock : '||RW_movim.tip_stock );
--      dbms_output.put_line('stock Dest: '||RW_movim.tip_stock_dest );
--              dbms_output.put_line('bodega : '||RW_movim.cod_bodega);
--              dbms_output.put_line('articulo : '||RW_movim.cod_Articulo);
--              dbms_output.put_line('uso : ' || RW_movim.COD_USO);
--              dbms_output.put_line('estado : ' ||RW_movim.cod_Estado);
--      dbms_output.put_line('estado dest: ' ||RW_movim.cod_Estado_dest);
--              dbms_output.put_line('cantidad : '||RW_movim.num_cantidad );
--          dbms_output.put_line('estado_mov :'||RW_movim.cod_estadomov);
--              dbms_output.put_line('serie :'||RW_movim.num_serie);
--           dbms_output.put_line('precio :'||RW_movim.prc_unidad);
--            dbms_output.put_line('cod_transacion :'||RW_movim.cod_transaccion);
--            dbms_output.put_line('num_transacion :'||RW_movim.num_transaccion);
--              dbms_output.put_line('ind_telefono : '||RW_movim.ind_telefono );
--                 dbms_output.put_line('num_telefono : '||RW_movim.num_telefono );
--                 dbms_output.put_line('cod_central : '||RW_movim.cod_central );
--                 dbms_output.put_line('cod_Cat : '||RW_movim.cod_cat );
--                 dbms_output.put_line('cod_subalm : '||RW_movim.cod_subalm );
--              dbms_output.put_line('plaza : '||RW_movim.cod_plaza );

        -- Ejecuta movimiento de entrada
                INSERT INTO al_movimientos (
                num_movimiento , tip_movimiento   , fec_movimiento  ,
                tip_stock      , cod_bodega       , cod_articulo    ,
                cod_uso        , cod_estado       , num_cantidad    ,
                cod_estadomov  , nom_usuarora     , tip_stock_dest  ,
                cod_bodega_dest, cod_uso_dest     , cod_estado_dest ,
                num_serie      , num_desde        , num_hasta       ,
                num_guia       , prc_unidad       , cod_transaccion ,
                num_transaccion, num_seriemec     , num_telefono    ,
                cap_code       , cod_producto     , cod_central     ,
                cod_moneda     , cod_subalm       , cod_central_dest,
                cod_subalm_dest, num_telefono_dest, cod_cat                 ,
                cod_cat_dest    , ind_telefono    , PLAN                        ,
                carga          , num_sec_loca     , cod_hlr         ,
                cod_plaza)
                VALUES(
                RW_movim.num_movimiento , RW_movim.tip_movimiento   , SYSDATE ,
                RW_movim.tip_stock      , RW_movim.cod_bodega       , RW_movim.cod_articulo    ,
                RW_movim.cod_uso        , RW_movim.cod_estado       , RW_movim.num_cantidad    ,
                RW_movim.cod_estadomov  , RW_movim.nom_usuarora   , RW_movim.tip_stock_dest  ,
                RW_movim.cod_bodega_dest, RW_movim.cod_uso_dest     , RW_movim.cod_estado_dest ,
                RW_movim.num_serie      , RW_movim.num_desde              , RW_movim.num_hasta       ,
                RW_movim.num_guia       , RW_movim.prc_unidad       , RW_movim.cod_transaccion ,
                RW_movim.num_transaccion, RW_movim.num_seriemec   , RW_movim.num_telefono    ,
                RW_movim.cap_code       , RW_movim.cod_producto     , RW_movim.cod_central     ,
                RW_movim.cod_moneda     , RW_movim.cod_subalm     , RW_movim.cod_central_dest,
                RW_movim.cod_subalm_dest, RW_movim.num_telefono_dest, RW_movim.cod_cat              ,
                RW_movim.cod_cat_dest   , RW_movim.ind_telefono   , RW_movim.PLAN                       ,
                RW_movim.carga          , RW_movim.num_sec_loca     , RW_movim.cod_hlr         ,
                RW_movim.cod_plaza);
EXCEPTION
                WHEN OTHERS THEN
                                         OV_tabla       :='AL_MOVIMIENTOS' ;
                                         OV_accion      := 'INSERT';
                                         OV_sqlcode     := '-20102';
                                         OV_sqlerrm :=  lpad(SQLERRM,40);
--                                       --dbms_outPUT.put_line ('MENSAJE='||OV_sqlerrm);
END P_INSERTAMOVIMIENTO_PR;

PROCEDURE   P_INSERTATRASPASO_PR(
RW_trasp IN al_traspasos_masivo%ROWTYPE,
OV_tabla                IN OUT VARCHAR2,
OV_accion                       IN OUT VARCHAR2,
OV_sqlcode                      IN OUT VARCHAR2,
OV_sqlerrm                      IN OUT VARCHAR2) IS
/*
<NOMBRE>          : P_INSERTATRASPASO_PR
<FECHACREA>       : 21/04/2004
<MODULO >         : AL
<AUTOR >      : Ulises Patricio Uribe Flores
<VERSION >    : 1.0
<DESCRIPCION> : Inserta registro traspaso en al_traspaso_masivo
<FECHAMOD >   :
<DESCMOD >    :
<ParamEntr>   : RW_trasp
<ParamSal >   : OV_tabla, OV_accion, OV_sqlcode, OV_sqlerrm
*/
 BEGIN
     BEGIN
         -- Ejecuta traspaso masivo para serie

                                INSERT INTO al_traspasos_masivo(
                                num_traspaso_masivo,                    cod_estado_tras,                  num_traspaso,
                                cod_bodega_ori,                                 cod_bodega_dest,                  tip_stock,
                                tip_stock_dest,                                 cod_articulo,                             cod_uso,
                                cod_estado,                                     num_serie,                                        num_peticion,
                                fec_traspaso_masivo,                    tip_movim_aut,                            tip_movim_env,
                                tip_movim_rec,                                  usu_traspaso_masivo,              des_observacion,
                                cap_code,                                               num_telefono,                             cod_central,
                                cod_subalm,                                     cod_cat,                                          num_seriemec,
                                nom_usuaproc,                                   fec_proceso,                              SQLCODE,
                                SQLERRM,                                                num_cantidad,                             num_sec_loca_ori,
                                num_sec_loca_dest, cod_pedido)
                                VALUES (
                                RW_trasp.num_traspaso_masivo,    RW_trasp.cod_estado_tras,     RW_trasp.num_traspaso,
                                RW_trasp.cod_bodega_ori,                 RW_trasp.cod_bodega_dest,     RW_trasp.tip_stock,
                                RW_trasp.tip_stock_dest,                 RW_trasp.cod_articulo,           RW_trasp.cod_uso,
                                RW_trasp.cod_estado,                     RW_trasp.num_serie,                      RW_trasp.num_peticion,
                                RW_trasp.fec_traspaso_masivo,    RW_trasp.tip_movim_aut,                  RW_trasp.tip_movim_env,
                                RW_trasp.tip_movim_rec,                          RW_trasp.usu_traspaso_masivo, RW_trasp.des_observacion,
                                RW_trasp.cap_code,                               RW_trasp.num_telefono,           RW_trasp.cod_central,
                                RW_trasp.cod_subalm,                     RW_trasp.cod_cat,                        RW_trasp.num_seriemec,
                                RW_trasp.nom_usuaproc,                   RW_trasp.fec_proceso,            RW_trasp.SQLCODE,
                                RW_trasp.SQLERRM,                                RW_trasp.num_cantidad,           RW_trasp.num_sec_loca_ori,
                                RW_trasp.num_sec_loca_dest, RW_trasp.cod_pedido);
                                ----dbms_output.enable(99999999);
                EXCEPTION
                WHEN OTHERS THEN
                                         OV_tabla       :='AL_TRASPASOS_MASIVOS' ;
                                         OV_accion      := sqlerrm;
                                         OV_sqlcode     := '-20103';
                                         OV_sqlerrm := 'No se pudo traspasar serie : '||RW_trasp.num_serie;
        END;
        BEGIN
                siscel.P_Al_Tratamiento_Masivo(RW_trasp.num_traspaso_masivo);
                EXCEPTION
                WHEN OTHERS THEN
--              dbms_output.put_line('RW_trasp.NUM_TRASPASO_MASIVO : '||RW_trasp.NUM_TRASPASO_MASIVO);
--              dbms_output.put_line('RW_trasp.COD_ESTADO_TRAS: '||RW_trasp.COD_ESTADO_TRAS);
--              dbms_output.put_line('RW_trasp.NUM_TRASPASO : '||RW_trasp.NUM_TRASPASO)                 ;
--              dbms_output.put_line('RW_trasp.COD_BODEGA_ORI   : '||RW_trasp.COD_BODEGA_ORI)           ;
--              dbms_output.put_line('RW_trasp.COD_BODEGA_DEST: '||RW_trasp.COD_BODEGA_DEST)            ;
--              dbms_output.put_line('RW_trasp.TIP_STOCK        : '||RW_trasp.TIP_STOCK)                        ;
--              dbms_output.put_line('RW_trasp.TIP_STOCK_DEST   : '||RW_trasp.TIP_STOCK_DEST)           ;
--              dbms_output.put_line('RW_trasp.COD_ARTICULO     : '||RW_trasp.COD_ARTICULO)             ;
--              dbms_output.put_line('RW_trasp.COD_USO  : '||RW_trasp.COD_USO)                  ;
--              dbms_output.put_line('RW_trasp.COD_ESTADO       : '||RW_trasp.COD_ESTADO)               ;
--              dbms_output.put_line('RW_trasp.NUM_SERIE        : '||RW_trasp.NUM_SERIE)                        ;
--              dbms_output.put_line('RW_trasp.NUM_PETICION : '||RW_trasp.NUM_PETICION)                 ;
--              dbms_output.put_line('RW_trasp.FEC_TRASPASO_MASIVO      : '||RW_trasp.FEC_TRASPASO_MASIVO);
--              dbms_output.put_line('RW_trasp.TIP_MOVIM_AUT: '||RW_trasp.TIP_MOVIM_AUT)                        ;
--              dbms_output.put_line('RW_trasp.TIP_MOVIM_ENV    : '||RW_trasp.TIP_MOVIM_ENV)             ;
--              dbms_output.put_line('RW_trasp.TIP_MOVIM_REC    : '||RW_trasp.TIP_MOVIM_REC)              ;
--              dbms_output.put_line('RW_trasp.USU_TRASPASO_MASIVO: '||RW_trasp.USU_TRASPASO_MASIVO)    ;
--              dbms_output.put_line('RW_trasp.DES_OBSERVACION  : '||RW_trasp.DES_OBSERVACION)    ;
--              dbms_output.put_line('RW_trasp.CAP_CODE         : '||RW_trasp.CAP_CODE)                   ;
--              dbms_output.put_line('RW_trasp.NUM_TELEFONO: '||RW_trasp.NUM_TELEFONO)                  ;
--              dbms_output.put_line('RW_trasp.NUM_SERIEMEC     : '||RW_trasp.NUM_SERIEMEC)              ;
--              dbms_output.put_line('RW_trasp.NOM_USUAPROC     : '||RW_trasp.NOM_USUAPROC)               ;
--              dbms_output.put_line('RW_trasp.FEC_PROCESO: '||RW_trasp.FEC_PROCESO)            ;
--              dbms_output.put_line('RW_trasp.SQLCODE  : '||RW_trasp.SQLCODE )         ;
--              dbms_output.put_line('RW_trasp.SQLERRM          : '||RW_trasp.SQLERRM)  ;
--              dbms_output.put_line('RW_trasp.NUM_CANTIDAD: '||RW_trasp.NUM_CANTIDAD);
--              dbms_output.put_line('RW_trasp.COD_PEDIDO               : '||RW_trasp.COD_PEDIDO);
--              dbms_output.put_line('RW_trasp.NUM_SEC_LOCA_ORI : '||RW_trasp.NUM_SEC_LOCA_ORI);
--              dbms_output.put_line('RW_trasp.NUM_SEC_LOCA_DEST : '||RW_trasp.NUM_SEC_LOCA_DEST);
--
                                         OV_tabla       :='P_AL_TRATAMIENTO_MASIVO :'||RW_trasp.num_serie ;
                                         OV_accion      := 'INSERT';
                                         OV_sqlcode     := '-20104';
                                                 OV_sqlerrm := SQLERRM;
        END;

END P_INSERTATRASPASO_PR;
--
PROCEDURE   P_CAMBIOESTADO_PR
(TS_serie IN al_series.num_Serie%TYPE,
 TI_cod_estado IN al_estados.cod_estado%TYPE) IS
/*
<NOMBRE>          : P_CAMBIOESTADO_PR
<FECHACREA>       : 21/04/2004
<MODULO >         : AL
<AUTOR >      : Ulises Patricio Uribe Flores
<VERSION >    : 1.0
<DESCRIPCION> : Realiza cambio de estado de serie vía al_movimientos
<FECHAMOD >   :
<DESCMOD >    :
<ParamEntr>   : TS_serie
<ParamSal >   :
*/
        RW_movim_cam_esta al_estados.cod_estado%TYPE;
        TN_num_movim     al_movimientos.num_movimiento%TYPE;
        TV_cod_estadomov al_movimientos.cod_estadomov%TYPE:='SO';
        TV_nompara6      ged_parametros.nom_parametro%TYPE:= 'TIPO_MOVIM_CAM_EST';
        v_nom_estado_new ged_parametros.nom_parametro%TYPE:= 'ESTADO_NUEVO';
        v_estado_new     ged_parametros.nom_parametro%TYPE;
        TV_trassaccion   ged_parametros.nom_parametro%TYPE;
        CI_uno           INTEGER :=1;
        CI_zero          INTEGER :=0;
        CI_cod_producto  INTEGER:=1;
        CV_cod_modulo    VARCHAR(2):='AL';
        RW_movim         al_movimientos%ROWTYPE;
        OV_tabla                 VARCHAR2(50);
        OV_accion                        VARCHAR2(50);
        OV_sqlcode                       VARCHAR2(50);
        OV_sqlerrm                       VARCHAR2(1000);

                 CURSOR v_parametros_movimiento IS
                 SELECT tip_stock, cod_bodega, cod_articulo, cod_uso, cod_estado,
                        ind_telefono, num_telefono, cod_central, cod_subalm, cod_cat, plan, carga
                 FROM   al_series
                 WHERE  num_serie = TS_serie;
        ERROR_CAMBIO_ESTADO EXCEPTION;
        ERROR_ESTADOS_IGUALES EXCEPTION;
BEGIN
            --   Obtengo Numero de Movimiento




                        SELECT al_seq_mvto.NEXTVAL
                                INTO   TN_num_movim
                                FROM   dual;

        -- Obtiene ESTADO TEMPORAL_DEVOLUCION

                                SELECT val_parametro
                                INTO   RW_movim_cam_esta
                                FROM   ged_parametros
                                WHERE  cod_modulo = CV_cod_modulo
                                AND    cod_producto = CI_cod_producto
                                AND    nom_parametro =  TV_nompara6;


                        FOR CC IN v_parametros_movimiento LOOP
                            IF cc.cod_estado = TI_cod_estado THEN
                                    RAISE  ERROR_ESTADOS_IGUALES;
                                END IF;

                                RW_movim.NUM_MOVIMIENTO  := TN_num_movim;
                                RW_movim.TIP_MOVIMIENTO  := TO_NUMBER(RW_movim_cam_esta);
                                RW_movim.FEC_MOVIMIENTO  := SYSDATE;
                                RW_movim.TIP_STOCK       := cc.tip_Stock;
                                RW_movim.COD_BODEGA              := cc.cod_bodega;
                                RW_movim.COD_ARTICULO    := cc.cod_articulo;
                                RW_movim.COD_USO                 := cc.cod_uso;
                                RW_movim.COD_ESTADO              := cc.cod_estado;
                                RW_movim.NUM_CANTIDAD    := CI_uno;   --es siempre uno 1
                                RW_movim.COD_ESTADOMOV   := TV_cod_estadomov;
                                RW_movim.NOM_USUARORA    := USER;   --USER
                                RW_movim.COD_ESTADO_DEST := TI_cod_estado;
                                RW_movim.NUM_SERIE               := TS_serie;
                                RW_movim.NUM_DESDE               := CI_zero; -- siempre es zero
                                RW_movim.COD_TRANSACCION := TO_NUMBER(TV_trassaccion); -- Parametros internos
                                RW_movim.NUM_TRANSACCION := NULL;
                                RW_movim.COD_PRODUCTO    := CI_uno;
                                RW_movim.IND_TELEFONO    := cc.ind_telefono;
                                RW_movim.NUM_TELEFONO    := cc.num_telefono;
                                RW_movim.COD_SUBALM          := cc.cod_subalm;
                                RW_movim.COD_CENTRAL     := cc.cod_central;
                                RW_movim.COD_CAT                 := cc.cod_cat;
                                RW_movim.PLAN                    := cc.plan;
                                RW_movim.CARGA                   := cc.carga;


                        END LOOP;
                        P_INSERTAMOVIMIENTO_PR(RW_movim,OV_tabla, OV_accion,OV_sqlcode, OV_sqlerrm);
            IF OV_tabla IS NOT NULL THEN
                                                RAISE  ERROR_CAMBIO_ESTADO;
                        END IF;

   EXCEPTION
                         WHEN ERROR_CAMBIO_ESTADO THEN
                           RAISE_APPLICATION_ERROR('sqlcode : ' ||SQLCODE||' sqlerrm : ' ||SQLERRM,':Error INSERTANDO MOVIMIENTO en cambio de Estado serie N°: '||TS_serie);
                    WHEN ERROR_ESTADOS_IGUALES THEN
                           RAISE_APPLICATION_ERROR('sqlcode : ' ||SQLCODE||' sqlerrm : ' ||SQLERRM,': Error "ESTADOS IGUALES" serie N°: '||TS_serie);
                         WHEN OTHERS THEN
                           RAISE_APPLICATION_ERROR(SQLCODE||SQLERRM,'Error INESPERADO en cambio de Estado serie N°: '||TS_serie);
END P_CAMBIOESTADO_PR;
--
FUNCTION P_OBTIENECATARTICULO_FN(
IV_tipterminal   IN al_articulos.tip_terminal%TYPE,
IV_indequiacc   IN al_articulos.ind_equiacc%TYPE)
RETURN VARCHAR2 IS
/*
<NOMBRE>          : P_OBTIENECATARTICULO_FN
<FECHACREA>       : 21/04/2004
<MODULO >         : AL
<AUTOR >      : Ulises Patricio Uribe Flores
<VERSION >    : 1.0
<DESCRIPCION> : Devuelve el tipo de articulo (imei, simcard, tarjeta, etc,) dependiedo de los parametros entrantes
<FECHAMOD >   :
<DESCMOD >    :
<ParamEntr>   : IV_tipterminal,    IV_indequiacc
<ParamSal >   :         OV_return
*/      OV_return VARCHAR2(100);
BEGIN

        IF (IV_tipterminal  = 'T') AND( IV_indequiacc = 'E') THEN
                      OV_return :='T';
        ELSIF   (IV_tipterminal  = 'D' AND IV_indequiacc         = 'E') THEN
                      OV_return :='D';
        ELSIF  (IV_tipterminal  = 'D' AND IV_indequiacc  = 'A') THEN
                      OV_return :='TR';
        ELSIF (IV_tipterminal  = 'G' AND IV_indequiacc = 'E') THEN
                      OV_return :='G';
                ELSE
                          NULL;
                END IF;
RETURN    OV_return;

END P_OBTIENECATARTICULO_FN;
--
PROCEDURE P_PMPARTICULO_PR(
IN_cod_articulo IN  al_articulos.cod_articulo%TYPE,
ON_precio          OUT  NUMBER,
OV_tabla        IN OUT           VARCHAR2,
OV_accion          IN OUT        VARCHAR2,
OV_sqlcode         IN OUT        VARCHAR2,
OV_sqlerrm         IN OUT VARCHAR2) IS
/*
<NOMBRE>          : P_PMPARTICULO_PR
<FECHACREA>       : 21/04/2004
<MODULO >         : AL
<AUTOR >      : Ulises Patricio Uribe Flores
<VERSION >    : 1.0
<DESCRIPCION> : Obtiene el precio pmp de un articulo
<FECHAMOD >   :
<DESCMOD >    :
<ParamEntr>   : IN_cod_articulo
<ParamSal >   : ON_precio, OV_tabla, OV_accion, OV_sqlcode, OV_sqlerrm
*/
        v_cod_moneda        ge_monedas.cod_moneda%TYPE;
        v_cod_moneda_local  ge_monedas.cod_moneda%TYPE;
        ON_precio_aux           NUMBER;
        v_fecha             al_pdte_calculo.fec_movimiento%TYPE;
BEGIN
        -- Obtiene Operadora Local

        -- Obtiene Csdigo de Moneda Local

        al_pac_validaciones.p_obtiene_moneda(v_cod_moneda_local);
        -- Obtiene Precio del zltimo registro del PMP
        BEGIN
                SELECT  NVL(PREC_PMP,0)
                INTO  ON_precio
                FROM al_pmp_articulo
                WHERE  cod_articulo = IN_cod_articulo
                AND fec_ult_mod = (SELECT max(fec_ult_mod)
                                   FROM al_pmp_articulo where cod_articulo = IN_cod_articulo);
          EXCEPTION
                WHEN OTHERS THEN
                                         OV_tabla       :='AL_PMP_ARTICULO' ;
                                         OV_accion      := 'SELECT';
                                         OV_sqlcode     := '-20105';
                                         OV_sqlerrm := 'No se pudo recuperar PMP para articulo : ' ||IN_cod_articulo;
                                         RETURN;
   END;

        -- Si el pmp es nulo se busca la orden de ingreso con fecha mayor de entrada para obtener el Precio
        EXCEPTION
                    WHEN NO_DATA_FOUND THEN
                        BEGIN
                                SELECT  NVL(SUM(PRC_UNIDAD + PRC_FF +PRC_ADIC),0),a.cod_moneda,a.fec_creacion
                                INTO ON_precio, v_cod_moneda , v_fecha
                                FROM al_Cabecera_ordenes2 a, al_lineas_ordenes2 b
                                WHERE a.num_orden = (SELECT MAX(c.num_orden) FROM al_cabecera_ordenes2 c, al_lineas_ordenes2 d
                                          WHERE c.num_orden = d.num_orden
                                          AND d.cod_articulo = IN_cod_articulo
                                          AND c.cod_estado <> 'NU')
                                AND a.num_orden = b.num_orden
                                GROUP BY a.cod_moneda,a.fec_creacion;
                                EXCEPTION
                        WHEN OTHERS THEN
                       BEGIN
                                                          SELECT  NVL(SUM(PRC_UNIDAD + PRC_FF +PRC_ADIC),0),a.cod_moneda,a.fec_creacion
                                                          INTO ON_precio, v_cod_moneda , v_fecha
                                                          FROM al_hCabecera_ordenes2 a, al_hlineas_ordenes2 b
                                                          WHERE a.num_orden = (SELECT MAX(c.num_orden) FROM al_hcabecera_ordenes2 c, al_hlineas_ordenes2 d
                                                                        WHERE c.num_orden = d.num_orden
                                                                        AND d.cod_articulo = IN_cod_articulo
                                                                        AND c.cod_estado <> 'NU')
                                                          AND a.num_orden = b.num_orden
                                                          GROUP BY a.cod_moneda,a.fec_creacion;
                                          EXCEPTION
                                                          WHEN OTHERS THEN
                                                                           ON_precio:=0;
                                                                  END;
                        END;
           IF ON_precio IS NULL  THEN
                   ON_precio:=0;
           ELSE
                  IF ON_precio <> 0 THEN
                         IF v_cod_moneda_local <> v_cod_moneda THEN
                                al_pac_validaciones.p_convertir_precio(v_cod_moneda,v_cod_moneda_local,ON_precio, ON_precio_aux, v_fecha);
                                ON_precio := ON_precio_aux;
                         END IF;
              END IF;
                END IF;
END P_PMPARTICULO_PR;
--
PROCEDURE P_OBTIENEPRECIOKIT_PR(
-- Inicio : XO-200510160888  Responsable cambio: Zenen Muñoz H.  fecha: 17-10-2005  Desc.: Cambio de tipo de datos de number a number (14,4)*
IN_PRECIOUNIDAD       IN OUT    al_series.prc_compra%TYPE,
-- Fin incidencia: XO-200510160888
TV_numkit             IN        al_Series.num_Serie%TYPE,
OV_tabla       IN OUT    VARCHAR2,
OV_accion          IN OUT        VARCHAR2,
OV_sqlcode         IN OUT        VARCHAR2,
OV_sqlerrm         IN OUT    VARCHAR2) IS
/*
<NOMBRE>          : P_OBTIENEPRECIOKIT_PR
<FECHACREA>       : 21/04/2004
<MODULO >         : AL
<AUTOR >      : Ulises Patricio Uribe Flores
<VERSION >    : 1.0
<DESCRIPCION> : Obtiene el precio pmp de un kit
<FECHAMOD >   :
<DESCMOD >    :
<ParamEntr>   : TV_numkit
<ParamSal >   : IN_PRECIOUNIDAD, OV_tabla, OV_accion, OV_sqlcode, OV_sqlerrm
*/
-- Inicio : XO-200510160888  Responsable cambio: Zenen Muñoz H.  fecha: 17-10-2005  Desc.: Cambio de tipo de datos de number a number (14,4)*
TV_valor_armado    al_series.prc_compra%TYPE;
-- Fin incidencia: XO-200510160888
BEGIN

        BEGIN
                                SELECT   NVL(SUM(a.prc_compra*a.can_articulo),0)
                                INTO     IN_preciounidad
                                FROM     al_componente_kit a
                                WHERE    a.num_kit = TV_numkit;
                EXCEPTION
                                        WHEN OTHERS THEN
                                                         OV_tabla       :='GED_PARAMETRO-V_tipmovimE' ;
                                                         OV_accion      := 'SELECT';
                                                         OV_sqlcode     := '-20106';
                                                         OV_sqlerrm := 'No se pudo recuperar suma de componente para Kit : '||TV_numkit;
                                                         RETURN;
            END;
        -- OBTIENE VALOR ARMADO DE KIT
        BEGIN
                                SELECT a.valor_armado_kit
                                INTO   TV_valor_armado
                                FROM   al_datos_generales a;
                                IN_preciounidad:=IN_preciounidad + TV_valor_armado;
                EXCEPTION
                                        WHEN OTHERS THEN
                                                 OV_tabla       :='AL_DATOS_GENERALES-TV_valor_armado' ;
                                                 OV_accion      := 'SELECT';
                                                 OV_sqlcode     := '-20107';
                                                 OV_sqlerrm := 'No se pudo recuperar valor de armado de kit';
                                                 RETURN;
        END;
END P_OBTIENEPRECIOKIT_PR;
--
PROCEDURE P_OBTIENEHLR_PR(
TV_hlr         IN OUT       al_movimientos.cod_hlr%TYPE,
TV_simcard     IN                       al_series.num_Serie%TYPE,
OV_tabla       IN OUT    VARCHAR2,
OV_accion          IN OUT        VARCHAR2,
OV_sqlcode         IN OUT        VARCHAR2,
OV_sqlerrm         IN OUT    VARCHAR2)IS
/*
<NOMBRE>          : P_OBTIENEHLR_PR
<FECHACREA>       : 21/04/2004
<MODULO >         : AL
<AUTOR >      : Ulises Patricio Uribe Flores
<VERSION >    : 1.0
<DESCRIPCION> : Obtiene hlr de una ICC dada ..
<FECHAMOD >   :
<DESCMOD >    :
<ParamEntr>   : TV_hlr  , TV_simcard
<ParamSal >   : TV_hlr , OV_tabla, OV_accion, OV_sqlcode, OV_sqlerrm
*/
BEGIN
                        SELECT cod_hlr
                        INTO TV_hlr
                        FROM gsm_simcard_to
                        WHERE num_simcard = TV_simcard;
        EXCEPTION
                 WHEN OTHERS THEN
                         OV_tabla       :='gsm_simcard_to' ;
                         OV_accion      := 'SELECT';
                         OV_sqlcode     :='-20108';
                         OV_sqlerrm := 'No se pudo recuperar hlr para ICC : '|| TV_simcard ;
                         RETURN;
END P_OBTIENEHLR_PR;
--
PROCEDURE P_ESNUMERADO_PR(
IV_celular     IN           VARCHAR2,
TV_subalm      IN OUT           ga_celnum_uso.cod_subalm%TYPE,
TV_central     IN OUT           ga_celnum_uso.cod_central%TYPE,
TV_cat         IN OUT           ga_celnum_uso.cod_cat%TYPE,
OV_tabla       IN OUT           VARCHAR2,
OV_accion          IN OUT           VARCHAR2,
OV_sqlcode         IN OUT           VARCHAR2,
OV_sqlerrm         IN OUT       VARCHAR2) IS
/*
<NOMBRE>          : P_OBTIENEHLR_PR
<FECHACREA>       : 21/04/2004
<MODULO >         : AL
<AUTOR >      : Ulises Patricio Uribe Flores
<VERSION >    : 1.0
<DESCRIPCION> : Obtieme central, categoria y subalm de un numero celular
<FECHAMOD >   :
<DESCMOD >    :
<ParamEntr>   : TIV_celular
<ParamSal >   : TV_subalm ,TV_central ,TV_cat , OV_tabla, OV_accion, OV_sqlcode, OV_sqlerrm
*/
BEGIN
                                SELECT cod_subalm, cod_central,  cod_cat
                                INTO   TV_subalm,TV_central,TV_cat
                                FROM   ga_celnum_uso
                                WHERE  TO_NUMBER(IV_celular) BETWEEN num_desde AND num_hasta;
                EXCEPTION
                                WHEN OTHERS THEN
                                         OV_tabla       :='GA_CELNUM_USO' ;
                                         OV_accion      := 'SELECT';
                                         OV_sqlcode     := '-20109';
                                         OV_sqlerrm := 'No se pudo recuperar Subalm, central y categoria para celular : '||IV_celular;
                                         RETURN;
END P_ESNUMERADO_PR;
--
PROCEDURE P_MOVIMCAMESTA_PR(
TV_param        IN OUT          ged_parametros.val_parametro%TYPE,
TV_nompara6     IN          ged_parametros.nom_parametro%TYPE,
CV_cod_modulo   IN          VARCHAR,
CI_cod_producto IN                      INTEGER   ,
OV_tabla        IN OUT          VARCHAR2,
OV_accion           IN OUT          VARCHAR2,
OV_sqlcode          IN OUT          VARCHAR2,
OV_sqlerrm          IN OUT      VARCHAR2) IS

BEGIN
                SELECT val_parametro
                INTO   TV_param
                FROM   ged_parametros
                WHERE  cod_modulo = CV_cod_modulo
                AND    cod_producto = CI_cod_producto
                AND    nom_parametro = TV_nompara6;
   EXCEPTION
         WHEN OTHERS THEN
                 OV_tabla       :='GED_PARAMETROS-RW_movim_cam_esta' ;
                 OV_accion      := 'SELECT';
                 OV_sqlcode     := '-20110';
                 OV_sqlerrm := 'No se pudo recuperar parametro para cambio de estado';
                 RETURN;
END P_MOVIMCAMESTA_PR;
--
PROCEDURE P_OBTIENEDATOSTRASPASO_PR(
TV_serie                 IN             al_series.num_serie%TYPE,
TI_bod_ori           IN OUT     al_bodegas.cod_bodega%TYPE,
TI_uso_tras          IN OUT     al_series.cod_uso%TYPE,
TV_est_tras          IN OUT             al_series.cod_estado%TYPE  ,
TN_prc_unidad            IN OUT     al_series.prc_compra%TYPE,
OV_tabla                 IN OUT         VARCHAR2,
OV_accion                IN OUT     VARCHAR2,
OV_sqlcode               IN OUT     VARCHAR2,
OV_sqlerrm               IN OUT      VARCHAR2)IS
BEGIN
                                        --dbms_output.put_line('TV_serie : '||TV_serie);
                                        SELECT cod_bodega , cod_uso , cod_estado, prc_compra
                                        INTO   TI_bod_ori, TI_uso_tras, TV_est_tras,TN_prc_unidad
                                        FROM   al_series
                                        WHERE  num_serie = TV_serie;

                    EXCEPTION
                                 WHEN OTHERS THEN
                                         OV_tabla       :='AL_SERIES-bod_uso_est'||TV_serie ;
                                         OV_accion      := 'SELECT';
                                         OV_sqlcode     := '-20111';
                                         OV_sqlerrm := SQLERRM;
                                         RETURN;
END P_OBTIENEDATOSTRASPASO_PR;
--
PROCEDURE P_OBTIENEMOVIMIENTO_PR(
IN_MOVIM       IN OUT    al_movimientos.num_movimiento%TYPE,
OV_tabla       IN OUT    VARCHAR2,
OV_accion          IN OUT        VARCHAR2,
OV_sqlcode         IN OUT        VARCHAR2,
OV_sqlerrm         IN OUT    VARCHAR2) IS
/*
<NOMBRE>          : P_OBTIENEMOVIMIENTO_PR
<FECHACREA>       : 21/04/2004
<MODULO >         : AL
<AUTOR >      : Ulises Patricio Uribe Flores
<VERSION >    : 1.0
<DESCRIPCION> : Obtieme numero de movimento siguiente para insertar movimiento
<FECHAMOD >   :
<DESCMOD >    :
<ParamEntr>   : IN_MOVIM
<ParamSal >   : IN_MOVIM , OV_tabla, OV_accion, OV_sqlcode, OV_sqlerrm
*/
BEGIN
    SELECT al_seq_mvto.NEXTVAL
        INTO   IN_movim
        FROM   dual;
EXCEPTION
        WHEN OTHERS THEN
         OV_tabla       :='AL_SEQ_MOVTO' ;
         OV_accion      := 'SELECT';
         OV_sqlcode     := '-20112';
         OV_sqlerrm := 'No se pudo recuperar secuencia para insertar movimiento';
         RETURN;
END P_OBTIENEMOVIMIENTO_PR;
--
PROCEDURE P_OBTIENENUMTRASPASOMASIVO_PR(
TV_num_trasM   IN OUT    al_traspasos_masivo.num_traspaso_masivo%TYPE,
OV_tabla       IN OUT    VARCHAR2,
OV_accion          IN OUT        VARCHAR2,
OV_sqlcode         IN OUT        VARCHAR2,
OV_sqlerrm         IN OUT    VARCHAR2) IS
/*
<NOMBRE>          : P_OBTIENENUMTRASPASOMASIVO_PR
<FECHACREA>       : 21/04/2004
<MODULO >         : AL
<AUTOR >      : Ulises Patricio Uribe Flores
<VERSION >    : 1.0
<DESCRIPCION> : Obtieme numero de traspaso masivo  siguiente para insertar traspaso masivo
<FECHAMOD >   :
<DESCMOD >    :
<ParamEntr>   : TV_num_trasM
<ParamSal >   : TV_num_trasM , OV_tabla, OV_accion, OV_sqlcode, OV_sqlerrm
*/
        BEGIN
                                SELECT al_seq_traspaso_masivo.NEXTVAL
                                        INTO   TV_num_trasM
                                        FROM   dual;
        EXCEPTION
                WHEN OTHERS THEN
                                         OV_tabla       :='AL_SEQ_TRASPASO_MASIVO' ;
                                         OV_accion      := 'SELECT';
                                         OV_sqlcode     := '-20113';
                                         OV_sqlerrm := 'No se pudo recuperar secuencia para insertar traspaso masivo';
                 RETURN;
END P_OBTIENENUMTRASPASOMASIVO_PR;
--
PROCEDURE P_OBTIENENUMEROTRASPASO_PR(
TV_num_tras    IN OUT    al_traspasos_masivo.num_traspaso%TYPE,
OV_tabla       IN OUT    VARCHAR2,
OV_accion          IN OUT        VARCHAR2,
OV_sqlcode         IN OUT        VARCHAR2,
OV_sqlerrm         IN OUT    VARCHAR2) IS
/*
<NOMBRE>          : P_OBTIENENUMTRASPASOMASIVO_PR
<FECHACREA>       : 21/04/2004
<MODULO >         : AL
<AUTOR >      : Ulises Patricio Uribe Flores
<VERSION >    : 1.0
<DESCRIPCION> : Obtieme numero de traspaso siguiente para insertar traspaso masivo
<FECHAMOD >   :
<DESCMOD >    :
<ParamEntr>   : TV_num_tras
<ParamSal >   : TV_num_tras , OV_tabla, OV_accion, OV_sqlcode, OV_sqlerrm
*/
        BEGIN
                                        SELECT al_seq_traspaso.NEXTVAL
                                        INTO   TV_num_tras
                                        FROM   dual;
        EXCEPTION
                 WHEN OTHERS THEN
                                         OV_tabla       :='AL_SEQ_TRASPASO' ;
                                         OV_accion      := 'SELECT';
                                         OV_sqlcode     := '-20114';
                                         OV_sqlerrm := 'No se pudo recuperar secuencia para trapaso';
                         RETURN;
END P_OBTIENENUMEROTRASPASO_PR;
--
PROCEDURE P_OBTIENEPLAZA_PR(
IV_cod_bodega    IN     al_bodegas.cod_bodega%TYPE,
OV_cod_plaza    IN OUT    al_series.cod_plaza%TYPE,
OV_tabla       IN OUT    VARCHAR2,
OV_accion          IN OUT        VARCHAR2,
OV_sqlcode         IN OUT        VARCHAR2,
OV_sqlerrm         IN OUT    VARCHAR2) IS
/*
<NOMBRE>          : P_OBTIENENUMTRASPASOMASIVO_PR
<FECHACREA>       : 21/04/2004
<MODULO >         : AL
<AUTOR >      : Ulises Patricio Uribe Flores
<VERSION >    : 1.0
<DESCRIPCION> : Obtieme numero de traspaso siguiente para insertar traspaso masivo
<FECHAMOD >   :
<DESCMOD >    :
<ParamEntr>   : TV_num_tras
<ParamSal >   : TV_num_tras , OV_tabla, OV_accion, OV_sqlcode, OV_sqlerrm
*/
BEGIN
SELECT cod_oficina_def
INTO OV_cod_plaza
FROM al_datos_generales;
        EXCEPTION
                 WHEN OTHERS THEN
                                         OV_tabla       :='AL_DATOS_GENERALES' ;
                                         OV_accion      := 'SELECT';
                                         OV_sqlcode     := '-20115';
                                         OV_sqlerrm := 'No se pudo recuperar plaza por defecto';
                         RETURN;
END;
END AL_DEVOLUCIONKIT_PG ; 
/
SHOW ERRORS
