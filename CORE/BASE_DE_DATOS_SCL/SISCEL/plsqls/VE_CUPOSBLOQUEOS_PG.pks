CREATE OR REPLACE PACKAGE ve_cuposbloqueos_pg
IS
        PROCEDURE ve_ins_cupbloq_pr
                   (EN_tipcomis                 IN ve_vendedores.cod_tipcomis%TYPE
                   ,EV_region                   IN ge_ciucom.cod_region%TYPE
                   ,EV_departamento             IN ge_ciucom.cod_provincia%TYPE
                   ,EV_distrito                 IN ge_ciucom.cod_ciudad%TYPE     DEFAULT NULL
                   ,EN_cod_vendedor             IN ve_vendedores.cod_vendedor%TYPE       DEFAULT NULL
                   ,EN_diapag                   IN ve_cupobloqueo_to.num_diapag%TYPE
                   ,EN_dialeg                   IN ve_cupobloqueo_to.num_dialeg%TYPE
                   ,EN_cant                     IN ve_cupobloqueo_to.can_dias%TYPE
                   ,EV_fecini                   IN VARCHAR2
                   ,EV_fecfin                   IN VARCHAR2
                   ,EV_tipven                   IN ve_cupobloqueo_to.tip_vendedor%TYPE
                   ,SN_cod_respuesta    OUT NOCOPY NUMBER
                   ,SN_msg_respuesta    OUT NOCOPY VARCHAR2
                   );

END ve_cuposbloqueos_pg;
/
SHOW ERRORS
