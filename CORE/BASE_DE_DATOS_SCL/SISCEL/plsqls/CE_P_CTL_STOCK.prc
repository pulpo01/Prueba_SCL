CREATE OR REPLACE PROCEDURE        CE_P_CTL_STOCK (resul IN OUT VARCHAR2,
cod_tipclave IN VARCHAR2
)IS
/******************************************************************************
   NOMBRE:      CTL_STOCK
   OBJETIVO:    Controla el stock de claves disponibles
   REVISIONS:
   Ver        Fecha        Autor
   ---------  ----------  ---------------
   1.0        01/01/2000  Cristian Retamal M.
******************************************************************************/
   pnum_actminimo	CED_CTRSTOCK.NUM_ACTMINIMO%TYPE;
   pnum_activos		CED_CTRSTOCK.NUM_ACTIVOS%TYPE;
   pnum_disponibles CED_CTRSTOCK.NUM_DISPONIBLES%TYPE;
   pnum_activar		CED_TIPCLAVES.NUM_ACTIVAR%TYPE;
   cont				NUMBER;
   pcod_estadosol	CED_CTRSTOCK.COD_ESTADOSOL%TYPE;
   estado			VARCHAR2(3);
   ERROR EXCEPTION;
   BEGIN
   estado:='NK';
   SELECT NUM_ACTMINIMO, NUM_ACTIVOS, NUM_DISPONIBLES, COD_ESTADOSOL
   INTO pnum_actminimo, pnum_activos, pnum_disponibles, pcod_estadosol
   FROM CED_CTRSTOCK
   WHERE COD_TIPCLAVE=cod_tipclave;
   IF pnum_actminimo > pnum_activos THEN
   	  IF pnum_disponibles >= pnum_activar THEN
	  	 --	ENVIAR COMANDO A COMVERSE
		 -- POR DEFINIR
		 cont:=1;
	  	 LOOP
		 	IF cont <= pnum_activar THEN
			   UPDATE CET_CLAVEDISP A SET
			   COD_ESTADO='A'
			   WHERE COD_ESTADO='I'
			   AND A.NUM_SERIE IN
			   (SELECT MIN(B.NUM_SERIE) FROM CET_CLAVEDISP B
			   WHERE COD_ESTADO='I');
			   cont:=cont + 1;
			ELSE
			   COMMIT;
			   EXIT WHEN cont > pnum_activar;
			END IF;
		 END LOOP;
		 UPDATE CED_CTRSTOCK SET
		 NUM_DISPONIBLES=NUM_DISPONIBLES - pnum_activar,
		 NUM_ACTIVOS    =NUM_ACTIVOS + pnum_activar;
	  END IF;
	  IF pnum_disponibles < pnum_activar THEN
	  	 IF pcod_estadosol!='A' OR pcod_estadosol!='F' THEN
		 	resul:='NO';
			estado:='OK';
		 END IF;
		 IF pcod_estadosol='A' OR pcod_estadosol='F' THEN
		 	resul:='SI';
			UPDATE CED_CTRSTOCK SET
			FEC_ULTSOLICTUD=SYSDATE,
			COD_ESTADOSOL='R';
		 END IF;
	  END IF;
   END IF;
   IF estado='OK' THEN
      IF pnum_actminimo > pnum_disponibles THEN
	    IF pcod_estadosol!='A' OR pcod_estadosol!='F' THEN
		 	resul:='NO';
	  	END IF;
	  	IF pcod_estadosol='A' OR pcod_estadosol='F' THEN
		 	resul:='SI';
			UPDATE CED_CTRSTOCK SET
			FEC_ULTSOLICTUD=SYSDATE,
			COD_ESTADOSOL='R';
	  	END IF;
   	  END IF;
    END IF;
   	 EXCEPTION
	 WHEN ERROR THEN
	 ROLLBACK;
     WHEN OTHERS THEN
     ROLLBACK;
END CE_P_CTL_STOCK;
/
SHOW ERRORS
