package com.tmmas.scl.gestionlc.dao;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;

import com.tmmas.scl.gestionlc.common.dto.UsuarioDTO;
import com.tmmas.scl.gestionlc.common.exception.GestionLimiteConsumoException;
import com.tmmas.scl.gestionlc.dao.common.GestionLimiteConsumoAbstractDAO;

public class UsuarioDAO extends GestionLimiteConsumoAbstractDAO {

    /**
     * obtiene datos del usuario SCL
     * 
     * @param
     * @return UsuarioDTO
     * @throws GestionLimiteConsumoException
     */
    public UsuarioDTO obtieneDatosUsuario(UsuarioDTO usuarioDTO) throws GestionLimiteConsumoException {

        loggerDebug("Inicio(DAO):obtieneDatosUsuario");
        Connection conn = null;
        CallableStatement cstmt = null;
        conn = obtenerConexion();
        try {

            String call = getSQL("consultas.nombre.package", "consulta.datos.usuario", 5);
            cstmt = conn.prepareCall(call);

            loggerDebug("IN 1 - NomUsuario [ " + usuarioDTO.getStrNomUsuario() + " ]");
            cstmt.setString(1, usuarioDTO.getStrNomUsuario());
            cstmt.registerOutParameter(2, oracle.jdbc.driver.OracleTypes.CURSOR);
            cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
            cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
            cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);

            loggerDebug("antes execute");
            cstmt.execute();
            loggerDebug("despues execute");

            evaluaResultado(cstmt.getInt(3), cstmt.getString(4), cstmt.getInt(5));

            ResultSet resultSet = (ResultSet) cstmt.getObject(2);

            if (resultSet.next()) {
                usuarioDTO.setIntCodVendedor(resultSet.getInt(1));
                usuarioDTO.setStrCodTipComis(resultSet.getString(2));
                usuarioDTO.setStrCodOficina(resultSet.getString(3));
            }

        } catch (GestionLimiteConsumoException e) {
            throw e;
        } catch (Exception e) {
            loggerError(e);
            loggerError("Ocurrio un error al obtener datos del Usuario. " + e);
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

        loggerDebug("fin(DAO):obtieneDatosUsuario");
        return usuarioDTO;
    }

}
