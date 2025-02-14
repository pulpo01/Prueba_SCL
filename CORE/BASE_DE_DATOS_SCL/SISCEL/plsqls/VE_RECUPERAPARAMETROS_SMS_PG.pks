CREATE OR REPLACE PACKAGE ve_recuperaparametros_sms_pg
IS
/*
<Documentación
      TipoDoc = "Package">
      <Elemento
          Nombre = "ve_recuperaparametros_sms_pg"
          Lenguaje="PL/SQL"
          Fecha="02-09-2005"
          Versión="1.0"
          Diseñador="Rayen Ceballos"
          Programador="Roberto Pérez"
	  Migración="Jubitza Villanueva G."
          Ambiente Desarrollo="BD">
          <Retorno>NA</Retorno>
          <Descripción>Recuperación de valores para parámetros</Descripción>
          <Parámetros>
             <Entrada>NA</Entrada>
             <Salida>NA</Salida>
          </Parámetros>
       </Elemento>
      </Documentación>
*/
CV_version           CONSTANT VARCHAR2(5):= '1.0';
CV_codmodulo         CONSTANT VARCHAR2(2):='GA';
--------------------------------------------------------------------------------------------------------
FUNCTION ve_recupera_parametros_fn (
        ev_nom_parametro    IN               ged_parametros.nom_parametro%TYPE,
        ev_cod_modulo       IN               ged_parametros.cod_modulo%TYPE,
        en_cod_producto     IN               ged_parametros.cod_producto%TYPE,
        sv_val_parametro    OUT NOCOPY       ged_parametros.val_parametro%TYPE,
        sn_cod_retorno      OUT NOCOPY       ge_errores_td.cod_msgerror%TYPE,
        sv_mens_retorno     OUT NOCOPY       ge_errores_td.det_msgerror%TYPE,
        sn_num_evento       OUT NOCOPY       ge_errores_pg.evento
    )RETURN BOOLEAN;
--------------------------------------------------------------------------------------------------------
FUNCTION VE_recupera_glosa_FN(
        EV_cod_modulo    IN         ged_codigos.cod_modulo%TYPE,
        EV_nom_tabla     IN         ged_codigos.nom_tabla%TYPE,
        EV_nom_columna   IN         ged_codigos.nom_columna%TYPE,
        SV_des_valor     OUT NOCOPY ged_codigos.des_valor%TYPE,
	    SN_cod_retorno   OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
	    SV_mens_retorno  OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
	    SN_num_evento    OUT NOCOPY ge_errores_pg.Evento
    ) RETURN BOOLEAN;
--------------------------------------------------------------------------------------------------------

END ve_recuperaparametros_sms_pg;
/
SHOW ERRORS
