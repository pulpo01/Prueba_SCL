CREATE OR REPLACE PACKAGE          "GA_TRAMA_PG" /*
<Documentación
   TipoDoc = "Package">
   <Elemento
       Nombre = "GA_TRAMA_PG"
       Lenguaje="PL/SQL"
       Fecha="18-06-2005"
       Versión="1.0"
       Diseñador="Carlos Navarro H. - Marcelo Godoy S."
       Programador="Marcelo Godoy S. - Carlos Navarro H."
       Ambiente Desarrollo="BD">
       <Retorno>NA</Retorno>
       <Descripción>Package negocio de llamada a servicios IVR</Descripción>
       <Parámetros>
          <Entrada>NA</Entrada>
          <Salida>NA</Salida>
       </Parámetros>
    </Elemento>
   </Documentación>
*/

IS
   CV_error_no_clasif   CONSTANT VARCHAR2 (30) := 'Error no clasificado';
   CN_largoquery        CONSTANT NUMBER        := 3000;
   CN_largoerrtec       CONSTANT NUMBER        := 500;
   CN_largodesc         CONSTANT NUMBER        := 1000;
   CN_abonadobaja       CONSTANT VARCHAR2 (3)  := 'BAA';
   nonulo               CONSTANT VARCHAR2 (1)  := '';
   CN_consecutivo       CONSTANT VARCHAR2 (4)  := '0000';

   CV_ACTIVADO CONSTANT VARCHAR2(11):= 'ACTIVADO';
   CV_DESACTIVADO CONSTANT VARCHAR2(11):= 'DESACTIVADO';

FUNCTION ga_error_desborde_fn(SV_IND_OVERFLOW     OUT NOCOPY VARCHAR2
							  ,SN_COD_RETORNO  OUT NOCOPY NUMBER
							  ,SV_MENS_RETORNO OUT NOCOPY VARCHAR2
							  ,SN_NUM_EVENTO   OUT NOCOPY NUMBER
							  )
							  RETURN BOOLEAN;
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   PROCEDURE ga_trama_pr (
      EV_trama_in       IN              VARCHAR2,
      SV_trama_out      OUT NOCOPY      VARCHAR2,
      SN_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      SV_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      SN_num_evento     OUT NOCOPY      ge_errores_pg.evento

   );
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
END Ga_Trama_Pg;
/
SHOW ERRORS
