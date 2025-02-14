CREATE OR REPLACE FUNCTION GE_FN_LUHN(v_serie in varchar2) return varchar2 is
-- Objetvo: Obtener el digito verificador para una serie IMEI o ICC
-- Entrada : Numero correspondiente al serie sin el digito verificador
-- Salida : Digito verificador
v_resultado varchar2(100);
v_total number;
iLargo number;
v_digito number;
v_num_superior number;
i  number;
begin
  --Inicializacion de variable
  v_total := 0;
  iLargo := length(ltrim(rtrim(v_serie)));
  v_resultado:='';
   i:=1;

  --Obtner resultado de multiplicar x 2 las posiciones pares
  WHILE (i <= iLargo)
  Loop
          if (mod(i,2) = 0) then /*Si es PAR*/
                 v_resultado := v_resultado || to_char(to_number(substr(v_serie, i,1)) * 2);
          else
                 v_resultado := v_resultado || substr(v_serie, i,1);
          end if;
          i := i +1;
  End Loop;

  --Totalizar resultados
  i:= 1;
  while (i <= length(ltrim(rtrim(v_resultado)) ) )
  Loop
                 v_total := v_total + to_number(substr(v_resultado, i,1));
                 i:=i+1;
  End Loop;

  -- Obtener el digito correspondiente
  if v_total < 10 then
         v_num_superior := 10;
  elsif (mod(v_total,10) = 0) then
     v_num_superior := v_total;
  else
         iLargo := length(trim(to_char(v_total)));
         v_num_superior := to_number(substr(to_char(v_total),1, iLargo -1)) + 1;
         v_num_superior := v_num_superior * 10;
         v_digito := v_num_superior - v_total;
  end if;

  v_digito := v_num_superior - v_total;

  return to_char(v_digito);
end;
/
SHOW ERRORS
