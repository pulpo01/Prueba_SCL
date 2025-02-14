CREATE OR REPLACE PACKAGE BODY PR_MONTO_ESCRITO IS
function mto_escrito (x number,y number) return varchar2 is
A     number(3)        := 0;
B     number(3)        := 0;
C     varchar2(20)     := null;
con_A number(2)        := 0;
con_B number(2)        := 0;
                         /*                5  4  3  2  1  */
                         /*                123123123123123*/
monto varchar2(20)     := ltrim(to_char(x,'000000000000000.00'));
decim varchar2(20)     := substr(monto,instr(monto,'.')+1,2);
str_A varchar2(300)    := null;
str_B varchar2(300)    := null;
str_C varchar2(300)    := null;
mon_esc varchar2(300) := null;
begin
   con_A := 13;
   loop
      str_A := substr(monto,con_A,3);
      con_B := 3;
      str_B := null;
      loop
         B := to_number(substr(str_A,con_B,1));
         C := arreglo(con_B,B);
         if con_B = 1 then
            if B = 1 then
               if to_number(substr(str_A,2,2)) > 0 then
                  C := 'CIENTO';
               end if;
            end if;
         elsif con_B = 3 then
            if B > 0 then
               if to_number(substr(str_A,con_B - 1,1)) = 1 then
                  c := arreglo (4,B);
                  con_B := 2;
               elsif to_number(substr(str_A,con_B - 1,1)) >= 2 or
                     to_number(substr(str_A,con_B - 1,1)) = 0 then
                  if B = 1 then
                     if con_A = 7 then
                        C := 'UNO';
                     else
                        C := 'UN';
                     end if;
                  end if;
                  if to_number(substr(str_A,con_B - 1,1)) = 2 then
                     C := 'VEINTI' || C;
                     con_B := con_B - 1;
                  elsif to_number(substr(str_A,con_B - 1,1)) != 0 then
                     C := 'Y ' || C;
                  end if;
               end if;
            end if;
         end if;
         if B != 0 then
            str_B := C || ' ' || str_B;
         end if;
         exit when con_B = 1;
         con_B := con_B - 1;
      end loop;
      if nvl(to_number(substr(str_A,1,3)),0) != 0 then
         if con_A = 1 then
            if nvl(to_number(substr(str_A,3,1)),0) = 1 and
               nvl(to_number(substr(str_A,2,1)),0) = 0 then
               str_B := str_B || 'BILLON';
            else
               str_B := str_B || 'BILLONES';
            end if;
         elsif con_A = 4 then
            str_B := str_B || 'MIL';
         elsif con_A = 7 then
            if nvl(to_number(substr(str_A,3,1)),0) = 1 and
               nvl(to_number(substr(str_A,2,1)),0) = 0 then
               str_B := str_B || 'MILLON';
            else
               str_B := str_B || 'MILLONES';
            end if;
         elsif con_A = 10 then
            str_B := str_B || 'MIL';
         end if;
         str_C := str_B || ' ' || str_C;
      end if;
	  if y = 1 then
         mon_esc := rtrim(str_C) || ' ' || decim || '/100';
      elsif y = 2 then
	     mon_esc := rtrim(str_C);
	  elsif y = 3 then
	     mon_esc := decim || '/100';
	  end if;
      exit when con_A = 1;
      con_A := con_A - 3;
      str_A := substr(monto,con_A,3);
   end loop;
   dbms_output.put_line(mon_esc);
   return(mon_esc);
end;

function arreglo(a number, b number) return varchar2 is
c varchar2(20);
begin
   if a = 1 then
      if b = 1 then
         c := 'CIEN';
      elsif b = 2 then
         c := 'DOSCIENTOS';
      elsif b = 3 then
         c := 'TRESCIENTOS';
      elsif b = 4 then
         c := 'CUATROCIENTOS';
      elsif b = 5 then
         c := 'QUINIENTOS';
      elsif b = 6 then
         c := 'SEISCIENTOS';
      elsif b = 7 then
         c := 'SETECIENTOS';
      elsif b = 8 then
         c := 'OCHOCIENTOS';
      elsif b = 9 then
         c := 'NOVECIENTOS';
      end if;
   elsif a = 2 then
      if b = 1 then
         c := 'DIEZ';
      elsif b = 2 then
         c := 'VEINTE';
      elsif b = 3 then
         c := 'TREINTA';
      elsif b = 4 then
         c := 'CUARENTA';
      elsif b = 5 then
         c := 'CINCUENTA';
      elsif b = 6 then
         c := 'SESENTA';
      elsif b = 7 then
         c := 'SETENTA';
      elsif b = 8 then
         c := 'OCHENTA';
      elsif b = 9 then
         c := 'NOVENTA';
      end if;
   elsif a = 3 then
      if b = 1 then
         c := 'UNO';
      elsif b = 2 then
         c := 'DOS';
      elsif b = 3 then
         c := 'TRES';
      elsif b = 4 then
         c := 'CUATRO';
      elsif b = 5 then
         c := 'CINCO';
      elsif b = 6 then
         c := 'SEIS';
      elsif b = 7 then
         c := 'SIETE';
      elsif b = 8 then
         c := 'OCHO';
      elsif b = 9 then
         c := 'NUEVE';
      end if;
   elsif a = 4 then
      if b = 1 then
         c := 'ONCE';
      elsif b = 2 then
         c := 'DOCE';
      elsif b = 3 then
         c := 'TRECE';
      elsif b = 4 then
         c := 'CATORCE';
      elsif b = 5 then
         c := 'QUINCE';
      elsif b = 6 then
         c := 'DIECISEIS';
      elsif b = 7 then
         c := 'DIECISIETE';
      elsif b = 8 then
         c := 'DIECIOCHO';
      elsif b = 9 then
         c := 'DIECINUEVE';
      end if;
   end if;
   return(c);
end;
END PR_MONTO_ESCRITO;
/
SHOW ERRORS
