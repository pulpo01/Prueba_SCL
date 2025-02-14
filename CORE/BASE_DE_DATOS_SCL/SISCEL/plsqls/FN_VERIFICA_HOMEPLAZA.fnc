CREATE OR REPLACE FUNCTION           Fn_Verifica_HomePlaza (sCodCliente in VARCHAR2, sCodRegion IN VARCHAR2, sCodProvincia IN VARCHAR2, sCodCiudad IN VARCHAR2)
/******************************************************************************
CREADO   : 12/12/2002
AUTOR    : SANDRA PINTO ZAMOEA
AREA     : POSTVENTA
EMPRESA  : TELEFONICA MOVIL SOLUTION S.A.
******************************************************************************/


RETURN VARCHAR2 IS
sValParametro ged_parametros.VAL_PARAMETRO%type;
sMsgError varchar2(200);

sCodPlazaOficina ge_ciudades.cod_plaza%type;
sCodPlazaHome ge_ciudades.cod_plaza%type;

V_COD_OFICINA   GE_SEG_USUARIO.COD_OFICINA%TYPE;

V_COD_REGION    GE_CIUDADES.COD_REGION%TYPE;
V_COD_PROVINCIA GE_CIUDADES.COD_PROVINCIA%TYPE;
V_COD_CIUDAD    GE_CIUDADES.COD_CIUDAD%TYPE;


sRetorno varchar2(5); --variable que retorna el codigo de la plaza

BEGIN

        sRetorno := '';

        sMsgError := 'Error, al obtener Oficina del Usuario.';

		SELECT COD_OFICINA
		INTO   V_COD_OFICINA
		FROM   GE_SEG_USUARIO
		WHERE  NOM_USUARIO = USER;

        sMsgError := 'Error, al obtener Region, Provincia y Ciudad asociada a la oficina : ' || V_COD_OFICINA;

		SELECT B.COD_REGION, B.COD_PROVINCIA, B.COD_CIUDAD
		INTO   V_COD_REGION, V_COD_PROVINCIA, V_COD_CIUDAD
		FROM   GE_OFICINAS A,
			   GE_DIRECCIONES B
		WHERE  A.COD_OFICINA = V_COD_OFICINA
		AND	   A.COD_DIRECCION = B.COD_DIRECCION;

        sMsgError := 'Error, al obtener codigo de plaza para la oficina del Usuario. Oficina : ' || V_COD_OFICINA;

        select a.cod_plaza
        into   sCodPlazaOficina
        from   ge_ciudades a
        where  a.cod_region = V_COD_REGION
		and    a.cod_provincia = V_COD_PROVINCIA
		and    a.cod_ciudad = V_COD_CIUDAD;

        sMsgError := 'Error, al obtener codigo de plaza para el Home : Region : ' || sCodRegion || ', Provinicia : ' || sCodProvincia ||', Ciudad : ' || sCodCiudad;

        select cod_plaza
        into sCodPlazaHome
        from ge_ciudades
        where cod_region = sCodRegion     and
        cod_provincia = sCodProvincia     and
        cod_ciudad = sCodCiudad;

        if sCodPlazaOficina <> sCodPlazaHome then
           return 'Error, plaza de la oficina no es compatible con el Home seleccionado.';
        end if;
        return sRetorno;

EXCEPTION
WHEN OTHERS THEN
   RETURN sMsgError;
END;
/
SHOW ERRORS
