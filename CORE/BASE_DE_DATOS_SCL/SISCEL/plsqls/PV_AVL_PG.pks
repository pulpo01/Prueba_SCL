CREATE OR REPLACE PACKAGE PV_AVL_PG

IS

GV_des_error              ge_errores_pg.DesEvent;
GV_sSql                   ge_errores_pg.vQuery;
GV_version                CONSTANT VARCHAR2(5)  := '1.0';

CN_err_ejecutar_servicio  NUMBER(3)     := 302;
CN_err_cambio_estado      NUMBER(6)     := 200610;
CN_alta_bd                CONSTANT NUMBER(1)     := 1;
CN_alta_centrales         CONSTANT NUMBER(1)     := 2;
CN_baja_bd                CONSTANT NUMBER(1)     := 3;
CN_baja_centrales         CONSTANT NUMBER(1)     := 4;
CN_baja_abonado           CONSTANT NUMBER(1)     := 5;

CN_ind_avlini             CONSTANT NUMBER(1)     := 0;
CN_ind_avlaprov           CONSTANT NUMBER(1)     := 1;

CN_cero                   CONSTANT PLS_INTEGER  := 0;
CV_error_no_clasif        CONSTANT VARCHAR2(30) := 'Error no clasificado';

CV_cod_modulo             CONSTANT VARCHAR2(2)  := 'GA';
CN_cod_producto           CONSTANT NUMBER(1)    := 1;


----------------------------------------------------------------------------------------------------------------------
PROCEDURE PV_MARCAR_SERIE_AVL_PR
          (
          EN_num_abonado   IN  icc_movimiento.num_abonado%TYPE,
          EV_num_imei      IN  icc_movimiento.imei%TYPE
          );
----------------------------------------------------------------------------------------------------------------------
END;
/
SHOW ERRORS
