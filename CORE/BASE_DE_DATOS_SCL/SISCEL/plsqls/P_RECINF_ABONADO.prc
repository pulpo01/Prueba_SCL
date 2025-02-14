CREATE OR REPLACE PROCEDURE        P_RECINF_ABONADO (
   vp_producto   IN       NUMBER,
   vp_abonado    IN       NUMBER,
   vp_holding    IN OUT   VARCHAR2,
   vp_empresa    IN OUT   VARCHAR2,
   vp_venta      IN OUT   NUMBER,
   vp_error      IN OUT   VARCHAR2
)
IS
--
-- Procedimiento de recuperacion de datos de abonados/producto
-- afectados por transacciones de ventas incompletas.
--
-- Los valores del codigo de retorno (VP_ERROR), seran los siguientes :
--         - "0" ; La informacion ha sido recuperada correctamente
--         - "4" ; Error en el proceso interno de recuperacion
--
BEGIN
   IF vp_producto = 1
   THEN
      BEGIN
         SELECT a.cod_holding, a.cod_empresa, a.num_venta
           INTO vp_holding, vp_empresa, vp_venta
           FROM (SELECT cod_holding, cod_empresa, num_venta
                   FROM ga_abocel
                  WHERE num_abonado = vp_abonado
                 UNION
                 SELECT cod_holding, cod_empresa, num_venta
                   FROM ga_aboamist
                  WHERE num_abonado = vp_abonado) a;
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            BEGIN
               SELECT num_venta
                 INTO vp_venta
                 FROM ga_aborent
                WHERE num_abonado = vp_abonado;
            EXCEPTION
               WHEN OTHERS
               THEN
                  DELETE      ga_transacventa
                        WHERE num_abonado = vp_abonado;
            END;
      END;
   ELSIF vp_producto = 2
   THEN
      SELECT cod_holding, cod_empresa, num_venta
        INTO vp_holding, vp_empresa, vp_venta
        FROM ga_abobeep
       WHERE num_abonado = vp_abonado;
   ELSIF vp_producto = 3
   THEN
      SELECT cod_holding, cod_empresa, num_venta
        INTO vp_holding, vp_empresa, vp_venta
        FROM ga_abotrunk
       WHERE num_abonado = vp_abonado;
   ELSIF vp_producto = 4
   THEN
      SELECT cod_holding, cod_empresa, num_venta
        INTO vp_holding, vp_empresa, vp_venta
        FROM ga_abotrek
       WHERE num_abonado = vp_abonado;
   END IF;
EXCEPTION
   WHEN OTHERS
   THEN
      DELETE      ga_transacventa
            WHERE num_abonado = vp_abonado;
END;
/
SHOW ERRORS
