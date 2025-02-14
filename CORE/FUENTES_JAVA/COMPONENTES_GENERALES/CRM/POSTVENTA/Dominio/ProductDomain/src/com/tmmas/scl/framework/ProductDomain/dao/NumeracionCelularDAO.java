package com.tmmas.scl.framework.ProductDomain.dao;


import java.math.BigDecimal;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.util.ArrayList;


import org.apache.log4j.Logger;

import com.tmmas.cl.framework.base.ConnectionDAO;
import com.tmmas.cl.framework.exception.GeneralException;
import com.tmmas.cl.framework.util.ArrayUtl;
import com.tmmas.cl.framework.util.StackTraceUtl;
import com.tmmas.scl.framework.ProductDomain.dto.MesesProrrogasDTO;
import com.tmmas.scl.framework.ProductDomain.dao.interfaces.DatosGeneralesDAOIT;
import com.tmmas.scl.framework.ProductDomain.dao.interfaces.NumeracionCelularDAOIT;
import com.tmmas.scl.framework.ProductDomain.dto.BodegaDTO;
import com.tmmas.scl.framework.ProductDomain.dto.CategoriaTributariaDTO;
import com.tmmas.scl.framework.ProductDomain.dto.CausaCamSerieDTO;
import com.tmmas.scl.framework.ProductDomain.dto.CentralDTO;
import com.tmmas.scl.framework.ProductDomain.dto.CuotaDTO;
import com.tmmas.scl.framework.ProductDomain.dto.DatosCentralDTO;
import com.tmmas.scl.framework.ProductDomain.dto.DatosNumeracionDTO;
import com.tmmas.scl.framework.ProductDomain.dto.ModalidadPagoDTO;
import com.tmmas.scl.framework.ProductDomain.dto.NumeracionCelularDTO;
import com.tmmas.scl.framework.ProductDomain.dto.RegistroVentaDTO;
import com.tmmas.scl.framework.ProductDomain.dto.RestriccionesDTO;
import com.tmmas.scl.framework.ProductDomain.dto.SeleccionNumeroCelularDTO;
import com.tmmas.scl.framework.ProductDomain.dto.SeleccionNumeroCelularRangoDTO;
import com.tmmas.scl.framework.ProductDomain.dto.SerieDTO;
import com.tmmas.scl.framework.ProductDomain.dto.TecnologiaDTO;
import com.tmmas.scl.framework.ProductDomain.dto.TipoDeContratoDTO;
import com.tmmas.scl.framework.ProductDomain.dto.TipoTerminalDTO;
import com.tmmas.scl.framework.ProductDomain.dto.UsoArticuloDTO;
import com.tmmas.scl.framework.ProductDomain.dto.UsosVentaDTO;
import com.tmmas.scl.framework.ProductDomain.exception.ProductException;
import com.tmmas.scl.framework.ProductDomain.helper.Global;
import com.tmmas.scl.framework.aplicationDomain.dto.MensajeRetornoDTO;
import com.tmmas.scl.framework.aplicationDomain.dto.OperadoraLocalDTO;
import com.tmmas.scl.framework.aplicationDomain.dto.SesionDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ArticuloDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ParametroDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ParametrosVerificaPlanComercialDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.RetornoDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.ParametrosCambioSerieDTO;
import com.tmmas.scl.framework.ProductDomain.dto.ParametrosGeneralesDTO;


public class NumeracionCelularDAO extends ConnectionDAO implements NumeracionCelularDAOIT {

	private final Logger logger = Logger.getLogger(NumeracionCelularDAO.class);
	private final Global global = Global.getInstance();

	
	private String getSQLActualizaNroFax()	{

		StringBuffer call = new StringBuffer();
		call.append(" BEGIN ");
		call.append("   GA_SERV911CORREOFAX_PG.GA_UPDATE_FAX_PR( ?, ?, ?, ?, ?);");
		call.append(" END;");
		return call.toString();   
		
	} // getSQLActualizaNroFax
	
	// ----------------------------------------------------------------------------------------------------------------------------------------
	
	private String getSQLDesReservaNumeroCelular()	{

		StringBuffer call = new StringBuffer();
		call.append(" BEGIN ");
		call.append("   VE_NUMERACION_PG.VE_DEL_NUM_CEL_RESERVADO_PR( ?, ?, ?, ?);");
		call.append(" END;");
		return call.toString();   
		
	} // getSQLDesReservaNumeroCelular
	
	// ----------------------------------------------------------------------------------------------------------------------------------------
	
	private String getSQLInsertarNumeroCelularReservado()	{

		StringBuffer call = new StringBuffer();
		call.append(" BEGIN ");
		call.append("   VE_NUMERACION_PG.VE_INS_NUM_CEL_RESERVADO_PR( ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?);");
		call.append(" END;");
		return call.toString();   
		
	} // getSQLInsertarNumeroCelularReservado
	
	// ----------------------------------------------------------------------------------------------------------------------------------------
	
	private String getSQLreservaNumeroCelular()	{

		StringBuffer call = new StringBuffer();
		call.append(" BEGIN ");
		call.append("   VE_NUMERACION_PG.VE_P_NUMERACION_MANUAL_PR( ?, ?, ?, ?, ?, ?, ?, ?, ?, ?);");
		call.append(" END;");
		return call.toString();   

	} // getSQLObtieneSecuenciaTransacabo
	
	// ----------------------------------------------------------------------------------------------------------------------------------------

	private String getSQLObtieneSecuenciaTransacabo()	{

		StringBuffer call = new StringBuffer();
		call.append(" BEGIN ");
		call.append("   VE_intermediario_PG.VE_OBTIENE_SECUENCIA_PR( ?, ?, ?, ?, ?);");
		call.append(" END;");
		return call.toString();   

	} // getSQLObtieneSecuenciaTransacabo
	
	// ----------------------------------------------------------------------------------------------------------------------------------------

	private String getSQLObtieneNumeracionReutilizable()	{

		StringBuffer call = new StringBuffer();
		call.append(" BEGIN ");
		call.append("   VE_NUMERACION_PG.VE_NUMERACION_DISPONIBLE_PR( ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?);");
		call.append(" END;");
		return call.toString();   

	} // getSQLObtieneNumeracionReutilizable
	
	// ----------------------------------------------------------------------------------------------------------------------------------------

	private String getSQLObtieneNumeracionRango()	{

		StringBuffer call = new StringBuffer();
		call.append(" BEGIN ");
		call.append("   VE_NUMERACION_PG.VE_NUMERACION_RANGO_PR( ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?);");
		call.append(" END;");
		return call.toString();   

	} // getSQLObtieneNumeracionRango
		
	// ----------------------------------------------------------------------------------------------------------------------------------------
	
	private String getSQLObtieneNumeracionAutomatica()	{

		StringBuffer call = new StringBuffer();
		call.append(" BEGIN ");
		call.append("   VE_NUMERACION_PG.VE_NUMERACION_AUTOMATICA_PR( ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?);");
		call.append(" END;");
		return call.toString();   

	} // getSQLObtieneNumeracionAutomatica
	
	
	// ----------------------------------------------------------------------------------------------------------------------------------------
	

	
	private String getSQLObtieneCategoria()	{

		StringBuffer call = new StringBuffer();
		call.append(" BEGIN ");
		call.append("   VE_NUMERACION_PG.VE_OBTIENE_CATEGORIA_PR( ?, ?, ?, ?, ?);");
		call.append(" END;");
		return call.toString();   

	} // getSQLObtenerNumeracionReservada
	
	
	// ----------------------------------------------------------------------------------------------------------------------------------------
	
	
	private String getSQLObtenerNumeracionReservada()	{

		StringBuffer call = new StringBuffer();
		call.append(" BEGIN ");
		call.append("   VE_NUMERACION_PG.VE_NUMERACION_RESERVA_PR( ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ? );");
		call.append(" END;");
		return call.toString();   

	} // getSQLObtenerNumeracionReservada
	
	//	 ----------------------------------------------------------------------------------------------------------------------------------------
	
	private String getSQLReponerNumeracion() {
		
		StringBuffer call = new StringBuffer();
		call.append(" BEGIN ");
		call.append("   VE_NUMERACION_PG.VE_P_REPONER_NUMERACION_PR( ?, ?, ?, ?, ?, ?, ?, ?, ? );");
		call.append(" END;");
		return call.toString();   
		
	} // getSQLReponerNumeracion
	
	// ----------------------------------------------------------------------------------------------------------------------------------------
	

	public void reponerNumeracion(NumeracionCelularDTO numeracionCelularVO) throws ProductException {
		
		logger.debug("actDesactSS():start");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		CallableStatement cstmt = null;
		String call = getSQLReponerNumeracion();
		try {

			conn = getConnectionFromWLSInitialContext(global.getJndiForDataSource());

			cstmt = conn.prepareCall(call);
			logger.debug("Parámetros de entrada");
			logger.debug("numeracionCelularVO.getNumCelular() [" + String.valueOf(numeracionCelularVO.getNumCelular()) + "]");
			logger.debug("numeracionCelularVO.getNombreTabla() [" + String.valueOf(numeracionCelularVO.getNombreTabla()) + "]");
			logger.debug("numeracionCelularVO.getCodCat() [" + String.valueOf(numeracionCelularVO.getCodCat()) + "]");
			logger.debug("numeracionCelularVO.getCodUso() [" + String.valueOf(numeracionCelularVO.getCodUso()) + "]");
			logger.debug("numeracionCelularVO.getCodSubALM() [" + String.valueOf(numeracionCelularVO.getCodSubALM()) + "]");
			
			cstmt.setString(1, numeracionCelularVO.getNombreTabla());
			cstmt.setString(2, numeracionCelularVO.getCodSubALM());
			cstmt.setString(3, numeracionCelularVO.getCodCentral());
			cstmt.setString(4, numeracionCelularVO.getCodCat());
			cstmt.setString(5, numeracionCelularVO.getCodUso());
			cstmt.setString(6, String.valueOf(numeracionCelularVO.getNumCelular().longValue()));
				
			cstmt.registerOutParameter(7, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(8, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(9, java.sql.Types.NUMERIC);
			
			logger.debug("execute:antes");
			cstmt.execute();
			logger.debug("execute:despues");

			logger.debug("Recuperando salidas");
			codError = cstmt.getInt(7);
			logger.debug("codError[" + codError + "]");
			msgError = cstmt.getString(8);
			logger.debug("msgError[" + msgError + "]");
			numEvento = cstmt.getInt(9);
			logger.debug("numEvento[" + numEvento + "]");

			if (codError != 0) {
				logger.error("Ocurrió un error al reponet numero de celular.");
				throw new ProductException(String.valueOf(codError), numEvento,
						msgError);
			}

			logger.debug("Recuperando data...");

		} catch (ProductException e) {
			logger.debug("ProductException");
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + loge + "]");
			throw e;

		} catch (Exception e) {
			logger.error("Ocurrió un error al reponet numero de celular.", e);
			throw new ProductException("Ocurrió un error al reponet numero de celular.", e);
		} finally {
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
		logger.debug("reponerNumeracion():end");
		
	} // reponerNumeracion
	
	// ------------------------------------------------------------------------------------------------------------------------------------

	public SeleccionNumeroCelularDTO[] obtenerNumeracionReservada(DatosNumeracionDTO datosNumeracionDTO) throws ProductException	{
		logger.debug("obtenerNumeracionReservada():start");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		CallableStatement cstmt = null;
		SeleccionNumeroCelularDTO[] arrayNumerosReservados = null;
		String call = getSQLObtenerNumeracionReservada();
		
		try {
			conn = getConnectionFromWLSInitialContext(global.getJndiForDataSource());

			cstmt = conn.prepareCall(call);
			logger.debug("Parámetros de entrada");
			logger.debug("datosNumeracionDTO.getCodCliente() [" + String.valueOf(datosNumeracionDTO.getCodCliente()) + "]");
			logger.debug("datosNumeracionDTO.getCodCodUsoNue() [" + String.valueOf(datosNumeracionDTO.getCodCodUsoNue()) + "]");
			logger.debug("datosNumeracionDTO.getCodCatNue() [" + String.valueOf(datosNumeracionDTO.getCodCatNue()) + "]");
			logger.debug("datosNumeracionDTO.getCantidadMaximaNrosCelulares() [" + String.valueOf(datosNumeracionDTO.getCantidadMaximaNrosCelulares()) + "]");
			logger.debug("datosNumeracionDTO.getCodCentNue() [" + String.valueOf(datosNumeracionDTO.getCodCentNue()) + "]");
			logger.debug("datosNumeracionDTO.getCodVendedor() [" + String.valueOf(datosNumeracionDTO.getCodVendedor()) + "]");
			logger.debug("datosNumeracionDTO.getCodVendealer() [" + String.valueOf(datosNumeracionDTO.getCodVendealer()) + "]");
			
			cstmt.setLong(1,datosNumeracionDTO.getCodCliente().longValue());
			cstmt.setLong(2,datosNumeracionDTO.getCodVendedor().longValue());
			
			cstmt.setString(3,datosNumeracionDTO.getCodCodUsoNue());
			cstmt.setString(4, datosNumeracionDTO.getCodCatNue());
			cstmt.setBigDecimal(5,new BigDecimal(datosNumeracionDTO.getCantidadMaximaNrosCelulares()));
			cstmt.setLong(6,datosNumeracionDTO.getCodVendealer().longValue());
			cstmt.setString(7,datosNumeracionDTO.getCodCentNue());				
			cstmt.registerOutParameter(8, oracle.jdbc.driver.OracleTypes.CURSOR);
			
			cstmt.registerOutParameter(9,java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(10,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(11,java.sql.Types.NUMERIC);

			logger.debug("execute:antes");
			cstmt.execute();
			logger.debug("execute:despues");
		
			logger.debug("Recuperando salidas");
			codError = cstmt.getInt(9);
			logger.debug("codError[" + codError + "]");
			msgError = cstmt.getString(10);
			logger.debug("msgError[" + msgError + "]");
			numEvento = cstmt.getInt(11);
			logger.debug("numEvento[" + numEvento + "]");
		
			if (codError != 0) {
				logger.error("Ocurrió un error al obtener numeracion reservada.");
				throw new ProductException(String.valueOf(codError), numEvento,
						msgError);
			}

			logger.debug("Recuperando cursor...");
			logger.debug("object="+cstmt.getObject(8));
			ResultSet rs = (ResultSet) cstmt.getObject(8);

			ArrayList lista = new ArrayList();
			while (rs.next()) {
				SeleccionNumeroCelularDTO numerosReservados = new SeleccionNumeroCelularDTO();	
				numerosReservados.setNumCelular(new Long (rs.getLong(1)));
				numerosReservados.setCodCategoria(rs.getString(2));
				lista.add(numerosReservados);
			} // while

			logger.debug("Largo Lista nros. reservados[" + lista.size());
			arrayNumerosReservados = (SeleccionNumeroCelularDTO[]) ArrayUtl.copiaArregloTipoEspecifico(	lista.toArray(), SeleccionNumeroCelularDTO.class);			
			logger.debug("Largo arrayNumerosReservados ["+arrayNumerosReservados.length );

		} catch (ProductException e) {
			logger.debug("ProductException");
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + loge + "]");
			throw e;

		} catch (Exception e) {
			logger
			.error("Ocurrió un error al obtener numeracion reservada.", e);
			throw new ProductException("Ocurrió un error al obtener numeracion reservada.",	e);
		} finally {
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
		logger.debug("reponerNumeracion():end");
		return arrayNumerosReservados;	

	} // obtenerNumeracionReservada

	// ------------------------------------------------------------------------------------------------------------------------------------

	public String[] obtieneCategoria(DatosNumeracionDTO datosNumeracionVO)  throws ProductException	{
		
		logger.debug("obtieneCategoria():start");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		CallableStatement cstmt = null;
		String[] arregloCategorias = null;
		String call = getSQLObtieneCategoria();
		
		try {
			conn = getConnectionFromWLSInitialContext(global.getJndiForDataSource());

			cstmt = conn.prepareCall(call);
			logger.debug("Parámetros de entrada");
			logger.debug("datosNumeracionVO.getCodActabo() [" + String.valueOf(datosNumeracionVO.getCodActabo()) + "]");
			
			cstmt.setString(1,datosNumeracionVO.getCodActabo());
			cstmt.registerOutParameter(2, oracle.jdbc.driver.OracleTypes.CURSOR);
			cstmt.registerOutParameter(3,java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5,java.sql.Types.NUMERIC);

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
				logger.error("Ocurrió un error la categoria.");
				throw new ProductException(String.valueOf(codError), numEvento,
						msgError);
			}

			logger.debug("Recuperando cursor...");
			logger.debug("object="+cstmt.getObject(2));
			ResultSet rs = (ResultSet) cstmt.getObject(2);

			ArrayList lista = new ArrayList();
			while (rs.next()) {
				lista.add(rs.getString(1));
			} // while

			logger.debug("Largo Lista Categorias[" + lista.size());
			arregloCategorias = (String[])lista.toArray(new String[lista.size()]);

		} catch (ProductException e) {
			logger.debug("ProductException");
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + loge + "]");
			throw e;

		} catch (Exception e) {
			logger
			.error("Ocurrió un error la categoria.", e);
			throw new ProductException("Ocurrió un error la categoria.",	e);
		} finally {
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
		logger.debug("obtieneCategoria():end");
		return arregloCategorias;	

	} // obtieneCategoria

	// ------------------------------------------------------------------------------------------------------------------------------------

	public DatosNumeracionDTO obtieneNumeracionAutomatica(DatosNumeracionDTO datosNumeracionVO)  throws ProductException {
		
		logger.debug("obtieneNumeracionAutomatica():start");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		CallableStatement cstmt = null;
		DatosNumeracionDTO resultado = new DatosNumeracionDTO();
		
		String call = getSQLObtieneNumeracionAutomatica();
		try {

			conn = getConnectionFromWLSInitialContext(global.getJndiForDataSource());

			cstmt = conn.prepareCall(call);
			logger.debug("Parámetros de entrada");
			logger.info("Entrada en DAO:");
			logger.info("datosNumeracionVO.getCodCeldNue():" + datosNumeracionVO.getCodCeldNue());
			logger.info("datosNumeracionVO.getCodCentNue():" + datosNumeracionVO.getCodCentNue());
			logger.info("datosNumeracionVO.getCodCodUsoNue():" + datosNumeracionVO.getCodCodUsoNue());
			logger.info("datosNumeracionVO.getCodActabo():" + datosNumeracionVO.getCodActabo());

			cstmt.setString(1,datosNumeracionVO.getCodCeldNue());
			cstmt.setString(2,datosNumeracionVO.getCodCentNue());
			cstmt.setString(3, datosNumeracionVO.getCodCodUsoNue());
			cstmt.setString(4,datosNumeracionVO.getCodActabo());
			
			cstmt.registerOutParameter(5, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(6, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(7, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(8, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(9, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(10,java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(11,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(12,java.sql.Types.NUMERIC);
							
			logger.debug("execute:antes");
			cstmt.execute();
			logger.debug("execute:despues");

			logger.debug("Recuperando salidas");
			codError = cstmt.getInt(10);
			msgError = cstmt.getString(11);
			numEvento = cstmt.getInt(12);
			logger.info("codError[" + codError + "]");
			logger.info("msgError[" + msgError + "]");
			logger.info("numEvento[" + numEvento + "]");

			if (codError != 0) {
				logger.error("Ocurrió un error al obtener numeración automatica.");
				throw new ProductException(String.valueOf(codError), numEvento,
						msgError);
			}

			logger.debug("Recuperando data...");
			resultado.setCodSubalmNue(cstmt.getString(5));
			resultado.setNumCelular(new Long (cstmt.getLong(6)));
			resultado.setNomtabla(cstmt.getString(7));
			resultado.setCodCatNue(cstmt.getString(8));
			resultado.setFecBaja(cstmt.getString(9));
			
			logger.info("Salida en DAO:");
			logger.info("datosNumeracionVO.getCodSubalmNue():" + datosNumeracionVO.getCodSubalmNue());
			logger.info("datosNumeracionVO.getNumCelular():" + datosNumeracionVO.getNumCelular());
			logger.info("datosNumeracionVO.getNomtabla():" + datosNumeracionVO.getNomtabla());
			logger.info("datosNumeracionVO.getCodCatNue():" + datosNumeracionVO.getCodCatNue());
			logger.info("datosNumeracionVO.getFecBaja():" + datosNumeracionVO.getFecBaja());
			
		} catch (ProductException e) {
			logger.debug("ProductException");
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + loge + "]");
			throw e;

		} catch (Exception e) {
			logger.error("Ocurrió un error al obtener numeración automatica.", e);
			throw new ProductException("Ocurrió un error al obtener numeración automatica.", e);
		} finally {
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
		logger.debug("obtieneNumeracionAutomatica():end");
		
		return resultado;
		
	} // obtieneNumeracionAutomatica
	
	// ------------------------------------------------------------------------------------------------------------------------------------

	public SeleccionNumeroCelularDTO[] obtieneNumeracionReutilizable(DatosNumeracionDTO datosNumeracionVO)  throws ProductException	{
		
		logger.debug("obtenerNumeracionReutilizable():start");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		CallableStatement cstmt = null;
		SeleccionNumeroCelularDTO[] arrayNumerosReutilizables = null;
		String call = getSQLObtieneNumeracionReutilizable();
		
		try {
			conn = getConnectionFromWLSInitialContext(global.getJndiForDataSource());

			cstmt = conn.prepareCall(call);
			logger.debug("Parámetros de entrada");
			logger.info("datosNumeracionVO.getCodCatNue():"+datosNumeracionVO.getCodCatNue());
			logger.info("datosNumeracionVO.getCodCodUsoNue():"+datosNumeracionVO.getCodCodUsoNue());
			logger.info("datosNumeracionVO.getCodCentNue():"+datosNumeracionVO.getCodCentNue());
			logger.info("datosNumeracionVO.getCodSubalmNue():"+datosNumeracionVO.getCodSubalmNue());
			logger.info("datosNumeracionVO.getLimiteInferior():"+datosNumeracionVO.getLimiteInferior());
			logger.info("datosNumeracionVO.getLimiteSuperior():"+datosNumeracionVO.getLimiteSuperior());
			logger.info("datosNumeracionVO.getCantidadMaximaNrosCelulares():"+datosNumeracionVO.getCantidadMaximaNrosCelulares());
			
			
			cstmt.setString(1,datosNumeracionVO.getCodCatNue());
			
			//TODO: 15DIC2008 BUG INTERNO Se elimina lógica de portabilidad, pues no aplica para este servicio
			//if (datosNumeracionVO.getCodCodUsoNue()!=null && !"1".equals(global.getValorExterno("NC.portabilidad.numero"))){
			cstmt.setString(2,datosNumeracionVO.getCodCodUsoNue());
			/*}else{
				cstmt.setNull(2,java.sql.Types.NUMERIC);
			}*/
			cstmt.setString(3, datosNumeracionVO.getCodCentNue());
			cstmt.setString(4,datosNumeracionVO.getCodSubalmNue());
			cstmt.setLong(5,datosNumeracionVO.getLimiteInferior().longValue());
			cstmt.setLong(6,datosNumeracionVO.getLimiteSuperior().longValue());
			
			//TODO: 29ENE2009 76301 Se agrega propiedad para controlar la cantidad maxima de celulares que el sistema puede devolver. HH
			cstmt.setBigDecimal(7,new BigDecimal(datosNumeracionVO.getCantidadMaximaNrosCelulares()));

			cstmt.registerOutParameter(8, oracle.jdbc.driver.OracleTypes.CURSOR);
			cstmt.registerOutParameter(9,java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(10,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(11,java.sql.Types.NUMERIC);

			logger.info(" Iniciando Ejecución");
			logger.info("Execute Antes");

			cstmt.execute();

			logger.info("Execute Despues");
			logger.info(" Finalizo ejecución");

			codError = cstmt.getInt(9);
			msgError = cstmt.getString(10);
			numEvento = cstmt.getInt(11);
			logger.info("codError[" + codError + "]");
			logger.info("msgError[" + msgError + "]");
			logger.info("numEvento[" + numEvento + "]");
		
			if (codError != 0) {
				logger.error("Ocurrió un error al obtener numeración reutilizable.");
				throw new ProductException(String.valueOf(codError), numEvento,
						msgError);
			}


			ResultSet rs = (ResultSet) cstmt.getObject(8);
			ArrayList listadosNumeros = new ArrayList();
			//Obtener Datos desde el Cursor
			logger.info("Salida en DAO:");
			while(rs.next()){
				SeleccionNumeroCelularDTO NumerosReutilizables= new SeleccionNumeroCelularDTO();
				NumerosReutilizables.setNumCelular(new Long (rs.getLong(1)));
				NumerosReutilizables.setCodCategoria(rs.getString(2));
				NumerosReutilizables.setFechaBaja(rs.getString(3));
				listadosNumeros.add(NumerosReutilizables);
			}
			
			logger.info("Cantidad de nros reutilizables: "+listadosNumeros.size());
			arrayNumerosReutilizables = (SeleccionNumeroCelularDTO[])listadosNumeros.toArray(new SeleccionNumeroCelularDTO[listadosNumeros.size()]);
			
		} catch (ProductException e) {
			logger.debug("ProductException");
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + loge + "]");
			throw e;

		} catch (Exception e) {
			logger
			.error("Ocurrió un error al obtener numeración reutilizable.", e);
			throw new ProductException("Ocurrió un error al obtener numeración reutilizable.",	e);
		} finally {
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
		logger.debug("obtenerNumeracionReutilizable():end");
		return arrayNumerosReutilizables;	

	} // obtenerNumeracionReutilizable

	// ------------------------------------------------------------------------------------------------------------------------------------


	public SeleccionNumeroCelularRangoDTO[] obtenerNumeracionRango(DatosNumeracionDTO datosNumeracionVO)  throws ProductException	{
		
		logger.debug("obtenerNumeracionRango():start");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		CallableStatement cstmt = null;
		SeleccionNumeroCelularRangoDTO[] arrayListaRangos= null;
		String call = getSQLObtieneNumeracionRango();
		
		try {
			conn = getConnectionFromWLSInitialContext(global.getJndiForDataSource());

			cstmt = conn.prepareCall(call);
			logger.debug("Parámetros de entrada");
			logger.info("datosNumeracionVO.getCodCatNue():"+datosNumeracionVO.getCodCatNue());
			logger.info("datosNumeracionVO.getCodCodUsoNue():"+datosNumeracionVO.getCodCodUsoNue());
			logger.info("datosNumeracionVO.getCodCentNue():"+datosNumeracionVO.getCodCentNue());
			logger.info("datosNumeracionVO.getCodSubalmNue():"+datosNumeracionVO.getCodSubalmNue());
			logger.info("datosNumeracionVO.getLimiteInferior():"+datosNumeracionVO.getLimiteInferior());
			logger.info("datosNumeracionVO.getLimiteSuperior():"+datosNumeracionVO.getLimiteSuperior());
			logger.info("datosNumeracionVO.getCantidadMaximaNrosCelulares():"+datosNumeracionVO.getCantidadMaximaNrosCelulares());
			
			
			cstmt.setString(1,datosNumeracionVO.getCodCatNue());
			
			//TODO: 15DIC2008 BUG INTERNO Se elimina lógica de portabilidad, pues no aplica para este servicio
			//if (datosNumeracionVO.getCodCodUsoNue()!=null && !"1".equals(global.getValorExterno("NC.portabilidad.numero"))){
				cstmt.setString(2,datosNumeracionVO.getCodCodUsoNue());
			/*}else{
				cstmt.setNull(2,java.sql.Types.NUMERIC);
			}*/
			cstmt.setString(3, datosNumeracionVO.getCodCentNue());
			cstmt.setString(4,datosNumeracionVO.getCodSubalmNue());
			cstmt.setLong(5,datosNumeracionVO.getLimiteInferior().longValue());
			cstmt.setLong(6,datosNumeracionVO.getLimiteSuperior().longValue());
			//TODO: 29ENE2009 76301 Se agrega propiedad para controlar la cantidad maxima de celulares que el sistema puede devolver. HH
			cstmt.setBigDecimal(7,new BigDecimal(datosNumeracionVO.getCantidadMaximaNrosCelulares()));

			//TODO: 09DIC2008 PF-PV-024 RQ Se cambia retorno para obtener un listado y no un solo registro
			cstmt.registerOutParameter(8,oracle.jdbc.driver.OracleTypes.CURSOR);
			cstmt.registerOutParameter(9,java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(10,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(11,java.sql.Types.NUMERIC);

			logger.info(" Iniciando Ejecución");
			logger.info("Execute Antes");

			cstmt.execute();

			logger.info("Execute Despues");
			logger.info(" Finalizo ejecución");

			codError = cstmt.getInt(9);
			msgError = cstmt.getString(10);
			numEvento = cstmt.getInt(11);
			logger.info("codError[" + codError + "]");
			logger.info("msgError[" + msgError + "]");
			logger.info("numEvento[" + numEvento + "]");
		
			if (codError != 0) {
				logger.error("Ocurrió un error al obtener numeración rango.");
				throw new ProductException(String.valueOf(codError), numEvento,
						msgError);
			}

			//TODO: 09DIC2008 PF-PV-024 RQ Se cambia retorno para obtener un listado y no un solo registro
			ArrayList ListaNumerosRango = new ArrayList();
			ResultSet rs = (ResultSet) cstmt.getObject(8);			
			while(rs.next()){
				SeleccionNumeroCelularRangoDTO seleccionNumeroCelularRangoVO= new SeleccionNumeroCelularRangoDTO();
				seleccionNumeroCelularRangoVO.setNumDesde(new Long (rs.getLong(1)));
				seleccionNumeroCelularRangoVO.setNumHasta(new Long (rs.getLong(2)));
				seleccionNumeroCelularRangoVO.setCodCategoria(rs.getString(3));
				ListaNumerosRango.add(seleccionNumeroCelularRangoVO);
			}
			logger.info("Salida en DAO:");
			logger.info("Cantidad de nros por rango: "+ListaNumerosRango.size());
			
			arrayListaRangos = (SeleccionNumeroCelularRangoDTO[])ListaNumerosRango.toArray(new SeleccionNumeroCelularRangoDTO[ListaNumerosRango.size()]);
			
		} catch (ProductException e) {
			logger.debug("ProductException");
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + loge + "]");
			throw e;

		} catch (Exception e) {
			logger
			.error("Ocurrió un error al obtener numeración rango.", e);
			throw new ProductException("Ocurrió un error al obtener numeración rango.",	e);
		} finally {
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
		logger.debug("obtenerNumeracionRango():end");
		return arrayListaRangos;	

	} // obtenerNumeracionRango

	// ------------------------------------------------------------------------------------------------------------------------------------

	public void reservaNumeroCelular(NumeracionCelularDTO numeracionCelularVO) throws ProductException {
		
		logger.debug("reservaNumeroCelular():start");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		CallableStatement cstmt = null;
		
		String call = getSQLreservaNumeroCelular();
		try {

			conn = getConnectionFromWLSInitialContext(global.getJndiForDataSource());
			cstmt = conn.prepareCall(call);
		
			logger.info("Entrada en DAO:");
			logger.info("numeracionCelularVO.getSecuencia():"+numeracionCelularVO.getSecuencia());
			logger.info("numeracionCelularVO.getNombreTabla():"+numeracionCelularVO.getNombreTabla());
			logger.info("numeracionCelularVO.getCodSubALM():"+numeracionCelularVO.getCodSubALM());
			logger.info("numeracionCelularVO.getCodCentral():"+numeracionCelularVO.getCodCentral());
			logger.info("numeracionCelularVO.getCodCat():"+numeracionCelularVO.getCodCat());
			logger.info("numeracionCelularVO.getCodUso():"+numeracionCelularVO.getCodUso());
			logger.info("numeracionCelularVO.getNumCelular():"+numeracionCelularVO.getNumCelular());

			//VP_TRANSAC IN VARCHAR2 ,
			cstmt.setString(1, numeracionCelularVO.getSecuencia());
			//VP_TABLA IN VARCHAR2 ,
			cstmt.setString(2, numeracionCelularVO.getNombreTabla());
			//VP_SUBALM IN VARCHAR2 ,
			cstmt.setString(3, numeracionCelularVO.getCodSubALM());
			//VP_CENTRAL IN VARCHAR2 ,
			cstmt.setString(4, numeracionCelularVO.getCodCentral());
			//VP_CAT IN VARCHAR2 ,
			cstmt.setString(5, numeracionCelularVO.getCodCat());
			//VP_USO IN VARCHAR2 ,
			cstmt.setString(6, numeracionCelularVO.getCodUso());
			//VP_CELULAR IN VARCHAR2 ,
			cstmt.setString(7, String.valueOf(numeracionCelularVO.getNumCelular().longValue()));
			
			cstmt.registerOutParameter(8, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(9, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(10, java.sql.Types.NUMERIC);
			
			logger.debug("execute:antes");
			cstmt.execute();
			logger.debug("execute:despues");

			codError = cstmt.getInt(8);
			msgError = cstmt.getString(9);
			numEvento = cstmt.getInt(10);
			logger.info("codError[" + codError + "]");
			logger.info("msgError[" + msgError + "]");
			logger.info("numEvento[" + numEvento + "]");

			if (codError != 0) {
				logger.error("Ocurrió un error al reservar numero de celular.");
				throw new ProductException(String.valueOf(codError), numEvento,
						msgError);
			}

		
			
		} catch (ProductException e) {
			logger.debug("ProductException");
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + loge + "]");
			throw e;

		} catch (Exception e) {
			logger.error("Ocurrió un error al reservar numero de celular.", e);
			throw new ProductException("Ocurrió un error al reservar numero de celular.", e);
		} finally {
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
		logger.debug("reservaNumeroCelular():end");
		
		
	} // reservaNumeroCelular
	
	// ------------------------------------------------------------------------------------------------------------------------------------	

	public void insertarNumeroCelularReservado(NumeracionCelularDTO numeracionCelularVO) throws ProductException {
		
		logger.debug("insertarNumeroCelularReservado():start");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		CallableStatement cstmt = null;
		
		String call = getSQLInsertarNumeroCelularReservado();
		try {

			conn = getConnectionFromWLSInitialContext(global.getJndiForDataSource());
			cstmt = conn.prepareCall(call);
		
			logger.info("Entrada en DAO:");
			logger.info("numeracionCelularVO.getSecuencia():"+numeracionCelularVO.getSecuencia());
			logger.info("numeracionCelularVO.getNumLinea():"+numeracionCelularVO.getNumLinea());
			logger.info("numeracionCelularVO.getNumOrden():"+numeracionCelularVO.getNumOrden());
			logger.info("numeracionCelularVO.getNumCelular():"+numeracionCelularVO.getNumCelular());
			logger.info("numeracionCelularVO.getCodSubALM():"+numeracionCelularVO.getCodSubALM());
			logger.info("numeracionCelularVO.getCodCentral():"+numeracionCelularVO.getCodCentral());
			logger.info("numeracionCelularVO.getCodCat():"+numeracionCelularVO.getCodCat());
			logger.info("numeracionCelularVO.getCodUso():"+numeracionCelularVO.getCodUso());
			logger.info("numeracionCelularVO.getNomUsuarioSCL():"+numeracionCelularVO.getNomUsuarioSCL());
			logger.info("numeracionCelularVO.getIndProcNum():"+numeracionCelularVO.getIndProcNum());
			logger.info("numeracionCelularVO.getFechaBaja():"+numeracionCelularVO.getFecBaja());
			
			   //EN_NUM_TRANSACCION 	IN GA_RESNUMCEL.NUM_TRANSACCION%TYPE,
		    cstmt.setLong(1, new Long(numeracionCelularVO.getSecuencia()).longValue());
		    //EN_NUM_LINEA 			IN GA_RESNUMCEL.NUM_LINEA%TYPE,
		    cstmt.setLong(2, numeracionCelularVO.getNumLinea().longValue());
		    //EN_NUM_ORDEN 			IN GA_RESNUMCEL.NUM_ORDEN%TYPE,
		    cstmt.setLong(3, numeracionCelularVO.getNumOrden().longValue());
		    //EN_NUM_CELULAR        IN GA_RESNUMCEL.NUM_CELULAR%TYPE,
		    cstmt.setLong(4, numeracionCelularVO.getNumCelular().longValue());
		    //EV_COD_SUBALM         IN GA_RESNUMCEL.COD_SUBALM%TYPE,
		    cstmt.setString(5, numeracionCelularVO.getCodSubALM());
		    //EN_COD_PRODUCTO       IN GA_RESNUMCEL.COD_PRODUCTO%TYPE,
		    cstmt.setLong(6, numeracionCelularVO.getCodProducto().longValue());
		    //EN_COD_CENTRAL        IN GA_RESNUMCEL.COD_CENTRAL%TYPE,
		    cstmt.setLong(7, new Long(numeracionCelularVO.getCodCentral()).longValue());
		    //EN_COD_CAT            IN GA_RESNUMCEL.COD_CAT%TYPE,
		    cstmt.setLong(8, new Long(numeracionCelularVO.getCodCat()).longValue());
		    //EN_COD_USO            IN GA_RESNUMCEL.COD_USO%TYPE,	
		    cstmt.setLong(9, new Long(numeracionCelularVO.getCodUso()).longValue());
		    //EV_NOM_USUARIO 		IN GA_RESNUMCEL.NOM_USUARIO%TYPE,
		    cstmt.setString(10, numeracionCelularVO.getNomUsuarioSCL());
		    //EV_IND_PROCNUM 		IN GA_RESNUMCEL.IND_PROCNUM%TYPE,
		    cstmt.setString(11, numeracionCelularVO.getIndProcNum());
		    cstmt.setString(12, numeracionCelularVO.getFecBaja());
		    
 		    cstmt.registerOutParameter(13, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(14, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(15, java.sql.Types.NUMERIC);
			
			logger.debug("execute:antes");
			cstmt.execute();
			logger.debug("execute:despues");
			
			codError = cstmt.getInt(13);
			msgError = cstmt.getString(14);
			numEvento = cstmt.getInt(15);
			logger.info("codError[" + codError + "]");
			logger.info("msgError[" + msgError + "]");
			logger.info("numEvento[" + numEvento + "]");

			if (codError != 0) {
				logger.error("Ocurrió un error al insertar numero de celular reservado.");
				throw new ProductException(String.valueOf(codError), numEvento,
						msgError);
			}
			
		} catch (ProductException e) {
			logger.debug("ProductException");
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + loge + "]");
			throw e;

		} catch (Exception e) {
			logger.error("Ocurrió un error al insertar numero de celular reservado.", e);
			throw new ProductException("Ocurrió un error al insertar numero de celular reservado.", e);
		} finally {
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
		logger.debug("insertarNumeroCelularReservado():end");
		
		
	} // insertarNumeroCelularReservado
	
	// ------------------------------------------------------------------------------------------------------------------------------------

	public void desReservaNumeroCelular(NumeracionCelularDTO numeracionCelularVO) throws ProductException {
		
		logger.debug("desReservaNumeroCelular():start");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		CallableStatement cstmt = null;
		
		String call = getSQLDesReservaNumeroCelular();
		try {

			conn = getConnectionFromWLSInitialContext(global.getJndiForDataSource());
			cstmt = conn.prepareCall(call);
		
			logger.info("Entrada en DAO:");
			logger.info("numeracionCelularVO.getNumCelular():"+numeracionCelularVO.getNumCelular());

			cstmt.setLong(1, numeracionCelularVO.getNumCelular().longValue());									
			cstmt.registerOutParameter(2, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);
			
			logger.debug("execute:antes");
			cstmt.execute();
			logger.debug("execute:despues");
			
			codError = cstmt.getInt(2);
			msgError = cstmt.getString(3);
			numEvento = cstmt.getInt(4);
			logger.info("codError[" + codError + "]");
			logger.info("msgError[" + msgError + "]");
			logger.info("numEvento[" + numEvento + "]");

			if (codError != 0) {
				logger.error("Ocurrió un error al desreservar numero de celular.");
				throw new ProductException(String.valueOf(codError), numEvento,
						msgError);
			}

		
			
		} catch (ProductException e) {
			logger.debug("ProductException");
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + loge + "]");
			throw e;

		} catch (Exception e) {
			logger.error("Ocurrió un error al desreservar numero de celular.", e);
			throw new ProductException("Ocurrió un error al desreservar numero de celular.", e);
		} finally {
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
		logger.debug("desReservaNumeroCelular():end");
		
		
	} // desReservaNumeroCelular
	
	// ------------------------------------------------------------------------------------------------------------------------------------		

	public void actualizaNroFax(long numAbonado, String numeroFax)  throws ProductException {
		
		logger.debug("actualizaNroFax():start");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		CallableStatement cstmt = null;
		
		String call = getSQLActualizaNroFax();
		try {

			conn = getConnectionFromWLSInitialContext(global.getJndiForDataSource());
			cstmt = conn.prepareCall(call);
		
			logger.info("Entrada en DAO:");
			logger.info("numAbonado:"+String.valueOf(numAbonado));
			logger.info("numeroFax:"+numeroFax);			

			cstmt.setLong(1, numAbonado);
			cstmt.setLong(2, Long.parseLong(numeroFax));
			cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);
			
			logger.debug("execute:antes");
			cstmt.execute();
			logger.debug("execute:despues");
			
			codError = cstmt.getInt(3);
			msgError = cstmt.getString(4);
			numEvento = cstmt.getInt(5);
			logger.info("codError[" + codError + "]");
			logger.info("msgError[" + msgError + "]");
			logger.info("numEvento[" + numEvento + "]");

			if (codError != 0) {
				logger.error("Ocurrió un error al actualizar numero de fax.");
				throw new ProductException(String.valueOf(codError), numEvento,
						msgError);
			}

		} catch (ProductException e) {
			logger.debug("ProductException");
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + loge + "]");
			throw e;

		} catch (Exception e) {
			logger.error("Ocurrió un error al actualizar numero de fax.", e);
			throw new ProductException("Ocurrió un error al actualizar numero de fax.", e);
		} finally {
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
		logger.debug("actualizaNroFax():end");
		
		
	} // actualizaNroFax
	
	// ------------------------------------------------------------------------------------------------------------------------------------		


}//fin NumeracionCelularDAO


