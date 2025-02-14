package com.tmmas.scl.gestionlc.dao;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;

import com.tmmas.scl.gestionlc.common.dto.SegmentacionInDTO;
import com.tmmas.scl.gestionlc.common.dto.SegmentacionOutDTO;
import com.tmmas.scl.gestionlc.common.exception.GestionLimiteConsumoException;
import com.tmmas.scl.gestionlc.dao.common.GestionLimiteConsumoAbstractDAO;

/**
 * 
 * Contiene las operaciones asociadas a la segmentacion
 * 
 */
public class SegmentacionDAO extends GestionLimiteConsumoAbstractDAO {

    /**
     * permite obtener los datos de segmentacion
     * 
     * @param pIn
     * @return
     * @throws GestionLimiteConsumoException
     */
    public SegmentacionOutDTO obtieneSegmentacion(SegmentacionInDTO pIn) throws GestionLimiteConsumoException {

        loggerDebug("Inicio():obtieneSegmentacion");
        Connection conn = null;
        CallableStatement cstmt = null;
        conn = obtenerConexion();
        SegmentacionOutDTO result = null;

        try {

            String call = getSQL("consultas.nombre.package", "consulta.datos.segmentacion", 5);

            loggerDebug("CALL: " + call);

            cstmt = conn.prepareCall(call);

            loggerDebug("CodCliente: " + pIn.getLonCodCliente());

            cstmt.setLong(1, pIn.getLonCodCliente());
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

                result = new SegmentacionOutDTO();

                result.setStrCodColor(rs.getString(1));
                result.setStrDescColor(rs.getString(2));
                result.setStrCodSegmento(rs.getString(3));
                result.setStrDescSegmento(rs.getString(4));
            }

        } catch (GestionLimiteConsumoException e) {
            throw e;
        } catch (Exception e) {
            loggerError(e);
            loggerError("Ocurrio un error al obtener ejecutar obtieneSegmentacion. " + e);
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

        loggerDebug("fin():obtieneSegmentacion");

        return result;
    }

}
