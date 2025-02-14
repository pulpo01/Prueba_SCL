alter session set nls_date_format = 'yyyymmddhh24miss';
insert into fa_trazaproc
values (&ciclfact, &proceso, &status, '&fec_ini', '&fec_fin', '&obs', '', '' , '');
commit;
exit;
