CREATE OR REPLACE PACKAGE VE_UPD_INFO_CLIENTES_PG
IS
/*
<Documentación
   TipoDoc = "PACKAGE">
   <Elemento
      Nombre = "VE_VENTAS_PREAUTO_PG_2"
	  Lenguaje="PL/SQL"
	  Fecha creación="Enero-2008"
	  Creado por="Jorge Marín"
	  Fecha modificacion=""
	  Modificado por=""
	  Ambiente Desarrollo="BD">
	  <Retorno>N/A</Retorno>
	  <Descripción>Rutinas para el modelo optimizado de ByP </Descripción>
	  <Parámetros>
	     <Entrada>N/A</Entrada>
		 <Salida>N/A</Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/

  TYPE refcursor          IS REF CURSOR;
 -- Declaración de estructuras tipo tablas dinamicas.
   TYPE TIP_ENLACE_HIST 		IS RECORD    (FA_HISTCONC   FA_ENLACEHIST.FA_HISTCONC%TYPE);
   TYPE TIP_ENLACE_HIST_LIST	IS TABLE OF  TIP_ENLACE_HIST  INDEX BY PLS_INTEGER;

   TYPE TIP_MTO_FACTURA 		IS RECORD   (MTO_FACTURA   NUMBER);
   TYPE TIP_MTO_FACTURA_LIST	IS TABLE OF  TIP_MTO_FACTURA  INDEX BY PLS_INTEGER;

   TYPE TIP_CLIENTE 		    IS RECORD    (COD_CLIENTE   GE_CLIENTES.COD_CLIENTE%TYPE);
   TYPE TIP_CLIENTE_LIST	    IS TABLE OF  TIP_CLIENTE  INDEX BY PLS_INTEGER;

   TYPE TIP_EMAIL_USU 		    IS RECORD    (NOM_EMAIL   GE_SEG_USUARIO.NOM_EMAIL%TYPE);
   TYPE TIP_EMAIL_USU_LIST 	    IS TABLE OF  TIP_EMAIL_USU   INDEX BY PLS_INTEGER;


   TYPE TIP_GE_MTOPREAUTOCLI_TO IS TABLE OF     GE_MTOPREAUTOCLI_TO%ROWTYPE 	  	 INDEX BY PLS_INTEGER;
   TYPE TIP_GE_MTOPREAUTOCLI_TH IS TABLE OF     GE_MTOPREAUTOCLI_TH%ROWTYPE 	  	 INDEX BY PLS_INTEGER;

   CV_error_no_clasif           CONSTANT VARCHAR2(50)   := 'No es posible clasificar el error';
   CV_subject                   CONSTANT VARCHAR (50)   := 'Proceso de actualización de CC y MPA realizado';
   CV_version                   CONSTANT VARCHAR (10)   := '1';
   CV_cod_modulo 	   	        CONSTANT VARCHAR2 (2)   := 'GA';                   --Código de Modulo
   CV_nom_fact_cont   	        CONSTANT VARCHAR2(20)   := 'NUM_FACT_CONTINUAS';   --Nombre de parametro de para obtenero maximo de facturas continuas
   CV_cod_situabaa 	   	        CONSTANT VARCHAR2 (3)   := 'BAA';                  --Código de situación  de Baja "BAA"
   CV_cod_situabap 	   	        CONSTANT VARCHAR2 (3)   := 'BAP';                  --Código de situación  de Baja activa en proceso"BAA"
   CV_ind_alta_pos              CONSTANT VARCHAR2 (1)   := 'V';                    --Indicador de alta pospago.
   CV_cod_cred_exc              CONSTANT VARCHAR2 (3)   := 'EXC';                  --Cliente excepcionado.
   CV_calif_cred_baja           CONSTANT VARCHAR2 (1)   := 'X';                    --Clasificacion para Clientes con todos sus abonados en BAA y BAP
   CV_calif_cred_moro           CONSTANT VARCHAR2 (1)   := 'M';                    --Clasificacion para Clientes con morosidad pero no cumple con el minimo de facturas continuas
   CV_calif_cred_a              CONSTANT VARCHAR2 (1)   := 'A';                    --Clasificacion para Clientes sin mora
   CV_cod_programa 	   	        CONSTANT VARCHAR2 (3)   := 'MPA';                  --Código de programa"
   CN_cod_prestacion            CONSTANT NUMBER         := 24;                     --Código de prestacion.
   CN_cod_producto              CONSTANT NUMBER         := 1;                      --Código de producto.
   CN_cod_tipconce              CONSTANT NUMBER         := 3;                      --Código tipo concepto.
   CN_num_venta                 CONSTANT NUMBER         := 0;                      --Número de venta
   CN_no_procc                  CONSTANT NUMBER         := 0;                      --Cliente no cumple las condiciones para ser procesado
   CN_ok_procc                  CONSTANT NUMBER         := 1;                      --Cliente cumple las condiciones para ser procesado
   CN_clie_baja                 CONSTANT NUMBER         := 2;                      --Cliente tiene solo abonados en BAA y BAP


    PROCEDURE VE_CLASIF_CREDIT_PR(EN_COD_CLIENTE      IN GE_CLIENTES.COD_CLIENTE%TYPE,
                                  EN_COD_CLIENTE_FIN  IN GE_CLIENTES.COD_CLIENTE%TYPE,
                                  SV_MENS_RETORNO    OUT NOCOPY VARCHAR2,
                                  SN_NUM_EVENTO      OUT NOCOPY NUMBER );



END VE_UPD_INFO_CLIENTES_PG;
/
SHOW ERRORS
