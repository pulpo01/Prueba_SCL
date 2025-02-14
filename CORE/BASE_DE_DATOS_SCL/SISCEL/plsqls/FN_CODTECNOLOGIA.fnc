CREATE OR REPLACE FUNCTION Fn_CodTecnologia (sNumAbonado in varchar2, sNomTabla in varchar2)
RETURN VARCHAR2 IS
sCodTecnologia ga_abocel.COD_TECNOLOGIA%type;
begin
         if upper(sNomTabla)='GA_ABOCEL' then
                 select cod_tecnologia
                 into sCodTecnologia
                 from ga_abocel
                 where num_abonado=sNumAbonado;
         end if;

         if upper(sNomTabla)='GA_ABOAMIST' then
                 select cod_tecnologia
                 into sCodTecnologia
                 from ga_aboamist
                 where num_abonado=sNumAbonado;
         end if;

         return sCodTecnologia;
end;
/
SHOW ERRORS
