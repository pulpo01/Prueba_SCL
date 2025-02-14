CREATE OR REPLACE PACKAGE GA_NUMCEL_PERSONAL_TO_I_PG
IS
/*
<Documentación
TipoDoc = "Package">
 <Elemento
    Nombre = "GA_NUMCEL_PERSONAL_TO_I_PG"
    Lenguaje="PL/SQL"
    Fecha="23-08-2006"
    Versión="1.0"
    Diseñador="Patricio Gallegos"
    Programador="Patricio Gallegos"
    Ambiente Desarrollo="BD">
    <Retorno>NA</Retorno>
    <Descripción>Package de persistencia de la tabla GA_NUMCEL_PERSONAL_TO
    <Parámetros>
       <Entrada>NA</Entrada>
    </Parámetros>
 </Elemento>
</Documentación>
*/



  CV_Version                      CONSTANT VARCHAR2(3)   := '1.0';

  CV_PROCEDURE             CONSTANT VARCHAR2(45)  := 'GA_NUMCEL_PERSONAL_TO_I_PG.AGREGAR_PR';
  CV_0                     CONSTANT VARCHAR2(1)   := '0';
  CV_4                     CONSTANT VARCHAR2(1)   := '4';

  CN_0                     CONSTANT NUMBER(1)  := 0;
  CV_DES_ERROR_V1                  CONSTANT VARCHAR2(70) := 'Error el insertar registro en la tabla GA_NUMCEL_PERSONAL_TO.';

  LV_v_verror                      VARCHAR2(255);

  CN_20010                 CONSTANT NUMBER (6)     := -20010;

PROCEDURE GA_AGREGAR_PR(  EN_num_cel_pers               IN ga_numcel_personal_to.num_cel_pers%TYPE,
                                           EN_num_cel_corp              IN ga_numcel_personal_to.num_cel_corp%TYPE,
                                           EN_cod_estado                IN ga_numcel_personal_to.cod_estado%TYPE,
                                           EV_nom_usuario               IN ga_numcel_personal_to.nom_usuario%TYPE,
                                           ED_fec_ultmod                IN ga_numcel_personal_to.fec_ultmod%TYPE,
                                           EV_cod_prog                  IN VARCHAR2,
                                           SN_p_filasafectas   OUT NOCOPY  NUMBER,
                                           SN_p_retornora      OUT NOCOPY  NUMBER,
                                           SN_p_nroevento      OUT NOCOPY  NUMBER,
                                           SV_p_vcod_retorno   OUT NOCOPY VARCHAR2
  );

END GA_NUMCEL_PERSONAL_TO_I_PG;
/
SHOW ERRORS
