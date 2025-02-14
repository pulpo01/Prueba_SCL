CREATE OR REPLACE PACKAGE BODY PV_VIGENCIA_DIRECCION_PG AS

FUNCTION pv_UpdateUltimaConsulta_fn (
                      se_Cod_cliente      in  varchar2,
                      en_Cod_TipDireccion in  varchar2
                                   ) Return varchar2 IS
/*
<Documentación TipoDoc = "Función">
<Elemento Nombre = "pv_UpdateUltimaConsulta_fn" Lenguaje="PL/SQL" Fecha="07-09-2007" Versión="1.0.0" Diseñador="Gonzalo Salas " Programador="Gonzalo Salas " Ambiente="DEIMOS_COL">
<Retorno>Boolean</Retorno>
<Descripción>Retorna un True si esta vigente y False si ya expiro la vigencia</Descripción>
<Parámetros>
<Entrada>
  <param nom="se_Cod_cliente" Tipo="NUMBER">Codigo del Cliente</param>
  <param nom="en_cod_TipDireccion" Tipo="NUMBER">tipo de direccion</param>
</Entrada>
<Salida>
  <param nom="SN_cod_retorno" Tipo="NUMBER">Retorno de codigo</param>
  <param nom="SV_mens_retorno" Tipo="VARCHAR2">Mensaje de retorno</param>
</Salida>
</Parámetros>
</Elemento>
</Documentación>
*/
v_ExisteCliente    number;
BEGIN
   v_StrRetorno := 'TRUE';

   SELECT  count(1)
   INTO v_ExisteCliente
   FROM GA_DIRECCLI
   Where COD_CLIENTE = TO_NUMBER(se_COD_CLIENTE);

   IF v_ExisteCliente = 1 Then

      BEGIN
         UPDATE GA_DIRECCLI
         Set FECHA_CONSULTA = sysdate
         Where COD_CLIENTE = to_Number(se_COD_CLIENTE)
           and COD_TIPDIRECCION = en_cod_TipDireccion;
      EXCEPTION
      WHEN OTHERS THEN
         v_strRetorno       := 'FALSE';
      END;

   ELSE

      Begin
         INSERT INTO GA_DIRECCLI(
         COD_CLIENTE,
         COD_TIPDIRECCION,
         FECHA_CONSULTA
         )VALUES(
         TO_NUMBER(se_Cod_cliente),
                 en_cod_TipDireccion,
                 sysdate
         );
      Exception
      WHEN OTHERS THEN
         v_strRetorno       := 'FALSE';
          End;
   End if;

   RETURN v_strRetorno;
Exception
When Others then
      v_strRetorno := 'FALSE';
END pv_UpdateUltimaConsulta_fn;



FUNCTION pv_ConsultaVigencia_fn (
                      se_Cod_cliente       in           varchar2,
                      en_cod_TipDireccion  in           varchar2
                                   ) Return VARCHAR2 IS
/*
<Documentación TipoDoc = "Función">
<Elemento Nombre = "pv_ConsultaVigencia_fn" Lenguaje="PL/SQL" Fecha="07-09-2007" Versión="1.0.0" Diseñador="Gonzalo Salas " Programador="Gonzalo Salas " Ambiente="DEIMOS_COL">
<Retorno>Boolean</Retorno>
<Descripción>Retorna un True si esta vigente y False si ya expiro la vigencia</Descripción>
<Parámetros>
<Entrada>
  <param nom="se_Cod_cliente" Tipo="NUMBER">Codigo del Cliente</param>
  <param nom="en_cod_TipDireccion" Tipo="NUMBER">tipo de direccion</param>
</Entrada>
<Salida>
  <param nom="sn_diasrestantes" Tipo="NUMBER">Numero de dias de vigencia</param>
  <param nom="SN_cod_retorno" Tipo="NUMBER">Retorno de codigo</param>
  <param nom="SV_mens_retorno" Tipo="VARCHAR2">Mensaje de retorno</param>
</Salida>
</Parámetros>
</Elemento>
</Documentación>
*/

v_DiasLleva        number;
v_ExisteCliente    number;
V_DIAS             number;
sn_diasConsulta    number;
BEGIN
   v_Retorno := TRUE;

   SELECT  count(1)
   INTO v_ExisteCliente
   FROM GA_DIRECCLI
   Where COD_CLIENTE = TO_number(se_COD_CLIENTE);

   IF v_ExisteCliente >= 1 Then
      BEGIN
         SELECT trunc(to_number((sysdate - FECHA_CONSULTA)))
         INTO v_DiasLleva
         FROM GA_DIRECCLI
         Where COD_CLIENTE = to_number(se_COD_CLIENTE)
           and COD_TIPDIRECCION = en_cod_TipDireccion;

         Select TO_NUMBER(NVL(VAL_PARAMETRO,'0'))
                 INTO V_DIAS
                 FROM ged_parametros
                 Where
                 NOM_PARAMETRO = 'DVIGENCIA'
                 And COD_MODULO = 'GA'
         And COD_PRODUCTO = 1;

                 sn_diasConsulta := nvl(v_DiasLleva,0);

                 If nvl(sn_diasConsulta,0) < (v_Dias) Then
                    v_StrRetorno       := 'TRUE';
                 else
                    v_StrRetorno       := 'FALSE';
                 End if;

      EXCEPTION
      WHEN OTHERS THEN
         v_StrRetorno       := 'FALSE';
      END;
   ELSE
      v_StrRetorno := 'FALSE';
   End if;

   RETURN v_StrRetorno;

END pv_ConsultaVigencia_fn;

END pv_Vigencia_Direccion_pg;
/
SHOW ERRORS
