CREATE OR REPLACE PACKAGE GE_CORREO_MOVISTAR_PG
IS
  TYPE refcursor          IS REF CURSOR;
   
   CV_error_no_clasif           CONSTANT VARCHAR2 (50)  := 'No es posible clasificar el error';
   CV_subject                   CONSTANT VARCHAR (50)   := 'Proceso de actualización de CC y MPA realizado';
   CV_version                   CONSTANT VARCHAR (10)   := '1';
   CV_cod_modulo 	   	        CONSTANT VARCHAR2 (2)   := 'GE';       
   CN_cod_producto              CONSTANT NUMBER         := 1;          
   CV_individual                CONSTANT VARCHAR2 (15)  := 'Individual';
   CV_profesional               CONSTANT VARCHAR2 (15)  := 'Profesional';
   CV_Corporativo               CONSTANT VARCHAR2 (15)  := 'Corporativo';
   CV_campo_imsi                CONSTANT VARCHAR2 (4)   := 'IMSI';

    PROCEDURE GE_ENVIO_CORREO_PR(EN_NUM_VENTA       IN ga_abocel.num_venta%TYPE,
                                 EN_COD_CORREO      IN ge_usuario_aplic_td.cod_programa%TYPE,
                                 EV_TIP_BB          IN VARCHAR2,
                                 EV_SUBJECT         IN VARCHAR2,
                                 EV_BODY            IN VARCHAR2,
                                 SV_MENS_RETORNO    OUT NOCOPY VARCHAR2,
                                 SN_NUM_EVENTO      OUT NOCOPY NUMBER );
                                      
                                  

END GE_CORREO_MOVISTAR_PG;
/
SHOW ERRORS