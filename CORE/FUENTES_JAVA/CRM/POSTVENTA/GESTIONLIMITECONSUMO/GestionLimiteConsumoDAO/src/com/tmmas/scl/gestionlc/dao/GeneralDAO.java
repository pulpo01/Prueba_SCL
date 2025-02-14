package com.tmmas.scl.gestionlc.dao;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.util.ArrayList;

import com.tmmas.scl.gestionlc.common.dto.ArticuloDTO;
import com.tmmas.scl.gestionlc.common.dto.BodegaDTO;
import com.tmmas.scl.gestionlc.common.dto.CatTributariaDTO;
import com.tmmas.scl.gestionlc.common.dto.CausaCambioDTO;
import com.tmmas.scl.gestionlc.common.dto.ContratoDTO;
import com.tmmas.scl.gestionlc.common.dto.CuotaDTO;
import com.tmmas.scl.gestionlc.common.dto.EstadoDTO;
import com.tmmas.scl.gestionlc.common.dto.ModalidadDTO;
import com.tmmas.scl.gestionlc.common.dto.ParametroDTO;
import com.tmmas.scl.gestionlc.common.dto.ProrrogaDTO;
import com.tmmas.scl.gestionlc.common.dto.RestriccionesDTO;
import com.tmmas.scl.gestionlc.common.dto.UsoDTO;
import com.tmmas.scl.gestionlc.common.dto.UsuarioDTO;
import com.tmmas.scl.gestionlc.common.dto.ws.CargaModificacionLimiteConsumoOutDTO;
import com.tmmas.scl.gestionlc.common.dto.ws.IndicadorAbonoInDTO;
import com.tmmas.scl.gestionlc.common.dto.ws.IndicadorAbonoOutDTO;
import com.tmmas.scl.gestionlc.common.dto.ws.IndicadorVtaExternaVendedorInDTO;
import com.tmmas.scl.gestionlc.common.dto.ws.IndicadorVtaExternaVendedorOutDTO;
import com.tmmas.scl.gestionlc.common.exception.GestionLimiteConsumoException;
import com.tmmas.scl.gestionlc.dao.common.GestionLimiteConsumoAbstractDAO;

public class GeneralDAO extends GestionLimiteConsumoAbstractDAO {

    /**
     * permite obtener valor de un parametro
     * 
     * @param
     * @return ParametroDTO
     * @throws GestionLimiteConsumoException
     */
    public ParametroDTO obtieneParametros(ParametroDTO pParametroDTO) throws GestionLimiteConsumoException {

        loggerDebug("Inicio(DAO):obtieneParametros");
        Connection conn = null;
        CallableStatement cstmt = null;
        conn = obtenerConexion();
        ParametroDTO parametroDTO = new ParametroDTO();

        try {

            String call = getSQL("consultas.nombre.package", "obtiene.parametro", 7);
            cstmt = conn.prepareCall(call);

            loggerDebug("1 - NombreParametro [" + pParametroDTO.getStrNombreParametro() + "]");

            cstmt.setString(1, pParametroDTO.getStrNombreParametro());
            if (pParametroDTO.getStrCodigoModulo() != null) {
                cstmt.setString(2, pParametroDTO.getStrCodigoModulo());
            } else {
                cstmt.setNull(2, java.sql.Types.VARCHAR);
            }
            if (pParametroDTO.getIntCodigoProducto() != null) {
                cstmt.setInt(3, pParametroDTO.getIntCodigoProducto());
            } else {
                cstmt.setNull(3, java.sql.Types.NUMERIC);
            }

            cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
            cstmt.registerOutParameter(5, java.sql.Types.VARCHAR);
            cstmt.registerOutParameter(6, java.sql.Types.VARCHAR);
            cstmt.registerOutParameter(7, java.sql.Types.NUMERIC);

            loggerDebug("antes execute");
            cstmt.execute();
            loggerDebug("despues execute");

            loggerDebug("Valor Parametro: " + cstmt.getString(4));
            evaluaResultado(cstmt.getInt(5), cstmt.getString(6), cstmt.getInt(7));

            parametroDTO.setStrValorParametro(cstmt.getString(4));

        } catch (GestionLimiteConsumoException e) {
            loggerError(e);
            throw e;

        } catch (Exception e) {
            loggerError(e);
            loggerError("Ocurrio un error al ejecutar obtieneParametros. " + e);
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

        loggerDebug("fin(DAO):obtieneParametros");

        return parametroDTO;
    }

    /**
     * permite retornar la descripcion del grupo tecnologico
     * 
     * @param
     * @return String
     * @throws GestionLimiteConsumoException
     */
    public String obtieneDescGrupoTecnologico(String pCodTecnologia) throws GestionLimiteConsumoException {

        loggerDebug("Inicio(DAO):obtieneDescGrupoTecnologico");

        Connection conn = null;
        CallableStatement cstmt = null;
        conn = obtenerConexion();
        String strResultado = null;
        try {

            String call = getSQL("consultas.nombre.package", "consulta.datos.desc.grupo.tecno", 5);
            cstmt = conn.prepareCall(call);

            loggerDebug("1 - CodTecnologia [" + pCodTecnologia + "]");
            cstmt.setString(1, pCodTecnologia);

            cstmt.registerOutParameter(2, java.sql.Types.VARCHAR);
            cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
            cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
            cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);

            loggerDebug("antes execute");
            cstmt.execute();
            loggerDebug("despues execute");

            evaluaResultado(cstmt.getInt(3), cstmt.getString(4), cstmt.getInt(5));

            strResultado = cstmt.getString(2);

        } catch (GestionLimiteConsumoException e) {
            throw e;
        } catch (Exception e) {
            loggerError(e);
            loggerError("Ocurrio un error al ejecutar obtieneDescGrupoTecnologico. " + e);
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

        loggerDebug("fin(DAO):obtieneDescGrupoTecnologico");

        return strResultado;
    }

    /**
     * obtiene la descripcion asociada al codigo de un codSituacion
     * 
     * @param
     * @return String
     * @throws GestionLimiteConsumoException
     */
    public String obtieneDescSituacion(String pCodSituacion) throws GestionLimiteConsumoException {

        loggerDebug("Inicio(DAO):obtieneDescSituacion");

        Connection conn = null;
        CallableStatement cstmt = null;
        conn = obtenerConexion();
        String strResultado = null;
        try {

            String call = getSQL("consultas.nombre.package", "consulta.datos.desc.situacion", 5);
            cstmt = conn.prepareCall(call);

            loggerDebug("1 - CodSituacion [" + pCodSituacion + "]");
            cstmt.setString(1, pCodSituacion);

            cstmt.registerOutParameter(2, java.sql.Types.VARCHAR);
            cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
            cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
            cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);

            loggerDebug("antes execute");
            cstmt.execute();
            loggerDebug("despues execute");

            evaluaResultado(cstmt.getInt(3), cstmt.getString(4), cstmt.getInt(5));

            strResultado = cstmt.getString(2);

        } catch (GestionLimiteConsumoException e) {
            throw e;
        } catch (Exception e) {
            loggerError(e);
            loggerError("Ocurrio un error al ejecutar obtieneDescSituacion. " + e);
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

        loggerDebug("fin(DAO):obtieneDescSituacion");

        return strResultado;
    }

    /**
     * permite ejecutar el modelo de restricciones
     * 
     * @param
     * @throws GestionLimiteConsumoException
     */
    public void ejecutaModeloRestriccion(RestriccionesDTO pIn) throws GestionLimiteConsumoException {

        loggerDebug("Inicio(DAO):ejecutaModeloRestriccion");

        Connection conn = null;
        CallableStatement cstmt = null;
        conn = obtenerConexion();

        try {

            String call = getSQL("intermediario.nombre.package", "intermediario.ejecuta.esq.restriccion", 31);
            cstmt = conn.prepareCall(call);

            int i = 1;

            loggerDebug("---------Parametros para restriccion---------");

            cstmt.setString(i++, pIn.getStrSecuencia());
            loggerDebug(i - 1 + "Secuencia: " + pIn.getStrSecuencia());

            cstmt.setString(i++, pIn.getStrCodModulo());
            loggerDebug(i - 1 + "CodModulo: " + pIn.getStrCodModulo());

            cstmt.setString(i++, pIn.getStrCodProducto());
            loggerDebug(i - 1 + "CodProducto: " + pIn.getStrCodProducto());

            cstmt.setString(i++, pIn.getStrCodActAbo());
            loggerDebug(i - 1 + "CodActAbo: " + pIn.getStrCodActAbo());

            cstmt.setString(i++, pIn.getStrEvento());
            loggerDebug(i - 1 + "Evento: " + pIn.getStrEvento());

            cstmt.setString(i++, pIn.getStrPrograma());
            loggerDebug(i - 1 + "Programa: " + pIn.getStrPrograma());

            cstmt.setString(i++, pIn.getStrProceso());
            loggerDebug(i - 1 + "Proceso: " + pIn.getStrProceso());

            cstmt.setString(i++, pIn.getStrCodActAboDet());
            loggerDebug(i - 1 + "CodActAboDet: " + pIn.getStrCodActAboDet());

            cstmt.setString(i++, pIn.getStrNumAbonado());
            loggerDebug(i - 1 + "NumAbonado: " + pIn.getStrNumAbonado());

            cstmt.setString(i++, pIn.getStrCodCliente());
            loggerDebug(i - 1 + "CodCliente: " + pIn.getStrCodCliente());

            cstmt.setString(i++, pIn.getStrCodModGener());
            loggerDebug(i - 1 + "CodModGener: " + pIn.getStrCodModGener());

            cstmt.setString(i++, pIn.getStrNumVenta());
            loggerDebug(i - 1 + "NumVenta: " + pIn.getStrNumVenta());

            cstmt.setString(i++, pIn.getStrCodOs());
            loggerDebug(i - 1 + "CodOs: " + pIn.getStrCodOs());

            cstmt.setString(i++, pIn.getStrCodVendedor());
            loggerDebug(i - 1 + "CodVendedor: " + pIn.getStrCodVendedor());

            cstmt.setString(i++, pIn.getStrDesSs());
            loggerDebug(i - 1 + "DesSs: " + pIn.getStrDesSs());

            cstmt.setString(i++, pIn.getStrCodPlanTarifd());
            loggerDebug(i - 1 + "CodPlanTarifd: " + pIn.getStrCodPlanTarifd());

            cstmt.setString(i++, pIn.getStrCodUso());
            loggerDebug(i - 1 + "CodUso: " + pIn.getStrCodUso());

            cstmt.setString(i++, pIn.getStrCodCuentaOrigen());
            loggerDebug(i - 1 + "CodCuentaOrigen: " + pIn.getStrCodCuentaOrigen());

            cstmt.setString(i++, pIn.getStrCodCuentaDest());
            loggerDebug(i - 1 + "CodCuentaDest: " + pIn.getStrCodCuentaDest());

            cstmt.setString(i++, pIn.getStrCodClienteDest());
            loggerDebug(i - 1 + "CodClienteDest: " + pIn.getStrCodClienteDest());

            cstmt.setString(i++, pIn.getStrCodTipPlanTarif());
            loggerDebug(i - 1 + "CodTipPlanTarif: " + pIn.getStrCodTipPlanTarif());

            cstmt.setString(i++, pIn.getStrCodTipPlanTarid());
            loggerDebug(i - 1 + "CodTipPlanTarid: " + pIn.getStrCodTipPlanTarid());

            cstmt.setString(i++, pIn.getStrCodCiclo());
            loggerDebug(i - 1 + "CodCiclo: " + pIn.getStrCodCiclo());

            cstmt.setString(i++, pIn.getStrCodFechaSistema());
            loggerDebug(i - 1 + "CodFechaSistema: " + pIn.getStrCodFechaSistema());

            cstmt.setString(i++, pIn.getStrRestriccion());
            loggerDebug(i - 1 + "Restriccion: " + pIn.getStrRestriccion());

            cstmt.setString(i++, pIn.getStrCodModuloDet());
            loggerDebug(i - 1 + "CodModuloDet: " + pIn.getStrCodModuloDet());

            cstmt.setString(i++, pIn.getStrNumId());
            loggerDebug(i - 1 + "NumId: " + pIn.getStrNumId());

            cstmt.setString(i++, pIn.getStrCodCentral());
            loggerDebug(i - 1 + "CodCentral: " + pIn.getStrCodCentral());

            loggerDebug("---------Parametros para restriccion---------");

            int intCodError = i;
            cstmt.registerOutParameter(i++, java.sql.Types.VARCHAR);

            int intDescError = i;
            cstmt.registerOutParameter(i++, java.sql.Types.VARCHAR);

            int intNumEvent = i;
            cstmt.registerOutParameter(i, java.sql.Types.NUMERIC);

            loggerDebug("antes execute");
            cstmt.execute();
            loggerDebug("despues execute");

            evaluaResultado(cstmt.getInt(intCodError), cstmt.getString(intDescError), cstmt.getInt(intNumEvent));

        } catch (GestionLimiteConsumoException e) {
            throw e;
        } catch (Exception e) {
            loggerError(e);
            loggerError("Ocurrio un error al ejecutar ejecutaModeloRestriccion. " + e);
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

        loggerDebug("Fin(DAO):ejecutaModeloRestriccion");

    }

    /**
     * permite obtener el proximo valor de una secuencia
     * 
     * @param
     * @return String
     * @throws GestionLimiteConsumoException
     */
    public String obtieneNextValSecuencia(String pNombreSecuencia) throws GestionLimiteConsumoException {

        loggerDebug("Inicio(DAO):obtieneNextValSecuencia");

        Connection conn = null;
        CallableStatement cstmt = null;
        conn = obtenerConexion();
        String strResultado = null;

        try {

            String call = getSQL("consultas.nombre.package", "consulta.seq.nextval", 5);
            cstmt = conn.prepareCall(call);

            loggerDebug("1 - NombreSecuencia [" + pNombreSecuencia + "]");
            cstmt.setString(1, pNombreSecuencia);

            cstmt.registerOutParameter(2, java.sql.Types.VARCHAR);
            cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
            cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
            cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);

            loggerDebug("antes execute");
            cstmt.execute();
            loggerDebug("despues execute");

            evaluaResultado(cstmt.getInt(3), cstmt.getString(4), cstmt.getInt(5));

            strResultado = cstmt.getString(2);

        } catch (GestionLimiteConsumoException e) {
            throw e;
        } catch (Exception e) {
            loggerError(e);
            loggerError("Ocurrio un error al ejecutar obtieneNextValSecuencia. " + e);
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

        loggerDebug("Fin(DAO):obtieneNextValSecuencia");

        return strResultado;
    }

    /**
     * permite retornar la fecha actual como string
     * 
     * @param
     * @return String (strSysdate)
     * @throws GestionLimiteConsumoException
     */
    public String getSysdateAsString(String strFormatoFecha) throws GestionLimiteConsumoException {

        loggerDebug("Inicio(DAO):getSysdateAsString");

        Connection conn = null;
        CallableStatement cstmt = null;
        conn = obtenerConexion();
        String strSysdate = null;
        try {

            String call = getSQL("consultas.nombre.package", "consulta.datos.fecha.actual", 5);
            cstmt = conn.prepareCall(call);

            loggerDebug("1 - FormatoFecha [" + strFormatoFecha + "]");

            cstmt.setString(1, strFormatoFecha);
            cstmt.registerOutParameter(2, java.sql.Types.VARCHAR);
            cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
            cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
            cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);

            loggerDebug("antes execute");
            cstmt.execute();
            loggerDebug("despues execute");

            evaluaResultado(cstmt.getInt(3), cstmt.getString(4), cstmt.getInt(5));

            strSysdate = cstmt.getString(2);

        } catch (GestionLimiteConsumoException e) {
            throw e;
        } catch (Exception e) {
            loggerError(e);
            loggerError("Ocurrio un error al obtener fecha actual. " + e);
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

        loggerDebug("Fin(DAO):getSysdateAsString");

        return strSysdate;
    }

    /**
     * permite retornar los dias transcurridos desde la fecha indicada
     * 
     * @param
     * @return iDiasPasados(int)
     * @throws GestionLimiteConsumoException
     */
    public Integer getDiasPasados(String strFecha) throws GestionLimiteConsumoException {

        loggerDebug("Inicio(DAO):getDiasPasados");

        Connection conn = null;
        CallableStatement cstmt = null;
        conn = obtenerConexion();
        Integer intDiasPasados = 0;
        try {

            String call = getSQL("consultas.nombre.package", "consulta.datos.dias.transcurridos", 5);
            cstmt = conn.prepareCall(call);

            loggerDebug("1 - strFecha [" + strFecha + "]");
            cstmt.setString(1, strFecha);
            cstmt.registerOutParameter(2, java.sql.Types.NUMERIC);
            cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
            cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
            cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);

            loggerDebug("antes execute");
            cstmt.execute();
            loggerDebug("despues execute");

            evaluaResultado(cstmt.getInt(3), cstmt.getString(4), cstmt.getInt(5));

            intDiasPasados = Integer.valueOf(cstmt.getInt(2));

        } catch (GestionLimiteConsumoException e) {
            throw e;
        } catch (Exception e) {
            loggerError(e);
            loggerError("Ocurrio un error al obtener fecha actual. " + e);
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

        loggerDebug("Fin(DAO):getDiasPasados");

        return intDiasPasados;
    }

    /**
     * obtiene una lista de tipos de contrato
     * 
     * @param
     * @return ContratoDTO[]
     * @throws GestionLimiteConsumoException
     */
    public ContratoDTO[] obtieneListaContratos(String strNomUsuario, String strCodPrograma, String strIndEqPRestado) throws GestionLimiteConsumoException {

        loggerDebug("Inicio(DAO):obtieneListaContratos");

        Connection conn = null;
        CallableStatement cstmt = null;
        conn = obtenerConexion();
        ArrayList<ContratoDTO> arrSCComboContrato = new ArrayList<ContratoDTO>();
        ContratoDTO[] contratoDTOs = null;
        try {

            String call = getSQL("consultas.nombre.package", "consulta.lista.contratos", 7);
            cstmt = conn.prepareCall(call);

            loggerDebug("1 - strNomUsuario [" + strNomUsuario + "]");
            loggerDebug("2 - strCodPrograma [" + strCodPrograma + "]");
            loggerDebug("3 - strIndEqPRestado [" + strIndEqPRestado + "]");

            cstmt.setString(1, strNomUsuario);
            cstmt.setString(2, strCodPrograma);
            cstmt.setString(3, strIndEqPRestado);
            cstmt.registerOutParameter(4, oracle.jdbc.driver.OracleTypes.CURSOR);
            cstmt.registerOutParameter(5, java.sql.Types.VARCHAR);
            cstmt.registerOutParameter(6, java.sql.Types.VARCHAR);
            cstmt.registerOutParameter(7, java.sql.Types.NUMERIC);

            loggerDebug("antes execute");
            cstmt.execute();
            loggerDebug("despues execute");

            evaluaResultado(cstmt.getInt(5), cstmt.getString(6), cstmt.getInt(7));

            ResultSet rs = (ResultSet) cstmt.getObject(4);
            while (rs.next()) {
                ContratoDTO contratoDTO = new ContratoDTO();
                contratoDTO.setStrCodTipContrato(rs.getString(1));
                contratoDTO.setStrDesTipContrato(rs.getString(2));
                contratoDTO.setStrIndComodato(rs.getString(3));
                contratoDTO.setStrMesesMinimo(rs.getString(4));
                contratoDTO.setStrIndPrecioLista(rs.getString(5));
                contratoDTO.setStrIndProcequi(rs.getString(6));

                arrSCComboContrato.add(contratoDTO);
            }
            loggerDebug("registros obtenidos [ " + arrSCComboContrato.size() + " ]");
            contratoDTOs = (ContratoDTO[]) arrSCComboContrato.toArray(new ContratoDTO[arrSCComboContrato.size()]);

        } catch (GestionLimiteConsumoException e) {
            throw e;
        } catch (Exception e) {
            loggerError(e);
            loggerError("Ocurrio un error al ejecutar obtieneListaContratos. " + e);
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

        loggerDebug("Fin(DAO):obtieneListaContratos");

        return contratoDTOs;
    }

    /**
     * obtiene una lista de tipos de contrato
     * 
     * @param
     * @return ContratoDTO
     * @throws GestionLimiteConsumoException
     */
    public ContratoDTO obtieneDetalleContrato(ContratoDTO contratoDTO) throws GestionLimiteConsumoException {

        loggerDebug("Inicio(DAO):obtieneDetalleContrato");

        Connection conn = null;
        CallableStatement cstmt = null;
        conn = obtenerConexion();
        try {

            String call = getSQL("consultas.nombre.package", "consulta.datos.contrato", 5);
            cstmt = conn.prepareCall(call);

            loggerDebug("1 - StrCodTipContrato [" + contratoDTO.getStrCodTipContrato() + "]");

            cstmt.setString(1, contratoDTO.getStrCodTipContrato());
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
                contratoDTO.setStrCodTipContrato(rs.getString(1));
                contratoDTO.setStrDesTipContrato(rs.getString(2));
                contratoDTO.setStrIndComodato(rs.getString(3));
                contratoDTO.setStrMesesMinimo(rs.getString(4));
                contratoDTO.setStrIndPrecioLista(rs.getString(5));
                contratoDTO.setStrIndProcequi(rs.getString(6));

            }

        } catch (GestionLimiteConsumoException e) {
            throw e;
        } catch (Exception e) {
            loggerError(e);
            loggerError("Ocurrio un error al ejecutar obtieneListaContratos. " + e);
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

        loggerDebug("Fin(DAO):obtieneDetalleContrato");

        return contratoDTO;
    }

    /**
     * obtiene una lista de modalidades de pago
     * 
     * @param
     * @return ModalidadDTO[]
     * @throws GestionLimiteConsumoException
     */
    public ModalidadDTO[] obtieneListaModalidad(UsuarioDTO usuarioDTO, String strCodPrograma, ContratoDTO contratoDTO, String strCodPlanTarif)

        throws GestionLimiteConsumoException {
        loggerDebug("Inicio(DAO):obtieneListaModalidad");
        Connection conn = null;
        CallableStatement cstmt = null;
        conn = obtenerConexion();
        ArrayList<ModalidadDTO> arrSCComboModalidad = new ArrayList<ModalidadDTO>();
        ModalidadDTO[] modalidadDTOs = null;
        try {

            String call = getSQL("consultas.nombre.package", "consulta.lista.modalidad", 10);
            cstmt = conn.prepareCall(call);

            loggerDebug("1 - StrNomUsuario [" + usuarioDTO.getStrNomUsuario() + "]");
            loggerDebug("2 - StrCodPrograma [" + strCodPrograma + "]");
            loggerDebug("3 - StrCodTipComis [" + usuarioDTO.getStrCodTipComis() + "]");
            loggerDebug("4 - StrCodTipContrato [" + contratoDTO.getStrCodTipContrato() + "]");
            loggerDebug("5 - StrMesesMinimo [" + contratoDTO.getStrMesesMinimo() + "]");
            loggerDebug("6 - StrCodPlanTarif [" + strCodPlanTarif + "]");
            cstmt.setString(1, usuarioDTO.getStrNomUsuario());
            cstmt.setString(2, strCodPrograma);
            cstmt.setString(3, usuarioDTO.getStrCodTipComis());
            cstmt.setString(4, contratoDTO.getStrCodTipContrato());
            cstmt.setString(5, contratoDTO.getStrMesesMinimo());
            cstmt.setString(6, strCodPlanTarif);
            cstmt.registerOutParameter(7, oracle.jdbc.driver.OracleTypes.CURSOR);
            cstmt.registerOutParameter(8, java.sql.Types.VARCHAR);
            cstmt.registerOutParameter(9, java.sql.Types.VARCHAR);
            cstmt.registerOutParameter(10, java.sql.Types.NUMERIC);

            loggerDebug("antes execute");
            cstmt.execute();
            loggerDebug("despues execute");

            evaluaResultado(cstmt.getInt(8), cstmt.getString(9), cstmt.getInt(10));

            ResultSet rs = (ResultSet) cstmt.getObject(7);
            while (rs.next()) {
                ModalidadDTO modalidadDTO = new ModalidadDTO();
                modalidadDTO.setShoIndCuotas(Short.valueOf(rs.getShort(1)));
                modalidadDTO.setShoCodModVenta(Short.valueOf(rs.getShort(2)));
                modalidadDTO.setStrDesModVenta(rs.getString(3));

                arrSCComboModalidad.add(modalidadDTO);
            }
            loggerDebug("registros obtenidos [ " + arrSCComboModalidad.size() + " ]");
            modalidadDTOs = (ModalidadDTO[]) arrSCComboModalidad.toArray(new ModalidadDTO[arrSCComboModalidad.size()]);

        } catch (GestionLimiteConsumoException e) {
            throw e;
        } catch (Exception e) {
            loggerError(e);
            loggerError("Ocurrio un error al ejecutar obtieneListaModalidad. " + e);
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

        loggerDebug("Fin(DAO):obtieneListaModalidad");

        return modalidadDTOs;
    }

    /**
     * obtiene una lista de bodegas
     * 
     * @param
     * @return BodegaDTO[]
     * @throws GestionLimiteConsumoException
     */
    public BodegaDTO[] obtieneListaBodegas(Integer intCodVendedor, String strCodOperadora) throws GestionLimiteConsumoException {

        loggerDebug("Inicio(DAO):obtieneListaBodegas");

        Connection conn = null;
        CallableStatement cstmt = null;
        conn = obtenerConexion();
        ArrayList<BodegaDTO> arrSCComboBodegas = new ArrayList<BodegaDTO>();
        BodegaDTO[] bodegaDTOs = null;
        try {

            String call = getSQL("consultas.nombre.package", "consulta.lista.bodegas", 6);
            cstmt = conn.prepareCall(call);

            loggerDebug("1 - CodVendedor [" + intCodVendedor + "]");
            loggerDebug("1 - CodOperadora [" + strCodOperadora + "]");

            cstmt.setInt(1, intCodVendedor.intValue());
            cstmt.setString(2, strCodOperadora);
            cstmt.registerOutParameter(3, oracle.jdbc.driver.OracleTypes.CURSOR);
            cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
            cstmt.registerOutParameter(5, java.sql.Types.VARCHAR);
            cstmt.registerOutParameter(6, java.sql.Types.NUMERIC);

            loggerDebug("antes execute");
            cstmt.execute();
            loggerDebug("despues execute");

            evaluaResultado(cstmt.getInt(4), cstmt.getString(5), cstmt.getInt(6));

            ResultSet rs = (ResultSet) cstmt.getObject(3);
            while (rs.next()) {
                BodegaDTO bodegaDTO = new BodegaDTO();
                bodegaDTO.setIntCodBodega(Integer.valueOf(rs.getInt(1)));
                bodegaDTO.setStrDesBodega(rs.getString(2));

                arrSCComboBodegas.add(bodegaDTO);
            }
            loggerDebug("registros obtenidos [ " + arrSCComboBodegas.size() + " ]");
            bodegaDTOs = (BodegaDTO[]) arrSCComboBodegas.toArray(new BodegaDTO[arrSCComboBodegas.size()]);

        } catch (GestionLimiteConsumoException e) {
            throw e;
        } catch (Exception e) {
            loggerError(e);
            loggerError("Ocurrio un error al ejecutar obtieneListaBodegas. " + e);
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

        loggerDebug("Fin(DAO):obtieneListaBodegas");

        return bodegaDTOs;
    }

    /**
     * obtiene una lista de usos
     * 
     * @param void
     * @return UsoDTO[]
     * @throws GestionLimiteConsumoException
     */
    public UsoDTO[] obtieneListaUsos() throws GestionLimiteConsumoException {

        loggerDebug("Inicio(DAO):obtieneListaUsos");

        Connection conn = null;
        CallableStatement cstmt = null;
        conn = obtenerConexion();
        ArrayList<UsoDTO> arrSCComboUsos = new ArrayList<UsoDTO>();
        UsoDTO[] usoDTOs = null;
        try {

            String call = getSQL("consultas.nombre.package", "consulta.lista.usos", 4);
            cstmt = conn.prepareCall(call);

            cstmt.registerOutParameter(1, oracle.jdbc.driver.OracleTypes.CURSOR);
            cstmt.registerOutParameter(2, java.sql.Types.VARCHAR);
            cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
            cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);

            loggerDebug("antes execute");
            cstmt.execute();
            loggerDebug("despues execute");

            evaluaResultado(cstmt.getInt(2), cstmt.getString(3), cstmt.getInt(4));

            ResultSet rs = (ResultSet) cstmt.getObject(1);
            while (rs.next()) {
                UsoDTO usoDTO = new UsoDTO();
                usoDTO.setIntCodUso(Integer.valueOf(rs.getInt(1)));
                usoDTO.setStrDesUso(rs.getString(2));

                arrSCComboUsos.add(usoDTO);
            }
            loggerDebug("registros obtenidos [ " + arrSCComboUsos.size() + " ]");
            usoDTOs = (UsoDTO[]) arrSCComboUsos.toArray(new UsoDTO[arrSCComboUsos.size()]);

        } catch (GestionLimiteConsumoException e) {
            throw e;
        } catch (Exception e) {
            loggerError(e);
            loggerError("Ocurrio un error al ejecutar obtieneListaUsos. " + e);
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

        loggerDebug("Fin(DAO):obtieneListaUsos");

        return usoDTOs;
    }

    /**
     * obtiene una lista de Estados
     * 
     * @param void
     * @return EstadoDTO[]
     * @throws GestionLimiteConsumoException
     */
    public EstadoDTO[] obtieneListaEstados() throws GestionLimiteConsumoException {

        loggerDebug("Inicio(DAO):obtieneListaEstados");

        Connection conn = null;
        CallableStatement cstmt = null;
        conn = obtenerConexion();
        ArrayList<EstadoDTO> arrSCComboEstados = new ArrayList<EstadoDTO>();
        EstadoDTO[] estadoDTOs = null;
        try {

            String call = getSQL("consultas.nombre.package", "consulta.lista.estados", 4);
            cstmt = conn.prepareCall(call);

            cstmt.registerOutParameter(1, oracle.jdbc.driver.OracleTypes.CURSOR);
            cstmt.registerOutParameter(2, java.sql.Types.VARCHAR);
            cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
            cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);

            loggerDebug("antes execute");
            cstmt.execute();
            loggerDebug("despues execute");

            evaluaResultado(cstmt.getInt(2), cstmt.getString(3), cstmt.getInt(4));

            ResultSet rs = (ResultSet) cstmt.getObject(1);
            while (rs.next()) {
                EstadoDTO estadoDTO = new EstadoDTO();
                estadoDTO.setIntCodEstado(Integer.valueOf(rs.getInt(1)));
                estadoDTO.setStrDesEstado(rs.getString(2));

                arrSCComboEstados.add(estadoDTO);
            }
            loggerDebug("registros obtenidos [ " + arrSCComboEstados.size() + " ]");
            estadoDTOs = (EstadoDTO[]) arrSCComboEstados.toArray(new EstadoDTO[arrSCComboEstados.size()]);

        } catch (GestionLimiteConsumoException e) {
            throw e;
        } catch (Exception e) {
            loggerError(e);
            loggerError("Ocurrio un error al ejecutar obtieneListaEstados. " + e);
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

        loggerDebug("Fin(DAO):obtieneListaEstados");

        return estadoDTOs;
    }

    /**
     * obtiene una lista de prorrogas
     * 
     * @param void
     * @return ProrrogaDTO[]
     * @throws GestionLimiteConsumoException
     */
    public ProrrogaDTO[] obtieneListaProrrogas() throws GestionLimiteConsumoException {

        loggerDebug("Inicio(DAO):obtieneListaProrrogas");

        Connection conn = null;
        CallableStatement cstmt = null;
        conn = obtenerConexion();
        ArrayList<ProrrogaDTO> arrSCComboProrrogas = new ArrayList<ProrrogaDTO>();
        ProrrogaDTO[] prorrogaDTOs = null;
        try {

            String call = getSQL("consultas.nombre.package", "consulta.lista.prorrogas", 4);
            cstmt = conn.prepareCall(call);

            cstmt.registerOutParameter(1, oracle.jdbc.driver.OracleTypes.CURSOR);
            cstmt.registerOutParameter(2, java.sql.Types.VARCHAR);
            cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
            cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);

            loggerDebug("antes execute");
            cstmt.execute();
            loggerDebug("despues execute");

            evaluaResultado(cstmt.getInt(2), cstmt.getString(3), cstmt.getInt(4));

            ResultSet rs = (ResultSet) cstmt.getObject(1);
            while (rs.next()) {
                ProrrogaDTO prorrogaDTO = new ProrrogaDTO();
                prorrogaDTO.setIntNumMeses(Integer.valueOf(rs.getInt(1)));
                prorrogaDTO.setStrDesProrroga(rs.getString(2));

                arrSCComboProrrogas.add(prorrogaDTO);
            }
            loggerDebug("registros obtenidos [ " + arrSCComboProrrogas.size() + " ]");
            prorrogaDTOs = (ProrrogaDTO[]) arrSCComboProrrogas.toArray(new ProrrogaDTO[arrSCComboProrrogas.size()]);

        } catch (GestionLimiteConsumoException e) {
            throw e;
        } catch (Exception e) {
            loggerError(e);
            loggerError("Ocurrio un error al ejecutar obtieneListaProrrogas. " + e);
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

        loggerDebug("Fin(DAO):obtieneListaProrrogas");

        return prorrogaDTOs;
    }

    /**
     * obtiene una lista de prorrogas
     * 
     * @param void
     * @return ProrrogaDTO[]
     * @throws GestionLimiteConsumoException
     */
    public ArticuloDTO[] obtieneListaArticulos(String strTipTerminal, String strCodTecnologia) throws GestionLimiteConsumoException {

        loggerDebug("Inicio(DAO):obtieneListaArticulos");

        Connection conn = null;
        CallableStatement cstmt = null;
        conn = obtenerConexion();
        ArrayList<ArticuloDTO> arrSCComboArticulos = new ArrayList<ArticuloDTO>();
        ArticuloDTO[] articuloDTOs = null;
        try {

            String call = getSQL("consultas.nombre.package", "consulta.lista.articulos", 6);
            cstmt = conn.prepareCall(call);

            loggerDebug("1 - strTipTerminal [" + strTipTerminal + "]");
            loggerDebug("2 - strCodTecnologia [" + strCodTecnologia + "]");

            cstmt.setString(1, strTipTerminal);
            cstmt.setString(2, strCodTecnologia);
            cstmt.registerOutParameter(3, oracle.jdbc.driver.OracleTypes.CURSOR);
            cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
            cstmt.registerOutParameter(5, java.sql.Types.VARCHAR);
            cstmt.registerOutParameter(6, java.sql.Types.NUMERIC);

            loggerDebug("antes execute");
            cstmt.execute();
            loggerDebug("despues execute");

            evaluaResultado(cstmt.getInt(4), cstmt.getString(5), cstmt.getInt(6));

            ResultSet rs = (ResultSet) cstmt.getObject(3);
            while (rs.next()) {
                ArticuloDTO prorrogaDTO = new ArticuloDTO();
                prorrogaDTO.setIntCodArticulo(Integer.valueOf(rs.getInt(1)));
                prorrogaDTO.setStrDesArticulo(rs.getString(2));

                arrSCComboArticulos.add(prorrogaDTO);
            }
            loggerDebug("registros obtenidos [ " + arrSCComboArticulos.size() + " ]");
            articuloDTOs = (ArticuloDTO[]) arrSCComboArticulos.toArray(new ArticuloDTO[arrSCComboArticulos.size()]);

        } catch (GestionLimiteConsumoException e) {
            throw e;
        } catch (Exception e) {
            loggerError(e);
            loggerError("Ocurrio un error al ejecutar obtieneListaArticulos. " + e);
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

        loggerDebug("Fin(DAO):obtieneListaArticulos");

        return articuloDTOs;
    }

    /**
     * obtiene una lista de categorias tributarias
     * 
     * @param void
     * @return ProrrogaDTO[]
     * @throws GestionLimiteConsumoException
     */
    public CatTributariaDTO[] obtieneListaCategorias(Long lonCodCliente) throws GestionLimiteConsumoException {

        loggerDebug("Inicio(DAO):obtieneListaCategorias");

        Connection conn = null;
        CallableStatement cstmt = null;
        conn = obtenerConexion();
        ArrayList<CatTributariaDTO> arrSCComboCatTributarias = new ArrayList<CatTributariaDTO>();
        CatTributariaDTO[] catTributariaDTOs = null;
        try {

            String call = getSQL("consultas.nombre.package", "consulta.lista.categorias", 5);
            cstmt = conn.prepareCall(call);

            loggerDebug("1 - LonCodCliente [" + lonCodCliente + "]");

            cstmt.setLong(1, lonCodCliente.longValue());
            cstmt.registerOutParameter(2, oracle.jdbc.driver.OracleTypes.CURSOR);
            cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
            cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
            cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);

            loggerDebug("antes execute");
            cstmt.execute();
            loggerDebug("despues execute");

            evaluaResultado(cstmt.getInt(3), cstmt.getString(4), cstmt.getInt(5));

            ResultSet rs = (ResultSet) cstmt.getObject(2);
            while (rs.next()) {
                CatTributariaDTO catTributariaDTO = new CatTributariaDTO();
                catTributariaDTO.setIntCodTipDocum(Integer.valueOf(rs.getInt(1)));
                catTributariaDTO.setStrDesTipDocum(rs.getString(2));
                catTributariaDTO.setStrTipFoliacion(rs.getString(3));
                catTributariaDTO.setStrCodCaTribut(rs.getString(4));

                arrSCComboCatTributarias.add(catTributariaDTO);
            }
            loggerDebug("registros obtenidos [ " + arrSCComboCatTributarias.size() + " ]");
            catTributariaDTOs = (CatTributariaDTO[]) arrSCComboCatTributarias.toArray(new CatTributariaDTO[arrSCComboCatTributarias.size()]);

        } catch (GestionLimiteConsumoException e) {
            throw e;
        } catch (Exception e) {
            loggerError(e);
            loggerError("Ocurrio un error al ejecutar obtieneListaCategorias. " + e);
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

        loggerDebug("Fin(DAO):obtieneListaCategorias");

        return catTributariaDTOs;
    }

    /**
     * obtiene informacion de la causa de cambio
     * 
     * @param
     * @return CausaCambioDTO
     * @throws GestionLimiteConsumoException
     */
    public CausaCambioDTO obtieneDatosCausaCambio(CausaCambioDTO causaCambioDTO) throws GestionLimiteConsumoException {

        loggerDebug("Inicio(DAO):obtieneDatosCausaCambio");
        Connection conn = null;
        CallableStatement cstmt = null;
        conn = obtenerConexion();

        try {

            String call = getSQL("consultas.nombre.package", "consulta.datos.causa", 5);
            cstmt = conn.prepareCall(call);

            loggerDebug("IN 1 CodCausaCambio [ " + causaCambioDTO.getStrCodCausaCambio() + " ]");

            cstmt.setString(1, causaCambioDTO.getStrCodCausaCambio());
            cstmt.registerOutParameter(2, oracle.jdbc.driver.OracleTypes.CURSOR);
            cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
            cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
            cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);

            loggerDebug("antes execute");
            cstmt.execute();
            loggerDebug("despues execute");

            evaluaResultado(cstmt.getInt(3), cstmt.getString(4), cstmt.getInt(5));

            ResultSet rs = (ResultSet) cstmt.getObject(2);
            if (rs.next()) {
                causaCambioDTO.setStrDesCausaCambio(rs.getString(1));
                if (rs.getBigDecimal(2) != null) {
                    causaCambioDTO.setShoIndAntiguedad(Short.valueOf(rs.getShort(2)));
                } else {
                    causaCambioDTO.setShoIndAntiguedad(null);
                }
                if (rs.getBigDecimal(3) != null) {
                    causaCambioDTO.setShoIndCargo(Short.valueOf(rs.getShort(3)));
                } else {
                    causaCambioDTO.setShoIndCargo(null);
                }
                if (rs.getBigDecimal(4) != null) {
                    causaCambioDTO.setShoIndDevAlmacen(Short.valueOf(rs.getShort(4)));
                } else {
                    causaCambioDTO.setShoIndDevAlmacen(null);
                }
                if (rs.getBigDecimal(5) != null) {
                    causaCambioDTO.setShoCodEstadoDev(Short.valueOf(rs.getShort(5)));
                } else {
                    causaCambioDTO.setShoCodEstadoDev(null);
                }
            }

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

        loggerDebug("fin(DAO):obtieneDatosCausaCambio");
        return causaCambioDTO;
    }

    /**
     * obtiene una lista de cuotas
     * 
     * @param
     * @return CuotaDTO[]
     * @throws GestionLimiteConsumoException
     */
    public CuotaDTO[] obtieneListaCuotas(String strNomUsuario, Short shoCodModVenta) throws GestionLimiteConsumoException {

        loggerDebug("Inicio(DAO):obtieneListaCuotas");

        Connection conn = null;
        CallableStatement cstmt = null;
        conn = obtenerConexion();
        ArrayList<CuotaDTO> arrSCComboCuotas = new ArrayList<CuotaDTO>();
        CuotaDTO[] cuotaDTOs = null;
        try {

            String call = getSQL("consultas.nombre.package", "consulta.lista.cuotas", 7);
            cstmt = conn.prepareCall(call);

            loggerDebug("1 - NomUsuario [" + strNomUsuario + "]");
            loggerDebug("2 - CodModVenta [" + shoCodModVenta + "]");
            cstmt.setString(1, strNomUsuario);
            cstmt.setShort(2, shoCodModVenta.shortValue());
            cstmt.registerOutParameter(3, oracle.jdbc.driver.OracleTypes.CURSOR);
            cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
            cstmt.registerOutParameter(5, java.sql.Types.VARCHAR);
            cstmt.registerOutParameter(6, java.sql.Types.VARCHAR);
            cstmt.registerOutParameter(7, java.sql.Types.NUMERIC);

            loggerDebug("antes execute");
            cstmt.execute();
            loggerDebug("despues execute");

            evaluaResultado(cstmt.getInt(5), cstmt.getString(6), cstmt.getInt(7));

            if ("TRUE".equals(cstmt.getString(4))) {
                ResultSet rs = (ResultSet) cstmt.getObject(3);
                while (rs.next()) {
                    CuotaDTO modalidadDTO = new CuotaDTO();
                    modalidadDTO.setShoCodCuota(Short.valueOf(rs.getShort(1)));
                    modalidadDTO.setStrDesCuota(rs.getString(2));

                    arrSCComboCuotas.add(modalidadDTO);
                }
                loggerDebug("registros obtenidos [ " + arrSCComboCuotas.size() + " ]");
                cuotaDTOs = (CuotaDTO[]) arrSCComboCuotas.toArray(new CuotaDTO[arrSCComboCuotas.size()]);
            } else {
                cuotaDTOs = null;
            }
        } catch (GestionLimiteConsumoException e) {
            throw e;
        } catch (Exception e) {
            loggerError(e);
            loggerError("Ocurrio un error al ejecutar obtieneListaCuotas. " + e);
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

        loggerDebug("Fin(DAO):obtieneListaCuotas");

        return cuotaDTOs;
    }

    /**
     * obtiene el indicador de abono asociado a la modalidad de la venta
     * 
     * @param
     * @return IndicadorAbonoOutDTO
     * @throws GestionLimiteConsumoException
     */
    public IndicadorAbonoOutDTO obtieneIndicadorAbono(IndicadorAbonoInDTO pIndicadorAbonoInDTO) throws GestionLimiteConsumoException {

        loggerDebug("Inicio(DAO):obtieneIndicadorAbono");

        Connection conn = null;
        CallableStatement cstmt = null;
        conn = obtenerConexion();
        IndicadorAbonoOutDTO result = null;

        try {

            String call = getSQL("consultas.nombre.package", "consulta.ind.abono.modventa", 5);
            cstmt = conn.prepareCall(call);

            loggerDebug("1 - CodModVenta [" + pIndicadorAbonoInDTO.getIntCodModVenta() + "]");
            cstmt.setInt(1, pIndicadorAbonoInDTO.getIntCodModVenta());

            cstmt.registerOutParameter(2, java.sql.Types.NUMERIC);
            cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
            cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
            cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);

            loggerDebug("antes execute");
            cstmt.execute();
            loggerDebug("despues execute");

            evaluaResultado(cstmt.getInt(3), cstmt.getString(4), cstmt.getInt(5));

            result = new IndicadorAbonoOutDTO();
            result.setIntIndicadorAbono(cstmt.getInt(2));

            loggerDebug("IndicadorAbono : " + result.getIntIndicadorAbono());

        } catch (GestionLimiteConsumoException e) {
            throw e;
        } catch (Exception e) {
            loggerError(e);
            loggerError("Ocurrio un error al ejecutar obtieneIndicadorAbono. " + e);
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

        loggerDebug("Fin(DAO):obtieneIndicadorAbono");

        return result;
    }

    /**
     * obtiene el indicador de venta externa asociado al vendedor
     * 
     * @param
     * @return IndicadorAbonoOutDTO
     * @throws GestionLimiteConsumoException
     */
    public IndicadorVtaExternaVendedorOutDTO obtieneIndicadorVtaExternaVendedor(IndicadorVtaExternaVendedorInDTO pIndicadorVtaExternaVendedorInDTO)

        throws GestionLimiteConsumoException {
        loggerDebug("Inicio(DAO):obtieneIndicadorVtaExternaVendedor");
        Connection conn = null;
        CallableStatement cstmt = null;
        conn = obtenerConexion();
        IndicadorVtaExternaVendedorOutDTO result = null;

        try {

            String call = getSQL("consultas.nombre.package", "consulta.ind.vta.externa_vend", 5);
            cstmt = conn.prepareCall(call);

            loggerDebug("1 - CodVendedor [" + pIndicadorVtaExternaVendedorInDTO.getLonCodVendedor() + "]");
            cstmt.setLong(1, pIndicadorVtaExternaVendedorInDTO.getLonCodVendedor());

            cstmt.registerOutParameter(2, java.sql.Types.NUMERIC);
            cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
            cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
            cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);

            loggerDebug("antes execute");
            cstmt.execute();
            loggerDebug("despues execute");

            evaluaResultado(cstmt.getInt(3), cstmt.getString(4), cstmt.getInt(5));

            result = new IndicadorVtaExternaVendedorOutDTO();
            result.setIntIndicadorVtaExterna(cstmt.getInt(2));

            loggerDebug("IndicadorVtaExterna : " + result.getIntIndicadorVtaExterna());

        } catch (GestionLimiteConsumoException e) {
            throw e;
        } catch (Exception e) {
            loggerError(e);
            loggerError("Ocurrio un error al ejecutar obtieneIndicadorVtaExternaVendedor. " + e);
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

        loggerDebug("Fin(DAO):obtieneIndicadorVtaExternaVendedor");

        return result;
    }

    /**
     * obtiene informacion de la modalidad de pago
     * 
     * @param
     * @return ModalidadDTO
     * @throws GestionLimiteConsumoException
     */
    public ModalidadDTO obtieneDatosModalidad(ModalidadDTO modalidadDTO) throws GestionLimiteConsumoException {

        loggerDebug("Inicio(DAO):obtieneDatosModalidad");
        Connection conn = null;
        CallableStatement cstmt = null;
        conn = obtenerConexion();

        try {

            String call = getSQL("consultas.nombre.package", "consulta.datos.modalidad", 5);
            cstmt = conn.prepareCall(call);

            loggerDebug("IN 1 CodModVenta [ " + modalidadDTO.getShoCodModVenta() + " ]");

            cstmt.setShort(1, modalidadDTO.getShoCodModVenta().shortValue());
            cstmt.registerOutParameter(2, oracle.jdbc.driver.OracleTypes.CURSOR);
            cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
            cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
            cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);

            loggerDebug("antes execute");
            cstmt.execute();
            loggerDebug("despues execute");

            evaluaResultado(cstmt.getInt(3), cstmt.getString(4), cstmt.getInt(5));

            ResultSet rs = (ResultSet) cstmt.getObject(2);

            if (rs.next()) {
                modalidadDTO.setStrDesModVenta(rs.getString(1));
                if (rs.getBigDecimal(2) != null) {
                    modalidadDTO.setShoIndCuotas(Short.valueOf(rs.getShort(2)));
                } else {
                    modalidadDTO.setShoIndCuotas(null);
                }
                if (rs.getBigDecimal(3) != null) {
                    modalidadDTO.setShoIndPagado(Short.valueOf(rs.getShort(3)));
                } else {
                    modalidadDTO.setShoIndPagado(null);
                }
                if (rs.getBigDecimal(4) != null) {
                    modalidadDTO.setShoCodCauPago(Short.valueOf(rs.getShort(4)));
                } else {
                    modalidadDTO.setShoCodCauPago(null);
                }
                if (rs.getBigDecimal(5) != null) {
                    modalidadDTO.setShoIndAbono(Short.valueOf(rs.getShort(5)));
                } else {
                    modalidadDTO.setShoIndAbono(null);
                }
            }

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

        loggerDebug("fin(DAO):obtieneDatosModalidad");
        return modalidadDTO;
    }

    /**
     * permite obtener valor de bPLista
     * 
     * @param
     * @return boolean
     * @throws GestionLimiteConsumoException
     */
    public boolean obtieneBPLista(Long lonNumAbonado, String strTipTerminal) throws GestionLimiteConsumoException {

        loggerDebug("Inicio(DAO):obtieneBPLista");
        Connection conn = null;
        CallableStatement cstmt = null;
        conn = obtenerConexion();
        boolean bPLista;
        try {

            String call = getSQL("consultas.nombre.package", "obtiene.valor.bplista", 6);
            cstmt = conn.prepareCall(call);

            loggerDebug("1 - NumAbonado [" + lonNumAbonado + "]");
            loggerDebug("2 - TipTerminal [" + strTipTerminal + "]");

            cstmt.setLong(1, lonNumAbonado.longValue());
            cstmt.setString(2, strTipTerminal);

            cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
            cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
            cstmt.registerOutParameter(5, java.sql.Types.VARCHAR);
            cstmt.registerOutParameter(6, java.sql.Types.NUMERIC);

            loggerDebug("antes execute");
            cstmt.execute();
            loggerDebug("despues execute");

            evaluaResultado(cstmt.getInt(4), cstmt.getString(5), cstmt.getInt(6));
            String strResultado = cstmt.getString(3);
            if ("TRUE".equals(strResultado)) {
                bPLista = true;
            } else {
                bPLista = false;
            }

        } catch (GestionLimiteConsumoException e) {
            loggerError(e);
            throw e;

        } catch (Exception e) {
            loggerError(e);
            loggerError("Ocurrio un error al ejecutar obtieneBPLista. " + e);
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

        loggerDebug("fin(DAO):obtieneBPLista");

        return bPLista;
    }
    
    //inicio incedencia 169415 09/06/2011 FDL
    /**
     * permite obtener el estado de la venta
     * 
     * @param
     * @return ParametroDTO
     * @throws GestionLimiteConsumoException
     */
    public String obtieneEstadoVenta(Long num_abonado) throws GestionLimiteConsumoException {

        loggerDebug("Inicio(DAO):obtieneEstadoVenta");
        Connection conn = null;
        CallableStatement cstmt = null;
        conn = obtenerConexion();
        String estadoVenta;
        

        try {

            String call = getSQL("consultas.nombre.package", "consulta.estado.venta.abonado", 5);
            cstmt = conn.prepareCall(call);

            loggerDebug("1 - NumeroAbonado [" + num_abonado + "]");

            cstmt.setLong(1, num_abonado);

            cstmt.registerOutParameter(2, java.sql.Types.VARCHAR);
            cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
            cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
            cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);

            loggerDebug("antes execute");
            cstmt.execute();
            loggerDebug("despues execute");

            loggerDebug("Valor Estado Venta: " + cstmt.getString(2));
            evaluaResultado(cstmt.getInt(3), cstmt.getString(4), cstmt.getInt(5));

            estadoVenta = cstmt.getString(2);

        } catch (GestionLimiteConsumoException e) {
            loggerError(e);
            throw e;

        } catch (Exception e) {
            loggerError(e);
            loggerError("Ocurrio un error al ejecutar obtieneEstadoVenta. " + e);
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

        loggerDebug("fin(DAO):obtieneEstadoVenta");

        return estadoVenta;
    }
    //fin incedencia 169415 09/06/2011 FDL
}
