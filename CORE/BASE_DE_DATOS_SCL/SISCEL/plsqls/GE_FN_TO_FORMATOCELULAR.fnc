CREATE OR REPLACE FUNCTION        GE_FN_TO_FORMATOCELULAR(NumCelular in Number) RETURN varchar2
IS

sFormato  		  varchar2(50);
NumConFormato 	  varchar2(256);
i 				  number;
j 				  number;
iLargo 			  number;
sNumCelular 	  varchar2(256);

BEGIN
	 select to_number(val_parametro) into iLargo from ged_parametros where cod_modulo ='GE'
	 		and cod_producto = 1 and nom_parametro = 'LARGO_N_CELULAR';
     select des_parametro into sFormato from ged_parametros where cod_modulo ='GE'
	 		and cod_producto = 1 and nom_parametro = 'FORMATO_N_CELULAR';

	 select to_char(NumCelular) into sNumCelular from dual;

	 i:=0;
	 j:=1;
	 loop
	 	  EXIT when i = length(sFormato);
		  if substr(sFormato,i,1)='#' then
		  	 NumConFormato:=NumConFormato || substr(sNumCelular,j,1);
			 j:=j+1;
		  elsif substr(sFormato,i,1)<>' ' then
 		  	 NumConFormato:=NumConFormato || substr(sFormato,i,1);
		  end if;
          i:= i +1;
	 end loop;

   RETURN NumConFormato;

END GE_FN_TO_FORMATOCELULAR;
/
SHOW ERRORS
