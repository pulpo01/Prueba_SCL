CREATE OR REPLACE PACKAGE ga_cons_atlantida_fs_pg
/*
<Documentaci�n
   TipoDoc = "Package">
   <Elemento
       Nombre = "GA_CONS_ATLANTIDA_FS_PG"
       Lenguaje="PL/SQL"
       Fecha="02-06-2006"
       Versi�n="1.0"
       Dise�ador="Carlos Navarro H."
       Programador="Carlos Navarro H."
       Ambiente Desarrollo="BD">
       <Retorno>NA</Retorno>
       <Descripci�n>Package fachada de llamada a Servicios Atlantida</Descripci�n>
       <Par�metros>
          <Entrada>NA</Entrada>
          <Salida>NA</Salida>
       </Par�metros>
    </Elemento>
   </Documentaci�n>
*/
IS
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   PROCEDURE ga_cons_atlantida_abonado_pr (
      en_num_celular    IN              ga_cons_atlantida_pg.ga_num_celular,
      sv_servicio       OUT NOCOPY      VARCHAR2,
      sv_cod_servicio   OUT NOCOPY      ga_cons_atlantida_pg.ga_cod_servicio,
      sv_des_servicio   OUT NOCOPY      ga_cons_atlantida_pg.ga_des_servicio,
      sn_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento
   );

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   PROCEDURE ga_cons_atlantida_cliente_pr (
      en_cod_cliente    IN              ga_cons_atlantida_pg.ga_cod_cliente,
      sv_servicio       OUT NOCOPY      VARCHAR2,
      sv_cod_servicio   OUT NOCOPY      ga_cons_atlantida_pg.ga_cod_servicio,
      sv_des_servicio   OUT NOCOPY      ga_cons_atlantida_pg.ga_des_servicio,
      sn_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento
   );
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------}
END ga_cons_atlantida_fs_pg;
/
SHOW ERRORS
