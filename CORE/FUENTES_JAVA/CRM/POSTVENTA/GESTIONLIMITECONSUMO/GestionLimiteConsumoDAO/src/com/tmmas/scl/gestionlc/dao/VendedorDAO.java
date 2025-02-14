package com.tmmas.scl.gestionlc.dao;

import java.math.BigDecimal;
import java.sql.CallableStatement;
import java.sql.Connection;

import com.tmmas.scl.gestionlc.common.dto.UsuarioDTO;
import com.tmmas.scl.gestionlc.common.exception.GestionLimiteConsumoException;
import com.tmmas.scl.gestionlc.dao.common.GestionLimiteConsumoAbstractDAO;

public class VendedorDAO extends GestionLimiteConsumoAbstractDAO {

    /**
     * valida el estado del vendedor
     * 
     * @param
     * @return void
     * @throws GestionLimiteConsumoException
     */
    public void validarEstadoVendedor(UsuarioDTO usuarioDTO) throws GestionLimiteConsumoException {

        loggerDebug("Inicio(DAO):validarEstadoVendedor");
        Connection conn = null;
        CallableStatement cstmt = null;
        conn = obtenerConexion();
        String strResultado = null;
        try {

            String call = getSQL("intermediario.nombre.package", "val.vendedor.estado", 4);
            cstmt = conn.prepareCall(call);

            loggerDebug("IN 1 - CodVendedor [ " + usuarioDTO.getIntCodVendedor() + " ]");
            if (usuarioDTO.getIntCodVendedor() != null) {
                cstmt.setBigDecimal(1, new BigDecimal(usuarioDTO.getIntCodVendedor()));
            } else {
                cstmt.setBigDecimal(1, null);
            }

            cstmt.registerOutParameter(2, java.sql.Types.VARCHAR);
            cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
            cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);

            loggerDebug("antes execute");
            cstmt.execute();
            loggerDebug("despues execute");

            evaluaResultado(cstmt.getInt(2), cstmt.getString(3), cstmt.getInt(4));

            strResultado = cstmt.getString(3);
            String[] arreglo = strResultado.split("/");
            if (arreglo[1] != null && "1".equals(arreglo[1])) {
                throw new GestionLimiteConsumoException("ERR.0009", 9);
            }

        } catch (GestionLimiteConsumoException e) {
            throw e;
        } catch (Exception e) {
            loggerError(e);
            loggerError("Ocurrio un error al obtener el estado del vendedor. " + e);
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

        loggerDebug("fin(DAO):validarEstadoVendedor");
    }

    /**
     * bloquea/desbloquea al vendedor
     * 
     * @param
     * @return void
     * @throws GestionLimiteConsumoException
     */
    public void bloqueaDesbloqueaVendedor(UsuarioDTO usuarioDTO, String strOperacion) throws GestionLimiteConsumoException {

        loggerDebug("Inicio(DAO):bloqueaDesbloqueaVendedor");
        Connection conn = null;
        CallableStatement cstmt = null;
        conn = obtenerConexion();
        try {

            String call = getSQL("intermediario.nombre.package", "op.bloq.desbloq.vendedor", 5);
            cstmt = conn.prepareCall(call);

            loggerDebug("IN 1 - CodVendedor [ " + usuarioDTO.getIntCodVendedor() + " ]");
            loggerDebug("IN 2 - Operacion [ " + strOperacion + " ]");

            cstmt.setInt(1, usuarioDTO.getIntCodVendedor());
            cstmt.setString(2, strOperacion);

            cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
            cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
            cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);

            loggerDebug("antes execute");
            cstmt.execute();
            loggerDebug("despues execute");

            evaluaResultado(cstmt.getInt(3), cstmt.getString(4), cstmt.getInt(5));

        } catch (GestionLimiteConsumoException e) {
            throw e;
        } catch (Exception e) {
            loggerError(e);
            loggerError("Ocurrio un error al ejecutar bloquear/desbloquear el vendedor. " + e);
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

        loggerDebug("fin(DAO):bloqueaDesbloqueaVendedor");
    }

}
