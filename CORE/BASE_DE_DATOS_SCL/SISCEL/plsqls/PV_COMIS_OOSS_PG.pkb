CREATE OR REPLACE PACKAGE BODY PV_COMIS_OOSS_PG AS

------------------------------------------------------------------------------------------------------
	PROCEDURE PV_OBTIENE_DATOS_VENDEDOR_PR(EO_pv_comis_ooss            IN OUT             PV_COMIS_OOSS_QT,
                                           SC_cursor OUT NOCOPY refCursor,
                                           SN_cod_retorno           OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
                                           SV_mens_retorno          OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
                                           SN_num_evento            OUT NOCOPY        ge_errores_pg.evento)
IS
/*
    <Documentación
      TipoDoc = "Procedure">>
       <Elemento
          Nombre = "PV_OBTIENE_DATOS_ABONADO_PR
          Lenguaje="PL/SQL"
          Fecha="04-06-2007"
          Versión="La del package"
          Diseñador="Jimmy Lopez"
          Programador="Jimmy Lopez"
          Ambiente Desarrollo="BD">
          <Retorno>N/A</Retorno>>
          <Descripción></Descripción>>
       </Elemento>
    </Documentación>
*/
    LV_des_error       ge_errores_pg.DesEvent;
    LV_sSql               ge_errores_pg.vQuery;
    cant                number;
    codVendedorLegaInter   ve_vendedores.cod_vendedor%TYPE;
    codVendedorLegaExter   ve_vendealer.cod_vendealer%TYPE;
    codTipComis           ve_tipcomis.cod_tipcomis%TYPE;
    numTransaccion       ga_transacabo.num_transaccion%TYPE;
    codRetorno           ga_transacabo.cod_retorno%TYPE;
    desCadena            ga_transacabo.des_cadena%TYPE;
    error_vendedor       EXCEPTION;
    BEGIN
        sn_cod_retorno     := 0;
        sv_mens_retorno := ' ';
        sn_num_evento     := 0;

        IF EO_pv_comis_ooss.IND_INTERNO IS NULL THEN
           EO_pv_comis_ooss.IND_INTERNO := 1;
        END IF;

        IF EO_pv_comis_ooss.IND_INTERNO = 1 THEN
            SELECT count(1)
            INTO cant
            FROM ve_vendedores a, ve_tipcomis b
            WHERE a.cod_tipcomis = b.cod_tipcomis AND
                  a.cod_vendedor = EO_pv_comis_ooss.cod_vendedor AND
                                                (
                                                (a.ind_interno = 1  AND b.ind_vta_externa = CN_ind_vta_interna) or 
                                                (a.ind_interno = 0  and a.num_pin= 1 and b.ind_vta_externa = CN_ind_vta_externa));

        ELSE
            SELECT count(1)
            INTO cant
            FROM ve_vendedores a, ve_vendealer b, ve_tipcomis c
            WHERE a.cod_vendedor = b.cod_vendedor AND
                  a.cod_tipcomis = c.cod_tipcomis AND
                  a.ind_interno = 0 AND
                  b.cod_vendealer = EO_pv_comis_ooss.cod_vendedor AND
                  c.ind_vta_externa = CN_ind_vta_externa;
        END IF;

        IF cant < 1 THEN
           SV_mens_retorno := 'El vendedor no es válido o bien el usuario de ingreso no está dado de alta como vendedor en el sistema.';
           raise error_vendedor;
        END IF;

        IF EO_pv_comis_ooss.IND_INTERNO = 1 THEN
            SELECT count(1)
            INTO cant
            FROM ve_vendedores a, ve_tipcomis b
            WHERE a.cod_tipcomis = b.cod_tipcomis AND
            a.cod_vendedor = EO_pv_comis_ooss.cod_vendedor AND
            (
            (a.ind_interno = 1  AND a.fec_contrato <= SYSDATE AND nvl(a.fec_fincontrato,SYSDATE) >= SYSDATE AND  a.cod_estado = 0 AND b.ind_vta_externa = CN_ind_vta_interna) or
            (a.ind_interno = 0 and a.num_pin= 1  AND a.fec_contrato <= SYSDATE  AND nvl(a.fec_fincontrato,SYSDATE) >= SYSDATE AND a.cod_estado = 0  and b.ind_vta_externa = CN_ind_vta_externa)
            );

        ELSE
            SELECT count(1)
            INTO cant
            FROM ve_vendedores a, ve_vendealer b, ve_tipcomis c
            WHERE a.cod_vendedor = b.cod_vendedor AND
                  a.cod_tipcomis = c.cod_tipcomis AND
                  a.ind_interno = 0 AND
                  a.fec_contrato <= SYSDATE AND nvl(a.fec_fincontrato,SYSDATE) >= SYSDATE AND
                     a.cod_estado = 0 AND
                  b.cod_vendealer = EO_pv_comis_ooss.cod_vendedor AND
                  b.fec_contrato <= SYSDATE AND nvl(b.fec_fincontrato,SYSDATE) >= SYSDATE AND
                     b.cod_estado = 1 AND
                  c.ind_vta_externa = CN_ind_vta_externa;
        END IF;

        IF cant < 1 THEN
            SV_mens_retorno := 'Vendedor Inactivo';
            raise error_vendedor;
        END IF;

        IF EO_pv_comis_ooss.IND_INTERNO = 1 THEN
            SELECT a.cod_vendedor, b.cod_tipcomis
            INTO codVendedorLegaInter, codTipComis
            FROM ve_vendedores a, ve_tipcomis b
            WHERE a.cod_tipcomis = b.cod_tipcomis AND
                  a.cod_vendedor = EO_pv_comis_ooss.cod_vendedor AND
                 (
                 ( a.ind_interno = 1   AND a.fec_contrato <= SYSDATE AND nvl(a.fec_fincontrato,SYSDATE) >= SYSDATE AND  a.cod_estado = 0 AND b.ind_vta_externa = CN_ind_vta_interna) or 
                 ( a.ind_interno = 0 and a.num_pin= 1 AND  a.fec_contrato <= SYSDATE AND nvl(a.fec_fincontrato,SYSDATE) >= SYSDATE AND a.cod_estado = 0 AND b.ind_vta_externa = CN_ind_vta_externa)
                 );
        ELSE
            SELECT b.cod_vendealer, c.cod_tipcomis
            INTO codVendedorLegaExter, codTipComis
            FROM ve_vendedores a, ve_vendealer b, ve_tipcomis c
            WHERE a.cod_vendedor = b.cod_vendedor AND
                  a.cod_tipcomis = c.cod_tipcomis AND
                  a.ind_interno = 0 AND
                  a.fec_contrato <= SYSDATE AND nvl(a.fec_fincontrato,SYSDATE) >= SYSDATE AND
                     a.cod_estado = 0 AND
                  b.cod_vendealer = EO_pv_comis_ooss.cod_vendedor AND
                  b.fec_contrato <= SYSDATE AND nvl(b.fec_fincontrato,SYSDATE) >= SYSDATE AND
                     b.cod_estado = 1 AND
                  c.ind_vta_externa = CN_ind_vta_externa;
        END IF;

        /* Se comenta Funcionalidad debido a que esta validacion no aplica a operadora Guatemala El Salvador 
        Esto fue realizado por RSIS Cambio de Serie- Cambio de Simcard
        
        SELECT ga_seq_transacabo.NEXTVAL INTO numTransaccion FROM DUAL;

        VE_VALIDACION_PG.VE_VENTA_LEGALIZADAS_PR(numTransaccion, codTipComis, codVendedorLegaExter, codVendedorLegaInter);

        SELECT cod_retorno, des_cadena
        INTO codRetorno, desCadena
        FROM ga_transacabo
        WHERE num_transaccion = numTransaccion;

        IF codRetorno = 0 THEN
           IF desCadena = '0' THEN
                SV_mens_retorno := 'Vendedor posee ventas no legalizadas. No podrá continuar con la OOSS';
                raise error_vendedor;
           END IF;
        END IF;

        DELETE ga_transacabo WHERE num_transaccion = numTransaccion;*/

        IF EO_pv_comis_ooss.IND_INTERNO = 1 THEN
            OPEN SC_cursor FOR
                SELECT a.cod_vendedor, a.cod_oficina, a.cod_tipcomis, a.cod_vendedor,
                       a.nom_vendedor, 0, b.cod_oficina, b.des_oficina, a.cod_tipcomis,
                       c.des_tipcomis, b.cod_region, d.des_region, b.cod_provincia,
                       e.des_provincia, b.cod_comuna, f.des_comuna, '' as cod_vendealer, '' as nom_vendealer, g.cod_ciudad,
                       g.des_ciudad
                FROM ve_vendedores a,
                     ge_oficinas b,
                     ve_tipcomis c,
                     ge_regiones d,
                     ge_provincias e,
                     ge_comunas f,
                     ge_ciudades g,
                     ge_direcciones h
                WHERE a.cod_oficina = b.cod_oficina
                      AND a.cod_tipcomis = c.cod_tipcomis
                      AND a.cod_vendedor = EO_pv_comis_ooss.cod_vendedor
                      AND
                      (
                       (a.ind_interno = 1 AND c.ind_vta_externa = CN_ind_vta_interna) or  
                       (a.ind_interno = 0 and a.num_pin= 1 AND c.ind_vta_externa = CN_ind_vta_externa)
                      )
                      AND a.fec_contrato <= SYSDATE AND nvl(a.fec_fincontrato,SYSDATE) >= SYSDATE
                      AND a.cod_estado = 0
                      AND c.ind_vta_externa = CN_ind_vta_interna
                      AND b.cod_direccion = h.cod_direccion
                      AND d.cod_region = h.cod_region
                      AND e.cod_provincia = h.cod_provincia
                      AND e.cod_region = h.cod_region
                      AND f.cod_provincia = h.cod_provincia
                      AND f.cod_region = h.cod_region
                      AND f.cod_comuna = h.cod_comuna
                      AND g.cod_region = h.cod_region
                      AND g.cod_provincia = h.cod_provincia
                      AND g.cod_ciudad = h.cod_ciudad;
        ELSE
            OPEN SC_cursor FOR
                SELECT a.cod_vendedor, a.cod_oficina, a.cod_tipcomis, a.cod_vendedor,
                       a.nom_vendedor, 0, b.cod_oficina, b.des_oficina, a.cod_tipcomis,
                       c.des_tipcomis, b.cod_region, d.des_region, b.cod_provincia,
                       e.des_provincia, b.cod_comuna, f.des_comuna, g.cod_vendealer  ,
                       g.nom_vendealer, h.cod_ciudad, h.des_ciudad
                FROM ve_vendedores a,
                     ge_oficinas b,
                     ve_tipcomis c,
                     ge_regiones d,
                     ge_provincias e,
                     ge_comunas f,
                     ve_vendealer g,
                     ge_ciudades h,
                     ge_direcciones i
                WHERE a.cod_vendedor = g.cod_vendedor
                      AND a.cod_oficina = b.cod_oficina
                      AND a.cod_tipcomis = c.cod_tipcomis
                      AND a.ind_interno = 0
                      AND a.fec_contrato <= SYSDATE AND nvl(a.fec_fincontrato,SYSDATE) >= SYSDATE
                      AND a.cod_estado = 0
                      AND g.fec_contrato <= SYSDATE AND nvl(g.fec_fincontrato,SYSDATE) >= SYSDATE
                      AND g.cod_estado = 1
                      AND g.cod_vendealer = EO_pv_comis_ooss.cod_vendedor
                      AND c.ind_vta_externa = CN_ind_vta_externa
                      AND b.cod_direccion = i.cod_direccion
                      AND d.cod_region = i.cod_region
                      AND e.cod_provincia = i.cod_provincia
                      AND e.cod_region = i.cod_region
                      AND f.cod_provincia = i.cod_provincia
                      AND f.cod_region = i.cod_region
                      AND f.cod_comuna = i.cod_comuna
                      AND h.cod_region = i.cod_region
                      AND h.cod_provincia = i.cod_provincia
                      AND h.cod_ciudad = i.cod_ciudad;
        END IF;


 EXCEPTION
    WHEN error_vendedor THEN
         SN_cod_retorno := 203;
         LV_des_error   := 'PV_COMIS_OOSS_PG.PV_OBTIENE_DATOS_VENDEDOR_PR('||EO_pv_comis_ooss.cod_vendedor||'); '||SQLERRM;
         SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_COMIS_OOSS_PG.PV_OBTIENE_DATOS_VENDEDOR_PR', LV_sSQL, SN_cod_retorno, LV_des_error );
    WHEN NO_DATA_FOUND THEN
          SN_cod_retorno := 203;
          IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
             SV_mens_retorno := CV_error_no_clasif;
          END IF;
          LV_des_error   := 'PV_COMIS_OOSS_PG.PV_OBTIENE_DATOS_VENDEDOR_PR('||EO_pv_comis_ooss.cod_vendedor||'); '||SQLERRM;
          SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_COMIS_OOSS_PG.PV_OBTIENE_DATOS_VENDEDOR_PR', LV_sSQL, SN_cod_retorno, LV_des_error );
      WHEN OTHERS THEN
          SN_cod_retorno := 156;
          IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
             SV_mens_retorno := CV_error_no_clasif;
          END IF;
          LV_des_error   := 'PV_COMIS_OOSS_PG.PV_OBTIENE_DATOS_VENDEDOR_PR('||EO_pv_comis_ooss.cod_vendedor||'); '||SQLERRM;
          SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_COMIS_OOSS_PG.PV_OBTIENE_DATOS_VENDEDOR_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

   END PV_OBTIENE_DATOS_VENDEDOR_PR;

--------------------------------------------------------------------------------------------------------

	PROCEDURE PV_REGISTRA_DATOS_COMIS_PR  (EO_pv_comis_ooss    	    IN          	PV_COMIS_OOSS_QT,
									       SN_cod_retorno           OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
									       SV_mens_retorno          OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
									       SN_num_evento            OUT NOCOPY	    ge_errores_pg.evento)
IS
/*
	<Documentación
	  TipoDoc = "Procedure">>
	   <Elemento
	      Nombre = "PV_OBTIENE_DATOS_ABONADO_PR
	      Lenguaje="PL/SQL"
	      Fecha="04-06-2007"
	      Versión="La del package"
	      Diseñador="Jimmy Lopez"
	      Programador="Jimmy Lopez"
	      Ambiente Desarrollo="BD">
	      <Retorno>N/A</Retorno>>
	      <Descripción></Descripción>>
	   </Elemento>
	</Documentación>
*/
	LV_des_error	   ge_errores_pg.DesEvent;
	LV_sSql			   ge_errores_pg.vQuery;
	BEGIN
		sn_cod_retorno 	:= 0;
	    sv_mens_retorno := ' ';
	    sn_num_evento 	:= 0;



INSERT INTO pv_comis_ooss_td
            (cod_vendedor, cod_vendealer,ind_interno, cod_oficina,
             cod_tipcomis, num_os,nom_usuario, fecha,cod_os, sub_tipo
            )
     VALUES (eo_pv_comis_ooss.cod_vendedor, eo_pv_comis_ooss.cod_vendealer,eo_pv_comis_ooss.ind_interno, eo_pv_comis_ooss.cod_oficina,
             eo_pv_comis_ooss.cod_tipcomis, eo_pv_comis_ooss.num_os,eo_pv_comis_ooss.nom_usuario, sysdate ,eo_pv_comis_ooss.cod_os, eo_pv_comis_ooss.sub_tipo
            );


	EXCEPTION
	WHEN NO_DATA_FOUND THEN
	      SN_cod_retorno := 203;
	      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
	         SV_mens_retorno := CV_error_no_clasif;
	      END IF;
		  LV_des_error   := 'PV_COMIS_OOSS_PG.PV_REGISTRA_DATOS_COMIS_PR('||EO_pv_comis_ooss.cod_vendedor||', '||EO_pv_comis_ooss.num_os||'); '||SQLERRM;
	      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_COMIS_OOSS_PG.PV_REGISTRA_DATOS_COMIS_PR', LV_sSQL, SN_cod_retorno, LV_des_error );
	  WHEN OTHERS THEN
	      SN_cod_retorno := 156;
	      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
	         SV_mens_retorno := CV_error_no_clasif;
	      END IF;
		  LV_des_error   := 'PV_COMIS_OOSS_PG.PV_REGISTRA_DATOS_COMIS_PR('||EO_pv_comis_ooss.cod_vendedor||', '||EO_pv_comis_ooss.num_os||'); '||SQLERRM;
	      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_COMIS_OOSS_PG.PV_REGISTRA_DATOS_COMIS_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

END PV_REGISTRA_DATOS_COMIS_PR;

--------------------------------------------------------------------------------------------------------
END PV_COMIS_OOSS_PG;
/
SHOW ERROR
