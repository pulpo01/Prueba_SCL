CREATE OR REPLACE PACKAGE GE_CARTA_PG
/*
<Documentación TipoDoc = "Package">
   <Elemento Nombre = "GE_CARTA_PG"
          Lenguaje="PL/SQL"
          Fecha="13-08-2007"
          Versión="1.0"
          Diseñador= "Marcelo Godoy"
        Programador="Marcelo Godoy"
          Ambiente Desarrollo="BD">
      <Descripción>Package servicios base para dirección</Descripción>
  </Elemento>
</Documentación>
*/
IS
   TYPE refcursor IS REF CURSOR;

   cv_error_no_clasif   CONSTANT VARCHAR2 (50)
                                       := 'No es posible clasificar el error';
   cv_cod_modulo        CONSTANT VARCHAR2 (2)  := 'GE';
   cv_version           CONSTANT VARCHAR2 (2)  := '1';

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   PROCEDURE ge_val_exit_carta_pr (
      EV_cod_os   	    IN              ci_tipcartas.cod_os%TYPE,
	  can_reg           OUT             NUMBER,
      sn_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento
   );

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   PROCEDURE ge_recupera_carta_pr (
      so_carta_10060    IN              ge_carta_10060_qt,
	  SV_TEXTO_CARTA	OUT NOCOPY      ci_tipcartas.texto%TYPE,
      sn_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento
   );
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   PROCEDURE ge_recupera_carta_pr (
      so_carta_10231    IN              ge_carta_10231_qt,
	  SV_TEXTO_CARTA	OUT NOCOPY      ci_tipcartas.texto%TYPE,
      sn_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento
   );
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   PROCEDURE ge_recupera_carta_pr (
      so_carta_10020    IN              ge_carta_10020_qt,
	  sv_texto_carta	OUT NOCOPY 		ci_tipcartas.texto%TYPE,
      sn_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento
   );
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   PROCEDURE ge_recupera_carta_pr (
      so_carta_10022    IN              ge_carta_10022_qt,
	  sv_texto_carta	OUT NOCOPY 		ci_tipcartas.texto%TYPE,
      sn_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento
   );
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   PROCEDURE ge_recupera_carta_pr (
      so_carta_10034    IN              ge_carta_10034_qt,
	  sv_texto_carta	OUT NOCOPY 		ci_tipcartas.texto%TYPE,
      sn_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento
   );
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   PROCEDURE ge_recupera_carta_pr (
      so_carta_10233    IN              ge_carta_10233_qt,
	  sv_texto_carta	OUT NOCOPY 		ci_tipcartas.texto%TYPE,
      sn_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento
   );
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   PROCEDURE ge_recupera_carta_pr (
      so_carta_10508    IN              ge_carta_10508_qt,
	  sv_texto_carta	OUT NOCOPY 		ci_tipcartas.texto%TYPE,
      sn_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento
   );
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   PROCEDURE ge_recupera_carta_pr (
      so_carta_10530    IN              ge_carta_10530_qt,
	  sv_texto_carta	OUT NOCOPY 		ci_tipcartas.texto%TYPE,
      sn_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento
   );
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   PROCEDURE ge_recupera_carta_pr (
      so_carta_10539    IN              ge_carta_10539_qt,
	  sv_texto_carta	OUT NOCOPY 		ci_tipcartas.texto%TYPE,
      sn_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento
   );
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   PROCEDURE ge_recupera_carta_pr (
      so_carta_10541    IN              ge_carta_10541_qt,
	  sv_texto_carta	OUT NOCOPY 		ci_tipcartas.texto%TYPE,
      sn_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento
   );

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   PROCEDURE ge_recupera_carta_pr (
      so_carta_10120    IN              ge_carta_10120_qt,
	  SV_TEXTO_CARTA	OUT NOCOPY      ci_tipcartas.texto%TYPE,
      sn_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento
   );
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   PROCEDURE ge_recupera_carta_pr (
      EO_carta_40009    IN              ge_carta_40009_qt,
	  SV_TEXTO_CARTA	OUT NOCOPY      ci_tipcartas.texto%TYPE,
      sn_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento
   );
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
END GE_CARTA_PG;
/
SHOW ERRORS
