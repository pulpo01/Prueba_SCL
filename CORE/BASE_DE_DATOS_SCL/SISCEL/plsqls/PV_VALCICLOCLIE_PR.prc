CREATE OR REPLACE PROCEDURE PV_VALCICLOCLIE_PR(

        v_param_entrada IN  VARCHAR2,
    bRESULTADO      OUT VARCHAR2,
    vMENSAJE        OUT GA_TRANSACABO.DES_CADENA%TYPE

        )
IS
-- PL/SQL Specification
--
-- *************************************************************
-- * procedimiento      : PV_VALCICLOCLIE_PR
-- * Descripcion        : Valida que el cliente tenga ciclo de facturacion
-- *
-- * Fecha de creacion  : 13-01-2003 12:42
-- * Responsable        : Area Postventa
-- *************************************************************

        string GE_TABTYPE_VCH2ARRAY:= GE_TABTYPE_VCH2ARRAY('','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');

        ncod_ciclfact        FA_CICLFACT.COD_CICLFACT%TYPE;
        nCodCliOrig                      GE_CLIENTES.COD_CLIENTE%TYPE;

BEGIN
         GE_PAC_ArregloPR.GE_PR_RetornaArreglo(v_param_entrada, string);
     nCodCliOrig                        :=TO_NUMBER(string(6));

     bRESULTADO:='TRUE';

         SELECT COD_CICLFACT
         into ncod_ciclfact
         FROM FA_CICLFACT
         WHERE COD_CICLO = (SELECT COD_CICLO
                        FROM GE_CLIENTES
                        WHERE COD_CLIENTE = nCodCliOrig)
    AND SYSDATE BETWEEN FEC_DESDELLAM AND FEC_HASTALLAM;

EXCEPTION WHEN NO_DATA_FOUND THEN
                           bRESULTADO:='FALSE';
                           vMENSAJE:='Faltan datos del ciclo de facturacion del cliente';
              WHEN OTHERS  THEN
                           bRESULTADO:='FALSE';
                           vMENSAJE:='Error de Acceso ';
END PV_VALCICLOCLIE_PR;
/
SHOW ERRORS
