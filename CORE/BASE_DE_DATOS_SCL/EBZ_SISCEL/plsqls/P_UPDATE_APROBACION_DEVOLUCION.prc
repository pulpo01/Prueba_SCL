CREATE OR REPLACE procedure P_UPDATE_APROBACION_DEVOLUCION
(vp_cod_devolucion        in npt_devolucion.cod_devolucion%TYPE
,vp_cod_mensaje           out npt_mensaje.cod_mensaje%TYPE
,vp_not_cre_devolucion    in npt_devolucion.not_cre_devolucion%TYPE
,vp_cod_estado_flujo      in npt_estado_devolucion.cod_estado_flujo%TYPE
,vp_cod_usuario_cre       in npt_estado_devolucion.cod_usuario_cre%TYPE
,vp_cod_usuario_ing       in npt_estado_devolucion.cod_usuario_ing%TYPE
,vp_cod_motivo_rechazo    in npt_estado_devolucion.cod_motivo_rechazo%TYPE
,vp_obs_est_devolucion    in npt_estado_devolucion.obs_est_devolucion%TYPE
,vp_mot_rechazo           in number
)
as
/*
<NOMBRE>           : P_UPDATE_APROBACION_DEVOLUCION   .</NOMBRE>
<FECHACREA>        : <FECHACREA/>
<MODULO >          : AL </MODULO >
<AUTOR >       :  </AUTOR >
<VERSION >     : 1.0</VERSION >
<DESCRIPCION>  : Procedimiento encargado actualizar estados al momento de aprobar una devolución</DESCRIPCION>
<FECHAMOD >    : 27/06/2006 </FECHAMOD >
<DESCMOD >     : Optimizar los accesos que se realizan a la tabla NPT_ESTADO_PEDIDO Inc MA-200606190940  </DESCMOD >
<VERSIONMOD>   : 1.1</VERSIONMOD>
<FECHAMOD >    : 13/08/2009 </FECHAMOD >
<DESCMOD >     : Modificación a PL para: P-MIX-09003-Guatemala-Salvador   </DESCMOD >
<AUTOR>        : Z.M.H. </AUTORMOD>
<VERSIONMOD>   : 1.2</VERSIONMOD>

*/
 Cursor cLeePedidoDevol is
   select distinct COD_PEDIDO from npt_detalle_devolucion
   where cod_devolucion  = vp_cod_devolucion;

v_fec_ing_devolucion        DATE;
vp_cod_usuario_des          number;
v_COD_ESTADO_FLUJO          npt_estado_pedido.COD_ESTADO_FLUJO%TYPE;
v_FEC_CRE_EST_PEDIDO        npt_estado_pedido.FEC_CRE_EST_PEDIDO%TYPE;

BEGIN
  select sysdate into v_fec_ing_devolucion from dual;
  update npt_devolucion set
  not_cre_devolucion = vp_not_cre_devolucion
  where cod_devolucion = vp_cod_devolucion;
  insert into npt_estado_devolucion (cod_devolucion, fec_cre_est_devolucion, cod_usuario_cre,
    cod_usuario_ing, cod_motivo_rechazo, cod_estado_flujo, fec_inf_est_devolucion, obs_est_devolucion)
  values (vp_cod_devolucion, sysdate, vp_cod_usuario_cre, vp_cod_usuario_ing, vp_cod_motivo_rechazo,
    vp_cod_estado_flujo, sysdate, vp_obs_est_devolucion);
  select cod_usuario_cre into vp_cod_usuario_des from npt_devolucion
  where cod_devolucion = vp_cod_devolucion;
  select np_seq_mensaje.nextval into vp_cod_mensaje from dual;
  insert into npt_mensaje (cod_mensaje, cod_usuario_ori, cod_usuario_des, fec_mensaje, tip_mensaje,
    cod_estado_flujo, num_peddevrec, est_mensaje)
  values (vp_cod_mensaje, vp_cod_usuario_cre, vp_cod_usuario_des, v_fec_ing_devolucion, 'D',
    vp_cod_estado_flujo, vp_cod_devolucion, 'V');

-- P-MIX-09003-Guatemala-Salvador, este proceso se trraslado al PL: VE_DEVOLUCION_PEDIDO_PG.DEVOLUCION_PEDIDO
-- al momento de procesar un pedido, ZMH 13/08/2009
    
/*    
  if vp_mot_rechazo = 0 then
    FOR vLeePedidoDevol IN cLeePedidoDevol
    LOOP

       select COD_ESTADO_FLUJO, FEC_CRE_EST_PEDIDO into v_COD_ESTADO_FLUJO, v_FEC_CRE_EST_PEDIDO
       from npt_estado_pedido
       where cod_pedido = vLeePedidoDevol.COD_PEDIDO
       and FEC_CRE_EST_PEDIDO = (select max(FEC_CRE_EST_PEDIDO) from npt_estado_pedido
       where cod_pedido = vLeePedidoDevol.COD_PEDIDO and nvl(cod_pedido,cod_pedido) > 0);

       update npt_estado_pedido set
          COD_ESTADO_FLUJO = 49
       where cod_pedido = vLeePedidoDevol.COD_PEDIDO
       and   FEC_CRE_EST_PEDIDO = v_FEC_CRE_EST_PEDIDO;

       delete NPT_SERIE_PEDIDO
       where (COD_SERIE_PEDIDO,cod_pedido,lin_det_pedido) in
       (select COD_SERIE_PEDIDO,cod_pedido,lin_det_pedido
       from NPT_DETALLE_DEVOLUCION
       where cod_devolucion = vp_cod_devolucion
       and   cod_pedido = vLeePedidoDevol.COD_PEDIDO);

       update npt_estado_pedido set
          COD_ESTADO_FLUJO = v_COD_ESTADO_FLUJO
       where cod_pedido = vLeePedidoDevol.COD_PEDIDO
       and   FEC_CRE_EST_PEDIDO = v_FEC_CRE_EST_PEDIDO;

    End Loop;
  end if;
  */
END P_UPDATE_APROBACION_DEVOLUCION;  
/
SHOW ERRORS