CREATE OR REPLACE FORCE VIEW co_gestion (cod_cliente,
                                                cod_cuenta,
                                                cod_tipident,
                                                num_ident,
                                                cod_gestion,
                                                fec_gestion,
                                                obs_gestion,
                                                nom_usuario,
                                                fec_ultmod,
                                                cod_ciclo,
                                                cod_tipmor
                                               )
AS
   SELECT cod_cliente, cod_cuenta, cod_tipident, num_ident, cod_gestion,
          fec_gestion, obs_gestion, nom_usuario, fec_ultmod, cod_ciclo,
          cod_tipmor
     FROM co_gestion_to
    WHERE cod_tipmor = 'MOROS'
          WITH CHECK OPTION
/
SHOW ERRORS          