CREATE OR REPLACE PACKAGE ve_validavendedor_pg
IS
    /*
   <Documentaci�n
      TipoDoc = "Package">
      <Elemento
          Nombre = "VE_VALIDAVENDEDOR_PG"
          Lenguaje="PL/SQL"
          Fecha="01-09-2005"
          Versi�n="1.0"
          Dise�ador="Rayen Ceballos"
          Programador="Roberto P�rez"
		  Modificado por="H�ctor P�rez Guzm�n"
          Ambiente Desarrollo="BD">
          <Retorno>NA</Retorno>
          <Descripci�n>Package negocio de validacion de vendedor</Descripci�n>
          <Par�metros>
             <Entrada>NA</Entrada>
             <Salida>NA</Salida>
          </Par�metros>
       </Elemento>
      </Documentaci�n>
   */
    SUBTYPE cod_vendealer IS ve_vendealer.cod_vendealer%TYPE;

--------------------------------------------------------------------------------------------------------
    PROCEDURE ve_valida_pr (
        ev_codvendealer     IN               ve_vendealer.cod_vendealer%TYPE,
        ev_canalvendedor    IN               VARCHAR2,
        sn_cod_retorno      OUT NOCOPY       ge_errores_td.cod_msgerror%TYPE,
        sv_mens_retorno     OUT NOCOPY       ge_errores_td.det_msgerror%TYPE,
        sn_num_evento       OUT NOCOPY       ge_errores_pg.evento
    );

--------------------------------------------------------------------------------------------------------
END ve_validavendedor_pg;
/
SHOW ERRORS