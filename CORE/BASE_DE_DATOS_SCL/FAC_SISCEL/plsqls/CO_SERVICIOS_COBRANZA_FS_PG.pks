CREATE OR REPLACE PACKAGE Co_Servicios_Cobranza_Fs_Pg
/*
<Documentación
   TipoDoc = "Package">
   <Elemento
       Nombre = "CO_SERVICIOS_COBRANZA_FS_PG"
       Lenguaje="PL/SQL"
       Fecha="14-06-2006"
       Versión="1.0"
       Diseñador=""
       Programador="Soporte RyC"
       Ambiente Desarrollo="BD">
       <Retorno>NA</Retorno>
       <Descripción>Package fachada de llamada a Servicios de Cobranza</Descripción>
       <Parámetros>
          <Entrada>NA</Entrada>
          <Salida>NA</Salida>
       </Parámetros>
    </Elemento>
   </Documentación
     14.06.2006 Se crea por incidencia CO-200606070176 >
*/
IS
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   PROCEDURE co_interfaz_web_fs_pr (
      EN_codcliente     IN         NUMBER,
      EN_importepago    IN         NUMBER,
      EN_fecpago        IN         VARCHAR2,
      EN_codbanco       IN         VARCHAR2,
      SN_cod_retorno    OUT NOCOPY ge_errores_pg.CodError,
      SV_mens_retorno   OUT NOCOPY ge_errores_pg.MsgError,
      SN_num_evento     OUT NOCOPY ge_errores_pg.Evento);

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------}
END Co_Servicios_Cobranza_Fs_Pg;
/
SHOW ERRORS
