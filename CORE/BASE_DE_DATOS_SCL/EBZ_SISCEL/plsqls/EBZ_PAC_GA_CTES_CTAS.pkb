CREATE OR REPLACE PACKAGE BODY            EBZ_PAC_GA_CTES_CTAS
 AS
    PROCEDURE EBZ_PAC_GA_CTES_CTAS(cod_cta in number, cod_cliente out tCodCliente, nom_cliente out tNom_Cliente,
                            catribut out tCatTribut) IS
        CURSOR cliente IS
        select a.cod_cliente,
        a.nom_cliente || ' ' || a.nom_apeclien1 || ' ' || a.nom_apeclien2  || '(' || a.cod_cliente || ')' nom_cliente,
        b.cod_catribut
        from   ge_clientes a, ga_catributclie b
        where  a.cod_cuenta=cod_cta and b.cod_cliente=a.cod_cliente
        and sysdate between b.fec_desde and b.fec_hasta;
        indice NUMBER DEFAULT 1;
       BEGIN
              FOR cadacliente IN cliente
            LOOP
              cod_cliente(indice):=cadacliente.cod_cliente;
              nom_cliente(indice):=cadacliente.nom_cliente;
              if cadacliente.cod_catribut='B' then
                 catribut(indice):='BOLETA';
              else
                 catribut(indice):='FACTURA';
              end if;
               indice:=indice + 1;
            END LOOP;
       END;
           PROCEDURE GA_ABONADOS_CTES(cod_cte in number,  Num_Celular out tNum_Celular,Num_Abonado out tNum_Abonado,
             Cod_Situacion out tCod_Situacion, Fec_Alta out tFec_Alta) IS
             CURSOR abonado IS
             select num_abonado,num_celular,cod_situacion,to_char(fec_alta,'DD-MM-YYYY') FechaAlta
             from   ga_abocel
             where  cod_cliente=cod_cte
             order by num_celular;
             indice NUMBER DEFAULT 1;
             BEGIN
               FOR cadaAbonado IN abonado
                 LOOP
                   Num_abonado(indice):=cadaAbonado.num_abonado;
                   Num_celular(indice):=cadaAbonado.num_celular;
                   if cadaAbonado.cod_situacion='AAA' or cadaAbonado.cod_situacion='AOP' or
				      cadaAbonado.cod_situacion='AOA' or cadaAbonado.cod_situacion='AOS' or
					  cadaAbonado.cod_situacion='ATS' or cadaAbonado.cod_situacion='CVS' or
					  cadaAbonado.cod_situacion='ACP' or cadaAbonado.cod_situacion='CVA' or
					  cadaAbonado.cod_situacion='ATP' or cadaAbonado.cod_situacion='CSP' or
					  cadaAbonado.cod_situacion='ABP' or cadaAbonado.cod_situacion='ARP' or
					  cadaAbonado.cod_situacion='TAP' or cadaAbonado.cod_situacion='ATA' or
					  cadaAbonado.cod_situacion='PFB' or cadaAbonado.cod_situacion='PAP' or
					  cadaAbonado.cod_situacion='CNP' or cadaAbonado.cod_situacion='AVP' or
  			  		  cadaAbonado.cod_situacion='TVP' then
					  Cod_Situacion(indice):='Alta';
                   else
                       if cadaAbonado.cod_situacion='SAO' or cadaAbonado.cod_situacion='SAA' or
  					      cadaAbonado.cod_situacion='SAT' or cadaAbonado.cod_situacion='STP' or
                          cadaAbonado.cod_situacion='SCV' or cadaAbonado.cod_situacion='SRD' then
						  Cod_Situacion(indice):='Suspension';
					   else
						   if cadaAbonado.cod_situacion='RDS' or cadaAbonado.cod_situacion='RAO' or
							  cadaAbonado.cod_situacion='RAT' or cadaAbonado.cod_situacion='RCV' or
							  cadaAbonado.cod_situacion='RRD' or cadaAbonado.cod_situacion='REP' or
							  cadaAbonado.cod_situacion='RDA' or cadaAbonado.cod_situacion='REA' or
                              cadaAbonado.cod_situacion='RTP' or cadaAbonado.cod_situacion='BAA' or
							  cadaAbonado.cod_situacion='BAP' then
                              Cod_Situacion(indice):='Baja';
                           end if;
                       end if;
                   end if;
				   Fec_Alta(indice):=cadaAbonado.FechaAlta;
                   indice:=indice + 1;
               END LOOP;
             END;
           END;
/
SHOW ERRORS
