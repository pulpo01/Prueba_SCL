CREATE OR REPLACE PACKAGE BODY PV_ANULA_SINIESTRO_PG IS


FUNCTION RETORNA_VERSION RETURN VARCHAR2 --Modificaco por Soporte - Alejandro Hott - 30/11/2004 - TM-200411151097
IS
  p_version    CONSTANT VARCHAR2(3) := '001';
  p_subversion CONSTANT VARCHAR2(3) := '003'; --Modificaco por Soporte - Alejandro Hott - 29/11/2004 - TM-200411151097
BEGIN
   RETURN('Version : '||p_version||' <--> SubVersion : '||p_subversion);
END;

PROCEDURE PV_CARGA_ANULA_PR(EN_NUM_CELULAR  IN GA_ABOCEL.NUM_CELULAR%TYPE,
		    				EV_USUARIO	    IN GE_SEG_USUARIO.NOM_USUARIO%TYPE,
					        SV_CURSOR 	    OUT vCursor,
							SV_MENS_ERROR	OUT VARCHAR2,							
							SV_ERROR        OUT VARCHAR2)


			
/*
<DOC>
<NOMBRE>      PV_CARGA_ANULA_PR                                  </NOMBRE>
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
  v_Cursor             vCursor;
  vn_NumAbonado        GA_ABOCEL.NUM_ABONADO%TYPE;	
  vn_CodProducto       GA_ABOCEL.COD_PRODUCTO%TYPE;  	
  vn_CodActuacion      VARCHAR2(2) := 'AN';
  vv_Proc 		       VARCHAR2(255);
  vv_Tabla 		 	   VARCHAR2(255);
  vv_Act 		 	   VARCHAR2(255);
  vv_SqlCode		   VARCHAR2(255); 
  vv_Parametro	       VARCHAR2(255);
  vv_MensajeErr		   VARCHAR2(255);	
  vv_ErrorCode		   VARCHAR2(255);
  vn_Implicons	       NUMBER(14,4);
  vn_Ret			   NUMBER(1);
  vb_Ret		       BOOLEAN;
  VALIDA_ERROR   	   EXCEPTION;

BEGIN
	   SV_ERROR   := '0';
	   vv_proc 	  := 'PV_CARGA_ANULA_PR';
	   vv_act 	  := 'S';
	   vv_tabla   := '';  

	   vn_NumAbonado:=-1;
  	   PV_GENERAL_OOSS_PG.PV_DATOS_ABONADO_PR (EN_NUM_CELULAR,vn_Implicons,vv_Proc,vv_Tabla,vv_Act,vv_SqlCode,SV_MENS_ERROR,SV_ERROR); 
	   IF SV_ERROR = '4' THEN
	   	  vn_Ret := 3;
	   	  RAISE VALIDA_ERROR;
	   END IF;
	   
	   vn_NumAbonado := PV_GENERAL_OOSS_PG.VP_NUM_ABONADO;
  	   vn_CodProducto:=	PV_GENERAL_OOSS_PG.VP_COD_PRODUCTO;	   
	   
	   
  	   IF NOT PV_GENERAL_OOSS_PG.PV_VALIDA_USUARIO_FN(EV_USUARIO,SV_ERROR,vv_Proc,vv_Tabla,vv_Act,vv_SqlCode,SV_MENS_ERROR) THEN
	   	  vn_Ret := '1';
	   	  RAISE VALIDA_ERROR;
	   END IF;
	  

	   vv_Parametro := '||||' || CV_Cod_Actuacion || '|' || TO_CHAR(vn_NumAbonado) || '|' || '||||||||||||||||||' || TO_CHAR(EN_NUM_CELULAR)|| '|';
	   IF NOT PV_GENERAL_OOSS_PG.PV_EJEC_RESTRICCION_FN(CV_Cod_Modulo,CN_Cod_Producto,CV_Cod_Actuacion,CV_Evento,vv_Parametro,vv_Proc,vv_Tabla,vv_Act,vv_SqlCode,SV_MENS_ERROR,SV_ERROR) THEN
	   	  vn_Ret := '0';
	      RAISE VALIDA_ERROR;
	   END IF;  

	  	   
	   IF NOT PV_ANULA_SINIESTRO_PG.PV_REC_DATOS_SINIESTROS_FN(vn_NumAbonado,vn_CodProducto,v_Cursor,vv_Proc,vv_Tabla,vv_Act,vv_SqlCode,SV_MENS_ERROR,SV_ERROR) THEN
	   	  vn_Ret := '2';
		  RAISE VALIDA_ERROR;	
	   ELSE 
	   	  SV_CURSOR:= v_Cursor;		  
	   END IF;
	   	  
       EXCEPTION
				WHEN VALIDA_ERROR THEN
					 BEGIN
						 vv_ErrorCode := '-3000';
						 IF vn_Ret = 0 THEN
						   -- Inicio Modificación TM-200502141271 - 23/02/2005 - JJR.-
					 	   -- vv_MensajeErr := 'No puede realizar Anulación de Siniestro.';
					 	      vv_MensajeErr := 'Anulación No Exitosa';
					 	   -- Fin Modificación TM-200502141271 - 23/02/2005 - JJR.-
				 		 	
						 ELSIF vn_Ret = 1 THEN
						        -- Inicio Modificación TM-200502141271 - 23/02/2005 - JJR.-
				 		 	-- vv_MensajeErr := 'Usuario no válido.';					 
				 		 	   vv_MensajeErr := 'Usuario No Válido';
				 		 	-- Fin Modificación TM-200502141271 - 23/02/2005 - JJR.-
						 ELSIF vn_Ret = 2 THEN
						        -- Inicio Modificación TM-200502141271 - 23/02/2005 - JJR.-
				 		 	-- vv_MensajeErr := 'Error al recuperar información de Siniestros';	
				 		 	   vv_MensajeErr := 'Transacción Erronea, Reintente';	
				 		 	-- Fin Modificación TM-200502141271 - 23/02/2005 - JJR.-
						 ELSIF vn_Ret = 3 THEN
						   -- Inicio Modificación TM-200502141271 - 23/02/2005 - JJR.-
					 	   -- vv_MensajeErr := 'Celular No existe en Operador';
					 	      vv_MensajeErr := 'Número Tel. No Registrado';
					 	   -- Fin Modificación TM-200502141271 - 23/02/2005 - JJR.- 				 
						 END IF;

					 	vb_Ret:= PV_GENERAL_OOSS_PG.PV_GA_ERRORES_FN(vn_NumAbonado,vn_CodActuacion,CN_Cod_Producto,SV_ERROR,vv_Proc,vv_Tabla,vv_Act,vv_ErrorCode,vv_MensajeErr,vv_SqlCode,SV_MENS_ERROR);
						IF VB_RET  THEN
						   SV_ERROR	     := 4;
						   vv_SqlCode    := vv_ErrorCode;
						   SV_MENS_ERROR := vv_MensajeErr;
						   COMMIT;
						END IF;
					 	EXCEPTION
						WHEN OTHERS THEN
					   	     SV_ERROR	   := 4;						
							 vv_SqlCode    := SQLCODE;
					 		 SV_MENS_ERROR := SQLERRM;
					 END;	   
				WHEN OTHERS THEN
					 vv_ErrorCode := SQLCODE;
			 		 vv_MensajeErr := SQLERRM;
					 BEGIN
					 	vb_Ret:= PV_GENERAL_OOSS_PG.PV_GA_ERRORES_FN(vn_NumAbonado,vn_CodActuacion,CN_Cod_Producto,SV_ERROR,vv_Proc,vv_Tabla,vv_Act,vv_ErrorCode,vv_MensajeErr,vv_SqlCode,SV_MENS_ERROR);
						IF VB_RET  THEN
						     SV_ERROR	   := 4;						
							 vv_SqlCode    := vv_ErrorCode;
					 		 SV_MENS_ERROR := vv_MensajeErr ;						
						     COMMIT;
						END IF;
					 	EXCEPTION
						WHEN OTHERS THEN
  						     SV_ERROR	   := 4;
							 vv_SqlCode    := SQLCODE;
					 		 SV_MENS_ERROR := SQLERRM;
					 END;	   
					 	   
END PV_CARGA_ANULA_PR;

 
FUNCTION PV_REC_DATOS_SINIESTROS_FN	  (EN_NUM_ABONADO   IN GA_ABOCEL.NUM_ABONADO%TYPE,
	  							 	   EN_COD_PRODUCTO  IN GA_ABOCEL.COD_PRODUCTO%TYPE,
		 							   SV_CURSOR 	   OUT vCursor,															
					              	   SV_PROC         OUT VARCHAR2,
					           		   SV_TABLA        OUT VARCHAR2,
					           		   SV_ACT     	   OUT VARCHAR2,
					           		   SV_SQLCODE      OUT VARCHAR2,
					           		   SV_SQLERRM      OUT VARCHAR2,
					           		   SV_ERROR        OUT VARCHAR2)  RETURN BOOLEAN
/*
<DOC>
<NOMBRE>      PV_REC_DATOS_SINIESTROS_FN                         </NOMBRE>
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
  v_Cursor          vCursor;
BEGIN

	   SV_error   := '0';
	   SV_proc 	  := 'PV_REC_DATOS_SINIESTROS_FN';
	   SV_act 	  := 'S';
	   SV_tabla   := 'GA_SINIESTROS';  

	   OPEN v_Cursor FOR
	   SELECT  A.NUM_SINIESTRO,
  			   B.COD_ESTADO,
  			   C.DES_ESTADO,
  			   A.COD_CAUSA,
  			   D.DES_CAUSA,
  			   A.FEC_SINIESTRO,
  			   A.FEC_FORMALIZA,
  			   A.FEC_ANULA, 
  			   A.FEC_RESTITUC,
  			   A.NUM_CONSTPOL,
			   B.OBS_DETALLE,
  			   A.COD_ESTADO,
  			   A.NUM_SERIE,
  			   NVL(E.DES_TERMINAL,'TERMINAL TDMA') DES_TERMINAL
		FROM  GA_SINIESTROS A, GA_DETSINIE B, GA_ESTADOSIN C, GA_CAUSINIE D, AL_TIPOS_TERMINALES E
		WHERE B.COD_ESTADO     = C.COD_ESTADO 
		AND   A.NUM_SINIESTRO  = B.NUM_SINIESTRO 
		AND   A.COD_CAUSA      = D.COD_CAUSA 
		AND   A.COD_PRODUCTO   = D.COD_PRODUCTO 
		AND   A.COD_PRODUCTO   = EN_COD_PRODUCTO 
		AND   A.NUM_ABONADO    = EN_NUM_ABONADO 
		AND   A.TIP_TERMINAL   = E.TIP_TERMINAL (+) 
		AND   A.COD_PRODUCTO   = E.COD_PRODUCTO (+) 
		ORDER BY A.NUM_SINIESTRO, B.FEC_DETALLE, A.FEC_FORMALIZA;
		
		SV_CURSOR:= v_Cursor;

	    RETURN TRUE;
	    EXCEPTION
				WHEN OTHERS THEN
			 		 SV_error := 4;
					 SV_sqlcode := SQLCODE;
			 		 SV_sqlerrm := SQLERRM;
					 RETURN FALSE;	   
END PV_REC_DATOS_SINIESTROS_FN;


PROCEDURE PV_PROCESA_ANULACION_PR(EN_NUM_CELULAR   IN  GA_ABOCEL.NUM_CELULAR%TYPE,
	  		    				  EV_USUARIO	   IN  GE_SEG_USUARIO.NOM_USUARIO%TYPE,
								  EN_NUM_SINIESTRO IN  GA_SINIESTROS.NUM_SINIESTRO%TYPE,
								  SN_NUM_OS		   OUT CI_ORSERV.NUM_OS%TYPE,
						          SV_MENS_ERROR	   OUT VARCHAR2,
								  SV_ERROR         OUT VARCHAR2)
 
/*
<DOC>
<NOMBRE>      PV_PROCESA_ANULACION_PR                            </NOMBRE>
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
  vn_NumAbonado     GA_ABOCEL.NUM_ABONADO%TYPE;	
  vn_CodProducto 	GA_ABOCEL.COD_PRODUCTO%TYPE;
  vv_CodTecnologia  GA_ABOCEL.COD_TECNOLOGIA%TYPE;
  vv_CodSituacion   GA_ABOCEL.COD_SITUACION%TYPE;
  vn_CodCliente     GA_ABOCEL.COD_CLIENTE%TYPE;
  vn_NumICC	   	    GA_ABOCEL.NUM_SERIE%TYPE; 
  vn_NumOOSS		CI_ORSERV.NUM_OS%TYPE;
  vn_CodCiclo		GA_ABOCEL.COD_CICLO%TYPE;
  vv_CodPlanServ	GA_ABOCEL.COD_PLANSERV%TYPE;
  vd_FecAlta		GA_ABOCEL.FEC_ALTA%TYPE;
  vn_CodActuacion   VARCHAR2(2) := 'AN';	
  vv_Proc 		    VARCHAR2(255);
  vv_Tabla 		    VARCHAR2(255);
  vv_Act 		    VARCHAR2(255);
  vv_SqlCode        VARCHAR2(255);    
  vv_Parametro	    VARCHAR2(255);
  vv_MensajeErr		VARCHAR2(255);	
  vv_ErrorCode		VARCHAR2(255);
  vn_Ret			NUMBER(1);  
  vn_Secuencia      NUMBER(10);
  vn_Implicons	    NUMBER(14,4);  	
  vn_Error			NUMBER(1);
  vb_CheqTerm	    BOOLEAN;
  vb_Ret		    BOOLEAN;	
  VALIDA_ERROR   	EXCEPTION;
   
BEGIN
	   SV_ERROR   := '0';
	   vv_proc 	  := 'PV_PROCESA_ANULACION_PR';
	   vv_act 	  := 'S';
	   vv_tabla   := '';  
  
   	   IF NOT PV_GENERAL_OOSS_PG.PV_VALIDA_USUARIO_FN(EV_USUARIO,vv_Proc,vv_Tabla,vv_Act,vv_SqlCode,SV_MENS_ERROR,SV_ERROR) THEN
	   	  vn_Ret := 2;
	   	  RAISE VALIDA_ERROR;
	   END IF;
 	   dbms_output.put_line('UNO');
     PV_GENERAL_OOSS_PG.PV_DATOS_ABONADO_PR (EN_NUM_CELULAR,vn_Implicons,vv_Proc,vv_Tabla,vv_Act,vv_SqlCode,SV_MENS_ERROR,SV_ERROR); 
   	   dbms_output.put_line('DOS');
	   vn_NumAbonado    := PV_GENERAL_OOSS_PG.VP_NUM_ABONADO;
  	   vn_CodProducto	:= PV_GENERAL_OOSS_PG.VP_COD_PRODUCTO;	   
  	   vn_CodCliente    := PV_GENERAL_OOSS_PG.VP_COD_CLIENTE;	   
	   vv_CodTecnologia := PV_GENERAL_OOSS_PG.VP_COD_TECNOLOGIA;
	   vv_CodSituacion  := PV_GENERAL_OOSS_PG.VP_COD_SITUACION;	   
	   vn_NumICC  	   	:= PV_GENERAL_OOSS_PG.VP_NUM_SERIE;
	   vv_CodPlanServ	:= PV_GENERAL_OOSS_PG.VP_COD_PLANSERV;
	   vd_FecAlta		:= PV_GENERAL_OOSS_PG.VP_FEC_ALTA;
	   vn_CodCiclo		:= PV_GENERAL_OOSS_PG.VP_COD_CICLO;
	   vb_CheqTerm 		:= FALSE;
	   
   	   vn_Ret := 0;

		IF PV_VALIDA_SINIESTRO_FN(EN_NUM_SINIESTRO,vv_Proc,vv_Tabla,vv_Act,vv_SqlCode,SV_MENS_ERROR,SV_ERROR) THEN
			IF PV_UPD_ANULACION_SINIESTRO_FN(EN_NUM_SINIESTRO,vv_Proc,vv_Tabla,vv_Act,vv_SqlCode,SV_MENS_ERROR,SV_ERROR) THEN
				IF PV_INS_DET_ANUL_SINIESTRO_FN(EN_NUM_SINIESTRO,EV_USUARIO,vv_Proc,vv_Tabla,vv_Act,vv_SqlCode,SV_MENS_ERROR,SV_ERROR) THEN
					vb_CheqTerm := PV_CHEQUEA_TERMINAL_FN(EN_NUM_SINIESTRO,vn_NumAbonado,vv_CodTecnologia,vv_CodSituacion,CV_Cod_Modulo,CV_Suspendido,vv_Proc,vv_Tabla,vv_Act,vv_SqlCode,SV_MENS_ERROR,SV_ERROR);
					IF vb_CheqTerm THEN
						IF PV_REHABILITA_SUSPENSION_FN (vv_Proc,vv_Tabla,vv_Act,vv_SqlCode,SV_MENS_ERROR,SV_ERROR) THEN
							IF PV_RESTITUIR_CARGO_BSCO_FN(EN_NUM_SINIESTRO,vv_Proc,vv_Tabla,vv_Act,vv_SqlCode,SV_MENS_ERROR,SV_ERROR) THEN
								IF PV_DEL_LISTAS_NEGRAS_FN(vn_NumAbonado,vn_NumICC,vv_Proc,vv_Tabla,vv_Act,vv_SqlCode,SV_MENS_ERROR,SV_ERROR) THEN
									IF PV_PASO_HIST_SINIESTRO_FN(EN_NUM_SINIESTRO,vv_Proc,vv_Tabla,vv_Act,vv_SqlCode,SV_MENS_ERROR,SV_ERROR) THEN
										IF vn_CodCiclo <> 25 THEN
											IF NOT PV_ASIGNA_CARGOS_FN(vn_CodCliente,vn_CodProducto,vv_CodPlanServ,vn_NumAbonado,EN_NUM_CELULAR,vd_FecAlta,EV_USUARIO,vv_Proc,vv_Tabla,vv_Act,vv_SqlCode,SV_MENS_ERROR,SV_ERROR) THEN
												vn_Ret := 1;
												RAISE VALIDA_ERROR;
											END IF;
										END IF;
									ELSE
										vn_Ret := 1;
										RAISE VALIDA_ERROR;
									END IF;
								ELSE
									vn_Ret := 1;
									RAISE VALIDA_ERROR;
								END IF;
							ELSE
								vn_Ret := 1;
								RAISE VALIDA_ERROR;
							END IF;
						ELSE
						vn_Ret := 1;
						RAISE VALIDA_ERROR;
						END IF;
					END IF;
				ELSE
					vn_Ret := 1;
					RAISE VALIDA_ERROR;
				END IF;
			ELSE
				vn_Ret := 1;
				RAISE VALIDA_ERROR;
			END IF;
		ELSE
			vn_Ret := 0;
			RAISE VALIDA_ERROR;
		END IF;
  
	   PV_EJEC_OOSS_PR(EV_USUARIO,EN_NUM_CELULAR,vn_NumOOSS,vv_Proc,vv_Tabla,vv_Act,vv_SqlCode,SV_MENS_ERROR,SV_ERROR);									 
   	   IF vb_CheqTerm THEN
	   	  PV_MOV_ANULSINIES_PR(EN_NUM_CELULAR,EV_USUARIO,vn_NumOOSS,vv_Proc,vv_Tabla,vv_Act,vv_SqlCode,SV_MENS_ERROR,SV_ERROR);
	   END IF;
	   COMMIT;
	   SN_NUM_OS:=vn_NumOOSS;
	   -- Inicio Modificación TM-200502141271 - 23/02/2005 - JJR.-
	   -- SV_MENS_ERROR:='ANULACION DE SINIESTRO EXITOSO';
	      SV_MENS_ERROR:='Transacción Exitosa';
	   -- Fin Modificación TM-200502141271 - 23/02/2005 - JJR.-
	   EXCEPTION
				WHEN VALIDA_ERROR THEN
			 		 SV_ERROR := 4;
					 vv_ErrorCode := -3000;
					 IF vn_Ret = 0 THEN
					 	vv_MensajeErr   := 'No existe Siniestro seleccionado';
					 ELSIF vn_Ret = 1 THEN
					 	-- Inicio Modificación TM-200502141271 - 23/02/2005 - JJR.-
					 	-- vv_MensajeErr := 'Error al intentar realizar una Anulación de Siniestro';
					 	   vv_MensajeErr := 'Transacción No Exitosa';
					 	-- Fin Modificación TM-200502141271 - 23/02/2005 - JJR.-
					 ELSIF vn_Ret = 2 THEN
					           -- Inicio Modificación TM-200502141271 - 23/02/2005 - JJR.-
				 		   -- vv_MensajeErr := 'Usuario no válido.';					 
				 		      vv_MensajeErr := 'Usuario No Válido';
				 		   -- Fin Modificación TM-200502141271 - 23/02/2005 - JJR.-
					 	   
					 END IF;
					 BEGIN
					    ROLLBACK;
					 	vb_Ret:= PV_GENERAL_OOSS_PG.PV_GA_ERRORES_FN(vn_NumAbonado,vn_CodActuacion,CN_Cod_Producto,SV_ERROR,vv_Proc,vv_Tabla,vv_Act,vv_ErrorCode,vv_MensajeErr,vv_SqlCode,SV_MENS_ERROR);
						IF vb_Ret THEN
						   SV_ERROR      := 4;
						   vv_SqlCode    := vv_ErrorCode;
   				 		   SV_MENS_ERROR := vv_MensajeErr;
					       COMMIT;
						END IF;
					 	EXCEPTION
						WHEN OTHERS THEN
					 		 SV_ERROR      := 4;
							 vv_SqlCode    := SQLCODE;
					 		 SV_MENS_ERROR := SQLERRM;
					 END;	   
				WHEN OTHERS THEN
					 vv_ErrorCode := SQLCODE;
			 		 vv_MensajeErr := SQLERRM;
					 BEGIN
					    ROLLBACK;
					 	vb_Ret:= PV_GENERAL_OOSS_PG.PV_GA_ERRORES_FN(vn_NumAbonado,vn_CodActuacion,CN_Cod_Producto,SV_ERROR,vv_Proc,vv_Tabla,vv_Act,vv_ErrorCode,vv_MensajeErr,vv_SqlCode,SV_MENS_ERROR);
						IF VB_RET  THEN
						     SV_ERROR	   := 4;						
							 vv_SqlCode    := vv_ErrorCode;
					 		 SV_MENS_ERROR := vv_MensajeErr ;	
						     COMMIT;
						END IF;
					 	EXCEPTION
						WHEN OTHERS THEN
  						     SV_ERROR	   := 4;
							 vv_SqlCode    := SQLCODE;
					 		 SV_MENS_ERROR := SQLERRM;
					 END;	   
END PV_PROCESA_ANULACION_PR;


FUNCTION  PV_VALIDA_SINIESTRO_FN       (EN_NUM_SINIESTRO IN GA_SINIESTROS.NUM_SINIESTRO%TYPE,
					           	  		SV_PROC          OUT VARCHAR2,
					          	  		SV_TABLA         OUT VARCHAR2,
					           	  		SV_ACT     	   	 OUT VARCHAR2,
					           	  		SV_SQLCODE       OUT VARCHAR2,
					           	  		SV_SQLERRM       OUT VARCHAR2,
					           	  		SV_ERROR         OUT VARCHAR2) RETURN BOOLEAN
/*
<DOC>
<NOMBRE>      PV_VALIDA_SINIESTRO_FN                      </NOMBRE>
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
   vn_Reg NUMBER(1);
BEGIN
 	   SV_error   := '0';
	   SV_proc 	  := 'PV_VALIDA_SINIESTRO_FN';
	   SV_act 	  := 'S';
	   SV_tabla   := 'GA_SINIESTROS'; 
	   
	   SELECT COUNT(1) 
	   INTO vn_Reg
	   FROM GA_SINIESTROS  
	   WHERE  NUM_SINIESTRO = EN_NUM_SINIESTRO;
	   
	   IF vn_Reg <> 0 THEN
	   	   RETURN TRUE;
	   ELSE
	   	   RETURN FALSE;	   
	   END IF;
	   EXCEPTION
				WHEN OTHERS THEN
			 		 SV_error := 4;
					 SV_sqlcode := SQLCODE;
			 		 SV_sqlerrm := SQLERRM;
					 
					 RETURN FALSE;	
END PV_VALIDA_SINIESTRO_FN;

FUNCTION  PV_UPD_ANULACION_SINIESTRO_FN(EN_NUM_SINIESTRO IN GA_SINIESTROS.NUM_SINIESTRO%TYPE,
					           	  		SV_PROC          OUT VARCHAR2,
					          	  		SV_TABLA         OUT VARCHAR2,
					           	  		SV_ACT     	   	 OUT VARCHAR2,
					           	  		SV_SQLCODE       OUT VARCHAR2,
					           	  		SV_SQLERRM       OUT VARCHAR2,
					           	  		SV_ERROR         OUT VARCHAR2) RETURN BOOLEAN
/*
<DOC>
<NOMBRE>      PV_UPD_ANULACION_SINIESTRO_FN                      </NOMBRE>
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

BEGIN
 	   SV_error   := '0';
	   SV_proc 	  := 'PV_UPD_ANULACION_SINIESTRO_FN';
	   SV_act 	  := 'U';
	   SV_tabla   := 'GA_SINIESTROS'; 
	   
	   UPDATE GA_SINIESTROS SET 
	  		  COD_ESTADO 	= 'AN', 
	  	  	  FEC_ANULA 	=  SYSDATE 
	   WHERE  NUM_SINIESTRO = EN_NUM_SINIESTRO;

	   RETURN TRUE;
	   
	   EXCEPTION
				WHEN OTHERS THEN
			 		 SV_error := 4;
					 SV_sqlcode := SQLCODE;
			 		 SV_sqlerrm := SQLERRM;
					 RETURN FALSE;	
END PV_UPD_ANULACION_SINIESTRO_FN;

FUNCTION  PV_INS_DET_ANUL_SINIESTRO_FN (EN_NUM_SINIESTRO  IN GA_SINIESTROS.NUM_SINIESTRO%TYPE,
   	  		    				   	    EV_USUARIO	   	  IN GE_SEG_USUARIO.NOM_USUARIO%TYPE,		  							  
					           	  		SV_PROC          OUT VARCHAR2,
					          	  		SV_TABLA         OUT VARCHAR2,
					           	  		SV_ACT     	   	 OUT VARCHAR2,
					           	  		SV_SQLCODE       OUT VARCHAR2,
					           	  		SV_SQLERRM       OUT VARCHAR2,
					           	  		SV_ERROR         OUT VARCHAR2) RETURN BOOLEAN
/*
<DOC>
<NOMBRE>      PV_INS_DET_ANUL_SINIESTRO_FN                       </NOMBRE>
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

  vv_ObsDetalle  GA_DETSINIE.OBS_DETALLE%TYPE;
  	 
BEGIN
 	   SV_error   := '0';
	   SV_proc 	  := 'PV_INS_DET_ANUL_SINIESTRO_FN';
	   SV_act 	  := 'I';
	   SV_tabla   := 'GA_DETSINIE'; 

	   vv_ObsDetalle := CV_Comentario;
	   
	   INSERT INTO GA_DETSINIE  (NUM_SINIESTRO, 	COD_ESTADO, FEC_DETALLE, NOM_USUARORA, OBS_DETALLE)
	   		  	   VALUES		(EN_NUM_SINIESTRO,  'AN',		SYSDATE,	 EV_USUARIO,   vv_ObsDetalle);

	   RETURN TRUE;
	   
	   EXCEPTION
				WHEN OTHERS THEN
			 		 SV_error := 4;
					 SV_sqlcode := SQLCODE;
			 		 SV_sqlerrm := SQLERRM;
					 RETURN FALSE;	   
END PV_INS_DET_ANUL_SINIESTRO_FN;

FUNCTION  PV_CHEQUEA_TERMINAL_FN 	   (EN_NUM_SINIESTRO  IN GA_SINIESTROS.NUM_SINIESTRO%TYPE,
					           	  		EN_NUM_ABONADO 	  IN GA_ABOCEL.NUM_ABONADO%TYPE,
										EV_COD_TECNOLOGIA IN GA_ABOCEL.COD_TECNOLOGIA%TYPE,
										EV_COD_SITUACION  IN GA_ABOCEL.COD_SITUACION%TYPE,
										EV_COD_MODULO     IN GA_SUSPREHABO.COD_MODULO%TYPE,
										EV_COD_SUSP		  IN GA_ABOCEL.COD_SITUACION%TYPE,
										SV_PROC          OUT VARCHAR2,
					          	  		SV_TABLA         OUT VARCHAR2,
					           	  		SV_ACT     	   	 OUT VARCHAR2,
					           	  		SV_SQLCODE       OUT VARCHAR2,
					           	  		SV_SQLERRM       OUT VARCHAR2,
					           	  		SV_ERROR         OUT VARCHAR2) RETURN BOOLEAN
/*
<DOC>
<NOMBRE>      PV_CHEQUEA_TERMINAL_FN    				         </NOMBRE>
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
  vv_CodModulo	   GA_SUSPREHABO.COD_MODULO%TYPE;
  vn_Regs		   NUMBER(2):=2;
  vn_Total		   NUMBER(2);
  vb_Return		   BOOLEAN;
  vn_Tipo		   NUMBER(1);
BEGIN
 	   SV_error   := '0';
	   SV_proc 	  := 'PV_CHEQUEA_TERMINAL_FN';
	   SV_act 	  := 'S';
	   SV_tabla   := ''; 

	   
	   SELECT COUNT(1) INTO vn_Total FROM GA_SINIESTROS WHERE NUM_ABONADO = EN_NUM_ABONADO;
	   
	   IF vn_Total = vn_Regs THEN
			SELECT COUNT(1) INTO vn_Tipo
			FROM   GA_SINIESTROS 
			WHERE  NUM_SINIESTRO = EN_NUM_SINIESTRO
			AND    TIP_TERMINAL  =  ge_fn_devvalparam('AL',1,'COD_SIMCARD_GSM'); 
			 
			IF vn_Tipo = 0 THEN 
			   vb_Return   := TRUE;
			ELSE
			   vb_Return   := FALSE;			
			END IF;
			
			RETURN vb_Return;
	   ELSE 
	   		IF  (vn_Total = 1) AND (ge_fn_devvalparam('GA',1,'TECNOLOGIA_GSM') = EV_COD_TECNOLOGIA) THEN
				SELECT COUNT(1) INTO vn_Total  FROM GA_SUSPREHABO WHERE NUM_ABONADO 	= EN_NUM_ABONADO;
				IF  vn_Total > 1 THEN
					SELECT COD_MODULO INTO vv_CodModulo FROM GA_SUSPREHABO
					WHERE NUM_ABONADO = EN_NUM_ABONADO
					AND   COD_MODULO  = 'GA'; 
				ELSE
					SELECT COD_MODULO INTO vv_CodModulo FROM GA_SUSPREHABO
					WHERE NUM_ABONADO = EN_NUM_ABONADO;
				END IF;	
				IF  EV_COD_SITUACION = EV_COD_SUSP AND  vv_CodModulo = EV_COD_MODULO THEN
					vb_Return   := TRUE;
				ELSE
				   	vb_Return   := FALSE;					
				END IF;
			ELSIF vn_Total = 1 THEN
				 vb_Return   := TRUE;
			END IF;   
	   END IF;
	   
	   RETURN TRUE;
	   
	   EXCEPTION
				WHEN OTHERS THEN
			 		 SV_error := 4;
					 SV_sqlcode := SQLCODE;
			 		 SV_sqlerrm := SQLERRM;
					 RETURN FALSE;	   
END PV_CHEQUEA_TERMINAL_FN;

FUNCTION  PV_REHABILITA_SUSPENSION_FN  (SV_PROC          OUT VARCHAR2,
					          	  		SV_TABLA         OUT VARCHAR2,
					           	  		SV_ACT     	   	 OUT VARCHAR2,
					           	  		SV_SQLCODE       OUT VARCHAR2,
					           	  		SV_SQLERRM       OUT VARCHAR2,
					           	  		SV_ERROR         OUT VARCHAR2) RETURN BOOLEAN
/*
<DOC>
<NOMBRE>      PV_REHABILITA_SUSPENSION_FN   			         </NOMBRE>
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
  
  vn_NumAbonado     GA_ABOCEL.NUM_ABONADO%TYPE;
  vv_CodServicio	   GA_SUSPREHABO.COD_SERVICIO%TYPE;
  vd_FecSuspcen	   GA_SUSPREHABO.FEC_SUSPCEN%TYPE; 
BEGIN
 	   SV_error   := '0';
	   SV_proc 	  := 'PV_REHABILITA_SUSPENSION_FN';
	   SV_act 	  := 'S';
	   SV_tabla   := ''; 

	   vn_NumAbonado    := PV_GENERAL_OOSS_PG.VP_NUM_ABONADO;
	   
	   
	   IF NOT PV_ACTUALIZA_SITUACION_FN(vn_NumAbonado,SV_PROC,SV_TABLA,SV_ACT,SV_SQLCODE,SV_SQLERRM,SV_ERROR) THEN
	   	  RETURN FALSE;
	   END IF;
	
	   IF NOT PV_CONSULTA_SUSPENSION_FN (vn_NumAbonado,vv_CodServicio,vd_FecSuspcen,SV_PROC,SV_TABLA,SV_ACT,SV_SQLCODE,SV_SQLERRM,SV_ERROR) THEN
	   	  RETURN FALSE;
	   END IF;		

       IF NOT PV_MODIFICA_SUSPENSION_FN(vn_NumAbonado,vv_CodServicio,vd_FecSuspcen,SV_PROC,SV_TABLA,SV_ACT,SV_SQLCODE,SV_SQLERRM,SV_ERROR) THEN
	   	  RETURN FALSE;
	   END IF;		

	   RETURN TRUE;
	   
	   EXCEPTION
				WHEN OTHERS THEN
			 		 SV_error := 4;
					 SV_sqlcode := SQLCODE;
			 		 SV_sqlerrm := SQLERRM;
					 RETURN FALSE;	   
END PV_REHABILITA_SUSPENSION_FN;


FUNCTION  PV_ACTUALIZA_SITUACION_FN  (EN_NUM_ABONADO    IN GA_ABOCEL.NUM_ABONADO%TYPE,
		  							  SV_PROC          OUT VARCHAR2,
					          	  	  SV_TABLA         OUT VARCHAR2,
					           	  	  SV_ACT     	   OUT VARCHAR2,
					           	  	  SV_SQLCODE       OUT VARCHAR2,
					           	  	  SV_SQLERRM       OUT VARCHAR2,
					           	  	  SV_ERROR         OUT VARCHAR2) RETURN BOOLEAN
/*
<DOC>
<NOMBRE>      PV_ACTUALIZA_SITUACION_FN   			         </NOMBRE>
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
BEGIN
 	   SV_error   := '0';
	   SV_proc 	  := 'PV_ACTUALIZA_SITUACION_FN';
	   SV_act 	  := 'I';
	   SV_tabla   := ''; 

   
	   UPDATE  GA_ABOCEL SET 
  	   		   COD_SITUACION = DECODE (COD_SITUACION, 'SAA','RTP','AOS','RAO','ATS','RAT','CVS','RCV','RDS','RRD','RTP') 
  	  	   	  ,FEC_ULTMOD 	 = SYSDATE 
       WHERE   NUM_ABONADO   = EN_NUM_ABONADO;
  	   
	   UPDATE  GA_ABOAMIST SET 
  		   	   COD_SITUACION = DECODE (COD_SITUACION, 'SAA','RTP','AOS','RAO','ATS','RAT','CVS','RCV','RDS','RRD','RTP') 
  		  	  ,FEC_ULTMOD 	 = SYSDATE 
  	   WHERE   NUM_ABONADO   = EN_NUM_ABONADO;
		
		
	   RETURN TRUE;
	   
	   EXCEPTION
				WHEN OTHERS THEN
			 		 SV_error := 4;
					 SV_sqlcode := SQLCODE;
			 		 SV_sqlerrm := SQLERRM;
					 RETURN FALSE;	   
END PV_ACTUALIZA_SITUACION_FN;

FUNCTION  PV_CONSULTA_SUSPENSION_FN    (EN_NUM_ABONADO    IN GA_ABOCEL.NUM_ABONADO%TYPE,
		  							   	SN_COD_SERVICIO	 OUT GA_SUSPREHABO.COD_SERVICIO%TYPE,
		  							    SD_FEC_SUSPCEN	 OUT GA_SUSPREHABO.FEC_SUSPCEN%TYPE,
					           	  		SV_PROC          OUT VARCHAR2,
					          	  		SV_TABLA         OUT VARCHAR2,
					           	  		SV_ACT     	   	 OUT VARCHAR2,
					           	  		SV_SQLCODE       OUT VARCHAR2,
					           	  		SV_SQLERRM       OUT VARCHAR2,
					           	  		SV_ERROR         OUT VARCHAR2) RETURN BOOLEAN
/*
<DOC>
<NOMBRE>      PV_CONSULTA_SUSPENSION_FN   			         </NOMBRE>
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
  
  vn_CodServicio   GA_SUSPREHABO.COD_SERVICIO%TYPE;
  vd_FecSuspcen	   GA_SUSPREHABO.FEC_SUSPCEN%TYPE; 
BEGIN
 	   SV_error   := '0';
	   SV_proc 	  := 'PV_CONSULTA_SUSPENSION_FN';
	   SV_act 	  := 'S';
	   SV_tabla   := ''; 


		
		SELECT COD_SERVICIO, FEC_SUSPCEN 
		INTO   vn_CodServicio, vd_FecSuspcen
		FROM   GA_SUSPREHABO 
		WHERE  NUM_ABONADO   = EN_NUM_ABONADO
		 AND   IND_SINIESTRO = 1
		 AND   ROWNUM <=1
		 ORDER BY FEC_SUSPCEN DESC;

		 SN_COD_SERVICIO := vn_CodServicio;
		 SD_FEC_SUSPCEN  := vd_FecSuspcen;
	   RETURN TRUE;
	   
	   EXCEPTION
				WHEN OTHERS THEN
			 		 SV_error := 4;
					 SV_sqlcode := SQLCODE;
			 		 SV_sqlerrm := SQLERRM;
					 RETURN FALSE;	   
END PV_CONSULTA_SUSPENSION_FN;

FUNCTION  PV_MODIFICA_SUSPENSION_FN    (EN_NUM_ABONADO    IN GA_ABOCEL.NUM_ABONADO%TYPE,
		  							   	EN_COD_SERVICIO	  IN GA_SUSPREHABO.COD_SERVICIO%TYPE,
		  							    ED_FEC_SUSPCEN	  IN GA_SUSPREHABO.FEC_SUSPCEN%TYPE,
					           	  		SV_PROC          OUT VARCHAR2,
					          	  		SV_TABLA         OUT VARCHAR2,
					           	  		SV_ACT     	   	 OUT VARCHAR2,
					           	  		SV_SQLCODE       OUT VARCHAR2,
					           	  		SV_SQLERRM       OUT VARCHAR2,
					           	  		SV_ERROR         OUT VARCHAR2) RETURN BOOLEAN
/*
<DOC>
<NOMBRE>      PV_MODIFICA_SUSPENSION_FN   			         </NOMBRE>
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
  
BEGIN
 	   SV_error   := '0';
	   SV_proc 	  := 'PV_REHABILITA_SUSPENSION_FN';
	   SV_act 	  := 'U';
	   SV_tabla   := ''; 

		
		UPDATE GA_SUSPREHABO SET 
			   FEC_REHABD    = SYSDATE
			  ,TIP_REGISTRO  = 3 
		WHERE  NUM_ABONADO   = EN_NUM_ABONADO 
		  AND  IND_SINIESTRO = 1 
		  AND  COD_SERVICIO  = EN_COD_SERVICIO
		  AND  FEC_SUSPCEN	 = ED_FEC_SUSPCEN;	   
	   RETURN TRUE;
	   
	   EXCEPTION
				WHEN OTHERS THEN
			 		 SV_error := 4;
					 SV_sqlcode := SQLCODE;
			 		 SV_sqlerrm := SQLERRM;
					 RETURN FALSE;	   
END PV_MODIFICA_SUSPENSION_FN;

PROCEDURE  PV_MOV_ANULSINIES_PR  	   (EN_NUM_CELULAR   IN GA_ABOCEL.NUM_CELULAR%TYPE,
		   							    EV_USUARIO	   	 IN GE_SEG_USUARIO.NOM_USUARIO%TYPE,
										EN_NUM_OS		 IN CI_ORSERV.NUM_OS%TYPE,
					           	  		SV_PROC          OUT VARCHAR2,
					          	  		SV_TABLA         OUT VARCHAR2,
					           	  		SV_ACT     	   	 OUT VARCHAR2,
					           	  		SV_SQLCODE       OUT VARCHAR2,
					           	  		SV_SQLERRM       OUT VARCHAR2,
					           	  		SV_ERROR         OUT VARCHAR2)
/*
<DOC>
<NOMBRE>      PV_MOV_ANULSINIES_PR  			         	     </NOMBRE>
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
  
  vn_NumAbonado     GA_ABOCEL.NUM_ABONADO%TYPE;
  vv_CodPlanTarif   GA_ABOCEL.COD_PLANTARIF%TYPE;  
  vv_CodTecnologia  GA_ABOCEL.COD_TECNOLOGIA%TYPE;
  vn_NumSerie	    GA_ABOCEL.NUM_SERIE%TYPE;
  vn_NumICC	   	    GA_ABOCEL.NUM_SERIE%TYPE;
  v_TipTerminal	    GA_ABOCEL.TIP_TERMINAL%TYPE;
  v_CodCentral	    GA_ABOCEL.COD_CENTRAL%TYPE;
  vn_CodServicio	GA_SUSPREHABO.COD_SERVICIO%TYPE;
  vd_FecSuspcen	    GA_SUSPREHABO.FEC_SUSPCEN%TYPE; 
  vn_CodActabo	    PV_ACTABO_TIPLAN.COD_ACTABO%TYPE;
  vv_Imei		    ICC_MOVIMIENTO.IMSI%TYPE;
  vn_Secuencia  	ICC_MOVIMIENTO.NUM_MOVIMIENTO%TYPE;
  vn_PvSecuenc  	ICC_MOVIMIENTO.NUM_MOVIMIENTO%TYPE;
  vv_CodTipModi	    PV_ACTABO_TIPLAN.COD_TIPMODI%TYPE;
  vc_CodEstado	    CHAR(1):='1';
  vn_NumMin		    NUMBER(10);
  VALIDA_ERROR		EXCEPTION;
BEGIN
 	   SV_error   := '0';
	   SV_proc 	  := 'PV_MOV_ANULSINIES_PR';
	   SV_act 	  := 'S';
	   SV_tabla   := ''; 

	   vn_NumAbonado    := PV_GENERAL_OOSS_PG.VP_NUM_ABONADO;
   	   vv_CodPlanTarif  := PV_GENERAL_OOSS_PG.VP_COD_PLANTARIF;
	   vn_NumSerie      := PV_GENERAL_OOSS_PG.VP_NUM_SERIE;
	   v_TipTerminal    := PV_GENERAL_OOSS_PG.VP_TIP_TERMINAL;
	   v_CodCentral	    := PV_GENERAL_OOSS_PG.VP_COD_CENTRAL;
	   vv_CodTecnologia := PV_GENERAL_OOSS_PG.VP_COD_TECNOLOGIA;
	   --vv_CodTipModi	:= 'AN'; -- Comentado por Soporte - Alejandro Hott - 25/11/2004
	   vv_CodTipModi	:= 'RT'; -- Modificado por Soporte - Alejandro Hott - 25/11/2004
	   vn_NumMin	   	:= 0;
	   
	   IF  PV_GENERAL_OOSS_PG.VP_COD_CICLO <> 25 THEN  
	   	   vn_NumMin := AL_FN_PREFIJO_NUMERO(EN_NUM_CELULAR); 
		   vn_NumMin	   := 0;
	   END IF; 
	   vn_CodActabo := PV_RECUPERA_DTOS_MOV_FN (vv_CodPlanTarif,vv_CodTipModi,SV_PROC,SV_TABLA,SV_ACT,SV_SQLCODE,SV_SQLERRM,SV_ERROR);

	   IF vn_CodActabo = '' OR  vn_CodActabo IS NULL THEN
		  	 RAISE VALIDA_ERROR;
			 vn_CodActabo := '';
	   END IF;
	   
	   IF  ge_fn_devvalparam(CV_Cod_Modulo,CN_Cod_Producto,'TECNOLOGIA_GSM') = vv_CodTecnologia THEN
			  vv_Imei    :=PV_GENERAL_OOSS_PG.VP_NUM_IMEI;
			  vn_NumICC  :=PV_GENERAL_OOSS_PG.VP_NUM_SERIE;
	   ELSE
		 	  vv_Imei:=NULL;
	   END IF;
		 
	   SELECT ICC_SEQ_NUMMOV.NEXTVAL INTO vn_Secuencia FROM DUAL;
	   SELECT PV_ERRORES_SQ.NEXTVAL  INTO vn_PvSecuenc FROM DUAL;

	   IF PV_CONSULTA_SUSPENSION_FN (vn_NumAbonado,vn_CodServicio,vd_FecSuspcen,SV_PROC,SV_TABLA,SV_ACT,SV_SQLCODE,SV_SQLERRM,SV_ERROR) THEN

	   PV_GENERAL_OOSS_PG.PV_MOV_CENTRAL_PR(vn_Secuencia, vn_NumAbonado,    vc_CodEstado,  vn_CodActabo,     CV_Cod_Modulo,      EV_USUARIO,   SYSDATE,      v_TipTerminal,
		  		 						    v_CodCentral, 0,			    NULL, 	       EN_NUM_CELULAR,   vn_NumSerie,		 NULL,		   NULL,
   											vn_CodServicio,	      NULL,   vn_NumMin,	   NULL,		     vv_CodTecnologia,	 NULL,		   vv_Imei , -- Modificado por soporte - Alejandro Hott - 25/11/2004
   											NULL,		  vn_NumICC,	    NULL,		   NULL,		     NULL,			 	 NULL,  	   NULL,
   											NULL,		  SV_PROC,SV_TABLA, SV_ACT,		   SV_SQLCODE,		 SV_SQLERRM,		 SV_ERROR);
	     														  
	   END IF;		
	   
	   EXCEPTION
				WHEN OTHERS THEN
			 		 SV_error := 4;
					 SV_sqlcode := SQLCODE;
			 		 SV_sqlerrm := SQLERRM;
					 	   
END PV_MOV_ANULSINIES_PR;

FUNCTION  PV_RECUPERA_DTOS_MOV_FN  (    EV_COD_PLANTARIF  IN GA_ABOCEL.COD_PLANTARIF%TYPE,
		  						   		EN_COD_TIPMODI	  IN PV_ACTABO_TIPLAN.COD_TIPMODI%TYPE,
					           	  		SV_PROC          OUT VARCHAR2,
					          	  		SV_TABLA         OUT VARCHAR2,
					           	  		SV_ACT     	   	 OUT VARCHAR2,
					           	  		SV_SQLCODE       OUT VARCHAR2,
					           	  		SV_SQLERRM       OUT VARCHAR2,
					           	  		SV_ERROR         OUT VARCHAR2) RETURN PV_ACTABO_TIPLAN.COD_ACTABO%TYPE
/*
<DOC>
<NOMBRE>      PV_RECUPERA_DTOS_MOV_FN  			                 </NOMBRE>
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
  vn_CodActabo	   PV_ACTABO_TIPLAN.COD_ACTABO%TYPE; 
BEGIN
 	   SV_error   := '0';
	   SV_proc 	  := 'PV_RECUPERA_DTOS_MOV_FN';
	   SV_act 	  := 'S';
	   SV_tabla   := ''; 

	   
	   SELECT COD_ACTABO INTO vn_CodActabo 
	   FROM PV_ACTABO_TIPLAN
	   WHERE  COD_TIPMODI = EN_COD_TIPMODI
	    AND   COD_TIPLAN  = (SELECT COD_TIPLAN 
 	   			   	  	       FROM TA_PLANTARIF 
					          WHERE COD_PLANTARIF = EV_COD_PLANTARIF);

	   
	   RETURN vn_CodActabo;
	   
	   EXCEPTION
				WHEN OTHERS THEN
			 		 SV_error := 4;
					 SV_sqlcode := SQLCODE;
			 		 SV_sqlerrm := SQLERRM;
	   
END PV_RECUPERA_DTOS_MOV_FN;

FUNCTION PV_RESTITUIR_CARGO_BSCO_FN( EN_NUM_SINIESTRO  IN GA_SINIESTROS.NUM_SINIESTRO%TYPE,
					           	  	 SV_PROC          OUT VARCHAR2,
					          	  	 SV_TABLA         OUT VARCHAR2,
					           	  	 SV_ACT     	  OUT VARCHAR2,
					           	  	 SV_SQLCODE       OUT VARCHAR2,
					           	  	 SV_SQLERRM       OUT VARCHAR2,
					           	  	 SV_ERROR         OUT VARCHAR2) RETURN BOOLEAN
/*
<DOC>
<NOMBRE>      PV_RESTITUIR_CARGO_BSCO_FN                         </NOMBRE>
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
  vn_NumAbonado   GA_ABOCEL.NUM_ABONADO%TYPE;
  vn_CodCliente   GA_ABOCEL.COD_CLIENTE%TYPE;
  vn_CodProducto  GA_ABOCEL.COD_PRODUCTO%TYPE;
  vn_CodCiclo	  GA_ABOCEL.COD_CICLO%TYPE;
  vv_CodCargoBsco GA_SINIESTROS.COD_CARGOBASICO%TYPE;	
  vc_TipoAccion	  Char(1):='R';	
BEGIN
	   SV_error   := '0';
	   SV_proc 	  := 'PV_RESTITUIR_CARGO_BSCO_FN';
	   SV_act 	  := 'S';
	   SV_tabla   := '';  
  
	   vn_NumAbonado    := PV_GENERAL_OOSS_PG.VP_NUM_ABONADO;
	   vn_CodCliente    := PV_GENERAL_OOSS_PG.VP_COD_CLIENTE;
	   vn_CodProducto   := PV_GENERAL_OOSS_PG.VP_COD_PRODUCTO;
	   vn_CodCiclo	    := PV_GENERAL_OOSS_PG.VP_COD_CICLO; 
  	   vv_CodCargoBsco  := PV_RECUPERA_CARGO_BSCO_FN(EN_NUM_SINIESTRO,SV_PROC,SV_TABLA,SV_ACT,SV_SQLCODE,SV_SQLERRM,SV_ERROR);

	   IF vv_CodCargoBsco  IS NOT NULL THEN
	   	   P_CARGO_BASICO(vn_CodProducto,vn_CodCliente,vn_NumAbonado,vv_CodCargoBsco,vn_CodCiclo,SYSDATE,vc_TipoAccion,SV_PROC,SV_TABLA,SV_ACT,SV_SQLCODE,SV_SQLERRM,SV_ERROR);
	   END IF;
	   
	   RETURN TRUE;
	   
	   EXCEPTION
				WHEN OTHERS THEN
			 		 SV_error := 4;
					 SV_sqlcode := SQLCODE;
			 		 SV_sqlerrm := SQLERRM;

					 RETURN FALSE; 	   
END PV_RESTITUIR_CARGO_BSCO_FN;

FUNCTION PV_RECUPERA_CARGO_BSCO_FN  (EN_NUM_SINIESTRO   IN GA_SINIESTROS.NUM_SINIESTRO%TYPE,
					           	  	 SV_PROC            OUT VARCHAR2,
					          	  	 SV_TABLA           OUT VARCHAR2,
					           	  	 SV_ACT     	    OUT VARCHAR2,
					           	  	 SV_SQLCODE         OUT VARCHAR2,
					           	  	 SV_SQLERRM         OUT VARCHAR2,
					           	  	 SV_ERROR           OUT VARCHAR2) RETURN VARCHAR2
/*
<DOC>
<NOMBRE>      PV_RECUPERA_CARGO_BSCO_FN                         </NOMBRE>
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

  vv_CodCargoBsco GA_SINIESTROS.COD_CARGOBASICO%TYPE;		  		
BEGIN
	   SV_error   := '0';
	   SV_proc 	  := 'PV_RECUPERA_CARGO_BSCO_FN';
	   SV_act 	  := 'S';
	   SV_tabla   := '';  
  

	   
	   SELECT NVL(COD_CARGOBASICO,NULL) 
	   INTO   vv_CodCargoBsco
	   FROM   GA_SINIESTROS 
	   WHERE  NUM_SINIESTRO = EN_NUM_SINIESTRO;

	   RETURN vv_CodCargoBsco;

	   EXCEPTION
				WHEN NO_DATA_FOUND THEN
			 		 RETURN NULL;	   
				WHEN OTHERS THEN
			 		 SV_error := 4;
					 SV_sqlcode := SQLCODE;
			 		 SV_sqlerrm := SQLERRM;
	   					 
					 	   
END PV_RECUPERA_CARGO_BSCO_FN;

FUNCTION PV_DEL_LISTAS_NEGRAS_FN  (	 EN_NUM_ABONADO      IN GA_ABOCEL.NUM_ABONADO%TYPE,
		 						  	 EV_NUM_ICC			 IN GA_ABOCEL.NUM_SERIE%TYPE,
		 						  	 SV_PROC            OUT VARCHAR2,
					          	  	 SV_TABLA           OUT VARCHAR2,
					           	  	 SV_ACT     	    OUT VARCHAR2,
					           	  	 SV_SQLCODE         OUT VARCHAR2,
					           	  	 SV_SQLERRM         OUT VARCHAR2,
					           	  	 SV_ERROR           OUT VARCHAR2) RETURN BOOLEAN
/*
<DOC>
<NOMBRE>      PV_DEL_LISTAS_NEGRAS_FN                            </NOMBRE>
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

BEGIN
	   SV_error   := '0';
	   SV_proc 	  := 'PV_DEL_LISTAS_NEGRAS_FN';
	   SV_act 	  := 'S';
	   SV_tabla   := '';  
  
   
	   DELETE GA_LNCELU 
	   WHERE NUM_ABONADO = EN_NUM_ABONADO
	    AND NUM_SERIE = EV_NUM_ICC;

	   RETURN TRUE;

	   EXCEPTION
				WHEN OTHERS THEN
			 		 SV_error := 4;
					 SV_sqlcode := SQLCODE;
			 		 SV_sqlerrm := SQLERRM;
    				 RETURN FALSE;
	   					 
					 	   
END PV_DEL_LISTAS_NEGRAS_FN;

FUNCTION  PV_PASO_HIST_SINIESTRO_FN (EN_NUM_SINIESTRO   IN GA_SINIESTROS.NUM_SINIESTRO%TYPE,
					           	  	 SV_PROC            OUT VARCHAR2,
					          	  	 SV_TABLA           OUT VARCHAR2,
					           	  	 SV_ACT     	    OUT VARCHAR2,
					           	  	 SV_SQLCODE         OUT VARCHAR2,
					           	  	 SV_SQLERRM         OUT VARCHAR2,
					           	  	 SV_ERROR           OUT VARCHAR2) RETURN BOOLEAN
/*
<DOC>
<NOMBRE>      PV_PASO_HIST_SINIESTRO_FN                           </NOMBRE>
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
  vb_Ret  BOOLEAN;
BEGIN
	   SV_error   := '0';
	   SV_proc 	  := 'PV_PASO_HIST_SINIESTRO_FN';
	   SV_act 	  := '';
	   SV_tabla   := '';  
  
	   IF PV_HIST_DET_SINIESTRO_FN(EN_NUM_SINIESTRO,SV_PROC,SV_TABLA,SV_ACT,SV_SQLCODE,SV_SQLERRM,SV_ERROR) THEN
		   IF PV_DEL_DET_SINIESTRO_FN(EN_NUM_SINIESTRO,SV_PROC,SV_TABLA,SV_ACT,SV_SQLCODE,SV_SQLERRM,SV_ERROR) THEN
			   IF PV_HIST_SINIESTRO_FN(EN_NUM_SINIESTRO,SV_PROC,SV_TABLA,SV_ACT,SV_SQLCODE,SV_SQLERRM,SV_ERROR) THEN
			   	 vb_Ret := PV_DEL_SINIESTRO_FN(EN_NUM_SINIESTRO,SV_PROC,SV_TABLA,SV_ACT,SV_SQLCODE,SV_SQLERRM,SV_ERROR);
			   END IF;
		   END IF;
	   END IF;
	   RETURN TRUE;
	   EXCEPTION
				WHEN OTHERS THEN
			 		 SV_error := 4;
					 SV_sqlcode := SQLCODE;
			 		 SV_sqlerrm := SQLERRM;
	   				 RETURN FALSE;
	   					 
					 	   
END PV_PASO_HIST_SINIESTRO_FN;

FUNCTION PV_HIST_DET_SINIESTRO_FN  ( EN_NUM_SINIESTRO   IN GA_SINIESTROS.NUM_SINIESTRO%TYPE,
					           	  	 SV_PROC            OUT VARCHAR2,
					          	  	 SV_TABLA           OUT VARCHAR2,
					           	  	 SV_ACT     	    OUT VARCHAR2,
					           	  	 SV_SQLCODE         OUT VARCHAR2,
					           	  	 SV_SQLERRM         OUT VARCHAR2,
					           	  	 SV_ERROR           OUT VARCHAR2) RETURN BOOLEAN
/*
<DOC>
<NOMBRE>      PV_HIST_DET_SINIESTRO_FN                            </NOMBRE>
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

BEGIN
	   SV_error   := '0';
	   SV_proc 	  := 'PV_HIST_DET_SINIESTRO_FN';
	   SV_act 	  := 'I';
	   SV_tabla   := 'GA_HDETSINIE';  
  
  	   INSERT INTO GA_HDETSINIE (NUM_SINIESTRO, 
	   		  	   				 COD_ESTADO, 
								 FEC_DETALLE, 
								 NOM_USUARORA,
								 FEC_HISTORICO, 
								 OBS_DETALLE ) 
   			             (SELECT NUM_SINIESTRO, 
						 		 COD_ESTADO, 
								 FEC_DETALLE, 
								 NOM_USUARORA,
								 SYSDATE,       
								 OBS_DETALLE  
				          FROM   GA_DETSINIE 
				          WHERE NUM_SINIESTRO =EN_NUM_SINIESTRO); 
  
	   RETURN TRUE;

	   EXCEPTION
				WHEN OTHERS THEN
			 		 SV_error := 4;
					 SV_sqlcode := SQLCODE;
			 		 SV_sqlerrm := SQLERRM;
    				 RETURN FALSE;
	   					 
					 	   
END PV_HIST_DET_SINIESTRO_FN;

FUNCTION PV_DEL_DET_SINIESTRO_FN  (  EN_NUM_SINIESTRO   IN GA_SINIESTROS.NUM_SINIESTRO%TYPE,
					           	  	 SV_PROC            OUT VARCHAR2,
					          	  	 SV_TABLA           OUT VARCHAR2,
					           	  	 SV_ACT     	    OUT VARCHAR2,
					           	  	 SV_SQLCODE         OUT VARCHAR2,
					           	  	 SV_SQLERRM         OUT VARCHAR2,
					           	  	 SV_ERROR           OUT VARCHAR2) RETURN BOOLEAN
/*
<DOC>
<NOMBRE>      PV_DEL_DET_SINIESTRO_FN                            </NOMBRE>
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

BEGIN
	   SV_error   := '0';
	   SV_proc 	  := 'PV_DEL_DET_SINIESTRO_FN';
	   SV_act 	  := 'D';
	   SV_tabla   := 'GA_DETSINIE';  
  
  	   DELETE GA_DETSINIE 
	   WHERE NUM_SINIESTRO = EN_NUM_SINIESTRO;
   

  
	   RETURN TRUE;

	   EXCEPTION
				WHEN OTHERS THEN
			 		 SV_error := 4;
					 SV_sqlcode := SQLCODE;
			 		 SV_sqlerrm := SQLERRM;
    				 RETURN FALSE;
	   					 
					 	   
END PV_DEL_DET_SINIESTRO_FN;


FUNCTION PV_HIST_SINIESTRO_FN  (     EN_NUM_SINIESTRO   IN GA_SINIESTROS.NUM_SINIESTRO%TYPE,
					           	  	 SV_PROC            OUT VARCHAR2,
					          	  	 SV_TABLA           OUT VARCHAR2,
					           	  	 SV_ACT     	    OUT VARCHAR2,
					           	  	 SV_SQLCODE         OUT VARCHAR2,
					           	  	 SV_SQLERRM         OUT VARCHAR2,
					           	  	 SV_ERROR           OUT VARCHAR2) RETURN BOOLEAN
/*
<DOC>
<NOMBRE>      PV_HIST_SINIESTRO_FN                            </NOMBRE>
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

BEGIN
	   SV_error   := '0';
	   SV_proc 	  := 'PV_HIST_SINIESTRO_FN';
	   SV_act 	  := 'I';
	   SV_tabla   := 'GA_HSINIESTROS';  
  
  	   INSERT INTO GA_HSINIESTROS ( NUM_SINIESTRO, 
	   		  	   				  	NUM_ABONADO,   
									COD_PRODUCTO,  
									COD_CAUSA,     
									COD_ESTADO,  
									NUM_TERMINAL,
									NUM_SERIE,   
									FEC_SINIESTRO, 
									FEC_HISTORICO, 
									COD_CARGOBASICO, 
									COD_SERVICIO,  
									FEC_FORMALIZA, 
									FEC_ANULA,   
									FEC_RESTITUC,  
									NUM_CONSTPOL, 			 
									NUM_SOLLIQ, 	
									NUM_SERIEREP) 
						   (SELECT  NUM_SINIESTRO, 
						   			NUM_ABONADO,   
									COD_PRODUCTO,  
									COD_CAUSA, 	 
									COD_ESTADO, 	 
									NUM_TERMINAL,	
									NUM_SERIE,   
									FEC_SINIESTRO, 
									SYSDATE, 
									COD_CARGOBASICO,  
									COD_SERVICIO, 
									FEC_FORMALIZA, 
									FEC_ANULA, 	  
									FEC_RESTITUC,  
									NUM_CONSTPOL,  
									NUM_SOLLIQ, 	
									NUM_SERIEREP 
							   FROM GA_SINIESTROS 	 
							   WHERE NUM_SINIESTRO =EN_NUM_SINIESTRO);
 
  
	   RETURN TRUE;

	   EXCEPTION
				WHEN OTHERS THEN
			 		 SV_error := 4;
					 SV_sqlcode := SQLCODE;
			 		 SV_sqlerrm := SQLERRM;
    				 RETURN FALSE;
	   					 
					 	   
END PV_HIST_SINIESTRO_FN;

FUNCTION PV_DEL_SINIESTRO_FN  (EN_NUM_SINIESTRO   IN GA_SINIESTROS.NUM_SINIESTRO%TYPE,
					           SV_PROC            OUT VARCHAR2,
					           SV_TABLA           OUT VARCHAR2,
					           SV_ACT     	      OUT VARCHAR2,
					           SV_SQLCODE         OUT VARCHAR2,
					           SV_SQLERRM         OUT VARCHAR2,
					           SV_ERROR           OUT VARCHAR2) RETURN BOOLEAN
/*
<DOC>
<NOMBRE>      PV_DEL_SINIESTRO_FN                            </NOMBRE>
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

BEGIN
	   SV_error   := '0';
	   SV_proc 	  := 'PV_DEL_SINIESTRO_FN';
	   SV_act 	  := 'D';
	   SV_tabla   := 'GA_SINIESTROS';  
  
  	   DELETE GA_SINIESTROS  
	   WHERE NUM_SINIESTRO = EN_NUM_SINIESTRO; 
   

  
	   RETURN TRUE;

	   EXCEPTION
				WHEN OTHERS THEN
			 		 SV_error := 4;
					 SV_sqlcode := SQLCODE;
			 		 SV_sqlerrm := SQLERRM;
    				 RETURN FALSE;
	   					 
					 	   
END PV_DEL_SINIESTRO_FN;

FUNCTION PV_ASIGNA_CARGOS_FN  	   ( EN_COD_CLIENTE		 IN GA_ABOCEL.COD_CLIENTE%TYPE,
		 						   	 EN_COD_PRODUCTO	 IN GA_ABOCEL.COD_PRODUCTO%TYPE,
									 EV_COD_PLANSERV	 IN GA_ABOCEL.COD_PLANSERV%TYPE,
   									 EN_NUM_ABONADO    	 IN GA_ABOCEL.NUM_ABONADO%TYPE,
									 EN_NUM_TERMINAL   	 IN GA_ABOCEL.NUM_CELULAR%TYPE,
									 ED_FEC_ALTA       	 IN GA_ABOCEL.FEC_ALTA%TYPE,
									 EV_USUARIO	   	     IN GE_SEG_USUARIO.NOM_USUARIO%TYPE,
									 SV_PROC            OUT VARCHAR2,
					          	  	 SV_TABLA           OUT VARCHAR2,
					           	  	 SV_ACT     	    OUT VARCHAR2,
					           	  	 SV_SQLCODE         OUT VARCHAR2,
					           	  	 SV_SQLERRM         OUT VARCHAR2,
					           	  	 SV_ERROR           OUT VARCHAR2) RETURN BOOLEAN

 									
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
  vb_Ret		  BOOLEAN;
  vn_CodCiclFact  FA_CICLFACT.COD_CICLFACT%TYPE;
  vv_CodPlanCom   GA_CLIENTE_PCOM.COD_PLANCOM%TYPE;
  vv_CodConcepto  GA_ACTUASERV.COD_CONCEPTO%TYPE;
  vv_CodMoneda	  GA_TARIFAS.COD_MONEDA%TYPE;
  vv_ImpTarifa	  GA_TARIFAS.IMP_TARIFA%TYPE;
  vn_CodActuacion VARCHAR2(2) := 'AN';
  v_Cursor		  vCursor;

BEGIN
	   SV_error   := '0';
	   SV_proc 	  := 'PV_ASIGNA_CARGOS_PR';
	   SV_act 	  := '';
	   SV_tabla   := '';  
  	   
	   
  	   vn_CodCiclFact := PV_GENERAL_OOSS_PG.PV_RECUPERA_CICLO_FACT_FN(EN_COD_CLIENTE,SV_PROC,SV_TABLA,SV_ACT,SV_SQLCODE,SV_SQLERRM,SV_ERROR);
	   vv_CodPlanCom  := PV_GENERAL_OOSS_PG.PV_RECUPERA_PLAN_COMERCIAL_FN(EN_COD_CLIENTE,SV_PROC,SV_TABLA,SV_ACT,SV_SQLCODE,SV_SQLERRM,SV_ERROR);

       IF PV_GENERAL_OOSS_PG.PV_CARGOS_FN(EN_COD_PRODUCTO,vn_CodActuacion,EV_COD_PLANSERV,vv_CodConcepto,vv_CodMoneda,vv_ImpTarifa,SV_PROC,SV_TABLA,SV_ACT,SV_SQLCODE,SV_SQLERRM,SV_ERROR) THEN
       	  vb_Ret:= PV_GENERAL_OOSS_PG.PV_INSERTA_CARGOS_FN(EN_COD_CLIENTE,EN_COD_PRODUCTO,EN_NUM_ABONADO,EN_NUM_TERMINAL,vv_CodPlanCom,ED_FEC_ALTA,vn_CodCiclFact,vv_CodConcepto,
							                           vv_ImpTarifa,vv_CodMoneda,EV_USUARIO,SV_PROC,SV_TABLA,SV_ACT,SV_SQLCODE,SV_SQLERRM,SV_ERROR);
     	  vb_Ret:= PV_GENERAL_OOSS_PG.PV_UPD_CARGOS_FN(EN_COD_CLIENTE,EN_NUM_ABONADO,vn_CodCiclFact,SV_PROC,SV_TABLA,SV_ACT,SV_SQLCODE,SV_SQLERRM,SV_ERROR);
	   END IF;
	   		
      RETURN TRUE;
	   EXCEPTION
				WHEN OTHERS THEN
			 		 SV_error := 4;
					 SV_sqlcode := SQLCODE;
			 		 SV_sqlerrm := SQLERRM;
	   				 RETURN FALSE;
	   					 
					 	   
END PV_ASIGNA_CARGOS_FN;


PROCEDURE PV_EJEC_OOSS_PR   	   ( EV_USUARIO	         IN GE_SEG_USUARIO.NOM_USUARIO%TYPE,
	  						   	   	 EN_NUM_CELULAR		 IN GA_ABOCEL.NUM_CELULAR%TYPE,
		  						   	 SN_NUM_OS		    OUT CI_ORSERV.NUM_OS%TYPE,
		  						   	 SV_PROC            OUT VARCHAR2,
					          	  	 SV_TABLA           OUT VARCHAR2,
					           	  	 SV_ACT     	    OUT VARCHAR2,
					           	  	 SV_SQLCODE         OUT VARCHAR2,
					           	  	 SV_SQLERRM         OUT VARCHAR2,
					           	  	 SV_ERROR           OUT VARCHAR2)
/*
<DOC>
<NOMBRE>      PV_EJEC_OOSS_PR                           </NOMBRE>
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
  vn_CodActuacion      VARCHAR2(2) := 'AN';
  v_CodInterno	 	   CI_ORSERV.COD_INTER%TYPE;
  vn_NumAbonado	 	   GA_ABOCEL.NUM_ABONADO%TYPE;
  vn_CodCliente	 	   GA_ABOCEL.COD_CLIENTE%TYPE;
  vn_CodProducto	   GA_ABOCEL.COD_PRODUCTO%TYPE;
  vn_NumOOSS		   CI_ORSERV.NUM_OS%TYPE;
  vn_CodOS			   CI_ORSERV.COD_OS%TYPE;
  vn_Secuencia 	       GA_TRANSACABO.NUM_TRANSACCION%TYPE;
  vv_CodCarBscoOrg     GA_INTARCEL.COD_CARGOBASICO%TYPE;
  vv_CodCarBscoAnt     GA_INTARCEL.COD_CARGOBASICO%TYPE;
  vv_CodCarBscoAct     GA_INTARCEL.COD_CARGOBASICO%TYPE;
  vb_Ret			   BOOLEAN;
BEGIN
	   SV_error   := '0';
	   SV_proc 	  := 'PV_EJEC_OOSS_PR';
	   SV_act 	  := '';
	   SV_tabla   := '';  
  	   
	   vn_NumAbonado := PV_GENERAL_OOSS_PG.VP_NUM_ABONADO;
	   vn_CodCliente := PV_GENERAL_OOSS_PG.VP_COD_CLIENTE;
	   vn_CodProducto:= PV_GENERAL_OOSS_PG.VP_COD_PRODUCTO;
	   vn_CodOS		 := CN_Cod_OOSS;
   	   v_CodInterno := vn_NumAbonado;
	   

	   SELECT CI_SEQ_NUMOS.NEXTVAL INTO vn_NumOOSS FROM DUAL;
	   SELECT GA_SEQ_TRANSACABO.NEXTVAL INTO vn_Secuencia FROM DUAL;
	   
	  
	   PV_REGISTRA_OOSS_PG.PV_INSERTA_SOLIC_SERV_PR(vn_Secuencia,vn_NumOOSS,CV_Cod_Actuacion,vn_NumAbonado,CN_Cod_OOSS,vn_CodProducto,v_CodInterno,EV_USUARIO,CV_Comentario,CV_Cod_Modulo,'');
	  
       vv_CodCarBscoOrg := PV_RECUPERA_CARGO_BSCO_ORIG_FN(vn_CodCliente,vn_NumAbonado,SV_PROC,SV_TABLA,SV_ACT,SV_SQLCODE,SV_SQLERRM,SV_ERROR);
   	  
	   IF vv_CodCarBscoOrg = 'SIN' THEN
   	   	   vv_CodCarBscoAct := PV_RECUPERA_CARGO_BSCO_ACT_FN(vn_CodCliente,vn_NumAbonado,SV_PROC,SV_TABLA,SV_ACT,SV_SQLCODE,SV_SQLERRM,SV_ERROR);
      
		   IF vv_CodCarBscoOrg = vv_CodCarBscoAct THEN
		   	  vv_CodCarBscoAnt := PV_RECUPERA_CARGO_BSCO_ANT_FN(vn_CodCliente,vn_NumAbonado,SV_PROC,SV_TABLA,SV_ACT,SV_SQLCODE,SV_SQLERRM,SV_ERROR);
		
			  vb_Ret := PV_REG_AUDITORIA_FN(vn_NumOOSS,EN_NUM_CELULAR,vn_NumAbonado,vv_CodCarBscoAnt,SV_PROC,SV_TABLA,SV_ACT,SV_SQLCODE,SV_SQLERRM,SV_ERROR);
 		
		   END IF;
	   END IF;	
	
   	   vb_Ret		:= PV_GENERAL_OOSS_PG.PV_REG_CARTA_FN(vn_NumOOSS,vn_CodOS,vn_CodCliente,EN_NUM_CELULAR,SV_PROC,SV_TABLA,SV_ACT,SV_SQLCODE,SV_SQLERRM,SV_ERROR);
	   SN_NUM_OS := vn_NumOOSS;
	   EXCEPTION
				WHEN OTHERS THEN
			 		 SV_error := 4;
					 SV_sqlcode := SQLCODE;
			 		 SV_sqlerrm := SQLERRM;

					 	   
END PV_EJEC_OOSS_PR;

FUNCTION PV_REG_AUDITORIA_FN	        (EN_NUM_OS		     IN CI_ORSERV.NUM_OS%TYPE,
		 								 EN_NUM_CELULAR		 IN GA_ABOCEL.NUM_CELULAR%TYPE,
										 EN_NUM_ABONADO		 IN GA_ABOCEL.NUM_ABONADO%TYPE,
										 EV_COD_CARGOBASICO	 IN GA_INTARCEL.COD_CARGOBASICO%TYPE,
		 								 SV_PROC            OUT VARCHAR2,
					          	  	 	 SV_TABLA           OUT VARCHAR2,
					           	  	 	 SV_ACT     	    OUT VARCHAR2,
					           	  	 	 SV_SQLCODE         OUT VARCHAR2,
					           	  	 	 SV_SQLERRM         OUT VARCHAR2,
					           	  	 	 SV_ERROR           OUT VARCHAR2) RETURN BOOLEAN
/*
<DOC>
<NOMBRE>      PV_REG_AUDITORIA_FN                      </NOMBRE>
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
  vv_CodSituacion    GA_AUDREST.COD_SITUACION%TYPE := 'ANS';
  vv_Mensaje	     GA_AUDREST.NOM_PROC%TYPE 	   := 'Error no se realizó el cambio';
BEGIN
	   SV_error   := '0';
	   SV_proc 	  := 'PV_REG_AUDITORIA_FN';
	   SV_act 	  := 'S';
	   SV_tabla   := 'GA_AUDREST';  
  	   

	   
	   INSERT INTO GA_AUDREST  (NUM_ABONADO,     NUM_CELULAR	 ,NUM_SERIE, COD_SITUACION, NOM_USUARORA, FEC_ALTA ,FEC_RESTAURA, NOM_PROC,  NUM_VENTA)
	   		  	   VALUES 	   (EN_NUM_ABONADO,	 EN_NUM_CELULAR	 , EV_COD_CARGOBASICO, vv_CodSituacion, ''			, SYSDATE  ,SYSDATE,	  vv_Mensaje, EN_NUM_OS);		    	   
 


	   RETURN TRUE;

	   EXCEPTION
				WHEN OTHERS THEN
			 		 SV_error := 4;
					 SV_sqlcode := SQLCODE;
			 		 SV_sqlerrm := SQLERRM;
	   				 RETURN FALSE;	   					 
					 	   
END PV_REG_AUDITORIA_FN;

FUNCTION PV_RECUPERA_CARGO_BSCO_ORIG_FN  (EN_COD_CLIENTE      IN GA_ABOCEL.COD_CLIENTE%TYPE,
		 								  EN_NUM_ABONADO	  IN GA_ABOCEL.NUM_ABONADO%TYPE,
										  SV_PROC            OUT VARCHAR2,
					          	  	 	  SV_TABLA           OUT VARCHAR2,
					           	  	 	  SV_ACT     	     OUT VARCHAR2,
					           	  	 	  SV_SQLCODE         OUT VARCHAR2,
					           	  	 	  SV_SQLERRM         OUT VARCHAR2,
					           	  	 	  SV_ERROR           OUT VARCHAR2) RETURN GA_INTARCEL.COD_CARGOBASICO%TYPE
/*
<DOC>
<NOMBRE>      PV_RECUPERA_CARGO_BSCO_ORIG_FN                       </NOMBRE>
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
  vv_CodCargoBasico   GA_INTARCEL.COD_CARGOBASICO%TYPE;
BEGIN
	   SV_error   := '0';
	   SV_proc 	  := 'PV_RECUPERA_CARGO_BSCO_ORIG_FN';
	   SV_act 	  := 'S';
	   SV_tabla   := 'GA_INTARCEL';  
  
  
	   SELECT COD_CARGOBASICO
	   INTO   vv_CodCargoBasico
	   FROM  GA_INTARCEL A
	   WHERE A.NUM_ABONADO   = EN_NUM_ABONADO 
	     AND A.COD_CLIENTE   = EN_COD_CLIENTE
		 AND A.FEC_HASTA     = (SELECT MAX(FEC_HASTA) 
		 	 			        FROM   GA_INTARCEL B 
							    WHERE  A.COD_CLIENTE=B.COD_CLIENTE 
							    AND    A.NUM_ABONADO=B.NUM_ABONADO)	;   



	   RETURN vv_CodCargoBasico;

	   EXCEPTION
				WHEN OTHERS THEN
			 		 SV_error := 4;
					 SV_sqlcode := SQLCODE;
			 		 SV_sqlerrm := SQLERRM;
	   					 
					 	   
END PV_RECUPERA_CARGO_BSCO_ORIG_FN;

FUNCTION PV_RECUPERA_CARGO_BSCO_ANT_FN  (EN_COD_CLIENTE   IN GA_ABOCEL.COD_CLIENTE%TYPE,
		 								 EN_NUM_ABONADO	  IN GA_ABOCEL.NUM_ABONADO%TYPE,
										 SV_PROC         OUT VARCHAR2,
					          	  	 	 SV_TABLA        OUT VARCHAR2,
					           	  	 	 SV_ACT     	 OUT VARCHAR2,
					           	  	 	 SV_SQLCODE      OUT VARCHAR2,
					           	  	 	 SV_SQLERRM      OUT VARCHAR2,
					           	  	 	 SV_ERROR        OUT VARCHAR2) RETURN GA_INTARCEL.COD_CARGOBASICO%TYPE
/*
<DOC>
<NOMBRE>      PV_RECUPERA_CARGO_BSCO_ANT_FN                       </NOMBRE>
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
  vv_CodCargoBasico   GA_INTARCEL.COD_CARGOBASICO%TYPE;
BEGIN
	   SV_error   := '0';
	   SV_proc 	  := 'PV_RECUPERA_CARGO_BSCO_ANT_FN';
	   SV_act 	  := 'S';
	   SV_tabla   := 'GA_INTARCEL';  
  
  
	 SELECT COD_CARGOBASICO
	 INTO   vv_CodCargoBasico
	 FROM 	GA_INTARCEL A
	 WHERE  A.NUM_ABONADO = EN_NUM_ABONADO 
	    AND A.COD_CLIENTE = EN_COD_CLIENTE
	    AND (TRUNC(A.FEC_HASTA) = (SELECT TRUNC(MAX(B.FEC_DESDE)) 
							   	  FROM 	 GA_INTARCEL B 
								  WHERE  A.COD_CLIENTE=B.COD_CLIENTE 
	 							  AND    A.NUM_ABONADO=B.NUM_ABONADO)
	    OR  TRUNC(A.FEC_HASTA) = (SELECT TRUNC(MAX(B.FEC_DESDE-1)) 
							   	  FROM 	 GA_INTARCEL B 
								  WHERE  A.COD_CLIENTE=B.COD_CLIENTE 
	 							  AND A.NUM_ABONADO=B.NUM_ABONADO));



	   RETURN vv_CodCargoBasico;

	   EXCEPTION
				WHEN OTHERS THEN
			 		 SV_error := 4;
					 SV_sqlcode := SQLCODE;
			 		 SV_sqlerrm := SQLERRM;
	   					 
					 	   
END PV_RECUPERA_CARGO_BSCO_ANT_FN;


FUNCTION PV_RECUPERA_CARGO_BSCO_ACT_FN  (EN_COD_CLIENTE   IN GA_ABOCEL.COD_CLIENTE%TYPE,
		 								 EN_NUM_ABONADO	  IN GA_ABOCEL.NUM_ABONADO%TYPE,
										 SV_PROC         OUT VARCHAR2,
					          	  	 	 SV_TABLA        OUT VARCHAR2,
					           	  	 	 SV_ACT     	 OUT VARCHAR2,
					           	  	 	 SV_SQLCODE      OUT VARCHAR2,
					           	  	 	 SV_SQLERRM      OUT VARCHAR2,
					           	  	 	 SV_ERROR        OUT VARCHAR2) RETURN GA_INTARCEL.COD_CARGOBASICO%TYPE
/*
<DOC>
<NOMBRE>      PV_RECUPERA_CARGO_BSCO_ACT_FN                       </NOMBRE>
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
  vv_CodCargoBasico   GA_INTARCEL.COD_CARGOBASICO%TYPE;
BEGIN
	   SV_error   := '0';
	   SV_proc 	  := 'PV_RECUPERA_CARGO_BSCO_ACT_FN';
	   SV_act 	  := 'S';
	   SV_tabla   := 'GA_INTARCEL';  
  
  
  	   SELECT COD_CARGOBASICO
   	   INTO   vv_CodCargoBasico	   
  	   FROM   GA_INTARCEL A
  	   WHERE  A.NUM_ABONADO =EN_NUM_ABONADO 
  	   AND 	  A.COD_CLIENTE = EN_COD_CLIENTE
  	   AND 	  A.FEC_HASTA   = (SELECT MAX(FEC_HASTA) 
  		 			 	 	     FROM GA_INTARCEL B 
						        WHERE A.COD_CLIENTE = B.COD_CLIENTE 
						          AND A.NUM_ABONADO=B.NUM_ABONADO);



	   RETURN vv_CodCargoBasico;

	   EXCEPTION
				WHEN OTHERS THEN
			 		 SV_error := 4;
					 SV_sqlcode := SQLCODE;
			 		 SV_sqlerrm := SQLERRM;
	   					 
					 	   
END PV_RECUPERA_CARGO_BSCO_ACT_FN;

PROCEDURE PV_ESTADO_ANUL_PR   (EN_NUM_CELULAR   IN GA_ABOCEL.NUM_CELULAR%TYPE,
  							   EN_NUM_OS	    IN CI_ORSERV.NUM_OS%TYPE,
							   EV_USUARIO	   	IN GE_SEG_USUARIO.NOM_USUARIO%TYPE,
					           SV_ESTADO 	   OUT VARCHAR2,
   							   SV_MENS_ERROR	OUT VARCHAR2,							
							   SV_ERROR        OUT VARCHAR2)

/*
<DOC>
<NOMBRE>      PV_ESTADO_ANUL_PR                                 </NOMBRE>
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
  vv_Estado        VARCHAR2(255);
  vv_Parametro	   VARCHAR2(255);
  vn_CodActuacion  VARCHAR2(2) := 'AN';
  vv_Proc 		   VARCHAR2(255);
  vv_Tabla 		   VARCHAR2(255);
  vv_Act 		   VARCHAR2(255);
  vv_Error 		   VARCHAR2(255);    
  vn_Secuencia     NUMBER(10);
  vn_Implicons	   NUMBER(14,4);
  vn_Ret		   NUMBER(1);
  vn_NumAbonado	   GA_ABOCEL.NUM_ABONADO%TYPE;
  vn_CodProducto   GA_ABOCEL.COD_PRODUCTO%TYPE;  
  vv_Fecha 		   CI_ORSERV.FECHA%TYPE;	
  vb_Ret		   BOOLEAN;
  vv_SqlCode	   VARCHAR2(255); 
  vv_MensajeErr	   VARCHAR2(255);	
  vv_ErrorCode	   VARCHAR2(255);
  sActabo 	   VARCHAR2(5); -- Alejandro Hott - Soporte 15-03-2005 Inc. TM-200502161273
  
  VALIDA_ERROR   EXCEPTION;  
BEGIN

  	   SV_ERROR   := '0';
	   vv_proc 	  := 'PV_ESTADO_ANUL_PR';
	   vv_act 	  := 'S';
	   vv_tabla   := ''; 
	   
	   vn_NumAbonado:=-1;				 
	   PV_GENERAL_OOSS_PG.PV_DATOS_ABONADO_PR (EN_NUM_CELULAR,vn_Implicons,vv_Proc,vv_Tabla,vv_Act,vv_ErrorCode,SV_MENS_ERROR,SV_ERROR); 
	   IF SV_ERROR = '4' THEN
	   	  vn_Ret := 3;
	   	  RAISE VALIDA_ERROR;
	   END IF;
	   	   
	   -- Inicio Modificación - GBM - 23-02-2005 - TM-200502161273
	   IF PV_GENERAL_OOSS_PG.VP_COD_SITUACION = 'RTP' THEN
	   	  vn_Ret := 4;
	   	  RAISE VALIDA_ERROR;
	   END IF;
	   -- Fin Modificación - GBM - 23-02-2005 - TM-200502161273
  	   vn_NumAbonado := PV_GENERAL_OOSS_PG.VP_NUM_ABONADO;
   	   vn_CodProducto:=	PV_GENERAL_OOSS_PG.VP_COD_PRODUCTO;

	   -- Si no existe restriccion para el abonado se procede con la validación de existencia de datos de Siniestro
	   IF PV_VALIDA_ANUL_SINIE_FN(EN_NUM_CELULAR,EN_NUM_OS,vv_Proc,vv_Tabla,vv_Act,vv_ErrorCode,SV_MENS_ERROR,SV_ERROR) THEN
	   	     vv_Fecha  :=  PV_RECUPERA_FECHA_ANUL_FN(vn_NumAbonado,EN_NUM_OS,vv_Proc,vv_Tabla,vv_Act,vv_ErrorCode,SV_MENS_ERROR,SV_ERROR);
			 IF vv_Fecha IS NOT NULL THEN
			        -- Inicio Modificación TM-200502141271 - 23/02/2005 - JJR.-
		  	 	-- vv_Estado := 'La Anulación se hizo efectiva ' || TO_CHAR(vv_Fecha,ge_fn_devvalparam('GE',1,'FORMATO_SEL4')); --Modificado por Alejandro Hott - Soporte 29-11-2004 - TM-200411151097
		  	 	   vv_Estado := 'Transacción Exitosa ' || TO_CHAR(vv_Fecha,ge_fn_devvalparam('GE',1,'FORMATO_SEL4')); --Modificado por Alejandro Hott - Soporte 29-11-2004 - TM-200411151097
		  	 	-- Fin Modificación TM-200502141271 - 23/02/2005 - JJR.-
	   	     ELSE
	   	   		vn_Ret := 2;
	   	   		RAISE VALIDA_ERROR;
			 END IF;
   	    ELSE
  	   		vn_Ret := 2;
  	   		RAISE VALIDA_ERROR;
	   END IF;
	   
	   SV_ESTADO := vv_Estado;
	   
	   EXCEPTION
				WHEN VALIDA_ERROR THEN
			 		 vv_error 	  := 4;
					 vv_ErrorCode := -3000;
					 IF vn_Ret = 0 THEN
			 		 	 -- Inicio Modificación TM-200502141271 - 23/02/2005 - JJR.-
				 		 -- vv_MensajeErr := 'Usuario no válido.';					 
				 		    vv_MensajeErr := 'Usuario No Válido';	   
				 		 -- Fin Modificación TM-200502141271 - 23/02/2005 - JJR.-
			 		 	   
					 ELSIF vn_Ret = 1 THEN
					        -- Inicio Modificación TM-200502141271 - 23/02/2005 - JJR.-
					 	-- vv_MensajeErr := 'El celular no puede realizar consulta de Anulación de Siniestro';
					 	   vv_MensajeErr := 'Transacción No Autorizada';
					 	-- Fin Modificación TM-200502141271 - 23/02/2005 - JJR.-
					 ELSIF vn_Ret = 2 THEN
					 	-- Inicio Modificación TM-200502141271 - 23/02/2005 - JJR.-
					 	-- vv_MensajeErr := 'El Abonado no posee Anulación de Siniestro';
					 	   vv_MensajeErr := 'No Existe Notificación Robo/Extravio';
					 	-- Fin Modificación TM-200502141271 - 23/02/2005 - JJR.-
					 ELSIF vn_Ret = 3 THEN
					 	   -- Inicio Modificación TM-200502141271 - 23/02/2005 - JJR.-
					 	   -- vv_MensajeErr := 'Celular No existe en Operador';
					 	      vv_MensajeErr := 'Número Tel. No Registrado';
					 	   -- Fin Modificación TM-200502141271 - 23/02/2005 - JJR.-
					 -- Inicio Modificación - GBM - 23-02-2005 - TM-200502161273
					 ELSIF vn_Ret = 4 THEN
					 	   vv_MensajeErr := 'EN PROCESO';
					 -- Fin Modificación - GBM - 23-02-2005 - TM-200502161273
				     END IF;
					 BEGIN
					 	--Inicio modificacion - Alejandro Hott - Soporte 15-03-2005 Inc. TM-200502161273
					 	BEGIN
			                            SELECT COD_ACTABO INTO sActabo
			                            FROM   GA_ERRORES
			                            WHERE  COD_ACTABO = vn_CodActuacion
			                            AND    CODIGO = vn_NumAbonado
			                            AND    FEC_ERROR = SYSDATE;
			                            VB_RET := True;
			                        EXCEPTION
			                            WHEN NO_DATA_FOUND THEN
					 		vb_Ret:= PV_GENERAL_OOSS_PG.PV_GA_ERRORES_FN(vn_NumAbonado,vn_CodActuacion,CN_Cod_Producto,SV_ERROR,vv_Proc,vv_Tabla,vv_Act,vv_ErrorCode,vv_MensajeErr,vv_SqlCode,SV_MENS_ERROR);
					 	END;
					 	--Fin modificacion - Alejandro Hott - Soporte 15-03-2005 Inc. TM-200502161273
					 	  IF VB_RET  THEN
						  	  SV_ERROR	     := 4;
						   	  vv_SqlCode    := vv_ErrorCode;
						   	  SV_MENS_ERROR := vv_MensajeErr;
						   	  COMMIT;
					 	   END IF;
					 
					 	   EXCEPTION
						   WHEN OTHERS THEN
					   	     SV_ERROR	   := 4;						
							 vv_SqlCode    := SQLCODE;
					 		 SV_MENS_ERROR := SQLERRM;
					 END;	   
				WHEN OTHERS THEN
					 vv_ErrorCode := SQLCODE;
			 		 vv_MensajeErr := SQLERRM;
					 BEGIN
					 	--Inicio modificacion - Alejandro Hott - Soporte 15-03-2005 Inc. TM-200502161273
					 	BEGIN
			                            SELECT COD_ACTABO INTO sActabo
			                            FROM   GA_ERRORES
			                            WHERE  COD_ACTABO = vn_CodActuacion
			                            AND    CODIGO = vn_NumAbonado
			                            AND    FEC_ERROR = SYSDATE;
			                            VB_RET := True;
			                        EXCEPTION
			                            WHEN NO_DATA_FOUND THEN
					 		vb_Ret:= PV_GENERAL_OOSS_PG.PV_GA_ERRORES_FN(vn_NumAbonado,vn_CodActuacion,CN_Cod_Producto,SV_ERROR,vv_Proc,vv_Tabla,vv_Act,vv_ErrorCode,vv_MensajeErr,vv_SqlCode,SV_MENS_ERROR);
					 	END;
					 	--Fin modificacion - Alejandro Hott - Soporte 15-03-2005 Inc. TM-200502161273
						IF VB_RET  THEN
						     SV_ERROR	   := 4;						
							 vv_SqlCode    := vv_ErrorCode;
					 		 SV_MENS_ERROR := vv_MensajeErr ;						
						     COMMIT;
						END IF;
					 	EXCEPTION
						WHEN OTHERS THEN
  						     SV_ERROR	   := 4;
							 vv_SqlCode    := SQLCODE;
					 		 SV_MENS_ERROR := SQLERRM;
					 END;	   
END PV_ESTADO_ANUL_PR;

FUNCTION PV_VALIDA_ANUL_SINIE_FN        (EN_NUM_CELULAR      IN  GA_ABOCEL.NUM_CELULAR%TYPE,
		 								 EN_NUM_OS	         IN  CI_ORSERV.NUM_OS%TYPE, 
		 								 SV_PROC            OUT VARCHAR2,
					          	  	 	 SV_TABLA           OUT VARCHAR2,
					           	  	 	 SV_ACT     	    OUT VARCHAR2,
					           	  	 	 SV_SQLCODE         OUT VARCHAR2,
					           	  	 	 SV_SQLERRM         OUT VARCHAR2,
					           	  	 	 SV_ERROR           OUT VARCHAR2) RETURN BOOLEAN
/*
<DOC>
<NOMBRE>      PV_VALIDA_ANUL_SINIE_FN                        </NOMBRE>
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
   vn_Reg	NUMBER(1);
BEGIN
	   SV_error   := '0';
	   SV_proc 	  := 'PV_VALIDA_ANUL_SINIE_FN';
	   SV_act 	  := 'S';
	   SV_tabla   := '';  
  
   	   vn_Reg := 0;
	   
			SELECT COUNT(1)
			INTO   vn_Reg 
			FROM GA_HSINIESTROS A , GA_HDETSINIE C, GA_ABOCEL D
			WHERE A.NUM_ABONADO   IN (SELECT COD_INTER FROM CI_ORSERV
				  				  	  WHERE  NUM_OS = EN_NUM_OS)
			AND   A.FEC_SINIESTRO IN (SELECT MAX(B.FEC_SINIESTRO) FROM GA_HSINIESTROS B
			    				  	  WHERE B.NUM_ABONADO = A.NUM_ABONADO)  
			AND   C.NUM_SINIESTRO = A.NUM_SINIESTRO
			AND   C.COD_ESTADO    = A.COD_ESTADO
			AND   D.NUM_CELULAR   = EN_NUM_CELULAR
			AND   D.NUM_ABONADO   = A.NUM_ABONADO;
			
			IF vn_Reg = 0 THEN
		 		SELECT COUNT(1) 
				INTO   vn_Reg
				FROM GA_HSINIESTROS A , GA_HDETSINIE C, GA_ABOAMIST D
				WHERE A.NUM_ABONADO   IN (SELECT COD_INTER FROM CI_ORSERV
					  				  	  WHERE  NUM_OS = EN_NUM_OS)
				AND   A.FEC_SINIESTRO IN (SELECT MAX(B.FEC_SINIESTRO) FROM GA_HSINIESTROS B
				    				  	  WHERE B.NUM_ABONADO = A.NUM_ABONADO)  
				AND   C.NUM_SINIESTRO = A.NUM_SINIESTRO
				AND   C.COD_ESTADO    = A.COD_ESTADO
				AND   D.NUM_CELULAR   = EN_NUM_CELULAR
				AND   D.NUM_ABONADO   = A.NUM_ABONADO;
			END IF;

			IF vn_Reg = 0 THEN
				SELECT COUNT(1)
				INTO   vn_Reg 
				FROM GA_SINIESTROS A , GA_DETSINIE C, GA_ABOCEL D -- Modificado por Soporte - Alejandro Hott - 25/11/2004
				WHERE A.NUM_ABONADO   IN (SELECT COD_INTER FROM CI_ORSERV
					  				  	  WHERE  NUM_OS = EN_NUM_OS)
				AND   A.FEC_SINIESTRO IN (SELECT MAX(B.FEC_SINIESTRO) FROM GA_HSINIESTROS B
				    				  	  WHERE B.NUM_ABONADO = A.NUM_ABONADO)  
				AND   C.NUM_SINIESTRO = A.NUM_SINIESTRO
				AND   C.COD_ESTADO    = A.COD_ESTADO
				AND   D.NUM_CELULAR   = EN_NUM_CELULAR
				AND   D.NUM_ABONADO   = A.NUM_ABONADO;
				
				IF vn_Reg = 0 THEN
			 		SELECT COUNT(1) 
					INTO   vn_Reg
					FROM GA_SINIESTROS A , GA_DETSINIE C, GA_ABOAMIST D -- Modificado por Soporte - Alejandro Hott - 25/11/2004
					WHERE A.NUM_ABONADO   IN (SELECT COD_INTER FROM CI_ORSERV
						  				  	  WHERE  NUM_OS = EN_NUM_OS)
					AND   A.FEC_SINIESTRO IN (SELECT MAX(B.FEC_SINIESTRO) FROM GA_HSINIESTROS B
					    				  	  WHERE B.NUM_ABONADO = A.NUM_ABONADO)  
					AND   C.NUM_SINIESTRO = A.NUM_SINIESTRO
					AND   C.COD_ESTADO    = A.COD_ESTADO
					AND   D.NUM_CELULAR   = EN_NUM_CELULAR
					AND   D.NUM_ABONADO   = A.NUM_ABONADO;
				END IF;		
			END IF;					
				
  	   IF vn_Reg <> 0 THEN
	   	   RETURN TRUE;
	   ELSE
	   	   RETURN FALSE;
	   END IF;

	   EXCEPTION
				WHEN OTHERS THEN
			 		 SV_error := 4;
					 SV_sqlcode := SQLCODE;
			 		 SV_sqlerrm := SQLERRM;
					 
	   					 
					 	   
END PV_VALIDA_ANUL_SINIE_FN;

FUNCTION PV_RECUPERA_FECHA_ANUL_FN      (EN_NUM_ABONADO      IN  GA_ABOCEL.NUM_ABONADO%TYPE,
		 								 EN_NUM_OS	         IN  CI_ORSERV.NUM_OS%TYPE, 
		 								 SV_PROC            OUT VARCHAR2,
					          	  	 	 SV_TABLA           OUT VARCHAR2,
					           	  	 	 SV_ACT     	    OUT VARCHAR2,
					           	  	 	 SV_SQLCODE         OUT VARCHAR2,
					           	  	 	 SV_SQLERRM         OUT VARCHAR2,
					           	  	 	 SV_ERROR           OUT VARCHAR2) RETURN DATE
/*
<DOC>
<NOMBRE>      PV_RECUPERA_FECHA_ANUL_FN                       </NOMBRE>
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
   vv_Fecha CI_ORSERV.FECHA%TYPE;
BEGIN
	   SV_error   := '0';
	   SV_proc 	  := 'PV_RECUPERA_FECHA_ANUL_FN';
	   SV_act 	  := 'S';
	   SV_tabla   := '';  
  
	   
	   SELECT FECHA 
	   INTO   vv_Fecha
	   FROM   CI_ORSERV
	   WHERE  NUM_OS 	 = EN_NUM_OS
	   AND    COD_INTER  = EN_NUM_ABONADO;
		
  	  
	   RETURN vv_Fecha;

	   EXCEPTION
				WHEN NO_DATA_FOUND THEN
			 		RETURN NULL;
				WHEN OTHERS THEN
			 		 SV_error := 4;
					 SV_sqlcode := SQLCODE;
			 		 SV_sqlerrm := SQLERRM;
	   					 
					 	   
END PV_RECUPERA_FECHA_ANUL_FN;



END PV_ANULA_SINIESTRO_PG;
/
SHOW ERROR
