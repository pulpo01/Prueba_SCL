CREATE OR REPLACE PACKAGE BODY              "GA_TRAFICO_FS_PG" IS

SN_cod_retornoau   ge_errores_pg.CodError;
SV_mens_retornoau  ge_errores_pg.MsgError;
SN_num_eventoau    ge_errores_pg.Evento;
SN_num_transaccion ge_auditoria_to.num_ticket%TYPE;
LV_param	   VARCHAR2(4000);

ERR_MOAUDITORIA    EXCEPTION;
ERR_AGAUDITORIA    EXCEPTION;
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE GA_DET_LLAMADA_LDI_FS_PR (EN_num_celular   IN         ga_abocel.num_celular%TYPE,
                                     SN_unidades      OUT NOCOPY NUMBER,
                            		 SD_datem   	  OUT NOCOPY DATE,
                            		 SN_cod_retorno   OUT NOCOPY ge_errores_pg.CodError,
                              		 SV_mens_retorno  OUT NOCOPY ge_errores_pg.MsgError
)
/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "GA_DET_LLAMADA_LDI_FS_PR"
      Lenguaje="PL/SQL"
      Fecha="09-05-2005"
      Versión="1.0"
      Diseñador=""Fernando Garcia E."
      Programador="Jubitza Villanueva G."
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
      <Descripción>Mascara que consulta cantidad de minutos consumidos de larga distancia</Descripción>
      <Parámetros>
         <Entrada>
            <param nom="EN_num_celular" Tipo="NUMERICO">Numero de Celular</param>
         </Entrada>
         <Salida>
            <param nom="SN_unidades" Tipo="NUMERICO">Total de unidades consultadas</param>
            <param nom="SD_datem" Tipo="FECHA">Fecha XXX</param>
            <param nom="SN_cod_retorno"   Tipo="NUMERICO">Codigo de Retorno</param>
            <param nom="SV_mens_retorno"  Tipo="CARACTER">Mensaje de Retorno</param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/AS
    SN_num_evento  ge_errores_pg.Evento;
BEGIN
    /*ge_auditoria_pg.ge_agregaauditoria_pr( SN_num_transaccion, 'INICI', USER, NULL, 'num_celular=' || EN_num_celular, 'SAI', 'ECU_0006', NULL, SN_cod_retornoau, SV_mens_retornoau, SN_num_eventoau);
    IF SN_cod_retornoau IS NULL THEN
    */
	   GA_TRAFICO_PG.GA_DET_LLAMADA_LDI_PR(EN_num_celular,
					 SN_unidades,
					 SD_datem,
					 SN_cod_retorno,
					 SV_mens_retorno,
					 SN_num_evento);

	    /*ge_auditoria_pg.ge_modificaauditoria_pr( 'TERMI', SN_num_evento, SN_cod_retorno, SN_num_transaccion, NULL, NULL, SN_cod_retornoau, SV_mens_retornoau, SN_num_eventoau);
        IF SN_cod_retornoau IS NOT NULL THEN
            RAISE ERR_MOAUDITORIA;
        END IF;
    ELSE
        RAISE ERR_AGAUDITORIA;
    END IF;
    */
    EXCEPTION

        WHEN ERR_AGAUDITORIA THEN
            SN_cod_retorno  := SN_cod_retornoau;
            SV_mens_retorno := SV_mens_retornoau;

        WHEN ERR_MOAUDITORIA  THEN
            SN_cod_retorno  := SN_cod_retornoau;
            SV_mens_retorno := SV_mens_retornoau;
END GA_DET_LLAMADA_LDI_FS_PR;
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE GA_DET_LLAMADA_FF_FS_PR(EN_num_celular   IN         ga_abocel.num_celular%TYPE,
                                   SN_unidades      OUT NOCOPY NUMBER,
				   				   SN_cod_retorno   OUT NOCOPY ge_errores_pg.CodError,
				   				   SV_mens_retorno  OUT NOCOPY ge_errores_pg.MsgError
)
/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "GA_DET_LLAMADA_FF_FS_PR"
      Lenguaje="PL/SQL"
      Fecha="09-05-2005"
      Versión="1.0"
      Diseñador=""Fernando Garcia E."
      Programador="Jubitza Villanueva G."
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
      <Descripción>MAscara que consulta minutos de F consumidos</Descripción>
      <Parámetros>
         <Entrada>
            <param nom="EN_num_celular" Tipo="NUMERICO">Numero de Celular</param>
         </Entrada>
         <Salida>
            <param nom="SN_unidades" Tipo="NUMERICO">Total de unidades consultadas</param>
            <param nom="SN_cod_retorno"   Tipo="NUMERICO">Codigo de Retorno</param>
            <param nom="SV_mens_retorno"  Tipo="CARACTER">Mensaje de Retorno</param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/AS
    SN_num_evento  ge_errores_pg.Evento;
BEGIN
    /*ge_auditoria_pg.ge_agregaauditoria_pr( SN_num_transaccion, 'INICI', USER, NULL, 'num_celular =' || EN_num_celular , 'SAI', 'ECU_0007', NULL, SN_cod_retornoau, SV_mens_retornoau, SN_num_eventoau);
    IF SN_cod_retornoau IS NULL THEN
    */
	   GA_TRAFICO_PG.GA_DET_LLAMADA_FF_PR(EN_num_celular,
					 SN_unidades,
					 SN_cod_retorno,
					 SV_mens_retorno,
					 SN_num_evento);

	    /*ge_auditoria_pg.ge_modificaauditoria_pr( 'TERMI', SN_num_evento, SN_cod_retorno, SN_num_transaccion, NULL, NULL, SN_cod_retornoau, SV_mens_retornoau, SN_num_eventoau);
        IF SN_cod_retornoau IS NOT NULL THEN
            RAISE ERR_MOAUDITORIA;
        END IF;
    ELSE
        RAISE ERR_AGAUDITORIA;
    END IF;
    */
    EXCEPTION

        WHEN ERR_AGAUDITORIA THEN
            SN_cod_retorno  := SN_cod_retornoau;
            SV_mens_retorno := SV_mens_retornoau;

        WHEN ERR_MOAUDITORIA  THEN
            SN_cod_retorno  := SN_cod_retornoau;
            SV_mens_retorno := SV_mens_retornoau;
END GA_DET_LLAMADA_FF_FS_PR;
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE GA_DET_FRANJA_FS_PR (EN_num_celular  IN           ga_abocel.num_celular%TYPE,
                				SC_min_hor	    OUT NOCOPY   refcursor,
                				SC_min_tip_dia  OUT NOCOPY   refcursor,
                				SN_plan_min_lib OUT NOCOPY   NUMBER,
                				SN_usado	  	OUT NOCOPY   NUMBER,
                				SN_nousado	  	OUT NOCOPY   NUMBER,
                				SD_fec_corte	OUT NOCOPY   DATE,
                				SN_ind_planesp	OUT NOCOPY   NUMBER,
                				SN_valor		OUT NOCOPY   NUMBER,
                				SN_Bs2bs		OUT NOCOPY   NUMBER,
                				SC_min_planesp	OUT NOCOPY   refcursor,
                				SN_cod_retorno  OUT NOCOPY   ge_errores_pg.CodError,
                				SV_mens_retorno OUT NOCOPY   ge_errores_pg.MsgError
)
/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "GA_DET_FRANJA_FS_PR"
      Lenguaje="PL/SQL"
      Fecha="16-05-2005"
      Versión="1.0"
      Diseñador=""Fernando Garcia E."
      Programador="Jubitza Villanueva G."
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
       <Descripción>Mascara que consulta minutos consumidos segun franja horaria</Descripción>
      <Parámetros>
         <Entrada>
            <param nom="EN_num_celular"     Tipo="NUMERICO">Secuencia nro del abonado</param>
         </Entrada>
         <Salida>
            <param nom="SN_peak"     Tipo="NUMERICO">Minutos consumidos en horario de mayor demanda</param>
            <param nom="SN_nopeak"     Tipo="NUMERICO">Minutos consumidos en horario no correspondiente al de mayor demanda</param>
            <param nom="SN_weekend"     Tipo="NUMERICO">Minutos consumidos en horario fin de semana</param>
            <param nom="SN_nigth"     Tipo="NUMERICO">Minutos consumidos en horario nocturno</param>
            <param nom="SN_other"     Tipo="NUMERICO">Minutos consumidos en otras franjas horarias no correspondientes a SN_peak, SN_nopeak, SN_weekend y SN_nigth</param>
            <param nom="SN_plan_min_lib"     Tipo="NUMERICO">Cantidad de minutos libres del plan tarifario del abonado</param>
            <param nom="SN_usado"     Tipo="NUMERICO">Cantidad de minutos libres consumidos</param>
            <param nom="SN_nousado"     Tipo="NUMERICO">Cantidad de minutos libres no consumidos</param>
            <param nom="SD_fec_corte"     Tipo="FECHA">Fecha de la última llamada que es dato de las estadísticas retornadas por el servicio</param>
            <param nom="SN_pac_group"     Tipo="NUMERICO">Indicador que dice si el abonado posee el plan "Mi Plan", 0 indica que no posee el plan, distinto de cero indica que lo tiene</param>
            <param nom="SN_valor"     Tipo="NUMERICO">Minutos libres del plan "Mi Plan", si SN_ind_planesp es distinto de cero</param>
            <param nom="SN_Bs2bs"     Tipo="NUMERICO">Cantidad de mínutos libres consumidos intrared. Se asume como operadora origen y destino Movistar</param>
            <param nom="SN_pico"     Tipo="NUMERICO">si SN_ind_planesp es distinto de cero corresponde a la cantidad de minutos consumidos en horario de mayor demanda con plan "Mi Plan"</param>
            <param nom="SN_nopico"     Tipo="NUMERICO">si SN_ind_planesp es distinto de cero corresponde a la cantidad de minutos consumidos en horario no correspondiente al de mayor demanda con plan "Mi Plan"</param>
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
    /*ge_auditoria_pg.ge_agregaauditoria_pr( SN_num_transaccion, 'INICI', USER, NULL, 'num_celular =' || EN_num_celular || ' -- ' , 'SAI', 'ECU_0008', NULL, SN_cod_retornoau, SV_mens_retornoau, SN_num_eventoau);
    IF SN_cod_retornoau IS NULL THEN
    */
	   GA_TRAFICO_PG.GA_DET_FRANJA_PR(EN_num_celular,
                				SC_min_hor,
                				SC_min_tip_dia,
                				SN_plan_min_lib,
                				SN_usado,
                				SN_nousado,
                				SD_fec_corte,
                				SN_ind_planesp,
                				SN_valor,
                				SN_Bs2bs,
                				SC_min_planesp,
                				SN_cod_retorno,
                				SV_mens_retorno,
					    		SN_num_evento);

	    /*ge_auditoria_pg.ge_modificaauditoria_pr( 'TERMI', SN_num_evento, SN_cod_retorno, SN_num_transaccion, NULL, NULL, SN_cod_retornoau, SV_mens_retornoau, SN_num_eventoau);
        IF SN_cod_retornoau IS NOT NULL THEN
            RAISE ERR_MOAUDITORIA;
        END IF;
    ELSE
        RAISE ERR_AGAUDITORIA;
    END IF;
    */
    EXCEPTION

        WHEN ERR_AGAUDITORIA THEN
            SN_cod_retorno  := SN_cod_retornoau;
            SV_mens_retorno := SV_mens_retornoau;

        WHEN ERR_MOAUDITORIA  THEN
            SN_cod_retorno  := SN_cod_retornoau;
            SV_mens_retorno := SV_mens_retornoau;
END GA_DET_FRANJA_FS_PR;
END GA_TRAFICO_FS_PG;
/
SHOW ERRORS
