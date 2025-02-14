CREATE OR REPLACE Procedure SISCEL.P_Al_Trasven_Web_New
IS

/*
<Documentación TipoDoc = "Package">
<Elemento Nombre = "P_Al_Trasven_Web_New" Lenguaje="PL/SQL" Fecha="05-12-2005" Versión="1.0" Diseñador="****" Programador="****" Ambiente="BD">
<Retorno>NA</Retorno>
<Descripción>PL, encargado de realizar facturaciones en NPW</Descripción>
<Parámetros>
    <Entrada>    </Entrada>
    <Salida>     </Salida>
</Parámetros>
</Elemento>
</Documentación>

-- PL/SQL Specification
-- *************************************************************************************************************
-- <VERSION >     : 1.1, se modifica para incidencia: CO-200605050103
-- <DESCRIPCION>  : Procedimiento encargado de transacciones para facturar Pedidos de npw</DESCRIPCION>
-- <FECHAMOD >    : 10-05-2006
-- <DESCMOD >     : Se agrega función:  NP_VALIDA_AL_CARGOS_FN, que se encarga de validar la existencia del total de series para cada linea de detalle en el pedido
-- <VERSION >     : 1.2, se modifica para incidencia: CO-200605050103
-- <FECHAMOD >    : 09-03-2007
-- <DESCMOD >     : Se actualiza el monto del descuento de mayorista, Incidencia: 38412.
-- <VERSION >     : 1.3
-- <AUTOR>        : Zenén Muñoz H.
-- <FECHAMOD >    : 17-04-2007
-- <DESCMOD >     : Se modifica el query que rescata un pedido candidato para facturar en NPW, Incidencia: 39617.
-- <VERSION >     : 1.4
-- <AUTOR>        : Carlos Araya Donoso
-- <FECHAMOD >    : 29-05-2007
-- <DESCMOD >     : Se incorpora asignacion de numero de movimiento para la entrada de mercaderia mayorista incidencia 38808
-- <VERSION >     : 1.5
-- <AUTOR>        :  Ingrid Cabrera
-- <FECHAMOD >    : 09-07-2007
-- <DESCMOD >     : Se modifica query de cursor series_conceptos 42217

-- <VERSION >     : 1.6
-- <AUTOR>        : zENÉN mUÑOZ h.
-- <FECHAMOD >    : 10-10-2007
-- <DESCMOD >     : Se moficia invocación a PL: P_AL_VEN_DIS_WEB_NEW, al que se le agrega en forma opcional el identificador de cliente mayorista, MA 44724

-- <VERSION >     : 1.7
-- <AUTOR>        : Zenén Muñoz H.
-- <FECHAMOD >    : 25-10-2007
-- <DESCMOD >     : Se moficia invocación a PL: P_AL_VEN_DIS_WEB_NEW, para que acepte el movimiento de articulos no seriados, para
                    Mayoristas o Dealers. MA 44724

-- <VERSION >     : 1.8
-- <AUTOR>        : Zenén Muñoz H.
-- <FECHAMOD >    : 27-02-2009
-- <DESCMOD >     : Verifica que al pedido de un mayorista se el hayan ingresado series en la tabla: np_detser_actvta_mayoristas_to
                    Incidencia: 80001

-- <VERSION >     : 1.9
-- <AUTOR>        : Zenén Muñoz H.
-- <FECHAMOD >    : 13/08/2009
-- <DESCMOD >     : Modificación a PL para: P-MIX-09003-Guatemala-Salvador
                    Se elimina código de Incidencia: 80001

-- **************************************************************************************************************

*/
cc  NUMBER:=0;

   /*v_no_existe_trasven         NUMBER;*/
   v_val_dto1                  NUMBER(14,4):=0;   --JAMB 201469
   v_flag                      NUMBER:=0;   --JAMB 201469
   sum_car_ocasi			   NUMBER:=0;
   v_num_noseriado             PLS_INTEGER; --NUMBER;
   v_realiza_venta             NUMBER;  /* 0 NO REALIZA VENTA , 1 REALIZA VENTA */
   v_existe_traspaso           PLS_INTEGER; --NUMBER; /*-- 0 (traspaso ya se realizo antes)   1 (traspaso no se ha realizado)*/
   v_existe_error_tras         PLS_INTEGER; --NUMBER;
   v_count_serie_ped           NUMBER;
   v_discount_serie_ped        PLS_INTEGER; --NUMBER;
   v_count_cod_estado_tras     NUMBER;
   v_err                       PLS_INTEGER; --NUMBER;
   v_err2                      PLS_INTEGER; --NUMBER;
   v_err_pedido                PLS_INTEGER; --NUMBER;
   v_countdis_indserie         PLS_INTEGER; --NUMBER;
   v_cantidad                  PLS_INTEGER; --NUMBER;
   v_cod_pedido                npt_pedido.cod_pedido%TYPE;
   v_cod_pedido_det            npt_pedido.cod_pedido%TYPE;
   v_cod_pedido_ser            npt_pedido.cod_pedido%TYPE;
   v_can_total_pedido          npt_pedido.can_total_pedido%TYPE;
   v_cod_cliente               npt_pedido.cod_cliente%TYPE;
   v_tip_doc_pedido            npt_pedido.tip_doc_pedido%TYPE;
   v_cod_usuario               npt_pedido.cod_usuario_cre%TYPE;
   v_cod_usuario_ing           npt_pedido.cod_usuario_ing%TYPE;
   v_lin_det_pedido            npt_detalle_pedido.lin_det_pedido%TYPE;
   v_lin_det_pedido_ser        npt_detalle_pedido.lin_det_pedido%TYPE;
   v_mto_uni_det_pedido        npt_detalle_pedido.mto_uni_det_pedido%TYPE;
   v_mto_des_det_pedido        npt_detalle_pedido.mto_des_det_pedido%TYPE;
   v_cod_articulo2             npt_detalle_pedido.cod_articulo%TYPE;
   v_cod_tecnologia			   npt_detalle_pedido.cod_tecnologia%TYPE;
   v_det_ind_equiacc		   al_articulos.ind_equiacc%TYPE;
   v_det_tip_terminal		   al_articulos.tip_terminal%TYPE;

   v_num_traspaso_masivo       al_traspasos_masivo.num_traspaso_masivo%TYPE;
   v_cod_estado_tras           al_traspasos_masivo.cod_estado_tras%TYPE;
   v_num_traspaso              al_traspasos_masivo.num_traspaso%TYPE;
   v_cod_bodega_ori            al_traspasos_masivo.cod_bodega_ori%TYPE;
   v_cod_bodega_dest           al_traspasos_masivo.cod_bodega_dest%TYPE;
   v_tip_stock                 al_traspasos_masivo.tip_stock%TYPE;
   v_cod_bodega_ori_aux        al_traspasos_masivo.cod_bodega_ori%TYPE;
   v_cod_bodega_dest_aux       al_traspasos_masivo.cod_bodega_dest%TYPE;

   v_tip_stock_aux             al_traspasos_masivo.tip_stock%TYPE;
   v_cod_articulo              al_traspasos_masivo.cod_articulo%TYPE;
   v_cod_uso                   al_traspasos_masivo.cod_uso%TYPE;
   v_cod_estado                al_traspasos_masivo.cod_estado%TYPE;
   v_num_serie                 al_traspasos_masivo.num_serie%TYPE;
   v_usu_traspaso_masivo       al_traspasos_masivo.usu_traspaso_masivo%TYPE;
   v_num_cantidad              al_traspasos_masivo.num_cantidad%TYPE;

   v_venta                     al_ventas%ROWTYPE;
   
   v_cargo                     al_cargos%ROWTYPE;
   v_dcto                      al_cargos.val_dto%TYPE;
   
   v_ind_equiacc               al_articulos.ind_equiacc%TYPE;
   v_ind_equiacc_aux           al_articulos.ind_equiacc%TYPE;
   v_ind_seriado               al_articulos.ind_seriado%TYPE;
   v_estado_pedido             npt_estado_pedido.cod_estado_flujo%TYPE;
   v_doc_guia                  ga_datosgener.cod_docguia%TYPE;
   v_doc_boleta                ga_datosgener.cod_docboleta%TYPE;
   v_ran_desde                 al_asig_documentos.ran_desde%TYPE;
   v_ran_hasta                 al_asig_documentos.ran_hasta%TYPE;
   v_errores                   al_errores_web%ROWTYPE;
   v_cod_pedido_aux            npt_pedido.cod_pedido%TYPE;
   v_nom_usuario_web           al_datos_generales.nom_usuario_web%TYPE;
   v_tip_stock_dest            al_traspasos_masivo.tip_stock_dest%TYPE;
   v_stock_consignacion        al_traspasos_masivo.tip_stock_dest%TYPE;
   v_stock_mercaderia          al_traspasos_masivo.tip_stock_dest%TYPE;
   v_stock_mercaderia_dealer   al_traspasos_masivo.tip_stock_dest%TYPE;
   v_tip_bodega                al_bodegas.tip_bodega%TYPE;
   v_contaux                   NUMBER;
   v_cont                      PLS_INTEGER; --NUMBER;
   v_valida_venta              PLS_INTEGER;

   -- INICIO ECU_05010
   v_valparametro86            npt_parametro.valor_parametro%TYPE;
   v_valparametro90actabo      npt_parametro.valor_parametro%TYPE;
   v_valparametro89tipservicio npt_parametro.valor_parametro%TYPE;
   v_sumatoria_mtocargo        ge_cargos.IMP_CARGO%type;
   v_sumatoria_descuento       ge_cargos.IMP_CARGO%type;
   v_ptj_des_det_pedido        npt_detalle_pedido.ptj_des_det_pedido%TYPE;
   v_valnumdecimalfact         PLS_INTEGER;
   -- FIN  ECU_05010


   /* VARIABLES PARA EL MANEJO DE ERRORES */
   --error_proceso_traspaso      EXCEPTION;
   --error_proceso_venta         EXCEPTION;
   --error_traspaso_hecho        EXCEPTION;
   --error_traspaso_venta        EXCEPTION;
   --no_existe_venta             EXCEPTION;

  /* nuevas variables para manejo de error (pmolina)*/
   v_paso    VARCHAR2 (255);
   error_proceso_general       EXCEPTION;
   error_Tratamiento_Masivo    EXCEPTION;
   /* Variables de foliacion  */
   vf_tip_foliacion            ge_tipdocumen.tip_foliacion%TYPE;
   vf_codigo_operadora         VARCHAR2 (255);
   vf_consulta_foliacion       VARCHAR2 (255);
   vf_consume_foliacion        VARCHAR2 (255);
   vf_num_proceso              fa_interfact.num_proceso%TYPE;
   v_siguiente_registro		   NUMBER;
   v_paralelismo			   NUMBER;
   v_cant_pedido                    NUMBER;
   v_num_seq_proc                   NUMBER;
   v_tipo_venta                     NUMBER :=0;
-----------------Variables para realizar movimientos de series via E/S  o Traspaso de Series-----------
   vs_via_traspa			   npt_parametro.valor_parametro%TYPE;
   cs_verdadero				   npt_parametro.valor_parametro%TYPE :='TRUE';
   vs_sal_def_may			   npt_parametro.valor_parametro%TYPE;
   vs_ing_mer_may			   npt_parametro.valor_parametro%TYPE;
   LI_traspaso_serie           INTEGER;
   LI_tipo_traspaso            INTEGER;

   sSql VARCHAR2(4000);
   NEVENTO VARCHAR2(20) :='0';
   ERRORCOD VARCHAR2(20);
   ERRORNEG VARCHAR2(200);
   ERRORDES VARCHAR2(50);
   ErrorNoCla VARCHAR2(50):= 'No Es Posible Recuperar Error Clasificado';
   LR_movim    				   al_movimientos%ROWTYPE;

   LN_ind_telefono			   al_series.ind_telefono%TYPE;
   LN_num_telefono			   al_series.num_telefono%TYPE;
   LV_cod_subalm			   al_series.cod_subalm%TYPE;
   LN_cod_central			   al_series.cod_central%TYPE;
   LN_cod_cat				   al_series.cod_cat%TYPE;
   LN_carga 				   al_series.carga%TYPE;
   LV_plan 					   al_series.plan%TYPE;
   LN_cod_producto			   al_series.cod_producto%TYPE;
   LN_cod_plaza				   al_series.cod_plaza%TYPE;
   LN_cod_hlr				   al_series.cod_hlr%TYPE;

   CN_stock_mercaderia CONSTANT PLS_INTEGER := 2;
   CV_ind_equipo CONSTANT VARCHAR2(1) := 'E';
   CV_tip_terminal CONSTANT VARCHAR2(1) := 'T';
   CN_doc_tras_mercad_dealer CONSTANT PLS_INTEGER := 6;

   ---****INCIDENCIA XO-200611011241*****------
   LV_cod_tipcomis_may  ged_codigos.COD_VALOR%TYPE :=0;
   LN_mayorista PLS_INTEGER :=0;
   LN_cod_cliente       NPT_PEDIDO.COD_CLIENTE%TYPE;
   CV_VE     	 	    CONSTANT VARCHAR2(3) := 'VE';
   CV_VE_TIPCOMIS       CONSTANT VARCHAR2(15) := 'VE_TIPCOMIS';
   CV_COD_TIPCOMIS      CONSTANT VARCHAR2(15) := 'COD_TIPCOMIS';

--   vExisteMayorista     number;  -- 80001  ZMH 27-02-2009  -- P-MIX-09003-Guatemala-Salvador
--   vClienteMayorista    npt_pedido.cod_cliente%type;   -- 80001  ZMH 27-02-2009 -- P-MIX-09003-Guatemala-Salvador
--   LN_EstadoCliente     number;    -- 80001  ZMH 27-02-2009  -- P-MIX-09003-Guatemala-Salvador
--   LV_Error             varchar2(200);   -- 80001  ZMH 27-02-2009  -- P-MIX-09003-Guatemala-Salvador

   e_BUSCA_ERROR EXCEPTION;
   ERR_INSERT_MOVIM  EXCEPTION;
----------------- FIN ----------------------------------------------------------------------------------


   /* CURSOR DE PEDIDOS  */
   CURSOR pedido (p_v_estado_pedido npt_estado_pedido.cod_estado_flujo%TYPE) IS
   SELECT n.cod_pedido
   FROM
   (
   SELECT MIN(d.cod_pedido) cod_pedido, d.cod_bodega, d.tip_stock, d.cod_articulo, d.cod_uso, d.cod_estado
   FROM (
         SELECT a.cod_pedido
         FROM   npt_pedido a, npt_estado_pedido b, npt_detalle_pedido e
         WHERE  a.cod_pedido = b.cod_pedido
		 AND    nvl(b.cod_pedido,b.cod_pedido) > 0                    --Inc MA-200606190940 ipct
         AND    a.cod_pedido = e.cod_pedido
         AND   (NOT EXISTS (SELECT NULL
                            FROM  al_errores_web d
                            WHERE d.cod_pedido       = a.cod_pedido
                            AND   d.cod_estado_error = 'PR'))
         AND b.cod_estado_flujo = p_v_estado_pedido
         AND fec_cre_est_pedido = (SELECT MAX(fec_cre_est_pedido)
                                   FROM   npt_estado_pedido
                                   WHERE  cod_pedido = a.cod_pedido AND nvl(cod_pedido,cod_pedido) > 0) --Inc MA-200606190940 ipct
         AND a.ind_proc<>1
	 AND NOT EXISTS (
             SELECT NULL
             FROM npt_pedido c, npt_detalle_pedido d, npt_estado_pedido f
             WHERE c.cod_pedido = d.cod_pedido
             AND   d.cod_pedido = f.cod_pedido
             AND   nvl(f.cod_pedido,f.cod_pedido) > 0                --Inc MA-200606190940 ipct
-- Inicio 39617, Para evitar que dos pedido con igual detalle y esten en condiciones de ser facturados, pueda ser considerado uno de ellos.
             AND   d.COD_Pedido =  e.COD_pedido
-- Fin 39617
             AND   d.COD_BODEGA =  e.COD_BODEGA
             AND   d.TIP_STOCK = e.TIP_STOCK
             AND   d.COD_ARTICULO = e.COD_ARTICULO
             AND   d.COD_USO = e.COD_USO
             AND   d.COD_ESTADO = e.COD_ESTADO
             AND  (NOT EXISTS (SELECT NULL
                               FROM  al_errores_web d
                               WHERE d.cod_pedido       = c.cod_pedido
                               AND   d.cod_estado_error = 'PR'))
             AND f.cod_estado_flujo = p_v_estado_pedido
             AND fec_cre_est_pedido = (SELECT MAX (fec_cre_est_pedido)
                                       FROM   npt_estado_pedido
                                       WHERE  cod_pedido = c.cod_pedido AND nvl(cod_pedido,cod_pedido) > 0)  --Inc MA-200606190940 ipct
             AND c.ind_proc=1)
             GROUP BY a.cod_pedido
	     HAVING COUNT(1) = (SELECT COUNT(1) FROM npt_detalle_pedido WHERE cod_pedido=a.cod_pedido)
   ) p , npt_detalle_pedido d
   WHERE p.cod_pedido=d.cod_pedido
   GROUP BY d.cod_bodega, d.tip_stock, d.cod_articulo, d.cod_uso, d.cod_estado
   ) n
   GROUP BY n.cod_pedido
   HAVING COUNT(1) = (SELECT COUNT(1) FROM npt_detalle_pedido WHERE cod_pedido=n.cod_pedido)
   ORDER BY 1;

   CURSOR detalle (p_v_cod_pedido npt_pedido.cod_pedido%TYPE)    IS
      SELECT   a.cod_pedido, a.lin_det_pedido, a.cod_bodega, a.tip_stock,a.cod_articulo, a.cod_uso,
	           a.cod_estado, a.can_asig_detalle_pedido,mto_uni_det_pedido, a.mto_des_det_pedido, a.cod_tecnologia,
	           a.ptj_des_det_pedido, b.ind_equiacc, b.tip_terminal  -- ECU_05010
         FROM npt_detalle_pedido a, al_articulos b
         WHERE a.cod_pedido = p_v_cod_pedido
		 AND a.cod_articulo = b.cod_articulo
         ORDER BY a.cod_pedido, a.lin_det_pedido;


    CURSOR series (p_v_cod_pedido npt_pedido.cod_pedido%TYPE,p_v_lin_det_pedido   npt_detalle_pedido.lin_det_pedido%TYPE) IS
       SELECT npt_serie.cod_pedido, npt_serie.lin_det_pedido, npt_serie.cod_serie_pedido,
       series.ind_telefono, series.num_telefono, series.cod_subalm, series.cod_central, series.cod_cat,
       series.carga, series.plan, series.cod_producto, series.cod_plaza, series.cod_hlr
       FROM npt_serie_pedido npt_serie, al_series series
       WHERE npt_serie.cod_pedido = p_v_cod_pedido
       AND npt_serie.lin_det_pedido = p_v_lin_det_pedido
       AND npt_serie.cod_serie_pedido = series.num_serie
       ORDER BY npt_serie.cod_pedido, npt_serie.lin_det_pedido;


   CURSOR articulo (p_v_cod_pedido npt_pedido.cod_pedido%TYPE) IS
      -- Interesante la creacisn de mndices para esta TABLA. En tst_dba2 no existen????
      SELECT   cod_articulo
         FROM npt_detalle_pedido
         WHERE cod_pedido = p_v_cod_pedido
         ORDER BY cod_pedido;

   CURSOR series_conceptos (p_v_cod_pedido npt_serie_pedido.cod_pedido%TYPE, p_v_lin_det_pedido   npt_serie_pedido.lin_det_pedido%TYPE) IS
      SELECT AVG (c.mto_uni_det_pedido), AVG (c.mto_des_det_pedido), a.cod_articulo, COUNT (1)
         FROM al_series a, npt_serie_pedido b, npt_detalle_pedido c
         WHERE a.num_serie = b.cod_serie_pedido
         AND b.cod_pedido = p_v_cod_pedido
         AND b.lin_det_pedido = p_v_lin_det_pedido
         AND b.cod_pedido = c.cod_pedido
         AND b.lin_det_pedido = c.lin_det_pedido
         AND EXISTS ( SELECT 1
		              FROM ged_parametros
                      WHERE (nom_parametro LIKE 'USO_PREPAGO%'
                          OR nom_parametro LIKE 'COD_USO_VENTA%')
                          AND val_parametro = TO_CHAR (a.cod_uso)) /* GSM */
--         GROUP BY c.mto_uni_det_pedido,c.mto_des_det_pedido,a.cod_articulo,a.cod_subalm,a.cod_central,a.cod_cat;
         GROUP BY c.mto_uni_det_pedido,c.mto_des_det_pedido,a.cod_articulo;    -- 42217  IPCT

    -- INICIO ECU_05010
    CURSOR CURSOR_DETALLE_CARGO (p_v_cod_pedido           npt_detalle_pedido.cod_pedido%TYPE,
	                             p_v_lin_det_pedido       npt_detalle_pedido.lin_det_pedido%TYPE,
								 p_v_valparametro90actabo npt_parametro.valor_parametro%TYPE,
								 p_v_valparametro89tipservicio npt_parametro.valor_parametro%TYPE) IS
    SELECT A.COD_PRODUCTO, A.COD_SERVICIO,
	       A.MTO_CARGO, C.COD_CONCEPTO, C.COD_CONCORIG
    FROM  NP_DETALLE_CARGO_TO A,
          GA_ACTUASERV B,
  		  FA_CONCEPTOS C
    WHERE A.COD_PEDIDO     = p_v_cod_pedido                 AND
	      A.LIN_DET_PEDIDO = p_v_lin_det_pedido             AND
          B.COD_ACTABO     = p_v_valparametro90actabo       AND
          B.COD_TIPSERV    = p_v_valparametro89tipservicio  AND
  		  C.COD_CONCORIG   = B.COD_CONCEPTO                 AND
          B.COD_PRODUCTO   = A.COD_PRODUCTO                 AND
          B.COD_SERVICIO   = A.COD_SERVICIO;
    -- FIN INICIO ECU_05010

---------------------------------------------------------------------------------------------------------------------
/* Comienza el programa */
---------------------------------------------------------------------------------------------------------------------
BEGIN

/*--------------------------------------------------------------------------------
   VALORES DE TIP_DOC_PEDIDO -- VENTAS NO INCLUYE CAMBIO DE TIPO DE STOCK
	 1 = Factura Venta
	 2 = Traspaso ( Para el caso de contrato )  a consignacion
	 3 = Factura Venta Regalo
	 4 = Boleta Venta
	 5 = Boleta Venta Regalo
	 6 = Traspaso ( Para el caso de contrato )  a mercaderia dealer
	 7 = Traspaso ( Para el caso de contrato )  a mercaderia
	 El tipo de stock esta en duro hasta que la parte de web vea como pasar el tipo de stock destino.
------------------------------------------------------------------------------------*/

   v_num_noseriado := 0;
   v_stock_consignacion := 10;
   v_stock_mercaderia_dealer := 4;
   v_stock_mercaderia := 2;


   /* obtiene estado de lectura siscel :10 */
   v_paso := '(ETAPA1:TRASPASO): OBTIENE ESTADO PEDIDO';

   P_Np_Estado_Traspaso (v_estado_pedido, v_err);
   -- INICIO ECU_05010
  BEGIN
    SELECT TO_NUMBER(VAL_PARAMETRO) INTO v_valnumdecimalfact
    FROM GED_PARAMETROS
    WHERE NOM_PARAMETRO= 'NUM_DECIMAL_FACT' AND COD_MODULO ='GE' AND COD_PRODUCTO = 1;

	SELECT UPPER(VALOR_PARAMETRO) INTO v_valparametro86
    FROM NPT_PARAMETRO WHERE ALIAS_PARAMETRO = 'CAR_OCASI';

    SELECT UPPER(VALOR_PARAMETRO) INTO v_valparametro89tipservicio
    FROM NPT_PARAMETRO WHERE ALIAS_PARAMETRO = 'TIPO_SERV';

    SELECT UPPER(VALOR_PARAMETRO) INTO v_valparametro90actabo
    FROM NPT_PARAMETRO WHERE ALIAS_PARAMETRO = 'COD_ACTABO';


   EXCEPTION
		    WHEN NO_DATA_FOUND THEN
			NULL;
   END;
   -- FIN  ECU_05010


   IF v_err <> 0 THEN  RAISE error_proceso_general;END IF;

   v_paso:='(ETAPA1:TRASPASO): OBTIENE USUARIO PEDIDO WEB';
   SELECT nom_usuario_web INTO v_nom_usuario_web FROM al_datos_generales;
   IF v_nom_usuario_web IS  NULL THEN RAISE error_proceso_general; END IF;

   /*-------COMIENZA RUTINA DE TRASPASO----------------------------------*/

select count(1)into cc from npt_estado_pedido where cod_pedido = v_cod_pedido;
dbms_output.put_line('-7 venta  :'||cc);
   v_paso:='(ETAPA1:TRASPASO): OBTIENE SECUENCIA DE TRASPASO';
   SELECT al_seq_traspaso.NEXTVAL INTO v_num_traspaso FROM dual;

   v_paso:= '(ETAPA1:TRASPASO): ABRE CURSOR PEDIDO';
   OPEN pedido (v_estado_pedido);
   LOOP
     BEGIN
       FETCH pedido INTO v_cod_pedido;
         EXIT WHEN pedido%NOTFOUND;


         SELECT cod_bodega, cod_cliente, cod_usuario_eje, can_total_pedido,
	           cod_cliente, tip_doc_pedido, cod_usuario_ing, ind_traspaso
         INTO   v_cod_bodega_dest,v_cod_cliente,v_cod_usuario,v_can_total_pedido,
               v_cod_cliente,v_tip_doc_pedido,v_cod_usuario_ing, LI_traspaso_serie
         FROM   npt_pedido
         WHERE  cod_pedido = v_cod_pedido;


		 --PARALELISMO
		 BEGIN
			 v_siguiente_registro := 0;
             v_paso:='(ETAPA 0.0:PARALELISMO): for update no wait';
			 SELECT cod_pedido INTO v_cod_pedido
			 FROM npt_pedido
			 WHERE cod_pedido = v_cod_pedido
			 AND ind_proc<>1
			 FOR UPDATE NOWAIT;
             v_paso:='(ETAPA 0.1:PARALELISMO): update pedido indicador de proceso a 1';
			 UPDATE npt_pedido
			 SET ind_proc=1
			 WHERE cod_pedido = v_cod_pedido;
			 --COMMIT;
             v_paso:='(ETAPA 0.2:PARALELISMO): Obteniendo parametro indicador de uso paralelistico';
			 SELECT NVL(val_parametro,0) INTO v_paralelismo
		     FROM ged_parametros
             WHERE nom_parametro = 'IND_VTAPARALELA' AND cod_modulo ='GA' AND cod_producto = 1;
			 --PARALELISMO
	     EXCEPTION
		    WHEN NO_DATA_FOUND THEN
				 v_siguiente_registro := 1;
			WHEN OTHERS THEN
		 	   IF SQLCODE = -54 THEN
			      v_siguiente_registro := 1;
			   ELSE
			          v_errores.cod_pedido := v_cod_pedido;
			          v_errores.fec_error := SYSDATE;
			          v_errores.glosa_error_traspaso := v_paso;
			          v_errores.glosa_error_venta := SQLERRM;
			          v_errores.cod_estado_error :='PR';
				  RAISE error_proceso_general;
			   END IF;
		 END;
/*
-- P-MIX-09003-Guatemala-Salvador
-- 80001 ZMH 27-02-2009
         v_paso:='(ETAPA 0.3:PARALELISMO): Valida Series Mayorista' || v_cod_pedido;
		 Begin
		    Select count(1) into  vExisteMayorista
            From np_detser_actvta_mayoristas_to
            Where cod_pedido = v_cod_pedido;
            If vExisteMayorista = 0 then
                v_paso:='(ETAPA 0.3:PARALELISMO): Series Mayorista Rescata Cliente' || v_cod_pedido;
                Select cod_cliente into vClienteMayorista
				From npt_pedido
                Where cod_pedido = v_cod_pedido;
                v_paso:='(ETAPA 0.3:PARALELISMO): Series Mayorista Cliente Mayorista' || vClienteMayorista;
				Np_Gestor_Mayoristas_Pg.NP_CLIENTE_MAYORISTA_PR(vClienteMayorista, LN_EstadoCliente,  LV_Error);
				If LN_EstadoCliente = 1 then  -- Es cliente mayorista
                   v_paso:='(ETAPA 0.3:PARALELISMO): Series Mayorista Ingresa Series' || v_cod_pedido;
				   NP_GESTOR_MAYORISTAS_PG.NP_ALAMCENASERIE_NUEVA_PR(v_cod_pedido, LV_Error);
				End if;
			End if;
		 End;
-- fin 80001
*/
select count(1)into cc from npt_estado_pedido where cod_pedido = v_cod_pedido;
dbms_output.put_line('-6 venta  :'||cc);
         IF v_siguiente_registro = 0 THEN
         	v_existe_traspaso := 1;
         	v_existe_error_tras := 1;

         	v_paso:='(ETAPA1:TRASPASO): VALIDACION DE SERIES REPETIDAS PARA PEDIDO= '||v_cod_pedido;
		 	SELECT COUNT (cod_serie_pedido) INTO v_count_serie_ped
		    FROM npt_serie_pedido
			WHERE cod_pedido = v_cod_pedido;
         	SELECT COUNT (DISTINCT (cod_serie_pedido)) INTO v_discount_serie_ped
		    FROM npt_serie_pedido
			WHERE cod_pedido = v_cod_pedido;
         	IF v_count_serie_ped <> v_discount_serie_ped THEN
            v_errores.cod_pedido := v_cod_pedido;
            v_errores.fec_error := SYSDATE;
            v_errores.glosa_error_traspaso := 'ERROR '||v_paso;
            v_errores.cod_estado_error :='PR';
            RAISE error_proceso_general;
         END IF;

		 v_paso := '(ETAPA1:TRASPASO): VALIDACION DE SERIES YA TRASPASADAS PARA PEDIDO= '||v_cod_pedido;
		 IF LI_traspaso_serie = 0 THEN

		 -- Si es = 0 TRUE, series no traspasadas,
		 -- Si es mayor a 0 FALSE, series ya traspasadas; seguir con la venta*/
		 -- Si es 1, series traspasadas por TRASPASO MASIVO.
		 -- SI es 2, series traspasadas por ENTRADA y SALIDA EXTRA.
         -- IF v_count_cod_estado_tras < 1 THEN


			-----------Zona para obtener valores por defecto para la venta via TRASPASO DE SERIES o ENTRADA/SALIDA EXTRA----------
         BEGIN
		     --Rescatar datos por defecto, como el codigo de la mercaderia dealer. Que es una
		     --validación que se debe hacer para las series.
		     sSql := 'select a.valor_parametro from npt_parametro a where a.alias_parametro = "VIA_TRASPA"';
	         ERRORCOD := '899'; -- Error único si falta alguno de estos parametros.

		     SELECT a.valor_parametro
			 INTO   vs_via_traspa
			 FROM   npt_parametro a
		     WHERE  a.alias_parametro = 'VIA_TRASPA';

			  --Rescatar datos por defecto, como el codigo de Ingreso mercaderia Mayorista.
		     sSql := 'select a.valor_parametro from npt_parametro a where a.alias_parametro = "ING_MER_MA"';
			 ERRORCOD := '897'; -- Error único si falta alguno de estos parametros.
     		 SELECT a.valor_parametro
			 INTO   vs_ing_mer_may
			 FROM   npt_parametro a
     		 WHERE  a.alias_parametro = 'ING_MER_MA';

			   --Rescatar datos por defecto, como el codigo de Salida Definitiva Mayorista.
     		 sSql := 'select a.valor_parametro from npt_parametro a where a.alias_parametro = "SAL_DEF_MA"';
			 ERRORCOD := '898'; -- Error único si falta alguno de estos parametros.
     		 SELECT a.valor_parametro
			 INTO   vs_sal_def_may
			 FROM   npt_parametro a
     		 WHERE  a.alias_parametro = 'SAL_DEF_MA';


		     EXCEPTION
	   		 WHEN OTHERS THEN

			      IF NOT GE_ERRORES_PG.MENSAJEERROR(ERRORCOD,ERRORNEG) THEN
			         	 ERRORNEG := ErrorNoCla;
			      END IF;
	      		  ERRORDES := 'NP_ORIGENVENTA_PR('||'); - ' || SQLERRM;
	      		  NEVENTO  := GE_ERRORES_PG.GRABARPL( NEVENTO, 'NP', 'Error Definido por el sistema', '1.0', USER, 'P_AL_TRASVEN_WEB_NEW', sSql, SQLCODE, ERRORDES );
				  v_errores.cod_pedido := v_cod_pedido;
            	  v_errores.fec_error := SYSDATE;
            	  v_errores.glosa_error_traspaso := 'Error en '||sSql;
            	  v_errores.cod_estado_error :='PR';
				  RAISE error_proceso_general;
   		 END;

	 		 -- según el valor del parametro vs_via_traspa la forma de traspaso de series puede ser TRASPASO o E/S extra.
			 IF  vs_via_traspa = cs_verdadero THEN
				 	  LI_tipo_traspaso := 1; -- Traspaso.
			 ELSE
				 	  LI_tipo_traspaso := 2; -- E/S Extra.
			 END IF;
----------------------------------------------FIN----------------------------------------------------------------------

				  ---Solo para mayorista se cambia el tipo stock para realizar la busqueda
						  SELECT a.cod_valor
						  INTO LV_cod_tipcomis_may
						  FROM  ged_codigos a
						  WHERE a.cod_modulo = CV_VE
						  AND a.nom_tabla = CV_VE_TIPCOMIS
						  AND a.nom_columna = CV_COD_TIPCOMIS;

						  SELECT a.cod_cliente
						  INTO  LN_cod_cliente
						  FROM  NPT_PEDIDO a
						  WHERE a.COD_PEDIDO  = v_cod_pedido ;

						  SELECT count(DISTINCT a.cod_tipcomis) --*** Si es 1 es mayorista -- 0 es dealer
						  INTO LN_mayorista
						  FROM ve_vendedores a
						  WHERE a.cod_cliente = LN_cod_cliente
						  AND   a.cod_tipcomis = LV_cod_tipcomis_may;


		  --------------------------------------------------------------------------

			 v_paso:= '(ETAPA1:TRASPASO): ASIGNA TIPO STOCK DESTINO';
			 v_tip_stock_dest := NULL;

			  IF LN_mayorista = 1 THEN
			  	 v_tip_stock_dest := v_stock_mercaderia_dealer;
			  ELSE
		         /* OJO, esto al final cuenta para registro de cambio de estado pedido */

		         IF v_tip_doc_pedido = 2 THEN
		            v_tip_stock_dest := v_stock_consignacion;
		         ELSIF v_tip_doc_pedido = 6 THEN
		            v_tip_stock_dest := v_stock_mercaderia_dealer;
		         ELSIF v_tip_doc_pedido = 7 THEN
		            v_tip_stock_dest := v_stock_mercaderia;
		         END IF;
			  END IF;
select count(1)into cc from npt_estado_pedido where cod_pedido = v_cod_pedido;
dbms_output.put_line('-5 venta  :'||cc);

	         /** OJO , solo validamos el tip_stock_destino contra la bodega destino, no el tipo de stock. Esa validacion va por WEB. */
			 v_paso := '(ETAPA1:TRASPASO): VERIFICA TIPO STOCK PARA BODEGA DESTINO='||v_cod_bodega_dest;
	         IF v_tip_stock_dest IS NOT NULL THEN
	            SELECT tip_bodega INTO v_tip_bodega
	              FROM al_bodegas
	              WHERE cod_bodega = v_cod_bodega_dest;
	            IF v_tip_bodega IS NULL THEN
	               v_errores.cod_pedido := v_cod_pedido;
	               v_errores.fec_error := SYSDATE;
	               v_errores.glosa_error_traspaso := 'ERROR ' ||v_paso;
	               v_errores.cod_estado_error :='PR';
	               RAISE error_proceso_general;
	            END IF;
	            SELECT COUNT (1) INTO v_contaux
	              FROM (SELECT 1 FROM al_tipostock_tipbodega
				        WHERE tip_stock = v_tip_stock_dest AND tip_bodega = v_tip_bodega AND ROWNUM = 1);
	            IF v_contaux = 0 THEN
	               v_errores.cod_pedido := v_cod_pedido;
	               v_errores.fec_error := SYSDATE;
	               v_errores.glosa_error_traspaso := 'ERROR EN SELECT al_tipostock_tipbodega 0';
	               v_errores.cod_estado_error :='PR';
	               RAISE error_proceso_general;
	            END IF;
	         END IF;

	         v_paso := '(ETAPA1:TRASPASO): OBTIENE USUARIO DE TRASPASO MASIVO PARA USUARIO= '||v_cod_usuario;
			 P_Np_Sacar_Usuario (v_cod_usuario, v_usu_traspaso_masivo, v_err2);
	         IF v_err2 <> 0 THEN
	            v_errores.cod_pedido := v_cod_pedido;
	            v_errores.fec_error := SYSDATE;
	            v_errores.glosa_error_traspaso := 'ERROR EN RETORNO DE P_Np_Sacar_Usuario ' || TO_CHAR(v_err2);
	            v_errores.glosa_error_venta := SQLERRM;
	            v_errores.cod_estado_error :='PR';
	            RAISE error_proceso_general;
	         END IF;
select count(1)into cc from npt_estado_pedido where cod_pedido = v_cod_pedido;
dbms_output.put_line('-4 venta  :'||cc);
	         v_num_noseriado := 0;
			 IF  vs_via_traspa = cs_verdadero THEN
				 v_paso := '(ETAPA1:TRASPASO): OBTIENE SECUENCIA DE TRASPASO MASIVO';
		         SELECT al_seq_traspaso_masivo.NEXTVAL INTO v_num_traspaso_masivo FROM dual;
			 END IF;

	         v_paso := '(ETAPA1:TRASPASO): ABRE CURSOR DETALLE PARA PEDIDO= '||v_cod_pedido;
			 OPEN detalle (v_cod_pedido);
	         LOOP
	            FETCH detalle INTO v_cod_pedido_det, v_lin_det_pedido, v_cod_bodega_ori, v_tip_stock, v_cod_articulo,
	                               v_cod_uso, v_cod_estado, v_num_cantidad, v_mto_uni_det_pedido, v_mto_des_det_pedido,
								   v_cod_tecnologia, v_ptj_des_det_pedido, v_det_ind_equiacc, v_det_tip_terminal;
	            EXIT WHEN detalle%NOTFOUND;
				v_paso := '(ETAPA1:TRASPASO): VALIDACION: ACTIVO FIJO POR WEB NO PUEDE VENDER NI TRASPASAR';
	            IF v_tip_stock = 1 AND v_tip_stock_dest IS NOT NULL THEN
	               v_errores.cod_pedido := v_cod_pedido;
	               v_errores.fec_error := SYSDATE;
	               v_errores.glosa_error_traspaso := 'ERROR ' || v_paso;
	               v_errores.cod_estado_error :='PR';
	               RAISE error_proceso_general;
	            END IF;
                IF  vs_via_traspa = cs_verdadero THEN
					v_cod_estado_tras := 'PW';
					v_paso := '(ETAPA1:TRASPASO): OBTIENE SECUENCIA DE TRASPASO MASIVO';
		            IF v_cod_bodega_ori_aux <> v_cod_bodega_ori  OR v_cod_bodega_dest_aux <> v_cod_bodega_dest
		               OR v_tip_stock_aux <> v_tip_stock  OR v_cod_pedido_aux <> v_cod_pedido  THEN
		               SELECT al_seq_traspaso.NEXTVAL INTO v_num_traspaso FROM dual;
		            END IF;
				END IF;

	            v_paso := '(ETAPA1:TRASPASO): VALIDA EXISTENCIA DE ARTICULO Y ACCESORIO PARA PEDIDO= '||v_cod_pedido;
				/* valida existencia de articulo y accesorio en mismo pedido  */
	            SELECT COUNT (1) INTO v_countdis_indserie
	              FROM (SELECT DISTINCT (a.ind_equiacc)
	                       FROM al_articulos a, npt_detalle_pedido b
	                       WHERE b.cod_pedido = v_cod_pedido
	                       AND b.cod_articulo = a.cod_articulo
	                       AND ROWNUM < 3);
	            IF v_countdis_indserie > 1 THEN
	               v_errores.cod_pedido := v_cod_pedido;
	               v_errores.fec_error := SYSDATE;
	               v_errores.glosa_error_traspaso := 'Existencia de articulo y accesorio en mismo pedido';
	               v_errores.cod_estado_error :='PR';
	               RAISE error_proceso_general;
	            END IF;

	            v_paso := '(ETAPA1:TRASPASO): VERIFICA SI ARTICULO= '||v_cod_articulo||'  ES SERIADO';
				SELECT ind_seriado INTO v_ind_seriado
	              FROM al_articulos
	              WHERE cod_articulo = v_cod_articulo;
	            IF v_ind_seriado IS NULL THEN
	               v_errores.cod_pedido := v_cod_pedido;
	               v_errores.fec_error := SYSDATE;
	               v_errores.glosa_error_traspaso := 'ERROR ind_seriado es nulo en AL_ARTICULOS';
	               v_errores.cod_estado_error :='PR';
	               RAISE error_proceso_general;
	            END IF;

--  44724, el tipo stock destino, sólo se cambia para los no seriados
                             if v_ind_seriado <> 1 then
			 	 v_tip_stock_dest := v_tip_stock;
                             End if;
-- Fin 44724

	            /* Usado para post pago  */
	            v_paso := '(ETAPA1:TRASPASO): ASIGNA TIPO STOCK DESTINO';
				IF v_cod_uso = 2 AND v_tip_stock_dest IS NULL THEN
	               v_tip_stock_dest := v_stock_mercaderia_dealer;
	            ELSIF v_tip_stock_dest IS NULL THEN
	               v_tip_stock_dest := v_tip_stock;
	            END IF;
				/* -------------------------------------*/
	 			IF v_ind_seriado <> 1 THEN
				   --FLAG_VIA_TRASPASO_SERIE = TRUE , SIGNIFICA QUE REALIZARA EL TRASAPASO DE SERIES
				   --SI ES FALSE, HARA EL TRASPASO DE SERIE VIA UNA ENTRADA/SALIDA EXTRA
				   IF vs_via_traspa = cs_verdadero THEN
				       v_paso := '(ETAPA1:TRASPASO)(ART.NO SERIADO): INSERTAR TRASPASO MASIVO. NUM_TRASPASO= '||v_num_traspaso_masivo||'   SERIE= '|| v_num_serie;
				       v_num_noseriado :=   v_num_noseriado + 1;
	                   v_num_serie     := 'NS' || v_num_noseriado;
     	               Al_Pac_Trasven_Web.insertar_traspaso_masivo ( v_num_traspaso_masivo, v_cod_estado_tras, v_num_traspaso,
     				   											   	 v_cod_bodega_ori, v_cod_bodega_dest, v_tip_stock,v_cod_articulo,
     																 v_cod_uso, v_cod_estado, v_num_serie,v_usu_traspaso_masivo,
																	 v_num_cantidad,v_cod_pedido,v_tip_stock_dest );
select count(1)into cc from npt_estado_pedido where cod_pedido = v_cod_pedido;
dbms_output.put_line('-3 venta  :'||cc);
-- Inicio de cambios de movimientos de mayoristas, 44724, 25-10-2007
/*
				   ELSE

				   -- ENTRADA Y SALIDA EXTRA PARA LOS NO SERIADOS
				   --Obtener secuencia  de movimiento.
   						SELECT al_seq_mvto.nextval
   						INTO   LR_movim.num_movimiento
   						FROM DUAL;
   						-------- salida -----------
						LR_movim.cod_articulo      := v_cod_articulo;
						LR_movim.cod_estado        := v_cod_estado;
						LR_movim.cod_uso           := v_cod_uso;
   						LR_movim.tip_stock         := v_tip_stock;
						LR_movim.fec_movimiento    := sysdate;
						LR_movim.cod_estadomov     := 'PR';
						LR_movim.ind_telefono      := NULL;
   						LR_movim.num_telefono      := NULL;
   						LR_movim.cod_central       := NULL;
   						LR_movim.cod_cat           := NULL;
   						LR_movim.cod_subalm        := NULL;
   						LR_movim.cod_subalm_dest   := NULL;
   						LR_movim.cod_central_dest  := NULL;
   						LR_movim.cod_cat_dest      := NULL;
   						LR_movim.num_serie         := NULL;
   						LR_movim.num_serie         := NULL;
   						LR_movim.carga         	   := NULL;
   						LR_movim.plan         	   := NULL;
   						LR_movim.cod_producto      := 1;
						LR_movim.cod_articulo      := v_cod_articulo;
						LR_movim.num_cantidad      := v_num_cantidad;
						LR_movim.nom_usuarora	   := USER;
						LR_movim.cod_plaza		   := LN_cod_plaza;
						--
						--
						LR_movim.tip_movimiento    := vs_sal_def_may;-- Salida Definitiva
						LR_movim.cod_bodega		   := v_cod_bodega_ori;

   					    BEGIN
							 v_paso := '(ETAPA1:TRASPASO)(INSERTAR EN AL_PAC_VALIDACIONES.P_INSERTA_MOVIM (LR_MOVIM)P1 )';
							 sSql := 'Al_Pac_Validaciones.p_inserta_movim  (LR_movim)P1';

   					    	 Al_Pac_Validaciones.p_inserta_movim  (LR_movim);

							 EXCEPTION WHEN OTHERS THEN
							 --VAR ='SALIDA';
							 ERRORCOD := '789';
							 RAISE ERR_INSERT_MOVIM;
						END;
						-------- Salida de series movim 3  -----------
--/* REQ_38808 C.A.A.D. 29-05-2007 INICIO
     				SELECT al_seq_mvto.nextval
     				INTO   LR_movim.num_movimiento
     				FROM DUAL;
     				LR_movim.tip_stock     := NVL(v_tip_stock_dest, v_tip_stock);
--/* REQ_38808 C.A.A.D. 29-05-2007 TERMINO

						-------- Entrada Extra Bodega Del Dealer v_cod_bodega_dest -----------
						LR_movim.tip_movimiento  := vs_ing_mer_may; -- Ingreso mercaderia
						LR_movim.cod_bodega		   := v_cod_bodega_dest;
						LR_movim.cod_plaza		   := LN_cod_plaza;
   						-- INSERTAR MOVIMIENTO
						BEGIN
							 v_paso := '(ETAPA1:TRASPASO)(INSERTAR EN AL_PAC_VALIDACIONES.P_INSERTA_MOVIM (LR_MOVIM)P2 )';
							 sSql := 'Al_Pac_Validaciones.p_inserta_movim  (LR_movim)P2';

   					    	 Al_Pac_Validaciones.p_inserta_movim  (LR_movim);

							 EXCEPTION WHEN OTHERS THEN
        					 --VAR ='ENTRADA';
							 ERRORCOD := '788';
        					 RAISE ERR_INSERT_MOVIM;
        				END;*/
-- fin cambio de movimientos de mayoristas, 44724, 25-10-2007
						-------- FIN Entrada Extra Bodega Del Dealer v_cod_bodega_dest -----------
     			   END IF;
	            ELSE
	               v_paso := '(ETAPA1:TRASPASO): ABRIR CURSOR SERIES PARA POBLAR TABLA DE TRASPASOS MASIVOS';
				   OPEN series (v_cod_pedido, v_lin_det_pedido);
	               LOOP
					  FETCH series INTO v_cod_pedido_ser,v_lin_det_pedido_ser,v_num_serie,LN_ind_telefono,
		  		   			  	   LN_num_telefono, LV_cod_subalm, LN_cod_central, LN_cod_cat, LN_carga, LV_plan, LN_cod_producto, LN_cod_plaza, LN_cod_hlr;
	                  EXIT WHEN series%NOTFOUND;

				      --FLAG_VIA_TRASPASO_SERIE = TRUE , SIGNIFICA QUE REALIZARA EL TRASAPASO DE SERIES
				      --SI ES FALSE, HARA EL TRASPASO DE SERIE VIA UNA ENTRADA/SALIDA EXTRA
select count(1)into cc from npt_estado_pedido where cod_pedido = v_cod_pedido;
dbms_output.put_line('-2 venta  :'||cc);
					  IF vs_via_traspa = cs_verdadero THEN
    	                  /* POBLAMIENTO DE LA TABLA AL_TRASPASOS_MASIVO NECESARIA PARA LOS TRASPASOS MASIVOS */
    					  v_paso := '(ETAPA1:TRASPASO)(INSERTAR TRASPASO MASIVO) NUM_TRASPASO= '||v_num_traspaso_masivo||'   SERIE= '||v_num_serie;
    	                  Al_Pac_Trasven_Web.insertar_traspaso_masivo ( v_num_traspaso_masivo, v_cod_estado_tras, v_num_traspaso,
    					                       						    v_cod_bodega_ori,v_cod_bodega_dest,v_tip_stock,v_cod_articulo,
    																	v_cod_uso,v_cod_estado,v_num_serie,v_usu_traspaso_masivo,1,
    																	v_cod_pedido,v_tip_stock_dest );
					  ELSE
					  	--ENTRADA/SALIDA EXTRA POR CADA SERIE.
             	   	    -- COlocar la zona para la entrada y salida extra.
             			--ENTRADA/SALIDA EXTRA SERIADOS

       				    --Obtener secuencia  de movimiento.
     					SELECT al_seq_mvto.nextval
     					INTO   LR_movim.num_movimiento
     					FROM DUAL;
  						-------- salida -----------

     					LR_movim.cod_articulo      := v_cod_articulo;
  						LR_movim.cod_estado        := v_cod_estado;
  						LR_movim.cod_uso           := v_cod_uso;
     					LR_movim.tip_stock         := v_tip_stock;
  						LR_movim.fec_movimiento    := sysdate;
  						LR_movim.cod_estadomov     := 'PR';
  						LR_movim.num_serie         := v_num_serie;
   						LR_movim.ind_telefono      := LN_ind_telefono;
   						LR_movim.num_telefono      := LN_num_telefono;
   						LR_movim.cod_central       := LN_cod_central;
   						LR_movim.cod_cat           := LN_cod_cat;
   						LR_movim.cod_subalm        := LV_cod_subalm;
   						LR_movim.cod_subalm_dest   := LV_cod_subalm;
   						LR_movim.cod_central_dest  := LN_cod_central;
   						LR_movim.cod_cat_dest      := LN_cod_cat;
   						LR_movim.carga         	   := LN_carga;
   						LR_movim.plan         	   := LV_plan;
   						LR_movim.cod_producto      := 1;
     					LR_movim.num_cantidad      := 1;
						LR_movim.nom_usuarora	   := USER;
						LR_movim.cod_plaza		   := LN_cod_plaza;
  						--
  						--
  						LR_movim.tip_movimiento    := vs_sal_def_may;-- Salida Definitiva
  						LR_movim.cod_bodega		   := v_cod_bodega_ori;
     						-- INSERTAR MOVIMIENTO
--  P-MIX-09003-Guatemala-Salvador
/*
   					    BEGIN
							 v_paso := '(ETAPA1:TRASPASO)(INSERTAR EN AL_PAC_VALIDACIONES.P_INSERTA_MOVIM (LR_MOVIM)P3 )';
							 sSql := 'Al_Pac_Validaciones.p_inserta_movim  (LR_movim)P3';

   					    	 Al_Pac_Validaciones.p_inserta_movim  (LR_movim);

							 EXCEPTION WHEN OTHERS THEN
							 --VAR ='SALIDA';
							 ERRORCOD := '787';
							 RAISE ERR_INSERT_MOVIM;
  						END;
*/
  						-------- Salida de series movim 3  -----------
  						-------- Entrada Extra Bodega Del Dealer v_cod_bodega_dest -----------

       				    --Obtener secuencia  de movimiento.
     					SELECT al_seq_mvto.nextval
     					INTO   LR_movim.num_movimiento
     					FROM DUAL;

  						LR_movim.tip_movimiento    := vs_ing_mer_may; -- Ingreso mercaderia
  						LR_movim.cod_bodega		   := v_cod_bodega_dest;
     					LR_movim.tip_stock         := v_tip_stock_dest;
						LR_movim.cod_hlr		   := LN_cod_hlr;

     						-- INSERTAR MOVIMIENTO
--  P-MIX-09003-Guatemala-Salvador
/*

  						BEGIN
							 v_paso := '(ETAPA1:TRASPASO)(INSERTAR EN AL_PAC_VALIDACIONES.P_INSERTA_MOVIM (LR_MOVIM)P4 )';
							 sSql := 'Al_Pac_Validaciones.p_inserta_movim  (LR_movim)P4';

     					     Al_Pac_Validaciones.p_inserta_movim  (LR_movim);

  							 EXCEPTION WHEN OTHERS THEN
  							 --VAR ='ENTRADA';
							 ERRORCOD := '786';
  							 RAISE ERR_INSERT_MOVIM;
  						END;
*/
  						-------- FIN Entrada Extra Bodega Del Dealer v_cod_bodega_dest -----------
					  END IF;
        	      END LOOP;
    	          CLOSE series;
				END IF;
	            v_cod_bodega_ori_aux := v_cod_bodega_ori;
	            v_cod_bodega_dest_aux := v_cod_bodega_dest;
	            v_tip_stock := v_tip_stock_aux;
	            v_cod_pedido_aux := v_cod_pedido;

-- Inicio 44724. Se cambia ya que en un pedido pueden existir líneas de artículos seriados y no seriados, ZMH 25-10-2007
		     --IF (v_cod_uso = 2 AND v_tip_stock_dest = v_stock_mercaderia_dealer) OR LN_mayorista = 1 THEN
             IF (v_tip_stock_dest = v_stock_mercaderia_dealer) OR LN_mayorista = 1 THEN
			 	 UPDATE npt_detalle_pedido
				    SET tip_stock = v_tip_stock_dest
					WHERE cod_pedido = v_cod_pedido
                                        and LIN_DET_PEDIDO = v_lin_det_pedido;
		     END IF;
-- fin 44724.

	         END LOOP;
	         CLOSE detalle;
select count(1)into cc from npt_estado_pedido where cod_pedido = v_cod_pedido;
dbms_output.put_line('-1 venta  :'||cc);
			 IF vs_via_traspa = cs_verdadero THEN
				 v_paso := '(ETAPA1:TRASPASO)(PL TRATAMIENTO MASIVO WEB) NUM_TRASPASO= '||v_num_traspaso_masivo||'  PEDIDO= '||v_cod_pedido ;
				 P_Al_Tratamiento_Masivo_Web (v_num_traspaso_masivo,v_cod_pedido,v_errores,v_err_pedido );
				 IF v_err_pedido <> 0 THEN
					v_existe_error_tras := 0;
					RAISE error_Tratamiento_Masivo;
		         END IF;
			 END IF;
                 select count(1)into cc from npt_estado_pedido where cod_pedido = v_cod_pedido;
dbms_output.put_line('0 venta  :'||cc);
			-- IF (v_tip_doc_pedido = 2 OR v_tip_doc_pedido = 6 OR v_tip_doc_pedido = 7 ) THEN
             IF (v_tip_doc_pedido = 2 OR v_tip_doc_pedido = 7 ) THEN
			    v_paso := '(ETAPA1:TRASPASO)(INSERTA ESTADO DE TRASPASO)  PEDIDO=' ||v_cod_pedido ||'  USUARIO= '||
				            v_cod_usuario ||'  USUARIO_ING='|| v_cod_usuario_ing  ||'  NUM_TRASPASO='||v_num_traspaso_masivo;

                  DBMS_OUTPUT.PUT_LINE ( 'v_paso = ' || v_paso );
	            P_Np_Insert_Estado_Traspaso (v_cod_pedido,v_cod_usuario,v_cod_usuario_ing,v_num_traspaso_masivo,v_err );

	         END IF;
	         IF v_err<>0 THEN
	            v_errores.cod_pedido := v_cod_pedido;
	            v_errores.fec_error := SYSDATE;
	            v_errores.glosa_error_traspaso := 'ERROR EN RETORNO DE P_Np_Insert_Estado_Traspaso ' || TO_CHAR(v_err);
	            v_errores.cod_estado_error :='PR';
	            RAISE error_proceso_general;
	         END IF;  /* SE A?ADE CONTROL DE ERROR*/

			 v_paso:='(ETAPA1:TRASPASO)(ACTUALIZA TIPO STOCK EN NPT_DETALLE_PEDIDO: Uso='||v_cod_uso||'  TipoSotck= '||v_tip_stock_dest;


             /* Esto se debe llevar a un pl aparte  */  /* Usado para post pago  */

              ---Para mayorista se cambia el tipo stock -----------------------------

/*  esto quedo en el detalle del pedido, unas líneas arriba, 44724 25-10-2007  ZMH
             IF (v_cod_uso = 2 AND v_tip_stock_dest = v_stock_mercaderia_dealer) OR LN_mayorista = 1 THEN
                  UPDATE npt_detalle_pedido
                    SET tip_stock = v_tip_stock_dest
                    WHERE cod_pedido = v_cod_pedido;
             END IF;
*/

             v_num_serie := NULL;
              UPDATE npt_pedido
             SET    ind_traspaso = LI_tipo_traspaso
             WHERE  cod_pedido = v_cod_pedido;
         END IF;
        /* FINALIZA RUTINA DE TRASPASO  */
        --
      END IF;
--      END;
      --COMMIT;
            select num_doc_pedido into cc from npt_pedido where cod_pedido = v_cod_pedido;
            dbms_output.put_line('1 venta  :'||cc);
/* ------------------COMIENZA RUTINA DE VENTA-------------------------------------------------------*/
   IF v_siguiente_registro = 0 THEN
 --     BEGIN
         v_paso := '(ETAPA2 VENTA): COMIENZA RUTINA DE VENTA';
         IF v_existe_error_tras = 0 THEN
            v_errores.cod_pedido := v_cod_pedido;
            v_errores.fec_error := SYSDATE;
            v_errores.glosa_error_traspaso := 'ERROR v_existe_error_tras = 0';
            v_errores.cod_estado_error :='PR';
            RAISE error_proceso_general;
         END IF;
         IF v_tip_doc_pedido = 1 OR v_tip_doc_pedido = 3 OR v_tip_doc_pedido = 4 OR v_tip_doc_pedido = 5 OR v_tip_doc_pedido = 6 THEN
            v_ind_equiacc_aux := NULL;
            v_ind_equiacc := NULL;
         ELSE
            v_errores.cod_pedido := v_cod_pedido;
            v_errores.fec_error := SYSDATE;
            v_errores.glosa_error_traspaso := 'ERROR v_tip_doc_pedido = 1 OR v_tip_doc_pedido = 3 OR v_tip_doc_pedido = 4 OR v_tip_doc_pedido = 5 falso';
            v_errores.cod_estado_error :='PR';
            RAISE error_proceso_general;
         END IF;
         OPEN articulo (v_cod_pedido);
         LOOP
            FETCH articulo INTO v_cod_articulo2;
            v_paso := '(ETAPA2 VENTA)(PASO1:ABRE CURSOR ARTICULO): ARTICULO= '|| v_cod_articulo2;
            EXIT WHEN articulo%NOTFOUND;
            v_paso := '(ETAPA2 VENTA)(PASO1 VALIDACION ART_ACC EN MISMO PEDIDO): COD_ARTICULO= '||v_cod_articulo2||'  IND_EQUIACC_AUX:' ||v_ind_equiacc;
            v_ind_equiacc_aux := v_ind_equiacc;

            SELECT ind_equiacc
            INTO v_ind_equiacc
            FROM al_articulos
            WHERE cod_articulo = v_cod_articulo2;
            v_paso := '(ETAPA2 VENTA)(PASO1 VALIDACION ART_ACC EN MISMO PEDIDO):
                      obtener ind_equiacc para articulo= ' ||v_cod_articulo2;

            IF v_ind_equiacc IS NULL THEN
               v_errores.cod_pedido := v_cod_pedido;
               v_errores.fec_error := SYSDATE;
               v_errores.glosa_error_traspaso := 'ERROR '||v_paso;
               v_errores.cod_estado_error :='PR';
               RAISE error_proceso_general;
            END IF;

            IF  v_ind_equiacc_aux <> v_ind_equiacc AND v_ind_equiacc_aux IS NOT NULL THEN
                v_paso := '(ETAPA2 VENTA)(PASO1 VALIDACION ART_ACC EN MISMO PEDIDO)(ARTICULO-ACCESORIO MISMO PEDIDO):
                          v_ind_equiacc= ' ||v_ind_equiacc || '  v_ind_equiacc_aux=' ||v_ind_equiacc_aux;
                v_errores.cod_pedido := v_cod_pedido;
                v_errores.fec_error := SYSDATE;
                v_errores.glosa_error_traspaso := 'ERROR VALIDACION ART_ACC EN MISMO PEDIDO)(ARTICULO-ACCESORIO MISMO PEDIDO';
                v_errores.cod_estado_error :='PR';
                RAISE error_proceso_general;
            END IF;
         END LOOP;
         CLOSE articulo;
         v_paso := '(ETAPA2 VENTA)(PASO2 DATOS PARA AL_VENTAS): OBTENER USUARIO DE PSD_USUARIO PARA USUARIO= '||v_cod_usuario;
         P_Np_Sacar_Usuario (v_cod_usuario, v_usu_traspaso_masivo, v_err2);
         IF v_err2 <> 0 THEN
            v_errores.cod_pedido := v_cod_pedido;
            v_errores.fec_error := SYSDATE;
            v_errores.glosa_error_traspaso := 'ERROR DE RETORNO EN P_Np_Sacar_Usuario ' || TO_CHAR(v_err2);
            v_errores.glosa_error_venta := SQLERRM;
            v_errores.cod_estado_error :='PR';
            v_errores.num_venta := v_venta.num_venta;
            RAISE error_proceso_general;
         ELSE
            v_paso:='(ETAPA2 VENTA)(PASO2 DATOS PARA AL_VENTAS): OBTENER TIPO DE DOCUMENTO';
            SELECT cod_docguia, cod_docboleta INTO v_doc_guia, v_doc_boleta FROM ga_datosgener;
            IF v_tip_doc_pedido = 1 OR v_tip_doc_pedido = 6 OR v_tip_doc_pedido = 3 THEN
               v_venta.cod_tipdocum := v_doc_guia;
            ELSE
               IF v_tip_doc_pedido = 4 OR v_tip_doc_pedido = 5 THEN
                  v_venta.cod_tipdocum := v_doc_boleta;
               END IF;
            END IF;
            /* foliacion */ /*ge_tipdocumen.tip_foliacion (P, A) Prefoliado Autofoliado*/
            v_paso:='(ETAPA2 VENTA)(PASO2 DATOS PARA AL_VENTAS): OBTENER TIPO DE FOLIACION PARA TIPO DOCUMENTO= '||v_venta.cod_tipdocum;
            SELECT tip_foliacion INTO vf_tip_foliacion
               FROM ge_tipdocumen
               WHERE cod_tipdocum = v_venta.cod_tipdocum;
             v_venta.tip_foliacion := vf_tip_foliacion;
            /* fin */

            /* TRATAMIENTO DE POBLAMIENTO DE LA TABLA AL_VENTAS NECESARIA PARA LA VENTA MASIVA */
            SELECT ga_seq_venta.NEXTVAL INTO v_venta.num_venta FROM dual;

            v_paso:='(ETAPA2 VENTA)(PASO2 DATOS PARA AL_VENTAS): OBTENER OFICINA DEL VENDEDOR AUTORIZADO ';
            BEGIN
/*
                 SELECT a.cod_oficina, a.cod_tipcomis,  a.cod_vendedor, a.cod_vende_raiz
                 INTO v_venta.cod_oficina,  v_venta.cod_tipcomis,v_venta.cod_vendedor, v_venta.cod_vendedor_agente
                 FROM ve_vendedores a, npt_pedido b
                 WHERE a.cod_vendedor = b.cod_vendedor and b.cod_pedido = v_cod_pedido;

            EXCEPTION
                WHEN NO_DATA_FOUND THEN
*/
            SELECT cod_oficina INTO v_venta.cod_oficina
               FROM ge_oficinas
               WHERE cod_oficina = (SELECT a.cod_oficina
                                    FROM ve_vendedores a, al_datos_generales b
                                    WHERE a.cod_vendedor = b.cod_vendedor_web);

            v_paso:='(ETAPA2 VENTA)(PASO2 DATOS PARA AL_VENTAS): OBTENER TIPO COMISIONISTA DEL VENDEDOR AUTORIZADO';
            SELECT cod_tipcomis INTO v_venta.cod_tipcomis
              FROM ve_tipcomis
             WHERE cod_tipcomis = (SELECT a.cod_tipcomis
                                     FROM ve_vendedores a, al_datos_generales b
                                     WHERE a.cod_vendedor = b.cod_vendedor_web);

            /*  SELECCIONA PARAMETRO DE TIPO DE VENTA */
             v_paso:='(ETAPA2 VENTA)(PASO2 DATOS PARA AL_VENTAS): OBTIENE TIPO DE VENTA (npt_parametro)';
             SELECT TO_NUMBER(VALOR_PARAMETRO) INTO v_tipo_venta FROM npt_parametro
             WHERE ALIAS_PARAMETRO = 'TIPO_VENTA';

            /*  SELECCIONA VENDEDOR Y VENDEDOR AGENTE */
            v_paso:='(ETAPA2 VENTA)(PASO2 DATOS PARA AL_VENTAS): OBTENER VENDEDOR Y VENDEDOR AGENTE';
            SELECT cod_vendedor, cod_vende_raiz INTO v_venta.cod_vendedor, v_venta.cod_vendedor_agente
               FROM ve_vendedores
               WHERE cod_oficina = v_venta.cod_oficina
               AND cod_tipcomis = v_venta.cod_tipcomis
               AND SYSDATE BETWEEN fec_contrato
               AND NVL (fec_fincontrato, SYSDATE)
               AND ind_tipventa = v_tipo_venta
               AND cod_vendedor = (SELECT cod_vendedor_web FROM al_datos_generales);
              END;
            /* SELECCIONA UBICACION DEL CLIENTE */
            v_paso:='(ETAPA2 VENTA)(PASO2 DATOS PARA AL_VENTAS): OBTENER UBICACION DEL CLIENTE';
            SELECT b.cod_region, b.cod_provincia, b.cod_ciudad
               INTO v_venta.cod_region, v_venta.cod_provincia, v_venta.cod_ciudad
               FROM ge_oficinas a, ge_direcciones b
               WHERE a.cod_oficina = v_venta.cod_oficina
               AND b.cod_direccion = a.cod_direccion;

            /* SELECCIONA CUENTA DEL CLIENTE */
            v_paso:='(ETAPA2 VENTA)(PASO2 DATOS PARA AL_VENTAS): OBTENER CUENTA';
            SELECT cod_cuenta INTO v_venta.cod_cuenta
               FROM ge_clientes
               WHERE cod_cliente = v_cod_cliente;
            /* SELECCIONA MODALIDAD DE VENTA */
            v_paso:='(ETAPA2 VENTA)(PASO2 DATOS PARA AL_VENTAS): ASIGNAR MODALIDAD DE VENTA';
            IF ( v_tip_doc_pedido = 6 OR v_tip_doc_pedido = 1 OR v_tip_doc_pedido = 4 ) AND v_ind_equiacc = 'E' THEN
               v_venta.cod_modventa := 9;
            ELSE
               IF (v_tip_doc_pedido = 1 OR v_tip_doc_pedido = 4 ) AND v_ind_equiacc = 'A' THEN
                  v_venta.cod_modventa := 1;
               ELSE
                  IF v_tip_doc_pedido = 3 OR v_tip_doc_pedido = 5 THEN
                     v_venta.cod_modventa := 5;
                  END IF;
               END IF;
            END IF;
                        select num_doc_pedido into cc from npt_pedido where cod_pedido = v_cod_pedido;
            dbms_output.put_line('2 venta  :'||cc);
            v_venta.cod_estado := 'PW';
            v_venta.cod_producto := 1;
            v_venta.num_unidades := v_can_total_pedido;
            v_venta.ind_venta := 'V';
            v_venta.fec_venta := SYSDATE;
            v_venta.ind_estventa := 'AC';
            v_venta.num_transaccion := -1;
            v_venta.ind_tipventa := 1;
            v_venta.cod_cliente := v_cod_cliente;
            v_venta.nom_usuar_vta := v_nom_usuario_web;
            v_venta.nom_usuaproc := v_nom_usuario_web;
            v_venta.fec_proceso := SYSDATE;
            v_venta.fec_aceprec := SYSDATE;
            v_venta.ind_activacion := 0;
            v_venta.cod_pedido := v_cod_pedido;
            v_venta.tip_valor := 1;
            v_venta.tip_venta := 'W';

            /* ge_tipdocumen.tip_foliacion (P, A) Prefoliado Autofoliado (si es P ejecuta funciones de reserva y consumo de folio*/
            IF vf_tip_foliacion = 'P' THEN
               v_paso:='(ETAPA2 VENTA)(PASO2 DATOS PARA AL_VENTAS)(DOC PREFOLIADO) OBTENER OPERADORA PARA CLIENTE= '||v_venta.cod_cliente;
               vf_codigo_operadora  :=Fn_Obtiene_Opercliente (v_venta.cod_cliente);
               v_venta.cod_operadora := vf_codigo_operadora;
               vf_consulta_foliacion:=Fa_Foliacion_Pg.fa_consulta_folio_fn(v_venta.cod_tipdocum,v_venta.cod_vendedor,
                                                       v_venta.cod_oficina,vf_codigo_operadora,NULL,NULL,NULL,2);
            select num_doc_pedido into cc from npt_pedido where cod_pedido = v_cod_pedido;
            dbms_output.put_line('3 venta  :'||cc);
               IF SUBSTR (vf_consulta_foliacion, 1, 1) != 1 THEN
                  v_paso:='(ETAPA2 VENTA)(PASO2 DATOS PARA AL_VENTAS)(DOC PREFOLIADO) ERROR AL CONSULTAR FOLIO PARA TIP_DOCUMENTO= '||v_venta.cod_tipdocum;
                      v_errores.cod_pedido := v_cod_pedido;
                      v_errores.fec_error := SYSDATE;
                      v_errores.glosa_error_traspaso := 'ERROR AL CONSULTAR FOLIO PARA TIP_DOCUMENTO= '||v_venta.cod_tipdocum;
                      v_errores.cod_estado_error :='PR';
                      v_errores.num_venta := v_venta.num_venta;
                  RAISE error_proceso_general;
               END IF;
               v_venta.num_folio :=trim (SUBSTR (vf_consulta_foliacion,INSTR (SUBSTR (vf_consulta_foliacion, 3), ';') + 3 ) );
               v_venta.pref_plaza :=trim (SUBSTR (vf_consulta_foliacion,3,INSTR (SUBSTR (vf_consulta_foliacion, 3), ';')- 1));
            END IF;

            v_paso:='(ETAPA2 VENTA)(PASO3 AL_VENTAS)(INSERTAR AL_VENTAS) VENTA= '||v_venta.num_venta;
            Al_Pac_Trasven_Web.insertar_al_ventas (v_venta);
            v_num_serie := NULL;
            v_paso:='(ETAPA2 VENTA)(PASO4 DETALLE): PEDIDO= ' ||v_cod_pedido;
                        select num_doc_pedido into cc from npt_pedido where cod_pedido = v_cod_pedido;
            dbms_output.put_line('4 venta  :'||cc);
            OPEN detalle (v_cod_pedido);
            LOOP
               FETCH detalle INTO v_cod_pedido_det,v_lin_det_pedido,v_cod_bodega_ori,v_tip_stock,v_cod_articulo,
                                  v_cod_uso,v_cod_estado,v_num_cantidad,v_mto_uni_det_pedido,v_mto_des_det_pedido,
                                  v_cod_tecnologia, v_ptj_des_det_pedido, v_det_ind_equiacc, v_det_tip_terminal;
               EXIT WHEN detalle%NOTFOUND;
               v_paso:='(ETAPA2 VENTA)(PASO4 DETALLE): OBTENER IND_SERIADO PARA ARTICULO= '||v_cod_articulo;
               SELECT ind_seriado INTO v_ind_seriado
                 FROM al_articulos
                 WHERE cod_articulo = v_cod_articulo;
               IF v_ind_seriado IS NULL THEN
                  v_paso:='(ETAPA2 VENTA)(PASO4 DETALLE): IND_SERIADO NO ENCONTRADO';
                  v_errores.cod_pedido := v_cod_pedido;
                  v_errores.fec_error := SYSDATE;
                  v_errores.glosa_error_traspaso := 'ERROR IND_SERIADO NO ENCONTRADO';
                  v_errores.cod_estado_error :='PR';
                  v_errores.num_venta := v_venta.num_venta;
                  RAISE error_proceso_general;
               END IF;
               v_dcto := v_num_cantidad * v_mto_uni_det_pedido * v_ptj_des_det_pedido / 100;
               -- INICIO ECU_05010
                  v_sumatoria_mtocargo := 0;
                  v_sumatoria_descuento:= 0;
                    v_paso:='(ETAPA2 VENTA)(PASO4 DETALLE): OBTENER PLAN COMERCIAL DE CLIENTE: '||v_cod_cliente;
                  SELECT cod_plancom INTO v_cargo.cod_plancom
                  FROM ga_cliente_pcom
                  WHERE cod_cliente = v_cod_cliente
                  AND SYSDATE BETWEEN FEC_DESDE AND FEC_HASTA;

                  IF v_valparametro86 = 'TRUE' THEN
                     v_cargo.cod_cliente        := v_venta.cod_cliente;
                     v_cargo.fec_alta           := SYSDATE;
                     v_cargo.cod_moneda         := '001';
                     v_cargo.ind_factur         := 1;
                     v_cargo.num_transaccion    := -1;
                     v_cargo.mes_garantia       := 0;
                     v_cargo.num_abonado        := 0;
                     v_cargo.num_serie            := 0;
                     v_cargo.tip_dto            := 0;
                     v_cargo.num_venta          := v_venta.num_venta;
                     v_cargo.num_unidades       := v_num_cantidad;
                     v_cargo.cod_bodega         := v_cod_bodega_dest;
                     v_cargo.tip_stock          := v_tip_stock;
                     v_cargo.cod_articulo       := v_cod_articulo;
                     v_cargo.cod_uso            := v_cod_uso;
                     v_cargo.cod_estado         := v_cod_estado;
                     v_cargo.cod_tecnologia     := v_cod_tecnologia;
                     v_paso:='(ETAPA2 VENTA)(PASO4 DETALLE): DETALLE CARGO: PEDIDO ['||v_cod_pedido || '] LINEA [' ||v_lin_det_pedido ||']' ;
                     sum_car_ocasi := 0;
                     FOR regDetalleCargo IN CURSOR_DETALLE_CARGO  (v_cod_pedido,
                                                                   v_lin_det_pedido,
                                                                   v_valparametro90actabo,
                                                                   v_valparametro89tipservicio)
                     LOOP
                         SELECT ge_seq_cargos.NEXTVAL INTO v_cargo.num_cargo FROM dual;
                         v_cargo.cod_producto    := regdetallecargo.cod_producto;
                         v_cargo.cod_concepto    := regdetallecargo.cod_concorig;
                         v_cargo.imp_cargo       := regdetallecargo.mto_cargo;
/* XO-200510070821 Se almacena la sumatoria de los cargos ocasionales */
                         sum_car_ocasi             := sum_car_ocasi + v_cargo.imp_cargo;
/* XO-200510070821 Se almacena la sumatoria de los cargos ocasionales */
                         IF (v_ptj_des_det_pedido IS NULL) OR (v_ptj_des_det_pedido = 0) THEN
                             v_cargo.val_dto         := 0;
                            v_cargo.cod_concepto_dto:= NULL;
                         ELSE
                            v_cargo.cod_concepto_dto:= regdetallecargo.cod_concepto;
/* XO-200510070821 Se incorporan la cantidad de unidades al monto del descuento */
                            v_cargo.val_dto         := (regdetallecargo.mto_cargo * v_ptj_des_det_pedido/100) * v_num_cantidad;
/* XO-200510070821 Se incorporan la cantidad de unidades al monto del descuento */
                         END IF;
                         v_sumatoria_mtocargo := v_sumatoria_mtocargo +   regdetallecargo.mto_cargo;
                         v_sumatoria_descuento:= v_sumatoria_descuento +  v_cargo.val_dto;
/*JAMB 201469*/
   v_flag:=1;

   


                           Al_Pac_Trasven_Web.insertar_al_cargos (v_cargo);
                           
                           
                     END LOOP;
                  END IF;
                              select num_doc_pedido into cc from npt_pedido where cod_pedido = v_cod_pedido;
            dbms_output.put_line('5 venta  :'||cc);
               -- FIN INICIO ECU_05010
               IF v_ind_seriado = 1  THEN
                  v_paso:='(ETAPA2 VENTA)(PASO4 DETALLE)(PROCESO PARA ARTICULOS SERIADOS)';
                  v_realiza_venta := 0;

                  /*---Solo para mayorista se cambia el tipo stock para realizar la busqueda

                          IF LN_mayorista = 1 THEN
                               v_tip_stock := CN_stock_mercaderia;
                          END IF;*/

                  --------------------------------------------------------------------------

                  OPEN series (v_cod_pedido, v_lin_det_pedido);
                  LOOP
                     FETCH series INTO v_cod_pedido_ser,v_lin_det_pedido_ser,v_num_serie,LN_ind_telefono,
                                          LN_num_telefono, LV_cod_subalm, LN_cod_central, LN_cod_cat, LN_carga, LV_plan, LN_cod_producto, LN_cod_plaza, LN_cod_hlr;

                     EXIT WHEN series%NOTFOUND;
                     v_paso:='(ETAPA2 VENTA)(PASO5 SERIE): BUSCAR SERIE PARA PEDIDO ='||v_cod_pedido_ser||',   LINEA_DET_PEDIDO= '||v_lin_det_pedido_ser||',   SERIE= '||v_num_serie;
                     SELECT COUNT (1) INTO v_realiza_venta
                       FROM (SELECT 1
                               FROM al_series a
                               WHERE a.num_serie = v_num_serie
                               AND a.cod_bodega = v_cod_bodega_dest
                               AND a.cod_articulo = v_cod_articulo
                               AND a.tip_stock = v_tip_stock
                               AND EXISTS ( SELECT 1
                                            FROM ged_parametros
                                            WHERE (nom_parametro LIKE 'USO_PREPAGO%' OR nom_parametro LIKE 'COD_USO_VENTA%')
                                            AND val_parametro = TO_CHAR (a.cod_uso)) /* GSM*/
                               AND a.cod_estado = v_cod_estado
                               AND ROWNUM = 1);
                                          v_paso:='(ETAPA2 VENTA)(PASO5 SERIE):NO SE ENCUENTRA SERIE PARA SERIE= '||v_num_serie||
                                ',  BODEGA= '||v_cod_bodega_dest||',  ARTICULO= '||v_cod_articulo||',  TIPSTOCK='||v_tip_stock||',  PEDIDO='||v_cod_pedido;
                        --v_paso:='serie='||v_num_serie||' ,pedido='||v_cod_pedido;
                        dbms_output.put_line(v_paso);
                     IF v_realiza_venta = 0 THEN

                        v_errores.cod_pedido := v_cod_pedido;
                        v_errores.fec_error := SYSDATE;
                        v_errores.glosa_error_traspaso := 'NO SE ENCUENTRA SERIE PARA SERIE= '||v_num_serie;
                        v_errores.cod_estado_error :='PR';
                        v_errores.num_venta := v_venta.num_venta;
                        RAISE error_proceso_general;
                     END IF;
                  END LOOP;
                  CLOSE series; /* OPEN series (v_cod_pedido, v_lin_det_pedido);  */
               END IF;
                           select num_doc_pedido into cc from npt_pedido where cod_pedido = v_cod_pedido;
               dbms_output.put_line('6 venta  :'||cc);
               IF v_ind_seriado <> 1 THEN
                  v_paso:='(ETAPA2 VENTA)(PASO4 DETALLE)(PROCESO PARA ARTICULOS NO SERIADO)';
                  v_realiza_venta := 1;
                  v_cargo.num_serie := NULL;
                  SELECT ge_seq_cargos.NEXTVAL INTO v_cargo.num_cargo FROM dual;
                  v_paso:='(ETAPA2 VENTA)(PASO4 DETALLE)(NO SERIADOS): OBTENER EQUIACC,CONCEPTO ART,CONCEPTO DTO PARA ARTICULO: '||v_cod_articulo;
                  SELECT ind_equiacc, cod_conceptoart, cod_conceptodto
                    INTO v_ind_equiacc, v_cargo.cod_concepto, v_cargo.cod_concepto_dto
                    FROM al_articulos
                    WHERE cod_articulo = v_cod_articulo;
                  IF v_ind_equiacc IS NULL THEN
                     v_paso:='(ETAPA2 VENTA)(PASO4 DETALLE)(NO SERIADOS): IND_EQUIACC,CONCEPTO_ART,CONCEPTO_DTO. NO ENCONTRADOS PARA ARTICULO= '||v_cod_articulo;
                     v_errores.cod_pedido := v_cod_pedido;
                     v_errores.fec_error := SYSDATE;
                     v_errores.glosa_error_traspaso := 'IND_EQUIACC,CONCEPTO_ART,CONCEPTO_DTO. NO ENCONTRADOS PARA ARTICULO= '||v_cod_articulo;
                     v_errores.cod_estado_error :='PR';
                     v_errores.num_venta := v_venta.num_venta;
                     RAISE error_proceso_general;
                  END IF;
                  IF v_ind_equiacc = 'E' THEN
                     v_cargo.cod_producto := 1;
                  ELSE
                     v_cargo.cod_producto := 5;
                  END IF;

                  v_paso:='(ETAPA2 VENTA)(PASO4 DETALLE)(NO SERIADOS): OBTENER PLAN COMERCIAL DE CLIENTE: '||v_cod_cliente;
                  SELECT cod_plancom INTO v_cargo.cod_plancom
                    FROM ga_cliente_pcom
                    WHERE cod_cliente = v_cod_cliente
                    AND SYSDATE BETWEEN FEC_DESDE AND FEC_HASTA;

                  select num_doc_pedido into cc from npt_pedido where cod_pedido = v_cod_pedido;
                  dbms_output.put_line('7 venta  :'||cc);
                  v_cargo.cod_cliente := v_venta.cod_cliente;
                  v_cargo.fec_alta := SYSDATE;
                  --v_cargo.imp_cargo := v_mto_uni_det_pedido;  -- ECU_05010
                  v_cargo.imp_cargo := v_mto_uni_det_pedido - v_sumatoria_mtocargo;
                  v_cargo.cod_moneda := '001';
                  v_cargo.num_unidades := v_num_cantidad;
                  v_cargo.ind_factur := 1;
                  v_cargo.num_transaccion := -1;
                  v_cargo.num_venta := v_venta.num_venta;
                  v_cargo.mes_garantia := 0;
                  v_cargo.num_abonado := 0;
                  --v_cargo.val_dto := v_dcto * v_num_cantidad;
-- Incidencia: 38412

                  -- 31 Enero 2014 v_cargo.val_dto := v_mto_des_det_pedido * v_num_cantidad;
                  -- v_cargo.val_dto := v_mto_des_det_pedido;
                  v_cargo.val_dto := v_mto_des_det_pedido * v_num_cantidad;
                  v_flag:=2;
                  

  

                  IF (v_cargo.val_dto IS NULL) OR (v_cargo.val_dto = 0) THEN
                      v_cargo.val_dto         := 0;
                      v_cargo.cod_concepto_dto:= NULL;
                  ELSIF v_valparametro86 = 'TRUE' THEN
                      v_cargo.val_dto := v_cargo.val_dto - (sum_car_ocasi * v_num_cantidad * (v_ptj_des_det_pedido / 100));   -- ECU_05010
                      v_flag:=3;
                  END IF;

/*
-- XO-200510070821 Se incorporan la cantidad de unidades al monto del descuento
                     IF (v_ptj_des_det_pedido IS NULL) OR (v_ptj_des_det_pedido = 0) THEN
                      v_cargo.val_dto         := 0;
                      v_cargo.cod_concepto_dto:= NULL;
                  ELSIF v_valparametro86 = 'TRUE' THEN
                      v_cargo.val_dto := v_dcto - (sum_car_ocasi * v_num_cantidad * (v_ptj_des_det_pedido / 100));   -- ECU_05010
                  ELSE
                      v_cargo.val_dto := v_dcto;   -- ECU_05010
                  END IF;
-- XO-200510070821 Se incorporan la cantidad de unidades al monto del descuento
*/
-- Fin Incidencia 38412
                  v_cargo.tip_dto := 0;
                  v_cargo.cod_bodega := v_cod_bodega_dest;
                  v_cargo.tip_stock := v_tip_stock;
                  v_cargo.cod_articulo := v_cod_articulo;
                  v_cargo.cod_uso := v_cod_uso;
                  v_cargo.cod_estado := v_cod_estado;
                  v_cargo.cod_tecnologia:= v_cod_tecnologia;
                     Al_Pac_Trasven_Web.insertar_al_cargos (v_cargo);
               ELSE   /* v_ind_seriado = 1  */
                     OPEN series_conceptos (v_cod_pedido, v_lin_det_pedido);
                     LOOP
                        FETCH series_conceptos INTO v_mto_uni_det_pedido, v_dcto, v_cod_articulo, v_cantidad;
                        EXIT WHEN series_conceptos%NOTFOUND;
                        v_paso:='(ETAPA2 VENTA)(PASO4 DETALLE)(ART.SERIADO): ABRIR CURSOR SERIES-CONCEPTOS';
                        v_cargo.num_terminal := NULL;
                        v_cargo.cod_subalm := NULL;
                        v_cargo.cod_central := NULL;
                        v_cargo.cod_cat := NULL;
                        v_cargo.ind_telefono := NULL;
                        v_cargo.num_serie := 0;
                        /* POBLAMIENTO DE LA TABLA AL_CARGOS NECESARIA PARA LA VENTA MASIVA */
                        SELECT ge_seq_cargos.NEXTVAL INTO v_cargo.num_cargo FROM dual;

                        v_paso:='(ETAPA2 VENTA)(PASO4 DETALLE)(ART.SERIADO)(DATOS PARA AL_CARGOS): OBTENER IND_EQUIACC,CONCEPTO_ART,CONCEPTO_DTO';
                        SELECT ind_equiacc, cod_conceptoart, cod_conceptodto
                          INTO v_ind_equiacc, v_cargo.cod_concepto, v_cargo.cod_concepto_dto
                          FROM al_articulos
                          WHERE cod_articulo = v_cod_articulo;
                        IF v_ind_equiacc IS NULL THEN
                           v_errores.cod_pedido := v_cod_pedido;
                           v_errores.fec_error := SYSDATE;
                           v_errores.glosa_error_traspaso := 'v_ind_equiacc es nulo';
                           v_errores.cod_estado_error :='PR';
                           v_errores.num_venta := v_venta.num_venta;
                           RAISE error_proceso_general;
                        END IF;

                        IF v_ind_equiacc = 'E' THEN
                           v_cargo.cod_producto := 1;
                        ELSE
                           v_cargo.cod_producto := 5;
                        END IF;

                        v_paso:='(ETAPA2 VENTA)(PASO4 DETALLE)(ART.SERIADO)(DATOS PARA AL_CARGOS): OBTENER PLAN COMERCIAL DE CLIENTE= '||v_cod_cliente;
                        SELECT cod_plancom INTO v_cargo.cod_plancom
                          FROM ga_cliente_pcom
                            WHERE cod_cliente = v_cod_cliente
                        AND SYSDATE BETWEEN FEC_DESDE AND FEC_HASTA;

                        v_cargo.cod_cliente := v_venta.cod_cliente;
                        v_cargo.fec_alta := SYSDATE;
                        --v_cargo.imp_cargo := v_mto_uni_det_pedido;  ECU_05010
                        v_cargo.imp_cargo := v_mto_uni_det_pedido - v_sumatoria_mtocargo;
                        v_cargo.cod_moneda := '001';
                        v_cargo.num_unidades := v_cantidad;
                        v_cargo.ind_factur := 1;
                        v_cargo.num_transaccion := -1;
                        v_cargo.num_venta := v_venta.num_venta;
                        v_cargo.mes_garantia := 0;
                        v_cargo.num_abonado := 0;
--                      v_cargo.val_dto := v_dcto * v_num_cantidad;   ECU_05010
-- Incidencia: 38412

                          -- 31 ene 2014 v_cargo.val_dto := v_mto_des_det_pedido * v_num_cantidad;
                          v_cargo.val_dto := ((v_cargo.imp_cargo * v_num_cantidad ) * (v_ptj_des_det_pedido / 100));
                          v_val_dto1 := v_cargo.val_dto;
                          v_flag:=4;

   
                  
                          IF (v_cargo.val_dto IS NULL) OR (v_cargo.val_dto = 0) THEN
                              v_cargo.val_dto         := 0;
                              v_cargo.cod_concepto_dto:= NULL;
                          ELSIF v_valparametro86 = 'TRUE' THEN
                              v_cargo.val_dto := v_cargo.val_dto - (sum_car_ocasi * v_num_cantidad * (v_ptj_des_det_pedido / 100));   -- ECU_05010
                              v_flag:=5;
                      
                         END IF;
/*
-- XO-200510070821 Se incorporan la cantidad de unidades al monto del descuento
                              IF (v_ptj_des_det_pedido IS NULL) OR (v_ptj_des_det_pedido = 0) THEN
                            v_cargo.val_dto         := 0;
                            v_cargo.cod_concepto_dto:= NULL;
                        ELSIF v_valparametro86 = 'TRUE' THEN
-- CO-200605050103 Cambio en la cantidad de artículos que se graban en la tabla ga_cargos
                            v_cargo.val_dto := v_dcto - (sum_car_ocasi * v_cantidad * (v_ptj_des_det_pedido / 100));   -- ECU_05010
--                            v_cargo.val_dto := v_dcto - (sum_car_ocasi * v_num_cantidad * (v_ptj_des_det_pedido / 100));   -- ECU_05010
                        ELSE
                            v_cargo.val_dto := v_cantidad * v_mto_uni_det_pedido * v_ptj_des_det_pedido / 100;
                        END IF;
-- XO-200510070821 Se incorporan la cantidad de unidades al monto del descuento
*/
-- Fin Incidencia 38412
                        v_cargo.tip_dto := 0;
                        v_cargo.cod_bodega := v_cod_bodega_dest;
                        v_cargo.tip_stock := v_tip_stock;
                        v_cargo.cod_articulo := v_cod_articulo;
                        v_cargo.cod_uso := v_cod_uso;
                        v_cargo.cod_estado := v_cod_estado;
                        v_cargo.cod_tecnologia:= v_cod_tecnologia;
                        v_paso:='(ETAPA2 VENTA)(PASO4 DETALLE)(ART.SERIADO)(INSERTAR AL_CARGOS) CARGO= '||v_cargo.num_cargo;

                        /*JAMB 201469*/
                        

                        Al_Pac_Trasven_Web.insertar_al_cargos (v_cargo);
                           
                     END LOOP;
                     CLOSE series_conceptos;
               END IF;
            END LOOP;
            CLOSE detalle;
         END IF;
         
         select num_doc_pedido into cc from npt_pedido where cod_pedido = v_cod_pedido;
         dbms_output.put_line('8 venta  :'||cc);
         v_paso:='(ETAPA2 VENTA)(PASO6 VERIFICACION PARA REALIZAR PROCESO VENTA)';
         IF v_realiza_venta <> 0 THEN   /*   SE EJECUTA PL DE VENTAS  */
         dbms_output.PUT_LINE('p19');
            v_paso:='(ETAPA2:VENTA)(PASO7:REALIZA VENTA)  realiza_venta= '||v_realiza_venta;
            SELECT fa_seq_numpro.NEXTVAL INTO vf_num_proceso FROM dual;
            IF vf_tip_foliacion = 'P' THEN  /* funcion de consumo de folio:  se debe validar que sea igual la consulta y el consumo  */
               v_paso :='(ETAPA2:VENTA)(PASO7:REALIZA VENTA): OBTENER OPERADORA DE CLIENTE= '||v_venta.cod_cliente;
               vf_codigo_operadora := Fn_Obtiene_Opercliente (v_venta.cod_cliente);
               v_paso :='(ETAPA2:VENTA)(PASO7:REALIZA VENTA)(CONSUME FOLIO): TIP_DOCUMENTO= '||v_venta.cod_tipdocum;
               vf_consume_foliacion := Fa_Foliacion_Pg.fa_consume_folio_fn ( v_venta.cod_tipdocum, v_venta.cod_vendedor,
                                                                                   v_venta.cod_oficina, vf_codigo_operadora,
                                                                             NULL, v_venta.num_venta, vf_num_proceso,
                                                                             SYSDATE,1);
               IF SUBSTR(vf_consume_foliacion,1,1)!=2 OR SUBSTR(vf_consulta_foliacion,3)!=SUBSTR(vf_consume_foliacion,3) THEN
                  v_errores.cod_pedido := v_cod_pedido;
                  v_errores.fec_error := SYSDATE;
                  v_errores.glosa_error_traspaso := 'SUBSTR(vf_consume_foliacion,1,1)!=2 OR SUBSTR(vf_consulta_foliacion,3)!=SUBSTR(vf_consume_foliacion,3)';
                  v_errores.cod_estado_error :='PR';
                  v_errores.num_venta := v_venta.num_venta;
                  RAISE error_proceso_general;
               END IF;
            END IF;

            v_paso :='(ETAPA2:VENTA)(PASO7:REALIZA VENTA)(P_AL_VEN_DIS_WEB) VENTA= '||v_venta.num_venta||' PROCESO= '||vf_num_proceso||' PEDIDO= ' ||v_cod_pedido;
-- Se moficia invocación a PL: P_AL_VEN_DIS_WEB_NEW, al que se le agrega en forma opcional el identificador de cliente mayorista, 44724
--            P_Al_Ven_Dis_Web_New ( v_venta.num_venta, vf_num_proceso, v_cod_pedido, vf_tip_foliacion, v_errores, v_err_pedido, LN_mayorista);
-- Se elimina opción de salida definitiva para Mayorista o Dealer, se hace para todos. 25-10-2007
            P_Al_Ven_Dis_Web_New ( v_venta.num_venta, vf_num_proceso, v_cod_pedido, vf_tip_foliacion, v_errores, v_err_pedido);
            IF v_err_pedido <> 0 THEN
               RAISE error_proceso_general;
            END IF;

dbms_output.PUT_LINE('tipo v_tip_doc_pedido' || v_tip_doc_pedido );
            IF (v_tip_doc_pedido <> 2 AND v_tip_doc_pedido <> 7 ) THEN
        dbms_output.PUT_LINE('entrooooooo');
                v_paso :='(ETAPA2:VENTA)(PASO7:REALIZA VENTA)(P_Np_Insert_Estado_Factura) PEDIDO= '||v_cod_pedido||' VENTA= '||v_venta.num_venta;
                P_Np_Insert_Estado_Factura ( v_cod_pedido,v_cod_usuario,v_cod_usuario_ing,v_venta.num_venta,v_err );
            END IF;

            IF v_err <> 0 THEN
               v_errores.cod_pedido := v_cod_pedido;
               v_errores.fec_error := SYSDATE;
               v_errores.glosa_error_traspaso := 'ERROR EN RETORNO DE P_Np_Insert_Estado_Factura ' || TO_CHAR(v_err);
               v_errores.glosa_error_venta := SQLERRM;
               v_errores.cod_estado_error :='PR';
               v_errores.num_venta := v_venta.num_venta;
               RAISE error_proceso_general;
            END IF;
         ELSE
            v_errores.cod_pedido := v_cod_pedido;
            v_errores.fec_error := SYSDATE;
            v_errores.glosa_error_traspaso := 'CARACT INFORMADAS <> AL_SERIES. NO SE ENCUENTRA SERIE_PEDIDO';
            v_errores.glosa_error_venta := SQLERRM;
            v_errores.cod_estado_error :='PR';
            v_paso :='(ETAPA2:VENTA)(PASO8:NO REALIZA VENTA): CARACT INFORMADAS <> AL_SERIES. NO SE ENCUENTRA SERIE_PEDIDO';
                v_errores.num_venta := v_venta.num_venta;
                v_errores.num_traspaso_masivo := v_num_traspaso_masivo;
                IF NOT v_num_serie IS NULL THEN v_errores.num_serie := v_num_serie; END IF;
                IF NOT v_cod_articulo IS NULL THEN v_errores.cod_articulo := v_cod_articulo; END IF;
                IF NOT v_lin_det_pedido IS NULL THEN v_errores.lin_pedido := v_lin_det_pedido; END IF;
            RAISE error_proceso_general;
         END IF;
         --COMMIT;
         v_errores := NULL;
         v_err_pedido := 0;
      END IF;

      BEGIN
         SELECT 1
         INTO v_valida_venta
         FROM GA_VENTAS
         WHERE NUM_VENTA = v_venta.num_venta;
         P_Al_Hist_Traspasos(v_num_traspaso_masivo);
      EXCEPTION
      WHEN NO_DATA_FOUND THEN
         NULL;
      WHEN TOO_MANY_ROWS THEN
         P_Al_Hist_Traspasos(v_num_traspaso_masivo);
      END;
      EXCEPTION
         WHEN error_proceso_general THEN
         IF NOT v_venta.num_venta IS NULL THEN v_errores.num_venta := v_venta.num_venta; END IF;
         IF NOT v_num_serie IS NULL THEN v_errores.num_serie := v_num_serie; END IF;
         IF NOT v_cod_articulo IS NULL THEN v_errores.cod_articulo := v_cod_articulo; END IF;
         IF NOT v_lin_det_pedido IS NULL THEN v_errores.lin_pedido := v_lin_det_pedido; END IF;
          ROLLBACK;
          SELECT al_seq_errores_web.NEXTVAL INTO v_errores.num_error FROM dual;
          Al_Pac_Trasven_Web.insertar_al_errores_web(v_errores);
          v_errores := NULL;
          --COMMIT;
         WHEN error_Tratamiento_Masivo THEN
         IF NOT v_num_serie IS NULL THEN v_errores.num_serie := v_num_serie; END IF;
         IF NOT v_cod_articulo IS NULL THEN v_errores.cod_articulo := v_cod_articulo; END IF;
         IF NOT v_lin_det_pedido IS NULL THEN v_errores.lin_pedido := v_lin_det_pedido; END IF;
         IF NOT v_num_traspaso_masivo IS NULL THEN v_errores.num_traspaso_masivo := v_num_traspaso_masivo; END IF;
         ROLLBACK;
          SELECT al_seq_errores_web.NEXTVAL INTO v_errores.num_error FROM dual;
         Al_Pac_Trasven_Web.insertar_al_errores_web(v_errores);
          v_errores := NULL;
          --COMMIT;
        WHEN ERR_INSERT_MOVIM THEN
        -- TRATAMIENTO ERROR PARA SALIDA ENTRADA EXTRA.
           IF NOT GE_ERRORES_PG.MENSAJEERROR(ERRORCOD,ERRORNEG) THEN
              ERRORNEG := ErrorNoCla;
           END IF;

           ERRORDES := 'P_AL_TRASVEN_WEB_NEW('||'); - ' || SQLERRM;
           NEVENTO  := GE_ERRORES_PG.GRABARPL( NEVENTO, 'NP', 'Error Definido por el sistema', '1.0', USER, 'NP_ORIGENVENTA_PR', sSql, SQLCODE, ERRORDES );

           v_errores.cod_pedido := v_cod_pedido;
           v_errores.fec_error := SYSDATE;
           v_errores.num_venta := v_venta.num_venta;
           v_errores.num_traspaso_masivo := v_num_traspaso_masivo;
           v_errores.glosa_error_traspaso := v_paso;
           v_errores.glosa_error_venta := SQLERRM;
           v_errores.cod_estado_error :='PR';
           ROLLBACK;
           SELECT al_seq_errores_web.NEXTVAL INTO v_errores.num_error FROM dual;
           IF NOT v_num_serie IS NULL THEN v_errores.num_serie := v_num_serie; END IF;
           IF NOT v_cod_articulo IS NULL THEN v_errores.cod_articulo := v_cod_articulo; END IF;
           IF NOT v_lin_det_pedido IS NULL THEN v_errores.lin_pedido := v_lin_det_pedido; END IF;
           Al_Pac_Trasven_Web.insertar_al_errores_web (v_errores);
           v_errores := NULL;
           --COMMIT;
--         exit;

--         exit;
         WHEN OTHERS THEN
                 v_errores.cod_pedido := v_cod_pedido;
                v_errores.fec_error := SYSDATE;
                v_errores.num_venta := v_venta.num_venta;
                v_errores.num_traspaso_masivo := v_num_traspaso_masivo;
                v_errores.glosa_error_traspaso := v_paso;
                v_errores.glosa_error_venta := SQLERRM;
                v_errores.cod_estado_error :='PR';
                ROLLBACK;
                SELECT al_seq_errores_web.NEXTVAL INTO v_errores.num_error FROM dual;
                IF NOT v_num_serie IS NULL THEN v_errores.num_serie := v_num_serie; END IF;
                IF NOT v_cod_articulo IS NULL THEN v_errores.cod_articulo := v_cod_articulo; END IF;
                IF NOT v_lin_det_pedido IS NULL THEN v_errores.lin_pedido := v_lin_det_pedido; END IF;
                Al_Pac_Trasven_Web.insertar_al_errores_web (v_errores);
          v_errores := NULL;
          --COMMIT;
--         exit;
      END;
      --COMMIT;
      IF v_paralelismo = 1 THEN EXIT; END IF;
      /*-- FINALIZA RUTINA DE VENTA   ------------------------------------------------------ */



   END LOOP;
   CLOSE pedido;
   --COMMIT;

 IF pedido%isopen THEN CLOSE pedido; END IF;
     IF detalle%isopen THEN CLOSE detalle; END IF;
     IF series%isopen THEN CLOSE series; END IF;
      IF articulo%isopen THEN CLOSE articulo; END IF;
     IF series_conceptos%isopen THEN CLOSE series_conceptos; END IF;

EXCEPTION

   WHEN OTHERS THEN
                v_errores.cod_pedido := v_cod_pedido;
                v_errores.fec_error := SYSDATE;
                v_errores.num_venta := v_venta.num_venta;
                v_errores.num_traspaso_masivo := v_num_traspaso_masivo;
                v_errores.glosa_error_traspaso := v_paso;
                v_errores.glosa_error_venta := SQLERRM;
                v_errores.cod_estado_error :='PR';
                SELECT al_seq_errores_web.NEXTVAL INTO v_errores.num_error FROM dual;
                ROLLBACK;
                IF NOT v_num_serie IS NULL THEN v_errores.num_serie := v_num_serie; END IF;
                IF NOT v_cod_articulo IS NULL THEN v_errores.cod_articulo := v_cod_articulo; END IF;
                IF NOT v_lin_det_pedido IS NULL THEN v_errores.lin_pedido := v_lin_det_pedido; END IF;
        ROLLBACK;
        Al_Pac_Trasven_Web.insertar_al_errores_web (v_errores);
          v_errores := NULL;
          --COMMIT;
END;
/
