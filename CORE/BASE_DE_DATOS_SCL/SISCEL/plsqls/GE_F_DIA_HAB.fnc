CREATE OR REPLACE FUNCTION        GE_F_DIA_HAB
( FECHA IN DATE)  return   date is
Begin
--Nombre de la Funcion  : GE_F_DIA_HAB
--Creado Por            : JUAN GODOY VELEZ
--Descripcion           : Entrega el siguiente dia habil a la fecha ingresada
--Parametros de Input   : fecha  = fecha a la cual se le quiere buscar el siguiente dia habil
--Parametro de Salida   : Retorna la fecha siguiente correspondiente al dia habil .
--
--Fecha e Historia      : Martes, 06 de Marzo del 2000 : Creado.
--
 declare
   DIA_HABIL DATE;
   OK 		 number;
   CONTADOR  NUMBER(6);
   fecha_in date;
   begin
		for A in 1..365	loop
		contador:=A;
		OK:=0;
	    select count(*) into OK from ta_diasfest
		where FEC_DIAFEST = trunc(fecha)+contador;
		if OK = 0 AND (TO_CHAR(FECHA+CONTADOR,'DAY') not like '%SATURDAY%' and  TO_CHAR(FECHA+CONTADOR,'DAY') not like  '%SUNDAY%')
		  THEN
		   exit;
		end if;
	    end loop;
		return( trunc(fecha+contador));
 end;
End;
/
SHOW ERRORS
