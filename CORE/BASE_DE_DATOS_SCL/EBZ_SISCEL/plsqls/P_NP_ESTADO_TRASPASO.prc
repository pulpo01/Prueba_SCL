CREATE OR REPLACE PROCEDURE            P_NP_ESTADO_TRASPASO
(vp_cod_estado_flujo      OUT npt_parametro.valor_parametro%TYPE
,vp_err                   OUT NUMBER
)
as
vp_valor_parametro      npt_parametro.valor_parametro%TYPE;
BEGIN
        vp_err := 0;
        SELECT valor_parametro
    INTO vp_valor_parametro
    FROM npt_parametro
    WHERE alias_parametro = 'ESTSISL';
        vp_cod_estado_flujo   := TO_NUMBER(vp_valor_parametro);
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
               VP_ERR:= SQLCODE;
      WHEN OTHERS then
               VP_ERR:= SQLCODE;
END;
/
SHOW ERRORS
