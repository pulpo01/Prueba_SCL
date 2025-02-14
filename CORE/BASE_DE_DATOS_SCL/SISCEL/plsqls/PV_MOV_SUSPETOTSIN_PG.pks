CREATE OR REPLACE PACKAGE PV_MOV_SUSPETOTSIN_PG
IS
   TYPE refCursor IS REF CURSOR;
   CV_error_no_clasif      CONSTANT VARCHAR2 (50) := 'No es posible clasificar el error';
   CV_cod_modulo           CONSTANT VARCHAR2 (2)  := 'GA';
   CV_cod_modulo_GE        CONSTANT VARCHAR2 (2)  := 'GE';
   CV_version              CONSTANT VARCHAR2 (2)  := '1';
   CV_gsFormato2           CONSTANT VARCHAR2 (20) := 'FORMATO_SEL2';
   CV_gsFormato4           CONSTANT VARCHAR2 (20) := 'FORMATO_SEL4';
   CV_gsFormato7           CONSTANT VARCHAR2 (20) := 'FORMATO_SEL7';
   CV_gsFormato11          CONSTANT VARCHAR2 (20) := 'FORMATO_SEL11';
   CV_cod_aplic            CONSTANT VARCHAR2 (3)  := 'PVA';
   CN_producto             CONSTANT NUMBER        := 1;

 
   CN_0                    CONSTANT NUMBER (1)     :=   0;
   CV_0                    CONSTANT VARCHAR2 (1)   := '0';
   CV_1                    CONSTANT VARCHAR2 (1)   := '1';
   
   GV_formato_sel2    ged_parametros.val_parametro%type;
   GV_formato_sel7    ged_parametros.val_parametro%type;
------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------
       PROCEDURE PV_REGISTRA_MOV_PR(             EO_FEC_TRANS     IN  DATE,
                                                 SN_RESULTADO     OUT NOCOPY INTEGER,
                                                 SV_SQLCODE       OUT NOCOPY VARCHAR2,
                                                 SV_SQLERRM       OUT NOCOPY VARCHAR2
                                                 );

END PV_MOV_SUSPETOTSIN_PG;
/
