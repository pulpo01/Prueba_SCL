CREATE OR REPLACE PROCEDURE            P_NP_INSERT_ESTADO_FACTURA(
vp_cod_pedido           in npt_estado_pedido.cod_pedido%TYPE,
vp_cod_usuario_cre      in npt_estado_pedido.cod_usuario_cre%TYPE,
vp_cod_usuario_ing      in npt_estado_pedido.cod_usuario_ing%TYPE,
vp_num_venta            in ge_cargos.num_venta%TYPE,
vp_err                  out NUMBER
)
as
vp_cod_estado_flujo     npt_estado_pedido.cod_estado_flujo%TYPE;
vp_valor_parametro      npt_parametro.valor_parametro%TYPE;
BEGIN
   vp_err := 0;
   SELECT substr(valor_parametro, 1,2)
    INTO vp_valor_parametro
    FROM npt_parametro
   WHERE alias_parametro = 'ESTSISF';
  vp_cod_estado_flujo   := TO_NUMBER(vp_valor_parametro);
  INSERT INTO npt_estado_pedido
   (cod_pedido,
    fec_cre_est_pedido,
   cod_usuario_cre,
    cod_usuario_ing,
         cod_motivo_rechazo,
   cod_motivo_excepcion,
   cod_estado_flujo,
   fec_inf_est_pedido,
   obs_est_pedido)
  VALUES (vp_cod_pedido,
                sysdate,
    vp_cod_usuario_cre,
    vp_cod_usuario_ing,
   null,
    null,
   vp_cod_estado_flujo,
   sysdate,
   null);
  UPDATE npt_pedido
     SET num_doc_pedido =  vp_num_venta
     WHERE cod_pedido = vp_cod_pedido;
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
               VP_ERR:= SQLCODE;
     WHEN OTHERS then
               VP_ERR:= SQLCODE;
END;
/
SHOW ERRORS
