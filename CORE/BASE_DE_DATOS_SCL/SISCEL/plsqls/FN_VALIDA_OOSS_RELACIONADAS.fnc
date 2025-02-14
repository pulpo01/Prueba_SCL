CREATE OR REPLACE FUNCTION Fn_Valida_OoSs_Relacionadas
( VP_MODULO    pv_iorserv.COD_MODULO%TYPE,
  VP_IDGESTOR    pv_iorserv.ID_GESTOR%TYPE,
  VP_NroOOSS      pv_iorserv.NUM_OS%TYPE
)
RETURN boolean IS
-- Autor: PAGC

V_NroOOSS      pv_iorserv.NUM_OS%TYPE;
V_Resultado    boolean;
V_Estado       pv_erecorrido.COD_ESTADO%type;
V_TipEstado    pv_erecorrido.TIP_ESTADO%type;

  CURSOR NUMOOSSs IS
   SELECT NUM_OS
     FROM PV_IORSERV
    WHERE COD_MODULO = VP_MODULO AND
       ID_GESTOR = VP_IDGESTOR AND
       NUM_OS NOT IN  (VP_NroOOSS);
begin

  if VP_MODULO is null or VP_IDGESTOR is null or VP_NroOOSS is null then
     V_Resultado := False;
  else
    V_Resultado := True;

    OPEN NUMOOSSs;
        LOOP
             FETCH NUMOOSSs INTO V_NroOOSS;
             EXIT WHEN NUMOOSSs%NOTFOUND;

       select max(cod_estado) into V_Estado
       from pv_erecorrido where num_os=V_NroOOSS;

 /*      select tip_estado into V_TipEstado
       from pv_erecorrido where num_os=V_NroOOSS AND cod_estado=V_Estado;
*/

--       if V_Estado != 990 and V_TipEstado !=4 THEN
       if V_Estado != 990 then
           V_Resultado := False;
           exit;
       end if;

     END LOOP;

    Close NUMOOSSs;

       Return V_Resultado;
 end if;

Exception
    when Others THEN
	    dbms_output.put_line('Erro Fatal ->' || to_Char(sqlcode));
        return false;
end;
/
SHOW ERRORS
