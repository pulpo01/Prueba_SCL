CREATE OR REPLACE PACKAGE            EBZ_PAC_SEGURIDAD AS
	   TYPE tCodCuenta is TABLE of GA_CUENTAS.COD_CUENTA%type INDEX BY BINARY_INTEGER;
	   TYPE tDesCuenta is TABLE of GA_CUENTAS.DES_CUENTA%type INDEX BY BINARY_INTEGER;
	   TYPE tCodUsuario is TABLE of NPT_USUARIO.COD_USUARIO%type INDEX BY BINARY_INTEGER;
	   TYPE tNumIdent is TABLE of NPT_USUARIO.NUM_IDENT%type INDEX BY BINARY_INTEGER;
  	   TYPE tLoginUsuario is TABLE of NPT_USUARIO.LOGIN_USUARIO%type INDEX BY BINARY_INTEGER;
   	   TYPE tClaUsuario is TABLE of NPT_USUARIO.CLA_USUARIO%type INDEX BY BINARY_INTEGER;
   	   TYPE tEmailUsuario is TABLE of NPT_USUARIO.EMAIL_USUARIO%type INDEX BY BINARY_INTEGER;
   	   TYPE tTipUsuario is TABLE of NPT_USUARIO.TIP_USUARIO%type INDEX BY BINARY_INTEGER;
   	   TYPE tCatUsuario is TABLE of NPT_USUARIO.CAT_USUARIO%type INDEX BY BINARY_INTEGER;
   	   TYPE tEstUsuario is TABLE of NPT_USUARIO.EST_USUARIO%type INDEX BY BINARY_INTEGER;
	   PROCEDURE EBZ_PAC_CTAS_VEND(cod_vendedor in number,
	   			 				   cod_cuenta out tCodCuenta,
								   des_cuenta out tDesCuenta);
  	   PROCEDURE EBZ_PAC_USUARIO_VEND(cod_vendedor in number,
	                               cod_usuario out tCodUsuario,
								   num_ident out tNumIdent,
								   login_usuario out tLoginUsuario,
								   cla_usuario out tClaUsuario,
								   email_usuario out tEmailUsuario,
								   tip_usuario out tTipUsuario,
								   cat_usuario out tCatusuario,
								   est_usuario out tEstUsuario);
  	   PROCEDURE EBZ_PAC_USUARIO_CTA(codcuenta in number,
	                               cod_usuario out tCodUsuario,
								   num_ident out tNumIdent,
								   login_usuario out tLoginUsuario,
								   cla_usuario out tClaUsuario,
								   email_usuario out tEmailUsuario,
								   tip_usuario out tTipUsuario,
								   cat_usuario out tCatusuario,
								   est_usuario out tEstUsuario);
END EBZ_PAC_SEGURIDAD;
/
SHOW ERRORS
