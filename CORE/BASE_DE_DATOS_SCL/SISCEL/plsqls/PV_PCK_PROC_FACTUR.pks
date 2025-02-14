CREATE OR REPLACE PACKAGE Pv_Pck_Proc_Factur IS

    /*****************************************/
    /* POST-VENTA ACTIVA PROCESO FACTURACION */
    /*****************************************/
    PROCEDURE pv_act_proc_factur( mod_gener      IN  VARCHAR2,
                                  flg_comm       IN  VARCHAR2,
                                                                  flg_prioridad  IN  NUMBER,
                                                                  prioridad  IN  NUMBER,
                                  status         OUT VARCHAR2,
                                  error          OUT VARCHAR2,
                                                                  d_est_fina     OUT NUMBER);



    /********************************************************/
    /* POST-VENTA ACTIVA ORDEN DE SERVICIO PARA FACTURACION */
    /********************************************************/
    FUNCTION pv_act_ord_serv( num_proc IN NUMBER,
                              num_vent IN NUMBER,
                              cod_esta IN VARCHAR2,
                              num_foli IN NUMBER,
                                                          pref_plaza IN VARCHAR2,
                              ind_docu IN VARCHAR2,
                              fec_venc IN DATE,
                              nom_usua IN VARCHAR2,
                              cod_caus IN VARCHAR2,
                                                          tip_foliacion IN VARCHAR2) RETURN NUMBER;

END Pv_Pck_Proc_Factur;
/
SHOW ERRORS
