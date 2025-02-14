CREATE OR REPLACE PROCEDURE Pv_Pr_Avisiniestro(
        nNUM_ABONADO            IN NUMBER,      -- Número de Abonado
        nNUM_OOSS               IN NUMBER,      -- Número de OOSS
        vACTUACION              IN VARCHAR2,    -- Código de Actuación
        vCOD_CAUSUSP            IN VARCHAR2,    -- Código de causa de siniestro
        vNOM_USUARORA           IN VARCHAR2,    -- Usuario Responsable
        vOBS_DETALLE            IN VARCHAR2,    -- Observación del Siniestro
        vTIP_TERMINAL           IN VARCHAR2,    -- Tipo de terminal siniestrado (SIMCARD, EQUIPO)
        vTIP_SUSP_AVSINIE       IN VARCHAR2,    -- Tipo Suspensión siniestro (1:con suspensión, 0:sin suspensión)
        nCOD_ERROR             OUT NUMBER,      -- Código de Error
        sMEN_ERROR             OUT VARCHAR2     -- Mensaje de Error
)
IS

--Pv_Pr_Avisiniestro v1.0 // ahott 27-09-2003 CH-220920031330
--Pv_Pr_Avisiniestro v1.1 //AHOTT 12-01-2004 CH-200412011615
--Pv_Pr_Avisiniestro v1.2 // Inicio modificacion by SAQL/Soporte 23/02/2006 - RA-200602070724
--Pv_Pr_Avisiniestro v1.3 // INI TMC|37441|06/02/2007|EFR
--Pv_Pr_Avisiniestro v1.4 //COL-41030|05-06-2007|PCR
--Pv_Pr_Avisiniestro v1.5 //COL-70900|20-11-2008|AVC

        nNumError               NUMBER (2);   -- número de error
        sMsgError               VARCHAR(70);  -- mensaje de error
        bCargoBasico            BOOLEAN;      -- flag para conocer si se procedera a cambiar cargo basico
        LN_CANT_SUSPREHABO            NUMBER (2);
        vCodCliente             GA_ABOCEL.COD_CLIENTE%TYPE;
        vNumCelular             GA_ABOCEL.NUM_CELULAR%TYPE;
        vCodPlantarif           GA_ABOCEL.COD_PLANTARIF%TYPE;
        vCodCargoBasico         GA_ABOCEL.COD_CARGOBASICO%TYPE;
        vTipPlantarif           GA_ABOCEL.TIP_PLANTARIF%TYPE;
        vCodTipContrato         GA_ABOCEL.COD_TIPCONTRATO%TYPE;
        vIndEqPrestado          GA_ABOCEL.IND_EQPRESTADO%TYPE;
        vCargoBasicoNuevo       GA_ABOCEL.COD_CARGOBASICO%TYPE;
        vCodCiclo               GA_ABOCEL.COD_CICLO%TYPE;
        vCargoBasicoReha        GA_ABOCEL.COD_CARGOBASICO%TYPE;
        vUsoAmistar             GA_ABOCEL.COD_USO%TYPE;
        vNumSerie               GA_ABOCEL.NUM_SERIE%TYPE;
                vNumSerie2              GA_ABOCEL.NUM_SERIE%TYPE; -- ahott 27-09-2003 CH-220920031330
        vCodProducto            GA_ABOCEL.COD_PRODUCTO%TYPE;
        vUso                    GA_ABOCEL.COD_USO%TYPE;
        vNumSerieMec            GA_ABOCEL.NUM_SERIEMEC%TYPE;
        vCodOperador            TA_DATOSGENER.COD_OPERADOR%TYPE;
        nNumSiniestro           GA_SINIESTROS.NUM_SINIESTRO%TYPE;
        nNumPeticion            GA_SUSPREHABO.NUM_PETICION%TYPE;
        vCodPlantarifNue        GA_FINCICLO.COD_PLANTARIF%TYPE;
        vCodSusPreha            GA_CAUSUSP.COD_SUSPREHA%TYPE;
                v_codsusp               GA_CAUSINIE.COD_CAUSUSP%TYPE;
        vImpCargo_Abonado       TA_CARGOSBASICO.IMP_CARGOBASICO%TYPE;
        vImpCargo_Causa         TA_CARGOSBASICO.IMP_CARGOBASICO%TYPE;
        vFecSys                 DATE;
        vNumImei                GA_ABOCEL.NUM_IMEI%TYPE;
        vValParametro           GED_PARAMETROS.VAL_PARAMETRO%TYPE;
        vValParametro2          GED_PARAMETROS.VAL_PARAMETRO%TYPE;
        LV_COD_CAUSA_EIR        GA_LISTACAUSAEIR_TD.COD_CAUSA%TYPE;
        LV_COD_OS               PV_IORSERV.COD_OS%TYPE;
        VTIP_SUSP            GA_SUSPREHABO.TIP_SUSP%TYPE;


        SCOD_TECNOLOGIA         VARCHAR2(7);
                SSCOD_TECNOLOGIA        VARCHAR2(7);
                sNomTablaAbo                    VARCHAR2(20); --AHOTT 12-01-2004 CH-200412011615

        ERROR_PROCESO EXCEPTION;


        sNOM_TABLA       GA_ERRORES.NOM_TABLA%TYPE;
        sNOM_PROC        GA_ERRORES.NOM_PROC%TYPE;
        sCOD_ACT         GA_ERRORES.COD_ACT%TYPE;
--        sCOD_SQLCODE     GA_ERRORES.COD_SQLCODE%TYPE;
        sCOD_SQLCODE     VARCHAR2(30);
--        sCOD_SQLERRM     GA_ERRORES.COD_SQLERRM%TYPE;
                sCOD_SQLERRM    VARCHAR2(200);
        sERROR           VARCHAR2(2);
        nContador        NUMBER(1);
                vCarBas_Intarcel GA_INTARCEL.COD_CARGOBASICO%TYPE; -- Ahott 02-12-2003 CH-261120031532

                PARAMETRO VARCHAR2(1); -- p-col-06054 y.o.
                cod_causa_pl varchar(2); -- p-col-06054 y.o.
                TRANSAC GA_TRANSACABO.NUM_TRANSACCION%TYPE := 0;-- p-col-06054 y.o.
                ERROR_QUERY EXCEPTION; -- p-col-06054 y.o.
                SERIE GA_ABOCEL.NUM_SERIE%TYPE;  -- p-col-06054 y.o.
                dato_causa number; -- p-col-06054 y.o.
                LV_simcard  ged_parametros.VAL_PARAMETRO%TYPE;


BEGIN

                 -- Inicialización de Variables
         nNumError:=0;
         sMsgError:='Inicio Operacion';

         SELECT  COD_OS
         INTO    LV_COD_OS
         FROM PV_IORSERV
         WHERE NUM_OS =nNUM_OOSS;

         bCargoBasico:=TRUE;
         -- Inicio modificacion by SAQL/Soporte 23/02/2006 - RA-200602070724
         -- vFecSys:=SYSDATE;
         select a.FECHA_ING INTO vFecSys
         from pv_iorserv a, pv_camcom b
         where a.num_os = nNUM_OOSS
         and a.num_os = b.num_os
         and b.num_abonado = nNUM_ABONADO;
         -- Fin modificacion by SAQL/Soporte 23/02/2006 - RA-200602070724
         sNOM_PROC:='PV_PR_AVISINIESTRO';

         BEGIN
                  BEGIN
                           -- Selección de Datos del Abonado Suspendido
                           nNumError := 1;
                           sMsgError := 'Error, al seleccionar desde GA_ABOCEL';
                           sNOM_TABLA:='GA_ABOCEL';
                           sCOD_ACT:='S';

                           SELECT COD_CLIENTE,NUM_CELULAR,COD_PLANTARIF,COD_CARGOBASICO,TIP_PLANTARIF,COD_CICLO,
                                  COD_TIPCONTRATO,IND_EQPRESTADO,COD_USO,NUM_SERIE,COD_PRODUCTO,NUM_SERIEMEC, NUM_IMEI,
                                  COD_TECNOLOGIA
                           INTO vCodCliente,vNumCelular,vCodPlantarif,vCodCargoBasico,vTipPlantarif,vCodCiclo,
                                  vCodTipContrato,vIndEqPrestado,vUso,vNumSerie,vCodProducto,vNumSerieMec, vNumImei,
                                  SCOD_TECNOLOGIA
                           FROM GA_ABOCEL
                           WHERE NUM_ABONADO =nNUM_ABONADO;
                                                   sNomTablaAbo:='GA_ABOCEL' ; --AHOTT 12-01-2004 CH-200412011615

                           EXCEPTION
                                        WHEN NO_DATA_FOUND THEN
                                        BEGIN
                                        -- Selección de Datos del Abonado Suspendido
                                                nNumError := 1;
                                                sMsgError := 'Error, al seleccionar desde GA_ABOAMIST';
                                                sNOM_TABLA:='GA_ABOAMIST';
                                                sCOD_ACT:='S';

                                        SELECT COD_CLIENTE,NUM_CELULAR,COD_PLANTARIF,COD_CARGOBASICO,TIP_PLANTARIF,COD_CICLO,
                                        COD_TIPCONTRATO,'0',COD_USO,NUM_SERIE,COD_PRODUCTO,NUM_SERIEMEC, NUM_IMEI,
                                        COD_TECNOLOGIA
                                        INTO vCodCliente,vNumCelular,vCodPlantarif,vCodCargoBasico,vTipPlantarif,vCodCiclo,
                                                vCodTipContrato,vIndEqPrestado,vUso,vNumSerie,vCodProducto,vNumSerieMec, vNumImei,
                                                SCOD_TECNOLOGIA
                                        FROM GA_ABOAMIST
                                        WHERE NUM_ABONADO =nNUM_ABONADO;
                                                                                sNomTablaAbo:='GA_ABOAMIST'; --AHOTT 12-01-2004 CH-200412011615

                                                EXCEPTION
                                                                 WHEN OTHERS THEN
                                                                          RAISE ERROR_PROCESO;
                                END;
                  END;


                  --Selección tipo de terminal equipo
                  nNumError := 17;
                  sMsgError := 'Error, al seleccionar desde GED_PARAMETROS';
                  sNOM_TABLA:='GED_PARAMETROS';
                  sCOD_ACT:='S';

                  SELECT val_parametro
                  into vValParametro
                  FROM ged_parametros
                  WHERE nom_parametro='COD_TERMINAL_GSM'
                  AND cod_modulo='AL'
                  AND cod_producto=1;

                  IF vTIP_TERMINAL= vValParametro THEN
                         vNumSerie := vNumImei;
                  END IF;

                  --Selección tipo de Simcard -
                  nNumError := 31;
                  sMsgError := 'Error, al seleccionar desde GED_PARAMETROS';
                  sNOM_TABLA:='GED_PARAMETROS';
                  sCOD_ACT:='S';

                                  SELECT val_parametro
                                  into LV_simcard
                  FROM ged_parametros
                  WHERE nom_parametro='COD_SIMCARD_GSM'
                  AND cod_modulo='AL'
                  AND cod_producto=1;

                  -- Inicialización por si acaso, no posee cambios pensidnetes a ciclo
                  vCodPlantarifNue:=vCodPlantarif;


                  -- Selección Uso AMISTAR
          nNumError := 2;
                  sMsgError := 'Error, al seleccionar desde AL_DATOS_GENERALES';
                  sNOM_TABLA:='AL_DATOS_GENERALES';
                  sCOD_ACT:='S';

                  SELECT COD_USO_AMI
                  INTO vUsoAmistar
                  FROM AL_DATOS_GENERALES;


                  -- Selección Codigo de Operador
          nNumError := 3;
                  sMsgError := 'Error, al seleccionar desde TA_DATOSGENER';
                  sNOM_TABLA:='TA_DATOSGENER';
                  sCOD_ACT:='S';

                  SELECT COD_OPERADOR
                  INTO  vCodOperador
                  FROM TA_DATOSGENER;

                  EXCEPTION
                         WHEN NO_DATA_FOUND THEN
                                 RAISE ERROR_PROCESO;
         END;

        --Se ingresa a este if solo si el aviso de siniestro indica suspensisn
        IF (vTIP_SUSP_AVSINIE='1') or (vTIP_SUSP_AVSINIE='2') THEN
           BEGIN
                 nNumError := 4;
                 sMsgError := 'Error al ingresar datos en GA_MODABOCEL';
                 sNOM_TABLA:='GA_MODABOCEL';
                 sCOD_ACT:='I';

                                 if sNomTablaAbo='GA_ABOCEL' then --ahott 12-01-2004

                                         --Inicio ahott CH-261120031532 02-12-2003
                                         BEGIN
                                                 SELECT COD_CARGOBASICO
                                                 INTO vCarBas_Intarcel
                                                 FROM ga_intarcel WHERE
                                                 COD_CLIENTE=vCodCliente AND NUM_ABONADO=nNUM_ABONADO
                                                 AND FEC_HASTA=(SELECT MAX(FEC_HASTA) FROM GA_INTARCEL
                                                 WHERE COD_CLIENTE=vCodCliente AND NUM_ABONADO=nNUM_ABONADO);

                                                 EXCEPTION
                                WHEN NO_DATA_FOUND THEN
                                                        vCarBas_Intarcel := '';

                                                 IF vCodCargoBasico <> vCarBas_Intarcel THEN
                                                           vCodCargoBasico := vCarBas_Intarcel;
                                                 END IF;

                                         END;
                                         --Fin ahott CH-261120031532 02-12-2003

                                 end if; --ahott 12-01-2004 CH-200412011615

-- Ini CO-200606150196 Esteban Fuenzalida 14/07/2006 .-
--                 INSERT INTO GA_MODABOCEL(NUM_ABONADO, COD_TIPMODI, FEC_MODIFICA, NUM_CELULAR,
--                 TIP_PLANTARIF, COD_PLANTARIF,COD_CARGOBASICO,COD_CICLO,COD_TIPCONTRATO,
--                 IND_EQPRESTADO,NOM_USUARORA,NUM_OS)
--                 VALUES(nNUM_ABONADO, vACTUACION, vFecSys, vNumCelular,vTipPlantarif,
--                 vCodPlantarif,vCodCargoBasico,vCodCiclo,vCodTipContrato,vIndEqPrestado,
--                vNOM_USUARORA,nNUM_OOSS);
                      BEGIN
                         SELECT NUM_CELULAR INTO vNumCelular
                         FROM GA_MODABOCEL
                         WHERE NUM_ABONADO = nNUM_ABONADO
                         AND NUM_CELULAR = vNumCelular
                         AND FEC_MODIFICA = vFecSys;

                         IF vNumCelular is not null THEN

                            UPDATE PV_IORSERV SET
                            FECHA_ING = vFecSys+1/86400
                            WHERE NUM_OS = nNUM_OOSS;

                            vFecSys:=vFecSys+1/86400;

                            INSERT INTO GA_MODABOCEL (
                               NUM_ABONADO, COD_TIPMODI, FEC_MODIFICA, NUM_CELULAR,
                               TIP_PLANTARIF, COD_PLANTARIF, COD_CARGOBASICO,
                               COD_CICLO, COD_TIPCONTRATO, IND_EQPRESTADO, NOM_USUARORA, NUM_OS
                            ) VALUES (
                               nNUM_ABONADO, vACTUACION, vFecSys, vNumCelular,
                               vTipPlantarif, vCodPlantarif, vCodCargoBasico,
                               vCodCiclo, vCodTipContrato, vIndEqPrestado, vNOM_USUARORA, nNUM_OOSS);

                         END IF;
                      EXCEPTION
                         WHEN NO_DATA_FOUND THEN
                            INSERT INTO GA_MODABOCEL (
                               NUM_ABONADO, COD_TIPMODI, FEC_MODIFICA, NUM_CELULAR,
                               TIP_PLANTARIF, COD_PLANTARIF, COD_CARGOBASICO,
                               COD_CICLO, COD_TIPCONTRATO, IND_EQPRESTADO, NOM_USUARORA, NUM_OS
                            ) VALUES (
                               nNUM_ABONADO, vACTUACION, vFecSys, vNumCelular,
                               vTipPlantarif, vCodPlantarif, vCodCargoBasico,
                               vCodCiclo, vCodTipContrato, vIndEqPrestado, vNOM_USUARORA, nNUM_OOSS);
                      END;
-- Fin CO-200606150196 Esteban Fuenzalida 14/07/2006 .-

                 EXCEPTION
                        WHEN NO_DATA_FOUND THEN
                                 RAISE ERROR_PROCESO;


                 WHEN DUP_VAL_ON_INDEX THEN
                                                  vFecSys:=vFecSys+1/86400;
                                                  INSERT INTO GA_MODABOCEL (
                               NUM_ABONADO, COD_TIPMODI, FEC_MODIFICA, NUM_CELULAR,
                               TIP_PLANTARIF, COD_PLANTARIF, COD_CARGOBASICO,
                               COD_CICLO, COD_TIPCONTRATO, IND_EQPRESTADO, NOM_USUARORA, NUM_OS
                            ) VALUES (
                               nNUM_ABONADO, vACTUACION, vFecSys, vNumCelular,
                               vTipPlantarif, vCodPlantarif, vCodCargoBasico,
                               vCodCiclo, vCodTipContrato, vIndEqPrestado, vNOM_USUARORA, nNUM_OOSS);

           END;


           -- Validación de Uso Linea
           IF vUso=vUsoAmistar THEN
                        bCargoBasico:=FALSE;
           END IF;


           -- Validación de Cambio de CargoBasico
           IF vTipPlantarif='E' THEN
                        bCargoBasico:=FALSE;
           END IF;


           BEGIN
                  -- Selección de  Importe del Cargo Basico Actual del Abonado
                  nNumError := 5;
                  sMsgError := 'Error, al seleccionar Importe del Abonado';
                  sNOM_TABLA:='TA_CARGOBASICO';
                  sCOD_ACT:='S';

                  SELECT IMP_CARGOBASICO
                  INTO   vImpCargo_Abonado
                  FROM   TA_CARGOSBASICO
                  WHERE  COD_PRODUCTO=vCodProducto
                  AND    SYSDATE BETWEEN fec_desde AND fec_hasta--COL-36518|02-01-2007|GEZ
                                  AND    COD_CARGOBASICO=vCodCargoBasico;

                  EXCEPTION
                     WHEN NO_DATA_FOUND THEN
                                 RAISE ERROR_PROCESO;
                END;


            BEGIN
                   -- Selección de  Importe del Cargo Basico de Causa de Suspensión
               nNumError := 7;
                   sMsgError := 'Error, al seleccionar Importe de Causa de Suspension';
                   sNOM_TABLA:='TA_CARGOBASICO';
                   sCOD_ACT:='S';

                   SELECT A.IMP_CARGOBASICO,A.COD_CARGOBASICO
                   INTO vImpCargo_Causa,vCargoBasicoNuevo
                   FROM GA_CAUSINIE B, TA_CARGOSBASICO A
                   WHERE B.COD_CARGOBASICO = A.COD_CARGOBASICO
                   AND B.COD_PRODUCTO = vCodProducto
                   AND B.COD_CAUSA = vCOD_CAUSUSP;


                   -- Comparación de Importes de Cargos Básicos
                   IF   vImpCargo_Abonado < vImpCargo_Causa THEN
                                bCargoBasico:=FALSE;
                   END IF;

                   EXCEPTION
                                WHEN NO_DATA_FOUND THEN
                                         bCargoBasico:=FALSE;
                END;


                -- Ejecución de Cargo Básico
                IF bCargoBasico THEN

                   nNumError := 8;
                   sMsgError := 'Error, al ejecutar proceso P_CARGO_BASICO';
                   sNOM_PROC:='P_CARGO_BASICO';
                   sNOM_TABLA:='';
                   sCOD_ACT:='E';
                   sCOD_SQLCODE:='';
                   sCOD_SQLERRM:='';
                   sERROR:='0';
                   vFecSys:=SYSDATE;

                   P_Cargo_Basico(1,vCodCliente,nNUM_ABONADO,vCargoBasicoNuevo,vCodCiclo,vFecSys,'S',
                   sNOM_PROC,sNOM_TABLA,sCOD_ACT,sCOD_SQLCODE,sCOD_SQLERRM,sERROR);

                   IF sERROR <> '0' THEN
                          RAISE ERROR_PROCESO;
                   END IF;

                                --homologación
                                ELSE
                                   vCargoBasicoNuevo:='';
                END IF;

                -- Actualización de GA_ABOCEL, situación
                sNOM_PROC:='PV_PR_AVISINIESTRO';


            IF  vUso=vUsoAmistar THEN
                        BEGIN
                                 nNumError := 9;
                                 sMsgError := 'Error, al actualizar GA_ABOCEL';
                                 sNOM_TABLA:='GA_ABOAMIST';
                                 sCOD_ACT:='U';

                                 UPDATE GA_ABOAMIST
                                        SET COD_SITUACION='STP',
                                                FEC_ULTMOD=SYSDATE
                                 WHERE NUM_ABONADO=nNUM_ABONADO;

                                 EXCEPTION
                                        WHEN OTHERS THEN
                                                 RAISE ERROR_PROCESO;
                        END;
                ELSE
                        BEGIN
                                 nNumError := 10;
                                 sMsgError := 'Error, al actualizar GA_ABOCEL';
                                 sNOM_TABLA:='GA_ABOCEL';
                                 sCOD_ACT:='U';

                                 UPDATE GA_ABOCEL
                                        SET COD_SITUACION='STP',
                                                FEC_ULTMOD=SYSDATE
                                 WHERE NUM_ABONADO=nNUM_ABONADO;

                                 EXCEPTION
                                        WHEN OTHERS THEN
                                                 RAISE ERROR_PROCESO;
                        END;
                END IF;


                -- Ingreso de Siniestro
                BEGIN
                        nNumError := 10;
                        sMsgError := 'Error, al Seleccionar Cargo a Ciclo Pendiente';
                        sNOM_TABLA:='GA_FINCICLO';
                        sCOD_ACT:='S';

                        SELECT B.COD_CARGOBASICO,A.COD_PLANTARIF
                        INTO vCargoBasicoReha,vCodPlantarifNue
                        FROM GA_FINCICLO A, TA_PLANTARIF B
                        WHERE A.COD_PRODUCTO=B.COD_PRODUCTO
                        AND A.COD_PLANTARIF=B.COD_PLANTARIF
                        AND A.NUM_ABONADO=nNUM_ABONADO;

                        EXCEPTION
                                WHEN NO_DATA_FOUND THEN
                                        NULL;

                                        vCargoBasicoReha:=vCodCargoBasico;
                                        vCodPlantarifNue:=vCodPlantarif;
                END;
        -- Inicio modificacion by SAQL/Soporte 01/03/2006 - RA-200602070724
        ELSE
           BEGIN
              nNumError := 4;
              sMsgError := 'Error al ingresar datos en GA_MODABOCEL';
              sNOM_TABLA:='GA_MODABOCEL';
              sCOD_ACT:='I';
              if sNomTablaAbo='GA_ABOCEL' then
                 BEGIN
                    SELECT COD_CARGOBASICO  INTO vCarBas_Intarcel
                    FROM ga_intarcel
                    WHERE  COD_CLIENTE=vCodCliente
                    AND NUM_ABONADO=nNUM_ABONADO
                    AND FEC_HASTA=(
                       SELECT MAX(FEC_HASTA)
                       FROM GA_INTARCEL
                       WHERE COD_CLIENTE=vCodCliente
                       AND NUM_ABONADO=nNUM_ABONADO);
                 EXCEPTION
                    WHEN NO_DATA_FOUND THEN
                       vCarBas_Intarcel := '';
                       IF vCodCargoBasico <> vCarBas_Intarcel THEN
                          vCodCargoBasico := vCarBas_Intarcel;
                       END IF;
                 END;
              end if;
              BEGIN
                 SELECT NUM_CELULAR INTO vNumCelular
                 FROM GA_MODABOCEL
                 WHERE NUM_ABONADO = nNUM_ABONADO
                 AND NUM_CELULAR = vNumCelular
                 AND FEC_MODIFICA = vFecSys;
                 IF vNumCelular is not null THEN
                    UPDATE PV_IORSERV SET
                    FECHA_ING = vFecSys+1/86400
                    WHERE NUM_OS = nNUM_OOSS;
                    vFecSys:=vFecSys+1/86400;
                    INSERT INTO GA_MODABOCEL (
                       NUM_ABONADO, COD_TIPMODI, FEC_MODIFICA, NUM_CELULAR,
                       TIP_PLANTARIF, COD_PLANTARIF, COD_CARGOBASICO,
                       COD_CICLO, COD_TIPCONTRATO, IND_EQPRESTADO, NOM_USUARORA, NUM_OS
                    ) VALUES (
                       nNUM_ABONADO, vACTUACION, vFecSys, vNumCelular,
                       vTipPlantarif, vCodPlantarif, vCodCargoBasico,
                       vCodCiclo, vCodTipContrato, vIndEqPrestado, vNOM_USUARORA, nNUM_OOSS);
                 END IF;
              EXCEPTION
                 WHEN NO_DATA_FOUND THEN
                    INSERT INTO GA_MODABOCEL (
                       NUM_ABONADO, COD_TIPMODI, FEC_MODIFICA, NUM_CELULAR,
                       TIP_PLANTARIF, COD_PLANTARIF, COD_CARGOBASICO,
                       COD_CICLO, COD_TIPCONTRATO, IND_EQPRESTADO, NOM_USUARORA, NUM_OS
                    ) VALUES (
                       nNUM_ABONADO, vACTUACION, vFecSys, vNumCelular,
                       vTipPlantarif, vCodPlantarif, vCodCargoBasico,
                       vCodCiclo, vCodTipContrato, vIndEqPrestado, vNOM_USUARORA, nNUM_OOSS);
              END;
           EXCEPTION
              WHEN NO_DATA_FOUND THEN
                 RAISE ERROR_PROCESO;
           END;
           -- Fin modificacion by SAQL/Soporte 01/03/2006 - RA-200602070724
        END IF;

        -- Ingresar Siniestro
        BEGIN
                nNumError := 6;
                sMsgError := 'Error, al seleccionar Servicio de Siniestro';
                sNOM_TABLA:='TA_CARGOBASICO';
                sCOD_ACT:='S';

                /* OCB-INI[2003-04-17] */

                SELECT B.COD_CAUSUSP
                INTO v_codsusp
                FROM GA_CAUSINIE B
                WHERE  B.COD_PRODUCTO = vCodProducto
                AND B.COD_CAUSA = vCOD_CAUSUSP;

                SELECT VAL_PARAMETRO INTO SSCOD_TECNOLOGIA
                FROM GED_PARAMETROS
                WHERE NOM_PARAMETRO = 'TECNOLOGIA_TDMA' AND COD_MODULO = 'GA' AND COD_PRODUCTO = 1;

--              Modificación por integración sixbell
/*              IF SCOD_TECNOLOGIA = SSCOD_TECNOLOGIA  THEN

                        SELECT VAL_PARAMETRO INTO vCodSusPreha FROM GED_PARAMETROS
                        WHERE NOM_PARAMETRO = 'COD_SERVAVSINIE' AND COD_MODULO = 'GA' AND COD_PRODUCTO = 1;

                ELSE

                        SELECT VAL_PARAMETRO INTO vCodSusPreha FROM GED_PARAMETROS
                        WHERE NOM_PARAMETRO = 'COD_SERVAVSINIE_GSM' AND COD_MODULO = 'GA' AND COD_PRODUCTO = 1;

                END IF; */

                nNumError := 22;
                sMsgError := 'Error al seleccionar código suspensión.';
                sNOM_TABLA:= 'PV_SERV_SUSPREHA_TO';
                sCOD_ACT := 'S';

                SELECT A.COD_SERVICIO INTO vCodSusPreha FROM PV_SERV_SUSPREHA_TO A
                WHERE A.COD_PRODUCTO = vCodProducto
                AND A.COD_MODULO = 'GA'
                AND EXISTS (SELECT B.COD_TIPLAN FROM TA_PLANTARIF B
                            WHERE B.COD_PRODUCTO  = vCodProducto
                            AND   B.COD_PLANTARIF = vCodPlantarif
                            AND   A.COD_TIPLAN = B.COD_TIPLAN)
                AND A.COD_TECNOLOGIA = SCOD_TECNOLOGIA
                AND COD_ACTABO = vACTUACION;

                /* OCB-FIN[2003-04-17] */

                nNumError := 11;
                sMsgError := 'Error, seleccionar Secuencia GA_SEQ_SINIESTROS';
                sNOM_TABLA:='GA_SEQ_SINIESTROS';
                sCOD_ACT:='S';

            SELECT GA_SEQ_SINIESTROS.NEXTVAL
            INTO nNumSiniestro
            FROM DUAL;


                nNumError := 12;
                sMsgError := 'Error, ingresar GA_SINIESTROS';
                sNOM_TABLA:='GA_SINIESTROS';
                sCOD_ACT:='I';

                INSERT INTO GA_SINIESTROS
                (NUM_SINIESTRO, NUM_ABONADO, NUM_TERMINAL, NUM_SERIE, FEC_SINIESTRO,
                COD_PRODUCTO, COD_SERVICIO, COD_CAUSA, COD_CARGOBASICO, COD_ESTADO, TIP_TERMINAL, IND_SUSP)
                VALUES(nNumSiniestro,nNUM_ABONADO,vNumCelular,vNumSerie,vFecSys,vCodProducto,
                vCodSusPreha,vCOD_CAUSUSP,vCargoBasicoNuevo,'AV', vTIP_TERMINAL, vTIP_SUSP_AVSINIE);


                nNumError := 13;
                sMsgError := 'Error, ingresar GA_DET_SINIE';
                sNOM_TABLA:='GA_DET_SINIE';
                sCOD_ACT:='I';

                INSERT INTO GA_DETSINIE (NUM_SINIESTRO, COD_ESTADO, FEC_DETALLE, NOM_USUARORA, OBS_DETALLE)
                VALUES(nNumSiniestro,'AV',vFecSys,vNOM_USUARORA,vOBS_DETALLE);


                IF vTIP_TERMINAL <> LV_simcard THEN
                        -- ini p-col-06054 y.o.

                        BEGIN


                                nNumError := 14;
                                sMsgError := 'Error, ingresar GA_LNCELU';
                                sNOM_TABLA:='GA_LNCELU';

                                IF vNumSerie IS NOT NULL AND vCodOperador IS NOT NULL THEN

                                                        INSERT INTO GA_LNCELU (NUM_SERIE, IND_PROCEQUI, NUM_SERIEMEC, COD_OPERADOR,NUM_CELULAR,
                                                             NUM_ABONADO, COD_CLIENTE, FEC_ALTA, COD_FABRICANTE,COD_ARTICULO)
                                                        SELECT vNumSerie,A.IND_PROCEQUI,vNumSerieMec,vCodOperador,vNumCelular,nNUM_ABONADO,
                                                             vCodCliente,vFecSys,C.COD_FABRICANTE,A.COD_ARTICULO
                                                        FROM GA_EQUIPABOSER A, AL_ARTICULOS C
                                                        WHERE NUM_ABONADO = nNUM_ABONADO
                                                        AND NUM_SERIE = vNumSerie
                                                        AND FEC_ALTA =(SELECT MAX(FEC_ALTA)
                                                                  FROM GA_EQUIPABOSER B
                                                                  WHERE A.NUM_ABONADO=B.NUM_ABONADO
                                                                  AND A.NUM_SERIE=B.NUM_SERIE)
                                                                  AND A.COD_ARTICULO=C.COD_ARTICULO;

                                                        SELECt COD_CAUSA
                                        INTO LV_COD_CAUSA_EIR
                                         FROM GA_LISTACAUSAEIR_TD
                                        WHERE COD_TIPOLISTA='B'
                                        AND COD_OS = LV_COD_OS
                                        AND IND_CAUSA= 1
                                        AND SYSDATE BETWEEN FEC_DESDE AND FEC_HASTA;

                                        INSERT INTO GA_CAUSAEIR_TO (NUM_SERIE,COD_CAUSA,COD_TIPOLISTA,
                                                                    COD_OS,FEC_ING,NOM_USUARIO,ORIG_TRANS,COD_CAUSA_OS)
                                        SELECT vNumSerie,LV_COD_CAUSA_EIR,'B',LV_COD_OS,vFecSys,vNOM_USUARORA,'1',vCOD_CAUSUSP
                            FROM GA_EQUIPABOSER A, AL_ARTICULOS C
                                                        WHERE NUM_ABONADO = nNUM_ABONADO
                                                        AND NUM_SERIE = vNumSerie
                                                        AND FEC_ALTA =(SELECT MAX(FEC_ALTA)
                                                                  FROM GA_EQUIPABOSER B
                                                                  WHERE A.NUM_ABONADO=B.NUM_ABONADO
                                                                  AND A.NUM_SERIE=B.NUM_SERIE)
                                                                  AND A.COD_ARTICULO=C.COD_ARTICULO;




                                ELSE
                                                        nNumError := 30;
                                                        sMsgError := 'Error, OPERADOR NULL ';
                                                        sNOM_TABLA:='GA_LNCELU';
                                                        sCOD_ACT:='I';

                                                        RAISE ERROR_PROCESO;

                                END IF;



                        EXCEPTION
                                    WHEN DUP_VAL_ON_INDEX THEN
                                         NULL;


                        END;
                        END IF;
                        -- fin p-col-06054 y.o.

                nNumError := 18;
                sMsgError := 'Error, al seleccionar desde GED_PARAMETROS';
                sNOM_TABLA:='GED_PARAMETROS';
                sCOD_ACT:='S';

                SELECT val_parametro
                into vValParametro2
                FROM ged_parametros
                WHERE nom_parametro='COD_SIMCARD_GSM'
                AND cod_modulo='AL'
                AND cod_producto=1;

                nNumError := 19;
                sMsgError := 'Error, al seleccionar desde GA_SINIESTROS';
                sNOM_TABLA:='GA_SINIESTROS';
                sCOD_ACT:='S';

/* INI TMC|37441|06/02/2007|EFR

                SELECT COUNT(*)
                INTO nContador
                FROM GA_SINIESTROS
                WHERE NUM_ABONADO = nNUM_ABONADO;

                IF nContador = 2 THEN
                        nNumError := 20;
                        sMsgError := 'Error, Actualizando GA_SINIESTROS';
                        sNOM_TABLA:='GA_SINIESTROS';
                        sCOD_ACT:='U';

                        UPDATE GA_SINIESTROS SET IND_SUSP = 0
                        WHERE TIP_TERMINAL = vValParametro and NUM_ABONADO = nNUM_ABONADO;

                        nNumError := 21;
                        sMsgError := 'Error, Actualizando GA_SINIESTROS';
                        sNOM_TABLA:='GA_SINIESTROS';
                        sCOD_ACT:='U';

                        UPDATE GA_SINIESTROS SET IND_SUSP = 1
                        WHERE TIP_TERMINAL = vValParametro2 and NUM_ABONADO = nNUM_ABONADO;
                END IF;

FIN TMC|37441|06/02/2007|EFR */
                EXCEPTION
                        WHEN OTHERS THEN
                                 RAISE ERROR_PROCESO;
        END;


    IF vTIP_SUSP_AVSINIE='1' THEN
      VTIP_SUSP:='T';
    end if;


    IF vTIP_SUSP_AVSINIE='2' THEN
      VTIP_SUSP:='P';
    end if;


        --Se ingresa a este if solo si el aviso de siniestro indica suspensión
        IF vTIP_SUSP_AVSINIE='1' or vTIP_SUSP_AVSINIE='2' THEN
                BEGIN
                        nNumError := 15;
                        sMsgError := 'Error, seleccionar Secuencia GA_SEQ_PETSR';
                        sNOM_TABLA:='GA_SEQ_PETSR';
                        sCOD_ACT:='S';

                        SELECT GA_SEQ_PETSR.NEXTVAL
                        INTO nNumPeticion
                        FROM DUAL;


                        nNumError := 16;
                        sMsgError := 'Error, al ingresar en GA_susprehabo';
                        sNOM_TABLA:='GA_SUSPREHABO';
                        sCOD_ACT:='I';
                        LN_CANT_SUSPREHABO:= 0;
                        SELECT COUNT(1)
                        INTO LN_CANT_SUSPREHABO
                         FROM GA_SUSPREHABO
                        WHERE NUM_ABONADO =nNUM_ABONADO
                          AND COD_MODULO = 'GA'
                          AND COD_SERVICIO = vCodSusPreha
                          AND TIP_REGISTRO = 1;

                        IF LN_CANT_SUSPREHABO= 0 THEN


                        INSERT INTO GA_SUSPREHABO (NUM_ABONADO, COD_SERVICIO, FEC_SUSPBD, COD_SERVSUPL,
                        COD_NIVEL, COD_PRODUCTO, NUM_TERMINAL, NOM_USUARORA,COD_MODULO, TIP_REGISTRO,
                        COD_CAUSUSP, TIP_SUSP, COD_CARGOBASICO, IND_SINIESTRO, NUM_PETICION, COD_PLANNUE)
                        VALUES(nNUM_ABONADO,vCodSusPreha,SYSDATE,NULL,NULL,1,vNumCelular,vNOM_USUARORA,
                        'GA','1',v_codsusp ,VTIP_SUSP,vCargoBasicoNuevo,1,nNumPeticion,vCodPlantarifNue);


                        END IF;

                        EXCEPTION
                                WHEN OTHERS THEN
                                         RAISE ERROR_PROCESO;

                END;
        END IF;



        UPDATE PV_PARAM_ABOCEL
        SET COD_SERVICIO=vCodSusPreha
        WHERE NUM_OS  =nNUM_OOSS;





        nCOD_ERROR:=0;
        sMEN_ERROR:='Operacion Exitosa';

        EXCEPTION
                WHEN ERROR_PROCESO THEN
                          sCOD_SQLCODE:=substr(to_char(SQLCODE), 1, 15);
                          sCOD_SQLERRM:=SUBSTR(SQLERRM,1,60);

                          ROLLBACK;

                          INSERT INTO GA_ERRORES(COD_ACTABO,CODIGO,FEC_ERROR,COD_PRODUCTO,NOM_PROC,
                          NOM_TABLA,COD_ACT,COD_SQLCODE,COD_SQLERRM)
                          VALUES(vACTUACION,nNUM_ABONADO,SYSDATE,1,sNOM_PROC,sNOM_TABLA,sCOD_ACT,
                          sCOD_SQLCODE,sCOD_SQLERRM);

                          COMMIT;

                          nCOD_ERROR:=nNumError;
                          sMEN_ERROR:=sMsgError;
END;
/

