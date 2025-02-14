CREATE OR REPLACE PACKAGE BODY GA_NUMCEL_PERSONAL_TO_D_PG
IS
/*
<Documentaci�n
TipoDoc = "Package">
 <Elemento
    Nombre = "GA_NUMCEL_PERSONAL_TO_D_PG"
    Lenguaje="PL/SQL"
    Fecha="23-08-2006"
    Versi�n="1.0"
    Dise�ador="Patricio Gallegos"
    Programador="Patricio Gallegos"
    Ambiente Desarrollo="BD">
    <Retorno>NA</Retorno>
    <Descripci�n>Package de persistencia de la tabla GA_NUMCEL_PERSONAL_TO
    <Par�metros>
       <Entrada>NA</Entrada>
    </Par�metros>
 </Elemento>
</Documentaci�n>
*/

PROCEDURE GA_BORRAR_PR(  EN_num_cel_pers                IN ga_numcel_personal_to.num_cel_pers%TYPE,
                                           EV_cod_prog                  IN VARCHAR2,
                                           SN_p_filasafectas   OUT NOCOPY  NUMBER,
                                           SN_p_retornora      OUT NOCOPY  NUMBER,
                                           SN_p_nroevento      OUT NOCOPY  NUMBER,
                                           SV_p_vcod_retorno   OUT NOCOPY VARCHAR2
  )

IS
/*
<Documentaci�n
TipoDoc = "PROCEDURE">
 <Elemento
    Nombre = "BORRAR_PR"
    Lenguaje="PL/SQL"
    Fecha="06-07-2006"
    Versi�n="1.0"
    Dise�ador="Patricio Gallegos"
    Programador="Patricio Gallegos"
    Ambiente Desarrollo="BD">
    <Retorno>NA</Retorno>
    <Descripci�n>Prodedimiento que permite borrar registro en la tabla ga_numcel_personal_to>
    <Par�metros>
       <Entrada>
                   <param nom="EN_num_cel_pers" Tipo="VARCHAR">N�mero celular personal</param>
                   <param nom="EV_cod_prog" Tipo="VARCHAR">Modulo</param>
           </Entrada>
           <Salida>
                   <param nom="SN_p_filasafectas" Tipo="NUMBER">N�mero de filas borradas</param>
                   <param nom="SN_p_retornora" Tipo="NUMBER">C�digo error oracle </param>
                   <param nom="SN_p_nroevento" Tipo="NUMBER">N�mero de evento</param>
                   <param nom="SV_p_vcod_retorno" Tipo="VARCHAR">c�digo retorno de error</param>
           </Salida>
    </Par�metros>
 </Elemento>
</Documentaci�n>
*/

BEGIN

         DELETE ga_numcel_personal_to
         WHERE num_cel_pers = EN_num_cel_pers;

         SN_p_filasafectas := SQL%ROWCOUNT;
         SN_p_retornora    := SQLCODE;
         SV_p_vcod_retorno := CV_0;

EXCEPTION
                  WHEN OTHERS THEN

                SN_p_nroevento := GE_ERRORES_PG.GRABARPL(CN_0,
                                                                                                EV_cod_prog,
                                                                                                CV_DES_ERROR_V1,
                                                                                                CV_Version,
                                                                                                User,
                                                        CV_PROCEDURE,
                                                                                                NULL,
                                                                                                SQLCODE,
                                                                                                SQLERRM);

                LV_v_verror := SUBSTR(CV_DES_ERROR_V1 || SQLERRM,1,255);
                SN_p_retornora    := SQLCODE;
                SV_p_vcod_retorno := CV_4;
END GA_BORRAR_PR;

END GA_NUMCEL_PERSONAL_TO_D_PG;
/
SHOW ERRORS
