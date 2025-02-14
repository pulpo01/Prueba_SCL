CREATE OR REPLACE PROCEDURE        PV_PRE_NOTACREDINTER(
vp_secuencia_ga    IN VARCHAR2,
 vp_ind_ordentotal  IN VARCHAR2,
 vp_tipo_tabla      IN VARCHAR2,
 vp_cod_cliente     IN VARCHAR2,
 vp_num_proceso     IN VARCHAR2,
 vp_categoria_trib  IN VARCHAR2,
 vp_cod_modventa    IN VARCHAR2
 ) IS
oficina             VARCHAR2(2);
secuencia_ga        NUMBER;
vendedor	        NUMBER(6);
snumseq		        NUMBER(12);
Lnumseq		        NUMBER(12);
lseqnue		        NUMBER(12);
vp_letra	        GE_LETRAS.LETRA%TYPE;
cantidad            NUMBER(12);
producto            NUMBER(2);
vp_ordentotal       NUMBER(12);
vp_cod_modgener     VARCHAR2(3);
vp_des_cadena       VARCHAR2(255);
vp_error            NUMBER(2);
usuario	            VARCHAR2(30);
gls_error           VARCHAR2(250);
fecha               VARCHAR(10);
sFecInicio          VARCHAR(10);
sFecFin             VARCHAR(10);
VP_SQLCODE          VARCHAR2(5);
VP_SQLERRM          VARCHAR2(50);
cod_concepto        FA_CONCEPTOS.COD_CONCEPTO%TYPE;
fec_emision         VARCHAR(10);
vp_cod_catimpos     GE_DATOSGENER.COD_CATIMPOS%TYPE; --GE_LETRAS.COD_CATIMPOS%TYPE;
vp_cod_tipdocum     FA_HISTDOCU.COD_TIPDOCUM%TYPE;
cod_vendedor_agente FA_HISTDOCU.COD_VENDEDOR_AGENTE%TYPE;
sletra              FA_HISTDOCU.LETRA%TYPE;
scentremi           FA_HISTDOCU.COD_CENTREMI%TYPE;
ssecuenci           FA_HISTDOCU.NUM_SECUENCI%TYPE;
vp_num_folio        FA_HISTDOCU.NUM_FOLIO%TYPE;
Acum_netograv       FA_HISTDOCU.ACUM_NETOGRAV%TYPE;
acum_netonograv     FA_HISTDOCU.ACUM_NETONOGRAV%TYPE;
acum_iva	        FA_HISTDOCU.ACUM_IVA%TYPE;
cod_plancom         FA_HISTDOCU.COD_PLANCOM%TYPE;
vp_imp_maximo	    FA_CONTROLNC.imp_maximo%TYPE;
centremi            NUMBER(4);
srowid		        VARCHAR(18);
vp_num_dias	        FA_CONTROLNC.num_dias%TYPE;
stotaplicado        NUMBER(14,4);
stotal1             NUMBER(14,4);
ind_supertel	    FA_HISTDOCU.IND_SUPERTEL%TYPE;
vp_ciclo	        FA_HISTDOCU.COD_CICLFACT%TYPE;
vp_tabla            VARCHAR2(20);
ins_ajuste          VARCHAR2(2000);
cursor_name         NUMBER;
rows_processed      INTEGER;
abrir		        NUMBER;
moneda              VARCHAR2(3);
cod_retorno         NUMBER;
des_cadena          VARCHAR2(255);
vp_entrada          varchar2(1);
vp_cantidad			number(4);
ERROR_PROCESO EXCEPTION;

/*  Este en una Copia del PL de Facturacion
    FA_PRE_NOTACREDINTER
	30/05/2002 Christian Estay M.
*/
-- errores de variables IN vp_error := 1;
-- errores de select vp_error := 2;
-- errores de insert vp_error := 3;
-- errores de update vp_error := 4;
-- el ultimo fue Msj30'
BEGIN
  	vp_error := 0;
  	moneda := '001';
  	abrir := 0;
	vp_cantidad	:=0;
  	usuario := '';
    gls_error := gls_error||'Termino Ok';
        if vp_ind_ordentotal is null or vp_ind_ordentotal = '' then
        	    vp_error := 1;
                gls_error := 'Error. Falta ingresar Ind.Ordentotal en parametros de entrada.';
                RAISE ERROR_PROCESO;
        end if;
        if vp_tipo_tabla is null or vp_tipo_tabla = '' then
        	    vp_error := 1;
                gls_error := 'Error. Falta ingresar Tipo Tabla en parametros de entrada.';
                RAISE ERROR_PROCESO;
        end if;
        if vp_cod_cliente is null or vp_cod_cliente = '' then
        	    vp_error := 1;
                gls_error := 'Error. Falta ingresar Cliente en parametros de entrada.';
                RAISE ERROR_PROCESO;
        end if;
        vp_ordentotal := TO_NUMBER(vp_ind_ordentotal);
------- bGetAgenteNOT
        IF vp_tipo_tabla = 'H' THEN
              BEGIN
                  SELECT FEC_EMISION, COD_CATIMPOS, COD_TIPDOCUM , COD_VENDEDOR_AGENTE, LETRA,
                         COD_CENTREMI, NUM_SECUENCI, NUM_FOLIO, ACUM_NETOGRAV,
                         ACUM_NETONOGRAV, COD_PLANCOM, ACUM_IVA, IND_SUPERTEL, COD_CICLFACT
                  INTO   fec_emision, vp_cod_catimpos, vp_cod_tipdocum, cod_vendedor_agente, sletra,
                         scentremi, ssecuenci, vp_num_folio, acum_netograv,
                         acum_netonograv, cod_plancom, acum_iva, ind_supertel, vp_ciclo
                  FROM   FA_HISTDOCU
                  WHERE  IND_ORDENTOTAL = vp_ordentotal;
              EXCEPTION
                  WHEN NO_DATA_FOUND THEN
                  	     vp_error := 2;
                  	     gls_error := 'Error.No encontro datos en el select FA_HISTDOCU Msj1';
                  	     RAISE ERROR_PROCESO;
              END;
              BEGIN
               	  SELECT FA_HISTCONC INTO vp_tabla
                  FROM   FA_ENLACEHIST
                  WHERE  COD_CICLFACT = vp_ciclo;
              EXCEPTION
                  WHEN NO_DATA_FOUND THEN
                  	     vp_error := 2;
                  	     gls_error := 'Error.No encontro datos en el select FA_HISTCONC Msj2';
                  	     RAISE ERROR_PROCESO;
              END;
        ELSE
			  BEGIN
                  SELECT FEC_EMISION, COD_CATIMPOS, COD_TIPDOCUM , COD_VENDEDOR_AGENTE, LETRA,
                         COD_CENTREMI, NUM_SECUENCI, NUM_FOLIO, ACUM_NETOGRAV,
                         ACUM_NETONOGRAV, COD_PLANCOM, ACUM_IVA, IND_SUPERTEL, COD_CICLFACT
                  INTO   fec_emision, vp_cod_catimpos, vp_cod_tipdocum, cod_vendedor_agente, sletra,
                         scentremi, ssecuenci, vp_num_folio, acum_netograv,
                         acum_netonograv, cod_plancom, acum_iva, ind_supertel, vp_ciclo
                  FROM   FA_FACTDOCU_NOCICLO
                  WHERE  IND_ORDENTOTAL = vp_ordentotal;
			  EXCEPTION
                  WHEN NO_DATA_FOUND THEN
                  	     vp_error := 2;
                  	     gls_error := 'Error.No encontro datos en el select FA_FACTDOCU_NOCICLO Msj3';
                  	     RAISE ERROR_PROCESO;
		      END;
        END IF;
        if vp_num_folio <= 0  then
             	vp_error := 5;
                gls_error := 'Error. Documento no tiene asociado num.folio. Msj4';
                RAISE ERROR_PROCESO;
        end if;
		SELECT  COUNT(*) INTO cantidad
        FROM    FA_INTERFACT
        WHERE   num_foliorel = vp_num_folio and
        	    cod_tipmovimien = 25        and
                cod_estadoc < 200;
        if cantidad > 0 then
             	vp_error := 5;
                gls_error := 'Error. Documento tiene pendiente la emision de Nota de Credito.Msj6';
                RAISE ERROR_PROCESO;
        end if;
        If (ind_Supertel = '1') And (vp_cod_tipdocum = '2') Then
             	vp_error := 5;
                gls_error := 'Error. Factura Corresponde a Supertelefono, No es posible generar Nota de Credito Msj7';
                RAISE ERROR_PROCESO;
        End If;
        if cod_vendedor_agente is null then
             	vp_error := 5;
                gls_error := 'Error. Documento no tiene asociado un vendedor.Msj8';
                RAISE ERROR_PROCESO;
        end if;
------- bValnotaCred
        SELECT count(NUM_FOLIO) INTO cantidad
        FROM   FA_AJUSTES
        WHERE  NUM_FOLIO = vp_num_folio
        AND    COD_CLIENTE = vp_cod_cliente
        AND    COD_TIPDOCUM = vp_cod_tipdocum
        AND    ACUM_NETOGRAVNC > 0;
        if cantidad != 0 then
             	vp_error := 6;
                gls_error := 'Error. Factura Ya tiene notas de credito anteriores.Msj29';
                RAISE ERROR_PROCESO;
        end if;
------- bValnotaCred
        SELECT count(NUM_FOLIO) INTO cantidad
        FROM   FA_AJUSTES
        WHERE  NUM_FOLIO = vp_num_folio
        AND    COD_CLIENTE = vp_cod_cliente
        AND    COD_TIPDOCUM = vp_cod_tipdocum;
        if cantidad <= 0 then
		     BEGIN
        	      INSERT INTO FA_AJUSTES
               		  (NUM_FOLIO         ,
              		  ACUM_NETONOGRAVORIG,
			  		  ACUM_NETONOGRAVNC  ,
			  		  ACUM_NETONOGRAVND ,
 	          		  ACUM_NETOGRAVORIG,
              		  ACUM_NETOGRAVNC ,
 	          		  ACUM_NETOGRAVND,
 	          		  COD_PLANCOM,
 	          		  COD_CATIMPOS,
 	          		  ACUM_IVAORIG,
 	          		  ACUM_IVANC,
 	          		  ACUM_IVAND,
 	          		  COD_CLIENTE,
 	          		  COD_TIPDOCUM  )
              		  VALUES
              		  (vp_num_folio,
               		  acum_netograv,
               		  0,
               		  0,
               		  acum_netonograv,
               		  0,
               		  0,
               		  cod_plancom,
               		  vp_cod_catimpos,
 	           		  acum_iva,
 	          		  0,
 	           		  0,
 	           		  vp_cod_cliente,
 	           		  vp_cod_tipdocum);
		      EXCEPTION
		           WHEN DUP_VAL_ON_INDEX THEN
				   	    vp_error := 3;
                   	    gls_error := 'Error.al insertar en la tabla FA_AJUSTES por PK duplicadas Msj30';
                   	    RAISE ERROR_PROCESO;
				   WHEN OTHERS THEN
                        vp_error := 3;
                        gls_error := 'Error.al insertar en la tabla FA_AJUSTES Msj9';
                        RAISE ERROR_PROCESO;
		      END;
---------------bSQLInsertConc
              if vp_tipo_tabla = 'N' then
			        BEGIN
					     --gls_error := gls_error||'INSERT INTO FA_AJUSTECONC';
                         INSERT INTO FA_AJUSTECONC
                        	     (NUM_FOLIO, COD_CONCEPTO, COLUMNA,
                        	      COD_PRODUCTO, FEC_EFECTIVIDAD, IMP_CONCEPTO, COD_MONEDA,
                        	      IMP_FACTURABLE, COD_REGION, COD_PROVINCIA, COD_CIUDAD,
                        	      COD_MODULO, NUM_UNIDADES, NUM_SERIEMEC, COD_TIPCONCE, FEC_VALOR,
                        	  	  IMP_MONTOBASE, IND_FACTUR, IND_SUPERTEL, NUM_ABONADO, COD_PORTADOR,
                        	  	  DES_CONCEPTO, SEQ_CUOTAS, NUM_CUOTAS, ORD_CUOTA, NUM_SERIELE,
                        	  	  MES_GARANTIA, NUM_GUIA, IND_ALTA, NUM_PAQUETE, NUM_VENTA, NUM_TRANSACCION,
                        	  	  FLAG_IMPUES, FLAG_DTO, COD_CLIENTE, COD_TIPDOCUM)
								  SELECT vp_num_folio, a.COD_CONCEPTO,
                        	  		 	 a.COLUMNA, a.COD_PRODUCTO, a.FEC_EFECTIVIDAD, 0,'001',
                        	  		 	 a.IMP_FACTURABLE, a.COD_REGION, a.COD_PROVINCIA,
                        	  		 	 a.COD_CIUDAD, b.COD_MODULO,
                        	 		 	 a.NUM_UNIDADES, a.NUM_SERIEMEC,
                        	  		 	 a.COD_TIPCONCE, a.FEC_VALOR,a.IMP_MONTOBASE,
                        	  		 	 a.IND_FACTUR, c.ind_supertel, a.NUM_ABONADO, a.COD_PORTADOR,
                        	  		 	 a.DES_CONCEPTO, a.SEQ_CUOTAS, a.NUM_CUOTAS, a.ORD_CUOTA,
                        	  		 	 a.NUM_SERIELE, a.MES_GARANTIA, a.NUM_GUIA, a.IND_ALTA,
                        	  		 	 a.NUM_PAQUETE, c.NUM_VENTA, c.NUM_TRANSACCION, a.FLAG_IMPUES,
                        	  		 	 a.FLAG_DTO, c.COD_CLIENTE, C.COD_TIPDOCUM
                        	  FROM   FA_CONCEPTOS          b,
                              		 FA_FACTDOCU_NOCICLO  c,
                              		 FA_FACTCONC_NOCICLO  a
                        	  WHERE  a.IND_ORDENTOTAL =  vp_ordentotal AND
                              		 a.COD_CONCEPTO   =  b.COD_CONCEPTO   AND
                               		 a.IND_ORDENTOTAL =  c.IND_ORDENTOTAL AND
                              		 a.COD_TIPCONCE   <> 1                AND
                              		 ( a.COD_TIPCONCE   <> 2 OR ( a.COD_TIPCONCE = 2 AND (a.COD_CONCEREL=0 OR a.COD_CONCEREL IS NULL)));
					EXCEPTION
				              WHEN OTHERS THEN
                        	  	    vp_error := 3;
                        			gls_error := 'Error.al insertar en la tabla FA_AJUSTECONC Msj10';
                        			RAISE ERROR_PROCESO;
		   			END;
                    BEGIN
    					--gls_error := gls_error||'update INTO FA_AJUSTECONC';
					    UPDATE FA_AJUSTECONC A  -- modifica los cargos insertados anteriormente
                               SET IMP_FACTURABLE = (SELECT A.IMP_FACTURABLE + B.IMP_FACTURABLE
                                                     FROM   FA_FACTCONC_NOCICLO B
                                                     WHERE  B.IND_ORDENTOTAL = vp_ordentotal     AND
                                                            B.COD_TIPCONCE = 2         	         AND
                                                            A.COD_CONCEPTO = B.COD_CONCEREL      AND
                                                            A.COLUMNA = B.COLUMNA_REL)
                        WHERE  A.NUM_FOLIO = vp_num_folio AND
                               A.COD_CONCEPTO IN (SELECT B.COD_CONCEREL
                                                  FROM   FA_FACTCONC_NOCICLO B
                                                  WHERE  B.IND_ORDENTOTAL = vp_ordentotal    AND
                                                         B.COD_TIPCONCE = 2         	     AND
                                                         A.COD_CONCEPTO = B.COD_CONCEREL     AND
                                                         A.COLUMNA = B.COLUMNA_REL);
					EXCEPTION
				              WHEN OTHERS THEN
                        	  	    vp_error := 4;
                        			gls_error := 'Error.al hacer update FA_AJUSTECONC Msj11';
                        			RAISE ERROR_PROCESO;
	                END;
                 	--gls_error := gls_error||to_char(vp_num_folio) || ' '|| vp_cod_cliente ||' ' || to_char(vp_cod_tipdocum);
                    BEGIN
					    SELECT COUNT(A.COD_CONCEPTO)
						INTO vp_cantidad
						FROM FA_AJUSTECONC A
                        WHERE  A.NUM_FOLIO = vp_num_folio AND
						       A.COD_CLIENTE = vp_cod_cliente AND
 	           		  		   A.COD_TIPDOCUM = vp_cod_tipdocum;
					EXCEPTION
				              WHEN OTHERS THEN
                        	  	    vp_error := 4;
                        			gls_error := 'Error.al contar registros insertados EN FA_AJUSTECONC MsjXX';
                        			RAISE ERROR_PROCESO;
	                END;
			    ELSE
			        BEGIN
					       --gls_error := gls_error||'entre abajo';
	        	        	ins_ajuste := 'INSERT INTO FA_AJUSTECONC ';
                        	ins_ajuste := ins_ajuste || '(NUM_FOLIO, COD_CONCEPTO, COLUMNA, ';
                        	ins_ajuste := ins_ajuste || 'COD_PRODUCTO, FEC_EFECTIVIDAD, IMP_CONCEPTO, COD_MONEDA, ';
                        	ins_ajuste := ins_ajuste || 'IMP_FACTURABLE, COD_REGION, COD_PROVINCIA, COD_CIUDAD, ';
                        	ins_ajuste := ins_ajuste || 'COD_MODULO, NUM_UNIDADES, NUM_SERIEMEC, COD_TIPCONCE, FEC_VALOR, ';
                        	ins_ajuste := ins_ajuste || 'IMP_MONTOBASE, IND_FACTUR, IND_SUPERTEL, NUM_ABONADO, COD_PORTADOR, ';
                        	ins_ajuste := ins_ajuste || 'DES_CONCEPTO, SEQ_CUOTAS, NUM_CUOTAS, ORD_CUOTA, NUM_SERIELE, ';
                        	ins_ajuste := ins_ajuste || 'MES_GARANTIA, NUM_GUIA, IND_ALTA, NUM_PAQUETE, NUM_VENTA, NUM_TRANSACCION, ';
                        	ins_ajuste := ins_ajuste || 'FLAG_IMPUES, FLAG_DTO, COD_CLIENTE, COD_TIPDOCUM) ';
                        	ins_ajuste := ins_ajuste || 'SELECT c.num_folio, a.COD_CONCEPTO, ';
                        	ins_ajuste := ins_ajuste || 'a.COLUMNA, a.COD_PRODUCTO, a.FEC_EFECTIVIDAD, 0, ' || rtrim(moneda) || ', ';
                        	ins_ajuste := ins_ajuste || 'a.IMP_FACTURABLE, a.COD_REGION, a.COD_PROVINCIA, ';
                        	ins_ajuste := ins_ajuste || 'a.COD_CIUDAD, b.COD_MODULO, ';
                        	ins_ajuste := ins_ajuste || 'a.NUM_UNIDADES, a.NUM_SERIEMEC, ';
                        	ins_ajuste := ins_ajuste || 'a.COD_TIPCONCE, a.FEC_VALOR,a.IMP_MONTOBASE, ';
                        	ins_ajuste := ins_ajuste || 'a.IND_FACTUR, c.ind_supertel, a.NUM_ABONADO, a.COD_PORTADOR, ';
                        	ins_ajuste := ins_ajuste || 'a.DES_CONCEPTO, a.SEQ_CUOTAS, a.NUM_CUOTAS, a.ORD_CUOTA, ';
                        	ins_ajuste := ins_ajuste || 'a.NUM_SERIELE, a.MES_GARANTIA, a.NUM_GUIA, a.IND_ALTA, ';
                        	ins_ajuste := ins_ajuste || 'a.NUM_PAQUETE, c.NUM_VENTA, c.NUM_TRANSACCION, a.FLAG_IMPUES, ';
                        	ins_ajuste := ins_ajuste || 'a.FLAG_DTO, c.COD_CLIENTE, C.COD_TIPDOCUM ';
                        	ins_ajuste := ins_ajuste || 'FROM  FA_CONCEPTOS         b, ';
                        	ins_ajuste := ins_ajuste || '      FA_HISTDOCU          c, ';
                        	ins_ajuste := ins_ajuste || '     ' || rtrim(vp_tabla) || ' a  ';
                        	ins_ajuste := ins_ajuste || 'WHERE a.IND_ORDENTOTAL = ' || rtrim(to_char(vp_ordentotal)) || ' AND ';
                        	ins_ajuste := ins_ajuste || '      a.COD_CONCEPTO   =  b.COD_CONCEPTO     AND ';
                        	ins_ajuste := ins_ajuste || '      a.IND_ORDENTOTAL =  c.IND_ORDENTOTAL   AND ';
                        	ins_ajuste := ins_ajuste || '      a.COD_TIPCONCE   <> 1                  AND ';
                        	ins_ajuste := ins_ajuste || '      ( a.COD_TIPCONCE   <> 2 OR ( a.COD_TIPCONCE=2 AND (COD_CONCEREL=0 OR COD_CONCEREL IS NULL)))';
	        	      		cursor_name := dbms_sql.open_cursor;
	        	      		dbms_sql.parse(cursor_name, ins_ajuste, dbms_sql.v7);
	        	      		rows_processed := dbms_sql.execute(cursor_name);
	        	      		dbms_sql.close_cursor(cursor_name);
				    EXCEPTION
				            WHEN OTHERS THEN
                        	  	    vp_error := 4;
                        			gls_error := 'Error.al hacer update FA_AJUSTECONC Msj12';
                        			RAISE ERROR_PROCESO;
	                END;
                    BEGIN
	        	        	ins_ajuste := '';
	        	        	ins_ajuste := 'UPDATE FA_AJUSTECONC A ';
			            	ins_ajuste := ins_ajuste || 'SET    IMP_FACTURABLE =  (SELECT A.IMP_FACTURABLE + B.IMP_FACTURABLE ';
							ins_ajuste := ins_ajuste || '                          FROM   ' || rtrim(vp_tabla) || ' B ';
							ins_ajuste := ins_ajuste || '                          WHERE  B.IND_ORDENTOTAL = ' || rtrim(to_char(vp_ordentotal)) || ' AND ';
							ins_ajuste := ins_ajuste || '                                 B.COD_TIPCONCE = 2         	  AND ';
							ins_ajuste := ins_ajuste || '                                 A.COD_CONCEPTO = B.COD_CONCEREL     AND ';
							ins_ajuste := ins_ajuste || '                                 A.COLUMNA = B.COLUMNA_REL) ';
							ins_ajuste := ins_ajuste || 'WHERE  A.NUM_FOLIO = ' || rtrim(to_char(vp_num_folio)) || ' AND ';
							ins_ajuste := ins_ajuste || '       A.COD_CONCEPTO IN (SELECT B.COD_CONCEREL ';
							ins_ajuste := ins_ajuste || '                          FROM   ' || rtrim(vp_tabla) || ' B ';
							ins_ajuste := ins_ajuste || '                          WHERE  B.IND_ORDENTOTAL = ' || rtrim(to_char(vp_ordentotal)) || ' AND ';
							ins_ajuste := ins_ajuste || '                                 B.COD_TIPCONCE = 2         	  AND ';
							ins_ajuste := ins_ajuste || '                                 A.COD_CONCEPTO = B.COD_CONCEREL     AND ';
							ins_ajuste := ins_ajuste || '                                 A.COLUMNA = B.COLUMNA_REL) ';
	        	      		cursor_name := dbms_sql.open_cursor;
	        	      		dbms_sql.parse(cursor_name, ins_ajuste, dbms_sql.v7);
	        	     		rows_processed := dbms_sql.execute(cursor_name);
	        	      		dbms_sql.close_cursor(cursor_name);
					EXCEPTION
				            WHEN OTHERS THEN
                        	  	    vp_error := 4;
                        			gls_error := 'Error.al hacer update FA_AJUSTECONC Msj13';
                        			RAISE ERROR_PROCESO;
	                END;
             end if;
        end if;
------- sSecuenciaEmi
		SELECT FA_SEQ_CREDITO.NEXTVAL INTO snumseq
        FROM   DUAL;
        snumseq := snumseq + 1;
        BEGIN
        		SELECT user, RTRIM(to_char(SYSDATE, 'dd-mm-yyyy')) INTO usuario, fecha
				FROM   DUAL;
		EXCEPTION
				WHEN NO_DATA_FOUND THEN
                  	 vp_error := 2;
					 gls_error := 'Error.al sacar el sysdate from dual Msj15';
                  	 RAISE ERROR_PROCESO;
		END;
        SELECT NVL(COD_VENDEDOR, -1), NVL(COD_OFICINA, ' ') INTO vendedor, oficina
        FROM   GE_SEG_USUARIO
        WHERE  NOM_USUARIO = usuario;
		if vendedor = -1 or oficina = ' ' then
               SELECT COD_AGENTESTARTEL, COD_OFICCENTRAL INTO vendedor, oficina
               FROM   GE_DATOSGENER;
               if vendedor = -1 or oficina = ' ' then
            	        vp_error := 2;
                        gls_error := 'Error. No existe vendedor.Msj16';
                        RAISE ERROR_PROCESO;
               end if;
        end if;
        BEGIN
        	   SELECT COD_CENTREMI INTO centremi
        	   FROM   AL_DOCUM_SUCURSAL
        	   WHERE  COD_TIPDOCUM = 25 AND
                      COD_OFICINA = oficina;
		EXCEPTION
			   WHEN NO_DATA_FOUND THEN
                   vp_error := 2;
				   gls_error := 'Error.al sacar COD_CENTREMI Msj17';
                   RAISE ERROR_PROCESO;
        END;
------- bGetLetraAG
        BEGIN
		       SELECT LETRA INTO vp_letra
        	   FROM   GE_LETRAS
			   WHERE  COD_CATIMPOS = vp_cod_catimpos
				      AND COD_TIPDOCUM = 25;
		EXCEPTION
			   WHEN NO_DATA_FOUND THEN
                   vp_error := 2;
				   gls_error := 'Error.en el select GE_LETRAS Msj18';
                   RAISE ERROR_PROCESO;
	    END;
        if vp_letra = ' ' then
             	vp_error := 5;
                gls_error := 'Error. Categoria impositiva no tiene asociada Letra (GE_LETRAS).Msj19';
                RAISE ERROR_PROCESO;
        end if;
--- bInsertProceso
        BEGIN
   	    	 INSERT INTO FA_PROCESOS( NUM_PROCESO, COD_TIPDOCUM, COD_VENDEDOR_AGENTE,
                           COD_CENTREMI, FEC_EFECTIVIDAD, NOM_USUARORA,
                           LETRAAG, NUM_SECUAG, COD_TIPDOCNOT, COD_VENDEDOR_AGENTENOT,
				           LETRANOT, COD_CENTRNOT, NUM_SECUNOT, IND_ESTADO, COD_CICLFACT, IND_NOTACREDC)
                           VALUES (to_number(vp_num_proceso), 25, vendedor,
--      	               centremi, fec_emision, usuario,
      		               centremi, SYSDATE, usuario,
        	               vp_letra, snumseq, vp_cod_tipdocum, cod_vendedor_agente,
        	               sletra, scentremi, ssecuenci, NULL, NULL, 0
       	                  );
		EXCEPTION
			 WHEN OTHERS THEN
                	  	  vp_error := 3;
                          gls_error := 'Error.En el INSERT FA_PROCESOS Msj20';
                          RAISE ERROR_PROCESO;
	    END;
------- bInsertPrefactura
		BEGIN
		     INSERT INTO FA_PREFACTURA
        	   		  	   (NUM_PROCESO, COD_CLIENTE, COD_CONCEPTO, COLUMNA,
        				   COD_PRODUCTO, COD_MONEDA, FEC_VALOR, FEC_EFECTIVIDAD, IMP_CONCEPTO,
						   IMP_FACTURABLE, IMP_MONTOBASE, COD_REGION, COD_PROVINCIA, COD_CIUDAD,
        				   COD_MODULO, COD_PLANCOM, IND_FACTUR, COD_CATIMPOS,COD_PORTADOR,IND_ESTADO,
        				   COD_TIPCONCE,NUM_UNIDADES,COD_CICLFACT,COD_CONCEREL,COLUMNA_REL,NUM_ABONADO,
       					   NUM_TERMINAL,CAP_CODE,NUM_SERIEMEC,NUM_SERIELE,FLAG_IMPUES,FLAG_DTO,NUM_VENTA,
        				   NUM_TRANSACCION,MES_GARANTIA,NUM_GUIA,IND_ALTA,IND_SUPERTEL,NUM_PAQUETE,IND_CUOTA,
        				   NUM_CUOTAS, ORD_CUOTA, COD_TIPDOCUM)
        				   SELECT to_number(vp_num_proceso),  to_number(vp_cod_cliente), a.COD_CONCEPTO, a.COLUMNA, a.COD_PRODUCTO,
 	            				   '001',a.FEC_VALOR, a.FEC_EFECTIVIDAD,
 		        				   a.IMP_CONCEPTO, a.IMP_FACTURABLE, 0, a.COD_REGION, a.COD_PROVINCIA, a.COD_CIUDAD,
 		        				   a.COD_MODULO, b.COD_PLANCOM, a.IND_FACTUR, b.COD_CATIMPOS, a.COD_PORTADOR,
 		        				   0, a.COD_TIPCONCE, 1, NULL, NULL, NULL, a.NUM_ABONADO, NULL, NULL,
 		        				   a.NUM_SERIEMEC, a.NUM_SERIELE, a.FLAG_IMPUES, a.FLAG_DTO, a.NUM_VENTA,
 		        				   a.NUM_TRANSACCION, a.MES_GARANTIA, a.NUM_GUIA, a.IND_ALTA, a.IND_SUPERTEL,
                				   a.NUM_PAQUETE, a.SEQ_CUOTAS, a.NUM_CUOTAS, a.ORD_CUOTA, B.COD_TIPDOCUM
        					FROM    FA_AJUSTECONC a, FA_AJUSTES b
        					WHERE   a.NUM_FOLIO = vp_num_folio     AND
                					a.COD_CLIENTE = to_number(vp_cod_cliente) AND
                					b.COD_TIPDOCUM = vp_cod_tipdocum AND
 		        					a.NUM_FOLIO = b.NUM_FOLIO   AND
	            					a.COD_CLIENTE = b.COD_CLIENTE AND
	            					a.COD_TIPDOCUM = b.COD_TIPDOCUM;
	    EXCEPTION
			 WHEN OTHERS THEN
                	  	  vp_error := 3;
                          gls_error := 'Error.En el INSERT FA_PREFACTURA Msj21';
                          RAISE ERROR_PROCESO;
	    END;
------- bControlPeriodo
	    vp_imp_maximo := 0;
	    vp_num_dias   := 0;
		BEGIN
		        SELECT  IMP_MAXIMO, NUM_DIAS
                INTO 	vp_imp_maximo, vp_num_dias
        		FROM    FA_CONTROLNC
      			WHERE   NOM_USUARIO = usuario AND
                		FEC_DESDE <= SYSDATE  AND
                		FEC_HASTA >= SYSDATE;
	    EXCEPTION
			    WHEN OTHERS THEN
                	   	vp_error := 2;
				    	gls_error := 'Error.Existe mas de un registro a asignar Msj22';
                   	    RAISE ERROR_PROCESO;
		END;
  		SELECT COUNT(*) INTO CANTIDAD
   		FROM    fa_aplicadonc
   		WHERE   NOM_USUARIO = usuario  AND
           		COD_CLIENTE = to_number(vp_cod_cliente)  AND
           		FEC_INICIO <= SYSDATE      AND
       			FEC_FIN >= SYSDATE;
        if CANTIDAD <= 0 then
--------------- bInsertAplicadoNC
	            BEGIN
					 INSERT INTO FA_APLICADONC(NOM_USUARIO, COD_CLIENTE, FEC_INICIO, FEC_FIN, TOT_APLICADO)
                                 VALUES ( usuario, to_number(vp_cod_cliente),
                                          TO_DATE(TO_CHAR(TRUNC(SYSDATE, 'MONTH'), 'DD-MM-YYYY HH24:MI:SS'), 'DD-MM-YYYY HH24:MI:SS'),
                                          TO_DATE(TO_CHAR(TRUNC(ADD_MONTHS(SYSDATE,1),'MONTH')-1/86400, 'DD-MM-YYYY HH24:MI:SS'), 'DD-MM-YYYY HH24:MI:SS'),
                                          acum_netograv
                                         );
	  		    EXCEPTION
			         WHEN OTHERS THEN
                	  	  vp_error := 3;
                          gls_error := 'Error.En el INSERT FA_APLICADONC Msj23';
                          RAISE ERROR_PROCESO;
			    END;
        else
                SELECT  ROWID, TOT_APLICADO, TO_CHAR(FEC_INICIO, 'DD/MM/YYYY'), TO_CHAR(FEC_FIN, 'DD/MM/YYYY')
                        INTO srowid, sTotAplicado, sFecInicio, sFecFin
                FROM    FA_APLICADONC
                WHERE   NOM_USUARIO = usuario  AND
                        COD_CLIENTE = to_number(vp_cod_cliente)  AND
                        FEC_INICIO <= SYSDATE      AND
                        FEC_FIN >= SYSDATE;
        	    stotal1 := acum_netograv + sTotAplicado;
                if stotal1 <= vp_imp_maximo then
				       BEGIN
	                   	   UPDATE FA_APLICADONC
	                   	   SET    TOT_APLICADO = TOT_APLICADO + acum_netograv
		               	   WHERE  ROWID = sRowid;
					   EXCEPTION
			           	   WHEN OTHERS THEN
                	  	   vp_error := 3;
                           gls_error := 'Error.En el INSERT FA_APLICADONC Msj24';
                           RAISE ERROR_PROCESO;
			    	   END;
                else
            	       vp_error := 2;
                       gls_error := 'Error. Se ha sobrepasado el Limite Importe para el Usuario. Msj25';
                       RAISE ERROR_PROCESO;
                end if;
        end if;
------- bUpdConc_tot
		BEGIN
      		 UPDATE  FA_AJUSTECONC
      		 SET     IMP_CONCEPTO = IMP_FACTURABLE
     		 WHERE   NUM_FOLIO    = vp_Num_Folio AND
           			 COD_CLIENTE  = to_number(vp_cod_cliente) AND
       	    		 COD_TIPDOCUM = vp_cod_tipdocum;
		EXCEPTION
			 WHEN OTHERS THEN
                 	 vp_error := 4;
                     gls_error := 'Error.En el UPDATE FA_AJUSTECONC Msj26';
                     RAISE ERROR_PROCESO;
		END;
        lSeqNue := sNumSeq + 1;
------- bUpdSecuencia
        BEGIN
      		UPDATE  GE_SECUENCIASEMI
       		SET     NUM_SECUENCI = lSeqNue
      		WHERE   COD_TIPDOCUM = 25       AND
           	    	COD_CENTREMI = centremi AND
                    LETRA = vp_letra; -- GE_LETRAS
		EXCEPTION
			WHEN OTHERS THEN
                 	vp_error := 4;
                    gls_error := 'Error.En el UPDATE GE_SECUENCIASEMI Msj27';
                    RAISE ERROR_PROCESO;
		END;
        SELECT GA_SEQ_TRANSACABO.NEXTVAL INTO secuencia_ga
        FROM   DUAL;
		BEGIN
        	   SELECT 	COD_MODGENER INTO vp_cod_modgener
        	   FROM 	FA_GENCENTREMI
        	   WHERE 	COD_CENTREMI = centremi AND
            			COD_TIPMOVIMIEN = 25    AND
            			COD_CATRIBUT = vp_categoria_trib AND
		        		COD_MODVENTA = TO_NUMBER(vp_cod_modventa);
    	        		vp_entrada := '0';
		EXCEPTION
			   WHEN NO_DATA_FOUND THEN
                  		vp_error := 2;
				   		gls_error := 'Error.al en el select en la FA_GENCENTREMI  Msj28';
                    	RAISE ERROR_PROCESO;
		END;
        PV_INS_INTERFACT( to_char(secuencia_ga), vp_num_proceso, '0',
 		    		    vp_cod_modgener, '25', vp_categoria_trib, to_char(vp_num_folio), '100', '3', fecha, vp_entrada, vp_cod_modventa, '0');
						select COD_RETORNO, DES_CADENA into cod_retorno, des_cadena
						from   ga_transacabo
						where  num_transaccion = secuencia_ga;
 	    if cod_retorno != 0 then
		      vp_error := 9;
		      gls_error := 'Error. En Llamado a PL FA_INS_INTERFACT Scuencia = '||to_char(secuencia_ga);
              RAISE ERROR_PROCESO;
	    else
	          delete from ga_transacabo where num_transaccion = secuencia_ga;
	    end if;
   RAISE ERROR_PROCESO;
   EXCEPTION
      WHEN ERROR_PROCESO THEN
           /*if vp_error != 0 then
                ROLLBACK;
           end if;*/
           INSERT INTO GA_TRANSACABO (NUM_TRANSACCION, COD_RETORNO, DES_CADENA)
           VALUES (TO_NUMBER(vp_secuencia_ga), vp_error, gls_error );
      WHEN DUP_VAL_ON_INDEX THEN
           --ROLLBACK;
           INSERT INTO GA_TRANSACABO (NUM_TRANSACCION, COD_RETORNO, DES_CADENA)
           VALUES (TO_NUMBER(vp_secuencia_ga), 1, 'Duplicado');
      WHEN NO_DATA_FOUND THEN
           --ROLLBACK;
           INSERT INTO GA_TRANSACABO (NUM_TRANSACCION, COD_RETORNO, DES_CADENA)
           VALUES (TO_NUMBER(vp_secuencia_ga), 1, 'Datos No Fueron Encontrados');
      WHEN OTHERS THEN
           --ROLLBACK;
      	   INSERT INTO GA_TRANSACABO (NUM_TRANSACCION, COD_RETORNO, DES_CADENA)
           VALUES (TO_NUMBER(vp_secuencia_ga), 1, 'Otros Errores No Esperados');
END PV_PRE_NOTACREDINTER;
/
SHOW ERRORS
