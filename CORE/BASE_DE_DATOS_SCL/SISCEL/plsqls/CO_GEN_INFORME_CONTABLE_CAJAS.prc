CREATE OR REPLACE PROCEDURE CO_GEN_INFORME_CONTABLE_CAJAS (
	   	szhCodOficina_Arg				IN VARCHAR2	,		/* Csdigo de Oficina */
	   	ihzCodCaja_Arg				IN VARCHAR2	,		/* Csdigo de Caja */
		szhNumEjercicio_Arg          		IN VARCHAR2           	/*Numero de Paso Cobros */
        ) IS
	/***/
    	/* #define's */
    	TERMINO_CON_ERROR           EXCEPTION;
    	/***/
    	/* Variables */
	szhNullVariable  			VARCHAR2(1);
    	szhCodOficina	 			CO_HISTMOVCAJA.COD_OFICINA%TYPE;		/* VARCHAR2 */
    	ihCodCaja				CO_HISTMOVCAJA.COD_CAJA%TYPE;        		/* NUMBER(2) */
    	szhNumEjercicio			CO_HISTMOVCAJA.NUM_EJERCICIO%TYPE;		/* VARCHAR2 */
	ihCodEvento                 	SC_EVENTO.COD_EVENTO%TYPE;        		/* NUMBER(2) */
    	szhIdLote                 		SC_ENT_LOTE.ID_LOTE%TYPE;				/* VARCHAR2(30) */
	szhDesError				SC_ERROR_INGRESO.DES_ERROR%TYPE;
	/**  29-05-2003 **/
	vp_pref_plaza				CO_HISTMOVCAJA.PREF_PLAZA%TYPE;
	/**  29-05-2003 **/


/* ********************************************************************************************* */
/* (0) * MODULO PRINCIPAL    */
/* ********************************************************************************************* */
BEGIN
     /*  IF GE_FN_DEVVALPARAM('CO', 1, 'SE_CONTABILIZA') = 'S' THEN	 XO-200509050594 */
		/***/
    		/* VALIDA_ARGUMENTOS */
    		IF (  szhCodOficina_Arg  IS NULL ) or ( ihzCodCaja_Arg  IS NULL ) or ( szhNumEjercicio_Arg IS NULL )  THEN
	    		raise_application_error(-20101, 'No se aceptan valores en null');
    		END IF;
		/***/

		/**  29-05-2003 **/
		SELECT DISTINCT (pref_plaza)
	      INTO	 vp_pref_plaza
	 	FROM co_histmovcaja
	 	WHERE cod_oficina = szhCodOficina_Arg
		AND	cod_caja = ihzCodCaja_Arg
		AND	num_ejercicio = szhNumEjercicio_Arg
		AND pref_plaza is not null;
		/**  29-05-2003 **/

		/* Cajas Deposito */
		 /*  se reemplazo por el siguiente , para multiempresa  27/12/2002
		 ihCodCaja:=TO_NUMBER(ihzCodCaja_Arg);
   		 INSERT INTO CO_ACUM_DEPRECAUDA
         	select
         		a.cod_oficina,
		 	a.cod_caja,
		 	a.num_ejercicio,
		 	a.tip_valor,
		 	b.cod_banco,
         		b.cta_corriente,
		 	b.num_deposito,
		 	sum(b.importe) importe,
		 	trunc(b.FEC_DEPOSITO) fec_genintcon,
		 	NULL
		 	from  co_movdep b , co_histmovcaja a
         		where a.cod_oficina  = szhCodOficina_Arg
         		and   a.cod_caja     = ihCodCaja
         		and   a.num_secumov  > 0
         		and   a.num_ejercicio= szhNumEjercicio_Arg
         		and   a.cod_caja     =b.cod_caja
         		and   a.cod_oficina  =b.cod_oficina
         		and   a.num_secumov  =b.num_secumov
         		and   a.num_ejercicio=b.num_ejercicio
         		group by a.cod_oficina,a.cod_caja,a.num_ejercicio,a.tip_valor,b.cod_banco,
         		b.cta_corriente,b.num_deposito,trunc(b.fec_deposito);  */

		ihCodCaja:=TO_NUMBER(ihzCodCaja_Arg);
   		INSERT INTO /*+ APPEND */ CO_ACUM_DEPRECAUDA
         	SELECT
	      		a.cod_oficina,
			a.cod_caja,
			a.num_ejercicio,
			a.tip_valor,
			b.cod_banco,
	         	b.cta_corriente,
			b.num_deposito,
			SUM(b.importe) importe,
			TRUNC(b.FEC_DEPOSITO) fec_genintcon,
			NULL,a.cod_operadora_scl, a.cod_plaza
		FROM co_movdep b , co_histmovcaja a
         	WHERE a.cod_oficina  = szhCodOficina_Arg
         	AND a.cod_caja     = ihCodCaja
         	AND a.num_secumov  > 0
         	AND a.num_ejercicio= szhNumEjercicio_Arg
         	AND a.cod_caja     =b.cod_caja
         	AND a.cod_oficina  =b.cod_oficina
         	AND a.num_secumov  =b.num_secumov
         	AND a.num_ejercicio=b.num_ejercicio
         	GROUP BY a.cod_operadora_scl, a.cod_plaza, a.cod_oficina,a.cod_caja,a.num_ejercicio,a.tip_valor,b.cod_banco,
         			b.cta_corriente,b.num_deposito,trunc(b.fec_deposito);

		/* Cajas Por tipo de Documento Recaudado*/
    		/*   se reemplazo por el siguiente , para multiempresa  27/12/2002
		INSERT INTO CO_ACUM_CIERECAUDA
 	     	select 	cod_oficina, cod_caja,  num_ejercicio, tip_valor, sum(importe) importe,
 	      			sysdate 	fec_genintcon,  NULL	   fec_imputcontable, cod_tipdocum, NULL, NULL
		 from  	(select  	a.cod_oficina,  a.cod_caja,  a.num_ejercicio,  1 tip_valor,
						decode(b.imp_pago,NULL,a.importe,nvl(c.imp_concepto,a.importe)) importe,
                        			sysdate fec_genintcon,
                        			decode(c.cod_tipdocum,NULL,99,nvl(c.cod_tipdocrel,c.cod_tipdocum)) cod_tipdocum ,
                        			NULL
                		from  co_pagosconc c,co_pagos b,(	select
												a.cod_oficina, a.cod_caja, a.num_ejercicio,
                    	   								a.num_compago, sum(a.importe) importe
                    	   								from  co_histmovcaja a
                               								where a.cod_oficina  = szhCodOficina_Arg
                                							and   a.cod_caja     = ihCodCaja
                                							and   a.num_secumov  > 0
                                							and   a.num_ejercicio=szhNumEjercicio_Arg
                                							and   a.ind_erroneo  = 0
                                							and   a.tip_movcaja not in ('1','2','3','4','5','10','19','20','21','22','23','24','25')
                                							group by a.cod_oficina,a.cod_caja,a.num_ejercicio,
                                							num_compago) a
                 		where nvl(a.num_compago,-99999)=b.num_compago (+)
        			and   b.num_secuenci=c.num_secuenci (+)
        			and   b.cod_tipdocum=c.cod_tipdocum (+)
        			and   b.cod_vendedor_agente=c.cod_vendedor_agente(+)) a
                 		group by a.cod_oficina,a.cod_caja,a.num_ejercicio,a.tip_valor,a.cod_tipdocum;  */

	       INSERT INTO CO_ACUM_CIERECAUDA
 	       SELECT cod_oficina, cod_caja,  num_ejercicio, tip_valor, sum(importe) importe,
 	      		sysdate fec_genintcon,  NULL	   fec_imputcontable, cod_tipdocum, cod_operadora_scl, cod_plaza
		 FROM (SELECT a.cod_oficina,  a.cod_caja,  a.num_ejercicio,  1 tip_valor,
					  decode(b.imp_pago,NULL,a.importe,nvl(c.imp_concepto,a.importe)) importe,
                        		  sysdate fec_genintcon,
                        		  decode(c.cod_tipdocum,NULL,99,nvl(c.cod_tipdocrel,c.cod_tipdocum)) cod_tipdocum ,
                        		   NULL, a.cod_operadora_scl, a.cod_plaza
                			   --< Se elimina hint(No permitido por área base de datos) / TM-200412061142 / RVelizR - Sop RyC >
                			   --from    co_pagosconc c,co_pagos b,(select /*+ index (a pk_co_histmovcaja */
                         FROM co_pagosconc c,co_pagos b,(SELECT
											a.cod_oficina, a.cod_caja, a.num_ejercicio,    /*--a.tip_valor,*/
                    	   							a.num_compago, SUM(a.importe) importe,a.cod_operadora_scl, a.cod_plaza, a.tip_document
                                                                      FROM co_histmovcaja a
                               						      WHERE a.cod_oficina  = szhCodOficina_Arg
                                                    		      AND a.cod_caja     = ihCodCaja
                                                    		      AND a.num_secumov  > 0
                                                    		      AND a.num_ejercicio=szhNumEjercicio_Arg
                                                    		      AND a.ind_erroneo  = 0
                                                    		      AND a.tip_movcaja NOT IN ('1','2','3','4','5','10','19','20','21','22','23','24','25')
                                                    		      GROUP BY a.cod_oficina,a.cod_caja,a.num_ejercicio, /*--a.tip_valor,*/
                                                    		       num_compago,a.cod_operadora_scl, a.cod_plaza, a.tip_document) a
                 	    WHERE NVL(a.num_compago,-99999)=b.num_compago (+)
        		    AND b.num_secuenci=c.num_secuenci (+)
            		    --   < se reemplaza el outer para que opte por un solo índice / TM-200412061142 / RVelizR -Sop RyC >
			    --   and   a.tip_document=b.cod_tipdocum (+)
                       AND NVL(a.tip_document,0)=NVL(b.cod_tipdocum,0)
			    AND b.cod_tipdocum=c.cod_tipdocum (+)
			    /**  29-05-2003 **/
			    AND b.pref_plaza = vp_pref_plaza
			    /**  29-05-2003 **/
			    AND b.cod_vendedor_agente=c.cod_vendedor_agente(+)) a
                 	    GROUP BY a.cod_operadora_scl, a.cod_plaza, a.cod_oficina,a.cod_caja,a.num_ejercicio,a.tip_valor,a.cod_tipdocum;

		/***/
		COMMIT;
	   	/***/

      /* END IF;	XO-200509050594 */
END CO_GEN_INFORME_CONTABLE_CAJAS;
/
SHOW ERRORS
