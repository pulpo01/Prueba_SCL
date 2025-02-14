package com.tmmas.scl.gestionlc.dao;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;

import com.tmmas.scl.gestionlc.common.dto.PlanTarifarioDTO;
import com.tmmas.scl.gestionlc.common.dto.PlanTarifarioInDTO;
import com.tmmas.scl.gestionlc.common.dto.PlanTarifarioOutDTO;
import com.tmmas.scl.gestionlc.common.exception.GestionLimiteConsumoException;
import com.tmmas.scl.gestionlc.dao.common.GestionLimiteConsumoAbstractDAO;

/**
 * 
 * Contiene las operaciones asociadas al plan tarifario
 * 
 */

public class PlanTarifarioDAO extends GestionLimiteConsumoAbstractDAO {

    /**
     * permite obtener los datos del plan tarifario
     * 
     * @param pIn
     * @return
     * @throws GestionLimiteConsumoException
     */
    public PlanTarifarioOutDTO obtienePlanTarifario(PlanTarifarioInDTO pIn) throws GestionLimiteConsumoException {

        loggerDebug("Inicio(DAO):obtienePlanTarifario");
        Connection conn = null;
        CallableStatement cstmt = null;
        conn = obtenerConexion();
        PlanTarifarioOutDTO result = null;

        try {

            String call = getSQL("consultas.nombre.package", "consulta.datos.plan.tarifario", 5);

            loggerDebug("CALL: " + call);

            cstmt = conn.prepareCall(call);

            loggerDebug("CodPlanTarifario: " + pIn.getStrCodPlanTarif());
            cstmt.setString(1, pIn.getStrCodPlanTarif());
            cstmt.registerOutParameter(2, oracle.jdbc.driver.OracleTypes.CURSOR);
            cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
            cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
            cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);

            loggerDebug("antes execute");
            cstmt.execute();
            loggerDebug("despues execute");

            evaluaResultado(cstmt.getInt(3), cstmt.getString(4), cstmt.getInt(5));

            ResultSet rs = (ResultSet) cstmt.getObject(2);
            if (rs.next()) {

                result = new PlanTarifarioOutDTO();

                result.setStrDescPlanTarifario(rs.getString(1));
                result.setStrTipoTerminal(rs.getString(2));
                result.setStrCodLimConsumo(rs.getString(3));
                result.setStrCodCargoBasico(rs.getString(4));
                result.setStrTipPlanTarif(rs.getString(5));
                result.setStrTipPlan(rs.getString(6));

            }

        } catch (GestionLimiteConsumoException e) {
            throw e;
        } catch (Exception e) {
            loggerError(e);
            loggerError("Ocurrio un error al obtener ejecutar obtienePlanTarifario. " + e);
            throw new GestionLimiteConsumoException("ERR.0001", 0);
        } finally {
            try {
                if (cstmt != null) {
                    cstmt.close();
                }
                if (!conn.isClosed()) {
                    cerrarConexion(conn);
                }
            } catch (Exception e) {
                throw new GestionLimiteConsumoException(e);
            }
        }

        loggerDebug("fin(DAO):obtienePlanTarifario");

        return result;
    }

    /**
     * permite obtener los datos del plan tarifario
     * 
     * @param
     * @return
     * @throws GestionLimiteConsumoException
     */
    public PlanTarifarioDTO getDetallePlanTarifario(PlanTarifarioDTO planTarifarioDTO) throws GestionLimiteConsumoException {

        loggerDebug("Inicio(DAO):getDetallePlanTarifario");
        Connection conn = null;
        CallableStatement cstmt = null;
        conn = obtenerConexion();

        try {

            String call = getSQL("consultas.nombre.package", "consulta.detalle.plantarif", 5);

            loggerDebug("CALL: " + call);

            cstmt = conn.prepareCall(call);

            loggerDebug("1 - CodPlanTarif [" + planTarifarioDTO.getStrCodPlanTarif() + "]");
            cstmt.setString(1, planTarifarioDTO.getStrCodPlanTarif());
            cstmt.registerOutParameter(2, oracle.jdbc.driver.OracleTypes.CURSOR);
            cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
            cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
            cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);

            loggerDebug("antes execute");
            cstmt.execute();
            loggerDebug("despues execute");

            evaluaResultado(cstmt.getInt(3), cstmt.getString(4), cstmt.getInt(5));

            ResultSet rs = (ResultSet) cstmt.getObject(2);
            if (rs.next()) {
                planTarifarioDTO.setStrCodPlanTarif(rs.getString(1));
                planTarifarioDTO.setStrDesPlanTarif(rs.getString(2));
                planTarifarioDTO.setStrTipTerminal(rs.getString(3));
                planTarifarioDTO.setStrCodLimConsumo(rs.getString(4));
                planTarifarioDTO.setStrCodCargoBasico(rs.getString(5));
                if (rs.getBigDecimal(6) != null) {
                    planTarifarioDTO.setShoTipPlanConsumo(Short.valueOf(rs.getShort(6)));
                } else {
                    planTarifarioDTO.setShoTipPlanConsumo(null);
                }
                planTarifarioDTO.setStrTipPlanTarif(rs.getString(7));
                if (rs.getBigDecimal(8) != null) {
                    planTarifarioDTO.setShoNumDias(Short.valueOf(rs.getShort(8)));
                } else {
                    planTarifarioDTO.setShoNumDias(null);
                }
                if (rs.getBigDecimal(9) != null) {
                    planTarifarioDTO.setShoNumAbonados(Short.valueOf(rs.getShort(9)));
                } else {
                    planTarifarioDTO.setShoNumAbonados(null);
                }
                planTarifarioDTO.setStrFecDesde(rs.getString(10));
                planTarifarioDTO.setStrFecHasta(rs.getString(11));
                if (rs.getBigDecimal(12) != null) {
                    planTarifarioDTO.setShoIndFamiliar(Short.valueOf(rs.getShort(12)));
                } else {
                    planTarifarioDTO.setShoIndFamiliar(null);
                }
                planTarifarioDTO.setStrTipUnitas(rs.getString(13));
                planTarifarioDTO.setStrClaPlanTarif(rs.getString(14));
                if (rs.getBigDecimal(15) != null) {
                    planTarifarioDTO.setShoIndCargoHabil(Short.valueOf(rs.getShort(15)));
                } else {
                    planTarifarioDTO.setShoIndCargoHabil(null);
                }
                if (rs.getBigDecimal(16) != null) {
                    planTarifarioDTO.setShoNumDiasExpira(Short.valueOf(rs.getShort(16)));
                } else {
                    planTarifarioDTO.setShoNumDiasExpira(null);
                }
                planTarifarioDTO.setStrCodPlanComverse(rs.getString(17));
                planTarifarioDTO.setStrCodServicio(rs.getString(18));
                planTarifarioDTO.setStrCodTiplan(rs.getString(19));
                planTarifarioDTO.setStrCodCategoria(rs.getString(20));

            }

        } catch (GestionLimiteConsumoException e) {
            throw e;
        } catch (Exception e) {
            loggerError(e);
            loggerError("Ocurrio un error al obtener ejecutar getDetallePlanTarifario. " + e);
            throw new GestionLimiteConsumoException("ERR.0001", 0);
        } finally {
            try {
                if (cstmt != null) {
                    cstmt.close();
                }
                if (!conn.isClosed()) {
                    cerrarConexion(conn);
                }
            } catch (Exception e) {
                throw new GestionLimiteConsumoException(e);
            }
        }

        loggerDebug("fin(DAO):getDetallePlanTarifario");

        return planTarifarioDTO;
    }

}
