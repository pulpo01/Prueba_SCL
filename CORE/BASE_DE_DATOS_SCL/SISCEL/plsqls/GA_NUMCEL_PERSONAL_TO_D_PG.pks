CREATE OR REPLACE PACKAGE GA_NUMCEL_PERSONAL_TO_D_PG

IS
/*
<Documentación
TipoDoc = "Package">
 <Elemento
    Nombre = "GA_NUMCEL_PERSONAL_TO_D_PG"
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

  CV_PROCEDURE             CONSTANT VARCHAR2(45)  := 'GA_NUMCEL_PERSONAL_TO_D_PG.BORRAR_PR';
  CV_0                     CONSTANT VARCHAR2(1)   := '0';
  CV_4                     CONSTANT VARCHAR2(1)   := '4';

  CN_0                     CONSTANT NUMBER(1)  := 0;
  CV_DES_ERROR_V1                  CONSTANT VARCHAR2(70) := 'Error al borrar registro en la tabla GA_NUMCEL_PERSONAL_TO.';

  LV_v_verror                      VARCHAR2(255);

  CN_20010                 CONSTANT NUMBER (6)     := -20010;

PROCEDURE GA_BORRAR_PR(  EN_num_cel_pers                IN ga_numcel_personal_to.num_cel_pers%TYPE,
                                           EV_cod_prog                  IN VARCHAR2,
                                           SN_p_filasafectas   OUT NOCOPY  NUMBER,
                                           SN_p_retornora      OUT NOCOPY  NUMBER,
                                           SN_p_nroevento      OUT NOCOPY  NUMBER,
                                           SV_p_vcod_retorno   OUT NOCOPY VARCHAR2
  );

END GA_NUMCEL_PERSONAL_TO_D_PG;
/
SHOW ERRORS
