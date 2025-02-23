CREATE OR REPLACE TRIGGER TA_TRG_AFUP_SERVESPE AFTER UPDATE ON TA_SERVESPECIALES FOR EACH ROW

BEGIN
   UPDATE GE_MULTIIDIOMA
      SET DES_CONCEPTO  = :new.des_servespecial,
          FEC_ULTMOD    = SYSDATE,
          NOM_USUARIO   = USER
    WHERE NOM_TABLA     = 'TA_SERVESPECIALES'
      AND NOM_CAMPO     = 'NUM_SERVESPECIAL'
      AND COD_PRODUCTO  = 0
      AND COD_CONCEPTO  = :new.num_servespecial
      AND COD_IDIOMA    = ge_fn_idioma_local()
      AND NOM_CAMPO_DES = 'DES_SERVESPECIAL' ;
END TA_TRG_AFUP_SERVESPE;
/
SHOW ERRORS
