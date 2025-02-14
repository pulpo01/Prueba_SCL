CREATE OR REPLACE PROCEDURE        P_DEL_LIMITECLIABO(
  VP_ABONADO IN     NUMBER ,
  VP_ERROR   IN OUT VARCHAR2 )
IS
--
-- Procedimiento de borrado de limites de consumo ligados al abonado
-- afectados por transacciones de ventas incompletas.
--
-- Los valores del codigo de retorno (VP_ERROR), seran los siguientes :
--         - "0" ; Los limites de consumo han sido borrados correctamente
--         - "4" ; Error en el proceso interno
--
BEGIN
    DELETE GA_LIMITE_CLIABO_TO
     WHERE NUM_ABONADO  = VP_ABONADO 
  and cod_cliente = ( select cod_cliente from ga_abocel where num_abonado = VP_ABONADO ); 
EXCEPTION
   WHEN OTHERS THEN
        VP_ERROR := '4';
END;
/
SHOW ERRORS
