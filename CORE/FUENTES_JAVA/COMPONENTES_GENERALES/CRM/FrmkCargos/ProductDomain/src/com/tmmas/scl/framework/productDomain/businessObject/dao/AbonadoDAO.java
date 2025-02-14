/**
 * Fecha ------------------- Autor  ------------------------- Cambios ----------
 * 01/06/2007	     	Elizabeth Vera        				Versión Inicial
 * 26/07/2007           Raúl Lozano                       ObtenerListaAbonados(fec_AcepVenta,cod_uso)
 */
package com.tmmas.scl.framework.productDomain.businessObject.dao;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;

import org.apache.log4j.Logger;

import com.tmmas.cl.framework.base.ConnectionDAO;
import com.tmmas.cl.framework.util.ArrayUtl;
import com.tmmas.cl.framework.util.StackTraceUtl;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ClienteDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ParametrosObtencionCargosDTO;
import com.tmmas.scl.framework.customerDomain.exception.CustomerBillException;
import com.tmmas.scl.framework.productDomain.businessObject.dao.interfaces.AbonadoDAOIT;
import com.tmmas.scl.framework.productDomain.businessObject.helper.Global;
import com.tmmas.scl.framework.productDomain.dataTransferObject.AbonadoDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.AbonadoListDTO;
import com.tmmas.scl.framework.productDomain.exception.ProductException;

public class AbonadoDAO extends ConnectionDAO implements AbonadoDAOIT {

	private final Logger logger = Logger.getLogger(AbonadoDAO.class);

	private final Global global = Global.getInstance();
	
//	 INI P-MIX-09003 OCB;
	private String getSQLverificaRenovacion(){
		StringBuffer call = new StringBuffer();

		call.append(" DECLARE ");
		call.append(" BEGIN ");
		call.append("   PV_CONFIG_RENOVACION_PG.PV_VERIFICA_RENOVACION_PR( ?, ?, ?, ?, ?, ?);");
		call.append(" END;");
		return call.toString();
	}
	
	
	
	
	
	
    public ParametrosObtencionCargosDTO verificaRenovacion (ParametrosObtencionCargosDTO lineaEntrada) 
	throws ProductException{
			logger.debug("Inicio:verificaRenovacion()");
			ParametrosObtencionCargosDTO resultado = new ParametrosObtencionCargosDTO();
			int codError = 0;
			String msgError = null;
			int numEvento = 0;
			Connection conn = null;
			CallableStatement cstmt = null; 
			
			try {
				String call = getSQLverificaRenovacion();
				logger.debug("sql[" + call + "]");
				conn = getConnectionFromWLSInitialContext(global.getCPUJndiForDataSource());
				cstmt = conn.prepareCall(call);
				
				logger.debug("lineaEntrada.getNumOsRenova()  [" + lineaEntrada.getNumOsRenova() + "]");
				logger.debug("lineaEntrada.getOrdenServicio()[" + lineaEntrada.getOrdenServicio() + "]");
				cstmt.setString(1,lineaEntrada.getNumOsRenova());
				cstmt.setString(2,lineaEntrada.getOrdenServicio());
				
				cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
				cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);
				cstmt.registerOutParameter(5, java.sql.Types.VARCHAR);
				cstmt.registerOutParameter(6, java.sql.Types.NUMERIC);
				logger.debug("Inicio:verificaRenovacion:execute");
				cstmt.execute();
				logger.debug("Fin:verificaRenovacion:execute");
				codError = cstmt.getInt(4);
				msgError = cstmt.getString(5);
				numEvento = cstmt.getInt(6);
				int res = cstmt.getInt(3);
				resultado.setIndComodato(res);
				
			} 
			catch (Exception e) {
				logger.error("Ocurrió un error al consultar la renovación",e);
				if (logger.isDebugEnabled()) {
					logger.debug("Codigo de Error[" + codError + "]");
					logger.debug("Mensaje de Error[" + msgError + "]");
					logger.debug("Numero de Evento[" + numEvento + "]");
				}
			} finally {
			 	if (logger.isDebugEnabled()) 
					logger.debug("Cerrando conexiones...");
				try {
					if (cstmt!=null)
						cstmt.close();
					if (!conn.isClosed()) {
						conn.close();
					}
				} catch (SQLException e) {
					logger.debug("SQLException", e);
				}
			}
			logger.debug("Fin:verificaRenovacion()");
			return resultado;
	}//fin ResultadoValidacionRenovacionDTO
	// FIN P-MIX-09003 OCB;
	
	
	
	private String getSQLobtenerListaAbonados() {
		StringBuffer call = new StringBuffer();

		call.append(" DECLARE ");
		call.append("   eo_abonado GA_ABONADO_QT := PV_INICIA_ESTRUCTURAS_PG.PV_INICIA_GA_ABONADO_QT_FN;");
		call.append(" BEGIN ");
		call.append("   eo_abonado.COD_CLIENTE := ?;");
		call.append("   PV_DATOS_ABONADO_PG.PV_OBTIENE_LISTA_ABONADOS_PR( eo_abonado, ?, ?, ?, ?);");
		call.append(" END;");
		
		return call.toString();		
	}	

	private String getSQLobtenerDatosAbonado() {
		StringBuffer call = new StringBuffer();
		
		call.append(" DECLARE ");
		call.append("   so_abonado GA_ABONADO_QT := PV_INICIA_ESTRUCTURAS_PG.PV_INICIA_GA_ABONADO_QT_FN;");
		call.append(" BEGIN ");
		call.append("   so_abonado.NUM_ABONADO := ?;");
		call.append("   PV_DATOS_ABONADO_PG.PV_OBTIENE_DATOS_ABONADO_PR( so_abonado, ?, ?, ?);");
		call.append("		? := so_abonado.COD_CLIENTE;");
		call.append("		? := so_abonado.NUM_ABONADO;");
		call.append("		? := so_abonado.NUM_CELULAR;");
		call.append("		? := so_abonado.NUM_SERIE;");
		call.append("		? := so_abonado.NUM_SIMCARD;");
		call.append("		? := so_abonado.COD_TECNOLOGIA;");
		call.append("		? := so_abonado.COD_SITUACION;");
		call.append("		? := so_abonado.DES_SITUACION;");
		call.append("		? := so_abonado.TIP_PLANTARIF;");
		call.append("		? := so_abonado.DES_TIPPLANTARIF;");
		call.append("		? := so_abonado.COD_PLANTARIF;");
		call.append("		? := so_abonado.DES_PLANTARIF;");
		call.append("		? := so_abonado.COD_CICLO;");
		call.append("		? := so_abonado.COD_LIMCONSUMO;");
		call.append("		? := so_abonado.DES_LIMCONSUMO;");
		call.append("		? := so_abonado.COD_PLANSERV;");
		call.append("		? := so_abonado.COD_TIPLAN;");
		call.append("		? := so_abonado.DES_TIPLAN;");
		call.append("		? := so_abonado.COD_TIPCONTRATO;");
		call.append("		? := so_abonado.FECHA_ALTA;");
		call.append("		? := so_abonado.FEC_FINCONTRA;");
		call.append("		? := so_abonado.IND_EQPRESTADO;");
		call.append("		? := so_abonado.FECHA_PRORROGA;");
		call.append("		? := so_abonado.FLG_RANGO;");
		call.append("		? := so_abonado.IMP_CARGOBASICO;");
		call.append("		? := so_abonado.NUM_ANEXO;");
		call.append("		? := so_abonado.COD_USUARIO;");
		call.append("		? := so_abonado.COD_USO;");
		call.append("		? := so_abonado.TIP_TERMINAL;");
		call.append("		? := so_abonado.DES_TERMINAL;");
		call.append("		? := so_abonado.NUM_VENTA;");
		call.append("		? := so_abonado.COD_CUENTA;");		
		call.append("		? := so_abonado.COD_SUBCUENTA;");
		call.append("		? := so_abonado.COD_VENDEDOR;");
		call.append("		? := so_abonado.COD_CAUSA_VENTA;");
		call.append("		? := so_abonado.FECHA_BAJA;");
		call.append("		? := so_abonado.FECHA_BAJACEN;");
		call.append("		? := so_abonado.FECHA_ULTMOD;");
		call.append("		? := so_abonado.COD_EMPRESA;");
		call.append("		? := so_abonado.FECHA_ACEPVENTA;");
		call.append("		? := so_abonado.NUM_CONTRATO;");
		call.append("		? := so_abonado.MODALIDAD_DE_PAGO;");		
		call.append("		? := so_abonado.COD_CARGOBASICO;");
		call.append("		? := so_abonado.COD_CENTRAL;");
		
		call.append(" END;");
	
		return call.toString();		
	}
	
	private String getSQLUpdCodSituaAbonado(){
		StringBuffer call=new StringBuffer();
		call.append("	DECLARE	"); 
		call.append("	 BEGIN	");
		call.append("	   PV_SERVICIOS_POSVENTA_PG.VE_UPDABOCELCODSITUAC_PR ( ?,?,?,?,? );");
		call.append("	 END; 	");
		
		return call.toString();
	}
	
	

	
	/**
	 * Obtiene la lista de abonados del cliente
	 * 
	 * @param cliente
	 * @return AbonadoListDTO
	 * @throws ProductException
	 */
	
	public AbonadoListDTO obtenerListaAbonados(ClienteDTO cliente)
			throws ProductException {
		
		logger.debug("obtenerListaAbonados():start");
		
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		AbonadoListDTO abonadosList = null;
		AbonadoDTO[] abonados = null;
		Connection conn = null;
		CallableStatement cstmt = null;
		
		String call = getSQLobtenerListaAbonados();
		try {
		
			logger.debug("cliente.getCodCliente()[" + cliente.getCodCliente() + "]");
			
			conn = getConnectionFromWLSInitialContext(global.getCPUJndiForDataSource());
			
			cstmt = conn.prepareCall(call);
			cstmt.setLong(1, cliente.getCodCliente());
			cstmt.registerOutParameter(2, oracle.jdbc.driver.OracleTypes.CURSOR);			
			cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);			
			
			
			logger.debug("execute:antes");
			cstmt.execute();
			logger.debug("execute:despues");
			
			logger.debug("Recuperando salidas");
			codError = cstmt.getInt(3);
			logger.debug("codError[" + codError + "]");
			msgError = cstmt.getString(4);
			logger.debug("msgError[" + msgError + "]");
			numEvento = cstmt.getInt(5);
			logger.debug("numEvento[" + numEvento + "]");
			
			if (codError != 0) {
				logger.error(" Ocurrió un error al obtener lista de abonados");
				throw new ProductException(String.valueOf(codError),numEvento, msgError);
			}
			
			logger.debug("Recuperando cursor...");
			logger.debug("object="+cstmt.getObject(2));
			ResultSet rs = (ResultSet) cstmt.getObject(2);
			
			ArrayList lista = new ArrayList();
			while (rs.next()) {
				AbonadoDTO abonado = new AbonadoDTO();
			
				abonado.setCodCliente(rs.getLong(1));
				logger.debug("codCliente[" + abonado.getCodCliente() + "]");
				abonado.setNumAbonado(rs.getLong(2));
				logger.debug("NumAbonado[" + abonado.getNumAbonado() + "]");
				abonado.setNumCelular(rs.getLong(3));
				logger.debug("NumCelular[" + abonado.getNumCelular() + "]");
				abonado.setNumSerie(rs.getString(4));
				logger.debug("NumSerie[" + abonado.getNumSerie() + "]");
				abonado.setNumImei(rs.getString(5));
				logger.debug("NumImei[" + abonado.getNumImei() + "]");
				abonado.setCodTecnologia(rs.getString(6));
				logger.debug("CodTecnologia[" + abonado.getCodTecnologia() + "]");
				abonado.setCodSituacion(rs.getString(7));
				logger.debug("CodSituacion[" + abonado.getCodSituacion() + "]");
				abonado.setDesSituacion(rs.getString(8));
				logger.debug("DesSituacion[" + abonado.getDesSituacion() + "]");
				abonado.setCodTipoPlanTarif(rs.getString(9));
				logger.debug("CodTipoPlanTarif[" + abonado.getCodTipoPlanTarif() + "]");
				abonado.setDesTipoPlanTarif(rs.getString(10));
				logger.debug("DesTipoPlanTarif[" + abonado.getDesTipoPlanTarif() + "]");
				abonado.setCodPlanTarif(rs.getString(11));
				logger.debug("CodPlanTarif[" + abonado.getCodPlanTarif() + "]");
				abonado.setDesPlanTarif(rs.getString(12));
				logger.debug("DesPlanTarif[" + abonado.getDesPlanTarif() + "]");
				abonado.setCodCiclo(rs.getInt(13));
				logger.debug("CodCiclo[" + abonado.getCodCiclo() + "]");
				abonado.setLimiteConsumo(rs.getString(14));
				logger.debug("LimiteConsumo[" + abonado.getLimiteConsumo() + "]");
				abonado.setDesLimiteConsumo(rs.getString(15));
				logger.debug("DesLimiteConsumo[" + abonado.getDesLimiteConsumo() + "]");
				abonado.setCodTipPlan(rs.getString(16));
				logger.debug("CodTipPlan[" + abonado.getCodTipPlan() + "]");
				abonado.setDesTipPlan(rs.getString(17));
				logger.debug("DesTipPlan[" + abonado.getDesTipPlan() + "]");
				abonado.setCodCargoBasico(rs.getString(18));
				logger.debug("CodCargoBasico[" + abonado.getCodCargoBasico() + "]");
				abonado.setCodTipContrato(rs.getString(19));
				logger.debug("CodTipContrato[" + abonado.getCodTipContrato() + "]");
				abonado.setCodModVenta(rs.getString(20));
				logger.debug("CodModVenta[" + abonado.getCodModVenta() + "]");
				abonado.setNroContrato(rs.getString(21));
				logger.debug("NroContrato[" + abonado.getNroContrato() + "]");
				abonado.setCodPlanServ(rs.getString(22));
				logger.debug("CodPlanServ[" + abonado.getCodPlanServ() + "]");
				abonado.setCodCentral(rs.getInt(23));
				logger.debug("CodCentral[" + abonado.getCodCentral() + "]");
				abonado.setNumVenta(rs.getInt(24));
				logger.debug("NumVenta[" + abonado.getNumVenta() + "]");
				abonado.setCodUso(rs.getString(25));
				logger.debug("CodUso[" + abonado.getCodUso() + "]");
				abonado.setFecAcepVenta(rs.getDate(26));
				logger.debug("FecAcepVenta[" + abonado.getFecAcepVenta() + "]");
				abonado.setFecAlta(rs.getDate(27));
				logger.debug("FecAlta[" + abonado.getFecAlta() + "]");				
				abonado.setFecProrroga(rs.getDate(28));
				logger.debug("FecProrroga[" + abonado.getFecProrroga() + "]");
				abonado.setNumAnexo(rs.getString(29));
				logger.debug("NumAnexo[" + abonado.getNumAnexo() + "]");
				abonado.setCodUsuario(rs.getLong(30));
				logger.debug("CodUsuario[" + abonado.getCodUsuario() + "]");
				abonado.setCodTipoTerminal(rs.getString(31));
				logger.debug("CodTipoTerminal[" + abonado.getCodTipoTerminal() + "]");
				abonado.setNumVenta(rs.getLong(32));
				logger.debug("NumVenta[" + abonado.getNumVenta() + "]");
				abonado.setImpCargoBasico(rs.getString(33));
				logger.debug("ImpCargoBasico[" + abonado.getImpCargoBasico() + "]");
				abonado.setCodCuenta(rs.getLong(34));
				logger.debug("CodCuenta[" + abonado.getCodCuenta() + "]");
				abonado.setCodSubCuenta(rs.getString(35));
				logger.debug("CodSubCuenta[" + abonado.getCodSubCuenta() + "]");
				abonado.setCodVendedor(rs.getLong(36));
				logger.debug("CodVendedor[" + abonado.getCodVendedor() + "]");
				abonado.setCodCausaVenta(rs.getString(37));
				logger.debug("CodCausaVenta[" + abonado.getCodCausaVenta() + "]");
				abonado.setFecBaja(rs.getDate(38));
				logger.debug("FecBaja[" + abonado.getFecBaja() + "]");
				abonado.setFecBajaCen(rs.getDate(39));
				logger.debug("FecBajaCen[" + abonado.getFecBajaCen() + "]");
				abonado.setFecUltModificacion(rs.getDate(40));
				logger.debug("FecUltModificacion[" + abonado.getFecUltModificacion() + "]");
				abonado.setCodEmpresa(rs.getString(41));
				logger.debug("CodEmpresa[" + abonado.getCodEmpresa() + "]");
				abonado.setFecFinContrato(rs.getDate(42));
				logger.debug("FecFinContrato[" + abonado.getFecFinContrato() + "]");
				abonado.setIndEqPrestado(rs.getString(43));
				logger.debug("IndEqPrestado[" + abonado.getIndEqPrestado() + "]");
				abonado.setFlgRango(rs.getInt(44));
				logger.debug("FlgRango[" + abonado.getFlgRango() + "]");
				
				lista.add(abonado);
			}
			abonados = (AbonadoDTO[]) ArrayUtl.copiaArregloTipoEspecifico(	lista.toArray(), AbonadoDTO.class);
			abonadosList = new AbonadoListDTO();
			abonadosList.setAbonados(abonados);			
			rs.close();
		} catch (ProductException e) {
			logger.debug("ProductException");
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + loge + "]");
			throw e;
			
		}
		catch (Exception e) {
			logger.error("Ocurrió un error general al obtener lista de abonados", e);
			throw new ProductException("Ocurrió un error general al obtener lista de abonados",e);
		}
		finally {
			try {
				if (cstmt != null) {
					cstmt.close();
					cstmt = null;
				}
				if (conn != null) {
					if (!conn.isClosed()) {
						conn.close();
					}
					conn = null;
				}
			} catch (SQLException e) {
				cstmt = null;
				conn = null;
				logger.debug("SQLException[" + e + "]");
			}
		}
		logger.debug("obtenerListaAbonados():end");
		return abonadosList;

	}
	
	/**
	 * Recupera la informacion del abonado
	 * 
	 * @param abonado
	 * @return AbonadoDTO
	 * @throws ProductException
	 */
	
	public AbonadoDTO obtenerDatosAbonado(AbonadoDTO abonado)
	throws ProductException {

		logger.debug("obtenerDatosAbonado():start");
		
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		AbonadoDTO respuesta = null;		
		Connection conn = null;
		CallableStatement cstmt = null;
		
		String call = getSQLobtenerDatosAbonado();
		try {
		
			logger.debug("abonado.getNumAbonado()[" + abonado.getNumAbonado() + "]");
			
			conn = getConnectionFromWLSInitialContext(global.getCPUJndiForDataSource());
			
			cstmt = conn.prepareCall(call);			
			
			cstmt.setLong(1, abonado.getNumAbonado());
			
			cstmt.registerOutParameter(2, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);
			
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);	//COD_CLIENTE
			cstmt.registerOutParameter(6, java.sql.Types.NUMERIC);	//NUM_ABONADO
			cstmt.registerOutParameter(7, java.sql.Types.NUMERIC);	//NUM_CELULAR
			cstmt.registerOutParameter(8, java.sql.Types.VARCHAR);  //NUM_SERIE
			cstmt.registerOutParameter(9, java.sql.Types.VARCHAR);	//NUM_SIMCARD
			cstmt.registerOutParameter(10, java.sql.Types.VARCHAR);	//COD_TECNOLOGIA
			cstmt.registerOutParameter(11, java.sql.Types.VARCHAR);	//COD_SITUACION
			cstmt.registerOutParameter(12, java.sql.Types.VARCHAR);	//DES_SITUACION
			cstmt.registerOutParameter(13, java.sql.Types.VARCHAR);	//TIP_PLANTARIF
			cstmt.registerOutParameter(14, java.sql.Types.VARCHAR);	//DES_TIPPLANTARIF
			cstmt.registerOutParameter(15, java.sql.Types.VARCHAR);	//COD_PLANTARIF
			cstmt.registerOutParameter(16, java.sql.Types.VARCHAR);	//DES_PLANTARIF
			cstmt.registerOutParameter(17, java.sql.Types.VARCHAR);	//COD_CICLO
			cstmt.registerOutParameter(18, java.sql.Types.VARCHAR);	//COD_LIMCONSUMO
			cstmt.registerOutParameter(19, java.sql.Types.VARCHAR);	//DES_LIMCONSUMO
			cstmt.registerOutParameter(20, java.sql.Types.VARCHAR);	//COD_PLANSERV
			cstmt.registerOutParameter(21, java.sql.Types.VARCHAR);	//COD_TIPLAN
			cstmt.registerOutParameter(22, java.sql.Types.VARCHAR);	//DES_TIPLAN
			cstmt.registerOutParameter(23, java.sql.Types.VARCHAR);	//COD_TIPCONTRATO
			cstmt.registerOutParameter(24, java.sql.Types.DATE);	//FECHA_ALTA
			cstmt.registerOutParameter(25, java.sql.Types.DATE);	//FEC_FINCONTRA
			cstmt.registerOutParameter(26, java.sql.Types.VARCHAR);	//IND_EQPRESTADO
			cstmt.registerOutParameter(27, java.sql.Types.DATE);	//FECHA_PRORROGA
			cstmt.registerOutParameter(28, java.sql.Types.NUMERIC);	//FLG_RANGO
			cstmt.registerOutParameter(29, java.sql.Types.NUMERIC);	//IMP_CARGOBASICO
			cstmt.registerOutParameter(30, java.sql.Types.VARCHAR); //NUM_ANEXO
			cstmt.registerOutParameter(31, java.sql.Types.NUMERIC); //COD_USUARIO
			cstmt.registerOutParameter(32, java.sql.Types.VARCHAR); //COD_USO
			cstmt.registerOutParameter(33, java.sql.Types.VARCHAR); //TIP_TERMINAL
			cstmt.registerOutParameter(34, java.sql.Types.VARCHAR); //DES_TERMINAL
			cstmt.registerOutParameter(35, java.sql.Types.NUMERIC); //NUM_VENTA
			cstmt.registerOutParameter(36, java.sql.Types.NUMERIC); //COD_CUENTA
			cstmt.registerOutParameter(37, java.sql.Types.VARCHAR); //COD_SUBCUENTA
			cstmt.registerOutParameter(38, java.sql.Types.NUMERIC); //COD_VENDEDOR
			cstmt.registerOutParameter(39, java.sql.Types.VARCHAR); //COD_CAUSA_VENTA
			cstmt.registerOutParameter(40, java.sql.Types.DATE);	//FECHA_BAJA
			cstmt.registerOutParameter(41, java.sql.Types.DATE);	//FECHA_BAJACEN
			cstmt.registerOutParameter(42, java.sql.Types.DATE);	//FECHA_ULTMOD
			cstmt.registerOutParameter(43, java.sql.Types.NUMERIC);	//COD_EMPRESA
			cstmt.registerOutParameter(44, java.sql.Types.DATE);	//FECHA_ACEPVENTA
			cstmt.registerOutParameter(45, java.sql.Types.VARCHAR); //NUM_CONTRATO
			cstmt.registerOutParameter(46, java.sql.Types.NUMERIC);	//MODALIDAD_DE_PAGO
			cstmt.registerOutParameter(47, java.sql.Types.VARCHAR); //COD_CARGOBASICO
			cstmt.registerOutParameter(48, java.sql.Types.NUMERIC);	//COD_CENTRAL
			
			logger.debug("execute:antes");
			cstmt.execute();
			logger.debug("execute:despues");
			
			logger.debug("Recuperando salidas");
			codError = cstmt.getInt(2);
			logger.debug("codError[" + codError + "]");
			msgError = cstmt.getString(3);
			logger.debug("msgError[" + msgError + "]");
			numEvento = cstmt.getInt(4);
			logger.debug("numEvento[" + numEvento + "]");
			
			if (codError != 0) {
				logger.error(" Ocurrió un error al recuperar los datos del abonado");
				throw new ProductException(String.valueOf(codError),numEvento, msgError);
			}
			
			//obtener info del cliente y completar respuesta
			logger.debug("Recuperando data...");
			
			long codCliente = cstmt.getLong(5);
			logger.debug("codCliente[" + codCliente + "]");
			
			long numAbonado = cstmt.getLong(6);
			logger.debug("numAbonado[" + numAbonado + "]");
			
			long numCelular = cstmt.getLong(7);
			logger.debug("numCelular[" + numCelular + "]");
			
			String numSerie = cstmt.getString(8);
			logger.debug("numSerie[" + numSerie + "]");

			String numSimcard = cstmt.getString(9);
			logger.debug("numSimcard[" + numSimcard + "]");

			String codTecnologia = cstmt.getString(10);
			logger.debug("codTecnologia[" + codTecnologia + "]");
			
			String codSituacion = cstmt.getString(11);
			logger.debug("codSituacion[" + codSituacion + "]");

			String desSituacion = cstmt.getString(12);
			logger.debug("desSituacion[" + desSituacion + "]");
			
			String tipPlanTarif = cstmt.getString(13);
			logger.debug("tipPlanTarif[" + tipPlanTarif + "]");
			
			String desTipPlanTarif = cstmt.getString(14);
			logger.debug("desTipPlanTarif[" + desTipPlanTarif + "]");

			String codPlanTarif = cstmt.getString(15);
			logger.debug("codPlanTarif[" + codPlanTarif + "]");
			
			String desPlanTarif = cstmt.getString(16);
			logger.debug("desPlanTarif[" + desPlanTarif + "]");
			
			int codCiclo = cstmt.getInt(17);
			logger.debug("codCiclo[" + codCiclo + "]");

			String codLimConsumo = cstmt.getString(18);
			logger.debug("codLimConsumo[" + codLimConsumo + "]");
			
			String desLimConsumo = cstmt.getString(19);
			logger.debug("desLimConsumo[" + desLimConsumo + "]");	
			
			String codPlanServ = cstmt.getString(20);
			logger.debug("codPlanServ[" + codPlanServ + "]");
			
			String codTiplan =  cstmt.getString(21);
			logger.debug("codTiplan[" + codTiplan + "]");
			
			String desTiplan =  cstmt.getString(22);
			logger.debug("desTiplan[" + desTiplan + "]");
			
			String codTipContrato =  cstmt.getString(23);
			logger.debug("codTipContrato[" + codTipContrato + "]");
			
			Date fechaAlta = cstmt.getDate(24);
			logger.debug("fechaAlta[" + fechaAlta + "]");
			
			Date fechaFinContrato = cstmt.getDate(25);
			logger.debug("fechaFinContrato[" + fechaFinContrato + "]");
			
			String indEqPrestado = cstmt.getString(26);
			logger.debug("indEqPrestado[" + indEqPrestado + "]");
			
			Date fechaProrroga = cstmt.getDate(27);
			logger.debug("fechaProrroga[" + fechaProrroga + "]");
			
			int flgRango = cstmt.getInt(28);
			logger.debug("flgRango[" + flgRango + "]");
			
			String impCargoBasico = cstmt.getString(29);
			logger.debug("impCargoBasico[" + impCargoBasico + "]");
			
			String numAnexo = cstmt.getString(30);
			logger.debug("numAnexo[" + numAnexo + "]");
			
			long codUsuario = cstmt.getLong(31);
			logger.debug("codUsuario[" + codUsuario + "]");
			
			String codUso = cstmt.getString(32);
			logger.debug("codUso[" + codUso + "]");
			
			String tipTerminal = cstmt.getString(33);
			logger.debug("tipTerminal[" + tipTerminal + "]");

			String desTerminal = cstmt.getString(34);
			logger.debug("desTerminal[" + desTerminal + "]");
			
			long numVenta = cstmt.getLong(35);
			logger.debug("numVenta[" + numVenta + "]");
			
			long codCuenta = cstmt.getLong(36);
			logger.debug("codCuenta[" + codCuenta + "]");
			
			String codSubCuenta = cstmt.getString(37);
			logger.debug("codSubCuenta[" + codSubCuenta + "]");
			
			long codVendedor = cstmt.getLong(38);
			logger.debug("codVendedor[" + codVendedor + "]");

			String codCausaVenta = cstmt.getString(39);
			logger.debug("codCausaVenta[" + codCausaVenta + "]");

			Date fechaBaja = cstmt.getDate(40);
			logger.debug("fechaBaja[" + fechaBaja + "]");
			
			Date fechaBajaCen = cstmt.getDate(41);
			logger.debug("fechaBajaCen[" + fechaBajaCen + "]");

			Date fechaUltMod = cstmt.getDate(42);
			logger.debug("fechaUltMod[" + fechaUltMod + "]");
			
			long codEmpresa = cstmt.getLong(43);
			logger.debug("codEmpresa[" + codEmpresa + "]");
			
			Date fecAcepVenta = cstmt.getDate(44);
			logger.debug("fecAcepVenta[" + fecAcepVenta + "]");
			
			String numContrato = cstmt.getString(45);
			logger.debug("numContrato[" + numContrato + "]");
			
			int modalidadPago = cstmt.getInt(46);
			logger.debug("modalidadPago[" + modalidadPago + "]");

			String codCargoBasico = cstmt.getString(47);
			logger.debug("codCargoBasico[" + codCargoBasico + "]");
			
			int codCentral = cstmt.getInt(48);
			logger.debug("codCentral[" + codCentral + "]");
			
			respuesta = new AbonadoDTO();
			respuesta.setCodCliente(codCliente);
			respuesta.setNumAbonado(numAbonado);
			respuesta.setNumCelular(numCelular);
			respuesta.setNumSerie(numSerie);
			respuesta.setSimCard(numSimcard);
			respuesta.setCodTecnologia(codTecnologia);
			respuesta.setCodSituacion(codSituacion);
			respuesta.setDesSituacion(desSituacion);
			respuesta.setCodTipoPlanTarif(tipPlanTarif);
			respuesta.setDesTipoPlanTarif(desTipPlanTarif);
			respuesta.setCodPlanTarif(codPlanTarif);
			respuesta.setDesPlanTarif(desPlanTarif);
			respuesta.setCodCiclo(codCiclo);
			respuesta.setLimiteConsumo(codLimConsumo);
			respuesta.setDesLimiteConsumo(desLimConsumo);
			respuesta.setCodPlanServ(codPlanServ);
			respuesta.setCodTipPlan(codTiplan);
			respuesta.setDesTipPlan(desTiplan);
			respuesta.setCodTipContrato(codTipContrato);
			respuesta.setFecFinContrato(fechaFinContrato);
			respuesta.setFecAlta(fechaAlta);
			respuesta.setFecProrroga(fechaProrroga);
			respuesta.setIndEqPrestado(indEqPrestado);
			respuesta.setFlgRango(flgRango);
			respuesta.setImpCargoBasico(impCargoBasico);
			respuesta.setNumAnexo(numAnexo);
			respuesta.setCodUsuario(codUsuario);
			respuesta.setCodUso(codUso);
			respuesta.setCodTipoTerminal(tipTerminal);
			respuesta.setDesTipoTerminal(desTerminal);
			respuesta.setNumVenta(numVenta);
			respuesta.setCodCuenta(codCuenta);
			respuesta.setCodSubCuenta(codSubCuenta);
			respuesta.setCodVendedor(codVendedor);
			respuesta.setCodCausaVenta(codCausaVenta);
			respuesta.setFecBaja(fechaBaja);
			respuesta.setFecBajaCen(fechaBajaCen);
			respuesta.setFecUltModificacion(fechaUltMod);
			respuesta.setCodEmpresa(String.valueOf(codEmpresa));
			respuesta.setFecAcepVenta(fecAcepVenta);
			respuesta.setNumContrato(numContrato);
			respuesta.setCodModVenta(String.valueOf(modalidadPago));
			respuesta.setCodCargoBasico(codCargoBasico);
			respuesta.setCodCentral(codCentral);
			
		} catch (ProductException e) {
			logger.debug("ProductException");
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + loge + "]");
			throw e;
			
		}
		catch (Exception e) {
			logger.error("Ocurrió un error general al recuperar al recuperar los datos del abonado", e);
			throw new ProductException("Ocurrió un error general al recuperar al recuperar los datos del abonado",e);
		}
		finally {
			try {
				if (cstmt != null) {
					cstmt.close();
					cstmt = null;
				}
				if (conn != null) {
					if (!conn.isClosed()) {
						conn.close();
					}
					conn = null;
				}
			} catch (SQLException e) {
				cstmt = null;
				conn = null;
				logger.debug("SQLException[" + e + "]");
			}
		}
		logger.debug("obtenerDatosAbonado():end");
		return respuesta;
	}
	
	
	/**
	 * Actualiza código situación del abonado
	 * @param abonado
	 * @return 
	 * @throws CustomerBillException
	 */
	public void updCodigoSituacion(AbonadoDTO abonado) 
	throws ProductException{
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		
		CallableStatement cstmt = null; 
		try {
			logger.debug("Inicio:updCodigoSituacion");
			
			String call = getSQLUpdCodSituaAbonado();

			logger.debug("sql[" + call + "]");
			conn = getConnectionFromWLSInitialContext(global.getCPUJndiForDataSource());

			cstmt = conn.prepareCall(call);

			cstmt.setLong(1,abonado.getNumVenta());
			cstmt.setString(2,abonado.getCodSituacion());
			
			cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);
			
			logger.debug("Inicio:updCodigoSituacion:execute");
			cstmt.execute();
			logger.debug("Fin:updCodigoSituacion:execute");

			codError=cstmt.getInt(3);
			msgError = cstmt.getString(4);
			numEvento=cstmt.getInt(5);

			if (codError != 0) {
				logger.error("Ocurrió un error al actualizar código situación del abonado");
				throw new ProductException(
						"Ocurrió un error al actualizar código situación del abonado", String
								.valueOf(codError), numEvento, msgError);
			}
		} catch (Exception e) {
			logger.error("Ocurrió un error al actualizar código situación del abonado",e);
			if (logger.isDebugEnabled()) {
				logger.debug("Codigo de Error[" + codError + "]");
				logger.debug("Mensaje de Error[" + msgError + "]");
				logger.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new ProductException(
					"Ocurrió un error al actualizar código situación del abonado",e);
		} finally {
				logger.debug("Cerrando conexiones...");
	    try {
	    	cstmt.close();
			if (!conn.isClosed()) {
				conn.close();
			}
		  } catch (SQLException e) {
				logger.debug("SQLException", e);
		  }
		}
		logger.debug("Fin:updCodigoSituacion");
	}//fin updCodigoSituacion
}

