CREATE OR REPLACE PACKAGE pv_nro_piloto_pg
IS
    --Declaracion de Variables Globales  
    cv_error_no_clasif      CONSTANT VARCHAR2(50) := 'No Es Posible Recuperar Error Clasificado';
   
    type trecord is record(
         num_abonado_seq number,
         num_celular     number
     );
    type trecord_tab is table of trecord index by binary_integer;
    LN_record trecord_tab;
      
    LN_indice     integer:=0;
    LN_count      integer:=0;
    LN_numero     number;
    LN_num_abonado ga_abocel.num_abonado%type;   
    LN_num_celular ga_abocel.num_celular%type;      
    V_des_error   varchar(200);
    Ssql          varchar(200); 
   PROCEDURE pv_numero_piloto_pr(SN_num_venta       IN  ga_abocel.num_venta%TYPE,
                                 SN_cod_retorno     OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                                 SV_mens_retorno    OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                                 SN_num_evento      OUT NOCOPY ge_errores_pg.evento);
   PROCEDURE pv_abocel_pr(SN_num_abonado     IN  ga_abocel.num_abonado%TYPE,
                           --SN_num_piloto      IN  ga_nro_piloto_rango_to.num_piloto%TYPE,
                           SN_num_desde       IN  ga_rangos_fijos_to.num_desde%TYPE,
                           SN_cod_retorno     OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                           SV_mens_retorno    OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                           SN_num_evento      OUT NOCOPY ge_errores_pg.evento);                           
   PROCEDURE pv_equipaboser_pr(SN_num_abonado     IN  ga_abocel.num_abonado%TYPE,
                                SN_cod_retorno     OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                                SV_mens_retorno    OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                                SN_num_evento      OUT NOCOPY ge_errores_pg.evento);
   PROCEDURE pv_limite_cliabo_pr(SN_num_abonado     IN  ga_abocel.num_abonado%TYPE,
                                 SN_cod_retorno     OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                                 SV_mens_retorno    OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                                 SN_num_evento      OUT NOCOPY ge_errores_pg.evento);
   PROCEDURE pv_intarcel_acciones_pr(SN_num_abonado     IN  ga_abocel.num_abonado%TYPE,
                                     SN_cod_retorno     OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                                     SV_mens_retorno    OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                                     SN_num_evento      OUT NOCOPY ge_errores_pg.evento);
   PROCEDURE pv_intarcel_pr(SN_num_abonado     IN  ga_abocel.num_abonado%TYPE,
                            SN_cod_retorno     OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                            SV_mens_retorno    OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                            SN_num_evento      OUT NOCOPY ge_errores_pg.evento);
   PROCEDURE pv_infaccel_pr(SN_num_abonado     IN  ga_abocel.num_abonado%TYPE,
                            SN_cod_retorno     OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                            SV_mens_retorno    OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                            SN_num_evento      OUT NOCOPY ge_errores_pg.evento);
   PROCEDURE pv_servsuplabo_pr(SN_num_abonado     IN  ga_abocel.num_abonado%TYPE,
                               SN_cod_retorno     OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                               SV_mens_retorno    OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                               SN_num_evento      OUT NOCOPY ge_errores_pg.evento);    
   PROCEDURE pv_rangos_numericos_pr(SN_num_abonado     IN  ga_abocel.num_abonado%TYPE,
                                    SN_num_desde       IN  ga_rangos_fijos_to.num_desde%TYPE,
                                    SN_cod_retorno     OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                                    SV_mens_retorno    OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                                    SN_num_evento      OUT NOCOPY ge_errores_pg.evento);
   PROCEDURE pv_baja_nropiloto_pr(SN_num_abonado     IN  ga_abocel.num_abonado%TYPE,
                                  SV_cod_causa       IN  ga_abocel.cod_causabaja%TYPE,
                                  SN_num_desde       IN  ga_rangos_fijos_to.num_desde%TYPE,
                                  SN_cod_retorno     OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                                  SV_mens_retorno    OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                                  SN_num_evento      OUT NOCOPY ge_errores_pg.evento);
   PROCEDURE pv_enlace_vpn_rango_pr(SN_cod_retorno     OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                                    SV_mens_retorno    OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                                    SN_num_evento      OUT NOCOPY ge_errores_pg.evento);                            
   PROCEDURE pv_borra_nropiloto_pr(SN_num_piloto      IN  ga_nro_piloto_rango_to.num_piloto%TYPE,
                                   SN_num_desde       IN  ga_rangos_fijos_to.num_desde%TYPE,
                                  SN_cod_retorno     OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                                  SV_mens_retorno    OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                                  SN_num_evento      OUT NOCOPY ge_errores_pg.evento);
   PROCEDURE pv_ciclocli_pr(SN_num_abonado     IN  ga_abocel.num_abonado%TYPE,
                            SN_cod_retorno     OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                            SV_mens_retorno    OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                            SN_num_evento      OUT NOCOPY ge_errores_pg.evento);                                     
       
END;
/
SHOW ERRORS