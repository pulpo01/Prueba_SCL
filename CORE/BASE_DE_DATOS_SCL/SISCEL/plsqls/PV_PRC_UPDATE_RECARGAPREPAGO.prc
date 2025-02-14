CREATE OR REPLACE PROCEDURE        PV_PRC_UPDATE_RECARGAPREPAGO(
v_num_movimiento	  	in NUMBER,
v_num_abonado			in NUMBER,
v_cod_actabo			in VARCHAR2,
v_cod_producto			in NUMBER
)
as
v_error				varchar2(4);
v_msgerror			varchar2(500);
BEGIN
    UPDATE PV_HISTRECARGAPREPAGO_TH
	SET IND_ESTADO=2
    WHERE NUM_MOVIMIENTO  		= v_num_movimiento;
EXCEPTION
   WHEN OTHERS THEN
        V_ERROR    := SQLCODE;
		V_MSGERROR := SQLERRM;
		INSERT INTO GA_ERRORES(COD_ACTABO, CODIGO, FEC_ERROR, COD_PRODUCTO,
		                       NOM_PROC,NOM_TABLA,
							   COD_ACT, COD_SQLCODE, COD_SQLERRM)
		            VALUES(v_cod_actabo,v_num_abonado,sysdate,v_cod_producto,
					       'PV_PRC_UPDATE_RECARGAPREPAGO','PV_HISTRECARGAPREPAGO_TH',
						   'U',V_ERROR,v_msgerror);
END;
/
SHOW ERRORS
