CREATE OR REPLACE PACKAGE        GR_PAC_ARPUPREPAGO AS
  PROCEDURE sube_comverse (nombre in     varchar2,
                           arch   in out utl_file.file_type);
  PROCEDURE principal(v_parametro in     varchar2,
                      arch_err    in out utl_file.file_type);
  PROCEDURE pone_series(v_fecmax in     date,
                        arch_err in out utl_file.file_type);
  PROCEDURE pone_aboamist(arch_err in out utl_file.file_type);
  PROCEDURE limpia_psd(arch_err in out utl_file.file_type);
  PROCEDURE carga_pivote(v_fecha in     date,
                         arch    in out utl_file.file_type);
end GR_PAC_ARPUPREPAGO;
/
SHOW ERRORS
