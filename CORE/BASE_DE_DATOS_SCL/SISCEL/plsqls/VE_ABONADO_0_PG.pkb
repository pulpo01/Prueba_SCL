CREATE OR REPLACE PACKAGE BODY ve_abonado_0_pg

IS

        PROCEDURE ve_valida_abonado_pr
                (
                 en_cod_cliente ga_abocel.cod_cliente%TYPE
                ,sn_cod_validacion OUT NOCOPY NUMBER
                ,sn_cod_respuesta OUT NOCOPY NUMBER
                ,sv_mensaje_respuesta OUT NOCOPY VARCHAR2
                )
        /*
        <Documentación
          TipoDoc = "Procedimiento">
           <Elemento
              Nombre = "VE_VALIDA_ABONADO_PR"
              Lenguaje="PL/SQL"
              Fecha creación="22-02-2007"
              Creado por="Tito Donoso Vera"
              Fecha modificacion=""
              Modificado por=""
              Ambiente Desarrollo="BD">
              <Retorno>Valida existencia de abonados activos del cliente</Retorno>
              <Descripción>Validacion para efectuar cobro de abonado 0</Descripción>
              <Parámetros>
                 <Entrada>
                           <param nom="en_cod_cliente" Tipo="NUMBER">Codigo del cliente</param>
                           <param nom="en_num_abonado" Tipo="NUMBER">Numero del abonado que se esta creando</param>
                         </Entrada>
                 <Salida>
                           <param nom="sn_cod_validacion" Tipo="NUMBER">codigo de validacion para la creacion de nuevo abonado (1 = corresponde efectuar cargo, 0 = No corresponde efectuar cargo)</param>
                           <param nom="sn_cod_respuesta" Tipo="NUMBER">codigo de salida (0: OK, 4: Error)</param>
                   <param nom="sn_mensaje_respuesta" Tipo="VARCHAR2">Mensaje de salida</param>
                         </Salida>
              </Parámetros>
           </Elemento>
        </Documentación>
        */

        IS
            CV_error_no_clasif     VARCHAR2(50):= 'No es posible clasificar el error';
                e_error_parametros     EXCEPTION;
                e_error_cliente            EXCEPTION;
            n_cod_error            NUMBER(6);
            v_count_cliente                NUMBER(1);

        BEGIN

          IF en_cod_cliente IS NULL THEN
            RAISE e_error_parametros;
          END IF;


          SELECT COUNT(1)
            INTO v_count_cliente
            FROM ge_clientes
           WHERE cod_cliente = en_cod_cliente
             AND ROWNUM <= 1;

          IF v_count_cliente = 0 THEN
            RAISE e_error_cliente;
          END IF;

          SELECT 1 - COUNT(1)
            INTO sn_cod_validacion
            FROM ga_abocel abo
           WHERE abo.cod_cliente = en_cod_cliente
--           AND abo.cod_situacion = 'AAA'
                 AND NOT EXISTS (SELECT 1 FROM ga_parametros_multiples_vw b
                                                        WHERE b.nom_parametro='COD_SITUABO_BAJA'
                                                        AND b.valor_texto = abo.cod_situacion)
             AND abo.tip_plantarif = 'E'
             AND ROWNUM <= 1;


          sn_cod_respuesta := 0;
        EXCEPTION
          WHEN e_error_parametros THEN
              sn_cod_respuesta := 4;
                  sv_mensaje_respuesta := 'Error en el ingreso de parametros.';
          WHEN e_error_cliente THEN
              sn_cod_respuesta := 4;
                  sv_mensaje_respuesta := 'Error en identificacion del cliente.';
          WHEN OTHERS THEN
              sn_cod_respuesta := 4;
                  sv_mensaje_respuesta := 'Error Ejecución de Servicio.';


        END ve_valida_abonado_pr;

------------------------------------------------------------------------------------------------------------
--//////////////////////////////////////////////////////////////////////////////////////////////////////////
------------------------------------------------------------------------------------------------------------

        PROCEDURE ve_registra_cargobasico_pr
                (
                 en_cod_cliente                          ga_abocel.cod_cliente%TYPE
                ,en_num_abonado                                  ga_abocel.num_abonado%TYPE
                ,sn_cod_respuesta         OUT NOCOPY NUMBER
                ,sv_mensaje_respuesta OUT NOCOPY VARCHAR2
                )
        /*
        <Documentación
          TipoDoc = "Procedimiento">
           <Elemento
              Nombre = "VE_VALIDA_ABONADO_PR"
              Lenguaje="PL/SQL"
              Fecha creación="22-02-2007"
              Creado por="Tito Donoso Vera"
              Fecha modificacion=""
              Modificado por=""
              Ambiente Desarrollo="BD">
              <Retorno>Valida existencia de abonados activos del cleinte</Retorno>
              <Descripción>Validacion para efectuar cobro de abonado 0</Descripción>
              <Parámetros>
                 <Entrada>
                           <param nom="en_cod_cliente" Tipo="NUMBER">Codigo del cliente</param>
                           <param nom="en_num_abonado" Tipo="NUMBER">Numero del abonado que se esta creando</param>
                         </Entrada>
                 <Salida>
                           <param nom="sn_cod_respuesta" Tipo="NUMBER">codigo de salida (0: OK, 4: Error)</param>
                   <param nom="sn_mensaje_respuesta" Tipo="VARCHAR2">Mensaje de salida</param>
                         </Salida>
              </Parámetros>
           </Elemento>
        </Documentación>
        */

        IS
            CV_error_no_clasif     VARCHAR2(50):= 'No es posible clasificar el error';
                e_error_parametros     EXCEPTION;
            n_cod_error            NUMBER(6);
                iDecimal               NUMBER(2);

                n_cargobasico          ta_cargosbasico.imp_cargobasico%TYPE;
                n_codciclo                         ge_clientes.cod_ciclo%TYPE;
                n_codplan                          ga_cliente_pcom.cod_plancom%TYPE;
                n_indfactur                        ge_clientes.ind_factur%TYPE;
                n_codconcepto              fa_conceptos.cod_concepto%TYPE;
                n_codmoneda                        ta_cargosbasico.cod_moneda%TYPE;

        BEGIN

            IF en_cod_cliente IS NULL OR en_num_abonado IS NULL THEN
              RAISE e_error_parametros;
            END IF;

            SELECT cb.imp_cargobasico,
                           cb.cod_moneda
                  INTO n_cargobasico,
                           n_codmoneda
                  FROM ga_abocel       ac,
                           ga_empresa      em,
                           ta_plantarif    pt,
                           ta_cargosbasico cb
                 WHERE ac.cod_cliente   = en_cod_cliente
                   AND ac.num_abonado   = en_num_abonado
                   AND em.cod_empresa   = ac.cod_empresa
                   AND pt.cod_plantarif = em.cod_plantarif
                   AND cb.cod_cargobasico = pt.cod_cargobasico
                   AND SYSDATE > pt.fec_desde
                   AND pt.fec_hasta > NVL(pt.fec_hasta, SYSDATE)
                   AND SYSDATE > cb.fec_desde
                   AND cb.fec_hasta > NVL(cb.fec_hasta, SYSDATE);

            SELECT ge_pac_general.param_general('num_decimal')
              INTO iDecimal
              FROM dual;

                --selecciona campos para inserta en ge_cargos
            SELECT cl.cod_ciclo,
                           pc.cod_plancom,
                           cl.ind_factur
                  INTO n_codciclo,
                           n_codplan,
                           n_indfactur
                  FROM ge_clientes cl,
                           ga_cliente_pcom pc
             WHERE cl.cod_cliente = en_cod_cliente
                   AND pc.cod_cliente = cl.cod_cliente
                   AND pc.fec_desde <= SYSDATE
                   AND NVL(pc.fec_hasta, SYSDATE) >= SYSDATE;

                --selecciona codigo de concepto
                SELECT cod_abonocel
                  INTO n_codconcepto
                  FROM fa_datosgener
                 WHERE ROWNUM = 1;


                INSERT INTO ge_cargos
                                   (num_cargo,                      cod_cliente,                        cod_producto,
                                        cod_concepto,               fec_alta,                           imp_cargo,
                                        cod_moneda,                 cod_plancom,                        num_unidades,
                                        ind_factur,                 num_transaccion,            num_venta,
                                        num_paquete,                num_abonado,                        num_terminal,
                                        cod_ciclfact,               num_serie,                          num_seriemec,
                                        cap_code,                           mes_garantia,                       num_preguia,
                                        num_guia,                           num_factura,                        cod_concepto_dto,
                                        val_dto,                            tip_dto,                            ind_cuota,
                                        ind_supertel,               ind_manual,                         nom_usuarora,
                                        pref_plaza,                 cod_tecnologia)
                         VALUES(ge_seq_cargos.nextval,  en_cod_cliente,                 1,
                                        n_codconcepto,                  SYSDATE,                                ge_pac_general.redondea(n_cargobasico, iDecimal, 0),
                                        n_codmoneda,                    n_codplan,                              1,
                                        n_indfactur,                    0,                                              0,
                                        DEFAULT,                                en_num_abonado,                 DEFAULT,
                                        n_codciclo,                             DEFAULT,                                DEFAULT,
                                        DEFAULT,                                DEFAULT,                                DEFAULT,
                                        DEFAULT,                                0,                                              DEFAULT,
                                        DEFAULT,                                DEFAULT,                                DEFAULT,
                                        DEFAULT,                                DEFAULT,                                USER,
                                        DEFAULT,                                DEFAULT);
            sn_cod_respuesta := 0;--OK
        EXCEPTION
          WHEN e_error_parametros THEN
              sn_cod_respuesta := 4;
                  sv_mensaje_respuesta := 'Error en ingreso de parametros.';
          WHEN OTHERS THEN

              sn_cod_respuesta := 4;
                  sv_mensaje_respuesta := 'Error Ejecución de Servicio.';
        END ve_registra_cargobasico_pr;


------------------------------------------------------------------------------------------------------------
--//////////////////////////////////////////////////////////////////////////////////////////////////////////
------------------------------------------------------------------------------------------------------------

        FUNCTION ve_valida_abonado_fn
                (
                 en_cod_cliente IN ga_abocel.cod_cliente%TYPE
                )
        /*
        <Documentación
          TipoDoc = "Funcion">
           <Elemento
              Nombre = "VE_VALIDA_ABONADO_FN"
              Lenguaje="PL/SQL"
              Fecha creación="20-03-2007"
              Creado por="Tito Donoso Vera"
              Fecha modificacion=""
              Modificado por=""
              Ambiente Desarrollo="BD">
              <Retorno>1: no tiene mas abonados. Indica accion de cobro. 0: Tiene mas abonados. No ejecutar accion de cobro</Retorno>
              <Descripción>Revisa existencia de abonados activos del cliente usando con procedimiento VE_VALIDA_ABONADO_PR</Descripción>
              <Parámetros>
                 <Entrada>
                           <param nom="en_cod_cliente" Tipo="NUMBER">Codigo del cliente</param>
                         </Entrada>
              </Parámetros>
           </Elemento>
        </Documentación>
        */
        RETURN NUMBER
        IS
        n_cod_respuesta         NUMBER;
        v_mensaje_respuesta VARCHAR2(50);
        n_cod_validacion        NUMBER;
        BEGIN

          IF en_cod_cliente IS NULL OR en_cod_cliente < 0 THEN
                 RETURN -1;
          END IF;
          ve_abonado_0_pg.ve_valida_abonado_pr(en_cod_cliente, n_cod_validacion, n_cod_respuesta, v_mensaje_respuesta);

          IF n_cod_respuesta = 0 then
                RETURN n_cod_validacion;
          ELSE
            RETURN - 1;
          END IF;

        END ve_valida_abonado_fn;

END ve_abonado_0_pg;
/
SHOW ERRORS
