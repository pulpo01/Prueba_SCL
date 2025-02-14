CREATE OR REPLACE FUNCTION Fn_Obtiene_PlazaOficina (sCodOficina in VARCHAR2)
/******************************************************************************
CREADO   : 09/01/2003
AUTOR    : PAMELA GONZALEZ P.
AREA     : VENTAS
EMPRESA  : TELEFONICA MOVIL SOLUTION S.A.
******************************************************************************/


RETURN VARCHAR2 IS
nCodDireccion ge_direcciones.COD_DIRECCION%type;
sCodRegion ge_direcciones.COD_REGION%type;
sCodProvincia ge_direcciones.COD_PROVINCIA%type;
sCodCiudad ge_direcciones.COD_CIUDAD%type;
sMsgError varchar2(200);

sCodPlaza ge_ciudades.COD_PLAZA%type; --variable que retorna el codigo de la plaza de la Oficina

BEGIN

        sMsgError := 'Error, al obtener codigo de plaza para la oficina: ' || sCodOficina;

        select a.cod_plaza
        into sCodPlaza
        from ge_ciudades a, ge_direcciones b, ge_oficinas c
        where c.cod_oficina = sCodOficina and
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
