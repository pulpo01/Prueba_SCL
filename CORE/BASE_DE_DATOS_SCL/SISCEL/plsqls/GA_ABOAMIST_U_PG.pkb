CREATE OR REPLACE PACKAGE BODY ga_aboamist_u_PG IS

PROCEDURE GA_modificar_PR(EV_codcliente IN ge_clientes.cod_cliente%TYPE,
					      EV_codcuenta IN ga_cuentas.cod_cuenta%TYPE,
					      EV_codvendedor IN ga_aboamist.cod_vendedor%TYPE,
					      EV_numventa IN ga_aboamist.num_venta%TYPE,
					      EV_numabonado IN ga_aboamist.num_abonado%TYPE,
					      EV_codusuario IN ga_aboamist.cod_usuario%TYPE,
					      SV_error OUT NOCOPY VARCHAR2
                         ) IS

        /*
		<Documentación TipoDoc = "GA_modificar_PR>"
		<Elemento Nombre = "PROCEDURE" Lenguaje="PL/SQL" Fecha="28-06-2005" Versión="1.0.0" Diseñador="Rayen Ceballos" Programador="Roberto Pérez" Ambiente="BD>
		<Retorno>NA</Retorno>
		<Descripción> Modifica GA_ABOAMIST</Descripción>
		<Parámetros>
		<Entrada>
		<param nom="EV_codcliente" Tipo="STRING">Codigo Cliente</param>
		<param nom="EV_codcuenta" Tipo="STRING">Cod. cuenta</param>
		<param nom="EV_codvendedor" Tipo="STRING">Cod. Vendedor</param>
		<param nom="EV_numventa" Tipo="STRING">Num. Venta</param>
		<param nom="EV_numabonado" Tipo="STRING">Num. Abonado</param>
		<param nom="EV_codusuario" Tipo="STRING">codigo usuario</param>
		</Entrada>
		<Salida>
		<param nom="SV_error" Tipo="STRING">Descripcion de un eventual error en la ejecucion del procedimiento</param>
		</Salida>
		</Parámetros>
		</Elemento>
		</Documentación>
		*/

BEGIN
        UPDATE ga_aboamist
		SET    cod_usuario=EV_codusuario,
		       cod_cliente=EV_codcliente,
		   	   cod_cuenta=EV_codcuenta,
			   cod_vendedor=EV_codvendedor,
			   num_venta=EV_numventa,
			   nom_usuarora=USER,
			   fec_alta=SYSDATE,
			   fec_activacion=SYSDATE
			  ,fec_acepventa=NULL --XO-200510060816: German Espinoza Z; 18/10/2005,fec_acepventa=SYSDATE --XO-200509260738: German Espinoza Z; 02/10/2005
		WHERE  num_abonado=EV_numabonado;

		--XO-200509260738: German Espinoza Z; 02/10/2005

		UPDATE ga_ventas
		SET       fec_venta=SYSDATE
			 ,ind_estventa='PD'
		WHERE num_venta=EV_numventa;
		--XO-200509260738: German Espinoza Z; 02/10/2005

        EXCEPTION
		   WHEN OTHERS THEN
			   SV_error:='GA_ABOAMIST_U_PG.GA_MODIFICAR_PR: ' || TO_CHAR(SQLCODE) || ' ' || SQLERRM;
END GA_modificar_PR;

END ga_aboamist_u_PG;
/
SHOW ERRORS
