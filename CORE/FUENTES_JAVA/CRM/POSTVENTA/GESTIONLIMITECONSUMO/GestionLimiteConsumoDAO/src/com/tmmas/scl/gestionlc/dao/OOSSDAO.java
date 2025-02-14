package com.tmmas.scl.gestionlc.dao;

import java.math.BigDecimal;
import java.sql.CallableStatement;
import java.sql.Connection;

import com.tmmas.scl.gestionlc.common.dto.AbonadoDTO;
import com.tmmas.scl.gestionlc.common.dto.ContratoDTO;
import com.tmmas.scl.gestionlc.common.dto.EquipAboSerDTO;
import com.tmmas.scl.gestionlc.common.dto.FolioDTO;
import com.tmmas.scl.gestionlc.common.dto.InterfazAbonadoDTO;
import com.tmmas.scl.gestionlc.common.dto.OOSSDTO;
import com.tmmas.scl.gestionlc.common.dto.SerieDTO;
import com.tmmas.scl.gestionlc.common.dto.SiniestroDTO;
import com.tmmas.scl.gestionlc.common.dto.UsuarioDTO;
import com.tmmas.scl.gestionlc.common.exception.GestionLimiteConsumoException;
import com.tmmas.scl.gestionlc.dao.common.GestionLimiteConsumoAbstractDAO;

public class OOSSDAO extends GestionLimiteConsumoAbstractDAO {

    static final int SESTADOCONSUMIDO = 2;
    static final int SESTADODISPONIBLE = 3;
    static final int SESTADOORANOFOUND = 4;
    static final int SESTADOORAMANYROWS = 5;
    static final int SESTADONOCONSUMIDO = 8;

    /**
     * inserta en la tabla GA_MODABOCEL
     * 
     * @param
     * @return void
     * @throws GestionLimiteConsumoException
     */
    public void insertaModabocel(AbonadoDTO abonadoDTO, String strCodOperacion, SiniestroDTO siniestroDTO, UsuarioDTO usuarioDTO, String strCodCauCambio,
            ContratoDTO contratoDTO) throws GestionLimiteConsumoException {

        loggerDebug("Inicio(DAO):insertaModabocel");
        Connection conn = null;
        CallableStatement cstmt = null;
        conn = obtenerConexion();

        try {

            String call = getSQL("consultas.nombre.package", "inserta.datos.modabocel", 12);
            cstmt = conn.prepareCall(call);

            loggerDebug("1 - NumAbonado [ " + abonadoDTO.getLonNumAbonado() + " ]");
            loggerDebug("2 - CodOperacion [ " + strCodOperacion + " ]");
            loggerDebug("3 - NomUsuario [ " + usuarioDTO.getStrNomUsuario() + " ]");
            loggerDebug("4 - TipTerminal [ " + siniestroDTO.getStrTipTerminal() + " ]");
            loggerDebug("5 - NumSerie [ " + abonadoDTO.getStrNumSerie() + " ]");
            loggerDebug("6 - CodCauCambio [ " + strCodCauCambio + " ]");
            loggerDebug("7 - IndEqPrestado [ " + abonadoDTO.getStrIndEqPrestado() + " ]");
            loggerDebug("8 - CodTipContrato [ " + contratoDTO.getStrCodTipContrato() + " ]");
            loggerDebug("9 - NumMeses [ " + contratoDTO.getStrMesesMinimo() + " ]");

            cstmt.setLong(1, abonadoDTO.getLonNumAbonado().longValue());
            cstmt.setString(2, strCodOperacion);
            cstmt.setString(3, usuarioDTO.getStrNomUsuario());
            cstmt.setString(4, siniestroDTO.getStrTipTerminal());
            cstmt.setString(5, abonadoDTO.getStrNumSerie());
            cstmt.setString(6, strCodCauCambio);
            cstmt.setShort(7, Short.valueOf(abonadoDTO.getStrIndEqPrestado()));
            cstmt.setString(8, contratoDTO.getStrCodTipContrato());
            cstmt.setShort(9, Short.valueOf(contratoDTO.getStrMesesMinimo()));
            cstmt.registerOutParameter(10, java.sql.Types.VARCHAR);
            cstmt.registerOutParameter(11, java.sql.Types.VARCHAR);
            cstmt.registerOutParameter(12, java.sql.Types.NUMERIC);

            loggerDebug("antes execute");
            cstmt.execute();
            loggerDebug("despues execute");

            evaluaResultado(cstmt.getInt(10), cstmt.getString(11), cstmt.getInt(12));

        } catch (GestionLimiteConsumoException e) {
            throw e;
        } catch (Exception e) {
            loggerError(e);
            loggerError("Ocurrio un error al insertar en la tabla GA_MDOABOCEL. " + e);
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

        loggerDebug("fin(DAO):insertaModabocel");
    }

    /**
     * llama a P_INTERFASES_ABONADO
     * 
     * @param
     * @return InterfazAbonadoDTO
     * @throws GestionLimiteConsumoException
     */
    public InterfazAbonadoDTO ejecutaInterfasesAbonados(InterfazAbonadoDTO interfazAbonadoDTO) throws GestionLimiteConsumoException {

        loggerDebug("Inicio(DAO):ejecutaInterfasesAbonados");
        Connection conn = null;
        CallableStatement cstmt = null;
        conn = obtenerConexion();

        try {

            String call = getSQL("intermediario.nombre.package", "actualiza.interfaz.abonado", 13);
            cstmt = conn.prepareCall(call);

            loggerDebug("1 - StrActabo [ " + interfazAbonadoDTO.getStrActabo() + " ]");
            loggerDebug("2 - StrProducto [ " + interfazAbonadoDTO.getStrProducto() + " ]");
            loggerDebug("3 - StrAbonado [ " + interfazAbonadoDTO.getStrAbonado() + " ]");
            loggerDebug("4 - StrOrigen [ " + interfazAbonadoDTO.getStrOrigen() + " ]");
            loggerDebug("5 - StrDestino [ " + interfazAbonadoDTO.getStrDestino() + " ]");
            loggerDebug("6 - StrVar3 [ " + interfazAbonadoDTO.getStrVar3() + " ]");
            loggerDebug("7 - StrVar4 [ " + interfazAbonadoDTO.getStrVar4() + " ]");
            loggerDebug("8 - StrVar5 [ " + interfazAbonadoDTO.getStrVar5() + " ]");
            loggerDebug("9 - StrVar6 [ " + interfazAbonadoDTO.getStrVar6() + " ]");
            cstmt.setString(1, interfazAbonadoDTO.getStrActabo());
            cstmt.setString(2, interfazAbonadoDTO.getStrProducto());
            cstmt.setString(3, interfazAbonadoDTO.getStrAbonado());
            cstmt.setString(4, interfazAbonadoDTO.getStrOrigen());
            cstmt.setString(5, interfazAbonadoDTO.getStrDestino());
            cstmt.setString(6, interfazAbonadoDTO.getStrVar3());
            cstmt.setString(7, interfazAbonadoDTO.getStrVar4());
            cstmt.setString(8, interfazAbonadoDTO.getStrVar5());
            cstmt.setString(9, interfazAbonadoDTO.getStrVar6());
            cstmt.registerOutParameter(10, java.sql.Types.NUMERIC);
            cstmt.registerOutParameter(11, java.sql.Types.NUMERIC);
            cstmt.registerOutParameter(12, java.sql.Types.VARCHAR);
            cstmt.registerOutParameter(13, java.sql.Types.NUMERIC);

            loggerDebug("antes execute");
            cstmt.execute();
            loggerDebug("despues execute");

            evaluaResultado(cstmt.getInt(11), cstmt.getString(12), cstmt.getInt(13));

            interfazAbonadoDTO.setLonNumTransaccion(Long.valueOf(cstmt.getLong(10)));

        } catch (GestionLimiteConsumoException e) {
            throw e;
        } catch (Exception e) {
            loggerError(e);
            loggerError("Ocurrio un error al insertar en la tabla GA_MDOABOCEL. " + e);
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

        loggerDebug("fin(DAO):insertaModabocel");
        return interfazAbonadoDTO;
    }

    /**
     * inserta en la tabla GA_MODABOCEL
     * 
     * @param
     * @return FolioDTO
     * @throws GestionLimiteConsumoException
     */
    public FolioDTO cosultaFolio(UsuarioDTO usuarioDTO, String strCodCatTribut, Integer intOpcion, FolioDTO folioDTO, Integer intRangoInicial)

        throws GestionLimiteConsumoException {
        loggerDebug("Inicio(DAO):cosultaFolio");
        Connection conn = null;
        CallableStatement cstmt = null;
        conn = obtenerConexion();

        try {

            String call = getSQL("intermediario.nombre.package", "consulta.consumo.folio", 11);
            cstmt = conn.prepareCall(call);

            loggerDebug("1 - CodCatTribut [ " + strCodCatTribut + " ]");
            loggerDebug("2 - CodVendedor [ " + usuarioDTO.getIntCodVendedor() + " ]");
            loggerDebug("3 - NomUsuario [ " + usuarioDTO.getStrCodOficina() + " ]");
            loggerDebug("6 - PrefijoFolio [ " + folioDTO.getStrPrefijoFolio() + " ]");
            loggerDebug("5 - NumeroFolio [ " + folioDTO.getIntNumeroFolio() + " ]");
            loggerDebug("7 - RangoInicial [ " + intRangoInicial + " ]");
            loggerDebug("8 - Opcion [ " + intOpcion + " ]");

            cstmt.setString(1, strCodCatTribut);
            cstmt.setInt(2, usuarioDTO.getIntCodVendedor().intValue());
            cstmt.setString(3, usuarioDTO.getStrCodOficina());
            cstmt.setString(4, folioDTO.getStrPrefijoFolio());
            // cstmt.setBigDecimal(5, folioDTO.getIntNumeroFolio() != null ?
            // new BigDecimal(folioDTO.getIntNumeroFolio().intValue()) : null);
            if (folioDTO.getIntNumeroFolio() != null) {
                cstmt.setBigDecimal(5, new BigDecimal(folioDTO.getIntNumeroFolio().intValue()));
            } else {
                cstmt.setNull(5, java.sql.Types.NUMERIC);
            }
            // cstmt.setBigDecimal(6, intRangoInicial != null ? new
            // BigDecimal(intRangoInicial.intValue()): null);
            if (intRangoInicial != null) {
                cstmt.setBigDecimal(6, new BigDecimal(intRangoInicial.intValue()));
            } else {
                cstmt.setNull(6, java.sql.Types.NUMERIC);
            }
            cstmt.setInt(7, intOpcion.intValue());
            cstmt.registerOutParameter(8, java.sql.Types.VARCHAR);
            cstmt.registerOutParameter(9, java.sql.Types.VARCHAR);
            cstmt.registerOutParameter(10, java.sql.Types.VARCHAR);
            cstmt.registerOutParameter(11, java.sql.Types.NUMERIC);

            loggerDebug("antes execute");
            cstmt.execute();
            loggerDebug("despues execute");

            evaluaResultado(cstmt.getInt(9), cstmt.getString(10), cstmt.getInt(11));

            String strResultado = cstmt.getString(8);
            String[] resultados = strResultado.split(";");
            folioDTO.setIntCodEstadoFolio(Integer.valueOf(resultados[0]));
            folioDTO.setStrPrefijoFolio(resultados[1]);
            if (resultados[2] != null) {
                folioDTO.setIntNumeroFolio(Integer.valueOf(resultados[2]));
            } else {
                folioDTO.setIntNumeroFolio(Integer.valueOf(0));
            }

            if (intOpcion.equals(Integer.valueOf(getValorInterno("parametro.BusquedaSinRango")))) {
                if (folioDTO.getIntCodEstadoFolio().intValue() == SESTADOCONSUMIDO) {
                    folioDTO.setStrDesEstadoFolio(getValorInterno("parametro.sDESC_ESTADO_CONSUMIDO"));
                } else if (folioDTO.getIntCodEstadoFolio().intValue() == SESTADOORANOFOUND) {
                    folioDTO.setStrDesEstadoFolio(getValorInterno("parametro.sDESC_ESTADO_ORA_NO_FOUND"));
                    // valida venta sin folio
                    if (validaVentaSinFolio()) {
                        folioDTO.setShoIndFacturaCiclo(Short.valueOf(getValorInterno("parametro.FACTURA_CONTADO")));
                    } else {
                        throw new GestionLimiteConsumoException("ERR.0025", 0);
                    }
                } else if (folioDTO.getIntCodEstadoFolio().intValue() == SESTADOORAMANYROWS) {
                    folioDTO.setStrDesEstadoFolio(getValorInterno("parametro.sDESC_ESTADO_ORA_MANY_ROWS"));
                } else if (folioDTO.getIntCodEstadoFolio().intValue() == SESTADONOCONSUMIDO) {
                    folioDTO.setStrDesEstadoFolio(getValorInterno("parametro.sDESC_ESTADO_NO_CONSUMIDO"));
                }
            }

        } catch (GestionLimiteConsumoException e) {
            throw e;
        } catch (Exception e) {
            loggerError(e);
            loggerError("Ocurrio un error al ejecutar cosultaFolio. " + e);
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

        loggerDebug("fin(DAO):cosultaFolio");
        return folioDTO;
    }

    /**
     * valida posibilidad de hacer venta sin folio
     * 
     * @param
     * @return boolean
     * @throws GestionLimiteConsumoException
     */
    private boolean validaVentaSinFolio() throws GestionLimiteConsumoException {

        loggerDebug("Inicio(DAO):validaVentaSinFolio");

        Connection conn = null;
        CallableStatement cstmt = null;
        conn = obtenerConexion();
        Integer intIndVentaSinFolio = null;
        boolean bResultado;
        try {

            String call = getSQL("validaciones.nombre.package", "val.venta.sin.folio", 4);
            cstmt = conn.prepareCall(call);

            cstmt.registerOutParameter(1, java.sql.Types.NUMERIC);
            cstmt.registerOutParameter(2, java.sql.Types.VARCHAR);
            cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
            cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);

            loggerDebug("antes execute");
            cstmt.execute();
            loggerDebug("despues execute");

            evaluaResultado(cstmt.getInt(2), cstmt.getString(3), cstmt.getInt(4));

            intIndVentaSinFolio = Integer.valueOf(cstmt.getInt(1));

            if (!intIndVentaSinFolio.equals(Integer.valueOf(1))) {
                bResultado = false;
            } else {
                bResultado = true;
            }

        } catch (GestionLimiteConsumoException e) {
            throw e;
        } catch (Exception e) {
            loggerError(e);
            loggerError("Ocurrio un error al ejecutar validaVentaSinFolio. " + e);
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

        loggerDebug("fin(DAO):validaVentaSinFolio");

        return bResultado;
    }

    /**
     * inserta en la tabla GA_EQUIPABOSER el equipo
     * 
     * @param
     * @return void
     * @throws GestionLimiteConsumoException
     */
    public void insertaEquipAboSerEqui(EquipAboSerDTO equipAboSerDTO) throws GestionLimiteConsumoException {

        loggerDebug("Inicio(DAO):insertaEquipAboSerEqui");
        Connection conn = null;
        CallableStatement cstmt = null;
        conn = obtenerConexion();

        try {

            String call = getSQL("consultas.nombre.package", "inserta.equipaboser.equi", 26);
            cstmt = conn.prepareCall(call);

            loggerDebug("IN 1 CodBodega [" + equipAboSerDTO.getIntCodBodega() + "]");
            loggerDebug("IN 2 NumSerieMec [" + equipAboSerDTO.getStrNumSerieMec() + "]");
            loggerDebug("IN 3 CodEstado [" + equipAboSerDTO.getShoCodEstado() + "]");
            loggerDebug("IN 4 NumMovimiento [" + equipAboSerDTO.getLonNumMovimiento() + "]");
            loggerDebug("IN 5 bHayCargos [" + equipAboSerDTO.isbHayCargos() + "]");
            loggerDebug("IN 6 NumAbonado [" + equipAboSerDTO.getLonNumAbonado() + "]");
            loggerDebug("IN 7 NumSerie [" + equipAboSerDTO.getStrNumSerie() + "]");
            loggerDebug("IN 8 getStrTipStock [" + equipAboSerDTO.getStrTipStock() + "]");
            loggerDebug("IN 9 getIntCodArticulo [" + equipAboSerDTO.getIntCodArticulo() + "]");
            loggerDebug("IN 10 getStrIndProcEqui [" + equipAboSerDTO.getStrIndProcEqui() + "]");
            loggerDebug("IN 11 isbPLista [" + equipAboSerDTO.isbPLista() + "]");
            loggerDebug("IN 12 IndPropiedad [" + equipAboSerDTO.getStrIndPropiedad() + "]");
            loggerDebug("IN 13 TipTerminal [" + equipAboSerDTO.getStrTipTerminal() + "]");
            loggerDebug("IN 14 DesArticulo [" + equipAboSerDTO.getStrDesArticulo() + "]");
            loggerDebug("IN 15 CodUso [" + equipAboSerDTO.getShoCodUso() + "]");
            loggerDebug("IN 16 IndComodato [" + equipAboSerDTO.getShoIndComodato() + "]");
            loggerDebug("IN 17 CodTecnologia [" + equipAboSerDTO.getStrCodTecnologia() + "]");
            loggerDebug("IN 18 Importe [" + equipAboSerDTO.getDouImporte() + "]");
            loggerDebug("IN 19 TipDto [" + equipAboSerDTO.getShoTipDto() + "]");
            loggerDebug("IN 20 ValDto [" + equipAboSerDTO.getDouValDto() + "]");
            loggerDebug("IN 21 CodModVenta [" + equipAboSerDTO.getDouValDto() + "]");
            loggerDebug("IN 22 CodCuota [" + equipAboSerDTO.getShoCodCuota() + "]");
            loggerDebug("IN 23 CodCausa [" + equipAboSerDTO.getStrCodCausa() + "]");

            cstmt.setInt(1, equipAboSerDTO.getIntCodBodega());
            cstmt.setString(2, equipAboSerDTO.getStrNumSerieMec());
            cstmt.setShort(3, equipAboSerDTO.getShoCodEstado());
            cstmt.setLong(4, equipAboSerDTO.getLonNumMovimiento());

            if (equipAboSerDTO.isbHayCargos()) {
                cstmt.setString(5, getValorInterno("parametro.valor.true"));
            } else {
                cstmt.setString(5, getValorInterno("parametro.valor.false"));
            }
            cstmt.setLong(6, equipAboSerDTO.getLonNumAbonado());
            cstmt.setString(7, equipAboSerDTO.getStrNumSerie());
            cstmt.setString(8, equipAboSerDTO.getStrTipStock());
            cstmt.setInt(9, equipAboSerDTO.getIntCodArticulo());
            cstmt.setString(10, equipAboSerDTO.getStrIndProcEqui());

            if (equipAboSerDTO.isbPLista()) {
                cstmt.setString(11, getValorInterno("parametro.valor.true"));
            } else {
                cstmt.setString(11, getValorInterno("parametro.valor.false"));
            }

            cstmt.setString(12, equipAboSerDTO.getStrIndPropiedad());
            cstmt.setString(13, equipAboSerDTO.getStrTipTerminal());
            cstmt.setString(14, equipAboSerDTO.getStrDesArticulo());
            cstmt.setShort(15, equipAboSerDTO.getShoCodUso());
            cstmt.setShort(16, equipAboSerDTO.getShoIndComodato());
            cstmt.setString(17, equipAboSerDTO.getStrCodTecnologia());

            if (equipAboSerDTO.getDouImporte() != null) {
                cstmt.setBigDecimal(18, new BigDecimal(equipAboSerDTO.getDouImporte().doubleValue()));
            } else {
                cstmt.setNull(18, java.sql.Types.NUMERIC);
            }

            if (equipAboSerDTO.getShoTipDto() != null) {
                cstmt.setShort(19, equipAboSerDTO.getShoTipDto());
            } else {
                cstmt.setNull(19, java.sql.Types.NUMERIC);
            }

            if (equipAboSerDTO.getDouValDto() != null) {
                cstmt.setBigDecimal(20, new BigDecimal(equipAboSerDTO.getDouValDto().doubleValue()));
            } else {
                cstmt.setNull(20, java.sql.Types.NUMERIC);
            }

            if (equipAboSerDTO.getShoCodModVenta() != null) {
                cstmt.setShort(21, equipAboSerDTO.getShoCodModVenta());
            } else {
                cstmt.setNull(21, java.sql.Types.NUMERIC);
            }

            if (equipAboSerDTO.getShoCodCuota() != null) {
                cstmt.setShort(22, equipAboSerDTO.getShoCodCuota());
            } else {
                cstmt.setNull(22, java.sql.Types.NUMERIC);
            }

            cstmt.setString(23, equipAboSerDTO.getStrCodCausa());
            cstmt.registerOutParameter(24, java.sql.Types.VARCHAR);
            cstmt.registerOutParameter(25, java.sql.Types.VARCHAR);
            cstmt.registerOutParameter(26, java.sql.Types.NUMERIC);

            loggerDebug("antes execute");
            cstmt.execute();
            loggerDebug("despues execute");

            evaluaResultado(cstmt.getInt(24), cstmt.getString(25), cstmt.getInt(26));

        } catch (GestionLimiteConsumoException e) {
            throw e;
        } catch (Exception e) {
            loggerError(e);
            loggerError("Ocurrio un error al insertar en la tabla GA_EQUIPABOSER. " + e);
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

        loggerDebug("fin(DAO):insertaEquipAboSerEqui");
    }

    /**
     * inserta en la tabla GA_EQUIPABOSER la simcard
     * 
     * @param
     * @return void
     * @throws GestionLimiteConsumoException
     */
    public void insertaEquipAboSerSimc(EquipAboSerDTO equipAboSerDTO) throws GestionLimiteConsumoException {

        loggerDebug("Inicio(DAO):insertaEquipAboSerSimc");
        Connection conn = null;
        CallableStatement cstmt = null;
        conn = obtenerConexion();

        try {

            String call = getSQL("consultas.nombre.package", "inserta.equipaboser.simc", 26);
            cstmt = conn.prepareCall(call);

            loggerDebug("IN 1 CodBodega [" + equipAboSerDTO.getIntCodBodega() + "]");
            loggerDebug("IN 2 NumSerieMec [" + equipAboSerDTO.getStrNumSerieMec() + "]");
            loggerDebug("IN 3 CodEstado [" + equipAboSerDTO.getShoCodEstado() + "]");
            loggerDebug("IN 4 NumMovimiento [" + equipAboSerDTO.getLonNumMovimiento() + "]");
            loggerDebug("IN 5 bHayCargos [" + equipAboSerDTO.isbHayCargos() + "]");
            loggerDebug("IN 6 NumAbonado [" + equipAboSerDTO.getLonNumAbonado() + "]");
            loggerDebug("IN 7 NumSerie [" + equipAboSerDTO.getStrNumSerie() + "]");
            loggerDebug("IN 8 getStrTipStock [" + equipAboSerDTO.getStrTipStock() + "]");
            loggerDebug("IN 9 getIntCodArticulo [" + equipAboSerDTO.getIntCodArticulo() + "]");
            loggerDebug("IN 10 getStrIndProcEqui [" + equipAboSerDTO.getStrIndProcEqui() + "]");
            loggerDebug("IN 11 isbPLista [" + equipAboSerDTO.isbPLista() + "]");
            loggerDebug("IN 12 IndPropiedad [" + equipAboSerDTO.getStrIndPropiedad() + "]");
            loggerDebug("IN 13 TipTerminal [" + equipAboSerDTO.getStrTipTerminal() + "]");
            loggerDebug("IN 14 DesArticulo [" + equipAboSerDTO.getStrDesArticulo() + "]");
            loggerDebug("IN 15 CodUso [" + equipAboSerDTO.getShoCodUso() + "]");
            loggerDebug("IN 16 IndComodato [" + equipAboSerDTO.getShoIndComodato() + "]");
            loggerDebug("IN 17 CodTecnologia [" + equipAboSerDTO.getStrCodTecnologia() + "]");
            loggerDebug("IN 18 Importe [" + equipAboSerDTO.getDouImporte() + "]");
            loggerDebug("IN 19 TipDto [" + equipAboSerDTO.getShoTipDto() + "]");
            loggerDebug("IN 20 ValDto [" + equipAboSerDTO.getDouValDto() + "]");
            loggerDebug("IN 21 CodModVenta [" + equipAboSerDTO.getDouValDto() + "]");
            loggerDebug("IN 22 CodCuota [" + equipAboSerDTO.getShoCodCuota() + "]");
            loggerDebug("IN 23 CodCausa [" + equipAboSerDTO.getStrCodCausa() + "]");

            cstmt.setInt(1, equipAboSerDTO.getIntCodBodega());
            cstmt.setString(2, equipAboSerDTO.getStrNumSerieMec());
            cstmt.setShort(3, equipAboSerDTO.getShoCodEstado());
            cstmt.setLong(4, equipAboSerDTO.getLonNumMovimiento());

            if (equipAboSerDTO.isbHayCargos()) {
                cstmt.setString(5, getValorInterno("parametro.valor.true"));
            } else {
                cstmt.setString(5, getValorInterno("parametro.valor.false"));
            }

            cstmt.setLong(6, equipAboSerDTO.getLonNumAbonado());
            cstmt.setString(7, equipAboSerDTO.getStrNumSerie());
            cstmt.setString(8, equipAboSerDTO.getStrTipStock());
            cstmt.setInt(9, equipAboSerDTO.getIntCodArticulo());
            cstmt.setString(10, equipAboSerDTO.getStrIndProcEqui());
            cstmt.setString(11, equipAboSerDTO.getStrIndPropiedad());
            cstmt.setString(12, equipAboSerDTO.getStrTipTerminal());
            cstmt.setString(13, equipAboSerDTO.getStrDesArticulo());
            cstmt.setShort(14, equipAboSerDTO.getShoCodUso());

            if (equipAboSerDTO.isbPLista()) {
                cstmt.setString(15, getValorInterno("parametro.valor.true"));
            } else {
                cstmt.setString(15, getValorInterno("parametro.valor.false"));
            }

            cstmt.setShort(16, equipAboSerDTO.getShoIndComodato());
            cstmt.setString(17, equipAboSerDTO.getStrCodTecnologia());
            if (equipAboSerDTO.getDouImporte() != null) {
                cstmt.setBigDecimal(18, new BigDecimal(equipAboSerDTO.getDouImporte().doubleValue()));
            } else {
                cstmt.setNull(18, java.sql.Types.NUMERIC);
            }

            if (equipAboSerDTO.getShoTipDto() != null) {
                cstmt.setShort(19, equipAboSerDTO.getShoTipDto());
            } else {
                cstmt.setNull(19, java.sql.Types.NUMERIC);
            }

            if (equipAboSerDTO.getDouValDto() != null) {
                cstmt.setBigDecimal(20, new BigDecimal(equipAboSerDTO.getDouValDto().doubleValue()));
            } else {
                cstmt.setNull(20, java.sql.Types.NUMERIC);
            }

            if (equipAboSerDTO.getShoCodModVenta() != null) {
                cstmt.setShort(21, equipAboSerDTO.getShoCodModVenta());
            } else {
                cstmt.setNull(21, java.sql.Types.NUMERIC);
            }

            if (equipAboSerDTO.getShoCodCuota() != null) {
                cstmt.setShort(22, equipAboSerDTO.getShoCodCuota());
            } else {
                cstmt.setNull(22, java.sql.Types.NUMERIC);
            }

            cstmt.setString(23, equipAboSerDTO.getStrCodCausa());
            cstmt.registerOutParameter(24, java.sql.Types.VARCHAR);
            cstmt.registerOutParameter(25, java.sql.Types.VARCHAR);
            cstmt.registerOutParameter(26, java.sql.Types.NUMERIC);

            loggerDebug("antes execute");
            cstmt.execute();
            loggerDebug("despues execute");

            evaluaResultado(cstmt.getInt(24), cstmt.getString(25), cstmt.getInt(26));

        } catch (GestionLimiteConsumoException e) {
            throw e;
        } catch (Exception e) {
            loggerError(e);
            loggerError("Ocurrio un error al insertar en la tabla GA_EQUIPABOSER. " + e);
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

        loggerDebug("fin(DAO):insertaEquipAboSerSimc");
    }

    /**
     * inserta en la tabla CI_ORSERV
     * 
     * @param
     * @return void
     * @throws GestionLimiteConsumoException
     */
    public void insertaCiOrServ(OOSSDTO oossDTO) throws GestionLimiteConsumoException {

        loggerDebug("Inicio(DAO):insertaCiOrServ");
        Connection conn = null;
        CallableStatement cstmt = null;
        conn = obtenerConexion();

        try {

            String call = getSQL("consultas.nombre.package", "inserta.ooss.ciorserv", 16);
            cstmt = conn.prepareCall(call);

            loggerDebug("IN 1 NumOS     [ " + oossDTO.getLonNumOS() + " ]");
            loggerDebug("IN 2 CodOS     [ " + oossDTO.getStrCodOS() + " ]");
            loggerDebug("IN 3 Producto  [ " + oossDTO.getShoCodProducto() + " ]");
            loggerDebug("IN 4 TipInter  [ " + oossDTO.getShoTipInter() + " ]");
            loggerDebug("IN 5 CodInter  [ " + oossDTO.getLonCodInter() + " ]");
            loggerDebug("IN 6 UsuarioSCL[ " + oossDTO.getStrUsuario() + " ]");
            loggerDebug("IN 7 Fecha     [ " + oossDTO.getStrFecha() + " ]");
            loggerDebug("IN 8 Comentario[ " + oossDTO.getStrComentario() + " ]");
            loggerDebug("IN 9 NumCargo  [ " + oossDTO.getLonNumCargo() + " ]");
            loggerDebug("IN 10 CodModulo[ " + oossDTO.getStrCodModulo() + " ]");
            loggerDebug("IN 11 IdGestor [ " + oossDTO.getStrIdGestor() + " ]");
            loggerDebug("IN 12 NumMovOS [ " + oossDTO.getLonNumMovimiento() + " ]");
            loggerDebug("IN 13 EstadoOS [ " + oossDTO.getShoCodEstado() + " ]");

            if (oossDTO.getLonNumOS() != null) {
                cstmt.setBigDecimal(1, BigDecimal.valueOf(oossDTO.getLonNumOS().longValue()));
            } else {
                cstmt.setBigDecimal(1, null);
            }
            cstmt.setString(2, oossDTO.getStrCodOS());
            if (oossDTO.getShoCodProducto() != null) {
                cstmt.setBigDecimal(3, BigDecimal.valueOf(oossDTO.getShoCodProducto().shortValue()));
            } else {
                cstmt.setBigDecimal(3, null);
            }
            if (oossDTO.getShoTipInter() != null) {
                cstmt.setBigDecimal(4, BigDecimal.valueOf(oossDTO.getShoTipInter().shortValue()));
            } else {
                cstmt.setBigDecimal(4, null);
            }
            if (oossDTO.getLonCodInter() != null) {
                cstmt.setBigDecimal(5, BigDecimal.valueOf(oossDTO.getLonCodInter().longValue()));
            } else {
                cstmt.setBigDecimal(5, null);
            }
            cstmt.setString(6, oossDTO.getStrUsuario());
            cstmt.setString(7, oossDTO.getStrFecha());
            cstmt.setString(8, oossDTO.getStrComentario());
            if (oossDTO.getLonNumCargo() != null) {
                if (oossDTO.getLonNumCargo() != null) {
                    cstmt.setBigDecimal(9, BigDecimal.valueOf(oossDTO.getLonNumCargo().longValue()));
                } else {
                    cstmt.setBigDecimal(9, null);
                }
            } else {
                cstmt.setNull(9, java.sql.Types.NUMERIC);
            }
            cstmt.setString(10, oossDTO.getStrCodModulo());
            cstmt.setString(11, oossDTO.getStrIdGestor());
            if (oossDTO.getLonNumMovimiento() != null) {
                cstmt.setBigDecimal(12, BigDecimal.valueOf(oossDTO.getLonNumMovimiento().longValue()));
            } else {
                cstmt.setBigDecimal(12, null);
            }
            if (oossDTO.getShoCodEstado() != null) {
                cstmt.setBigDecimal(13, BigDecimal.valueOf(oossDTO.getShoCodEstado().intValue()));
            } else {
                cstmt.setBigDecimal(13, null);
            }
            cstmt.registerOutParameter(14, java.sql.Types.VARCHAR);
            cstmt.registerOutParameter(15, java.sql.Types.VARCHAR);
            cstmt.registerOutParameter(16, java.sql.Types.NUMERIC);

            loggerDebug("antes execute");
            cstmt.execute();
            loggerDebug("despues execute");

            evaluaResultado(cstmt.getInt(14), cstmt.getString(15), cstmt.getInt(16));

        } catch (GestionLimiteConsumoException e) {
            throw e;
        } catch (Exception e) {
            loggerError(e);
            loggerError("Ocurrio un error al insertar en la tabla CI_ORSERV. " + e);
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

        loggerDebug("fin(DAO):insertaCiOrServ");
    }

    /**
     * actualiza abonado
     * 
     * @param
     * @return void
     * @throws GestionLimiteConsumoException
     */
    public void actualizarAbonado(AbonadoDTO abonadoDTO, SerieDTO serieDTO, String strIndProcequi, ContratoDTO contratoDTO, boolean bCheckTerminal,
            String strNumContrato, String strNumAnexo) throws GestionLimiteConsumoException {

        loggerDebug("Inicio(DAO):actualizarAbonado");
        Connection conn = null;
        CallableStatement cstmt = null;
        conn = obtenerConexion();

        try {

            String call = getSQL("consultas.nombre.package", "actualiza.datos.abonado", 17);
            cstmt = conn.prepareCall(call);

            loggerDebug("IN 1 NomTabla [" + abonadoDTO.getStrNomTablaAbonado() + "]");
            loggerDebug("IN 2 NumSerieMec [" + serieDTO.getStrNumSerieMec() + "]");
            loggerDebug("IN 3 NumAbonado [" + abonadoDTO.getLonNumAbonado() + "]");
            loggerDebug("IN 4 NumSerie [" + serieDTO.getStrNumSerie() + "]");
            loggerDebug("IN 5 IndProcequi [" + strIndProcequi + "]");
            loggerDebug("IN 6 CodModVenta [" + abonadoDTO.getShoCodModVenta() + "]");
            loggerDebug("IN 7 TipTerminal [" + serieDTO.getStrTipTerminal() + "]");
            loggerDebug("IN 8 CodUso [" + serieDTO.getShoCodUso() + "]");
            loggerDebug("IN 9 IndComodato [" + contratoDTO.getStrIndComodato() + "]");
            loggerDebug("IN 10 bCheckTerminal [" + bCheckTerminal + "]");
            loggerDebug("IN 11 CodTecnologia [" + abonadoDTO.getStrCodTecnologia() + "]");
            loggerDebug("IN 12 NumContrato [" + strNumContrato + "]");
            loggerDebug("IN 13 NumAnexo [" + strNumAnexo + "]");
            loggerDebug("IN 14 CodTipContrato [" + contratoDTO.getStrCodTipContrato() + "]");

            cstmt.setString(1, abonadoDTO.getStrNomTablaAbonado());
            cstmt.setString(2, serieDTO.getStrNumSerieMec());
            cstmt.setLong(3, abonadoDTO.getLonNumAbonado().longValue());
            cstmt.setString(4, serieDTO.getStrNumSerie());
            cstmt.setString(5, strIndProcequi);
            cstmt.setShort(6, abonadoDTO.getShoCodModVenta().shortValue());
            cstmt.setString(7, serieDTO.getStrTipTerminal());
            cstmt.setShort(8, serieDTO.getShoCodUso().shortValue());
            cstmt.setString(9, contratoDTO.getStrIndComodato());

            if (bCheckTerminal) {
                cstmt.setString(10, getValorInterno("parametro.valor.true"));
            } else {
                cstmt.setString(10, getValorInterno("parametro.valor.false"));
            }

            cstmt.setString(11, abonadoDTO.getStrCodTecnologia());
            cstmt.setString(12, strNumContrato);
            cstmt.setString(13, strNumAnexo);
            cstmt.setString(14, contratoDTO.getStrCodTipContrato());
            cstmt.registerOutParameter(15, java.sql.Types.VARCHAR);
            cstmt.registerOutParameter(16, java.sql.Types.VARCHAR);
            cstmt.registerOutParameter(17, java.sql.Types.NUMERIC);

            loggerDebug("antes execute");
            cstmt.execute();
            loggerDebug("despues execute");

            evaluaResultado(cstmt.getInt(15), cstmt.getString(16), cstmt.getInt(17));

        } catch (GestionLimiteConsumoException e) {
            throw e;
        } catch (Exception e) {
            loggerError(e);
            loggerError("Ocurrio un error al actualizar en la tabla del abonado. " + e);
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

        loggerDebug("fin(DAO):actualizarAbonado");
    }

    /**
     * inserta contrato abonado
     * 
     * @param
     * @return void
     * @throws GestionLimiteConsumoException
     */
    public void insertaContrato(AbonadoDTO abonadoDTO, ContratoDTO contratoDTO, String strNumContrato, String strNumAnexo) throws GestionLimiteConsumoException {

        loggerDebug("Inicio(DAO):insertaContrato");
        Connection conn = null;
        CallableStatement cstmt = null;
        conn = obtenerConexion();

        try {

            String call = getSQL("consultas.nombre.package", "inserta.contrato", 9);
            cstmt = conn.prepareCall(call);

            loggerDebug("IN 1 CodProducto       [ " + getValorInterno("parametro.codigo.producto.uno") + " ]");
            loggerDebug("IN 2 NumAbonado        [ " + abonadoDTO.getLonNumAbonado() + " ]");
            loggerDebug("IN 3 CodCuenta         [ " + abonadoDTO.getLonCodCuenta() + " ]");
            loggerDebug("IN 4 CodTipContrato    [ " + contratoDTO.getStrCodTipContrato() + " ]");
            loggerDebug("IN 5 NumContrato       [ " + strNumContrato + " ]");
            loggerDebug("IN 6 NumAnexo          [ " + strNumAnexo + " ]");

            cstmt.setShort(1, Short.valueOf(getValorInterno("parametro.codigo.producto.uno")));
            if (abonadoDTO.getLonNumAbonado() != null) {
                cstmt.setBigDecimal(2, BigDecimal.valueOf(abonadoDTO.getLonNumAbonado().longValue()));
            } else {
                cstmt.setBigDecimal(2, null);
            }
            if (abonadoDTO.getLonCodCuenta() != null) {
                cstmt.setBigDecimal(3, BigDecimal.valueOf(abonadoDTO.getLonCodCuenta().longValue()));
            } else {
                cstmt.setBigDecimal(3, null);
            }
            cstmt.setString(4, contratoDTO.getStrCodTipContrato());
            cstmt.setString(5, strNumContrato);
            cstmt.setString(6, strNumAnexo);
            cstmt.registerOutParameter(7, java.sql.Types.VARCHAR);
            cstmt.registerOutParameter(8, java.sql.Types.VARCHAR);
            cstmt.registerOutParameter(9, java.sql.Types.NUMERIC);

            loggerDebug("antes execute");
            cstmt.execute();
            loggerDebug("despues execute");

            evaluaResultado(cstmt.getInt(7), cstmt.getString(8), cstmt.getInt(9));

        } catch (GestionLimiteConsumoException e) {
            throw e;
        } catch (Exception e) {
            loggerError(e);
            loggerError("Ocurrio un error al actualizar en la tabla del abonado. " + e);
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

        loggerDebug("fin(DAO):insertaContrato");
    }

    /**
     * inserta movimiento
     * 
     * @param
     * @return void
     * @throws GestionLimiteConsumoException
     */
    public void insertaMovimiento(AbonadoDTO abonadoDTO, SiniestroDTO siniestroDTO, SerieDTO serieDTO, Long lonNumOS, String strCodOS, Long lonNumSecIccAnt,
            String strNomUsuario, Long lonNumSecIcc) throws GestionLimiteConsumoException {

        loggerDebug("Inicio(DAO):insertaMovimiento");
        Connection conn = null;
        CallableStatement cstmt = null;
        conn = obtenerConexion();

        try {

            String call = getSQL("consultas.nombre.package", "inserta.movimiento", 18);
            cstmt = conn.prepareCall(call);

            loggerDebug("IN 1 NumAbonado        [ " + abonadoDTO.getLonNumAbonado() + " ]");
            loggerDebug("IN 2 TipTerminal       [ " + siniestroDTO.getStrTipTerminal() + " ]");
            loggerDebug("IN 3 NumSerieNew       [ " + serieDTO.getStrNumSerie() + " ]");
            loggerDebug("IN 4 NumSerieOld       [ " + abonadoDTO.getStrNumSerie() + " ]");
            loggerDebug("IN 5 codTecnologia     [ " + abonadoDTO.getStrCodTecnologia() + " ]");
            loggerDebug("IN 6 CodCliente        [ " + abonadoDTO.getLonCodCliente() + " ]");
            loggerDebug("IN 7 CodCentral        [ " + abonadoDTO.getShoCodCentral() + " ]");
            loggerDebug("IN 8 NumCelular        [ " + abonadoDTO.getLonNumCelular() + " ]");
            loggerDebug("IN 9 NumImei           [ " + abonadoDTO.getStrNumImei() + " ]");
            loggerDebug("IN 10 NumOS            [ " + lonNumOS + " ]");
            loggerDebug("IN 11 CodOS            [ " + strCodOS + " ]");
            loggerDebug("IN 12 NumSecIccAnt     [ " + lonNumSecIccAnt + " ]");
            loggerDebug("IN 13 NumSiniestro     [ " + siniestroDTO.getLonNumSiniestro() + " ]");
            loggerDebug("IN 14 NomUsuario       [ " + strNomUsuario + " ]");
            loggerDebug("IN 15 lonNumSecIccAnt  [ " + lonNumSecIcc + " ]");

            cstmt.setLong(1, abonadoDTO.getLonNumAbonado());
            cstmt.setString(2, siniestroDTO.getStrTipTerminal());
            cstmt.setString(3, serieDTO.getStrNumSerie());
            cstmt.setString(4, abonadoDTO.getStrNumSerie());
            cstmt.setString(5, abonadoDTO.getStrCodTecnologia());
            cstmt.setLong(6, abonadoDTO.getLonCodCliente());
            cstmt.setShort(7, abonadoDTO.getShoCodCentral());
            cstmt.setLong(8, abonadoDTO.getLonNumCelular());
            cstmt.setString(9, abonadoDTO.getStrNumImei());
            cstmt.setLong(10, lonNumOS);
            cstmt.setString(11, strCodOS);
            cstmt.setLong(12, lonNumSecIccAnt);
            cstmt.setLong(13, siniestroDTO.getLonNumSiniestro());
            cstmt.setString(14, strNomUsuario);
            cstmt.setLong(15, lonNumSecIcc);
            cstmt.registerOutParameter(16, java.sql.Types.VARCHAR);
            cstmt.registerOutParameter(17, java.sql.Types.VARCHAR);
            cstmt.registerOutParameter(18, java.sql.Types.NUMERIC);

            loggerDebug("antes execute");
            cstmt.execute();
            loggerDebug("despues execute");

            evaluaResultado(cstmt.getInt(16), cstmt.getString(17), cstmt.getInt(18));

        } catch (GestionLimiteConsumoException e) {
            throw e;
        } catch (Exception e) {
            loggerError(e);
            loggerError("Ocurrio un error al insertar el movimiento. " + e);
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

        loggerDebug("fin(DAO):insertaMovimiento");
    }

    /**
     * rehabilita serie Suspendida
     * 
     * @param
     * @return void
     * @throws GestionLimiteConsumoException
     */
    public void rehabilitarSuspension(AbonadoDTO abonadoDTO, SiniestroDTO siniestroDTO, Long lonNumOS, String strCodOS, Long lonNumSecIcc,
            String strNomUsuario, String strActabo) throws GestionLimiteConsumoException {

        loggerDebug("Inicio(DAO):rehabilitarSuspension");
        Connection conn = null;
        CallableStatement cstmt = null;
        conn = obtenerConexion();

        try {

            String call = getSQL("consultas.nombre.package", "rehabilita.suspension", 18);
            cstmt = conn.prepareCall(call);

            loggerDebug("IN 1 NomTablaAbonado   [ " + abonadoDTO.getStrNomTablaAbonado() + " ]");
            loggerDebug("IN 2 Actuacion         [ " + strActabo + " ]");
            loggerDebug("IN 3 NumAbonado        [ " + abonadoDTO.getLonNumAbonado() + " ]");
            loggerDebug("IN 4 TipTerminal       [ " + siniestroDTO.getStrTipTerminal() + " ]");
            loggerDebug("IN 5 NumSerieHex       [ " + abonadoDTO.getStrNumSerieHex() + " ]");
            loggerDebug("IN 6 NumSerieOld       [ " + abonadoDTO.getStrNumSerie() + " ]");
            loggerDebug("IN 7 codTecnologia     [ " + abonadoDTO.getStrCodTecnologia() + " ]");
            loggerDebug("IN 8 CodPlanTarif      [ " + abonadoDTO.getStrCodPlanTarif() + " ]");
            loggerDebug("IN 9 CodCentral        [ " + abonadoDTO.getShoCodCentral() + " ]");
            loggerDebug("IN 10 NumCelular       [ " + abonadoDTO.getLonNumCelular() + " ]");
            loggerDebug("IN 11 NumImei          [ " + abonadoDTO.getStrNumImei() + " ]");
            loggerDebug("IN 12 NumOS            [ " + lonNumOS + " ]");
            loggerDebug("IN 13 CodOS            [ " + strCodOS + " ]");
            loggerDebug("IN 14 NumSecIcc        [ " + lonNumSecIcc + " ]");
            loggerDebug("IN 15 NomUsuario       [ " + strNomUsuario + " ]");

            cstmt.setString(1, abonadoDTO.getStrNomTablaAbonado());
            cstmt.setString(2, strActabo);
            cstmt.setLong(3, abonadoDTO.getLonNumAbonado());
            cstmt.setString(4, siniestroDTO.getStrTipTerminal());
            cstmt.setString(5, abonadoDTO.getStrNumSerieHex());
            cstmt.setString(6, abonadoDTO.getStrNumSerie());
            cstmt.setString(7, abonadoDTO.getStrCodTecnologia());
            cstmt.setString(8, abonadoDTO.getStrCodPlanTarif());
            cstmt.setShort(9, abonadoDTO.getShoCodCentral());
            cstmt.setLong(10, abonadoDTO.getLonNumCelular());
            cstmt.setString(11, abonadoDTO.getStrNumImei());
            cstmt.setLong(12, lonNumOS);
            cstmt.setString(13, strCodOS);
            cstmt.setLong(14, lonNumSecIcc);
            cstmt.setString(15, strNomUsuario);
            cstmt.registerOutParameter(16, java.sql.Types.VARCHAR);
            cstmt.registerOutParameter(17, java.sql.Types.VARCHAR);
            cstmt.registerOutParameter(18, java.sql.Types.NUMERIC);

            loggerDebug("antes execute");
            cstmt.execute();
            loggerDebug("despues execute");

            evaluaResultado(cstmt.getInt(16), cstmt.getString(17), cstmt.getInt(18));

        } catch (GestionLimiteConsumoException e) {
            throw e;
        } catch (Exception e) {
            loggerError(e);
            loggerError("Ocurrio un error al rehabilitar serie. " + e);
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

        loggerDebug("fin(DAO):rehabilitarSuspension");
    }

    /**
     * cambia estado movimiento icc
     * 
     * @param
     * @return void
     * @throws GestionLimiteConsumoException
     */
    public void cambiarEstadoMovimientoICC(Long lonNumSecIcc) throws GestionLimiteConsumoException {

        loggerDebug("Inicio(DAO):cambiarEstadoMovimientoICC");
        Connection conn = null;
        CallableStatement cstmt = null;
        conn = obtenerConexion();

        try {

            String call = getSQL("consultas.nombre.package", "cambia.estado.movimiento", 4);
            cstmt = conn.prepareCall(call);

            loggerDebug("IN 1 NumSecIcc [ " + lonNumSecIcc + " ]");

            cstmt.setLong(1, lonNumSecIcc);
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
            loggerError("Ocurrio un error al cambiar el estado del movimiento serie. " + e);
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

        loggerDebug("fin(DAO):cambiarEstadoMovimientoICC");
    }
}
