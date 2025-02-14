CREATE OR REPLACE PROCEDURE P_AL_INGRESO_CORRECCION(
v_num_transaccion	IN	    varchar2,
v_num_corre_X 		IN	    varchar2,
v_tip_corre_X 		IN	    varchar2) IS
v_glosa_error	 varchar2(70);
ihCodEvento      SC_EVENTO.COD_EVENTO%TYPE;
szhIdLote        SC_ENT_LOTE.ID_LOTE%TYPE;
szhDesError      SC_ERROR_INGRESO.DES_ERROR%TYPE;
v_num_corre      al_cab_cor_mone.num_corre%type;
v_tip_corre      al_cab_cor_mone.tip_corre%type;
v_error 	 varchar2(70);
nSeqKardex       number;
periodo	         varchar2(70);
iCountPer        INTEGER;
v_Cod_Operadora	 ge_operadora_scl.cod_operadora_scl%type;
ERROR_PROCESO_GENERAL           EXCEPTION;
v_proced			varchar2(70);
CURSOR Lotes is
select trunc(a.fec_corre) 			   fec_movimiento,
	  75					   cod_evento,
          'C/'||to_char(a.fec_corre,'YYYYMMDD')    id_lote,
	  to_char(sysdate,'YYYYMM')         	   per_contable,
	  user					   nom_usuario_lote,
	  sysdate				   fec_lote
	  from al_cab_cor_mone a, al_lin_cor_mone b
	  where a.num_corre =  v_num_corre
	  and   a.num_corre = b.num_corre
	  and   b.fec_imputacion  is null
	  group by trunc(a.fec_corre), to_char(a.fec_corre,'YYYYMMDD'), to_char(sysdate,'yyyymm');
CURSOR detalle_lotes is
select 75					 cod_evento,
       'C/'||to_char(a.fec_corre,'YYYYMMDD')	 id_lote,
	lpad(b.cod_articulo,6,0)		 cod_concepto,
	b.mto_corre				 imp_movimiento,
	NULL					 des_transaccisn
	from  al_cab_cor_mone a, al_lin_cor_mone b
	where a.num_corre =  v_num_corre
  	and   a.num_corre = b.num_corre
	and   b.fec_imputacion is null
	group by to_char(a.fec_corre,'YYYYMMDD'),b.cod_articulo, b.mto_corre;
CURSOR Articulos is
select 	19				tip_movim,
	'T'				Indicador_Entsal,
	sysdate         		fec_movimiento,
	1				bodega_central,
	2				mercaderia,
	1				estado_nueva,
	cod_articulo    		codigo_articulo,
	0				num_movimiento,
	0				cod_orig,
	0				corr_apli,
	2				uso_venta
from    al_lin_cor_mone
where   num_corre = v_num_corre
and     fec_imputacion is null;
  BEGIN
  	select  c.cod_operadora_scl
	into v_Cod_Operadora
    from ge_direcciones f,ge_ciudades g,
           al_bodegas d,ge_operadora_scl c
    where  c.cod_operadora_scl= GE_FN_OPERADORA_SCL
           and c.cod_bodeganodo =d.cod_bodega
           and d.cod_direccion = f.cod_direccion
           and f.cod_region = g.cod_region
           and f.cod_provincia = g.cod_provincia
           and f.cod_ciudad  = g.cod_ciudad ;
  v_proced:='P_AL_INGRESO_CORRECCION';
  INSERT INTO GA_TRANSACABO (NUM_TRANSACCION, COD_RETORNO, DES_CADENA)
  VALUES (TO_NUMBER(v_num_transaccion), 0, 'error correccion');
  v_num_corre:=to_number(v_num_corre_X);
  v_tip_corre:=to_number(v_tip_corre_X);
		for CC in lotes  loop
		dbms_output.put_line(cc.id_lote);
  	          INSERT INTO SC_ENT_CAB_LOTE (COD_EVENTO,ID_LOTE,PER_CONTABLE,NOM_USUARIO_LOTE,FEC_LOTE, COD_OPERADORA_SCL)
			  values (
			  cc.cod_evento,
			  cc.id_lote,
			  cc.per_contable,
			  cc.nom_usuario_lote,
			  cc.fec_lote,
			  v_Cod_Operadora);
		end loop;
		for CC1 in detalle_lotes  loop
       		INSERT INTO SC_ENT_LOTE (COD_EVENTO,ID_LOTE,COD_CONCEPTO,IMP_MOVIMIENTO,COD_OPERADORA_SCL)
			  values (
			  cc1.cod_evento,
			  cc1.id_lote,
			  cc1.cod_concepto,
			  cc1.imp_movimiento,
			  v_Cod_Operadora);
		end loop;
  IF v_tip_corre = 1 then
  --Si tip_corre = 1 entonces registrar articulos en Kardex, caso contrario sslo el proceso anterior(Traspaso a OFA)
      for CC2 in articulos loop
    	    -- secuencia de KArdex
	    select al_seq_kardex.nextval
	    into nSeqKardex
	    from dual;
	    --para sacar el periodo correspondiente
	    select count(*)
	    into iCountPer
	    from al_cale_kardex
	    where to_date(cc2.FEC_movimiento,'dd-mm-yyyy') between
	    fec_inic and fec_term;
	    if iCountPer = 0 then
	   	select  trunc(sysdate,'month')
		into    periodo
		from    dual;
	    else
		select to_char(fec_peri,'dd-mm-yyyy')
	        into periodo
	        from al_cale_kardex
		where to_date(cc2.FEC_movimiento,'dd-mm-yyyy')
		between fec_inic and fec_term;
	    end if;
	    INSERT INTO AL_KARDEX(NUM_MOVKARDEX, TIP_MOVIMIENTO, IND_ENTSAL, FEC_MOVIMIENTO,
	    			  FEC_PERIODO, COD_BODEGA, TIP_STOCK, COD_ESTADO, COD_ARTICULO,
	    			  NUM_MOVIMIENTO, COD_ORIG, CORR_APLI,COD_USO)
	    VALUES(nSeqKardex,CC2.tip_movim, CC2.Indicador_Entsal,CC2.fec_movimiento,
	    	   to_date(periodo,'dd-mm-yyyy'),CC2.bodega_central, CC2.mercaderia, CC2.estado_nueva, CC2.codigo_articulo,
	    	   CC2.num_movimiento, CC2.cod_orig, CC2.corr_apli,CC2.uso_venta);
	    commit;
      end loop;
  end if;
  for CC in lotes  loop
      szhDesError:='0';
      SC_P_INGRESA_LOTE(to_char(cc.cod_evento),cc.id_lote,v_Cod_Operadora);
      SELECT count(*)
      INTO   szhDesError
      FROM   SC_ERROR_INGRESO
      WHERE  COD_EVENTO = cc.cod_evento
      AND    ID_LOTE    = cc.id_lote;
      IF szhDesError='0'  THEN
         Update    al_lin_cor_mone
         set   fec_imputacion = sysdate
         where num_corre =  v_num_corre
         and   fec_imputacion is null;
         v_error := 0;
         commit;
      else
         rollback;
     end if;
  end loop;
EXCEPTION
	WHEN  ERROR_PROCESO_GENERAL  THEN
	        INSERT INTO GA_TRANSACABO (NUM_TRANSACCION, COD_RETORNO, DES_CADENA)
	VALUES (TO_NUMBER(v_num_transaccion), 1, 'error correccion');
		RAISE_APPLICATION_ERROR (-20205,v_proced||' '||SQLERRM || ' ' || sqlcode ||'ERROR CORRECCION MONETARIA');
	WHEN OTHERS THEN
	INSERT INTO GA_TRANSACABO (NUM_TRANSACCION, COD_RETORNO, DES_CADENA)
	VALUES (TO_NUMBER(v_num_transaccion), 2, 'error correccion');
   		RAISE_APPLICATION_ERROR (-20204,v_proced||' '||SQLERRM || ' ' || sqlcode);
END P_AL_INGRESO_CORRECCION;
/
SHOW ERRORS
