CREATE OR REPLACE PACKAGE BODY GA_SERVICIOS_ABONADOS_FS_PG
IS

SN_cod_retornoau   ge_errores_pg.CodError;
SV_mens_retornoau  ge_errores_pg.MsgError;
SN_num_eventoau    ge_errores_pg.Evento;
SN_num_transaccion ge_auditoria_to.num_ticket%TYPE;
LV_param		   VARCHAR2(4000);

ERR_MOAUDITORIA    EXCEPTION;
ERR_AGAUDITORIA    EXCEPTION;
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE GA_VALIDA_CLAVE_WEB_FS_PR (EN_num_celular   IN     ga_abocel.num_celular%TYPE,
                                   EV_clave           IN     ga_abocel.cod_password%TYPE,
                                   SN_validacion      OUT NOCOPY     NUMBER,
								   SN_cod_retorno     OUT NOCOPY   ge_errores_pg.CodError,
								   SV_mens_retorno    OUT NOCOPY   ge_errores_pg.MsgError
)
/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "GA_VALIDA_CLAVE_WEB_FS_PR"
      Lenguaje="PL/SQL"
      Fecha="30-04-2005"
      Versión="1.0"
      Diseñador=""Fernando Garcia E."
      Programador="Jubitza Villanueva G."
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
      <Descripción>Mascara que valida la clave secreta de acceso a la web de un abonado</Descripción>
      <Parámetros>
         <Entrada>
            <param nom="EN_num_celular" Tipo="NUMERICO">Numero de Celular</param>
            <param nom="EV_clave" Tipo="CARACTER">Clave a validar</param>
         </Entrada>
         <Salida>
            <param nom="SN_Validacion" Tipo="Number">Retorno de verificacion</param>
            <param nom="SN_cod_retorno"   Tipo="NUMERICO">Codigo de Retorno</param>
            <param nom="SV_mens_retorno"  Tipo="CARACTER">Mensaje de Retorno</param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
AS
    SN_num_evento  ge_errores_pg.Evento;
BEGIN
    ge_auditoria_pg.ge_agregaauditoria_pr( SN_num_transaccion, 'INICI', USER, NULL, 'num_celular=' || EN_num_celular ||'-- '||'clave=' || EV_clave, 'SAI', 'ECU_0002', NULL, SN_cod_retornoau, SV_mens_retornoau, SN_num_eventoau);
    IF SN_cod_retornoau IS NULL THEN
	   GA_SERVICIOS_ABONADOS_PG.GA_VALIDA_CLAVE_WEB_PR(EN_num_celular,
					 EV_clave,
					 SN_validacion,
					 SN_cod_retorno,
					 SV_mens_retorno,
					 SN_num_evento);

	    ge_auditoria_pg.ge_modificaauditoria_pr( 'TERMI', SN_num_evento, SN_cod_retorno, SN_num_transaccion, NULL, NULL, SN_cod_retornoau, SV_mens_retornoau, SN_num_eventoau);
        IF SN_cod_retornoau IS NOT NULL THEN
            RAISE ERR_MOAUDITORIA;
        END IF;
    ELSE
        RAISE ERR_AGAUDITORIA;
    END IF;

    EXCEPTION

        WHEN ERR_AGAUDITORIA THEN
            SN_cod_retorno  := SN_cod_retornoau;
            SV_mens_retorno := SV_mens_retornoau;

        WHEN ERR_MOAUDITORIA  THEN
            SN_cod_retorno  := SN_cod_retornoau;
            SV_mens_retorno := SV_mens_retornoau;
END GA_VALIDA_CLAVE_WEB_FS_PR;
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE GA_MODIFICA_CLAVE_WEB_FS_PR (
		  						   EN_num_celular   IN     ga_abocel.num_celular%TYPE,
		  						   EV_clave         IN     ga_abocel.cod_password%TYPE,
								   SN_numos          OUT NOCOPY    ci_orserv.num_os%TYPE,
								   SN_cod_retorno     OUT NOCOPY   ge_errores_pg.CodError,
								   SV_mens_retorno    OUT NOCOPY   ge_errores_pg.MsgError
                                  )
/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "GA_MODIFICA_CLAVE_WEB_FS_PR"
      Lenguaje="PL/SQL"
      Fecha="30-04-2005"
      Versión="1.0"
      Diseñador=""Fernando Garcia E."
      Programador="Jubitza Villanueva G."
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
      <Descripción>MAscara que Modifica contraseña web del abonado</Descripción>
      <Parámetros>
         <Entrada>
            <param nom="EN_num_celular"     Tipo="NUMERICO">Secuencia nro del abonado</param>
            <param nom="EV_clave"  	   	    Tipo="CARACTER">Nueva Contraseña web del abonado</param>
         </Entrada>
         <Salida>
            <param nom="SN_numos"     Tipo="NUMERICO">Orden de servicio generada</param>
            <param nom="SN_validacion"     Tipo="NUMERICO">Retorno de la validacion</param>
            <param nom="SN_cod_retorno"     Tipo="NUMERICO">Codigo de Retorno</param>
            <param nom="SV_mens_retorno"    Tipo="CARACTER">Mensaje de Retorno</param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/AS
    SN_num_evento  ge_errores_pg.Evento;
BEGIN
    ge_auditoria_pg.ge_agregaauditoria_pr( SN_num_transaccion, 'INICI', USER, NULL, 'num_celular =' || EN_num_celular || ' -- ' , 'SAI', 'ECU_0003', NULL, SN_cod_retornoau, SV_mens_retornoau, SN_num_eventoau);
    IF SN_cod_retornoau IS NULL THEN
	   GA_SERVICIOS_ABONADOS_PG.GA_MODIFICA_CLAVE_WEB_PR(EN_num_celular,
					 EV_clave,
					 SN_numos,
					 SN_cod_retorno,
					 SV_mens_retorno,
					 SN_num_evento);

	    ge_auditoria_pg.ge_modificaauditoria_pr( 'TERMI', SN_num_evento, SN_cod_retorno, SN_num_transaccion, NULL, NULL, SN_cod_retornoau, SV_mens_retornoau, SN_num_eventoau);
        IF SN_cod_retornoau IS NOT NULL THEN
            RAISE ERR_MOAUDITORIA;
        END IF;
    ELSE
        RAISE ERR_AGAUDITORIA;
    END IF;

    EXCEPTION

        WHEN ERR_AGAUDITORIA THEN
            SN_cod_retorno  := SN_cod_retornoau;
            SV_mens_retorno := SV_mens_retornoau;

        WHEN ERR_MOAUDITORIA  THEN
            SN_cod_retorno  := SN_cod_retornoau;
            SV_mens_retorno := SV_mens_retornoau;
END GA_MODIFICA_CLAVE_WEB_FS_PR;
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE GA_DEFAULT_CLAVE_WEB_FS_PR (EN_num_celular  IN     ga_abocel.num_celular%TYPE,
								   SN_cod_retorno     OUT NOCOPY   ge_errores_pg.CodError,
								   SV_mens_retorno    OUT NOCOPY   ge_errores_pg.MsgError
								  )
/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "GA_DEFAULT_CLAVE_WEB_FS_PR"
      Lenguaje="PL/SQL"
      Fecha="30-04-2005"
      Versión="1.0"
      Diseñador=""Fernando Garcia E."
      Programador="Jubitza Villanueva G."
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
       <Descripción>Mascara que reseta contraseña web del abonado</Descripción>
      <Parámetros>
         <Entrada>
            <param nom="EN_num_celular"     Tipo="NUMERICO">Secuencia nro del abonado</param>
         </Entrada>
         <Salida>
            <param nom="SN_cod_retorno"     Tipo="NUMERICO">Codigo de Retorno</param>
            <param nom="SV_mens_retorno"    Tipo="CARACTER">Mensaje de Retorno</param>
         </Salida>
      </Parámetros>
  </Elemento>
</Documentación>
*/
AS
    SN_num_evento  ge_errores_pg.Evento;
BEGIN
    ge_auditoria_pg.ge_agregaauditoria_pr( SN_num_transaccion, 'INICI', USER, NULL, 'num_celular =' || EN_num_celular || ' -- ' , 'SAI', 'ECU_0004', NULL, SN_cod_retornoau, SV_mens_retornoau, SN_num_eventoau);
    IF SN_cod_retornoau IS NULL THEN
	   GA_SERVICIOS_ABONADOS_PG.GA_DEFAULT_CLAVE_WEB_PR(EN_num_celular,
					 SN_cod_retorno,
					 SV_mens_retorno,
					 SN_num_evento);

	    ge_auditoria_pg.ge_modificaauditoria_pr( 'TERMI', SN_num_evento, SN_cod_retorno, SN_num_transaccion, NULL, NULL, SN_cod_retornoau, SV_mens_retornoau, SN_num_eventoau);
        IF SN_cod_retornoau IS NOT NULL THEN
            RAISE ERR_MOAUDITORIA;
        END IF;
    ELSE
        RAISE ERR_AGAUDITORIA;
    END IF;

    EXCEPTION

        WHEN ERR_AGAUDITORIA THEN
            SN_cod_retorno  := SN_cod_retornoau;
            SV_mens_retorno := SV_mens_retornoau;

        WHEN ERR_MOAUDITORIA  THEN
            SN_cod_retorno  := SN_cod_retornoau;
            SV_mens_retorno := SV_mens_retornoau;
END GA_DEFAULT_CLAVE_WEB_FS_PR;
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE GA_MODIFICA_DIRECCION_FS_PR (EN_num_celular    IN  ga_abocel.num_celular%TYPE,
                                     EV_cod_region       IN  ge_direcciones.cod_region%TYPE,
                                     EV_cod_provincia    IN  ge_direcciones.cod_provincia%TYPE,
                                     EV_cod_ciudad       IN  ge_direcciones.cod_ciudad%TYPE,
                                     EV_cod_comuna       IN  ge_direcciones.cod_comuna%TYPE,
                                     EV_nom_calle        IN  ge_direcciones.nom_calle%TYPE,
                                     EV_num_calle        IN  ge_direcciones.num_calle%TYPE,
                                     EV_num_piso         IN  ge_direcciones.num_piso%TYPE,
                                     EV_cod_postal       IN  ge_direcciones.zip%TYPE,
                                     EV_observacion      IN  ge_direcciones.obs_direccion%TYPE,
                                     EV_desdir1          IN  ge_direcciones.des_direc1%TYPE,
                                     EV_desdir2          IN  ge_direcciones.des_direc2%TYPE,
                                     EV_cod_tipdireccion IN  ge_tipdireccion.cod_tipdireccion%TYPE,
 									 SN_numos		     OUT NOCOPY   ci_orserv.num_os%TYPE,
								     SN_cod_retorno      OUT NOCOPY   ge_errores_pg.CodError,
								     SV_mens_retorno     OUT NOCOPY   ge_errores_pg.MsgError
                                     )
/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "GA_MODIFICA_DIRECCION_FS_PR"
      Lenguaje="PL/SQL"
      Fecha="30-04-2005"
      Versión="1.0"
      Diseñador=""Fernando Garcia E."
      Programador="Jubitza Villanueva G."
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
      <Descripción>Capa de negocio para servicio Actualización de dirección ECU-050050</Descripción>
      <Parámetros>
         <Entrada>
            <param nom="EN_num_celular" Tipo="NUMERICO">Numero de Celular</param>
            <param nom="EV_cod_region" Tipo="CARACTER">Codigo de Region</param>
            <param nom="EV_cod_provincia" Tipo="CARACTER">Codigo de Provincia</param>
            <param nom="EV_cod_cuidad" Tipo="CARACTER">Codigo de Cuidad</param>
            <param nom="EV_cod_comuna" Tipo="CARACTER">Codigo de Comuna</param>
            <param nom="EV_nom_calle" Tipo="CARACTER">Nombre de la Calle</param>
            <param nom="EV_num_calle" Tipo="CARACTER">Piso y departamento</param>
            <param nom="EV_num_piso" Tipo="CARACTER">Numero del Piso</param>
            <param nom="EV_cod_postal" Tipo="CARACTER">Numero del Piso</param>
            <param nom="EV_observacion" Tipo="CARACTER">Otros indicadores</param>
            <param nom="EV_desdir1" Tipo="CARACTER">Descripcion direccion 1</param>
            <param nom="EV_desdir2" Tipo="CARACTER">Descripcion direccion 2</param>
            <param nom="EV_cod_tipdireccion" Tipo="CARACTER">Código del tipo de direccion a modificar</param>
         </Entrada>
         <Salida>
            <param nom="SN_numos"     Tipo="Numerico">Orden de servicio generada</param>
            <param nom="SN_cod_retorno"     Tipo="NUMERICO">Codigo de Retorno</param>
            <param nom="SV_mens_retorno"    Tipo="CARACTER">Mensaje de Retorno</param>
         </Salida>
      </Parámetros>
  </Elemento>
</Documentación>
*/
AS
    SN_num_evento  ge_errores_pg.Evento;
BEGIN
	LV_param:='num_celular ='||EN_num_celular||',EV_cod_region='||EV_cod_region||
	          ',EV_cod_provincia='||EV_cod_provincia||
			  ',EV_cod_ciudad='||EV_cod_ciudad||
			  ',EV_cod_comuna='||EV_cod_comuna||
			  ',EV_nom_calle='||EV_nom_calle||
			  ',EV_num_calle='||EV_num_calle||
			  ',EV_num_piso='||EV_num_piso||
			  ',EV_cod_postal='||EV_cod_postal||
			  ',EV_observacion='||EV_observacion||
			  ',EV_desdir1='||EV_desdir1||
			  ',EV_desdir2='||EV_desdir2||
			  ',EV_cod_tipdireccion='||EV_cod_tipdireccion;
	LV_param:=SUBSTR(LV_param,1,1024);
    ge_auditoria_pg.ge_agregaauditoria_pr( SN_num_transaccion, 'INICI', USER, NULL, LV_param, 'SAI', 'ECU_0015', NULL, SN_cod_retornoau, SV_mens_retornoau, SN_num_eventoau);
    IF SN_cod_retornoau IS NULL THEN

	   GA_SERVICIOS_ABONADOS_PG.GA_MODIFICA_DIRECCION_PR (EN_num_celular,
	                 EV_cod_region,
					 EV_cod_provincia,
                     EV_cod_ciudad,
                     EV_cod_comuna,
                     EV_nom_calle,
                     EV_num_calle,
                     EV_num_piso,
                     EV_cod_postal,
                     EV_observacion,
                     EV_desdir1,
                     EV_desdir2,
					 EV_cod_tipdireccion,
					 SN_numos,
					 SN_cod_retorno,
                     SV_mens_retorno,
					 SN_num_evento);

	    ge_auditoria_pg.ge_modificaauditoria_pr( 'TERMI', SN_num_evento, SN_cod_retorno, SN_num_transaccion, NULL, NULL, SN_cod_retornoau, SV_mens_retornoau, SN_num_eventoau);
        IF SN_cod_retornoau IS NOT NULL THEN
            RAISE ERR_MOAUDITORIA;
        END IF;
    ELSE
        RAISE ERR_AGAUDITORIA;
    END IF;

    EXCEPTION

        WHEN ERR_AGAUDITORIA THEN
            SN_cod_retorno  := SN_cod_retornoau;
            SV_mens_retorno := SV_mens_retornoau;

        WHEN ERR_MOAUDITORIA  THEN
            SN_cod_retorno  := SN_cod_retornoau;
            SV_mens_retorno := SV_mens_retornoau;
END GA_MODIFICA_DIRECCION_FS_PR;
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE GA_CONS_DATOS_ABO_FS_PR   (EN_num_celular  IN          ga_abocel.num_celular%TYPE,
								  SN_num_abonado     OUT NOCOPY  ga_abocel.num_abonado%TYPE,
 								  SV_tip_plantarif   OUT NOCOPY  ga_abocel.tip_plantarif%TYPE,
								  SN_cod_categoria   OUT NOCOPY  ge_clientes.cod_categoria%TYPE,
								  SV_tip_terminal    OUT NOCOPY  ga_abocel.tip_terminal%TYPE,
 								  SV_cod_plantarif   OUT NOCOPY  ga_abocel.cod_plantarif%TYPE,
 								  SV_cod_valor       OUT NOCOPY  ge_valores_cli.cod_valor%TYPE,
 								  SV_des_valor       OUT NOCOPY  ge_valores_cli.des_valor%TYPE,
								  SV_cod_tiplan      OUT NOCOPY  ga_servicios_abonados_pg.codvalor,
								  SV_des_tiplan      OUT NOCOPY  ga_servicios_abonados_pg.desvalor,
								  SN_cod_retorno     OUT NOCOPY  ge_errores_pg.CodError,
								  SV_mens_retorno    OUT NOCOPY  ge_errores_pg.MsgError
                                  )
/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "GA_CONS_DATOS_ABO_FS_PR"
      Lenguaje="PL/SQL"
      Fecha="30-04-2005"
      Versión="1.0"
      Diseñador=""Fernando Garcia E."
      Programador="Jubitza Villanueva G."
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
      <Descripción>Capa de negocio que retorna datos de una cuenta</Descripción>
      <Parámetros>
         <Entrada>
            <param nom="EN_num_celular" Tipo="NUMERICO">Numero de Celular</param>
         </Entrada>
         <Salida>
            <param nom="SN_num_abonado"     Tipo="NUMERICO">Secuencia nro del abonado</param>
            <param nom="SV_tip_plantarif"   Tipo="CARACTER">Tipo de plan tarIFario</param>
            <param nom="SN_cod_categoria"     Tipo="NUMERICO">Categoria del Cliente</param>
            <param nom="SV_tip_terminal"    Tipo="CARACTER">Tipo de terminal</param>
            <param nom="SV_cod_plantarif"   Tipo="CARACTER">Codigo plan tarIFario</param>
            <param nom="SV_cod_valor"   Tipo="CARACTER">Código del valor de comportamiento del cliente</param>
            <param nom="SV_des_valor"   Tipo="CARACTER">Descripción del código del valor de comportamiento del cliente</param>
            <param nom="SV_cod_tiplan"   Tipo="CARACTER">Código del tipo de plan</param>
            <param nom="SV_des_tiplan"   Tipo="CARACTER">Descripción del tipo de plan</param>
            <param nom="SN_cod_retorno"   Tipo="NUMERICO">Codigo de Retorno</param>
            <param nom="SV_mens_retorno"  Tipo="CARACTER">Mensaje de Retorno</param>
         </Salida>
      </Parámetros>
  </Elemento>
</Documentación>
*/
AS
    SN_num_evento  ge_errores_pg.Evento;
BEGIN
    ge_auditoria_pg.ge_agregaauditoria_pr( SN_num_transaccion, 'INICI', USER, NULL, 'num_celular ='||EN_num_celular, 'SAI', 'ECU_0009', NULL, SN_cod_retornoau, SV_mens_retornoau, SN_num_eventoau);
    IF SN_cod_retornoau IS NULL THEN
	   GA_SERVICIOS_ABONADOS_PG.GA_CONS_DATOS_ABO_PR (EN_num_celular,
	                 SN_num_abonado,
					 SV_tip_plantarif,
                     SN_cod_categoria,
                     SV_tip_terminal,
                     SV_cod_plantarif,
					 SV_cod_valor,
					 SV_des_valor,
					 SV_cod_tiplan,
					 SV_des_tiplan,
                     SN_cod_retorno,
                     SV_mens_retorno,
					 SN_num_evento);
	    ge_auditoria_pg.ge_modificaauditoria_pr( 'TERMI', SN_num_evento, SN_cod_retorno, SN_num_transaccion, NULL, NULL, SN_cod_retornoau, SV_mens_retornoau, SN_num_eventoau);
        IF SN_cod_retornoau IS NOT NULL THEN
            RAISE ERR_MOAUDITORIA;
        END IF;
    ELSE
        RAISE ERR_AGAUDITORIA;
    END IF;

    EXCEPTION

        WHEN ERR_AGAUDITORIA THEN
            SN_cod_retorno  := SN_cod_retornoau;
            SV_mens_retorno := SV_mens_retornoau;

        WHEN ERR_MOAUDITORIA  THEN
            SN_cod_retorno  := SN_cod_retornoau;
            SV_mens_retorno := SV_mens_retornoau;
END GA_CONS_DATOS_ABO_FS_PR;

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
FUNCTION GA_VALIDA_SITUACION_ABO_FS_FN (EN_num_celular  IN      ga_abocel.num_celular%TYPE,
   		 						  EV_cod_situacion      IN      ga_abocel.cod_situacion%TYPE,
								  SN_cod_retorno     OUT NOCOPY   ge_errores_pg.CodError,
								  SV_mens_retorno    OUT NOCOPY   ge_errores_pg.MsgError
								  )
/*
<Documentación
  TipoDoc = "Funcion">
   <Elemento
      Nombre = "GA_VALIDA_SITUACION_ABO_FS_FN"
      Lenguaje="PL/SQL"
      Fecha="30-04-2005"
      Versión="1.0"
      Diseñador="Fernando Garcia"
      Programador="Jubitza Villanueva G."
      Ambiente Desarrollo="BD">
      <Retorno>BOOLEAN. TRUE si abonado esta en situacion consultada</Retorno>
      <Descripción>Mascara para Validar situacion del abonado</Descripción>
      <Parámetros>
         <Entrada>
            <param nom="EN_num_celular" Tipo="NUMERICO">Numero de Celular</param>
            <param nom="EV_cod_situacion"    Tipo="CARACTER">Situacion a validar</param>
         </Entrada>
         <Salida>
            <param nom="SN_cod_retorno"       Tipo="NUMERICO">Codigo de Retorno</param>
            <param nom="SV_mens_retorno"      Tipo="CARACTER">Mensaje de Retorno</param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
RETURN  BOOLEAN
AS
    SN_num_evento  ge_errores_pg.Evento;
	berror		   BOOLEAN;
BEGIN
	berror:=TRUE;
    ge_auditoria_pg.ge_agregaauditoria_pr( SN_num_transaccion, 'INICI', USER, NULL, 'num_celular ='||EN_num_celular||',EV_cod_situacion='||EV_cod_situacion, 'SAI', 'ECU_0010', NULL, SN_cod_retornoau, SV_mens_retornoau, SN_num_eventoau);
    IF SN_cod_retornoau IS NULL THEN
	   IF NOT GE_VALIDACIONES_PG.ge_valida_situacion_abo_fn(
	   		         EN_num_celular,
	                 EV_cod_situacion,
                     SN_cod_retorno,
                     SV_mens_retorno,
					 SN_num_evento) THEN
		  berror:=FALSE;
	   END IF;
	   ge_auditoria_pg.ge_modificaauditoria_pr( 'TERMI', SN_num_evento, SN_cod_retorno, SN_num_transaccion, NULL, NULL, SN_cod_retornoau, SV_mens_retornoau, SN_num_eventoau);
       IF SN_cod_retornoau IS NOT NULL THEN
            RAISE ERR_MOAUDITORIA;
       END IF;
    ELSE
        RAISE ERR_AGAUDITORIA;
    END IF;

	IF NOT berror THEN
	   RETURN FALSE;
	ELSE
	  RETURN TRUE;
	END IF;

    EXCEPTION

        WHEN ERR_AGAUDITORIA THEN
            SN_cod_retorno  := SN_cod_retornoau;
            SV_mens_retorno := SV_mens_retornoau;
			RETURN FALSE;
        WHEN ERR_MOAUDITORIA  THEN
            SN_cod_retorno  := SN_cod_retornoau;
            SV_mens_retorno := SV_mens_retornoau;
			RETURN FALSE;
END  GA_VALIDA_SITUACION_ABO_FS_FN;
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE GA_CONS_DAT_TERMINAL_ABO_FS_PR (EN_num_celular IN  ga_abocel.num_celular%TYPE,
								  SV_num_min             OUT NOCOPY  ga_abocel.num_min%TYPE,
								  SV_esn 			  	 OUT NOCOPY  ga_abocel.num_serie%TYPE,
								  SV_imsi             	 OUT NOCOPY  ga_abocel.num_imei%TYPE,
								  SV_des_tipident     	 OUT NOCOPY  ge_tipident.des_tipident%TYPE,
								  SV_num_ident        	 OUT NOCOPY  ge_clientes.num_ident%TYPE,
 								  SV_cod_tipident     	 OUT NOCOPY  ge_clientes.cod_tipident%TYPE,
								   SN_cod_retorno     OUT NOCOPY   ge_errores_pg.CodError,
								   SV_mens_retorno    OUT NOCOPY   ge_errores_pg.MsgError
                                  )
/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "GA_CONS_DAT_TERMINAL_ABO_FS_PR"
      Lenguaje="PL/SQL"
      Fecha="30-04-2005"
      Versión="1.0"
      Diseñador=""Fernando Garcia E."
      Programador="Jubitza Villanueva G."
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
      <Descripción>Mascara que consulta datos del terminal e identificacion de un cliente</Descripción>
      <Parámetros>
         <Entrada>
            <param nom="EN_num_celular" Tipo="NUMERICO">Numero de Celular</param>
         </Entrada>
         <Salida>
            <param nom="SV_num_min     Tipo="CARACTER">Numero min</param>
            <param nom="SV_esn"   Tipo="CARACTER">Serie del terminal / simcard</param>
            <param nom="SV_imsi"     Tipo="CARACTER">Serie del terminal GSM</param>
            <param nom="SV_des_tipident"    Tipo="CARACTER">Descripción tipo de identIFicación</param>
            <param nom="SV_num_ident"   Tipo="CARACTER">Número de identIFicación</param>
            <param nom="SV_cod_tipident"   Tipo="CARACTER">Código de identIFicación</param>
            <param nom="SN_cod_retorno"   Tipo="NUMERICO">Codigo de Retorno</param>
            <param nom="SV_mens_retorno"  Tipo="CARACTER">Mensaje de Retorno</param>
         </Salida>
      </Parámetros>
 </Elemento>
</Documentación>
*/
AS
    SN_num_evento  ge_errores_pg.Evento;
BEGIN
    ge_auditoria_pg.ge_agregaauditoria_pr( SN_num_transaccion, 'INICI', USER, NULL, 'num_celular ='||EN_num_celular, 'SAI', 'ECU_0012', NULL, SN_cod_retornoau, SV_mens_retornoau, SN_num_eventoau);
    IF SN_cod_retornoau IS NULL THEN
	   GA_SERVICIOS_ABONADOS_PG.GA_CONS_DAT_TERMINAL_ABO_PR (EN_num_celular,
	                 SV_num_min,
					 SV_esn,
                     SV_imsi,
                     SV_des_tipident,
                     SV_num_ident,
					 SV_cod_tipident,
                     SN_cod_retorno,
                     SV_mens_retorno,
					 SN_num_evento);
	    ge_auditoria_pg.ge_modificaauditoria_pr( 'TERMI', SN_num_evento, SN_cod_retorno, SN_num_transaccion, NULL, NULL, SN_cod_retornoau, SV_mens_retornoau, SN_num_eventoau);
        IF SN_cod_retornoau IS NOT NULL THEN
            RAISE ERR_MOAUDITORIA;
        END IF;
    ELSE
        RAISE ERR_AGAUDITORIA;
    END IF;

    EXCEPTION

        WHEN ERR_AGAUDITORIA THEN
            SN_cod_retorno  := SN_cod_retornoau;
            SV_mens_retorno := SV_mens_retornoau;

        WHEN ERR_MOAUDITORIA  THEN
            SN_cod_retorno  := SN_cod_retornoau;
            SV_mens_retorno := SV_mens_retornoau;
END GA_CONS_DAT_TERMINAL_ABO_FS_PR;
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE GA_ACTIVA_PREPAGO_FS_PR (EN_num_celular     IN    ga_abocel.num_celular%TYPE,
                                 EV_cod_provincia  IN    ge_direcciones.cod_provincia%TYPE,
 		  						 EV_cod_region     IN    ge_direcciones.cod_region%TYPE,
                                 EV_cod_ciudad     IN    ge_direcciones.cod_ciudad%TYPE,
                                 EV_cod_comuna     IN    ge_direcciones.cod_comuna%TYPE,
                                 EV_nom_calle      IN    ge_direcciones.nom_calle%TYPE,
                                 EV_num_calle      IN    ge_direcciones.num_calle%TYPE,
                                 EV_num_piso       IN    ge_direcciones.num_piso%TYPE,
                                 EV_num_casilla    IN    ge_direcciones.num_casilla%TYPE,
                                 EV_obs_direccion  IN    ge_direcciones.obs_direccion%TYPE,
                                 EV_des_direc1     IN    ge_direcciones.des_direc1%TYPE,
                                 EV_des_direc2     IN    ge_direcciones.des_direc2%TYPE,
                                 EV_cod_pueblo     IN    ge_direcciones.cod_pueblo%TYPE,
                                 EV_cod_estado     IN    ge_direcciones.cod_estado%TYPE,
 								 EV_cod_tipident   IN        ge_clientes.cod_tipident%TYPE,
								 EV_num_ident      IN OUT    ge_clientes.num_ident%TYPE,
								 EV_nom_cliente    IN    ge_clientes.nom_cliente%TYPE,
								 EV_nom_apeclien1  IN    ge_clientes.nom_apeclien1%TYPE,
								 EV_nom_apeclien2  IN    ge_clientes.nom_apeclien2%TYPE,
								 SC_numos		   OUT NOCOPY    refcursor,
								 SN_cod_retorno    OUT NOCOPY    ge_errores_pg.CodError,
								 SV_mens_retorno   OUT NOCOPY    ge_errores_pg.MsgError
                                  )

/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "GA_ACTIVA_PREPAGO_FS_PR"
      Lenguaje="PL/SQL"
      Fecha="30-04-2005"
      Versión="1.0"
      Diseñador=""Fernando Garcia E."
      Programador="Jubitza Villanueva G."
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
      <Descripción> Mascara para activacion de abonado prepago.../Descripción>
      <Parámetros>
         <Entrada>
            <param nom="EN_num_celular" Tipo="NUMERICO">Numero de Celular</param>
            <param nom="EV_cod_provincia" Tipo="CARACTER">Codigo de Provincia</param>
            <param nom="EV_cod_region" Tipo="CARACTER">Codigo de Region</param>
            <param nom="EV_cod_cuidad" Tipo="CARACTER">Codigo de Cuidad</param>
            <param nom="EV_cod_comuna" Tipo="CARACTER">Codigo de Comuna</param>
            <param nom="EV_nom_calle" Tipo="CARACTER">Nombre de la Calle</param>
            <param nom="EV_num_calle" Tipo="CARACTER">Piso y departamento</param>
            <param nom="EV_num_piso" Tipo="CARACTER">Numero del Piso</param>
            <param nom="EV_num_casilla" Tipo="CARACTER">Numero de la casilla</param>
            <param nom="EV_obs_direccion" Tipo="CARACTER">Otros indicadores</param>
            <param nom="EV_des_direc1" Tipo="CARACTER">Descripcion direccion 1</param>
            <param nom="EV_des_direc2" Tipo="CARACTER">Descripcion direccion 2</param>
            <param nom="EV_cod_pueblo" Tipo="CARACTER">Codigo de pueblo</param>
			<param nom="EV_cod_estado" Tipo="CARACTER">Codigo de estado</param>
            <param nom="EV_cod_tipident"   Tipo="CARACTER">Código de identIFicación</param>
            <param nom="EV_num_ident"   Tipo="CARACTER">Número de identIFicación</param>
            <param nom="EV_nom_cliente"    Tipo="CARACTER">Nombre de Cliente</param>
            <param nom="EV_nom_apeclien1"    Tipo="CARACTER">Primer apellido</param>
            <param nom="EV_nom_apeclien2"    Tipo="CARACTER">Segundo apellido</param>
         </Entrada>
         <Salida>
            <param nom="SC_numos"     Tipo="CURSOR">Cursor de ordenes de servicio generadas</param>
            <param nom="SN_cod_retorno"     Tipo="NUMERICO">Codigo de Retorno</param>
            <param nom="SV_mens_retorno"    Tipo="CARACTER">Mensaje de Retorno</param>
         </Salida>
      </Parámetros>
 </Elemento>
</Documentación>
*/
AS
    SN_num_evento  ge_errores_pg.Evento;
BEGIN
	LV_param:='num_celular ='||EN_num_celular||',EV_cod_region='||EV_cod_region||
	          ',EV_cod_provincia='||EV_cod_provincia||
			  ',EV_cod_ciudad='||EV_cod_ciudad||
			  ',EV_cod_comuna='||EV_cod_comuna||
			  ',EV_nom_calle='||EV_nom_calle||
			  ',EV_num_calle='||EV_num_calle||
			  ',EV_num_piso='||EV_num_piso||
			  ',EV_num_casilla='||EV_num_casilla||
			  ',EV_obs_direccion='||EV_obs_direccion||
			  ',EV_des_direc1='||EV_des_direc1||
			  ',EV_des_direc2='||EV_des_direc2||
			  ',EV_cod_pueblo='||EV_cod_pueblo||
			  ',EV_cod_estado='||EV_cod_estado||
			  ',EV_cod_tipident='||EV_cod_tipident||
			  ',EV_num_ident='||EV_num_ident||
			  ',EV_nom_cliente='||EV_nom_cliente||
			  ',EV_nom_apeclien1='||EV_nom_apeclien1||
			  ',EV_nom_apeclien2='||EV_nom_apeclien2;
	LV_param:=SUBSTR(LV_param,1,1024);
    ge_auditoria_pg.ge_agregaauditoria_pr( SN_num_transaccion, 'INICI', USER, NULL, LV_param, 'SAI', 'ECU_0014', NULL, SN_cod_retornoau, SV_mens_retornoau, SN_num_eventoau);
    IF SN_cod_retornoau IS NULL THEN
	   GA_SERVICIOS_ABONADOS_PG.GA_ACTIVA_PREPAGO_PR (EN_num_celular,
					 EV_cod_provincia,
	                 EV_cod_region,
                     EV_cod_ciudad,
                     EV_cod_comuna,
                     EV_nom_calle,
                     EV_num_calle,
                     EV_num_piso,
					 EV_num_casilla,
					 EV_obs_direccion,
                     EV_des_direc1,
                     EV_des_direc2,
                     EV_cod_pueblo,
                     EV_cod_estado,
 					 EV_cod_tipident,
					 EV_num_ident,
					 EV_nom_cliente,
					 EV_nom_apeclien1,
					 EV_nom_apeclien2,
					 SC_numos,
                     SN_cod_retorno,
                     SV_mens_retorno,
					 SN_num_evento);

	    ge_auditoria_pg.ge_modificaauditoria_pr( 'TERMI', SN_num_evento, SN_cod_retorno, SN_num_transaccion, NULL, NULL, SN_cod_retornoau, SV_mens_retornoau, SN_num_eventoau);
        IF SN_cod_retornoau IS NOT NULL THEN
            RAISE ERR_MOAUDITORIA;
        END IF;
    ELSE
        RAISE ERR_AGAUDITORIA;
    END IF;

    EXCEPTION

        WHEN ERR_AGAUDITORIA THEN
            SN_cod_retorno  := SN_cod_retornoau;
            SV_mens_retorno := SV_mens_retornoau;

        WHEN ERR_MOAUDITORIA  THEN
            SN_cod_retorno  := SN_cod_retornoau;
            SV_mens_retorno := SV_mens_retornoau;
END GA_ACTIVA_PREPAGO_FS_PR;

END GA_SERVICIOS_ABONADOS_FS_PG;
/
SHOW ERRORS