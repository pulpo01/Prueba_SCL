CREATE OR REPLACE PACKAGE BODY            EBZ_PAC_SEGURIDAD AS
	   PROCEDURE EBZ_PAC_CTAS_VEND(cod_vendedor in number,
	   			 				   cod_cuenta out tCodCuenta,
  							       des_cuenta out tDesCuenta) IS
       CURSOR cuentas IS
  	   SELECT DISTINCT C.COD_CUENTA,C.DES_CUENTA
	   FROM   VE_VENDCLIENTE B,GE_CLIENTES A,GA_CUENTAS C
	   WHERE  B.COD_VENDEDOR = cod_vendedor AND
		      C.COD_CUENTA = A.COD_CUENTA   AND
           	  B.COD_CLIENTE = A.COD_CLIENTE
	   ORDER BY C.COD_CUENTA;
	   indice NUMBER DEFAULT 1;
	   BEGIN
			 FOR cadacuenta IN cuentas
			 LOOP
			 	 cod_cuenta(indice):=cadacuenta.cod_cuenta;
				 des_cuenta(indice):=cadacuenta.des_cuenta;
				 indice:=indice + 1;
			 END LOOP;
       END;
  	   PROCEDURE EBZ_PAC_USUARIO_VEND(cod_vendedor in number,
	                               cod_usuario out tCodUsuario,
								   num_ident out tNumIdent,
								   login_usuario out tLoginUsuario,
								   cla_usuario out tClaUsuario,
								   email_usuario out tEmailUsuario,
								   tip_usuario out tTipUsuario,
								   cat_usuario out tCatusuario,
								   est_usuario out tEstUsuario) IS
        CURSOR usuarios IS
		SELECT COD_USUARIO,NOM_USUARIO,NUM_IDENT,LOGIN_USUARIO,CLA_USUARIO,EMAIL_USUARIO,TIP_USUARIO,
		       CAT_USUARIO,EST_USUARIO
		FROM NPT_USUARIO
		WHERE CAT_USUARIO IN ('M', 'A' ) AND
		      NUM_IDENT IN (
			                 SELECT DISTINCT A.COD_CLIENTE
							 FROM GE_CLIENTES A,VE_VENDCLIENTE B
							 WHERE B.COD_VENDEDOR = cod_vendedor AND
							  	   B.COD_CLIENTE = A.COD_CLIENTE
							);
        indice NUMBER DEFAULT 1;
 		BEGIN
			 FOR cadausuario IN usuarios
			 LOOP
			 	 cod_usuario(indice):=cadausuario.cod_usuario;
				 num_ident(indice):=cadausuario.num_ident;
 			 	 login_usuario(indice):=cadausuario.login_usuario;
 			 	 cla_usuario(indice):=cadausuario.cla_usuario;
 			 	 email_usuario(indice):=cadausuario.email_usuario;
  			 	 tip_usuario(indice):=cadausuario.tip_usuario;
  			 	 cat_usuario(indice):=cadausuario.cat_usuario;
  			 	 est_usuario(indice):=cadausuario.est_usuario;
				 indice:=indice + 1;
			 END LOOP;
        END;
		PROCEDURE EBZ_PAC_USUARIO_CTA(codcuenta in number,
	                               cod_usuario out tCodUsuario,
								   num_ident out tNumIdent,
								   login_usuario out tLoginUsuario,
								   cla_usuario out tClaUsuario,
								   email_usuario out tEmailUsuario,
								   tip_usuario out tTipUsuario,
								   cat_usuario out tCatusuario,
								   est_usuario out tEstUsuario) IS
        CURSOR usuarios IS
		SELECT COD_USUARIO,NOM_USUARIO,NUM_IDENT,LOGIN_USUARIO,CLA_USUARIO,EMAIL_USUARIO,TIP_USUARIO,
		       CAT_USUARIO,EST_USUARIO
		FROM NPT_USUARIO
		WHERE CAT_USUARIO='A' AND
		      NUM_IDENT IN (
			                 SELECT DISTINCT A.COD_CLIENTE
							 FROM GE_CLIENTES A,GA_CUENTAS B
							 WHERE B.COD_CUENTA = codcuenta AND
							  	   B.COD_CUENTA = A.COD_CUENTA
							);
        indice NUMBER DEFAULT 1;
 		BEGIN
			 FOR cadausuario IN usuarios
			 LOOP
			 	 cod_usuario(indice):=cadausuario.cod_usuario;
				 num_ident(indice):=cadausuario.num_ident;
 			 	 login_usuario(indice):=cadausuario.login_usuario;
 			 	 cla_usuario(indice):=cadausuario.cla_usuario;
 			 	 email_usuario(indice):=cadausuario.email_usuario;
  			 	 tip_usuario(indice):=cadausuario.tip_usuario;
  			 	 cat_usuario(indice):=cadausuario.cat_usuario;
  			 	 est_usuario(indice):=cadausuario.est_usuario;
				 indice:=indice + 1;
			 END LOOP;
        END;
END;
/
SHOW ERRORS
