CREATE OR REPLACE PROCEDURE P_INSERT_DOCUMENTO_PED(
vp_cod_tipo_pago            in npt_documento.cod_tipo_pago%TYPE,
vp_cod_pedido               in npt_documento.cod_pedido%TYPE,
vp_cod_banco                in npt_documento.cod_banco%TYPE,
vp_num_documento            in npt_documento.num_documento%TYPE,
vp_mto_documento            in npt_documento.mto_documento%TYPE,
vp_fec_ven_documento        in varchar2,
vp_strError                 out nocopy varchar2
)
as
v_cod_documento             number;
v_fec_cre_documento         date;
BEGIN
  v_fec_cre_documento:=sysdate;
  select np_seq_docume.nextval into v_cod_documento from dual;
   begin
    insert into npt_documento (cod_documento, cod_tipo_pago, cod_pedido, cod_banco,
    fec_cre_documento, num_documento, mto_documento, fec_ven_documento)
    values (v_cod_documento, vp_cod_tipo_pago, vp_cod_pedido, vp_cod_banco,
    v_fec_cre_documento, vp_num_documento, vp_mto_documento, to_date(vp_fec_ven_documento, 'dd-mm-yyyy'));
  exception
    when dup_val_on_index then
	    vp_strError:= 'Error Registro duplicado en npt_documento';
    when others then
     	vp_strError := 'Error Entrada npt_documento ' || to_char(sqlcode);
  end;
END;
/
SHOW ERRORS
