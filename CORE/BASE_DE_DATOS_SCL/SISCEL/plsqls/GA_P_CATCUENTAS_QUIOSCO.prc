CREATE OR REPLACE PROCEDURE GA_P_CATCUENTAS_QUIOSCO (
   vp_transac       IN   NUMBER,
   v_num_ident      IN   VARCHAR2,
   v_cod_catribut   IN   VARCHAR2,
   v_tipo_modulo    IN   NUMBER,
   --Mantenci�n adaptativa MPA-200607140007 se agrega variable para tipo de identificador [PAAA 27-07-2006, soporte]
   v_tipo_ident     IN   VARCHAR2
   --Fin mantenci�n MPA-200607140007
)
IS
   v_error              NUMBER                                           := 0;
   v_cadena             ga_transacabo.des_cadena%TYPE                      := NULL;
   v_error_proc      	ga_transacabo.des_cadena%TYPE                      := NULL;
   v_tipo_aux           Char (1)  					   := '1';
   v_cadena_aux         ga_transacabo.des_cadena%TYPE                      := NULL;
BEGIN

   v_tipo_aux := TO_CHAR (v_tipo_modulo);
   --v_cadena_aux := v_num_ident || ',' || v_cod_catribut || ',' || v_tipo_aux;
   
   --Mantenci�n adaptativa MPA-200607140007 se agrega tipo identificador a cadena [PAAA 27-07-2006, soporte]
   --v_cadena_aux := '''' || v_num_ident || '''' || ',' || '''' || v_cod_catribut || ''''|| ',' || '''' || v_tipo_aux|| '''';
   v_cadena_aux := '''' || v_num_ident || '''' || ',' || '''' || v_cod_catribut || ''''|| ',' || '''' || v_tipo_aux|| '''' || ',' || '''' || v_tipo_ident|| '''';
   --Fin mantenci�n MPA-200607140007
   
   v_cadena := ge_fn_ejecuta_rutina('GA', 2, v_cadena_aux);

   v_error := 0;

   v_error_proc :=  Substr(v_cadena, 1,5);

   IF v_error_proc <> 'ERROR'
   THEN
   	   INSERT INTO ga_transacabo (num_transaccion, cod_retorno, des_cadena)
   	   VALUES (vp_transac, v_error, v_cadena);
   END IF;

END ga_p_catcuentas_quiosco;
/
SHOW ERRORS


--******************************************************************************************
--** Informaci�n de Versionado *************************************************************
--******************************************************************************************
--** Pieza                                               : 
--**  %ARCHIVE%
--** Identificador en PVCS                               : 
--**  %PID%
--** Producto                                            : 
--**  %PP%
--** Revisi�n                                            : 
--**  %PR%
--** Autor de la Revisi�n                                :          
--**  %AUTHOR%
--** Estado de la Revisi�n ($TO_BE_DEFINED es Check-Out) : 
--**  %PS%
--** Fecha de Creaci�n de la Revisi�n                    : 
--**  %DATE% 
--** Worksets ******************************************************************************
--** %PIRW%
--** Historia ******************************************************************************
--** %PL%
--******************************************************************************************
