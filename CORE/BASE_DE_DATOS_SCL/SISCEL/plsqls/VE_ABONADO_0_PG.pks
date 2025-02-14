CREATE OR REPLACE PACKAGE ve_abonado_0_pg

IS

        PROCEDURE ve_valida_abonado_pr
                (
                 en_cod_cliente ga_abocel.cod_cliente%TYPE
                ,sn_cod_validacion OUT NOCOPY NUMBER
                ,sn_cod_respuesta OUT NOCOPY NUMBER
                ,sv_mensaje_respuesta OUT NOCOPY VARCHAR2
                );

        PROCEDURE ve_registra_cargobasico_pr
                (
                 en_cod_cliente                          ga_abocel.cod_cliente%TYPE
                ,en_num_abonado                                  ga_abocel.num_abonado%TYPE
                ,sn_cod_respuesta         OUT NOCOPY NUMBER
                ,sv_mensaje_respuesta OUT NOCOPY VARCHAR2
                );

        FUNCTION ve_valida_abonado_fn
                (en_cod_cliente ga_abocel.cod_cliente%TYPE)
        RETURN NUMBER;

END;
/
SHOW ERRORS
