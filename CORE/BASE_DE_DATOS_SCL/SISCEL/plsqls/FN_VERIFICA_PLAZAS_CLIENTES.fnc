CREATE OR REPLACE FUNCTION           Fn_Verifica_Plazas_Clientes (sCodCliente1 in VARCHAR2, sCodCliente2 IN VARCHAR2)
/******************************************************************************
CREADO   : 13/12/2002
AUTOR    : SANDRA PINTO ZAMORA
AREA     : POSTVENTA
EMPRESA  : TELEFONICA MOVIL SOLUTION S.A.
******************************************************************************/


RETURN VARCHAR2 IS
sValParametro ged_parametros.VAL_PARAMETRO%type;
sMsgError varchar2(200);

sCodPlazaClie1 ge_ciudades.cod_plaza%type;
sCodPlazaClie2 ge_ciudades.cod_plaza%type;

sRetorno varchar2(5); --variable que retorna el codigo de la plaza

BEGIN

        sRetorno := '';

        sMsgError := 'Error, al obtener val_parametro para nom_parametro = TIP_DIREC_FACT';

        select val_parametro
        into sValParametro
        from ged_parametros
        where cod_modulo='GA'
        and cod_producto=1
        and nom_parametro='TIP_DIREC_FACT';

        sMsgError := 'Error, al obtener codigo de plaza para el cliente1: ' || sCodCliente1;

        select a.cod_plaza
        into sCodPlazaClie1
        from ge_ciudades a, ge_direcciones b, ga_direccli c
        where c.cod_cliente = sCodCliente1 and
        c.cod_tipdireccion= sValParametro and
        c.cod_direccion = b.cod_direccion and
        b.cod_region = a.Cod_Region       and
        b.cod_provincia = a.Cod_Provincia and
        b.cod_ciudad = a.Cod_Ciudad;

        sMsgError := 'Error, al obtener codigo de plaza para el cliente2: ' || sCodCliente2;

        select a.cod_plaza
        into sCodPlazaClie2
        from ge_ciudades a, ge_direcciones b, ga_direccli c
        where c.cod_cliente = sCodCliente2 and
        c.cod_tipdireccion= sValParametro and
        c.cod_direccion = b.cod_direccion and
        b.cod_region = a.Cod_Region       and
        b.cod_provincia = a.Cod_Provincia and
        b.cod_ciudad = a.Cod_Ciudad;

        if sCodPlazaClie1 <> sCodPlazaClie2 then
                   return 'Error, plazas de ambos clientes no son compatibles.';
                end if;

        return sRetorno;

EXCEPTION
WHEN OTHERS THEN
   RETURN sMsgError;
END;
/
SHOW ERRORS
