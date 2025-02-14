CREATE OR REPLACE PACKAGE        pv_plan_freedom_pk is

function pv_verifica_plan_freedom_fn(p_vcod_cliente in number) return varchar2;
function pv_es_plan_freedom_fn(p_vcod_plantarif in varchar) return varchar2;

end pv_plan_freedom_pk;
/
SHOW ERRORS
