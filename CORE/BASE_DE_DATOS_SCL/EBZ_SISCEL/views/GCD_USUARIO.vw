CREATE OR REPLACE FORCE VIEW GCD_USUARIO(
   COD_USUARIO
 , NOM_USUARIO
 , NUM_IDENT
 , LOGIN_USUARIO
 , CLA_USUARIO
 , EMAIL_USUARIO
 , TIP_USUARIO
 , CAT_USUARIO
 , EST_USUARIO
 ) AS 
select u.cod_usuario, u.nom_usuario || ' ' || u.app_usuario  || ' ' || u.apm_usuario nom_usuario,
ur.cod_relacion_siscel num_ident,u.uid_usuario login_usuario, u.pwd_usuario cla_usuario,
u.email_usuario, u.cod_tipo_usuario tip_usuario,  ur.cat_usuario, u.est_usuario
from psd_usuario u, gct_usuario_relacionado ur
where ur.cod_usuario = u.cod_usuario
with check option
/
SHOW ERRORS
