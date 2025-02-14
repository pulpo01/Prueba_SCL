CREATE OR REPLACE PACKAGE Pv_traspaso_IndActuac_pg AS
/*
<Documentación TipoDoc = "Package">
   <Elemento Nombre = "Pv_traspaso_IndActuac_pg"
          Lenguaje="PL/SQL"
          Fecha="15-06-2007"
          Versión="1.0"
          Diseñador=""
          Programador="José Jara"
          Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
      <Descripción>Package busqueda si el abonado realizo mas de un traspaso en el mismo ciclo</Descripción>
      <Descripción>si es asi deja el campo ind_actuac con un valor 9 el cual no sera considerado por facturacion</Descripción>
      <Parámetros>
         <Entrada>NA</Entrada>
         <Salida>NA</Salida>
      </Parámetros>
</Elemento>
</Documentación>
*/

   cv_error_no_clasif      VARCHAR2 (50) := 'No es posible clasificar el error';
   cv_cod_modulo           VARCHAR2 (2)  := 'GA';

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


   PROCEDURE GA_Actualiza_IndActuac_PR(EN_num_abonado    IN  NUMBER,
                                       EN_cod_cliente    IN  NUMBER,
                                       EN_CicloFact      IN NUMBER,
                                       SV_mens_retorno   OUT NOCOPY VARCHAR2,
                                       SV_cod_retorno    OUT NOCOPY NUMBER
                                       );

END Pv_traspaso_IndActuac_pg;
/
SHOW ERRORS
