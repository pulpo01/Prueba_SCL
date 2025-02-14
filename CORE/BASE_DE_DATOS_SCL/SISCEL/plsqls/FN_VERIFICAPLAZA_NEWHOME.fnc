CREATE OR REPLACE FUNCTION FN_VERIFICAPLAZA_NEWHOME (sCodPlaza in VARCHAR2, sCodRegion IN VARCHAR2, sCodProvincia IN VARCHAR2, sCodCiudad IN VARCHAR2)
/******************************************************************************
CREADO   : 17/12/2002
AUTOR    : SANDRA PINTO / MANUEL ACEVEDO
AREA     : POSTVENTA
******************************************************************************/
RETURN VARCHAR2 IS

sCodPlazaNEW ge_ciudades.cod_plaza%type;

sMsgError varchar2(200);
sRetorno varchar2(100);

BEGIN

        sRetorno := '';

                sMsgError := 'Error, al obtener plaza del Nuevo Home. Region : ' || sCodRegion || ', Provincia: ' || sCodProvincia || ', Ciudad : ' || sCodCiudad;

                select cod_plaza
                into   sCodPlazaNEW
                from   ge_ciudades
                where  cod_region = sCodRegion
                and    cod_provincia = sCodProvincia
                and    cod_ciudad = sCodCiudad;

        if sCodPlaza <> sCodPlazaNEW then
                   sRetorno := 'Error, Ciudad no es compatible con la nueva plaza del Cliente.';
                end if;

        return sRetorno;

EXCEPTION
WHEN OTHERS THEN
   RETURN sMsgError;
END;
/
SHOW ERRORS
