CREATE OR REPLACE FUNCTION AL_FN_PREFIJO_NUMERO(NUM_CELULAR IN ga_abocel.num_celular%type) RETURN VARCHAR2
IS
-- *************************************************************
-- * Funcion               : Prefijo de numero telefonico
-- * Salida                : Prefijo de numero de telefonico
-- * Descripcion           : Funcion que retorna el prefijo de un numero telefonico correspondiente a su rango
-- * Fecha de creacion     : 05 de Junio de 2002
-- * Responsable           : Juan Carlos Godoy Velez
-- *************************************************************

/*
<NOMBRE>       : AL_FN_PREFIJO_NUMERO
<FECHACREA>    : 05-06-2002
<MODULO >      : gENERAL </MODULO >
<AUTOR >       : Juan Carlos Godoy Velez>
<VERSION >     : 1.1>
<DESCRIPCION>  : Funcion que retorna el prefijo de un numero telefonico correspondiente a su rango.
<FECHAMOD >    : 14/08/2006 </FECHAMOD >
<DESCMOD >     : Por problemas de perfonmance, se obtiene el MIN desde la tabla ged_parametros.</DESCMOD >
<ParamEntr>    : Numero de celular</ParamEntr>
<ParamSal >    : prefijo del numero numero de celular    (solo si es función o procedimiento) </ParamEntr>
*/

NUM_MIN ga_celnum_subalm.NUM_MIN%TYPE;
BEGIN

   if num_celular is null then
        raise_application_error(-20101, 'No se ha ingresado numero celular....');
   end if;

   BEGIN
        --Incidencia CO-200608110308 C.A.A.D. Inicio

        --select num_min into NUM_MIN
        --from   ga_celnum_subalm
        --where  num_celular between num_desde and num_hasta;

        SELECT val_parametro INTO NUM_MIN
        FROM ged_parametros
        WHERE nom_parametro = 'VAL_MIN_FIJO'
        AND cod_modulo = 'AL'
        AND cod_producto = 1;

        --Incidencia CO-200608110308 C.A.A.D. Termino

   EXCEPTION
       WHEN no_data_found THEN
                  raise_application_error(-20102, 'Numero no existe en Tabla de SubAlm');
   END;

   Return num_min;

END AL_FN_PREFIJO_NUMERO;
/
SHOW ERRORS
