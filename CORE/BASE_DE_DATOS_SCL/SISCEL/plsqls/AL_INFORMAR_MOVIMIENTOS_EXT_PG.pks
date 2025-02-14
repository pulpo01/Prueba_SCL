CREATE OR REPLACE PACKAGE AL_INFORMAR_MOVIMIENTOS_EXT_PG
/*
<Documentación TipoDoc = "Package">
<Elemento Nombre = "AL_INFORMAR_MOVIMIENTOS_EXT_PG"
Lenguaje="PL/Sql" 
Fecha="20-01-2010" 
Version="1.0" 
Diseñador="****" 
Programador="Luis Munoz" 
Ambiente="BD">
<Retorno>NA</Retorno>
<Descripción>PKG  encargado de informar a movimientos a ente externo</Descripción> 
<Parámetros>
    <Entrada>    </Entrada>
    <Salida>     </Salida>
</Parámetros>
</Elemento>
</Documentación>
*/
--
IS 
  TYPE REFCURSOR             IS REF CURSOR;
  CN_cero               CONSTANT   NUMBER :=0;
  CV_version            CONSTANT   VARCHAR2(5):='1.0'; 
  CV_error_no_clasif    CONSTANT   VARCHAR2(30):='Error no clasificado';
  CV_cod_modulo         CONSTANT   ged_parametros.cod_modulo%TYPE:='AL'; 
  CN_largoquery            CONSTANT   NUMBER:=3000;
  CN_largoerrtec        CONSTANT   NUMBER:=500;
  CN_largodesc            CONSTANT   NUMBER:=1000;
  CN_pend_informar      CONSTANT   NUMBER:=0;
  CN_en_proceso         CONSTANT   NUMBER:=1; 
  CN_informado          CONSTANT   NUMBER:=2;
  CN_leido              CONSTANT   NUMBER:=1;
  CN_leido_noenv        CONSTANT   NUMBER:=3; 
  CN_renovacion         CONSTANT   NUMBER:=4;
  CN_venta              CONSTANT   NUMBER:=1;
  CN_cambios              CONSTANT   NUMBER:=3;
  CN_canje              CONSTANT   NUMBER:=2;
  CN_seguro              CONSTANT   NUMBER:=5;
   --
PROCEDURE  AL_OBTENER_MOVIMIENTOS_PR
 (
  EV_fecha_desde       IN VARCHAR2,
  EV_fecha_hasta       in VARCHAR2,
  sn_cod_retorno       OUT NOCOPY  ge_errores_td.cod_msgerror%TYPE,
  sv_mens_retorno      OUT NOCOPY  ge_errores_td.det_msgerror%TYPE,
  sn_num_evento        OUT NOCOPY  ge_errores_pg.evento);
PROCEDURE AL_INFORMAR_MOV_SCL_PR
 (
  EV_fecha_desde       IN VARCHAR2,
  EV_fecha_hasta       in VARCHAR2,
  sn_cod_retorno       OUT NOCOPY  ge_errores_td.cod_msgerror%TYPE,
  sv_mens_retorno      OUT NOCOPY  ge_errores_td.det_msgerror%TYPE,
  sn_num_evento        OUT NOCOPY  ge_errores_pg.evento);

END AL_INFORMAR_MOVIMIENTOS_EXT_PG;
/
SHOW ERRORS

