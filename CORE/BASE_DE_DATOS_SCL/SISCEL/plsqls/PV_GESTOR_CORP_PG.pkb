CREATE OR REPLACE PACKAGE BODY PV_GESTOR_CORP_PG AS
PROCEDURE pv_bvalCorporativo(splan_tarifario_act 		IN  	VARCHAR2,
                             splan_tarifario_nue 		IN  	VARCHAR2,
				 			 scod_actabo_gestor  		IN  	VARCHAR2,
                             snum_abonado        		IN  	VARCHAR2,
				 			 sactabo_ooss          		IN  	VARCHAR2,
				 			 var_abonado_gestor     	IN      VARCHAR2,
				 			 var_abonado_gestor_def 	IN      VARCHAR2,
							 var_abonado_gestor_OUT     OUT     VARCHAR2,
				 			 var_abonado_gestor_def_OUT OUT     VARCHAR2,
							 scod_servicio				OUT     VARCHAR2,
				 			 scod_servsupl 				OUT	    VARCHAR2,
				 			 scod_nivel 				OUT     VARCHAR2,
							 pvCodValor          	    OUT     VARCHAR2,
                             pvErrorAplic        	    OUT     VARCHAR2,
                             pvErrorGlosa        	    OUT     VARCHAR2,
                             pvErrorOra          	    OUT     VARCHAR2,
                             pvErrorOraGlosa     	    OUT     VARCHAR2,
                             pvTrace             	    OUT     VARCHAR2)
IS
sparametroG    GED_PARAMETROS.VAL_PARAMETRO%TYPE;

ssplan_tarifario_act 	VARCHAR2(3);
ssplan_tarifario_nue 	VARCHAR2(3);
ind_gestor_ant     		VARCHAR2(3);
ind_gestor_nue     		VARCHAR2(3);
tip_rela           		VARCHAR2(1);
VAR_COD_SERPSUPLD  		VARCHAR2(2);
VAR_COD_SERVICIOSD 		VARCHAR2(3);
VAR_COD_NIVELD     		VARCHAR2(4);
VAR_COD_SERPSUPL   		VARCHAR2(2);
VAR_COD_SERVICIOS  		VARCHAR2(3);
VAR_COD_NIVEL	   		VARCHAR2(4);

IND_GESTOR         		NUMBER(9);
ssql 					VARCHAR2(3000);

ERROR_PROCESO EXCEPTION;

BEGIN

   pvCodValor             	    :='NO';
   pvErrorAplic           	  	:='0';
   pvErrorGlosa              	:='*';
   pvErrorOra 				   	:='0';
   pvErrorOraGlosa   		    :='*';
   pvTrace						:='*';

   ssplan_tarifario_act 	    :=splan_tarifario_act ;
   ssplan_tarifario_nue 	    :=splan_tarifario_nue ;
   ind_gestor_ant               := '';
   IND_GESTOR                   := 0;
   VAR_COD_SERVICIOS            :='';
   var_abonado_gestor_OUT       :='FALSE';
   var_abonado_gestor_def_OUT   :='FALSE';

    BEGIN
	    Select VAL_PARAMETRO INTO sparametroG
	    FROM GED_PARAMETROS
	    WHERE NOM_PARAMETRO = 'DEFAULT_GESTOR'
	    AND COD_PRODUCTO = 1
	    AND COD_MODULO = 'GA';

    EXCEPTION
            WHEN NO_DATA_FOUND    Then
            	     pvCodValor      := 'NO';
               	     pvErrorAplic    := '4';
                     pvErrorGlosa    := 'Parametro no encontrado';

	                 RAISE ERROR_PROCESO;
            WHEN OTHERS   Then
            	     pvCodValor      := 'NO';
            	     pvErrorAplic    := '4';
                     pvErrorGlosa    := 'Problemas Acceso GED_PARAMETROS';

					 RAISE ERROR_PROCESO;
    End;




    If RTRIM(LTRIM(scod_actabo_gestor)) = 'GO' Then


	   BEGIN
	          ssql:='';
			  ssql:=' Select B.COD_SERVICIO';
	          ssql:=ssql || ' FROM GAD_SERVSUP_PLAN A , GA_SERVSUPL B';
	          ssql:=ssql || ' WHERE A.COD_PRODUCTO    = 1';
	          ssql:=ssql || ' AND  A.COD_PLANTARIF    = ''' || ssplan_tarifario_nue || ''' ';
	          ssql:=ssql || ' AND  A.COD_SERVICIO     = B.COD_SERVICIO';
	          ssql:=ssql || ' AND  B.ind_gestor       = 1';
	          ssql:=ssql || ' AND  A.TIP_RELACION     IN  (' || sparametroG || ')';
	          ssql:=ssql || ' AND  sysdate between a.fec_desde and a.fec_hasta';

			  EXECUTE IMMEDIATE ssql  INTO ind_gestor_nue;

	          If rtrim(ltrim(ind_gestor_nue)) != ' ' Then
	             If UPPER(rtrim(ltrim(var_abonado_gestor_def))) IN  ('TRUE','VERDADERO') Then

			   	    pvCodValor    :='SI';
	           	    pvErrorAplic  :='0';
	             End If;
			  End If;

	   EXCEPTION
	          WHEN NO_DATA_FOUND    Then
	               If UPPER(rtrim(ltrim(var_abonado_gestor))) IN ('TRUE','VERDADERO') And UPPER(rtrim(ltrim(var_abonado_gestor_def))) IN('FALSE','FALSO') Then

			          pvCodValor    :='SI';
	            	  pvErrorAplic  :='0';
	               End If;
	          WHEN OTHERS    Then

			       pvCodValor    :='NO';
	               pvErrorAplic  :='1';
				   pvErrorGlosa  :='Error de Acceso a GAD_SERVSUP_PLAN/GA_SERVSUPL';

	   End;
    Else

        BEGIN
		      Select a.cod_servicio INTO ind_gestor_ant  from ga_servsuplabo a
		      where  a.num_abonado   =   snum_abonado AND
		             a.ind_estado    < 3              AND
		             a.cod_servicio in (select cod_servicio From ga_servsupl
		       			                where cod_producto = 1 and
		          		                ind_gestor         = 1 and
		          		                cod_servicio       = a.cod_servicio)
		             and rownum = 1;


		       If rtrim(ltrim(ind_gestor_ant)) != ' ' Then

		            Select a.cod_servsupl,a.cod_servicio,a.cod_nivel
		            into VAR_COD_SERPSUPL,VAR_COD_SERVICIOS,VAR_COD_NIVEL
					from ga_servsuplabo a
		            where  a.num_abonado   = snum_abonado  AND
		                   a.ind_estado   <  3             AND
		                   a.cod_servicio =  ind_gestor_ant;

		            If rtrim(ltrim(VAR_COD_SERPSUPL)) !=' ' Then
		               var_abonado_gestor_OUT := 'TRUE';

					   scod_servicio	:= VAR_COD_SERVICIOS;
				 	   scod_servsupl 	:= VAR_COD_SERPSUPL;
				 	   scod_nivel 		:= VAR_COD_NIVEL;

		            End If;

					pvCodValor     := 'SI';
                    pvErrorAplic   := '0';
		            ind_gestor_nue := '0';

		            If scod_actabo_gestor = 'GB' And sactabo_ooss not in ('TP','T2','RO','R2','AE','A2') Then
		               pvCodValor     := 'NO';
                       pvErrorAplic   := '1';

		               BEGIN
					   		   ssql:='';
		                       ssql:= 'Select B.IND_GESTOR,A.TIP_RELACION,B.COD_SERVSUPL,B.COD_SERVICIO,B.COD_NIVEL';
		                       ssql:= ssql || ' FROM GAD_SERVSUP_PLAN A , GA_SERVSUPL B';
		                       ssql:= ssql || ' WHERE A.COD_PRODUCTO     = 1';
		                       ssql:= ssql || ' AND   A.COD_PLANTARIF    = ''' || ssplan_tarifario_nue || ''' ';
		                       ssql:= ssql || ' AND   A.COD_SERVICIO     = B.COD_SERVICIO';
		                       ssql:= ssql || ' AND   A.COD_PRODUCTO     = B.COD_PRODUCTO';
		                       ssql:= ssql || ' AND   B.IND_GESTOR       = 1';
		                       ssql:= ssql || ' AND   A.TIP_RELACION     IN (' || sparametroG || ')';
		                       ssql:= ssql || ' AND   sysdate between a.fec_desde and a.fec_hasta';

							   EXECUTE IMMEDIATE ssql  INTO ind_gestor_nue,tip_rela,VAR_COD_SERPSUPLD,VAR_COD_SERVICIOSD,VAR_COD_NIVELD;

							   ssql:='';
							   ssql:= 'Select a.cod_servicio';
						       ssql:= ssql || ' FROM GAD_SERVSUP_PLAN A';
			                   ssql:= ssql || ' WHERE A.COD_PRODUCTO     = 1';
			                   ssql:= ssql || ' AND  A.COD_PLANTARIF     = ''' || ssplan_tarifario_act ||''' ';
			                   ssql:= ssql || ' AND  A.COD_SERVICIO      = ''' || VAR_COD_SERVICIOS ||''' ';
			                   ssql:= ssql || ' AND A.TIP_RELACION       IN (' || sparametroG || ')';
			                   ssql:= ssql || ' AND sysdate between a.fec_desde and a.fec_hasta';
			                   ssql:= ssql || ' AND rownum = 1';

							   EXECUTE IMMEDIATE ssql  INTO ind_gestor_ant;


		                       If rtrim(ltrim(ind_gestor_ant)) != ' ' then
		                       		var_abonado_gestor_def_OUT := 'TRUE';
		                       End If;

		                       If rtrim(ltrim(ind_gestor_nue)) = '0' And UPPER(rtrim(ltrim(var_abonado_gestor_def))) IN ('TRUE','VERDADERO') Then
		                               pvCodValor     := 'SI';
               	                       pvErrorAplic   := '0';
               	               Else If rtrim(ltrim(ind_gestor_nue))  = '0' And UPPER(rtrim(ltrim(var_abonado_gestor_def))) IN ('FALSE','FALSO') And pv_bValidaNormalTotal(splan_tarifario_nue)='TRUE' Then
		                  	           pvCodValor     := 'SI';
               	                       pvErrorAplic    := '0';
               	                    End If;
							   END IF;

		                 EXCEPTION
		                      	WHEN NO_DATA_FOUND    Then
        				             pvCodValor := 'NO';
               				         pvErrorAplic := '4';
               				         pvErrorOra := TO_CHAR(SQLCODE);
           		     		         pvErrorOraGlosa := SQLERRM;
              			        WHEN OTHERS   Then
		                    	     pvCodValor := 'NO';
               			             pvErrorAplic := '4';
              				         pvErrorOra := TO_CHAR(SQLCODE);
           		     		         pvErrorOraGlosa := SQLERRM;
		                 End;

		            Else

						 BEGIN


							ssql:='';
			                ssql := 'Select a.cod_servicio ';
			                ssql := ssql ||' FROM GAD_SERVSUP_PLAN A';
			                ssql := ssql ||' WHERE A.COD_PRODUCTO    = 1';
			                ssql := ssql ||' AND   A.COD_PLANTARIF   = ''' || ssplan_tarifario_act||''' ';
			                ssql := ssql ||' AND   A.COD_SERVICIO    = ''' || VAR_COD_SERVICIOS ||''' ';
			                ssql := ssql ||' AND   A.TIP_RELACION IN (' || sparametroG || ')' ;
			                ssql := ssql ||' AND   sysdate between a.fec_desde and a.fec_hasta';
			                ssql := ssql ||' AND   rownum = 1';

			                EXECUTE IMMEDIATE ssql  INTO ind_gestor_ant;


		                    If rtrim(ltrim(ind_gestor_ant)) != ' ' Then
		                           var_abonado_gestor_def_OUT := 'TRUE';
		                     	   pvCodValor   := 'SI';
               			           pvErrorAplic := '0';

              			    	   BEGIN
              			   	   	   	  ssql:='';
									  ssql:= 'SELECT B.COD_SERVICIO  FROM GAD_SERVSUP_PLAN A , GA_SERVSUPL B';
              			    	      ssql:= ssql ||' WHERE A.COD_PRODUCTO    = 1';
		                              ssql:= ssql ||' AND  A.COD_PLANTARIF   = ''' || ssplan_tarifario_nue||''' ';
		                     	      ssql:= ssql ||' AND  A.COD_SERVICIO    = B.COD_SERVICIO';
		                     	      ssql:= ssql ||' AND  A.COD_PRODUCTO    = B.COD_PRODUCTO';
		                              ssql:= ssql ||' AND B.IND_GESTOR = 1';
		                              ssql:= ssql ||' AND A.TIP_RELACION IN (' || sparametroG || ')';
		                              ssql:= ssql ||' AND sysdate between a.fec_desde and a.fec_hasta';
		                              ssql:= ssql ||' AND rownum = 1';

									  EXECUTE IMMEDIATE ssql  INTO ind_gestor_nue;

		                     	      pvCodValor   := 'NO';
               			              pvErrorAplic := '0';

		                           EXCEPTION
		                               WHEN  NO_DATA_FOUND    Then
		                           	         pvCodValor   := 'SI';
               			                     pvErrorAplic := '0';
               			           End;

		                   End If;

					     EXCEPTION
  				              WHEN  NO_DATA_FOUND    Then

	                          	         pvCodValor   := 'NO';
               			                 pvErrorAplic := '0';
										 pvErrorOra   := TO_CHAR(SQLCODE);


		                      WHEN  OTHERS    Then

	                          	         pvCodValor   := 'NO';
               			                 pvErrorAplic := '1';
										 pvErrorOra   := TO_CHAR(SQLCODE);

		          	     End;
		            End If;
			   END IF;
	   EXCEPTION
  	          WHEN  NO_DATA_FOUND    Then

	   	            pvCodValor   := 'NO';
               		pvErrorAplic := '0';
					pvErrorOra   := TO_CHAR(SQLCODE);
       End;
	END IF;


	EXCEPTION
        WHEN ERROR_PROCESO
        THEN
		pvCodValor    := 'NO';
       	pvErrorAplic  := '1';


End pv_bvalCorporativo;


PROCEDURE pv_bCorporativo(       snum_abonado        		IN  	VARCHAR2,
                                 scod_actabo_gestor  		IN  	VARCHAR2,
                                 snom_usuarora       		IN  	VARCHAR2,
                                 splan_tarifario_act 		IN  	VARCHAR2,
                                 splan_tarifario_nue 		IN  	VARCHAR2,
                                 stip_movimiento        	IN  	VARCHAR2,
				                 sactabo_ooss           	IN  	VARCHAR2,
				                 var_abonado_gestor     	IN      VARCHAR2,
				                 var_abonado_gestor_def 	IN      VARCHAR2,
								 sNum_SeqTransacabo			IN 		VARCHAR2,
				                 bgenera_comando	    	OUT     VARCHAR2,
								 var_abonado_gestor_OUT     OUT     VARCHAR2,
				 			     var_abonado_gestor_def_OUT OUT     VARCHAR2,
								 pvCodValor          		OUT     VARCHAR2,
                                 pvErrorAplic        		OUT     VARCHAR2,
                                 pvErrorGlosa        		OUT     VARCHAR2,
                                 pvErrorOra          		OUT     VARCHAR2,
                                 pvErrorOraGlosa     		OUT     VARCHAR2,
                                 pvTrace             		OUT     VARCHAR2)
IS
    nNumTran    				NUMBER(9);
	sscod_servicio				VARCHAR2(3);
	sscod_servsupl				VARCHAR2(2);
	sscod_nivel					VARCHAR2(4);
	vvar_abonado_gestor_OUT 	VARCHAR2(5);
	vvar_abonado_gestor_def_OUT VARCHAR2(5);
	sCadCambios_CORP    		VARCHAR2(6);
	VP_SQLCODE          		VARCHAR2(50);
	VP_SQLERRM          		VARCHAR2(50);
	VP_ERROR            		VARCHAR2(50);

BEGIN

    pvCodValor             	    :='NO';
    pvErrorAplic           	  	:='0';
    pvErrorGlosa              	:='*';
    pvErrorOra 				   	:='0';
    pvErrorOraGlosa   		    :='*';
    pvTrace 		   	   	   	:='*';
	sscod_servsupl	   	   	   	:='*';
	sscod_servicio	  			:='*';
	sscod_nivel   	   			:='*';
	vvar_abonado_gestor_OUT 	:='FALSE';
	vvar_abonado_gestor_def_OUT :='FALSE';
	sCadCambios_CORP            :=' ';
	bgenera_comando             :='FALSE';

	pv_bvalCorporativo(splan_tarifario_act,splan_tarifario_nue    ,scod_actabo_gestor,
					snum_abonado          ,sactabo_ooss           ,var_abonado_gestor,
					var_abonado_gestor_def,vvar_abonado_gestor_OUT ,vvar_abonado_gestor_def_OUT ,
					sscod_servicio        ,sscod_servsupl          ,sscod_nivel                 ,
					pvCodValor            ,pvErrorAplic           ,pvErrorGlosa               ,
					pvErrorOra            ,pvErrorOraGlosa,pvTrace);


	if	(rtrim(ltrim(pvCodValor)) = 'NO' AND rtrim(ltrim(pvErrorAplic)) = '0') THEN

		 var_abonado_gestor_OUT 	  := vvar_abonado_gestor_OUT;
		 var_abonado_gestor_def_OUT   := vvar_abonado_gestor_def_OUT;
		 pvCodValor  := 'SI';
	     pvErrorAplic:='0';


    else If (rtrim(ltrim(pvCodValor)) = 'SI' AND rtrim(ltrim(pvErrorAplic)) = '0')THEN


             If rtrim(ltrim(scod_actabo_gestor)) <> 'GO' Then
		       pv_bActDesSS_CORP(snum_abonado,stip_movimiento,sscod_servicio,sscod_servsupl,sscod_nivel,sCadCambios_CORP,
		                         pvCodValor,pvErrorAplic,pvErrorGlosa,pvErrorOra,pvErrorOraGlosa,pvTrace);
             End If;


			 var_abonado_gestor_OUT 	:=vvar_abonado_gestor_OUT;
	         var_abonado_gestor_def_OUT :=vvar_abonado_gestor_def_OUT;

	         BEGIN

	           /*SELECT GA_SEQ_TRANSACABO.NEXTVAL
               INTO nNumTran
               FROM DUAL;*/


			   nNumTran := sNum_SeqTransacabo;


		       PV_PRC_INS_MOVIMIENTO_PR(nNumTran,snum_abonado,scod_actabo_gestor,
			                            snom_usuarora,0,'',sCadCambios_CORP,0,
										VP_SQLCODE,VP_SQLERRM,VP_ERROR);


               IF VP_ERROR = '0' THEN

                      bgenera_comando := 'TRUE';
                      pvCodValor      :='SI';
                      pvErrorAplic    := '0';
					  pvErrorGlosa    :='*';
					  pvErrorOra 	  :='0';
					  pvErrorOraGlosa :='*';
					  pvTrace 		  :='*';
			   else

					  bgenera_comando := 'FALSE';
					  pvErrorOra      := TO_CHAR(SQLCODE);
                      pvCodValor      :='NO';
                      pvErrorAplic    := '1';
               end if;


	          EXCEPTION
                        WHEN OTHERS   THEN
                             pvCodValor     := 'NO';
                 		     pvErrorAplic   := '1';
                             pvErrorGlosa   := 'Problemas al generar N? de Transacion';
                             pvErrorOra     := TO_CHAR(SQLCODE);
           		             pvErrorOraGlosa:= SQLERRM;
              End;
		 else
		 	  var_abonado_gestor_OUT 	  := vvar_abonado_gestor_OUT;
			  var_abonado_gestor_def_OUT  := vvar_abonado_gestor_def_OUT;

	     	  pvCodValor  := 'NO';
	     	  pvErrorAplic:='1';

		 End if;
    End If;
END pv_bCorporativo;



PROCEDURE  pv_bActDesSS_CORP(snum_abonado        	IN  VARCHAR2,
		   		 		 stip_movimiento        IN  VARCHAR2,
 				         scod_servicio		    IN  VARCHAR2,
						 scod_servsupl 		    IN 	VARCHAR2,
				 		 scod_nivel 		    IN  VARCHAR2,
				 		 sCadCambios_CORP       OUT	VARCHAR2,
				 		 pvCodValor		        OUT	VARCHAR2,
				 		 pvErrorAplic		    OUT	VARCHAR2,
				 		 pvErrorGlosa		    OUT	VARCHAR2,
				 		 pvErrorOra		        OUT	VARCHAR2,
				 		 pvErrorOraGlosa	    OUT	VARCHAR2,
				 		 pvTrace		        OUT	VARCHAR2)

IS
sCadCambios VARCHAR2(6);
sGrupo      VARCHAR2(6);
sNivel      VARCHAR2(4);
sServSuplD  VARCHAR2(2);
sCodNivelD  VARCHAR2(4);

BEGIN

sCadCambios_CORP := '';

If stip_movimiento  = 'D' Then
    sCodNivelD := scod_nivel;
    sServSuplD := scod_servsupl;


    sGrupo := SUBSTR('00' + scod_servsupl, LENGTH('00' + scod_servsupl) - 1, 2);
    sNivel := '0000';
    sCadCambios := (sCadCambios + sGrupo + sNivel);

    sCadCambios_CORP := sCadCambios;

    pvCodValor   :='SI';
    pvErrorAplic :='0';

Else
    sGrupo := SUBSTR('00' + scod_servsupl, LENGTH('00' + scod_servsupl) - 1, 2);
    sNivel := SUBSTR('0000' + scod_nivel, LENGTH('0000' + scod_nivel) - 3, 4);
    sCadCambios := (sCadCambios + sGrupo + sNivel);

    sCadCambios_CORP := sCadCambios;

    pvCodValor    :='SI';
    pvErrorAplic  :='0';
End If;

END pv_bActDesSS_CORP;

FUNCTION pv_bValidaNormalTotal      (plantarnortot IN VARCHAR2) RETURN VARCHAR2
IS
	    STIPPLAN    TA_PLANTARIF.COD_TIPLAN%TYPE;
BEGIN
            BEGIN
	            Select COD_TIPLAN INTO STIPPLAN
	            FROM TA_PLANTARIF
	            WHERE COD_PRODUCTO = 1
	            AND COD_PLANTARIF = plantarnortot;

            	    If RTRIM(LTRIM(STIPPLAN)) = '3' Then
               		    RETURN 'TRUE';
                    End If;

             EXCEPTION
             		WHEN NO_DATA_FOUND    Then RETURN 'FALSE';
                        WHEN OTHERS       Then RETURN 'FALSE';

             End;

END pv_bValidaNormalTotal;

END PV_GESTOR_CORP_PG;
/
SHOW ERRORS
