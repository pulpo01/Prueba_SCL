CREATE OR REPLACE PACKAGE CO_PAGOSONLINE_PG IS
        PROCEDURE CO_OBTIENE_PARAMETRO_PR  (
                ev_cod_modulo       IN               ged_parametros.cod_modulo%TYPE,
                en_cod_producto     IN               ged_parametros.cod_producto%TYPE,
                ev_nom_parametro    IN               ged_parametros.nom_parametro%TYPE,
                sv_val_parametro    OUT NOCOPY       ged_parametros.val_parametro%TYPE,
                sn_cod_retorno      OUT NOCOPY       ge_errores_td.cod_msgerror%TYPE,
                sv_mens_retorno     OUT NOCOPY       ge_errores_td.det_msgerror%TYPE,
                sn_num_evento       OUT NOCOPY       ge_errores_pg.evento
        );

       PROCEDURE CO_OBTIENETRANSACCION_PR(SN_numtransaccion OUT NOCOPY CO_INTERFAZ_PAGOS.NUM_TRANSACCION%TYPE,
                                       SN_cod_error OUT NOCOPY NUMBER,
                                       SV_des_error OUT NOCOPY VARCHAR2,
                                       SN_cod_evento OUT NOCOPY NUMBER);

       PROCEDURE CO_OBTIENECAJA_PR(EV_emp IN CO_EMPRESAS_REX.EMP_RECAUDADORA%TYPE,
                                       SN_codcaja OUT NOCOPY CO_CAJAS.COD_CAJA%TYPE,
                                       SN_cod_error OUT NOCOPY NUMBER,
                                       SV_des_error OUT NOCOPY VARCHAR2,
                                       SN_cod_evento OUT NOCOPY NUMBER);

       PROCEDURE CO_OBTIENECLIENTE_PR(EN_numcelular IN GA_ABOCEL.NUM_CELULAR%TYPE,
                                       SN_codcliente OUT NOCOPY GA_ABOCEL.COD_CLIENTE%TYPE,
                                       SN_cod_error OUT NOCOPY NUMBER,
                                       SV_des_error OUT NOCOPY VARCHAR2,
                                       SN_cod_evento OUT NOCOPY NUMBER);

       PROCEDURE CO_SALDO_PR (EN_codcliente IN GA_ABOCEL.COD_CLIENTE%TYPE,
                                       SN_saldovencido OUT NOCOPY CO_CARTERA.IMPORTE_DEBE%TYPE,
                                       SN_saldoporvencer OUT NOCOPY CO_CARTERA.IMPORTE_DEBE%TYPE,
                                       SN_cod_error OUT NOCOPY NUMBER,
                                       SV_des_error OUT NOCOPY VARCHAR2,
                                       SN_cod_evento OUT NOCOPY NUMBER);


       PROCEDURE CO_SALDO_LIMITE_PR (EN_codcliente IN GA_ABOCEL.COD_CLIENTE%TYPE,
                                       SN_limitetarifario OUT NOCOPY CO_CARTERA.IMPORTE_DEBE%TYPE,
                                       SN_limiteadicional OUT NOCOPY CO_CARTERA.IMPORTE_DEBE%TYPE,
                                       SN_cod_error OUT NOCOPY NUMBER,
                                       SV_des_error OUT NOCOPY VARCHAR2,
                                       SN_cod_evento OUT NOCOPY NUMBER);

       PROCEDURE CO_NOMBRECLIENTE_PR (EN_codcliente IN GA_ABOCEL.COD_CLIENTE%TYPE,
                                       SV_nomcliente OUT NOCOPY GE_CLIENTES.NOM_CLIENTE%TYPE,
                                       SV_apecliente OUT NOCOPY GE_CLIENTES.NOM_APECLIEN1%TYPE,
                                       SN_cod_error OUT NOCOPY NUMBER,
                                       SV_des_error OUT NOCOPY VARCHAR2,
                                       SN_cod_evento OUT NOCOPY NUMBER);

       PROCEDURE CE_APLICA_PAGO_PR (EV_codbanco IN ge_bancos.cod_banco%TYPE,
                                       EN_codcaja IN co_cajas.cod_caja%TYPE,
                                       EV_codservicio IN co_interfaz_pagos.ser_solicitado%TYPE,
                                       EV_fecefectividad IN VARCHAR2,
                                       EN_numtransaccion IN co_interfaz_pagos.num_transaccion%TYPE,
                                       EV_operador IN co_interfaz_pagos.nom_usuarora%TYPE,
                                       EV_tiptransaccion IN co_interfaz_pagos.tip_transaccion%TYPE,
                                       EV_subtipo IN co_interfaz_pagos.sub_tip_transac%TYPE,
                                       EN_codservicio IN co_interfaz_pagos.cod_servicio%TYPE,
                                       EN_numejercicio IN co_interfaz_pagos.num_ejercicio%TYPE,
                                       EN_codcliente IN co_interfaz_pagos.cod_cliente%TYPE,
                                       EN_numcelular IN co_interfaz_pagos.num_celular%TYPE,
                                       EN_mtopago IN co_interfaz_pagos.mto_debe%TYPE,
                                       EV_numfolio IN co_interfaz_pagos.num_folioctc%TYPE,
                                       EN_tipvalor IN co_interfaz_pagos.tip_valor%TYPE,
                                       EN_numcheque IN co_interfaz_pagos.num_documento%TYPE,
                                       EV_bancocheque IN co_interfaz_pagos.cod_banco%TYPE,
                                       EV_ctacte IN co_interfaz_pagos.cta_corriente%TYPE,
                                       EV_autorizacion IN co_interfaz_pagos.cod_autoriza%TYPE,
                                       EN_numtarjeta IN co_interfaz_pagos.num_tarjeta%TYPE,
                                       EV_agencia IN co_interfaz_pagos.des_agencia%TYPE,
                                       EN_codoperacion IN co_interfaz_pagos.cod_operacion%TYPE,
                                       EN_numtransaccion_emp IN co_interfaz_pagos.num_transaccion_emp%TYPE,
                                       EN_codtiptarjeta IN co_interfaz_pagos.cod_tiptarjeta%TYPE,
                                       SN_cod_error OUT NOCOPY NUMBER,
                                       SV_des_error OUT NOCOPY VARCHAR2,
                                       SN_cod_evento OUT NOCOPY NUMBER);
                                       
       PROCEDURE CO_VALIDA_DATOSPAGO_PR(EN_num_transaccion IN co_interfaz_pagos.num_transaccion_emp%TYPE,
                                       EN_codcliente IN co_interfaz_pagos.cod_cliente%TYPE,
                                       EN_codbanco IN co_interfaz_pagos.emp_recaudadora%TYPE,       
                                       EN_fecpago IN VARCHAR2,
                                       EN_horpago IN VARCHAR2,
                                       EN_montopago IN co_interfaz_pagos.imp_pago%TYPE,
                                       SN_cod_error OUT NOCOPY NUMBER,
                                       SV_des_error OUT NOCOPY VARCHAR2,
                                       SN_cod_evento OUT NOCOPY NUMBER);        
                                                                              
       PROCEDURE CO_DESAPLICA_PAGO_PR( EN_numtransaccion IN co_interfaz_pagos.num_transaccion_emp%TYPE,
                                       SN_cod_error OUT NOCOPY NUMBER,
                                       SV_des_error OUT NOCOPY VARCHAR2,
                                       SN_cod_evento OUT NOCOPY NUMBER);                                             

END;
/
SHOW ERRORS