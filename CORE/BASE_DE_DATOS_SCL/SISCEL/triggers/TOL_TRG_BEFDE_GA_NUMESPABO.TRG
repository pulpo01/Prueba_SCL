CREATE OR REPLACE TRIGGER TOL_TRG_BEFDE_GA_NUMESPABO
BEFORE DELETE ON GA_NUMESPABO
REFERENCING OLD AS OLD
FOR EACH ROW
BEGIN
   BEGIN
       UPDATE tol_numfreq
              SET fec_ter_vig = SYSDATE
       WHERE cod_abonado  	= :OLD.num_abonado
       AND   linea_b 		= :OLD.num_telefesp
       AND   SYSDATE >= fec_ini_vig
       AND   (SYSDATE <= fec_ter_vig OR fec_ter_vig IS NULL);

      EXCEPTION
         WHEN OTHERS THEN
	     RAISE_APPLICATION_ERROR(-20999,'ERROR EN EL TRIGGER UPDATE TOL_TRG_BEFDE_ga_numespabo '||SQLERRM);
	     NULL;
   END;

END;
/
SHOW ERRORS
