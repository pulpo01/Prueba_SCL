CREATE OR REPLACE PACKAGE PV_VIGENCIA_DIRECCION_PG IS
/*
<Documentación
TipoDoc = "Package">
 <Elemento
    Nombre = "pv_Vigencia_Direccion_pg"
    Lenguaje="PL/SQL"
    Fecha="06-09-2007"
    Versión="1.0"
    Diseñador="Gonzalo Salas"
    Programador="Gonzalo Salas"
    Ambiente Desarrollo="BD">
    <Retorno>NA</Retorno>
    <Descripción></Descripción>
    <Parámetros>
       <Entrada>NA</Entrada>
    </Parámetros>
 </Elemento>
</Documentación>
*/
/* Variables Globales */
v_Retorno   boolean;
v_StrRetorno varchar2(5);
-- /*
--    FUNCTION pv_ConsultaVigencia_fn (
--                       se_Cod_cliente       in           varchar2,
--                       en_cod_TipDireccion  in           varchar2,
--                       sn_diasConsulta      out nocopy   varchar2,
--                       SN_cod_retorno       out nocopy   varchar2,
--                       SV_mens_retorno      out nocopy   varchar2
--                                    ) Return Boolean;
--    */

   FUNCTION pv_ConsultaVigencia_fn (
                      se_Cod_cliente       in           varchar2,
                      en_cod_TipDireccion  in           varchar2
                                   ) Return VARCHAR2;

   FUNCTION pv_UpdateUltimaConsulta_fn (
                      se_Cod_cliente       in           varchar2,
                      en_cod_TipDireccion  in           varchar2
--                      SN_cod_retorno       out nocopy   varchar2,
--                      SV_mens_retorno      out nocopy   varchar2
                                   ) Return VARCHAR2;



END pv_Vigencia_Direccion_pg;
/
SHOW ERRORS
