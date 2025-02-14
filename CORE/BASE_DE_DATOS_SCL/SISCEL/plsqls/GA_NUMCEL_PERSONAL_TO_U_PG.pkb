CREATE OR REPLACE PACKAGE BODY GA_NUMCEL_PERSONAL_TO_U_PG
IS
/*
<Documentación
TipoDoc = "Package">
 <Elemento
    Nombre = "GA_NUMCEL_PERSONAL_TO_U_PG"
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


PROCEDURE GA_MODIFICAR_PR(
                                                EN_num_cel_pers         IN ga_numcel_personal_to.num_cel_pers%TYPE,
                                           EN_num_cel_dtno              IN ga_numcel_personal_to.num_cel_pers%TYPE,
                                           EN_num_cel_corp              IN ga_numcel_personal_to.num_cel_corp%TYPE,
                                           EN_cod_estado                IN ga_numcel_personal_to.cod_estado%TYPE,
                                           EV_nom_usuario               IN ga_numcel_personal_to.nom_usuario%TYPE,
                                           ED_fec_ultmod                IN ga_numcel_personal_to.fec_ultmod%TYPE,
                                           EV_cod_prog                  IN VARCHAR2,
                                           SN_p_filasafectas   OUT NOCOPY  NUMBER,
                                           SN_p_retornora      OUT NOCOPY  NUMBER,
                                           SN_p_nroevento      OUT NOCOPY  NUMBER,
                                           SV_p_vcod_retorno   OUT NOCOPY VARCHAR2
  )

IS
/*
<Documentación
TipoDoc = "PROCEDURE">
 <Elemento
    Nombre = "BORRAR_PR"
    Lenguaje="PL/SQL"
    Fecha="06-07-2006"
    Versión="1.0"
    Diseñador="Patricio Gallegos"
    Programador="Patricio Gallegos"
    Ambiente Desarrollo="BD">
    <Retorno>NA</Retorno>
    <Descripción>Prodedimiento que permite insertar registro en la tabla ga_numcel_personal_to>
    <Parámetros>
       <Entrada>
                   <param nom="EN_num_cel_pers" Tipo="VARCHAR">Número celular personal</param>
                   <param nom="EN_num_cel_dtno" Tipo="VARCHAR">Número celular destino</param>
                   <param nom="EN_num_cel_corp" Tipo="VARCHAR">Número celular Atlantida</param>
                   <param nom="EN_cod_estado" Tipo="NUMBER">Modulo</param>
                   <param nom="EV_nom_usuario" Tipo="VARCHAR">Nombre usuario</param>
                   <param nom="ED_fec_ultmod" Tipo="DATE">Fecha modificación</param>
                   <param nom="EV_cod_prog" Tipo="VARCHAR">Modulo</param>
           </Entrada>
           <Salida>
                   <param nom="SN_p_filasafectas" Tipo="NUMBER">Número de filas borradas</param>
                   <param nom="SN_p_retornora" Tipo="NUMBER">Código error oracle </param>
                   <param nom="SN_p_nroevento" Tipo="NUMBER">Número de evento</param>
                   <param nom="SV_p_vcod_retorno" Tipo="VARCHAR">código retorno de error</param>
           </Salida>
    </Parámetros>
 </Elemento>
</Documentación>
*/

BEGIN

         UPDATE ga_numcel_personal_to
         SET
          num_cel_pers = NVL(EN_num_cel_dtno,num_cel_pers) ,
          num_cel_corp = NVL(EN_num_cel_corp,num_cel_corp) ,
          cod_estado   = NVL(EN_cod_estado,cod_estado) ,
          nom_usuario  = NVL(EV_nom_usuario,USER) ,
          fec_ultmod   = NVL(ED_fec_ultmod,SYSDATE)
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

END GA_MODIFICAR_PR;

END GA_NUMCEL_PERSONAL_TO_U_PG;
/
SHOW ERRORS
