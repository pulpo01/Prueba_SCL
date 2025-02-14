CREATE OR REPLACE FUNCTION GE_NUMERO_OPERADORA_FN(NUM_CELULAR IN ga_abocel.num_celular%type) RETURN VARCHAR2
IS
-- *************************************************************
-- * Funcion               : Prefijo de numero telefonico para NIR (Num Ident Region)
-- * Salida                        : Prefijo de numero de telefonico para NIR
-- * Descripcion           : Funcion que retorna un 1 (True) si existe el prefijo de un numero telefonico
-- *                         correspondiente a su rango NIR y 0 (False) en caso contrario
-- * Fecha de creacion     : 24 de Enero de 2003
-- * Responsable           : Erika Vadell
-- *************************************************************
NUM_DESDE ga_celnum_subalm.NUM_DESDE%TYPE;
BEGIN

   if num_celular is null then
        raise_application_error(-20101, 'No se ha ingresado numero celular....');
   end if;

   BEGIN
       select num_tdesde into NUM_DESDE
           from   ta_numnacional
           where  num_celular between num_tdesde and num_thasta
		   and    cod_operador in (1,2,3,4,5);

EXCEPTION
       WHEN no_data_found THEN
                Return 0;  -- False
   END;

   if NUM_DESDE is not null then
      Return 1;  -- True
   else
      Return 0;  -- False
   end if;

END GE_NUMERO_OPERADORA_FN;
/
SHOW ERRORS
