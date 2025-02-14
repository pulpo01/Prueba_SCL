CREATE OR REPLACE PACKAGE BODY            EBZ_PAC_GA_DTOS_GENERALES
 AS
    PROCEDURE GA_DTOS_CUENTAS(codigo in varchar2, Des_Cuenta out tDes_cuenta,
                              Nom_responsable out tNom_Responsable, Num_ident out tNum_ident,
                              Direccion out tDireccion, Fec_alta out tFec_Alta,
                              Cod_cattribut out tCatTribut) IS
        CURSOR cuenta IS --CURSOR CUENTAS
    select a.des_cuenta, a.nom_responsable, a.num_ident,
           b.nom_calle || ' ' || b.num_calle || ' ' || b.num_piso || ' ' || b.obs_direccion direccion,
               to_char(a.fec_alta, 'dd-mm-yyyy') fec_alta, a.cod_catribut
    from   ga_cuentas a, ge_direcciones b
    where  a.cod_cuenta=codigo and a.cod_direccion=b.cod_direccion;
        indice NUMBER DEFAULT 1;
       BEGIN
              FOR cadacuenta IN cuenta
            LOOP
               des_cuenta(indice):= cadacuenta.des_cuenta;
               nom_responsable(indice):=cadacuenta.nom_responsable;
               num_ident(indice):=cadacuenta.num_ident;
               Direccion(indice):=cadacuenta.direccion;
               fec_alta(indice):=cadacuenta.fec_alta;
               if cadacuenta.cod_catribut='B' or cadacuenta.cod_catribut is null then
                  Cod_cattribut(indice):='BOLETA';
               else
                  Cod_cattribut(indice):='FACTURA';
               end if;
               indice:=indice + 1;
            END LOOP;
       END;
        PROCEDURE GA_DTOS_CLIENTES(codigo in number, NombreCliente out tNom_Responsable,
                                   Num_ident out tNum_ident, CantAbonados out tCantidad,
                                   Cod_cliente out tCodCliente, Fec_alta out tFec_Alta,
                                   Telefono out tTelefono, ciclo out Tciclo,
                                   Cod_cattribut out tCatTribut, NombreEjecutivo out tNom_Responsable,
                                   CelularEjecutivo out tCelular, DireccionEjecutivo out tDireccion,
                                   EmailEjecutivo out tEmail,TelefonoCelularEje out ttelefono,
								   TelefonoFijoEje out ttelefono) IS
                  v_cantidad number(6);
                  v_celular_ejecutivo number(8);
                  v_email varchar2(255);
                  CURSOR cliente IS --CURSOR cliente
              select a.nom_cliente || ' ' || a.nom_apeclien1 || ' ' || a.nom_apeclien2 nom_cliente,
                                  a.num_ident, a.cod_cliente, substr(to_char(a.fec_alta,'dd-mm-yyyy'),1,10) fec_alta,
                 a.tef_cliente1, a.cod_ciclo Ciclo, b.cod_catribut, d.nom_vendedor,
                                 d.num_ident num_ident_ejecutivo,a.nom_email v_email,
                 e.nom_calle  || ' ' || e.num_calle || ' ' || e.num_piso || ' ' || e.obs_direccion direccion,
				 d.num_telef1 celularEje,d.num_telef2 fijoEje
                  from   ge_clientes a, ga_catributclie b, ve_vendcliente c, ve_vendedores d,
                         ge_direcciones e
                  where  a.cod_cliente=codigo and b.cod_cliente=a.cod_cliente
                                  and sysdate between b.fec_desde and b.fec_hasta
                                and a.cod_cliente = c.cod_cliente(+)
                 and c.cod_vendedor = d.cod_vendedor(+)
                                    and d.cod_direccion=e.cod_direccion(+);
           indice NUMBER DEFAULT 1;
           BEGIN
                  FOR cadacliente IN cliente
                    LOOP
                           select count(*) into v_cantidad
                           from   ga_abocel
                           where  cod_cliente=codigo
                                   and cod_producto=1; -- Cantidad de Abonados por Cliente
			               NombreCliente(indice):=cadacliente.nom_cliente;
                           Num_ident(indice):=cadacliente.num_ident;
                           CantAbonados(indice):=v_cantidad;
                           Cod_cliente(indice):=cadacliente.cod_cliente;
                           Fec_alta(indice):=cadacliente.fec_alta;
                           Telefono(indice):=cadacliente.tef_cliente1;
                           ciclo(indice):=cadacliente.ciclo;
                           if cadacliente.cod_catribut='B' then
                               Cod_cattribut(indice):='BOLETA';
                           else
                               Cod_cattribut(indice):='FACTURA';
                           end if;
                           NombreEjecutivo(indice):=cadacliente.nom_vendedor;
                           EmailEjecutivo(indice):=cadacliente.v_email;
						   TelefonoCelularEje(indice) := cadacliente.celularEje;
						   TelefonoFijoEje(indice) := cadacliente.fijoEje;
--                           begin
--                           select nom_email v_email
--                           from   ge_clientes
--                          where  num_ident=cadacliente.num_ident_ejecutivo
--                                and cod_tipident='01'
--                                       and fec_alta=(select max(fec_alta)
--                                                    from   ge_clientes
--                                                   where  num_ident=cadacliente.num_ident_ejecutivo
--                                                        and cod_tipident='01');
--                           EXCEPTION
--               when no_data_found then
--               null;
--                           end;
--                           CelularEjecutivo(indice):=v_celular_ejecutivo;
--                           DireccionEjecutivo(indice):=cadacliente.direccion;
--                           EmailEjecutivo(indice):=v_email;
               indice:=indice + 1;
            END LOOP;
       END;

PROCEDURE GA_DTOS_ABONADOS(codigo in varchar2, Num_ident out tNum_ident,
                         Direccion out tDireccion, Celular out tCelular,
                         NumSerie out tNumSerie, ModeloEquipo out tModeloEquipo,
                         MarcaEquipo out tMarcaEquipo, Fec_alta out tFec_Alta,
                         PlanTarif out tPlanTarifario) IS
           CURSOR abonado IS --CURSOR ABONADOS
        select b.num_ident, d.nom_calle || ' ' || d.num_calle || ' ' || d.num_piso || ' ' || d.obs_direccion direccion,
           a.num_celular, a.num_serie, g.des_fabricante, f.des_articulo,
               substr(to_char(a.fec_alta,'dd-mm-yyyy'),1,10) fec_alta, h.des_plantarif
    from   ga_abocel a, ge_clientes b, ga_direccli c, ge_direcciones d, ga_equipaboser e,
           al_articulos f, al_fabricantes g, ta_plantarif h
    where  a.num_celular=codigo
    and a.cod_situacion = 'AAA'
    and a.cod_cliente=b.cod_cliente
    and a.cod_cliente=c.cod_cliente and c.cod_tipdireccion=3
    and c.cod_direccion=d.cod_direccion and a.num_serie=e.num_serie
    and e.cod_articulo=f.cod_articulo and f.cod_fabricante=g.cod_fabricante
    and a.cod_plantarif=h.cod_plantarif;
    indice NUMBER DEFAULT 1;
    BEGIN
     FOR cadaabonado IN abonado
     LOOP
       num_ident(indice):=cadaabonado.num_ident;
       Direccion(indice):=cadaabonado.direccion;
       Celular(indice):=cadaabonado.num_celular;
       NumSerie(indice):=cadaabonado.num_serie;
       ModeloEquipo(indice):=cadaabonado.des_articulo;
       MarcaEquipo(indice):=cadaabonado.des_fabricante;
       Fec_alta(indice):=cadaabonado.fec_alta;
       PlanTarif(indice):=cadaabonado.des_plantarif;
       indice:=indice + 1;
     END LOOP;
END;

PROCEDURE GA_VERIF_CLI (


identificacion in varchar2,
                                                                tip_ide                   in varchar2, /* R o C o A*/
                                                                valor                   in number,
                                                                estado                   out t_respuesta /* 0 = identificacion no corresponde a valor 1= identificacion si corresponde a valor 2 tip_ide no valido*/
                                                           ) IS
                cursor c1 IS
                                select a.num_ident
                                from ga_cuentas a, ge_clientes b
                                where a.cod_cuenta = b.cod_cuenta
                                and b.cod_cliente = valor;
                cursor c2 IS
                                select b.cod_cliente
                                from ga_abocel a, ge_clientes b
                                where a.cod_cliente = b.cod_cliente
                                and a.num_celular = valor
                                and a.cod_situacion <> 'BAA';
                cursor c3 IS
                            select a.num_ident
                                from ga_cuentas a, ge_clientes b, ga_abocel c
                                where a.cod_cuenta = b.cod_cuenta
                                and b.cod_cliente = c.cod_Cliente
                                and c.cod_situacion <> 'BAA'
                                and c.num_celular = valor;
                rut                                varchar2(11);
                cliente                        number(8);
                BEGIN
                         if tip_ide = 'R' then
                            if not c1%ISOPEN then
                                   OPEN c1;
                                end if;
                                fetch c1 into rut;
                                if c1%FOUND then
                                   if identificacion = rut then
                                      estado(1) :=1;
                                   else
                                      estado(1) := 0;
                                   end if;
                                else
                                   estado(1):= 0;
                                end if;
                         elsif tip_ide = 'C' then
                            if not c2%ISOPEN then
                                   OPEN c2;
                                end if;
                                fetch c2 into cliente;
                                if c2%FOUND then
                                   if identificacion = cliente then
                                      estado(1) :=1;
                                   else
                                      estado(1) := 0;
                                   end if;
                                else
                                   estado(1):= 0;
                                end if;
                         elsif tip_ide = 'A' then
                            if not c3%ISOPEN then
                                   OPEN c3;
                                end if;
                                fetch c3 into rut;
                                if c3%FOUND then
                                   if identificacion = rut then
                                      estado(1) :=1;
                                   else
                                      estado(1) := 0;
                                   end if;
                                else
                                   estado(1):= 0;
                                end if;
                         else
                            estado(1) := 2;
                         end if;
                END GA_VERIF_CLI;


		PROCEDURE GA_CLI_OSITE
				  (
				   identificacion 	 in varchar2,
				   t_identifica		 in varchar2,
				   usuario			 out t_usuario,
				   n_usuario		 out t_n_usuario,
				   tipo_user		 out t_tipo_user,
				   num_ident		 out t_num_ident,
				   error			 out t_error
				  ) IS
 		  error_param    Exception;
		  n_error 	   integer;
		  i			   integer;
		cursor c1 is
			   select distinct a.cod_usuario cod_usuario, a.nom_usuario nom_usuario, 'C' tipo,a.num_ident num_ident
			   from npt_usuario a, ge_clientes b
			   where b.cod_cuenta = identificacion
			   and a.num_ident = to_char(b.cod_cliente)
			   UNION ALL
			   select distinct a.cod_usuario cod_usuario, a.nom_usuario nom_usuario, 'T' tipo,a.num_ident num_ident
			   from npt_usuario a, ge_clientes b, ve_vendcliente c
			   where b.cod_cuenta = identificacion
   			   and b.cod_cliente = c.cod_cliente
			   and a.num_ident = to_char(c.COD_VENDEDOR);


		cursor c2 is
			   select distinct a.cod_usuario cod_usuario, a.nom_usuario nom_usuario, 'R' tipo,a.num_ident num_ident
			   from npt_usuario a, ge_clientes b
			   where b.cod_cliente = identificacion
			   and a.num_ident = to_char(b.cod_cuenta)
			   UNION ALL
			   select distinct a.cod_usuario cod_usuario, a.nom_usuario nom_usuario, 'T' tipo,a.num_ident num_ident
			   from npt_usuario a, ge_clientes b, ve_vendcliente c
			   where b.cod_cliente = identificacion
			   and b.cod_cliente = c.cod_cliente
			   and a.num_ident = to_char(c.COD_VENDEDOR);

		cursor c3 is
			   select distinct a.cod_usuario cod_usuario, a.nom_usuario nom_usuario, 'R' tipo,a.num_ident num_ident
			   from npt_usuario a, ve_vendcliente b, ge_clientes c
			   where b.cod_vendedor = identificacion
			   and b.cod_cliente = c.cod_cliente
			   and  a.num_ident = to_char(c.cod_cuenta);

		BEGIN
		    --validar parametros de entrada al PL
			i:= 1;
			if not (t_identifica in ('R', 'C', 'T')) then
			   error (n_error):= 'Tipo de identificacion puede ser R, C o T';
			   n_error:= n_error +1;
			   raise error_param;
			end if;
		    if t_identifica = 'R' then
			   for L in c1 loop
			       usuario(i):= L.cod_usuario;
				   n_usuario(i):= L.nom_usuario;
				   tipo_user(i):= L.tipo;
				   num_ident(i):= L.num_ident;
				   i:= i +1;
			   end loop;
			elsif t_identifica = 'C' then
			   for L in c2 loop
			       usuario(i):= L.cod_usuario;
				   n_usuario(i):= L.nom_usuario;
				   tipo_user(i):= L.tipo;
   				   num_ident(i):= L.num_ident;
				   i:= i +1;
			   end loop;
			elsif t_identifica = 'T' then
			   for L in c3 loop
			       usuario(i):= L.cod_usuario;
				   n_usuario(i):= L.nom_usuario;
				   tipo_user(i):= L.tipo;
  				   num_ident(i):= L.num_ident;
				   i:= i +1;
			   end loop;
			end if;

		EXCEPTION
		        WHEN error_param THEN
				     error(n_error):= 'imposible continuar';
		        WHEN OTHERS THEN

				     error(n_error):= TO_CHAR(SQLCODE);
					 error(n_error+1):= sqlerrm;

		END GA_CLI_OSITE;
end;
/
SHOW ERRORS
