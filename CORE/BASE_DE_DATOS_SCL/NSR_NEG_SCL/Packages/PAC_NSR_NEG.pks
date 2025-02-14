CREATE OR REPLACE PACKAGE PAC_NSR_NEG IS

   PROCEDURE P_CONS_NSR_NEG(
      v_nsr               IN     VARCHAR2,
      v_es_negativo       IN OUT BOOLEAN,
      v_cod_error         IN OUT NUMBER,
      v_des_error         IN OUT VARCHAR2);


   PROCEDURE P_CONS_OP_MOVISTAR(
      v_cod_operador      OUT    NUMBER,
      v_cod_error         IN OUT NUMBER,
      v_des_error         IN OUT VARCHAR2);

   PROCEDURE P_CONS_CAUSAS_GRALES(
      v_cod_causa_nsnegat OUT    NUMBER,
      v_cod_causa_fraude  OUT    NUMBER,
      v_cod_error         IN OUT NUMBER,
      v_des_error         IN OUT VARCHAR2);

   PROCEDURE P_CONS_FECSYS(
      v_fec_sys           OUT    DATE,
      v_cod_error         IN OUT NUMBER,
      v_des_error         IN OUT VARCHAR2);
END PAC_NSR_NEG;
/
SHOW ERROR