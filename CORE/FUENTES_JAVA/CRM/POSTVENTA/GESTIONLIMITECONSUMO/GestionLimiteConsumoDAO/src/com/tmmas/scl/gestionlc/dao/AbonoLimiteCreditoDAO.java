package com.tmmas.scl.gestionlc.dao;

import com.tmmas.scl.gestionlc.common.dto.ws.FooOutDTO;
import com.tmmas.scl.gestionlc.common.exception.GestionLimiteConsumoException;
import com.tmmas.scl.gestionlc.dao.common.GestionLimiteConsumoAbstractDAO;

public class AbonoLimiteCreditoDAO extends GestionLimiteConsumoAbstractDAO {

    public FooOutDTO foo(String inDTO) throws GestionLimiteConsumoException {

        loggerDebug("Inicio():foo");
        // Connection conn = null;
        // CallableStatement cstmt = null;
        // conn = obtenerConexion();

        FooOutDTO result = new FooOutDTO();

        try {

            // String call =
            // getSQL("catalogo.nombre.package","cat.lista.bodegasVendedor", 5);
            // cstmt = conn.prepareCall(call);

            // loggerDebug("IN 1 - CodVendedor [ "+p_inDTO.getIntCodVendedor()+" ]");
            // cstmt.setInt(1, p_inDTO.getIntCodVendedor());

            // cstmt.registerOutParameter(2,
            // oracle.jdbc.driver.OracleTypes.CURSOR);
            // cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
            // cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
            // cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);

            loggerDebug("antes execute");
            // cstmt.execute();
            loggerDebug("despues execute");

            // evaluaResultado(cstmt.getInt(3), cstmt.getString(4),
            // cstmt.getInt(5));

            // ResultSet rs = (ResultSet) cstmt.getObject(2);

            if (inDTO == null) {

                throw new GestionLimiteConsumoException();
            }

            double random = Math.random() * 9999999;

            result.setSalida(String.valueOf(random));

        } catch (GestionLimiteConsumoException e) {
            throw e;
        } catch (Exception e) {
            loggerError(e);
            loggerError("Ocurrio un error al ejecutar foo. " + e);
            throw new GestionLimiteConsumoException("ERR.0001", 0);
            // } finally {
            // try {
            // if (cstmt != null)
            // cstmt.close();
            // if (!conn.isClosed()) {
            // cerrarConexion(conn);
            // }
            // } catch (Exception e) {
            // throw new AbonoLimiteCreditoException(e);
            // }
        }

        loggerDebug("fin():foo");

        return result;
    }

}
