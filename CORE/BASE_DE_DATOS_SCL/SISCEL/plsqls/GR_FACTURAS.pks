CREATE OR REPLACE PACKAGE        GR_FACTURAS AS
  PROCEDURE proc_empresa(v_parametro in     varchar2,
                         arch_err    in out utl_file.file_type,
			 arch_in     in out utl_file.file_type);
  PROCEDURE proc_individual(v_parametro in     varchar2,
                            arch_err    in out utl_file.file_type,
                            arch_in     in out utl_file.file_type);
  PROCEDURE extrae (p_desde   in     number,
                    p_hasta   in     number,
                    p_ciclo   in     number,
                    p_tabla   in     varchar2,
                    arch_err  in out utl_file.file_type);
  PROCEDURE pivote_empresa(arch_ok  in out utl_file.file_type,
			   arch_err in out utl_file.file_type);
  PROCEDURE pivote_individual(arch_ok  in out utl_file.file_type,
			      arch_err in out utl_file.file_type);
end gr_facturas;
/
SHOW ERRORS
