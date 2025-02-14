CREATE OR REPLACE FUNCTION Fn_Obtiene_OperCliente (sCodCliente in NUMBER)
/******************************************************************************
CREADO   : 16/12/2002
AUTOR    : SANDRA PINTO ZAMORA
AREA     : POSTVENTA
EMPRESA  : TELEFONICA MOVIL SOLUTION S.A.
******************************************************************************/


RETURN VARCHAR2 IS

sMsgError varchar2(200);

sCodOperadora ge_clientes.COD_OPERADORA%type; --variable que retorna el codigo de la plaza

BEGIN

        sCodOperadora := '';
        sMsgError := 'Error, al obtener codigo operadora para el cliente: ' || sCodCliente;

        select a.cod_operadora
        into sCodOperadora
        from ge_clientes a
        where a.cod_cliente = sCodCliente;

        return sCodOperadora;

EXCEPTION
WHEN OTHERS THEN
   RETURN sMsgError;
END;
/
SHOW ERRORS
