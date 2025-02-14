CREATE OR REPLACE PACKAGE ga_ooss_fs_pg
/*
<Documentaci�n
   TipoDoc = "Package">
   <Elemento
       Nombre = "PV_OOSS_FS_PG"
       Lenguaje="PL/SQL"
       Fecha="03-11-2005"
       Versi�n="1.0"
       Dise�ador="Andr�s Osorio"
       Programador="Andr�s Osorio"
       Ambiente Desarrollo="BD">
       <Retorno>NA</Retorno>
       <Descripci�n>Package fachada para servicios Consulta de Extratriempo</Descripci�n>
       <Par�metros>
          <Entrada>NA</Entrada>
          <Salida>NA</Salida>
       </Par�metros>
    </Elemento>
   </Documentaci�n>
*/

IS
	SN_cod_retornoau   ge_errores_pg.CodError;
	SV_mens_retornoau  ge_errores_pg.MsgError;
	SN_num_eventoau    ge_errores_pg.Evento;
	SN_num_transaccion ge_auditoria_to.num_ticket%TYPE;


ERR_MOAUDITORIA    EXCEPTION;
ERR_AGAUDITORIA    EXCEPTION;
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  PROCEDURE ga_extratiempo_consulta_fs_pr (EN_NUM_CELULAR     IN  NUMBER,
                       					 EV_COD_PLAN        IN  VARCHAR2,
										 SN_MIN_COMPRADOS   OUT NOCOPY NUMBER,
										 SN_MIN_USADOS	    OUT NOCOPY NUMBER,
										 SN_MIN_DISPONIBLES OUT NOCOPY NUMBER,
										 SN_cod_retorno     OUT NOCOPY   ge_errores_pg.CodError,
                			 			 SV_mens_retorno    OUT NOCOPY   ge_errores_pg.MsgError);
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

   FUNCTION ga_version_fn
      RETURN VARCHAR2;

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
END ga_ooss_fs_pg;
/
SHOW ERRORS
