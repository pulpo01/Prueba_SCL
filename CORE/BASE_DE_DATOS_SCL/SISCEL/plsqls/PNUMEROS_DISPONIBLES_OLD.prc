CREATE OR REPLACE PROCEDURE PNUMEROS_DISPONIBLES_OLD(P_TRANSACCION in varchar2 ,p_num_desde in NUMBER, p_num_aper in NUMBER, p_nros_disp in NUMBER, p_cod_uso in NUMBER, p_cod_cat in NUMBER, p_cod_central in NUMBER, p_cod_subalm in varchar2, p_cod_producto in NUMBER) IS

   v_numhasta_s      number(15);
   v_numsig_s        number(15);
   v_numdesde_i      number(15);
   v_numhasta_i      number(15);
   v_numsig_i        number(15);
   v_numlib_i        number(15);
   v_numhasta_u      number(15);
   v_numsig_u        number(15);
   v_numlib_u        number(15);


   v_desde           number(15);
   v_hasta           number(15);
   v_mensaje         varchar(100);
   v_error           number;
   v_DiasHib         number(2);
   no_hay_datos      exception;
   no_datos          boolean;

BEGIN
     v_error:=0;
	 v_mensaje:=' ';

     SELECT num_hasta, num_siguiente
	 INTO  v_numhasta_s, v_numsig_s
	 FROM ga_celnum_uso
	 WHERE num_desde=p_num_desde
	  and  cod_uso=p_cod_uso
	  and  cod_cat=p_cod_cat
	  and  cod_central=p_cod_central
	  and  cod_subalm=p_cod_subalm;


	 if SQL%NOTFOUND then
	    v_mensaje:='No Se encontro Informacion. Revise Tabla Ga_Celnum_Uso';
		raise no_hay_datos;
	 end if;



     if ((v_numsig_s + p_nros_disp - 1)=v_numhasta_s) then
       v_numsig_u:=v_numhasta_s;
	   v_numlib_u:=0;

	   UPDATE ga_celnum_uso
	   SET num_siguiente=v_numsig_u,
	       num_libres=v_numlib_u
	   WHERE num_desde=p_num_desde
	    and  cod_uso=p_cod_uso
	    and  cod_cat=p_cod_cat
	    and  cod_central=p_cod_central
	    and  cod_subalm=p_cod_subalm;

       if SQL%NOTFOUND then
	     v_mensaje:='No se pudo Modificar Tabla Ga_Celnum_Uso';
		 raise no_hay_datos;
	   end if;


    else
       if (	p_num_aper=p_num_desde) then
		 v_numsig_u:=(p_num_aper + p_nros_disp) ;
 	     v_numlib_u:=(v_numhasta_s - v_numsig_u + 1);

	     UPDATE ga_celnum_uso
	     SET num_siguiente=v_numsig_u ,
             num_libres=v_numlib_u
	     WHERE num_desde=p_num_desde
	      and  cod_uso=p_cod_uso
	      and  cod_cat=p_cod_cat
	      and  cod_central=p_cod_central
	      and  cod_subalm=p_cod_subalm;


  	     if SQL%NOTFOUND then
	       v_mensaje:='No se pudo Modificar Tabla Ga_Celnum_Uso';
		   raise no_hay_datos;
	     end if;


      else
	     v_numhasta_u:=(p_num_aper - 1 );
         v_numlib_u:=(v_numhasta_u - v_numsig_s + 1);

		 if (v_numsig_s > v_numhasta_u) then
		    v_numsig_s:= v_numhasta_u;
		 end if;

	     UPDATE ga_celnum_uso
	     SET num_hasta=v_numhasta_u ,
             num_libres=v_numlib_u,
			 num_siguiente=v_numsig_s
 	     WHERE num_desde=p_num_desde
	      and  cod_uso=p_cod_uso
	      and  cod_cat=p_cod_cat
	      and  cod_central=p_cod_central
	      and  cod_subalm=p_cod_subalm;

	     if SQL%NOTFOUND then
	        v_mensaje:='No se pudo Modificar Tabla Ga_Celnum_Uso';
		    raise no_hay_datos;
	     end if;


         v_numdesde_i:=p_num_aper;
	     v_numhasta_i:=v_numhasta_s;
         v_numsig_i:=(v_numdesde_i + p_nros_disp) ;
	     v_numlib_i:=(v_numhasta_i - v_numsig_i ) + 1;


         INSERT INTO ga_celnum_uso
		 (num_desde,num_hasta,cod_subalm,cod_producto,cod_central,cod_cat,cod_uso,num_libres,num_siguiente)
	     VALUES(v_numdesde_i,v_numhasta_i,p_cod_subalm,p_cod_producto,p_cod_central,p_cod_cat,p_cod_uso,v_numlib_i,v_numsig_i)
	     ;

	     if SQL%NOTFOUND then
	       v_mensaje:='No se pudo Insertar Rango Nuevo en Tabla Ga_Celnum_Uso';
		   raise no_hay_datos;
	     end if;
       end if;
    end if;



	 SELECT NUM_DIAS_HIBERNACION
	 INTO v_DiasHib
	 FROM al_usos
	 WHERE cod_uso=p_cod_uso;
	 if SQL%NOTFOUND then
	    v_mensaje:='No se encuentra dias de hibernacion en Tabla Ga_Celnum_Reutil';
		raise no_hay_datos;
	 else
       v_desde:=p_num_aper;
	   v_hasta:=(v_desde +  p_nros_disp);

       WHILE (v_desde < v_hasta) LOOP
         INSERT INTO ga_celnum_reutil
		 (num_celular,cod_subalm,cod_producto,cod_central,cod_cat,cod_uso,fec_baja,ind_equipado)
	     VALUES(v_desde,p_cod_subalm,p_cod_producto,p_cod_central,p_cod_cat,p_cod_uso,(sysdate - v_DiasHib),1)
		 ;

       	 if SQL%NOTFOUND then
   	       v_mensaje:='No se pudo Insertar en Tabla Ga_Celnum_Reutil';
		   raise no_hay_datos;
         end if;
	     v_desde:=v_desde + 1 ;
	   END LOOP;
	 end if;



INSERT INTO GA_TRANSACABO
(num_transaccion,cod_retorno,des_cadena)
VALUES (P_TRANSACCION,v_error,v_mensaje);
COMMIT;



EXCEPTION
  WHEN no_hay_datos THEN
    v_error:=1;
  WHEN	OTHERS THEN
    v_mensaje:=SQLERRM;
    v_error:=SQLCODE;

INSERT INTO GA_TRANSACABO
(num_transaccion,cod_retorno,des_cadena)
VALUES (P_TRANSACCION,v_error,v_mensaje);
COMMIT;
null;

END;
/
SHOW ERRORS
