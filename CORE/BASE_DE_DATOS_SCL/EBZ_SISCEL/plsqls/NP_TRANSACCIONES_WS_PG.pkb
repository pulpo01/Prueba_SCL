CREATE OR REPLACE PACKAGE BODY NP_TRANSACCIONES_WS_PG IS

    sSql VARCHAR2(4000);
    NEVENTO VARCHAR2(20);
    ERRORCOD VARCHAR2(20);
    ERRORNEG VARCHAR2(200);
    ERRORDES VARCHAR2(50);
	ErrorNoCla VARCHAR2(50):= 'No Es Posible Recuperar Error Clasificado';
	v_tip_stock_ori al_series.tip_stock%TYPE;
	v_mer_dealer npt_parametro.valor_parametro%TYPE;
	v_est_siscel_fact npt_parametro.valor_parametro%TYPE;
	CN_cero CONSTANT PLS_INTEGER := 0;
	CN_uno CONSTANT PLS_INTEGER := 1;
	e_BUSCA_ERROR EXCEPTION;

/*
-- PL/SQL Specification
-- *************************************************************
-- <NOMBRE>	   : NP_TRANSACIONES_WEB_PG   .</NOMBRE>
-- <FECHACREA>	   : 16/12/2005<FECHACREA/>
-- <MODULO >	   : WEBE</MODULO >
-- <AUTOR >       : Ingrid Cabrera T.</AUTOR >
-- <VERSION >     : 1.0</VERSION > MA-200605030927
-- <VERSION >     : 1.1, se modifica para incidencia: CO-200605050103
-- <VERSION >     : 1.2, se modifica para incidencia: 36095
-- <DESCRIPCION>  : PKG  encargado de algunas transacciones de npw</DESCRIPCION>
-- <FECHAMOD >    : 10-05-2006
-- <DESCMOD >     : Se agrega función:  NP_VALIDA_AL_CARGOS_FN, que se encarga de validar la existencia del total de series para cada linea de detalle en el pedido
-- <VERSION >     : 1.3, se modifica para incidencia: 72907
-- <AUTOR>        : ZMH </AUTOR>
-- <FECHAMOD >    : 20-11-2008
-- <DESCMOD >     : Se agrega función: NP_CARACTERVALIDO_FN, que se encarga de capturar los caracteres validos para una secuencia.
--                  Según una cadena de entrada (CadenaValida), o si no se inoca cadena, de la GED_CODIGOS.
-- *************************************************************
<FECHAMOD >    : 11/08/2009 </FECHAMOD >
<DESCMOD >     : Modificación a PL para: P-MIX-09003-Guatemala-Salvador   </DESCMOD >
<VERSIONMOD>   : 1.1    </VERSIONMOD>
<AUTOR>        : Z.M.H. </AUTORMOD>
*/


PROCEDURE MASK_NP_ORIGENVENTA_PR
(EN_numtrans    IN ga_transacabo.num_transaccion%TYPE,
 EN_numserie    IN al_series.num_serie%TYPE,
 EN_TipoProceso	IN PLS_INTEGER
)
IS

  	LV_coduso   al_usos.cod_uso%TYPE;
	LV_desuso   al_usos.des_uso%TYPE;
	LV_codart   al_articulos.cod_articulo%TYPE;
	LV_desart   al_articulos.des_articulo%TYPE;
	LV_deserror VARCHAR2(100);
	LV_codretorno ga_transacabo.cod_retorno%TYPE;
	LV_desretorno ga_transacabo.des_cadena%TYPE;
BEGIN

	NP_ORIGENVENTA_PR(EN_numserie, EN_TipoProceso, LV_coduso, LV_desuso, LV_codart, LV_desart, LV_deserror);

	IF LV_coduso IS NOT NULL AND LV_desuso IS NOT NULL AND LV_codart IS NOT NULL AND LV_desart IS NOT NULL THEN
	   LV_codretorno:=0;
	   LV_desretorno:=LV_coduso || '/' || LV_desuso || '/' || LV_codart || '/' || LV_desart;
	ELSE
	   LV_codretorno:=1;
	   LV_desretorno:=LV_deserror;
	END IF;

	INSERT INTO ga_transacabo (num_transaccion, cod_retorno, des_cadena)
	VALUES (EN_numtrans, LV_codretorno, LV_desretorno);

	COMMIT;

	EXCEPTION
	WHEN OTHERS THEN
		 RAISE_APPLICATION_ERROR (-20100,'<MASK_NP_ORIGENVENTA_PR>, Error Oracle: ' || TO_CHAR(SQLCODE) || chr(13) || ' Error : ' || SQLERRM);

END MASK_NP_ORIGENVENTA_PR;

PROCEDURE NP_INSERT_VALI_SERIES_TO_PR
(EN_codPedido              in npt_serie_pedido.cod_pedido%TYPE
,EN_linPedido              in npt_serie_pedido.lin_det_pedido%TYPE
,EV_codSerie               in Varchar2
,EV_codBarra               in npt_serie_pedido.cod_bar_ser_pedido%TYPE
)
is
/*
<NOMBRE>	   : NP_INSERT_VALI_SERIES_TO_PR   .</NOMBRE>
<FECHACREA>	   : 16/12/2005<FECHACREA/>
<MODULO >	   : VE</MODULO >
<AUTOR >       : Ingrid Cabrera T.</AUTOR >
<VERSION >     : 1.0</VERSION >
<DESCRIPCION>  : Procedimiento encargado de ingresar series a la tabla temporal np_validación_series_to</DESCRIPCION>
<FECHAMOD >    : 16/12/2005 </FECHAMOD >
<DESCMOD >     : Se Crea procedimiento por inc.MA-200512160880  </DESCMOD >
*/

indice  number :=1;
serie  np_validacion_series_to.num_serie%type;

BEGIN
  serie := '';
  while indice <= length(EV_codSerie) loop
      if substr(EV_codSerie, indice, 1) = '-' then
         insert into np_validacion_series_to
             (cod_pedido, lin_det_pedido, num_serie, cod_barra_serie)
         values (EN_codPedido, EN_linPedido, serie, EV_codBarra);
         serie :='';
      else
         serie := serie || substr(EV_codSerie, indice, 1);
      end if;
      indice := indice + 1;
  end loop;

EXCEPTION
        WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR (-20100,'<VALI_SERIES>, Error INSERT np_validacion_series_to, Error Oracle: ' || TO_CHAR(SQLCODE) || chr(13) || ' Error : ' || SQLERRM);
END NP_INSERT_VALI_SERIES_TO_PR;

procedure GRABAERROR_VALIDASERIES(
cError     IN NUMBER,
pCodPedido in npt_pedido.COD_PEDIDO%type,
pLinPedido IN npt_detalle_pedido.lin_det_PEDIDO%TYPE,
v_serie    IN NP_VALIDACION_SERIES_TO.num_serie%type)
is
-- PL/SQL Specification
--
-- *************************************************************
-- <NOMBRE>	   : NP_INSERT_VALI_SERIES_TO_PR   .</NOMBRE>
-- <FECHACREA>	   : 26/04/2006<FECHACREA/>
-- <MODULO >	   : VE</MODULO >
-- <AUTOR >       : Zenén Muñoz H.</AUTOR >
-- <VERSION >     : 1.0</VERSION >
-- <DESCRIPCION>  : Procedimiento encargado de ingresar series a la tabla temporal np_validación_series_to</DESCRIPCION>
-- <FECHAMOD >    : 26/04/2006 </FECHAMOD >
-- <DESCMOD >     : Se Crea procedimiento por inc.MA-200512160880  </DESCMOD >
-- *************************************************************
BEGIN
      
      update NP_VALIDACION_SERIES_TO 
      set estado='ERROR', cod_error=cError
	  where  cod_pedido=pCodPedido 
      and lin_det_pedido =pLinPEdido
      and num_serie=v_serie and estado is null;
	  

END GRABAERROR_VALIDASERIES;

PROCEDURE NP_VALIDASERIES_PR(
pCodPedido in npt_pedido.COD_PEDIDO%type,
msgError   OUT varchar2)
IS

-- PL/SQL Specification
--
-- *************************************************************
-- * procedimiento      : NP_VALIDASERIES_PR
-- * Descripción        : Procedimiento encargado de validar las series ingresadas
-- * Fecha de creación  : 17-10-2003
-- * Responsable        : Freddy Zavala G.
-- * Versión            : 1.0
-- * Versión            : 1.1 TM-200604242045 26/04/2006
-- * Motivo del cambio  : Control de errores en validación de series.
-- *                      cada vez que ocurre un error, se maneja el error a través de la instricción RAISE ERROR_PROCESO.
-- *************************************************************

 v_serie  		  			npt_serie_pedido.cod_serie_pedido%type;
 v_existe_serie_en_bodega   number(1);
 v_coinciden_bodegas        number(1);
 v_coincide_articulo		number(1);
 v_uso_valido				number(1);
 v_tip_stock_valido			number(1);
 v_estado_nuevo				number(1);
 v_traspaso_masivo			number(1);
 v_serie_valida				number(1);
 v_kit 						number(1);
 v_serie_temp				number(1);
 v_tip_stock				npt_detalle_pedido.tip_stock%type;
 v_cod_articulo				npt_detalle_pedido.cod_articulo%type;
 v_cod_uso					npt_detalle_pedido.cod_uso%type;
 v_cod_bodega				npt_detalle_pedido.cod_bodega%type;
 v_tip_stock_al				npt_detalle_pedido.tip_stock%type;
 v_cod_articulo_al			npt_detalle_pedido.cod_articulo%type;
 v_cod_uso_al				npt_detalle_pedido.cod_uso%type;
 v_cod_bodega_al			npt_detalle_pedido.cod_bodega%type;
 v_cod_tecnologia			npt_detalle_pedido.cod_tecnologia%type;
 v_num_telefono				al_componente_kit.num_telefono%type;
 v_existe_serie_pedido		npt_serie_pedido.cod_serie_pedido%type;
 v_ind_tel                  al_series.ind_telefono%type;
 v_cod_Art_num              al_articulos.cod_articulo%type;
 v_aux_lin_det_pedido       npt_detalle_pedido.lin_det_pedido%type;
 v_lin_det_pedido			npt_detalle_pedido.lin_det_pedido%type;
 v_validahistorico			varchar2(3);
 v_num_telefono_serie		al_series.NUM_TELEFONO%type;
 v_cod_central				al_series.COD_CENTRAL%type;
 v_codTecno_central			icg_central.COD_TECNOLOGIA%type;
 v_cod_central_kit			al_series.COD_CENTRAL%type;
----------------- Variables para determinar si se validan los series NO numeradas -----------------
 v_valida_numerado 			npt_parametro.valor_parametro%type;
 cs_verdadero 				npt_parametro.valor_parametro%type;
 cs_falso 					npt_parametro.valor_parametro%type;
 cs_tecnologia				npt_parametro.valor_parametro%type;
 cn_uso						npt_detalle_pedido.cod_uso%type;
------------------ FIN -------------------------------------------------------------------------

 LV_ind_equiacc    	        al_articulos.IND_EQUIACC%type;
 LV_tip_terminal 			al_articulos.TIP_TERMINAL%type;
 v_ind_equiacc				al_articulos.IND_EQUIACC%type;
 v_tip_terminal				al_articulos.TIP_TERMINAL%type;
 LN_mayorista               number(1);
 CN_POSTPAGO                CONSTANT PLS_INTEGER:=2;
 CN_PREPAGO					CONSTANT PLS_INTEGER:=3;

 -- Obtención de series desde tabla temporal.
 cursor c_series is select a.num_serie, b.tip_stock, b.cod_articulo, b.cod_uso,
	   				b.cod_bodega, b.lin_det_pedido, b.cod_tecnologia, c.ind_equiacc, c.tip_terminal
                    from NP_VALIDACION_SERIES_TO a,
					npt_detalle_pedido b, AL_ARTICULOS C
                    where a.cod_pedido = pCodPedido
                    and a.estado is null
					and b.cod_pedido=a.cod_pedido
					and b.lin_det_pedido=a.lin_det_pedido
					and b.cod_articulo = c.cod_articulo ;


   ERROR_PROCESO EXCEPTION;

msgError_l varchar2(255);
cError     number;


BEGIN
      v_aux_lin_det_pedido:= 0;
      msgError := '';
      cs_verdadero := 'TRUE';
      cs_falso	 := 'FALSE';
	  NEVENTO := 0;
	  cn_uso  := 2; --El codigo 2 pertence al uso POSTPAGO

      BEGIN
      --Rescatar datos por defecto, como el parametro que indica si se validan o no las series NO NUMERADAS
         sSql := 'select valor_parametro from npt_parametro';
         sSql := sSql || ' where alias_parametro = "VALIDA_NUM"';

         select upper(valor_parametro) into v_valida_numerado from npt_parametro
         where alias_parametro = 'VALIDA_NUM';

       EXCEPTION
          WHEN NO_DATA_FOUND THEN
              ERRORCOD := '790';
       	   RAISE  e_BUSCA_ERROR;

          WHEN OTHERS THEN
              ERRORCOD := '110';
              RAISE  e_BUSCA_ERROR;
      END;

      BEGIN
         --Rescatar el parametro de la tecnologia GSM ------
         sSql := 'select valor_parametro into cs_tecnologia from npt_parametro';
         sSql := sSql || ' where alias_parametro = "TIP_TECNO"';

         select valor_parametro into cs_tecnologia from npt_parametro
         where alias_parametro = 'TIP_TECNO';

      EXCEPTION
           WHEN NO_DATA_FOUND THEN
               ERRORCOD := '0';
        	   RAISE  e_BUSCA_ERROR;

           WHEN OTHERS THEN
               ERRORCOD := '110';
               RAISE  e_BUSCA_ERROR;
      END;

	  /*Valido si es mayorista o  dealer*/
	  BEGIN
	  	  LN_mayorista  := NP_VALIDA_MAYORISTA_FN(pCodPedido);
	  EXCEPTION
          WHEN NO_DATA_FOUND THEN
             cError := 60;
       	  	 RAISE ERROR_PROCESO;
      END;

      OPEN c_series;
         LOOP
            fetch c_series into v_serie, v_tip_stock, v_cod_articulo, v_cod_uso, v_cod_bodega, v_lin_det_pedido, v_cod_tecnologia, v_ind_equiacc, v_tip_terminal;
            exit when c_series%notfound;

           BEGIN
            -- Inicialización de variables.

            v_existe_serie_en_bodega:=0;
            v_coinciden_bodegas:=0;
            v_coincide_articulo:=0;
            v_uso_valido:=0;
            v_tip_stock_valido:=0;
            v_estado_nuevo:=0;
            v_traspaso_masivo:=0;
            v_serie_valida:=0;
            v_kit:=0;
            v_num_telefono:=null;
            v_existe_serie_pedido:='NO ESTA';

               BEGIN
	               msgError_l :=  'Stock de la serie no coincide con el suo especificado por el pedido';
	               -- Valido que el tipo de stock de la serie coincida con el suo especificado por el pedido
	         	   select tip_stock, cod_articulo, cod_uso, cod_bodega, num_telefono, cod_central
	         	   into   v_tip_stock_al, v_cod_articulo_al, v_cod_uso_al, v_cod_bodega_al, v_num_telefono_serie, v_cod_central
	         	   from   al_series
	         	   where  num_serie=v_serie;

	               msgError_l :=  'Tipo de stock de la serie no coincide con el uso especificado por el pedido';
	         	   -- Valido que el tipo de stock de la serie coincida con el uso especificado por el pedido
	         	   if v_tip_stock_al<>v_tip_stock then
	         	      cError := 50;
	         	      RAISE ERROR_PROCESO;
	         	   end if;

	               msgError_l := 'Código de artículo de la serie no coincide con el uso especificado por el pedido';
	         	   if v_cod_articulo_al<>v_cod_articulo then
	         	      -- Si el articulo no coincide dejo error en tabla temporal.
	         	      cError := 30;
	         	      RAISE ERROR_PROCESO;
	         	   end if;

	         	   -- Valido que el uso de la serie coincida con el uso especificado por el pedido
	               msgError_l := 'Código de uso de la serie no coincide con el uso especificado por el pedido';
	         	   if v_cod_uso_al<>v_cod_uso then
	         	      cError := 40;
	         	      RAISE ERROR_PROCESO;
	         	   end if;

	         	   -- Valido que la bodega en la que se encuentra la serie coincida con la que indica el pedido
	               msgError_l := 'Código de bodega de la serie no coincide con el uso especificado por el pedido';
	         	   if v_cod_bodega_al<>v_cod_bodega then
	         	      cError := 20;
	         	      RAISE ERROR_PROCESO;
	         	   end if;

	         	   --Valido que la tecnologia asociado a la central de la serie corresponda a la selecciona por el usuario
	               msgError_l := 'Tecnologia asociado a la central de la serie no corresponde a la selecciona por el usuario';

	      		   if v_num_telefono_serie >0 then
	      			  Select cod_tecnologia
	      			  into v_codTecno_central
	      			  from icg_central
	      			  where cod_central = v_cod_central;

	      			  if v_cod_tecnologia<>v_codTecno_central then
	                     cError := 25;
	      		         RAISE ERROR_PROCESO;
	      			  end if;
	      		   end if;

			        -- si la serie no existe en SCL, deja error en la tabla temporal, para esa serie.
	               msgError_l := 'Serie no existe en SCL';
            EXCEPTION
               WHEN NO_DATA_FOUND THEN
          	   cError := 10;
 	           RAISE ERROR_PROCESO;
            END;


            -- Valido que el estado de la serie sea nuevo.
            msgError_l := 'Estado de la serie no es nuevo';
            BEGIN
         	   select 1 into v_estado_nuevo from al_series where num_serie=v_serie and cod_estado=1;
         	   -- Si el estado de la serie no es nuevo deja error en tabla temporal.
         	EXCEPTION
               WHEN NO_DATA_FOUND THEN
                  cError := 60;
            	  RAISE ERROR_PROCESO;
            END;

            -- Valido que la serie no exista en la tabla de validaciones temporal.
            msgError_l := 'Serie no exista más de una vez en la tabla de validaciones temporal';
            BEGIN
         	   select count(1) into v_serie_temp 
               from NP_VALIDACION_SERIES_TO 
               where num_serie=v_serie ;
         	   -- Si la serie existe en la tabla deja error en tabla temporal de validación.
         	   if v_serie_temp>1 then
                 	   cError := 90;
                    RAISE ERROR_PROCESO;
         	   end if;
            END;


            BEGIN
         	   -- Valido que la serie no este ingresada en las tablas temporales de traspaso de bodegas.
               msgError_l := 'Serie esta ingresada en las tablas temporales de traspaso de bodega';
         	   select 1 into v_traspaso_masivo from al_traspasos_masivo
         	   where num_serie=v_serie and cod_pedido=pCodPedido;

         	   EXCEPTION
                  WHEN NO_DATA_FOUND THEN
         	      null;
            END;

            msgError_l := 'Serie esta ingresada en las tablas temporales de traspaso de bodegas';
            -- Si la serie se encuentra en las tablas temporales de traspaso de bodegas
            -- deja error en la tabla temporal.
            if v_traspaso_masivo=1 then
               cError := 70;
               RAISE ERROR_PROCESO;
            end if;
            
            msgError_l := 'Valida si la serie prepago es numerada';
            -- valida que la series simcard prepago sea numerada
            IF v_tip_terminal ='G' AND v_cod_uso =3 THEN
                IF  NP_VALIDA_NUMERACION_FN(v_serie) = 0 THEN
                    cError := 85;
                    RAISE  ERROR_PROCESO;
                END IF;
            END IF;

            BEGIN
               msgError_l := 'Serie corresponde a un kit';
         	   -- reviso si la serie corresponde a un kit
         	   select 1 into v_kit from al_articulos where cod_articulo=v_cod_articulo_al
         	   and tip_articulo=20;

         	EXCEPTION
               WHEN NO_DATA_FOUND THEN
         	   null;
            END;

            msgError_l := 'Serie corresponde a un kit, que no esta numerado';
            -- Si la serie corresponde a un kit valido que el kit este numerado.
            IF v_kit=1 THEN
				BEGIN

				select num_telefono, cod_central into v_num_telefono, v_cod_central_kit from al_componente_kit
				where num_kit=v_serie and ind_telefono>0;
				EXCEPTION
					WHEN NO_DATA_FOUND THEN
						cError := 80;
						RAISE ERROR_PROCESO;
				END;

				BEGIN
					msgError_l := 'No existe tecnología para la central de la serie kit';
					Select cod_tecnologia
					into v_codTecno_central
					from icg_central
					where cod_central = v_cod_central_kit;

					if v_cod_tecnologia<>v_codTecno_central then
						cError := 25;
						RAISE ERROR_PROCESO;
					end if;
				END;
            END IF;

            msgError_l := 'Serie fue ingresada por otro pedido a la tabla npt_serie_pedido.';
            --Valido que la serie no haya sido ingresada por otro pedido a la tabla npt_serie_pedido.
            BEGIN
             	 select valor_parametro into v_validahistorico from npt_parametro
            	 where alias_parametro = 'VALHISSER';

            	 if v_validahistorico='NO' then
            	     select a.cod_serie_pedido into v_existe_serie_pedido
            		 from 	npt_serie_pedido a
            		 where  a.cod_serie_pedido=v_serie;
            	 end if;

            	 if v_validahistorico='SI' then
            	     select a.cod_serie_pedido into v_existe_serie_pedido
            		 from 	npt_serie_pedido a, npt_pedido b
            		 where  a.cod_serie_pedido=v_serie and a.cod_pedido=b.cod_pedido
            		 union
            	     select a.cod_serie_pedido
            		 from 	npt_serie_pedido_hist_th a, npt_pedido_hist_th b
            		 where  a.cod_serie_pedido=v_serie and a.cod_pedido=b.cod_pedido;

            	 end if;
         	 EXCEPTION
               WHEN NO_DATA_FOUND THEN
         		 BEGIN
    			 	  select a.cod_serie_pedido into v_existe_serie_pedido
    				  from 	npt_serie_pedido a, npt_pedido b
    		 		  where  a.cod_serie_pedido=v_serie and a.cod_pedido=b.cod_pedido;
    		     EXCEPTION
    	 		      WHEN NO_DATA_FOUND THEN
    				  null;
         		 END;
             END;


            IF v_existe_serie_pedido<>'NO ESTA' THEN
               	   cError := 15;
                   RAISE ERROR_PROCESO;
            END IF;


			BEGIN
 				    CASE LN_mayorista
					WHEN  1 THEN--Si es mayorista
					   IF v_ind_equiacc = 'E' AND v_tip_terminal = 'G' THEN
--					   		  IF  NP_VALIDA_NUMERACION_FN(v_serie) = 1 AND v_cod_uso = CN_POSTPAGO AND v_cod_tecnologia = cs_tecnologia THEN  --NO NUMERADO       -- P-MIX-09003-Guatemala-Salvador
					   		  IF  v_cod_uso = CN_POSTPAGO AND v_cod_tecnologia = cs_tecnologia THEN  --NO NUMERADO
			  		                 msgError_l := 'Serie SIMCARD no numerada';
									 cError := 86;
	                               	 ERRORCOD := '1040';
	                               	 RAISE  e_BUSCA_ERROR;
						      END IF;
					   ELSIF v_ind_equiacc = 'E' AND (v_tip_terminal = 'D' OR v_tip_terminal= 'A') THEN
					   		 msgError_l := 'Serie ESN no numerada';
					    	 IF  NP_VALIDA_NUMERACION_FN(v_serie) = 1 AND v_cod_uso = CN_POSTPAGO THEN  --NUMERADA
										 cError := 87;
		                               	 ERRORCOD := '1040';
		                               	 RAISE  e_BUSCA_ERROR;
							  END IF;
					   END IF;
					WHEN 0 THEN--Dealer
					   IF v_ind_equiacc = 'E' AND v_tip_terminal = 'G' THEN
--					   		 IF  NP_VALIDA_NUMERACION_FN(v_serie) = 1 THEN	--NUMERADA        -- P-MIX-09003-Guatemala-Salvador
								/*IF  v_cod_uso = CN_POSTPAGO AND v_cod_tecnologia = cs_tecnologia  THEN
										 cError := 88;
		                               	 ERRORCOD := '1040';
		                               	 RAISE  e_BUSCA_ERROR;
								END IF;*/
                                null;
-- P-MIX-09003-Guatemala-Salvador
/*							 ELSE
								IF v_cod_uso = CN_POSTPAGO  AND v_cod_tecnologia = cs_tecnologia  THEN
										 cError := 88;
		                               	 ERRORCOD := '1041';
		                               	 RAISE  e_BUSCA_ERROR;
								END IF;
								IF  v_cod_uso = CN_PREPAGO AND v_cod_tecnologia = cs_tecnologia  THEN
										 cError := 88;
		                               	 ERRORCOD := '1042';
		                               	 RAISE  e_BUSCA_ERROR;
								END IF;
							 END IF;*/
--  fin P-MIX-09003-Guatemala-Salvador
					   ELSIF v_ind_equiacc = 'E' AND v_tip_terminal = 'T' THEn
                       /*
					   	     IF v_cod_uso = CN_POSTPAGO THEN
									 cError := 88;
	                               	 ERRORCOD := '791';
	                               	 RAISE  e_BUSCA_ERROR;
							 END IF;
                             */
                             null;
					   ELSIF v_ind_equiacc = 'E' AND (v_tip_terminal = 'D' OR v_tip_terminal= 'A') THEN
					   		  IF  NP_VALIDA_NUMERACION_FN(v_serie) = 1 THEN -- NUMERADA
							      IF v_cod_uso = CN_POSTPAGO  THEN
										 cError := 88;
		                               	 ERRORCOD := '1040';
		                               	 RAISE  e_BUSCA_ERROR;
								  END IF;
							  ELSE
								  IF (v_cod_uso = CN_PREPAGO OR v_cod_uso = CN_POSTPAGO)   THEN
										 cError := 88;
		                               	 ERRORCOD := '1041';
		                               	 RAISE  e_BUSCA_ERROR;
								  END IF;
							  END IF;
					   END IF;
					END CASE;

			  EXCEPTION
                       WHEN e_BUSCA_ERROR THEN
                          IF NOT GE_ERRORES_PG.MENSAJEERROR(ERRORCOD,ERRORNEG) THEN
                             ERRORNEG := ErrorNoCla;
                          END IF;
           			      --Debe grabar la serie con error en la tabla NP_VALIDACION_SERIES_TO, ya que despues
           			      --se realizan otra operaciones con esa información en la web.
                    	  msgError := ERRORNEG;
              		  	  GRABAERROR_VALIDASERIES( cError, pCodPedido, v_lin_det_pedido, v_serie);

                          ERRORDES := 'NP_ORIGENVENTA_PR('||'); - ' || SQLERRM;
                          NEVENTO  := GE_ERRORES_PG.GRABARPL( NEVENTO, 'NP', 'Error Definido por el sistema', '1.0', USER, 'NP_ORIGENVENTA_PR', sSql, SQLCODE, ERRORDES );
                       WHEN OTHERS THEN
                        ERRORCOD := '110';
                        IF NOT GE_ERRORES_PG.MENSAJEERROR(ERRORCOD,ERRORNEG) THEN
                           ERRORNEG := ErrorNoCla;
                        END IF;
                        ERRORDES := 'NP_ORIGENVENTA_PR('||'); - ' || SQLERRM;
                        NEVENTO  := GE_ERRORES_PG.GRABARPL( NEVENTO, 'NP', 'Error NO Definido por el sistema', '1.0', USER, 'NP_ORIGENVENTA_PR', sSql, SQLCODE, ERRORDES );
			END;

            msgError_l := 'Pregunto si la serie contiene errores';
            -- Pregunto si la serie contiene errores.
            BEGIN
              select 1 into v_serie_valida from NP_VALIDACION_SERIES_TO
              where  cod_pedido=pCodPedido and num_serie=v_serie
              and estado is null;

            EXCEPTION
              WHEN NO_DATA_FOUND THEN
              null;
            END;

            -- Si la serie no contiene errores, se marca como serie valida.
            IF v_serie_valida=1 then
              update NP_VALIDACION_SERIES_TO set estado='OK'
         	  where  cod_pedido=pCodPedido and num_serie=v_serie;
         	  commit;
            END IF;
         EXCEPTION

            WHEN e_BUSCA_ERROR THEN
               IF NOT GE_ERRORES_PG.MENSAJEERROR(ERRORCOD,ERRORNEG) THEN
                  ERRORNEG := ErrorNoCla;
               END IF;
			   --Debe grabar la serie con error en la tabla NP_VALIDACION_SERIES_TO, ya que despues
			   --se realizan otra operaciones con esa información en la web.
         	   msgError := ERRORNEG;
   		  	   GRABAERROR_VALIDASERIES( cError, pCodPedido,v_lin_det_pedido, v_serie);

			   --Debe grabar el error en el esquema de manejo de errores del  centro de competencia.
               ERRORDES := 'NP_ORIGENVENTA_PR('||'); - ' || SQLERRM;
               NEVENTO  := GE_ERRORES_PG.GRABARPL( NEVENTO, 'NP', 'Error Definido por el sistema', '1.0', USER, 'NP_ORIGENVENTA_PR', sSql, SQLCODE, ERRORDES );

            WHEN Others THEN
         	GRABAERROR_VALIDASERIES( cError, pCodPedido, v_lin_det_pedido,  v_serie);

         END;
         END LOOP;
      CLOSE c_series;

EXCEPTION
    WHEN ERROR_PROCESO THEN
	     if cError > 0 then
		      GRABAERROR_VALIDASERIES( cError, pCodPedido,  v_lin_det_pedido,v_serie);
		 else
              msgError :=  v_serie || msgError_l || ' ORA : ' || SQLCODE ;
         end if;


    WHEN OTHERS THEN
         msgError :=  v_serie || ' '  || SQLERRM || ' ORA : ' || SQLCODE ;

END NP_VALIDASERIES_PR;

FUNCTION NP_VALIDA_NUMERACION_FN(
  EN_serie  		IN	npt_serie_pedido.cod_serie_pedido%type
) RETURN NUMBER
IS

 /*
<Documentación TipoDoc = "Función">
<Elemento Nombre = "NP_VALIDA_MAYORISTA_FN" Lenguaje="PL/SQL" Fecha="10-05-2006" Versión="1.0" Diseñador="Zenén Muñoz" Programador="Zenén Muñoz" Ambiente="BD">
<Retorno>NA</Retorno>
<Descripción>Funcion encargada de validar la existencia del total de series para cada linea de detalle en el pedido</Descripción>
<Parámetros>
<Entrada>
<param nom="EN_codPedido" Tipo="NUMBER">Código del Pedido</param>
<param nom="EN_lindetPedido" Tipo="NUMBER">Número de línea del pedido</param>
<param nom="EN_Cantidadlinea" Tipo="NUMBER">Cantidad de series en la línea del Pedido</param>
</Entrada>
<Salida>
<param></param>
</Salida>
</Parámetros>
</Elemento>
</Documentación>
*/
v_ind_tel                  al_series.ind_telefono%type;

BEGIN

	SELECT COUNT (1)
	  INTO v_ind_tel
	  FROM al_series a
	 WHERE a.ind_telefono > 0
	   AND a.num_serie = EN_serie
	   AND a.num_telefono IS NOT NULL;


   IF v_ind_tel > 0 THEN
      RETURN 1; --Es numerada
   ELSE
      RETURN 0;   -- No es numerada
   END IF;
END NP_VALIDA_NUMERACION_FN;


FUNCTION NP_VALIDA_MAYORISTA_FN(
  EN_codPedido      in npt_detalle_pedido.cod_pedido%type
) RETURN NUMBER
IS

 /*
<Documentación TipoDoc = "Función">
<Elemento Nombre = "NP_VALIDA_MAYORISTA_FN" Lenguaje="PL/SQL" Fecha="10-05-2006" Versión="1.0" Diseñador="Zenén Muñoz" Programador="Zenén Muñoz" Ambiente="BD">
<Retorno>NA</Retorno>
<Descripción>Funcion encargada de validar la existencia del total de series para cada linea de detalle en el pedido</Descripción>
<Parámetros>
<Entrada>
<param nom="EN_codPedido" Tipo="NUMBER">Código del Pedido</param>
<param nom="EN_lindetPedido" Tipo="NUMBER">Número de línea del pedido</param>
<param nom="EN_Cantidadlinea" Tipo="NUMBER">Cantidad de series en la línea del Pedido</param>
</Entrada>
<Salida>
<param></param>
</Salida>
</Parámetros>
</Elemento>
</Documentación>
*/


LV_cod_tipcomis    ve_vendedores.COD_TIPCOMIS%TYPE :=0;
LV_cod_tipcomis_may ged_codigos.COD_VALOR%TYPE :=0;
LN_cod_cliente     NPT_PEDIDO.COD_CLIENTE%TYPE;
CV_VE     	 	   CONSTANT VARCHAR2(3) := 'VE';
CV_VE_TIPCOMIS     CONSTANT VARCHAR2(15) := 'VE_TIPCOMIS';
CV_COD_TIPCOMIS    CONSTANT VARCHAR2(15) := 'COD_TIPCOMIS';

BEGIN

	SELECT a.cod_valor
	INTO LV_cod_tipcomis_may
	FROM  ged_codigos a
	WHERE a.cod_modulo = CV_VE
	AND a.nom_tabla = CV_VE_TIPCOMIS
	AND a.nom_columna = CV_COD_TIPCOMIS;


	SELECT a.cod_cliente
	INTO  LN_cod_cliente
	FROM  NPT_PEDIDO a
	WHERE a.COD_PEDIDO  = EN_codPedido ;

	SELECT count(DISTINCT a.cod_tipcomis)
	INTO LV_cod_tipcomis
	FROM ve_vendedores a
	WHERE a.cod_cliente = LN_cod_cliente
	AND   a.cod_tipcomis = LV_cod_tipcomis_may;

   IF LV_cod_tipcomis > 0 THEN
      RETURN 1; --Es mayorista
   ELSE
      RETURN 0; --Es delear
   END IF;
END NP_VALIDA_MAYORISTA_FN;



/* CO-200605050103 Se incorpora validación del total de lineas del detalle del pedido que se esta grabando */
Function NP_VALIDA_AL_CARGOS_FN(
  EN_codPedido      in npt_detalle_pedido.cod_pedido%type,
  EN_lindetPedido   in npt_detalle_pedido.LIN_DET_PEDIDO%type,
  EN_Cantidadlinea  in npt_detalle_pedido.CAN_DETALLE_PEDIDO%type
) return number
IS

 /*
<Documentación TipoDoc = "Función">
<Elemento Nombre = "VALIDA_AL_CARGOS" Lenguaje="PL/SQL" Fecha="10-05-2006" Versión="1.0" Diseñador="Zenén Muñoz" Programador="Zenén Muñoz" Ambiente="BD">
<Retorno>NA</Retorno>
<Descripción>Funcion encargada de validar la existencia del total de series para cada linea de detalle en el pedido</Descripción>
<Parámetros>
<Entrada>
<param nom="EN_codPedido" Tipo="NUMBER">Código del Pedido</param>
<param nom="EN_lindetPedido" Tipo="NUMBER">Número de línea del pedido</param>
<param nom="EN_Cantidadlinea" Tipo="NUMBER">Cantidad de series en la línea del Pedido</param>
</Entrada>
<Salida>
<param></param>
</Salida>
</Parámetros>
</Elemento>
</Documentación>
*/

LN_Cantidad  npt_detalle_pedido.CAN_DETALLE_PEDIDO%type :=0;

BEGIN

   select CAN_DETALLE_PEDIDO into LN_Cantidad
   from npt_detalle_pedido where cod_pedido = EN_codPedido
   and LIN_DET_PEDIDO = EN_lindetPedido;

   if LN_Cantidad = EN_Cantidadlinea then
      return 1;
   else
      return 0;
   end if;

exception
    WHEN OTHERS THEN
        return 0;
END NP_VALIDA_AL_CARGOS_FN;
/* CO-200605050103 Fin */

------------------------------------------------------------------------

PROCEDURE NP_ORIGENVENTA_PR(evNumSerie  	IN  al_series.num_serie%TYPE,
		  					enTipoProceso	IN PLS_INTEGER,
							svCod_Uso 		OUT al_series.cod_uso%TYPE,
							svDes_Uso 		OUT al_usos.des_uso%TYPE,
							svCod_Articulo 	OUT al_series.cod_articulo%TYPE,
							svDes_Articulo 	OUT al_articulos.des_articulo%TYPE,
							ERRORNEG 	  	OUT VARCHAR2)
/*
<DOC>
<NOMBRE>NP_ORIGENVENTA_PR                               </NOMBRE>
<FECHACREA>16-08-2006                                               </FECHACREA>
<MODULO>      LOGISTICA                                                </MODULO>
<AUTOR>       Cristian Cortes Manzinger                                </AUTOR>
<VERSION>     1.0.0                                                    </VERSION>
<DESCRIPCION> Consultar por el origen de la venta de serie (NPw u Otro)</DESCRIPCION>
<FECHAMOD>    </FECHAMOD>
<DESCMOD>     </DESCMOD>
<ParamEntr>     evNumSerie: Numero de serie								</ParamEntr>
<ParamEntr>     enTipoProceso: Tipo de proceso que llama al servicio	</ParamEntr>
<ParamSal> Codigo de Uso                 </ParamSal>
<ParamSal> Descripcion del Uso                 </ParamSal>
<ParamSal> Codigo de Articulo                 </ParamSal>
<ParamSal> Descripcion de Articulo            </ParamSal>
<ParamSal> ERRORNEG: Descripcion Error Negocio                      </ParamSal>
</DOC>
*/
AS
   CN_Alta CONSTANT PLS_INTEGER := 1;
   CN_Desbloqueo CONSTANT PLS_INTEGER := 2;
   CN_EstadoRecep CONSTANT PLS_INTEGER := 14;

   LN_mayorista PLS_INTEGER;
   LN_cod_cliente npt_pedido.cod_cliente%TYPE;
   LN_cod_pedido npt_pedido.cod_pedido%TYPE;
   LV_cod_tipcomis ve_vendedores.cod_tipcomis%TYPE;
   LV_cod_tipcomis_may ve_vendedores.cod_tipcomis%TYPE;
   LN_cod_estado_flujo npt_estado_pedido.cod_estado_flujo%TYPE;
   --Inc. 37929 Rodrigo Araneda 23/02/2007
   LN_lin_det_pedido npt_serie_pedido.lin_det_pedido%TYPE;
   --Inc. 37929 Rodrigo Araneda 23/02/2007

BEGIN

   IF CN_Alta = enTipoProceso OR CN_Desbloqueo = enTipoProceso THEN

		   BEGIN
			  --Rescatar datos por defecto, como el codigo de la mercaderia dealer. Que es una
			  --validación que se debe hacer para las series.
		     sSql := 'select valor_parametro from npt_parametro';
		     sSql := sSql || ' where alias_parametro = "MER_DEALER"';

		     SELECT a.valor_parametro
			 INTO v_mer_dealer
			 FROM npt_parametro a
		     WHERE a.alias_parametro = 'MER_DEALER';

		     sSql := 'SELECT a.cod_valor FROM  ged_codigos a';
		     sSql := sSql || ' WHERE a.cod_modulo = VE';
			 sSql := sSql || ' AND a.nom_tabla = VE_TIPCOMIS';
			 sSql := sSql || ' AND a.nom_columna = COD_TIPCOMIS';

			 SELECT a.cod_valor
			 INTO LV_cod_tipcomis_may
			 FROM  ged_codigos a
			 WHERE a.cod_modulo = 'VE'
			 AND a.nom_tabla = 'VE_TIPCOMIS'
			 AND a.nom_columna = 'COD_TIPCOMIS';

		   EXCEPTION
			   WHEN NO_DATA_FOUND THEN
			       ERRORCOD := '796';
				   RAISE  e_BUSCA_ERROR;

			   WHEN OTHERS THEN
			       ERRORCOD := '110';
			       RAISE  e_BUSCA_ERROR;
		   END;

		   BEGIN
			 --Validar primero que se encuentre la serie en NPW
			    sSql := 'select cod_pedido into LN_cod_pedido from npt_serie_pedido';
			    sSql := sSql || ' where cod_serie_pedido = ' || evNumSerie;

			    --Ini. Inc. 37929 Rodrigo Araneda 23/02/2007
				--SELECT b.cod_cliente, b.cod_pedido
				--INTO LN_cod_cliente, LN_cod_pedido
				SELECT b.cod_cliente, b.cod_pedido, a.lin_det_pedido
				INTO LN_cod_cliente, LN_cod_pedido, LN_lin_det_pedido
				--Ini. Inc. 37929 Rodrigo Araneda 23/02/2007
				FROM npt_serie_pedido a, npt_pedido b
			    WHERE a.cod_serie_pedido = evNumSerie
				and a.cod_pedido = b.cod_pedido;

		   EXCEPTION
		      WHEN NO_DATA_FOUND THEN
		    	  ERRORCOD := '795';
				  RAISE  e_BUSCA_ERROR;

		      WHEN OTHERS THEN
		       ERRORCOD := '110';
		       RAISE  e_BUSCA_ERROR;
		   END;

		   BEGIN
			 --Validar que el pedido se encuentre  recepsionado.-
			    sSql := 'SELECT a.cod_estado_flujo';
			    sSql := sSql || ' FROM npt_estado_pedido a';
			    sSql := sSql || ' WHERE a.cod_pedido = ' || LN_cod_pedido;
			    sSql := sSql || ' AND a.cod_estado_flujo = ' || CN_EstadoRecep;

				SELECT a.cod_estado_flujo
				INTO  LN_cod_estado_flujo
				FROM npt_estado_pedido a
				WHERE a.cod_pedido = LN_cod_pedido
				AND a.cod_estado_flujo = CN_EstadoRecep;

		   EXCEPTION
		      WHEN NO_DATA_FOUND THEN
		    	  ERRORCOD := '792';
				  RAISE  e_BUSCA_ERROR;

		      WHEN OTHERS THEN
		          ERRORCOD := '110';
		          RAISE  e_BUSCA_ERROR;
		   END;

	   	   -- Valida que el cliente corresponda a un Mayorista .-
		   IF CN_Desbloqueo = enTipoProceso THEN
		   	  BEGIN

			     sSql := 'SELECT COUNT(DISTINCT COD_TIPCOMIS)';
			     sSql := sSql || ' FROM VE_VENDEDORES';
			     sSql := sSql || ' WHERE a.cod_cliente = ' || LN_cod_cliente;

				SELECT COUNT(DISTINCT a.cod_tipcomis)
				INTO LN_mayorista
				FROM ve_vendedores a
				WHERE a.cod_cliente = LN_cod_cliente;

				 IF LN_mayorista = CN_uno THEN
					SELECT DISTINCT a.cod_tipcomis
					INTO LV_cod_tipcomis
					FROM ve_vendedores a
					WHERE a.cod_cliente = LN_cod_cliente;

					IF LV_cod_tipcomis <> LV_cod_tipcomis_may THEN
				        ERRORCOD := '941';
				   	    RAISE  e_BUSCA_ERROR;
					END IF;

				 ELSE
			        ERRORCOD := '941';
			   	    RAISE  e_BUSCA_ERROR;
				 END IF;

			  EXCEPTION
			      WHEN OTHERS THEN
			       ERRORCOD := '110';
			       RAISE  e_BUSCA_ERROR;
			  END;

		   END IF;

		   BEGIN
		   --Validar que exista en la tabla al_series y que el tipo stock sea mercaderia dealer
		      sSql := 'select serie.num_serie, serie.cod_uso, usos.des_uso, serie.cod_articulo, articulos.des_articulo';
		      sSql := sSql || ' from al_series serie, al_usos usos, al_articulos articulos';
		      sSql := sSql || ' where serie.num_serie = ' || evNumSerie;
		      sSql := sSql || ' and serie.cod_uso = usos.cod_uso';
		      sSql := sSql || ' and serie.cod_articulo = articulos.cod_articulo';

			  IF CN_Alta = enTipoProceso THEN
			      SELECT serie.cod_uso svCod_Uso, usos.des_uso , serie.cod_articulo, articulos.des_articulo, serie.tip_stock
			      INTO svCod_Uso, svDes_Uso, svCod_Articulo, svDes_Articulo, v_tip_stock_ori
			      FROM al_series serie, al_usos usos, al_articulos articulos
			      WHERE serie.num_serie = evNumSerie
			      AND serie.cod_uso = usos.cod_uso
			      AND serie.cod_articulo = articulos.cod_articulo;

				  IF v_tip_stock_ori <> v_mer_dealer THEN
				  	   svCod_Uso:='';
					   svDes_Uso:='';
					   svCod_Articulo:='';
					   svDes_Articulo:='';

			           ERRORCOD := '794';
			   	  	   RAISE  e_BUSCA_ERROR;
			      END IF;

			 ELSIF CN_Desbloqueo = enTipoProceso THEN
		  		  SELECT a.cod_uso svCod_Uso, b.des_uso svDes_Uso, a.cod_articulo svCod_Articulo, c.des_articulo svDes_Articulo, a.tip_stock v_tip_stock_ori
				  INTO svCod_Uso, svDes_Uso, svCod_Articulo, svDes_Articulo, v_tip_stock_ori
				  FROM npt_detalle_pedido a, al_usos b, al_articulos c
		  	      WHERE a.cod_pedido = LN_cod_pedido
			      AND a.cod_uso = b.cod_uso
			      AND a.cod_articulo = c.cod_articulo
				  --Ini. Inc. 37929 Rodrigo Araneda 23/02/2007
				  AND a.lin_det_pedido = LN_lin_det_pedido;
				  --Fin Inc. 37929 Rodrigo Araneda 23/02/2007

			 END IF;


		      ERRORCOD := '798';
		      IF NOT GE_ERRORES_PG.MENSAJEERROR(ERRORCOD,ERRORNEG) THEN
		         ERRORNEG := ErrorNoCla;
		      END IF;

		   EXCEPTION
		     WHEN NO_DATA_FOUND THEN
		  	  ERRORCOD := '107';
			  RAISE  e_BUSCA_ERROR;

		      WHEN OTHERS THEN
		       ERRORCOD := '110';
		       RAISE  e_BUSCA_ERROR;
		   END;
	   ELSE
	    	  ERRORCOD := '170';
			  RAISE  e_BUSCA_ERROR;
   	   END IF;

   EXCEPTION

     WHEN e_BUSCA_ERROR THEN
      IF NOT GE_ERRORES_PG.MENSAJEERROR(ERRORCOD,ERRORNEG) THEN
         ERRORNEG := ErrorNoCla;
      END IF;

      ERRORDES := 'NP_ORIGENVENTA_PR('||'); - ' || SQLERRM;
      NEVENTO  := GE_ERRORES_PG.GRABARPL( NEVENTO, 'NP', 'Error Definido por el sistema', '1.0', USER, 'NP_ORIGENVENTA_PR', sSql, SQLCODE, ERRORDES );


     WHEN OTHERS THEN
      ERRORCOD := '110';

      IF NOT GE_ERRORES_PG.MENSAJEERROR(ERRORCOD,ERRORNEG) THEN
         ERRORNEG := ErrorNoCla;
      END IF;

      ERRORDES := 'NP_ORIGENVENTA_PR('||'); - ' || SQLERRM;
      NEVENTO  := GE_ERRORES_PG.GRABARPL( NEVENTO, 'NP', 'Error NO Definido por el sistema', '1.0', USER, 'NP_ORIGENVENTA_PR', sSql, SQLCODE, ERRORDES );

END;

FUNCTION NP_CARACTERVALIDO_FN (EV_CadenaEntrada IN  VARCHAR2,
  							   EV_CadenaValida  IN  VARCHAR2
				) RETURN VARCHAR2
IS
/*
<Documentación TipoDoc = "Función">
<Elemento Nombre = "NP_CARACTERVALIDO_FN" Lenguaje="PL/SQL" Fecha="20-11-2008" Versión="1.0" Diseñador="Zenén Muñoz" Programador="Zenén Muñoz" Ambiente="BD">
<Retorno>NA</Retorno>
<Descripción>Funcion encargada de validar la existencia del total de series para cada linea de detalle en el pedido</Descripción>
<Parámetros>
<Entrada>
<param nom="EV_CadenaEntrada" Tipo="VARCHAR2">Cadena de entrada a corregir</param>
<param nom="EV_CadenaValida" Tipo="VARCHAR2">Cadena de caracteres validos</param>
</Entrada>
<Salida>
<param></param>
</Salida>
</Parámetros>
</Elemento>
</Documentación>
*/

nLargoEntrada   number;
nLargoValida    number;
nIndEntrada     number:=0;
nIndValida      number:=0;
LV_CadenaValida GED_CODIGOS.DES_VALOR%type;
LV_CadenaSalida GED_CODIGOS.DES_VALOR%type :='';

BEGIN

   nLargoEntrada  := length(EV_CadenaEntrada);
   nIndEntrada    := 0;
   nIndValida     := 0;
   if length(EV_CadenaValida) = 0 or length(EV_CadenaValida) is null then
      Select DES_VALOR into LV_CadenaValida
      From GED_CODIGOS
      where cod_modulo = 'NP'
      and NOM_TABLA = 'GED_CODIGOS'
      and NOM_COLUMNA = 'CARACTERVALIDO';
   else
      LV_CadenaValida := EV_CadenaValida;
   end if;

   while nIndEntrada < nLargoEntrada loop
      nIndEntrada  := nIndEntrada + 1;
      nLargoValida := length(LV_CadenaValida);

      while nIndValida < nLargoValida loop
         nIndValida := nIndValida + 1;
         if substr(EV_CadenaEntrada, nIndEntrada, 1) = substr(LV_CadenaValida, nIndValida, 1) then
            LV_CadenaSalida := LV_CadenaSalida || substr(EV_CadenaEntrada, nIndEntrada, 1);
         end if;
      end loop;
      nIndValida := 0;
   end loop;
   RETURN LV_CadenaSalida;

END NP_CARACTERVALIDO_FN;

END NP_TRANSACCIONES_WS_PG;
/
