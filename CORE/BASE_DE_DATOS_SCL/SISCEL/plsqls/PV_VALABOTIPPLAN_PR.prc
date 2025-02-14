CREATE OR REPLACE PROCEDURE PV_VALABOTIPPLAN_PR (
    v_param_entrada IN  VARCHAR2,
    bRESULTADO      OUT VARCHAR2,
    vMENSAJE        OUT GA_TRANSACABO.DES_CADENA%TYPE
        )
IS
-- PL/SQL Specification
--
-- *************************************************************
-- * procedimiento      : PV_VALABOTIPPLAN_PR
-- * Descripcion        : Valida Inconsistencia del tipo de Plan Tarifario asociado al Cliente
-- *
-- * Fecha de creacion  : 13-01-2003 12:42
-- * Responsable        : Area Postventa
-- *************************************************************

        string GE_TABTYPE_VCH2ARRAY:= GE_TABTYPE_VCH2ARRAY('','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
        nCOD_CLIENTE             GA_ABOCEL.COD_CLIENTE%TYPE;
    ncount                   integer;
BEGIN
     GE_PAC_ArregloPR.GE_PR_RetornaArreglo(v_param_entrada, string);
         nCOD_CLIENTE        := TO_NUMBER(string(6));
         bRESULTADO:='TRUE';
         select count(*)
         into
         ncount
         from (select tip_plantarif
               from ga_abocel
                   where
                   cod_cliente  = nCOD_CLIENTE  and
                   cod_situacion not in ('BAA','BAP')
                   GROUP BY TIP_PLANTARIF);

         if ncount > 1 then
          bRESULTADO := 'FALSE';
          vMENSAJE   := 'Inconsistencia del tipo de Plan Tarifario asociado al Cliente';
     end if;


     EXCEPTION WHEN NO_DATA_FOUND THEN
                           bRESULTADO:='FALSE';
                           vMENSAJE:='El cliente presenta inconsistencia de tipo plan tarifario';
                   WHEN OTHERS  THEN
                           bRESULTADO:='FALSE';
                           vMENSAJE:='Error de Acceso';
END PV_VALABOTIPPLAN_PR;
/
SHOW ERRORS
