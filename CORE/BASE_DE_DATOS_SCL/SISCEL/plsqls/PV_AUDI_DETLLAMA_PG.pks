CREATE OR REPLACE package pv_audi_detllama_pg
is
   type refcursor is ref cursor;
   cv_error_no_clasif      constant varchar2 (50) := 'No es posible clasificar el error';
   cv_cod_modulo           constant varchar2 (2)  := 'GA';
   cv_cod_modulo_ge        constant varchar2 (2)  := 'GE';
   cv_version              constant varchar2 (2)  := '1';
   cv_gsformato2           constant varchar2 (20) := 'FORMATO_SEL2';
   cv_gsformato4           constant varchar2 (20) := 'FORMATO_SEL4';
   cv_gsformato7           constant varchar2 (20) := 'FORMATO_SEL7';
   
   cv_estado_pd            constant varchar2 (2)  := 'PD';
 
   cv_cod_aplic            constant varchar2 (3)  := 'PVA';
   cn_producto             constant number(1)        := 1;

 
   cn_0                    constant number (1)     :=  0;
   cv_0                    constant varchar2 (1)   := '0';
   cv_1                    constant varchar2 (1)   := '1';
   
------------------------------------------------------------------------------------------------------

        procedure pv_regis_audidetllam_pr(       eo_nom_usuario          in ge_seg_usuario.nom_usuario%type,
                                                 eo_cod_vendedor         in ge_seg_usuario.cod_vendedor%type,  
                                                 eo_cod_oficina          in ge_seg_usuario.cod_oficina%type,
                                                 eo_cod_cliente          in ga_abocel.cod_cliente%type,       
                                                 eo_num_abonado          in ga_abocel.num_abonado%type,
                                                 eo_rango_ini            in varchar2,
                                                 eo_rango_fin            in varchar2,
                                                 eo_ind_consulta         in number,
                                                 eo_cod_os               in varchar2,
                                                 sn_cod_retorno          out nocopy  ge_errores_td.cod_msgerror%type,
                                                 sv_mens_retorno         out nocopy  ge_errores_td.det_msgerror%type,
                                                 sn_num_evento           out nocopy  ge_errores_pg.evento);

------------------------------------------------------------------------------------------------------

end pv_audi_detllama_pg; 
/
SHOW ERRORS