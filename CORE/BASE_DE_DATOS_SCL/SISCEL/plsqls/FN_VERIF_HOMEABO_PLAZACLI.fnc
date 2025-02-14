CREATE OR REPLACE FUNCTION           Fn_Verif_HomeAbo_PlazaCli (sNumAbonado in VARCHAR2, sCodCliente IN VARCHAR2)
/******************************************************************************
CREADO   : 13/12/2002
AUTOR    : SANDRA PINTO ZAMORA
AREA     : POSTVENTA
EMPRESA  : TELEFONICA MOVIL SOLUTION S.A.
******************************************************************************/


RETURN VARCHAR2 IS
sValParametro ged_parametros.VAL_PARAMETRO%type;
sMsgError varchar2(200);

sCodPlazaClie ge_ciudades.cod_plaza%type;
sCodPlazaHome ge_ciudades.cod_plaza%type;
sCodRegion    ge_ciudades.cod_region%type;
sCodProvincia ge_ciudades.cod_provincia%type;
sCodCiudad    ge_ciudades.cod_ciudad%type;

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

        sMsgError := 'Error, al obtener codigo de plaza para el cliente: ' || sCodCliente;

        select a.cod_plaza
        into sCodPlazaClie
        from ge_ciudades a, ge_direcciones b, ga_direccli c
        where c.cod_cliente = sCodCliente and
        c.cod_tipdireccion= sValParametro and
        c.cod_direccion = b.cod_direccion and
        b.cod_region = a.Cod_Region       and
        b.cod_provincia = a.Cod_Provincia and
        b.cod_ciudad = a.Cod_Ciudad;

        sMsgError := 'Error, al obtener codigo de plaza para el Home del Abonado : ' || sNumAbonado;

                select a.cod_plaza
                into sCodPlazaHome
                from ge_ciudades a,
                (select cod_region, cod_provincia, cod_ciudad
                from   ga_abocel
                where  num_abonado = sNumAbonado
                union
                select cod_region, cod_provincia, cod_ciudad
                from   ga_aboamist
                where  num_abonado = sNumAbonado) b
                where  a.cod_region = b.cod_region
                and    a.cod_provincia = b.cod_provincia
                and    a.cod_ciudad = b.cod_ciudad;

        if sCodPlazaClie <> sCodPlazaHome then
                   return 'Error, plaza del cliente no es compatible con el Home del abonado.';
                end if;

        return sRetorno;

EXCEPTION
WHEN OTHERS THEN
   RETURN sMsgError;
END;
/
SHOW ERRORS
