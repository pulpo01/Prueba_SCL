CREATE OR REPLACE PACKAGE BODY PV_AVISO_SINIESTRO_PG IS

FUNCTION RETORNA_VERSION RETURN VARCHAR2 --MODIFICACION 30/11/2004 Alejandro Hott Soporte - TM-200411151097
IS
  p_version    CONSTANT VARCHAR2(3) := '001';
  p_subversion CONSTANT VARCHAR2(3) := '003'; --MODIFICACION 29/11/2004 Alejandro Hott Soporte - TM-200411151097
BEGIN
   RETURN('Version : '||p_version||' <--> SubVersion : '||p_subversion);
END;

PROCEDURE PV_TIPOS_SINIESTRO_PR(EN_num_celular  IN NUMBER,
		  						EV_usuario		IN VARCHAR2,
								tTip_Siniestro  OUT refCursor,
								SV_mensaje		OUT VARCHAR2,
								SV_error 	  	OUT VARCHAR2
)
/*
<DOC>
<NOMBRE>      PV_TIPOS_SINIESTRO_PR                              </NOMBRE>
<FECHACREA>   12/10/2004                                         </FECHACREA>
<MODULO>      POSTVENTA                                          </MODULO>
<AUTOR>       Hector Perez Guzman                                </AUTOR>
<VERSION>     1.0.0                                              </VERSION>
<DESCRIPCION> Obtiene tipos de siniestros posibles      		 </DESCRIPCION>
<DESCRIPCION> segun tecnologia del abonado                     	 </DESCRIPCION>
<FECHAMOD>    			                                         </FECHAMOD>
<DESCMOD>     													 </DESCMOD>
<ParamEntr>   EV_cod_tecnologia: Tecnologia del Abonado          </ParamEntr>
<ParamSal>    tTip_Siniesto: Cursor de Tipos de Siniestros       </ParamSal>
<ParamSal>    SV_error: Codgio Error Controlado                  </ParamSal>
<ParamSal>    SV_proc: Nombre Procedimiento                      </ParamSal>
<ParamSal>    SV_tabla: Nombre Tabla                             </ParamSal>
<ParamSal>    SV_act: Accion Efectuada sobre la Tabla            </ParamSal>
<ParamSal>    SV_sqlcode: Codigo Error Oracle                    </ParamSal>
<ParamSal>    SV_sqlerrm: Mensaje Error Oracle                   </ParamSal>
</DOC>
*/
IS
    GN_cod_tecnologia 	  GA_ABOCEL.COD_TECNOLOGIA%TYPE;
	GN_num_abonado		  GA_ABOCEL.NUM_ABONADO%TYPE;
  	GN_valor 			  NUMBER(1);
	GV_implimcons  		  NUMBER(14,4);
	ERROR_PROCESO		  EXCEPTION;
	B_Ret				  BOOLEAN;

	SV_proc  		      VARCHAR2(50);
	SV_tabla 		      VARCHAR2(50);
	SV_act	  			  VARCHAR2(2);
	SV_sqlcode 			  VARCHAR2(50);
	SV_sqlerrm 			  VARCHAR2(250);

	BEGIN

		SV_error:='0';
		SV_proc := 'PV_TIPOS_SINIESTRO_PR';

   	    IF NOT PV_GENERAL_OOSS_PG.PV_VALIDA_USUARIO_FN(EV_usuario,SV_error, SV_proc,SV_tabla,SV_act,SV_sqlcode,SV_sqlerrm) THEN
		    SV_mensaje := 'Usuario no valido ';
	   	    RAISE ERROR_PROCESO;
	    END IF;

		IF NOT PV_GENERAL_OOSS_PG.PV_VAL_LARGO_CELULAR_FN(EN_num_celular, SV_error, SV_proc, SV_tabla, SV_act, SV_sqlcode, SV_sqlerrm) THEN
		    SV_mensaje :=  'Celular No Cumple Con Largo Definido Por Operadora';
		    RAISE ERROR_PROCESO;
		END IF;

		PV_GENERAL_OOSS_PG.PV_DATOS_ABONADO_PR (EN_num_celular,GV_implimcons,SV_PROC,SV_TABLA,SV_ACT,SV_SQLCODE,SV_SQLERRM,SV_ERROR);
	    IF SV_ERROR = 4 THEN
		   SV_mensaje := 'Celular no existe';
		   RAISE ERROR_PROCESO;
		ELSE
		   GN_cod_tecnologia := PV_GENERAL_OOSS_PG.VP_COD_TECNOLOGIA;
		   GN_num_abonado	  := PV_GENERAL_OOSS_PG.VP_NUM_ABONADO;
		END IF;



		IF SV_ERROR = 0 THEN
			SV_act := 'S';
			SV_tabla := 'GED_CODIGOS';

			OPEN tTip_Siniestro FOR
			SELECT   des_valor
				   	 , cod_valor
			FROM     GED_CODIGOS
			WHERE    cod_modulo  = 'GA'--CV_cod_modulo
			AND      nom_tabla   = 'GA_SINIESTROS'
			AND      nom_columna = 'TIP_SINIESTRO'
			AND      cod_valor LIKE DECODE('GSM',GN_cod_tecnologia,'%','E')
			ORDER BY des_valor ASC;
		ELSE
			RAISE ERROR_PROCESO;
		END IF;

	EXCEPTION
		WHEN ERROR_PROCESO THEN

			SV_error := 4;
			SV_sqlcode := SQLCODE;
			SV_sqlerrm := SQLERRM;
			IF GN_num_abonado = '' OR LTRIM(RTRIM(GN_num_abonado)) IS NULL THEN
			    GN_num_abonado := -1;
			END IF;
			B_Ret:= PV_GENERAL_OOSS_PG.PV_GA_ERRORES_FN(GN_num_abonado,PV_GENERAL_OOSS_PG.CV_cod_actabo,PV_GENERAL_OOSS_PG.CN_cod_producto,SV_error, SV_proc,SV_tabla,SV_act,SV_sqlcode,SV_sqlerrm, SV_sqlcode,SV_sqlerrm);

		WHEN OTHERS THEN
			SV_error := 4;
			SV_sqlcode := SQLCODE;
			SV_sqlerrm := SQLERRM;
			SV_mensaje := 'Error en Ejecucion ';
			IF GN_num_abonado = '' OR LTRIM(RTRIM(GN_num_abonado)) IS NULL THEN
			    GN_num_abonado := -1;
			END IF;
			B_Ret:= PV_GENERAL_OOSS_PG.PV_GA_ERRORES_FN(GN_num_abonado,PV_GENERAL_OOSS_PG.CV_cod_actabo,PV_GENERAL_OOSS_PG.CN_cod_producto,SV_error, SV_proc,SV_tabla,SV_act,SV_sqlcode,SV_sqlerrm, SV_sqlcode,SV_sqlerrm);

END PV_TIPOS_SINIESTRO_PR;

-----------------------------------------------------------------------

PROCEDURE PV_TIPO_SUSPENSION_PR(EV_tipo_siniestro  IN VARCHAR2,
		  						EV_usuario		   IN VARCHAR2,
								tTip_Suspension    OUT refCursor,
								SV_mensaje		   OUT VARCHAR2,
								SV_error 		   OUT VARCHAR2
)
/*
<DOC>
<NOMBRE>      PPV_TIPO_SUSPENSION_PR                             </NOMBRE>
<FECHACREA>   12/10/2004                                         </FECHACREA>
<MODULO>      POSTVENTA                                          </MODULO>
<AUTOR>       Hector Perez Guzman                                </AUTOR>
<VERSION>     1.0.0                                              </VERSION>
<DESCRIPCION> Obtiene tipos de suspension segun codigo de siniestro</DESCRIPCION>
<FECHAMOD>    		                                             </FECHAMOD>
<DESCMOD>     													 </DESCMOD>
<ParamEntr>   EV_cod_tecnologia: Tecnologia del Abonado          </ParamEntr>
<ParamSal>    tTip_Siniesto: Cursor de Tipos de Siniestros       </ParamSal>
<ParamSal>    SV_error: Codgio Error Controlado                  </ParamSal>
<ParamSal>    SV_proc: Nombre Procedimiento                      </ParamSal>
<ParamSal>    SV_tabla: Nombre Tabla                             </ParamSal>
<ParamSal>    SV_act: Accion Efectuada sobre la Tabla            </ParamSal>
<ParamSal>    SV_sqlcode: Codigo Error Oracle                    </ParamSal>
<ParamSal>    SV_sqlerrm: Mensaje Error Oracle                   </ParamSal>
</DOC>
*/
IS
    ERROR_PROCESO    EXCEPTION;
	B_tipo			 BOOLEAN;

	SV_proc  		      VARCHAR2(50);
	SV_tabla 		      VARCHAR2(50);
	SV_act	  			  VARCHAR2(2);
	SV_sqlcode 			  VARCHAR2(50);
	SV_sqlerrm 			  VARCHAR2(250);
	GN_num_abonado		  GA_ABOCEL.NUM_ABONADO%TYPE;
	B_Ret				  BOOLEAN;

	BEGIN

		SV_error:='0';
		SV_proc := 'PV_TIPO_SUSPENSION_PR';

   	    IF NOT PV_GENERAL_OOSS_PG.PV_VALIDA_USUARIO_FN(EV_usuario,SV_error, SV_proc,SV_tabla,SV_act,SV_sqlcode,SV_sqlerrm) THEN
	   	   RAISE ERROR_PROCESO;
	    END IF;

		SV_act := 'S';
		SV_tabla := 'GED_CODIGOS';
		B_tipo := TRUE;
		IF EV_tipo_siniestro <> 'A' AND EV_tipo_siniestro <> 'S' AND EV_tipo_siniestro <> 'E' THEN
		   SV_sqlerrm := 4;
		   B_tipo := FALSE;
		   RAISE ERROR_PROCESO;
		END IF;

		OPEN tTip_Suspension FOR
		SELECT des_valor
			   , cod_valor
		FROM   GED_CODIGOS
		WHERE  cod_modulo = PV_GENERAL_OOSS_PG.CV_cod_modulo
		AND    nom_tabla = 'GA_SINIESTROS'
		AND    nom_columna = 'TIP_SUSPENSION'
		AND    cod_valor IN (DECODE('A',DECODE('S',EV_tipo_siniestro,'A','A'),1,0),DECODE('E',EV_tipo_siniestro,0,1),DECODE('E',EV_tipo_siniestro,1,1))
		ORDER BY DES_VALOR ASC;

	EXCEPTION
		WHEN ERROR_PROCESO THEN
			SV_error := 4;
			IF NOT B_tipo THEN
			   SV_mensaje := 'Tipo de Siniestro Incorrecto';
			ELSE
			   SV_mensaje := 'Usuario no valido ';
			END IF;

			IF GN_num_abonado = '' OR LTRIM(RTRIM(GN_num_abonado)) IS NULL THEN
			    GN_num_abonado := -1;
			END IF;
			B_Ret:= PV_GENERAL_OOSS_PG.PV_GA_ERRORES_FN(GN_num_abonado,PV_GENERAL_OOSS_PG.CV_cod_actabo,PV_GENERAL_OOSS_PG.CN_cod_producto,SV_error, SV_proc,SV_tabla,SV_act,SV_sqlcode,SV_sqlerrm, SV_sqlcode,SV_sqlerrm);

		WHEN OTHERS THEN
			SV_error := 4;
			SV_sqlcode := SQLCODE;
			SV_sqlerrm := SQLERRM;

			IF GN_num_abonado = '' OR LTRIM(RTRIM(GN_num_abonado)) IS NULL THEN
			    GN_num_abonado := -1;
			END IF;
			B_Ret:= PV_GENERAL_OOSS_PG.PV_GA_ERRORES_FN(GN_num_abonado,PV_GENERAL_OOSS_PG.CV_cod_actabo,PV_GENERAL_OOSS_PG.CN_cod_producto,SV_error, SV_proc,SV_tabla,SV_act,SV_sqlcode,SV_sqlerrm, SV_sqlcode,SV_sqlerrm);


END PV_TIPO_SUSPENSION_PR;

-----------------------------------------------------------------------

PROCEDURE PV_CAUSA_SINIESTRO_PR(EN_num_celular  IN NUMBER,
		  						EV_usuario		IN VARCHAR2,
								tCausa_Siniestro   OUT refCursor,
								SV_mensaje         OUT VARCHAR2,
								SV_error 		   OUT VARCHAR2
)
/*
<DOC>
<NOMBRE>      PV_CAUSA_SINIESTRO_PR                             </NOMBRE>
<FECHACREA>   12/10/2004                                         </FECHACREA>
<MODULO>      POSTVENTA                                          </MODULO>
<AUTOR>       Hector Perez Guzman                                </AUTOR>
<VERSION>     1.0.0                                              </VERSION>
<DESCRIPCION> Obtiene tipos de suspension segun codigo de siniestro</DESCRIPCION>
<FECHAMOD>    		                                             </FECHAMOD>
<DESCMOD>     													 </DESCMOD>
<ParamEntr>   EV_cod_tecnologia: Tecnologia del Abonado          </ParamEntr>
<ParamSal>    tTip_Siniesto: Cursor de Tipos de Siniestros       </ParamSal>
<ParamSal>    SV_error: Codgio Error Controlado                  </ParamSal>
<ParamSal>    SV_proc: Nombre Procedimiento                      </ParamSal>
<ParamSal>    SV_tabla: Nombre Tabla                             </ParamSal>
<ParamSal>    SV_act: Accion Efectuada sobre la Tabla            </ParamSal>
<ParamSal>    SV_sqlcode: Codigo Error Oracle                    </ParamSal>
<ParamSal>    SV_sqlerrm: Mensaje Error Oracle                   </ParamSal>
</DOC>
*/
IS
  	GV_cod_plantarif 	  GA_ABOCEL.COD_PLANTARIF%TYPE;
	GV_cod_tecnologia	  GA_ABOCEL.COD_TECNOLOGIA%TYPE;
	GN_num_abonado		  GA_ABOCEL.NUM_ABONADO%TYPE;
	GV_implimcons  		  NUMBER(14,4);
	GV_cod_servicio		  VARCHAR2(3);

	SV_proc  		      VARCHAR2(50);
	SV_tabla 		      VARCHAR2(50);
	SV_act	  			  VARCHAR2(2);
	SV_sqlcode 			  VARCHAR2(50);
	SV_sqlerrm 			  VARCHAR2(250);

	ERROR_PROCESO EXCEPTION;

	SV_cod_servicio 	  PV_SERV_SUSPREHA_TO.COD_SERVICIO%TYPE;
	b_Ret				  BOOLEAN;

	BEGIN

		SV_error:='0';
		SV_proc := 'PV_CAUSA_SINIESTRO_PR';

   	    IF NOT PV_GENERAL_OOSS_PG.PV_VALIDA_USUARIO_FN(EV_usuario,SV_error, SV_proc,SV_tabla,SV_act,SV_sqlcode,SV_sqlerrm) THEN
	   	    SV_mensaje :=  'Usuario no valido ';
		    RAISE ERROR_PROCESO;
	    END IF;

		IF NOT PV_GENERAL_OOSS_PG.PV_VAL_LARGO_CELULAR_FN(EN_num_celular, SV_error, SV_proc, SV_tabla, SV_act, SV_sqlcode, SV_sqlerrm) THEN
		    SV_mensaje :=  'Celular No Cumple Con Largo Definido Por Operadora';
		    RAISE ERROR_PROCESO;
		END IF;

		PV_GENERAL_OOSS_PG.PV_DATOS_ABONADO_PR (EN_num_celular,GV_implimcons,SV_PROC,SV_TABLA,SV_ACT,SV_SQLCODE,SV_SQLERRM,SV_ERROR);
	    IF SV_ERROR = 4 THEN
		   SV_mensaje := 'Celular no existe';
		   RAISE ERROR_PROCESO;
		ELSE
			GV_cod_plantarif :=  PV_GENERAL_OOSS_PG.VP_COD_PLANTARIF;
			GV_cod_tecnologia := PV_GENERAL_OOSS_PG.VP_COD_TECNOLOGIA;
			GN_num_abonado	  := PV_GENERAL_OOSS_PG.VP_NUM_ABONADO;
		END IF;

		SV_act := 'S';
		SV_tabla := 'PV_SERV_SUSPREHA_TO / TA_PLANTARIF';

		SELECT a.cod_servicio
		INTO   GV_cod_servicio
		FROM   PV_SERV_SUSPREHA_TO a
		WHERE  a.cod_producto = 1
		AND    a.cod_modulo = PV_GENERAL_OOSS_PG.CV_cod_modulo
		AND EXISTS (SELECT b.cod_tiplan
				    FROM TA_PLANTARIF b
		            WHERE b.cod_producto = 1
		            AND   b.cod_plantarif = GV_cod_plantarif
		            AND   a.cod_tiplan = b.cod_tiplan)
		AND a.cod_tecnologia = GV_cod_tecnologia
		AND a.cod_actabo = PV_GENERAL_OOSS_PG.CV_cod_actabo;

		SV_tabla := 'GA_CAUSINIE';
		OPEN tCausa_Siniestro FOR
		SELECT des_causa
		, cod_causa
		, cod_servicio--GV_cod_servicio --MODIFICACION 30/11/2004 Alejandro Hott Soporte - TM-200411151097
		, GV_cod_servicio
		, cod_caususp
		FROM
		GA_CAUSINIE
		WHERE
		cod_producto = PV_GENERAL_OOSS_PG.CN_cod_producto --MODIFICACION 30/11/2004 Alejandro Hott Soporte - TM-200411151097
		and cod_servicio = GV_cod_servicio; --MODIFICACION 30/11/2004 Alejandro Hott Soporte - TM-200411151097

	EXCEPTION
		WHEN ERROR_PROCESO THEN
			SV_error := 4;
			SV_sqlcode := SQLCODE;
			SV_sqlerrm := SQLERRM;
			IF GN_num_abonado = '' OR LTRIM(RTRIM(GN_num_abonado)) IS NULL THEN
			    GN_num_abonado := -1;
			END IF;
			b_Ret:= PV_GENERAL_OOSS_PG.PV_GA_ERRORES_FN(GN_num_abonado,PV_GENERAL_OOSS_PG.CV_cod_actabo,PV_GENERAL_OOSS_PG.CN_cod_producto,SV_error, SV_proc, SV_tabla, SV_act, SV_sqlcode, SV_sqlerrm,  SV_sqlcode, SV_sqlerrm);
		WHEN OTHERS THEN
			SV_error := 4;
			SV_sqlcode := SQLCODE;
			SV_sqlerrm := SQLERRM;
			IF GN_num_abonado = '' OR LTRIM(RTRIM(GN_num_abonado)) IS NULL THEN
			    GN_num_abonado := -1;
			END IF;
			b_Ret:= PV_GENERAL_OOSS_PG.PV_GA_ERRORES_FN(GN_num_abonado,PV_GENERAL_OOSS_PG.CV_cod_actabo,PV_GENERAL_OOSS_PG.CN_cod_producto,SV_error, SV_proc, SV_tabla, SV_act, SV_sqlcode, SV_sqlerrm,  SV_sqlcode, SV_sqlerrm);

END PV_CAUSA_SINIESTRO_PR;

-------------------------------------------------------------------------

FUNCTION PV_ASIGNA_CARGOS_FN  	   ( EN_cod_cliente		 IN GA_ABOCEL.COD_CLIENTE%TYPE,
									 EV_cod_planserv	 IN GA_ABOCEL.COD_PLANSERV%TYPE,
   									 EN_num_abonado    	 IN GA_ABOCEL.NUM_ABONADO%TYPE,
									 EN_num_terminal   	 IN GA_ABOCEL.NUM_CELULAR%TYPE,
									 ED_fec_alta       	 IN GA_ABOCEL.FEC_ALTA%TYPE,
									 EV_usuario        	 IN GE_CARGOS.NOM_USUARORA%TYPE,
									 SV_error           OUT VARCHAR2,
									 SV_proc            OUT VARCHAR2,
					          	  	 SV_tabla           OUT VARCHAR2,
					           	  	 SV_act     	    OUT VARCHAR2,
					           	  	 SV_sqlcode         OUT VARCHAR2,
					           	  	 SV_sqlerrm         OUT VARCHAR2
					           	  	 ) RETURN BOOLEAN


/*
<DOC>
<NOMBRE>      PV_ASIGNA_CARGOS_PR                           </NOMBRE>
<FECHACREA>   14/10/2004                                         </FECHACREA>
<MODULO>      POSTVENTA                                          </MODULO>
<AUTOR>       Hector Perez Guzman                                </AUTOR>
<VERSION>     1.0.0                                              </VERSION>
<DESCRIPCION> 													 </DESCRIPCION>
<FECHAMOD>    		                                             </FECHAMOD>
<DESCMOD>     													 </DESCMOD>
<ParamEntr>             										 </ParamEntr>
<ParamSal>           											 </ParamSal>
<ParamSal>    SV_error: Codgio Error Controlado                  </ParamSal>
<ParamSal>    SV_proc: Nombre Procedimiento                      </ParamSal>
<ParamSal>    SV_tabla: Nombre Tabla                             </ParamSal>
<ParamSal>    SV_act: Accion Efectuada sobre la Tabla            </ParamSal>
<ParamSal>    SV_sqlcode: Codigo Error Oracle                    </ParamSal>
<ParamSal>    SV_sqlerrm: Mensaje Error Oracle                   </ParamSal>
</DOC>
*/
IS
  GB_ret		  BOOLEAN;
  GN_codciclfact  FA_CICLFACT.COD_CICLFACT%TYPE;
  GV_codplancom   GA_CLIENTE_PCOM.COD_PLANCOM%TYPE;
  SV_codconcepto  GA_ACTUASERV.COD_CONCEPTO%TYPE;
  SV_codmoneda	  GA_TARIFAS.COD_MONEDA%TYPE;
  SV_imptarifa	  GA_TARIFAS.IMP_TARIFA%TYPE;
  vn_CodActuacion VARCHAR2(2) := 'FO';
  v_Cursor		  refCursor;

BEGIN
	   SV_error   := '0';
	   SV_proc 	  := 'PV_ASIGNA_CARGOS_PR';
	   SV_act 	  := '';
	   SV_tabla   := '';


  	   GN_codciclfact := PV_GENERAL_OOSS_PG.PV_RECUPERA_CICLO_FACT_FN(EN_cod_cliente,SV_error, SV_proc,SV_tabla,SV_act,SV_sqlcode,SV_sqlerrm);
	   GV_codplancom  := PV_GENERAL_OOSS_PG.PV_RECUPERA_PLAN_COMERCIAL_FN(EN_cod_cliente,SV_error, SV_proc,SV_tabla,SV_act,SV_sqlcode,SV_sqlerrm);
	   BEGIN
       		GB_ret:= PV_GENERAL_OOSS_PG.PV_CARGOS_FN(PV_GENERAL_OOSS_PG.CN_cod_producto,PV_GENERAL_OOSS_PG.CV_cod_actabo,EV_cod_planserv,SV_codconcepto,SV_codmoneda,SV_imptarifa,SV_error, SV_proc,SV_tabla,SV_act,SV_sqlcode,SV_sqlerrm);
	   EXCEPTION
	   		WHEN OTHERS THEN
				 NULL;
	   END;
       IF SV_imptarifa > 0 THEN
		   GB_ret:= PV_GENERAL_OOSS_PG.PV_INSERTA_CARGOS_FN(EN_cod_cliente,PV_GENERAL_OOSS_PG.CN_cod_producto,EN_num_abonado,EN_num_terminal,GV_codplancom,ED_fec_alta,GN_codciclfact,SV_codconcepto,
								                           SV_imptarifa,SV_codmoneda,EV_usuario,SV_error, SV_proc,SV_tabla,SV_act,SV_sqlcode,SV_sqlerrm);
	       GB_ret:= PV_GENERAL_OOSS_PG.PV_UPD_CARGOS_FN(EN_cod_cliente,EN_num_abonado,GN_codciclfact,SV_error, SV_proc,SV_tabla,SV_act,SV_sqlcode,SV_sqlerrm);
	   END IF;
       RETURN TRUE;
	   EXCEPTION
				WHEN OTHERS THEN
			 		 SV_error := 4;
					 SV_sqlcode := SQLCODE;
			 		 SV_sqlerrm := SQLERRM;
	   				 RETURN FALSE;


END PV_ASIGNA_CARGOS_FN;

-------------------------------------------------------------------------

FUNCTION PV_RECUPERA_TIPO_ESTADO_FN(EN_num_ooss  IN NUMBER,
		  							EN_cod_estado      IN NUMBER,
									SV_tipo_estado     OUT VARCHAR2,
									SV_error 		   OUT VARCHAR2,
									SV_proc  		   OUT VARCHAR2,
									SV_tabla 		   OUT VARCHAR2,
									SV_act	  		   OUT VARCHAR2,
									SV_sqlcode 		   OUT VARCHAR2,
									SV_sqlerrm 		   OUT VARCHAR2
)RETURN BOOLEAN
/*
<DOC>
<NOMBRE>      PV_RECUPERA_ESTADO_OOSS_FN                         </NOMBRE>
<FECHACREA>   13/10/2004                                         </FECHACREA>
<MODULO>      POSTVENTA                                          </MODULO>
<AUTOR>       Hector Perez Guzman                                </AUTOR>
<VERSION>     1.0.0                                              </VERSION>
<DESCRIPCION> </DESCRIPCION>
<FECHAMOD>    		                                             </FECHAMOD>
<DESCMOD>     													 </DESCMOD>
<ParamEntr>             </ParamEntr>
<ParamSal>           </ParamSal>
<ParamSal>    SV_error: Codgio Error Controlado                  </ParamSal>
<ParamSal>    SV_proc: Nombre Procedimiento                      </ParamSal>
<ParamSal>    SV_tabla: Nombre Tabla                             </ParamSal>
<ParamSal>    SV_act: Accion Efectuada sobre la Tabla            </ParamSal>
<ParamSal>    SV_sqlcode: Codigo Error Oracle                     </ParamSal>
<ParamSal>    SV_sqlerrm: Mensaje Error Oracle                    </ParamSal>
</DOC>
*/
IS
	BEGIN

		RETURN TRUE;

		SV_error:='0';
		SV_proc := 'PV_RECUPERA_TIPO_ESTADO_FN';

		SV_act := 'S';
		SV_tabla := 'PV_IORSERV';

		SELECT tip_estado
		INTO SV_tipo_estado
		FROM PV_ERECORRIDO
		WHERE  num_os     = EN_num_ooss
		AND    cod_estado = EN_cod_estado
		UNION
		SELECT tip_estado
		FROM PVH_ERECORRIDO
		WHERE  num_os     = EN_num_ooss
		AND    cod_estado = EN_cod_estado;

	EXCEPTION
		WHEN NO_DATA_FOUND THEN
			 RETURN FALSE;
 			 SV_error := 4;
			 SV_sqlcode := SQLCODE;
			 SV_sqlerrm := 'NO SE ENCONTRO TIPO DE ESTADO';
		WHEN OTHERS THEN
			 SV_error := 4;
			 SV_sqlcode := SQLCODE;
			 SV_sqlerrm := SQLERRM;

END PV_RECUPERA_TIPO_ESTADO_FN;

-----------------------------------------------------------------

FUNCTION PV_RECUPERA_ESTADO_OOSS_FN(EN_num_ooss  IN NUMBER,
									SV_estado_ooss     OUT VARCHAR2,
									SV_error 		   OUT VARCHAR2,
									SV_proc  		   OUT VARCHAR2,
									SV_tabla 		   OUT VARCHAR2,
									SV_act	  		   OUT VARCHAR2,
									SV_sqlcode 		   OUT VARCHAR2,
									SV_sqlerrm 		   OUT VARCHAR2
)RETURN BOOLEAN
/*
<DOC>
<NOMBRE>      PV_RECUPERA_ESTADO_OOSS_FN                         </NOMBRE>
<FECHACREA>   13/10/2004                                         </FECHACREA>
<MODULO>      POSTVENTA                                          </MODULO>
<AUTOR>       Hector Perez Guzman                                </AUTOR>
<VERSION>     1.0.0                                              </VERSION>
<DESCRIPCION> </DESCRIPCION>
<FECHAMOD>    		                                             </FECHAMOD>
<DESCMOD>     													 </DESCMOD>
<ParamEntr>             </ParamEntr>
<ParamSal>           </ParamSal>
<ParamSal>    SV_error: Codgio Error Controlado                  </ParamSal>
<ParamSal>    SV_proc: Nombre Procedimiento                      </ParamSal>
<ParamSal>    SV_tabla: Nombre Tabla                             </ParamSal>
<ParamSal>    SV_act: Accion Efectuada sobre la Tabla            </ParamSal>
<ParamSal>    SV_sqlcode: Codigo Error Oracle                    </ParamSal>
<ParamSal>    SV_sqlerrm: Mensaje Error Oracle                   </ParamSal>
</DOC>
*/
IS
  	GN_cod_estado  PV_IORSERV.COD_ESTADO%TYPE;
	GN_tip_estado  PV_ERECORRIDO.TIP_ESTADO%TYPE;

	BEGIN
		SV_error:='0';
		SV_proc := 'PV_RECUPERA_ESTADO_OOSS_FN';

		SV_act := 'S';
		SV_tabla := 'PV_IORSERV/PV_ERECORRIDO';

		SELECT a.cod_estado
			  ,b.tip_estado
		INTO   GN_cod_estado
			  ,GN_tip_estado
		FROM   PV_IORSERV a, PV_ERECORRIDO b
		WHERE  a.num_os = b.num_os
		AND    a.cod_estado = b.cod_estado
		--AND    (a.num_ospadre IS NOT NULL or a.num_os = a.num_ospadre)
		AND    a.cod_modgener = 'ACF'
		AND    a.cod_os       = CN_cod_ooss
		and    a.num_os = EN_num_ooss
		--Inicio Modificacion - ACB - 09/02/2005 - TM-200502081255
		UNION
		SELECT a.cod_estado
			  ,b.tip_estado
		FROM   PVH_IORSERV a, PVH_ERECORRIDO b
		WHERE  a.num_os = b.num_os
		AND    a.cod_estado = b.cod_estado
		AND    a.cod_modgener = 'ACF'
		AND    a.cod_os       = CN_cod_ooss
		and    a.num_os = EN_num_ooss;
 		--Fin Modificacion - ACB - 09/02/2005 - TM-200502081255

		IF GN_cod_estado = 10 THEN
		-- Inicio Modificacion TM-200502141271 - 23/02/2005 - JJR.-
		-- SV_estado_ooss := 'ORDEN DE SERVICIO PENDIENTE';
		    SV_estado_ooss := 'Robo/Extravio en Proceso';
		-- Fin Modificacion TM-200502141271 - 23/02/2005 - JJR.-
		ELSE
		    IF GN_cod_estado >= 15 AND GN_cod_estado <= 950 THEN
			    IF GN_tip_estado = 4 THEN
			    -- Inicio Modificacion TM-200502141271 - 23/02/2005 - JJR.-
			        -- SV_estado_ooss := 'EN PROCESO / ERROR';
			   	   SV_estado_ooss := 'Transaccion Erronea';
			    -- Fin Modificacion TM-200502141271 - 23/02/2005 - JJR.-
			    ELSE
			    -- Inicio Modificacion TM-200502141271 - 23/02/2005 - JJR.-
				   --  SV_estado_ooss := 'EN PROCESO';
				       SV_estado_ooss := 'Transaccion en Proceso';
			    -- Fin Modificacion TM-200502141271 - 23/02/2005 - JJR.-
			    END IF;
			ELSE
			    IF GN_cod_estado >= 950 AND GN_cod_estado <= 999 THEN
			        -- Inicio Modificacion TM-200502141271 - 23/02/2005 - JJR.-
				-- SV_estado_ooss := 'ORDEN DE SERVICIO FINALIZADA';
				   SV_estado_ooss := 'Transaccion Exitosa';
				-- Fin Modificacion TM-200502141271 - 23/02/2005 - JJR.-
				END IF;
			END IF;
		END IF;
		RETURN TRUE;
	EXCEPTION
		WHEN NO_DATA_FOUND THEN
		         --Inicio Modificacion - ACB - 09/02/2005 - TM-200502081255
			 --RETURN FALSE;
 			 --Fin Modificacion - ACB - 09/02/2005 - TM-200502081255
 			 SV_error := 4;
			 SV_sqlcode := SQLCODE;
			 SV_sqlerrm := 'NO SE LOGRO RECUPERAR ESTADO DE OOSS';
			 --Inicio Modificacion - ACB - 09/02/2005 - TM-200502081255
			 RETURN FALSE;
 			 --Fin Modificacion - ACB - 09/02/2005 - TM-200502081255
		WHEN OTHERS THEN
			 SV_error := 4;
			 SV_sqlcode := SQLCODE;
			 SV_sqlerrm := SQLERRM;
			 --Inicio Modificacion - ACB - 09/02/2005 - TM-200502081255
			 RETURN FALSE;
 			 --Fin Modificacion - ACB - 09/02/2005 - TM-200502081255

END PV_RECUPERA_ESTADO_OOSS_FN;

------------------------------------------------------------------

FUNCTION PV_RECUPERA_NUM_SINIES_FN(EN_num_celular  	  IN NUMBER,
		  						   SN_num_siniestro   OUT NUMBER,
								   SV_error 		  OUT VARCHAR2,
								   SV_proc  		  OUT VARCHAR2,
								   SV_tabla 		  OUT VARCHAR2,
								   SV_act	  		  OUT VARCHAR2,
								   SV_sqlcode 		  OUT VARCHAR2,
								   SV_sqlerrm 		  OUT VARCHAR2
)RETURN BOOLEAN
/*
<DOC>
<NOMBRE>      PV_RECUPERA_NUM_SINIES_FN                          </NOMBRE>
<FECHACREA>   14/10/2004                                         </FECHACREA>
<MODULO>      POSTVENTA                                          </MODULO>
<AUTOR>       Hector Perez Guzman                                </AUTOR>
<VERSION>     1.0.0                                              </VERSION>
<DESCRIPCION> </DESCRIPCION>
<FECHAMOD>    		                                             </FECHAMOD>
<DESCMOD>     													 </DESCMOD>
<ParamEntr>             </ParamEntr>
<ParamSal>           </ParamSal>
<ParamSal>    SV_error: Codgio Error Controlado                  </ParamSal>
<ParamSal>    SV_proc: Nombre Procedimiento                      </ParamSal>
<ParamSal>    SV_tabla: Nombre Tabla                             </ParamSal>
<ParamSal>    SV_act: Accion Efectuada sobre la Tabla            </ParamSal>
<ParamSal>    SV_sqlcode: Codigo Error Oracle                           </ParamSal>
<ParamSal>    SV_sqlerrm: Mensaje Error Oracle                           </ParamSal>
</DOC>
*/
IS

  GV_cod_servicio GA_SINIESTROS.COD_SERVICIO%TYPE;
  GN_num_abonado  GA_ABOCEL.NUM_ABONADO%TYPE;
  GN_num_serie	  GA_ABOCEL.NUM_SERIE%TYPE;
  GV_implimcons   NUMBER(14,4);
	BEGIN

		PV_GENERAL_OOSS_PG.PV_DATOS_ABONADO_PR (EN_num_celular,GV_implimcons,SV_PROC,SV_TABLA,SV_ACT,SV_SQLCODE,SV_SQLERRM,SV_ERROR);
	    GN_num_abonado := PV_GENERAL_OOSS_PG.VP_NUM_ABONADO;
		GN_num_serie   := PV_GENERAL_OOSS_PG.VP_NUM_SERIE;

		SV_error:='0';
		SV_proc := 'PV_RECUPERA_NUM_SINIES_FN';
		SV_act := 'S';
		SV_tabla := 'GA_SINIESTROS';

		IF PV_GENERAL_OOSS_PG.PV_RECUPERA_CODIGO_SERVICIO_FN(EN_num_celular, GV_cod_servicio, SV_error, SV_proc, SV_tabla, SV_act, SV_sqlcode, SV_sqlerrm) THEN

			SELECT num_siniestro
			INTO   SN_num_siniestro
			FROM   GA_SINIESTROS
			WHERE  num_abonado  = GN_num_abonado
			AND    cod_servicio = GV_cod_servicio
			AND    num_serie    = GN_num_serie;

		ELSE
			SV_error := 4;
			SV_sqlerrm := 'ERROR RECUPERANDO CODIGO DE SERVICIO ';
		END IF;

		RETURN TRUE;
	EXCEPTION
		WHEN NO_DATA_FOUND THEN
			 RETURN FALSE;
		WHEN OTHERS THEN
			 SV_error := 4;
			 SV_sqlcode := SQLCODE;
			 SV_sqlerrm := SQLERRM;
			 RETURN FALSE;
END PV_RECUPERA_NUM_SINIES_FN;

--------------------------------------------------------------

PROCEDURE PV_ESTADO_TRANSACCION_PR(EN_num_celular  	  IN GA_ABOCEL.NUM_CELULAR%TYPE,
		  						   EN_num_ooss        IN PV_CAMCOM.NUM_OS%TYPE,
								   EV_usuario		  IN VARCHAR2,
								   SV_mensaje	  	  OUT VARCHAR2,
								   SV_resp_estado     OUT VARCHAR2,
								   SN_num_siniestro   OUT GA_SINIESTROS.NUM_SINIESTRO%TYPE,
								   SV_det_siniestro	  OUT GA_DETSINIE.OBS_DETALLE%TYPE,
								   SV_error 		  OUT VARCHAR2
)
/*
<DOC>
<NOMBRE>      PV_ESTADO_TRANSACCION_PR                          </NOMBRE>
<FECHACREA>   14/10/2004                                         </FECHACREA>
<MODULO>      POSTVENTA                                          </MODULO>
<AUTOR>       Hector Perez Guzman                                </AUTOR>
<VERSION>     1.0.0                                              </VERSION>
<DESCRIPCION> </DESCRIPCION>
<FECHAMOD>    		                                             </FECHAMOD>
<DESCMOD>     													 </DESCMOD>
<ParamEntr>             </ParamEntr>
<ParamSal>           </ParamSal>
<ParamSal>    SV_error: Codgio Error Controlado                  </ParamSal>
<ParamSal>    SV_proc: Nombre Procedimiento                      </ParamSal>
<ParamSal>    SV_tabla: Nombre Tabla                             </ParamSal>
<ParamSal>    SV_act: Accion Efectuada sobre la Tabla            </ParamSal>
<ParamSal>    SV_sqlcode: Codigo Error Oracle                           </ParamSal>
<ParamSal>    SV_sqlerrm: Mensaje Error Oracle                           </ParamSal>
</DOC>
*/
IS
  	SN_cod_estado   PV_IORSERV.COD_ESTADO%TYPE;
	SV_des_estado   PV_ERECORRIDO.DESCRIPCION%TYPE;

	SV_proc  		 VARCHAR2(50);
	SV_tabla 		 VARCHAR2(50);
	SV_act	  		 VARCHAR2(2);
	SV_sqlcode 		 VARCHAR2(50);
	SV_sqlerrm 		 VARCHAR2(250);
	GV_implimcons	 NUMBER(14,4);
	B_existe_celular BOOLEAN;
	B_valida_largo	 BOOLEAN;
	B_valida_user	 BOOLEAN;

	ERROR_PROCESO   EXCEPTION;
	BEGIN

		SV_error:='0';
		SV_proc := 'PV_ESTADO_TRANSACCION_PR';
		SV_act := 'S';
		SV_tabla := 'GA_SINIESTROS';

		B_valida_user := TRUE;
   	    IF NOT PV_GENERAL_OOSS_PG.PV_VALIDA_USUARIO_FN(EV_usuario,SV_error, SV_proc,SV_tabla,SV_act,SV_sqlcode,SV_sqlerrm) THEN
	   	   B_valida_user := FALSE;
		   RAISE ERROR_PROCESO;
	    END IF;

		IF NOT PV_GENERAL_OOSS_PG.PV_VAL_LARGO_CELULAR_FN(EN_num_celular, SV_error, SV_proc, SV_tabla, SV_act, SV_sqlcode, SV_sqlerrm) THEN
		    B_valida_largo := FALSE;
		    RAISE ERROR_PROCESO;
		END IF;


		B_existe_celular := TRUE;
		PV_GENERAL_OOSS_PG.PV_DATOS_ABONADO_PR (EN_num_celular,GV_implimcons,SV_PROC,SV_TABLA,SV_ACT,SV_SQLCODE,SV_SQLERRM,SV_ERROR);
	    IF SV_ERROR = 4 THEN
		    B_existe_celular := FALSE;
		    RAISE ERROR_PROCESO;
		END IF;

	    IF PV_VALIDA_OOSS_FN(EN_num_celular, EN_num_ooss, SV_error, SV_proc, SV_tabla, SV_act, SV_sqlcode, SV_sqlerrm) THEN
		   IF PV_RECUPERA_ESTADO_OOSS_FN(EN_num_ooss, SV_des_estado, SV_error, SV_proc, SV_tabla, SV_act, SV_sqlcode, SV_sqlerrm) THEN
		   	  IF PV_RECUPERA_NUM_SINIES_FN(EN_num_celular, SN_num_siniestro, SV_error, SV_proc, SV_tabla, SV_act, SV_sqlcode, SV_sqlerrm) THEN
			  	 IF PV_DETT_SINIESTRO_FN(SN_num_siniestro, SV_det_siniestro, SV_error, SV_proc, SV_tabla, SV_act, SV_sqlcode, SV_sqlerrm) THEN
					SV_error:='0';
				 END IF;
			  ELSE
			  	 SN_num_siniestro := 0;
			  -- Inicio Modificacion TM-200502141271 - 23/02/2005 - JJR.-
			  --	 SV_det_siniestro :='Siniestro aun no ha sido inscrito';
			  	 SV_det_siniestro :='Robo/Extravio aun no Registrado';
			  -- Fin Modificacion TM-200502141271 - 23/02/2005 - JJR.-
			  END IF;
		   END IF;
	     -- Inicio Modificacion TM-200502141271 - 23/02/2005 - JJR.-
            ELSE
		SV_mensaje := SV_sqlerrm;
	    -- Fin Modificacion TM-200502141271 - 23/02/2005 - JJR.-
	    END IF;
		IF SV_error = 4 THEN
		    SV_resp_estado := SV_sqlerrm;
		ELSE
		    SV_resp_estado := SV_des_estado;
		END IF;


	EXCEPTION
		WHEN ERROR_PROCESO THEN
			 IF NOT B_existe_celular THEN
			 	-- Inicio Modificacion TM-200502141271 - 24/02/2005 - JJR.-
			 	-- SV_mensaje := 'Celular no existe';
			 	   SV_mensaje := 'Numero Tel. No Registrado';
			 	-- Fin Modificacion TM-200502141271 - 24/02/2005 - JJR.-
			 END IF;
			 IF NOT B_valida_user THEN
			    SV_mensaje := 'Usuario no valido ';
			 END IF;
			 IF NOT B_valida_largo THEN
			        -- Inicio Modificacion TM-200502141271 - 24/02/2005 - JJR.-
			 	-- SV_mensaje := 'Celular No Cumple Con Largo Definido Por Operadora';
			 	   SV_mensaje := 'Numero Tel. No Valido';
			 	-- Fin Modificacion TM-200502141271 - 24/02/2005 - JJR.-

			 END IF;
		WHEN OTHERS THEN

			 SV_error := 4;
			 --SV_sqlcode := SQLCODE;
			 --SV_sqlerrm := SQLERRM;


END PV_ESTADO_TRANSACCION_PR;


-------------------------------------------------------------

FUNCTION PV_VALIDA_OOSS_FN(EN_num_celular    IN GA_ABOCEL.NUM_CELULAR%TYPE,
		  	               EN_num_ooss       IN PV_CAMCOM.NUM_OS%TYPE,
						   SV_error 		   OUT VARCHAR2,
						   SV_proc  		   OUT VARCHAR2,
						   SV_tabla 		   OUT VARCHAR2,
						   SV_act	  		   OUT VARCHAR2,
						   SV_sqlcode 		   OUT VARCHAR2,
						   SV_sqlerrm 		   OUT VARCHAR2
)RETURN BOOLEAN
/*
<DOC>
<NOMBRE>      PV_RECUPERA_NUM_SINIES_FN                          </NOMBRE>
<FECHACREA>   14/10/2004                                         </FECHACREA>
<MODULO>      POSTVENTA                                          </MODULO>
<AUTOR>       Hector Perez Guzman                                </AUTOR>
<VERSION>     1.0.0                                              </VERSION>
<DESCRIPCION> </DESCRIPCION>
<FECHAMOD>    		                                             </FECHAMOD>
<DESCMOD>     													 </DESCMOD>
<ParamEntr>             </ParamEntr>
<ParamSal>           </ParamSal>
<ParamSal>    SV_error: Codgio Error Controlado                  </ParamSal>
<ParamSal>    SV_proc: Nombre Procedimiento                      </ParamSal>
<ParamSal>    SV_tabla: Nombre Tabla                             </ParamSal>
<ParamSal>    SV_act: Accion Efectuada sobre la Tabla            </ParamSal>
<ParamSal>    SV_sqlcode: Codigo Error Oracle                           </ParamSal>
<ParamSal>    SV_sqlerrm: Mensaje Error Oracle                           </ParamSal>
</DOC>
*/
IS
    VG_count1 NUMBER;
	VG_count2 NUMBER;
	VN_num_abonado NUMBER(8);
	VN_num_os	   NUMBER(10);
	ERROR_PROCESO  EXCEPTION;
	BEGIN

		SV_error :='0';
		SV_proc  := 'PV_VALIDA_OOSS_FN';
		SV_act 	 := 'S';
		SV_tabla := 'GA_ABOCEL/GA_ABOAMIST';


		BEGIN
			SELECT COUNT(1)
			INTO VN_num_abonado
			FROM GA_ABOAMIST
			WHERE NUM_CELULAR = EN_num_celular
			-- Inicio Modificacion - GBM - 24-02-2005 - TM-200502161273
			--AND   COD_SITUACION IN ('AAA','SAA');
			AND   COD_SITUACION IN ('AAA','SAA','STP','RTP');
			-- Fin Modificacion - GBM - 24-02-2005 - TM-200502161273
			IF VN_num_abonado = 0 THEN
				SELECT COUNT(1)
				INTO VN_num_abonado
				FROM GA_ABOCEL
				WHERE NUM_CELULAR = EN_num_celular
				-- Inicio Modificacion - GBM - 24-02-2005 - TM-200502161273
				--AND   COD_SITUACION IN ('AAA','SAA');
				AND   COD_SITUACION IN ('AAA','SAA','STP','RTP');
				-- Fin Modificacion - GBM - 24-02-2005 - TM-200502161273
			END IF;

			IF VN_num_abonado = 0 then
			   RAISE ERROR_PROCESO;
			END IF;
		EXCEPTION
			WHEN NO_DATA_FOUND THEN
				SV_sqlerrm := 'Celular Inexistente';
				RETURN FALSE;
			WHEN ERROR_PROCESO THEN
				SV_sqlerrm := 'Numero Tel. No Registrado';
				RETURN FALSE;
			-- Fin Modificacion - GBM - 24-02-2005 - TM-200502161273

		END;


		BEGIN
			SV_tabla := 'PV_CAMCOM/PVH_CAMCOM';

			SELECT num_os
			INTO VN_num_os
			FROM PV_CAMCOM
			WHERE NUM_OS = EN_num_ooss
			AND   NUM_CELULAR = EN_num_celular
			UNION
			SELECT num_os
			FROM PVH_CAMCOM
			WHERE NUM_OS = EN_num_ooss
			AND   NUM_CELULAR = EN_num_celular;
		EXCEPTION
			WHEN NO_DATA_FOUND THEN
			      -- Inicio Modificacion TM-200502141271 - 24/02/2005 - JJR.-
			      -- SV_sqlerrm := 'No Existe Aviso De Siniestro para el Numero Ingresado';
				 SV_sqlerrm := 'No Existe Numero de Orden de Servicio';
			      -- Fin Modificacion TM-200502141271 - 24/02/2005 - JJR.-
				 RETURN FALSE;

			WHEN OTHERS THEN
				 SV_error := 4;
				 SV_sqlcode := SQLCODE;
				 SV_sqlerrm := SQLERRM;
				 RETURN FALSE;
		END;

		RETURN TRUE; -- Existe ooss

	EXCEPTION
		WHEN OTHERS THEN
			 SV_error := 4;
			 SV_sqlcode := SQLCODE;
			 SV_sqlerrm := SQLERRM;
			 RETURN FALSE;
END PV_VALIDA_OOSS_FN;

-------------------------------------------------------------

FUNCTION PV_DETT_SINIESTRO_FN(EN_num_siniestro  IN NUMBER,
		 					  SV_det_siniestro	OUT VARCHAR2,
							  SV_error 		   	OUT VARCHAR2,
							  SV_proc  		    OUT VARCHAR2,
							  SV_tabla 		    OUT VARCHAR2,
							  SV_act	  		OUT VARCHAR2,
							  SV_sqlcode 		OUT VARCHAR2,
							  SV_sqlerrm 		OUT VARCHAR2
)RETURN BOOLEAN
/*
<DOC>
<NOMBRE>      PV_DETT_SINIESTRO_FN			                     </NOMBRE>
<FECHACREA>   14/10/2004                                         </FECHACREA>
<MODULO>      POSTVENTA                                          </MODULO>
<AUTOR>       Hector Perez Guzman                                </AUTOR>
<VERSION>     1.0.0                                              </VERSION>
<DESCRIPCION> </DESCRIPCION>
<FECHAMOD>    		                                             </FECHAMOD>
<DESCMOD>     													 </DESCMOD>
<ParamEntr>             </ParamEntr>
<ParamSal>           </ParamSal>
<ParamSal>    SV_error: Codgio Error Controlado                  </ParamSal>
<ParamSal>    SV_proc: Nombre Procedimiento                      </ParamSal>
<ParamSal>    SV_tabla: Nombre Tabla                             </ParamSal>
<ParamSal>    SV_act: Accion Efectuada sobre la Tabla            </ParamSal>
<ParamSal>    SV_sqlcode: Codigo Error Oracle                           </ParamSal>
<ParamSal>    SV_sqlerrm: Mensaje Error Oracle                           </ParamSal>
</DOC>
*/
IS
	BEGIN

		SV_error:='0';
		SV_proc := 'PV_DETT_SINIESTRO_FN';
		SV_act := 'S';
		SV_tabla := 'GA_DETSINIE';

		SELECT obs_detalle
		INTO  SV_det_siniestro
		FROM GA_DETSINIE
		WHERE num_siniestrO = EN_num_siniestro;

		IF SV_det_siniestro = '' OR LTRIM(RTRIM(SV_det_siniestro)) IS NULL THEN
		   SV_det_siniestro := 'SINIESTRO SIN OBSERVACIONES';
		END IF;
		RETURN TRUE;
	EXCEPTION
		WHEN NO_DATA_FOUND THEN
			 RETURN FALSE;
			 SV_error := 4;
			 SV_sqlerrm := 'NO SE ENCUENTRA SINIESTRO';

		WHEN OTHERS THEN
			 RETURN FALSE;
			 SV_error := 4;
			 SV_sqlcode := SQLCODE;
			 SV_sqlerrm := SQLERRM;

END PV_DETT_SINIESTRO_FN;

------------------------------------------------------------

FUNCTION PV_VAL_TIPO_SINIESTRO_FN(EN_num_abonado  IN NUMBER,
		  	                       EN_tipo_terminal   IN NUMBER,
								   SV_respuesta       OUT BOOLEAN,
								   SV_error 		   OUT VARCHAR2,
								   SV_proc  		   OUT VARCHAR2,
								   SV_tabla 		   OUT VARCHAR2,
								   SV_act	  		   OUT VARCHAR2,
								   SV_sqlcode 		   OUT VARCHAR2,
								   SV_sqlerrm 		   OUT VARCHAR2
)RETURN BOOLEAN
/*
<DOC>
<NOMBRE>      PV_VAL_TIPO_SINIESTRO_FN                         </NOMBRE>
<FECHACREA>   14/10/2004                                         </FECHACREA>
<MODULO>      POSTVENTA                                          </MODULO>
<AUTOR>       Hector Perez Guzman                                </AUTOR>
<VERSION>     1.0.0                                              </VERSION>
<DESCRIPCION> </DESCRIPCION>
<FECHAMOD>    		                                             </FECHAMOD>
<DESCMOD>     													 </DESCMOD>
<ParamEntr>             </ParamEntr>
<ParamSal>           </ParamSal>
<ParamSal>    SV_error: Codgio Error Controlado                  </ParamSal>
<ParamSal>    SV_proc: Nombre Procedimiento                      </ParamSal>
<ParamSal>    SV_tabla: Nombre Tabla                             </ParamSal>
<ParamSal>    SV_act: Accion Efectuada sobre la Tabla            </ParamSal>
<ParamSal>    SV_sqlcode: Codigo Error Oracle                           </ParamSal>
<ParamSal>    SV_sqlerrm: Mensaje Error Oracle                           </ParamSal>
</DOC>
*/
IS

	GN_contador	 NUMBER;

	BEGIN

		SV_error:='0';
		SV_proc := 'PV_VAL_TIPO_SINIESTRO_PR';
		SV_act := 'S';
		SV_tabla := 'GA_SINIESTROS';

		SELECT COUNT(1)
		INTO GN_contador
		FROM  GA_SINIESTROS
 		WHERE num_abonado = EN_num_abonado
 		AND   tip_terminal = EN_tipo_terminal;

		IF GN_contador > 0 THEN
		    SV_respuesta := TRUE;
		ELSE
		    SV_respuesta := FALSE;
		END IF;
		RETURN TRUE;
	EXCEPTION

		WHEN OTHERS THEN
			 SV_error := 4;
			 SV_sqlcode := SQLCODE;
			 SV_sqlerrm := SQLERRM;
			 RETURN FALSE;
END PV_VAL_TIPO_SINIESTRO_FN;

--------------------------------------------------------------

PROCEDURE PV_ACEPTA_AS_PR(EN_num_celular 	 IN NUMBER,
						  EV_tipo_sinie  	 IN VARCHAR,
						  EN_tipo_susp       IN NUMBER,
						  EN_causa_sinie     IN NUMBER,
						  EV_usuario		 IN VARCHAR2,
						  SV_mensaje		OUT VARCHAR2,
						  SN_num_solEqu     OUT NUMBER,
						  SN_num_solSim     OUT NUMBER,
						  SV_error 		    OUT VARCHAR2
)
/*
<DOC>
<NOMBRE>      PV_ACEPTA_AS_PR                          </NOMBRE>
<FECHACREA>   14/10/2004                                         </FECHACREA>
<MODULO>      POSTVENTA                                          </MODULO>
<AUTOR>       Hector Perez Guzman                                </AUTOR>
<VERSION>     1.0.0                                              </VERSION>
<DESCRIPCION> Acepta Aviso de Siniestro							 </DESCRIPCION>
<FECHAMOD>    		                                             </FECHAMOD>
<DESCMOD>     													 </DESCMOD>
<ParamEntr>   Numero de Celular       							 </ParamEntr>
<ParamEntr>   Tipo de Siniestro  [ E / S / A ]					 </ParamEntr>
<ParamEntr>   Tipo de Suspension       							 </ParamEntr>
<ParamEntr>   Causa de Siniestro       							 </ParamEntr>
<ParamSal>    SV_error: Codgio Error Controlado                  </ParamSal>
<ParamSal>    SV_error: Codgio Error Controlado                  </ParamSal>
<ParamSal>    SV_proc: Nombre Procedimiento                      </ParamSal>
<ParamSal>    SV_tabla: Nombre Tabla                             </ParamSal>
<ParamSal>    SV_act: Accion Efectuada sobre la Tabla            </ParamSal>
<ParamSal>    SV_sqlcode: Codigo Error Oracle                    </ParamSal>
<ParamSal>    SV_sqlerrm: Mensaje Error Oracle                   </ParamSal>
</DOC>
*/
IS

  	GV_implimcons  		  NUMBER(14,4);
	GN_cod_tecnologia 	  GA_ABOCEL.COD_TECNOLOGIA%TYPE;
	GV_cod_situacion	  GA_ABOCEL.COD_SITUACION%TYPE;
	GN_num_abonado		  GA_ABOCEL.NUM_ABONADO%TYPE;
	GN_num_celular		  GA_ABOCEL.NUM_CELULAR%TYPE;
	GV_cod_cliente		  GA_ABOCEL.COD_CLIENTE%TYPE;
	GN_tip_terminal		  GA_ABOCEL.TIP_TERMINAL%TYPE;
	GV_tip_plantarif	  GA_ABOCEL.TIP_PLANTARIF%TYPE;
	GV_cod_plantarif	  GA_ABOCEL.COD_PLANTARIF%TYPE;
	GV_num_seriehex		  GA_ABOCEL.NUM_SERIEHEX%TYPE;
	GN_cod_cliclo		  GA_ABOCEL.COD_CICLO%TYPE;
	GN_tip_term_sin		  GA_ABOCEL.TIP_TERMINAL%TYPE;
	GV_usuario			  GA_ABOCEL.NOM_USUARORA%TYPE;
	GV_codplanserv		  GA_ABOCEL.COD_PLANSERV%TYPE;
	GD_fecalta			  GA_ABOCEL.FEC_ALTA%TYPE;

	SV_descripcion		  CI_TIPORSERV.DESCRIPCION%TYPE;
	SN_tip_procesa		  CI_TIPORSERV.TIP_PROCESA%TYPE;
	SN_modgener			  CI_TIPORSERV.COD_MODGENER%TYPE;
	SV_des_estadoc		  FA_INTESTADOC.DES_ESTADOC%TYPE;

	GV_tip_susp_avsinie   PV_CAMCOM.TIP_SUSP_AVSINIE%TYPE;
	GN_ind_central_ss	  PV_CAMCOM.IND_CENTRAL_SS%TYPE;

	SV_cod_servicio		  PV_SERV_SUSPREHA_TO.COD_SERVICIO%TYPE;
	GV_comentario		  PV_PARAM_ABOCEL.OBS_DETALLE%TYPE;

	sCantNumSerie 		  NUMBER(2); -- Modificacion - GBM - 23-02-2005 - TM-200502161273
	GN_secuencia1		  NUMBER(10);
	GN_secuencia2		  NUMBER(10);
	GN_seq_enviada	      NUMBER(10);
	GN_veces			  NUMBER(1);
	GV_parametros		  VARCHAR2(300);
	GN_pos				  NUMBER(1);
	GV_bdatos			  VARCHAR2(9);
	B_ok				  BOOLEAN;
	B_valida_largo		  BOOLEAN;
	B_valida_user		  BOOLEAN;
	B_existe_celular	  BOOLEAN;

	SV_proc  		      VARCHAR2(50);
	SV_tabla 		      VARCHAR2(50);
	SV_act	  			  VARCHAR2(2);
	SV_sqlcode 			  VARCHAR2(50);
	SV_sqlerrm 			  VARCHAR2(250);
	SV_sqlcode_aux		  VARCHAR2(50);
	SV_sqlerrm_aux		  VARCHAR2(250);

	B_Ret				  BOOLEAN;

	ERROR_PROCESO		  EXCEPTION;
	ERROR_RESTRICCIONES	  EXCEPTION;

	BEGIN

		SV_error:='0';
		SV_proc := 'PV_ACEPTA_AS_PR';
		GN_secuencia2 := 0;
		GV_comentario := 'Aviso Siniestro Por Plataforma Externa';

		B_valida_user := TRUE;
   	    IF NOT PV_GENERAL_OOSS_PG.PV_VALIDA_USUARIO_FN(EV_usuario,SV_error, SV_proc,SV_tabla,SV_act,SV_sqlcode,SV_sqlerrm) THEN
		   SV_mensaje   := 'Usuario no valido ';
		   RAISE ERROR_PROCESO;
	    END IF;

		B_valida_largo := TRUE;
		IF NOT PV_GENERAL_OOSS_PG.PV_VAL_LARGO_CELULAR_FN (EN_num_celular, SV_error, SV_proc, SV_tabla, SV_act, SV_sqlcode, SV_sqlerrm) THEN
		   -- Inicio Modificacion TM-200502141271 - 24/02/2005 - JJR.-
		   -- SV_mensaje := 'Celular No Cumple Con Largo Definido Por Operadora';
		      SV_mensaje := 'Numero Tel. No Valido';
		   -- Fin Modificacion TM-200502141271 - 24/02/2005 - JJR.-
		   RAISE ERROR_PROCESO;
		END IF;

		B_existe_celular := TRUE;
		PV_GENERAL_OOSS_PG.PV_DATOS_ABONADO_PR (EN_num_celular,GV_implimcons,SV_PROC,SV_TABLA,SV_ACT,SV_SQLCODE,SV_SQLERRM,SV_ERROR);
	    IF SV_ERROR = 4 THEN

		   -- Inicio Modificacion TM-200502141271 - 24/02/2005 - JJR.-
		   -- SV_mensaje :=  'Celular no existe o Situacion no es Valida';
		      SV_mensaje := 'Numero Tel. No Registrado';
		   -- Fin Modificacion TM-200502141271 - 24/02/2005 - JJR.-
		   RAISE ERROR_PROCESO;
		ELSE
			GN_cod_tecnologia := PV_GENERAL_OOSS_PG.VP_COD_TECNOLOGIA;
			GN_num_abonado 	  := PV_GENERAL_OOSS_PG.VP_NUM_ABONADO;
			GV_cod_cliente 	  := PV_GENERAL_OOSS_PG.VP_COD_CLIENTE;
			GV_tip_plantarif  := PV_GENERAL_OOSS_PG.VP_TIP_PLANTARIF;
			GV_cod_plantarif  := PV_GENERAL_OOSS_PG.VP_COD_PLANTARIF;
			GV_num_seriehex   := PV_GENERAL_OOSS_PG.VP_NUM_SERIEHEX;
			GN_cod_cliclo 	  := PV_GENERAL_OOSS_PG.VP_COD_CICLO;
			GN_tip_terminal   := PV_GENERAL_OOSS_PG.VP_TIP_TERMINAL;
			GV_codplanserv	  := PV_GENERAL_OOSS_PG.VP_COD_PLANSERV;
			GD_fecalta		  := PV_GENERAL_OOSS_PG.VP_FEC_ALTA;
			GN_num_celular 	  := EN_num_celular;
		END IF;


		PV_GENERAL_OOSS_PG.PV_PARAMETROS_OOSS_PR(CN_cod_ooss,SV_descripcion, SN_tip_procesa, SN_modgener, SV_des_estadoc, SV_error, SV_proc, SV_tabla, SV_act, SV_sqlcode, SV_sqlerrm);

		BEGIN
			SV_tabla := 'V$DATABASE';
			SV_act := 'S';
			SELECT name
			INTO GV_bdatos
			FROM V$DATABASE;
		EXCEPTION
			WHEN OTHERS THEN
				 RAISE ERROR_PROCESO;
		END;

		SN_num_solEqu := 0;
		SN_num_solSim := 0;

		BEGIN
			SV_tabla := 'SECUENCIA (GA_SEQ_TRANSACABO)';
			SV_act := 'S';
			SELECT CI_SEQ_NUMOS.NEXTVAL
			INTO GN_secuencia1
			FROM DUAL;
		EXCEPTION
			WHEN OTHERS THEN
				 RAISE ERROR_PROCESO;
		END;

		GN_seq_enviada := GN_secuencia1;

		-- Inicio Modificacion - GBM - 23-02-2005 - TM-200502161273
		sCantNumSerie := 0;
		IF PV_GENERAL_OOSS_PG.VP_COD_TECNOLOGIA = 'CDMA' THEN
			BEGIN

			SELECT COUNT(*)
			INTO sCantNumSerie
			FROM GA_SINIESTROS
			WHERE NUM_ABONADO=PV_GENERAL_OOSS_PG.VP_NUM_ABONADO
			AND NUM_SERIE=PV_GENERAL_OOSS_PG.VP_NUM_SERIE;

			EXCEPTION
			WHEN OTHERS THEN
				 RAISE ERROR_PROCESO;
			END;

			IF sCantNumSerie >0 THEN
				SV_mensaje := 'ABONADO YA CUENTA CON SINIESTRO DEL EQUIPO.';
				RAISE ERROR_RESTRICCIONES;
			END IF;

		ELSE -- TECNOLOGIA GSM

			IF EV_tipo_sinie = 'A' OR EV_tipo_sinie = 'E' THEN
				-- VALIDAR EQUIPO
				BEGIN

				SELECT COUNT(*)
				INTO sCantNumSerie
				FROM GA_SINIESTROS
				WHERE NUM_ABONADO=PV_GENERAL_OOSS_PG.VP_NUM_ABONADO
				AND NUM_SERIE=PV_GENERAL_OOSS_PG.VP_NUM_IMEI;

				EXCEPTION
				WHEN OTHERS THEN
					RAISE ERROR_PROCESO;
				END;


				IF sCantNumSerie > 0 THEN
					SV_mensaje := 'ABONADO YA CUENTA CON SINIESTRO DEL EQUIPO.';
					RAISE ERROR_RESTRICCIONES;
				END IF;
			END IF;

			IF EV_tipo_sinie = 'A' OR EV_tipo_sinie = 'S' THEN
				-- VALIDAR SIMCARD
				BEGIN

				SELECT COUNT(*)
				INTO sCantNumSerie
				FROM GA_SINIESTROS
				WHERE NUM_ABONADO=PV_GENERAL_OOSS_PG.VP_NUM_ABONADO
				AND NUM_SERIE=PV_GENERAL_OOSS_PG.VP_NUM_SERIE;

				EXCEPTION
				WHEN OTHERS THEN
					RAISE ERROR_PROCESO;
				END;

				IF sCantNumSerie >0 THEN
					SV_mensaje := 'ABONADO YA CUENTA CON SINIESTRO DE LA SIMCARD.';
					RAISE ERROR_RESTRICCIONES;
				END IF;
			END IF;

		END IF;
		-- Fin Modificacion - GBM - 23-02-2005 - TM-200502161273
		GV_parametros := '||||' || PV_GENERAL_OOSS_PG.CV_cod_actabo ||'|' || TO_CHAR(GN_num_abonado)         || '|' || TO_CHAR(GV_cod_cliente) ||'|' || SN_modgener ||'||' || CN_cod_ooss || '|';
		IF NOT PV_GENERAL_OOSS_PG.PV_EJEC_RESTRICCION_FN(PV_GENERAL_OOSS_PG.CV_cod_modulo,PV_GENERAL_OOSS_PG.CN_cod_producto,PV_GENERAL_OOSS_PG.CV_cod_actabo,CV_evento,GV_parametros, SV_proc, SV_tabla, SV_act, SV_sqlcode, SV_sqlerrm, SV_error) THEN
		   SV_mensaje := SV_sqlerrm;
		   RAISE ERROR_RESTRICCIONES;
		END IF;

		GN_pos:=1;
		IF EV_tipo_sinie = 'A' THEN
		    GN_veces := 2;
		ELSE
		    IF EN_tipo_susp = 0 THEN
			   GN_veces := 1;
			ELSE
			   GN_veces := 1;
			END IF;
		END IF;

		---- Ejecutar Cargos ------
    	IF NOT PV_ASIGNA_CARGOS_FN(GV_cod_cliente,GV_codplanserv,GN_num_abonado,EN_num_celular,GD_fecalta,EV_usuario, SV_proc, SV_tabla, SV_act, SV_sqlcode, SV_sqlerrm, SV_error) THEN
		   RAISE ERROR_PROCESO;
		END IF;

		WHILE GN_pos <= GN_veces LOOP

			  IF EV_tipo_sinie = 'A' THEN
			      IF GN_pos = 1 THEN
				      GN_tip_term_sin := ge_fn_devvalparam('AL', PV_GENERAL_OOSS_PG.CN_Cod_Producto, 'COD_SIMCARD_GSM');--'G';
				      GV_tip_susp_avsinie := '1';
				      GN_ind_central_ss := 1;
					  SN_num_solSim := GN_seq_enviada;
			  	  ELSE
				  	  GN_tip_term_sin := ge_fn_devvalparam('AL', PV_GENERAL_OOSS_PG.CN_Cod_Producto,'COD_TERMINAL_GSM');--'T';
				      GV_tip_susp_avsinie := '0';
				      GN_ind_central_ss := 0;

					  SV_tabla := 'SECUENCIA (GA_SEQ_TRANSACABO)';
					  SV_act := 'S';
					  BEGIN
					  	  SELECT CI_SEQ_NUMOS.NEXTVAL
						  INTO GN_secuencia2
						  FROM DUAL;
					  EXCEPTION
						  WHEN OTHERS THEN
							  SV_error := 4;
							  SV_sqlcode := SQLCODE;
							  SV_sqlerrm := SQLERRM;
							  RAISE ERROR_PROCESO;
					  END;
					  GN_seq_enviada := GN_secuencia2;
					  SN_num_solEqu  := GN_seq_enviada;
				  END IF;
			  ELSE
			  	  IF EN_tipo_susp = 0 THEN
				  	  GV_tip_susp_avsinie := '0';
			      	  GN_ind_central_ss := 0;
	  	  		  ELSE
				  	  GV_tip_susp_avsinie := '1';
			      	  GN_ind_central_ss := 1;
				  END IF;

				  IF GN_cod_tecnologia = ge_fn_devvalparam(PV_GENERAL_OOSS_PG.CV_Cod_Modulo, PV_GENERAL_OOSS_PG.CN_Cod_Producto,'TECNOLOGIA_GSM') THEN
				  	-- Inicio - Alejandro Hott - Soporte 29-11-2004 - TM-200411151097
				  	IF EV_tipo_sinie = 'E' THEN
				  	  GN_tip_term_sin := ge_fn_devvalparam('AL', PV_GENERAL_OOSS_PG.CN_Cod_Producto,'COD_TERMINAL_GSM');
				  	  SN_num_solEqu := GN_seq_enviada;
				  	ELSE
				  	  GN_tip_term_sin := ge_fn_devvalparam('AL', PV_GENERAL_OOSS_PG.CN_Cod_Producto,'COD_SIMCARD_GSM');
				  	  SN_num_solSim := GN_seq_enviada;
				  	END IF;
				  	-- Fin - Alejandro Hott - Soporte 29-11-2004 - TM-200411151097
				  ELSE
					  GN_tip_term_sin := GN_tip_terminal;
				  END IF;
			      SN_num_solEqu := GN_seq_enviada;
			  END IF;

			  PV_GENERAL_OOSS_PG.PV_INSCRIBE_OOSS_PR(EN_num_celular
			  										, CN_cod_ooss
													, EV_usuario
													, GN_seq_enviada
													, SN_modgener
													, PV_GENERAL_OOSS_PG.CV_cod_actabo
													, GN_num_abonado
													, PV_GENERAL_OOSS_PG.CN_cod_producto
													, GN_ind_central_ss
													, GN_tip_term_sin
													, GV_tip_susp_avsinie
													, EN_causa_sinie
													, NULL
													, NULL
													, NULL
													, NULL
													, 0
													, NULL
													, NULL
													, 0
													, NULL
													, NULL
													, NULL
													, NULL
													, 0
													, NULL
													, 0
													, SV_descripcion
													, SN_tip_procesa
													, SN_modgener
													, SV_des_estadoc
													, 3
													, 0
													, SV_error
													, SV_proc
													, SV_tabla
													, SV_act
													, SV_sqlcode
													, SV_sqlerrm
													);

			  IF SV_error = 4 THEN
			  	-- Inicio Modificacion TM-200502141271 - 24/02/2005 - JJR.-
			 	-- SV_mensaje   := 'Error Durante ejecucion ';
			 	   SV_mensaje := 'Transaccion Erronea';
			 	-- Fin Modificacion TM-200502141271 - 24/02/2005 - JJR.-
				 RAISE ERROR_PROCESO;
			  END IF;

			  --- Insertar Carta --
			  B_Ret := PV_GENERAL_OOSS_PG.PV_REG_CARTA_FN(GN_seq_enviada, CN_cod_ooss, GV_cod_cliente, EN_num_celular, SV_proc, SV_tabla, SV_act, SV_sqlcode, SV_sqlerrm, SV_error);

			  GN_pos := GN_pos +1;

		END LOOP;

		COMMIT;

		SV_mensaje 	:= 'Aviso De Siniestro Exitoso';

	EXCEPTION
		WHEN ERROR_PROCESO THEN

			 ROLLBACK;
			 SN_num_solEqu := 0;
 			 SN_num_solSim := 0;

			 SV_sqlcode_aux := SUBSTR(SV_sqlcode,1,15);--SQLCODE;
			 SV_sqlerrm_aux := SUBSTR(SV_sqlerrm,1,60);--SQLERRM;

			 IF GN_num_abonado = '' OR LTRIM(RTRIM(GN_num_abonado)) IS NULL THEN
			     GN_num_abonado := -1;
			 END IF;

			 B_Ret:= PV_GENERAL_OOSS_PG.PV_GA_ERRORES_FN(GN_num_abonado,PV_GENERAL_OOSS_PG.CN_cod_producto,PV_GENERAL_OOSS_PG.CN_cod_producto, SV_error, SV_proc, SV_tabla, SV_act, SV_sqlcode_aux, SV_sqlerrm_aux, SV_sqlcode, SV_sqlerrm);
			 SV_error := 4;

			 COMMIT;

		WHEN ERROR_RESTRICCIONES THEN

			 ROLLBACK;
			 SN_num_solEqu := 0;
 			 SN_num_solSim := 0;

			 SV_sqlcode_aux := SUBSTR(SV_sqlcode,1,15);--SQLCODE;
			 SV_sqlerrm_aux := SUBSTR(SV_sqlerrm,1,60);--SQLERRM;

			 IF GN_num_abonado = '' OR LTRIM(RTRIM(GN_num_abonado)) IS NULL THEN
			     GN_num_abonado := -1;
			 END IF;
			 B_Ret:= PV_GENERAL_OOSS_PG.PV_GA_ERRORES_FN(GN_num_abonado,PV_GENERAL_OOSS_PG.CN_cod_producto,PV_GENERAL_OOSS_PG.CN_cod_producto, SV_error, SV_proc, SV_tabla, SV_act, SV_sqlcode_aux, SV_sqlerrm_aux, SV_sqlcode, SV_sqlerrm);

			 SV_error := 4;

             COMMIT;

END PV_ACEPTA_AS_PR;

---------------------------------------------------------------

FUNCTION PV_RECUPERA_TERMINAL_FN(EN_tip_siniestro  IN NUMBER,
		 					     SV_tipo_terminal	OUT VARCHAR2,
								 SV_error 		   OUT VARCHAR2,
								 SV_proc  		   OUT VARCHAR2,
								 SV_tabla 		   OUT VARCHAR2,
								 SV_act	  		   OUT VARCHAR2,
								 SV_sqlcode 		   OUT VARCHAR2,
								 SV_sqlerrm 		   OUT VARCHAR2
)RETURN BOOLEAN
/*
<DOC>
<NOMBRE>      PV_RECUPERA_TERMINAL_FN		                     </NOMBRE>
<FECHACREA>   14/10/2004                                         </FECHACREA>
<MODULO>      POSTVENTA                                          </MODULO>
<AUTOR>       Hector Perez Guzman                                </AUTOR>
<VERSION>     1.0.0                                              </VERSION>
<DESCRIPCION> </DESCRIPCION>
<FECHAMOD>    		                                             </FECHAMOD>
<DESCMOD>     													 </DESCMOD>
<ParamEntr>             </ParamEntr>
<ParamSal>           </ParamSal>
<ParamSal>    SV_error: Codgio Error Controlado                  </ParamSal>
<ParamSal>    SV_proc: Nombre Procedimiento                      </ParamSal>
<ParamSal>    SV_tabla: Nombre Tabla                             </ParamSal>
<ParamSal>    SV_act: Accion Efectuada sobre la Tabla            </ParamSal>
<ParamSal>    SV_sqlcode: Codigo Error Oracle                           </ParamSal>
<ParamSal>    SV_sqlerrm: Mensaje Error Oracle                           </ParamSal>
</DOC>
*/
IS
    GV_ter_gsm 			  VARCHAR2(20);
    GV_sim_gsm 			  VARCHAR2(20);
	GN_cod_tecnologia 	  GA_ABOCEL.COD_TECNOLOGIA%TYPE;

	BEGIN

		SV_error:='0';
		SV_proc := 'PV_RECUPERA_TERMINAL_FN';
		SV_act := 'S';
		SV_tabla := 'GED_PARAMETROS';

		IF GN_cod_tecnologia = 'GSM' THEN
			IF SV_tipo_terminal = 'E' OR SV_tipo_terminal = 'A' THEN
				SELECT val_parametro
				INTO   GV_ter_gsm
				FROM   GED_PARAMETROS
				WHERE  nom_parametro = 'COD_TERMINAL_GSM'
				AND    cod_modulo = 'AL'
				AND    cod_producto = PV_GENERAL_OOSS_PG.CN_cod_producto;
			END IF;
			IF SV_tipo_terminal = 'S' OR SV_tipo_terminal = 'A' THEN
				SELECT val_parametro
				INTO GV_sim_gsm
				FROM ged_parametros
				WHERE nom_parametro='COD_SIMCARD_GSM'
				AND cod_modulo='AL'
				AND cod_producto= PV_GENERAL_OOSS_PG.CN_cod_producto;
			END IF;
		ELSE
			SV_tipo_terminal := 'A'; --Borrar
		END IF;

		RETURN TRUE;
	EXCEPTION
		WHEN NO_DATA_FOUND THEN
			 RETURN FALSE;
			 SV_error := 4;
			 SV_sqlerrm := 'NO SE ENCUENTRA SINIESTRO';

		WHEN OTHERS THEN
			 RETURN FALSE;
			 SV_error := 4;
			 SV_sqlcode := SQLCODE;
			 SV_sqlerrm := SQLERRM;

END PV_RECUPERA_TERMINAL_FN;

END PV_AVISO_SINIESTRO_PG;
/
SHOW ERRORS
