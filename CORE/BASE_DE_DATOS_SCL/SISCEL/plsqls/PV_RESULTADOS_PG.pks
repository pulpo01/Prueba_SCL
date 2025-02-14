CREATE OR REPLACE PACKAGE PV_RESULTADOS_PG IS

        PROCEDURE PV_RESULTADO_PR
        (
          EV_transac in varchar2,
          EN_cod_cliente in number
        );

        PROCEDURE PV_RESULTADO_DOS_PR
        (
          EV_transac in varchar2,
          EN_cod_cliente in number
        );

        PROCEDURE PV_RESULTADO_PR
        (
          EV_transac in varchar2,
          EN_cod_cliente in number,
          EN_num_abonado in GA_ABOCEL.NUM_ABONADO%TYPE
        );


END PV_RESULTADOS_PG;
/
SHOW ERRORS
