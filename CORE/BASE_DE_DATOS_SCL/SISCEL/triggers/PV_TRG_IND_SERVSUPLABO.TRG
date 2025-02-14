CREATE OR REPLACE TRIGGER PV_TRG_IND_SERVSUPLABO
AFTER INSERT OR UPDATE ON GA_SERVSUPLABO
REFERENCING OLD AS OLD NEW AS NEW
FOR EACH ROW

DECLARE
  n_es_detllam   GA_SERVSUPL.COD_SERVICIO%TYPE;
  n_es_fyfcel    GA_SERVSUPL.COD_SERVICIO%TYPE;
  s_cod_cliente  GA_ABOCEL.COD_CLIENTE%TYPE;
  n_ciclo        GA_ABOCEL.COD_CICLO%TYPE;
  s_cod_ciclo    GA_INFACCEL.COD_CICLFACT%TYPE;

--	  Autor : Rayen Ceballos Baeza (Posventa)
--   Fecha:   29/05/2003
--	 Comentario; triggers que modifica indicador de FYF en ga_intarcel o indicador
---  			 DETLLAM en ga_infaccel en el caso que active o desactive servcicios
---- 			 de estos grupos


BEGIN

IF INSERTING THEN

   SELECT COD_CLIENTE, COD_CICLO
   INTO s_cod_cliente, n_ciclo
   FROM GA_ABOCEL
   WHERE NUM_ABONADO = :new.NUM_ABONADO;

   BEGIN
	   SELECT COD_SERVICIO
	   INTO   n_es_detllam
	   FROM   GA_GRUPOS_SERVSUP
	   WHERE  COD_GRUPO = 'DETLLAM'
	   AND  COD_SERVICIO = :new.COD_SERVICIO
	   AND  COD_PRODUCTO = 1;

	   EXCEPTION
                WHEN OTHERS THEN
                n_es_detllam := NULL;
  END;

  BEGIN
	   SELECT COD_SERVICIO
	   INTO   n_es_fyfcel
	   FROM   GA_GRUPOS_SERVSUP
	   WHERE  COD_GRUPO = 'FYFCEL'
	   AND  COD_SERVICIO = :new.COD_SERVICIO
	   AND  COD_PRODUCTO = 1;

	   EXCEPTION
                WHEN OTHERS THEN
				n_es_fyfcel  := NULL;
   END;

   IF (n_es_detllam IS NOT NULL)  THEN
	   SELECT COD_CICLFACT
       INTO s_cod_ciclo
       FROM FA_CICLFACT
       WHERE COD_CICLO = n_ciclo
       AND sysdate BETWEEN FEC_DESDELLAM AND FEC_HASTALLAM;

       IF  (:new.IND_ESTADO <=  2) THEN
	       UPDATE GA_INFACCEL
	       SET IND_DETALLE = 1
	       WHERE COD_CLIENTE = s_cod_cliente
	       AND NUM_ABONADO = :new.NUM_ABONADO
	       AND COD_CICLFACT = s_cod_ciclo;
		   COMMIT;
	   END IF;
   END IF;


   IF (n_es_fyfcel IS NOT NULL) AND (:new.IND_ESTADO <=  2) THEN
   	  UPDATE GA_INTARCEL SET
      IND_FRIENDS = 1
      WHERE COD_CLIENTE = s_cod_cliente
      AND NUM_ABONADO = :new.NUM_ABONADO
      AND SYSDATE BETWEEN FEC_DESDE AND NVL(FEC_HASTA, SYSDATE);
	  COMMIT;
   END IF;
END IF;

IF UPDATING THEN

   SELECT COD_CLIENTE, COD_CICLO
   INTO s_cod_cliente, n_ciclo
   FROM GA_ABOCEL
   WHERE NUM_ABONADO = :old.NUM_ABONADO;

   BEGIN
	   SELECT COD_SERVICIO
	   INTO   n_es_detllam
	   FROM   GA_GRUPOS_SERVSUP
	   WHERE  COD_GRUPO = 'DETLLAM'
	   AND  COD_SERVICIO = :old.COD_SERVICIO
	   AND  COD_PRODUCTO = 1;


	   EXCEPTION
                WHEN OTHERS THEN
                n_es_detllam := NULL;

   END;

   BEGIN

	   SELECT COD_SERVICIO
	   INTO   n_es_fyfcel
	   FROM   GA_GRUPOS_SERVSUP
	   WHERE  COD_GRUPO = 'FYFCEL'
	   AND  COD_SERVICIO = :old.COD_SERVICIO
	   AND  COD_PRODUCTO = 1;

	   EXCEPTION
                WHEN OTHERS THEN
                n_es_fyfcel  := NULL;

   END;


   IF (n_es_detllam IS NOT NULL) AND (:new.IND_ESTADO = 3) THEN

       SELECT COD_CICLFACT
       INTO s_cod_ciclo
       FROM FA_CICLFACT
       WHERE COD_CICLO = n_ciclo
       AND SYSDATE BETWEEN FEC_DESDELLAM AND FEC_HASTALLAM;

       UPDATE GA_INFACCEL
       SET IND_DETALLE = 0
       WHERE COD_CLIENTE = s_cod_cliente
       AND NUM_ABONADO = :old.NUM_ABONADO
       AND COD_CICLFACT = s_cod_ciclo;
       COMMIT;

   END IF;


   IF (n_es_fyfcel IS NOT NULL) AND (:new.IND_ESTADO = 3) THEN

       UPDATE GA_INTARCEL SET
       IND_FRIENDS = 0
       WHERE COD_CLIENTE = s_cod_cliente
       AND NUM_ABONADO = :old.NUM_ABONADO
       AND SYSDATE BETWEEN FEC_DESDE AND NVL(FEC_HASTA, SYSDATE);
       COMMIT;

   END IF;


END IF;

	EXCEPTION
	WHEN OTHERS THEN
	NULL;

END PV_TRG_IND_SERVSUPLABO;
/
SHOW ERRORS
