CREATE OR REPLACE PROCEDURE PV_TRASPASOPREPAGO_PR
(
VP_NUM_TRANSACCION		IN NUMBER,
VP_NUM_ABONADO_ORIGEN	IN NUMBER,
VP_COD_CLIENTE_DESTINO	IN NUMBER,
VP_CUENTA_DESTINO		IN NUMBER,
VP_COD_OS				IN VARCHAR2,
VP_COD_ACTABO			IN VARCHAR2,
VP_COMENTARIO			IN VARCHAR2,
VP_TIP_INTER	  		IN NUMBER,
V_FECHA                 IN VARCHAR2 --INC.  33989
 )
IS
/******************************************************************************
   Nombre        :     PV_TRASPASOPREPAGO_PR
   AREA          :     Desarrollo Post-Venta POSTVENTA
   Creado		 :     17 noviembre 2003  Proyecto
   				 	   Patrcica Castro R.
   Comentarios	 :     Proyecto Traspaso Abonado Prepago


MODIFCIACIONES
   Fecha		  	   	Comentarios

******************************************************************************/


V_RESULTADO			NUMBER;
V_SQLCODE			NUMBER;
V_SQLERRM			VARCHAR2(100);
V_NUM_OS			NUMBER;
V_USUARIO			NUMBER;
-- Inicio modificacion by SAQL/Soporte 13/04/2006 - RA-200602210820
--V_FECHA                         DATE := SYSDATE; --  33989
-- Fin modificacion by SAQL/Soporte 13/04/2006 - RA-200602210820

-- Inicio modificacion by SAQL/Soporte 11/01/2006 - RA-200601060519
serror                          VARCHAR2(500);
scod_per                        VARCHAR2(500);
sdes_per                        VARCHAR2(500);
scod_ora                        VARCHAR2(500);
sdes_trace                      VARCHAR2(500);
V_CODCLIENTE_ANT                GA_ABOAMIST.COD_CLIENTE%TYPE;
V_COD_SUBCUENTA_DEST            GA_ABOAMIST.COD_SUBCUENTA%TYPE;
V_CODCUENTA_ANT                 GA_ABOAMIST.COD_CUENTA%TYPE;
V_COD_SUBCUENTA_ANT             GA_ABOAMIST.COD_SUBCUENTA%TYPE;
V_CODPRODUCTO                   GA_ABOAMIST.COD_PRODUCTO%TYPE;
V_NUM_TERMINAL                  GA_ABOAMIST.NUM_CELULAR%TYPE;
V_CODUSUARIO_ANT                GA_USUAMIST.COD_USUARIO%TYPE;
-- Fin modificacion by SAQL/Soporte 11/01/2006 - RA-200601060519

DFecha        date;         --INC.  33989 jajr - 08/09/2006
Formato_Fecha varchar2(20); --INC.  33989 jajr - 08/09/2006
Formato_Hora  varchar2(20); --INC.  33989 jajr - 08/09/2006
VP_TABLA      varchar2(50); --INC.  33989 jajr - 08/09/2006
VP_ACCION     varchar2(1); --INC.  33989 jajr - 08/09/2006


ERROR_PROCESO EXCEPTION;

BEGIN
	 V_RESULTADO := 0;

--Inicio INC.33989 jajr - 08/09/2006

     VP_TABLA :='GED_parametros';
     vp_accion :='S'; 
	 SELECT VAL_PARAMETRO into Formato_Fecha FROM GED_PARAMETROS
	 WHERE  NOM_PARAMETRO = ('FORMATO_SEL2');

     VP_TABLA :='GED_parametros2';
     vp_accion :='S';
	 SELECT VAL_PARAMETRO into Formato_Hora FROM GED_PARAMETROS
	 WHERE  NOM_PARAMETRO = ('FORMATO_SEL7');

	 --DFecha := to_date(V_FECHA,Formato_Fecha ||' '||Formato_Hora); -- 78512 COL|18-02-2009|EFR
	 DFecha := SYSDATE; -- 78512 COL|18-02-2009|EFR

--Fin INC.33989 jajr - 08/09/2006

	 IF VP_NUM_ABONADO_ORIGEN IS NOT NULL AND VP_COD_CLIENTE_DESTINO IS NOT NULL THEN


           VP_TABLA :='GA_ABOAMIST'||VP_NUM_ABONADO_ORIGEN;
            vp_accion :='S'; 

	 	  -- Inicio modificacion by SAQL/Soporte 11/01/2006 - RA-200601060519
	 	  SELECT COD_CLIENTE, COD_CUENTA, NVL(COD_SUBCUENTA,0), COD_PRODUCTO, NUM_CELULAR
	 	  INTO V_CODCLIENTE_ANT, V_CODCUENTA_ANT, V_COD_SUBCUENTA_ANT, V_CODPRODUCTO, V_NUM_TERMINAL
	 	  FROM GA_ABOAMIST
	 	  WHERE NUM_ABONADO = VP_NUM_ABONADO_ORIGEN
	 	  AND COD_SITUACION = 'AAA';


          VP_TABLA :='GA_USUAMIST'||VP_NUM_ABONADO_ORIGEN;
          vp_accion :='S'; 
	 	  SELECT COD_USUARIO INTO V_CODUSUARIO_ANT
	 	  FROM GA_USUAMIST A
	 	  WHERE NUM_ABONADO = VP_NUM_ABONADO_ORIGEN
	 	  AND FEC_ALTA = (
	 	     SELECT MAX(B.FEC_ALTA)
	 	     FROM GA_USUAMIST B
	 	     WHERE A.NUM_ABONADO = B.NUM_ABONADO
	 	  );
	 	  -- Fin modificacion by SAQL/Soporte 11/01/2006 - RA-200601060519

          VP_TABLA :='GA_ABOAMIST'||VP_NUM_ABONADO_ORIGEN;
          vp_accion :='U'; 

  
	 	  UPDATE GA_ABOAMIST
		  SET COD_CLIENTE = VP_COD_CLIENTE_DESTINO,
		  COD_CUENTA = VP_CUENTA_DESTINO
		  WHERE NUM_ABONADO = VP_NUM_ABONADO_ORIGEN
		  AND COD_SITUACION = 'AAA';

		  --Sequencia

          VP_TABLA :='GA_SEQ_USUARIOS.NEXTVAL';
          vp_accion :='S'; 

		  SELECT GA_SEQ_USUARIOS.NEXTVAL
		  INTO V_USUARIO
		  FROM DUAL;

          VP_TABLA :='GA_USUAMIST';
          vp_accion :='I'; 

		INSERT INTO GA_USUAMIST
        	   		(COD_USUARIO
					, NUM_ABONADO
					, NOM_USUARIO
					, NOM_APELLIDO1
					, FEC_ALTA
					, COD_TIPIDENT
					, NUM_IDENT
					, IND_ESTADO
					, NOM_APELLIDO2
					, FEC_NACIMIEN
					, COD_ESTCIVIL
					, IND_SEXO)
       			(SELECT
					 V_USUARIO
       				, VP_NUM_ABONADO_ORIGEN
        			, SUBSTR(NOM_CLIENTE, 1, 20)
					, SUBSTR(NOM_APECLIEN1,1,19) ||'.'
					-- Inicio modificacion by SAQL/Soporte 13/04/2006 - RA-200602210820
					--, SYSDATE
					--, V_FECHA Inc. 33989 - 08/09/2006 - jjr.-
					,DFecha --Inc. 33989 - 08/09/2006 - jjr.-
					-- Fin modificacion by SAQL/Soporte 13/04/2006 - RA-200602210820
        			, COD_TIPIDENT
					, NUM_IDENT
					, 'C'
					, NOM_APECLIEN2
        			, FEC_NACIMIEN
					, IND_ESTCIVIL
					, IND_SEXO
				FROM GE_CLIENTES
				WHERE COD_CLIENTE = VP_COD_CLIENTE_DESTINO);

	
		  -- Llamamos al PL PV_TRASPASO_PG.PV_TRASPABO_PR para dejar constancia del traspaso

           VP_TABLA :='PV_TRASPASO_PG.PV_TRASPABO_PR';
          vp_accion :='I'; 
		    
		  PV_TRASPASO_PG.PV_TRASPABO_PR (
		  V_CODCLIENTE_ANT, VP_COD_CLIENTE_DESTINO, VP_CUENTA_DESTINO, 0, V_CODCUENTA_ANT, V_COD_SUBCUENTA_ANT,
		  V_USUARIO, V_CODUSUARIO_ANT, VP_NUM_ABONADO_ORIGEN, V_CODPRODUCTO, V_NUM_TERMINAL, USER, 0,
		  -- Inicio modificacion by SAQL/Soporte 13/04/2006 - RA-200602210820
		  --VP_COD_ACTABO,  serror, scod_per, sdes_per, scod_ora, sdes_trace );
		  --VP_COD_ACTABO,  serror, scod_per, sdes_per, scod_ora, sdes_trace, V_FECHA ); Inc. 33989 - 08/09/2006 - jjr.-
  		  VP_COD_ACTABO,  serror, scod_per, sdes_per, scod_ora, sdes_trace, DFecha ); --Inc. 33989 - 08/09/2006 - jjr.-

		  -- Fin modificacion by SAQL/Soporte 13/04/2006 - RA-200602210820
		  IF serror = 'SI' THEN
		     V_SQLCODE := TO_NUMBER(SCOD_PER);
		     V_RESULTADO := TO_NUMBER(SCOD_ORA);
		     V_SQLERRM := SDES_PER;
		     RAISE ERROR_PROCESO;
		  END IF;
		  -- Fin modificacion by SAQL/Soporte 11/01/2006 - RA-200601060519

           VP_TABLA :='CI_SEQ_NUMOS.NEXTVAL';
          vp_accion :='S';   
		  --Sequencia
		  SELECT CI_SEQ_NUMOS.NEXTVAL
		  INTO V_NUM_OS
		  FROM DUAL;


		  -- PL que inserta la OOSS en la tabla CI_ORSERV
		  -- Inicio modificacion by SAQL/Soporte 13/04/2006 - RA-200602210820
		  -- PV_INSCIORSERV_PR(V_NUM_OS, VP_COD_OS,1,VP_TIP_INTER,VP_NUM_ABONADO_ORIGEN,USER ,VP_COMENTARIO ,V_RESULTADO, V_SQLCODE, V_SQLERRM);
		  --PV_INSCIORSERV_PR(V_NUM_OS, VP_COD_OS,1,VP_TIP_INTER,VP_NUM_ABONADO_ORIGEN,USER ,VP_COMENTARIO ,V_RESULTADO, V_SQLCODE, V_SQLERRM, V_FECHA); Inc. 33989 - 08/09/2006 - jjr.-
          VP_TABLA :='PV_INSCIORSERV_PR';
          Vp_accion :='I';   
  		  PV_INSCIORSERV_PR(V_NUM_OS, VP_COD_OS,1,VP_TIP_INTER,VP_NUM_ABONADO_ORIGEN,USER ,VP_COMENTARIO ,V_RESULTADO, V_SQLCODE, V_SQLERRM, DFecha); --Inc. 33989 - 08/09/2006 - jjr.-

		  -- Fin modificacion by SAQL/Soporte 13/04/2006 - RA-200602210820

		  IF V_RESULTADO = 1 THEN
		  	 -- Proceso Trasapso Exitoso
			 INSERT INTO GA_TRANSACABO
             		(NUM_TRANSACCION
					, COD_RETORNO
					, DES_CADENA)
             VALUES
			 	   (VP_NUM_TRANSACCION
				   ,0
				   ,NULL);
		  ELSE
			  RAISE ERROR_PROCESO;
		  END IF;
	 ELSE
	 	 V_RESULTADO  := '4';
	 END IF;


	 EXCEPTION
     WHEN ERROR_PROCESO THEN

          ROLLBACK;
           V_SQLCODE := sqlcode;  
		  INSERT INTO GA_ERRORES (COD_ACTABO,CODIGO,FEC_ERROR,COD_PRODUCTO,COD_SQLERRM,NOM_PROC,NOM_TABLA,COD_ACT,cod_sqlcode)
		  VALUES (VP_COD_ACTABO,VP_COD_CLIENTE_DESTINO,SYSDATE,1,V_SQLERRM,'PV_INSCIORSERV_PR',VP_TABLA,  Vp_accion, V_SQLCODE);

		  INSERT INTO GA_TRANSACABO (NUM_TRANSACCION, COD_RETORNO, DES_CADENA)
          VALUES (VP_NUM_TRANSACCION,V_RESULTADO,V_SQLERRM);

    WHEN OTHERS THEN

                 V_RESULTADO := '4';
				 ROLLBACK;
                 V_SQLCODE := sqlcode;

 		         INSERT INTO GA_ERRORES (COD_ACTABO,CODIGO,FEC_ERROR,COD_PRODUCTO,COD_SQLERRM,NOM_PROC,NOM_TABLA,COD_ACT,cod_sqlcode)
				 VALUES (VP_COD_ACTABO,VP_COD_CLIENTE_DESTINO,SYSDATE,1,V_SQLERRM, 'PV_TRASPASOPREPAGO_PR',VP_TABLA,  Vp_accion, V_SQLCODE );

				 INSERT INTO GA_TRANSACABO (NUM_TRANSACCION, COD_RETORNO, DES_CADENA)
                 VALUES (VP_NUM_TRANSACCION,V_RESULTADO,V_SQLERRM);

END PV_TRASPASOPREPAGO_PR;
/
SHOW ERRORS