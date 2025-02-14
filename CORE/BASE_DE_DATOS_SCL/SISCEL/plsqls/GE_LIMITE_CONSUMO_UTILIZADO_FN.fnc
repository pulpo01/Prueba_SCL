CREATE OR REPLACE FUNCTION GE_LIMITE_CONSUMO_UTILIZADO_FN(
cliente in tol_acumula_to.COD_CLIENTE%TYPE,
abonado in tol_acumula_to.COD_ABONADO%TYPE,
limite in tol_acumula_to.COD_LIMITE%TYPE,
fectasa in tol_acumula_to.FEC_TASA%TYPE,
ciclo in tol_acumula_to.COD_CICLO%TYPE) RETURN tol_acumula_to.NIV_CONSUMO%TYPE is

v_niv_consumo      tol_acumula_to.NIV_CONSUMO%TYPE;

BEGIN

   SELECT niv_consumo
   INTO v_niv_consumo
   FROM tol_acumula_to
   WHERE cod_cliente = cliente
   AND (cod_abonado = abonado or cod_abonado = 0)
   AND cod_limite = limite
   AND fec_tasa = fectasa
   AND cod_ciclo = ciclo;

   RETURN v_niv_consumo;

   exception
      when no_data_found then
	  	   RETURN NULL;
      when others then
            RAISE_APPLICATION_ERROR (-20100,'ERROR : '|| TO_CHAR(SQLCODE) ||' ' || SQLERRM);
END;
/
SHOW ERRORS
