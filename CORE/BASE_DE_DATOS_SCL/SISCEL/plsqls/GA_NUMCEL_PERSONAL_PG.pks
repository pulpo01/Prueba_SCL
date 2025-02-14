CREATE OR REPLACE PACKAGE GA_NUMCEL_PERSONAL_PG
IS
/*
<Documentación
TipoDoc = "Package">
 <Elemento
    Nombre = "GA_NUMCEL_PERSONAL_PG"
    Lenguaje="PL/SQL"
    Fecha="23-08-2006"
    Versión="1.0"
    Diseñador="Patricio Gallegos"
    Programador="Patricio Gallegos"
    Ambiente Desarrollo="BD">
    <Retorno>NA</Retorno>
    <Descripción>Package de negocio para activación, desactivación y modificación de números personales
    <Parámetros>
       <Entrada>NA</Entrada>
    </Parámetros>
 </Elemento>
</Documentación>
*/


         GV_cod_modulo                  CONSTANT                VARCHAR2(2):='GA';
         GV_prm_grptecdma               CONSTANT                VARCHAR2(13):='GRUPO_TEC_DMA';

         CV_error_no_clasif       VARCHAR2(30):= 'Error no Clasificado';

         CN_0                     CONSTANT NUMBER (1)     := 0;

         CV_0                     CONSTANT VARCHAR2 (1)   := '0';
         CV_1                     CONSTANT VARCHAR2 (1)   := '1';

         CN_ESTADO_SU                     CONSTANT NUMBER (1)     := 0;
         CN_ESTADO_AC                     CONSTANT NUMBER (1)     := 1;
         CN_ESTADO_PA                     CONSTANT NUMBER (1)     := 2;
         CN_ESTADO_PM                     CONSTANT NUMBER (1)     := 3;
         CN_ESTADO_PD                     CONSTANT NUMBER (1)     := 4;

         GN_cod_estado_icc                CONSTANT     NUMBER(1) :=1;

         GV_cod_actabo                    CONSTANT     ga_actabo.cod_actabo%TYPE := 'NL';
         GN_num_intentos                  CONSTANT NUMBER (1)     := 0;
         GN_ind_bloqueo           CONSTANT NUMBER (1)     := 0;

         GV_param_grpgsm                  CONSTANT     VARCHAR2(13) := 'GRUPO_TEC_GSM';
         GV_PARAM_APLCDMA                 CONSTANT     VARCHAR2(20) := 'APLICA_NUMPERS_CDMA';


--------------------------------------------------------------------------------------------------
FUNCTION GA_EXISTE_NUMPERSONAL_FN(EN_num_cel_pers        IN ga_numcel_personal_to.num_cel_pers%TYPE)
RETURN INTEGER;
--------------------------------------------------------------------------------------------------
FUNCTION GA_EXISTE_NUMCORPORATIVO_FN(EN_num_cel_pers     IN ga_numcel_personal_to.NUM_CEL_CORP%TYPE)
RETURN INTEGER;
--------------------------------------------------------------------------------------------------
FUNCTION GA_EXISTE_NUMPERSONAL2_FN(EN_num_cel_pers       IN ga_numcel_personal_to.num_cel_pers%TYPE)
RETURN INTEGER;
--------------------------------------------------------------------------------------------------
FUNCTION GA_EXISTE_NUMCORPORATIVO2_FN(EN_num_cel_pers    IN ga_numcel_personal_to.NUM_CEL_CORP%TYPE)
RETURN INTEGER;

--------------------------------------------------------------------------------------------------
PROCEDURE GA_VAL_ACTIV_NUMPERS_PR (EV_num_celular        IN VARCHAR2,--ga_abocel.num_celular%TYPE,
                                                                  EV_cod_prog            IN VARCHAR2,
                                                                  SN_cod_retorno    OUT NOCOPY INTEGER,
                                                                  SN_num_evento     OUT NOCOPY INTEGER,
                                                                  SV_mens_retorno   OUT NOCOPY VARCHAR2);
--------------------------------------------------------------------------------------------------

PROCEDURE GA_VAL_ACTIV_NUMPERS_MODIF_PR (EV_num_celular        IN VARCHAR2,--ga_abocel.num_celular%TYPE,
                                                                  EV_cod_prog            IN VARCHAR2,
                                                                  SN_cod_retorno    OUT NOCOPY INTEGER,
                                                                  SN_num_evento     OUT NOCOPY INTEGER,
                                                                  SV_mens_retorno   OUT NOCOPY VARCHAR2);
--------------------------------------------------------------------------------------------------

PROCEDURE GA_VAL_ACCESO_NUMPERS_PR (
                                                           EV_param_entrada IN  VARCHAR2,
                                                           SV_resultado      OUT NOCOPY VARCHAR2,
                                                           SV_mensaje        OUT NOCOPY GA_TRANSACABO.DES_CADENA%TYPE);
--------------------------------------------------------------------------------------------------
PROCEDURE GA_ACTIVA_NUMPERSONAL_PR (
                                                                  EV_num_cel_pers        IN VARCHAR2,
                                                                  EV_num_cel_corp        IN VARCHAR2,
                                                                  EN_num_movimiento      IN icc_movimiento.num_movant%TYPE,
                                                                  EV_cod_prog            IN VARCHAR2,
                                                                  SN_p_correlativo      OUT NOCOPY NUMBER,
                                                                  SN_cod_retorno    OUT NOCOPY INTEGER,
                                                                  SN_num_evento     OUT NOCOPY INTEGER,
                                                                  SV_msg_retorno        OUT NOCOPY VARCHAR2
                                                                  );
--------------------------------------------------------------------------------------------------
PROCEDURE GA_DESACTIVA_NUMPERSONAL_PR (
                                                                  EV_num_cel_pers       IN VARCHAR2,--ga_numcel_personal_to.num_cel_pers%TYPE,
                                                                  EV_cod_prog           IN VARCHAR2,
                                                                  SN_p_correlativo      OUT NOCOPY NUMBER,
                                                                  SN_cod_retorno    OUT NOCOPY INTEGER,
                                                                  SN_num_evento     OUT NOCOPY INTEGER,
                                                                  SV_msg_retorno        OUT NOCOPY VARCHAR2
                                                                  );
--------------------------------------------------------------------------------------------------
PROCEDURE GA_MODIFICA_NUMPERSONAL_PR (
                                                                  EV_num_cel_pers        IN VARCHAR2,
                                                                  EV_num_cel_dtno        IN VARCHAR2,
                                                                  EV_cod_prog            IN VARCHAR2,
                                                                  SN_p_correlativo      OUT NOCOPY NUMBER,
                                                                  SN_cod_retorno    OUT NOCOPY INTEGER,
                                                                  SN_num_evento     OUT NOCOPY INTEGER,
                                                                  SV_msg_retorno        OUT NOCOPY VARCHAR2
                                                                  );
--------------------------------------------------------------------------------------------------
PROCEDURE GA_MODIFICA_NUMPERSONALCORP_PR (
                                                                  EV_num_cel_pers        IN VARCHAR2,
                                                                  EV_num_cel_dtno        IN VARCHAR2,
                                                                  EV_cod_prog            IN VARCHAR2,
                                                                  SN_p_correlativo      OUT NOCOPY NUMBER,
                                                                  SN_cod_retorno    OUT NOCOPY INTEGER,
                                                                  SN_num_evento     OUT NOCOPY INTEGER,
                                                                  SV_msg_retorno        OUT NOCOPY VARCHAR2
                                                                  );
--------------------------------------------------------------------------------------------------
FUNCTION GA_RET_DESCR_EST_FN(EN_cod_estado       IN ga_numcel_personal_to.cod_estado%TYPE)
RETURN VARCHAR2;

--------------------------------------------------------------------------------------------------
PROCEDURE GA_ACTLZA_NUMCEL_PERSONAL_PR
(
  EN_NUM_PER_ORIGEN  IN GA_NUMCEL_PERSONAL_TO.NUM_CEL_CORP%TYPE,
  EN_NUM_PER_DESTINO IN GA_NUMCEL_PERSONAL_TO.NUM_CEL_CORP%TYPE,
  EV_COD_ACTABO          IN GA_ACTABO.COD_ACTABO%TYPE
  );


--------------------------------------------------------------------------------------------------
END GA_NUMCEL_PERSONAL_PG;
/
SHOW ERRORS
