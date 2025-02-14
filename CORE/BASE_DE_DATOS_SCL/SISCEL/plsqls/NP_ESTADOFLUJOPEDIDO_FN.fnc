CREATE OR REPLACE FUNCTION NP_ESTADOFLUJOPEDIDO_FN (p_cod_pedido varchar2) RETURN VARCHAR2 is

 v_cod_estado_flujo npt_estado_pedido.COD_ESTADO_FLUJO%type;
/*
<NOMBRE>          : NP_ESTADOFLUJOPEDIDO_FN</NOMBRE>
<FECHACREA>       : 01/03/2003<FECHACREA/>
<MODULO>          : VE</MODULO>
<AUTOR>       : </AUTOR>
<VERSION>     : 1.0</VERSION >
<DESCRIPCION>  : Funcion que chequea el estado del pedido</DESCRIPCION>
<FECHAMOD>    : 23/06/2006 </FECHAMOD>
<DESCMOD>     : Optimizar los accesos que se realizan a la tabla NPT_ESTADO_PEDIDO Inc MA-200606190940 </DESCMOD>
<VERSIONMOD>     : 1.1</VERSIONMOD>
*/

 BEGIN

 select cod_estado_flujo into v_cod_estado_flujo
 from   npt_estado_pedido
 where  cod_pedido=p_cod_pedido
            and fec_cre_est_pedido=(select max(fec_cre_est_pedido)
                                                           from   npt_estado_pedido
                                                           where  cod_pedido=p_cod_pedido and nvl(cod_pedido,cod_pedido) > 0);  --Inc MA-200606190940 ipct

 RETURN v_cod_estado_flujo;

 EXCEPTION
        WHEN NO_DATA_FOUND THEN
           RETURN 'ERROR ' || 'NO SE ENCONTRO PEDIDO ' || p_cod_pedido || ' EN TABLA NPT_ESTADO_PEDIDO';
    WHEN OTHERS THEN
           RAISE_APPLICATION_ERROR(-20100, 'Error ' || to_char(SQLCODE) || ': ' || SQLERRM);

 end;
/
SHOW ERRORS
