CREATE OR REPLACE PROCEDURE PV_VALIDA_INFACCEL_PR ( v_param_entrada IN  VARCHAR2,
                                                    bRESULTADO      OUT VARCHAR2,
                                                    vMENSAJE        OUT GA_TRANSACABO.DES_CADENA%TYPE
                                                   )
IS
    string GE_TABTYPE_VCH2ARRAY:= GE_TABTYPE_VCH2ARRAY('','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');

    v_cod_cliente           GA_INFACCEL.COD_CLIENTE%TYPE;
    v_num_abonado           GA_INFACCEL.NUM_ABONADO%TYPE;
    n_cant                  NUMBER;

BEGIN
    GE_PAC_ArregloPR.GE_PR_RetornaArreglo(v_param_entrada, string);
    v_cod_cliente             :=TO_NUMBER(string(6));
    v_num_abonado             :=TO_NUMBER(string(5));

    SELECT COUNT(1)
	  INTO n_cant
      FROM ga_infaccel
     WHERE cod_cliente = v_cod_cliente
       AND num_abonado = v_num_abonado
       AND cod_ciclfact = (SELECT cod_ciclfact
                             FROM fa_ciclfact a, ga_abocel b
                            WHERE a.cod_ciclo = b.cod_ciclo
                              AND a.ano = (SELECT TO_CHAR (SYSDATE, 'YY')
                                             FROM DUAL)
                              AND a.fec_desdellam < SYSDATE
                              AND a.fec_hastallam > SYSDATE
                              AND b.num_abonado   = v_num_abonado);

	IF NOT (n_cant > 0)  THEN
	   bRESULTADO:='FALSE';
	   vMENSAJE  :='ABONADO: . NO TIENE PERIODO DE FACTURACIÛN VIGENTE. NO PUEDE ACTIVAR/DESACTIVAR SERVICIOS SUPLEMENTARIOS.';
	ELSE
	   bRESULTADO:='TRUE';
	END IF;


	EXCEPTION
        WHEN OTHERS  THEN
            dbms_output.PUT_LINE(SQLERRM);
            bRESULTADO:='FALSE';
            vMENSAJE  :='Error de Acceso ';


END PV_VALIDA_INFACCEL_PR;
/
SHOW ERRORS
