CREATE OR REPLACE PACKAGE NP_DEVOLUCIONSERIES_PG
IS 
    PROCEDURE NP_VALI_SERIEDEVOLUCION_PR (
       v_cod_pedido in npt_detalle_devolucion.cod_pedido%TYPE,
       EV_strError out nocopy varchar
    );

    PROCEDURE NP_DETO_DEVOLTOTALPED_PR (
       v_cod_pedido in npt_detalle_devolucion.cod_pedido%type,
       v_DevProExi      in number,
       v_SerieKITActivo in number,
       EV_strError out nocopy varchar
    );

    PROCEDURE NP_ALDE_DEVOLTOTAL_PR (
       v_cod_Devolucion in npt_detalle_devolucion.cod_devolucion%type,
       v_cod_pedido     in npt_detalle_devolucion.cod_pedido%TYPE,
       v_cod_TipoDev    in npt_detalle_devolucion.cod_tipo_devolucion%type
    );

    PROCEDURE NP_ALDE_DEVOLPARCIAL_PR (
       v_cod_Devolucion in npt_detalle_devolucion.cod_devolucion%type,
       v_cod_pedido     in npt_detalle_devolucion.cod_pedido%TYPE,
       v_cod_TipoDev    in npt_detalle_devolucion.cod_tipo_devolucion%type
    );
    PROCEDURE NP_SEDE_VALIDASERIESDEV_PR(
       EN_cod_devolucion in NPT_DEVOLUCION.cod_devolucion%TYPE
    );
END NP_DEVOLUCIONSERIES_PG;
/
SHOW ERRORS
