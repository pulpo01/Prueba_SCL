CREATE OR REPLACE PROCEDURE P_DEL_CAMNUMERO (
   v_producto   IN       ga_abocel.cod_producto%TYPE,
   v_error              OUT              varchar2
)
IS

CURSOR c1 IS
        SELECT a.num_abonado,a.num_celular,a.cod_cliente,a.IND_SUPERTEL,a.NUM_TELEFIJA
        FROM GA_ABOCEL a
        WHERE a.COD_SITUACION='CNP'
        AND       a.cod_producto=v_producto
        AND   a.FEC_ULTMOD < SYSDATE - 1;

        v_abonado                       ga_abocel.num_abonado%TYPE;
        v_celular                       ga_abocel.num_celular%TYPE;
        v_estado           icc_movimiento.cod_estado%TYPE;
        v_movimiento         icc_movimiento.num_movimiento%TYPE;
        v_celular_modabo         ga_modabocel.NUM_CELULAR%TYPE;
        v_cod_region_modabo  ga_modabocel.COD_REGION%type;
        v_cod_provincia_modabo ga_modabocel.cod_provincia%type;
        v_cod_ciudad_modabo        ga_modabocel.cod_ciudad%type;
        v_cod_celda_modabo         ga_modabocel.cod_celda%type;
        v_cod_uso_modabo           ga_modabocel.COD_USO%type;
        v_cod_central_modabo            ga_modabocel.cod_central_plex%type;
        v_cod_central_plex_modabo ga_modabocel.cod_central_plex%type;
        v_num_celular_plex_modabo ga_modabocel.num_celular_plex%type;
        v_ind_plexsys_modabo              ga_modabocel.ind_plexsys%type;
        v_num_min_mdn_modabo      ga_modabocel.num_min_mdn%type;
        v_fec_modifica_modabo                     ga_modabocel.fec_modifica%type;
        v_numtransacabo                   ga_transacabo.NUM_TRANSACCION%type;
        v_ind_procnum_resnum              ga_resnumcel.IND_PROCNUM%type;
        v_cod_subalm_resnum                       ga_resnumcel.cod_subalm%type;
        v_cod_central_resnum                      ga_resnumcel.cod_central%type;
        v_cod_cat_resnum                                  ga_resnumcel.cod_cat%type;
        v_cod_uso_resnum                                  ga_resnumcel.cod_uso%type;
        v_fec_baja_resnum                                 ga_resnumcel.fec_baja%type;
        ReponerNumeracionOK               boolean;
        v_year                                    varchar2(4);
        v_mes                                     varchar2(2);
        icc_mov                                   integer;
        icc_histmov                               integer;
        nNumMovimiento                    icc_movimiento.num_movimiento%Type;
        iCursor                                   integer;
        iResul                                    integer;
        i                                                 integer;
        szSqlText                                 varchar(200);
        errorsql                                  number;
        bHayCargos                                boolean;
        v_num_venta                               ge_cargos.NUM_VENTA%type;
        v_cod_cliente                     ga_abocel.cod_cliente%type;
        v_transac_resnum                          ga_resnumcel.NUM_TRANSACCION%type;
        v_linea_resnum                    ga_resnumcel.NUM_LINEA%type;
        v_orden_resnum                    ga_resnumcel.NUM_ORDEN%type;
        v_retorno                                 ga_transacabo.COD_RETORNO%type;
        error_ret_rep_num         exception;
        bEjecReponerNumeracion            boolean;
        v_Rowid_modabocel                         RowId;
        v_indSuperTel                     ga_abocel.ind_supertel%type;
        v_telefija                                ga_abocel.NUM_TELEFIJA%type;
		v_formato_fec							  varchar2(30);
BEGIN
   OPEN c1;
   LOOP
      FETCH c1 INTO v_abonado,
                    v_celular,
                                        v_cod_cliente,
                                        v_indSuperTel,
                                        v_telefija;
      EXIT WHEN c1%NOTFOUND;
           BEGIN

                   BEGIN
                           icc_histmov:=0;
                        -- Buscar en ICC_MOVIMIENTO ----
                           icc_mov:=0;
                           select num_abonado into v_abonado
                           from icc_movimiento where
                                        num_abonado=v_abonado
                           and  cod_actabo='CN'
                           and rownum=1;
                           icc_mov:=1;-- <-- indica que movimiento fue encontrado
                        -- Fin busqueda movimiento Central--
                   Exception
                                WHEN no_data_found Then
                                        BEGIN
                                                --Buscar en icc historico --
                                                    select trim(to_char(sysdate,'YYYY')) into v_year from dual;
                                                        select trim(to_char(sysdate,'MM'))   into v_mes from dual;

                                                        szSqlText := '';
                                                        szSqlText := 'SELECT NUM_MOVIMIENTO FROM ICC_HISTMOV';
                                                        szSqlText := szSqlText || v_mes || v_year;
                                                szSqlText := szSqlText || ' WHERE NUM_ABONADO =' || v_abonado || ' AND cod_actabo=''CN'' AND ROWNUM=1';

                        --                              dbms_output.PUT_LINE(szSqlText);
                                                        iCursor := DBMS_SQL.OPEN_CURSOR;
                                                        DBMS_SQL.PARSE(iCursor, szSqlText, DBMS_SQL.V7);
                                                        DBMS_SQL.DEFINE_COLUMN(iCursor, 1, nNumMovimiento);

                                                        iResul := DBMS_SQL.EXECUTE(iCursor);
                                                        i := 0;
                                                        LOOP
                                                                IF DBMS_SQL.FETCH_ROWS(iCursor) > 0 THEN
                                                                        DBMS_SQL.COLUMN_VALUE(iCursor, 1, nNumMovimiento);
                                                                ELSE
                                                                        DBMS_SQL.CLOSE_CURSOR(iCursor);
                                                                        EXIT;
                                                                end if;
                                                        end loop;
                                                        --dbms_output.PUT_LINE(nNumMovimiento);
                                                        if nNumMovimiento is not null then
                                                           icc_histmov:=1;-- <<----Indica que movimiento se encuentra en el historico
                                                        end if;
                                                Exception
                                                When Others Then
                                                        -- -942 : ORA-00942: table or view does not exist. No se ha creado tabla de historico movimiento
                                                        -- Si el error es distinto a -942, error al buscar en historico
                                                        -- no se realizara deshacer operacion para este abonado
                                                        errorsql:=to_number(SQLCODE);
                                                        if errorsql!=-942 then
                                                           icc_histmov:=1;
                                                        end if;
                                        END;
                   END;

           -- No se encontro Movimiento central
           if icc_histmov=0 and icc_mov=0 then

                                  select rowid,
                                                 fec_modifica,
                                                 num_celular,
                                                 cod_region,
                                                 cod_provincia,
                                                 cod_ciudad,
                                                 cod_celda,
                                                 cod_central,
                                                 cod_uso,
                                                 cod_central_plex,
                                                 num_celular_plex,
                                                 ind_plexsys,
                                                 num_min_mdn
                                  into   v_Rowid_modabocel,
                                                 v_fec_modifica_modabo,
                                                 v_celular_modabo,
                                                 v_cod_region_modabo,
                                                 v_cod_provincia_modabo,
                                                 v_cod_ciudad_modabo,
                                                 v_cod_celda_modabo,
                                                 v_cod_central_modabo,
                                                 v_cod_uso_modabo,
                                                 v_cod_central_plex_modabo,
                                                 v_num_celular_plex_modabo,
                                                 v_ind_plexsys_modabo,
                                                 v_num_min_mdn_modabo
                                  from ga_modabocel
                                  where num_abonado=v_abonado
                                                and cod_tipmodi='CN'
                                                and fec_modifica in
                                                        (select max(fec_modifica)
                                                        from ga_modabocel
                                                        where cod_tipmodi='CN'
                                                        and num_abonado=v_abonado);

                                 -- Seleccionar numero de venta de la tabla de cargos
                                 Begin

                                         select num_venta into v_num_venta
                                         from ge_cargos
                                         where cod_cliente = v_cod_cliente
                                         and num_abonado = v_abonado
                                         and num_terminal = v_celular_modabo
                                         and trunc(v_fec_modifica_modabo)=trunc(fec_alta)
                                         and rownum=1;
                                         bHayCargos:=true;
                                         exception
                                                          When no_data_found then
                                                          bHayCargos:=False;
                                 End;-- Fin --

                                 if bHayCargos=True then
                                         -- Borrar numero de venta si es mayor a 0
                                         if v_num_venta>0 then
                                                delete ga_ventas where num_venta = v_num_venta;
                                         end if;

                                         --Borrar Cargos
                                         Delete ge_cargos
                                         where cod_cliente = v_cod_cliente
                                         and num_abonado = v_abonado
                                         and num_terminal = v_celular_modabo
                                         and trunc(v_fec_modifica_modabo)=trunc(fec_alta);

                                 end if;

                                 -- Borrar Numero antiguo de la tabla GA_CELNUM_REUTIL
                                 DELETE GA_CELNUM_REUTIL
                                 WHERE NUM_CELULAR=v_celular_modabo;

                                 -- Actualizar GA_ABOCEL
                                 Update GA_ABOCEL A
                                                SET NUM_CELULAR   = v_celular_modabo,
                                                        COD_SITUACION = 'AAA',
                                                        COD_REGION    = nvl(v_cod_region_modabo,A.COD_REGION),
                                                        COD_PROVINCIA = nvl(v_cod_provincia_modabo,A.COD_PROVINCIA),
                                                        COD_CIUDAD    = nvl(v_cod_ciudad_modabo,A.Cod_Ciudad),
                                                        COD_CELDA     = nvl(v_cod_celda_modabo,A.cod_celda),
                                                        COD_CENTRAL   = nvl(v_cod_central_modabo,A.cod_central),
                                                        COD_USO       = nvl(v_cod_uso_modabo,A.cod_uso),
                                                        COD_CENTRAL_PLEX= nvl(v_cod_central_plex_modabo,A.cod_central_plex),
                                                        NUM_CELULAR_PLEX= nvl(v_num_celular_plex_modabo,A.num_celular_plex),
                                                        IND_PLEXSYS     = nvl(v_ind_plexsys_modabo,A.ind_plexsys),
                                                        NUM_MIN_MDN     = nvl(v_num_min_mdn_modabo,A.num_min_mdn)
                                                where num_abonado   =v_abonado and num_celular = v_celular;

                                --Borrar registro en GA_MODABOCEL
                                Delete ga_modabocel where rowid = v_Rowid_modabocel;

                                --Actualizar numero celular en tabla de los servicios suplemetarios
                                UPDATE GA_SERVSUPLABO SET NUM_TERMINAL = v_celular_modabo
                                Where NUM_ABONADO = v_abonado
                                And   ind_estado!=4;

                                --Actualizacion por Supertelefono
                                if v_indSuperTel!='0' then
                                   delete GA_CTC_MOVIMIENTOS
                                   where num_redfija=v_telefija
                                   and num_celular1=v_celular_modabo --Original
                                   and num_celular2=v_celular --Nuevo
                                   and trunc(fec_movimiento)=trunc(v_fec_modifica_modabo);
                                end if;

                                Begin
                                          ReponerNumeracionOK := False;

                                          select num_celular into v_celular
                                          from GA_CELNUM_REUTIL
                                          where num_celular = v_celular;

                                          -- El numero fue encontrado, no se necesita
                                          -- ejecutar proceso de reposicion numerica
                                          ReponerNumeracionOK := True;

                            exception
                                          -- Numero no encontrado, se debe ejecutar Reposicion numerica
                                          When no_data_found then
                                          BEGIN

                                                  -- Para ejecutar el PL P_REPONER_NUMERACION deben
                                                  -- existir datos en la tabla de reserva numero celular (GA_RESNUMCEL)
                                                  -- de no ser asi existe una inconsistencia que debe ser checkeada

                                                  --Seleccion de datos de la tabla de reserva de numero celular
                                                  select num_transaccion,num_linea,num_orden,ind_procnum,cod_subalm,cod_central,cod_cat,cod_uso,fec_baja
                                                  into v_transac_resnum,v_linea_resnum,v_orden_resnum,v_ind_procnum_resnum,v_cod_subalm_resnum,v_cod_central_resnum,v_cod_cat_resnum,v_cod_uso_resnum,v_fec_baja_resnum
                                                  From GA_RESNUMCEL
                                                  Where Num_celular = v_celular
                                                  And fec_reserva = (select max(fec_reserva) from ga_resnumcel where num_celular=v_celular);

												  v_formato_fec := SP_FN_FORMATOFECHA('FORMATO_SEL2');

                                                  select GA_SEQ_TRANSACABO.Nextval into v_numtransacabo from dual;
                                                  p_reponer_numeracion (v_numtransacabo,
                                                                                           v_ind_procnum_resnum,
                                                                                           v_cod_subalm_resnum,
                                                                                           v_cod_central_resnum,
                                                                                           v_cod_cat_resnum,
                                                                                           v_cod_uso_resnum,
                                                                                           v_celular,
                                                                                           to_char(v_fec_baja_resnum,v_formato_fec));

                                                 --Validar retorno del PL
                                                 SELECT COD_RETORNO into v_retorno
                                                 From Ga_Transacabo where num_transaccion = v_numtransacabo;

                                                 if v_retorno!=0 then
                                                        raise error_ret_rep_num;
                                                 end if;

                                                 Delete Ga_Transacabo where num_transaccion = v_numtransacabo;

                                                 --Borrar registro de reserva numero
                                                 Delete GA_RESNUMCEL
                                                 where num_transaccion=v_transac_resnum
                                                 And   num_linea=v_linea_resnum
                                                 And   num_orden=v_orden_resnum;

                                                 ReponerNumeracionOK := True;

                                          exception
                                                  when error_ret_rep_num then
                                                           rollback;
                                                           v_error:=v_retorno;
                                                           ReponerNumeracionOK := False;
                                                  when Others then
                                                           rollback;
                                                           v_error:=SUBSTR(SQLCODE,1,15);
                                                           ReponerNumeracionOK := False;

                                          End; --Fin Proceso de Reposicion numerica
                                End;--Existe Registro en GA_CELNUM_REUTIL

                                 if ReponerNumeracionOK = True Then
                                        v_error:='0';
                                        Commit;
                                 else
                                        Rollback;
                                 End if;
                   End if; -- Existe Movimiento

                EXCEPTION
                                 WHEN OTHERS THEN
                                         RollBack;
                                         v_error:=SUBSTR(SQLCODE,1,15);
           END;
        END LOOP;
        CLOSE c1;
END;
/
SHOW ERRORS
