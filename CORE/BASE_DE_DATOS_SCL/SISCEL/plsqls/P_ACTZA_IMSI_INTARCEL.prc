CREATE OR REPLACE PROCEDURE p_actza_imsi_intarcel
(
 VP_TRANSACCION IN VARCHAR2,
 VP_CODCLIENTE  IN NUMBER,
 VP_ABONADO     IN NUMBER,
 VP_IMSI        IN VARCHAR2,
 VP_ACTABO IN VARCHAR2 := NULL
)
IS
--
-- Procedimiento que actualiza vigencia de los datos en la tabla de interfase
-- Abonados/Tarificacion e inserta nuevo registro con la nueva IMSI
-- debido al cambio de serie para un abonado.
--
--            Los posibles retornos del procedimiento son :
--                - '0' Actualización realizada correctamente
--                -  '1' No existe datos para realizar actualización
--                -  '2' Error al actualización de vigencia
--                 -  '3' Error al insertar nuevo registro con IMSI
--                 - '4' Error al insertar en GA_TRANSACABO
--                  si el abonado es  prepago no se insertara el registro en la ga_intarcel

  V_ERROR                        VARCHAR2(1);
  V_ERRORMSG             VARCHAR2(255);

  V_ROWID                    ROWID;
  V_COD_CLIENTE      GA_INTARCEL.COD_CLIENTE%TYPE;
  V_IND_NUMERO       GA_INTARCEL.IND_NUMERO%TYPE;
  V_IMP_LIMCONSUMO   GA_INTARCEL.IMP_LIMCONSUMO%TYPE;
  V_IND_FRIENDS      GA_INTARCEL.IND_FRIENDS%TYPE;
  V_IND_DIASESP      GA_INTARCEL.IND_DIASESP%TYPE;
  V_COD_CELDA        GA_INTARCEL.COD_CELDA%TYPE;
  V_TIP_PLANTARIF    GA_INTARCEL.TIP_PLANTARIF%TYPE;
  V_COD_PLANTARIF    GA_INTARCEL.COD_PLANTARIF%TYPE;
  V_NUM_CELULAR      GA_INTARCEL.NUM_CELULAR%TYPE;
  V_COD_CARGOBASICO  GA_INTARCEL.COD_CARGOBASICO%TYPE;
  V_COD_CICLO        GA_INTARCEL.COD_CICLO%TYPE;
  V_COD_PLANCOM      GA_INTARCEL.COD_PLANCOM%TYPE;
  V_COD_PLANSERV     GA_INTARCEL.COD_PLANSERV%TYPE;
  V_COD_GRPSERV      GA_INTARCEL.COD_GRPSERV%TYPE;
  V_COD_GRUPO        GA_INTARCEL.COD_GRUPO%TYPE;
  V_COD_PORTADOR     GA_INTARCEL.COD_PORTADOR%TYPE;
  V_COD_USO          GA_INTARCEL.COD_USO%TYPE;
  V_NUM_SERIE        GA_INTARCEL.NUM_SERIE%TYPE;
  V_FEC_SYSDATE      GA_INTARCEL.FEC_HASTA%TYPE;
  V_ALTA             GA_ABOCEL.FEC_ALTA%TYPE;
  V_NUM_ABONADO      GA_ABOCEL.NUM_ABONADO%TYPE;

  IND_VALOR          NUMBER;

  --TOL SIN INTEGRACION - RACB - 24042003
  vErrorAplic VARCHAR2(100);
  vErrorGlosa VARCHAR2(100);
  vErrorOra VARCHAR2(100);
  vErrorOraGlosa VARCHAR2(100);
  vTrace VARCHAR2(100);
  REG_ABOCEL VARCHAR2(1);
  V_FEC_HASTA        GA_INTARCEL.FEC_HASTA%TYPE;
  Vimsi				 GA_INTARCEL.NUM_IMSI%TYPE;    	  --Inc. 73695|01/12/2008|jjr.-
  Vplan_nue			 GA_INTARCEL.COD_PLANTARIF%TYPE;  --Inc. 73695|01/12/2008|jjr.-
  Vcargo_nue		 GA_INTARCEL.COD_CARGOBASICO%TYPE;--Inc. 73695|01/12/2008|jjr.-

 BEGIN



     REG_ABOCEL:='N';
     V_ERROR   := '0';
     V_NUM_ABONADO:=0;

	 --Ini. Inc.- 73695|jjr|01/12/2008
	 Vimsi := null;
     IF VP_IMSI IS NOT NULL then

	 	--comprobar si es una cambio de tecnologia, de esta forma, si es cambio de tecnologia obtener el plan de la ga_abocel
		-- si no es cambio de tecnologia obtener el plan de la ga_intarcel
		Begin
	 	   select num_imsi into vimsi
		   from ga_intarcel
		   where num_abonado = vp_abonado
		   and cod_cliente = vp_codcliente
		   and sysdate between fec_desde and fec_hasta;
		Exception
		when others then
			  Vimsi := null;
		end;
	 END IF;

	 if vimsi is null then --es cambio de tecnologia, obtener el plan de ga_abocel

		 -- INI. PAGC 18-04-2007
		 -- Por cambio de tecnologia con cambio de plan
		 -- Se debe actualizar el plan nuevo en la tabla GA_INTARCEL
		 --     SELECT NUM_ABONADO INTO V_NUM_ABONADO FROM GA_ABOCEL
         SELECT NUM_ABONADO, cod_plantarif,cod_cargobasico
         INTO V_NUM_ABONADO, V_COD_PLANTARIF,V_COD_CARGOBASICO FROM GA_ABOCEL
     	 WHERE NUM_ABONADO = VP_ABONADO;

    	 IF   V_NUM_ABONADO > 0 THEN
         	  V_ERROR    := '0';
              REG_ABOCEL := 'S';
    	END IF;
	else
		--no es cambio de tecnologia, obtener el plan de la ga_intarcel

		V_NUM_ABONADO := VP_ABONADO;

		select cod_plantarif, cod_cargobasico
		into v_cod_plantarif, v_cod_cargobasico
		from ga_intarcel
		where num_abonado =  VP_ABONADO
		and cod_cliente = vp_codcliente
		and sysdate between fec_desde and fec_hasta;

		IF   V_NUM_ABONADO > 0 THEN
        	 V_ERROR    := '0';
             REG_ABOCEL := 'S';
    	END IF;

	end if;

		--Fin. Inc.- 73695|jjr|01/12/2008


 IF  RTRIM(LTRIM(REG_ABOCEL)) = 'S' THEN

      SELECT SYSDATE INTO V_FEC_SYSDATE FROM DUAL;

      V_ERROR := '1'; -- Error indica que no existen datos

      SELECT ROWID,
                   COD_CLIENTE,
                   IND_NUMERO,
                   IMP_LIMCONSUMO,
                   IND_FRIENDS,
                   IND_DIASESP,
                   COD_CELDA,
                   TIP_PLANTARIF,
                   --COD_PLANTARIF, Por cambio de tecnologia con cambio de plan..
                   NUM_CELULAR,
                   --COD_CARGOBASICO, Por cambio de tecnologia con cambio de plan. pagc 11-05-2007
                   COD_CICLO,
                   COD_PLANCOM,
                   COD_PLANSERV,
                   COD_GRPSERV,
                   COD_GRUPO,
                   COD_PORTADOR,
                   COD_USO,
                   NUM_SERIE,
                   FEC_HASTA
      INTO V_ROWID,
                   V_COD_CLIENTE,
                   V_IND_NUMERO,
                   V_IMP_LIMCONSUMO,
                   V_IND_FRIENDS,
                   V_IND_DIASESP,
                   V_COD_CELDA,
                   V_TIP_PLANTARIF,
                   --V_COD_PLANTARIF, Por cambio de tecnologia con cambio de plan ..
                   V_NUM_CELULAR,
                   --V_COD_CARGOBASICO, Por cambio de tecnologia con cambio de plan ..
                   V_COD_CICLO,
                   V_COD_PLANCOM,
                   V_COD_PLANSERV,
                   V_COD_GRPSERV,
                   V_COD_GRUPO,
                   V_COD_PORTADOR,
                   V_COD_USO,
                   V_NUM_SERIE,
                   V_FEC_HASTA
      FROM GA_INTARCEL
      WHERE NUM_ABONADO = VP_ABONADO AND
                        COD_CLIENTE = VP_CODCLIENTE
      AND SYSDATE BETWEEN FEC_DESDE
                        AND FEC_HASTA;

         V_ERROR := '2'; -- Error al actualizar vigencia ga_intarcel

          UPDATE GA_INTARCEL
          SET    GA_INTARCEL.FEC_HASTA =  V_FEC_SYSDATE - (1/(24*60*60))
          WHERE  ROWID=V_ROWID;

         V_ERROR := '3'; -- Error al insertar nuevo registro en ga_intarcel

    INSERT INTO GA_INTARCEL (
                                           COD_CLIENTE,
                                                   NUM_ABONADO,
                                                   IND_NUMERO,
                                                   FEC_DESDE,
                                                   FEC_HASTA,
                                                   IMP_LIMCONSUMO,
                                                   IND_FRIENDS,
                                                   IND_DIASESP,
                                                   COD_CELDA,
                                                   TIP_PLANTARIF,
                                                   COD_PLANTARIF,
                                                   NUM_SERIE,
                                                   NUM_CELULAR,
                                                   COD_CARGOBASICO,
                                                   COD_CICLO,
                                                   COD_PLANCOM,
                                                   COD_PLANSERV,
                                                   COD_GRPSERV,
                                                   COD_GRUPO,
                                                   COD_PORTADOR,
                                                   COD_USO,
                                                   NUM_IMSI
                                                   )
    VALUES                                 (
                                           V_COD_CLIENTE,
                                                   VP_ABONADO,
                                                   V_IND_NUMERO,
                                                   V_FEC_SYSDATE ,
                                                   V_FEC_HASTA, --TO_DATE('31-12-3000','DD-MM-YYYY'),
                                                   V_IMP_LIMCONSUMO,
                                                   V_IND_FRIENDS,
                                                   V_IND_DIASESP,
                                                   V_COD_CELDA,
                                                   V_TIP_PLANTARIF,
                                                   V_COD_PLANTARIF,
                                                   V_NUM_SERIE,
                                                   V_NUM_CELULAR,
                                                   V_COD_CARGOBASICO,
                                                   V_COD_CICLO,
                                                   V_COD_PLANCOM,
                                                   V_COD_PLANSERV,
                                                   V_COD_GRPSERV,
                                                   V_COD_GRUPO,
                                                   V_COD_PORTADOR,
                                                   V_COD_USO,
                                                   VP_IMSI
                                                   );


                IF VP_ACTABO IS NOT NULL
                                THEN
                                    IND_VALOR := 0;
                                        --V_ALTA :=  V_FEC_SYSDATE + (1/(24*60*60));
                                        PV_ACTUALIZA_CAMB_COMERC_PR(V_COD_CLIENTE,
                                                                VP_ABONADO,
                                                                                                IND_VALOR,
                                                                                                VP_ACTABO,
                                                                                                V_FEC_SYSDATE,
                                                                                                vErrorAplic,
                                                                                                vErrorGlosa,
                                                                                                vErrorOra,
                                                                                                vErrorOraGlosa,
                                                                                                vTrace);
                                        IF vErrorAplic = 'FALSE'
                                        THEN
                                                V_ERROR := '4';  -- Error al insertar nuevo registro en ga_intarcel_acciones_to
                                        END IF;
                END IF;

                V_ERROR := '5';  -- Error en PL





        -- Si existen registros con vigencia posterior (a ciclo), por ejemplo, debido
        -- a una Anulación de Siniestro, actualizó IMSI.

		--Ini. Inc.- 73695|jjr|01/12/2008

	 	Vplan_nue  := null;
		Vcargo_nue := null;
		begin
			select a.cod_plantarif, a.cod_cargobasico
			into  Vplan_nue, Vcargo_nue
			from  ga_intarcel a, ga_finciclo b
			where a.cod_cliente = V_COD_CLIENTE
			and   a.num_abonado = VP_ABONADO
			and   a.num_abonado = b.num_abonado
			and   a.cod_plantarif = b.cod_plantarif
			and   a.fec_desde > sysdate;
		exception
		when others then
			 Vplan_nue  := null;
			 Vcargo_nue := null;
		end;

		if vplan_nue is not null then
		   if vplan_nue <>  V_COD_PLANTARIF then
		   	  V_COD_PLANTARIF	:= vplan_nue;
			  V_COD_CARGOBASICO	:= Vcargo_nue;
		   end if;
		end if;

		--Fin. Inc.- 73695|jjr|01/12/2008

        UPDATE GA_INTARCEL SET NUM_IMSI = VP_IMSI
		                      ,COD_PLANTARIF = V_COD_PLANTARIF --Por cambio tecnologia c/cambio plan
		                      ,COD_CARGOBASICO = V_COD_CARGOBASICO  --Por cambio tecnologia c/cambio plan
		               WHERE   COD_CLIENTE = V_COD_CLIENTE AND
		                       NUM_ABONADO = VP_ABONADO AND
		                       FEC_DESDE > V_FEC_HASTA;



        INSERT INTO GA_TRANSACABO (NUM_TRANSACCION,
                                   COD_RETORNO,
                                   DES_CADENA)
                           VALUES (to_number(VP_TRANSACCION),
                                   '0',
                                   NULL);
        -- commit; MAM 13/10/2003 INCIDENCIA MA-111020030243
  END IF;

EXCEPTION
   WHEN NO_DATA_FOUND THEN
                           V_ERROR    := '0';
                           REG_ABOCEL := 'N';
                                   INSERT INTO GA_TRANSACABO (NUM_TRANSACCION,
                                   COD_RETORNO,
                                   DES_CADENA)
                           VALUES (to_number(VP_TRANSACCION),
                                   '0',
                                   NULL);
   WHEN OTHERS THEN
        V_ERRORMSG := SUBSTR(SQLERRM, 1, 254);
        INSERT INTO GA_TRANSACABO (NUM_TRANSACCION,
                                   COD_RETORNO,
                                   DES_CADENA)
                           VALUES (to_number(VP_TRANSACCION),
                                   V_ERROR,
                                   V_ERRORMSG);
END;
/
SHOW ERRORS
