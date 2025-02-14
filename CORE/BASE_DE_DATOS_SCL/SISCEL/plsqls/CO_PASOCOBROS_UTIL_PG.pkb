CREATE OR REPLACE package body co_pasocobros_util_pg as
    type fa_ciclo_servidores_lt is table of fa_ciclo_servidores_tt%rowtype index by binary_integer;

    procedure co_inicializar_pasocobros_fn (
	    en_ciclo in number,
		ev_host  in varchar2,
		sn_error out nocopy number,
		sv_mensaje out nocopy varchar2
	) is pragma autonomous_transaction;
		/*
		   	<Documentaci¢n TipoDoc = "Procedimiento">
		   	<Elemento Nombre = "CO_INICIALIZAR_PASOCOBROS_FN" Lenguaje="PL/SQL" Fecha="19-06-2008" Versi¢n="1.0" Dise?ador="Cristian Iturra" Programador="Cristian Iturra" Ambiente="BD Colombia">
		   	<Retorno>NA</Retorno>
		   	<Descripción>Inicializa sinónimos para ejecución de pasocobros y registra ejecución FA_CICLO_SERVIDORES_TT</Descripci¢n>
		   	<Parámetros>
		   	<Entrada>
			   	<param nom="EN_ciclo"    Tipo="NUMBER">Código del ciclo de facturación</param>
			   	<param nom="EN_ciclo"    Tipo="NUMBER">Id. del Host (NULL => 'DEFAULT_HOST')</param>
		   	</Entrada>
		   	<Salida>
			   	<param nom="SN_retorno"  Tipo="NUMBER">   Indicador de si hubo error. 0=Sin Error, otro valor=Error</param>
			   	<param nom="SV_mensaje"  Tipo="VARCHAR2"> Descripcion del Error ocurrido </param>
		   	<Salida>
		   	</Parámetros>
		   	</Elemento>
		   	</Documentación>
		*/
       ln_tabla_doc varchar2(30);
	   lv_host varchar2(40);
	   ln_ciclo_actual varchar2(40);
	   ln_cantidad number;
	   --
	   ll_filas fa_ciclo_servidores_lt;
	begin
	    sn_error := CN_ERROR_PARAMETROS;
	    if en_ciclo is null then
			sv_mensaje := 'Parámetro EN_CICLO es obligatorio';
			return;
		end if;

	    if ev_host is null then
		    lv_host := CV_SINGLE_HOST;
		else
		    lv_host := ev_host;
		end if;

		sn_error := CN_ERROR_PROCESO;
		sv_mensaje := 'Error al consultar Ciclos por Servidores';

		select *
		bulk collect into ll_filas
		from fa_ciclo_servidores_tt
		where nom_programa = CV_PROGRAMA_ID	;

		if ll_filas is null or ll_filas.first is null then
		    -- No hay PasoCobrosCiclo en ejecucion => Crear Sinónimo
			ln_tabla_doc := 'FA_FACTDOCU_' || en_ciclo;
			sv_mensaje := 'Error al setear sinónimos para el ciclo';

			-- Si hay error sale con exception (others)
			execute immediate
			   'create or replace public synonym '|| CV_SINONIMO_DOCUMENTOS ||' for FA_FACTDOCU_' || EN_CICLO;

			-- Si hay error sale con exception (others)
			execute immediate
			   'create or replace public synonym '|| CV_SINONIMO_CONCEPTOS ||' for FA_FACTCONC_' || EN_CICLO;

		else
		    -- Hay un PasoCobrosCiclo ejecutándose => Revisar si es el mismo ciclo
			for i in 1 .. ll_filas.count loop
			    if ll_filas(i).cod_ciclfact != EN_CICLO then
					sv_mensaje := 'No se puede ejecutar ' || CV_PROGRAMA_ID || ' simultáneamente para ciclos diferentes';
					return;
				end if;
			end loop;
		end if;

		sv_mensaje := 'Error al registrar ejecución';
		insert into FA_CICLO_SERVIDORES_TT ( COD_CICLFACT, HOST_ID, NOM_PROGRAMA )
		values ( en_ciclo, lv_host, CV_PROGRAMA_ID );

	    sn_error :=0;
		sv_mensaje := 'Ejecución PasoCobrosCiclo inicializada';
		COMMIT;
	exception
	    when dup_val_on_index then
		    sv_mensaje := sv_mensaje || ' [ PasoCobrosCiclo ya está ejecutándose en el mismo host (' || lv_host || ') ]';
	    when others then
			sv_mensaje := sv_mensaje || ' [ ' || sqlcode || ', ' || sqlerrm || ' ]';
		ROLLBACK;
	end;

    procedure co_finalizar_pasocobros_fn (
	    en_ciclo in number,
		ev_host  in varchar2,
		sn_error out nocopy number,
		sv_mensaje out nocopy varchar2
	) is pragma autonomous_transaction;
		/*
		   	<Documentaci¢n TipoDoc = "Procedimiento">
		   	<Elemento Nombre = "CO_FINBALIZAR_PASOCOBROS_FN" Lenguaje="PL/SQL" Fecha="19-06-2008" Versi¢n="1.0" Dise?ador="Cristian Iturra" Programador="Cristian Iturra" Ambiente="BD Colombia">
		   	<Retorno>NA</Retorno>
		   	<Descripción>Registra fin de ejecución para ejecución de pasocobros</Descripci¢n>
		   	<Parámetros>
		   	<Entrada>
			   	<param nom="EN_ciclo"    Tipo="NUMBER">Código del ciclo de facturación</param>
			   	<param nom="EN_ciclo"    Tipo="NUMBER">Id. del Host (NULL => 'DEFAULT_HOST')</param>
		   	</Entrada>
		   	<Salida>
			   	<param nom="SN_retorno"  Tipo="NUMBER">   Indicador de si hubo error. 0=Sin Error, otro valor=Error</param>
			   	<param nom="SV_mensaje"  Tipo="VARCHAR2"> Descripcion del Error ocurrido </param>
		   	<Salida>
		   	</Parámetros>
		   	</Elemento>
		   	</Documentación>
		*/
	  lv_host varchar2(40);
	  ln_cantidad number;
	begin
	    sn_error :=1;
		sv_mensaje := 'Error al finalizar ejecución';

	    if en_ciclo is null then
		    sn_error := CN_ERROR_PARAMETROS;
			sv_mensaje := 'Parámetro EN_CICLO es obligatorio';
			return;
		end if;

	    if ev_host is null then
		    lv_host := CV_SINGLE_HOST;
		else
		    lv_host := ev_host;
		end if;


		delete from fa_ciclo_servidores_tt
		where nom_programa = CV_PROGRAMA_ID
		and   host_id = lv_host
		and   cod_ciclfact = en_ciclo;
        COMMIT;

		sn_error :=0;
		sv_mensaje := 'Pasocobros finalizado';
	exception
	    when others then
		    sn_error := sqlcode;
			sv_mensaje := sv_mensaje || ' [ ' || sqlcode || ', ' || sqlerrm|| ' ]';
		ROLLBACK;
	end;
end;
/
SHOW ERRORS
