CREATE OR REPLACE PROCEDURE PV_VALIDA_TARJETA_RASCA_PR(v_param_entrada IN  VARCHAR2,
                                             		   bRESULTADO      OUT VARCHAR2,
                                             		   vMENSAJE        OUT GA_TRANSACABO.DES_CADENA%TYPE)
IS
         string SISCEL.GE_TABTYPE_VCH2ARRAY:= SISCEL.GE_TABTYPE_VCH2ARRAY('','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');

         nABONADO   ga_abocel.NUM_ABONADO%TYPE;
		 sTecnologia_GSM ga_abocel.COD_TECNOLOGIA%TYPE;
		 sTecnologia_TDMA ga_abocel.COD_TECNOLOGIA%TYPE;
		 sTecnologia ga_abocel.COD_TECNOLOGIA%TYPE;
		 val_param_tecnologia ged_parametros.VAL_PARAMETRO%TYPE;

BEGIN
         bRESULTADO := 'TRUE';

		 GE_PAC_ArregloPR.GE_PR_RetornaArreglo(v_param_entrada, string);
         --Ge_Pac_Arreglopr.GE_PR_RetornaArreglo(v_param_entrada, string);
     	 nABONADO := TO_NUMBER(string(5));


 	 	 	 --***** Resctar tecnologia del Abondado *****
			 --SELECT cod_tecnologia INTO sTecnologia FROM ga_aboamist WHERE num_abonado = nABONADO;

		     BEGIN
			 	  SELECT cod_tecnologia INTO sTecnologia FROM ga_aboamist WHERE num_abonado = nABONADO AND COD_SITUACION <> 'BAA';
			 	  if SQL%NOTFOUND then
				       SELECT cod_tecnologia INTO sTecnologia FROM ga_abocel WHERE num_abonado = nABONADO AND COD_SITUACION <> 'BAA';
				  end if;
			 END;

			 SELECT val_parametro INTO sTecnologia_GSM FROM ged_parametros WHERE nom_parametro = 'TECNOLOGIA_GSM' AND COD_MODULO = 'GA' AND cod_producto = 1;
			 SELECT val_parametro INTO sTecnologia_TDMA FROM ged_parametros WHERE nom_parametro = 'TECNOLOGIA_TDMA' AND COD_MODULO = 'GA' AND cod_producto = 1;


			 IF sTecnologia <> sTecnologia_GSM AND sTecnologia <> sTecnologia_TDMA THEN
			 	SELECT cod_tecnologia INTO sTecnologia FROM ga_abocel WHERE num_abonado = nABONADO;
				IF sTecnologia <> sTecnologia_GSM AND sTecnologia <> sTecnologia_TDMA THEN
         	 	   bRESULTADO := 'FALSE';
             	   vMENSAJE   := 'NO ABONADO NO POSEE LA TECNOLOGIA PARA REALIZAR ESTA CONSULTA (solo GSM o CDMA)';
				END IF;
			 END IF;

			 IF sTecnologia = sTecnologia_GSM THEN
			 	SELECT val_parametro INTO val_param_tecnologia FROM ged_parametros WHERE nom_parametro = 'COD_SERVTARJETA_GSM';
				--Solo con uno esta apto para esta consulta 0 = false 1 = true
				IF val_param_tecnologia <> 1 THEN
         	 	   bRESULTADO := 'FALSE';
             	   vMENSAJE   := 'LA TECNOLOGiA DEL ABONADO NO ES COMPATIBLE CON LA TECNOLOGIA PARA ESTA CONSULTA.TECNOLOGiA (GSM-CDMA)';
				END IF;
			 END IF;
			 IF sTecnologia = sTecnologia_TDMA THEN
			 	SELECT val_parametro INTO val_param_tecnologia FROM ged_parametros WHERE nom_parametro = 'COD_SERVTARJETA_CDMA';
				--Solo con uno esta apto para esta consulta 0 = false 1 = true
				IF val_param_tecnologia <> 1 THEN
         	 	   bRESULTADO := 'FALSE';
             	   vMENSAJE   := 'LA TECNOLOGiA DEL ABONADO NO ES COMPATIBLE CON LA TECNOLOGIA PARA ESTA CONSULTA.TECNOLOGiA (GSM-CDMA)';
				END IF;
			 END IF;

     EXCEPTION
     WHEN OTHERS THEN
          bRESULTADO := 'FALSE';
          vMENSAJE   := 'ERROR EN PV_VALIDA_TARJETA_RASCA_PR: NO SE PUEDE REALIZAR ESTA CONSULTA.';

END;
/
SHOW ERRORS
