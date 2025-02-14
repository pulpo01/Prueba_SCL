CREATE OR REPLACE FORCE VIEW al_vcertificado_ingreso (num_orden_sap,
                                                      num_orden,
                                                      cod_proveedor,
                                                      nom_proveedor,
                                                      num_orden_ref,
                                                      fec_creacion,
                                                      fec_historico,
                                                      cod_moneda,
                                                      cod_articulo,
                                                      des_articulo,
                                                      unidad,
                                                      can_servida,
                                                      total,
                                                      usuario
                                                     )
AS
   SELECT al_cabecera_ordenes1.num_orden_sap, al_cabecera_ordenes2.num_orden,
          al_cabecera_ordenes2.cod_proveedor, al_proveedores.nom_proveedor,
          al_cabecera_ordenes2.num_orden_ref,
          TO_CHAR (al_cabecera_ordenes1.fec_creacion, 'DD-MM-YYYY'),
          TO_CHAR (NULL, 'DD-MM-YYYY HH24:MI:SS'),
          al_cabecera_ordenes2.cod_moneda, al_lineas_ordenes2.cod_articulo,
          al_articulos.des_articulo, 'UN',
          NVL (al_lineas_ordenes2.can_orden, 0),
            NVL (al_lineas_ordenes2.prc_unidad, 0)
          * NVL (al_lineas_ordenes2.can_orden, 0),
          al_cabecera_ordenes2.usu_creacion
     FROM al_cabecera_ordenes2 al_cabecera_ordenes2,
          al_proveedores al_proveedores,
          al_cabecera_ordenes1 al_cabecera_ordenes1,
          al_lineas_ordenes2 al_lineas_ordenes2,
          al_articulos al_articulos
    WHERE al_cabecera_ordenes2.tip_orden = 2
      AND al_cabecera_ordenes2.cod_proveedor = al_proveedores.cod_proveedor(+)
      AND al_cabecera_ordenes2.num_orden_ref = al_cabecera_ordenes1.num_orden(+)
      AND al_cabecera_ordenes1.tip_orden = 1
      AND al_cabecera_ordenes2.num_orden = al_lineas_ordenes2.num_orden
      AND al_lineas_ordenes2.tip_orden = 2
      AND al_lineas_ordenes2.cod_articulo = al_articulos.cod_articulo(+)
   UNION
   SELECT al_hcabecera_ordenes1.num_orden_sap,
          al_hcabecera_ordenes2.num_orden,
          al_hcabecera_ordenes2.cod_proveedor, al_proveedores.nom_proveedor,
          al_hcabecera_ordenes2.num_orden_ref,
          TO_CHAR (al_hcabecera_ordenes1.fec_creacion, 'DD-MM-YYYY'),
          TO_CHAR (al_hcabecera_ordenes1.fec_historico,
                   'DD-MM-YYYY HH24:MI:SS'
                  ),
          al_hcabecera_ordenes2.cod_moneda, al_hlineas_ordenes2.cod_articulo,
          al_articulos.des_articulo, 'UN',
          NVL (al_hlineas_ordenes2.can_orden, 0),
            NVL (al_hlineas_ordenes2.prc_unidad, 0)
          * NVL (al_hlineas_ordenes2.can_orden, 0),
          al_hcabecera_ordenes2.usu_creacion
     FROM al_hcabecera_ordenes2 al_hcabecera_ordenes2,
          al_proveedores al_proveedores,
          al_hcabecera_ordenes1 al_hcabecera_ordenes1,
          al_hlineas_ordenes2 al_hlineas_ordenes2,
          al_articulos al_articulos
    WHERE al_hcabecera_ordenes2.tip_orden = 2
      AND al_hcabecera_ordenes2.cod_proveedor = al_proveedores.cod_proveedor(+)
      AND al_hcabecera_ordenes2.num_orden_ref = al_hcabecera_ordenes1.num_orden(+)
      AND al_hcabecera_ordenes1.tip_orden = 1
      AND al_hcabecera_ordenes2.num_orden = al_hlineas_ordenes2.num_orden
      AND al_hlineas_ordenes2.tip_orden = 2
      AND al_hlineas_ordenes2.cod_articulo = al_articulos.cod_articulo(+)
/
SHOW ERRORS


