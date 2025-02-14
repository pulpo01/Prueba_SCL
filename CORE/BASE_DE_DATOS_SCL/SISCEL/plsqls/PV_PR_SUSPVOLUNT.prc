CREATE OR REPLACE PROCEDURE Pv_Pr_Suspvolunt(
    nNUM_ABONADO        IN NUMBER,              -- Número de Abonado
        nNUM_OOSS               IN NUMBER,      -- Número de OOSS
        vACTUACION              IN VARCHAR2,    -- Código de Actuación
        vCOD_CAUSUSP    IN VARCHAR2,    -- Código de causa de suspensión
        vCOD_SERVICIO   IN VARCHAR2,    -- Código servicio rehabilitacion
        vNOM_USUARORA   IN VARCHAR2,    -- Usuario Responsable
        nCOD_ERROR              OUT NOCOPY NUMBER,              -- Código de Error --XO-200509030583: German Espinoza Z; 16/09/2005
        sMEN_ERROR              OUT NOCOPY VARCHAR2     -- Mensaje de Error        --XO-200509030583: German Espinoza Z; 16/09/2005
)
IS
   /*

     Suspension Voluntaria de Servicio (version 1.0.0 2002-09-06)

   */
        nNumError               NUMBER (2);   -- número de error
        sMsgError               VARCHAR(60); -- mensaje de error
        bCargoBasico    BOOLEAN;


        vCodModulo              GA_CAUSUSP.COD_MODULO%TYPE;
        vCodCliente             GA_ABOCEL.COD_CLIENTE%TYPE;
        vNumCelular             GA_ABOCEL.NUM_CELULAR%TYPE;
        vCodPlantarif   GA_ABOCEL.COD_PLANTARIF%TYPE;
        vCodCargoBasico GA_ABOCEL.COD_CARGOBASICO%TYPE;
        vTipPlantarif   GA_ABOCEL.TIP_PLANTARIF%TYPE;
        vCodTipContrato         GA_ABOCEL.COD_TIPCONTRATO%TYPE;
        vIndEqPrestado          GA_ABOCEL.IND_EQPRESTADO%TYPE;
        vImpCargo_Abonado       TA_CARGOSBASICO.IMP_CARGOBASICO%TYPE;
        vImpCargo_Causa         TA_CARGOSBASICO.IMP_CARGOBASICO%TYPE;
        vCargoBasicoNuevo       GA_ABOCEL.COD_CARGOBASICO%TYPE;
        vFecSys                         DATE;
        vCodCiclo                       GA_ABOCEL.COD_CICLO%TYPE;
        vCargoBasicoReha        GA_ABOCEL.COD_CARGOBASICO%TYPE;
        nNumPeticion            GA_PETSR.NUM_PETICION%TYPE;
        vCodPlantarifNue        GA_FINCICLO.COD_PLANTARIF%TYPE;
        vCodSusPreha            GA_CAUSUSP.COD_SUSPREHA%TYPE;
        sIndListaNegra          GA_CAUSUSP.IND_LN%TYPE;
        vCodProducto            GA_ABOCEL.COD_PRODUCTO%TYPE;
        vNumSerie                       GA_ABOCEL.NUM_SERIE%TYPE;
        vNumSerieMec            GA_ABOCEL.NUM_SERIEMEC%TYPE;
        vCodOperador            TA_DATOSGENER.COD_OPERADOR%TYPE;
        vCarBas_Intarcel GA_INTARCEL.COD_CARGOBASICO%TYPE; -- Ahott 02-12-2003 CH-261120031532
        VCat_abonado    VARCHAR(2); --XO-200509030583: JJR; 25/09/2005
    LV_COD_CAUSA_EIR    GA_LISTACAUSAEIR_TD.COD_CAUSA%TYPE; 
    LV_COD_OS        PV_IORSERV.COD_OS%TYPE;    
        ERROR_PROCESO EXCEPTION;

        sNOM_TABLA       GA_ERRORES.NOM_TABLA%TYPE;
        sNOM_PROC        GA_ERRORES.NOM_PROC%TYPE;
        sCOD_ACT         GA_ERRORES.COD_ACT%TYPE;
        sCOD_SQLCODE GA_ERRORES.COD_SQLCODE%TYPE;
        sCOD_SQLERRM GA_ERRORES.COD_SQLERRM%TYPE;
        sERROR           VARCHAR2(2);
        LN_TIP_SUSPENSION     GA_CAUSUSP.TIP_SUSPENCION%TYPE;
        LV_TIP_SUSPENSION_AUX VARCHAR2(1);
        LV_GRP_PRESTACION     TA_PLANTARIF.GRP_PRESTACION%TYPE;

BEGIN

         -- Inicialización de Variables
         nNumError:=0;
         sMsgError:='Operacion Exitosa';
         bCargoBasico:=TRUE;
         vFecSys:=SYSDATE;
         sNOM_PROC:='GA_PR_SUSPVOLUNT';
         vCodModulo:='GA';
         vCodSusPreha:=vCOD_SERVICIO;

         BEGIN

                  -- Selección de Datos del Abonado Suspendido
          nNumError := 1;
                  sMsgError := 'Error, al seleccionar desde GA_ABOCEL o GA_ABOAMIST'; --XO-200509030583: German Espinoza Z; 16/09/2005
                  sNOM_TABLA:='GA_ABOCEL';
                  sCOD_ACT:='S';

                  SELECT COD_CLIENTE,NUM_CELULAR,COD_PLANTARIF,COD_CARGOBASICO,TIP_PLANTARIF,COD_CICLO,
                                 COD_TIPCONTRATO,IND_EQPRESTADO,COD_PRODUCTO,NUM_SERIE,NUM_SERIEMEC,'PO' --XO-200509030583: JJR; 25/09/2005
                  INTO vCodCliente,vNumCelular,vCodPlantarif,vCodCargoBasico,vTipPlantarif,vCodCiclo,
                           vCodTipContrato,vIndEqPrestado,vCodProducto,vNumSerie,vNumSerieMec,VCat_abonado --XO-200509030583: JJR; 25/09/2005
                  FROM GA_ABOCEL
                  WHERE NUM_ABONADO =nNUM_ABONADO
                  --XO-200509030583: German Espinoza Z; 16/09/2005
                  UNION
                  SELECT COD_CLIENTE,NUM_CELULAR,COD_PLANTARIF,COD_CARGOBASICO,TIP_PLANTARIF,COD_CICLO,
                                 COD_TIPCONTRATO,NULL,COD_PRODUCTO,NUM_SERIE,NUM_SERIEMEC,'PP' --XO-200509030583: JJR; 25/09/2005
                  FROM GA_ABOAMIST
                  WHERE NUM_ABONADO =nNUM_ABONADO;
                  --FIN/XO-200509030583: German Espinoza Z; 16/09/2005

                  --Inicialización por si acaso no posee cambio a ciclo pendiente

                  vCodPlantarifNue:=vCodPlantarif;

                  
                  nNumError := 0;
                  sMsgError := 'Error, al seleccionar GRP_PRESTACION';
                  sNOM_TABLA:='TA_PLANTARIF';
                  sCOD_ACT:='S';
                  
                  SELECT  GRP_PRESTACION
                  INTO LV_GRP_PRESTACION
                  FROM TA_PLANTARIF
                  WHERE  COD_PLANTARIF=vCodPlantarif;
                  

                  --XO-200509030583: German Espinoza Z; 16/09/2005
                  nNumError := 1;
                  sMsgError := 'Error, al seleccionar desde GA_CAUSUSP';
                  sNOM_TABLA:='GA_CAUSUSP';
                  sCOD_ACT:='S';
                  --XO-200509030583: German Espinoza Z; 16/09/2005

                  SELECT IND_LN,TIP_SUSPENCION
                  INTO  sIndListaNegra,LN_TIP_SUSPENSION
                  FROM GA_CAUSUSP
                  WHERE COD_PRODUCTO=vCodProducto
                  AND COD_MODULO='GA'
                  AND COD_CAUSUSP=vCOD_CAUSUSP;

         EXCEPTION
                WHEN NO_DATA_FOUND THEN
                         RAISE ERROR_PROCESO;
         END;

         BEGIN

                 IF LN_TIP_SUSPENSION=1 THEN
                    LV_TIP_SUSPENSION_AUX:='P'; --SUSPENSION UNIDIRECCIONAL
                 ELSE
                    LV_TIP_SUSPENSION_AUX:='T'; --SUSPENSION BIDIRECCIONAL
                 END IF;

                 nNumError := 2;

                 --XO-200509030583: German Espinoza Z; 16/09/2005
                 --sMsgError := 'Error al ingresar datos en GA_MODABOCEL';
                 sMsgError := 'Error al Seleccionar datos en GA_INTARCEL';
                 --FIN/XO-200509030583: German Espinoza Z; 16/09/2005

                 sNOM_TABLA:='GA_MODABOCEL';

                 sCOD_ACT:='I';

                 --Inicio ahott CH-261120031532 02-12-2003
                 select cod_cargobasico
                 into vCarBas_Intarcel
                 from ga_intarcel where
                 cod_cliente=vCodCliente and num_abonado=nNUM_ABONADO
                 and fec_hasta=(select max(fec_hasta) from ga_intarcel
                 where cod_cliente=vCodCliente and num_abonado=nNUM_ABONADO);
         --Inicio XO-200509030583 25-09-2005 - JJR.-
         EXCEPTION
                WHEN NO_DATA_FOUND THEN
                IF VCat_abonado = 'PO' THEN
                         RAISE ERROR_PROCESO;
                END IF;
         END;
                 IF VCat_abonado = 'PO' THEN
                        if vCodCargoBasico <> vCarBas_Intarcel then
                           vCodCargoBasico := vCarBas_Intarcel;
                        end if;
                 END IF;
         --Fin XO-200509030583 25-09-2005 - JJR.-
                 --Fin ahott CH-261120031532 02-12-2003
--Inicio XO-200509030583 25-09-2005 - JJR.-
        BEGIN
                 --XO-200509030583: German Espinoza Z; 16/09/2005
                 nNumError := 2;
                 sMsgError := 'Error al ingresar datos en GA_MODABOCEL';
                 sNOM_TABLA:='GA_MODABOCEL';
                 sCOD_ACT:='I';
                 --FIN/XO-200509030583: German Espinoza Z; 16/09/2005

                 INSERT INTO GA_MODABOCEL(NUM_ABONADO, COD_TIPMODI, FEC_MODIFICA, NUM_CELULAR,
                 TIP_PLANTARIF, COD_PLANTARIF,COD_CARGOBASICO,COD_CICLO,COD_TIPCONTRATO,
                 IND_EQPRESTADO,NOM_USUARORA,NUM_OS)
                 VALUES(nNUM_ABONADO,vACTUACION, vFecSys, vNumCelular,vTipPlantarif,vCodPlantarif,
                 vCodCargoBasico,vCodCiclo,vCodTipContrato,vIndEqPrestado,vNOM_USUARORA,nNUM_OOSS);

         EXCEPTION
                WHEN NO_DATA_FOUND THEN
                         RAISE ERROR_PROCESO;

         END;
         
         
         SELECT  COD_OS 
         INTO    LV_COD_OS
         FROM PV_IORSERV
         WHERE NUM_OS =nNUM_OOSS;
         
         
         
         
--Fin XO-200509030583 25-09-2005 - JJR.-
         -- Validación de Cambio de CargoBasico

         IF vTipPlantarif='E' THEN
                bCargoBasico:=FALSE;
         END IF;



       IF LV_GRP_PRESTACION='TM' OR LV_GRP_PRESTACION='TF' OR LV_GRP_PRESTACION='IE' THEN
 

         IF bCargoBasico THEN
         BEGIN

                        -- Selección de  Importe del Cargo Basico Actual del Abonado
                nNumError := 3;
                        sMsgError := 'Error, al seleccionar Importe del Abonado';
                        sNOM_TABLA:='TA_CARGOBASICO';
                        sCOD_ACT:='S';

                        SELECT IMP_CARGOBASICO
                        INTO vImpCargo_Abonado
                        FROM TA_CARGOSBASICO
                        WHERE COD_PRODUCTO=1
                        AND    SYSDATE BETWEEN FEC_DESDE AND FEC_HASTA --COL-36573|05-01-2007|AHA
                        AND COD_CARGOBASICO=vCodCargoBasico;

        EXCEPTION
                WHEN NO_DATA_FOUND THEN
                         RAISE ERROR_PROCESO;
        END;

    BEGIN
                        -- Selección de  Importe del Cargo Basico de Causa de Suspensión
                nNumError := 4;
                        sMsgError := 'Error, al seleccionar Importe de Causa de Suspension';
                        sNOM_TABLA:='TA_CARGOBASICO';
                        sCOD_ACT:='S';



                               
                        SELECT A.IMP_CARGOBASICO,A.COD_CARGOBASICO
                        INTO vImpCargo_Causa,vCargoBasicoNuevo
                        FROM GA_CAUSUSP B, TA_CARGOSBASICO A
                        WHERE B.COD_SUSPREHA = A.COD_CARGOBASICO
                        AND B.COD_MODULO = vCodModulo
                        AND B.COD_PRODUCTO = 1
                        AND B.COD_CAUSUSP = vCOD_CAUSUSP;

                        -- Comparación de Importes de Cargos Básicos

                        --XO-200509030583: German Espinoza Z; 16/09/2005
                        --IF    vImpCargo_Abonado < vImpCargo_Causa THEN
                        IF      vImpCargo_Causa>=vImpCargo_Abonado THEN
                        --FIN/XO-200509030583: German Espinoza Z; 16/09/2005

                                bCargoBasico:=FALSE;
                                --Inicio Modificación - GBM/Soporte - 27-02-2006 - RA-200602200813
                                vCargoBasicoNuevo:=NULL;
                                --Fin Modificación - GBM/Soporte - 27-02-2006 - RA-200602200813
                        END IF;


        EXCEPTION
                WHEN NO_DATA_FOUND THEN
                         bCargoBasico:=FALSE;
        END;

        END IF; -- CargoBasico
       ELSE
                bCargoBasico:=FALSE;
                vCargoBasicoNuevo:=NULL;
                
       END IF; -- CargoBasico

        -- Ejecución de Cargo Básico

        IF bCargoBasico THEN

           nNumError := 5;
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

        END IF;


        -- Actualización de GA_ABOCEL, situación

        sNOM_PROC:='PV_PR_SUSPVOLUNT';

        BEGIN

                 nNumError := 6;
                 sMsgError := 'Error, al actualizar GA_ABOCEL';
                 sNOM_TABLA:='GA_ABOCEL';
                 sCOD_ACT:='U';

                 UPDATE GA_ABOCEL
                        SET COD_SITUACION='STP',
                                FEC_ULTMOD=SYSDATE
                 WHERE NUM_ABONADO=nNUM_ABONADO;

                 --XO-200509030583: German Espinoza Z; 16/09/2005
                 IF SQL%ROWCOUNT=0 THEN
                        UPDATE GA_ABOAMIST
                        SET COD_SITUACION='STP',
                                FEC_ULTMOD=SYSDATE
                                WHERE NUM_ABONADO=nNUM_ABONADO;
                 END IF;
                 --XO-200509030583: German Espinoza Z; 16/09/2005

        EXCEPTION
                WHEN OTHERS THEN
                         RAISE ERROR_PROCESO;
        END;

        -- Ingreso en GA_PETSR

        BEGIN

                 BEGIN
                          nNumError := 7;
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

                 nNumError := 8;
                 sMsgError := 'Error, seleccionar Secuencia GA_SEQ_PETSR';
                 sNOM_TABLA:='GA_SEQ_PETSR';
                 sCOD_ACT:='S';

                 SELECT GA_SEQ_PETSR.NEXTVAL
                 INTO nNumPeticion
                 FROM DUAL;


                 nNumError := 9;
                 sMsgError := 'Error, al ingresar en GA_PETSR';
                 sNOM_TABLA:='GA_PETSR';
                 sCOD_ACT:='I';


                 INSERT INTO GA_PETSR (NUM_PETICION, NUM_ABONADO, FEC_ALTA, COD_PRODUCTO,
                 TIP_SUSP,COD_CAUSASUSP, NOM_USUARORA, FEC_SUSPENSION, FEC_REHABILITA,
                 COD_SUSPENSION,COD_SERVSUPL,COD_NIVEL, COD_CARGOSUSP, COD_CARGOREHA,
                 IND_ESTADOSUSP)
                 VALUES (nNumPeticion,nNUM_ABONADO,SYSDATE,1,LV_TIP_SUSPENSION_AUX,vCOD_CAUSUSP,
                 vNOM_USUARORA,SYSDATE,NULL,vCodSusPreha,NULL,NULL,vCargoBasicoNuevo,
                 vCargoBasicoReha,1);


        EXCEPTION
                WHEN OTHERS THEN

                         RAISE ERROR_PROCESO;
        END;

        BEGIN

                 nNumError := 10;
                 sMsgError := 'Error, al ingresar en GA_susprehabo';
                 sNOM_TABLA:='GA_SUSPREHABO';
                 sCOD_ACT:='I';


                 INSERT INTO GA_SUSPREHABO (NUM_ABONADO, COD_SERVICIO, FEC_SUSPBD, COD_SERVSUPL,
                 COD_NIVEL, COD_PRODUCTO, NUM_TERMINAL, NOM_USUARORA,COD_MODULO, TIP_REGISTRO,
                 COD_CAUSUSP, TIP_SUSP, COD_CARGOBASICO, IND_SINIESTRO, NUM_PETICION, COD_PLANNUE)
                 VALUES(nNUM_ABONADO,vCodSusPreha,SYSDATE,NULL,NULL,1,vNumCelular,vNOM_USUARORA,
                 'GA','1',vCOD_CAUSUSP,LV_TIP_SUSPENSION_AUX,vCargoBasicoNuevo,0,nNumPeticion,vCodPlantarifNue);


                 IF sIndListaNegra =1 THEN
                 BEGIN

                        nNumError := 11;
                        sMsgError := 'Error, al obtener TA_DATOSGENER';
                        sNOM_TABLA:='TA_DATOSGENER';
                        sCOD_ACT:='S';

                        SELECT COD_OPERADOR
                        INTO  vCodOperador
                    FROM TA_DATOSGENER;

                        nNumError := 12;
                        sMsgError := 'Error, al ingresar en GA_LNCELU';
                        sNOM_TABLA:='GA_LNCELU';
                        sCOD_ACT:='I';

                        INSERT INTO GA_LNCELU (NUM_SERIE, IND_PROCEQUI, NUM_SERIEMEC, COD_OPERADOR,
                        NUM_CELULAR,NUM_ABONADO, COD_CLIENTE, FEC_ALTA, COD_FABRICANTE,COD_ARTICULO)
                        SELECT vNumSerie,A.IND_PROCEQUI,vNumSerieMec,vCodOperador,vNumCelular,nNUM_ABONADO,
                        vCodCliente,vFecSys,C.COD_FABRICANTE,A.COD_ARTICULO
                        FROM GA_EQUIPABOSER A, AL_ARTICULOS C
                        WHERE NUM_ABONADO=nNUM_ABONADO
                        AND NUM_SERIE=vNumSerie
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
            WHERE NUM_ABONADO=nNUM_ABONADO                                                     
            AND NUM_SERIE=vNumSerie                                                            
            AND FEC_ALTA =(SELECT MAX(FEC_ALTA)                                                
            FROM GA_EQUIPABOSER B                                                              
            WHERE A.NUM_ABONADO=B.NUM_ABONADO                                                  
            AND A.NUM_SERIE=B.NUM_SERIE)                                                       
            AND A.COD_ARTICULO=C.COD_ARTICULO;                                                 
                        
                        
                 EXCEPTION
                        
                        WHEN OTHERS THEN
                                 RAISE ERROR_PROCESO;
                 END;


                 END IF;

        EXCEPTION
                WHEN OTHERS THEN
                         RAISE ERROR_PROCESO;

        END;

    nNumError:=0;
        sMsgError:='Operacion Exitosa';
    nCOD_ERROR:=nNumError;
        sMEN_ERROR:=sMsgError;

EXCEPTION

        WHEN ERROR_PROCESO THEN

                  sCOD_SQLCODE := SQLCODE;
                  sCOD_SQLERRM := substr(SQLERRM,1,59);

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
SHOW ERRORS