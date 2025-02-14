CREATE OR REPLACE PROCEDURE PV_PRC_VALFECCUMPLA_ABONADO(
--Verifica si existe OoSs pendiente
          v_param_entrada IN  VARCHAR2,
          bRESULTADO      OUT VARCHAR2,
          vMENSAJE        OUT GA_TRANSACABO.DES_CADENA%TYPE
) IS

     string GE_TABTYPE_VCH2ARRAY:= GE_TABTYPE_VCH2ARRAY('','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');

---- parametros reales de entrada --------------

     nCLIENTE    GA_ABOCEL.COD_CLIENTE%TYPE;
     nABONADO    GA_ABOCEL.NUM_ABONADO%TYPE;

------------------------------------------------

     vCantidad         NUMBER(3);
     vCantidad_AUX     NUMBER(3);


BEGIN

     GE_PAC_ArregloPR.GE_PR_RetornaArreglo(v_param_entrada, string);
     nCLIENTE       := -1;
     nCLIENTE       := TO_NUMBER(string(6));
     nABONADO       := TO_NUMBER(string(5));

     bRESULTADO  := 'TRUE';
     vMENSAJE   := 'OK';
     vCantidad   := 0;


     BEGIN

         SELECT COUNT(1) INTO vCantidad_AUX
         FROM GA_EMPRESA
         WHERE cod_cliente = nCLIENTE;

         IF  vCantidad_AUX > 0 THEN

                     BEGIN

                             SELECT COUNT(1) INTO vCantidad
                             FROM GA_ABOCEL
                             WHERE cod_cliente = nCLIENTE
                             AND FEC_CUMPLAN >SYSDATE;


                             If vCantidad > 0 Then
                                    bRESULTADO := 'FALSE';
                                    vMENSAJE   := 'SE ENCONTRO ABONADO CON FECHA DE CUMPLIMIENTO DE PLAN FUTURA';
                             Else
                                bRESULTADO := 'TRUE';
                                vMENSAJE   := 'NO SE ENCONTRO ABONADOS CON FECHA DE CUMPLIMIENTO DE PLAN FUTURA';
                             End If;

                     EXCEPTION
                             WHEN NO_DATA_FOUND THEN
                                  bRESULTADO := 'TRUE';
                                  vMENSAJE   := 'NO SE ENCONTRO ABONADOS CON FECHA DE CUMPLIMIENTO DE PLAN FUTURA';
                     END;
          ELSE
                    BEGIN

                             SELECT COUNT(1) INTO vCantidad
                             FROM GA_ABOCEL
                             WHERE cod_cliente =  nCLIENTE AND
                                   NUM_ABONADO =  nABONADO AND
                                   FEC_CUMPLAN >SYSDATE;


                             If vCantidad > 0 Then
                                    bRESULTADO := 'FALSE';
                                    vMENSAJE   := 'SE ENCONTRO ABONADO CON FECHA DE CUMPLIMIENTO DE PLAN FUTURA';
                             Else
                                bRESULTADO := 'TRUE';
                                vMENSAJE   := 'NO SE ENCONTRO ABONADOS CON FECHA DE CUMPLIMIENTO DE PLAN FUTURA';
                             End If;

                     EXCEPTION
                             WHEN NO_DATA_FOUND THEN
                                  bRESULTADO := 'TRUE';
                                  vMENSAJE   := 'NO SE ENCONTRO ABONADOS CON FECHA DE CUMPLIMIENTO DE PLAN FUTURA';
                     END;


          END IF;

    END;
END;
/
SHOW ERRORS
