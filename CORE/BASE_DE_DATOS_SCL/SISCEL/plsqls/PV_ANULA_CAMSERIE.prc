CREATE OR REPLACE PROCEDURE        PV_ANULA_CAMSERIE (
                             PRC_TRANSAC IN VARCHAR2,
                             V_ABONADO   IN GA_ABOCEL.NUM_ABONADO%TYPE,
							 V_VENTA 	 IN	GA_VENTAS.NUM_VENTA%TYPE)
IS

/*
  Procedimiento Para Anular un cambio de Serie
  Autor : Christian Estay M.
  Fecha : 15-05-2002
*/

V_SERIE_NUE 		GA_ABOCEL.NUM_SERIE%TYPE;
V_TERMINAL_NUE 		GA_ABOCEL.TIP_TERMINAL%TYPE;
V_CLIENTE 			GA_ABOCEL.COD_CLIENTE%TYPE;
V_CENTRAL 			GA_ABOCEL.COD_CENTRAL%TYPE;
V_CELULAR           GA_ABOCEL.NUM_CELULAR%TYPE;
V_FEC_CAMBIO 		GA_EQUIPABOSER.FEC_ALTA%TYPE;
V_FILA_EQUIPABOSER 	ROWID;
V_SERIE_ANT 		GA_ABOCEL.NUM_SERIE%TYPE;
V_SERIE_HEX_ANT     GA_ABOCEL.NUM_SERIEHEX%TYPE;
V_SERIE_HEX_NUE     GA_ABOCEL.NUM_SERIEHEX%TYPE;
V_TERMINAL_ANT 		GA_ABOCEL.TIP_TERMINAL%TYPE;
V_PROCEQUI			GA_EQUIPABOSER.IND_PROCEQUI%TYPE;
V_FILA_MODABOCEL 	ROWID;

V_TRANSACCION 		GA_TRANSACABO.NUM_TRANSACCION%TYPE;
V_ESTADO 			AL_SERIES.COD_ESTADO%TYPE;
V_IND_EQPRESTADO    GA_EQUIPABOSER.IND_EQPRESTADO%TYPE;

VP_TABLA 			VARCHAR2(30);
VP_PROC 			VARCHAR2(30);
VP_ACT  			VARCHAR2(2);
V_ERROR				NUMBER(9):=0;

nCantDias		    GAD_PLAZO_DEVDIF.DIAS_DEVOLUCION%TYPE;
vCantDias		    VARCHAR2(3);
nCodProducto        GA_ABOCEL.COD_PRODUCTO%TYPE;
vCodCausa		    GAT_EQUIPOS_DEVDIF.COD_CAUSA%TYPE;
dfechadev	        DATE;

ERROR_PROCESO EXCEPTION;

BEGIN

   BEGIN

   V_ERROR  := 0;
   VP_PROC  :='P_DEL_CAMSERIE';
   VP_TABLA :='GA_ABOCEL';
   VP_ACT   :='S';

   dbms_output.put_line ('Antes1 : ');

   SELECT NUM_SERIE,TIP_TERMINAL,COD_CLIENTE,COD_CENTRAL,NUM_SERIEHEX,NUM_CELULAR,COD_PRODUCTO
     INTO V_SERIE_NUE,V_TERMINAL_NUE,V_CLIENTE,V_CENTRAL,V_SERIE_HEX_NUE,V_CELULAR,nCodProducto
     FROM GA_ABOCEL
    WHERE NUM_ABONADO=V_ABONADO;

   dbms_output.put_line ('Antes FEC_CAMBIO: ');

   IF V_SERIE_NUE <> ' ' THEN

      VP_TABLA:='GA_EQUIPABOSER';
      VP_ACT:='S';
      SELECT TRUNC(MAX(FEC_ALTA)),ROWID
        INTO V_FEC_CAMBIO, V_FILA_EQUIPABOSER
        FROM GA_EQUIPABOSER
       WHERE NUM_ABONADO=V_ABONADO
         AND NUM_SERIE=V_SERIE_NUE
	GROUP BY ROWID;

	  dbms_output.put_line ('FEC_CAMBIO: ' || to_char(V_FEC_CAMBIO));

	  SELECT NUM_SERIE,TIP_TERMINAL,IND_PROCEQUI,IND_EQPRESTADO
        INTO V_SERIE_ANT,V_TERMINAL_ANT,V_PROCEQUI,V_IND_EQPRESTADO
        FROM GA_EQUIPABOSER
       WHERE NUM_ABONADO=V_ABONADO
         AND FEC_ALTA IN (SELECT MAX(FEC_ALTA)
                            FROM GA_EQUIPABOSER
                           WHERE NUM_ABONADO = V_ABONADO
                             AND TRUNC(FEC_ALTA) < V_FEC_CAMBIO);

      VP_TABLA:='GA_MODABOCEL';
      VP_ACT:='S';
      SELECT ROWID
        INTO V_FILA_MODABOCEL
        FROM GA_MODABOCEL
       WHERE NUM_ABONADO=V_ABONADO
         AND COD_TIPMODI='CE'
         AND NUM_SERIE=V_SERIE_ANT
         AND TRUNC(FEC_MODIFICA)=V_FEC_CAMBIO;


	   --Copiamos en la ga_hsegurabo
	     insert into ga_hsegurabo (NUM_ABONADO, FEC_ALTA, FEC_HISTORICO,
		                          COD_PRODUCTO, NUM_TERMINAL, NUM_SERIE,
								  COD_TIPSEGU, NUM_CONTRATO, NUM_ANEXO,
								  NUM_PERIODO, FEC_FINCONTRATO, NOM_USUARORA,
								  NUM_REEMPLAZOS, NUM_PERIODO_REEMP)
        select NUM_ABONADO, FEC_ALTA, sysdate ,
		       COD_PRODUCTO,NUM_TERMINAL, NUM_SERIE,
			   COD_TIPSEGU, NUM_CONTRATO, NUM_ANEXO,
			   NUM_PERIODO, FEC_FINCONTRATO, NOM_USUARORA,
			   NUM_REEMPLAZOS, NUM_PERIODO_REEMP
		  from ga_segurabo
 	     Where num_abonado = V_ABONADO
	       And num_serie   = V_SERIE_NUE;


	   --Actualizamo el Seguro a la Serie Ant
	 	Update ga_segurabo
		   set num_serie   = V_SERIE_ANT
 	     Where num_abonado = V_ABONADO
	       And num_serie   = V_SERIE_NUE;


       --Comenzamos los Delete

       VP_TABLA:='GA_MODABOCEL';
       VP_ACT:='D';
       DELETE GA_MODABOCEL WHERE ROWID=V_FILA_MODABOCEL;

       VP_TABLA:='GA_EQUIPABOSER';
       VP_ACT:='D';
       DELETE GA_EQUIPABOSER WHERE ROWID=V_FILA_EQUIPABOSER;

       VP_TABLA:='GA_VENTAS';
       VP_ACT:='D';
	   DELETE GA_DOCVENTA WHERE NUM_VENTA=V_VENTA;
       DELETE GA_VENTAS WHERE NUM_VENTA=V_VENTA;

       VP_TABLA:='GA_ABOCEL';
       VP_ACT:='U';
       UPDATE GA_ABOCEL
          SET NUM_SERIE      = V_SERIE_ANT,
              TIP_TERMINAL   = V_TERMINAL_ANT,
              IND_PROCEQUI   = V_PROCEQUI,
			  IND_EQPRESTADO = V_IND_EQPRESTADO,
              COD_SITUACION  = 'AAA'   --Hay que cambia a CSP
        WHERE NUM_ABONADO=V_ABONADO;

       IF V_TERMINAL_ANT <> V_TERMINAL_NUE THEN
          VP_TABLA:='OPENSERV';
          VP_ACT:='U';
          SELECT GA_SEQ_TRANSACABO.NEXTVAL
            INTO V_TRANSACCION
            FROM DUAL;

          P_OPENSERV_TERMINAL(V_TRANSACCION,1,V_ABONADO,V_TERMINAL_ANT,V_CENTRAL,0);
       END IF;

	   --Insertar en la ICC_MOLVIMIEMTO el movimiento a Central con la serie antigua HEXA
        p_transforma_hexa (V_SERIE_ANT,V_SERIE_HEX_ANT);
        vp_tabla := 'ICC_MOVIMIENTO';
        vp_act := 'I';

        INSERT INTO icc_movimiento
                    (cod_estado, num_movimiento,
                     num_abonado, cod_modulo,
                     cod_actuacion, nom_usuarora,
                     fec_ingreso, cod_central,
                     num_celular, num_serie,
                     num_serie_nue,
                     tip_terminal_nue, cod_actabo,
                     num_intentos,
                     des_respuesta,
                     tip_terminal,
                     ind_bloqueo)
             VALUES (1, icc_seq_nummov.NEXTVAL,
                     v_abonado, 'GA',
                     12, 'MIGRACION',
                     SYSDATE, V_CENTRAL,
                     V_CELULAR, V_SERIE_HEX_ANT,
                     V_SERIE_HEX_NUE,
                     V_TERMINAL_NUE, 'CE',
                     0,
                     'PENDIENTE CAMBIO SERIE REST.',
                     DECODE (V_TERMINAL_ANT,NULL,'D',
					         V_TERMINAL_ANT),
                     0);


         vp_tabla := 'DIASDEVDIF';
         vp_act := 'I';
		 PV_PR_DEVVALPARAM('GA',nCodProducto,'DIASDEVDIF',vCantDias);
		 nCantDias:=to_number(vCantDias);
		 dfechadev:=sysdate+nCantDias;
         vp_tabla := 'GAT_EQUIPOS_DEVDIF';
         vp_act := 'I';
  	     -- Ingresar equipo(nuevo) en devolucion diferida al saco
    	 INSERT INTO GAT_EQUIPOS_DEVDIF(COD_CLIENTE, NUM_ABONADO, NUM_SERIE,
		                                COD_TIPMOV, COD_OPERACION,COD_CAUSA,
										FEC_INGRESO, NOM_USUARIO, COD_ESTADO_DEV,
										FEC_MAXIMA_DEV,IND_COBRO, NUM_CARGO)
	   	                         VALUES(V_CLIENTE,V_ABONADO,V_SERIE_NUE,
								        '1','NV',64,
		 								sysdate,'POSVENTA','N',
										dfechadev,NULL,NULL);

          RAISE ERROR_PROCESO;

   END IF;
   EXCEPTION
        WHEN OTHERS THEN
	       V_ERROR := 4;
           RAISE ERROR_PROCESO;
   END;

EXCEPTION
     WHEN ERROR_PROCESO THEN
	     INSERT INTO GA_TRANSACABO
	                (NUM_TRANSACCION,
	                 COD_RETORNO,
	                 DES_CADENA)
	         VALUES (PRC_TRANSAC,
	                 V_ERROR,
	                 'Error en ->'||VP_TABLA );

END;
/
SHOW ERRORS
