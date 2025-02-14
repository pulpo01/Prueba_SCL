CREATE OR REPLACE TRIGGER PV_TRG_GA_LNCELU
 BEFORE 
 INSERT
 ON GA_LNCELU
 REFERENCING OLD AS OLD NEW AS NEW
 FOR EACH ROW 
DECLARE
    iCount number;
    iContador number;
    sCausa ga_siniestros.cod_causa%type;
BEGIN


     select count(1) into icount
     from ga_siniestros
     where num_serie = :new.num_serie;

     IF iCount > 0 THEN

         SELECT COD_CAUSA INTO sCausa
         FROM GA_SINIESTROS
         WHERE NUM_SERIE = :NEW.NUM_SERIE;

         IF sCausa = '1' or sCausa = '4' THEN

              :NEW.COD_CAUSA := sCausa;
             SELECT COUNT(1) INTO iContador
             FROM GA_ABOCEL
             WHERE NUM_ABONADO = :NEW.NUM_ABONADO;
             IF iContador = 1 THEN
                 :NEW.TIP_ABONADO := 'C';
             ELSE
                  :NEW.TIP_ABONADO := 'P';
             END IF;

         END IF;

     END IF;
END    PV_TRG_GA_LNCELU;
/
SHOW ERRORS