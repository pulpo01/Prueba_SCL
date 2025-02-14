CREATE OR REPLACE PACKAGE BODY VE_Utilitarios_PG IS

        PROCEDURE VE_RegistroDefault_Error_PR(EV_nomPackage   IN  VARCHAR2,
                                              EV_nomProcedure IN  VARCHAR2,
                                              EV_sql          IN  VARCHAR2,
                                              EN_CodRetorno   IN  NUMBER,
                                              EV_LabelError   IN  VARCHAR2,
                                              SN_cod_retorno  OUT NOCOPY ge_errores_pg.CodError,
                                              SV_mens_retorno OUT NOCOPY ge_errores_pg.MsgError,
                                              SN_num_evento   OUT NOCOPY ge_errores_pg.Evento) IS

        LV_desError     ge_errores_pg.desevent;
        BEGIN
             SN_num_evento:=0;
                 SN_cod_retorno := EN_CodRetorno;
             IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                SV_mens_retorno := CV_ERROR_NO_CLASIF;
             END IF;
             LV_desError := EV_LabelError || EV_nomPackage || '.' || EV_nomProcedure || ';- ' || SQLERRM;
             SN_num_evento := Ge_Errores_Pg.Grabarpl(SN_num_evento,
                                                     CV_MODULO_GA,
                                                     SV_mens_retorno,
                                                     '1.0',
                                                      USER,
                                                      EV_nomPackage||'.'||EV_nomProcedure,
                                                      EV_sql,
                                                      SQLCODE,
                                                      LV_desError);

        END VE_RegistroDefault_Error_PR;
END VE_Utilitarios_PG;


/
SHOW ERRORS
