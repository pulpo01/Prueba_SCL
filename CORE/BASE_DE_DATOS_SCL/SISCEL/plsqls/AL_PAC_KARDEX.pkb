CREATE OR REPLACE PACKAGE BODY Al_Pac_Kardex IS
   v_concepto		 sc_ent_lote.cod_concepto%TYPE;
   v_vtipoapertura   ged_parametros.val_parametro%TYPE;
   v_aper_tecnologia SC_INDAPERTURA_TD.aper_tecnologia%TYPE;
   v_aper_oficina    SC_INDAPERTURA_TD.aper_oficina%TYPE;
   v_aper_articulo  SC_INDAPERTURA_TD.aper_tecnologia%TYPE; /*   TMM-04092   Diciembre 2004 */

--   v_aper_operadora  sc_indapertura_td.aper_operadora%type;
   v_SI VARCHAR2(1) := 'S';
   v_NO VARCHAR2(1) := 'N';
   v_id_lote         sc_ent_cab_lote.id_lote%TYPE;
   v_error_concepto  sc_error_ingreso.cod_error%TYPE := 5;
   bRet   BOOLEAN:=FALSE;

PROCEDURE P_INGRESO_ENTRADA(
v_error IN OUT AL_INTERCIERRE.cod_retorno%TYPE)IS

CURSOR Lotes_Ofic_Tecno IS
------ TODAS LAS CABECERAS ------ CURSOR PARA APERTURA POR TECNOLOGIA y bodega
   SELECT  TRUNC(a.fec_movimiento),
   69 cod_evento,
   'E/'||TO_CHAR(a.fec_movimiento,'yyyymmdd') id_lote,
   TO_CHAR(a.fec_periodo,'yyyymm') per_contable,
   USER nom_usuario_lote,
   SYSDATE fec_lote,
   c.cod_operadora_scl operadora,
   a.cod_grpconcepto cod_grpconcepto,
   d.cod_tecnologia cod_tecnologia
   FROM   AL_KARDEX a, al_tecnoarticulo_td d, al_bodeganodo b, ge_operadora_scl c
   WHERE  a.fec_imputentsal IS NULL
   AND    a.ind_entsal ='E'
   AND    a.cod_motivo IS NOT NULL
   AND    d.ind_defecto = 1
   AND    a.cod_articulo = d.cod_articulo
   AND    a.cod_bodega = b.cod_bodega
   AND    b.cod_bodeganodo = c.cod_bodeganodo
--   and    a.fec_movimiento  < trunc(sysdate)
   GROUP BY  TRUNC(a.fec_movimiento) ,TO_CHAR(a.fec_movimiento,'yyyymmdd'),
   TO_CHAR(a.fec_periodo,'yyyymm'),c.cod_operadora_scl,a.cod_grpconcepto,d.cod_tecnologia;

CURSOR Lotes_Tecno IS
------ TODAS LAS CABECERAS ------ CURSOR PARA APERTURA POR TECNOLOGIA
   SELECT  TRUNC(a.fec_movimiento),
   69 cod_evento,
   'E/'||TO_CHAR(a.fec_movimiento,'yyyymmdd') id_lote,
   TO_CHAR(a.fec_periodo,'yyyymm') per_contable,
   USER nom_usuario_lote,
   SYSDATE fec_lote,
   c.cod_operadora_scl operadora,
   d.cod_tecnologia cod_tecnologia
   FROM   AL_KARDEX a, al_tecnoarticulo_td d, al_bodeganodo b , ge_operadora_scl c
   WHERE  a.fec_imputentsal IS NULL
   AND    a.ind_entsal ='E'
   AND    a.cod_motivo IS NOT NULL
   AND    d.ind_defecto = 1
   AND    a.cod_articulo = d.cod_articulo
   AND    a.cod_bodega = b.cod_bodega
   AND    a.fec_movimiento  < TRUNC(SYSDATE)
   AND    b.cod_bodeganodo = c.cod_bodeganodo
   GROUP BY  TRUNC(a.fec_movimiento) ,TO_CHAR(a.fec_movimiento,'yyyymmdd'),
   TO_CHAR(a.fec_periodo,'yyyymm'),c.cod_operadora_scl,d.cod_tecnologia;
--
CURSOR Lotes_Ofic IS
------ TODAS LAS CABECERAS ------ CURSOR APERTURA POR OFICINA (bodega)
   SELECT  TRUNC(a.fec_movimiento),
   69 cod_evento,
   'E/'||TO_CHAR(a.fec_movimiento,'yyyymmdd') id_lote,
   TO_CHAR(a.fec_periodo,'yyyymm') per_contable,
   USER nom_usuario_lote,
   SYSDATE fec_lote,
   c.cod_operadora_scl operadora,
   a.cod_grpconcepto cod_grpconcepto
   FROM   AL_KARDEX a, al_bodeganodo b , ge_operadora_scl c
   WHERE  a.fec_imputentsal IS NULL
   AND    a.ind_entsal ='E'
   AND    a.cod_motivo IS NOT NULL
   AND    a.cod_bodega = b.cod_bodega
   AND    a.fec_movimiento  < TRUNC(SYSDATE)
   AND    b.cod_bodeganodo = c.cod_bodeganodo
   GROUP BY  TRUNC(a.fec_movimiento) ,TO_CHAR(a.fec_movimiento,'yyyymmdd'),
   TO_CHAR(a.fec_periodo,'yyyymm'),c.cod_operadora_scl,a.cod_grpconcepto;
 --
CURSOR Lotes IS
------ TODAS LAS CABECERAS ------ APERTURA POR OPERADORA
   SELECT  TRUNC(a.fec_movimiento),
   69 cod_evento,
   'E/'||TO_CHAR(a.fec_movimiento,'yyyymmdd') id_lote,
   TO_CHAR(a.fec_periodo,'yyyymm') per_contable,
   USER nom_usuario_lote,
   SYSDATE fec_lote,
   c.cod_operadora_scl operadora
   FROM   AL_KARDEX a, al_bodeganodo b , ge_operadora_scl c
   WHERE  a.fec_imputentsal IS NULL
   AND    a.ind_entsal ='E'
   AND    a.cod_motivo IS NOT NULL
   AND    a.cod_bodega = b.cod_bodega
   AND    a.fec_movimiento  < TRUNC(SYSDATE)
   AND    b.cod_bodeganodo = c.cod_bodeganodo
   GROUP BY  TRUNC(a.fec_movimiento) ,TO_CHAR(a.fec_movimiento,'yyyymmdd'),
   TO_CHAR(a.fec_periodo,'yyyymm'),c.cod_operadora_scl;

CURSOR detalle_lotes_Ofic_Tecno IS
-- DETALLE DE APERTURA POR TECNOLOGIA
        SELECT  /*+ index(b) */
		69 cod_evento,
        'E/'||TO_CHAR(a.fec_movimiento,'yyyymmdd') id_lote,
        LPAD(a.tip_movimiento,6,0) cod_concepto,
        NVL(SUM(a.cant_entrada * a.prc_unitario),0) imp_movimiento,
        NULL des_transaccion,
		f.cod_operadora_scl	operadora,
		a.cod_grpconcepto cod_grpconcepto,
		g.cod_tecnologia cod_tecnologia
        FROM   ge_direcciones b ,(SELECT /*+ index(a1,ak01_al_kardex) */ a1.*
                                 FROM  AL_KARDEX a1
                                 WHERE a1.cod_motivo IS NOT NULL
                                 AND   a1.ind_entsal = 'E'
				 AND   a1.num_movkardex > -1
		 		 AND   a1.fec_imputentsal IS NULL
				 /*AND   a1.fec_movimiento < TRUNC (SYSDATE)*/) a,
 			    ge_ciudades c, al_tecnoarticulo_td g , al_bodegas d , al_bodeganodo e , ge_operadora_scl f
        WHERE  b.cod_direccion > -1
        AND    b.cod_direccion  =  d.cod_direccion
        AND    b.cod_region     =  c.cod_region
        AND    b.cod_provincia  =  c.cod_provincia
        AND    b.cod_ciudad     =  c.cod_ciudad
		AND    g.ind_defecto    =  1
		AND    a.cod_articulo   =  g.cod_articulo
        AND    a.cod_bodega     =  d.cod_bodega
		AND    d.cod_bodega     =  e.cod_bodega
		AND    e.cod_bodeganodo =  f.cod_bodeganodo
        GROUP BY  a.fec_movimiento,a.fec_periodo,a.tip_movimiento,f.cod_operadora_scl, a.cod_grpconcepto,g.cod_tecnologia;
--

CURSOR detalle_lotes_Tecno IS
-- DETALLE DE APERTURA POR TECNOLOGIA
        SELECT  /*+ index(b) */
		69 cod_evento,
        'E/'||TO_CHAR(a.fec_movimiento,'yyyymmdd') id_lote,
        LPAD(a.tip_movimiento,6,0) cod_concepto,
        NVL(SUM(a.cant_entrada * a.prc_unitario),0) imp_movimiento,
        NULL des_transaccion,
		f.cod_operadora_scl	operadora,
		g.cod_tecnologia cod_tecnologia
        FROM   ge_direcciones b ,(SELECT /*+ index(a1,ak01_al_kardex) */ a1.*
                                 FROM  AL_KARDEX a1
                                 WHERE a1.cod_motivo IS NOT NULL
                                 AND   a1.ind_entsal = 'E'
				 AND   a1.num_movkardex > -1
		 		 AND   a1.fec_imputentsal IS NULL
				 AND   a1.fec_movimiento < TRUNC (SYSDATE)) a,
 			   ge_ciudades c, al_tecnoarticulo_td g, al_bodegas d , al_bodeganodo e , ge_operadora_scl f
        WHERE  b.cod_direccion > -1
        AND    b.cod_direccion  =  d.cod_direccion
        AND    b.cod_region     =  c.cod_region
        AND    b.cod_provincia  =  c.cod_provincia
        AND    b.cod_ciudad     =  c.cod_ciudad
		AND    g.ind_defecto    =  1
		AND    a.cod_articulo   =  g.cod_articulo
        AND    a.cod_bodega     =  d.cod_bodega
		AND    d.cod_bodega     =  e.cod_bodega
		AND    e.cod_bodeganodo =  f.cod_bodeganodo
        GROUP BY  a.fec_movimiento,a.fec_periodo,a.tip_movimiento,f.cod_operadora_scl, g.cod_tecnologia;
--
-- DETALLE DE APERTURA POR OFICINA
CURSOR detalle_lotes_Ofic IS
        SELECT  /*+ index(b) */
		69 cod_evento,
        'E/'||TO_CHAR(a.fec_movimiento,'yyyymmdd') id_lote,
        LPAD(a.tip_movimiento,6,0) cod_concepto,
        NVL(SUM(a.cant_entrada * a.prc_unitario),0) imp_movimiento,
        NULL des_transaccion,
		f.cod_operadora_scl	operadora,
		a.cod_grpconcepto cod_grpconcepto
        FROM   ge_direcciones b ,(SELECT /*+ index(a1,ak01_al_kardex) */ a1.*
                                 FROM  AL_KARDEX a1
                                 WHERE a1.cod_motivo IS NOT NULL
                                 AND   a1.ind_entsal = 'E'
				 AND   a1.num_movkardex > -1
		 		 AND   a1.fec_imputentsal IS NULL
				 AND   a1.fec_movimiento < TRUNC (SYSDATE)) a,
 			   ge_ciudades c, al_bodegas d ,  al_bodeganodo e , ge_operadora_scl f
        WHERE  b.cod_direccion > -1
        AND    b.cod_direccion  =  d.cod_direccion
        AND    b.cod_region     =  c.cod_region
        AND    b.cod_provincia  =  c.cod_provincia
        AND    b.cod_ciudad     =  c.cod_ciudad
	    AND    a.cod_bodega     =  d.cod_bodega
	    AND    d.cod_bodega     = e.cod_bodega
		AND    e.cod_bodeganodo = f.cod_bodeganodo
        GROUP BY  a.fec_movimiento,a.fec_periodo,a.tip_movimiento,f.cod_operadora_scl, a.cod_grpconcepto;
--
-- DETALLE DE APERTURA POR OPERADORA
CURSOR detalle_lotes IS
        SELECT  /*+ index(b) */
		69 cod_evento,
        'E/'||TO_CHAR(a.fec_movimiento,'yyyymmdd') id_lote,
        LPAD(a.tip_movimiento,6,0) cod_concepto,
        NVL(SUM(a.cant_entrada * a.prc_unitario),0) imp_movimiento,
        NULL des_transaccion,
        c.cod_plaza cod_plaza,
		f.cod_operadora_scl	operadora
        FROM   ge_direcciones b ,(SELECT /*+ index(a1,ak01_al_kardex) */ a1.*
                                 FROM  AL_KARDEX a1
                                 WHERE a1.cod_motivo IS NOT NULL
                                 AND   a1.ind_entsal = 'E'
								 AND   a1.num_movkardex > -1
		 		 		         AND   a1.fec_imputentsal IS NULL
								 AND   a1.fec_movimiento < TRUNC (SYSDATE)) a,
 			   al_bodegas d , ge_ciudades c,  al_bodeganodo e , ge_operadora_scl f
        WHERE  b.cod_direccion > -1
        AND    b.cod_direccion  =  d.cod_direccion
        AND    b.cod_region     =  c.cod_region
        AND    b.cod_provincia  =  c.cod_provincia
        AND    b.cod_ciudad     =  c.cod_ciudad
	AND    a.cod_bodega     =  d.cod_bodega
	AND    d.cod_bodega     = e.cod_bodega
	AND    e.cod_bodeganodo = f.cod_bodeganodo
        GROUP BY  a.fec_movimiento,a.fec_periodo,a.tip_movimiento,c.cod_plaza, f.cod_operadora_scl;


/*   InicioTMM-0492 Apertura por Articulo  Diciembre 2004 */

		CURSOR Lotes_Articulo_Tecnologia IS
		SELECT  TRUNC(a.fec_movimiento),
		69 cod_evento,
		'E/'||TO_CHAR(a.fec_movimiento,'yyyymmdd') id_lote,
		TO_CHAR(a.fec_periodo,'yyyymm') per_contable,
		USER nom_usuario_lote,
		SYSDATE fec_lote,
		c.cod_operadora_scl operadora,
		a.cod_grpconcepto  cod_grpconcepto,
		a.cod_grpconcepto_articulo cod_grpconcepto_articulo,
		d.cod_tecnologia cod_tecnologia
		FROM   AL_KARDEX a, al_tecnoarticulo_td d, al_bodeganodo b, ge_operadora_scl c
		WHERE  a.fec_imputentsal IS NULL
		AND    a.ind_entsal ='E'
		AND    a.cod_motivo IS  NULL
		AND    d.ind_defecto = 1
		AND    a.cod_articulo = d.cod_articulo
		AND    a.cod_bodega = b.cod_bodega
		AND    b.cod_bodeganodo = c.cod_bodeganodo
		GROUP BY  TRUNC(a.fec_movimiento) ,TO_CHAR(a.fec_movimiento,'yyyymmdd'),
		TO_CHAR(a.fec_periodo,'yyyymm'),c.cod_operadora_scl,a.cod_grpconcepto_articulo,a.cod_grpconcepto, d.cod_tecnologia;

          CURSOR DetLotes_Articulo_Tecnologia  IS
	      SELECT
		  69 cod_evento,
	      'E/'||TO_CHAR(a.fec_movimiento,'yyyymmdd') id_lote,
	      LPAD(a.cod_grpconcepto_articulo,6,0) cod_concepto,
	      NVL(SUM(a.cant_entrada * a.prc_unitario),0) imp_movimiento,
	      NULL des_transaccion,
			f.cod_operadora_scl	operadora,
            a.cod_grpconcepto cod_grpconcepto,
			a.cod_grpconcepto_articulo cod_grpconcepto_articulo,
			g.cod_tecnologia cod_tecnologia
			 FROM   ge_direcciones b ,(SELECT a1.*
			                          FROM  AL_KARDEX a1
			                          WHERE a1.cod_motivo IS  NULL
			                          AND   a1.ind_entsal = 'E'
			AND   a1.num_movkardex > -1
			AND   a1.fec_imputentsal IS NULL) a,
			 ge_ciudades c, al_tecnoarticulo_td g , al_bodegas d , al_bodeganodo e , ge_operadora_scl f
		      WHERE  b.cod_direccion > -1
		      AND    b.cod_direccion  =  d.cod_direccion
		      AND    b.cod_region     =  c.cod_region
		      AND    b.cod_provincia  =  c.cod_provincia
		      AND    b.cod_ciudad     =  c.cod_ciudad
			AND    g.ind_defecto    =  1
			AND    a.cod_articulo   =  g.cod_articulo
			AND    a.cod_bodega     =  d.cod_bodega
			AND    d.cod_bodega     =  e.cod_bodega
			AND    e.cod_bodeganodo =  f.cod_bodeganodo
			GROUP BY  a.fec_movimiento,a.cod_grpconcepto_articulo, f.cod_operadora_scl,
			a.cod_grpconcepto,g.cod_tecnologia;



/*   Fin TMM-0492 Apertura por Articulo  Diciembre 2004 */

   ihcodevento      sc_evento.cod_evento%TYPE;
   szhidlote        sc_ent_lote.id_lote%TYPE;
   szhDesError      sc_error_ingreso.cod_error%TYPE;
   v_bodeganodo     al_bodeganodo.cod_bodeganodo%TYPE;
   BEGIN

       /*   TMM-04092   Diciembre 2004  */
      /*                     	   Se modifica la QUERY sc_indapertura_td agregando  la columna aper_articulo   */
	     SELECT aper_bodega, aper_tecnologia, aper_articulo
		  INTO v_aper_oficina, v_aper_tecnologia, v_aper_articulo
		  FROM SC_INDAPERTURA_TD
		  WHERE cod_modulo = 'AL';
          IF v_aper_articulo = v_SI THEN
		  /*   TMM-04092   Diciembre 2004  ,     Logica de Apretura  por  Articulo  */
					FOR cc IN Lotes_Articulo_Tecnologia  LOOP
								v_id_lote := cc.id_lote||'/'||cc.cod_grpconcepto_articulo||'/'||cc.cod_tecnologia||'/';
								INSERT INTO sc_ent_cab_lote (cod_evento,id_lote,per_contable,nom_usuario_lote,fec_lote, cod_operadora_scl)
								VALUES ( cc.cod_evento, v_id_lote, cc.per_contable, cc.nom_usuario_lote, cc.fec_lote,cc.operadora);
					END LOOP;

					FOR cc1 IN DetLotes_Articulo_Tecnologia  LOOP
							   v_id_lote := cc1.id_lote||'/'||cc1.cod_grpconcepto_articulo   ||'/'||cc1.cod_tecnologia||'/';
							   v_concepto :=SC_CONCEPTOGRP_FN(cc1.cod_evento,'AL_ARTICULOS',cc1.cod_grpconcepto_articulo,'AL_BODEGAS',cc1.cod_grpconcepto,'AL_TECNOLOGIA',cc1.cod_tecnologia);
							   IF v_concepto IS NULL THEN
						            v_concepto := 'E'||cc1.cod_concepto;
						   	   END IF;
			                   INSERT INTO sc_ent_lote (cod_evento,id_lote,cod_concepto,imp_movimiento, cod_operadora_scl)
			                             VALUES (cc1.cod_evento, v_id_lote, v_concepto, cc1.imp_movimiento, cc1.operadora);
					END LOOP;

					FOR cc IN Lotes_Articulo_Tecnologia  LOOP
							szhDesError:=0;
							v_id_lote := cc.id_lote||'/'||cc.cod_grpconcepto_articulo||'/'||cc.cod_tecnologia||'/';
							SC_P_INGRESA_LOTE(TO_CHAR(cc.cod_evento),v_id_lote,cc.operadora);
							SELECT COUNT(1)  INTO   szhDesError
							FROM   sc_error_ingreso
							WHERE  cod_evento = cc.cod_evento AND
								   			   id_lote    = v_id_lote AND
											   cod_error  <> v_error_concepto;
							IF szhDesError=0  THEN
							   				  bRet := TRUE;
							ELSE
											  bRet := FALSE;
							END IF;
					END LOOP;

		  ELSE
				  IF  v_aper_oficina = v_NO AND v_aper_tecnologia = v_NO THEN
				  	  -- apertura original
			            FOR cc IN lotes  LOOP
							   	  v_id_lote := cc.id_lote;
			                  INSERT INTO sc_ent_cab_lote (cod_evento,id_lote,per_contable,nom_usuario_lote,fec_lote, cod_operadora_scl)
			                          VALUES (
			                          cc.cod_evento,
			                          v_id_lote,
			                          cc.per_contable,
			                          cc.nom_usuario_lote,
			                          cc.fec_lote,
			                          cc.operadora);
			                END LOOP;
			            FOR cc1 IN detalle_lotes LOOP
					     	   v_concepto := SC_CONCEPTOGRP_FN(cc1.cod_evento,'AL_TIPOS_MOVIMIENTOS',cc1.cod_concepto);
							   IF v_concepto IS NULL THEN
						            v_concepto := 'E'||cc1.cod_concepto;
						   	   END IF;
							   	  v_id_lote := cc1.id_lote;
			                   INSERT INTO sc_ent_lote (cod_evento,id_lote,cod_concepto,imp_movimiento, cod_operadora_scl)
			                             VALUES (
			                             cc1.cod_evento,
			                             v_id_lote,
			                             v_concepto,
			                             cc1.imp_movimiento,
										 cc1.operadora);
			             END LOOP;
			                FOR cc IN lotes  LOOP
			                   szhDesError:=0;
							   	  v_id_lote := cc.id_lote;
			                          SC_P_INGRESA_LOTE(TO_CHAR(cc.cod_evento),v_id_lote,cc.operadora);
			                          SELECT COUNT(1)
			                          INTO   szhDesError
			                          FROM   sc_error_ingreso
			                          WHERE  cod_evento = cc.cod_evento
			                          AND    id_lote    = v_id_lote
									  AND	 cod_error  <> v_error_concepto;
			                          IF szhDesError=0  THEN
									  	    bRet := TRUE;
			                          ELSE
									  	    bRet := FALSE;
			                          END IF;
			              END LOOP;
		--
				  ELSE
		--
				  	  IF v_aper_oficina = v_SI AND v_aper_tecnologia = v_SI THEN
					   -- apertura por original, bodega y tecnologia
			                FOR cc IN lotes_ofic_Tecno  LOOP
							   	  v_id_lote := cc.id_lote||'/'||cc.cod_grpconcepto||'/'||cc.cod_tecnologia||'/';
			                  INSERT INTO sc_ent_cab_lote (cod_evento,id_lote,per_contable,nom_usuario_lote,fec_lote, cod_operadora_scl)
			                          VALUES (
			                          cc.cod_evento,
			                          v_id_lote,
			                          cc.per_contable,
			                          cc.nom_usuario_lote,
			                          cc.fec_lote,
			                          cc.operadora);
			                END LOOP;
			            	FOR cc1 IN detalle_lotes_ofic_tecno LOOP
					     	   v_concepto := SC_CONCEPTOGRP_FN(cc1.cod_evento,'AL_TIPOS_MOVIMIENTOS',cc1.cod_concepto,'AL_BODEGAS',cc1.cod_grpconcepto,'AL_TECNOLOGIA',cc1.cod_tecnologia);
							   IF v_concepto IS NULL THEN
						            v_concepto := 'E'||cc1.cod_concepto;
						   	   END IF;
							   	  v_id_lote := cc1.id_lote||'/'||cc1.cod_grpconcepto||'/'||cc1.cod_tecnologia||'/';
			                   INSERT INTO sc_ent_lote (cod_evento,id_lote,cod_concepto,imp_movimiento, cod_operadora_scl)
			                             VALUES (
			                             cc1.cod_evento,
			                             v_id_lote,
			                             v_concepto,
			                             cc1.imp_movimiento,
										 cc1.operadora);
			             	END LOOP;
			                FOR cc IN lotes_ofic_tecno  LOOP
			                   szhDesError:=0;
							   	  v_id_lote := cc.id_lote||'/'||cc.cod_grpconcepto||'/'||cc.cod_tecnologia||'/';
			                          SC_P_INGRESA_LOTE(TO_CHAR(cc.cod_evento),v_id_lote,cc.operadora);
			                          SELECT COUNT(1)
			                          INTO   szhDesError
			                          FROM   sc_error_ingreso
			                          WHERE  cod_evento = cc.cod_evento
			                          AND    id_lote    = v_id_lote
									  AND	 cod_error  <> v_error_concepto;
			                          IF szhDesError=0  THEN
									  	    bRet := TRUE;
			                          ELSE
									        bRet := FALSE;
			                          END IF;
			              END LOOP;

				      ELSE
					  	  IF v_aper_tecnologia = v_SI THEN
		  				  	 -- apertura por Tecnologia
								FOR cc IN lotes_tecno  LOOP
								   	  v_id_lote := cc.id_lote||'/'||cc.cod_tecnologia||'/';
				                  INSERT INTO sc_ent_cab_lote (cod_evento,id_lote,per_contable,nom_usuario_lote,fec_lote, cod_operadora_scl)
				                          VALUES (
				                          cc.cod_evento,
				                          v_id_lote,
				                          cc.per_contable,
				                          cc.nom_usuario_lote,
				                          cc.fec_lote,
				                          cc.operadora);
				                END LOOP;
				            	FOR cc1 IN detalle_lotes_tecno LOOP
						     	   v_concepto := SC_CONCEPTOGRP_FN(cc1.cod_evento,'AL_TIPOS_MOVIMIENTOS',cc1.cod_concepto,'AL_TECNOLOGIA',cc1.cod_tecnologia);
								   IF v_concepto IS NULL THEN
							            v_concepto := 'E'||cc1.cod_concepto;
							   	   END IF;
								   	  v_id_lote := cc1.id_lote||'/'||cc1.cod_tecnologia||'/';
				                   INSERT INTO sc_ent_lote (cod_evento,id_lote,cod_concepto,imp_movimiento, cod_operadora_scl)
				                             VALUES (
				                             cc1.cod_evento,
				                             v_id_lote,
				                             v_concepto,
				                             cc1.imp_movimiento,
											 cc1.operadora);
				             	END LOOP;
				                FOR cc IN lotes_tecno  LOOP
				                   szhDesError:=0;
								   	  v_id_lote := cc.id_lote||'/'||cc.cod_tecnologia||'/';
				                          SC_P_INGRESA_LOTE(TO_CHAR(cc.cod_evento),v_id_lote,cc.operadora);
				                          SELECT COUNT(1)
				                          INTO   szhDesError
				                          FROM   sc_error_ingreso
				                          WHERE  cod_evento = cc.cod_evento
				                          AND    id_lote    = v_id_lote
										  AND	 cod_error  <> v_error_concepto;
				                          IF szhDesError=0  THEN
										        bRet := TRUE;
										  ELSE
										        bRet := FALSE;
				                          END IF;
				                END LOOP;

						  ELSE
						  	 -- apertura por oficina
			                FOR cc IN lotes_ofic  LOOP
							   	  v_id_lote := cc.id_lote||'/'||cc.cod_grpconcepto||'/';
			                  INSERT INTO sc_ent_cab_lote (cod_evento,id_lote,per_contable,nom_usuario_lote,fec_lote, cod_operadora_scl)
			                          VALUES (
			                          cc.cod_evento,
			                          v_id_lote,
			                          cc.per_contable,
			                          cc.nom_usuario_lote,
			                          cc.fec_lote,
			                          cc.operadora);
			                END LOOP;
			            	FOR cc1 IN detalle_lotes_ofic LOOP
					     	   v_concepto := SC_CONCEPTOGRP_FN(cc1.cod_evento,'AL_TIPOS_MOVIMIENTOS',cc1.cod_concepto,'AL_BODEGAS',cc1.cod_grpconcepto);
							   IF v_concepto IS NULL THEN
						            v_concepto := 'E'||cc1.cod_concepto;
						   	   END IF;
							   	  v_id_lote := cc1.id_lote||'/'||cc1.cod_grpconcepto||'/';
			                   INSERT INTO sc_ent_lote (cod_evento,id_lote,cod_concepto,imp_movimiento, cod_operadora_scl)
			                             VALUES (
			                             cc1.cod_evento,
			                             v_id_lote,
			                             v_concepto,
			                             cc1.imp_movimiento,
										 cc1.operadora);
			             	END LOOP;
			                FOR cc IN lotes_ofic  LOOP
			                   szhDesError:=0;
							   	  v_id_lote := cc.id_lote||'/'||cc.cod_grpconcepto||'/';
			                          SC_P_INGRESA_LOTE(TO_CHAR(cc.cod_evento),v_id_lote,cc.operadora);
			                          SELECT COUNT(1)
			                          INTO   szhDesError
			                          FROM   sc_error_ingreso
			                          WHERE  cod_evento = cc.cod_evento
			                          AND    id_lote    = v_id_lote
									  AND	 cod_error  <> v_error_concepto;
			                          IF szhDesError=0  THEN
									  	    bRet := TRUE;
			                          ELSE
									        bRet := FALSE;
			                          END IF;
			              END LOOP;
						  END IF;
				      END IF;
				  END IF;
  	      END IF;    /*   TMM-04092  Diciembre  2004   */
	 BEGIN
      IF bRet  THEN
		  	    UPDATE AL_KARDEX
		        SET    fec_imputentsal = SYSDATE
		        WHERE  fec_movimiento BETWEEN fec_movimiento AND (fec_movimiento+1)-24/60/60
		        AND    ind_entsal ='E'
		        AND    fec_imputentsal IS NULL
				AND    cod_motivo IS NOT NULL;
		        v_error := 0;
		        --commit;
			END IF;
		   EXCEPTION WHEN OTHERS THEN
						  RAISE_APPLICATION_ERROR(SQLCODE,'Error updateando Kardex Ingreso Salida, nativo:'||SQLERRM);
	  END;
END P_INGRESO_ENTRADA;

PROCEDURE P_INGRESO_SALIDA(
v_error IN OUT AL_INTERCIERRE.cod_retorno%TYPE)IS

--
CURSOR Lotes_Ofic_Tecno IS
   SELECT  TRUNC(a.fec_movimiento),
   70 cod_evento,
   'S/'||TO_CHAR(a.fec_movimiento,'yyyymmdd') id_lote,
   TO_CHAR(a.fec_periodo,'yyyymm') per_contable,
   USER nom_usuario_lote,
   SYSDATE fec_lote,
   c.cod_operadora_scl operadora,
   a.cod_grpconcepto cod_grpconcepto,
   d.cod_tecnologia  cod_tecnologia
   FROM   AL_KARDEX a, al_tecnoarticulo_td d, al_bodeganodo b , ge_operadora_scl c
   WHERE  a.fec_imputentsal IS NULL
   AND    a.ind_entsal   ='S'
   AND    a.cod_motivo IS NOT NULL
   AND    d.ind_defecto  = 1
   AND 	  a.cod_articulo = d.cod_articulo
   AND    a.cod_bodega = b.cod_bodega
   AND    b.cod_bodeganodo = c.cod_bodeganodo
--   and    a.fec_movimiento  < trunc(sysdate)
   GROUP BY  TRUNC(a.fec_movimiento) ,TO_CHAR(a.fec_movimiento,'yyyymmdd'),
   TO_CHAR(a.fec_periodo,'yyyymm'),c.cod_operadora_scl, a.cod_grpconcepto, d.cod_tecnologia;
   --
CURSOR Lotes_Tecno IS
   SELECT  TRUNC(a.fec_movimiento),
   70 cod_evento,
   'S/'||TO_CHAR(a.fec_movimiento,'yyyymmdd') id_lote,
   TO_CHAR(a.fec_periodo,'yyyymm') per_contable,
   USER nom_usuario_lote,
   SYSDATE fec_lote,
   c.cod_operadora_scl operadora,
   d.cod_tecnologia  cod_tecnologia
   FROM   AL_KARDEX a, al_tecnoarticulo_td d, al_bodeganodo b , ge_operadora_scl c
   WHERE  a.fec_imputentsal IS NULL
   AND    a.ind_entsal ='S'
   AND    a.cod_motivo IS NOT NULL
   AND    d.ind_defecto  = 1
   AND 	  a.cod_articulo = d.cod_articulo
   AND    a.cod_bodega = b.cod_bodega
   AND    a.fec_movimiento  < TRUNC(SYSDATE)
   AND    b.cod_bodeganodo = c.cod_bodeganodo
   GROUP BY  TRUNC(a.fec_movimiento) ,TO_CHAR(a.fec_movimiento,'yyyymmdd'),
   TO_CHAR(a.fec_periodo,'yyyymm'),c.cod_operadora_scl, d.cod_tecnologia;

CURSOR Lotes_Ofic IS
   SELECT  TRUNC(a.fec_movimiento),
   70 cod_evento,
   'S/'||TO_CHAR(a.fec_movimiento,'yyyymmdd') id_lote,
   TO_CHAR(a.fec_periodo,'yyyymm') per_contable,
   USER nom_usuario_lote,
   SYSDATE fec_lote,
   c.cod_operadora_scl operadora,
   a.cod_grpconcepto cod_grpconcepto
   FROM   AL_KARDEX a, al_bodeganodo b , ge_operadora_scl c
   WHERE  a.fec_imputentsal IS NULL
   AND    a.ind_entsal ='S'
   AND    a.cod_motivo IS NOT NULL
   AND    a.cod_bodega = b.cod_bodega
   AND    a.fec_movimiento  < TRUNC(SYSDATE)
   AND    b.cod_bodeganodo = c.cod_bodeganodo
   GROUP BY  TRUNC(a.fec_movimiento) ,TO_CHAR(a.fec_movimiento,'yyyymmdd'),
   TO_CHAR(a.fec_periodo,'yyyymm'),c.cod_operadora_scl, a.cod_grpconcepto;

CURSOR Lotes IS
   SELECT  TRUNC(a.fec_movimiento),
   70 cod_evento,
   'S/'||TO_CHAR(a.fec_movimiento,'yyyymmdd') id_lote,
   TO_CHAR(a.fec_periodo,'yyyymm') per_contable,
   USER nom_usuario_lote,
   SYSDATE fec_lote,
   c.cod_operadora_scl operadora
   FROM   AL_KARDEX a, al_bodeganodo b , ge_operadora_scl c
   WHERE  a.fec_imputentsal IS NULL
   AND    a.ind_entsal ='S'
   AND    a.cod_motivo IS NOT NULL
   AND    a.cod_bodega = b.cod_bodega
   AND    a.fec_movimiento  < TRUNC(SYSDATE)
   AND    b.cod_bodeganodo = c.cod_bodeganodo
   GROUP BY  TRUNC(a.fec_movimiento) ,TO_CHAR(a.fec_movimiento,'yyyymmdd'),
   TO_CHAR(a.fec_periodo,'yyyymm'),c.cod_operadora_scl;
   --
CURSOR detalle_lotes_Ofic_Tecno IS
    SELECT /*+ index(b) */
		70 cod_evento,
        'S/'||TO_CHAR(a.fec_movimiento,'yyyymmdd') id_lote,
        LPAD(a.tip_movimiento,6,0) cod_concepto,
        NVL(SUM(a.cant_salida * a.prc_unitario),0) imp_movimiento,
        NULL des_transaccion,
		f.cod_operadora_scl	operadora,
		a.cod_grpconcepto cod_grpconcepto,
		g.cod_tecnologia cod_tecnologia
        FROM   ge_direcciones b, (SELECT /*+ index(a1,ak01_al_kardex) */ a1.*
                                 FROM  AL_KARDEX a1
                                 WHERE a1.cod_motivo IS NOT NULL
                                 AND   a1.ind_entsal = 'S'
				 AND   a1.num_movkardex > -1
		 		 AND   a1.fec_imputentsal IS NULL
				 /*AND   a1.fec_movimiento < TRUNC (SYSDATE)*/) a,
			   ge_ciudades c, al_tecnoarticulo_td g, al_bodegas d, al_bodeganodo e, ge_operadora_scl f
        WHERE  b.cod_direccion > -1
        AND    b.cod_direccion  =  d.cod_direccion
        AND    b.cod_region     =  c.cod_region
        AND    b.cod_provincia  =  c.cod_provincia
        AND    b.cod_ciudad     =  c.cod_ciudad
        AND    a.cod_bodega     =  d.cod_bodega
		AND    g.ind_defecto    =  1
		AND    a.cod_articulo   =  g.cod_articulo
		AND    d.cod_bodega     =  e.cod_bodega
		AND    e.cod_bodeganodo =  f.cod_bodeganodo
        GROUP BY  a.fec_movimiento,a.fec_periodo,a.tip_movimiento, f.cod_operadora_scl, a.cod_grpconcepto,g.cod_tecnologia;

   --
CURSOR detalle_lotes_tecno IS
    SELECT /*+ index(b) */
	    70 cod_evento,
        'S/'||TO_CHAR(a.fec_movimiento,'yyyymmdd') id_lote,
        LPAD(a.tip_movimiento,6,0) cod_concepto,
        NVL(SUM(a.cant_salida * a.prc_unitario),0) imp_movimiento,
        NULL des_transaccion,
		f.cod_operadora_scl	operadora,
		g.cod_tecnologia cod_tecnologia
        FROM   ge_direcciones b, (SELECT /*+ index(a1,ak01_al_kardex) */ a1.*
                                 FROM  AL_KARDEX a1
                                 WHERE a1.cod_motivo IS NOT NULL
                                 AND   a1.ind_entsal = 'S'
				 AND   a1.num_movkardex > -1
		 		 AND   a1.fec_imputentsal IS NULL
				 AND   a1.fec_movimiento < TRUNC (SYSDATE)) a,
			   ge_ciudades c, al_tecnoarticulo_td g, al_bodegas d, al_bodeganodo e, ge_operadora_scl f
        WHERE  b.cod_direccion > -1
        AND    b.cod_direccion  = d.cod_direccion
        AND    b.cod_region     = c.cod_region
        AND    b.cod_provincia  = c.cod_provincia
        AND    b.cod_ciudad     = c.cod_ciudad
		AND    g.ind_defecto    = 1
        AND    a.cod_articulo   = g.cod_articulo
        AND    d.cod_bodega     = e.cod_bodega
		AND    e.cod_bodeganodo = f.cod_bodeganodo
        GROUP BY  a.fec_movimiento,a.fec_periodo,a.tip_movimiento, f.cod_operadora_scl, g.cod_tecnologia;


CURSOR detalle_lotes_Ofic IS
    SELECT /*+ index(b) */
	70 cod_evento,
        'S/'||TO_CHAR(a.fec_movimiento,'yyyymmdd') id_lote,
        LPAD(a.tip_movimiento,6,0) cod_concepto,
        NVL(SUM(a.cant_salida * a.prc_unitario),0) imp_movimiento,
        NULL des_transaccion,
		f.cod_operadora_scl	operadora,
		a.cod_grpconcepto cod_grpconcepto
        FROM   ge_direcciones b, (SELECT /*+ index(a1,ak01_al_kardex) */ a1.*
                                 FROM  AL_KARDEX a1
                                 WHERE a1.cod_motivo IS NOT NULL
                                 AND   a1.ind_entsal = 'S'
				 AND   a1.num_movkardex > -1
		 		 AND   a1.fec_imputentsal IS NULL
				 AND   a1.fec_movimiento < TRUNC (SYSDATE)) a,
			    ge_ciudades c,al_bodegas d, al_bodeganodo e , ge_operadora_scl f
        WHERE  b.cod_direccion > -1
        AND b.cod_direccion = d.cod_direccion
        AND b.cod_region = c.cod_region
        AND b.cod_provincia = c.cod_provincia
        AND b.cod_ciudad = c.cod_ciudad
        AND a.cod_bodega = d.cod_bodega
	    AND d.cod_bodega = e.cod_bodega
	    AND e.cod_bodeganodo = f.cod_bodeganodo
        GROUP BY  a.fec_movimiento,a.fec_periodo,a.tip_movimiento, f.cod_operadora_scl, a.cod_grpconcepto;

CURSOR detalle_lotes IS
    SELECT /*+ index(b) */
	70 cod_evento,
        'S/'||TO_CHAR(a.fec_movimiento,'yyyymmdd') id_lote,
        LPAD(a.tip_movimiento,6,0) cod_concepto,
        NVL(SUM(a.cant_salida * a.prc_unitario),0) imp_movimiento,
        NULL des_transaccion,
        c.cod_plaza cod_plaza,
		f.cod_operadora_scl	operadora
        FROM   ge_direcciones b, (SELECT /*+ index(a1,ak01_al_kardex) */ a1.*
                                 FROM  AL_KARDEX a1
                                 WHERE a1.cod_motivo IS NOT NULL
                                 AND   a1.ind_entsal = 'S'
				 AND   a1.num_movkardex > -1
		 		 AND   a1.fec_imputentsal IS NULL
				 AND   a1.fec_movimiento < TRUNC (SYSDATE)) a,
			    ge_ciudades c, al_bodegas d, al_bodeganodo e, ge_operadora_scl f
        WHERE  b.cod_direccion > -1
        AND b.cod_direccion = d.cod_direccion
        AND b.cod_region    = c.cod_region
        AND b.cod_provincia = c.cod_provincia
        AND b.cod_ciudad = c.cod_ciudad
        AND a.cod_bodega = d.cod_bodega
        AND d.cod_bodega = e.cod_bodega
	AND e.cod_bodeganodo = f.cod_bodeganodo
        GROUP BY  a.fec_movimiento,a.fec_periodo,a.tip_movimiento,c.cod_plaza, f.cod_operadora_scl;

/*   InicioTMM-0492 Apertura por Articulo  Diciembre 2004 */

			CURSOR Lotes_Articulo_Tecnologia IS
		SELECT  TRUNC(a.fec_movimiento),
		70 cod_evento,
		'S/'||TO_CHAR(a.fec_movimiento,'yyyymmdd') id_lote,
		TO_CHAR(a.fec_periodo,'yyyymm') per_contable,
		USER nom_usuario_lote,
		SYSDATE fec_lote,
		c.cod_operadora_scl operadora,
		a.cod_grpconcepto_articulo cod_grpconcepto_articulo,
		d.cod_tecnologia cod_tecnologia
		FROM   AL_KARDEX a, al_tecnoarticulo_td d, al_bodeganodo b, ge_operadora_scl c
		WHERE  a.fec_imputentsal IS NULL
		AND    a.ind_entsal ='S'
		AND    a.cod_motivo IS NOT NULL
		AND    d.ind_defecto = 1
		AND    a.cod_articulo = d.cod_articulo
		AND    a.cod_bodega = b.cod_bodega
		AND    b.cod_bodeganodo = c.cod_bodeganodo
		GROUP BY  TRUNC(a.fec_movimiento) ,TO_CHAR(a.fec_movimiento,'yyyymmdd'),
		TO_CHAR(a.fec_periodo,'yyyymm'),c.cod_operadora_scl,a.cod_grpconcepto_articulo,d.cod_tecnologia;

           CURSOR DetLotes_Articulo_Tecnologia  IS
	      SELECT
		  70 cod_evento,
	      'S/'||TO_CHAR(a.fec_movimiento,'yyyymmdd') id_lote,
	      LPAD(a.cod_grpconcepto_articulo,6,0) cod_concepto,
	      NVL(SUM(a.cant_salida * a.prc_unitario),0) imp_movimiento,
	      NULL des_transaccion,
			f.cod_operadora_scl	operadora,
			a.cod_grpconcepto_articulo cod_grpconcepto_articulo,
			a.cod_grpconcepto cod_grpconcepto,
			g.cod_tecnologia cod_tecnologia
			 FROM   ge_direcciones b ,(SELECT a1.*
			                          FROM  AL_KARDEX a1
			                          WHERE a1.cod_motivo IS  NOT NULL
			                          AND   a1.ind_entsal = 'S'
			AND   a1.num_movkardex > -1
			AND   a1.fec_imputentsal IS NULL) a,
			 ge_ciudades c, al_tecnoarticulo_td g , al_bodegas d , al_bodeganodo e , ge_operadora_scl f
		      WHERE  b.cod_direccion > -1
		      AND    b.cod_direccion  =  d.cod_direccion
		      AND    b.cod_region     =  c.cod_region
		      AND    b.cod_provincia  =  c.cod_provincia
		      AND    b.cod_ciudad     =  c.cod_ciudad
			AND    g.ind_defecto    =  1
			AND    a.cod_articulo   =  g.cod_articulo
			AND    a.cod_bodega     =  d.cod_bodega
			AND    d.cod_bodega     =  e.cod_bodega
			AND    e.cod_bodeganodo =  f.cod_bodeganodo
			GROUP BY  a.fec_movimiento,a.cod_grpconcepto_articulo,f.cod_operadora_scl,
			a.cod_grpconcepto,g.cod_tecnologia;

/*   Fin TMM-0492 Apertura por Articulo  Diciembre 2004 */

   ihcodevento      sc_evento.cod_evento%TYPE;
   szhidlote        sc_ent_lote.id_lote%TYPE;
   szhDesError      sc_error_ingreso.cod_error%TYPE;
   error   VARCHAR2(100);
   BEGIN
   	       /*   TMM-04092   Diciembre 2004  */
      /*                     	   Se modifica la QUERY sc_indapertura_td agregando  la columna aper_articulo   */
	     SELECT aper_bodega, aper_tecnologia, aper_articulo
		  INTO v_aper_oficina, v_aper_tecnologia, v_aper_articulo
		  FROM SC_INDAPERTURA_TD
		  WHERE cod_modulo = 'AL';
          IF v_aper_articulo = v_SI THEN
		  /*   TMM-04092   Diciembre 2004   */
          /*     Logica de Apretura  por  Articulo  */
					FOR cc IN Lotes_Articulo_Tecnologia  LOOP
								v_id_lote := cc.id_lote||'/'||cc.cod_grpconcepto_articulo||'/'||cc.cod_tecnologia||'/';
								INSERT INTO sc_ent_cab_lote (cod_evento,id_lote,per_contable,nom_usuario_lote,fec_lote, cod_operadora_scl)
								VALUES ( cc.cod_evento, v_id_lote, cc.per_contable, cc.nom_usuario_lote, cc.fec_lote,cc.operadora);
					END LOOP;

					FOR cc1 IN DetLotes_Articulo_Tecnologia  LOOP
							   v_id_lote := cc1.id_lote||'/'||cc1.cod_grpconcepto_articulo||'/'||cc1.cod_tecnologia||'/';
							   v_concepto :=SC_CONCEPTOGRP_FN(cc1.cod_evento,'AL_ARTICULOS',cc1.cod_grpconcepto_articulo,'AL_BODEGAS',cc1.cod_grpconcepto,'AL_TECNOLOGIA',cc1.cod_tecnologia);

							   IF v_concepto IS NULL THEN
						            v_concepto := 'E'||cc1.cod_concepto;
						   	   END IF;
			                   INSERT INTO sc_ent_lote (cod_evento,id_lote,cod_concepto,imp_movimiento, cod_operadora_scl)
			                             VALUES (cc1.cod_evento, v_id_lote, v_concepto, cc1.imp_movimiento, cc1.operadora);
					END LOOP;

					FOR cc IN Lotes_Articulo_Tecnologia LOOP
							szhDesError:=0;
							v_id_lote := cc.id_lote||'/'||cc.cod_grpconcepto_articulo||'/'||cc.cod_tecnologia||'/';
							SC_P_INGRESA_LOTE(TO_CHAR(cc.cod_evento),v_id_lote,cc.operadora);
							SELECT COUNT(1)  INTO   szhDesError
							FROM   sc_error_ingreso
							WHERE  cod_evento = cc.cod_evento AND
								   			   id_lote    = v_id_lote AND
											   cod_error  <> v_error_concepto;
							IF szhDesError=0  THEN
							   				  bRet := TRUE;
							ELSE
											  bRet := FALSE;
							END IF;
					END LOOP;

		  ELSE
			  IF  v_aper_oficina = v_NO AND v_aper_tecnologia = v_NO THEN
			  	  -- apertura original
				   FOR cc IN lotes  LOOP
					   	  v_id_lote := cc.id_lote;
	                  INSERT INTO sc_ent_cab_lote (cod_evento,id_lote,per_contable,nom_usuario_lote,fec_lote, cod_operadora_scl)
	                          VALUES (
	                          cc.cod_evento,
	                          v_id_lote,
	                          cc.per_contable,
	                          cc.nom_usuario_lote,
	                          cc.fec_lote,
	                          cc.operadora);
	                END LOOP;
	                FOR cc1 IN detalle_lotes  LOOP
			   		   v_concepto := SC_CONCEPTOGRP_FN(cc1.cod_evento,'AL_TIPOS_MOVIMIENTOS',cc1.cod_concepto);
					   IF v_concepto IS NULL THEN
				            v_concepto := 'E'||cc1.cod_concepto;
				   	   END IF;
					   	  v_id_lote := cc1.id_lote;
	                   INSERT INTO sc_ent_lote (cod_evento,id_lote,cod_concepto,imp_movimiento, cod_operadora_scl)
	                          VALUES (
	                          cc1.cod_evento,
	                          v_id_lote,
	                          v_concepto,
	                          cc1.imp_movimiento,
							  cc1.operadora);
	                END LOOP;
	                FOR cc IN lotes  LOOP
	                   szhDesError:=0;
					   	  v_id_lote := cc.id_lote;
	                          SC_P_INGRESA_LOTE(TO_CHAR(cc.cod_evento),v_id_lote,cc.operadora);

	                          SELECT COUNT(1)
	                          INTO   szhDesError
	                          FROM   sc_error_ingreso
	                          WHERE  cod_evento = cc.cod_evento
	                          AND    id_lote    = v_id_lote
							  AND	 cod_error  <> v_error_concepto;
	                          IF szhDesError=0  THEN
							  	    bRet := TRUE;
	                          ELSE
							       bRet := FALSE ;
	                           END IF;
	              END LOOP;
			  ELSE
			  	  IF v_aper_oficina = v_SI AND v_aper_tecnologia = v_SI THEN
				   -- apertura por original, bodega y tecnologia
							FOR cc IN lotes_ofic_tecno  LOOP
								   v_id_lote := cc.id_lote||'/'||cc.cod_grpconcepto||'/'||cc.cod_tecnologia||'/';
				                   INSERT INTO sc_ent_cab_lote (cod_evento,id_lote,per_contable,nom_usuario_lote,fec_lote, cod_operadora_scl)
				                          VALUES (
				                          cc.cod_evento,
				                          v_id_lote,
				                          cc.per_contable,
				                          cc.nom_usuario_lote,
				                          cc.fec_lote,
				                          cc.operadora);
			                END LOOP;
			                FOR cc1 IN detalle_lotes_ofic_tecno  LOOP
						   		   v_concepto := SC_CONCEPTOGRP_FN(cc1.cod_evento,'AL_TIPOS_MOVIMIENTOS',cc1.cod_concepto,'AL_BODEGAS',cc1.cod_grpconcepto, 'AL_TECNOLOGIA', cc1.cod_tecnologia);
								   IF v_concepto IS NULL THEN
							            v_concepto := 'E'||cc1.cod_concepto;
							   	   END IF;
								   	  v_id_lote := cc1.id_lote||'/'||cc1.cod_grpconcepto||'/'||cc1.cod_tecnologia||'/';
				                   INSERT INTO sc_ent_lote (cod_evento,id_lote,cod_concepto,imp_movimiento, cod_operadora_scl)
				                          VALUES (
				                          cc1.cod_evento,
				                          v_id_lote,
				                          v_concepto,
				                          cc1.imp_movimiento,
										  cc1.operadora);
			                END LOOP;
			                FOR cc IN lotes_ofic_tecno  LOOP
			                      szhDesError:=0;
							   	  v_id_lote := cc.id_lote||'/'||cc.cod_grpconcepto||'/'||cc.cod_tecnologia||'/';
		                          SC_P_INGRESA_LOTE(TO_CHAR(cc.cod_evento),v_id_lote,cc.operadora);
		                          SELECT COUNT(1)
	                              INTO   szhDesError
		                          FROM   sc_error_ingreso
		                          WHERE  cod_evento = cc.cod_evento
		                          AND    id_lote    = v_id_lote
								  AND	 cod_error  <> v_error_concepto;
		                          IF szhDesError=0  THEN
		                               bRet := TRUE;
		                          ELSE
								       bRet := FALSE;
		                          END IF;
			              END LOOP;
			      ELSE
				  	  IF v_aper_tecnologia = v_SI THEN
	  				  	 -- apertura por Tecnologia
				                FOR cc IN lotes_Tecno  LOOP
								   	  v_id_lote := cc.id_lote||'/'||cc.cod_tecnologia||'/';
				                  INSERT INTO sc_ent_cab_lote (cod_evento,id_lote,per_contable,nom_usuario_lote,fec_lote, cod_operadora_scl)
				                          VALUES (
				                          cc.cod_evento,
				                          v_id_lote,
				                          cc.per_contable,
				                          cc.nom_usuario_lote,
				                          cc.fec_lote,
				                          cc.operadora);
				                END LOOP;
				                FOR cc1 IN detalle_lotes_Tecno  LOOP
						   		   v_concepto := SC_CONCEPTOGRP_FN(cc1.cod_evento,'AL_TIPOS_MOVIMIENTOS',cc1.cod_concepto,'AL_TECNOLOGIA',cc1.cod_tecnologia);
								   IF v_concepto IS NULL THEN
							            v_concepto := 'E'||cc1.cod_concepto;
							   	   END IF;
								   	  v_id_lote := cc1.id_lote||'/'||cc1.cod_tecnologia||'/';
				                   INSERT INTO sc_ent_lote (cod_evento,id_lote,cod_concepto,imp_movimiento, cod_operadora_scl)
				                          VALUES (
				                          cc1.cod_evento,
				                          v_id_lote,
				                          v_concepto,
				                          cc1.imp_movimiento,
										  cc1.operadora);
				                END LOOP;
				                FOR cc IN lotes_Tecno  LOOP
				                   szhDesError:=0;
								   	  v_id_lote := cc.id_lote||'/'||cc.cod_tecnologia||'/';
				                          SC_P_INGRESA_LOTE(TO_CHAR(cc.cod_evento),v_id_lote,cc.operadora);
				                          SELECT COUNT(1)
				                          INTO   szhDesError
				                          FROM   sc_error_ingreso
				                          WHERE  cod_evento = cc.cod_evento
				                          AND    id_lote    = v_id_lote
										  AND	 cod_error  <> v_error_concepto;
				                          IF szhDesError=0  THEN
										  	   bRet := TRUE;
				                          ELSE
										       bRet := FALSE;
				                          END IF;
				              END LOOP;
					  ELSE
					  	 -- apertura por oficina
							FOR cc IN lotes_ofic  LOOP
								   v_id_lote := cc.id_lote||'/'||cc.cod_grpconcepto||'/';
				     			                 INSERT INTO sc_ent_cab_lote (cod_evento,id_lote,per_contable,nom_usuario_lote,fec_lote, cod_operadora_scl)
				                          VALUES (
				                          cc.cod_evento,
				                          v_id_lote,
				                          cc.per_contable,
				                          cc.nom_usuario_lote,
				                          cc.fec_lote,
				                          cc.operadora);
			                END LOOP;
			                FOR cc1 IN detalle_lotes_ofic  LOOP
						   		   v_concepto := SC_CONCEPTOGRP_FN(cc1.cod_evento,'AL_TIPOS_MOVIMIENTOS',cc1.cod_concepto,'AL_BODEGAS',cc1.cod_grpconcepto);
								   IF v_concepto IS NULL THEN
							            v_concepto := 'E'||cc1.cod_concepto;
							   	   END IF;
								   	  v_id_lote := cc1.id_lote||'/'||cc1.cod_grpconcepto||'/';
				                   INSERT INTO sc_ent_lote (cod_evento,id_lote,cod_concepto,imp_movimiento, cod_operadora_scl)
				                          VALUES (
				                          cc1.cod_evento,
				                          v_id_lote,
				                          v_concepto,
				                          cc1.imp_movimiento,
										  cc1.operadora);
			                END LOOP;
			                FOR cc IN lotes_ofic  LOOP
			                      szhDesError:=0;
							   	  v_id_lote := cc.id_lote||'/'||cc.cod_grpconcepto||'/';
		                          SC_P_INGRESA_LOTE(TO_CHAR(cc.cod_evento),v_id_lote,cc.operadora);
		                          SELECT COUNT(1)
		                          INTO   szhDesError
		                          FROM   sc_error_ingreso
		                          WHERE  cod_evento = cc.cod_evento
		                          AND    id_lote    = v_id_lote
								  AND	 cod_error  <> v_error_concepto;
		                          IF szhDesError=0  THEN
		                               bRet := TRUE;
		                          ELSE
								      bRet := FALSE;
		                          END IF;
			              END LOOP;
					  END IF;
			      END IF;
			  END IF;
	  END IF; /*    TMM-04092   Diciembre 2004 */
	  BEGIN
 	      IF bRet  THEN
		  	    UPDATE AL_KARDEX
		        SET    fec_imputentsal = SYSDATE
		        WHERE  fec_movimiento BETWEEN fec_movimiento AND (fec_movimiento+1)-24/60/60
		        AND    ind_entsal ='S'
		        AND    fec_imputentsal IS NULL
				AND cod_motivo IS NOT NULL;
		        v_error := 0;
		        --commit;
			END IF;
		   EXCEPTION WHEN OTHERS THEN
						  RAISE_APPLICATION_ERROR(SQLCODE,'Error updateando Kardex Ingreso Salida, nativo:'||SQLERRM);
	  END;
END P_INGRESO_SALIDA;

PROCEDURE P_INGRESO_VENTA(
v_error IN OUT AL_INTERCIERRE.cod_retorno%TYPE) IS

CURSOR Lotes_Ofic_Tecno IS
        SELECT  TRUNC(a.fec_movimiento) fec_movimiento,
        71 cod_evento,
        'S/'||TO_CHAR(a.fec_movimiento,'yyyymmdd') id_lote,
        TO_CHAR(a.fec_periodo,'yyyymm') per_contable,
        USER nom_usuario_lote,
        SYSDATE fec_lote,
        e.cod_operadora_scl operadora,
		a.cod_grpconcepto   cod_grpconcepto,
		f.cod_tecnologia    cod_tecnologia
        FROM   AL_KARDEX a, al_movimientos b, ga_ventas c, al_tecnoarticulo_td  f, al_bodeganodo d, ge_operadora_scl e
        WHERE  a.num_movkardex > -1
        AND a.ind_entsal ='S'
        AND a.fec_imputentsal IS NULL
        AND a.cod_motivo IS NULL
	    AND a.cod_articulo = f.cod_articulo
		AND f.ind_defecto  = 1
        AND a.fec_movimiento < TRUNC(SYSDATE)
        AND a.num_movimiento = b.num_movimiento
        AND a.cod_bodega = d.cod_bodega
        AND b.num_transaccion = c.num_venta
        AND c.ind_venta = 'V'
        AND d.cod_bodeganodo = e.cod_bodeganodo
        GROUP BY  TRUNC(a.fec_movimiento) ,TO_CHAR(a.fec_movimiento,'yyyymmdd'),TO_CHAR(a.fec_periodo,'yyyymm'),
		e.cod_operadora_scl, a.cod_grpconcepto,f.cod_tecnologia;
--
CURSOR Lotes_Tecno IS
        SELECT  TRUNC(a.fec_movimiento) fec_movimiento,
        71 cod_evento,
        'S/'||TO_CHAR(a.fec_movimiento,'yyyymmdd') id_lote,
        TO_CHAR(a.fec_periodo,'yyyymm') per_contable,
        USER nom_usuario_lote,
        SYSDATE fec_lote,
        e.cod_operadora_scl operadora,
		f.cod_tecnologia cod_tecnologia
        FROM   AL_KARDEX a, al_movimientos b, ga_ventas c, al_tecnoarticulo_td f, al_bodeganodo d, ge_operadora_scl e
        WHERE  a.num_movkardex > -1
        AND a.ind_entsal ='S'
        AND a.fec_imputentsal IS NULL
        AND a.cod_motivo IS NULL
	    AND a.cod_articulo = f.cod_articulo
		AND f.ind_defecto = 1
        AND a.fec_movimiento < TRUNC(SYSDATE)
        AND a.num_movimiento = b.num_movimiento
        AND a.cod_bodega = d.cod_bodega
        AND b.num_transaccion = c.num_venta
        AND c.ind_venta = 'V'
        AND d.cod_bodeganodo = e.cod_bodeganodo
        GROUP BY  TRUNC(a.fec_movimiento) ,TO_CHAR(a.fec_movimiento,'yyyymmdd'),TO_CHAR(a.fec_periodo,'yyyymm'),
		e.cod_operadora_scl, f.cod_tecnologia;

CURSOR Lotes_Ofic IS
	    SELECT  TRUNC(a.fec_movimiento) fec_movimiento,
        71 cod_evento,
        'S/'||TO_CHAR(a.fec_movimiento,'yyyymmdd') id_lote,
        TO_CHAR(a.fec_periodo,'yyyymm') per_contable,
        USER nom_usuario_lote,
        SYSDATE fec_lote,
        e.cod_operadora_scl operadora,
		a.cod_grpconcepto cod_grpconcepto
        FROM   AL_KARDEX a, al_movimientos b, ga_ventas c, al_bodeganodo d, ge_operadora_scl e
        WHERE  a.num_movkardex > -1
        AND a.ind_entsal ='S'
        AND a.fec_imputentsal IS NULL
        AND a.cod_motivo IS NULL
        AND a.fec_movimiento < TRUNC(SYSDATE)
        AND a.num_movimiento = b.num_movimiento
        AND a.cod_bodega = d.cod_bodega
        AND b.num_transaccion = c.num_venta
        AND c.ind_venta = 'V'
        AND d.cod_bodeganodo = e.cod_bodeganodo
        GROUP BY  TRUNC(a.fec_movimiento) ,TO_CHAR(a.fec_movimiento,'yyyymmdd'),TO_CHAR(a.fec_periodo,'yyyymm'),e.cod_operadora_scl, a.cod_grpconcepto;

CURSOR Lotes IS
        SELECT  TRUNC(a.fec_movimiento) fec_movimiento,
        71 cod_evento,
        'S/'||TO_CHAR(a.fec_movimiento,'yyyymmdd') id_lote,
        TO_CHAR(a.fec_periodo,'yyyymm') per_contable,
        USER nom_usuario_lote,
        SYSDATE fec_lote,
        e.cod_operadora_scl operadora
        FROM   AL_KARDEX a, al_movimientos b, ga_ventas c, al_bodeganodo d, ge_operadora_scl e
        WHERE  a.num_movkardex > -1
        AND a.ind_entsal ='S'
        AND a.fec_imputentsal IS NULL
        AND a.cod_motivo IS NULL
        AND a.fec_movimiento < TRUNC(SYSDATE)
        AND a.num_movimiento = b.num_movimiento
        AND a.cod_bodega = d.cod_bodega
        AND b.num_transaccion = c.num_venta
        AND c.ind_venta = 'V'
        AND d.cod_bodeganodo = e.cod_bodeganodo
        GROUP BY  TRUNC(a.fec_movimiento) ,TO_CHAR(a.fec_movimiento,'yyyymmdd'),TO_CHAR(a.fec_periodo,'yyyymm'),e.cod_operadora_scl;
		--
CURSOR detalle_lotes_Ofic_Tecno IS
        SELECT /*+ index(b) */
		71 cod_evento,
        'S/'||TO_CHAR(a.fec_movimiento,'yyyymmdd') id_lote,
        LPAD(a.cod_uso,6,0) cod_concepto,
        NVL(SUM(a.cant_salida * a.prc_pmp),0) imp_movimiento,
        NULL des_transaccion,
		h.cod_operadora_scl	operadora,
		a.cod_grpconcepto cod_grpconcepto ,
		i.cod_tecnologia cod_tecnologia
        FROM al_movimientos b, ga_ventas c, (SELECT /*+ index(a1,ak01_al_kardex) */ a1.*
					  FROM   AL_KARDEX a1
					  WHERE  a1.cod_motivo IS NULL
					  AND    a1.ind_entsal ='S'
					  AND    a1.num_movkardex > -1
					  AND    a1.fec_imputentsal IS NULL
					  AND    a1.fec_movimiento  < TRUNC(SYSDATE)) a,
 	    ge_direcciones d, ge_ciudades f, al_tecnoarticulo_td i, al_bodegas e, al_bodeganodo g, ge_operadora_scl h
        WHERE  b.num_transaccion = c.num_venta
        AND c.ind_venta      = 'V'
	    AND a.cod_articulo   = i.cod_articulo
		AND i.ind_defecto    = 1
        AND a.num_movimiento = b.num_movimiento
        AND a.cod_bodega     = e.cod_bodega
        AND d.cod_direccion  > -1
        AND d.cod_region     =f.cod_region
        AND d.cod_provincia  =f.cod_provincia
        AND d.cod_ciudad     = f.cod_ciudad
        AND e.cod_direccion  = d.cod_direccion
        AND e.cod_bodega     = g.cod_bodega
		AND g.cod_bodeganodo = h.cod_bodeganodo
        GROUP BY a.fec_movimiento,a.fec_periodo,a.cod_uso, h.cod_operadora_scl, a.cod_grpconcepto,i.cod_tecnologia;
		--
CURSOR detalle_lotes_Tecno IS
        SELECT /*+ index(b) */
		71 cod_evento,
        'S/'||TO_CHAR(a.fec_movimiento,'yyyymmdd') id_lote,
        LPAD(a.cod_uso,6,0) cod_concepto,
        NVL(SUM(a.cant_salida * a.prc_pmp),0) imp_movimiento,
        NULL des_transaccion,
		h.cod_operadora_scl	operadora,
		i.cod_tecnologia cod_tecnologia
        FROM al_movimientos b, ga_ventas c , (SELECT /*+ index(a1,ak01_al_kardex) */ a1.*
					      FROM   AL_KARDEX a1
					      WHERE  a1.cod_motivo IS NULL
					      AND    a1.ind_entsal ='S'
					      AND    a1.num_movkardex > -1
					      AND    a1.fec_imputentsal IS NULL
					      AND    a1.fec_movimiento  < TRUNC(SYSDATE)) a,
 	       ge_direcciones d,  ge_ciudades f, al_tecnoarticulo_td i, al_bodegas e, al_bodeganodo g, ge_operadora_scl h
        WHERE  b.num_transaccion = c.num_venta
        AND c.ind_venta = 'V'
		AND a.cod_articulo = i.cod_articulo
		AND i.ind_defecto = 1
        AND a.num_movimiento = b.num_movimiento
        AND a.cod_bodega = e.cod_bodega
        AND d.cod_direccion > -1
        AND d.cod_region =f.cod_region
        AND d.cod_provincia =f.cod_provincia
        AND d.cod_ciudad = f.cod_ciudad
        AND e.cod_direccion = d.cod_direccion
		AND e.cod_bodega = g.cod_bodega
		AND g.cod_bodeganodo = h.cod_bodeganodo
        GROUP BY a.fec_movimiento,a.fec_periodo,a.cod_uso, h.cod_operadora_scl, i.cod_tecnologia;

CURSOR detalle_lotes_Ofic IS
        SELECT /*+ index(b) */
		71 cod_evento,
        'S/'||TO_CHAR(a.fec_movimiento,'yyyymmdd') id_lote,
        LPAD(a.cod_uso,6,0) cod_concepto,
        NVL(SUM(a.cant_salida * a.prc_pmp),0) imp_movimiento,
        NULL des_transaccion,
		h.cod_operadora_scl	operadora,
		a.cod_grpconcepto cod_grpconcepto
        FROM al_movimientos b, ga_ventas c,
			   		  (SELECT /*+ index(a1,ak01_al_kardex) */ a1.*
					  FROM   AL_KARDEX a1
					  WHERE  a1.cod_motivo IS NULL
					  AND    a1.ind_entsal ='S'
					  AND    a1.num_movkardex > -1
					  AND    a1.fec_imputentsal IS NULL
					  AND    a1.fec_movimiento  < TRUNC(SYSDATE)) a,
 	    ge_direcciones d, ge_ciudades f, al_bodegas e, al_bodeganodo g, ge_operadora_scl h
        WHERE  b.num_transaccion = c.num_venta
        AND    c.ind_venta = 'V'
        AND    a.num_movimiento = b.num_movimiento
        AND    a.cod_bodega = e.cod_bodega
        AND    d.cod_direccion > -1
        AND    d.cod_region =f.cod_region
        AND    d.cod_provincia =f.cod_provincia
        AND    d.cod_ciudad = f.cod_ciudad
        AND    e.cod_direccion = d.cod_direccion
		AND    e.cod_bodega = g.cod_bodega
		AND    g.cod_bodeganodo = h.cod_bodeganodo
        GROUP BY a.fec_movimiento,a.fec_periodo,a.cod_uso, h.cod_operadora_scl, a.cod_grpconcepto;

CURSOR detalle_lotes IS
        SELECT /*+ index(b) */
		71 cod_evento,
        'S/'||TO_CHAR(a.fec_movimiento,'yyyymmdd') id_lote,
        LPAD(a.cod_uso,6,0) cod_concepto,
        NVL(SUM(a.cant_salida * a.prc_pmp),0) imp_movimiento,
        NULL des_transaccion,
        f.cod_plaza cod_plaza,
		h.cod_operadora_scl	operadora
        FROM al_movimientos b, ga_ventas c,
			   		  (SELECT /*+ index(a1,ak01_al_kardex) */ a1.*
					  FROM   AL_KARDEX a1
					  WHERE  a1.cod_motivo IS NULL
					  AND    a1.ind_entsal ='S'
					  AND    a1.num_movkardex > -1
					  AND    a1.fec_imputentsal IS NULL
					  AND    a1.fec_movimiento  < TRUNC(SYSDATE)) a,
 	        ge_direcciones d, ge_ciudades f, al_bodegas e, al_bodeganodo g, ge_operadora_scl h
        WHERE  b.num_transaccion = c.num_venta
        AND    c.ind_venta = 'V'
        AND    a.num_movimiento = b.num_movimiento
        AND    a.cod_bodega = e.cod_bodega
        AND    d.cod_direccion > -1
        AND    d.cod_region =f.cod_region
        AND    d.cod_provincia =f.cod_provincia
        AND    d.cod_ciudad = f.cod_ciudad
        AND    e.cod_direccion = d.cod_direccion
	AND    e.cod_bodega = g.cod_bodega
	AND    g.cod_bodeganodo = h.cod_bodeganodo
        GROUP BY a.fec_movimiento,a.fec_periodo,a.cod_uso,f.cod_plaza, h.cod_operadora_scl;

   ihcodevento      sc_evento.cod_evento%TYPE;
   szhidlote        sc_ent_lote.id_lote%TYPE;
   szhDesError      sc_error_ingreso.cod_error%TYPE;
   BEGIN
   		  SELECT aper_bodega, aper_tecnologia
		  INTO v_aper_oficina, v_aper_tecnologia
		  FROM SC_INDAPERTURA_TD
		  WHERE cod_modulo = 'AL';


  		  IF  v_aper_oficina = v_NO AND v_aper_tecnologia = v_NO THEN
		  	  -- apertura original
				  FOR cc IN lotes  LOOP
					   	  v_id_lote := cc.id_lote;
	                   INSERT INTO sc_ent_cab_lote (cod_evento,id_lote,per_contable,nom_usuario_lote,fec_lote, cod_operadora_scl)
	                          VALUES (
	                          cc.cod_evento,
	                          v_id_lote,
	                          cc.per_contable,
	                          cc.nom_usuario_lote,
	                          cc.fec_lote,
	                          cc.operadora);
	                END LOOP;
	                FOR cc1 IN detalle_lotes  LOOP
	   		          v_concepto := SC_CONCEPTOGRP_FN(cc1.cod_evento,'AL_USOS',cc1.cod_concepto);
					  IF v_concepto IS NULL THEN
				            v_concepto := 'E'||cc1.cod_concepto;
				   	   END IF;
					   	  v_id_lote := cc1.id_lote;
	                  INSERT INTO sc_ent_lote (cod_evento,id_lote,cod_concepto,imp_movimiento, cod_operadora_scl)
	                          VALUES (
	                          cc1.cod_evento,
	                          v_id_lote,
	                          v_concepto,
	                          cc1.imp_movimiento,
							  cc1.operadora);
	                END LOOP;
	                FOR cc IN lotes  LOOP
	                   szhDesError:=0;
					   	  v_id_lote := cc.id_lote;
	                          sc_p_ingresa_lote(TO_CHAR(cc.cod_evento),v_id_lote,cc.operadora);
	                          SELECT COUNT(1)
	                          INTO   szhDesError
	                          FROM   sc_error_ingreso
	                          WHERE  cod_evento = cc.cod_evento
	                          AND    id_lote    = v_id_lote
							  AND	 cod_error  <> v_error_concepto;
	                          IF szhDesError=0  THEN
							  	    bRet :=TRUE;
	                          ELSE
							  	    bRet :=FALSE;
	                          END IF;
	              END LOOP;
		  ELSE
		  	  IF v_aper_oficina = v_SI AND v_aper_tecnologia = v_SI THEN
			   -- apertura por original, bodega y tecnologia
				 	FOR cc IN lotes_Ofic_tecno  LOOP
					   	  v_id_lote := cc.id_lote||'/'||cc.cod_grpconcepto||'/'||cc.cod_tecnologia||'/';
	                   INSERT INTO sc_ent_cab_lote (cod_evento,id_lote,per_contable,nom_usuario_lote,fec_lote, cod_operadora_scl)
	                          VALUES (
	                          cc.cod_evento,
	                          v_id_lote,
	                          cc.per_contable,
	                          cc.nom_usuario_lote,
	                          cc.fec_lote,
	                          cc.operadora);
	                END LOOP;
	                FOR cc1 IN detalle_lotes_Ofic_tecno  LOOP
	   		           v_concepto := SC_CONCEPTOGRP_FN(cc1.cod_evento,'AL_USOS',cc1.cod_concepto,'AL_BODEGAS',cc1.cod_grpconcepto,'AL_TECNOLOGIA',cc1.cod_tecnologia);
					   IF v_concepto IS NULL THEN
				            v_concepto := 'E'||cc1.cod_concepto;
				   	   END IF;
					   					   	  v_id_lote := cc1.id_lote||'/'||cc1.cod_grpconcepto||'/'||cc1.cod_tecnologia||'/';
	                  INSERT INTO sc_ent_lote (cod_evento,id_lote,cod_concepto,imp_movimiento, cod_operadora_scl)
	                          VALUES (
	                          cc1.cod_evento,
	                          v_id_lote,
	                          v_concepto,
	                          cc1.imp_movimiento,
							  cc1.operadora);
	                END LOOP;
	                FOR cc IN lotes_Ofic_tecno  LOOP
	                   szhDesError:=0;
					   	  v_id_lote := cc.id_lote||'/'||cc.cod_grpconcepto||'/'||cc.cod_tecnologia||'/';
	                          sc_p_ingresa_lote(TO_CHAR(cc.cod_evento),v_id_lote,cc.operadora);
	                          SELECT COUNT(1)
	                          INTO   szhDesError
	                          FROM   sc_error_ingreso
	                          WHERE  cod_evento = cc.cod_evento
	                          AND    id_lote    = v_id_lote
							  AND	 cod_error  <> v_error_concepto;
	                          IF szhDesError=0  THEN
							  	 bRet :=TRUE;
	                          ELSE
							  	 bRet :=FALSE;
	                          END IF;
	              END LOOP;

		      ELSE
			  	  IF v_aper_tecnologia = v_SI THEN
  				  	 -- apertura por Tecnologia
					 	FOR cc IN lotes_tecno  LOOP
						   	  v_id_lote := cc.id_lote||'/'||cc.cod_tecnologia||'/';
		                   INSERT INTO sc_ent_cab_lote (cod_evento,id_lote,per_contable,nom_usuario_lote,fec_lote, cod_operadora_scl)
		                          VALUES (
		                          cc.cod_evento,
		                          v_id_lote,
		                          cc.per_contable,
		                          cc.nom_usuario_lote,
		                          cc.fec_lote,
		                          cc.operadora);
		                END LOOP;
		                FOR cc1 IN detalle_lotes_tecno  LOOP
		   		           v_concepto := SC_CONCEPTOGRP_FN(cc1.cod_evento,'AL_USOS',cc1.cod_concepto,'AL_TECNOLOGIA',cc1.cod_tecnologia);
						   IF v_concepto IS NULL THEN
					            v_concepto := 'E'||cc1.cod_concepto;
					   	   END IF;
						   	  v_id_lote := cc1.id_lote||'/'||cc1.cod_tecnologia||'/';
		                  INSERT INTO sc_ent_lote (cod_evento,id_lote,cod_concepto,imp_movimiento, cod_operadora_scl)
		                          VALUES (
		                          cc1.cod_evento,
		                          v_id_lote,
		                          v_concepto,
		                          cc1.imp_movimiento,
								  cc1.operadora);
		                END LOOP;
		                FOR cc IN lotes_tecno  LOOP
		                   szhDesError:=0;
						   	  v_id_lote := cc.id_lote||'/'||cc.cod_tecnologia||'/';
		                          sc_p_ingresa_lote(TO_CHAR(cc.cod_evento),v_id_lote,cc.operadora);
		                          SELECT COUNT(1)
		                          INTO   szhDesError
		                          FROM   sc_error_ingreso
		                          WHERE  cod_evento = cc.cod_evento
		                          AND    id_lote    = v_id_lote
								  AND	 cod_error  <> v_error_concepto;
		                          IF szhDesError=0  THEN
								  	 bRet :=TRUE;
		                          ELSE
							  	    bRet :=FALSE;
		                          END IF;
		              END LOOP;
				  ELSE
				  	 -- apertura por oficina
							 FOR cc IN lotes_ofic  LOOP
						   	  v_id_lote := cc.id_lote||'/'||cc.cod_grpconcepto||'/';
		                    INSERT INTO sc_ent_cab_lote (cod_evento,id_lote,per_contable,nom_usuario_lote,fec_lote, cod_operadora_scl)
		                          VALUES (
		                          cc.cod_evento,
		                          v_id_lote,
		                          cc.per_contable,
		                          cc.nom_usuario_lote,
		                          cc.fec_lote,
		                          cc.operadora);
		                   END LOOP;
		                   FOR cc1 IN detalle_lotes_ofic  LOOP
		   		           v_concepto := SC_CONCEPTOGRP_FN(cc1.cod_evento,'AL_USOS',cc1.cod_concepto,'AL_BODEGAS',cc1.cod_grpconcepto);
						   IF v_concepto IS NULL THEN
					            v_concepto := 'E'||cc1.cod_concepto;
					   	   END IF;
						   	  v_id_lote := cc1.id_lote||'/'||cc1.cod_grpconcepto||'/';
		                   INSERT INTO sc_ent_lote (cod_evento,id_lote,cod_concepto,imp_movimiento, cod_operadora_scl)
		                          VALUES (
		                          cc1.cod_evento,
		                          v_id_lote,
		                          v_concepto,
		                          cc1.imp_movimiento,
								  cc1.operadora);
		                   END LOOP;
		                   FOR cc IN lotes_ofic  LOOP
		                   szhDesError:=0;
						   	  v_id_lote := cc.id_lote||'/'||cc.cod_grpconcepto||'/';
		                          sc_p_ingresa_lote(TO_CHAR(cc.cod_evento),v_id_lote,cc.operadora);
		                          SELECT COUNT(1)
		                          INTO   szhDesError
		                          FROM   sc_error_ingreso
		                          WHERE  cod_evento = cc.cod_evento
		                          AND    id_lote    = v_id_lote
								  AND	 cod_error  <> v_error_concepto;
		                          IF szhDesError=0  THEN
		                          	 	bRet :=TRUE;
		                          ELSE
							  	        bRet :=FALSE;
		                          END IF;
		                  END LOOP;
				  END IF;
		      END IF;
		  END IF;
		BEGIN
			IF bRet  THEN
			   		 UPDATE    AL_KARDEX
	                 SET fec_imputentsal = SYSDATE
	                 WHERE  fec_movimiento BETWEEN fec_movimiento AND (fec_movimiento+1)-24/60/60
	                 AND  num_movkardex IN
	                                        (SELECT a.num_movkardex
	                                        FROM   AL_KARDEX a, al_movimientos b, ga_ventas c
	                                        WHERE  a.fec_imputentsal IS NULL
	                                        AND    a.num_movimiento = b.num_movimiento
	                                        AND    b.num_transaccion = c.num_venta
	                                        AND    c.ind_venta = 'V'
	                                        AND    a.cod_motivo IS NULL
	                                        AND    a.ind_entsal ='S'
	                                        AND    a.fec_movimiento  < TRUNC(SYSDATE) );
	                                        v_error := 0;
	                  --commit;
			END IF;
			EXCEPTION WHEN OTHERS THEN
					  RAISE_APPLICATION_ERROR(SQLCODE,'Error updateando Kardex Ingreso Venta, nativo:'||SQLERRM);

		END;
END P_INGRESO_VENTA;
PROCEDURE P_INGRESO_RECAMBIO(
v_error IN OUT AL_INTERCIERRE.cod_retorno%TYPE)IS

CURSOR Lotes_Ofic_Tecno IS
        SELECT  TRUNC(a.fec_movimiento) fec_movimiento,
        72 cod_evento,
        'S/'||TO_CHAR(a.fec_movimiento,'yyyymmdd') id_lote,
        TO_CHAR(a.fec_periodo,'yyyymm') per_contable,
        USER nom_usuario_lote,
        SYSDATE fec_lote,
        e.cod_operadora_scl operadora,
		a.cod_grpconcepto cod_grpconcepto ,
		f.cod_tecnologia  cod_tecnologia
        FROM   AL_KARDEX a, al_movimientos b, ga_ventas c,al_tecnoarticulo_td f, al_bodeganodo d, ge_operadora_scl e
        WHERE  a.num_movkardex > -1
        AND a.fec_imputentsal IS NULL
        AND a.ind_entsal ='S'
        AND a.cod_motivo IS NULL
		AND a.cod_articulo = f.cod_articulo
		AND f.ind_defecto  = 1
        AND a.fec_movimiento  < TRUNC(SYSDATE)
        AND a.num_movimiento = b.num_movimiento
        AND a.cod_bodega = d.cod_bodega
        AND b.num_transaccion = c.num_venta
        AND c.ind_venta = 'E'
        AND d.cod_bodeganodo = e.cod_bodeganodo
        GROUP BY  TRUNC(a.fec_movimiento) ,TO_CHAR(a.fec_movimiento,'yyyymmdd'),TO_CHAR(a.fec_periodo,'yyyymm'),e.cod_operadora_scl, a.cod_grpconcepto,f.cod_tecnologia;
		--

CURSOR Lotes_Tecno IS
        SELECT  TRUNC(a.fec_movimiento) fec_movimiento,
        72 cod_evento,
        'S/'||TO_CHAR(a.fec_movimiento,'yyyymmdd') id_lote,
        TO_CHAR(a.fec_periodo,'yyyymm') per_contable,
        USER nom_usuario_lote,
        SYSDATE fec_lote,
        e.cod_operadora_scl operadora,
		f.cod_tecnologia  cod_tecnologia
        FROM   AL_KARDEX a, al_movimientos b, ga_ventas c, al_tecnoarticulo_td f, al_bodeganodo d, ge_operadora_scl e
        WHERE  a.num_movkardex > -1
        AND a.fec_imputentsal IS NULL
        AND a.ind_entsal ='S'
        AND a.cod_motivo IS NULL
		AND a.cod_articulo = f.cod_articulo
		AND f.ind_defecto  = 1
        AND a.fec_movimiento  < TRUNC(SYSDATE)
        AND a.num_movimiento = b.num_movimiento
        AND a.cod_bodega = d.cod_bodega
        AND b.num_transaccion = c.num_venta
        AND c.ind_venta = 'E'
        AND d.cod_bodeganodo = e.cod_bodeganodo
        GROUP BY  TRUNC(a.fec_movimiento) ,TO_CHAR(a.fec_movimiento,'yyyymmdd'),TO_CHAR(a.fec_periodo,'yyyymm'),e.cod_operadora_scl, f.cod_tecnologia;

CURSOR Lotes_Ofic IS
        SELECT  TRUNC(a.fec_movimiento) fec_movimiento,
        72 cod_evento,
        'S/'||TO_CHAR(a.fec_movimiento,'yyyymmdd') id_lote,
        TO_CHAR(a.fec_periodo,'yyyymm') per_contable,
        USER nom_usuario_lote,
        SYSDATE fec_lote,
        e.cod_operadora_scl operadora,
		a.cod_grpconcepto cod_grpconcepto
        FROM   AL_KARDEX a, al_movimientos b, ga_ventas c, al_bodeganodo d, ge_operadora_scl e
        WHERE a.num_movkardex > -1
        AND a.fec_imputentsal IS NULL
        AND a.ind_entsal ='S'
        AND a.cod_motivo IS NULL
        AND a.fec_movimiento < TRUNC(SYSDATE)
        AND a.num_movimiento = b.num_movimiento
        AND a.cod_bodega = d.cod_bodega
        AND b.num_transaccion = c.num_venta
        AND c.ind_venta = 'E'
        AND d.cod_bodeganodo = e.cod_bodeganodo
        GROUP BY  TRUNC(a.fec_movimiento) ,TO_CHAR(a.fec_movimiento,'yyyymmdd'),TO_CHAR(a.fec_periodo,'yyyymm'),e.cod_operadora_scl, a.cod_grpconcepto;

CURSOR Lotes IS
        SELECT  TRUNC(a.fec_movimiento) fec_movimiento,
        72 cod_evento,
        'S/'||TO_CHAR(a.fec_movimiento,'yyyymmdd') id_lote,
        TO_CHAR(a.fec_periodo,'yyyymm') per_contable,
        USER nom_usuario_lote,
        SYSDATE fec_lote,
        e.cod_operadora_scl operadora
        FROM   AL_KARDEX a, al_movimientos b, ga_ventas c, al_bodeganodo d, ge_operadora_scl e
        WHERE a.num_movkardex > -1
        AND a.fec_imputentsal IS NULL
        AND a.ind_entsal ='S'
        AND a.cod_motivo IS NULL
        AND a.fec_movimiento  < TRUNC(SYSDATE)
        AND a.num_movimiento = b.num_movimiento
        AND a.cod_bodega = d.cod_bodega
        AND b.num_transaccion = c.num_venta
        AND c.ind_venta = 'E'
        AND d.cod_bodeganodo = e.cod_bodeganodo
        GROUP BY  TRUNC(a.fec_movimiento) ,TO_CHAR(a.fec_movimiento,'yyyymmdd'),TO_CHAR(a.fec_periodo,'yyyymm'),e.cod_operadora_scl;
--
CURSOR detalle_lotes_Ofic_Tecno IS
        SELECT /*+ index(b) */
		72 cod_evento,
        'S/'||TO_CHAR(a.fec_movimiento,'yyyymmdd') id_lote,
        LPAD(a.cod_uso,6,0) cod_concepto,
        NVL(SUM(a.cant_salida * a.prc_pmp),0) imp_movimiento,
        NULL des_transaccion,
		h.cod_operadora_scl	operadora,
		a.cod_grpconcepto cod_grpconcepto ,
		i.cod_tecnologia cod_tecnologia
        FROM  al_movimientos b, ga_ventas c,
			   (SELECT /*+ index(a1,ak01_al_kardex) */ a1.*
			    FROM   AL_KARDEX a1
			    WHERE  a1.cod_motivo IS NULL
			    AND    a1.ind_entsal ='S'
			    AND    a1.num_movkardex > -1
			    AND    a1.fec_movimiento  < TRUNC(SYSDATE)
			    AND    a1.fec_imputentsal IS NULL) a,
			ge_direcciones d, ge_ciudades f, al_tecnoarticulo_td i, al_bodegas e, al_bodeganodo g, ge_operadora_scl h
        WHERE  b.num_transaccion = c.num_venta
        AND c.ind_venta = 'E'
		AND a.cod_articulo = i.cod_articulo
		AND i.ind_defecto  = 1
        AND a.num_movimiento = b.num_movimiento
        AND a.cod_bodega = e.cod_bodega
        AND d.cod_direccion > -1
        AND d.cod_region =f.cod_region
        AND d.cod_provincia =f.cod_provincia
        AND d.cod_ciudad = f.cod_ciudad
        AND e.cod_direccion = d.cod_direccion
		AND e.cod_bodega = g.cod_bodega
		AND g.cod_bodeganodo = h.cod_bodeganodo
        GROUP BY a.fec_movimiento,a.fec_periodo,a.cod_uso, h.cod_operadora_scl, a.cod_grpconcepto,i.cod_tecnologia;

--
CURSOR detalle_lotes_Tecno IS
        SELECT /*+ index(b) */
		72 cod_evento,
        'S/'||TO_CHAR(a.fec_movimiento,'yyyymmdd') id_lote,
        LPAD(a.cod_uso,6,0) cod_concepto,
        NVL(SUM(a.cant_salida * a.prc_pmp),0) imp_movimiento,
        NULL des_transaccion,
		h.cod_operadora_scl	operadora,
		i.cod_tecnologia cod_tecnologia
        FROM   al_movimientos b, ga_ventas c ,
			        (SELECT /*+ index(a1,ak01_al_kardex) */ a1.*
			        FROM   AL_KARDEX a1
				WHERE  a1.cod_motivo IS NULL
			        AND    a1.ind_entsal ='S'
			        AND    a1.num_movkardex > -1
			        AND    a1.fec_movimiento  < TRUNC(SYSDATE)
			        AND    a1.fec_imputentsal IS NULL) a,
			     ge_direcciones d, ge_ciudades f, al_Tecnoarticulo_td i, al_bodegas e, al_bodeganodo g, ge_operadora_scl h
        WHERE  b.num_transaccion = c.num_venta
        AND c.ind_venta = 'E'
		AND a.cod_articulo = i.cod_articulo
		AND i.ind_defecto  = 1
        AND a.num_movimiento = b.num_movimiento
        AND a.cod_bodega = e.cod_bodega
        AND d.cod_direccion > -1
        AND d.cod_region =f.cod_region
        AND d.cod_provincia =f.cod_provincia
        AND d.cod_ciudad = f.cod_ciudad
        AND e.cod_direccion = d.cod_direccion
		AND e.cod_bodega = g.cod_bodega
		AND g.cod_bodeganodo = h.cod_bodeganodo
        GROUP BY a.fec_movimiento,a.fec_periodo,a.cod_uso, h.cod_operadora_scl, i.cod_tecnologia;

CURSOR detalle_lotes_ofic IS
        SELECT /*+ index(b) */
		72 cod_evento,
        'S/'||TO_CHAR(a.fec_movimiento,'yyyymmdd') id_lote,
        LPAD(a.cod_uso,6,0) cod_concepto,
        NVL(SUM(a.cant_salida * a.prc_pmp),0) imp_movimiento,
        NULL des_transaccion,
		h.cod_operadora_scl	operadora,
		a.cod_grpconcepto cod_grpconcepto
        FROM   al_movimientos b, ga_ventas c,
			       (SELECT /*+ index(a1,ak01_al_kardex) */ a1.*
			        FROM   AL_KARDEX a1
				WHERE  a1.cod_motivo IS NULL
			        AND    a1.ind_entsal ='S'
			        AND    a1.num_movkardex > -1
			        AND    a1.fec_movimiento  < TRUNC(SYSDATE)
			        AND    a1.fec_imputentsal IS NULL) a,
			     ge_direcciones d, ge_ciudades f, al_bodegas e, al_bodeganodo g, ge_operadora_scl h
        WHERE  b.num_transaccion = c.num_venta
        AND c.ind_venta = 'E'
        AND a.num_movimiento = b.num_movimiento
        AND a.cod_bodega = e.cod_bodega
        AND d.cod_direccion > -1
        AND d.cod_region =f.cod_region
        AND d.cod_provincia =f.cod_provincia
        AND d.cod_ciudad = f.cod_ciudad
        AND e.cod_direccion = d.cod_direccion
	AND e.cod_bodega = g.cod_bodega
	AND g.cod_bodeganodo = h.cod_bodeganodo
        GROUP BY a.fec_movimiento,a.fec_periodo,a.cod_uso, h.cod_operadora_scl, a.cod_grpconcepto;

CURSOR detalle_lotes IS
        SELECT /*+ index(b) */
		72 cod_evento,
        'S/'||TO_CHAR(a.fec_movimiento,'yyyymmdd') id_lote,
        LPAD(a.cod_uso,6,0) cod_concepto,
        NVL(SUM(a.cant_salida * a.prc_pmp),0) imp_movimiento,
        NULL des_transaccion,
        f.cod_plaza cod_plaza,
		h.cod_operadora_scl	operadora
        FROM al_movimientos b, ga_ventas c,
			        (SELECT /*+ index(a1,ak01_al_kardex) */ a1.*
			        FROM   AL_KARDEX a1
				WHERE  a1.cod_motivo IS NULL
			        AND    a1.ind_entsal ='S'
			        AND    a1.num_movkardex > -1
			        AND    a1.fec_movimiento  < TRUNC(SYSDATE)
			        AND    a1.fec_imputentsal IS NULL) a,
			     ge_direcciones d, ge_ciudades f, al_bodegas e, al_bodeganodo g, ge_operadora_scl h
        WHERE  b.num_transaccion = c.num_venta
        AND c.ind_venta = 'E'
        AND a.num_movimiento = b.num_movimiento
        AND a.cod_bodega = e.cod_bodega
        AND d.cod_direccion > -1
        AND d.cod_region =f.cod_region
        AND d.cod_provincia =f.cod_provincia
        AND d.cod_ciudad = f.cod_ciudad
        AND e.cod_direccion = d.cod_direccion
	AND e.cod_bodega = g.cod_bodega
	AND g.cod_bodeganodo = h.cod_bodeganodo
        GROUP BY a.fec_movimiento,a.fec_periodo,a.cod_uso,f.cod_plaza, h.cod_operadora_scl;

   ihcodevento      sc_evento.cod_evento%TYPE;
   szhidlote        sc_ent_lote.id_lote%TYPE;
   szhDesError      sc_error_ingreso.cod_error%TYPE;
   BEGIN
   		  SELECT aper_bodega, aper_tecnologia
		  INTO v_aper_oficina, v_aper_tecnologia
		  FROM SC_INDAPERTURA_TD
		  WHERE cod_modulo = 'AL';

  		  IF  v_aper_oficina = v_NO AND v_aper_tecnologia = v_NO THEN
		  	  -- apertura original
			   FOR cc IN lotes  LOOP
				   	  v_id_lote := cc.id_lote;
                   INSERT INTO sc_ent_cab_lote (cod_evento,id_lote,per_contable,nom_usuario_lote,fec_lote, cod_operadora_scl)
                          VALUES (
                          cc.cod_evento,
                          v_id_lote,
                          cc.per_contable,
                          cc.nom_usuario_lote,
                          cc.fec_lote,
                          cc.operadora);
                END LOOP;

                FOR cc1 IN detalle_lotes  LOOP
		           v_concepto := SC_CONCEPTOGRP_FN(cc1.cod_evento,'AL_USOS',cc1.cod_concepto);
				   IF v_concepto IS NULL THEN
			            v_concepto := 'E'||cc1.cod_concepto;
			   	   END IF;
				   	  v_id_lote := cc1.id_lote;
                  INSERT INTO sc_ent_lote (cod_evento,id_lote,cod_concepto,imp_movimiento, cod_operadora_scl)
                          VALUES (
                          cc1.cod_evento,
                          v_id_lote,
                          v_concepto,
                          cc1.imp_movimiento,
						  cc1.operadora);
                END LOOP;
                FOR cc IN lotes  LOOP
                   szhDesError:=0;
				   	  v_id_lote := cc.id_lote;
                          sc_p_ingresa_lote(TO_CHAR(cc.cod_evento),v_id_lote,cc.operadora);
                          SELECT COUNT(1)
                          INTO   szhDesError
                          FROM   sc_error_ingreso
                          WHERE  cod_evento = cc.cod_evento
                          AND    id_lote    = v_id_lote
						  AND	 cod_error  <> v_error_concepto;
                          IF szhDesError=0  THEN
						  	 bRet :=TRUE;
                          ELSE
 					  	     bRet :=FALSE;
                          END IF;
              END LOOP;

		  ELSE
		  	  IF v_aper_oficina = v_SI AND v_aper_tecnologia = v_SI THEN
			   -- apertura por original, bodega y tecnologia
					   FOR cc IN lotes_ofic_tecno  LOOP
						   	  v_id_lote := cc.id_lote||'/'||cc.cod_grpconcepto||'/'||cc.cod_tecnologia||'/';
		                   INSERT INTO sc_ent_cab_lote (cod_evento,id_lote,per_contable,nom_usuario_lote,fec_lote, cod_operadora_scl)
		                          VALUES (
		                          cc.cod_evento,
		                          v_id_lote,
		                          cc.per_contable,
		                          cc.nom_usuario_lote,
		                          cc.fec_lote,
		                          cc.operadora);
		                END LOOP;

		                FOR cc1 IN detalle_lotes_ofic_tecno  LOOP
				           v_concepto := SC_CONCEPTOGRP_FN(cc1.cod_evento,'AL_USOS',cc1.cod_concepto,'AL_BODEGAS',cc1.cod_grpconcepto, 'AL_TECNOLOGIA', cc1.cod_tecnologia);
						   IF v_concepto IS NULL THEN
					            v_concepto := 'E'||cc1.cod_concepto;
					   	   END IF;
						   	  v_id_lote := cc1.id_lote||'/'||cc1.cod_grpconcepto||'/'||cc1.cod_tecnologia||'/';
		                  INSERT INTO sc_ent_lote (cod_evento,id_lote,cod_concepto,imp_movimiento, cod_operadora_scl)
		                          VALUES (
		                          cc1.cod_evento,
		                          v_id_lote,
		                          v_concepto,
		                          cc1.imp_movimiento,
								  cc1.operadora);
		                END LOOP;
		                FOR cc IN lotes_ofic_tecno  LOOP
		                   szhDesError:=0;
						   	  v_id_lote := cc.id_lote||'/'||cc.cod_grpconcepto||'/'||cc.cod_tecnologia||'/';
		                          sc_p_ingresa_lote(TO_CHAR(cc.cod_evento),v_id_lote,cc.operadora);
		                          SELECT COUNT(1)
		                          INTO   szhDesError
		                          FROM   sc_error_ingreso
		                          WHERE  cod_evento = cc.cod_evento
		                          AND    id_lote    = v_id_lote
								  AND	 cod_error  <> v_error_concepto;
		                          IF szhDesError=0  THEN
		                  		  	 	bRet :=TRUE;
		                          ELSE
							  	        bRet :=FALSE;
		                          END IF;
		              END LOOP;
		      ELSE
			  	  IF v_aper_tecnologia = v_SI THEN
  				  	 -- apertura por Tecnologia
						FOR cc IN lotes_Tecno  LOOP
						   	  v_id_lote := cc.id_lote||'/'||cc.cod_tecnologia||'/';
		                   INSERT INTO sc_ent_cab_lote (cod_evento,id_lote,per_contable,nom_usuario_lote,fec_lote, cod_operadora_scl)
		                          VALUES (
		                          cc.cod_evento,
		                          v_id_lote,
		                          cc.per_contable,
		                          cc.nom_usuario_lote,
		                          cc.fec_lote,
		                          cc.operadora);
		                END LOOP;

		                FOR cc1 IN detalle_lotes_tecno  LOOP
				           v_concepto := SC_CONCEPTOGRP_FN(cc1.cod_evento,'AL_USOS',cc1.cod_concepto,'AL_TECNOLOGIA',cc1.cod_tecnologia);
						   IF v_concepto IS NULL THEN
					            v_concepto := 'E'||cc1.cod_concepto;
					   	   END IF;
						   	  v_id_lote := cc1.id_lote||'/'||cc1.cod_tecnologia||'/';
		                  INSERT INTO sc_ent_lote (cod_evento,id_lote,cod_concepto,imp_movimiento, cod_operadora_scl)
		                          VALUES (
		                          cc1.cod_evento,
		                          v_id_lote,
		                          v_concepto,
		                          cc1.imp_movimiento,
								  cc1.operadora);
		                END LOOP;
		                FOR cc IN lotes_Tecno  LOOP
		                   szhDesError:=0;
						   	  v_id_lote := cc.id_lote||'/'||cc.cod_tecnologia||'/';
		                          sc_p_ingresa_lote(TO_CHAR(cc.cod_evento),v_id_lote,cc.operadora);
		                          SELECT COUNT(1)
		                          INTO   szhDesError
		                          FROM   sc_error_ingreso
		                          WHERE  cod_evento = cc.cod_evento
		                          AND    id_lote    = v_id_lote
								  AND	 cod_error  <> v_error_concepto;
		                          IF szhDesError=0  THEN
		                  		  	 	bRet :=TRUE;
		                          ELSE
							  	        bRet :=FALSE;
		                          END IF;
		              END LOOP;
				  ELSE
				  	 -- apertura por oficina
							   FOR cc IN lotes_ofic  LOOP
								   	  v_id_lote := cc.id_lote||'/'||cc.cod_grpconcepto||'/';
				                   INSERT INTO sc_ent_cab_lote (cod_evento,id_lote,per_contable,nom_usuario_lote,fec_lote, cod_operadora_scl)
				                          VALUES (
				                          cc.cod_evento,
				                          v_id_lote,
				                          cc.per_contable,
				                          cc.nom_usuario_lote,
				                          cc.fec_lote,
				                          cc.operadora);
				                END LOOP;

				                FOR cc1 IN detalle_lotes_ofic  LOOP
						           v_concepto := SC_CONCEPTOGRP_FN(cc1.cod_evento,'AL_USOS',cc1.cod_concepto,'AL_BODEGAS',cc1.cod_grpconcepto);
								   IF v_concepto IS NULL THEN
							            v_concepto := 'E'||cc1.cod_concepto;
							   	   END IF;
								   	  v_id_lote := cc1.id_lote||'/'||cc1.cod_grpconcepto||'/';
				                  INSERT INTO sc_ent_lote (cod_evento,id_lote,cod_concepto,imp_movimiento, cod_operadora_scl)
				                          VALUES (
				                          cc1.cod_evento,
				                          v_id_lote,
				                          v_concepto,
				                          cc1.imp_movimiento,
										  cc1.operadora);
				                END LOOP;
				                FOR cc IN lotes_ofic  LOOP
				                   szhDesError:=0;
								   	  v_id_lote := cc.id_lote||'/'||cc.cod_grpconcepto||'/';
				                          sc_p_ingresa_lote(TO_CHAR(cc.cod_evento),v_id_lote,cc.operadora);
				                          SELECT COUNT(1)
				                          INTO   szhDesError
				                          FROM   sc_error_ingreso
				                          WHERE  cod_evento = cc.cod_evento
				                          AND    id_lote    = v_id_lote
										  AND	 cod_error  <> v_error_concepto;
				                          IF szhDesError=0  THEN
				                  		  	 	bRet :=TRUE;
				                          ELSE
							  	                bRet :=FALSE;
				                          END IF;
				              END LOOP;
				  END IF;
		      END IF;
		  END IF;

		BEGIN
			IF bRet THEN
			   	  UPDATE    AL_KARDEX
	              SET fec_imputentsal = SYSDATE
	              WHERE fec_movimiento BETWEEN fec_movimiento AND (fec_movimiento+1)-24/60/60
	              AND   num_movkardex IN
	                            (SELECT a.num_movkardex
	                            FROM   AL_KARDEX a, al_movimientos b, ga_ventas c
	                            WHERE  a.fec_imputentsal IS NULL
	                            AND    a.num_movimiento = b.num_movimiento
	                            AND    b.num_transaccion = c.num_venta
	                            AND    c.ind_venta = 'E'
	                            AND    a.cod_motivo IS NULL
	                            AND    a.ind_entsal ='S'
	                            AND    a.fec_movimiento  < TRUNC(SYSDATE) );
	              v_error := 0;
	              --commit;
			END IF ;
			EXCEPTION WHEN OTHERS THEN
					  RAISE_APPLICATION_ERROR(SQLCODE,'Error updateando Kardex Ingreso Recambio, nativo:'||SQLERRM);
		END;

END P_INGRESO_RECAMBIO;

PROCEDURE P_INGRESO_COSTO_VENTA(
v_error IN OUT AL_INTERCIERRE.cod_retorno%TYPE)IS

CURSOR Lotes_Ofic_Tecno IS
        SELECT  TRUNC(a.fec_movimiento) fec_movimiento,
        73 cod_evento,
        'S/'||TO_CHAR(a.fec_movimiento,'yyyymmdd') id_lote,
        TO_CHAR(a.fec_periodo,'yyyymm') per_contable,
        USER nom_usuario_lote,
        SYSDATE fec_lote,
        e.cod_operadora_scl operadora,
		a.cod_grpconcepto cod_grpconcepto ,
		f.cod_tecnologia cod_tecnologia
        FROM   AL_KARDEX a, al_movimientos b, ga_ventas c, al_tecnoarticulo_td f, al_bodeganodo d, ge_operadora_scl e
        WHERE  a.num_movkardex > -1
        AND a.cod_motivo IS NULL
        AND a.ind_entsal ='S'
        AND a.fec_movimiento  < TRUNC(SYSDATE)
        AND a.fec_imputcostoventa IS NULL
		AND a.cod_articulo = f.cod_articulo
		AND f.ind_defecto = 1
        AND a.num_movimiento = b.num_movimiento
        AND a.cod_bodega = d.cod_bodega
        AND b.num_transaccion = c.num_venta
        AND c.ind_venta IN ('V','E')
        AND d.cod_bodeganodo = e.cod_bodeganodo
        GROUP BY  TRUNC(a.fec_movimiento) ,TO_CHAR(a.fec_movimiento,'yyyymmdd'),TO_CHAR(a.fec_periodo,'yyyymm'), e.cod_operadora_scl, a.cod_grpconcepto, f.cod_tecnologia;
--
CURSOR Lotes_Tecno IS
        SELECT  TRUNC(a.fec_movimiento) fec_movimiento,
        73 cod_evento,
        'S/'||TO_CHAR(a.fec_movimiento,'yyyymmdd') id_lote,
        TO_CHAR(a.fec_periodo,'yyyymm') per_contable,
        USER nom_usuario_lote,
        SYSDATE fec_lote,
        e.cod_operadora_scl operadora,
		f.cod_tecnologia cod_tecnologia
        FROM   AL_KARDEX a, al_movimientos b, ga_ventas c,al_tecnoarticulo_td f, al_bodeganodo d, ge_operadora_scl e
        WHERE  a.num_movkardex > -1
        AND a.cod_motivo IS NULL
        AND a.ind_entsal ='S'
        AND a.fec_movimiento  < TRUNC(SYSDATE)
        AND a.fec_imputcostoventa IS NULL
		AND a.cod_articulo = f.cod_articulo
		AND f.ind_defecto = 1
        AND a.num_movimiento = b.num_movimiento
        AND a.cod_bodega = d.cod_bodega
        AND b.num_transaccion = c.num_venta
        AND c.ind_venta IN ('V','E')
        AND d.cod_bodeganodo = e.cod_bodeganodo
        GROUP BY  TRUNC(a.fec_movimiento) ,TO_CHAR(a.fec_movimiento,'yyyymmdd'),TO_CHAR(a.fec_periodo,'yyyymm'), e.cod_operadora_scl, f.cod_tecnologia;

CURSOR Lotes_Ofic IS
        SELECT  TRUNC(a.fec_movimiento) fec_movimiento,
        73 cod_evento,
        'S/'||TO_CHAR(a.fec_movimiento,'yyyymmdd') id_lote,
        TO_CHAR(a.fec_periodo,'yyyymm') per_contable,
        USER nom_usuario_lote,
        SYSDATE fec_lote,
        e.cod_operadora_scl operadora,
		a.cod_grpconcepto cod_grpconcepto
        FROM AL_KARDEX a, al_movimientos b, ga_ventas c , al_bodeganodo d, ge_operadora_scl e
        WHERE  a.num_movkardex > -1
        AND a.cod_motivo IS NULL
        AND a.ind_entsal ='S'
        AND a.fec_movimiento < TRUNC(SYSDATE)
        AND a.fec_imputcostoventa IS NULL
        AND a.num_movimiento = b.num_movimiento
        AND a.cod_bodega = d.cod_bodega
        AND b.num_transaccion = c.num_venta
        AND c.ind_venta IN ('V','E')
        AND d.cod_bodeganodo = e.cod_bodeganodo
        GROUP BY  TRUNC(a.fec_movimiento) ,TO_CHAR(a.fec_movimiento,'yyyymmdd'),TO_CHAR(a.fec_periodo,'yyyymm'), e.cod_operadora_scl, a.cod_grpconcepto;

CURSOR Lotes IS
        SELECT  TRUNC(a.fec_movimiento) fec_movimiento,
        73 cod_evento,
        'S/'||TO_CHAR(a.fec_movimiento,'yyyymmdd') id_lote,
        TO_CHAR(a.fec_periodo,'yyyymm') per_contable,
        USER nom_usuario_lote,
        SYSDATE fec_lote,
        e.cod_operadora_scl operadora
        FROM AL_KARDEX a, al_movimientos b, ga_ventas c, al_bodeganodo d, ge_operadora_scl e
        WHERE  a.num_movkardex > -1
        AND a.cod_motivo IS NULL
        AND a.ind_entsal ='S'
        AND a.fec_movimiento < TRUNC(SYSDATE)
        AND a.fec_imputcostoventa IS NULL
        AND a.num_movimiento = b.num_movimiento
        AND a.cod_bodega = d.cod_bodega
        AND b.num_transaccion = c.num_venta
        AND c.ind_venta IN ('V','E')
        AND d.cod_bodeganodo = e.cod_bodeganodo
        GROUP BY  TRUNC(a.fec_movimiento) ,TO_CHAR(a.fec_movimiento,'yyyymmdd'),TO_CHAR(a.fec_periodo,'yyyymm'), e.cod_operadora_scl;
--
CURSOR detalle_lotes_Ofic_Tecno IS
        SELECT /*+ index(b) */
		73 cod_evento,
         'S/'||TO_CHAR(a.fec_movimiento,'yyyymmdd') id_lote,
        LPAD(a.cod_uso,6,0) cod_concepto,
        NVL(SUM(a.cant_salida * mto_costoventa),0) imp_movimiento,
        NULL des_transaccion,
		h.cod_operadora_scl	operadora,
		a.cod_grpconcepto cod_grpconcepto ,
		i.cod_tecnologia cod_tecnologia
        FROM al_movimientos b, ga_ventas c,
			        (SELECT /*+ index(a1,ak01_al_kardex) */ a1.*
			        FROM   AL_KARDEX a1
				WHERE  a1.cod_motivo IS NULL
			        AND    a1.ind_entsal ='S'
			        AND    a1.num_movkardex > -1
			        AND    a1.fec_imputcostoventa IS NULL
			        AND    a1.fec_movimiento  < TRUNC(SYSDATE)) a,
	       ge_direcciones d, ge_ciudades f, al_tecnoarticulo_td i, al_bodegas e, al_bodeganodo g, ge_operadora_scl h
        WHERE  b.num_transaccion = c.num_venta
        AND c.ind_venta IN ('V','E')
		AND a.cod_articulo = i.cod_articulo
		AND i.ind_defecto = 1
        AND a.num_movimiento = b.num_movimiento
        AND a.cod_bodega = e.cod_bodega
        AND d.cod_direccion > -1
        AND d.cod_region =f.cod_region
        AND d.cod_provincia =f.cod_provincia
        AND d.cod_ciudad = f.cod_ciudad
        AND e.cod_direccion = d.cod_direccion
		AND e.cod_bodega = g.cod_bodega
		AND g.cod_bodeganodo = h.cod_bodeganodo
        GROUP BY a.fec_movimiento,a.fec_periodo,a.cod_uso, h.cod_operadora_scl, a.cod_grpconcepto, i.cod_tecnologia;
--
CURSOR detalle_lotes_Tecno IS
        SELECT /*+ index(b) */
		73 cod_evento,
         'S/'||TO_CHAR(a.fec_movimiento,'yyyymmdd') id_lote,
        LPAD(a.cod_uso,6,0) cod_concepto,
        NVL(SUM(a.cant_salida * mto_costoventa),0) imp_movimiento,
        NULL des_transaccion,
		h.cod_operadora_scl	operadora,
		i.cod_tecnologia cod_tecnologia
        FROM al_movimientos b, ga_ventas c,
			   (SELECT /*+ index(a1,ak01_al_kardex) */ a1.*
			    FROM   AL_KARDEX a1
				WHERE  a1.cod_motivo IS NULL
		        AND    a1.ind_entsal ='S'
		        AND    a1.num_movkardex > -1
		        AND    a1.fec_imputcostoventa IS NULL
		        AND    a1.fec_movimiento  < TRUNC(SYSDATE)) a,
	       ge_direcciones d, ge_ciudades f, al_tecnoarticulo_td i, al_bodegas e, al_bodeganodo g, ge_operadora_scl h
        WHERE  b.num_transaccion = c.num_venta
        AND    c.ind_venta IN ('V','E')
		AND    a.cod_articulo = i.cod_articulo
		AND    i.ind_defecto = 1
        AND    a.num_movimiento = b.num_movimiento
        AND    a.cod_bodega = e.cod_bodega
        AND    d.cod_direccion > -1
        AND    d.cod_region =f.cod_region
        AND    d.cod_provincia =f.cod_provincia
        AND    d.cod_ciudad = f.cod_ciudad
        AND    e.cod_direccion = d.cod_direccion
	    AND    e.cod_bodega = g.cod_bodega
		AND    g.cod_bodeganodo = h.cod_bodeganodo
        GROUP BY a.fec_movimiento,a.fec_periodo,a.cod_uso, h.cod_operadora_scl, i.cod_tecnologia;


CURSOR detalle_lotes_ofic IS
        SELECT /*+ index(b) */
		73 cod_evento,
         'S/'||TO_CHAR(a.fec_movimiento,'yyyymmdd') id_lote,
        LPAD(a.cod_uso,6,0) cod_concepto,
        NVL(SUM(a.cant_salida * mto_costoventa),0) imp_movimiento,
        NULL des_transaccion,
		h.cod_operadora_scl	operadora,
		a.cod_grpconcepto cod_grpconcepto
        FROM al_movimientos b, ga_ventas c,
			        (SELECT /*+ index(a1,ak01_al_kardex) */ a1.*
			        FROM   AL_KARDEX a1
				WHERE  a1.cod_motivo IS NULL
			        AND    a1.ind_entsal ='S'
			        AND    a1.num_movkardex > -1
			        AND    a1.fec_imputcostoventa IS NULL
			        AND    a1.fec_movimiento  < TRUNC(SYSDATE)) a,
	       ge_direcciones d, al_bodegas e, ge_ciudades f, al_bodeganodo g, ge_operadora_scl h
        WHERE  b.num_transaccion = c.num_venta
        AND    c.ind_venta IN ('V','E')
        AND    a.num_movimiento = b.num_movimiento
        AND    a.cod_bodega = e.cod_bodega
        AND    d.cod_direccion > -1
        AND    d.cod_region =f.cod_region
        AND    d.cod_provincia =f.cod_provincia
        AND    d.cod_ciudad = f.cod_ciudad
        AND    e.cod_direccion = d.cod_direccion
	AND    e.cod_bodega = g.cod_bodega
	AND    g.cod_bodeganodo = h.cod_bodeganodo
        GROUP BY a.fec_movimiento,a.fec_periodo,a.cod_uso, h.cod_operadora_scl, a.cod_grpconcepto;

CURSOR detalle_lotes IS
        SELECT /*+ index(b) */
		73 cod_evento,
         'S/'||TO_CHAR(a.fec_movimiento,'yyyymmdd') id_lote,
        LPAD(a.cod_uso,6,0) cod_concepto,
        NVL(SUM(a.cant_salida * mto_costoventa),0) imp_movimiento,
        NULL des_transaccion,
        f.cod_plaza cod_plaza,
		h.cod_operadora_scl	operadora
        FROM al_movimientos b, ga_ventas c,
			        (SELECT /*+ index(a1,ak01_al_kardex) */ a1.*
			        FROM   AL_KARDEX a1
				WHERE  a1.cod_motivo IS NULL
			        AND    a1.ind_entsal ='S'
			        AND    a1.num_movkardex > -1
			        AND    a1.fec_imputcostoventa IS NULL
			        AND    a1.fec_movimiento  < TRUNC(SYSDATE)) a,
	       ge_direcciones d, ge_ciudades f, al_bodegas e, al_bodeganodo g, ge_operadora_scl h
        WHERE  b.num_transaccion = c.num_venta
        AND c.ind_venta IN ('V','E')
        AND a.num_movimiento = b.num_movimiento
        AND a.cod_bodega = e.cod_bodega
        AND d.cod_direccion > -1
        AND d.cod_region =f.cod_region
        AND d.cod_provincia =f.cod_provincia
        AND d.cod_ciudad = f.cod_ciudad
        AND e.cod_direccion = d.cod_direccion
	AND e.cod_bodega = g.cod_bodega
	AND g.cod_bodeganodo = h.cod_bodeganodo
        GROUP BY a.fec_movimiento,a.fec_periodo,a.cod_uso,f.cod_plaza, h.cod_operadora_scl;

   ihcodevento      sc_evento.cod_evento%TYPE;
   szhidlote        sc_ent_lote.id_lote%TYPE;
   szhDesError      sc_error_ingreso.cod_error%TYPE;
   BEGIN
   		  SELECT aper_bodega, aper_tecnologia
		  INTO v_aper_oficina, v_aper_tecnologia
		  FROM SC_INDAPERTURA_TD
		  WHERE cod_modulo = 'AL';
  		  IF  v_aper_oficina = v_NO AND v_aper_tecnologia = v_NO THEN
		  	  -- apertura original
					  FOR cc IN lotes  LOOP
						   	  v_id_lote := cc.id_lote;
		                   INSERT INTO sc_ent_cab_lote (cod_evento,id_lote,per_contable,nom_usuario_lote,fec_lote, cod_operadora_scl)
		                          VALUES (
		                          cc.cod_evento,
		                          v_id_lote,
		                          cc.per_contable,
		                          cc.nom_usuario_lote,
		                          cc.fec_lote,
		                          cc.operadora);
		                END LOOP;
		                FOR cc1 IN detalle_lotes  LOOP
		  		           v_concepto := SC_CONCEPTOGRP_FN(cc1.cod_evento,'AL_USOS',cc1.cod_concepto);
						   IF v_concepto IS NULL THEN
					            v_concepto := 'E'||cc1.cod_concepto;
					   	   END IF;
						   	  v_id_lote := cc1.id_lote;
		                  INSERT INTO sc_ent_lote (cod_evento,id_lote,cod_concepto,imp_movimiento, cod_operadora_scl)
		                          VALUES (
		                          cc1.cod_evento,
		                          v_id_lote,
		                          v_concepto,
		                          cc1.imp_movimiento,
								  cc1.operadora);
		                END LOOP;
		                FOR cc IN lotes  LOOP
		                   szhDesError:=0;
						   	  v_id_lote := cc.id_lote;
		                          sc_p_ingresa_lote(TO_CHAR(cc.cod_evento),v_id_lote,cc.operadora);
		                          SELECT COUNT(1)
		                          INTO   szhDesError
		                          FROM   sc_error_ingreso
		                          WHERE  cod_evento = cc.cod_evento
		                          AND    id_lote    = v_id_lote
								  AND	 cod_error  <> v_error_concepto;
		                          IF szhDesError=0  THEN
								  	    bRet :=TRUE;
		                          ELSE
							  	        bRet :=FALSE;
		                          END IF;
		              END LOOP;
		  ELSE
		  	  IF v_aper_oficina = v_SI AND v_aper_tecnologia = v_SI THEN
			   -- apertura por original, bodega y tecnologia
				   FOR cc IN lotes_ofic_tecno  LOOP
							   	  v_id_lote := cc.id_lote||'/'||cc.cod_grpconcepto||'/'||cc.cod_tecnologia||'/';
			                   INSERT INTO sc_ent_cab_lote (cod_evento,id_lote,per_contable,nom_usuario_lote,fec_lote, cod_operadora_scl)
			                          VALUES (
			                          cc.cod_evento,
			                          v_id_lote,
			                          cc.per_contable,
			                          cc.nom_usuario_lote,
			                          cc.fec_lote,
			                          cc.operadora);
			                END LOOP;
			                FOR cc1 IN detalle_lotes_ofic_tecno  LOOP
			  		           v_concepto := SC_CONCEPTOGRP_FN(cc1.cod_evento,'AL_USOS',cc1.cod_concepto,'AL_BODEGAS',cc1.cod_grpconcepto,'AL_TECNOLOGIA',cc1.cod_tecnologia);
							   IF v_concepto IS NULL THEN
						            v_concepto := 'E'||cc1.cod_concepto;
						   	   END IF;
							   	  v_id_lote := cc1.id_lote||'/'||cc1.cod_grpconcepto||'/'||cc1.cod_tecnologia||'/';
			                  INSERT INTO sc_ent_lote (cod_evento,id_lote,cod_concepto,imp_movimiento, cod_operadora_scl)
			                          VALUES (
			                          cc1.cod_evento,
			                          v_id_lote,
			                          v_concepto,
			                          cc1.imp_movimiento,
									  cc1.operadora);
			                END LOOP;
			                FOR cc IN lotes_ofic_tecno LOOP
			                   szhDesError:=0;
							   	  v_id_lote := cc.id_lote||'/'||cc.cod_grpconcepto||'/'||cc.cod_tecnologia||'/';
			                          sc_p_ingresa_lote(TO_CHAR(cc.cod_evento),v_id_lote,cc.operadora);
			                          SELECT COUNT(1)
			                          INTO   szhDesError
			                          FROM   sc_error_ingreso
			                          WHERE  cod_evento = cc.cod_evento
			                          AND    id_lote    = v_id_lote
									  AND	 cod_error  <> v_error_concepto;
			                          IF szhDesError=0  THEN
			                          	    bRet :=TRUE;
			                          ELSE
							  	             bRet :=FALSE;
			                          END IF;
			              END LOOP;
		      ELSE
			  	  IF v_aper_tecnologia = v_SI THEN
  				  	 -- apertura por Tecnologia
							 FOR cc IN lotes_tecno  LOOP
							   	  v_id_lote := cc.id_lote||'/'||cc.cod_tecnologia||'/';
			                   INSERT INTO sc_ent_cab_lote (cod_evento,id_lote,per_contable,nom_usuario_lote,fec_lote, cod_operadora_scl)
			                          VALUES (
			                          cc.cod_evento,
			                          v_id_lote,
			                          cc.per_contable,
			                          cc.nom_usuario_lote,
			                          cc.fec_lote,
			                          cc.operadora);
			                END LOOP;
			                FOR cc1 IN detalle_lotes_tecno  LOOP
			  		           v_concepto := SC_CONCEPTOGRP_FN(cc1.cod_evento,'AL_USOS',cc1.cod_concepto,'AL_TECNOLOGIA',cc1.cod_tecnologia);
							   IF v_concepto IS NULL THEN
						            v_concepto := 'E'||cc1.cod_concepto;
						   	   END IF;
							   	  v_id_lote := cc1.id_lote||'/'||cc1.cod_tecnologia||'/';
			                  INSERT INTO sc_ent_lote (cod_evento,id_lote,cod_concepto,imp_movimiento, cod_operadora_scl)
			                          VALUES (
			                          cc1.cod_evento,
			                          v_id_lote,
			                          v_concepto,
			                          cc1.imp_movimiento,
									  cc1.operadora);
			                END LOOP;
			                FOR cc IN lotes_tecno  LOOP
			                   szhDesError:=0;
							   	  v_id_lote := cc.id_lote||'/'||cc.cod_tecnologia||'/';
			                          sc_p_ingresa_lote(TO_CHAR(cc.cod_evento),v_id_lote,cc.operadora);
			                          SELECT COUNT(1)
			                          INTO   szhDesError
			                          FROM   sc_error_ingreso
			                          WHERE  cod_evento = cc.cod_evento
			                          AND    id_lote    = v_id_lote
									  AND	 cod_error  <> v_error_concepto;
			                          IF szhDesError=0  THEN
			                          	    bRet :=TRUE;
			                          ELSE
							  	       	  bRet :=FALSE;
			                          END IF;
			              END LOOP;
				  ELSE
				  	 -- apertura por oficina
							FOR cc IN lotes_ofic  LOOP
							   	  v_id_lote := cc.id_lote||'/'||cc.cod_grpconcepto||'/';
			                   INSERT INTO sc_ent_cab_lote (cod_evento,id_lote,per_contable,nom_usuario_lote,fec_lote, cod_operadora_scl)
			                          VALUES (
			                          cc.cod_evento,
			                          v_id_lote,
			                          cc.per_contable,
			                          cc.nom_usuario_lote,
			                          cc.fec_lote,
			                          cc.operadora);
			                END LOOP;
			                FOR cc1 IN detalle_lotes_ofic  LOOP
			  		           v_concepto := SC_CONCEPTOGRP_FN(cc1.cod_evento,'AL_USOS',cc1.cod_concepto,'AL_BODEGAS',cc1.cod_grpconcepto);
							   IF v_concepto IS NULL THEN
						            v_concepto := 'E'||cc1.cod_concepto;
						   	   END IF;
							   	  v_id_lote := cc1.id_lote||'/'||cc1.cod_grpconcepto||'/';
			                  INSERT INTO sc_ent_lote (cod_evento,id_lote,cod_concepto,imp_movimiento, cod_operadora_scl)
			                          VALUES (
			                          cc1.cod_evento,
			                          v_id_lote,
			                          v_concepto,
			                          cc1.imp_movimiento,
									  cc1.operadora);
			                END LOOP;
			                FOR cc IN lotes_ofic  LOOP
			                   szhDesError:=0;
							   	  v_id_lote := cc.id_lote||'/'||cc.cod_grpconcepto||'/';
			                          sc_p_ingresa_lote(TO_CHAR(cc.cod_evento),v_id_lote,cc.operadora);
			                          SELECT COUNT(1)
			                          INTO   szhDesError
			                          FROM   sc_error_ingreso
			                          WHERE  cod_evento = cc.cod_evento
			                          AND    id_lote    = v_id_lote
									  AND	 cod_error  <> v_error_concepto;
			                          IF szhDesError=0  THEN
			                          	    bRet :=TRUE;
			                          ELSE
							  	      	  bRet :=FALSE;
			                          END IF;
			              END LOOP;

				  END IF;
		      END IF;
		  END IF;

		BEGIN
			IF bRet THEN
        	 	UPDATE    AL_KARDEX
		        SET fec_imputcostoventa = SYSDATE
		        WHERE fec_movimiento BETWEEN fec_movimiento AND (fec_movimiento+1)-24/60/60
		        AND   num_movkardex IN
		                     (SELECT a.num_movkardex
		                      FROM   AL_KARDEX a, al_movimientos b, ga_ventas c
		                      WHERE  a.fec_imputcostoventa IS NULL
		                      AND    a.num_movimiento = b.num_movimiento
		                      AND    b.num_transaccion = c.num_venta
		                      AND    c.ind_venta IN ('V','E')
		                      AND    a.cod_motivo IS NULL
		                      AND    a.ind_entsal ='S'
		                      AND    a.fec_movimiento  < TRUNC(SYSDATE));
		        v_error := 0;
		        --commit;
			END IF;
				EXCEPTION WHEN OTHERS THEN
						  RAISE_APPLICATION_ERROR(SQLCODE,'Error updateando Kardex Ingreso Costo Venta, nativo:'||SQLERRM);
		END;
END P_INGRESO_COSTO_VENTA;

PROCEDURE P_INGRESO_SUBSIDIO(
v_error IN OUT AL_INTERCIERRE.cod_retorno%TYPE) IS

 CURSOR LOTES_Ofic_Tecno IS
        SELECT  TRUNC(a.fec_movimiento) fec_movimiento,
        74 cod_evento,
        'S/'||TO_CHAR(a.fec_movimiento,'yyyymmdd') id_lote,
        TO_CHAR(a.fec_periodo,'yyyymm') per_contable,
        USER nom_usuario_lote,
        SYSDATE fec_lote ,
        e.cod_operadora_scl operadora,
		a.cod_grpconcepto cod_grpconcepto ,
		f.cod_tecnologia cod_tecnologia
        FROM   AL_KARDEX a, al_movimientos b, ga_ventas c, al_tecnoarticulo_td f, al_bodeganodo d, ge_operadora_scl e
        WHERE  a.fec_imputsubsidio IS NULL
        AND a.cod_motivo IS NULL
        AND a.ind_entsal ='S'
		AND a.cod_articulo = f.cod_articulo
		AND f.ind_defecto  = 1
        AND a.fec_movimiento < TRUNC(SYSDATE)
        AND a.num_movimiento = b.num_movimiento
        AND a.cod_bodega = d.cod_bodega
        AND b.num_transaccion = c.num_venta
        AND c.ind_venta IN ('V','E')
        AND d.cod_bodeganodo = e.cod_bodeganodo
        GROUP BY  TRUNC(a.fec_movimiento) ,TO_CHAR(a.fec_movimiento,'yyyymmdd'),TO_CHAR(a.fec_periodo,'yyyymm'), e.cod_operadora_scl, a.cod_grpconcepto,f.cod_tecnologia;
--
 CURSOR LOTES_Tecno IS
        SELECT  TRUNC(a.fec_movimiento) fec_movimiento,
        74 cod_evento,
        'S/'||TO_CHAR(a.fec_movimiento,'yyyymmdd') id_lote,
        TO_CHAR(a.fec_periodo,'yyyymm') per_contable,
        USER nom_usuario_lote,
        SYSDATE fec_lote ,
        e.cod_operadora_scl operadora,
		f.cod_tecnologia cod_tecnologia
        FROM   AL_KARDEX a, al_movimientos b, ga_ventas c, al_tecnoarticulo_td f, al_bodeganodo d, ge_operadora_scl e
        WHERE  a.fec_imputsubsidio IS NULL
        AND    a.cod_motivo IS NULL
        AND    a.ind_entsal ='S'
		AND    a.cod_articulo = f.cod_articulo
		AND    f.ind_defecto = 1
        AND    a.fec_movimiento  < TRUNC(SYSDATE)
        AND    a.num_movimiento = b.num_movimiento
        AND    a.cod_bodega = d.cod_bodega
        AND    b.num_transaccion = c.num_venta
        AND    c.ind_venta IN ('V','E')
        AND    d.cod_bodeganodo = e.cod_bodeganodo
        GROUP BY  TRUNC(a.fec_movimiento) ,TO_CHAR(a.fec_movimiento,'yyyymmdd'),TO_CHAR(a.fec_periodo,'yyyymm'), e.cod_operadora_scl, f.cod_tecnologia;

 CURSOR LOTES_OFIC IS
        SELECT  TRUNC(a.fec_movimiento) fec_movimiento,
        74 cod_evento,
        'S/'||TO_CHAR(a.fec_movimiento,'yyyymmdd') id_lote,
        TO_CHAR(a.fec_periodo,'yyyymm') per_contable,
        USER nom_usuario_lote,
        SYSDATE fec_lote ,
        e.cod_operadora_scl operadora,
		a.cod_grpconcepto cod_grpconcepto
        FROM AL_KARDEX a, al_movimientos b, ga_ventas c, al_bodeganodo d, ge_operadora_scl e
        WHERE  a.fec_imputsubsidio IS NULL
        AND    a.cod_motivo IS NULL
        AND    a.ind_entsal ='S'
        AND    a.fec_movimiento  < TRUNC(SYSDATE)
        AND    a.num_movimiento = b.num_movimiento
        AND    a.cod_bodega 	= d.cod_bodega
        AND    b.num_transaccion = c.num_venta
        AND    c.ind_venta IN ('V','E')
        AND    d.cod_bodeganodo = e.cod_bodeganodo
        GROUP BY  TRUNC(a.fec_movimiento) ,TO_CHAR(a.fec_movimiento,'yyyymmdd'),TO_CHAR(a.fec_periodo,'yyyymm'), e.cod_operadora_scl, a.cod_grpconcepto;

 CURSOR LOTES IS
        SELECT  TRUNC(a.fec_movimiento) fec_movimiento,
        74 cod_evento,
        'S/'||TO_CHAR(a.fec_movimiento,'yyyymmdd') id_lote,
        TO_CHAR(a.fec_periodo,'yyyymm') per_contable,
        USER nom_usuario_lote,
        SYSDATE fec_lote ,
        e.cod_operadora_scl operadora
        FROM AL_KARDEX a, al_movimientos b, ga_ventas c, al_bodeganodo d, ge_operadora_scl e
        WHERE  a.fec_imputsubsidio IS NULL
        AND a.cod_motivo IS NULL
        AND a.ind_entsal ='S'
        AND a.fec_movimiento  < TRUNC(SYSDATE)
        AND a.num_movimiento = b.num_movimiento
        AND a.cod_bodega = d.cod_bodega
        AND b.num_transaccion = c.num_venta
        AND c.ind_venta IN ('V','E')
        AND d.cod_bodeganodo = e.cod_bodeganodo
        GROUP BY  TRUNC(a.fec_movimiento) ,TO_CHAR(a.fec_movimiento,'yyyymmdd'),TO_CHAR(a.fec_periodo,'yyyymm'), e.cod_operadora_scl;
--
CURSOR detalle_lotes_Ofic_Tecno IS
        SELECT /*+ index(b) */
		74 cod_evento,
         'S/'||TO_CHAR(a.fec_movimiento,'yyyymmdd') id_lote,
        LPAD(a.cod_uso,6,0) cod_concepto,
        NVL(SUM(a.cant_salida * a.mto_subsidio),0) imp_movimiento,
        NULL des_transaccion,
		h.cod_operadora_scl	operadora,
		a.cod_grpconcepto cod_grpconcepto ,
		i.cod_tecnologia cod_tecnologia
        FROM al_movimientos b, ga_ventas c,
			        (SELECT /*+ index(a1,ak01_al_kardex) */ a1.*
			        FROM AL_KARDEX a1
					WHERE  a1.cod_motivo IS NULL
		        	AND    a1.ind_entsal ='S'
					AND    a1.num_movkardex > -1
		        	AND    a1.fec_movimiento  < TRUNC(SYSDATE)
					AND    a1.fec_imputsubsidio IS NULL ) a,
		ge_direcciones d, ge_ciudades f, al_tecnoarticulo_td i, al_bodegas e,al_bodeganodo g, ge_operadora_scl h
        WHERE b.num_transaccion = c.num_venta
		AND c.ind_venta IN ('V','E')
		AND a.cod_articulo = i.cod_articulo
		AND i.ind_defecto  = 1
        AND a.num_movimiento = b.num_movimiento
        AND a.cod_bodega = e.cod_bodega
        AND d.cod_region =f.cod_region
        AND d.cod_provincia =f.cod_provincia
        AND d.cod_ciudad = f.cod_ciudad
	AND e.cod_direccion = d.cod_direccion
	AND e.cod_bodega = g.cod_bodega
	AND g.cod_bodeganodo = h.cod_bodeganodo
        GROUP BY a.fec_movimiento,a.fec_periodo,a.cod_uso, h.cod_operadora_scl, a.cod_grpconcepto,i.cod_tecnologia;
--


CURSOR detalle_lotes_Tecno IS
        SELECT /*+ index(b) */
		74 cod_evento,
         'S/'||TO_CHAR(a.fec_movimiento,'yyyymmdd') id_lote,
        LPAD(a.cod_uso,6,0) cod_concepto,
        NVL(SUM(a.cant_salida * a.mto_subsidio),0) imp_movimiento,
        NULL des_transaccion,
		h.cod_operadora_scl	operadora,
		i.cod_tecnologia cod_tecnologia
        FROM al_movimientos b, ga_ventas c,
			        (SELECT /*+ index(a1,ak01_al_kardex) */ a1.*
			        FROM AL_KARDEX a1
					WHERE  a1.cod_motivo IS NULL
		        	AND    a1.ind_entsal ='S'
					AND    a1.num_movkardex > -1
		        	AND    a1.fec_movimiento  < TRUNC(SYSDATE)
					AND    a1.fec_imputsubsidio IS NULL ) a,
		   	 ge_direcciones d, ge_ciudades f, al_tecnoarticulo_td i, al_bodegas e,al_bodeganodo g, ge_operadora_scl h
        WHERE  b.num_transaccion = c.num_venta
		AND c.ind_venta IN ('V','E')
		AND a.cod_articulo = i.cod_articulo
		AND i.ind_defecto  = 1
        AND a.num_movimiento = b.num_movimiento
        AND a.cod_bodega = e.cod_bodega
        AND d.cod_region =f.cod_region
        AND d.cod_provincia =f.cod_provincia
        AND d.cod_ciudad = f.cod_ciudad
		AND e.cod_direccion = d.cod_direccion
		AND e.cod_bodega = g.cod_bodega
		AND g.cod_bodeganodo = h.cod_bodeganodo
        GROUP BY a.fec_movimiento,a.fec_periodo,a.cod_uso, h.cod_operadora_scl, i.cod_tecnologia;
--
CURSOR detalle_lotes_ofic IS
        SELECT /*+ index(b) */
		74 cod_evento,
         'S/'||TO_CHAR(a.fec_movimiento,'yyyymmdd') id_lote,
        LPAD(a.cod_uso,6,0) cod_concepto,
        NVL(SUM(a.cant_salida * a.mto_subsidio),0) imp_movimiento,
        NULL des_transaccion,
		h.cod_operadora_scl	operadora,
		a.cod_grpconcepto cod_grpconcepto
        FROM al_movimientos b, ga_ventas c,
			        (SELECT /*+ index(a1,ak01_al_kardex) */ a1.*
			        FROM AL_KARDEX a1
					WHERE  a1.cod_motivo IS NULL
		        	AND    a1.ind_entsal ='S'
					AND    a1.num_movkardex > -1
		        	AND    a1.fec_movimiento  < TRUNC(SYSDATE)
					AND    a1.fec_imputsubsidio IS NULL )a,
		   ge_direcciones d, al_bodegas e, ge_ciudades f,al_bodeganodo g, ge_operadora_scl h
        WHERE  b.num_transaccion = c.num_venta
        AND c.ind_venta IN ('V','E')
        AND a.num_movimiento = b.num_movimiento
        AND a.cod_bodega = e.cod_bodega
        AND d.cod_region =f.cod_region
        AND d.cod_provincia =f.cod_provincia
        AND d.cod_ciudad = f.cod_ciudad
        AND e.cod_direccion = d.cod_direccion
	AND e.cod_bodega = g.cod_bodega
	AND g.cod_bodeganodo = h.cod_bodeganodo
        GROUP BY a.fec_movimiento,a.fec_periodo,a.cod_uso, h.cod_operadora_scl, a.cod_grpconcepto;

CURSOR detalle_lotes IS
        SELECT /*+ index(b) */
		74 cod_evento,
         'S/'||TO_CHAR(a.fec_movimiento,'yyyymmdd') id_lote,
        LPAD(a.cod_uso,6,0) cod_concepto,
        NVL(SUM(a.cant_salida * a.mto_subsidio),0) imp_movimiento,
        NULL des_transaccion,
        f.cod_plaza cod_plaza,
		h.cod_operadora_scl	operadora
        FROM al_movimientos b, ga_ventas c,
			        (SELECT /*+ index(a1,ak01_al_kardex) */ a1.*
			        FROM AL_KARDEX a1
					WHERE  a1.cod_motivo IS NULL
		        	AND    a1.ind_entsal ='S'
					AND    a1.num_movkardex > -1
		        	AND    a1.fec_movimiento  < TRUNC(SYSDATE)
					AND    a1.fec_imputsubsidio IS NULL )a,
		   ge_direcciones d, al_bodegas e, ge_ciudades f,al_bodeganodo g, ge_operadora_scl h
        WHERE  b.num_transaccion = c.num_venta
        AND    c.ind_venta IN ('V','E')
        AND    a.num_movimiento = b.num_movimiento
        AND    a.cod_bodega = e.cod_bodega
        AND    d.cod_region =f.cod_region
        AND    d.cod_provincia =f.cod_provincia
        AND    d.cod_ciudad = f.cod_ciudad
        AND    e.cod_direccion = d.cod_direccion
	AND    e.cod_bodega = g.cod_bodega
	AND    g.cod_bodeganodo = h.cod_bodeganodo
        GROUP BY a.fec_movimiento,a.fec_periodo,a.cod_uso, f.cod_plaza, h.cod_operadora_scl;

   ihcodevento      sc_evento.cod_evento%TYPE;
   szhidlote        sc_ent_lote.id_lote%TYPE;
   szhDesError      sc_error_ingreso.cod_error%TYPE;
   BEGIN
   		  SELECT aper_bodega, aper_tecnologia
		  INTO v_aper_oficina, v_aper_tecnologia
		  FROM SC_INDAPERTURA_TD
		  WHERE cod_modulo = 'AL';


  		  IF  v_aper_oficina = v_NO AND v_aper_tecnologia = v_NO THEN
		  	  -- apertura original
	                FOR cc IN lotes  LOOP
					   	  v_id_lote := cc.id_lote;
	                   INSERT INTO sc_ent_cab_lote (cod_evento,id_lote,per_contable,nom_usuario_lote,fec_lote, cod_operadora_scl)
	                          VALUES (
	                          cc.cod_evento,
	                          v_id_lote,
	                          cc.per_contable,
	                          cc.nom_usuario_lote,
	                          cc.fec_lote,
	                          cc.operadora            );
	                END LOOP;
	                FOR cc1 IN detalle_lotes  LOOP
			           v_concepto := SC_CONCEPTOGRP_FN(cc1.cod_evento,'AL_USOS',cc1.cod_concepto);
					   IF v_concepto IS NULL THEN
				            v_concepto := 'E'||cc1.cod_concepto;
				   	   END IF;
					   	  v_id_lote := cc1.id_lote;
	                   INSERT INTO sc_ent_lote (cod_evento,id_lote,cod_concepto,imp_movimiento, cod_operadora_scl)
	                          VALUES (
	                          cc1.cod_evento,
	                          v_id_lote,
	                          v_concepto,
	                          cc1.imp_movimiento,
							  cc1.operadora);
	                END LOOP;
	                FOR cc IN lotes  LOOP
	                   szhDesError:=0;
					   	  v_id_lote := cc.id_lote;
	                          sc_p_ingresa_lote(TO_CHAR(cc.cod_evento),v_id_lote,cc.operadora);
	                          SELECT COUNT(1)
	                          INTO   szhDesError
	                          FROM   sc_error_ingreso
	                          WHERE  cod_evento = cc.cod_evento
	                          AND    id_lote    = cc.id_lote
							  AND	 cod_error  <> v_error_concepto;
	                          IF szhDesError=0  THEN
	   						        bRet :=TRUE;
	                          ELSE
							  	    bRet :=FALSE;
	                          END IF;
	              END LOOP;
		  ELSE
		  	  IF v_aper_oficina = v_SI AND v_aper_tecnologia = v_SI THEN
			   -- apertura por original, bodega y tecnologia
			                FOR cc IN lotes_ofic_tecno  LOOP
							   	  v_id_lote := cc.id_lote||'/'||cc.cod_grpconcepto||'/'||cc.cod_tecnologia||'/';
			                   INSERT INTO sc_ent_cab_lote (cod_evento,id_lote,per_contable,nom_usuario_lote,fec_lote, cod_operadora_scl)
			                          VALUES (
			                          cc.cod_evento,
			                          v_id_lote,
			                          cc.per_contable,
			                          cc.nom_usuario_lote,
			                          cc.fec_lote,
			                          cc.operadora            );
			                END LOOP;
			                FOR cc1 IN detalle_lotes_ofic_tecno  LOOP
					           v_concepto := SC_CONCEPTOGRP_FN(cc1.cod_evento,'AL_USOS',cc1.cod_concepto,'AL_BODEGAS',cc1.cod_grpconcepto,'AL_TECNOLOGIA',cc1.cod_tecnologia);
							   IF v_concepto IS NULL THEN
						            v_concepto := 'E'||cc1.cod_concepto;
						   	   END IF;
							   	  v_id_lote := cc1.id_lote||'/'||cc1.cod_grpconcepto||'/'||cc1.cod_tecnologia||'/';
			                   INSERT INTO sc_ent_lote (cod_evento,id_lote,cod_concepto,imp_movimiento, cod_operadora_scl)
			                          VALUES (
			                          cc1.cod_evento,
			                          v_id_lote,
			                          v_concepto,
			                          cc1.imp_movimiento,
									  cc1.operadora);
			                END LOOP;
			                FOR cc IN lotes_ofic_tecno  LOOP
			                   szhDesError:=0;
							   	  v_id_lote := cc.id_lote||'/'||cc.cod_grpconcepto||'/'||cc.cod_tecnologia||'/';
								      DBMS_OUTPUT.PUT_LINE(v_id_lote);
			                          sc_p_ingresa_lote(TO_CHAR(cc.cod_evento),v_id_lote,cc.operadora);
			                          SELECT COUNT(1)
			                          INTO   szhDesError
			                          FROM   sc_error_ingreso
			                          WHERE  cod_evento = cc.cod_evento
			                          AND    id_lote    = cc.id_lote
									  AND	 cod_error  <> v_error_concepto;
									  DBMS_OUTPUT.PUT_LINE('szhDesError: '||szhDesError);
			                          IF szhDesError=0  THEN
			  						        bRet :=TRUE;
			                          ELSE
 							                bRet :=FALSE;
			                          END IF;
			              END LOOP;
		      ELSE
			  	  IF v_aper_tecnologia = v_SI THEN
  				  	 -- apertura por Tecnologia
			                FOR cc IN lotes_Tecno  LOOP
							   	  v_id_lote := cc.id_lote||'/'||cc.cod_tecnologia||'/';
			                   INSERT INTO sc_ent_cab_lote (cod_evento,id_lote,per_contable,nom_usuario_lote,fec_lote, cod_operadora_scl)
			                          VALUES (
			                          cc.cod_evento,
			                          v_id_lote,
			                          cc.per_contable,
			                          cc.nom_usuario_lote,
			                          cc.fec_lote,
			                          cc.operadora            );
			                END LOOP;
			                FOR cc1 IN detalle_lotes_Tecno  LOOP
					           v_concepto := SC_CONCEPTOGRP_FN(cc1.cod_evento,'AL_USOS',cc1.cod_concepto,'AL_TECNOLOGIA',cc1.cod_tecnologia);
							   IF v_concepto IS NULL THEN
						            v_concepto := 'E'||cc1.cod_concepto;
						   	   END IF;
							   	  v_id_lote := cc1.id_lote||'/'||cc1.cod_tecnologia||'/';
			                   INSERT INTO sc_ent_lote (cod_evento,id_lote,cod_concepto,imp_movimiento, cod_operadora_scl)
			                          VALUES (
			                          cc1.cod_evento,
			                          v_id_lote,
			                          v_concepto,
			                          cc1.imp_movimiento,
									  cc1.operadora);
			                END LOOP;
			                FOR cc IN lotes_Tecno  LOOP
			                   szhDesError:=0;
							   	  v_id_lote := cc.id_lote||'/'||cc.cod_tecnologia||'/';
			                          sc_p_ingresa_lote(TO_CHAR(cc.cod_evento),v_id_lote,cc.operadora);
			                          SELECT COUNT(1)
			                          INTO   szhDesError
			                          FROM   sc_error_ingreso
			                          WHERE  cod_evento = cc.cod_evento
			                          AND    id_lote    = cc.id_lote
									  AND	 cod_error  <> v_error_concepto;
			                          IF szhDesError=0  THEN
			  						        bRet :=TRUE;
			                          ELSE
							  	    bRet :=FALSE;
			                          END IF;
			              END LOOP;
				  ELSE
				  	 -- apertura por oficina
			                FOR cc IN lotes_ofic  LOOP
							   	  v_id_lote := cc.id_lote||'/'||cc.cod_grpconcepto||'/';
			                   INSERT INTO sc_ent_cab_lote (cod_evento,id_lote,per_contable,nom_usuario_lote,fec_lote, cod_operadora_scl)
			                          VALUES (
			                          cc.cod_evento,
			                          v_id_lote,
			                          cc.per_contable,
			                          cc.nom_usuario_lote,
			                          cc.fec_lote,
			                          cc.operadora            );
			                END LOOP;
			                FOR cc1 IN detalle_lotes_ofic  LOOP
					           v_concepto := SC_CONCEPTOGRP_FN(cc1.cod_evento,'AL_USOS',cc1.cod_concepto,'AL_BODEGAS',cc1.cod_grpconcepto);
							   IF v_concepto IS NULL THEN
						            v_concepto := 'E'||cc1.cod_concepto;
						   	   END IF;
							   	  v_id_lote := cc1.id_lote||'/'||cc1.cod_grpconcepto||'/';
			                   INSERT INTO sc_ent_lote (cod_evento,id_lote,cod_concepto,imp_movimiento, cod_operadora_scl)
			                          VALUES (
			                          cc1.cod_evento,
			                          v_id_lote,
			                          v_concepto,
			                          cc1.imp_movimiento,
									  cc1.operadora);
			                END LOOP;
			                FOR cc IN lotes_ofic  LOOP
			                   szhDesError:=0;
							   	  v_id_lote := cc.id_lote||'/'||cc.cod_grpconcepto||'/';
			                          sc_p_ingresa_lote(TO_CHAR(cc.cod_evento),v_id_lote,cc.operadora);
			                          SELECT COUNT(1)
			                          INTO   szhDesError
			                          FROM   sc_error_ingreso
			                          WHERE  cod_evento = cc.cod_evento
			                          AND    id_lote    = cc.id_lote
									  AND	 cod_error  <> v_error_concepto;
			                          IF szhDesError=0  THEN
			  						        bRet :=TRUE;
			                          ELSE
							  	            bRet :=FALSE;
			                          END IF;
			              END LOOP;
				  END IF;
		      END IF;
		  END IF;


		BEGIN
			IF bRet THEN
               UPDATE    AL_KARDEX
               SET   fec_imputsubsidio = SYSDATE
               WHERE fec_movimiento BETWEEN fec_movimiento AND (fec_movimiento+1)-24/60/60
               AND   num_movkardex IN
                            (SELECT a.num_movkardex
                             FROM   AL_KARDEX a, al_movimientos b, ga_ventas c
                             WHERE  a.fec_imputsubsidio IS NULL
                             AND    a.num_movimiento = b.num_movimiento
                             AND    b.num_transaccion = c.num_venta
                             AND    c.ind_venta IN ('V','E')
                             AND    a.cod_motivo IS NULL
                             AND    a.ind_entsal ='S'
                             AND    a.fec_movimiento  < TRUNC(SYSDATE));
               v_error := 0;
               --commit;
			END IF ;
			EXCEPTION WHEN OTHERS THEN
					  RAISE_APPLICATION_ERROR(SQLCODE,'Error updateando Kardex Ingreso Subsidio, nativo:'||SQLERRM);
		END;

END P_INGRESO_SUBSIDIO;
END Al_Pac_Kardex;
/
SHOW ERRORS
