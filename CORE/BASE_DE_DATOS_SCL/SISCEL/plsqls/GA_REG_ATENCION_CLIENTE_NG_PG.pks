CREATE OR REPLACE PACKAGE ga_reg_atencion_cliente_ng_pg
/*
<Documentaci�n
   TipoDoc = "Package">
   <Elemento
       Nombre = "GA_REG_ATENCION_CLIENTE_NG_PG"
       Lenguaje="PL/SQL"
       Fecha="18-06-2005"
       Versi�n="1.0"
       Dise�ador="Carlos Navarro H. - Marcelo Godoy S."
       Programador="Marcelo Godoy S. - Carlos Navarro H."
       Ambiente Desarrollo="BD">
       <Retorno>NA</Retorno>
       <Descripci�n>Package negocio de insercion al registro del atencion al cliente</Descripci�n>
       <Par�metros>
          <Entrada>NA</Entrada>
          <Salida>NA</Salida>
       </Par�metros>
    </Elemento>
   </Documentaci�n>
*/
IS

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE ga_inserta_reg_atencion_pr (
   EN_num_celular      IN            ga_abocel.num_celular%TYPE,
   EN_cod_atencion     IN            ci_reg_atencion_clientes.cod_atencion%TYPE,
   EV_obs_atencion     IN            ci_reg_atencion_clientes.obs_atencion%TYPE,
   EV_nom_usuario      IN            ci_reg_atencion_clientes.nom_usuarora%TYPE,
   EV_cod_oficina      IN       	 ci_reg_atencion_clientes.cod_oficina%TYPE,
   SN_cod_retorno      OUT NOCOPY    ge_errores_td.cod_msgerror%TYPE,
   SV_mens_retorno     OUT NOCOPY    ge_errores_td.det_msgerror%TYPE,
   SN_num_evento       OUT NOCOPY    ge_errores_pg.Evento
);

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
END ga_reg_atencion_cliente_ng_pg;
/
SHOW ERRORS
