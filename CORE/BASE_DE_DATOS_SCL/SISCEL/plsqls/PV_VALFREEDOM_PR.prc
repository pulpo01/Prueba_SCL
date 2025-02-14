CREATE OR REPLACE PROCEDURE PV_VALFREEDOM_PR(
        v_param_entrada IN  VARCHAR2,
    bRESULTADO      OUT VARCHAR2,
    vMENSAJE        OUT GA_TRANSACABO.DES_CADENA%TYPE

        )
IS
-- PL/SQL Specification
--
-- *************************************************************
-- * procedimiento      : PV_VALFREEDOM_PR
-- * Descripcion        : Valida plan Freedom
-- *
-- * Fecha de creacion  : 13-01-2003 12:46
-- * Responsable        : Area Postventa
-- *************************************************************

   string GE_TABTYPE_VCH2ARRAY:= GE_TABTYPE_VCH2ARRAY('','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
     retorno              varchar2(2);
        sval_parametro       ged_parametros.val_parametro%TYPE;
        nCodCliOrig                      GE_CLIENTES.COD_CLIENTE%TYPE;


BEGIN
         GE_PAC_ArregloPR.GE_PR_RetornaArreglo(v_param_entrada, string);
     nCodCliOrig                        := TO_NUMBER(string(5));

         bRESULTADO:='TRUE';

     select val_parametro
     into sval_parametro
         from ged_parametros
     where nom_parametro = 'IND_OPERPROPCVTA'
     and cod_producto    = 1
     and cod_modulo      = 'GA';

     retorno :=pv_plan_freedom_pk.pv_verifica_plan_freedom_fn(nCodCliOrig);

         if retorno = 'SI' then
                bRESULTADO:='FALSE';
                vMENSAJE:='El cliente tiene asociado Plan Freedom';
         end if;


EXCEPTION WHEN NO_DATA_FOUND THEN
                           bRESULTADO:='FALSE';
                           vMENSAJE:='No se encuentra Parametrizado Planes Freedom';
              WHEN OTHERS  THEN
                           bRESULTADO:='FALSE';
                           vMENSAJE:='Error de Acceso ';

END PV_VALFREEDOM_PR;
/
SHOW ERRORS
