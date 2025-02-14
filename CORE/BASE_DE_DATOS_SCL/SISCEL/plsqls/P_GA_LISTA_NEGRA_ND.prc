CREATE OR REPLACE PROCEDURE P_GA_LISTA_NEGRA_ND IS

        vcod_cliente  gat_equipos_devdif.cod_cliente%TYPE;
        vnum_abonado  gat_equipos_devdif.num_abonado%TYPE;
        vnum_serie    gat_equipos_devdif.num_serie%TYPE;
        vcod_tipmov   gat_equipos_devdif.cod_tipmov%TYPE;
        vcodoperador  ta_datosgener.cod_operador%TYPE;
        vvalparametro ged_parametros.val_parametro%TYPE;
        error_proceso EXCEPTION;

        CURSOR cgat_equipos_devdif (cvalparametro   ged_parametros.val_parametro%TYPE) IS
        SELECT cod_cliente,
                   num_abonado,
                   num_serie,
                   cod_tipmov
        FROM  gat_equipos_devdif
        WHERE cod_estado_dev = 'ND'
        AND       fec_maxima_dev + cvalparametro < SYSDATE;

-- *************************************************************
-- * procedimiento      : P_GA_LISTA_NEGRA_ND
-- * Descripcion        : Ingresa a listas negras equipos con
-- *                      plazo de devolucion vencido
-- * Fecha de creacion  : Noviembre 2002
-- * Responsable        : Pedro Salas Sanfurgo CRM
-- *************************************************************

BEGIN
     -- Obtengo la Cantidad de Dias Maximo para devolucion
     vvalparametro := GE_FN_DEVVALPARAM('GA',1,'NUM_DIAS_MAXDEV');

         --Capturo Codigo Operador
     SELECT cod_operador
     INTO vcodoperador
     FROM ta_datosgener;

         OPEN cgat_equipos_devdif (vvalparametro);
         LOOP
                 FETCH cgat_equipos_devdif INTO vcod_cliente,vnum_abonado,vnum_serie,vcod_tipmov;

                 EXIT WHEN cgat_equipos_devdif%NOTFOUND;

             INSERT INTO ga_lncelu (num_serie, ind_procequi, cod_operador, cod_fabricante,
                                            cod_articulo, num_seriemec, num_celular, num_abonado,
                                                        cod_cliente, fec_alta)
         SELECT a.num_serie, b.ind_procequi, vcodoperador, c.cod_fabricante,
                            b.cod_articulo, b.num_seriemec, a.num_celular, a.num_abonado,
                                a.cod_cliente, SYSDATE
                 FROM  ga_habocel a, ga_hequipaboser b, al_articulos c
                 WHERE a.num_abonado  = vnum_abonado
                 AND   a.num_serie    = vnum_serie
                 AND   a.cod_cliente  = vcod_cliente
                 AND   a.num_abonado  = b.num_abonado
                 AND   a.num_serie    = b.num_serie
                 AND   b.cod_articulo = c.cod_articulo;

         -- Cambio el estado
         UPDATE gat_equipos_devdif
                 SET   cod_estado_dev = 'LN'
                 WHERE cod_cliente = vcod_cliente
                 AND   num_abonado = vnum_abonado
                 AND   num_serie   = vnum_serie
                 AND   cod_tipmov  = vcod_tipmov;

                 COMMIT;
     END LOOP;

         CLOSE cgat_equipos_devdif;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
                dbms_output.put_line(SQLCODE ||' '||SQLERRM);
    WHEN OTHERS THEN
        dbms_output.put_line(SQLCODE ||' '||SQLERRM);
                ROLLBACK;
END;
/
SHOW ERRORS
