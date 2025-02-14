CREATE OR REPLACE FUNCTION Fn_Obtiene_PlazaCliente (sCodCliente in NUMBER)
/******************************************************************************
CREADO   : 03/12/2002
AUTOR    : JOAN ZAMORANO J.
AREA     : POSTVENTA
EMPRESA  : TELEFONICA MOVIL SOLUTION S.A.
******************************************************************************/


RETURN VARCHAR2 IS
sValParametro ged_parametros.VAL_PARAMETRO%type;
nCodDireccion ga_direccli.COD_DIRECCION%type;
sCodRegion ge_direcciones.COD_REGION%type;
sCodProvincia ge_direcciones.COD_PROVINCIA%type;
sCodCiudad ge_direcciones.COD_CIUDAD%type;
sMsgError varchar2(200);

sCodPlaza ge_ciudades.COD_PLAZA%type; --variable que retorna el codigo de la plaza

BEGIN
        sMsgError := 'Error, al obtener val_parametro para nom_parametro = TIP_DIREC_FACT';

        select val_parametro
        into sValParametro
        from ged_parametros
        where cod_modulo='GA'
        and cod_producto=1
        and nom_parametro='TIP_DIREC_FACT';

        sMsgError := 'Error, al obtener codigo de plaza para el cliente: ' || sCodCliente;

        select a.cod_plaza
        into sCodPlaza
        from ge_ciudades a, ge_direcciones b, ga_direccli c
        where c.cod_cliente = sCodCliente and
        c.cod_tipdireccion= sValParametro and
        c.cod_direccion = b.cod_direccion and
        b.cod_region = a.Cod_Region       and
        b.cod_provincia = a.Cod_Provincia and
        b.cod_ciudad = a.Cod_Ciudad;

        return sCodPlaza;

EXCEPTION
WHEN OTHERS THEN
   RETURN sMsgError;
END;
/
SHOW ERRORS
