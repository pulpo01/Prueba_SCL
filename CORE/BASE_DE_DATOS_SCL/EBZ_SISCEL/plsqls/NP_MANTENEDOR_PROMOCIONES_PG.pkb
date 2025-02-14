CREATE OR REPLACE PACKAGE BODY NP_MANTENEDOR_PROMOCIONES_PG IS
--------------------------------------------------------------------------------------------------------
procedure np_existe_descprom_pr (
 EN_cod_promocion IN npt_promocion_td.cod_promocion%TYPE,
 EV_des_promocion IN npt_promocion_td.des_promocion%TYPE,
 SN_cod_error	  OUT NOCOPY NUMBER,
 SV_mensaje		  OUT NOCOPY VARCHAR2) as

LN_cod_promocion  npt_promocion_td.cod_promocion%TYPE;
begin

   SN_cod_error:=0;
   SV_mensaje:='0';
   LN_cod_promocion:=0;
   select cod_promocion into LN_cod_promocion
     from NPT_PROMOCION_TD
    where upper(des_promocion)=upper(EV_des_promocion);

	if LN_cod_promocion<>EN_cod_promocion then
	   SN_cod_error:=1;
	   SV_mensaje:='Ya existe una promoción con la descripción ingresada.';
    else
	   if LN_cod_promocion=0 then
	      SN_cod_error:=2;
	      SV_mensaje:='La promoción SIN PROMOCION no puede ser modificada.';
	   end if;
	end if;

exception
when no_data_found then
   null;
when too_many_rows then
      SN_cod_error:=1;
	  SV_mensaje:='Ya existe una promoción con la descripción ingresada.';
when others then
   SN_cod_error:=SQLCODE;
   SV_mensaje:=SUBSTR(sqlerrm,1,200);
end;
--------------------------------------------------------------------------------------------------------
function np_valida_art_existe_fn(EN_cod_promocion  IN npt_prom_articulo_td.cod_promocion%TYPE,
		 					  EN_cod_articulo   IN npt_prom_articulo_td.cod_articulo%TYPE)
          RETURN BOOLEAN as
LN_total  number;
begin
    LN_total:=0;
    select count(1) into LN_total
	  from npt_prom_articulo_td a where a.cod_promocion=EN_cod_promocion
		   					        and a.cod_articulo =EN_cod_articulo;

	IF LN_total > 0 then
    	RETURN TRUE;
	end if;
 	RETURN FALSE;

exception
when others then
   RETURN TRUE;

end;
--------------------------------------------------------------------------------------------------------
procedure np_promocion_utilizada_cli_pr(
EN_cod_promocion  IN npt_promocion_td.cod_promocion%TYPE,
EN_cod_usuario    IN npt_prom_cliente_td.cod_usuario%TYPE,
SN_cod_error	  OUT NOCOPY NUMBER,
SV_mensaje		  OUT NOCOPY VARCHAR2) as

LN_total  number(15);
begin
    LN_total:=0;
	SN_cod_error:=0;
	SV_mensaje:='0';
    select count(1) into LN_total
	  from npt_pedido a where a.cod_promocion=EN_cod_promocion
	  and a.cod_usuario_cre=EN_cod_usuario;
	if LN_total > 0 then
	   SN_cod_error:=1;
	   SV_mensaje:='la promoción ha sido utilizada por el cliente en algún pedido.';
	end if;

exception
when others then
   SN_cod_error:=SQLCODE;
   SV_mensaje:=SUBSTR(sqlerrm,1,200);
end;
--------------------------------------------------------------------------------------------------------
procedure np_promocion_utilizada_pr(
EN_cod_promocion  IN npt_promocion_td.cod_promocion%TYPE,
SN_cod_error	  OUT NOCOPY NUMBER,
SV_mensaje		  OUT NOCOPY VARCHAR2) as

LN_total  number(15);
begin
    LN_total:=0;
	SN_cod_error:=0;
	SV_mensaje:='0';
    select count(1) into LN_total
	  from npt_pedido a where a.cod_promocion=EN_cod_promocion;
	if LN_total > 0 then
	   SN_cod_error:=1;
	   SV_mensaje:='La promoción ha sido utilizada en algún pedido.';
	end if;

exception
when others then
   SN_cod_error:=SQLCODE;
   SV_mensaje:=SUBSTR(sqlerrm,1,200);
end;
--------------------------------------------------------------------------------------------------------
procedure np_articulo_utilizado_pr
(EN_cod_promocion IN npt_prom_articulo_td.cod_promocion%TYPE,
 EN_cod_articulo  IN npt_prom_articulo_td.cod_articulo%TYPE,
 SN_cod_error	  OUT NOCOPY NUMBER,
 SV_mensaje		  OUT NOCOPY VARCHAR2) as

LN_total  number(18);
begin
    LN_total:=0;
	SN_cod_error:=0;
	SV_mensaje:='0';
    select count(1) into LN_total
	  from npt_pedido a, npt_detalle_pedido b,npt_prom_articulo_td c
	 where a.cod_promocion=EN_cod_promocion and
	       a.cod_pedido=b.cod_pedido and
		   c.cod_promocion=a.cod_promocion and
		   b.cod_articulo=EN_cod_articulo and
		   b.cod_articulo=c.cod_articulo;
	if LN_total > 0 then
       SN_cod_error:=1;
	   SV_mensaje:='un articulo que ha sido utilizado en algún pedido';
	end if;


exception
when others then
   SN_cod_error:=SQLCODE;
   SV_mensaje:=SUBSTR(sqlerrm,1,200);
end;
/*
--------------------------------------------------------------------------------------------------------
function NP_VALIDA_PROMOCION_fn(
   EN_cod_promocion             IN npt_promocion_td.cod_promocion%TYPE,
   SN_cod_error					OUT NOCOPY NUMBER,
   SV_mensaje					OUT NOCOPY VARCHAR2) RETURN BOOLEAN as

LN_total  number;
begin
    SV_mensaje:='0';
    SN_cod_error:=0;
    LN_total:=0;

	if not np_valida_prom_vigente_fn(EN_cod_promocion) then
	   SV_mensaje:='La promoción no se encuentra vigente';
	   SN_cod_error:=1;
	   RETURN FALSE;
	end if;
 	RETURN TRUE;

exception
when others then
   SN_cod_error:=SQLCODE;
   SV_mensaje:=SUBSTR(sqlerrm,1,200);
   RETURN FALSE;
end;
*/
--------------------------------------------------------------------------------------------------------
procedure NP_INS_PROMOCION_PR(
   EV_des_promocion             IN npt_promocion_td.des_promocion%TYPE,
   EV_fec_ini_vigencia			IN varchar2,
   EV_fec_fin_vigencia			IN varchar2,
   EV_usu_creacion				IN npt_promocion_td.usua_creacion%TYPE,
   SN_cod_promocion				OUT NOCOPY NUMBER,
   SN_cod_error					OUT NOCOPY NUMBER,
   SV_mensaje					OUT NOCOPY VARCHAR2) as
le_error  exception;
begin
   SN_cod_error:=0;
   SV_mensaje:='0';
   SN_cod_promocion:=0;

   insert into NPT_PROMOCION_TD (cod_promocion, des_promocion,
	   						  fec_ini_vigencia,fec_fin_vigencia,
							  fec_creacion,usua_creacion,fec_actualiza,usua_actualiza)
					values (npt_promocion_sq.nextval,EV_des_promocion,
						    to_date(EV_fec_ini_vigencia,'dd-mm-yyyy'),to_date(EV_fec_fin_vigencia,'dd-mm-yyyy'),
							sysdate,EV_usu_creacion,null,null)
   RETURNING cod_promocion
   INTO SN_cod_promocion;

exception
when le_error then
     null;
when others then
   SN_cod_error:=SQLCODE;
   SV_mensaje:=SUBSTR(sqlerrm,1,200);
end;
--------------------------------------------------------------------------------------------------------
procedure NP_INS_PROMOCION_HIST_PR(
   EN_cod_promocion             IN npt_promocion_td.cod_promocion%TYPE,
   EV_accion					IN npt_promocion_th.cod_accion%TYPE,
   EV_usua_actualiza			IN npt_promocion_th.usua_actualiza%TYPE,
   SN_cod_error					OUT NOCOPY NUMBER,
   SV_mensaje					OUT NOCOPY VARCHAR2) as
begin

   SN_cod_error:=0;
   SV_mensaje:='0';
   insert into NPT_PROMOCION_TH
   select a.cod_promocion, a.des_promocion,
	   	  a.fec_ini_vigencia,a.fec_fin_vigencia,
		  a.fec_creacion,a.usua_creacion,sysdate,EV_usua_actualiza,EV_accion 
   from NPT_PROMOCION_TD a where a.cod_promocion=EN_cod_promocion;
exception
when others then
   SN_cod_error:=SQLCODE;
   SV_mensaje:=SUBSTR(sqlerrm,1,200);
end;
--------------------------------------------------------------------------------------------------------
procedure NP_INS_PROM_ARTICULO_PR(
   EN_cod_promocion             IN npt_prom_articulo_td.cod_promocion%TYPE,
   EN_cod_articulo              IN npt_prom_articulo_td.cod_articulo%TYPE,
   EV_prc_articulo   			IN VARCHAR2,
   EV_usu_creacion				IN npt_promocion_td.usua_creacion%TYPE,
   SN_cod_error					OUT NOCOPY NUMBER,
   SV_mensaje					OUT NOCOPY VARCHAR2) as

LE_error     exception;
LN_precio    npt_prom_articulo_td.prc_articulo%TYPE;
begin
   SN_cod_error:=0;
   SV_mensaje:='0';

   LN_precio:=to_number(EV_prc_articulo);
   insert into NPT_PROM_ARTICULO_TD (cod_promocion, cod_articulo,prc_articulo,
		                             fec_creacion,usua_creacion,fec_actualiza,usua_actualiza,ind_actualiza)
					values (EN_cod_promocion,EN_cod_articulo,LN_precio,
					    sysdate,EV_usu_creacion,null,null,2);
exception
WHEN DUP_VAL_ON_INDEX then
     begin
	    UPDATE NPT_PROM_ARTICULO_TD
	       SET IND_ACTUALIZA=1, prc_articulo=LN_precio
	     WHERE cod_promocion=EN_cod_promocion AND cod_articulo=EN_cod_articulo;
     exception
	 when others then
	    UPDATE NPT_PROM_ARTICULO_TD
	       SET IND_ACTUALIZA=1
	     WHERE cod_promocion=EN_cod_promocion AND cod_articulo=EN_cod_articulo;
	 end;
when others then
   SN_cod_error:=SQLCODE;
   SV_mensaje:=SUBSTR(sqlerrm,1,200);
end;
--------------------------------------------------------------------------------------------------------
procedure NP_INS_PROM_CLIENTE_PR(
   EN_cod_promocion             IN npt_prom_cliente_td.cod_promocion%TYPE,
   EN_cod_usuario               IN npt_prom_cliente_td.cod_usuario%TYPE,
   EV_usu_creacion				IN npt_prom_cliente_td.usua_creacion%TYPE,
   SN_cod_error					OUT NOCOPY NUMBER,
   SV_mensaje					OUT NOCOPY VARCHAR2) as
begin

   SN_cod_error:=0;
   SV_mensaje:='0';
   insert into NPT_PROM_CLIENTE_TD (cod_promocion, cod_usuario,
    	                            fec_creacion,usua_creacion,fec_actualiza,usua_actualiza,ind_actualiza)
					values (EN_cod_promocion,EN_cod_usuario,
						    sysdate,EV_usu_creacion,null,null,2);
exception
WHEN DUP_VAL_ON_INDEX then
	 UPDATE NPT_PROM_CLIENTE_TD
	 SET IND_ACTUALIZA=1
	 WHERE cod_promocion=EN_cod_promocion AND cod_usuario=EN_cod_usuario;
when others then
   SN_cod_error:=SQLCODE;
   SV_mensaje:=SUBSTR(sqlerrm,1,200);
end;
--------------------------------------------------------------------------------------------------------
procedure NP_INS_PROM_ARTICULO_HIST_PR(
   EN_cod_promocion             IN npt_prom_articulo_td.cod_promocion%TYPE,
   EN_cod_articulo              IN npt_prom_articulo_td.cod_articulo%TYPE,
   EV_accion					IN npt_prom_articulo_th.cod_accion%TYPE,
   EV_usuario_act				IN npt_prom_articulo_th.usua_actualiza%TYPE,
   SN_cod_error					OUT NOCOPY NUMBER,
   SV_mensaje					OUT NOCOPY VARCHAR2) as
begin
   SN_cod_error:=0;
   SV_mensaje:='0';

   insert into NPT_PROM_ARTICULO_TH
   select a.cod_promocion, a.cod_articulo,a.prc_articulo,
		  a.fec_creacion,a.usua_creacion,sysdate,EV_usuario_act,EV_accion
   from NPT_PROM_ARTICULO_TD a where a.cod_promocion=EN_cod_promocion and
                                 a.cod_articulo=EN_cod_articulo;

exception
when others then
   SN_cod_error:=SQLCODE;
   SV_mensaje:=SUBSTR(sqlerrm,1,200);
end;
--------------------------------------------------------------------------------------------------------
procedure NP_INS_PROM_CLIENTE_HIST_PR(
   EN_cod_promocion             IN npt_prom_cliente_td.cod_promocion%TYPE,
   EN_cod_usuario               IN npt_prom_cliente_td.cod_usuario%TYPE,
   EV_accion					IN npt_prom_cliente_th.cod_accion%TYPE,
   EV_usua_actualiza			IN npt_prom_cliente_th.usua_actualiza%TYPE,
   SN_cod_error					OUT NOCOPY NUMBER,
   SV_mensaje					OUT NOCOPY VARCHAR2) as
begin
   SN_cod_error:=0;
   SV_mensaje:='0';
   insert into NPT_PROM_CLIENTE_TH
   select a.cod_promocion, a.cod_usuario,
		  a.fec_creacion,a.usua_creacion,sysdate,EV_usua_actualiza,EV_accion
   from NPT_PROM_CLIENTE_TD a where a.cod_promocion=EN_cod_promocion and
                                 a.cod_usuario=EN_cod_usuario;
exception
when others then
   SN_cod_error:=SQLCODE;
   SV_mensaje:=SUBSTR(sqlerrm,1,200);
end;
--------------------------------------------------------------------------------------------------------
procedure NP_DEL_PROMOCION_PR(
   EN_cod_promocion             IN npt_promocion_td.cod_promocion%TYPE,
   EV_usua_actualiza			IN npt_promocion_td.usua_actualiza%TYPE,
   SN_cod_error					OUT NOCOPY NUMBER,
   SV_mensaje					OUT NOCOPY VARCHAR2)  as
LE_error    EXCEPTION;
begin
   SN_cod_error:=0;
   SV_mensaje:='0';

   --Verificar si fue utilizada...
   np_promocion_utilizada_pr(EN_cod_promocion,SN_cod_error,SV_mensaje);
   if SN_cod_error<>0 then
      SN_cod_error:=1;
      SV_mensaje:='No puede eliminar la promoción dado que ha sido utilizada en un pedido';
      RAISE le_error;
   end if;
   NP_DEL_TODO_PROMOCION_PR(EN_cod_promocion,EV_usua_actualiza,SN_cod_error,SV_mensaje);

exception
when LE_error then
   null;
when others then
   SN_cod_error:=SQLCODE;
   SV_mensaje:=SUBSTR(sqlerrm,1,200);
end;
--------------------------------------------------------------------------------------------------------
/*
procedure NP_DEL_PROM_ARTICULO_PR(
   EN_cod_promocion             IN npt_prom_articulo_td.cod_promocion%TYPE,
   EN_cod_articulo				IN npt_prom_articulo_td.cod_articulo%TYPE,
   SN_cod_error					OUT NOCOPY NUMBER,
   SV_mensaje					OUT NOCOPY VARCHAR2)  as

LE_error    EXCEPTION;
EV_usuario_act varchar2(30);
begin
   SV_mensaje:='0';
   SN_cod_error:=0;
   EV_usuario_act:=null;
   --No puede eliminar un articulo si fue utilizado en un pedido...
   if np_articulo_utilizado_fn(EN_cod_promocion,EN_cod_articulo) then
      SN_cod_error:=1;
	  SV_mensaje:='El artículo no puede ser eliminado dado que ha sido utilizado en un pedido';
	  raise LE_error;
   end if;

   --No se puede eliminar el último articulo asociado.....
   if np_promocion_un_articulo_fn(EN_cod_promocion) then
	   if np_promocion_con_clientes_fn(EN_cod_promocion) then
	      SN_cod_error:=1;
		  SV_mensaje:='No es posible eliminar el artículo dado que la promoción posee clientes asociados';
		  raise LE_error;
	   end if;
   end if;

   NP_INS_PROM_ARTICULO_HIST_PR(EN_cod_promocion,EN_cod_articulo,'D',EV_usuario_act,SN_cod_error,SV_mensaje);
   IF SV_mensaje = '0' then
      DELETE  FROM NPT_PROM_ARTICULO_TD a
	  		  where a.cod_promocion=EN_cod_promocion AND
			        a.cod_articulo=EN_cod_articulo;
   ELSE
      raise LE_error;
   END IF;
exception
when LE_error then
   null;
when others then
   SN_cod_error:=SQLCODE;
   SV_mensaje:=SUBSTR(sqlerrm,1,200);
end;
--------------------------------------------------------------------------------------------------------
procedure NP_DEL_PROM_CLIENTE_PR(
   EN_cod_promocion             IN npt_prom_cliente_td.cod_promocion%TYPE,
   EN_cod_usuario				IN npt_prom_cliente_td.cod_usuario%TYPE,
   EV_usua_actualiza			IN npt_prom_cliente_td.usua_actualiza%TYPE,
   SN_cod_error					OUT NOCOPY NUMBER,
   SV_mensaje					OUT NOCOPY VARCHAR2) as

LE_error    EXCEPTION;
begin
   SN_cod_error:=0;
   SV_mensaje:='0';

   if np_promocion_utilizada_fn(EN_cod_promocion) then
      SN_cod_error:=1;
	  SV_mensaje:='No puede desasociar el cliente dado que la promoción ha sido utilizada en un pedido';
	  raise LE_error;
   end if;

   NP_INS_PROM_CLIENTE_HIST_PR(EN_cod_promocion,EN_cod_usuario,'D',EV_usua_actualiza,SN_cod_error,SV_mensaje);
   IF SV_mensaje ='0' then
      DELETE  FROM NPT_PROM_CLIENTE_TD a
	  		  where a.cod_promocion=EN_cod_promocion AND
			        a.cod_usuario=EN_cod_usuario;
   ELSE
      raise LE_error;
   END IF;
exception
when LE_error then
   null;
when others then
   SN_cod_error:=SQLCODE;
   SV_mensaje:=SUBSTR(sqlerrm,1,200);
end;
*/
--------------------------------------------------------------------------------------------------------
procedure NP_DEL_TODO_PROMOCION_PR(
   EN_cod_promocion             IN npt_promocion_td.cod_promocion%TYPE,
   EV_usua_actualiza			IN npt_promocion_td.usua_actualiza%TYPE,
   SN_cod_error					OUT NOCOPY NUMBER,
   SV_mensaje					OUT NOCOPY VARCHAR2) as


le_error exception;

begin
   SV_mensaje:='0';
   SN_cod_error:=0;


   insert into NPT_PROM_CLIENTE_TH
   select a.cod_promocion, a.cod_usuario,
		  a.fec_creacion,a.usua_creacion,sysdate,EV_usua_actualiza,'D'
   from NPT_PROM_CLIENTE_TD a where a.cod_promocion=EN_cod_promocion;
   delete from NPT_PROM_CLIENTE_TD a where a.cod_promocion=EN_cod_promocion;


   insert into NPT_PROM_ARTICULO_TH
   select a.cod_promocion, a.cod_articulo,a.prc_articulo,
		  a.fec_creacion,a.usua_creacion,sysdate,EV_usua_actualiza,'D'
   from NPT_PROM_ARTICULO_TD a where a.cod_promocion=EN_cod_promocion;
   delete from NPT_PROM_ARTICULO_TD a where a.cod_promocion=EN_cod_promocion;


   --borrando cabecera
   insert into NPT_PROMOCION_TH
   select a.cod_promocion, a.des_promocion,
	   	  a.fec_ini_vigencia,a.fec_fin_vigencia,
		  a.fec_creacion,a.usua_creacion,sysdate,EV_usua_actualiza,'D'
   from NPT_PROMOCION_TD a where a.cod_promocion=EN_cod_promocion;

   delete from  NPT_PROMOCION_TD a where a.cod_promocion=EN_cod_promocion;



exception
when le_error then
        null;
when others then
   SN_cod_error:=SQLCODE;
   SV_mensaje:=SUBSTR(sqlerrm,1,200);
end;
--------------------------------------------------------------------------------------------------------
procedure NP_MOD_PROM_ARTICULO_PR(
   EN_cod_promocion             IN npt_prom_articulo_td.cod_promocion%TYPE,
   EV_usuario_act				IN npt_prom_articulo_td.usua_actualiza%TYPE,
   SN_cod_error					OUT NOCOPY NUMBER,
   SV_mensaje					OUT NOCOPY VARCHAR2) as

le_error   exception;

cursor clientes(EN_cod_promocion in number) is
select ind_actualiza,cod_articulo from   npt_prom_articulo_td where cod_promocion=EN_cod_promocion;

begin
   --Verificar si está vencida....
   --Verificar si el artículo fue utilizado....
   SV_mensaje:='0';
   SN_cod_error:=0;
   for c1 in clientes(EN_cod_promocion) loop
   begin
       if c1.ind_actualiza = 2 then --nuevo....
	      NP_INS_PROM_ARTICULO_HIST_PR(EN_cod_promocion,c1.cod_articulo,'I',EV_usuario_act,SN_cod_error,SV_mensaje);
		  if SV_mensaje<>'0' then
		     SV_mensaje:='0';
   			 SN_cod_error:=0;
		  end if;
	   else
          if c1.ind_actualiza is null then ---eliminar....
		      NP_INS_PROM_ARTICULO_HIST_PR(EN_cod_promocion,c1.cod_articulo,'D',EV_usuario_act,SN_cod_error,SV_mensaje);
		      if SV_mensaje<>'0' then
		         SV_mensaje:='0';
   			     SN_cod_error:=0;
		      end if;

		      DELETE  FROM NPT_PROM_ARTICULO_TD a
	  		  where a.cod_promocion=EN_cod_promocion AND
			        a.cod_articulo=C1.cod_articulo;
		  end if;
	   end if;

   exception
   when others then
        null;
   end;
   end loop;

   update NPT_PROM_ARTICULO_TD set ind_actualiza=null
     where cod_promocion=EN_cod_promocion;

exception
when le_error then
        null;
when others then
   SN_cod_error:=SQLCODE;
   SV_mensaje:=SUBSTR(sqlerrm,1,200);
end;
------------------------------------------------------------------------
procedure NP_MOD_PROMOCION_PR(
   EN_cod_promocion             IN npt_promocion_td.cod_promocion%TYPE,
   EV_des_promocion_ant			IN npt_promocion_td.des_promocion%TYPE,
   EV_des_promocion				IN npt_promocion_td.des_promocion%TYPE,
   EV_fec_ini_ant	            IN VARCHAR2,
   EV_fec_ini		            IN VARCHAR2,
   EV_fec_fin_ant	            IN VARCHAR2,
   EV_fec_fin		            IN VARCHAR2,
   EV_usuario_act				IN VARCHAR2,
   SN_cod_error					OUT NOCOPY NUMBER,
   SV_mensaje					OUT NOCOPY VARCHAR2) as

le_error   exception;
ln_existe  number;
begin
   SV_mensaje:='0';
   SN_cod_error:=0;

   --La descripcion siempre se puede modificar...la vigencia depende....
   if trim(EV_fec_ini_ant)<>trim(EV_fec_ini) or trim(EV_fec_fin_ant)<>trim(EV_fec_fin) THEN
  /*
	  --Verificar si fue utilizada...
      np_promocion_utilizada_pr(EN_cod_promocion,SN_cod_error,SV_mensaje);
      if SN_cod_error<>0 then
         SV_mensaje:='No puede modificar la vigencia de una promoción que ha sido utilizada en un pedido';
	     RAISE le_error;
	   end if;
	*/
	   if to_date(EV_fec_fin_ant,'dd-mm-yyyy')<trunc(to_date(sysdate,'dd-mm-yyyy')) then
  	      SN_cod_error:=1;
	      SV_mensaje:='La promoción no puede ser modificada pues se encuentra vencida';
	      RAISE le_error;
	   end if;

   end if;

   NP_INS_PROMOCION_HIST_PR(EN_cod_promocion,'U',EV_usuario_act,SN_cod_error,SV_mensaje);

   IF SV_mensaje <>'0' then
      RAISE LE_error;
   end if;

   begin
     update NPT_PROMOCION_TD A
       set a.des_promocion=EV_des_promocion,a.fec_ini_vigencia=to_date(EV_fec_ini,'dd-mm-yyyy'),
	       a.fec_fin_vigencia=to_date(EV_fec_fin,'dd-mm-yyyy'),
	       a.usua_actualiza=EV_usuario_act,
	       a.fec_actualiza=sysdate
		   where a.cod_promocion=EN_cod_promocion;

   exception
   when others then
      SN_cod_error:=1;
      SV_mensaje:='Error al actualizar datos';
      RAISE le_error;
   end;

exception
when le_error then
        null;
when others then
   SN_cod_error:=SQLCODE;
   SV_mensaje:=SUBSTR(sqlerrm,1,200);
end;
------------------------------------------------------------------------
procedure NP_MOD_PROM_CLIENTES_PR(
   EN_cod_promocion             IN npt_prom_cliente_td.cod_promocion%TYPE,
   EV_usuario_act				IN npt_prom_cliente_td.usua_actualiza%TYPE,
   SN_cod_error					OUT NOCOPY NUMBER,
   SV_mensaje					OUT NOCOPY VARCHAR2) as

le_error   exception;

cursor clientes(EN_cod_promocion in number) is
select ind_actualiza,cod_usuario from   npt_prom_cliente_td where cod_promocion=EN_cod_promocion;

begin
   SV_mensaje:='0';
   SN_cod_error:=0;
   for c1 in clientes(EN_cod_promocion) loop
   begin
       if c1.ind_actualiza = 2 then --nuevo....
	      NP_INS_PROM_CLIENTE_HIST_PR(EN_cod_promocion,c1.cod_usuario,'I',EV_usuario_act,SN_cod_error,SV_mensaje);
		  if SV_mensaje<>'0' then
		     SV_mensaje:='0';
   			 SN_cod_error:=0;
		  end if;
	   else
          if c1.ind_actualiza is null then ---eliminar....
		      NP_INS_PROM_CLIENTE_HIST_PR(EN_cod_promocion,c1.cod_usuario,'D',EV_usuario_act,SN_cod_error,SV_mensaje);
		      if SV_mensaje<>'0' then
		         SV_mensaje:='0';
   			     SN_cod_error:=0;
		      end if;

		      DELETE  FROM NPT_PROM_CLIENTE_TD a
	  		  where a.cod_promocion=EN_cod_promocion AND
			        a.cod_usuario=C1.cod_usuario;
		  end if;
	   end if;

   exception
   when others then
        null;
   end;
   end loop;

   update NPT_PROM_CLIENTE_TD set ind_actualiza=null
     where cod_promocion=EN_cod_promocion;

exception
when le_error then
        null;
when others then
   SN_cod_error:=SQLCODE;
   SV_mensaje:=SUBSTR(sqlerrm,1,200);
end;

------------------------------------------------------------------------

END NP_MANTENEDOR_PROMOCIONES_PG;
/
SHOW ERRORS