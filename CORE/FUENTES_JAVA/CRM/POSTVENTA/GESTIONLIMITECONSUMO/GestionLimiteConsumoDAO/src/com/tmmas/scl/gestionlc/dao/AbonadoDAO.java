package com.tmmas.scl.gestionlc.dao;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.util.ArrayList;

import com.tmmas.scl.gestionlc.common.dto.AbonadoDTO;
import com.tmmas.scl.gestionlc.common.dto.SiniestroDTO;
import com.tmmas.scl.gestionlc.common.dto.UsuarioDTO;
import com.tmmas.scl.gestionlc.common.exception.GestionLimiteConsumoException;
import com.tmmas.scl.gestionlc.dao.common.GestionLimiteConsumoAbstractDAO;

public class AbonadoDAO extends GestionLimiteConsumoAbstractDAO {

    public void validarOOSSPendiente(AbonadoDTO abonadoDTO, String strCodOS) throws GestionLimiteConsumoException {

        loggerDebug("Inicio(DAO):validarOOSSPendiente");
        Connection conn = null;
        CallableStatement cstmt = null;
        conn = obtenerConexion();
        try {

            String call = getSQL("validaciones.nombre.package", "val.ooss.pendiente.abonado", 5);
            cstmt = conn.prepareCall(call);

            loggerDebug("1 - NumAbonado [" + abonadoDTO.getLonNumAbonado() + "]");
            loggerDebug("2 - CodOS      [" + strCodOS + "]");
            cstmt.setLong(1, abonadoDTO.getLonNumAbonado());
            cstmt.setString(2, strCodOS);
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
            loggerError("Ocurrio un error al validar OOSS de abonado. " + e);
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

        loggerDebug("fin(DAO):validarOOSSPendiente");
    }

    public AbonadoDTO obtenerDatosAbonado(AbonadoDTO abonadoDTO) throws GestionLimiteConsumoException {

        loggerDebug("Inicio(DAO):obtenerDatosAbonado");
        Connection conn = null;
        CallableStatement cstmt = null;
        conn = obtenerConexion();
        try {

            String call = getSQL("consultas.nombre.package", "consulta.datos.abonado", 5);
            cstmt = conn.prepareCall(call);

            loggerDebug("1 - NumAbonado [" + abonadoDTO.getLonNumAbonado() + "]");
            cstmt.setLong(1, abonadoDTO.getLonNumAbonado());
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
                abonadoDTO.setStrNomTablaAbonado(rs.getString(1));
                if (rs.getBigDecimal(2) != null) {
                    abonadoDTO.setShoCodProducto(Short.valueOf(rs.getBigDecimal(2).shortValue()));
                } else {
                    abonadoDTO.setShoCodProducto(null);
                }
                if (rs.getBigDecimal(3) != null) {
                    abonadoDTO.setLonCodCuenta(Long.valueOf(rs.getBigDecimal(3).longValue()));
                } else {
                    abonadoDTO.setLonCodCuenta(null);
                }
                abonadoDTO.setStrCodSubCuenta(rs.getString(4));
                if (rs.getBigDecimal(5) != null) {
                    abonadoDTO.setLonCodCliente(Long.valueOf(rs.getBigDecimal(5).longValue()));
                } else {
                    abonadoDTO.setLonCodCliente(null);
                }
                if (rs.getBigDecimal(6) != null) {
                    abonadoDTO.setLonCodUsuario(Long.valueOf(rs.getBigDecimal(6).longValue()));
                } else {
                    abonadoDTO.setLonCodUsuario(null);
                }
                abonadoDTO.setStrCodSituacion(rs.getString(7));
                abonadoDTO.setStrCodEstado(rs.getString(8));
                if (rs.getBigDecimal(9) != null) {
                    abonadoDTO.setIntCodVendedor(Integer.valueOf(rs.getBigDecimal(9).intValue()));
                } else {
                    abonadoDTO.setIntCodVendedor(null);
                }
                if (rs.getBigDecimal(10) != null) {
                    abonadoDTO.setIntCodVendedorAgente(Integer.valueOf(rs.getBigDecimal(10).intValue()));
                } else {
                    abonadoDTO.setIntCodVendedorAgente(null);
                }
                abonadoDTO.setStrClaseServicio(rs.getString(11));
                abonadoDTO.setStrCodCargoBasico(rs.getString(12));
                if (rs.getBigDecimal(13) != null) {
                    abonadoDTO.setShoCodCredCon(Short.valueOf(rs.getBigDecimal(13).shortValue()));
                } else {
                    abonadoDTO.setShoCodCredCon(null);
                }
                if (rs.getBigDecimal(14) != null) {
                    abonadoDTO.setShoCodCredMor(Short.valueOf(rs.getBigDecimal(14).shortValue()));
                } else {
                    abonadoDTO.setShoCodCredMor(null);
                }
                abonadoDTO.setStrCodLimConsumo(rs.getString(15));
                abonadoDTO.setStrCodPlanServ(rs.getString(16));
                abonadoDTO.setStrCodPlanTarif(rs.getString(17));
                abonadoDTO.setStrCodTipContrato(rs.getString(18));
                if (rs.getBigDecimal(19) != null) {
                    abonadoDTO.setShoCodUso(Short.valueOf(rs.getBigDecimal(19).shortValue()));
                } else {
                    abonadoDTO.setShoCodUso(null);
                }
                abonadoDTO.setTimFecActCen(rs.getTimestamp(20));
                abonadoDTO.setTimFecAlta(rs.getTimestamp(21));
                abonadoDTO.setTimFecBaja(rs.getTimestamp(22));
                abonadoDTO.setTimFecBajaCen(rs.getTimestamp(23));
                abonadoDTO.setTimFecFinContra(rs.getTimestamp(24));
                abonadoDTO.setTimFecUltMod(rs.getTimestamp(25));
                if (rs.getBigDecimal(26) != null) {
                    abonadoDTO.setShoIndFactur(Short.valueOf(rs.getBigDecimal(26).shortValue()));
                } else {
                    abonadoDTO.setShoIndFactur(null);
                }
                abonadoDTO.setStrIndProcAlta(rs.getString(27));
                abonadoDTO.setStrIndProcEqui(rs.getString(28));
                if (rs.getBigDecimal(29) != null) {
                    abonadoDTO.setShoIndRehabi(Short.valueOf(rs.getBigDecimal(29).shortValue()));
                } else {
                    abonadoDTO.setShoIndRehabi(null);
                }
                if (rs.getBigDecimal(30) != null) {
                    abonadoDTO.setShoIndSeguro(Short.valueOf(rs.getBigDecimal(30).shortValue()));
                } else {
                    abonadoDTO.setShoIndSeguro(null);
                }
                if (rs.getBigDecimal(31) != null) {
                    abonadoDTO.setShoIndSuspen(Short.valueOf(rs.getBigDecimal(31).shortValue()));
                } else {
                    abonadoDTO.setShoIndSuspen(null);
                }
                abonadoDTO.setStrNomUsuarora(rs.getString(32));
                abonadoDTO.setStrNumAnexo(rs.getString(33));
                abonadoDTO.setStrNumContrato(rs.getString(34));
                abonadoDTO.setStrNumSerie(rs.getString(35));
                abonadoDTO.setStrNumSerieMec(rs.getString(36));
                abonadoDTO.setStrPerfilAbonado(rs.getString(37));
                if (rs.getBigDecimal(38) != null) {
                    abonadoDTO.setShoCodCentral(Short.valueOf(rs.getBigDecimal(38).shortValue()));
                } else {
                    abonadoDTO.setShoCodCentral(null);
                }
                if (rs.getBigDecimal(39) != null) {
                    abonadoDTO.setLonNumVenta(Long.valueOf(rs.getBigDecimal(39).longValue()));
                } else {
                    abonadoDTO.setLonNumVenta(null);
                }
                if (rs.getBigDecimal(40) != null) {
                    abonadoDTO.setLonCodEmpresa(Long.valueOf(rs.getBigDecimal(40).longValue()));
                } else {
                    abonadoDTO.setLonCodEmpresa(null);
                }
                if (rs.getBigDecimal(41) != null) {
                    abonadoDTO.setLonCodHolding(Long.valueOf(rs.getBigDecimal(41).longValue()));
                } else {
                    abonadoDTO.setLonCodHolding(null);
                }
                if (rs.getBigDecimal(42) != null) {
                    abonadoDTO.setShoCodModVenta(Short.valueOf(rs.getBigDecimal(42).shortValue()));
                } else {
                    abonadoDTO.setShoCodModVenta(null);
                }
                abonadoDTO.setStrCodCausaBaja(rs.getString(43));
                if (rs.getBigDecimal(44) != null) {
                    abonadoDTO.setShoCodCiclo(Short.valueOf(rs.getBigDecimal(44).shortValue()));
                } else {
                    abonadoDTO.setShoCodCiclo(null);
                }
                abonadoDTO.setStrCodGrpServ(rs.getString(45));
                abonadoDTO.setTimFecAcepVenta(rs.getTimestamp(46));
                abonadoDTO.setTimFecCumPlan(rs.getTimestamp(47));
                if (rs.getBigDecimal(48) != null) {
                    abonadoDTO.setShoNumPercontrato(Short.valueOf(rs.getBigDecimal(48).shortValue()));
                } else {
                    abonadoDTO.setShoNumPercontrato(null);
                }
                abonadoDTO.setStrTipPlanTarif(rs.getString(49));
                abonadoDTO.setStrTipTerminal(rs.getString(50));
                abonadoDTO.setTimFecCumplimen(rs.getTimestamp(51));
                abonadoDTO.setTimFecRecDocum(rs.getTimestamp(52));
                if (rs.getBigDecimal(53) != null) {
                    abonadoDTO.setShoIndInsGuias(Short.valueOf(rs.getBigDecimal(53).shortValue()));
                } else {
                    abonadoDTO.setShoIndInsGuias(null);
                }
                if (rs.getBigDecimal(54) != null) {
                    abonadoDTO.setLonNumCelular(Long.valueOf(rs.getBigDecimal(54).longValue()));
                } else {
                    abonadoDTO.setLonNumCelular(null);
                }
                if (rs.getBigDecimal(55) != null) {
                    abonadoDTO.setShoCodCentralPlex(Short.valueOf(rs.getBigDecimal(55).shortValue()));
                } else {
                    abonadoDTO.setShoCodCentralPlex(null);
                }
                if (rs.getBigDecimal(55) != null) {
                    abonadoDTO.setShoCodCentralPlex(Short.valueOf(rs.getBigDecimal(55).shortValue()));
                } else {
                    abonadoDTO.setShoCodCentralPlex(null);
                }
                abonadoDTO.setStrCodRegion(rs.getString(56));
                abonadoDTO.setStrCodProvincia(rs.getString(57));
                abonadoDTO.setStrCodCiudad(rs.getString(58));
                if (rs.getBigDecimal(59) != null) {
                    abonadoDTO.setShoIndPlexSys(Short.valueOf(rs.getBigDecimal(59).shortValue()));
                } else {
                    abonadoDTO.setShoIndPlexSys(null);
                }
                if (rs.getBigDecimal(60) != null) {
                    abonadoDTO.setLonNumCelularPlex(Long.valueOf(rs.getBigDecimal(60).longValue()));
                } else {
                    abonadoDTO.setLonNumCelularPlex(null);
                }
                abonadoDTO.setStrNumSerieHex(rs.getString(61));
                abonadoDTO.setStrCodCelda(rs.getString(62));
                abonadoDTO.setStrNumPersonal(rs.getString(63));
                if (rs.getBigDecimal(64) != null) {
                    abonadoDTO.setIntCodCarrier(Integer.valueOf(rs.getBigDecimal(64).intValue()));
                } else {
                    abonadoDTO.setIntCodCarrier(null);
                }
                if (rs.getBigDecimal(65) != null) {
                    abonadoDTO.setIntCodOpredFija(Integer.valueOf(rs.getBigDecimal(65).intValue()));
                } else {
                    abonadoDTO.setIntCodOpredFija(null);
                }
                if (rs.getBigDecimal(66) != null) {
                    abonadoDTO.setShoIndPrepago(Short.valueOf(rs.getBigDecimal(66).shortValue()));
                } else {
                    abonadoDTO.setShoIndPrepago(null);
                }
                if (rs.getBigDecimal(67) != null) {
                    abonadoDTO.setShoIndSuperTel(Short.valueOf(rs.getBigDecimal(67).shortValue()));
                } else {
                    abonadoDTO.setShoIndSuperTel(null);
                }
                abonadoDTO.setStrNumTeleFija(rs.getString(68));
                if (rs.getBigDecimal(69) != null) {
                    abonadoDTO.setIntCodVendealer(Integer.valueOf(rs.getBigDecimal(69).intValue()));
                } else {
                    abonadoDTO.setIntCodVendealer(null);
                }
                if (rs.getBigDecimal(70) != null) {
                    abonadoDTO.setShoIndDisp(Short.valueOf(rs.getBigDecimal(70).shortValue()));
                } else {
                    abonadoDTO.setShoIndDisp(null);
                }
                if (rs.getBigDecimal(71) != null) {
                    abonadoDTO.setIntCodClienteDist(Integer.valueOf(rs.getBigDecimal(71).intValue()));
                } else {
                    abonadoDTO.setIntCodClienteDist(null);
                }
                abonadoDTO.setStrIndEqPrestado(rs.getString(72));
                abonadoDTO.setTimFecProrroga(rs.getTimestamp(73));
                abonadoDTO.setStrNumMin(rs.getString(74));
                abonadoDTO.setStrNumImei(rs.getString(75));
                abonadoDTO.setStrCodTecnologia(rs.getString(76));

            }
        } catch (GestionLimiteConsumoException e) {
            throw e;
        } catch (Exception e) {
            loggerError(e);
            loggerError("Ocurrio un error al obtener datos del abonado. " + e);
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

        loggerDebug("fin(DAO):obtenerDatosAbonado");
        return abonadoDTO;
    }

    public SiniestroDTO[] obtenerSiniestros(AbonadoDTO abonadoDTO) throws GestionLimiteConsumoException {

        loggerDebug("Inicio(DAO):obtenerSiniestros");
        Connection conn = null;
        CallableStatement cstmt = null;
        conn = obtenerConexion();
        SiniestroDTO[] listaSiniestroVOs = null;
        try {

            String call = getSQL("consultas.nombre.package", "consulta.siniestro.abonado", 5);
            cstmt = conn.prepareCall(call);

            loggerDebug("1 - NumAbonado [" + abonadoDTO.getLonNumAbonado() + "]");
            cstmt.setLong(1, abonadoDTO.getLonNumAbonado());
            cstmt.registerOutParameter(2, oracle.jdbc.driver.OracleTypes.CURSOR);
            cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
            cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
            cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);

            loggerDebug("antes execute");
            cstmt.execute();
            loggerDebug("despues execute");

            evaluaResultado(cstmt.getInt(3), cstmt.getString(4), cstmt.getInt(5));

            ResultSet rs = (ResultSet) cstmt.getObject(2);
            ArrayList<SiniestroDTO> arrSiniestros = new ArrayList<SiniestroDTO>();

            while (rs.next()) {
                SiniestroDTO siniestroDTO = new SiniestroDTO();

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
                if (rs.getBigDecimal(10) != null) {
                    siniestroDTO.setLonNumConstancia(Long.valueOf(rs.getBigDecimal(10).longValue()));
                } else {
                    siniestroDTO.setLonNumConstancia(null);
                }
                siniestroDTO.setStrObservaciones(rs.getString(11));
                siniestroDTO.setStrDesTerminal(rs.getString(12));
                siniestroDTO.setStrTipTerminal(rs.getString(13));

                arrSiniestros.add(siniestroDTO);
            }
            listaSiniestroVOs = (SiniestroDTO[]) arrSiniestros.toArray(new SiniestroDTO[arrSiniestros.size()]);
            loggerDebug("Elementos encontrados [" + listaSiniestroVOs.length + "]");

            if (listaSiniestroVOs.length == 0) {
                throw new GestionLimiteConsumoException("ERR.0312", 0, "No se encontraron avisos de siniestro");
            }
        } catch (GestionLimiteConsumoException e) {
            throw e;
        } catch (Exception e) {
            loggerError(e);
            loggerError("Ocurrio un error al ontener los avisos de siniestros del abonado. " + e);
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

        loggerDebug("fin(DAO):obtenerSiniestros");
        return listaSiniestroVOs;
    }

    public void validarAvisoSiniestro(AbonadoDTO abonadoDTO) throws GestionLimiteConsumoException {

        loggerDebug("Inicio(DAO):validarAvisoSiniestro");
        Connection conn = null;
        CallableStatement cstmt = null;
        conn = obtenerConexion();
        try {

            String call = getSQL("validaciones.nombre.package", "val.aviso.siniestro.abonado", 5);
            cstmt = conn.prepareCall(call);

            loggerDebug("1 - NumAbonado [" + abonadoDTO.getLonNumAbonado() + "]");
            loggerDebug("2 - NombreTabla [" + abonadoDTO.getStrNomTablaAbonado() + "]");
            cstmt.setLong(1, abonadoDTO.getLonNumAbonado());
            cstmt.setString(2, abonadoDTO.getStrNomTablaAbonado());
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
            loggerError("Ocurrio un error al ontener los abisos de siniestros del abonado. " + e);
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

        loggerDebug("fin(DAO):validarAvisoSiniestro");
    }

    public AbonadoDTO obtenerCicloPendiente(AbonadoDTO abonadoDTO) throws GestionLimiteConsumoException {

        loggerDebug("Inicio(DAO):obtenerCicloPendiente");
        Connection conn = null;
        CallableStatement cstmt = null;
        conn = obtenerConexion();
        try {

            String call = getSQL("consultas.nombre.package", "intermediario.sol.pend.ciclo", 5);
            cstmt = conn.prepareCall(call);

            loggerDebug("1 - CodCliente [" + abonadoDTO.getLonCodCliente() + "]");
            cstmt.setLong(1, abonadoDTO.getLonCodCliente());
            cstmt.registerOutParameter(2, java.sql.Types.VARCHAR);
            cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
            cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
            cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);

            loggerDebug("antes execute");
            cstmt.execute();
            loggerDebug("despues execute");

            evaluaResultado(cstmt.getInt(3), cstmt.getString(4), cstmt.getInt(5));

            loggerDebug("Count Ciclo Pendiente: " + cstmt.getInt(2));

            abonadoDTO.setIntSolPendienteCiclo(cstmt.getInt(2));
            loggerDebug("Count Ciclo Pendiente: " + abonadoDTO.getIntSolPendienteCiclo());

        } catch (GestionLimiteConsumoException e) {
            throw e;
        } catch (Exception e) {
            loggerError(e);
            loggerError("Ocurrio un error al obtener el ciclo pendiente del abonado. " + e);
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

        loggerDebug("Fin(DAO):obtenerCicloPendiente");
        return abonadoDTO;
    }

    public void validarRecambio(AbonadoDTO abonadoDTO, UsuarioDTO usuarioDTO) throws GestionLimiteConsumoException {

        loggerDebug("Inicio(DAO):validarRecambio");
        Connection conn = null;
        CallableStatement cstmt = null;
        conn = obtenerConexion();
        try {

            String call = getSQL("validaciones.nombre.package", "val.recambio.abonado", 6);
            cstmt = conn.prepareCall(call);

            loggerDebug("1 - NumAbonado [" + abonadoDTO.getLonNumAbonado() + "]");
            loggerDebug("2 - CodCliente [" + abonadoDTO.getLonCodCliente() + "]");
            loggerDebug("3 - NomUsuario [" + usuarioDTO.getStrNomUsuario() + "]");
            cstmt.setLong(1, abonadoDTO.getLonNumAbonado());
            cstmt.setLong(2, abonadoDTO.getLonCodCliente());
            cstmt.setString(3, usuarioDTO.getStrNomUsuario());
            cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
            cstmt.registerOutParameter(5, java.sql.Types.VARCHAR);
            cstmt.registerOutParameter(6, java.sql.Types.NUMERIC);

            loggerDebug("antes execute");
            cstmt.execute();
            loggerDebug("despues execute");

            evaluaResultado(cstmt.getInt(4), cstmt.getString(5), cstmt.getInt(6));

        } catch (GestionLimiteConsumoException e) {
            throw e;
        } catch (Exception e) {
            loggerError(e);
            loggerError("Ocurrio un error al validar recambio. " + e);
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

        loggerDebug("fin(DAO):validarRecambio");
    }
}
