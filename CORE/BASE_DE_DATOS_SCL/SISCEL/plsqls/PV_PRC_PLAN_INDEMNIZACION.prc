CREATE OR REPLACE PROCEDURE        PV_PRC_PLAN_INDEMNIZACION(vp_abonado           in number,
                                                                    vp_pencontra        out varchar2,
                                                                        vp_tipindem                     out varchar2
                              )
IS
  -- Retorna el valor a cobrar segun el plan de indemnizacion del abonados
  --

  --Declaracion de Variables
  v_plan_indemnizacion pv_plan_indemnizacion_td.cod_plan_indemnizacion%type;
  v_cuenta                         ga_abocel.cod_cuenta%type;
  v_contrato               ga_abocel.num_contrato%type;
  v_anexo                          ga_abocel.num_anexo%type;
  v_tipContrato        ga_abocel.cod_tipcontrato%type;

  -- Variables Constantes
  cnsStandard   number:=0;
  cnsEscalonada number:=1;

BEGIN

        SELECT NVL(COD_INDEMNIZACION,0),COD_CUENTA, NUM_ANEXO, NUM_CONTRATO,COD_TIPCONTRATO
          INTO v_plan_indemnizacion,v_cuenta,v_anexo,v_contrato,v_tipcontrato
          FROM GA_ABOCEL
         WHERE NUM_ABONADO   = vp_abonado
           AND COD_SITUACION not in ('BAA','BAP');

    vp_tipindem := to_char(v_plan_indemnizacion);

    IF v_plan_indemnizacion = cnsStandard THEN


       SELECT to_char(C.COD_PENALIZA)
             INTO vp_pencontra
         FROM GA_PERCONTRATO C, GA_CONTCTA B
        WHERE B.COD_CUENTA       = v_cuenta
          AND B.NUM_CONTRATO (+) = v_contrato
          AND B.NUM_ANEXO    (+) = v_anexo
          AND B.COD_TIPCONTRATO  = C.COD_TIPCONTRATO (+)
          AND B.NUM_MESES        = C.NUM_MESES       (+)
          AND B.COD_PRODUCTO     = C.COD_PRODUCTO    (+);

        ELSIF v_plan_indemnizacion = cnsEscalonada THEN

                  vp_pencontra := v_tipcontrato;

        END IF;


EXCEPTION
                 WHEN NO_DATA_FOUND THEN
                          vp_pencontra := '';

END;
/
SHOW ERRORS
