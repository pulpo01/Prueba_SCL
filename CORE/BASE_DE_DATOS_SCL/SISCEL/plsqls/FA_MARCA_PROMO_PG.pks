CREATE OR REPLACE PACKAGE FA_MARCA_PROMO_PG
/*
<Documentaci�n TipoDoc = "Package">
   <Elemento Nombre = "FA_MARCA_PROMO_PG"
          Lenguaje="PL/SQL"
          Fecha="08-03-2007"
          Versi�n="1.0"
          Dise�ador=""
          Programador="Javier Garcia"
          Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
      <Descripci�n></Descripci�n>
      <Par�metros>
         <Entrada>NA</Entrada>
         <Salida>NA</Salida>
      </Par�metros>
</Elemento>
</Documentaci�n>
*/
IS
   cv_error_no_clasif      VARCHAR2 (50) := 'OK';
   cv_cod_modulo           VARCHAR2 (2)  := 'FA';
   cv_version              VARCHAR2 (2)  := '1';


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------




   PROCEDURE FA_MARCA_PROMO_PR         (EN_Digito	        IN NUMBER,
   									    EN_Cod_cliente      IN NUMBER,
   			 							EN_Cod_ciclo        IN NUMBER,
   			 							ED_Fec_llamada      IN DATE,
   			 							SN_Cod_retorno      OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                                  		SV_Mens_retorno     OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                                  		SN_Num_evento       OUT NOCOPY ge_errores_pg.evento);



END FA_MARCA_PROMO_PG;
/
SHOW ERRORS
