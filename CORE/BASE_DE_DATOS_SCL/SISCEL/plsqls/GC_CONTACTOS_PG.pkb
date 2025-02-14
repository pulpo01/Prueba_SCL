CREATE OR REPLACE package body Gc_Contactos_Pg AS

 -- Gc_Contactos_Pg VERSION 1.0 --EFR 63035 COL 09-04-2008
 -- Gc_Contactos_Pg VERSION 1.1 COL 63035|29-04-2008|SAQL
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
        FUNCTION  GC_CreacionDeCliente_FN (
                          sCodTipIdent IN gc_cliente_to.cod_tipident%TYPE,
                          sNumIdent    IN gc_cliente_to.num_ident%TYPE,
                          sDesIdent        IN gc_cliente_to.des_ident%TYPE,
                          sNumFonoContacto IN gc_cliente_to.num_fono_contacto%TYPE,
                          sNomUsuarora IN gc_cliente_to.nom_usuarora%TYPE,
                          sObservacion IN gc_cliente_to.gls_observacion%TYPE,
                          sCodCuenta IN gc_cliente_to.cod_cuenta%TYPE
                          )
                          RETURN gc_cliente_to.id_cliente_gc%TYPE
                AS
           vIdCliente gc_cliente_to.id_cliente_gc%TYPE;
                   bExisteClienteGC INTEGER;
        BEGIN
             bExisteClienteGC := 0;

                 --Determinar la existencia del cliente en el módulo Gestor de Contactos
                 BEGIN
            SELECT id_cliente_gc INTO vIdCliente
                FROM gc_cliente_to
            WHERE cod_tipident = sCodTipIdent
                    AND num_ident = sNumIdent
                        FOR UPDATE NOWAIT;
                 EXCEPTION
                    WHEN NO_DATA_FOUND THEN
                           bExisteClienteGC := 1;
                        WHEN OTHERS THEN
                          RAISE_APPLICATION_ERROR (-20001,SQLERRM);
                 END;


                 IF bExisteClienteGC = 0 THEN
                    -- Se actualizan datos del cliente
                        UPDATE GC_CLIENTE_TO
                        SET     des_ident = sDesIdent,
                                num_fono_contacto = sNumFonoContacto,
                            fec_ultmod = SYSDATE,
                                nom_usuarora = sNomUsuarora,
                                gls_observacion = sObservacion,
                                cod_cuenta = sCodCuenta
                        WHERE id_cliente_gc = vIdCliente;

                 ELSE
                    --Cliente nuevo en Gestor de Contactos
                    INSERT INTO GC_CLIENTE_TO (id_cliente_gc, num_ident, cod_tipident, des_ident, num_fono_contacto,
                                                   fec_ultmod, nom_usuarora, gls_observacion,cod_cuenta)
                                   VALUES (gc_seq_cliente.NEXTVAL,sNumIdent,sCodTipIdent,sDesIdent,sNumFonoContacto,
                                               SYSDATE,sNomUsuarora,sObservacion,sCodCuenta)
                           RETURNING id_cliente_gc INTO vIdCliente;

                 END IF;
                 RETURN vIdCliente;
        EXCEPTION
          WHEN OTHERS THEN
             RAISE_APPLICATION_ERROR (-20002,SQLERRM);
                 RETURN -1;
    END GC_CreacionDeCliente_FN;

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    FUNCTION GC_ProximaFechaHabil_FN(
                                                                         FECHAINICIAL DATE,
                                                                         HORAS INTEGER
                                                                         )
                                                                         RETURN DATE AS


        DIA_SEMANA INTEGER;
        CANT_FIN_SEMANA INTEGER;
        FECHAFINAL DATE;
        DIAS INTEGER;
        DIAD INTEGER;

        BEGIN
                 DIA_SEMANA := to_char( FECHAINICIAL,'d');
                 --DIAS:=FLOOR(HORAS/24);
                 DIAS:=(HORAS/24);
                 CANT_FIN_SEMANA :=  FLOOR((DIA_SEMANA + DIAS) / 7) ;
                 FECHAFINAL := FECHAINICIAL + (CANT_FIN_SEMANA * 2) + DIAS;

                 DIAD:= TO_CHAR(TO_DATE('15-02-2004','DD-MM-YYYY'),'d');

                 IF DIAD = 1 THEN
                        IF TO_CHAR(FECHAFINAL,'d') = '1' or TO_CHAR(FECHAFINAL,'d') = '7' THEN
                   FECHAFINAL := FECHAFINAL +2;
                        END IF;
                 ELSIF DIAD = 7 THEN
                        IF TO_CHAR(FECHAFINAL,'d') = '6' or TO_CHAR(FECHAFINAL,'d') = '7' THEN
                   FECHAFINAL := FECHAFINAL +2;
                        END IF;
                 END IF;

                 RETURN FECHAFINAL;


    END GC_ProximaFechaHabil_FN;

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    FUNCTION  GC_CreacionDeContacto_FN (
                          pCodSentido IN gc_contacto_to.cod_sentido%TYPE,
              pNomContacto IN gc_contacto_to.nom_contacto%TYPE,
                          pCodCanal    IN gc_contacto_to.cod_canal_contacto%TYPE,
                          pNumIPPC     IN gc_contacto_to.num_ip_pc%TYPE,
              pNumFono     IN gc_contacto_to.num_fono_contacto%TYPE,
                          pEMail       IN gc_contacto_to.e_mail_contacto%TYPE,
                          pObservacion IN gc_contacto_to.gls_observaciones%TYPE,
              pContactoPadre IN gc_contacto_to.id_contacto_padre%TYPE,
                          pIdCliente     IN gc_contacto_to.id_cliente_gc%TYPE,
                          pUsuario       IN gc_contacto_to.nom_usuarora%TYPE,
              pNombrePC      IN gc_contacto_to.nom_pc%TYPE
                          )
                          RETURN gc_contacto_to.id_contacto%TYPE
                AS
                vIdContacto gc_contacto_to.id_contacto%TYPE;
        BEGIN
             INSERT INTO gc_contacto_to
                 (id_contacto, cod_sentido, fec_contacto, nom_contacto, cod_canal_contacto, num_ip_pc,
         num_fono_contacto, e_mail_contacto, gls_observaciones, id_contacto_padre,
                 id_cliente_gc, nom_usuarora,nom_pc)
         VALUES
                 (gc_seq_contacto.NEXTVAL, pCodSentido, SYSDATE, pNomContacto, pCodCanal, pNumIPPC,
                  pNumFono, pEMail, pObservacion, pContactoPadre, pIdCliente, pUsuario,pNombrePC)
                                RETURNING id_contacto INTO vIdContacto;
                RETURN vIdContacto;
        EXCEPTION
          WHEN OTHERS THEN
             RAISE_APPLICATION_ERROR (-20001,SQLERRM);
                 RETURN -1;
    END GC_CreacionDeContacto_FN;

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
        FUNCTION  GC_CreacionDeApunte_FN (
              pCodTripleta IN gc_apunte_to.cod_tripleta%TYPE,
              pIdContacto IN gc_apunte_to.id_contacto%TYPE,
              pIdCliente IN gc_apunte_to.id_cliente_gc%TYPE,
              pCodNivel IN gc_apunte_to.cod_nivel%TYPE,
                          pUsuario  IN gc_apunte_to.usu_crea_apunte%TYPE,
                          pObservacion IN gc_apunte_to.gls_observaciones%TYPE
              )
                          RETURN gc_apunte_to.id_apunte%TYPE
             AS
                 vIdApunte gc_apunte_to.id_apunte%TYPE;
                 vTipNivel  gc_apunte_to.tip_nivel%TYPE;
                 vCodSector gc_tripleta_td.cod_sector%TYPE;
                 vTipPlan gc_apunte_to.cod_tiplan%TYPE;
                 vCodTecnologia gc_apunte_to.cod_tecnologia%TYPE;
                 vCodSLA gc_apunte_to.cod_sla%TYPE;
                 vFlagCliente gc_tripleta_td.flg_cliente%TYPE;
                 FALTA_CODIGO_NIVEL EXCEPTION;
        BEGIN
             vTipPlan := NULL;
                 vCodTecnologia := NULL;

                 --Traer tipo de nivel definido en la tripleta
                 SELECT tip_nivel, cod_sla, flg_cliente, cod_sector INTO vTipNivel, vCodSLA, vFlagCliente, vCodSector
                 FROM gc_tripleta_td
                 WHERE cod_tripleta = pCodTripleta;

                 IF (vFlagCliente = 'S' OR vTipNivel = 4) AND pCodNivel IS NULL THEN
                    RAISE FALTA_CODIGO_NIVEL;
                 END IF;

                 IF vTipNivel = 3 THEN
                    -- Traer tecnologia Y Tipo de plan
                        SELECT plantarifario.cod_tiplan, abopostpago.cod_tecnologia
                        INTO vTipPlan, vCodTecnologia
            FROM ta_plantarif plantarifario,
                 ga_abocel abopostpago
            WHERE abopostpago.cod_plantarif = plantarifario.cod_plantarif
            AND abopostpago.cod_producto = plantarifario.cod_producto
            AND num_abonado = pCodNivel
            UNION
            SELECT plantarifario.cod_tiplan, aboprepago.cod_tecnologia
                        FROM ta_plantarif plantarifario,
                 ga_aboamist aboprepago
            WHERE aboprepago.cod_plantarif = plantarifario.cod_plantarif
            AND aboprepago.cod_producto = plantarifario.cod_producto
            AND num_abonado = pCodNivel;

                 END IF;

                 INSERT INTO gc_apunte_to (id_apunte, cod_tripleta, id_contacto,fec_fin_apunte, fec_crea_apunte,
                                           usu_crea_apunte, cod_estado_apunte, fec_estado_apunte, usu_estado_apunte,
                                   id_cliente_gc, tip_nivel, cod_nivel, fec_asig, ind_acepclie,
                                                                   cod_tecnologia, cod_tiplan, cod_sla, gls_observaciones, cod_sector)
                                VALUES (gc_seq_apunte.NEXTVAL, pCodTripleta, pIdContacto, NULL, SYSDATE,
                                        pUsuario, 'P', SYSDATE, pUsuario,
                                                pIdCliente, vTipNivel, pCodNivel, NULL, NULL,
                                                vCodTecnologia, vTipPlan, vCodSLA, pObservacion, vCodSector
                                        )
                 RETURNING id_apunte INTO vIdApunte;

                 RETURN vIdApunte;
        EXCEPTION
          WHEN FALTA_CODIGO_NIVEL THEN
             RAISE_APPLICATION_ERROR (-20002,'Codigo de nivel no puede ser nulo');
                 RETURN -1;
          WHEN OTHERS THEN
             RAISE_APPLICATION_ERROR (-20001,SQLERRM);
                 RETURN -1;
        END GC_CreacionDeApunte_FN;

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   PROCEDURE GC_CreacionDeTareas_PR (
              pCodTripleta IN gc_tripleta_td.cod_tripleta%TYPE,
                          pIdApunte IN gc_tarea_apunte_to.id_apunte%TYPE,
              pIdContacto IN gc_tarea_apunte_to.id_contacto%TYPE,
              pUsuario IN gc_tarea_apunte_to.usu_crea_tarea%TYPE,
              pCodNivel IN gc_tarea_apunte_to.cod_nivel%TYPE,
              pIdCliente IN gc_tarea_apunte_to.id_cliente_gc%TYPE,
                          pObservacion IN gc_tarea_apunte_to.gls_observaciones%TYPE )
                 AS
                 vTareaPred gc_tarea_apunte_to.id_tarea%TYPE;
                 vIndActiva gc_tarea_apunte_to.ind_activa%TYPE;
                 vFecAsig  gc_tarea_apunte_to.fec_asig%TYPE;
                 vUsuAsig  gc_tarea_apunte_to.usu_asig%TYPE;
                 vCodEstadoTarea gc_tarea_apunte_to.cod_estado_tarea%TYPE;
                 vFechaSistema DATE;
                 vCantidadDeTareas INTEGER;
                 vTareaAsignada INTEGER;
                 vTareaActivada INTEGER;
                 APUNTE_CON_TAREAS_CREADAS EXCEPTION;

                 CURSOR TareasXTripleta(vCodTripleta gc_tripleta_td.cod_tripleta%TYPE) IS
                   SELECT tarea.cod_tarea, tripleta.cod_sector, tarea.tip_tarea, tarea.ind_manual,
                          tareaTripleta.cod_tarea_pred, tripleta.tip_nivel, tareatripleta.cod_prioridad, tarea.ind_ejec_inme
           FROM gc_tripleta_td tripleta,
                        gc_tarea_tripleta_td tareaTripleta,
                        gc_tarea_td tarea
                   WHERE tripleta.cod_tripleta = vCodTripleta
                   AND tripleta.cod_tripleta = tareaTripleta.cod_tripleta
                   AND tarea.cod_tarea = tareaTripleta.cod_tarea
                   AND SYSDATE BETWEEN tarea.fec_ini_vigencia AND tarea.fec_fin_vigencia
                   ORDER BY tareaTripleta.sec_tarea_tripleta ASC;
        BEGIN
            vTareaPred     := 0;
                vFechaSistema  := SYSDATE;
                vTareaAsignada := 0;
                vTareaActivada := 0;
                vCodEstadoTarea := 'P';

                --Chequear que no se hayan creado las tareas para el apunte
                SELECT COUNT(1) INTO vCantidadDeTareas
                FROM gc_tarea_apunte_to
                WHERE id_apunte =  pIdApunte
                AND id_contacto = pIdContacto;
                -- AND FEC_CREA_TAREA BETWEEN SYSDATE-365 AND SYSDATE; -- EFR 63035 COL 09-04-2008 -- se reversa inc. COL 63035|29-04-2008|SAQL

                IF vCantidadDeTareas > 0 THEN
                   RAISE APUNTE_CON_TAREAS_CREADAS;
                END IF;

                FOR vcTareasXTripleta IN TareasXTripleta(pCodTripleta) LOOP
                        --SI LA TAREA ES LA PRIMERA EN SER INICIADA
                        IF vcTareasXTripleta.cod_tarea_pred IS NULL THEN
                           vIndActiva := 1;
               vTareaPred := 0;
                           vTareaActivada := 1;
                        ELSE
                           vIndActiva := 0;
                        END IF;

                        IF vcTareasXTripleta.cod_tarea_pred IS NULL THEN
                           IF vcTareasXTripleta.ind_manual <> 'S' OR vcTareasXTripleta.ind_ejec_inme = 'S' THEN
                                    --Si la tarea no es manual (automática) o es de ejecucion inmediata
                                    vFecAsig := vFechaSistema;
                                    vUsuAsig := pUsuario;
                                        vTareaAsignada := 1;

                                        IF vcTareasXTripleta.ind_manual = 'S' THEN
                                           vCodEstadoTarea := 'A';
                                        END IF;
                                ELSE
                                        vFecAsig := NULL;
                                vUsuAsig := NULL;
                                END IF;
                        ELSE
                           vFecAsig := NULL;
                           vUsuAsig := NULL;
                        END IF;

                        INSERT INTO gc_tarea_apunte_to (id_tarea, id_apunte, id_contacto, cod_tarea, fec_crea_tarea,
                                                        usu_crea_tarea, cod_estado_tarea, fec_estado_tarea,
                                                                                        usu_estado_tarea, ind_activa, ind_manual, tip_tarea, fec_asig,
                                                                                        id_tarea_pred, usu_asig, cod_sector_asig, tip_nivel, cod_nivel,
                                            id_cliente_gc, cod_prioridad, gls_observaciones, ind_ejec_inme,
                                            num_mov_mensaje, cod_modulo_origen)
                                        VALUES (gc_seq_tarea_apunte.NEXTVAL, pIdApunte, pIdContacto, vcTareasXTripleta.cod_tarea, SYSDATE,
                                        pUsuario, vCodEstadoTarea, SYSDATE,
                                                        pUsuario, vIndActiva, vcTareasXTripleta.ind_manual, vcTareasXTripleta.tip_tarea, vFecAsig,
                                                        vTareaPred, vUsuAsig, vcTareasXTripleta.cod_sector, vcTareasXTripleta.Tip_Nivel, pCodNivel,
                                                        pIdCliente, vcTareasXTripleta.cod_prioridad, pObservacion, vcTareasXTripleta.ind_ejec_inme,
                                                        NULL, 'GC' )
                                        RETURNING id_tarea INTO vTareaPred;

                        vCodEstadoTarea := 'P';
                END LOOP;

                IF vTareaActivada > 0 THEN
                   UPDATE gc_apunte_to
                   SET fec_activacion = SYSDATE
                   WHERE id_apunte = pIdApunte
                   AND id_Contacto = pIdContacto;
                END IF;

            IF vTareaAsignada > 0 THEN
                   UPDATE gc_apunte_to
                   SET fec_asig = vFechaSistema,
                   cod_estado_apunte = 'A',
                   fec_estado_apunte = SYSDATE,
                   usu_estado_apunte = pUsuario
                   WHERE id_apunte = pIdApunte
                   AND id_Contacto = pIdContacto
                   AND fec_asig IS NULL;
                END IF;

        EXCEPTION
          WHEN APUNTE_CON_TAREAS_CREADAS THEN
                 RAISE_APPLICATION_ERROR  (-20002, 'Apunte ya tiene creada las tareas');
          WHEN OTHERS THEN
             RAISE_APPLICATION_ERROR (-20001,SQLERRM);
        END GC_CreacionDeTareas_PR;

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    PROCEDURE GC_CrearDatoAdicionalApunte_PR (
              pIdApunte IN gc_datos_adic_apunte_to.id_apunte%TYPE,
                          pCodDatoAdic IN gc_datos_adic_apunte_to.cod_datadic%TYPE,
                          pNomDatoAdic IN gc_datos_adic_apunte_to.nom_datadic%TYPE,
              pValorDatoAdic IN gc_datos_adic_apunte_to.val_datadic%TYPE)
         AS
        BEGIN

           DELETE gc_datos_adic_apunte_to
           WHERE id_apunte = pIdApunte
           AND cod_datadic = pCodDatoAdic;

           INSERT INTO gc_datos_adic_apunte_to (id_apunte, cod_datadic, nom_datadic, val_datadic)
           VALUES (pIdApunte, pCodDatoAdic, pNomDatoAdic,pValorDatoAdic );


        EXCEPTION
          WHEN OTHERS THEN
             RAISE_APPLICATION_ERROR (-20001,SQLERRM);
        END GC_CrearDatoAdicionalApunte_PR;


------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   PROCEDURE GC_CreacionDeContactoSCL_PR (
                  pCodCtaSCL IN gc_cliente_to.cod_cuenta%TYPE,
                          sCodTripletaNogc IN gc_apunte_to.cod_tripleta%TYPE,
              pCodNivel IN gc_apunte_to.cod_nivel%TYPE,
              pUsuario IN gc_apunte_to.usu_crea_apunte%TYPE,
                          pObservacion IN VARCHAR2)
         AS
                 vIdCliente gc_cliente_to.id_cliente_gc%TYPE;
                 vIdContacto gc_contacto_to.id_contacto%TYPE;
                 vIdApunte gc_apunte_to.id_apunte%TYPE;
                 vCodTipIdent  gc_cliente_to.cod_tipident%TYPE;
                 vNumIdent     gc_cliente_to.num_ident%TYPE;
                 vDesIdent         gc_cliente_to.des_ident%TYPE;
                 vNumFonoContacto gc_cliente_to.num_fono_contacto%TYPE;
                 vCodCanal     gc_contacto_to.cod_canal_contacto%TYPE;
                 vCodTripleta gc_apunte_to.cod_tripleta%TYPE;
                 vNumTareas INTEGER;

        BEGIN

         SELECT cod_tipident, num_ident, des_cuenta, tel_contacto
                 INTO   vCodTipIdent, vNumIdent, vDesIdent, vNumFonoContacto
                 FROM ga_cuentas
                 WHERE cod_cuenta = pCodCtaSCL;

                 SELECT cod_tripleta
                 INTO vCodTripleta
                 FROM gc_tripleta_td
                 WHERE cod_tripleta_nogc = sCodTripletaNogc;

                 vIdCliente := GC_CreacionDeCliente_FN(vCodTipIdent, vNumIdent, vDesIdent, vNumFonoContacto, pUsuario, NULL, pCodCtaSCL);

                 vIdContacto := GC_CreacionDeContacto_FN('S', vDesIdent, 6, ' ', vNumFonoContacto,
                                                              NULL, NULL, NULL, vIdCliente,
                                                                                                  pUsuario, ' ');

                 vIdApunte := GC_CreacionDeApunte_FN(vCodTripleta, vIdContacto, vIdCliente, pCodNivel, pUsuario, pObservacion);

                 GC_CreacionDeTareas_PR(vCodTripleta, vIdApunte, vIdContacto, pUsuario, pCodNivel, vIdCliente, pObservacion);

                 SELECT COUNT(1) INTO vNumTareas
                 FROM gc_tarea_apunte_to
                 WHERE id_apunte = vIdApunte;
                 --AND FEC_CREA_TAREA BETWEEN SYSDATE-365 AND SYSDATE; -- EFR 63035 COL 09-04-2008 -- se reversa inc. COL 63035|29-04-2008|SAQL

                 IF vNumTareas = 0 THEN
                    GC_ModificacionApunte_PR(1, vIdApunte, 'C', pUsuario, 'C','','','');
         END IF;

        EXCEPTION
          WHEN OTHERS THEN
             RAISE_APPLICATION_ERROR (-20001,SQLERRM);
        END GC_CreacionDeContactoSCL_PR;

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   PROCEDURE GC_agregarCambioEnBitacora_PR (
                  pNomTabla IN gc_bitacora_to.nom_tabla%TYPE,
                          pNomCampo IN gc_bitacora_to.nom_campo%TYPE,
                          pidTabla IN gc_bitacora_to.id_tabla%TYPE,
              pValorAnterior IN gc_bitacora_to.val_anterior%TYPE,
              pValorNuevo IN gc_bitacora_to.val_nuevo%TYPE,
                          pUsuModif IN gc_bitacora_to.usu_modif%TYPE,
                          pObservacion IN gc_bitacora_to.gls_observaciones%TYPE)
           AS
   BEGIN
                INSERT INTO gc_bitacora_to (id_bitacora,nom_tabla, nom_campo, id_tabla, fec_modif, usu_modif, gls_observaciones,
                                    val_anterior, val_nuevo)
               VALUES (gc_seq_bitacora.NEXTVAL, pNomTabla,pNomCampo,pidTabla,SYSDATE, pUsuModif,pObservacion,pValorAnterior,pValorNuevo );

   END GC_agregarCambioEnBitacora_PR;



------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   PROCEDURE  GC_ModificacionTareas_PR (
                          opcion integer,
                          codestado        IN gc_tarea_apunte_to.cod_estado_tarea%TYPE,
                          sUsuarioasign    IN gc_tarea_apunte_to.usu_asig%TYPE,
                          indactiva        IN gc_tarea_apunte_to.ind_activa%TYPE,
                          iIdTarea         IN gc_tarea_apunte_to.id_tarea%TYPE,
                          iIdApunte        IN gc_apunte_to.id_apunte%TYPE,
                          glsobservaciones IN gc_apunte_to.gls_observaciones%TYPE,
                          sUsuarioestado   IN gc_tarea_apunte_to.usu_estado_tarea%TYPE
                          )
        AS
           vIndManual gc_tarea_apunte_to.ind_manual%TYPE;
                ct integer;
        -- 1 modifica ind_activo pot id tarea
        -- 3 modifica modifica usuario y fecha de asignacion por id tare
        -- 4 modificacion de todas las tareas de un apunte por apunte
        -- 5 modifica ind_activa y cod estado por id_tare

        BEGIN

                   IF opcion = 1 AND indactiva IS NOT NULL THEN
                           UPDATE gc_tarea_apunte_to SET
                           ind_activa = indactiva,
                           gls_observaciones = glsobservaciones
                           WHERE id_tarea = iIdTarea
                           AND ind_manual = 'S';
                   ELSIF opcion = 3 AND sUsuarioasign IS NOT NULL THEN
-- BFC 05/07/2005 Se comenta para que se pueda asignar tareas pendientes y asignadas, manuales y automaticas
                           --SELECT ind_manual into vIndManual
                           --FROM gc_tarea_apunte_to
                   --WHERE id_tarea = iIdTarea;

                           --IF vIndManual = 'S' THEN
                               UPDATE gc_tarea_apunte_to SET
                           usu_asig = sUsuarioasign,
                           fec_asig = SYSDATE,
                           cod_estado_tarea = 'A',
                           gls_observaciones = glsobservaciones
                           WHERE id_tarea = iIdTarea
                           AND cod_estado_tarea IN ('P', 'A');
                   --ELSE
                       --    UPDATE gc_tarea_apunte_to SET
                       --    usu_asig = sUsuarioasign,
                       --    fec_asig = SYSDATE,
                       --    gls_observaciones = glsobservaciones
                       --    WHERE id_tarea = iIdTarea
                       --    AND cod_estado_tarea = 'P';
                   --END IF;

                   ELSIF opcion = 4 AND iIdApunte IS NOT NULL AND codestado IS NOT NULL THEN

                           SELECT count(1) INTO ct --- verifica si el apunte esta Cancelado o Detenido por Cliente
                           FROM gc_apunte_to
                           WHERE id_apunte = iIdApunte
                           AND cod_estado_apunte = codestado;

                           IF ct = 1 THEN
                              UPDATE gc_tarea_apunte_to set
                                  cod_estado_tarea = codestado,
                                  usu_estado_tarea = sUsuarioestado,
                                  fec_estado_tarea = SYSDATE,
                                  gls_observaciones = glsobservaciones
                                  WHERE id_apunte = iIdApunte;
                           END IF;
                   ELSIF opcion = 5 AND codestado IS NOT NULL AND sUsuarioestado IS NOT NULL AND indactiva IS NOT NULL THEN
                       UPDATE gc_tarea_apunte_to SET
                           cod_estado_tarea = codestado,
                           usu_estado_tarea = sUsuarioestado,
                           fec_estado_tarea = SYSDATE,
                           ind_activa = indactiva,
                           gls_observaciones = glsobservaciones
                           WHERE id_tarea = iIdTarea;
                           -- GC_ActualizacionEstadoApunt_PR(codestado,iIdTarea,sUsuarioestado); -- COL 63035|29-04-2008|SAQL
                   ELSE
                       RAISE_APPLICATION_ERROR (-20002,'Parametros no Validos');
                   END IF;
        END GC_ModificacionTareas_PR;

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
        PROCEDURE  GC_ModificacionApunte_PR(
                          opcion INTEGER,
                          iIdApunte         IN gc_apunte_to.id_apunte%TYPE,
                          sEstado           IN gc_apunte_to.cod_estado_apunte%TYPE,
                          sUsuario          IN gc_apunte_to.usu_estado_apunte%TYPE,
                          sEstadoCondic     IN gc_apunte_to.cod_estado_apunte%TYPE,
                          glsobservaciones  IN gc_apunte_to.gls_observaciones %TYPE,
                          indacepclie       IN gc_apunte_to.ind_acepclie %TYPE,
                          idcontacto        IN gc_apunte_to.id_contacto %TYPE
                          )
        AS
                cta INTEGER;
                ctn INTEGER;

    -- 0 Cancelar Apuntes y Todas sus Tareas
        -- 1A Cambia el Estado del Apunte si es diferente a Cerrado
        -- 1B Cierra Apunte
        -- 2 modifica el apunte al estado aceptado o no por el clientes
        -- 3 modifica la fecha de activacion del apunte
        -- 4 Modifica el estado del Apunte

        BEGIN
                 IF opcion = 0 AND iIdApunte IS NOT NULL AND (sEstado = 'CA' OR sEstado = 'DT') THEN

                        SELECT COUNT(1) INTO cta
                        FROM gc_tarea_apunte_to          --Verifica que la tareas manuales no esten cerradas
                    WHERE id_apunte = iIdApunte
                        AND ind_manual = 'S'
                        AND cod_estado_tarea = 'C';
                        -- AND FEC_CREA_TAREA BETWEEN SYSDATE-365 AND SYSDATE; -- EFR 63035 COL 09-04-2008 -- se reversa inc. COL 63035|29-04-2008|SAQL

                        SELECT COUNT(1) INTO ctn
                        FROM gc_tarea_apunte_to           --Verifica que las tareas automaticas no esten asignadas o cerradas
                    WHERE id_apunte = iIdApunte
                        AND ind_manual <> 'S'
                        AND (cod_estado_tarea = 'C'
                        OR cod_estado_tarea = 'A');

                           IF cta + ctn = 0 THEN
                              UPDATE GC_APUNTE_TO SET
                                  cod_estado_apunte = sEstado,
                                  usu_estado_apunte = sUsuario,
                                  fec_estado_apunte = SYSDATE,
                                  gls_observaciones = glsobservaciones
                                  WHERE id_apunte = iIdApunte;

                                  GC_ModificacionTareas_PR('4', sEstado, NULL,NULL,NULL, iIdApunte, glsobservaciones, sUsuario);

                           END IF;

                 ELSIF opcion = 1 AND iIdApunte IS NOT NULL AND sEstado IS NOT NULL AND sUsuario IS NOT NULL AND sEstadoCondic IS NOT NULL THEN

                        IF      sEstado <> 'C' THEN

                                UPDATE GC_APUNTE_TO SET
                                cod_estado_apunte = sEstado,
                                usu_estado_apunte = sUsuario,
                                fec_estado_apunte = SYSDATE,
                                gls_observaciones = glsobservaciones
                                WHERE id_apunte = iIdApunte
                                AND cod_estado_apunte <> sEstadoCondic;

                        ELSE

                                UPDATE GC_APUNTE_TO SET
                                cod_estado_apunte = sEstado,
                                usu_estado_apunte = sUsuario,
                                fec_estado_apunte = SYSDATE,
                                fec_fin_apunte = SYSDATE,
                                gls_observaciones = glsobservaciones
                                WHERE id_apunte = iIdApunte
                                AND cod_estado_apunte <> sEstadoCondic;

                        END IF;
                 ELSIF opcion = 2 AND iIdApunte IS NOT NULL THEN

                        UPDATE GC_APUNTE_TO SET
                        ind_acepclie = indacepclie,
                        gls_observaciones = glsobservaciones
                        WHERE id_apunte = iIdApunte;

                 ELSIF opcion = 3 AND iIdApunte IS NOT NULL AND idcontacto IS NOT NULL THEN

                        UPDATE GC_APUNTE_TO SET
                        fec_activacion = SYSDATE
                        WHERE id_apunte = iIdApunte
                        AND id_contacto = idcontacto;

                ELSIF opcion = 4 AND iIdApunte IS NOT NULL AND sUsuario IS NOT NULL AND idcontacto IS NOT NULL AND sEstado IS NOT NULL THEN

                        UPDATE GC_APUNTE_TO SET
                        fec_asig = SYSDATE,
                        cod_estado_apunte = sEstado,
                        fec_estado_apunte = SYSDATE,
                        usu_estado_apunte = sUsuario
                        WHERE id_apunte = iIdApunte
                        AND id_contacto = idcontacto
                        AND fec_asig IS NULL;

                ELSIF opcion = 5 AND iIdApunte IS NOT NULL THEN

                    SELECT COUNT(1) INTO cta
                        FROM gc_tarea_apunte_to          --Verifica que las tareas del apunte esten detenidas por cliente
                    WHERE id_apunte = iIdApunte
                        AND cod_estado_tarea <> 'DT';
                        -- AND FEC_CREA_TAREA BETWEEN SYSDATE-365 AND SYSDATE; -- EFR 63035 COL 09-04-2008 -- se reversa inc. COL 63035|29-04-2008|SAQL

                    SELECT COUNT(1) INTO ctn
                        FROM GC_APUNTE_TO                                --Virifica que el apunte este detenido por cliente
                        WHERE id_apunte = iIdApunte
                    AND cod_estado_apunte <> 'DT';

                        IF cta + ctn = 0 THEN

                           UPDATE GC_APUNTE_TO SET
                       cod_estado_apunte = 'P',
                           usu_estado_apunte = sUsuario, --Actualiza el estado del apunte a Pendiente
                           fec_estado_apunte = SYSDATE,
                           gls_observaciones = glsobservaciones
                           WHERE id_apunte = iIdApunte;

                           GC_ModificacionTareas_PR('4', 'P', NULL,NULL,NULL, iIdApunte, glsobservaciones, sUsuario);

                        END IF;
                ELSE
                       RAISE_APPLICATION_ERROR (-20002,'Parametros no Validos');
                END IF;

        END GC_ModificacionApunte_PR;

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
        PROCEDURE  GC_ActualizacionEstadoApunt_PR
                                                   (
                                                        sCodEstadoTarea IN gc_tarea_apunte_to.cod_estado_tarea%TYPE,
                                                        IdTarea                 IN gc_tarea_apunte_to.id_tarea%TYPE,
                                                        sUsuarioestado  IN gc_tarea_apunte_to.usu_estado_tarea%TYPE
                                                   )
        AS

                vIdApunte gc_tarea_apunte_to.id_apunte%TYPE;
                vIdTarea gc_tarea_apunte_to.id_tarea%TYPE;
                vTipTarea gc_tarea_apunte_to.tip_tarea%TYPE;
                vIndManual gc_tarea_apunte_to.tip_tarea%TYPE;
                vCodNivel gc_tarea_apunte_to.cod_nivel%TYPE;
                vCodTarea gc_tarea_apunte_to.cod_tarea%TYPE;
                lNumTareas INTEGER;
                bExistenTareas INTEGER;
                bAsignarTarea INTEGER;
                iEstadoApunte INTEGER;

    BEGIN
            bExistenTareas := 0;
                bAsignarTarea := 0;

            -- Rescatamos los Datos de la Tarea
                BEGIN

                    SELECT id_apunte, tip_tarea
                        INTO  vIdApunte, vTipTarea
                        FROM GC_TAREA_APUNTE_TO
                    WHERE id_tarea = IdTarea;
                END;
                -- Dependiendo del Estado al cual se ha actualizasdo la Tarea,
                -- es que se deben realizar ciertas actualizaciones sobre el Apunte
                -- Asociado a la Tarea.

                -- Actualizacion de la Tarea al Estado de Cerrada
            IF sCodEstadoTarea = 'C' THEN
                    BEGIN
                                -- Verificamos si estan todas las tareas cerradas
                                SELECT COUNT(1)
                                INTO lNumTareas
                                FROM GC_TAREA_APUNTE_TO
                                WHERE id_apunte = vIdApunte
                                AND cod_estado_tarea <> 'C';
                                -- AND FEC_CREA_TAREA BETWEEN SYSDATE-365 AND SYSDATE; -- EFR 63035 COL 09-04-2008 -- se reversa inc. COL 63035|29-04-2008|SAQL
                    END;

                        -- Si estan todas las tareas cerradas, entonces cerramos el Apunte
                        IF lNumTareas = 0 THEN
                           GC_ModificacionApunte_PR(1, vIdApunte, 'C', sUsuarioestado, 'C','','','');
                        ELSE
                            -- Verificamos si la ultima tarea que queda es de Cierre
                            BEGIN

                                    SELECT COUNT(1)
                                    INTO lNumTareas
                                        FROM GC_TAREA_APUNTE_TO
                                        WHERE id_apunte = vIdApunte
                                        AND cod_estado_tarea <> 'C'
                                        AND tip_tarea <> 'TC';
                                        -- AND FEC_CREA_TAREA BETWEEN SYSDATE-365 AND SYSDATE; -- EFR 63035 COL 09-04-2008 -- se reversa inc. COL 63035|29-04-2008|SAQL

                                END;
                                -- Si la tareas es de Cierre, entonce el Apunte esta Solucionado
                                IF lNumTareas = 0 THEN
                                GC_ModificacionApunte_PR(1, vIdApunte, 'S', sUsuarioestado, 'S','','','');
                                END IF;
                            -- Verificamos si la tareas tiene algun sucesor
                            BEGIN

                                SELECT id_tarea, tip_tarea, ind_manual, cod_nivel, cod_tarea
                                    INTO  vIdTarea, vTipTarea, vIndManual, vCodNivel, vCodTarea
                                    FROM GC_TAREA_APUNTE_TO
                            WHERE id_tarea_pred = IdTarea
                                    AND ind_activa = 0;
                                    -- AND FEC_CREA_TAREA BETWEEN SYSDATE-365 AND SYSDATE; -- EFR 63035 COL 09-04-2008 -- se reversa inc. COL 63035|29-04-2008|SAQL

                                EXCEPTION
                            WHEN NO_DATA_FOUND THEN
                                   bExistenTareas := 1;
                            END;
                            -- Si existen tareas sucesoras
                            IF bExistenTareas = 0 THEN
                                    -- Si la tarea es manual, entonces dejamos el in_activa en 1 (o sea activamos la tarea,
                                        -- de lo contrario, tambien activamos la tarea, pero ademas la asignamos.
                                    IF vIndManual = 'S' THEN
                                                GC_ModificacionTareas_PR (1, '', '', 1, vIdTarea, '', '','');
                                        ELSE
                                            GC_ModificacionTareas_PR (5, 'A', '', 1, vIdTarea, '', '',sUsuarioestado);
                                                -- Debemos provocar que se ingrese al estado de verificacion
                                                -- de asignacion de la tarea, para ello seteamos la variable
                                                -- bAsignarTarea en 1.
                                                bAsignarTarea := 1;

                                                -- Si el tipo de tarea es de Cierre de Compromiso, entonces
                                                -- realizamos el proceso de envio de mensaje.
                                        IF vTipTarea = 'TC' THEN
                                                   GC_InsertarMensaje_PR (vIdApunte, vCodNivel, vCodTarea, vIdTarea);
                                        END IF;
                                        END IF;
                            END IF;
                        END IF;
                END IF;

                -- Actualizacion de la Tarea al estado de Asignada
                IF sCodEstadoTarea = 'A' OR bAsignarTarea = 1 THEN
                    BEGIN
                            -- Si el tipo de tarea es de Cierre, entonces el apunte lo pasamos
                                -- al estado GCC, de lo contrario el apunte es pasado al estado Asignado.
                            IF vTipTArea = 'TC' THEN
                                    GC_ModificacionApunte_PR(1, vIdApunte, 'G', sUsuarioestado, 'A','','','');
                                ELSE
                                    GC_ModificacionApunte_PR(1, vIdApunte, 'A', sUsuarioestado, 'A','','','');
                                END IF;
                        END;
                END IF;

                -- Actualizacion de la Tarea al estado Detenida
            IF sCodEstadoTarea = 'D' OR  sCodEstadoTarea = 'DT' THEN
                    BEGIN
                            -- Si todas las tareas del apunte no estan asignadas ni cerradas,
                                -- entonces el apunte pasa a estado Detenido, de lo contrario su
                                -- estado no sufre ninguna modificacion.
                            SELECT COUNT(1)
                                INTO lNumTareas
                                FROM GC_TAREA_APUNTE_TO
                                WHERE id_apunte = vIdApunte
                                AND (cod_estado_tarea = 'A' OR cod_estado_tarea = 'C');
                                -- AND FEC_CREA_TAREA BETWEEN SYSDATE-365 AND SYSDATE; -- EFR 63035 COL 09-04-2008 -- se reversa inc. COL 63035|29-04-2008|SAQL

                                IF lNumTareas = 0 THEN
                                    GC_ModificacionApunte_PR(1, vIdApunte, 'D', sUsuarioestado, 'D','','','');
                                END IF;
                        END;
                END IF;

                IF sCodEstadoTarea = 'D' THEN
                   SELECT count(1)
                   INTO iEstadoApunte
                   FROM gc_tarea_apunte_to
                   WHERE id_apunte = vIdApunte
                   AND cod_estado_tarea <> 'P'
                   AND cod_estado_tarea <> 'CA';
                   -- AND FEC_CREA_TAREA BETWEEN SYSDATE-365 AND SYSDATE; -- EFR 63035 COL 09-04-2008 -- se reversa inc. COL 63035|29-04-2008|SAQL

                   IF iEstadoApunte = 0 THEN
                          UPDATE gc_apunte_to set
                          COD_ESTADO_APUNTE = 'P',
                          FEC_ESTADO_APUNTE = sysdate,
                          USU_ESTADO_APUNTE = sUsuarioestado
                          WHERE id_apunte = vIdApunte;
                   END IF;

                END IF;

                EXCEPTION
                    WHEN OTHERS THEN
                            RAISE_APPLICATION_ERROR (-20001,SQLERRM);

    END GC_ActualizacionEstadoApunt_PR;

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
        PROCEDURE  GC_InsertarMensaje_PR (
                  sIdApunte  IN gc_tarea_apunte_to.id_apunte%TYPE,
                  sCodNivel  IN gc_tarea_apunte_to.cod_nivel%TYPE,
                  sCodTarea  IN gc_tarea_apunte_to.cod_tarea%TYPE,
                  sIdTarea   IN gc_tarea_apunte_to.id_tarea%TYPE)
        AS

                  vCodMensaje gc_tarea_tripleta_td.cod_mensaje%TYPE;
                  vCodTripleta gc_apunte_to.cod_tripleta%TYPE;
                  vTipTerminal ga_abocel.tip_terminal%TYPE;
                  vNumCelular ga_abocel.num_celular%TYPE;
                  vNumSerie ga_abocel.num_serie%TYPE;
                  vCodTec ga_abocel.cod_tecnologia%TYPE;
                  vCodCanalEnvio gc_tarea_tripleta_td.cod_canal_envio%TYPE;
                  vCodActabo VARCHAR2(2) := 'MK';
                  vNumMovimiento NUMBER(9);
                  vCodActuacion NUMBER(5);
                  vCodCentral NUMBER(3);
                  vDesMensaje VARCHAR2(256);
                  bAboamist INTEGER;
        BEGIN
                 bAboamist := 0;

                 SELECT cod_tripleta
                 INTO vCodTripleta
                 FROM GC_APUNTE_TO
                 WHERE id_apunte = sIdApunte;

                 SELECT a.cod_mensaje, a.cod_canal_envio, b.des_mensaje
                 INTO vCodMensaje, vCodCanalEnvio, vDesMensaje
                 FROM GC_TAREA_TRIPLETA_TD a, GC_MENSAJES_TD b
                 WHERE a.cod_tripleta = vCodTripleta
                 AND a.cod_tarea = sCodTarea
                 AND a.cod_mensaje = b.cod_mensaje;

                 BEGIN
                          SELECT tip_terminal, num_celular, num_serie, cod_tecnologia, cod_central
                          INTO vTipTerminal, vNumCelular, vNumSerie, vCodTec, vCodCentral
                          FROM GA_ABOCEL
                          WHERE num_abonado = sCodNivel;

                 EXCEPTION
                      WHEN NO_DATA_FOUND THEN
                              bAboamist := 1;
                          WHEN OTHERS THEN
                              RAISE_APPLICATION_ERROR (-20001,SQLERRM);
                 END;

                 IF bAboamist <> 0 THEN
                        SELECT tip_terminal, num_celular, num_serie, cod_tecnologia, cod_central
                        INTO vTipTerminal, vNumCelular, vNumSerie, vCodTec, vCodCentral
                        FROM GA_ABOAMIST
                        WHERE num_abonado = sCodNivel;
                 END IF;

                 SELECT cod_actcen
                 INTO vCodActuacion
                 FROM GA_ACTABO
                 WHERE cod_actabo = vCodActabo
                 AND cod_producto = 1;

                 BEGIN
                          INSERT INTO ICC_MOVIMIENTO (num_movimiento, num_abonado, cod_modulo, cod_actuacion, tip_terminal,
                                                      cod_central, num_celular, num_serie, cod_mensaje, des_mensaje, tip_tecnologia, cod_actabo)
                          VALUES (icc_seq_nummov.NEXTVAL, sCodNivel, 'GC', vCodActuacion, vTipTerminal, vCodCentral, vNumCelular,
                             vNumSerie, vCodMensaje, vDesMensaje, vCodTec, vCodActabo)
              RETURNING num_movimiento INTO vNumMovimiento;
                 EXCEPTION
                         WHEN OTHERS THEN
                              RAISE_APPLICATION_ERROR (-20001,SQLERRM);
                 END;

                 UPDATE gc_tarea_apunte_to
                 SET num_mov_mensaje = vNumMovimiento
                 WHERE id_tarea = sIdTarea;

        EXCEPTION
                 WHEN OTHERS THEN
                      RAISE_APPLICATION_ERROR (-20001,SQLERRM);

        END GC_InsertarMensaje_PR;

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   PROCEDURE  GC_CreacionDeTareaAdicional_PR(

                          idtarea                          IN gc_tarea_apunte_to.id_tarea%TYPE,
                          tiptarea                         IN gc_tarea_apunte_to.tip_tarea%TYPE,
                          codoperaciontiptarea IN gc_tarea_td.cod_operacion_tiptarea%TYPE,
                          codmoduloorigen      IN gc_tarea_apunte_to.cod_modulo_origen%TYPE,
                          usuario                          IN gc_tarea_apunte_to.usu_asig%TYPE,
                          codestadotarea       IN gc_tarea_apunte_to.cod_estado_tarea%TYPE
                          )
        AS

                vIdapunte       gc_tarea_apunte_to.id_apunte%TYPE;
                vIdcontacto     gc_tarea_apunte_to.id_contacto%TYPE;
                vCodsectorasig  gc_tarea_apunte_to.cod_sector_asig%TYPE;
                vTipnivel           gc_tarea_apunte_to.tip_nivel%TYPE;
                vCodnivel               gc_tarea_apunte_to.cod_nivel%TYPE;
                vIdclientegc    gc_tarea_apunte_to.id_cliente_gc%TYPE;
            vCodtarea       gc_tarea_td.cod_tarea%TYPE;

        BEGIN
                 IF idtarea IS NOT NULL AND tiptarea IS NOT NULL AND codoperaciontiptarea IS NOT NULL AND codmoduloorigen IS NOT NULL AND usuario IS NOT NULL AND codestadotarea IS NOT NULL THEN

                SELECT id_apunte, id_contacto, cod_sector_asig, tip_nivel, cod_nivel, id_cliente_gc
                        INTO   vIdapunte, vIdcontacto, vCodsectorasig,  vTipnivel, vCodnivel, vIdclientegc
                        FROM gc_tarea_apunte_to
                        WHERE id_tarea = idtarea;

                        SELECT cod_tarea INTO vCodtarea
                        FROM gc_tarea_td
                        WHERE cod_operacion_tiptarea = codoperaciontiptarea;

                        INSERT INTO GC_TAREA_APUNTE_TO
                        (ID_TAREA, ID_APUNTE, ID_CONTACTO, COD_TAREA, FEC_CREA_TAREA,
                         USU_CREA_TAREA, COD_ESTADO_TAREA, FEC_ESTADO_TAREA, USU_ESTADO_TAREA,
                         IND_ACTIVA, IND_MANUAL, TIP_TAREA, FEC_ASIG, ID_TAREA_PRED, USU_ASIG,
                         COD_SECTOR_ASIG, TIP_NIVEL, COD_NIVEL, ID_CLIENTE_GC, GLS_OBSERVACIONES,
                         COD_PRIORIDAD, IND_EJEC_INME, COD_MODULO_ORIGEN, NUM_MOV_MENSAJE)
                         VALUES
                         (gc_seq_tarea_apunte.NEXTVAL, vIdapunte, vIdcontacto, vCodtarea, SYSDATE,
                         usuario, codestadotarea, SYSDATE , usuario,
                         1, 'N', tiptarea, SYSDATE, 0, usuario,
                         vCodsectorasig, vTipnivel, vCodnivel, vIdclientegc, NULL,
                         0, 'N', codmoduloorigen, '');

                 END IF;


        END GC_CreacionDeTareaAdicional_PR;

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    PROCEDURE  GC_ActualizacionEstadoTarea_PR
                                                   (
                                                    opcion integer,
                                                        sCodEstadoTarea IN gc_tarea_apunte_to.cod_estado_tarea%TYPE,
                                                        IdTarea                 IN gc_tarea_apunte_to.id_tarea%TYPE,
                                                        sUsuarioasig    IN gc_tarea_apunte_to.usu_asig%TYPE,
                                                        sNumMovMsg      IN gc_tarea_apunte_to.num_mov_mensaje%TYPE,
                                                        sObservacion    IN gc_tarea_apunte_to.gls_observaciones%TYPE,
                                                        sUsuarioestado  IN gc_tarea_apunte_to.usu_estado_tarea%TYPE,
                                                        sCodSectorAsig    IN gc_tarea_apunte_to.cod_sector_asig%TYPE
                                                   )
        AS


                sIdTarea gc_tarea_apunte_to.id_tarea%TYPE;


    BEGIN

                --Verificamos que venga como parametro Num_Movimiento
            IF sNumMovMsg <> '' THEN
                SELECT id_tarea INTO sIdTarea
                FROM gc_tarea_apunte_to
                WHERE num_mov_mensaje = sNumMovMsg;
                --AND FEC_CREA_TAREA BETWEEN SYSDATE-365 AND SYSDATE; -- EFR 63035 COL 09-04-2008 -- se reversa inc. COL 63035|29-04-2008|SAQL
            ELSE
                sIdTarea := IdTarea;
            END IF;

                IF opcion = 0 AND sCodEstadoTarea IS NOT NULL AND sUsuarioestado IS NOT NULL AND sUsuarioasig IS NOT NULL THEN

                          UPDATE gc_tarea_apunte_to SET
                          usu_asig = sUsuarioasig,
                          fec_asig = SYSDATE,
                          cod_estado_tarea = sCodEstadoTarea,
                          usu_estado_tarea = sUsuarioestado,   --Asigna Usuario y Estado a la Tarea
                          fec_estado_tarea = SYSDATE,
                          gls_observaciones = sObservacion
                          WHERE id_tarea = sIdTarea;
                          -- BFC 05/07/2005 Se comenta para que se pueda asignar tareas pendientes y asignadas, manuales y automaticas
                          --AND ind_manual = 'S';


                          GC_ActualizacionEstadoApunt_PR(sCodEstadoTarea,IdTarea,sUsuarioestado);

                ELSIF opcion = 1 AND sCodEstadoTarea IS NOT NULL AND sUsuarioestado IS NOT NULL THEN

                          UPDATE gc_tarea_apunte_to SET
                          cod_estado_tarea = sCodEstadoTarea,
                          usu_estado_tarea = sUsuarioestado,
                          fec_estado_tarea = SYSDATE,                   --Asigna Estado a la Tare
                          gls_observaciones = sObservacion
                          WHERE id_tarea = sIdTarea;
                          -- BFC 05/07/2005 Se comenta para que se pueda asignar tareas pendientes y asignadas, manuales y automaticas
                          --AND ind_manual = 'S';

                          GC_ActualizacionEstadoApunt_PR(sCodEstadoTarea,IdTarea,sUsuarioestado);

                ELSIF opcion = 2 AND sCodSectorAsig IS NOT NULL THEN

                          UPDATE gc_tarea_apunte_to SET
                          usu_asig = null,
                          fec_asig = null,                                                      --Asigna una Tarea a un sector y actualiza su esta a pendiente
                          cod_estado_tarea = 'P',
                          cod_sector_asig = sCodSectorAsig,
                          gls_observaciones = sObservacion
                          WHERE id_tarea = sIdTarea;
                          -- BFC 05/07/2005 Se comenta para que se pueda asignar tareas pendientes y asignadas, manuales y automaticas
                          --AND ind_manual = 'S';

                          GC_ActualizacionEstadoApunt_PR('P',IdTarea,sUsuarioestado);

                ELSE

                      RAISE_APPLICATION_ERROR (-20002,'Parametros no Validos'); -- Error si el llamodo no entra en ninguna opcion

                END IF;

    END GC_ActualizacionEstadoTarea_PR;

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    PROCEDURE GC_ActualizarEstadoMensaje_PR (
                         pREG_CMOV IN ICC_MOVIMIENTO%ROWTYPE)
   IS
   vNumMov       ICC_MOVIMIENTO.NUM_MOVIMIENTO%TYPE;
   vUsuario        ICC_MOVIMIENTO.NOM_USUARORA%TYPE;
   vIdTarea   GC_TAREA_APUNTE_TO.ID_TAREA%TYPE;

        BEGIN

        vNumMov    := pREG_CMOV.NUM_MOVIMIENTO;
        vUsuario   := pREG_CMOV.NOM_USUARORA;

        SELECT id_tarea INTO vIdTarea
        FROM gc_tarea_apunte_to
        WHERE num_mov_mensaje = vNumMov;
        --AND FEC_CREA_TAREA BETWEEN SYSDATE-365 AND SYSDATE; -- EFR 63035 COL 09-04-2008 -- se reversa inc. COL 63035|29-04-2008|SAQL

      GC_CONTACTOS_PG.GC_ModificacionTareas_PR(5,'C', null, 1, vIdTarea, null, 'Mensaje Enviado Exitosamente', vUsuario);

        EXCEPTION
          WHEN OTHERS THEN
             RAISE_APPLICATION_ERROR (-20001,SQLERRM);

    END GC_ActualizarEstadoMensaje_PR;
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

    PROCEDURE GC_MigracionesAbonado_PR(neNumAbonado        IN  ga_traspabo.num_abonado%TYPE,
                                           dsFecModifica       OUT NOCOPY tFecModifica,
                                           nsNumabonado        OUT NOCOPY tNumAbonado,
                                           vsNumTerminal       OUT NOCOPY tNumTerminal,
                                       nsNumabonadoAnt     OUT NOCOPY tNumAbonado,
                                                                           nsCodCuenta         OUT NOCOPY tCodCuenta,
                                       vsIndTraspaso       OUT NOCOPY tIndTraspaso,
                                       vsDesIndTraspaso    OUT NOCOPY tDesIndTraspaso,
                                       vsCodPlantarifOrig  OUT NOCOPY tCodPlantarif,
                                       vsDesPlanTarifOrig  OUT NOCOPY tDesPlantarif,
                                       vsCodPlanTarifDest  OUT NOCOPY tCodPlantarif,
                                                                   vsDesPlanTarifDest  OUT NOCOPY tDesPlantarif,
                                       nsCodVendedor       OUT NOCOPY tCodVendedor,
                                       vsNomVendedor       OUT NOCOPY tNomVendedor
                                                                      )
        AS

           CURSOR MigracionAbon_CU (NumAbonado varchar2)IS
                SELECT a.num_abonado, a.num_abonadoant, a.fec_modifica, a.ind_traspaso, b.des_valor,
                        a.cod_plantarif_orig, c.des_plantarif, a.cod_plantarif_dest, d.des_plantarif as des_plantarif_dest,
                        a.cod_vendedor, e.nom_vendedor, a.cod_cuentanue, a.cod_cuentaant, a.num_terminal
            FROM ga_traspabo a, ged_codigos b, ta_plantarif c, ta_plantarif d, ve_vendedores e
            WHERE a.num_abonado = NumAbonado
            AND c.cod_plantarif(+) = a.cod_plantarif_orig
            AND c.cod_producto(+) = 1
            AND a.cod_plantarif_dest = d.cod_plantarif(+)
            AND d.cod_producto(+) = 1
            AND a.cod_vendedor = e.cod_vendedor(+)
            AND b.cod_modulo(+) = 'GA'
            AND b.nom_tabla(+) = 'GA_TRASPABO'
            AND b.nom_columna(+) = 'IND_TRASPASO'
            AND b.cod_valor(+) = a.ind_traspaso
                        UNION
                        SELECT a.num_abonado, a.num_abonadoant, a.fec_modifica, a.ind_traspaso, b.des_valor,
                        a.cod_plantarif_orig, c.des_plantarif, a.cod_plantarif_dest, d.des_plantarif as des_plantarif_dest,
                        a.cod_vendedor, e.nom_vendedor, a.cod_cuentanue, a.cod_cuentaant, a.num_terminal
            FROM ga_htraspabo a, ged_codigos b, ta_plantarif c, ta_plantarif d, ve_vendedores e
            WHERE a.num_abonado = NumAbonado
            AND c.cod_plantarif(+) = a.cod_plantarif_orig
            AND c.cod_producto(+) = 1
            AND a.cod_plantarif_dest = d.cod_plantarif(+)
            AND d.cod_producto(+) = 1
            AND a.cod_vendedor = e.cod_vendedor(+)
            AND b.cod_modulo(+) = 'GA'
            AND b.nom_tabla(+) = 'GA_TRASPABO'
            AND b.nom_columna(+) = 'IND_TRASPASO'
            AND b.cod_valor(+) = a.ind_traspaso
            ORDER BY 3 DESC;

                        nNumAbonadoAnt ga_traspabo.num_abonado%TYPE;
                        ValorProceso BOOLEAN;
                        i NUMBER;

                BEGIN

                        nNumAbonadoAnt := neNumAbonado;
                        ValorProceso := TRUE;
                        i := 0;
            WHILE ValorProceso LOOP
                            ValorProceso := FALSE;
                            FOR MigracionAbon IN MigracionAbon_CU(nNumAbonadoAnt) LOOP
                                    IF MigracionAbon.cod_cuentanue =  MigracionAbon.cod_cuentaant THEN

                                            IF MigracionAbon.ind_traspaso = 'CTN' OR MigracionAbon.ind_traspaso = 'NCT' OR
                                                MigracionAbon.ind_traspaso = 'POP' OR MigracionAbon.ind_traspaso = 'PRP' OR
                                                MigracionAbon.ind_traspaso = 'REV' OR MigracionAbon.ind_traspaso = 'HIP' THEN
                                                        i := i + 1;
                            nsNumabonado(i)       := MigracionAbon.num_abonado;
                            nsNumabonadoAnt(i)    := MigracionAbon.num_abonadoant;
                            dsFecModifica(i)      := MigracionAbon.fec_modifica;
                            vsIndTraspaso(i)      := MigracionAbon.ind_traspaso;
                            vsDesIndTraspaso(i)   := MigracionAbon.des_valor;
                            vsCodPlantarifOrig(i) := MigracionAbon.cod_plantarif_orig;
                            vsDesPlanTarifOrig(i) := MigracionAbon.des_plantarif;
                            vsCodPlanTarifDest(i) := MigracionAbon.cod_plantarif_dest;
                                                        vsDesPlanTarifDest(i) := MigracionAbon.des_plantarif_dest;
                            nsCodVendedor(i)      := MigracionAbon.cod_vendedor;
                            vsNomVendedor(i)      := MigracionAbon.nom_vendedor;
                            vsNumTerminal(i)      := MigracionAbon.num_terminal;
                                                        nsCodCuenta(i)        := MigracionAbon.cod_cuentanue;
                                                END IF;

                                                IF MigracionAbon.num_abonado <> MigracionAbon.num_abonadoant THEN
                                                    nNumAbonadoAnt := MigracionAbon.num_abonadoant;
                                                    ValorProceso := TRUE;
                                                        EXIT;
                                                END IF;
                                        ELSE
                                            ValorProceso := FALSE;
                                            EXIT;
                                END IF;
                        END LOOP;
                        END LOOP;


                END;
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

END Gc_Contactos_Pg;
/
SHOW ERRORS
