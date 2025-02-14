CREATE OR REPLACE PROCEDURE PV_VALEMPCLI_PR (
    v_param_entrada IN  VARCHAR2,
    bRESULTADO      OUT VARCHAR2,
    vMENSAJE        OUT GA_TRANSACABO.DES_CADENA%TYPE
        )
IS
-- PL/SQL Specification
--
-- *************************************************************
-- * procedimiento      : PV_VALEMPCLI_PR
-- * Descripcion        : Valida si el Cliente esta definido como empresa
-- *
-- * Fecha de creacion  : 13-01-2003 12:46
-- * Responsable        : Area Postventa
-- *************************************************************

        string GE_TABTYPE_VCH2ARRAY:= GE_TABTYPE_VCH2ARRAY('','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');

        ncod_empresa             GA_EMPRESA.COD_EMPRESA%TYPE;
        ncod_ciclo               GA_EMPRESA.COD_CICLO%TYPE;
        scod_plantarif           GA_EMPRESA.COD_PLANTARIF%TYPE;
        ncod_num_abonados        GA_EMPRESA.NUM_ABONADOS%TYPE;
        nCodCliDest                              GA_EMPRESA.COD_CLIENTE%TYPE;

BEGIN

         GE_PAC_ArregloPR.GE_PR_RetornaArreglo(v_param_entrada, string);
     nCodCliDest                :=TO_NUMBER(STRING(16));

     bRESULTADO:='TRUE';
     dbms_output.PUT_LINE('CLIENTE   =' || nCodCliDest);

     SELECT COD_EMPRESA, COD_CICLO,
            COD_PLANTARIF, NUM_ABONADOS
         into
         ncod_empresa,ncod_ciclo,
         scod_plantarif,ncod_num_abonados
         FROM GA_EMPRESA
     WHERE COD_CLIENTE = nCodCliDest;



EXCEPTION WHEN NO_DATA_FOUND THEN
                           bRESULTADO:='FALSE';
                           vMENSAJE:='Faltan datos de la empresa del cliente';
              WHEN OTHERS  THEN
                           bRESULTADO:='FALSE';
                           vMENSAJE:='Error de Acceso ';


END PV_VALEMPCLI_PR;
/
SHOW ERRORS
