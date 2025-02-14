CREATE OR REPLACE PROCEDURE PV_VALPLANTIPPLAN_PR (
   v_param_entrada IN  VARCHAR2,
    bRESULTADO      OUT VARCHAR2,
    vMENSAJE        OUT GA_TRANSACABO.DES_CADENA%TYPE
        )
IS
-- PL/SQL Specification
--
-- *************************************************************
-- * procedimiento      : PV_VALPLANTIPPLAN_PR
-- * Descripcion        : Valida codigo tipo plan segun tipo plan tarifario
-- *
-- * Fecha de creacion  : 13-01-2003 12:46
-- * Responsable        : Area Postventa
-- *************************************************************

    string GE_TABTYPE_VCH2ARRAY:= GE_TABTYPE_VCH2ARRAY('','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');

        nCOD_CLIENTEO     GA_ABOCEL.COD_CLIENTE%TYPE;
        nCOD_CLIENTED     GA_ABOCEL.COD_CLIENTE%TYPE;

        nCOD_CUENTAO      GA_ABOCEL.COD_CUENTA%TYPE;
        nCOD_CUENTAD      GA_ABOCEL.COD_CUENTA%TYPE;
        scod_ACTUACI      PV_MOVIMIENTOS.COD_ACTABO%TYPE;

        sTIPLANTARIFD     GA_ABOCEL.TIP_PLANTARIF%TYPE;
        sTIPLANTARIF      GA_ABOCEL.TIP_PLANTARIF%TYPE;

        scod_plan       GA_ABOCEL.COD_PLANTARIF%TYPE;
        scod_pland      GA_ABOCEL.COD_PLANTARIF%TYPE;
        scod_tiplan     TA_PLANTARIF.COD_PLANTARIF%TYPE;
        scod_tipland    TA_PLANTARIF.COD_PLANTARIF%TYPE;
	vFormatoSel2    GED_PARAMETROS.VAL_PARAMETRO%TYPE;
        vFormatoSel7    GED_PARAMETROS.VAL_PARAMETRO%TYPE;

        SVALHIBRIDO     GED_PARAMETROS.VAL_PARAMETRO%TYPE; -- Modificación - GBM/Soporte - 04-09-2006 - CO-200608260346

BEGIN

        GE_PAC_ArregloPR.GE_PR_RetornaArreglo(v_param_entrada, string);
    scod_ACTUACI                :=string(4);
        nCOD_CUENTAO            :=TO_NUMBER(string(14));
        nCOD_CUENTAD            :=TO_NUMBER(string(15));
        nCOD_CLIENTEO           :=TO_NUMBER(string(6));
        nCOD_CLIENTED           :=TO_NUMBER(string(16));
        sTIPLANTARIF            :=string(17);
        sTIPLANTARIFD           :=string(18);


    bRESULTADO:='TRUE';

	BEGIN

        SELECT A.COD_PLANTARIF,B.COD_TIPLAN
        into
        scod_plan,scod_tiplan
        FROM GA_ABOCEL A,TA_PLANTARIF B
        WHERE
        A.COD_CLIENTE  = nCOD_CLIENTEO     AND
        A.COD_CUENTA   = nCOD_CUENTAO      AND
        A.COD_PLANTARIF = B.COD_PLANTARIF  AND
        B.COD_PRODUCTO  = 1                AND
        ROWNUM = 1;


	EXCEPTION WHEN NO_DATA_FOUND THEN
                       bRESULTADO:='FALSE';
                       vMENSAJE:='Error Plan Tarifario no existe.';
                  WHEN OTHERS  THEN
                       bRESULTADO:='FALSE';
                       vMENSAJE:='Error de Acceso ';
	END;



	IF sTIPLANTARIFD = 'E' THEN
	   BEGIN
	        SELECT a.COD_PLANTARIF,B.COD_TIPLAN
	        INTO scod_pland,scod_tipland
	        FROM
	        GA_EMPRESA a,TA_PLANTARIF B
	        WHERE a.COD_CLIENTE =  nCOD_CLIENTED    AND
	        A.COD_PLANTARIF     =  B.COD_PLANTARIF  AND
	        B.COD_PRODUCTO  = 1                     AND
	        ROWNUM = 1;

	        EXCEPTION WHEN NO_DATA_FOUND THEN
                           bRESULTADO:='FALSE';
                           vMENSAJE:='Cliente Destino no encontrado ';
                  WHEN OTHERS  THEN
                           bRESULTADO:='FALSE';
                           vMENSAJE:='Error de Acceso ';
           END;
	ELSE

	   BEGIN
	        SELECT A.COD_PLANTARIF,B.COD_TIPLAN
	        into
	        scod_pland,scod_tipland
	        FROM GA_ABOCEL A,TA_PLANTARIF B
	        WHERE
	        A.COD_CLIENTE   = nCOD_CLIENTED    AND
	        A.COD_CUENTA    = nCOD_CUENTAD     AND
	        A.COD_PLANTARIF = B.COD_PLANTARIF  AND
	        B.COD_PRODUCTO  = 1                AND
	        ROWNUM = 1;

		EXCEPTION WHEN NO_DATA_FOUND THEN
	                           --bRESULTADO:='FALSE'; --Modificación - GBM/Soporte - 04-09-2006 - CO-200608260346
	                           --vMENSAJE:='Error Plan Tarifario no existe.'; --Modificación - GBM/Soporte - 04-09-2006 - CO-200608260346
	                           bRESULTADO:='TRUE'; --Modificación - GBM/Soporte - 04-09-2006 - CO-200608260346
	                  WHEN OTHERS  THEN
	                           bRESULTADO:='FALSE';
	                           vMENSAJE:='Error de Acceso ';
	  END;
	END IF;



        IF scod_ACTUACI = 'RO' OR scod_ACTUACI = 'R2' THEN
	   if ((scod_pland != scod_plan)  and ((sTIPLANTARIFD = 'E' and sTIPLANTARIF = 'E') or (sTIPLANTARIFD = 'E' and sTIPLANTARIF = 'I') or (sTIPLANTARIFD = 'I' and sTIPLANTARIF = 'E')))then
           	  bRESULTADO:='FALSE';
           	  vMENSAJE :='No se puede realizar la operación mediante esta orden de servicio, debido a que ella implica un cambio de plan. Este cambio se debe realizar por la orden de servicio Cambio de plan con reordenamiento de cuenta.';
           end if;
        END IF;

-- Inicio Modificación - GBM/Soporte - 04-09-2006 - CO-200608260346
BEGIN
SELECT VAL_PARAMETRO
INTO SVALHIBRIDO
FROM GED_PARAMETROS
WHERE NOM_PARAMETRO='HAB_OPER_HIB_TRASABO'
AND COD_MODULO='GA'
AND COD_PRODUCTO=1;
-- Fin Modificación - GBM/Soporte - 04-09-2006 - CO-200608260346

      IF scod_ACTUACI = 'AE' OR scod_ACTUACI = 'A2' THEN

	    -- Inicio Modificación - GBM/Soporte - 04-09-2006 - CO-200608260346
	    IF rtrim(scod_tiplan) =  '3' AND SVALHIBRIDO='TRUE' THEN
		   bRESULTADO:='FALSE';
		   vMENSAJE:='Para planes cuenta controlada, no está permitida esta operación de' ||
		   ' Cambio de plan con Reordenamiento de cuenta.';
	    ELSE
	       -- Fin Modificación - GBM/Soporte - 04-09-2006 - CO-200608260346
	          if (scod_pland = scod_plan  and  sTIPLANTARIFD = 'E' and sTIPLANTARIF = 'E' )then
	            bRESULTADO:='FALSE';
	            vMENSAJE:='El Plan Tarifario del Cliente Destino debe ser Distinto';

			     /*

				 else
	                   if (rtrim(scod_tiplan) =  '3' and  sTIPLANTARIFD = 'E') then
	                         bRESULTADO:='FALSE';
	             vMENSAJE:='No puede realizar esta Solicitud cuando el cliente origen posee un plan Tarifario Hibrido' ||
	                                      ' y el destino posee un plan tarifario empresa';
	                   end if;

	                   if (rtrim(scod_tiplan) =  '3' and  sTIPLANTARIFD = 'I') then
	                          bRESULTADO:='FALSE';
	              vMENSAJE:='No puede realizar esta Solicitud cuando el cliente origen posee un plan Tarifario Hibrido' ||
	                                      ' y el destino posee un plan tarifario individual';
	              end if;

				*/
	          end if;

          -- Inicio Modificación - GBM/Soporte - 04-09-2006 - CO-200608260346
          END IF;
          -- Fin Modificación - GBM/Soporte - 04-09-2006 - CO-200608260346

        END IF;

-- Inicio Modificación - GBM/Soporte - 04-09-2006 - CO-200608260346
IF (scod_ACTUACI = 'TP' OR scod_ACTUACI = 'T2') AND (rtrim(scod_tiplan) =  '3') AND (scod_pland != scod_plan) AND (SVALHIBRIDO='TRUE') THEN
	bRESULTADO:='FALSE';
	vMENSAJE :='Para planes cuenta controlada, no está permitida esta operación de Traspaso.';
END IF;

EXCEPTION WHEN NO_DATA_FOUND THEN
   bRESULTADO:='FALSE';
   vMENSAJE:='Error Parámetro HAB_OPER_HIB_TRASABO no configurado.';
END;
-- Fin Modificación - GBM/Soporte - 04-09-2006 - CO-200608260346

END PV_VALPLANTIPPLAN_PR;
/
SHOW ERRORS
