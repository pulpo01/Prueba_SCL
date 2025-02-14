CREATE OR REPLACE FORCE VIEW NPD_USUARIO(
   COD_USUARIO
 , NOM_USUARIO
 , LOGIN_USUARIO
 , CLA_USUARIO
 , EMAIL_USUARIO
 , TIP_USUARIO
 , CAT_USUARIO
 , COD_TIPO_CANAL
 , EST_USUARIO
 ) AS 
select u.cod_usuario, u.nom_usuario || ' ' || u.app_usuario  || ' ' || u.apm_usuario nom_usuario,
u.uid_usuario login_usuario, u.pwd_usuario cla_usuario, u.email_usuario,
u.cod_tipo_usuario tip_usuario,  utc.cat_usuario, utc.cod_tipo_canal, u.est_usuario
from psd_usuario u, npt_usuario_tipo_canal utc
where utc.cod_usuario = u.cod_usuario
with check option
/
SHOW ERRORS
