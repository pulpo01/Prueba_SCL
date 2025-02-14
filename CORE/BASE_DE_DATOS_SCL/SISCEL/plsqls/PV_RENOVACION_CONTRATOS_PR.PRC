CREATE OR REPLACE PROCEDURE PV_RENOVACION_CONTRATOS_PR (
                    nNUM_ABONADO    IN  NUMBER,
                        nEXTENSION      IN  NUMBER,
                        vMOTIVO         IN  VARCHAR2,
                        nVISITA         IN  NUMBER,
                        nTRANS                  IN  NUMBER,
                        vTABLA          IN  VARCHAR2,
                    vCOD_ACTABO     IN  VARCHAR2,
                        vFEC_MODI               IN  DATE,
                        ERROR_APLIC             out VARCHAR2,
                        ERROR_GLOSA     out VARCHAR2,
                    ERROR_ORA       out VARCHAR2,
                        ERROR_ORA_GLOSA out VARCHAR2,
                    TRACE           out VARCHAR2
                        )
                IS
                        nUSUARIO             VARCHAR2(30);
                        ERROR_PROCESO        EXCEPTION;
                        vFMODI               GA_ABOCEL.FEC_FINCONTRA%TYPE;
                    TABLA_ERROR                  GA_ERRORES.NOM_TABLA%TYPE;
                        TIPO_ACTUACION_TABLA GA_ERRORES.COD_ACT%TYPE;

                BEGIN


                        ERROR_APLIC:='0';
                        ERROR_GLOSA:= 'NO HAY ERROR';
                        ERROR_ORA:='0';
                    ERROR_ORA_GLOSA:=' ';
                    TRACE:= 'INICIO|';
                    dbms_output.PUT_LINE('PASO 1 =' || vTABLA);

                        SELECT USER INTO nUSUARIO FROM DUAL;
                        SELECT ADD_MONTHS (vFEC_MODI, nEXTENSION)  INTO  vFMODI FROM DUAL;

                        IF vTABLA='GA_ABOCEL'   THEN

                                 BEGIN
                                  UPDATE GA_ABOCEL
                                  SET FEC_FINCONTRA   = vFMODI
                              Where NUM_ABONADO   = nNUM_ABONADO;
                  dbms_output.PUT_LINE('PASO 2 =' || vTABLA);

                            EXCEPTION
                                WHEN OTHERS
                                THEN
                        ERROR_APLIC     := '4';
                                        ERROR_GLOSA     := 'Problemas al Actualizar en GA_ABOCEL';
                                        ERROR_ORA               := TO_CHAR(SQLCODE);
                                        ERROR_ORA_GLOSA := SQLERRM;
                        RAISE ERROR_PROCESO;
                         END;

                        ELSIF vTABLA='GA_ABOAMIST'  THEN

                                 BEGIN
                                  UPDATE GA_ABOAMIST
                                  SET FEC_FINCONTRA   = vFMODI
                              Where NUM_ABONADO  =  nNUM_ABONADO;
                            EXCEPTION
                                WHEN OTHERS
                                THEN
                        ERROR_APLIC     := '4';
                                        ERROR_GLOSA     := 'Problemas al Actualizar en GA_ABOAMIST';
                                        ERROR_ORA               := TO_CHAR(SQLCODE);
                                        ERROR_ORA_GLOSA := SQLERRM;
                        RAISE ERROR_PROCESO;
                         END;
                        END IF;


            BEGIN
                                        INSERT INTO GA_MODABOCEL (NUM_ABONADO,
                                                                                COD_TIPMODI,
                                                                                FEC_MODIFICA,
                                                                                NOM_USUARORA,
                                                                                FEC_FINCONTRATO,
                                                                                MOT_RENOVACION,
                                                                                TIP_VISITA)
                                        VALUES     ( nNUM_ABONADO ,
                                                             vCOD_ACTABO,
                                                                 SYSDATE,
                                                                 nUSUARIO,
                                                                 vFEC_MODI,
                                                                 vMOTIVO,
                                                                 nVISITA);

                    dbms_output.PUT_LINE('PASO 3 =' || vTABLA);
                    EXCEPTION
                             WHEN OTHERS
                             THEN
                        ERROR_APLIC     := '4';
                                        ERROR_GLOSA     := 'Problemas al Insertar en GA_MODABOCEL';
                                        ERROR_ORA               := TO_CHAR(SQLCODE);
                                        ERROR_ORA_GLOSA := SQLERRM;
                        RAISE ERROR_PROCESO;
                    END;

                    ERROR_APLIC:='0';
                    ERROR_GLOSA:= 'NO HAY ERROR';
                        TRACE:= TRACE ||'FIN'  || '|';

                        RAISE ERROR_PROCESO;

                EXCEPTION
                    WHEN ERROR_PROCESO THEN
                         ERROR_ORA:= TO_CHAR(SQLCODE);
                         ERROR_ORA_GLOSA:= SQLERRM;
                                 IF ERROR_APLIC <> '0' THEN
                                 ROLLBACK;
                                 INSERT INTO GA_ERRORES (COD_ACTABO, CODIGO, FEC_ERROR, COD_PRODUCTO, NOM_PROC, NOM_TABLA, COD_ACT, COD_SQLCODE, COD_SQLERRM)
                                 VALUES (vCOD_ACTABO,nNUM_ABONADO,SYSDATE,1,'PV_RENOVACION_CONTRATOS_PR',TABLA_ERROR,TIPO_ACTUACION_TABLA ,ERROR_ORA,ERROR_ORA_GLOSA);
                 COMMIT;
                 ERROR_APLIC:='4';
                                 END IF;

                                  INSERT INTO GA_TRANSACABO (NUM_TRANSACCION,COD_RETORNO,DES_CADENA)
                                  VALUES(TO_NUMBER(nTRANS),ERROR_APLIC,ERROR_GLOSA);

END;
/
SHOW ERRORS
