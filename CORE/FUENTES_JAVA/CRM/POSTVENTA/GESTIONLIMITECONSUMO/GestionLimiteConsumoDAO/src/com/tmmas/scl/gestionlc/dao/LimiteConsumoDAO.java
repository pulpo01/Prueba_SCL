package com.tmmas.scl.gestionlc.dao;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;

import com.tmmas.scl.gestionlc.common.dto.LimiteConsumoInDTO;
import com.tmmas.scl.gestionlc.common.dto.LimiteConsumoOutDTO;
import com.tmmas.scl.gestionlc.common.dto.LimiteConsumoUmbralDTO;
import com.tmmas.scl.gestionlc.common.dto.LimiteConsumoUmbralInDTO;
import com.tmmas.scl.gestionlc.common.dto.LimiteConsumoUtilizadoDTO;
import com.tmmas.scl.gestionlc.common.dto.LimiteConsumoUtilizadoInDTO;
import com.tmmas.scl.gestionlc.common.dto.LimitePendienteInDTO;
import com.tmmas.scl.gestionlc.common.dto.LimitePendienteOutDTO;
import com.tmmas.scl.gestionlc.common.dto.MontoMaximoLimiteConsumoInDTO;
import com.tmmas.scl.gestionlc.common.dto.ws.EjecucionAbonoLimiteConsumoInDTO;
import com.tmmas.scl.gestionlc.common.dto.ws.EjecutaModificacionLimiteConsumoInDTO;
import com.tmmas.scl.gestionlc.common.exception.GestionLimiteConsumoException;
import com.tmmas.scl.gestionlc.dao.common.GestionLimiteConsumoAbstractDAO;

/**
 * 
 * Contiene las operaciones asociadas al limite de consumo
 * 
 */
@SuppressWarnings("unused")
public class LimiteConsumoDAO extends GestionLimiteConsumoAbstractDAO {

    /**
     * permite obtener el limite consumo y umbral
     * 
     * @param pIn
     * @return
     * @throws GestionLimiteConsumoException
     */
    public LimiteConsumoUmbralDTO obtenerLimiteConsumoUmbral(LimiteConsumoUmbralInDTO pIn) throws GestionLimiteConsumoException {

        loggerDebug("Inicio():obtenerLimiteConsumoUmbral");
        Connection conn = null;
        CallableStatement cstmt = null;
        conn = obtenerConexion();
        LimiteConsumoUmbralDTO result = null;

        try {

            String call = getSQL("consultas.nombre.package", "consulta.datos.limconsumo", 6);

            loggerDebug("CALL: " + call);

            cstmt = conn.prepareCall(call);

            int i = 1;

            loggerDebug("CodCliente: " + pIn.getLonCodCliente());
            cstmt.setLong(i++, pIn.getLonCodCliente());

            loggerDebug("NumAbonado: " + pIn.getLonNunAbonado());
            cstmt.setLong(i++, pIn.getLonNunAbonado());

            int inOutCursor = i;

            cstmt.registerOutParameter(i++, oracle.jdbc.driver.OracleTypes.CURSOR);

            int intCodError = i;
            cstmt.registerOutParameter(i++, java.sql.Types.VARCHAR);

            int intDescError = i;
            cstmt.registerOutParameter(i++, java.sql.Types.VARCHAR);

            int intNumEvento = i;
            cstmt.registerOutParameter(i, java.sql.Types.NUMERIC);

            loggerDebug("antes execute");
            cstmt.execute();
            loggerDebug("despues execute");

            evaluaResultado(cstmt.getInt(intCodError), cstmt.getString(intDescError), cstmt.getInt(intNumEvento));

            ResultSet rs = (ResultSet) cstmt.getObject(inOutCursor);

            if (rs.next()) {

                result = new LimiteConsumoUmbralDTO();

                result.setStrCodLimiteConsumo(rs.getString(1));
                result.setStrDescLimiteConsumo(rs.getString(2));
                result.setStrCodigoUmbral(rs.getString(3));
                result.setStrDescUmbral(rs.getString(4));
            }

            if (result == null) {

                loggerError("No se encontro datos para limite de consumo actual");

                throw new GestionLimiteConsumoException("ERR.0008", 0);
            }

        } catch (GestionLimiteConsumoException e) {

            loggerError(e);
            throw e;

        } catch (Exception e) {
            loggerError(e);
            loggerError("Ocurrio un error al obtener ejecutar obtieneLimiteConsumoUmbral. " + e);
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

        loggerDebug("fin():obtenerLimiteConsumoUmbral");

        return result;
    }

    /**
     * permite obtener el limite de consumo utilizado
     * 
     * @param pIn
     * @return
     * @throws GestionLimiteConsumoException
     */
    public LimiteConsumoUtilizadoDTO obtenerLimiteConsumoUtilizado(LimiteConsumoUtilizadoInDTO pIn) throws GestionLimiteConsumoException {

        loggerDebug("Inicio():obtenerLimiteConsumoUtilizado");
        Connection conn = null;
        CallableStatement cstmt = null;
        conn = obtenerConexion();
        LimiteConsumoUtilizadoDTO result = null;

        try {

            String call = getSQL("consultas.nombre.package", "consulta.datos.limconsumo.utilizado", 8);

            loggerDebug("CALL: " + call);

            cstmt = conn.prepareCall(call);

            int i = 1;

            loggerDebug("CodCliente: " + pIn.getLonCodCliente());
            cstmt.setLong(i++, pIn.getLonCodCliente());

            loggerDebug("NumAbonado: " + pIn.getLonNunAbonado());
            cstmt.setLong(i++, pIn.getLonNunAbonado());

            loggerDebug("CodUmbral: " + pIn.getStrCodUmbral());
            cstmt.setString(i++, pIn.getStrCodUmbral());

            loggerDebug("CodCiclo: " + pIn.getLonCodCiclo());
            cstmt.setLong(i++, pIn.getLonCodCiclo());

            int inOutValue = i;

            cstmt.registerOutParameter(i++, java.sql.Types.NUMERIC);

            int intCodError = i;
            cstmt.registerOutParameter(i++, java.sql.Types.VARCHAR);

            int intDescError = i;
            cstmt.registerOutParameter(i++, java.sql.Types.VARCHAR);

            int intNumEvento = i;
            cstmt.registerOutParameter(i, java.sql.Types.NUMERIC);

            loggerDebug("antes execute");
            cstmt.execute();
            loggerDebug("despues execute");

            evaluaResultado(cstmt.getInt(intCodError), cstmt.getString(intDescError), cstmt.getInt(intNumEvento));

            result = new LimiteConsumoUtilizadoDTO();

            loggerDebug("LimiteConsumoUtilizado: " + cstmt.getDouble(inOutValue));
            result.setDouMonto(cstmt.getDouble(inOutValue));

        } catch (GestionLimiteConsumoException e) {
            throw e;
        } catch (Exception e) {
            loggerError(e);
            loggerError("Ocurrio un error al obtener ejecutar obtenerLimiteConsumoUtilizado. " + e);
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

        loggerDebug("fin():obtenerLimiteConsumoUtilizado");

        return result;
    }

    /**
     * permite obtener el limite consumo
     * 
     * @param pIn
     * @return
     * @throws GestionLimiteConsumoException
     */
    public LimiteConsumoOutDTO obtenerLimiteConsumo(LimiteConsumoInDTO pIN) throws GestionLimiteConsumoException {

        loggerDebug("Inicio():obtenerLimiteConsumo");
        Connection conn = null;
        CallableStatement cstmt = null;
        conn = obtenerConexion();
        LimiteConsumoOutDTO limiteConsumoOutDTO = null;
        String strResultado = null;
        try {

            String call = getSQL("consultas.nombre.package", "consulta.datos.limite.consumo", 5);
            cstmt = conn.prepareCall(call);

            loggerDebug("1 - NumAbonado [" + pIN.getLonNumAbonado() + "]");
            cstmt.setLong(1, pIN.getLonNumAbonado());
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

                limiteConsumoOutDTO = new LimiteConsumoOutDTO();

                limiteConsumoOutDTO.setStrCodLimCons(rs.getString(1));
                limiteConsumoOutDTO.setStrDescripcion(rs.getString(2));
                if (rs.getBigDecimal(3) != null) {
                    limiteConsumoOutDTO.setDouMontLimCons(Double.valueOf(rs.getBigDecimal(3).doubleValue()));
                } else {
                    limiteConsumoOutDTO.setDouMontLimCons(null);
                }
                limiteConsumoOutDTO.setStrUnidadMedida(rs.getString(4));
                limiteConsumoOutDTO.setStrDescMontMinMax(rs.getString(5));
                limiteConsumoOutDTO.setStrIndDefault(rs.getString(6));
                limiteConsumoOutDTO.setStrFechaDesde(rs.getString(7));
                limiteConsumoOutDTO.setStrFechaHasta(rs.getString(8));
                if (rs.getBigDecimal(9) != null) {
                    limiteConsumoOutDTO.setDouMontoMinimo(Double.valueOf(rs.getBigDecimal(9).doubleValue()));
                } else {
                    limiteConsumoOutDTO.setDouMontoMinimo(null);
                }
                if (rs.getBigDecimal(10) != null) {
                    limiteConsumoOutDTO.setDouMontoMaximo(Double.valueOf(rs.getBigDecimal(10).doubleValue()));
                } else {
                    limiteConsumoOutDTO.setDouMontoMaximo(null);
                }
                if (rs.getBigDecimal(11) != null) {
                    limiteConsumoOutDTO.setIntFlagCorte(Integer.valueOf(rs.getBigDecimal(11).intValue()));
                } else {
                    limiteConsumoOutDTO.setIntFlagCorte(null);
                }
                if (rs.getBigDecimal(12) != null) {
                    limiteConsumoOutDTO.setDouMontoLimite(Double.valueOf(rs.getBigDecimal(12).doubleValue()));
                } else {
                    limiteConsumoOutDTO.setDouMontoLimite(null);
                }
            }
        } catch (GestionLimiteConsumoException e) {
            throw e;
        } catch (Exception e) {
            loggerError(e);
            loggerError("Ocurrio un error al validar OOSS de limite de consumo. " + e);
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

        loggerDebug("fin():obtenerLimiteConsumo");
        return limiteConsumoOutDTO;
    }

    /**
     * permite obtener el monto maximo de abono para limite de consumo
     * 
     * @param pIn
     * @return
     * @throws GestionLimiteConsumoException
     */
    public Double obtieneMontoMaximoAbonoLimiteConsumo(MontoMaximoLimiteConsumoInDTO pIn) throws GestionLimiteConsumoException {

        loggerDebug("Inicio():obtieneMontoMaximoAbonoLimiteConsumo");

        Connection conn = null;
        CallableStatement cstmt = null;
        conn = obtenerConexion();
        Double douResultado = null;

        try {

            String call = getSQL("consultas.nombre.package", "consulta.monto.maxlc", 6);
            cstmt = conn.prepareCall(call);

            cstmt.setLong(1, pIn.getLonCodCliente());
            loggerDebug("1 - CodCliente [" + pIn.getLonCodCliente() + "]");

            cstmt.setLong(2, pIn.getLonNunAbonado());
            loggerDebug("2 - NumAbonado [" + pIn.getLonNunAbonado() + "]");

            cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
            cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
            cstmt.registerOutParameter(5, java.sql.Types.VARCHAR);
            cstmt.registerOutParameter(6, java.sql.Types.NUMERIC);

            loggerDebug("antes execute");
            cstmt.execute();
            loggerDebug("despues execute");

            evaluaResultado(cstmt.getInt(4), cstmt.getString(5), cstmt.getInt(6));

            douResultado = cstmt.getDouble(3);

        } catch (GestionLimiteConsumoException e) {
            throw e;
        } catch (Exception e) {
            loggerError(e);
            loggerError("Ocurrio un error al ejecutar obtieneMontoMaximoAbonoLimiteConsumo. " + e);
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

        loggerDebug("fin():obtieneMontoMaximoAbonoLimiteConsumo");

        return douResultado;
    }

    /**
     * permite obtener el limite consumo
     * 
     * @param pIn
     * @return
     * @throws GestionLimiteConsumoException
     */
    public void ejecutarAbonoLimiteConsumo(EjecucionAbonoLimiteConsumoInDTO pIn) throws GestionLimiteConsumoException {

        loggerDebug("Inicio():ejecutarAbonoLimiteConsumo");
        Connection conn = null;
        CallableStatement cstmt = null;
        conn = obtenerConexion();
        String strResultado = null;
        try {

            String call = getSQL("intermediario.nombre.package", "intermediario.registra.abo.lim.con", 14);
            cstmt = conn.prepareCall(call);

            int i = 1;

            loggerDebug(i + " - CodCliente [" + pIn.getLonCodCliente() + "]");
            cstmt.setLong(i++, pIn.getLonCodCliente());

            loggerDebug(i + " - NumAbonado [" + pIn.getLonNumAbonado() + "]");
            cstmt.setLong(i++, pIn.getLonNumAbonado());

            loggerDebug(i + " - Abono [" + pIn.getDouAbono() + "]");
            cstmt.setDouble(i++, pIn.getDouAbono());

            loggerDebug(i + " - Usuario [" + pIn.getStrUsuario() + "]");
            cstmt.setString(i++, pIn.getStrUsuario());

            loggerDebug(i + " - CodModulo [" + pIn.getStrCodModulo() + "]");
            cstmt.setString(i++, pIn.getStrCodModulo());

            loggerDebug(i + " - NumTarea [" + pIn.getStrNumTarea() + "]");
            cstmt.setString(i++, pIn.getStrNumTarea());

            loggerDebug(i + " - NumOOSS [" + pIn.getLonNumOOSS() + "]");
            cstmt.setLong(i++, pIn.getLonNumOOSS());

            loggerDebug(i + " - CodOOSS [" + pIn.getStrCodOOSS() + "]");
            cstmt.setString(i++, pIn.getStrCodOOSS());

            loggerDebug(i + " - CodProducto [" + pIn.getIntCodProducto() + "]");
            cstmt.setInt(i++, pIn.getIntCodProducto());

            loggerDebug(i + " - CodInter [" + pIn.getLonCodInter() + "]");
            cstmt.setLong(i++, pIn.getLonCodInter());

            loggerDebug(i + " - Comentario [" + pIn.getStrComentario() + "]");
            cstmt.setString(i++, pIn.getStrComentario());

            int intCodError = i;
            cstmt.registerOutParameter(i++, java.sql.Types.VARCHAR);

            int intMsgError = i;
            cstmt.registerOutParameter(i++, java.sql.Types.VARCHAR);

            int intEvento = i;
            cstmt.registerOutParameter(i, java.sql.Types.NUMERIC);

            loggerDebug("antes execute");
            cstmt.execute();
            loggerDebug("despues execute");

            evaluaResultado(cstmt.getInt(intCodError), cstmt.getString(intMsgError), cstmt.getInt(intEvento));

        } catch (GestionLimiteConsumoException e) {
            throw e;
        } catch (Exception e) {
            loggerError(e);
            loggerError("Ocurrio un error al ejecutar ejecutarAbonoLimiteConsumo. " + e);
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

        loggerDebug("fin():ejecutarAbonoLimiteConsumo");

    }

    /**
     * permite obtener el ejecutar OOSS Modificacion Limite Consumo
     * 
     * @param pIn
     * @return
     * @throws GestionLimiteConsumoException
     */
    public void ejecutaModificacionLimiteConsumo(EjecutaModificacionLimiteConsumoInDTO pIn) throws GestionLimiteConsumoException {

        loggerDebug("Inicio():ejecutaModificacionLimiteConsumo");
        Connection conn = null;
        CallableStatement cstmt = null;
        conn = obtenerConexion();
        String strResultado = null;
        try {
            String call = getSQL("intermediario.nombre.package", "intermediario.registra.modif.lim.con", 15);
            cstmt = conn.prepareCall(call);

            int i = 1;

            loggerDebug(i + " - CodCliente [" + pIn.getLonCodCliente() + "]");
            cstmt.setLong(i++, pIn.getLonCodCliente());

            loggerDebug(i + " - NumAbonado [" + pIn.getLonNumAbonado() + "]");
            cstmt.setLong(i++, pIn.getLonNumAbonado());

            loggerDebug(i + " - DetalleMonto [" + pIn.getDouDetalleMonto() + "]");
            cstmt.setDouble(i++, pIn.getDouDetalleMonto());

            loggerDebug(i + " - RespCpntinuar [" + pIn.getStrRespContinuar() + "]");
            cstmt.setString(i++, pIn.getStrRespContinuar());

            loggerDebug(i + " - CodPlanTarif [" + pIn.getStrCodPlanTarif() + "]");
            cstmt.setString(i++, pIn.getStrCodPlanTarif());

            loggerDebug(i + " - CodLimConsumo [" + pIn.getStrCodLimConsumo() + "]");
            cstmt.setString(i++, pIn.getStrCodLimConsumo());

            loggerDebug(i + " - UsuarioBd [" + pIn.getStrUsuarioBd() + "]");
            cstmt.setString(i++, pIn.getStrUsuarioBd());

            loggerDebug(i + " - Comentario [" + pIn.getStrComentario() + "]");
            cstmt.setString(i++, pIn.getStrComentario());

            loggerDebug(i + " - NumOOSS [" + pIn.getLonNumOOSS() + "]");
            cstmt.setLong(i++, pIn.getLonNumOOSS());

            loggerDebug(i + " - CodOOSS [" + pIn.getStrCodOOSS() + "]");
            cstmt.setString(i++, pIn.getStrCodOOSS());

            loggerDebug(i + " - CodProducto [" + pIn.getIntCodProducto() + "]");
            cstmt.setInt(i++, pIn.getIntCodProducto());

            loggerDebug(i + " - CodInter [" + pIn.getLonCodInter() + "]");
            cstmt.setLong(i++, pIn.getLonCodInter());

            int intCodError = i;
            cstmt.registerOutParameter(i++, java.sql.Types.VARCHAR);

            int intMsgError = i;
            cstmt.registerOutParameter(i++, java.sql.Types.VARCHAR);

            int intEvento = i;
            cstmt.registerOutParameter(i, java.sql.Types.NUMERIC);

            loggerDebug("antes execute");
            cstmt.execute();
            loggerDebug("despues execute");

            loggerDebug(i + "Resultado1[" + cstmt.getInt(intCodError) + "]");
            loggerDebug(i + "Resultado2[" + cstmt.getString(intMsgError) + "]");
            loggerDebug(i + "Resultado3[" + cstmt.getInt(intEvento) + "]");

            evaluaResultado(cstmt.getInt(intCodError), cstmt.getString(intMsgError), cstmt.getInt(intEvento));

        } catch (GestionLimiteConsumoException e) {
            throw e;
        } catch (Exception e) {
            loggerError(e);
            loggerError("Ocurrio un error al validar OOSS de limite de consumo. " + e);
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

    }

    /**
     * permite obtener el limite de consumo utilizado
     * 
     * @param pIn
     * @return
     * @throws GestionLimiteConsumoException
     */
    public LimitePendienteOutDTO obtenerLimitePendiente(LimitePendienteInDTO pIn) throws GestionLimiteConsumoException {

        loggerDebug("Inicio():obtenerLimitePendiente");
        Connection conn = null;
        CallableStatement cstmt = null;
        conn = obtenerConexion();
        LimitePendienteOutDTO result = null;

        try {

            String call = getSQL("consultas.nombre.package", "obtiene.limite.pendiente", 6);

            loggerDebug("CALL: " + call);

            cstmt = conn.prepareCall(call);

            int i = 1;

            loggerDebug("CodCliente: " + pIn.getLonCodCliente());
            cstmt.setLong(i++, pIn.getLonCodCliente());

            loggerDebug("NumAbonado: " + pIn.getLonNunAbonado());
            cstmt.setLong(i++, pIn.getLonNunAbonado());

            int inOutValue = i;
            cstmt.registerOutParameter(i++, java.sql.Types.NUMERIC);

            int intCodError = i;
            cstmt.registerOutParameter(i++, java.sql.Types.VARCHAR);

            int intDescError = i;
            cstmt.registerOutParameter(i++, java.sql.Types.VARCHAR);

            int intNumEvento = i;
            cstmt.registerOutParameter(i, java.sql.Types.NUMERIC);

            loggerDebug("antes execute");
            cstmt.execute();
            loggerDebug("despues execute");

            evaluaResultado(cstmt.getInt(intCodError), cstmt.getString(intDescError), cstmt.getInt(intNumEvento));

            result = new LimitePendienteOutDTO();

            loggerDebug("Limite Pendiente es: " + cstmt.getInt(inOutValue));
            result.setIntLimPendiente(cstmt.getInt(inOutValue));

        } catch (GestionLimiteConsumoException e) {
            throw e;
        } catch (Exception e) {
            loggerError(e);
            loggerError("Ocurrio un error al obtener ejecutar obtenerLimitePendiente. " + e);
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

        loggerDebug("fin():obtenerLimitePendiente");

        return result;
    }

}
