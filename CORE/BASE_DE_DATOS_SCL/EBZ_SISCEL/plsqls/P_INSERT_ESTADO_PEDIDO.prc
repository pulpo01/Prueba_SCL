CREATE OR REPLACE PROCEDURE p_insert_estado_pedido(
vp_cod_pedido                                   in npt_estado_pedido.cod_pedido%TYPE,
vp_cod_mensaje                       OUT npt_mensaje.cod_mensaje%TYPE,
vp_cod_usuario_cre                     in npt_estado_pedido.cod_usuario_cre%TYPE,
vp_cod_usuario_ing                     in npt_estado_pedido.cod_usuario_ing%TYPE,
vp_cod_motivo_rechazo                            in npt_estado_pedido.cod_motivo_rechazo%TYPE,
vp_cod_motivo_excepcion                     in npt_estado_pedido.cod_motivo_excepcion%TYPE,
vp_cod_estado_flujo              in npt_estado_pedido.cod_estado_flujo%TYPE,
vp_fec_inf_est_pedido                            in varchar2,
vp_obs_est_pedido                     in npt_estado_pedido.obs_est_pedido%TYPE,
envia_mensaje                                                        in varchar2
)
as
v_fec_rec_pedido           DATE;
vp_cod_usuario_des         number;
vExiste                    Number;
BEGIN

   select count(1) into vExiste from npt_estado_pedido -- Validación para que no se duplique el estado en un pedido, inc. 188858, ZMH, 10-10-2012
   where cod_pedido = vp_cod_pedido
   and  cod_estado_flujo = vp_cod_estado_flujo;

    If vExiste = 0 then
       select sysdate into v_fec_rec_pedido from dual;
       insert into npt_estado_pedido (cod_pedido, fec_cre_est_pedido, cod_usuario_cre, cod_usuario_ing,
        cod_motivo_rechazo, cod_motivo_excepcion, cod_estado_flujo, fec_inf_est_pedido, obs_est_pedido)
       values (vp_cod_pedido, sysdate, vp_cod_usuario_cre,        vp_cod_usuario_ing, vp_cod_motivo_rechazo,
                              vp_cod_motivo_excepcion,       vp_cod_estado_flujo,
                                      sysdate, vp_obs_est_pedido);
                                   -- to_date(vp_fec_inf_est_pedido,'dd-mm-yyyy hh24:mi'), vp_obs_est_pedido); inc. 188858, ZMH, 12-11-2012
       if envia_mensaje = 'RP' then
              select cod_usuario_eje into vp_cod_usuario_des from npt_pedido
              where cod_pedido = vp_cod_pedido;
              select np_seq_mensaje.nextval into vp_cod_mensaje from dual;
              insert into npt_mensaje (cod_mensaje, cod_usuario_ori, cod_usuario_des, fec_mensaje, tip_mensaje,
                     cod_estado_flujo, num_peddevrec, est_mensaje)
              values (vp_cod_mensaje, vp_cod_usuario_cre, vp_cod_usuario_des, v_fec_rec_pedido, 'P',
                     vp_cod_estado_flujo, vp_cod_pedido, 'V');
       end if;
       if envia_mensaje = 'AP' then
              select cod_usuario_cre into vp_cod_usuario_des from npt_pedido
              where cod_pedido = vp_cod_pedido;
              select np_seq_mensaje.nextval into vp_cod_mensaje from dual;
              insert into npt_mensaje (cod_mensaje, cod_usuario_ori, cod_usuario_des, fec_mensaje, tip_mensaje,
                     cod_estado_flujo, num_peddevrec, est_mensaje)
              values (vp_cod_mensaje, vp_cod_usuario_cre, vp_cod_usuario_des, v_fec_rec_pedido, 'P',
                     vp_cod_estado_flujo, vp_cod_pedido, 'V');
       end if;
    End if;       
END;
/
SHOW ERRORS
