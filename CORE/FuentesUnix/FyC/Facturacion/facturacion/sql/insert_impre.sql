delete from fa_imp_factimpre
where cod_fuente in (225, 226)
/
commit
/
delete from fa_imp_impresion
where cod_fuente in (225, 226)
/
commit
/
insert into fa_imp_impresion
values (225, 'Literal Numero de Terminal')
/
insert into fa_imp_impresion
values (226, 'Numero de Terminal')
/
commit
/
insert into fa_imp_factimpre
values (225, 319)
/
insert into fa_imp_factimpre
values (226, 320)
/
commit
/
delete from fa_imp_formulario
where cod_formulario = 1
/
commit;
exit;
