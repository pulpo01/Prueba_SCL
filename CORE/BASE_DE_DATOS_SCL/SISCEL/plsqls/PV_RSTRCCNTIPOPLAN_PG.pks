CREATE OR REPLACE PACKAGE Pv_Rstrccntipoplan_Pg AS

PROCEDURE PV_Prepago_PR( 
                                  EV_param_entrada IN         VARCHAR2,
                                SV_resultado     OUT NOCOPY VARCHAR2,
                                SV_mensaje       OUT NOCOPY ga_transacabo.des_cadena%TYPE);

PROCEDURE PV_Hibrido_PR( 
                                  EV_param_entrada IN         VARCHAR2,
                                SV_resultado     OUT NOCOPY VARCHAR2,
                                SV_mensaje       OUT NOCOPY ga_transacabo.des_cadena%TYPE
                            );
                            
PROCEDURE PV_Postpago_PR( 
                                  EV_param_entrada IN         VARCHAR2,
                                SV_resultado     OUT NOCOPY VARCHAR2,
                                SV_mensaje       OUT NOCOPY ga_transacabo.des_cadena%TYPE
                            );
                                
END Pv_Rstrccntipoplan_Pg; 
/
SHOW ERRORS
