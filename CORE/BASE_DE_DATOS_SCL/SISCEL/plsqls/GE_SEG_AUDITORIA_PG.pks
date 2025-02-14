CREATE OR REPLACE PACKAGE                  GE_SEG_AUDITORIA_PG IS
/*
<Documentación
   TipoDoc = "Package">
   <Elemento
       Nombre = "GE_SEG_AUDITORIA_PG"
       Lenguaje="PL/SQL"
       Fecha="21-11-2005"
       Versión="1.0"
       Diseñador="Marcela Lucero. - Maritza Tapia."
       Programador="Maritza Tapia A."
       Ambiente Desarrollo="BD">
       <Retorno>NA</Retorno>
       <Descripción>Package De Reportes de Auditoria</Descripción>
       <Parámetros>
          <Entrada>NA</Entrada>
          <Salida>NA</Salida>
       </Parámetros>
    </Elemento>
   </Documentación>
*/


	TYPE refcursor IS REF CURSOR;

    CN_uno                  CONSTANT PLS_INTEGER   := 1;
    CN_cero                 CONSTANT PLS_INTEGER   := 0;
	CV_ok					CONSTANT VARCHAR2(5)   := '0';		 
	CV_version         	    CONSTANT VARCHAR2(5)   := '1.0';
	CV_subversion           CONSTANT VARCHAR2(1)   := '0';   
	CV_error_no_clasif      CONSTANT VARCHAR2 (100)   := 'Error no Clasificado';
    CV_cod_modulo           CONSTANT VARCHAR2 (2)     := 'GA';
	GN_Existe				NUMBER  := 0;


	
	FUNCTION GE_CON_VENDEDORES_FN(
    EV_cod_vendedor    IN  VE_VENDEDORES.COD_VENDEDOR%TYPE
	) RETURN BOOLEAN;
	
	FUNCTION GE_CON_OFICINA_FN(
    EV_cod_oficina    IN  GE_OFICINAS.COD_OFICINA%TYPE
	)RETURN BOOLEAN;
	
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
 );
	
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
    
	);  
	
	PROCEDURE GE_SEGUSUARIO_DE_PR(
    EN_numtransaccion IN NUMBER,
    EV_nom_usuario    IN  GE_SEG_USUARIO.NOM_USUARIO%TYPE
	);
	
	PROCEDURE GE_SEGGRUSUARIO_IN_PR(
    EN_numtransaccion   IN NUMBER,
	EV_cod_grupo		IN  GE_SEG_GRPUSUARIO.COD_GRUPO%TYPE,
	EV_nom_usuario      IN	GE_SEG_GRPUSUARIO.NOM_USUARIO%TYPE
	);
	
	PROCEDURE GE_SEGGRUSUARIO_DE_PR(
    EN_numtransaccion   IN NUMBER,
	EV_cod_grupo		IN  GE_SEG_GRPUSUARIO.COD_GRUPO%TYPE,
	EV_nom_usuario      IN	GE_SEG_GRPUSUARIO.NOM_USUARIO%TYPE
	);
	
	PROCEDURE GE_SEGGRUSUARIO_UP_PR(
    EN_numtransaccion   IN NUMBER,
	EV_cod_grupo		IN  GE_SEG_GRPUSUARIO.COD_GRUPO%TYPE,
	EV_nom_usuario      IN	GE_SEG_GRPUSUARIO.NOM_USUARIO%TYPE
	);	
	
	PROCEDURE GE_SEGPERFILES_IN_PR(
	EN_numtransaccion   IN  NUMBER,
	EV_cod_programa     IN	GE_SEG_PERFILES.COD_PROGRAMA%TYPE,
	EV_cod_grupo		IN  GE_SEG_PERFILES.COD_GRUPO%TYPE,
	EV_cod_proceso      IN	GE_SEG_PERFILES.COD_PROCESO%TYPE,
	EN_num_version      IN	GE_SEG_PERFILES.NUM_VERSION %TYPE
	); 
		
	PROCEDURE GE_SEGPERFILES_DE_PR(
    EN_numtransaccion   IN NUMBER,
	EV_cod_programa     IN	GE_SEG_PERFILES.COD_PROGRAMA%TYPE,
	EN_num_version      IN	GE_SEG_PERFILES.NUM_VERSION %TYPE,
	EV_cod_grupo		IN  GE_SEG_PERFILES.COD_GRUPO%TYPE
	);
	
	PROCEDURE GE_INSERTAR_ERRORES_PR (
    EN_numtransaccion   IN   NUMBER,
    EN_retorno          IN   NUMBER,
    EV_glosa            IN   VARCHAR2
	); 
	
    
    PROCEDURE GE_SEGUSUARIO_VALVISUAL_PR( 
	  	EV_nom_usuario      IN  GE_SEG_USUARIO.NOM_USUARIO%TYPE,
	    SN_ind_visual       OUT NOCOPY GE_SEG_USUARIO.IND_VISUAL%TYPE,
        SN_cod_retorno      OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
        SV_mens_retorno     OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
        SN_num_evento       OUT NOCOPY ge_errores_pg.evento
 	);
    
    
END GE_SEG_AUDITORIA_PG; 
/
SHOW ERRORS
