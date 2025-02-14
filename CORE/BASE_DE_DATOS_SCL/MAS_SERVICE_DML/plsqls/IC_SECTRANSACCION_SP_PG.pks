CREATE OR REPLACE PACKAGE IC_SECTRANSACCION_SP_PG
IS
/*
<Documentación
   TipoDoc = "PACKAGE">
   <Elemento
      Nombre = "IC_SECTRANSACCION_SP_PG"
	  Lenguaje="PL/SQL"
	  Fecha creación="ENE-2008"
	  Creado por="Juan Gonzalez C."
	  Fecha modificacion=""
	  Modificado por=""
	  Ambiente Desarrollo="BD">
	  <Retorno>N/A</Retorno>
	  <Descripción>Rutinas para tabla IC_SECTRANSACCION_TO </Descripción>
	  <Parámetros>
	     <Entrada>N/A</Entrada>
		 <Salida>N/A</Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
    TYPE refCursor IS REF CURSOR;
    CV_error_no_clasif CONSTANT VARCHAR2 (50) := 'No es posible clasificar el error';
    CV_cod_modulo CONSTANT VARCHAR2 (2)  := 'SE';
    CV_version CONSTANT VARCHAR2 (3)  := '1.0';
    Cn_Lista_Nula CONSTANT NUMBER := 1;

PROCEDURE IC_INSERTA_SEC_PR ( EN_COD_PROD_CONTRATADO IN IC_SECTRANSACCION_TO.COD_PROD_CONTRATADO%TYPE,
                                                  EN_NUM_CELULAR IN IC_SECTRANSACCION_TO.NUM_CELULAR%TYPE,
                                                  EN_NUM_MOV_ORIGEN IN IC_SECTRANSACCION_TO.NUM_MOV_ORIGEN%TYPE,
                                                  SN_ERROR OUT NOCOPY NUMBER,
                                                  SV_MENSAJE OUT NOCOPY VARCHAR2,
                                                  SN_EVENTO OUT NOCOPY NUMBER );

END IC_SECTRANSACCION_SP_PG;
/
SHOW ERRORS
