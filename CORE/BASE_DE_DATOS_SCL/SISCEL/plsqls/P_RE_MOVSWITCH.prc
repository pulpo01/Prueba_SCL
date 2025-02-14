CREATE OR REPLACE PROCEDURE P_RE_MOVSWITCH
(VP_REG_CMOV IN ICC_MOVIMIENTO%ROWTYPE)
IS
   vl_movimiento         INTEGER:=0;
   vl_tipcategoria       VARCHAR2(1);
   vl_reclamo            NUMBER(10);
   vl_celular            NUMBER(8);
   vl_rowd               INTEGER:=0;
   vl_nsd_celular        VARCHAR2(11);
   vl_nsd_celular_nue    VARCHAR2(11);
   vl_Tabla              VARCHAR2(35):=Null;
   vl_cod_nivel1         VARCHAR2(36):=Null;
   vl_cod_nivel2         VARCHAR2(72):=Null;
   vl_cod_nivel3         VARCHAR2(36):=Null;
   vl_cod_nivel4         VARCHAR2(36):=Null;
   vl_desa_caller        VARCHAR2(6):='060000';
   vl_habi_caller        VARCHAR2(6):='060001';
   vl_desa_LlamEspe      VARCHAR2(6):='050000';
   vl_habi_LlamEspe      VARCHAR2(6):='050001';
   vl_desa_msg_dig       VARCHAR2(36):='450000';
   vl_habi_msg_dig       VARCHAR2(36):='450001';
   vl_desa_info_ana      VARCHAR2(12):='260000070000';
   vl_habi_info_ana      VARCHAR2(12):='260001070007';
   vl_desa_info_dig      VARCHAR2(18):='260000370000080000';
   vl_habi_info_dig      VARCHAR2(18):='260001370013080001';
BEGIN
-- Este PL ya no es valido, ya que Reclamos no envia mas movimientos al Switch
   IF 2 < 1 THEN
      IF  VP_REG_CMOV.COD_ACTABO <> 'VA' AND VP_REG_CMOV.COD_ACTABO <> 'VB' THEN
--    ...Extrae los datos que relacionan la tabla RE_MOVSWITCH con ICC_MOVIMIENTO.
      vl_Tabla:='SELECT A1. ';
      SELECT num_movimiento,num_reclamo,tip_categoria,num_celular,nsd_celular,
             nsd_celular_nue
      INTO  vl_movimiento,vl_reclamo,vl_tipcategoria,vl_celular,vl_nsd_celular,
            vl_nsd_celular_nue
      FROM re_rel_movswt_iccmov
      WHERE num_movimiento = VP_REG_CMOV.num_movimiento;
--    ...Actualizar estado a OK en RE_MOVSWITCH.
      vl_Tabla:='UPDATE A1. ';
      UPDATE re_movswitch SET cod_estado = 'OK',fec_realizado = SYSDATE
      WHERE num_reclamo = vl_reclamo AND tip_categoria = vl_tipcategoria;
--     ...Verifica si es un servicio suplementario.  CALLER ID - INFOBOX.
--     ...Caller ID  InfoBox.
    IF VP_REG_CMOV.COD_ACTUACION = 36 THEN
       vl_Tabla:='SELECT A2. ';
       SELECT count(num_celular) INTO vl_rowd
       FROM re_servamist
       WHERE num_celular = vl_celular;
       IF vl_rowd > 0 THEN
          vl_Tabla:='SELECT A3. ';
          SELECT cod_nivel1,cod_nivel2,cod_nivel3,cod_nivel4
          INTO vl_cod_nivel1,vl_cod_nivel2,vl_cod_nivel3,vl_cod_nivel4
          FROM re_servamist
          WHERE num_celular = vl_celular;
--        *****************************************************************************
--        ...Actualiza o Borra por Baja Caller ID............................
          IF VP_REG_CMOV.COD_SERVICIOS = vl_desa_caller AND vl_cod_nivel1 = vl_habi_caller
             AND (vl_cod_nivel2 = vl_habi_info_ana OR  vl_cod_nivel2 = vl_habi_info_dig
             OR vl_cod_nivel3 = vl_habi_LlamEspe OR vl_cod_nivel4 = vl_habi_msg_dig) THEN
--           ...Actualizar por Baja.
             vl_Tabla:='UPDATE A2. ';
             UPDATE re_servamist SET cod_nivel1 = null ,nom_usuarora1 = VP_REG_CMOV.NOM_USUARORA,
             fec_altace1 = SYSDATE
             WHERE num_celular = vl_celular;
          ELSE
             IF VP_REG_CMOV.COD_SERVICIOS = vl_desa_caller   THEN
--           ...Borrar para Baja
                 vl_Tabla:='DELETE A1. ';
                DELETE FROM re_servamist
                WHERE num_celular = vl_celular;
             END IF;
          END IF;
--        ******************************************************************************
--        ...Actualiza o Borra por Baja InfoBox............................
          IF (VP_REG_CMOV.COD_SERVICIOS = vl_desa_info_ana  OR VP_REG_CMOV.COD_SERVICIOS = vl_desa_info_dig)
             AND ( vl_cod_nivel1 = vl_habi_caller
             OR vl_cod_nivel3 = vl_habi_LlamEspe OR vl_cod_nivel4 = vl_habi_msg_dig ) THEN
--           ...Update.
             vl_Tabla:='UPDATE A3. ';
             UPDATE re_servamist SET cod_nivel2 = null,nom_usuarora2 = VP_REG_CMOV.NOM_USUARORA,
             fec_altace2 = SYSDATE
             WHERE num_celular = vl_celular;
          ELSE
            IF (VP_REG_CMOV.COD_SERVICIOS = vl_desa_info_ana  OR VP_REG_CMOV.COD_SERVICIOS = vl_desa_info_dig) THEN
                vl_Tabla:='DELETE A2. ';
               DELETE FROM re_servamist
               WHERE num_celular = vl_celular;
            END IF;
          END IF;
--        *****************************************************************************
--        ...Actualiza o Borra por Baja Llamada en Espera............................
          IF VP_REG_CMOV.COD_SERVICIOS = vl_desa_LlamEspe AND vl_cod_nivel3 = vl_habi_LlamEspe
             AND (vl_cod_nivel2 = vl_habi_info_ana OR  vl_cod_nivel2 = vl_habi_info_dig
             OR vl_cod_nivel1 = vl_habi_caller OR vl_cod_nivel4 = vl_habi_msg_dig) THEN
--           ...Actualizar por Baja.
             vl_Tabla:='UPDATE A2. ';
             UPDATE re_servamist SET cod_nivel3 = null ,nom_usuarora3 = VP_REG_CMOV.NOM_USUARORA,
             fec_altace3 = SYSDATE
             WHERE num_celular = vl_celular;
          ELSE
             IF VP_REG_CMOV.COD_SERVICIOS = vl_desa_LlamEspe   THEN
--           ...Borrar para Baja
                 vl_Tabla:='DELETE A1. ';
                DELETE FROM re_servamist
                WHERE num_celular = vl_celular;
             END IF;
          END IF;
--        *******************************************************************************
--        ...Actualiza o Borra por Mensajeria Corta............................
          IF VP_REG_CMOV.COD_SERVICIOS = vl_desa_msg_dig AND vl_cod_nivel4 = vl_habi_msg_dig
             AND (vl_cod_nivel2 = vl_habi_info_ana OR  vl_cod_nivel2 = vl_habi_info_dig
             OR vl_cod_nivel1 = vl_habi_caller OR vl_cod_nivel3 = vl_habi_LlamEspe ) THEN
--           ...Actualizar por Baja.
             vl_Tabla:='UPDATE A3. ';
             UPDATE re_servamist SET cod_nivel4 = null ,nom_usuarora4 = VP_REG_CMOV.NOM_USUARORA,
             fec_altace4 = SYSDATE
             WHERE num_celular = vl_celular;
          ELSE
             IF VP_REG_CMOV.COD_SERVICIOS = vl_desa_msg_dig   THEN
--           ...Borrar para Baja
                 vl_Tabla:='DELETE A1. ';
                DELETE FROM re_servamist
                WHERE num_celular = vl_celular;
             END IF;
          END IF;
--        *******************************************************************************
--        ...Grabar para ALTA.........................................
          IF VP_REG_CMOV.COD_SERVICIOS = vl_habi_caller   THEN
--        ...Update
              vl_Tabla:='UPDATE A4. ';
             UPDATE re_servamist SET cod_nivel1 = vl_habi_caller,nom_usuarora1 = VP_REG_CMOV.NOM_USUARORA,
             fec_altace1 = SYSDATE
             WHERE num_celular = vl_celular;
          END IF;
          IF (VP_REG_CMOV.COD_SERVICIOS = vl_habi_info_ana OR VP_REG_CMOV.COD_SERVICIOS = vl_habi_info_dig) THEN
--           ...Update
             vl_Tabla:='UPDATE A5. ';
             UPDATE re_servamist SET cod_nivel2 = VP_REG_CMOV.COD_SERVICIOS,nom_usuarora2 = VP_REG_CMOV.NOM_USUARORA,
             fec_altace2 = SYSDATE
             WHERE num_celular = vl_celular;
          END IF;
          IF VP_REG_CMOV.COD_SERVICIOS = vl_habi_LlamEspe   THEN
--           ...Update
             vl_Tabla:='UPDATE A5. ';
             UPDATE re_servamist SET cod_nivel3 = vl_habi_LlamEspe,nom_usuarora3 = VP_REG_CMOV.NOM_USUARORA,
             fec_altace3 = SYSDATE
             WHERE num_celular = vl_celular;
          END IF;
          IF VP_REG_CMOV.COD_SERVICIOS = vl_habi_msg_dig   THEN
--           ...Update
             vl_Tabla:='UPDATE A5. ';
             UPDATE re_servamist SET cod_nivel4 = vl_habi_msg_dig ,nom_usuarora4 = VP_REG_CMOV.NOM_USUARORA,
             fec_altace4 = SYSDATE
             WHERE num_celular = vl_celular;
          END IF;
       ELSE
--        ...Alta
          IF VP_REG_CMOV.COD_SERVICIOS = vl_habi_caller THEN
             vl_Tabla:='INSERT A1. ';
             INSERT INTO re_servamist
                (num_celular,nom_usuarora1,nom_usuarora2,nom_usuarora3,nom_usuarora4,
                fec_altace1,fec_altace2,fec_altace3,fec_altace4,cod_nivel1,cod_nivel2,cod_nivel3,cod_nivel4)
                VALUES (VP_REG_CMOV.NUM_CELULAR,VP_REG_CMOV.NOM_USUARORA,Null,Null,Null,
                SYSDATE,Null,Null,Null,vl_habi_caller,Null,Null,Null);
          END IF;
          IF (VP_REG_CMOV.COD_SERVICIOS = vl_habi_info_ana OR VP_REG_CMOV.COD_SERVICIOS = vl_habi_info_dig) THEN
              vl_Tabla:='UPDATE A2. ';
              INSERT INTO re_servamist
                (num_celular,nom_usuarora1,nom_usuarora2,nom_usuarora3,nom_usuarora4,
                fec_altace1,fec_altace2,fec_altace3,fec_altace4,cod_nivel1,cod_nivel2,cod_nivel3,cod_nivel4)
                VALUES (VP_REG_CMOV.NUM_CELULAR,Null,VP_REG_CMOV.NOM_USUARORA,Null,Null,
                Null,SYSDATE,Null,Null,Null,VP_REG_CMOV.COD_SERVICIOS,Null,Null);
          END IF;
          IF VP_REG_CMOV.COD_SERVICIOS = vl_habi_LlamEspe THEN
             vl_Tabla:='INSERT A3. ';
             INSERT INTO re_servamist
                (num_celular,nom_usuarora1,nom_usuarora2,nom_usuarora3,nom_usuarora4,
                fec_altace1,fec_altace2,fec_altace3,fec_altace4,cod_nivel1,cod_nivel2,cod_nivel3,cod_nivel4)
                VALUES (VP_REG_CMOV.NUM_CELULAR,Null,Null,VP_REG_CMOV.NOM_USUARORA,Null,
                Null,Null,SYSDATE,Null,null,null,vl_habi_LlamEspe,Null);
          END IF;
          IF VP_REG_CMOV.COD_SERVICIOS = vl_habi_msg_dig THEN
             vl_Tabla:='INSERT A4. ';
             INSERT INTO re_servamist
                (num_celular,nom_usuarora1,nom_usuarora2,nom_usuarora3,nom_usuarora4,
                fec_altace1,fec_altace2,fec_altace3,fec_altace4,cod_nivel1,cod_nivel2,cod_nivel3,cod_nivel4)
                VALUES (VP_REG_CMOV.NUM_CELULAR,Null,Null,Null,VP_REG_CMOV.NOM_USUARORA,
                Null,Null,Null,SYSDATE,null,null,Null,vl_habi_msg_dig);
          END IF;
        END IF;
    END IF;
--     ...No es un servicio suplementario
    IF VP_REG_CMOV.COD_ACTUACION = 35 AND (VP_REG_CMOV.COD_ACTABO = 'CE'
       OR  VP_REG_CMOV.COD_ACTABO = 'ES') THEN
--     ...Cambio de Serie.  Externa UPDATE de la nueva serie
       vl_Tabla:='UPDATE A6. ';
       UPDATE al_series_activas SET num_serie = vl_nsd_celular,
       num_serhex = VP_REG_CMOV.NUM_SERIE,tip_terminal = VP_REG_CMOV.TIP_TERMINAL
       WHERE num_telefono = VP_REG_CMOV.NUM_CELULAR;
    END IF;
    END IF;
   END IF;
    EXCEPTION
       WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20600,'ERROR en Procedure P_RE_MOVSWITCH :'||vl_Tabla||'ORA'||TO_CHAR(SQLCODE),TRUE);
END;
/
SHOW ERRORS
