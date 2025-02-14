CREATE OR REPLACE PACKAGE        gr_pac_arpu_contrato AS
  PROCEDURE ejecuta_sql(p_sql   in     varchar2,
			      p_resul in out number);
  PROCEDURE extrae (p_desde   in     number,
                    p_hasta   in     number,
                    p_ciclo   in     number,
                    p_tabla   in     varchar2,
                    arch_err  in out utl_file.file_type);
  PROCEDURE pondera_clientes(arch_err  in out utl_file.file_type);
  PROCEDURE llena_archivo(arch_err in out utl_file.file_type);
  PROCEDURE principal (v_parametro in     varchar2,
		       arch_err    in out utl_file.file_type);
end gr_pac_arpu_contrato;
/
SHOW ERRORS
