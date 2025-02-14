CREATE OR REPLACE PACKAGE BODY PV_GARANTIA_DOASWAP_PG AS

PROCEDURE PV_GARANTIA_INI
	   (
	   V_Secuencia In Varchar,
	   nAbonado    In Varchar,
	   vCodCausa   In Varchar,
	   nNumSerie   In Varchar,
	   vNomTabla   In Varchar
	   )
Is
   V_Error      Varchar2(1) := '0';
   V_Cadena     Varchar2(255);

   Error_Proceso Exception;

Begin
   V_Error          := '0';
   V_Cadena         := 'OK';

   if vNomTabla = 'GA_ABOAMIST' then
      if vCodCausa = 'GD' then
	     PV_GARANTIA_DOA(nAbonado,nNumSerie,vNomTabla,V_Error,V_Cadena);
	     IF V_Error = '4' then
	  	    RAISE Error_Proceso;
	     end if;
      else
	     PV_GARANTIA_SWAP(nAbonado,vCodCausa,nNumSerie,vNomTabla,V_Error,V_Cadena);
	     IF V_Error = '4' then
	  	    RAISE Error_Proceso;
	     end if;
      end IF;
   else
      V_Error  := '4';
	  V_Cadena := 'ERROR: ESTA CAUSA ES SOLO PARA ABONADOS PREPAGO.';
	  Raise Error_Proceso;
   end if;

Exception
     When Error_Proceso Then
          Insert Into Ga_Transacabo (Num_Transaccion, Cod_Retorno, Des_Cadena)
                             Values (V_Secuencia    , V_Error    , V_Cadena);
          Commit;

END PV_GARANTIA_INI;

PROCEDURE PV_GARANTIA_DOA
	   (
	   nAbonado    In  Varchar,
	   nNumSerie   In  Varchar,
	   vNomTabla   In  Varchar,
	   V_Error     Out Varchar2,
   	   V_Cadena	   Out Varchar2
	   )
Is

   Dfec_Maxima_Alta Ga_Equipaboser.Fec_Alta%type;
   vGarantiaDoa 	ged_Parametros.Val_Parametro%type;

   Error_Proceso Exception;

Begin
   V_Error          := '0';
   V_Cadena         := 'OK';
   Dfec_Maxima_Alta := '';

   PV_PARAMETROS('DIAS_GARANTIA_DOA',vGarantiaDoa);

   PV_BUSCA_FECHA(nAbonado,nNumSerie,vNomTabla,Dfec_Maxima_Alta,V_Error,V_Cadena);

   if V_Error = '4' then
      Raise Error_Proceso;
   End If;

   If Dfec_Maxima_Alta + vGarantiaDoa < Trunc(Sysdate) Then
   	  V_Error  := '4';
	  V_Cadena := 'GARANTIA EXCEDE DE LOS '|| vGarantiaDoa ||' DIAS PERMITIDOS';
	  Raise Error_Proceso;
   End If;

Exception
     When Error_Proceso Then
	 	  DBMS_OUTPUT.PUT_LINE('ERROR PROCESO');

End PV_GARANTIA_DOA;

PROCEDURE PV_GARANTIA_SWAP
	   (
	   nAbonado    In  Varchar,
	   vCodCausa   In  Varchar,
	   nNumSerie   In  Varchar,
	   vNomTabla   In  Varchar,
	   V_Error     Out Varchar2,
   	   V_Cadena	   Out Varchar2
	   )
Is

   Dfec_Maxima_Alta Ga_Equipaboser.Fec_Alta%type;
   vGarantiaMes		ged_Parametros.Val_Parametro%type;
   vGarantiaDia		ged_Parametros.Val_Parametro%type;
   vGarantiaRep		ged_Parametros.Val_Parametro%type;
   vCodCierre 		sp_Hordenes_Reparacion.Cod_Cierre%type;
   dMesesPermitido	number(2);
   nCanReparaciones number(3) := 0;
   vEquIrreparable	Sp_Averias_Orden.num_orden%type;

   Error_Proceso Exception;

Begin
   V_Error          := '0';
   V_Cadena         := 'OK';
   Dfec_Maxima_Alta := '';

   PV_PARAMETROS ('MESES_GARANTIA_SWAP',vGarantiaMes);
   PV_PARAMETROS ('DIAS_GARANTIA_SWAP',vGarantiaDia);
   PV_PARAMETROS ('MESES_REITERA_SWAP',vGarantiaRep);

   PV_BUSCA_FECHA(nAbonado,nNumSerie,vNomTabla,Dfec_Maxima_Alta,V_Error,V_Cadena);

   SELECT MONTHS_BETWEEN(SYSDATE,TRUNC(Dfec_Maxima_Alta)) into dMesesPermitido FROM DUAL;

   if dMesesPermitido <= to_number(vGarantiaMes) then

	   If vCodCausa = 'GI' Then -- Garantia Swap -- Incumplimiento de fecha de compromiso.
	      Begin
		     Select Cod_Cierre
		       Into vCodCierre
		       From Sp_Hordenes_Reparacion
		      Where Num_Serie = nNumSerie;

		     If vCodCierre Is Null Then
		        V_Error  := '4';
		     	v_Cadena := 'NO PUEDE REALIZAR CAMBIO DE SERIE POR ESTA CAUSAL';
		     	Raise Error_Proceso;
		     End If;

		  Exception
		     When No_Data_Found Then
		        V_Error  := '4';
		        V_Cadena := 'ABONADO NO TIENE ORDENES DE REPARACION RELACIONADA A ESTA CAUSA';
		        Raise Error_Proceso;
			 When Others Then
			    V_Error  := '4';
		        V_Cadena := 'PV_GARANTIA_DOASWAP_PR (GS): ERROR AL OBTENER CODIGO DE CIERRE';
		        Raise Error_Proceso;
		  End;

	   elsif vCodCausa = 'GR' then -- En caso de tener mas de una reparacion dentro de los ultimos 3 meses.
	   		 Select Count(*)
			   into nCanReparaciones
			   From Sp_Hordenes_Reparacion
			  Where Num_Serie = nNumSerie
			    And fec_alta between add_months(sysdate , - vGarantiaRep) and sysdate;

			 if nCanReparaciones <= 1 then
			    V_Error  := '4';
		        V_Cadena := 'EN LOS ULTIMOS '|| vGarantiaRep ||' MESES SE HAN REGISTRADO UN TOTAL DE '|| nCanReparaciones ||' REPARACIONES';
		        Raise Error_Proceso;
			 end if;

	   elsif vCodCausa = 'GE' then -- Equipo se encuentra en estado Irreparable.
	   		 begin
	   		    Select a.Num_Orden
			      into vEquIrreparable
			      from Sp_hAverias_Orden a, Sp_Hordenes_Reparacion b
			     where b.num_serie  = nNumSerie
			       and b.num_orden  = a.num_orden
				   and a.cod_averia = 101;

				if vEquIrreparable <> null then
				   Raise Error_Proceso;
				end if;

			 exception
			    when no_data_found then
				V_Error  := '4';
		        V_Cadena := 'SU EQUIPO NO SE ENCUENTRA EN ESTADO IRREPARABLE';
		        Raise Error_Proceso;
			 end;
	   End If;
   else
      V_Error  := '4';
	  V_Cadena := 'PV_GARANTIA_DOASWAP_PR : EXCEDE DE MAXIMO DE MESES '|| dMesesPermitido ||' DE HABILITACION';
	  Raise Error_Proceso;
   end if;

Exception
     When Error_Proceso Then
          DBMS_OUTPUT.PUT_LINE('ERROR PROCESO');

End PV_GARANTIA_SWAP;

PROCEDURE PV_PARAMETROS (
		  				vNomParametro in  Varchar,
						vValParametro out Varchar2
						)
IS

Begin

   Select Val_Parametro
     Into vValParametro
	 From Ged_Parametros
	where Cod_Modulo    = 'GA'
	  And Cod_Producto  = 1
	  And Nom_Parametro = vNomParametro;

END PV_PARAMETROS;

PROCEDURE PV_BUSCA_FECHA (
		  				 nAbonado       in  varchar,
						 nNumSerie 		in  varchar,
						 vNomTabla      in  varchar,
						 vFecActivacion out varchar,
						 v_Error		out varchar,
						 v_Cadena		out varchar
						 )
IS
   vFecAlta      varchar2(10);
   vFecActiva 	 varchar2(10);
   Error_Proceso Exception;
BEGIN
   V_Error          := '0';
   V_Cadena         := 'OK';

   If vNomTabla = 'GA_ABOCEL' Then
   	  Begin
	     Select Trunc(Max(Fec_Alta))
		   Into vFecActivacion
		   From Ga_Equipaboser
          Where Num_Abonado = nAbonado
		    And Num_Serie	= nNumSerie;

	  Exception
	     When No_Data_Found Then
		 	  V_Error  := '4';
			  v_Cadena := 'PV_GARANTIA_DOASWAP_PR (GD): ERROR AL OBTENER FECHA MAXIMA DE ALTA';
			  raise Error_Proceso;
		 End;
   Elsif vNomTabla = 'GA_ABOAMIST' Then
      Begin
	     Select Trunc(Fec_Activacion)
		   Into vFecActiva
		   From Ga_Aboamist
		  Where Num_Abonado = nAbonado
		    And Num_Serie	= nNumSerie;

		 Select trunc(Min(Fec_Alta))
		   Into vFecAlta
		   From Ga_Equipaboser
		  Where Num_Abonado = nAbonado
			And Num_Serie   = nNumSerie;

         if vFecActiva > vFecAlta then
		    vFecActivacion := vFecActiva;
		 else
		    vFecActivacion := vFecAlta;
		 end if;

	  Exception
	     When No_Data_Found Then
		 	  Begin
			     Select trunc(Min(Fec_Alta))
		   		   Into vFecActivacion
		   		   From Ga_Equipaboser
		  		  Where Num_Abonado = nAbonado
				    And Num_Serie   = nNumSerie;
			  exception
			     When No_Data_Found Then
				 	  V_Error  := '4';
					  V_Cadena := 'PV_GARANTIA_DOASWAP_PR (GD): ERROR AL OBTENER FECHA MAXIMA DE ALTA';
					  Raise Error_Proceso;
			  end;
	  End;
   End If;

Exception
   When Error_Proceso Then
   		DBMS_OUTPUT.PUT_LINE('ERROR PROCESO');

END PV_BUSCA_FECHA;

END PV_GARANTIA_DOASWAP_PG;
/
SHOW ERRORS
