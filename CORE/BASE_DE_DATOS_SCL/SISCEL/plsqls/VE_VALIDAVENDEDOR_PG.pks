CREATE OR REPLACE PACKAGE ve_validavendedor_pg
IS
    /*
   <Documentación
      TipoDoc = "Package">
      <Elemento
          Nombre = "VE_VALIDAVENDEDOR_PG"
          Lenguaje="PL/SQL"
          Fecha="01-09-2005"
          Versión="1.0"
          Diseñador="Rayen Ceballos"
          Programador="Roberto Pérez"
		  Modificado por="Héctor Pérez Guzmán"
          Ambiente Desarrollo="BD">
          <Retorno>NA</Retorno>
          <Descripción>Package negocio de validacion de vendedor</Descripción>
          <Parámetros>
             <Entrada>NA</Entrada>
             <Salida>NA</Salida>
          </Parámetros>
       </Elemento>
      </Documentación>
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