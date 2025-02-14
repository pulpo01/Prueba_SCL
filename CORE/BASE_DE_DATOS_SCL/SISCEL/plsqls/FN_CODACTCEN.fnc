CREATE OR REPLACE FUNCTION Fn_CodActCen (sCodProducto in varchar2, sCodActAbo in varchar2, sCodModulo in varchar2, sCodTecnologia in varchar2)
RETURN VARCHAR2 IS
sCodActCen ga_actabo.COD_ACTCEN%type;
begin

         select cod_actcen into sCodActCen From ga_actabo
         Where Cod_Producto = sCodProducto
         and cod_actabo = sCodActAbo
         and cod_modulo = sCodModulo
         and cod_tecnologia = sCodTecnologia;

         return sCodActCen;
end;
/
SHOW ERRORS
