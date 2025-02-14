package com.tmmas.scl.gestionlc.dao;

import java.math.BigDecimal;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.util.ArrayList;

import com.tmmas.scl.gestionlc.common.dto.ConsultaSeriesDTO;
import com.tmmas.scl.gestionlc.common.dto.ProductoDTO;
import com.tmmas.scl.gestionlc.common.dto.SerieDTO;
import com.tmmas.scl.gestionlc.common.dto.UsuarioDTO;
import com.tmmas.scl.gestionlc.common.exception.GestionLimiteConsumoException;
import com.tmmas.scl.gestionlc.dao.common.GestionLimiteConsumoAbstractDAO;

public class SerieDAO extends GestionLimiteConsumoAbstractDAO {

    /**
     * obtiene informacion del producto(series)
     * 
     * @param
     * @return ProductoDTO
     * @throws GestionLimiteConsumoException
     */
    public ProductoDTO obtieneInfoProductoAbonado(Long lonNumAbonado, String strTipTerminal) throws GestionLimiteConsumoException {

        loggerDebug("Inicio(DAO):obtieneInfoProductoAbonado");
        Connection conn = null;
        CallableStatement cstmt = null;
        conn = obtenerConexion();

        ProductoDTO productoDTO = new ProductoDTO();
        try {

            String call = getSQL("consultas.nombre.package", "consulta.datos.producto", 6);
            cstmt = conn.prepareCall(call);

            loggerDebug("1 - NumAbonado [ " + lonNumAbonado + " ]");
            loggerDebug("2 - TipTerminal [ " + strTipTerminal + " ]");

            cstmt.setLong(1, lonNumAbonado.longValue());
            cstmt.setString(2, strTipTerminal);
            cstmt.registerOutParameter(3, oracle.jdbc.driver.OracleTypes.CURSOR);
            cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
            cstmt.registerOutParameter(5, java.sql.Types.VARCHAR);
            cstmt.registerOutParameter(6, java.sql.Types.NUMERIC);

            loggerDebug("antes execute");
            cstmt.execute();
            loggerDebug("despues execute");

            evaluaResultado(cstmt.getInt(4), cstmt.getString(5), cstmt.getInt(6));

            ResultSet resultSet = (ResultSet) cstmt.getObject(3);

            if (resultSet.next()) {
                productoDTO.setStrDesEquipo(resultSet.getString(1));
                productoDTO.setStrNumSerie(resultSet.getString(2));
                productoDTO.setStrDesProcequi(resultSet.getString(3));
                productoDTO.setStrDesTerminal(resultSet.getString(4));
                productoDTO.setStrDesModVenta(resultSet.getString(5));
                productoDTO.setStrNumSerieMec(resultSet.getString(6));
                productoDTO.setStrIndPropiedad(resultSet.getString(7));
                productoDTO.setStrDesUso(resultSet.getString(8));
                productoDTO.setStrIndProcequi(resultSet.getString(9));
                productoDTO.setStrIndCuotas(resultSet.getString(10));
                productoDTO.setStrCodModVenta(resultSet.getString(11));
            }

        } catch (GestionLimiteConsumoException e) {
            throw e;
        } catch (Exception e) {
            loggerError(e);
            loggerError("Ocurrio un error al obtener datos del producto. " + e);
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

        loggerDebug("fin(DAO):obtieneInfoProductoAbonado");
        return productoDTO;
    }

    /**
     * obtiene una lista de series
     * 
     * @param void
     * @return SerieDTO[]
     * @throws GestionLimiteConsumoException
     */
    public SerieDTO[] obtieneListadoSeries(ConsultaSeriesDTO consultaSeriesDTO) throws GestionLimiteConsumoException {

        loggerDebug("Inicio():obtieneListadoSeries");

        Connection conn = null;
        CallableStatement cstmt = null;
        conn = obtenerConexion();
        ArrayList<SerieDTO> arrSCComboSeries = new ArrayList<SerieDTO>();
        SerieDTO[] serieDTOs = null;
        try {

            String call = getSQL("consultas.nombre.package", "consulta.lista.series", 16);
            cstmt = conn.prepareCall(call);

            loggerDebug("1 - IntCodModVenta [" + consultaSeriesDTO.getIntCodModVenta() + "]");
            loggerDebug("2 - StrCodCategoria [" + consultaSeriesDTO.getStrCodCategoria() + "]");
            loggerDebug("3 - IntIndCausa [" + consultaSeriesDTO.getIntIndCausa() + "]");
            loggerDebug("4 - StrCodOperacion [" + consultaSeriesDTO.getStrCodOperacion() + "]");
            loggerDebug("5 - IntNumMeses [" + consultaSeriesDTO.getIntNumMeses() + "]");
            loggerDebug("6 - StrCodTipContrato [" + consultaSeriesDTO.getStrCodTipContrato() + "]");
            loggerDebug("7 - StrTipTerminal [" + consultaSeriesDTO.getStrTipTerminal() + "]");
            loggerDebug("8 - IntCodEstado [" + consultaSeriesDTO.getIntCodEstado() + "]");
            loggerDebug("9 - IntCodArticulo [" + consultaSeriesDTO.getIntCodArticulo() + "]");
            loggerDebug("10 - IntCodBodega [" + consultaSeriesDTO.getIntCodBodega() + "]");
            loggerDebug("11 - IntCodUso [" + consultaSeriesDTO.getIntCodUso() + "]");
            loggerDebug("12 - registros [" + Integer.parseInt(getValorExterno("cantidad.registros.series")) + "]");

            cstmt.setInt(1, consultaSeriesDTO.getIntCodModVenta().intValue());
            cstmt.setString(2, consultaSeriesDTO.getStrCodCategoria());
            cstmt.setInt(3, consultaSeriesDTO.getIntIndCausa().intValue());
            cstmt.setString(4, consultaSeriesDTO.getStrCodOperacion());
            cstmt.setInt(5, consultaSeriesDTO.getIntNumMeses().intValue());
            cstmt.setString(6, consultaSeriesDTO.getStrCodTipContrato());
            cstmt.setString(7, consultaSeriesDTO.getStrTipTerminal());
            cstmt.setInt(8, consultaSeriesDTO.getIntCodEstado().intValue());
            cstmt.setInt(9, consultaSeriesDTO.getIntCodArticulo().intValue());
            cstmt.setInt(10, consultaSeriesDTO.getIntCodBodega().intValue());
            cstmt.setInt(11, consultaSeriesDTO.getIntCodUso().intValue());
            cstmt.setInt(12, Integer.parseInt(getValorExterno("cantidad.registros.series")));
            cstmt.registerOutParameter(13, oracle.jdbc.driver.OracleTypes.CURSOR);
            cstmt.registerOutParameter(14, java.sql.Types.VARCHAR);
            cstmt.registerOutParameter(15, java.sql.Types.VARCHAR);
            cstmt.registerOutParameter(16, java.sql.Types.NUMERIC);

            loggerDebug("antes execute");
            cstmt.execute();
            loggerDebug("despues execute");

            if (cstmt.getInt(14) != 110011) {
                evaluaResultado(cstmt.getInt(14), cstmt.getString(15), cstmt.getInt(16));
            }
            ResultSet rs = (ResultSet) cstmt.getObject(13);
            while (rs.next()) {
                SerieDTO serieDTO = new SerieDTO();
                serieDTO.setStrDesStock(rs.getString(1));
                serieDTO.setStrNumSerie(rs.getString(2));
                serieDTO.setStrNumSerieMec(rs.getString(3));
                serieDTO.setStrTipStock(rs.getString(4));
                serieDTO.setStrIndValorar(rs.getString(5));

                arrSCComboSeries.add(serieDTO);
            }
            loggerDebug("registros obtenidos [ " + arrSCComboSeries.size() + " ]");
            serieDTOs = (SerieDTO[]) arrSCComboSeries.toArray(new SerieDTO[arrSCComboSeries.size()]);

        } catch (GestionLimiteConsumoException e) {
            throw e;
        } catch (Exception e) {
            loggerError(e);
            loggerError("Ocurrio un error al ejecutar obtieneListadoSeries. " + e);
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

        loggerDebug("fin(DAO):obtieneListadoSeries");

        return serieDTOs;
    }

    /**
     * reserva un articulo
     * 
     * @param
     * @return Long
     * @throws GestionLimiteConsumoException
     */
    public Long reservaArticulo(SerieDTO serieDTO, UsuarioDTO usuarioDTO) throws GestionLimiteConsumoException {

        loggerDebug("Inicio(DAO):reservaArticulo");
        Connection conn = null;
        CallableStatement cstmt = null;
        conn = obtenerConexion();
        Long lonNumTransaccion = null;
        try {

            String call = getSQL("consultas.nombre.package", "inserta.reserva.articulo", 11);
            cstmt = conn.prepareCall(call);

            loggerDebug("1 - CodArticulo    [ " + serieDTO.getIntCodArticulo() + " ]");
            loggerDebug("2 - CodBodega      [ " + serieDTO.getIntCodBodega() + " ]");
            loggerDebug("3 - TipStock       [ " + serieDTO.getStrTipStock() + " ]");
            loggerDebug("4 - CodUsoLinea    [ " + serieDTO.getShoCodUso() + " ]");
            loggerDebug("5 - CodEstado      [ " + serieDTO.getShoCodEstado() + " ]");
            loggerDebug("6 - NomUsuario     [ " + usuarioDTO.getStrNomUsuario() + " ]");
            loggerDebug("7 - NumSerie       [ " + serieDTO.getStrNumSerie() + " ]");

            if (serieDTO.getIntCodArticulo() != null) {
                cstmt.setBigDecimal(1, BigDecimal.valueOf(serieDTO.getIntCodArticulo().intValue()));
            } else {
                cstmt.setBigDecimal(1, null);
            }
            if (serieDTO.getIntCodBodega() != null) {
                cstmt.setBigDecimal(2, BigDecimal.valueOf(serieDTO.getIntCodBodega().intValue()));
            } else {
                cstmt.setBigDecimal(2, null);
            }
            cstmt.setString(3, serieDTO.getStrTipStock());
            if (serieDTO.getShoCodUso() != null) {
                cstmt.setBigDecimal(4, BigDecimal.valueOf(serieDTO.getShoCodUso().intValue()));
            } else {
                cstmt.setBigDecimal(4, null);
            }
            if (serieDTO.getShoCodEstado() != null) {
                cstmt.setBigDecimal(5, BigDecimal.valueOf(serieDTO.getShoCodEstado().intValue()));
            } else {
                cstmt.setBigDecimal(5, null);
            }
            cstmt.setString(6, usuarioDTO.getStrNomUsuario());
            cstmt.setString(7, serieDTO.getStrNumSerie());
            cstmt.registerOutParameter(8, java.sql.Types.NUMERIC);
            cstmt.registerOutParameter(9, java.sql.Types.NUMERIC);
            cstmt.registerOutParameter(10, java.sql.Types.VARCHAR);
            cstmt.registerOutParameter(11, java.sql.Types.NUMERIC);

            loggerDebug("antes execute");
            cstmt.execute();
            loggerDebug("despues execute");

            evaluaResultado(cstmt.getInt(9), cstmt.getString(10), cstmt.getInt(11));

            lonNumTransaccion = Long.valueOf(cstmt.getLong(8));

        } catch (GestionLimiteConsumoException e) {
            throw e;
        } catch (Exception e) {
            loggerError(e);
            loggerError("Ocurrio un error al reservar el articulo. " + e);
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

        loggerDebug("fin(DAO):reservaArticulo");
        return lonNumTransaccion;
    }

    /**
     * desreserva un articulo
     * 
     * @param
     * @return
     * @throws GestionLimiteConsumoException
     */
    public void desReservaArticulo(Long lonNumTransaccion) throws GestionLimiteConsumoException {

        loggerDebug("Inicio(DAO):desReservaArticulo");
        Connection conn = null;
        CallableStatement cstmt = null;
        conn = obtenerConexion();
        try {

            String call = getSQL("intermediario.nombre.package", "desreserva.articulo", 4);
            cstmt = conn.prepareCall(call);

            loggerDebug("1 - NumTransaccion [ " + lonNumTransaccion + " ]");

            cstmt.setLong(1, lonNumTransaccion);
            cstmt.registerOutParameter(2, java.sql.Types.NUMERIC);
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
            loggerError("Ocurrio un error al desreservar el articulo. " + e);
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

        loggerDebug("fin(DAO):desReservaArticulo");
    }

    /**
     * rollback reserva de serie
     * 
     * @param
     * @return
     * @throws GestionLimiteConsumoException
     */
    public void rollbackReservaSerie(Long lonNumTransaccion) throws GestionLimiteConsumoException {

        loggerDebug("Inicio(DAO):rollbackReservaSerie");
        Connection conn = null;
        CallableStatement cstmt = null;
        conn = obtenerConexion();
        try {

            String call = getSQL("intermediario.nombre.package", "rollback.reserva.articulo", 4);
            cstmt = conn.prepareCall(call);

            loggerDebug("1 - NumTransaccion [ " + lonNumTransaccion + " ]");

            cstmt.setLong(1, lonNumTransaccion);
            cstmt.registerOutParameter(2, java.sql.Types.NUMERIC);
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
            loggerError("Ocurrio un error al realizar el rollback de reserva de serie. " + e);
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

        loggerDebug("fin(DAO):rollbackReservaSerie");
    }

    /**
     * actualiza el stock de la serie
     * 
     * @param
     * @return void
     * @throws GestionLimiteConsumoException
     */
    public void actualizaStock(SerieDTO serieDTO, Long lonNumVenta, String strTipoMovimiento, String strNumTransaccion) throws GestionLimiteConsumoException {

        loggerDebug("Inicio(DAO):actualizaStock");
        Connection conn = null;
        CallableStatement cstmt = null;
        conn = obtenerConexion();
        try {

            String call = getSQL("intermediario.nombre.package", "actualiza.stock.serie", 14);
            cstmt = conn.prepareCall(call);

            loggerDebug("1 - NumTransaccion [ " + strNumTransaccion + " ]");
            loggerDebug("2 - TipoMovimiento [ " + strTipoMovimiento + " ]");
            loggerDebug("3 - TipStock [ " + serieDTO.getStrTipStock() + " ]");
            loggerDebug("4 - CodBodega [ " + serieDTO.getIntCodBodega() + " ]");
            loggerDebug("5 - CodArticulo [ " + serieDTO.getIntCodArticulo() + " ]");
            loggerDebug("6 - CodUso [ " + serieDTO.getShoCodUso() + " ]");
            loggerDebug("7 - CodEstado [ " + serieDTO.getShoCodEstado() + " ]");
            loggerDebug("8 - NumVenta [ " + lonNumVenta + " ]");
            loggerDebug("9 - Cantidad [ 1 ]");
            loggerDebug("10 - NumSerie [ " + serieDTO.getStrNumSerie() + " ]");
            loggerDebug("11 - IndTelefono [ 0 ]");

            cstmt.setString(1, strNumTransaccion);
            cstmt.setString(2, strTipoMovimiento);
            cstmt.setString(3, serieDTO.getStrTipStock());
            cstmt.setString(4, serieDTO.getIntCodBodega().toString());
            cstmt.setString(5, serieDTO.getIntCodArticulo().toString());
            cstmt.setString(6, serieDTO.getShoCodUso().toString());
            cstmt.setString(7, serieDTO.getShoCodEstado().toString());
            if (lonNumVenta != null) {
                cstmt.setString(8, lonNumVenta.toString());
            } else {
                cstmt.setString(8, null);
            }
            cstmt.setString(9, "1");
            cstmt.setString(10, serieDTO.getStrNumSerie());
            cstmt.setString(11, "0");
            cstmt.registerOutParameter(12, java.sql.Types.NUMERIC);
            cstmt.registerOutParameter(13, java.sql.Types.VARCHAR);
            cstmt.registerOutParameter(14, java.sql.Types.NUMERIC);

            loggerDebug("antes execute");
            cstmt.execute();
            loggerDebug("despues execute");

            evaluaResultado(cstmt.getInt(12), cstmt.getString(13), cstmt.getInt(14));

        } catch (GestionLimiteConsumoException e) {
            throw e;
        } catch (Exception e) {
            loggerError(e);
            loggerError("Ocurrio un error al actualizar stock. " + e);
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
        loggerDebug("fin(DAO):actualizaStock");
    }

    /**
     * obtiene informacion de la series
     * 
     * @param
     * @return ProductoDTO
     * @throws GestionLimiteConsumoException
     */
    public SerieDTO obtieneDatosSerie(SerieDTO serieDTO) throws GestionLimiteConsumoException {

        loggerDebug("Inicio(DAO):obtieneDatosSerie");
        Connection conn = null;
        CallableStatement cstmt = null;
        conn = obtenerConexion();

        try {

            String call = getSQL("consultas.nombre.package", "consulta.datos.serie", 17);
            cstmt = conn.prepareCall(call);

            loggerDebug("1 - CodUso [ " + serieDTO.getShoCodUso() + " ]");
            loggerDebug("2 - TipTerminal [ " + serieDTO.getStrTipTerminal() + " ]");
            loggerDebug("3 - NumSerie [ " + serieDTO.getStrNumSerie() + " ]");

            cstmt.setShort(1, serieDTO.getShoCodUso());
            cstmt.setString(2, serieDTO.getStrTipTerminal());
            cstmt.setString(3, serieDTO.getStrNumSerie());
            cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
            cstmt.registerOutParameter(5, java.sql.Types.VARCHAR);
            cstmt.registerOutParameter(6, java.sql.Types.VARCHAR);
            cstmt.registerOutParameter(7, java.sql.Types.NUMERIC);
            cstmt.registerOutParameter(8, java.sql.Types.NUMERIC);
            cstmt.registerOutParameter(9, java.sql.Types.NUMERIC);
            cstmt.registerOutParameter(10, java.sql.Types.NUMERIC);
            cstmt.registerOutParameter(11, java.sql.Types.NUMERIC);
            cstmt.registerOutParameter(12, java.sql.Types.NUMERIC);
            cstmt.registerOutParameter(13, java.sql.Types.VARCHAR);
            cstmt.registerOutParameter(14, java.sql.Types.NUMERIC);
            cstmt.registerOutParameter(15, java.sql.Types.NUMERIC);
            cstmt.registerOutParameter(16, java.sql.Types.VARCHAR);
            cstmt.registerOutParameter(17, java.sql.Types.NUMERIC);

            loggerDebug("antes execute");
            cstmt.execute();
            loggerDebug("despues execute");

            evaluaResultado(cstmt.getInt(15), cstmt.getString(16), cstmt.getInt(17));

            serieDTO.setStrDesStock(cstmt.getString(4));
            serieDTO.setStrNumSerie(cstmt.getString(5));
            serieDTO.setStrNumSerieMec(cstmt.getString(6));
            serieDTO.setStrTipStock(cstmt.getString(7));
            serieDTO.setStrIndValorar(cstmt.getString(8));
            if (cstmt.getBigDecimal(9) != null) {
                serieDTO.setShoCodEstado(Short.valueOf(cstmt.getShort(9)));
            } else {
                serieDTO.setShoCodEstado(null);
            }
            if (cstmt.getBigDecimal(10) != null) {
                serieDTO.setLonNumTelefono(Long.valueOf(cstmt.getLong(10)));
            } else {
                serieDTO.setLonNumTelefono(null);
            }
            if (cstmt.getBigDecimal(11) != null) {
                serieDTO.setIntCodBodega(Integer.valueOf(cstmt.getInt(11)));
            } else {
                serieDTO.setIntCodBodega(null);
            }
            if (cstmt.getBigDecimal(12) != null) {
                serieDTO.setIntCodArticulo(Integer.valueOf(cstmt.getInt(12)));
            } else {
                serieDTO.setIntCodArticulo(null);
            }
            serieDTO.setStrDesArticulo(cstmt.getString(13));
            // serieDTO.setShoMesesGarantia(cstmt.getBigDecimal(14) != null ?
            // Short.valueOf(cstmt.getShort(14)) : null);

        } catch (GestionLimiteConsumoException e) {
            throw e;
        } catch (Exception e) {
            loggerError(e);
            loggerError("Ocurrio un error al obtener datos de la serie. " + e);
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

        loggerDebug("fin(DAO):obtieneDatosSerie");
        return serieDTO;
    }
}
