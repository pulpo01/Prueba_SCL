CREATE OR REPLACE PACKAGE BODY                  GE_SEG_AUDITORIA_PG AS

PROCEDURE GE_INSERTAR_ERRORES_PR (
      EN_numtransaccion   IN   NUMBER,
      EN_retorno          IN   NUMBER,
      EV_glosa            IN   VARCHAR2
) IS
/*
<Documentación
  TipoDoc = Procedimiento">
   <Elemento
      Nombre = "GE_INSERTAR_ERRORES_PR"
      Lenguaje="PL/SQL"
      Fecha creación="23-11-2005"
      Creado por="Maritza Tapia A"
      Fecha modificacion=""
      Modificado por=""
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
      <Descripción>inserta el numero de Transaccion/Descripción>
      <Parámetros>
          <Entrada>
            <param nom="EN_numtransaccion " Tipo="Numerico">Numero Transaccion</param>
            <param nom="EN_retorno " Tipo="Numerico">Codigo de Error</param>
            <param nom="EV_glosa  " Tipo="CARACTER">Glosa</param>
         </Entrada>	  
         <Salida>	
		 </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
BEGIN
      INSERT INTO GA_TRANSACABO
                  (num_transaccion, cod_retorno, des_cadena
                  )
           VALUES (EN_numtransaccion, EN_retorno, EV_glosa
                  );
END GE_INSERTAR_ERRORES_PR;


FUNCTION GE_CON_VENDEDORES_FN(
    EV_cod_vendedor    IN  VE_VENDEDORES.COD_VENDEDOR%TYPE
) RETURN BOOLEAN
/*
<Documentación
  TipoDoc = "FUNCION">
   <Elemento
      Nombre = "GE_CON_VENDEDORES_FN"
      Lenguaje="PL/SQL"
      Fecha creación="23-11-2005"
      Creado por="Maritza Tapia A"
      Fecha modificacion=""
      Modificado por=""
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
      <Descripción>Recupera Codigo Vendedor/Descripción>
      <Parámetros>
          <Entrada>
            <param nom=" EV_cod_vendedor" Tipo="Numerico">Codigo Vendedor</param>
         </Entrada>	  
         <Salida>	
		 </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
AS

BEGIN
	 GN_Existe :=0;
	 
	 SELECT COUNT(1)
	   INTO GN_Existe
	   FROM VE_VENDEDORES a
	  WHERE a.cod_vendedor = EV_cod_vendedor;    
	   
	  IF GN_Existe > CN_cero THEN
	  	  RETURN TRUE;
	  ELSE
		  RETURN FALSE;
	  END IF;
	   
   EXCEPTION

      WHEN OTHERS THEN
      	   RETURN FALSE;

END GE_CON_VENDEDORES_FN;
-------------------------------------------------------------------------------------------------------------------------------------------------------------------
FUNCTION GE_CON_OFICINA_FN(
    EV_cod_oficina    IN  GE_OFICINAS.COD_OFICINA%TYPE
) RETURN BOOLEAN
/*
<Documentación
  TipoDoc = "FUNCION">
   <Elemento
      Nombre = "GE_CON_OFICINA_FN"
      Lenguaje="PL/SQL"
      Fecha creación="23-11-2005"
      Creado por="Maritza Tapia A"
      Fecha modificacion=""
      Modificado por=""
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
      <Descripción>Recupera Codigo oficina/Descripción>
      <Parámetros>
          <Entrada>
            <param nom=" EV_cod_oficina" Tipo="Numerico">Codigo de oficina</param>
         </Entrada>	  
         <Salida>	
		 </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
AS

BEGIN
	 GN_Existe :=0;
	 
	 SELECT COUNT(1)
	   INTO GN_Existe
	   FROM GE_OFICINAS a
	  WHERE a.cod_oficina =  EV_cod_oficina;    
	   
	  IF GN_Existe > CN_cero THEN
	  	  RETURN TRUE;
	  ELSE
		  RETURN FALSE;
	  END IF;
	   
   EXCEPTION

      WHEN OTHERS THEN
      	   RETURN FALSE;

END GE_CON_OFICINA_FN;

-------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE GE_SEGUSUARIO_IN_PR(
    EN_numtransaccion IN NUMBER, 
	EV_nom_usuario    IN  GE_SEG_USUARIO.NOM_USUARIO%TYPE,
	EV_nom_operador   IN  GE_SEG_USUARIO.NOM_OPERADOR%TYPE,
	EV_ind_adm  	  IN  GE_SEG_USUARIO.IND_ADM%TYPE,
	EV_cod_oficina    IN  GE_SEG_USUARIO.COD_OFICINA%TYPE,
	EV_cod_tipcomis   IN  GE_SEG_USUARIO.COD_TIPCOMIS%TYPE,
	EN_cod_vendedor   IN  GE_SEG_USUARIO.COD_VENDEDOR%TYPE,
    EV_IND_VISUAL	  IN  GE_SEG_USUARIO.IND_VISUAL%TYPE, 
	EV_email	      IN  GE_SEG_USUARIO.NOM_EMAIL%TYPE,
	EV_excep_eriesgo  IN  GE_SEG_USUARIO.IND_EXCEP_ERIESGO%TYPE
) 
/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "GE_SEGUSUARIO_IN_PR"
      Lenguaje="PL/SQL"
      Fecha creación="31-10-2005"
      Creado por="Maritza Tapia A"
      Fecha modificacion=""
      Modificado por=""
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
      <Descripción>Ingresa Usuario</Descripción>
      <Parámetros>
          <Entrada>
            <param nom="EN_numtransaccion" Tipo="NUMERICO">Numero de transaccion </param>
            <param nom="EV_nom_usuario" Tipo="CARACTER">Nombre Usuario</param>
            <param nom="EV_nom_operador" Tipo="CARACTER">Descripcion de Usuario Operador</param>
            <param nom="EV_ind_adm " Tipo="CARACTER">indice</param>
            <param nom="EV_cod_oficina"  Tipo="CARACTER">Codigo de Oficina</param>
            <param nom="EV_cod_tipcomis"  Tipo="CARACTER">Codigo Tipo comision</param>
            <param nom="EN_cod_vendedor"  Tipo="NUMERICO">Codigo Vendedor</param>
            <param nom="EV_excep_eriesgo"  Tipo="CARACTER">Usuario puede o no aplicar Excepciones en Evaluación de Riesgo</param>
         </Entrada>
         <Salida>            
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
IS
   error_con_vendedor  EXCEPTION;
   error_con_oficina   EXCEPTION;
   error_select        EXCEPTION; 
   LN_cod_retorno      ge_errores_td.cod_msgerror%TYPE;
   LV_mens_retorno     ge_errores_td.det_msgerror%TYPE;
   LN_num_evento       ge_errores_pg.Evento;
   LV_des_error        ge_errores_pg.DesEvent;
   LV_sSql             ge_errores_pg.vQuery;
BEGIN
	  LN_cod_retorno := 0;
	  LV_des_error := '';
      LN_num_evento :=0;
	
		IF EN_cod_vendedor IS NOT NULL THEN	 
		  IF NOT GE_CON_VENDEDORES_FN(EN_cod_vendedor)THEN
		  	 RAISE error_con_vendedor;
		  END IF; 
		END IF;
		
		IF EV_cod_oficina IS NOT NULL THEN	 
		  IF NOT GE_CON_OFICINA_FN (EV_cod_oficina)THEN
		  	 RAISE error_con_oficina;
		  END IF; 
		END IF;
	    
      	
	    LV_sSql := 'INSERT INTO GE_SEG_USUARIO (nom_usuario, nom_operador, ind_adm, cod_oficina, cod_tipcomis,cod_vendedor,'
		   	   || 'ind_excep_eriesgo,nom_email,ind_visual)'
	           || ' VALUES ('|| EV_nom_usuario||',' || EV_nom_operador|| ',' || EV_ind_adm|| ','|| EV_cod_oficina||','|| EV_cod_tipcomis ||','
	           || EN_cod_vendedor|| ',' || EV_excep_eriesgo||','||EV_email||','||EV_IND_VISUAL||')';
			   
			   
	    SELECT COUNT(1)
		INTO  GN_Existe
		FROM GE_SEG_USUARIO a
		WHERE a.nom_usuario = EV_nom_usuario;
		
		IF GN_Existe = CN_cero THEN
		
			INSERT INTO GE_SEG_USUARIO
			            (nom_usuario, nom_operador, ind_adm, cod_oficina, cod_tipcomis,
			             cod_vendedor, ind_excep_eriesgo,nom_email,ind_visual
			            )
			     VALUES (EV_nom_usuario, EV_nom_operador, EV_ind_adm , EV_cod_oficina, EV_cod_tipcomis,
			             EN_cod_vendedor, EV_excep_eriesgo,EV_email,EV_IND_VISUAL
                       );
                       
										
	    GE_INSERTAR_ERRORES_PR (EN_numtransaccion, LN_cod_retorno, LV_des_error);
		ELSE
			RAISE error_select;
		END IF;
		 
   EXCEPTION
   
       WHEN error_con_vendedor THEN
		     LN_cod_retorno := 476;
             IF NOT Ge_Errores_Pg.MENSAJEERROR(LN_cod_retorno,LV_mens_retorno) THEN
                    LV_mens_retorno := CV_error_no_clasIF;
             END IF;			  
             LV_des_error:='error_con_vendedor:GE_CON_VENDEDORES_FN('|| EN_cod_vendedor||')';
             LN_num_evento:=Ge_Errores_Pg.Grabarpl( LN_num_evento,CV_cod_modulo,LV_mens_retorno,
                                                   CV_version||'.'||CV_subversion, 
                                                   USER, 'GE_SEGUSUARIO_IN_FN.GE_SEGUSUARIO_IN_FN', 
                                                   LV_sSql , SQLCODE, LV_des_error );
												
		     GE_INSERTAR_ERRORES_PR (EN_numtransaccion, LN_cod_retorno, LV_des_error);

       WHEN error_con_oficina THEN
	   		 LN_cod_retorno := 173;
             IF NOT Ge_Errores_Pg.MENSAJEERROR(LN_cod_retorno,LV_mens_retorno) THEN
                    LV_mens_retorno := CV_error_no_clasIF;
             END IF;			  
             LV_des_error:='error_con_oficina:GE_CON_OFICINA_FN('|| EV_cod_oficina||')';
             LN_num_evento:=Ge_Errores_Pg.Grabarpl( LN_num_evento,CV_cod_modulo,LV_mens_retorno,
                                                   CV_version||'.'||CV_subversion, 
                                                   USER, 'GE_SEGUSUARIO_IN_FN.GE_SEGUSUARIO_IN_FN', 
                                                   LV_sSql , SQLCODE, LV_des_error );
		  	 GE_INSERTAR_ERRORES_PR (EN_numtransaccion, LN_cod_retorno, LV_des_error);													

	   WHEN error_select THEN
	   		 LN_cod_retorno := 603; --Usuario Existente en el sistema
             IF NOT Ge_Errores_Pg.MENSAJEERROR(LN_cod_retorno,LV_mens_retorno) THEN
                    LV_mens_retorno := CV_error_no_clasIF;
             END IF;			  
             LV_des_error:='error_con_oficina:GE_SEGUSUARIO_IN_FN('|| EV_nom_usuario||')';
             LN_num_evento:=Ge_Errores_Pg.Grabarpl( LN_num_evento,CV_cod_modulo,LV_mens_retorno,
                                                   CV_version||'.'||CV_subversion, 
                                                   USER, 'GE_SEGUSUARIO_IN_FN.GE_SEGUSUARIO_IN_FN', 
                                                   LV_sSql , SQLCODE, LV_des_error );
		     GE_INSERTAR_ERRORES_PR (EN_numtransaccion, LN_cod_retorno, LV_des_error);
	   
       WHEN OTHERS THEN
		     LN_cod_retorno := 604; --Error al Ingresar Usuario
             IF NOT Ge_Errores_Pg.MENSAJEERROR(LN_cod_retorno,LV_mens_retorno) THEN
                    LV_mens_retorno := CV_error_no_clasIF;
             END IF;			  
             LV_des_error:='error_ejec_omensaje:GE_SEGUSUARIO_IN_FN('|| EV_nom_usuario||',' || EV_nom_operador|| ',' 
		  														  || EV_ind_adm|| ','|| EV_cod_oficina||','
																  || EV_cod_tipcomis ||','|| EN_cod_vendedor|| ',' 
																  || EV_excep_eriesgo||')';
             LN_num_evento:=Ge_Errores_Pg.Grabarpl( LN_num_evento,CV_cod_modulo,LV_mens_retorno,
                                                   CV_version||'.'||CV_subversion, 
                                                   USER, 'GE_SEGUSUARIO_IN_FN.GE_SEGUSUARIO_IN_FN', 
                                                   LV_sSql , SQLCODE, LV_des_error );
		     GE_INSERTAR_ERRORES_PR (EN_numtransaccion, LN_cod_retorno, LV_des_error);			  

END GE_SEGUSUARIO_IN_PR;
-------------------------------------------------------------------------------------------------------------------------------------------------------------------

PROCEDURE GE_SEGUSUARIO_UP_PR(
    EN_numtransaccion IN NUMBER, 
	EV_nom_usuario    IN  GE_SEG_USUARIO.NOM_USUARIO%TYPE,
	EV_nom_operador   IN  GE_SEG_USUARIO.NOM_OPERADOR%TYPE,
	EV_ind_adm  	  IN  GE_SEG_USUARIO.IND_ADM%TYPE,
	EV_cod_oficina    IN  GE_SEG_USUARIO.COD_OFICINA%TYPE,
	EV_cod_tipcomis   IN  GE_SEG_USUARIO.COD_TIPCOMIS%TYPE,
	EN_cod_vendedor   IN  GE_SEG_USUARIO.COD_VENDEDOR%TYPE,
    EV_IND_VISUAL	  IN  GE_SEG_USUARIO.IND_VISUAL%TYPE,
    EV_nom_email	  IN  GE_SEG_USUARIO.NOM_EMAIL%TYPE
)  
/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "GE_SEGUSUARIO_UP_PR"
      Lenguaje="PL/SQL"
      Fecha creación="31-10-2005"
      Creado por="Maritza Tapia A"
      Fecha modificacion=""
      Modificado por=""
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
      <Descripción>Modifica Usuario</Descripción>
      <Parámetros>
          <Entrada>
            <param nom="EN_numtransaccion" Tipo="NUMERICO">Numero de transaccion </param>
            <param nom="EV_nom_usuario" Tipo="CARACTER">Nombre Usuario</param>
            <param nom="EV_nom_operador" Tipo="CARACTER">Descripcion de Usuario Operador</param>
            <param nom="EV_ind_adm " Tipo="CARACTER">indice</param>
            <param nom="EV_cod_oficina"  Tipo="CARACTER">Codigo de Oficina</param>
            <param nom="EV_cod_tipcomis"  Tipo="CARACTER">Codigo Tipo comision</param>
            <param nom="EN_cod_vendedor"  Tipo="NUMERICO">Codigo Vendedor</param>
            <param nom="EV_excep_eriesgo"  Tipo="CARACTER">Usuario puede o no aplicar Excepciones en Evaluación de Riesgo</param>
         </Entrada>
         <Salida>            
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
IS 	
   error_con_vendedor  EXCEPTION;
   error_con_oficina   EXCEPTION;
   LN_cod_retorno      ge_errores_td.cod_msgerror%TYPE;
   LV_mens_retorno     ge_errores_td.det_msgerror%TYPE;
   LN_num_evento       ge_errores_pg.Evento;
   LV_des_error        ge_errores_pg.DesEvent;
   LV_sSql             ge_errores_pg.vQuery;
BEGIN

    LN_cod_retorno := 0;
	LV_des_error := '';
    LN_num_evento :=0;

 
	IF EN_cod_vendedor IS NOT NULL THEN	 
	  IF NOT GE_CON_VENDEDORES_FN(EN_cod_vendedor)THEN
	  	 RAISE error_con_vendedor;
	  END IF; 
	END IF;
	
	IF EV_cod_oficina IS NOT NULL THEN	 
	  IF NOT GE_CON_OFICINA_FN (EV_cod_oficina)THEN
	  	 RAISE error_con_oficina;
	  END IF; 
	END IF;
	
    LV_sSql := 'UPDATE ge_seg_usuario SET nom_operador =' || EV_nom_operador ||', ind_adm =' ||EV_ind_adm || ', cod_oficina =' || EV_cod_oficina|| ', cod_tipcomis =' || EV_cod_tipcomis|| ', cod_vendedor = ' ||EN_cod_vendedor ||'ind_visual ='||EV_IND_VISUAL	|| 'WHERE nom_usuario = ' ||EV_nom_usuario;

	UPDATE ge_seg_usuario
	   SET nom_operador = EV_nom_operador,
	       ind_adm = EV_ind_adm,
	       cod_oficina = EV_cod_oficina,
	       cod_tipcomis = EV_cod_tipcomis,
	       cod_vendedor = EN_cod_vendedor, 
		   nom_email    = EV_nom_email,
           ind_visual   = EV_IND_VISUAL	
	 WHERE nom_usuario = EV_nom_usuario;
	   
     GE_INSERTAR_ERRORES_PR (EN_numtransaccion, LN_cod_retorno, LV_des_error);  
	   
   EXCEPTION
        WHEN error_con_vendedor THEN
			  LN_cod_retorno := 476;
              IF NOT Ge_Errores_Pg.MENSAJEERROR(LN_cod_retorno,LV_mens_retorno) THEN
                     LV_mens_retorno := CV_error_no_clasIF;
              END IF;			  
              LV_des_error:='error_con_vendedor:GE_CON_VENDEDORES_FN('|| EN_cod_vendedor||')';
              LN_num_evento:=Ge_Errores_Pg.Grabarpl( LN_num_evento,CV_cod_modulo,LV_mens_retorno,
                                                    CV_version||'.'||CV_subversion, 
                                                    USER, 'GE_SEGUSUARIO_IN_FN.GE_SEGUSUARIO_UP_FN', 
                                                    LV_sSql , SQLCODE, LV_des_error );
													
			  GE_INSERTAR_ERRORES_PR (EN_numtransaccion, LN_cod_retorno, LV_des_error);													
 
        WHEN error_con_oficina THEN
			  LN_cod_retorno := 173;
              IF NOT Ge_Errores_Pg.MENSAJEERROR(LN_cod_retorno,LV_mens_retorno) THEN
                     LV_mens_retorno := CV_error_no_clasIF;
              END IF;			  
              LV_des_error:='error_con_oficina:GE_CON_OFICINA_FN('|| EV_cod_oficina||')';
              LN_num_evento:=Ge_Errores_Pg.Grabarpl( LN_num_evento,CV_cod_modulo,LV_mens_retorno,
                                                    CV_version||'.'||CV_subversion, 
                                                    USER, 'GE_SEGUSUARIO_IN_FN.GE_SEGUSUARIO_UP_FN', 
                                                    LV_sSql , SQLCODE, LV_des_error );
													
			  GE_INSERTAR_ERRORES_PR (EN_numtransaccion, LN_cod_retorno, LV_des_error);													
 
    
			  
        WHEN OTHERS THEN
			  LN_cod_retorno := 605; --Error al Modificar Usuario
              IF NOT Ge_Errores_Pg.MENSAJEERROR(LN_cod_retorno,LV_mens_retorno) THEN
                     LV_mens_retorno := CV_error_no_clasIF;
              END IF;			  
              LV_des_error:='error_ejec_omensaje:GE_SEGUSUARIO_UP_FN('|| EV_nom_usuario||',' || EV_nom_operador|| ',' 
			  														  || EV_ind_adm|| ','|| EV_cod_oficina||','
																	  || EV_cod_tipcomis ||','|| EN_cod_vendedor||','||EV_IND_VISUAL	||')';
              LN_num_evento:=Ge_Errores_Pg.Grabarpl( LN_num_evento,CV_cod_modulo,LV_mens_retorno,
                                                    CV_version||'.'||CV_subversion, 
                                                    USER, 'GE_SEGUSUARIO_IN_FN.GE_SEGUSUARIO_IN_FN', 
                                                    LV_sSql , SQLCODE, LV_des_error );
													
			 GE_INSERTAR_ERRORES_PR (EN_numtransaccion, LN_cod_retorno, LV_des_error);													
			  

END GE_SEGUSUARIO_UP_PR;
-------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE GE_SEGUSUARIO_DE_PR(
    EN_numtransaccion IN NUMBER,
    EV_nom_usuario   IN  GE_SEG_USUARIO.NOM_USUARIO%TYPE

) IS
/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "GE_SEGUSUARIO_DE_FN"
      Lenguaje="PL/SQL"
      Fecha creación="31-10-2005"
      Creado por="Maritza Tapia A"
      Fecha modificacion=""
      Modificado por=""
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
      <Descripción>Elimina usuario</Descripción>
      <Parámetros>
          <Entrada>
            <param nom="EN_numtransaccion" Tipo="NUMERICO">Numero de transaccion </param>
            <param nom="EV_nom_usuario" Tipo="CARACTER">Nombre Usuario</param>
         </Entrada>
         <Salida>            
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/

   LN_cod_retorno      ge_errores_td.cod_msgerror%TYPE;
   LV_mens_retorno     ge_errores_td.det_msgerror%TYPE;
   LN_num_evento       ge_errores_pg.Evento;
   LV_des_error        ge_errores_pg.DesEvent;
   LV_sSql             ge_errores_pg.vQuery;
BEGIN

	  LN_cod_retorno := 0;
	  LV_des_error := '';
	  LN_num_evento :=0;
		
		
		
	  LV_sSql := 'DELETE ge_seg_usuario WHERE nom_usuario = ' ||EV_nom_usuario;
		
	  DELETE ge_seg_usuario
	   WHERE nom_usuario = ev_nom_usuario;		 					
	
	  GE_INSERTAR_ERRORES_PR (EN_numtransaccion, LN_cod_retorno, LV_des_error);
	   
   EXCEPTION
       WHEN OTHERS THEN
			  LN_cod_retorno := 606; --Error en Eliminacion de usuario
              IF NOT Ge_Errores_Pg.MENSAJEERROR(LN_cod_retorno,LV_mens_retorno) THEN
                     LV_mens_retorno := CV_error_no_clasIF;
              END IF;			  
              LV_des_error:='error_ejec_omensaje:GE_SEGUSUARIO_DE_FN('|| EV_nom_usuario||')';
              LN_num_evento:=Ge_Errores_Pg.Grabarpl( LN_num_evento,CV_cod_modulo,LV_mens_retorno,
                                                    CV_version||'.'||CV_subversion, 
                                                    USER, 'GE_SEGUSUARIO_IN_FN.GE_SEGUSUARIO_DE_FN', 
                                                    LV_sSql , SQLCODE, LV_des_error );
													
			  GE_INSERTAR_ERRORES_PR (EN_numtransaccion, LN_cod_retorno, LV_des_error);													
			  			  

END GE_SEGUSUARIO_DE_PR;
-------------------------------------------------------------------------------------------------------------------------------------------------------------------

PROCEDURE GE_SEGGRUSUARIO_IN_PR(
	EN_numtransaccion   IN NUMBER,
	EV_cod_grupo		IN  GE_SEG_GRPUSUARIO.COD_GRUPO%TYPE,
	EV_nom_usuario      IN	GE_SEG_GRPUSUARIO.NOM_USUARIO%TYPE
) 
/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "GE_SEGGRUSUARIO_IN_FN"
      Lenguaje="PL/SQL"
      Fecha creación="31-10-2005"
      Creado por="Maritza Tapia A"
      Fecha modificacion=""
      Modificado por=""
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
      <Descripción>Ingresa Grupo usuario</Descripción>
      <Parámetros>
          <Entrada>
            <param nom="EN_numtransaccion" Tipo="NUMERICO">Numero de transaccion </param>
            <param nom="EV_cod_grupo" Tipo="CARACTER">Codigo de Grupo</param>
            <param nom="EV_nom_usuario" Tipo="CARACTER">Nombre Usuario</param>
         </Entrada>
         <Salida>            
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
IS
   error_select        EXCEPTION;
   LN_cod_retorno      ge_errores_td.cod_msgerror%TYPE;
   LV_mens_retorno     ge_errores_td.det_msgerror%TYPE;
   LN_num_evento       ge_errores_pg.Evento;
   LV_des_error        ge_errores_pg.DesEvent;
   LV_sSql             ge_errores_pg.vQuery;
BEGIN
	  GN_Existe := 0;
	  LN_cod_retorno := 0;
	  LV_des_error := '';
      LN_num_evento :=0;
 

        LV_sSql := 'INSERT INTO GE_SEG_GRPUSUARIO(cod_grupo, nom_usuario) VALUES (' ||EV_cod_grupo||','
				   || EV_nom_usuario|| ')';		
	    
		SELECT COUNT(1)
		  INTO GN_Existe
		  FROM GE_SEG_GRPUSUARIO a
		 WHERE a.cod_grupo = EV_cod_grupo 
		   AND a.nom_usuario = EV_nom_usuario;
		
		IF GN_Existe = CN_cero THEN
		
			INSERT INTO GE_SEG_GRPUSUARIO
			            (cod_grupo, nom_usuario
			            )
			     VALUES (EV_cod_grupo, EV_nom_usuario
		            );
			GE_INSERTAR_ERRORES_PR (EN_numtransaccion, LN_cod_retorno, LV_des_error);
		ELSE
			RAISE  error_select;
		END IF;
		
	   					
	
	   
   EXCEPTION
       WHEN error_select THEN
   			  LN_cod_retorno := 607;--ERROR Codigo de Grupo se encuentra asociado a Usuario
              IF NOT Ge_Errores_Pg.MENSAJEERROR(LN_cod_retorno,LV_mens_retorno) THEN
                     LV_mens_retorno := CV_error_no_clasIF;
              END IF;			  
              LV_des_error:='error_ejec_omensaje:GE_SEGGRUSUARIO_IN_FN('|| EV_cod_grupo|| ',' || EV_nom_usuario ||')';
              LN_num_evento:=Ge_Errores_Pg.Grabarpl( LN_num_evento,CV_cod_modulo,LV_mens_retorno,
                                                    CV_version||'.'||CV_subversion, 
                                                    USER, 'GE_SEGUSUARIO_IN_FN.GE_SEGGRUSUARIO_IN_FN', 
                                                    LV_sSql , SQLCODE, LV_des_error );
													
			  GE_INSERTAR_ERRORES_PR (EN_numtransaccion, LN_cod_retorno, LV_des_error);													

	   
	   
       WHEN OTHERS THEN
			  LN_cod_retorno := 608;-- ERROR al Ingresar Codigo de Grupo 
              IF NOT Ge_Errores_Pg.MENSAJEERROR(LN_cod_retorno,LV_mens_retorno) THEN
                     LV_mens_retorno := CV_error_no_clasIF;
              END IF;			  
              LV_des_error:='error_ejec_omensaje:GE_SEGGRUSUARIO_IN_FN('|| EV_cod_grupo|| ',' || EV_nom_usuario ||')';
              LN_num_evento:=Ge_Errores_Pg.Grabarpl( LN_num_evento,CV_cod_modulo,LV_mens_retorno,
                                                    CV_version||'.'||CV_subversion, 
                                                    USER, 'GE_SEGUSUARIO_IN_FN.GE_SEGGRUSUARIO_IN_FN', 
                                                    LV_sSql , SQLCODE, LV_des_error );
													
			  GE_INSERTAR_ERRORES_PR (EN_numtransaccion, LN_cod_retorno, LV_des_error);													
			  			  

END GE_SEGGRUSUARIO_IN_PR;
-------------------------------------------------------------------------------------------------------------------------------------------------------------------

PROCEDURE GE_SEGGRUSUARIO_DE_PR(
	EN_numtransaccion   IN NUMBER,
	EV_cod_grupo		IN  GE_SEG_GRPUSUARIO.COD_GRUPO%TYPE,
	EV_nom_usuario      IN	GE_SEG_GRPUSUARIO.NOM_USUARIO%TYPE
) 
/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "GE_SEGGRUSUARIO_DE_FN"
      Lenguaje="PL/SQL"
      Fecha creación="31-10-2005"
      Creado por="Maritza Tapia A"
      Fecha modificacion=""
      Modificado por=""
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
      <Descripción>Elimina grupo usuario</Descripción>
      <Parámetros>
          <Entrada>
            <param nom="EN_numtransaccion" Tipo="NUMERICO">Numero de transaccion </param>
            <param nom="EV_cod_grupo" Tipo="CARACTER">Codigo de Grupo</param>
            <param nom="EV_nom_usuario" Tipo="CARACTER">Nombre Usuario</param>
         </Entrada>
         <Salida>            
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
IS
   LN_cod_retorno      ge_errores_td.cod_msgerror%TYPE;
   LV_mens_retorno     ge_errores_td.det_msgerror%TYPE;
   LN_num_evento       ge_errores_pg.Evento;
   LV_des_error        ge_errores_pg.DesEvent;
   LV_sSql             ge_errores_pg.vQuery;
BEGIN
   	    LN_cod_retorno := 0;
	    LV_des_error := '';
        LN_num_evento :=0;
 

        LV_sSql := 'DELETE GE_SEG_GRPUSUARIO WHERE a.cod_grupo =' ||EV_cod_grupo||' AND a.nom_usuario = '||EV_nom_usuario;				   		


		DELETE GE_SEG_GRPUSUARIO a
		 WHERE a.cod_grupo = EV_cod_grupo 
		   AND a.nom_usuario = EV_nom_usuario;
		   
  	    GE_INSERTAR_ERRORES_PR (EN_numtransaccion, LN_cod_retorno, LV_des_error);	
	   
   EXCEPTION
       WHEN OTHERS THEN
			  LN_cod_retorno := 609;--Error al eliminar Codigo de Grupo
              IF NOT Ge_Errores_Pg.MENSAJEERROR(LN_cod_retorno,LV_mens_retorno) THEN
                     LV_mens_retorno := CV_error_no_clasIF;
              END IF;			  
              LV_des_error:='error_ejec_omensaje:GE_SEGGRUSUARIO_DE_FN('|| EV_cod_grupo|| ',' || EV_nom_usuario ||')';
              LN_num_evento:=Ge_Errores_Pg.Grabarpl( LN_num_evento,CV_cod_modulo,LV_mens_retorno,
                                                    CV_version||'.'||CV_subversion, 
                                                    USER, 'GE_SEGUSUARIO_IN_FN.GE_SEGGRUSUARIO_DE_FN', 
                                                    LV_sSql , SQLCODE, LV_des_error );
			  GE_INSERTAR_ERRORES_PR (EN_numtransaccion, LN_cod_retorno, LV_des_error);													
			  			  

END GE_SEGGRUSUARIO_DE_PR;
-------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE GE_SEGGRUSUARIO_UP_PR(
	EN_numtransaccion   IN NUMBER,
	EV_cod_grupo		IN  GE_SEG_GRPUSUARIO.COD_GRUPO%TYPE,
	EV_nom_usuario      IN	GE_SEG_GRPUSUARIO.NOM_USUARIO%TYPE
) 
/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "GGE_SEGGRUSUARIO_UP_FN"
      Lenguaje="PL/SQL"
      Fecha creación="31-10-2005"
      Creado por="Maritza Tapia A"
      Fecha modificacion=""
      Modificado por=""
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
      <Descripción>Modifica grupo usuario</Descripción>
      <Parámetros>
          <Entrada>
            <param nom="EN_numtransaccion" Tipo="NUMERICO">Numero de transaccion </param>
            <param nom="EV_cod_grupo" Tipo="CARACTER">Codigo de Grupo</param>
            <param nom="EV_nom_usuario" Tipo="CARACTER">Nombre Usuario</param>
         </Entrada>
         <Salida>            
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
IS
   LN_cod_retorno      ge_errores_td.cod_msgerror%TYPE;
   LV_mens_retorno     ge_errores_td.det_msgerror%TYPE;
   LN_num_evento       ge_errores_pg.Evento;
   LV_des_error        ge_errores_pg.DesEvent;
   LV_sSql             ge_errores_pg.vQuery;
BEGIN
	    LN_cod_retorno := 0;
	    LV_des_error := '';
        LN_num_evento :=0;
 

        LV_sSql := 'UPDATE ge_seg_grpusuario  SET cod_grupo =' ||EV_cod_grupo||' nom_usuario ='||EV_nom_usuario||
				   'WHERE a.cod_grupo ='||EV_cod_grupo|| '  AND a.nom_usuario = '|| EV_nom_usuario;		


			UPDATE GE_SEG_GRPUSUARIO a
			   SET a.cod_grupo = EV_cod_grupo,
			       a.nom_usuario = EV_nom_usuario 
			 WHERE a.cod_grupo = EV_cod_grupo 
			   AND a.nom_usuario = EV_nom_usuario;	
			   
 	    GE_INSERTAR_ERRORES_PR (EN_numtransaccion, LN_cod_retorno, LV_des_error);					
	
	   
   EXCEPTION
       WHEN OTHERS THEN
			  LN_cod_retorno := 610;--Error al Modificar Codigo de Grupo
              IF NOT Ge_Errores_Pg.MENSAJEERROR(LN_cod_retorno,LV_mens_retorno) THEN
                     LV_mens_retorno := CV_error_no_clasIF;
              END IF;			  
              LV_des_error:='error_ejec_omensaje:GE_SEGGRUSUARIO_UP_FN('|| EV_cod_grupo|| ',' || EV_nom_usuario ||')';
              LN_num_evento:=Ge_Errores_Pg.Grabarpl( LN_num_evento,CV_cod_modulo,LV_mens_retorno,
                                                    CV_version||'.'||CV_subversion, 
                                                    USER, 'GE_SEGUSUARIO_IN_FN.GE_SEGGRUSUARIO_UP_FN', 
                                                    LV_sSql , SQLCODE, LV_des_error );
													
			  GE_INSERTAR_ERRORES_PR (EN_numtransaccion, LN_cod_retorno, LV_des_error);													
			  			  

END GE_SEGGRUSUARIO_UP_PR;
-------------------------------------------------------------------------------------------------------------------------------------------------------------------

PROCEDURE GE_SEGPERFILES_IN_PR(
	EN_numtransaccion   IN  NUMBER,
	EV_cod_programa     IN	GE_SEG_PERFILES.COD_PROGRAMA%TYPE,
	EV_cod_grupo		IN  GE_SEG_PERFILES.COD_GRUPO%TYPE,
	EV_cod_proceso      IN	GE_SEG_PERFILES.COD_PROCESO%TYPE,
	EN_num_version      IN	GE_SEG_PERFILES.NUM_VERSION %TYPE
) 
/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "GE_SEGPERFILES_IN_FN"
      Lenguaje="PL/SQL"
      Fecha creación="31-10-2005"
      Creado por="Maritza Tapia A"
      Fecha modificacion=""
      Modificado por=""
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
      <Descripción>Ingresa  perfiles usuario</Descripción>
      <Parámetros>
          <Entrada>
            <param nom="EN_numtransaccion" Tipo="NUMERICO">Numero de transaccion </param>
            <param nom="EV_cod_grupo" Tipo="CARACTER">Codigo de Grupo</param>			
            <param nom="EV_cod_programa" Tipo="CARACTER">Codigo de Programa</param>
            <param nom="EV_num_version" Tipo="NUMERICO">Numero de la version</param>
            <param nom="EV_cod_proceso" Tipo="CARACTER">Codigo de Proceso</param>
         </Entrada>
         <Salida>            
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
IS
   error_insert        EXCEPTION;
   LN_cod_retorno      ge_errores_td.cod_msgerror%TYPE;
   LV_mens_retorno     ge_errores_td.det_msgerror%TYPE;
   LN_num_evento       ge_errores_pg.Evento;
   LV_des_error        ge_errores_pg.DesEvent;
   LV_sSql             ge_errores_pg.vQuery;

BEGIN
        LN_num_evento :=0;
  	    LN_cod_retorno := 0;
	    LV_des_error := ''; 
        GN_Existe :=0;

        LV_sSql := 'INSERT INTO GE_SEG_PERFILES (cod_grupo, cod_programa, num_version, cod_proceso) VALUES (' ||EV_cod_grupo||',' 
				   || EV_cod_programa|| ',' ||EN_num_version|| ','||EV_cod_proceso|| ')';		

		SELECT COUNT(1)
		INTO GN_Existe
		FROM GE_SEG_PERFILES 
		WHERE cod_grupo = EV_cod_grupo
		  AND cod_programa = EV_cod_programa
		  AND num_version = EN_num_version
		  AND cod_proceso = EV_cod_proceso ;
		  
	    IF GN_Existe = CN_cero THEN		  
		  
			INSERT INTO GE_SEG_PERFILES
			            (cod_grupo, cod_programa, num_version, cod_proceso
			            )
			     VALUES (EV_cod_grupo, EV_cod_programa, EN_num_version, EV_cod_proceso
			            );
		ELSE
			RAISE error_insert;		
		END IF;

	   GE_INSERTAR_ERRORES_PR (EN_numtransaccion, LN_cod_retorno, LV_des_error);
		
							
	
	   
   EXCEPTION
   
   	   WHEN error_insert THEN
   			  LN_cod_retorno := 611;--Error Perfil ya existe
              IF NOT Ge_Errores_Pg.MENSAJEERROR(LN_cod_retorno,LV_mens_retorno) THEN
                     LV_mens_retorno := CV_error_no_clasIF;
              END IF;			  
              LV_des_error:='error_ejec_omensaje:GE_SEGPERFILES_IN_FN('|| EV_cod_grupo|| ',' || EV_cod_programa ||',' || EN_num_version ||',' || EV_cod_proceso ||')';
              LN_num_evento:=Ge_Errores_Pg.Grabarpl( LN_num_evento,CV_cod_modulo,LV_mens_retorno,
                                                    CV_version||'.'||CV_subversion, 
                                                    USER, 'GE_SEGUSUARIO_IN_FN.GE_SEGPERFILES_IN_FN', 
                                                    LV_sSql , SQLCODE, LV_des_error );
			  GE_INSERTAR_ERRORES_PR (EN_numtransaccion, LN_cod_retorno, LV_des_error);													

	   
       WHEN OTHERS THEN
			  LN_cod_retorno := 612;--Error al ingresar perfiles
              IF NOT Ge_Errores_Pg.MENSAJEERROR(LN_cod_retorno,LV_mens_retorno) THEN
                     LV_mens_retorno := CV_error_no_clasIF;
              END IF;			  
              LV_des_error:='error_ejec_omensaje:GE_SEGPERFILES_IN_FN('|| EV_cod_grupo|| ',' || EV_cod_programa ||',' || EN_num_version ||',' || EV_cod_proceso ||')';
              LN_num_evento:=Ge_Errores_Pg.Grabarpl( LN_num_evento,CV_cod_modulo,LV_mens_retorno,
                                                    CV_version||'.'||CV_subversion, 
                                                    USER, 'GE_SEGUSUARIO_IN_FN.GE_SEGPERFILES_IN_FN', 
                                                    LV_sSql , SQLCODE, LV_des_error );
			  GE_INSERTAR_ERRORES_PR (EN_numtransaccion, LN_cod_retorno, LV_des_error);													
			  			  

END GE_SEGPERFILES_IN_PR;
-------------------------------------------------------------------------------------------------------------------------------------------------------------------

PROCEDURE GE_SEGPERFILES_DE_PR(
	EN_numtransaccion   IN NUMBER,
	EV_cod_programa     IN	GE_SEG_PERFILES.COD_PROGRAMA%TYPE,
	EN_num_version      IN	GE_SEG_PERFILES.NUM_VERSION %TYPE,
	EV_cod_grupo		IN  GE_SEG_PERFILES.COD_GRUPO%TYPE
) 
/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "GE_SEGPERFILES_DE_PR"
      Lenguaje="PL/SQL"
      Fecha creación="31-10-2005"
      Creado por="Maritza Tapia A"
      Fecha modificacion=""
      Modificado por=""
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
      <Descripción>Elimina perfiles usuario</Descripción>
      <Parámetros>
          <Entrada>
            <param nom="EN_numtransaccion" Tipo="NUMERICO">Numero de transaccion </param>
            <param nom="EV_cod_programa" Tipo="CARACTER">Codigo de Programa</param>
            <param nom="EV_num_version" Tipo="NUMERICO">Numero de la version</param>
            <param nom="EV_cod_grupo" Tipo="CARACTER">Codigo de Grupo</param>
         </Entrada>
         <Salida>            
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
IS
   LN_cod_retorno      ge_errores_td.cod_msgerror%TYPE;
   LV_mens_retorno     ge_errores_td.det_msgerror%TYPE;
   LN_num_evento       ge_errores_pg.Evento;
   LV_des_error        ge_errores_pg.DesEvent;
   LV_sSql             ge_errores_pg.vQuery;
   error_delete        EXCEPTION;
BEGIN
       LN_num_evento :=0;
   	   LN_cod_retorno := 0;
	   LV_des_error := '';
       GN_Existe :=0;
 	 

        LV_sSql := 'DELETE GE_SEG_PERFILES WHERE cod_grupo =' ||EV_cod_grupo||' AND cod_programa =' 
				   || EV_cod_programa|| ' AND num_version =' ||EN_num_version;				   				  
		
	       DELETE GE_SEG_PERFILES
			WHERE cod_grupo = EV_cod_grupo
			  AND cod_programa = EV_cod_programa
			  AND num_version = EN_num_version;	
			  
  		   GE_INSERTAR_ERRORES_PR (EN_numtransaccion, LN_cod_retorno, LV_des_error);
	   
   EXCEPTION

			     
       WHEN OTHERS THEN
 
			  LN_cod_retorno := 613;--Error al eliminar perfil
              IF NOT Ge_Errores_Pg.MENSAJEERROR(LN_cod_retorno,LV_mens_retorno) THEN
                     LV_mens_retorno := CV_error_no_clasIF;
              END IF;			  
              LV_des_error:='error_ejec_omensaje:GE_SEGPERFILES_IN_FN('|| EV_cod_grupo|| ',' || EV_cod_programa ||',' || EN_num_version ||') - '||SQLERRM;
              LN_num_evento:=Ge_Errores_Pg.Grabarpl( LN_num_evento,CV_cod_modulo,LV_mens_retorno,
                                                    CV_version||'.'||CV_subversion, 
                                                    USER, 'GE_SEGUSUARIO_IN_FN.GE_SEGPERFILES_DE_FN', 
                                                    LV_sSql , SQLCODE, LV_des_error );
			 GE_INSERTAR_ERRORES_PR (EN_numtransaccion, LN_cod_retorno, LV_des_error);
   		      
END GE_SEGPERFILES_DE_PR;



-------------------------------------------------------------------------------------------------------------------------------------------------------------------

PROCEDURE GE_SEGUSUARIO_VALVISUAL_PR( 
	  	EV_nom_usuario      IN  GE_SEG_USUARIO.NOM_USUARIO%TYPE,
	    SN_ind_visual       OUT NOCOPY GE_SEG_USUARIO.IND_VISUAL%TYPE,
        SN_cod_retorno      OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
        SV_mens_retorno     OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
        SN_num_evento       OUT NOCOPY ge_errores_pg.evento
) 
/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "GE_SEGUSUARIO_VALVISUAL_PR"
      Lenguaje="PL/SQL"
      Fecha creación="04-06-2009"
      Creado por="OCB"
      Fecha modificacion=""
      Modificado por=""
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
      <Descripción>Obtiene indicador de Visaulización </Descripción>
      <Parámetros>
          <Entrada>
            <param nom="EV_nom_usuario" Tipo="CARACTER">Nombre Usuario</param>
         </Entrada>
       <Salida>
            <param nom="SN_ind_visual" Tipo="NUMERICO">indicador de retorno</param>>
             <param nom="SN_cod_retorno" Tipo="NUMERICO">Codigo de Retorno</param>>
             <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>>
             <param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>>
          </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
IS
 LV_des_error    ge_errores_pg.DesEvent;
 LV_sSql         ge_errores_pg.vQuery;
 
BEGIN
 
         sn_cod_retorno  := 0;
         sv_mens_retorno := NULL;
         sn_num_evento   := 0;
         SN_ind_visual   :=0;

   	     LV_sSql := 'SELECT ind_visual INTO'||   SN_ind_visual;
		 LV_sSql := LV_sSql || 'FROM GE_SEG_USUARIO	WHERE nom_usuario = '|| EV_nom_usuario;
		   	  
			   
	     SELECT ind_visual
		 INTO   SN_ind_visual
		 FROM GE_SEG_USUARIO 
		 WHERE nom_usuario = EV_nom_usuario;

  	    	
 
 EXCEPTION
        
        WHEN OTHERS THEN
             SN_cod_retorno := 156;
             IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                                SV_mens_retorno := CV_error_no_clasif;
             END IF;

            LV_des_error   := 'GE_SEG_AUDITORIA_PG.GE_SEGUSUARIO_VALVISUAL_PR('||EV_nom_usuario||','||  SN_ind_visual||','||sn_cod_retorno||','||sv_mens_retorno||','||sn_num_evento || ')' || SQLERRM;
            SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'GE_SEG_AUDITORIA_PG.GE_SEGUSUARIO_VALVISUAL_PR', LV_sSQL, SN_cod_retorno, LV_des_error );
															
			  			  

END GE_SEGUSUARIO_VALVISUAL_PR;



END GE_SEG_AUDITORIA_PG; 
/
SHOW ERRORS
