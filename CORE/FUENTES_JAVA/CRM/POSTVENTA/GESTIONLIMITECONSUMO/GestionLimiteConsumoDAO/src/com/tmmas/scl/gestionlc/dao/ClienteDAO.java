package com.tmmas.scl.gestionlc.dao;

import java.sql.CallableStatement;
import java.sql.Connection;

import com.tmmas.scl.gestionlc.common.dto.ClienteDTO;
import com.tmmas.scl.gestionlc.common.exception.GestionLimiteConsumoException;
import com.tmmas.scl.gestionlc.dao.common.GestionLimiteConsumoAbstractDAO;

public class ClienteDAO extends GestionLimiteConsumoAbstractDAO {

    public ClienteDTO obtenerOperadoraCliente(ClienteDTO clienteDTO) throws GestionLimiteConsumoException {

        loggerDebug("Inicio(DAO):obtenerOperadoraCliente");
        Connection conn = null;
        CallableStatement cstmt = null;
        conn = obtenerConexion();
        try {

            String call = getSQL("intermediario.nombre.package", "consulta.operadora.cli", 5);
            cstmt = conn.prepareCall(call);

            loggerDebug("1 - CodCliente [" + clienteDTO.getLonCodCliente() + "]");
            cstmt.setLong(1, clienteDTO.getLonCodCliente());
            cstmt.registerOutParameter(2, java.sql.Types.VARCHAR);
            cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
            cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
            cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);

            loggerDebug("antes execute");
            cstmt.execute();
            loggerDebug("despues execute");

            evaluaResultado(cstmt.getInt(3), cstmt.getString(4), cstmt.getInt(5));

            clienteDTO.setStrCodOperadora(cstmt.getString(2));

        } catch (GestionLimiteConsumoException e) {
            throw e;
        } catch (Exception e) {
            loggerError(e);
            loggerError("Ocurrio un error al obtener la operadora del cliente. " + e);
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

        loggerDebug("Fin(DAO):obtenerOperadoraCliente");
        return clienteDTO;
    }

}
