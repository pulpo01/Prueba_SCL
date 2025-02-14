CREATE OR REPLACE PROCEDURE P_AL_TRATAMIENTO_KARDEX IS
        v_ind_entsal         AL_TIPOS_MOVIMIENTOS.ind_entsal%TYPE;
        v_can_stock          AL_STOCK.can_stock%TYPE;
		v_can_stock_ant      AL_STOCK.can_stock%TYPE;
        v_fec_peri           AL_CALE_KARDEX.fec_peri%TYPE;
        v_ind_proc           AL_ARTICULOS.ind_proc%TYPE;
        v_prc_pmp            AL_PMP_ARTICULO.prec_pmp%TYPE;
		v_prc_pmp_ant        AL_PMP_ARTICULO.prec_pmp%TYPE;
        v_stock              AL_STOCK.can_stock%TYPE;
        vp_pmp_calc          AL_PMP_ARTICULO.prec_pmp%TYPE;
		v_cod_articulo       AL_MOVIMIENTOS.cod_articulo%TYPE;
        v_stock_ent          AL_PDTE_KARDEX.cant_entrada%TYPE;
		v_stock_ent_tipOI    AL_PDTE_KARDEX.cant_entrada%TYPE;
		v_prc_total_tipOI    AL_PMP_ARTICULO.prec_pmp%TYPE;
        v_max_fec_peri       AL_CALE_KARDEX.fec_peri%TYPE;
		v_max_fec_peri_ant   AL_CALE_KARDEX.fec_peri%TYPE;
        v_stock_sal          AL_PDTE_KARDEX.cant_salida%TYPE;
		v_stock_ent_art      AL_PDTE_KARDEX.cant_salida%TYPE;
		v_stock_sal_art      AL_PDTE_KARDEX.cant_salida%TYPE;
        v_tip_stock_dest     AL_MOVIMIENTOS.tip_stock_dest%TYPE;
        v_cod_bodega_dest    AL_MOVIMIENTOS.cod_bodega_dest%TYPE;
        v_cod_estado_dest    AL_MOVIMIENTOS.cod_estado_dest%TYPE;
        v_cod_uso_dest       AL_MOVIMIENTOS.cod_uso_dest%TYPE;
        v_precio             AL_PMP_ARTICULO.prec_pmp%TYPE;
		v_prc_unidad_tipOI   AL_MOVIMIENTOS.prc_unidad%TYPE;
		v_glosa_error        VARCHAR2(70);
        v_seq_kardex         NUMBER;
        v_tabla              VARCHAR2(70);
        v_prc_pmp_existe     NUMBER;
		v_prc_pmp_existe_ant NUMBER;
        v_last_movim         AL_MOVIMIENTOS.num_movimiento%TYPE;
        v_last_movim_ctrl    AL_MOVIMIENTOS.num_movimiento%TYPE;
        v_cont_movim         AL_MOVIMIENTOS.num_movimiento%TYPE :=0;
        v_movim              AL_MOVIMIENTOS.num_movimiento%TYPE;
        v_movim_aux          AL_MOVIMIENTOS.num_movimiento%TYPE;
		v_ult_fec_movimiento AL_MOVIMIENTOS.fec_movimiento%TYPE;
		v_fec_movimiento     AL_MOVIMIENTOS.fec_movimiento%TYPE;
        v_operadora          GE_OPERADORA_SCL.cod_operadora_scl%TYPE;
        v_sqlcode            VARCHAR2(80);
        v_sqlerrm            VARCHAR2(80);
        v_fec_inicio         DATE;
        CURSOR CC_movim IS
           SELECT
                 a.num_movimiento,  a.tip_movimiento,    a.fec_movimiento,  a.cod_bodega,      a.cod_articulo,
                 a.num_cantidad,    a.cod_estadomov,     a.num_serie,       a.cod_bodega_dest, a.num_desde,
                 a.num_hasta,       a.num_guia,          a.cod_uso,         a.cod_estado,      a.tip_stock,
                 a.tip_stock_dest,  a.cod_uso_dest,      a.cod_estado_dest, a.prc_unidad,      a.cap_code,
                 a.num_telefono,    a.num_seriemec,      a.nom_usuarora,    a.cod_transaccion, a.num_transaccion,
                 a.cod_producto,    a.cod_central,       a.cod_moneda,      a.cod_subalm,      a.cod_central_dest,
                 a.cod_subalm_dest, a.num_telefono_dest, a.cod_cat,         a.cod_cat_dest,    a.ind_telefono,
                 a.num_sec_loca,    a.PLAN,              a.carga
           FROM  al_movimientos a, al_articulos b
           WHERE a.num_movimiento > v_last_movim
		   AND   a.fec_movimiento < TRUNC(v_ult_fec_movimiento)+2
	   	   AND   b.ind_equiacc    IN ('A','E')
	   	   AND   a.cod_articulo   = b.cod_articulo
           ORDER BY a.cod_articulo;

        ERROR_PROCESO_KARDEX EXCEPTION;
BEGIN
    -- Inicio nuevo calculo PMP
    v_fec_inicio := SYSDATE;

    v_tabla :='al_ctrl_kardex';
    SELECT MAX(num_movimiento) INTO v_last_movim
    FROM   al_ctrl_kardex;

	-- Fecha movimiento de la ultima transacción procesada
	SELECT fec_movimiento INTO v_ult_fec_movimiento
    FROM   al_movimientos
	WHERE  num_movimiento = v_last_movim;


    -- Si no exite el movimiento en la fecha marco como error
    IF v_last_movim IS NULL THEN
       v_glosa_error:='Ultimo movimiento no encontrado para dia ';
       RAISE ERROR_PROCESO_KARDEX;
    END IF;

    -- Extraigo operadora
    v_tabla :='ge_operadora_scl';
    SELECT COD_OPERADORA_SCL INTO v_operadora
    FROM   GE_OPERADORA_SCL
    WHERE  COD_BODEGANODO = 1;

    -- Si no encuentro la operadora marco error
    IF v_operadora IS NULL THEN
       v_glosa_error:='Operadora no encontrada ';
       RAISE ERROR_PROCESO_KARDEX;
    END IF;

    -- Obteniendo los datos del movimiento, N veces como registros tenga el Cursor...
    v_glosa_error:= 'Entra Cursor';

	v_cod_articulo     := NULL;
	v_stock_ent_tipOI  :=0;
	v_prc_total_tipOI  :=0;
	v_stock_ent_art    :=0;
	v_stock_sal_art    :=0;

    FOR vp_movim IN CC_movim LOOP

           v_last_movim_ctrl:= vp_movim.num_movimiento;
           v_cont_movim     := v_cont_movim+1;
           v_movim_aux      := vp_movim.num_movimiento;

           -- Obtengo tipo de movimiento E=entrada S=salida T=traspso
           v_tabla:= 'al_tipos_movimientos';
           SELECT IND_ENTSAL INTO v_ind_entsal
           FROM   AL_TIPOS_MOVIMIENTOS
           WHERE  TIP_MOVIMIENTO = vp_movim.tip_movimiento;

	   	   -- Si no exite el tipo de movimiento marco como error
           IF v_ind_entsal IS NULL THEN
              v_glosa_error:='Movimiento no encontrado:' || vp_movim.tip_movimiento;
              RAISE ERROR_PROCESO_KARDEX;
           END IF;

           -- Obtencion de fecha de ejercicio para este movimiento
           v_tabla:= 'al_cale_kardex';
           SELECT fec_peri INTO v_fec_peri
           FROM AL_CALE_KARDEX
           WHERE TRUNC(vp_movim.fec_movimiento) BETWEEN fec_inic AND fec_term;

           -- Si no existe registro de fecha de ejercicio marco el error
           IF v_fec_peri IS NULL THEN
              v_glosa_error:='fecha de ejercicio no encontrada:' || vp_movim.fec_movimiento;
              RAISE ERROR_PROCESO_KARDEX;
           END IF;

           -- Obtencion de procedencia de la serie Nacional o Internacional
           v_tabla:= 'al_articulos';
           SELECT ind_proc INTO v_ind_proc
           FROM   AL_ARTICULOS
           WHERE  cod_articulo=vp_movim.cod_articulo;

           --Si la serie no tiene procedencia marco el error
           IF v_ind_proc IS NULL THEN
              v_glosa_error:='serie sin procedencia:' || vp_movim.num_serie;
              RAISE ERROR_PROCESO_KARDEX;
           END IF;

	   	   -- Buscar PMP para ejercicio del movimiento
           -- Modificacion para que extraiga PMP de articulo que corresponda a la operadora
           v_tabla:= 'al_pmp_articulo';
           SELECT NVL(COUNT(1),0)   INTO v_prc_pmp_existe
           FROM   AL_PMP_ARTICULO
           WHERE  FEC_PERIODO       = v_fec_peri
           AND    COD_ARTICULO      = vp_movim.cod_articulo
           AND    COD_OPERADORA_SCL = v_operadora;
           IF v_prc_pmp_existe = 0 THEN
              SELECT MAX(fec_periodo)  INTO v_max_fec_peri
              FROM   AL_PMP_ARTICULO
              WHERE  COD_ARTICULO      = vp_movim.cod_articulo
              AND    COD_OPERADORA_SCL = v_operadora;
	      IF v_max_fec_peri IS NULL THEN
                 v_prc_pmp   :=0;
				 v_can_stock :=0;
              ELSE
                 SELECT PREC_PMP, can_stock INTO v_prc_pmp, v_can_stock
                 FROM   AL_PMP_ARTICULO
                 WHERE  FEC_PERIODO         = v_max_fec_peri
                 AND    COD_ARTICULO        = vp_movim.cod_articulo
                 AND    COD_OPERADORA_SCL   = v_operadora;
              END IF;
           ELSE
              SELECT prec_pmp, can_stock INTO v_prc_pmp, v_can_stock
              FROM   AL_PMP_ARTICULO
              WHERE  fec_periodo         = v_fec_peri
              AND    cod_articulo        = vp_movim.cod_articulo
              AND    COD_OPERADORA_SCL   = v_operadora;
           END IF;

           -- Verifico que los campos no sean nulos para el caso de los traspasos
           IF vp_movim.tip_stock_dest IS NULL THEN
              v_tip_stock_dest:=vp_movim.tip_stock;
           ELSE
              v_tip_stock_dest:=vp_movim.tip_stock_dest;
           END IF;
           IF vp_movim.cod_bodega_dest IS NULL THEN
              v_cod_bodega_dest:=vp_movim.cod_bodega;
           ELSE
              v_cod_bodega_dest:=vp_movim.cod_bodega_dest;
           END IF;
		   IF vp_movim.cod_uso_dest IS NULL THEN
              v_cod_uso_dest:=vp_movim.cod_uso;
           ELSE
              v_cod_uso_dest:=vp_movim.cod_uso_dest;
           END IF;
		   IF vp_movim.cod_estado_dest IS NULL THEN
              v_cod_estado_dest:=vp_movim.cod_estado;
           ELSE
              v_cod_estado_dest:=vp_movim.cod_estado_dest;
           END IF;
		   IF vp_movim.prc_unidad IS NULL AND v_ind_entsal = 'E' THEN
                 NULL;
           END IF;

	   v_glosa_error:= 'Calculo';
	   IF v_cod_articulo <> vp_movim.cod_articulo OR v_cod_articulo IS NULL THEN
              -- En el caso de que no exista registro de PMP para ese articulo
              IF v_prc_pmp_existe_ant = 0 THEN
   	          	 v_glosa_error:= 'calculo pmp = 0';
                 IF v_max_fec_peri_ant IS NOT NULL THEN
   	             	vp_pmp_calc:= ROUND((v_prc_pmp_ant*v_can_stock_ant + v_prc_total_tipOI)/(v_can_stock_ant + v_stock_ent_tipOI),4);
                 ELSE
		    	 	vp_pmp_calc:= v_prc_unidad_tipOI;
                 END IF;
--                  INSERT INTO AL_PMP_ARTICULO(cod_articulo,fec_periodo,fec_ult_mod,can_stock,prec_pmp,fec_dia_pmp,cod_operadora_scl)
--                  VALUES(v_cod_articulo,v_fec_peri,SYSDATE,v_can_stock_ant+v_stock_ent_art - v_stock_sal_art,vp_pmp_calc,TRUNC(vp_movim.fec_movimiento),v_operadora);
              ELSE
                 v_glosa_error:= 'calculo pmp <> 0';
	         	 vp_pmp_calc:= ROUND((v_prc_pmp_ant*v_can_stock_ant + v_prc_total_tipOI)/(v_can_stock_ant + v_stock_ent_tipOI),4);
-- 		 		 UPDATE AL_PMP_ARTICULO
-- 		 		 SET    PREC_PMP          = vp_pmp_calc,
-- 		         		CAN_STOCK         = v_can_stock_ant+v_stock_ent_art-v_stock_sal_art,
-- 						FEC_DIA_PMP       = TRUNC(vp_movim.fec_movimiento),
-- 						FEC_ULT_MOD		  = SYSDATE
--                  WHERE  FEC_PERIODO       = v_fec_peri
--                  AND    COD_ARTICULO      = v_cod_articulo
--                  AND    COD_OPERADORA_SCL = v_operadora;
              END IF;

		  v_glosa_error := 'Pasa PMP historico';
-- 		  INSERT INTO al_hpmp_articulo_th (cod_articulo, fec_periodo, cod_operadora_scl, fec_historico, prec_pmp, fec_ult_mod, can_stock, fec_dia_pmp, can_salidas, can_entradas, nom_usuario, tip_proceso, can_ingresos, prc_unidad)
-- 		  SELECT cod_articulo, fec_periodo, cod_operadora_scl,SYSDATE fec_historico, prec_pmp, fec_ult_mod,can_stock,fec_dia_pmp,can_salidas, can_entradas, user, 'AUROMATICO', can_ingresos, prc_unidad
-- 		  FROM   al_pmp_articulo
-- 		  WHERE  cod_articulo = v_cod_articulo
-- 		  AND    fec_periodo  = v_fec_peri;

		  v_glosa_error := 'Actualiza kardex';
		  UPDATE al_pdte_kardex
		  SET    prc_pmp        = vp_pmp_calc
		  WHERE  COD_ARTICULO   = v_cod_articulo
		  AND    num_movimiento > v_last_movim;

	      v_stock_ent_tipOI  :=0;
	      v_prc_total_tipOI  :=0;
		  v_prc_unidad_tipOI :=0;
		  v_stock_ent_art    :=0;
          v_stock_sal_art    :=0;
	   END IF;

       v_glosa_error:= 'Entradas';
 	   IF v_ind_entsal = 'E' THEN
	      v_stock_ent     := vp_movim.num_cantidad;
	      v_stock_ent_art := v_stock_ent_art+v_stock_ent;
	      IF vp_movim.tip_movimiento = 10 THEN
		  	 v_prc_unidad_tipOI := vp_movim.prc_unidad;
		 	 v_stock_ent_tipOI  := v_stock_ent_tipOI+vp_movim.num_cantidad;
		 	 v_prc_total_tipOI  := v_prc_total_tipOI+vp_movim.prc_unidad*vp_movim.num_cantidad;
	      END IF;
	   END IF;

       v_glosa_error:= 'Salidas';
       IF v_ind_entsal='S' THEN
	   	  v_stock_sal:= vp_movim.num_cantidad;
    	  v_stock_sal_art := v_stock_sal_art+v_stock_sal;
       END IF;

	   v_cod_articulo       := vp_movim.cod_articulo;
	   v_fec_movimiento     := vp_movim.fec_movimiento;
	   v_prc_pmp_existe_ant := v_prc_pmp_existe;
	   v_max_fec_peri_ant   := v_max_fec_peri;
	   v_can_stock_ant      := v_can_stock;
	   v_prc_pmp_ant        := v_prc_pmp;

       -- Saco secuencial kardex
       v_tabla:= 'al_seq_kardex';

       SELECT al_seq_kardex.NEXTVAL INTO v_seq_kardex FROM dual;
       -- Realizo ingreso de registro en kardex
       INSERT INTO AL_PDTE_KARDEX(num_movkardex,           tip_movimiento,                  ind_entsal,               fec_movimiento,
	                              fec_periodo,             cod_bodega,                      tip_stock,                cod_estado,
 				      			  cod_articulo,            cod_motivo,                      cod_mone,                 ind_proce,
 				      			  num_movimiento,          cod_orig,                        corr_apli,                cod_proveedor,
				      			  cod_uso,                 prc_unitario,                    cant_entrada,             cant_salida,
				      			  cant_saldo,              prc_pmp,                         mto_costoventa,           num_serie,
			   	      			  cod_usua,	              cod_grpconcepto)
                           VALUES(v_seq_kardex,            vp_movim.tip_movimiento,         v_ind_entsal,             vp_movim.fec_movimiento,
                                  v_fec_peri,              vp_movim.cod_bodega,             vp_movim.tip_stock,       vp_movim.cod_estado,
				      			  vp_movim.cod_articulo,   NULL,                            vp_movim.cod_moneda,      v_ind_proc,
				      			  vp_movim.num_movimiento, NVL(vp_movim.cod_transaccion,0), vp_movim.num_transaccion, NULL,
				      			  vp_movim.cod_uso,        vp_movim.prc_unidad,             v_stock_ent,              v_stock_sal,
 				      			  v_can_stock,             vp_pmp_calc,                     NULL,                     vp_movim.num_serie,
				      			  vp_movim.nom_usuarora,   AL_BUSCA_GRUPO_BODEGA_FN(vp_movim.cod_bodega));
END LOOP;

IF v_cont_movim > 0 THEN

   IF v_prc_pmp_existe = 0 THEN
      v_glosa_error:= 'EndLoop calculo pmp = 0';
      IF v_max_fec_peri IS NOT NULL THEN
   	     vp_pmp_calc:= ROUND((v_prc_pmp*v_can_stock + v_prc_total_tipOI)/(v_can_stock + v_stock_ent_tipOI),4);
      ELSE
	     vp_pmp_calc:=  v_prc_unidad_tipOI;
      END IF;
--       INSERT INTO AL_PMP_ARTICULO(cod_articulo,fec_periodo,fec_ult_mod,can_stock,prec_pmp,fec_dia_pmp,cod_operadora_scl)
--       VALUES(v_cod_articulo,v_fec_peri,SYSDATE,v_can_stock+v_stock_ent_art - v_stock_sal_art,vp_pmp_calc,TRUNC(v_fec_movimiento),v_operadora);
   ELSE
      v_glosa_error:= 'EndLoop calculo pmp <> 0';
      vp_pmp_calc:= ROUND((v_prc_pmp*v_can_stock + v_prc_total_tipOI)/(v_can_stock + v_stock_ent_tipOI),4);
--       UPDATE AL_PMP_ARTICULO
--       SET    PREC_PMP          = vp_pmp_calc,
--              CAN_STOCK         = v_can_stock + v_stock_ent_art - v_stock_sal_art,
-- 		 FEC_DIA_PMP	   = TRUNC(v_fec_movimiento),
-- 			 FEC_ULT_MOD       = SYSDATE
--       WHERE  FEC_PERIODO       = v_fec_peri
--       AND    COD_ARTICULO      = v_cod_articulo
--       AND    COD_OPERADORA_SCL = v_operadora;
  END IF;

  v_glosa_error := 'EndLoop Pasa PMP historico';

--   INSERT INTO al_hpmp_articulo_th (cod_articulo, fec_periodo, cod_operadora_scl, fec_historico, prec_pmp, fec_ult_mod, can_stock, fec_dia_pmp, can_salidas, can_entradas, nom_usuario, tip_proceso, can_ingresos, prc_unidad)
--   SELECT cod_articulo, fec_periodo, cod_operadora_scl,SYSDATE fec_historico, prec_pmp, fec_ult_mod,can_stock,fec_dia_pmp,can_salidas, can_entradas, user, 'AUROMATICO', can_ingresos, prc_unidad
--   FROM   al_pmp_articulo
--   WHERE  cod_articulo = v_cod_articulo
-- 	AND  fec_periodo  = v_fec_peri;

  v_glosa_error := 'EndLoop Actualiza kardex';
  UPDATE al_pdte_kardex
  SET    prc_pmp        = vp_pmp_calc
  WHERE  COD_ARTICULO   = v_cod_articulo
  AND    num_movimiento > v_last_movim;

  v_sqlerrm:=SQLERRM;
  v_sqlcode:=SQLCODE;

  SELECT MAX(num_movimiento) INTO v_last_movim_ctrl
  FROM  al_movimientos a, al_articulos b
  WHERE a.num_movimiento > v_last_movim
  AND   a.fec_movimiento < TRUNC(v_ult_fec_movimiento)+2
  AND   b.ind_equiacc    IN ('A','E')
  AND   a.cod_articulo   = b.cod_articulo;

  INSERT INTO al_ctrl_kardex(NUM_MOVIMIENTO, FEC_INICIO, FEC_TRASPASO, CANT_REG, COD_ESTADO, NOM_USUARIO,DES_RESPUESTA)
  VALUES (v_last_movim_ctrl,v_fec_inicio,SYSDATE,v_cont_movim,'OK',USER,v_sqlcode||v_sqlerrm);
  COMMIT;
ELSE
  v_glosa_error:='No existen movimientos pendientes para procesar.';
  RAISE ERROR_PROCESO_KARDEX;
END IF;

EXCEPTION
          WHEN ERROR_PROCESO_KARDEX THEN
	           RAISE_APPLICATION_ERROR (-20001,'SCL:' || v_glosa_error );
          WHEN NO_DATA_FOUND THEN
               v_sqlerrm:=SQLERRM;
               v_sqlcode:=SQLCODE;
               INSERT INTO al_ctrl_kardex(NUM_MOVIMIENTO, FEC_INICIO, FEC_TRASPASO, CANT_REG, COD_ESTADO, NOM_USUARIO,DES_RESPUESTA)
               VALUES (v_last_movim_ctrl,v_fec_inicio,SYSDATE,v_cont_movim,'ER',USER,v_sqlcode||v_sqlerrm);
               RAISE_APPLICATION_ERROR (-20002,'TMError:' || 'SIN DATOS TABLA' || V_TABLA );
          WHEN OTHERS THEN
		       --DBMS_OUTPUT.PUT_LINE('Error Nro.Movimiento :'|| v_movim_aux );
               v_sqlerrm:=SQLERRM;
               v_sqlcode:=SQLCODE;
               INSERT INTO al_ctrl_kardex(NUM_MOVIMIENTO, FEC_INICIO, FEC_TRASPASO, CANT_REG, COD_ESTADO, NOM_USUARIO,DES_RESPUESTA)
               VALUES (v_last_movim_ctrl,v_fec_inicio,SYSDATE,v_cont_movim,'ER',USER,v_sqlcode||v_sqlerrm);
               RAISE_APPLICATION_ERROR (-20003,'TMError:' || TO_CHAR(SQLCODE) || SQLERRM || ' Error Generico.' || v_glosa_error || v_movim);
END;
/
SHOW ERRORS
