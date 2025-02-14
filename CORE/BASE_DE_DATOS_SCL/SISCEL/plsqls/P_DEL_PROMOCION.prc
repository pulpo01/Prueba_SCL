CREATE OR REPLACE PROCEDURE P_DEL_PROMOCION(
  VP_ABONADO IN NUMBER ,
  VP_CLIENTE IN NUMBER ,
  VP_ERROR IN OUT VARCHAR2 )
IS
--
-- Procedimiento de borrado de los beneficios asignados a
-- un abonado por ventas incompletas
--
-- Los valores del codigo de retorno (VP_ERROR), seran los siguientes :
--         - "0" ; Los seguros han sido borrados correctamente
--         - "4" ; Error en el proceso interno
--
BEGIN
   DELETE FROM bpt_beneficiarios
   WHERE cod_cliente = VP_CLIENTE
     AND num_abonado = VP_ABONADO;

   DELETE FROM bpt_beneficios
   WHERE cod_cliente = VP_CLIENTE
     AND num_abonado = VP_ABONADO;

EXCEPTION
   WHEN OTHERS THEN
        VP_ERROR := '4';
END;
/
SHOW ERRORS
