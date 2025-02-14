sqlplus -s /  @${XPF_SQL}/p_venweb_new
#
sqlplus -s /  << 'EOF'
update  fa_intqueueproc
set     cod_estado = 1
where   cod_proceso = 916
and     cod_modgener = 'ECM';
commit;
end;

EOF

