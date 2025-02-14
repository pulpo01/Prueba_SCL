CREATE OR REPLACE PROCEDURE PV_INFESTADOGEST_PR(

    v_param_entrada IN  VARCHAR2,
    bRESULTADO      OUT VARCHAR2,
    vMENSAJE        OUT GA_TRANSACABO.DES_CADENA%TYPE )
IS
-- PL/SQL Specification
--
-- *************************************************************
-- * procedimiento      : PV_INFESTADOGEST_PR
-- * Descripcion        : Informa Estado al Gestor
-- *
-- * Fecha de creacion  : 13-01-2004
-- * Responsable        : Area Postventa
-- *************************************************************

        string GE_TABTYPE_VCH2ARRAY:= GE_TABTYPE_VCH2ARRAY('','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');

        V_MODULO             PV_MOV_IDGESTOR_TO.COD_MODULO%TYPE;
		V_IDTAREA			 PV_MOV_IDGESTOR_TO.ID_GESTOR%TYPE;
		V_ABONADO			 GA_ABOCEL.NUM_ABONADO%TYPE;

BEGIN
         GE_PAC_ArregloPR.GE_PR_RetornaArreglo(v_param_entrada, string);

		 V_ABONADO:=TO_NUMBER(string(5));
         V_MODULO:=LTRIM(RTRIM(string(22)));
		 V_IDTAREA:=TO_NUMBER(string(23));

         bRESULTADO:='TRUE';

 	     IF V_MODULO IS NOT NULL OR LTRIM(RTRIM(V_MODULO)) <> '' THEN
		    PV_INFORMAR_ESTADO_TAFI_PR(V_MODULO,V_IDTAREA,V_ABONADO,NULL,'ASIGNADA','ASIGNADA');
		 END IF;

END;
/
SHOW ERRORS
