CREATE OR REPLACE PACKAGE BODY ve_cuposbloqueos_pg
IS
        PROCEDURE ve_ins_cupbloq_pr
                   (EN_tipcomis                 IN ve_vendedores.cod_tipcomis%TYPE
                   ,EV_region                   IN ge_ciucom.cod_region%TYPE
                   ,EV_departamento             IN ge_ciucom.cod_provincia%TYPE
                   ,EV_distrito                 IN ge_ciucom.cod_ciudad%TYPE     DEFAULT NULL
                   ,EN_cod_vendedor             IN ve_vendedores.cod_vendedor%TYPE       DEFAULT NULL
                   ,EN_diapag                   IN ve_cupobloqueo_to.num_diapag%TYPE
                   ,EN_dialeg                   IN ve_cupobloqueo_to.num_dialeg%TYPE
                   ,EN_cant                     IN ve_cupobloqueo_to.can_dias%TYPE
                   ,EV_fecini                   IN VARCHAR2
                   ,EV_fecfin                   IN VARCHAR2
                   ,EV_tipven                   IN ve_cupobloqueo_to.tip_vendedor%TYPE
                   ,SN_cod_respuesta    OUT NOCOPY NUMBER
                   ,SN_msg_respuesta    OUT NOCOPY VARCHAR2
                   )
        IS
                /*
                <Documentación
                  TipoDoc = "Procedimiento">
                   <Elemento
                      Nombre = "VE_INS_CUPBLOQ_PR"
                      Lenguaje="PL/SQL"
                      Fecha creación="11-04-2007"
                      Creado por="TDV"
                      Fecha modificacion=""
                      Modificado por=""
                      Ambiente Desarrollo="BD">
                      <Retorno>Inserta registros de cupos y bloqueos</Retorno>
                      <Descripción>Inserta registros de cupos y bloqueos</Descripción>
                      <Parámetros>
                         <Entrada>
                                   <param nom="en_tipcomis" Tipo="NUMBER">Codigo del tipo de comisionista</param>
                                   <param nom="ev_region" Tipo="NUMBER">codigo de region de vendedores</param>
                                   <param nom="ev_departamento" Tipo="NUMBER">codigo de departamento de vendedores</param>
                                   <param nom="ev_distrito" Tipo="NUMBER">codigo de distrito de vendedores</param>
                                   <param nom="en_cod_vendedor" Tipo="NUMBER">codigo de vendedores</param>
                                   <param nom="en_diapag" Tipo="NUMBER">dia de pago de vendedores</param>
                                   <param nom="en_dialeg" Tipo="NUMBER">dias de legalizacion</param>
                                   <param nom="EN_cant" Tipo="NUMBER">Cantidad de ventas legalizacion</param>
                                   <param nom="ev_fecini" Tipo="NUMBER">fecha de inicio de bloqueo</param>
                                   <param nom="ev_fecfin" Tipo="NUMBER">fecha de fin de bloqueo</param>
                                 </Entrada>
                         <Salida>
                                   <param nom="sn_cod_respuesta" Tipo="NUMBER">codigo de salida (0: OK, 4: Error)</param>
                           <param nom="sn_mensaje_respuesta" Tipo="VARCHAR2">Mensaje de salida</param>
                                 </Salida>
                      </Parámetros>
                   </Elemento>
                </Documentación>
                */

          dfec_ini              DATE;
          dfec_fin              DATE;
          e_parametros  EXCEPTION;
          e_fechas              EXCEPTION;

        BEGIN

                IF (EN_tipcomis IS NULL) OR --verifica parametros obligatorios
                   (EV_departamento IS NULL) OR
                   (EN_diapag IS NULL) OR
                   (EN_dialeg IS NULL) OR
                   (EN_cant   IS NULL) OR
                   (EV_fecini IS NULL) OR
                   (EV_fecfin IS NULL) OR
                   (EV_tipven is NULL) THEN
                                RAISE e_parametros;
                END IF;

                BEGIN -- valida que los formatos de los parametros fecha.
                        dfec_ini := TO_DATE(EV_fecini, 'DD-MM-YYYY');
                        dfec_fin := TO_DATE(EV_fecfin, 'DD-MM-YYYY');
                EXCEPTION WHEN OTHERS THEN
                        RAISE e_fechas;
                END;

                BEGIN
                        if EV_tipven = 'V' then
                                begin
                                        MERGE INTO ve_cupobloqueo_to cb
                                        USING (
                                        SELECT ve.cod_vendedor, ve.cod_oficina
                                                FROM ve_vendedores ve,
                                                ge_oficinas o,
                                                ge_ciucom cc
                                                WHERE ve.cod_tipcomis = EN_tipcomis
                                                AND ve.cod_vendedor = DECODE(EN_cod_vendedor, NULL, ve.cod_vendedor, EN_cod_vendedor)
                                                AND o.cod_oficina = ve.cod_oficina
                                                AND cc.cod_comuna = o.cod_comuna
                                                AND cc.cod_provincia = o.cod_provincia
                                                AND cc.cod_region = o.cod_region
                                                AND cc.cod_provincia = EV_departamento
                                                AND cc.cod_region = EV_region
                                                AND cc.cod_ciudad = DECODE(EV_distrito, NULL, cc.cod_ciudad, EV_distrito)
                                                ) ve
                                        ON (cb.cod_vendedor = ve.cod_vendedor)
                                        WHEN MATCHED THEN

                                        UPDATE
                                                SET cb.num_diapag  = EN_diapag,
                                                cb.num_dialeg  = EN_dialeg,
                                                cb.fec_ini        = dfec_ini,
                                                cb.fec_fin        = dfec_fin,
                                                cb.can_dias    =EN_cant,
                                                cb.nom_usuario = USER,
                                                cb.fec_modif   = SYSDATE

                                        WHEN NOT MATCHED THEN
                                                INSERT
                                                (cod_vendedor, num_diapag, num_dialeg, can_dias,
                                                fec_ini, fec_fin, nom_usuario, fec_modif, tip_vendedor )
                                                VALUES( ve.cod_vendedor, EN_diapag, EN_dialeg, EN_cant,
                                                dfec_ini, dfec_fin, USER, SYSDATE, EV_tipven );
                                end;
                        else
                                begin
                                        MERGE INTO ve_cupobloqueo_to cb
                                        USING (
                                        SELECT ve.cod_vendealer, ve.cod_oficina
                                                FROM ve_vendealer ve,
                                                ge_oficinas o,
                                                ge_ciucom cc
                                                WHERE ve.cod_tipcomis = EN_tipcomis
                                                AND ve.cod_vendealer = DECODE(EN_cod_vendedor, NULL, ve.cod_vendealer, EN_cod_vendedor)
                                                AND o.cod_oficina = ve.cod_oficina
                                                AND cc.cod_comuna = o.cod_comuna
                                                AND cc.cod_provincia = o.cod_provincia
                                                AND cc.cod_region = o.cod_region
                                                AND cc.cod_provincia = EV_departamento
                                                AND cc.cod_region = EV_region
                                                AND cc.cod_ciudad = DECODE(EV_distrito, NULL, cc.cod_ciudad, EV_distrito)
                                                ) ve
                                        ON (cb.cod_vendedor = ve.cod_vendealer)
                                        WHEN MATCHED THEN

                                        UPDATE
                                                SET cb.num_diapag  = EN_diapag,
                                                cb.num_dialeg  = EN_dialeg,
                                                cb.fec_ini        = dfec_ini,
                                                cb.fec_fin        = dfec_fin,
                                                cb.can_dias    =EN_cant,
                                                cb.nom_usuario = USER,
                                                cb.fec_modif   = SYSDATE

                                        WHEN NOT MATCHED THEN
                                                INSERT
                                                (cod_vendedor, num_diapag, num_dialeg, can_dias,
                                                fec_ini, fec_fin, nom_usuario, fec_modif, tip_vendedor )
                                                VALUES( ve.cod_vendealer, EN_diapag, EN_dialeg, EN_cant,
                                                dfec_ini, dfec_fin, USER, SYSDATE, EV_tipven );
                                end;
                        end if;
                END;
                SN_cod_respuesta := 0;
        EXCEPTION
        WHEN e_fechas THEN
                SN_cod_respuesta := 4;
                SN_msg_respuesta := 'Error en el paso de parametros de fecha';
        WHEN e_parametros THEN
                SN_cod_respuesta := 4;
                SN_msg_respuesta := 'Error en el paso de parametros';
        WHEN OTHERS THEN
                SN_cod_respuesta := 4;
                SN_msg_respuesta := 'Error en la ejecucion del servicio';
        END ve_ins_cupbloq_pr;

END ve_cuposbloqueos_pg;
/
SHOW ERRORS
