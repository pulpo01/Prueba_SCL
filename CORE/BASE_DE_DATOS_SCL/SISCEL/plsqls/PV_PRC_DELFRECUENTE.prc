CREATE OR REPLACE PROCEDURE        PV_PRC_DELFRECUENTE(
v_num_abonado	  	in NUMBER,
v_fec_ingreso   	in DATE
)
as
v_error				varchar2(4);
BEGIN
    DELETE PPT_NUMEROFRECUENTE
    WHERE NUM_ABONADO  		= v_num_abonado
    AND   FEC_MODIFICACION	= v_fec_ingreso;
EXCEPTION
   WHEN OTHERS THEN
        V_ERROR := sqlcode;
END;
/
SHOW ERRORS
