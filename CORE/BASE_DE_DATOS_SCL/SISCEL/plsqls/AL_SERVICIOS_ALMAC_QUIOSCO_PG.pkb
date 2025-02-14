CREATE OR REPLACE PACKAGE BODY al_servicios_almac_quiosco_pg IS
   PROCEDURE al_consulta_articulo_pr (
      en_cod_articulo       IN              al_articulos.cod_articulo%TYPE,
      sn_tip_articulo       OUT NOCOPY      al_articulos.tip_articulo%TYPE,
      sv_des_articulo       OUT NOCOPY      al_articulos.des_articulo%TYPE,
      sn_cod_conceptoart    OUT NOCOPY      al_articulos.cod_conceptoart%TYPE,
      sv_codconceptodscto   OUT NOCOPY      VARCHAR2,
	  sv_tip_terminal       OUT NOCOPY      al_articulos.tip_terminal%TYPE,
      sn_cod_retorno        OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno       OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento         OUT NOCOPY      ge_errores_pg.evento) IS
      lv_sql                ge_errores_pg.vquery;
      lv_des_error          ge_errores_pg.desevent;
   /*--
   <Documentacion TipoDoc = "Procedimiento">
      Elemento Nombre = "AL_consulta_articulo_PR"
      Lenguaje="PL/SQL"
      Fecha="05/07/2007"
      Version="1.0.0"
      Dise?ador="Hector Hermosilla"
      Programador="Hector Hermosilla
      Ambiente="BD"
   <Retorno>NA</Retorno>
   <Descripcion>
      Consulta articulo
   </Descripcion>
   <Parametros>
   <Entrada>
      <param nom="EN_cod_articulo"    Tipo="NUMBER> código articulo</param>
   </Entrada>
   <Salida>
       <param nom="SN_tip_articulo"    Tipo="NUMBER"> tipo articulo </param>
      <param nom="SV_des_articulo"    Tipo="STRING"> descripcion articulo </param>
      <param nom="SN_cod_conceptoart" Tipo="NUMBER"> código concepto artículo </param>
      <param nom="SN_cod_retorno"     Tipo="NUMBER"> codigo retorno </param>
      <param nom="SV_mens_retorno"    Tipo="STRING"> glosa mensaje error </param>
      <param nom="SN_num_evento"      Tipo="NUMBER"> numero de evento </param>
   </Salida>
   </Parametros>
   </Elemento>
   </Documentacion>
   --*/
   BEGIN
      sn_num_evento   := 0;
      sn_cod_retorno  := 0;
      sv_mens_retorno := '';

      lv_sql := 'SELECT articulo.tip_articulo, articulo.des_articulo,articulo.cod_conceptoart,articulo.cod_conceptodto'
             || ' FROM   al_articulos articulo'
             || ' WHERE articulo.cod_articulo = ' || en_cod_articulo;

      SELECT articulo.tip_articulo, articulo.des_articulo, articulo.cod_conceptoart, articulo.cod_conceptodto, articulo.tip_terminal 
        INTO sn_tip_articulo, sv_des_articulo, sn_cod_conceptoart, sv_codconceptodscto, sv_tip_terminal
        FROM al_articulos articulo
       WHERE articulo.cod_articulo = en_cod_articulo;

   EXCEPTION
      WHEN NO_DATA_FOUND THEN
         sn_cod_retorno := 10012;
         sv_mens_retorno := 'Problemas al recuperar datos del artículo';

         lv_des_error := 'NO_DATA_FOUND:al_servicios_almac_quiosco_pg.VE_consulta_articulo_PR(' || en_cod_articulo || ');- ' || SQLERRM;
         sn_num_evento := ge_errores_pg.grabarpl (sn_num_evento, cv_modulo_ga, sv_mens_retorno, '1.0', USER, 'al_servicios_almac_quiosco_pg.VE_consulta_articulo_PR(' || en_cod_articulo || ')', lv_sql, SQLCODE, lv_des_error);

    WHEN OTHERS THEN
         sn_cod_retorno := 10500;
         sv_mens_retorno :='Error al consultar Articulo';

         lv_des_error := 'OTHERS:al_servicios_almac_quiosco_pg.VE_consulta_articulo_PR(' || en_cod_articulo || ');- ' || SQLERRM;
         sn_num_evento := ge_errores_pg.grabarpl (sn_num_evento, cv_modulo_ga, sv_mens_retorno, '1.0', USER, 'al_servicios_almac_quiosco_pg.VE_consulta_articulo_PR(' || en_cod_articulo || ')', lv_sql, SQLCODE, lv_des_error);
   END al_consulta_articulo_pr;
           
END al_servicios_almac_quiosco_pg;
/
SHOW ERRORS
