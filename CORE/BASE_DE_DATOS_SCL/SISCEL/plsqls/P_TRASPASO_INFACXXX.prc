CREATE OR REPLACE PROCEDURE        P_TRASPASO_INFACXXX
(VP_PRODUCTO IN NUMBER,
 VP_CLIENTE IN NUMBER,
 VP_ABONADO IN NUMBER,
 VP_ABONADONUE IN NUMBER,
 VP_CICLO IN NUMBER,
 VP_FECSYS IN DATE,
 VP_CLIENEW IN NUMBER,
 VP_PROC IN OUT VARCHAR2,
 VP_TABLA IN OUT VARCHAR2,
 VP_ACT IN OUT VARCHAR2,
 VP_SQLCODE IN OUT VARCHAR2,
 VP_SQLERRM IN OUT VARCHAR2,
 VP_ERROR IN OUT VARCHAR2 )
IS
--
-- Procedimiento que refleja el traspaso de productos entre clientes
-- en las tablas de interfase con tarificacion
--
--            Los posibles retornos del procedimiento son :
--                - '0' Actualizaciones realizadas correctamente
--                - '4' Error en el proceso
--
   V_ROWID CHAR(18);
   V_CLIENTE GA_INFACCEL.COD_CLIENTE%TYPE;
   V_ABONADO GA_INFACCEL.NUM_ABONADO%TYPE;
   V_FECALTA GA_INFACCEL.FEC_ALTA%TYPE;
   V_FECBAJA GA_INFACCEL.FEC_BAJA%TYPE;
   V_CICLFACT GA_INFACCEL.COD_CICLFACT%TYPE;
   V_CELULAR GA_INFACCEL.NUM_CELULAR%TYPE;
   V_ACTUAC GA_INFACCEL.IND_ACTUAC%TYPE;
   V_FINCONTRA GA_INFACCEL.FEC_FINCONTRA%TYPE;
   V_INDALTA GA_INFACCEL.IND_ALTA%TYPE;
   V_DETALLE GA_INFACCEL.IND_DETALLE%TYPE;
   V_FACTUR GA_INFACCEL.IND_FACTUR%TYPE;
   V_CUOTAS GA_INFACCEL.IND_CUOTAS%TYPE;
   V_ARRIENDO GA_INFACCEL.IND_ARRIENDO%TYPE;
   V_CARGOS GA_INFACCEL.IND_CARGOS%TYPE;
   V_PENALIZA GA_INFACCEL.IND_PENALIZA%TYPE;
   V_SUPERTEL GA_INFACCEL.IND_SUPERTEL%TYPE;
   V_TELEFIJA GA_INFACCEL.NUM_TELEFIJA%TYPE;
   V_BEEPER GA_INFACBEEP.NUM_BEEPER%TYPE;
   V_RADIO GA_INFACTRUNK.NUM_RADIO%TYPE;
   V_MAN GA_INFACTREK.NUM_MAN%TYPE;
   V_CCONTROL GA_INFACCEL.IND_CUENCONTROLADA%TYPE;
   V_CARGOPRO GA_INFACCEL.IND_CARGOPRO%TYPE;
   V_OPREDFIJA GA_INFACCEL.COD_SUPERTEL%TYPE;
   V_FECHA GA_INFACCEL.FEC_BAJA%TYPE;
   V_USO GA_ABOCEL.COD_USO%TYPE;
   V_TABORIGEN VARCHAR2(10);
   IND_VALOR NUMBER;
   V_FACTUR_NVO GA_INFACCEL.IND_FACTUR%TYPE;
BEGIN
   VP_PROC := 'P_TRASPASO_INFACXXX';
   VP_TABLA := 'FA_CICLFACT';
   VP_ACT := 'S';
   V_TABORIGEN:='ABOCEL';
   SELECT COD_CICLFACT INTO V_CICLFACT
   FROM FA_CICLFACT
   WHERE COD_CICLO = VP_CICLO
         AND VP_FECSYS BETWEEN FEC_DESDELLAM
         AND FEC_HASTALLAM;
   BEGIN
      VP_TABLA := 'GE_CLIENTES';
      VP_ACT := 'S';
      SELECT IND_FACTUR INTO V_FACTUR_NVO
      FROM GE_CLIENTES
      WHERE COD_CLIENTE = VP_CLIENEW;
   EXCEPTION
      WHEN OTHERS THEN
      VP_SQLCODE := SQLCODE;
      VP_SQLERRM := SQLERRM;
      VP_ERROR := '4';
   END;
   IF VP_PRODUCTO = 1 THEN
      IND_VALOR := 6;
      VP_TABLA := 'GA_INFACCEL';
      VP_ACT := 'S';
      SELECT ROWID,COD_CLIENTE,NUM_ABONADO,
             FEC_ALTA,FEC_BAJA,NUM_CELULAR,
             IND_ACTUAC,FEC_FINCONTRA,IND_ALTA,
             IND_DETALLE,IND_FACTUR,IND_CUOTAS,
             IND_ARRIENDO,IND_CARGOS,IND_PENALIZA,
             IND_SUPERTEL,NUM_TELEFIJA, IND_CUENCONTROLADA, IND_CARGOPRO ,
             COD_SUPERTEL
      INTO V_ROWID,V_CLIENTE,V_ABONADO,
           V_FECALTA,V_FECBAJA,V_CELULAR,
           V_ACTUAC,V_FINCONTRA,V_INDALTA,
           V_DETALLE,V_FACTUR,V_CUOTAS,
           V_ARRIENDO,V_CARGOS,V_PENALIZA,
           V_SUPERTEL,V_TELEFIJA, V_CCONTROL, V_CARGOPRO , V_OPREDFIJA
      FROM GA_INFACCEL
      WHERE COD_CLIENTE = VP_CLIENTE
            AND NUM_ABONADO = VP_ABONADO
            AND COD_CICLFACT = V_CICLFACT
            AND IND_ACTUAC <> IND_VALOR;
      IND_VALOR := 3;
      V_FECHA :=VP_FECSYS - (1/(24*60*60));
      VP_TABLA := 'GA_INFACCEL';
      VP_ACT := 'U';
      UPDATE GA_INFACCEL
      SET FEC_BAJA = V_FECHA,
          IND_ACTUAC = IND_VALOR
      WHERE ROWID = V_ROWID;
      VP_TABLA := 'FA_CICLFACT';
      VP_ACT := 'S';
      SELECT COD_CICLFACT  INTO V_CICLFACT
      FROM FA_CICLFACT
      WHERE COD_CICLO = (SELECT COD_CICLO FROM GE_CLIENTES
                         WHERE COD_CLIENTE = VP_CLIENEW)
                         AND VP_FECSYS BETWEEN FEC_DESDELLAM  AND FEC_HASTALLAM;
      IND_VALOR := 1;
	  BEGIN
      	 VP_TABLA := 'GA_ABOCEL';
      	 VP_ACT := 'S';
      	 SELECT NUM_CELULAR,FEC_FINCONTRA,IND_SUPERTEL,COD_OPREDFIJA,NUM_TELEFIJA,COD_USO
      	 INTO V_CELULAR,V_FINCONTRA,V_SUPERTEL,V_OPREDFIJA,V_TELEFIJA,V_USO
      	 FROM GA_ABOCEL
      	 WHERE  NUM_ABONADO=VP_ABONADONUE;
	 EXCEPTION
	 	 WHEN NO_DATA_FOUND THEN
		    BEGIN
			      	 VP_TABLA := 'GA_ABOAMIST';
      	 			 VP_ACT := 'S';
      	 			 SELECT NUM_CELULAR,COD_USO
      	 			 INTO V_CELULAR,V_USO
      	 			 FROM GA_ABOAMIST
      	 			 WHERE  NUM_ABONADO=VP_ABONADONUE;
					 V_TABORIGEN:='ABOAMIST';
			EXCEPTION
			  WHEN OTHERS THEN
         	  	   VP_SQLCODE := SQLCODE;
         		   VP_SQLERRM := SQLERRM;
         		   VP_ERROR := '4';
			END;
	 END;
     IF V_TABORIGEN= 'ABOCEL' THEN
        IF V_USO=3 THEN
          V_CCONTROL:=0;
        END IF;
        VP_TABLA := 'GA_INFACCEL';
        VP_ACT := 'I';
        INSERT INTO GA_INFACCEL (COD_CLIENTE,NUM_ABONADO,COD_CICLFACT,
                               FEC_ALTA,FEC_BAJA,NUM_CELULAR,
                               IND_ACTUAC,FEC_FINCONTRA,IND_ALTA,
                               IND_DETALLE,IND_FACTUR,IND_CUOTAS,
                               IND_ARRIENDO,IND_CARGOS,IND_PENALIZA,
                               IND_SUPERTEL,NUM_TELEFIJA, IND_CUENCONTROLADA,
                               IND_CARGOPRO, COD_SUPERTEL)
                       VALUES (VP_CLIENEW,VP_ABONADONUE,V_CICLFACT,
                               VP_FECSYS,V_FECBAJA,V_CELULAR,
                               IND_VALOR,V_FINCONTRA,IND_VALOR,V_DETALLE,V_FACTUR_NVO,V_CUOTAS,
                               V_ARRIENDO,V_CARGOS,V_PENALIZA,V_SUPERTEL,V_TELEFIJA,
                               V_CCONTROL,V_CARGOPRO,V_OPREDFIJA);
	  END IF;
    ELSIF VP_PRODUCTO = 2 THEN
          IND_VALOR := 6;
          VP_TABLA := 'GA_INFACBEEP';
          VP_ACT := 'S';
          SELECT ROWID,COD_CLIENTE,NUM_ABONADO,
                 FEC_ALTA,FEC_BAJA,NUM_BEEPER,
                 IND_ACTUAC,FEC_FINCONTRA,IND_ALTA,
                 IND_DETALLE,IND_FACTUR,IND_CUOTAS,
                 IND_ARRIENDO,IND_CARGOS,IND_PENALIZA, IND_CARGOPRO
          INTO V_ROWID,V_CLIENTE,V_ABONADO,
               V_FECALTA,V_FECBAJA,V_BEEPER,
               V_ACTUAC,V_FINCONTRA,V_INDALTA,
               V_DETALLE,V_FACTUR,V_CUOTAS,
               V_ARRIENDO,V_CARGOS,V_PENALIZA, V_CARGOPRO
          FROM GA_INFACBEEP
          WHERE COD_CLIENTE = VP_CLIENTE
                AND NUM_ABONADO = VP_ABONADO
                AND COD_CICLFACT = V_CICLFACT
                AND IND_ACTUAC <> IND_VALOR;
          V_FECHA :=   VP_FECSYS - (1/(24*60*60));
          IND_VALOR := 3;
          VP_TABLA := 'GA_INFACBEEP';
          VP_ACT := 'U';
          UPDATE GA_INFACBEEP
          SET FEC_BAJA = V_FECHA,
              IND_ACTUAC = IND_VALOR
          WHERE ROWID = V_ROWID;
          SELECT COD_CICLFACT  INTO V_CICLFACT
          FROM FA_CICLFACT
          WHERE COD_CICLO = (SELECT COD_CICLO FROM GE_CLIENTES
                         WHERE COD_CLIENTE = VP_CLIENEW)
                         AND VP_FECSYS BETWEEN FEC_DESDELLAM  AND FEC_HASTALLAM;
          VP_TABLA := 'GA_ABOBEEP';
          VP_ACT := 'S';
          SELECT NUM_BEEPER,FEC_FINCONTRA
          INTO V_BEEPER,V_FINCONTRA
          FROM GA_ABOBEEP
          WHERE  NUM_ABONADO=VP_ABONADONUE;
          IND_VALOR := 1;
          VP_TABLA := 'GA_INFACBEEP';
          VP_ACT := 'I';
          INSERT INTO GA_INFACBEEP
                 (COD_CLIENTE,NUM_ABONADO,COD_CICLFACT,
                  FEC_ALTA,FEC_BAJA,NUM_BEEPER,IND_ACTUAC,FEC_FINCONTRA,IND_ALTA,
                  IND_DETALLE,IND_FACTUR,IND_CUOTAS,IND_ARRIENDO,IND_CARGOS,IND_PENALIZA,
                  IND_CARGOPRO)
          VALUES (VP_CLIENEW,VP_ABONADONUE,V_CICLFACT,
                  VP_FECSYS,V_FECBAJA,V_BEEPER,V_ACTUAC,V_FINCONTRA,IND_VALOR,
                  V_DETALLE,V_FACTUR_NVO,V_CUOTAS,
                  V_ARRIENDO,V_CARGOS,V_PENALIZA, V_CARGOPRO);
    END IF;
EXCEPTION
    WHEN OTHERS THEN
         VP_SQLCODE := SQLCODE;
         VP_SQLERRM := SQLERRM;
         VP_ERROR := '4';
END;
/
SHOW ERRORS
