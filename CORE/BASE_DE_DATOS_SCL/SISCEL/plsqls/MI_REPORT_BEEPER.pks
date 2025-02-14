CREATE OR REPLACE PACKAGE        MI_REPORT_BEEPER
 AS
Procedure proc_principal(fec_inicial in varchar2,
                         fec_final in varchar2,
                         path in varchar2);
Procedure proc_suspe_beeper(v_inicial in  varchar2,
                            v_final in  varchar2,
                            tabla in  varchar2,
                            direccion in varchar2,
                            v_error in out number);
Procedure proc_repo_beeper(v_inicial in  varchar2,
                            v_final in  varchar2,
                            tabla in  varchar2,
                            direccion in varchar2,
                            v_error in out number);
Procedure proc_suspe_trunk(v_inicial in  varchar2,
                            v_final in  varchar2,
                            tabla  in varchar2,
                            direccion in varchar2,
                            v_error  in out number);
Procedure proc_repo_trunk(v_inicial in  varchar2,
                            v_final in  varchar2,
                            tabla in varchar2,
                            direccion in varchar2,
                            v_error  in out number);
END;
/
SHOW ERRORS
