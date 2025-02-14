/**
 * 
 */
package com.tmmas.scl.gestionlc.dao;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;

import com.tmmas.scl.gestionlc.common.dto.AbonadoDTO;
import com.tmmas.scl.gestionlc.common.dto.DatosGeneralesSiniestroDTO;
import com.tmmas.scl.gestionlc.common.dto.SiniestroDTO;
import com.tmmas.scl.gestionlc.common.exception.GestionLimiteConsumoException;
import com.tmmas.scl.gestionlc.dao.common.GestionLimiteConsumoAbstractDAO;

/**
 * Copyright © 2009 Telef&oacute;nica M&oacute;viles Soluciones y Aplicaciones,
 * SA. Av. Del Condor 720, Huechuraba, Santiago de Chile, Chile Todos los
 * derechos reservados.
 * 
 * Este software es informaci&oacute;n propietaria y confidencial de TM-mAs SA.
 * Usted no debe develar tal información y s&oactute;lo debe usarla en
 * concordancia con los t&eacute;rminos de derechos de licencias que sean
 * adquiridos con TM-mAs.<br>
 * 
 * @Fecha 06-04-2011<br>
 * @Autor Sergio Vidal<br>
 * 
 **/
public class SiniestroDAO extends GestionLimiteConsumoAbstractDAO {

    /**
     * obtiene informacion del siniestro
     * 
     * @param
     * @return SiniestroDTO
     * @throws GestionLimiteConsumoException
     */
    public SiniestroDTO obtenerDatosSiniestro(SiniestroDTO siniestroDTO) throws GestionLimiteConsumoException {

        loggerDebug("Inicio(DAO):obtenerDatosSiniestro");
        Connection conn = null;
        CallableStatement cstmt = null;
        conn = obtenerConexion();
        try {

            String call = getSQL("consultas.nombre.package", "consulta.datos.siniestro", 5);
            cstmt = conn.prepareCall(call);

            loggerDebug("1 - NumSiniestro [" + siniestroDTO.getLonNumSiniestro() + "]");
            cstmt.setLong(1, siniestroDTO.getLonNumSiniestro());
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
                if (rs.getBigDecimal(1) != null) {
                    siniestroDTO.setLonNumSiniestro(Long.valueOf(rs.getBigDecimal(1).longValue()));
                } else {
                    siniestroDTO.setLonNumSiniestro(null);
                }
                siniestroDTO.setStrCodEstado(rs.getString(2));
                siniestroDTO.setStrDetEstado(rs.getString(3));
                siniestroDTO.setStrCodCausa(rs.getString(4));
                siniestroDTO.setStrDetCausa(rs.getString(5));
                siniestroDTO.setStrFechaSiniestro(rs.getString(6));
                siniestroDTO.setStrFechaFormaliza(rs.getString(7));
                siniestroDTO.setStrFechaAnula(rs.getString(8));
                siniestroDTO.setStrFechaRestitucion(rs.getString(9));
                siniestroDTO.setStrDesTerminal(rs.getString(10));
                siniestroDTO.setStrTipTerminal(rs.getString(11));

            }
        } catch (GestionLimiteConsumoException e) {
            throw e;
        } catch (Exception e) {
            loggerError(e);
            loggerError("Ocurrio un error al obtener datos del siniestro. " + e);
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

        loggerDebug("fin(DAO):obtenerDatosSiniestro");
        return siniestroDTO;
    }

    /**
     * obtiene los codigos de cargo basico
     * 
     * @param
     * @return DatosGeneralesSiniestroDTO
     * @throws GestionLimiteConsumoException
     */
    public DatosGeneralesSiniestroDTO obtenerCodCargosBasicos(SiniestroDTO siniestroDTO, AbonadoDTO abonadoDTO) throws GestionLimiteConsumoException {

        loggerDebug("Inicio(DAO):obtenerCodCargosBasicos");
        Connection conn = null;
        CallableStatement cstmt = null;
        conn = obtenerConexion();
        DatosGeneralesSiniestroDTO generalesSiniestroDTO = new DatosGeneralesSiniestroDTO();
        try {

            String call = getSQL("consultas.nombre.package", "consulta.datos.codcargos.basicos", 9);
            cstmt = conn.prepareCall(call);

            loggerDebug("1 - NumAbonado [" + abonadoDTO.getLonNumAbonado() + "]");
            loggerDebug("2 - CodCliente [" + abonadoDTO.getLonCodCliente() + "]");
            loggerDebug("3 - CodCausa   [" + siniestroDTO.getStrCodCausa() + "]");
            cstmt.setLong(1, abonadoDTO.getLonNumAbonado());
            cstmt.setLong(2, abonadoDTO.getLonCodCliente());
            cstmt.setString(3, siniestroDTO.getStrCodCausa());
            cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
            cstmt.registerOutParameter(5, java.sql.Types.VARCHAR);
            cstmt.registerOutParameter(6, java.sql.Types.VARCHAR);
            cstmt.registerOutParameter(7, java.sql.Types.VARCHAR);
            cstmt.registerOutParameter(8, java.sql.Types.VARCHAR);
            cstmt.registerOutParameter(9, java.sql.Types.NUMERIC);

            loggerDebug("antes execute");
            cstmt.execute();
            loggerDebug("despues execute");

            generalesSiniestroDTO.setStrCargoBasCauSinie(cstmt.getString(4));
            generalesSiniestroDTO.setStrCargoBasOri(cstmt.getString(5));
            generalesSiniestroDTO.setStrCargoBasAnt(cstmt.getString(6));

            evaluaResultado(cstmt.getInt(7), cstmt.getString(8), cstmt.getInt(9));

        } catch (GestionLimiteConsumoException e) {
            throw e;
        } catch (Exception e) {
            loggerError(e);
            loggerError("Ocurrio un error al obtener los códigos de cargo básico. " + e);
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

        loggerDebug("fin(DAO):obtenerCodCargosBasicos");
        return generalesSiniestroDTO;
    }

    /**
     * restituye siniestro
     * 
     * @param
     * @return void
     * @throws GestionLimiteConsumoException
     */
    public void restituirSiniestro(SiniestroDTO siniestroDTO) throws GestionLimiteConsumoException {

        loggerDebug("Inicio(DAO):restituirSiniestro");
        Connection conn = null;
        CallableStatement cstmt = null;
        conn = obtenerConexion();
        try {

            String call = getSQL("consultas.nombre.package", "restituye.siniestro", 4);
            cstmt = conn.prepareCall(call);

            loggerDebug("1 - NumSiniestro [" + siniestroDTO.getLonNumSiniestro() + "]");
            cstmt.setLong(1, siniestroDTO.getLonNumSiniestro());
            cstmt.registerOutParameter(2, java.sql.Types.VARCHAR);
            cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
            cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);

            loggerDebug("antes execute");
            cstmt.execute();
            loggerDebug("despues execute");

            evaluaResultado(cstmt.getInt(2), cstmt.getString(3), cstmt.getInt(4));

        } catch (GestionLimiteConsumoException e) {
            throw e;
        } catch (Exception e) {
            loggerError(e);
            loggerError("Ocurrio un error al restituir el siniestro. " + e);
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

        loggerDebug("fin(DAO):restituirSiniestro");
    }

    /**
     * pasa a historico el siniestro
     * 
     * @param
     * @return void
     * @throws GestionLimiteConsumoException
     */
    public void pasoHistorico(SiniestroDTO siniestroDTO) throws GestionLimiteConsumoException {

        loggerDebug("Inicio(DAO):pasoHistorico");
        Connection conn = null;
        CallableStatement cstmt = null;
        conn = obtenerConexion();
        try {

            String call = getSQL("consultas.nombre.package", "historico.siniestro", 4);
            cstmt = conn.prepareCall(call);

            loggerDebug("1 - NumSiniestro [" + siniestroDTO.getLonNumSiniestro() + "]");
            cstmt.setLong(1, siniestroDTO.getLonNumSiniestro());
            cstmt.registerOutParameter(2, java.sql.Types.VARCHAR);
            cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
            cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);

            loggerDebug("antes execute");
            cstmt.execute();
            loggerDebug("despues execute");

            evaluaResultado(cstmt.getInt(2), cstmt.getString(3), cstmt.getInt(4));

        } catch (GestionLimiteConsumoException e) {
            throw e;
        } catch (Exception e) {
            loggerError(e);
            loggerError("Ocurrio un error al pasar a historico el siniestro. " + e);
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

        loggerDebug("fin(DAO):pasoHistorico");
    }

}
