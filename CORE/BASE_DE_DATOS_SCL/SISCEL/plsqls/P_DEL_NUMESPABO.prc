CREATE OR REPLACE PROCEDURE P_DEL_NUMESPABO(
  VP_ABONADO IN NUMBER ,
  VP_ERROR IN OUT VARCHAR2 )
IS
--
-- Procedimiento de borrado de dias especiales de abonados
-- afectados por transacciones de ventas incompletas.
--
-- Los valores del codigo de retorno (VP_ERROR), seran los siguientes :
--         - "0" ; Los numeros han sido borrados correctamente
--         - "4" ; Error en el proceso interno
--
v_celular       ga_abocel.num_celular%TYPE;

BEGIN
    BEGIN
        SELECT num_celular
        INTO v_celular
        FROM ga_abocel
        WHERE num_abonado = VP_ABONADO;
    EXCEPTION
        WHEN NO_DATA_FOUND
        THEN
           SELECT num_celular
           INTO   v_celular
           FROM   ga_aboamist
           WHERE num_abonado = VP_ABONADO;
    END;

    DELETE ga_numespabo
    WHERE num_abonado = VP_ABONADO;

    DELETE ga_numespabo
    WHERE num_telefesp = to_char(v_celular);

EXCEPTION
   WHEN OTHERS THEN
        VP_ERROR := '4';
END;
/
SHOW ERRORS
