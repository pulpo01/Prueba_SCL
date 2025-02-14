CREATE OR REPLACE FUNCTION PV_MTONBPORC_FN (V_Num_Movimiento         NUMBER,
                                            V_Cod_concepto           NUMBER,
                                            V_Mto_Carga              NUMBER,
                                            V_Flag_Mto_Entrante      NUMBER,
                                            V_Num_Abonado            NUMBER
                                           ) RETURN VARCHAR2 IS
/*
<NOMBRE>	   : PV_MTONBPORC_FN.</NOMBRE>
<MODULO >	   : IC</MODULO >
<VERSION >     : 1.1</VERSION >
<DESCRIPCION>  : /DESCRIPCION>
<FECHAMOD >    : 06/06/2006 </FECHAMOD >
<DESCMOD >     : Se Incorpora la obtención del num_serie , al momento de validar si el cliente es prepago o postpago Inc.CO-0015 </DESCMOD >
*/

        V_TMP_COD_CLIENTE          GE_CLIENTES.COD_CLIENTE%TYPE;

        V_COD_CIUDAD               GA_ABOCEL.COD_CIUDAD%TYPE;
        V_COD_REGION               GA_ABOCEL.COD_REGION%TYPE;
        V_COD_PROVINCIA            GA_ABOCEL.COD_PROVINCIA%TYPE;
		V_COD_SERIE                GA_ABOCEL.NUM_SERIE%TYPE;

        V_COD_CATIMPOS             GE_CATIMPCLIENTES.COD_CATIMPOS%TYPE;

        V_FEC_DESDE                GE_ZONACIUDAD.FEC_DESDE%TYPE;
        V_COD_ZONAIMPO             GE_ZONACIUDAD.COD_ZONAIMPO%TYPE;

        V_FEC_DESDE2               FA_GRPSERCONC.FEC_DESDE%TYPE;

        V_PRC_IMPUESTO             GE_IMPUESTOS.PRC_IMPUESTO%TYPE;

        V_Mto_Carga_NETO           ICC_MOVIMIENTO.CARGA%TYPE;
        V_Mto_Carga_BRUTO          ICC_MOVIMIENTO.CARGA%TYPE;

        V_cod_actabo               ICC_MOVIMIENTO.COD_ACTABO%TYPE;
        V_Carga                    ICC_MOVIMIENTO.CARGA%TYPE;
        V_Num_serie                AL_SERIES.NUM_SERIE%TYPE;
        V_Serie_TDMA               ICC_MOVIMIENTO.NUM_SERIE%TYPE;
        V_Serie_GSM                ICC_MOVIMIENTO.ICC%TYPE;
        V_D_Num_serie              ICC_MOVIMIENTO.NUM_SERIE%TYPE;
        V_Num_Abonados             ICC_MOVIMIENTO.NUM_ABONADO%TYPE;
        V_Tip_Tecnologia           ICC_MOVIMIENTO.TIP_TECNOLOGIA%TYPE;

        V_COD_BODEGA               AL_SERIES.COD_BODEGA%TYPE;
        V_COD_DIRECCION            AL_BODEGAS.COD_DIRECCION%TYPE;

        V_COD_GRPSERVI             FA_GRPSERCONC.COD_GRPSERVI%TYPE;

        V_VAL_PARAMETRO            GED_PARAMETROS.VAL_PARAMETRO%TYPE;
        V_VAL_PARAMETRO_GSM        GED_PARAMETROS.VAL_PARAMETRO%TYPE;

        V_PARAM                    VARCHAR2(200);
		V_VAL_PARAMETRO2   		   GED_PARAMETROS.VAL_PARAMETRO%TYPE;

BEGIN

         /**************************************************************************************************/
         /* Opcion para Posventa retorna Porcentaje */
         /* Opcion para Beneficio y Promociones     */
         /**************************************************************************************************/

       ---GMGE 15/10/2004 CAPTURA FLG MTO SALIENTE
     BEGIN
  	 SELECT   VAL_PARAMETRO   INTO   V_VAL_PARAMETRO2
  	 FROM   GED_PARAMETROS
  	 WHERE   NOM_PARAMETRO = 'FLAG_MTO_SALIENTE'
	 AND	 COD_MODULO    = 'GA'  AND  COD_PRODUCTO  = 1;
	 EXCEPTION WHEN NO_DATA_FOUND THEN
        	      RETURN 'PARAMETRO FLAG_MTO_SALIENTE NO EXISTE | '||SQLERRM;
    		   WHEN OTHERS THEN
                      RETURN 'PARAM ERROR FLAG_MTO_SALIENTE | ' ||SQLERRM;
       END;
    	---GMGE 15/10/2004 FIN CAPTURA FLG MTO SALIENTE
	---GMGE 15/10/2004 COMPROBACION DE LA CONFIGURACIÓN DE LOS FLAGS DE MONTO ENTRANTE Y SALIENTE

      IF (V_Flag_Mto_Entrante IS NOT NULL) AND (V_VAL_PARAMETRO2=V_Flag_Mto_Entrante) THEN
	 	    RETURN V_Mto_Carga;
	  END IF;
	---GMGE 15/10/2004 FIN COMPROBACION DE LA CONFIGURACIÓN DE LOS FLAGS DE MONTO ENTRANTE Y SALIENTE

         BEGIN
           SELECT VAL_PARAMETRO INTO V_VAL_PARAMETRO
           FROM GED_PARAMETROS
           WHERE NOM_PARAMETRO = 'COD_TIPIMPTO_EXCLUIR'
		   AND COD_MODULO    = 'GA' AND COD_PRODUCTO  = 1;
           EXCEPTION
                WHEN NO_DATA_FOUND THEN
                     RETURN 'PARAMETRO NO EXISTE | '||SQLERRM;
                WHEN OTHERS THEN
                     RETURN 'PARAM TIPIMPTO | ' ||SQLERRM;
         END;


         BEGIN
           SELECT VAL_PARAMETRO INTO V_VAL_PARAMETRO_GSM
           FROM GED_PARAMETROS
           WHERE NOM_PARAMETRO = 'TECNOLOGIA_GSM'
		   AND COD_MODULO    = 'GA' AND COD_PRODUCTO  = 1;
           EXCEPTION
                WHEN NO_DATA_FOUND THEN
                     RETURN 'PARAMETRO TEC GSM NO EXISTE | '||SQLERRM;
                WHEN OTHERS THEN
                    RETURN 'PARAM TEC.GSM | ' || SQLERRM;
         END;


         /* VERIFICA SI EL ABONADO ES UN POSPAGO O PREPAGO */
         BEGIN

           SELECT COD_CLIENTE,COD_CIUDAD,COD_REGION,COD_PROVINCIA ,NUM_SERIE
		   INTO V_TMP_COD_CLIENTE,V_COD_CIUDAD,V_COD_REGION,V_COD_PROVINCIA,V_COD_SERIE
           FROM GA_ABOAMIST
           WHERE NUM_ABONADO =  V_Num_Abonado;
           EXCEPTION
                WHEN NO_DATA_FOUND THEN

                     BEGIN
                      SELECT COD_CLIENTE,COD_CIUDAD,COD_REGION,COD_PROVINCIA ,NUM_SERIE
					  INTO V_TMP_COD_CLIENTE,V_COD_CIUDAD,V_COD_REGION,V_COD_PROVINCIA,V_COD_SERIE
                      FROM GA_ABOCEL
                      WHERE NUM_ABONADO =  V_Num_Abonado;
                      EXCEPTION
                          WHEN NO_DATA_FOUND THEN
                               BEGIN
                                 SELECT NUM_SERIE, ICC, TIP_TECNOLOGIA INTO V_Serie_TDMA, V_Serie_GSM, V_Tip_Tecnologia
                                 FROM ICC_MOVIMIENTO
                                 WHERE
                                 NUM_MOVIMIENTO =  V_Num_Movimiento;
                                 EXCEPTION
                                     WHEN NO_DATA_FOUND THEN
                                          RETURN 'MOVIMIENTO NO EXISTE | '||SQLERRM;

                                     WHEN OTHERS THEN
                                          RETURN 'ERROR ACCESO ICC_MOVIMIENTO | '||SQLERRM;
                               END;

                               IF V_Tip_Tecnologia = V_VAL_PARAMETRO_GSM THEN
                                  IF V_SERIE_GSM IS NULL THEN
                                     --RETURN 'COMANDO SIN SERIE GSM ';
									      V_Num_Serie := V_COD_SERIE;
                                  END IF;
                                  V_Num_Serie := V_Serie_GSM;
                               ELSE

                                  BEGIN
                                    /* OBTIENE VALOR DECIMAL */
                                    SELECT LPAD(TO_CHAR(Ic_Pkg_Parametros.FN_GEN_HexToNum(SUBSTR(NVL(UPPER(V_Serie_TDMA),CHR('00')),1,2))),3, '0') ||
                                           LPAD(TO_CHAR(Ic_Pkg_Parametros.FN_GEN_HexToNum(SUBSTR(NVL(UPPER(V_Serie_TDMA), CHR('00')),3))),8, '0')
                                    INTO   V_Num_Serie FROM DUAL;
                                    EXCEPTION
                                         WHEN OTHERS THEN
                                              RETURN 'ERROR VALOR DEC | ' || SQLERRM;
                                  END;

                               END IF;

                               BEGIN
                                  SELECT COD_BODEGA INTO   V_COD_BODEGA
                                  FROM   AL_SERIES
                                  WHERE  NUM_SERIE = V_Num_Serie;
                                  EXCEPTION
                                         WHEN NO_DATA_FOUND THEN
                                              BEGIN
                                                 SELECT a.COD_BODEGA INTO   V_COD_BODEGA
                                                 FROM   AL_COMPONENTE_KIT a
                                                 WHERE  a.NUM_SERIE   = V_Num_Serie
                                                 AND    a.fec_entrada = (SELECT MAX(b.fec_entrada)
                                                                         FROM al_componente_kit b
                                                                         WHERE a.num_serie = b.num_serie);
                                                   EXCEPTION
                                                           WHEN NO_DATA_FOUND THEN
	 					              					   		BEGIN
					                         						 SELECT a.cod_bodega INTO   V_COD_BODEGA
								 			 						 FROM   al_movimientos a
											 						 WHERE  a.num_serie = V_Num_Serie
								 			 						 AND    a.tip_movimiento = 3
								 			 						 AND    a.fec_movimiento = (SELECT MAX(b.fec_movimiento)
								             						 FROM   al_movimientos b
											 						 WHERE  a.num_serie      = b.num_serie
											 						 AND    b.tip_movimiento = 3);
																EXCEPTION
											    				   WHEN NO_DATA_FOUND THEN
                                                     				 RETURN 'SERIE NO EXISTE | '||SQLERRM;
                                                				   WHEN OTHERS THEN
                                                     				 RETURN 'ERROR ACCESO AL_COMPONENTE_KIT | '||SQLERRM;
							          							END;
						 	   								WHEN OTHERS THEN
							        						     RETURN 'ERROR ACCESO AL_SERIES | '||SQLERRM;
						                        END;
                                                  WHEN OTHERS THEN
                                                       RETURN 'ERROR ACCESO AL_SERIES | '||SQLERRM;
                                END;


                                /* OBTIENE  DIRECCION  */

                                BEGIN
                                  SELECT COD_DIRECCION INTO V_COD_DIRECCION
                                  FROM AL_BODEGAS
                                  WHERE COD_BODEGA   = V_COD_BODEGA;
                                  EXCEPTION
                                        WHEN NO_DATA_FOUND THEN
                                             RETURN 'BODEGA NO EXISTE | '||SQLERRM;
                                        WHEN OTHERS THEN
                                             RETURN 'ERROR ACCESO AL_BODEGAS | '||SQLERRM;
                                END;

                                /* OBTIENE  CIUDAD ,PROVINCIA Y REGION */
                                BEGIN
                                  SELECT COD_CIUDAD,COD_REGION,COD_PROVINCIA INTO V_COD_CIUDAD,V_COD_REGION,V_COD_PROVINCIA
                                  FROM GE_DIRECCIONES
                                  WHERE COD_DIRECCION   = V_COD_DIRECCION;
                                  EXCEPTION
                                        WHEN NO_DATA_FOUND THEN
                                             RETURN 'DIRECCION NO EXISTE | '||SQLERRM;
                                        WHEN OTHERS THEN
                                             RETURN 'ERROR ACCESO GE_DIRECCIONES | '||SQLERRM;
                                END;

                                V_TMP_COD_CLIENTE := NULL;




                        WHEN OTHERS THEN
                             RETURN 'ERROR ACCESO GA_ABOCEL | '||SQLERRM;
                      END; /* GA_ABOAMIST */

              WHEN OTHERS THEN
                   RETURN 'ERROR ACCESO GA_ABOAMIST | '||SQLERRM;
         END; /* GA_ABOCEL */



                 -- TENEMOS cliente, region, provincia y ciudad


                /* OBTIENE CATEGORIA IMPOSITIVA */

                DBMS_OUTPUT.PUT_LINE('CLIENTE(1) : ' || V_TMP_COD_CLIENTE);

                IF V_TMP_COD_CLIENTE IS NOT NULL THEN
                   BEGIN
                     DBMS_OUTPUT.PUT_LINE('CLIENTE : ' || V_TMP_COD_CLIENTE || '*');

                     SELECT COD_CATIMPOS INTO V_COD_CATIMPOS
                     FROM GE_CATIMPCLIENTES
                     WHERE COD_CLIENTE = V_TMP_COD_CLIENTE
                     AND SYSDATE BETWEEN FEC_DESDE AND FEC_HASTA ;
                     EXCEPTION
                         WHEN NO_DATA_FOUND THEN
                              RETURN 'CLIENTE NO POSEE CATEGORIA IMPOSITIVA | '||SQLERRM;
                         WHEN OTHERS THEN
                              RETURN 'ERROR ACCESO GE_CATIMPCLIENTES | '||SQLERRM;
                   END;
                 END IF;

                 /* OBTIENE GRUPO SERVICIO DEL CONCEPTO */

                 IF V_Cod_concepto IS NOT NULL THEN
                    BEGIN
                      SELECT COD_GRPSERVI INTO V_COD_GRPSERVI
                      FROM FA_GRPSERCONC
                      WHERE COD_CONCEPTO = V_Cod_Concepto
                      AND SYSDATE BETWEEN FEC_DESDE AND FEC_HASTA ;
                      EXCEPTION
                          WHEN NO_DATA_FOUND THEN
                               RETURN 'CONCEPTO SIN GRUPO DE SERVICIO | '||SQLERRM;
                          WHEN OTHERS THEN
                               RETURN 'ERROR ACCESO FA_GRPSERCONC | '||SQLERRM;
                    END;
                 END IF;

                 /* OBTIENE ZONA IMPOSITIVA */

                 BEGIN
                   SELECT COD_ZONAIMPO INTO V_COD_ZONAIMPO
                   FROM GE_ZONACIUDAD
                   WHERE
                          COD_CIUDAD    = V_COD_CIUDAD    AND
                          COD_REGION    = V_COD_REGION    AND
                          COD_PROVINCIA = V_COD_PROVINCIA AND
                          SYSDATE BETWEEN FEC_DESDE AND FEC_HASTA ;
                   EXCEPTION
                        WHEN NO_DATA_FOUND THEN
                            RETURN 'CLIENTE NO POSEE ZONA IMPOSITIVA VIGENTE | '||SQLERRM;
                        WHEN OTHERS THEN
                            RETURN 'ERROR ACCESO GE_ZONACIUDAD | '||SQLERRM;
                 END;


                 /* OBTIENE PORCENTAJE */

                /* CASO MOV. LOGISTICAS */
                IF  V_Cod_concepto IS NULL AND V_TMP_COD_CLIENTE IS NULL THEN
                 BEGIN
                    /*
                    Se modifica por RA-200511110099 ya que Ecuador requiere tarifa basica + impuesto
                    Modificado por INSAB 15/11/2005
                    */
                    SELECT SUM(unique PRC_IMPUESTO) INTO V_PRC_IMPUESTO
                    FROM GE_IMPUESTOS
                    WHERE  COD_ZONAIMPO      = V_COD_ZONAIMPO   AND
                           COD_TIPIMPUES     <> V_VAL_PARAMETRO AND
                           SYSDATE BETWEEN FEC_DESDE AND FEC_HASTA;
                    EXCEPTION
                        WHEN NO_DATA_FOUND THEN
                             RETURN 'CLIENTE NO POSEE PORCENTAJE DE IMPUESTO (ZONA) | '||SQLERRM;
                        WHEN OTHERS THEN
                             RETURN 'ERROR ACCESO GE_IMPUESTOS (ZONA)| '||SQLERRM;
                 END;
                ELSE
                        /* CASOS DE RECARGAS, DONDE VIENE CONCEPTO FACT. */
                        IF  V_Cod_concepto IS NOT NULL AND V_TMP_COD_CLIENTE IS NOT NULL THEN
                            BEGIN
                              SELECT SUM(unique PRC_IMPUESTO) INTO V_PRC_IMPUESTO
                              FROM GE_IMPUESTOS
                              WHERE COD_CATIMPOS      = V_COD_CATIMPOS   AND
                                    COD_ZONAIMPO      = V_COD_ZONAIMPO   AND
                                    COD_TIPIMPUES     <> V_VAL_PARAMETRO AND
                                    COD_GRPSERVI      = V_COD_GRPSERVI   AND
                                    SYSDATE BETWEEN FEC_DESDE AND FEC_HASTA;
                              EXCEPTION
                                   WHEN NO_DATA_FOUND THEN
                                        RETURN 'CLIENTE NO POSEE PORCENTAJE DE IMPUESTO (ZONA/CATIMPOS/GRPSERVI)| '||SQLERRM;
                                   WHEN OTHERS THEN
                                        RETURN 'ERROR ACCESO GE_IMPUESTOS (ZONA/CATIMPOS/GRPSERVI)| '||SQLERRM;
                            END;
                        ELSE

                            /* CASO POSTVENTA Y ByP */
                                IF V_TMP_COD_CLIENTE IS NOT NULL AND V_Cod_concepto IS NULL THEN
                                   BEGIN
                                     SELECT SUM(unique PRC_IMPUESTO) INTO V_PRC_IMPUESTO
                                     FROM GE_IMPUESTOS
                                     WHERE COD_CATIMPOS      = V_COD_CATIMPOS   AND
                                           COD_ZONAIMPO      = V_COD_ZONAIMPO   AND
                                           COD_TIPIMPUES     <> V_VAL_PARAMETRO AND
                                           SYSDATE BETWEEN FEC_DESDE AND FEC_HASTA;
                                     EXCEPTION
                                         WHEN NO_DATA_FOUND THEN
                                              RETURN 'CLIENTE NO POSEE PORCENTAJE DE IMPUESTO (ZONA/CATIMPOS)| '||SQLERRM;
                                         WHEN OTHERS THEN
                                              RETURN 'ERROR ACCESO GE_IMPUESTOS (ZONA/CATIMPOS)| '||SQLERRM;
                                   END;
                                ELSE
                                        RETURN 'CASO NO CONTEMPLADO.';
                                END IF;

                        END IF;

                END IF;

                /* FIN OBTENCION PORCENTAJE DE IMPTO */

               IF (V_Flag_Mto_Entrante IS NULL AND V_Mto_Carga IS NULL) THEN /* CASO POSTVENTAS */
                   RETURN V_PRC_IMPUESTO;
               ELSE
				   IF V_Flag_Mto_Entrante  = 0 THEN /* VIENE MONTO NETO */
				        V_Mto_Carga_BRUTO := V_Mto_Carga * ( 1 + (V_PRC_IMPUESTO/100)) ;
                        RETURN V_Mto_Carga_BRUTO;
                   END IF;
                   IF V_Flag_Mto_Entrante  = 1 THEN /* VIENE MONTO BRUTO */
                      V_Mto_Carga_NETO := V_Mto_Carga / ( 1 + (V_PRC_IMPUESTO/100) );
                      RETURN V_Mto_Carga_NETO;
                   END IF;

               END IF;


         RETURN 'ERROR, NO SE PUDO ENTREGAR INFORMACIÓN SOLICITADA.';

END PV_MTONBPORC_FN;
/
SHOW ERRORS
