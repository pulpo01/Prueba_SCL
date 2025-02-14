CREATE OR REPLACE FUNCTION GE_PREFIJONIR_FN(NUM_CELULAR IN ga_abocel.num_celular%type) RETURN VARCHAR2
IS
-- *************************************************************
-- * Funcion               : Prefijo de numero telefonico para NIR (Num Ident Region)
-- * Salida                        : Prefijo de numero de telefonico para NIR
-- * Descripcion           : Funcion que retorna el prefijo de un numero telefonico correspondiente a su rango
-- *                         si es nulo devuelve un error
-- * Fecha de creacion     : 24 de Enero de 2003
-- * Responsable           : Erika Vadell
-- *************************************************************
NUM_NIR ga_celnum_subalm.NUM_NIR%TYPE;
BEGIN

   if num_celular is null then
        raise_application_error(-20101, 'No se ha ingresado numero celular....');
   end if;

   BEGIN
       select num_nir into NUM_NIR
           from   ga_celnum_subalm
           where  num_celular between num_desde and num_hasta;

           if NUM_NIR is null then
                raise_application_error(-20101, 'NIR para numero informado es Nulo....');
           end if;

           if ltrim(NUM_NIR) IS NULL then
                raise_application_error(-20101, 'NIR para numero informado no es valido....');
           end if;


   EXCEPTION
       WHEN no_data_found THEN
              raise_application_error(-20102, 'Numero no existe......');
   END;

   Return NUM_NIR;

END GE_PREFIJONIR_FN;
/
SHOW ERRORS
