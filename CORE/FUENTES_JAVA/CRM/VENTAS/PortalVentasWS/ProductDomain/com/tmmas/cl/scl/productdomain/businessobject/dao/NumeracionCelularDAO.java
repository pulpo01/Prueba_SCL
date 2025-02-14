/**
 * Copyright © 2008 Telef&oacute;nica M&oacute;viles Soluciones y Aplicaciones, SA.
 * Av. Del Condor 720, Huechuraba, Santiago de Chile, Chile
 * Todos los derechos reservados.
 *
 * Este software es informaci&oacute;n propietaria y confidencial de TM-mAs SA.
 * Usted no debe develar tal información y s&oactute;lo debe usarla en concordancia
 * con los t&eacute;rminos de derechos de licencias que sean adquiridos con TM-mAs.
 *
 * Fecha ------------------- Autor  ------------------------- Cambios ----------
 * 14/07/2008 09:31     Nicol&aacute;s Contreras    		Versión Inicial 
 * 
 * Esta clase tiene como finalidad manejar la interacción con las base de datos para las operaciones de Numeración Celular.
 * 
 * @author Nicolas Contreras
 * @version 1.0
 **/
package com.tmmas.cl.scl.productdomain.businessobject.dao;

import java.math.BigDecimal;
import java.sql.ResultSet;
import java.util.ArrayList;

import oracle.jdbc.driver.OracleTypes;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.SQLException;

import org.apache.log4j.Category;

import org.apache.log4j.Logger;

import com.tmmas.cl.framework.base.ConnectionDAO;
import com.tmmas.cl.scl.commonbusinessentities.dto.NumeroFrecuenteDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.exception.ProductDomainException;
import com.tmmas.cl.scl.productdomain.businessobject.dto.DatosNumeracionDTO;
import com.tmmas.cl.scl.productdomain.businessobject.dto.NumeracionCelularDTO;
import com.tmmas.cl.scl.productdomain.businessobject.dto.NumeroInternetDTO;
import com.tmmas.cl.scl.productdomain.businessobject.dto.SeleccionNumeroCelularDTO;
import com.tmmas.cl.scl.productdomain.businessobject.dto.SeleccionNumeroCelularRangoDTO;
import com.tmmas.cl.scl.productdomain.businessobject.helper.Global;




/**
 * Copyright © 2008 Telef&oacute;nica M&oacute;viles Soluciones y Aplicaciones, SA.
 * Av. Del Condor 720, Huechuraba, Santiago de Chile, Chile
 * Todos los derechos reservados.
 *
 * Este software es informaci&oacute;n propietaria y confidencial de TM-mAs SA.
 * Usted no debe develar tal información y s&oactute;lo debe usarla en concordancia
 * con los t&eacute;rminos de derechos de licencias que sean adquiridos con TM-mAs.
 *
 * Fecha ------------------- Autor  ------------------------- Cambios ----------
 * 09/10/2008 17:59:00     Santiago Ventura Infante      			Versión Inicial 
 * 
 *
 * 
 * ServiciosSCLFranquiciasFase2DAO
 * @author 
 * @version 1.0
 **/
public class NumeracionCelularDAO 
	extends ConnectionDAO
{
	private final Logger logger = Logger.getLogger(NumeracionCelularDAO.class);
	private static Category cat = Category.getInstance(ArticuloDAO.class);
	Global global = Global.getInstance();
	
	
	private Connection getConection() throws ProductDomainException
	{
		Connection conn = null;
		try {
			conn = getConnectionFromWLSInitialContext(global.getJndiForDataSource());
		} catch (Exception e1) {
			conn = null;
			cat.error(" No se pudo obtener una conexión ", e1);
			throw new ProductDomainException("No se pudo obtener una conexión", e1);
		}
		
		return conn;
	}
	
	private String getSQLDatos(String packageName, String procedureName, int paramCount)
	{
		StringBuffer sb = new StringBuffer("{call "+packageName+"."+procedureName+"(");
        for (int n = 1; n <= paramCount; n++) {
            sb.append("?");
            if (n < paramCount) sb.append(",");
        }
        return sb.append(")}").toString();
	}
	
	/**
	 * @param datosNumeracionVO
	 * @throws ProductDomainException
	 */
	public DatosNumeracionDTO obtieneNumeracionAutomatica(DatosNumeracionDTO datosNumeracionVO) 
		throws ProductDomainException
	{
		Connection conn = null;
		CallableStatement cstmt = null;
		int codError = 0;
		String msgError = null;
		conn = getConection();
		int numEvento = 0;
		DatosNumeracionDTO resultado = new DatosNumeracionDTO();
		logger.info("obtieneNumeracionAutomatica():start");

			try {
				
				String call = getSQLDatos("VE_NUMERACION_PG","VE_NUMERACION_AUTOMATICA_PR",12);
				cstmt = conn.prepareCall(call);

				logger.info("SQL["+ call + "]");
				
				logger.info("Entrada en DAO:");
				logger.info("datosNumeracionVO.getCodCeldNue():"+datosNumeracionVO.getCodCeldNue());
				logger.info("datosNumeracionVO.getCodCentNue():"+datosNumeracionVO.getCodCentNue());
				logger.info("datosNumeracionVO.getCodCodUsoNue():"+datosNumeracionVO.getCodCodUsoNue());
				logger.info("datosNumeracionVO.getCodActabo():"+datosNumeracionVO.getCodActabo());
				
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

				logger.info(" Iniciando Ejecución");
				logger.info("Execute Antes");

				cstmt.execute();

				logger.info("Execute Despues");
				logger.info(" Finalizo ejecución");

				codError = cstmt.getInt(10);
				msgError = cstmt.getString(11);
				numEvento = cstmt.getInt(12);
				logger.info("codError[" + codError + "]");
				logger.info("msgError[" + msgError + "]");
				logger.info("numEvento[" + numEvento + "]");
				
				if (codError!=0) {
					
					cat.error("Ocurrió un error al obtener numeracion automatica");
					throw new ProductDomainException("Ocurrió un error al obtener numeracion automatica", String
									.valueOf(codError), numEvento, msgError);
				}				
				
				resultado.setCodSubalmNue(cstmt.getString(5));
				resultado.setNumCelular(new Long (cstmt.getLong(6)));
				resultado.setNomtabla(cstmt.getString(7));
				resultado.setCodCatNue(cstmt.getString(8));
				resultado.setFecBaja(cstmt.getString(9));
				
				logger.info("Salida en DAO:");
				logger.info("datosNumeracionVO.getCodSubalmNue():"+datosNumeracionVO.getCodSubalmNue());
				logger.info("datosNumeracionVO.getNumCelular():"+datosNumeracionVO.getNumCelular());
				logger.info("datosNumeracionVO.getNomtabla():"+datosNumeracionVO.getNomtabla());
				logger.info("datosNumeracionVO.getCodCatNue():"+datosNumeracionVO.getCodCatNue());
				logger.info("datosNumeracionVO.getFecBaja():"+datosNumeracionVO.getFecBaja());
			} catch (Exception e) {
				e.printStackTrace();	
				if (!(e instanceof ProductDomainException)) {				
					logger.error(global.getValor("ERR.0078"));
					logger.error(e);
					logger.error("Codigo de Error[" + codError + "]");
					logger.error("Mensaje de Error[" + msgError + "]");
					logger.error("Numero de Evento[" + numEvento + "]");
					throw new ProductDomainException("ERR.0078",78,global.getValor("ERR.0078"));
				}else throw (ProductDomainException)e;

			} finally {
				logger.info("Cerrando conexiones...");
				try {
					if (cstmt != null) 
						cstmt.close();
					if (conn != null && !conn.isClosed()) 
						conn.close();
				} catch (SQLException e) {
					logger.error("SQLException[" + e.getMessage() + "]", e);
				}
			}
			logger.info("obtieneNumeracionAutomatica():end");
			return resultado;
		}

	
	/**
	 * @param datosNumeracionVO
	 * @return
	 * @throws ProductDomainException
	 */
	public SeleccionNumeroCelularDTO[] obtieneNumeracionReutilizable(DatosNumeracionDTO datosNumeracionVO) 
		throws ProductDomainException
	{
		Connection conn = null;
		CallableStatement cstmt = null;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		ResultSet rs = null;
		conn = getConection();
		SeleccionNumeroCelularDTO[] arrayNumerosReutilizables = null;
		logger.info("obtieneNumeracionReutilizable():start");

			try {
			
				String call = getSQLDatos("VE_NUMERACION_PG","VE_NUMERACION_DISPONIBLE_PR",11);
				cstmt = conn.prepareCall(call);

				logger.info("SQL["+ call + "]");
				logger.info("Entrada en DAO:");
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

				cstmt.registerOutParameter(8, OracleTypes.CURSOR);
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
				
				if (codError!=0) {
					
					cat.error("Ocurrió un error al obtener numeracion reutilizable");
					throw new ProductDomainException("Ocurrió un error al obtener numeracion reutilizable", String
									.valueOf(codError), numEvento, msgError);
				}	
				
				rs = (ResultSet)cstmt.getObject(8);
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
			
			} catch (Exception e) {
				e.printStackTrace();	
				if (!(e instanceof ProductDomainException)) {				
					logger.error(global.getValor("ERR.0078"));
					logger.error(e);
					logger.error("Codigo de Error[" + codError + "]");
					logger.error("Mensaje de Error[" + msgError + "]");
					logger.error("Numero de Evento[" + numEvento + "]");
					throw new ProductDomainException("ERR.0078",78,global.getValor("ERR.0078"));
				}else throw (ProductDomainException)e;

			} finally {
				logger.info("Cerrando conexiones...");
				try {
					if (rs != null) 
						rs.close();
					if (cstmt != null) 
						cstmt.close();
					if (conn != null && !conn.isClosed()) 
						conn.close();
				} catch (SQLException e) {
					logger.error("SQLException[" + e.getMessage() + "]", e);
				}
			}
			logger.info("obtieneNumeracionReutilizable():end");
			datosNumeracionVO.setArrayNumerosReutilizables(arrayNumerosReutilizables);
			return arrayNumerosReutilizables;
		}
	/**
	 * @param datosNumeracionVO
	 * @return
	 * @throws ProductDomainException
	 */
	public SeleccionNumeroCelularDTO[] obtieneNumeracionReservada(DatosNumeracionDTO datosNumeracionVO) 
		throws ProductDomainException
	{
		Connection conn = null;
		CallableStatement cstmt = null;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		conn = getConection();
		ResultSet rs = null;
		SeleccionNumeroCelularDTO[] arrayNumerosReservados = null;
		logger.info("obtieneNumeracionReservada():start");

			try {
				
				String call = getSQLDatos("VE_NUMERACION_PG","VE_NUMERACION_RESERVA_PR",11);
				cstmt = conn.prepareCall(call);

				logger.info("SQL["+ call + "]");
				logger.info("Entrada en DAO:");
				logger.info("datosNumeracionVO.getCodCliente():"+datosNumeracionVO.getCodCliente());
				logger.info("datosNumeracionVO.getCodVendedor():"+datosNumeracionVO.getCodVendedor());
				logger.info("datosNumeracionVO.getCodCodUsoNue():"+datosNumeracionVO.getCodCodUsoNue());
				logger.info("datosNumeracionVO.getCodCatNue():"+datosNumeracionVO.getCodCatNue());
				logger.info("datosNumeracionVO.getCantidadMaximaNrosCelulares():"+datosNumeracionVO.getCantidadMaximaNrosCelulares());
				logger.info("datosNumeracionVO.getCodCentNue():"+datosNumeracionVO.getCodCentNue());
				
				cstmt.setLong(1,datosNumeracionVO.getCodCliente().longValue());
				cstmt.setLong(2,datosNumeracionVO.getCodVendedor().longValue());
				
				cstmt.setString(3,datosNumeracionVO.getCodCodUsoNue());
				cstmt.setString(4, datosNumeracionVO.getCodCatNue());
				cstmt.setBigDecimal(5,new BigDecimal(datosNumeracionVO.getCantidadMaximaNrosCelulares()));
				cstmt.setLong(6,datosNumeracionVO.getCodVendealer().longValue());
				cstmt.setString(7,datosNumeracionVO.getCodCentNue());				
				
				cstmt.registerOutParameter(8, OracleTypes.CURSOR);
				
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
				
				if (codError!=0) {
					
					cat.error("Ocurrió un error al obtener numeracion reservada");
					throw new ProductDomainException("Ocurrió un error al obtener numeracion reservada", String
									.valueOf(codError), numEvento, msgError);
				}	
				
				rs = (ResultSet)cstmt.getObject(8);
				ArrayList listadosNumeros = new ArrayList();
				//Obtener Datos desde el Cursor
				logger.info("Salida en DAO:");
				while(rs.next()){
					SeleccionNumeroCelularDTO NumerosReservados= new SeleccionNumeroCelularDTO();
					NumerosReservados.setNumCelular(new Long (rs.getLong(1)));
					NumerosReservados.setCodCategoria(rs.getString(2));
					listadosNumeros.add(NumerosReservados);
				}
				logger.info("Cantidad de nros reservados: "+listadosNumeros.size());
				arrayNumerosReservados = (SeleccionNumeroCelularDTO[])listadosNumeros.toArray(new SeleccionNumeroCelularDTO[listadosNumeros.size()]);
			
			
			} catch (Exception e) {
				e.printStackTrace();	
				if (!(e instanceof ProductDomainException)) {				
					logger.error(global.getValor("ERR.0078"));
					logger.error(e);
					logger.error("Codigo de Error[" + codError + "]");
					logger.error("Mensaje de Error[" + msgError + "]");
					logger.error("Numero de Evento[" + numEvento + "]");
					throw new ProductDomainException("ERR.0078",78,global.getValor("ERR.0078"));
				}else throw (ProductDomainException)e;

			} finally {
				logger.info("Cerrando conexiones...");
				try {
					if (rs != null) 
						rs.close();
					if (cstmt != null) 
						cstmt.close();
					if (conn != null && !conn.isClosed()) 
						conn.close();
				} catch (SQLException e) {
					logger.error("SQLException[" + e.getMessage() + "]", e);
				}
			}
			logger.info("obtieneNumeracionReservada():end");
			datosNumeracionVO.setArrayNumerosReservados(arrayNumerosReservados);
			return arrayNumerosReservados;
		}
	/**
	 * @param datosNumeracionVO
	 * @return
	 * @throws ProductDomainException
	 */
	public SeleccionNumeroCelularRangoDTO[] obtieneNumeracionRango(DatosNumeracionDTO datosNumeracionVO) 
		throws ProductDomainException
	{
		Connection conn = null;
		CallableStatement cstmt = null;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		ResultSet rs = null;
		SeleccionNumeroCelularRangoDTO[] arrayListaRangos= null;
		conn = getConection();
		logger.info("obtieneNumeracionRango():start");

			try {
				
				String call = getSQLDatos("VE_NUMERACION_PG","VE_NUMERACION_RANGO_PR",11);
				cstmt = conn.prepareCall(call);

				logger.info("SQL["+ call + "]");
				logger.info("Entrada en DAO:");
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
				cstmt.registerOutParameter(8,OracleTypes.CURSOR);
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
				
				if (codError!=0) {
					
					cat.error("Ocurrió un error al obtener numeracion rango");
					throw new ProductDomainException("Ocurrió un error al obtener numeracion rango", String
									.valueOf(codError), numEvento, msgError);
				}	
				
				//TODO: 09DIC2008 PF-PV-024 RQ Se cambia retorno para obtener un listado y no un solo registro
				ArrayList ListaNumerosRango = new ArrayList();
				rs = (ResultSet)cstmt.getObject(8);
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
			
			} catch (Exception e) {
				e.printStackTrace();	
				if (!(e instanceof ProductDomainException)) {				
					logger.error(global.getValor("ERR.0078"));
					logger.error(e);
					logger.error("Codigo de Error[" + codError + "]");
					logger.error("Mensaje de Error[" + msgError + "]");
					logger.error("Numero de Evento[" + numEvento + "]");
					throw new ProductDomainException("ERR.0078",78,global.getValor("ERR.0078"));
				}else throw (ProductDomainException)e;

			} finally {
				logger.info("Cerrando conexiones...");
				try {
					if (rs != null) 
						rs.close();
					if (cstmt != null) 
						cstmt.close();
					if (conn != null && !conn.isClosed()) 
						conn.close();
				} catch (SQLException e) {
					logger.error("SQLException[" + e.getMessage() + "]", e);
				}
			}
			logger.info("obtieneNumeracionRango():end");
			datosNumeracionVO.setArrayNumerosCelularRango(arrayListaRangos);
			return arrayListaRangos;
		}
	/**
	 * @param datosNumeracionVO
	 * @throws ProductDomainException
	 */
	public void obtieneSubalm(DatosNumeracionDTO datosNumeracionVO) 
		throws ProductDomainException
	{
		Connection conn = null;
		CallableStatement cstmt = null;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		conn = getConection();
		logger.info("obtieneSubalm():start");

			try {
				
				String call = getSQLDatos("VE_NUMERACION_PG","VE_BUSCA_SUBALM_PR",5);
				cstmt = conn.prepareCall(call);

				logger.info("SQL["+ call + "]");
				logger.info("Entrada en DAO:");
				logger.info("datosNumeracionVO.getCodCeldNue():"+datosNumeracionVO.getCodCeldNue());
				
				cstmt.setString(1,datosNumeracionVO.getCodCeldNue());
				cstmt.registerOutParameter(2, java.sql.Types.VARCHAR);
				cstmt.registerOutParameter(3,java.sql.Types.NUMERIC);
				cstmt.registerOutParameter(4,java.sql.Types.VARCHAR);
				cstmt.registerOutParameter(5,java.sql.Types.NUMERIC);

				logger.info(" Iniciando Ejecución");
				logger.info("Execute Antes");

				cstmt.execute();

				logger.info("Execute Despues");
				logger.info(" Finalizo ejecución");

				codError = cstmt.getInt(3);
				msgError = cstmt.getString(4);
				numEvento = cstmt.getInt(5);
				logger.info("codError[" + codError + "]");
				logger.info("msgError[" + msgError + "]");
				logger.info("numEvento[" + numEvento + "]");
				
				if (codError!=0) {
					
					cat.error("Ocurrió un error al obtener numeracion automatica");
					throw new ProductDomainException("Ocurrió un error al obtener numeracion automatica", String
									.valueOf(codError), numEvento, msgError);
				}	
				
				datosNumeracionVO.setCodSubalmNue(cstmt.getString(2));
				logger.info("Salida en DAO:");
				logger.info("datosNumeracionVO.getCodSubalmNue():"+datosNumeracionVO.getCodSubalmNue());
				
			} catch (Exception e) {
				e.printStackTrace();	
				if (!(e instanceof ProductDomainException)) {				
					logger.error(global.getValor("ERR.0078"));
					logger.error(e);
					logger.error("Codigo de Error[" + codError + "]");
					logger.error("Mensaje de Error[" + msgError + "]");
					logger.error("Numero de Evento[" + numEvento + "]");
					throw new ProductDomainException("ERR.0078",78,global.getValor("ERR.0078"));
				}else throw (ProductDomainException)e;

			} finally {
				logger.info("Cerrando conexiones...");
				try {
					if (cstmt != null) 
						cstmt.close();
					if (conn != null && !conn.isClosed()) 
						conn.close();
				} catch (SQLException e) {
					logger.error("SQLException[" + e.getMessage() + "]", e);
				}
			}
			logger.info("obtieneSubalm():end");
		}
	
	
	/**
	 * @param datosNumeracionVO
	 * @throws ProductDomainException
	 */
	public String[] obtieneCategoria(DatosNumeracionDTO datosNumeracionVO) 
		throws ProductDomainException
	{
		Connection conn = null;
		CallableStatement cstmt = null;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		conn = getConection();
		String[] arregloCategorias = null;
		logger.info("obtieneCategoria():start");

			try {
				
				String call = getSQLDatos("VE_NUMERACION_PG","VE_OBTIENE_CATEGORIA_PR",5);
				cstmt = conn.prepareCall(call);

				logger.info("SQL["+ call + "]");
				logger.info("Entrada en DAO:");
				logger.info("datosNumeracionVO.getCodActabo():"+datosNumeracionVO.getCodActabo());
				
				cstmt.setString(1,datosNumeracionVO.getCodActabo());
				
				//TODO: 11DIC2008 PF-PV-030 PF-PV-31 RE, RQ Se cambia retorno a arreglo
				cstmt.registerOutParameter(2, OracleTypes.CURSOR);
				//cstmt.registerOutParameter(2, java.sql.Types.VARCHAR);
				
				cstmt.registerOutParameter(3,java.sql.Types.NUMERIC);
				cstmt.registerOutParameter(4,java.sql.Types.VARCHAR);
				cstmt.registerOutParameter(5,java.sql.Types.NUMERIC);

				logger.info(" Iniciando Ejecución");
				logger.info("Execute Antes");

				cstmt.execute();

				logger.info("Execute Despues");
				logger.info(" Finalizo ejecución");

				codError = cstmt.getInt(3);
				msgError = cstmt.getString(4);
				numEvento = cstmt.getInt(5);
				logger.info("codError[" + codError + "]");
				logger.info("msgError[" + msgError + "]");
				logger.info("numEvento[" + numEvento + "]");
				
				if (codError!=0) {
					
					cat.error("Ocurrió un error al obtener numeracion automatica");
					throw new ProductDomainException("Ocurrió un error al obtener numeracion automatica", String
									.valueOf(codError), numEvento, msgError);
				}					
				
				
				//TODO: 11DIC2008 PF-PV-030 PF-PV-31 RE, RQ Se cambia retorno a arreglo
				//salida
				ResultSet rs = (ResultSet)cstmt.getObject(2);
				codError=1;
				int i=0;
				ArrayList arrayList = new ArrayList();
				while(rs.next()){
					
					arrayList.add(rs.getString(1));
					
					i++;
				}
				
				arregloCategorias = (String[])arrayList.toArray(new String[arrayList.size()]);
				
				logger.info("Salida en DAO:");
				logger.info("Nro de categorías: "+arregloCategorias.length);				
				
			} catch (Exception e) {
				e.printStackTrace();	
				if (!(e instanceof ProductDomainException)) {				
					logger.error(global.getValor("ERR.0078"));
					logger.error(e);
					logger.error("Codigo de Error[" + codError + "]");
					logger.error("Mensaje de Error[" + msgError + "]");
					logger.error("Numero de Evento[" + numEvento + "]");
					throw new ProductDomainException("ERR.0078",78,global.getValor("ERR.0078"));
				}else throw (ProductDomainException)e;

			} finally {
				logger.info("Cerrando conexiones...");
				try {
					if (cstmt != null) 
						cstmt.close();
					if (conn != null && !conn.isClosed()) 
						conn.close();
				} catch (SQLException e) {
					logger.error("SQLException[" + e.getMessage() + "]", e);
				}
			}
			logger.info("obtieneCategoria():end");
			return arregloCategorias;
		}	




	/**
	 * @param datosNumeracionVO
	 * @throws ProductDomainException
	 */
	public void verificaCentral(DatosNumeracionDTO datosNumeracionVO) 
		throws ProductDomainException
	{
		Connection conn = null;
		CallableStatement cstmt = null;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		conn = getConection();
		logger.info("obtieneSubalm():start");

		try {
			
			String call = getSQLDatos("VE_NUMERACION_PG","VE_BUSCA_CENTAL_PR",4);
			cstmt = conn.prepareCall(call);

			logger.info("SQL["+ call + "]");
			logger.info("Entrada en DAO:");
			logger.info("datosNumeracionVO.getCodCentNue():"+datosNumeracionVO.getCodCentNue());
			
			cstmt.setString(1,datosNumeracionVO.getCodCentNue());
			cstmt.registerOutParameter(2,java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(3,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(4,java.sql.Types.NUMERIC);

			logger.info(" Iniciando Ejecución");
			logger.info("Execute Antes");

			cstmt.execute();

			logger.info("Execute Despues");
			logger.info(" Finalizo ejecución");

			codError = cstmt.getInt(2);
			msgError = cstmt.getString(3);
			numEvento = cstmt.getInt(4);
			logger.info("codError[" + codError + "]");
			logger.info("msgError[" + msgError + "]");
			logger.info("numEvento[" + numEvento + "]");
			
			if (codError!=0) {
				
				cat.error("Ocurrió un error al obtener numeracion automatica");
				throw new ProductDomainException("Ocurrió un error al obtener numeracion automatica", String
								.valueOf(codError), numEvento, msgError);
			}	
			
		} catch (Exception e) {
			e.printStackTrace();	
			if (!(e instanceof ProductDomainException)) {				
				logger.error(global.getValor("ERR.0078"));
				logger.error(e);
				logger.error("Codigo de Error[" + codError + "]");
				logger.error("Mensaje de Error[" + msgError + "]");
				logger.error("Numero de Evento[" + numEvento + "]");
				throw new ProductDomainException("ERR.0078",78,global.getValor("ERR.0078"));
			}else throw (ProductDomainException)e;

		} finally {
			logger.info("Cerrando conexiones...");
			try {
				if (cstmt != null) 
					cstmt.close();
				if (conn != null && !conn.isClosed()) 
					conn.close();
			} catch (SQLException e) {
				logger.error("SQLException[" + e.getMessage() + "]", e);
			}
		}
		logger.info("obtieneSubalm():end");
	}
		
		
	/**
	 * La capa de negocio efectua una consulta la tabla GA_CELNUM_REUTIL
	 * PACKAGE: PV_NUMERACION_PG
	 * PROCEDIMIENTO: PV_CONS_NUM_CEL_REUTIL_PR
	 * @param numeracionCelularVO
	 * @throws ProductDomainException
	 * 07/10/2008 15:42:23
	 * @author Santiago Ventura
	 */
	public void consultaNumeroCelularReutilizable(NumeracionCelularDTO numeracionCelularVO) 
		throws ProductDomainException
	{
		Connection conn = null;
		CallableStatement cstmt = null;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		conn = getConection();
		logger.debug("consultaNumeroCelularReutilizable:start");
	    try {
	    	
			
			String call = getSQLDatos("VE_NUMERACION_PG","VE_CONS_NUM_CEL_REUTIL_PR", 11);
			cstmt = conn.prepareCall(call);
			
			logger.info("SQL["+ call + "]");
			logger.info("Entrada en DAO:");
			logger.info("numeracionCelularVO.getNumCelular():"+numeracionCelularVO.getNumCelular());
			
			//EN_NUM_CELULAR        IN GA_CELNUM_REUTIL.NUM_CELULAR%TYPE,
			cstmt.setLong(1, numeracionCelularVO.getNumCelular().longValue());
			//SV_COD_SUBALM         OUT GA_CELNUM_REUTIL.COD_SUBALM%TYPE,
			cstmt.registerOutParameter(2, java.sql.Types.VARCHAR);
			//SN_COD_PRODUCTO       OUT GA_CELNUM_REUTIL.COD_PRODUCTO%TYPE,
			cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
			//SN_COD_CENTRAL        OUT GA_CELNUM_REUTIL.COD_CENTRAL%TYPE,
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);
			//SN_COD_CAT            OUT GA_CELNUM_REUTIL.COD_CAT%TYPE,
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);
			//SN_COD_USO            OUT GA_CELNUM_REUTIL.COD_USO%TYPE,
			cstmt.registerOutParameter(6, java.sql.Types.NUMERIC);
			//SN_IND_EQUIPADO       OUT GA_CELNUM_REUTIL.IND_EQUIPADO%TYPE,
			cstmt.registerOutParameter(7, java.sql.Types.NUMERIC);
			//SN_USO_ANTERIOR       OUT GA_CELNUM_REUTIL.USO_ANTERIOR%TYPE,
			cstmt.registerOutParameter(8, java.sql.Types.NUMERIC);
			
			cstmt.registerOutParameter(9, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(10, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(11, java.sql.Types.NUMERIC);
			
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
			
			//daoHelper.evaluaResultado("ERR.0711",codError,	global.getValor("ERR.0711"));
			
			numeracionCelularVO.setCodSubALM(cstmt.getString(2));
			numeracionCelularVO.setCodProducto(new Long(cstmt.getLong(3)));
			numeracionCelularVO.setCodCentral(String.valueOf(cstmt.getLong(4)));
			numeracionCelularVO.setCodCat(String.valueOf(cstmt.getLong(5)));
			numeracionCelularVO.setCodUso(String.valueOf(cstmt.getLong(6)));
			numeracionCelularVO.setIndEquipado(new Long(cstmt.getLong(7)));
			numeracionCelularVO.setUsoAnterior(new Long(cstmt.getLong(8)));
			numeracionCelularVO.setIndEnvioCentral(new Long(cstmt.getLong(9)));
			//TODO: 12DIC2008 PF-PV-032 y PF-PV-033 SV/RQ Se controla que el número no esta en la tabla de números reutilizables
			if(codError==0)
				numeracionCelularVO.setNombreTabla(global.getValor("NC.NombreTabla.R.SRV"));
			
			logger.info("Salida en DAO:");
			logger.info("numeracionCelularVO.getCodSubALM():"+numeracionCelularVO.getCodSubALM());
			logger.info("numeracionCelularVO.getCodProducto():"+numeracionCelularVO.getCodProducto());
			logger.info("numeracionCelularVO.getCodCentral():"+numeracionCelularVO.getCodCentral());
			logger.info("numeracionCelularVO.getCodCat():"+numeracionCelularVO.getCodCat());
			logger.info("numeracionCelularVO.getCodUso():"+numeracionCelularVO.getCodUso());
			logger.info("numeracionCelularVO.getIndEquipado():"+numeracionCelularVO.getIndEquipado());
			logger.info("numeracionCelularVO.getUsoAnterior():"+numeracionCelularVO.getUsoAnterior());
			logger.info("numeracionCelularVO.getIndEnvioCentral():"+numeracionCelularVO.getIndEnvioCentral());
			logger.info("numeracionCelularVO.getNombreTabla():"+numeracionCelularVO.getNombreTabla());
	 	} catch (Exception e) {
	 		if (!(e instanceof ProductDomainException)) {
				logger.error(global.getValor("ERR.0078"),e);
				logger.debug("Codigo de Error[" + codError + "]");
				logger.debug("Mensaje de Error[" + msgError + "]");
				logger.debug("Numero de Evento[" + numEvento + "]");
				throw new ProductDomainException("ERR_0078",78,global.getValor("ERR.0078"));
	 		}else throw (ProductDomainException)e;
	 	} finally {
			if (logger.isDebugEnabled()) {
				logger.debug("Cerrando conexiones...");
			}
			try {
				if (cstmt != null)cstmt.close();
				if (conn != null && !conn.isClosed())conn.close();
			} catch (SQLException e) {
				logger.error("SQLException[" + e + "]");
			}
		}
		logger.debug("consultaNumeroCelularReutilizable:end");
		
	}



	/**
	 * La capa de negocio efectua una consulta la tabla GA_RESNUMCEL
	 * PACKAGE: PV_NUMERACION_PG
	 * PROCEDIMIENTO: PV_CONS_NUM_CEL_RESERVADO_PR
	 * @param numeracionCelularVO
	 * @throws ProductDomainException
	 * 07/10/2008 15:42:21
	 * @author Santiago Ventura
	 */
	public void consultaNumeroCelularReservado(NumeracionCelularDTO numeracionCelularVO) 
		throws ProductDomainException
	{
		Connection conn = null;
		CallableStatement cstmt = null;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		conn = getConection();
		logger.debug("consultaNumeroCelularReservado:start");
	    try {
	    	
			String call = getSQLDatos("VE_NUMERACION_PG","VE_CONS_NUM_CEL_RESERVADO_PR", 10);
			cstmt = conn.prepareCall(call);
			
			logger.info("SQL["+ call + "]");
			logger.info("Entrada en DAO:");
			logger.info("numeracionCelularVO.getNumCelular():"+numeracionCelularVO.getNumCelular());
			
			//EN_NUM_CELULAR        IN GA_RESNUMCEL.NUM_CELULAR%TYPE,
			cstmt.setLong(1, numeracionCelularVO.getNumCelular().longValue());
			//SV_COD_SUBALM         OUT GA_RESNUMCEL.COD_SUBALM%TYPE,
			cstmt.registerOutParameter(2, java.sql.Types.VARCHAR);
			//SN_COD_PRODUCTO       OUT GA_RESNUMCEL.COD_PRODUCTO%TYPE,
			cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
			//SN_COD_CENTRAL        OUT GA_RESNUMCEL.COD_CENTRAL%TYPE,
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);
			//SN_COD_CAT            OUT GA_RESNUMCEL.COD_CAT%TYPE,
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);
			//SN_COD_USO            OUT GA_RESNUMCEL.COD_USO%TYPE,	
			cstmt.registerOutParameter(6, java.sql.Types.NUMERIC);
			//SV_IND_PROCNUM 		OUT GA_RESNUMCEL.IND_PROCNUM%TYPE,	
			cstmt.registerOutParameter(7, java.sql.Types.VARCHAR);
			
			cstmt.registerOutParameter(8, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(9, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(10, java.sql.Types.NUMERIC);
			
			logger.info(" Iniciando Ejecución");
			logger.info("Execute Antes");

			cstmt.execute();

			logger.info("Execute Despues");
			logger.info(" Finalizo ejecución");			
			codError = cstmt.getInt(8);
			msgError = cstmt.getString(9);
			numEvento = cstmt.getInt(10);
			logger.info("codError[" + codError + "]");
			logger.info("msgError[" + msgError + "]");
			logger.info("numEvento[" + numEvento + "]");
			
			if (codError!=0) {
				
				cat.error("Ocurrió un error al obtener numeracion automatica");
				throw new ProductDomainException("Ocurrió un error al obtener numeracion automatica", String
								.valueOf(codError), numEvento, msgError);
			}	
			
			numeracionCelularVO.setCodSubALM(cstmt.getString(2));
			numeracionCelularVO.setCodProducto(new Long(cstmt.getLong(3)));
			numeracionCelularVO.setCodCentral(String.valueOf(cstmt.getLong(4)));
			numeracionCelularVO.setCodCat(String.valueOf(cstmt.getLong(5)));
			numeracionCelularVO.setCodUso(String.valueOf(cstmt.getLong(6)));
			numeracionCelularVO.setIndProcNum(cstmt.getString(7));
			numeracionCelularVO.setNombreTabla(cstmt.getString(7));
			logger.info("Salida en DAO:");
			logger.info("numeracionCelularVO.getCodSubALM():"+numeracionCelularVO.getCodSubALM());
			logger.info("numeracionCelularVO.getCodProducto():"+numeracionCelularVO.getCodProducto());
			logger.info("numeracionCelularVO.getCodCentral():"+numeracionCelularVO.getCodCentral());
			logger.info("numeracionCelularVO.getCodCat():"+numeracionCelularVO.getCodCat());
			logger.info("numeracionCelularVO.getCodUso():"+numeracionCelularVO.getCodUso());
			logger.info("numeracionCelularVO.getIndProcNum():"+numeracionCelularVO.getIndProcNum());
			logger.info("numeracionCelularVO.getNombreTabla():"+numeracionCelularVO.getNombreTabla());
			
	 	} catch (Exception e) {
	 		logger.error(e);
	 		if (!(e instanceof ProductDomainException)) {
				logger.error(global.getValor("ERR.0078"),e);
				logger.debug("Codigo de Error[" + codError + "]");
				logger.debug("Mensaje de Error[" + msgError + "]");
				logger.debug("Numero de Evento[" + numEvento + "]");
				throw new ProductDomainException("ERR_0078",78,global.getValor("ERR.0078"));
	 		}else throw (ProductDomainException)e;
	 	} finally {
			if (logger.isDebugEnabled()) {
				logger.debug("Cerrando conexiones...");
			}
			try {
				if (cstmt != null)cstmt.close();
				if (conn != null && !conn.isClosed())conn.close();
			} catch (SQLException e) {
				logger.error("SQLException[" + e + "]");
			}
		}
		logger.debug("consultaNumeroCelularReservado:end");			
	}



	/**
	 * PACKAGE: PV_NUMERACION_PG
	 * PROCEDIMIENTO: PV_P_NUMERACION_MANUAL_PR
	 * @param numeracionCelularVO
	 * @throws ProductDomainException
	 * 07/10/2008 15:42:17
	 * @author Santiago Ventura
	 */
	public void reservaNumeroCelular(NumeracionCelularDTO numeracionCelularVO) 
		throws ProductDomainException
	{
		logger.debug("reservaNumeroCelular:start()");
		Connection conn = null;
		CallableStatement cstmt = null;
		int codError = 0;
		String msgError = null;
		conn = getConection();
		int numEvento = 0;

		try {
			
			//String call = ("{call P_NUMERACION_MANUAL(?,?,?,?,?,?,?)}");		
			String call = getSQLDatos("VE_NUMERACION_PG","VE_P_NUMERACION_MANUAL_PR", 10);
			cstmt = conn.prepareCall(call);
			logger.info("SQL["+ call + "]");
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
			
			logger.info(" Iniciando Ejecución");
			logger.info("Execute Antes");
			cstmt.execute();
			logger.info("Execute Despues");
			logger.info(" Finalizo ejecución");
			
			codError = cstmt.getInt(8);
			msgError = cstmt.getString(9);
			numEvento = cstmt.getInt(10);
			logger.info("codError[" + codError + "]");
			logger.info("msgError[" + msgError + "]");
			logger.info("numEvento[" + numEvento + "]");
			
			if (codError!=0) {
				
				cat.error("Ocurrió un error al reservar numero de celular");
				throw new ProductDomainException("Ocurrió un error al reservar numero de celular", String
								.valueOf(codError), numEvento, msgError);
			}	

			
		} catch (Exception e) {
			e.printStackTrace();	
			if (!(e instanceof ProductDomainException)) {				
				logger.error(global.getValor("ERR.0078"));
				logger.error(e);
				logger.error("Codigo de Error[" + codError + "]");
				logger.error("Mensaje de Error[" + msgError + "]");
				logger.error("Numero de Evento[" + numEvento + "]");
				throw new ProductDomainException("ERR.0078", 78, global.getValor("ERR.0078"));
			}else throw (ProductDomainException)e;
		} finally {
			logger.info("Cerrando conexiones...");
			try {
				if (cstmt != null) 
					cstmt.close();
				if (conn != null && !conn.isClosed()) 
					conn.close();
			} catch (SQLException e) {
				logger.error("SQLException[" + e.getMessage() + "]", e);
			}
		}
		logger.debug("reservaNumeroCelular:end()");				
	}



	/**
	 * La capa de negocio hace un insert en la tabla GA_RESNUMCEL
	 * PACKAGE: PV_NUMERACION_PG
	 * PROCEDIMIENTO: PV_INS_NUM_CEL_RESERVADO_PR
	 * @param numeracionCelularVO
	 * @throws ProductDomainException
	 * 07/10/2008 15:42:14
	 * @author Santiago Ventura
	 */
	public void insertarNumeroCelularReservado(NumeracionCelularDTO numeracionCelularVO) 
		throws ProductDomainException
	{
		Connection conn = null;
		CallableStatement cstmt = null;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		conn = getConection();
		logger.debug("insertarNumeroCelularReservado:start");
	    try {
	    	
			String call = getSQLDatos("VE_NUMERACION_PG","VE_INS_NUM_CEL_RESERVADO_PR", 15);
			cstmt = conn.prepareCall(call);
			
			logger.info("SQL["+ call + "]");
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
			
			logger.info(" Iniciando Ejecución");
			logger.info("Execute Antes");

			cstmt.execute();

			logger.info("Execute Despues");
			logger.info(" Finalizo ejecución");
			
			codError = cstmt.getInt(13);
			msgError = cstmt.getString(14);
			numEvento = cstmt.getInt(15);
			logger.info("codError[" + codError + "]");
			logger.info("msgError[" + msgError + "]");
			logger.info("numEvento[" + numEvento + "]");
			
			if (codError!=0) {
				
				cat.error("Ocurrió un error al reservar numero de celular");
				throw new ProductDomainException("Ocurrió un error al reservar numero de celular", String
								.valueOf(codError), numEvento, msgError);
			}	
						
	 	} catch (Exception e) {
	 		e.printStackTrace();
	 		if (!(e instanceof ProductDomainException)) {
				logger.error(global.getValor("ERR.0078"),e);
				logger.debug("Codigo de Error[" + codError + "]");
				logger.debug("Mensaje de Error[" + msgError + "]");
				logger.debug("Numero de Evento[" + numEvento + "]");
				throw new ProductDomainException("ERR_0078",78,global.getValor("ERR.0078"));
	 		}else throw (ProductDomainException)e;
	 	} finally {
			if (logger.isDebugEnabled()) {
				logger.debug("Cerrando conexiones...");
			}
			try {
				if (cstmt != null)cstmt.close();
				if (conn != null && !conn.isClosed())conn.close();
			} catch (SQLException e) {
				logger.error("SQLException[" + e + "]");
			}
		}
		logger.debug("insertarNumeroCelularReservado:end");		
	}



	/**
	 * La capa de negocio efectua una consulta la tabla GA_HRESERVA.
	 * Validar la existencia de un número celular.
	 * PACKAGE: PV_NUMERACION_PG
	 * PROCEDIMIENTO: PV_CONS_NUM_CEL_GA_HRESERVA_PR 
	 * @param numeracionCelularVO
	 * @throws ProductDomainException
	 * 07/10/2008 15:42:12
	 * @author Santiago Ventura
	 */
	public void consultaNumeroCelularHReservado(NumeracionCelularDTO numeracionCelularVO)
		throws ProductDomainException
	{
		Connection conn = null;
		CallableStatement cstmt = null;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		conn = getConection();
		logger.debug("consultaNumeroCelularHReservado:start");
	    try {
	    	
			
			String call = getSQLDatos("VE_NUMERACION_PG","VE_CONS_NUM_CEL_GA_HRESERVA_PR", 5);
			cstmt = conn.prepareCall(call);
			
			logger.info("SQL["+ call + "]");
			logger.info("Entrada en DAO:");
			logger.info("numeracionCelularVO.getNumCelular():"+numeracionCelularVO.getNumCelular());
			//EN_NUM_CELULAR        IN GA_HRESERVA.NUM_CELULAR%TYPE,
			cstmt.setLong(1, numeracionCelularVO.getNumCelular().longValue());
			//SN_NUM_CELULAR        OUT GA_HRESERVA.NUM_CELULAR%TYPE,
			cstmt.registerOutParameter(2, java.sql.Types.NUMERIC);
			
			cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);
			
			logger.info(" Iniciando Ejecución");
			logger.info("Execute Antes");

			cstmt.execute();

			logger.info("Execute Despues");
			logger.info(" Finalizo ejecución");			
			codError = cstmt.getInt(3);
			msgError = cstmt.getString(4);
			numEvento = cstmt.getInt(5);
			logger.info("codError[" + codError + "]");
			logger.info("msgError[" + msgError + "]");
			logger.info("numEvento[" + numEvento + "]");
			
			if (codError!=0) {
				
				cat.error("Ocurrió un error al reservar numero de celular");
				throw new ProductDomainException("Ocurrió un error al reervar numero de celular", String
								.valueOf(codError), numEvento, msgError);
			}	
			
			numeracionCelularVO.setNumCelular(new Long(cstmt.getLong(2)));
			logger.info("Salida en DAO:");
			logger.info("numeracionCelularVO.getNumCelular():"+numeracionCelularVO.getNumCelular());
			
	 	} catch (Exception e) {
	 		if (!(e instanceof ProductDomainException)) {
				logger.error(global.getValor("ERR.0078"),e);
				logger.debug("Codigo de Error[" + codError + "]");
				logger.debug("Mensaje de Error[" + msgError + "]");
				logger.debug("Numero de Evento[" + numEvento + "]");
				throw new ProductDomainException("ERR_0078",78,global.getValor("ERR.0078"));
	 		}else throw (ProductDomainException)e;
	 	} finally {
			if (logger.isDebugEnabled()) {
				logger.debug("Cerrando conexiones...");
			}
			try {
				if (cstmt != null)cstmt.close();
				if (conn != null && !conn.isClosed())conn.close();
			} catch (SQLException e) {
				logger.error("SQLException[" + e + "]");
			}
		}
		logger.debug("consultaNumeroCelularHReservado:end");
	}



	/**
	 * PACKAGE: PV_NUMERACION_PG
	 * PROCEDIMIENTO: PV_P_REPONER_NUMERACION_PR
	 * @param numeracionCelularVO
	 * @throws ProductDomainException
	 * 07/10/2008 15:42:10
	 * @author Santiago Ventura
	 */
	public void reponerNumeracion(NumeracionCelularDTO numeracionCelularVO) 
		throws ProductDomainException 
	{
		logger.debug("reponerNumeracion:start()");
		Connection conn = null;
		CallableStatement cstmt = null;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		conn = getConection();
		try {
			
			String call = getSQLDatos("VE_NUMERACION_PG","VE_P_REPONER_NUMERACION_PR", 9);
			//String call = ("{call P_REPONER_NUMERACION(?,?,?,?,?,?,?,?)}");			
			cstmt = conn.prepareCall(call);
			logger.info("SQL["+ call + "]");
			logger.info("Entrada en DAO:");
			logger.info("numeracionCelularVO.getNombreTabla():"+numeracionCelularVO.getNombreTabla());
			logger.info("numeracionCelularVO.getCodSubALM():"+numeracionCelularVO.getCodSubALM());
			logger.info("numeracionCelularVO.getCodCentral():"+numeracionCelularVO.getCodCentral());
			logger.info("numeracionCelularVO.getCodCat():"+numeracionCelularVO.getCodCat());
			logger.info("numeracionCelularVO.getCodUso():"+numeracionCelularVO.getCodUso());
			logger.info("numeracionCelularVO.getNumCelular():"+numeracionCelularVO.getNumCelular());
			
			//VP_TABLA IN VARCHAR2 ,
			cstmt.setString(1, numeracionCelularVO.getNombreTabla());
			//VP_SUBALM IN VARCHAR2 ,
			cstmt.setString(2, numeracionCelularVO.getCodSubALM());
			//VP_CENTRAL IN VARCHAR2 ,
			cstmt.setString(3, numeracionCelularVO.getCodCentral());
			//VP_CAT IN VARCHAR2 ,
			cstmt.setString(4, numeracionCelularVO.getCodCat());
			//VP_USO IN VARCHAR2 ,
			cstmt.setString(5, numeracionCelularVO.getCodUso());
			//VP_CELULAR IN VARCHAR2 ,
			cstmt.setString(6, String.valueOf(numeracionCelularVO.getNumCelular().longValue()));
			//VP_FECBAJA IN VARCHAR2			
		    //Calendar cal = Calendar.getInstance();
		    //SimpleDateFormat sdf = new SimpleDateFormat(global.getValorExterno("AAS.formato.fecha.SRV"));		    		    
			//cstmt.setString(7, sdf.format(cal.getTime()));
			
			cstmt.registerOutParameter(7, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(8, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(9, java.sql.Types.NUMERIC);
			
			logger.info(" Iniciando Ejecución");
			logger.info("Execute Antes");
			cstmt.execute();
			logger.info("Execute Despues");
			logger.info(" Finalizo ejecución");
			
			codError = cstmt.getInt(7);
			msgError = cstmt.getString(8);
			numEvento = cstmt.getInt(9);
			logger.info("codError[" + codError + "]");
			logger.info("msgError[" + msgError + "]");
			logger.info("numEvento[" + numEvento + "]");			
			
			if (codError!=0) {
				
				cat.error("Ocurrió un error al reservar numero de celular");
				throw new ProductDomainException("Ocurrió un error al reervar numero de celular", String
								.valueOf(codError), numEvento, msgError);
			}		
			
		} catch (Exception e) {
			e.printStackTrace();	
			if (!(e instanceof ProductDomainException)) {				
				logger.error(global.getValor("ERR.0078"));
				logger.error(e);
				logger.error("Codigo de Error[" + codError + "]");
				logger.error("Mensaje de Error[" + msgError + "]");
				logger.error("Numero de Evento[" + numEvento + "]");
				throw new ProductDomainException("ERR.0078", 78, global.getValor("ERR.0078"));
			}else throw (ProductDomainException)e;
		} finally {
			logger.info("Cerrando conexiones...");
			try {
				if (cstmt != null) 
					cstmt.close();
				if (conn != null && !conn.isClosed()) 
					conn.close();
			} catch (SQLException e) {
				logger.error("SQLException[" + e.getMessage() + "]", e);
			}
		}
		logger.debug("reponerNumeracion:end()");		
	}



	/**
	 * La capa de negocio efectua la desreserva de un numero celular. Haciendo un DELETE a la tabla GA_RESNUMCEL
	 * PACKAGE: PV_NUMERACION_PG
	 * PROCEDIMIENTO: PV_DEL_NUM_CEL_RESERVADO_PR 
	 * @param numeracionCelularVO
	 * @throws ProductDomainException
	 * 07/10/2008 15:42:07
	 * @author Santiago Ventura
	 */
	public void desReservaNumeroCelular(NumeracionCelularDTO numeracionCelularVO) 
		throws ProductDomainException
	{
		Connection conn = null;
		CallableStatement cstmt = null;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		logger.debug("desReservaNumeroCelular:start");
		conn = getConection();
		try {
	    	
			
			String call = getSQLDatos("VE_NUMERACION_PG","VE_DEL_NUM_CEL_RESERVADO_PR", 4);
			cstmt = conn.prepareCall(call);
			logger.info("SQL["+ call + "]");
			logger.info("Entrada en DAO:");
			logger.info("numeracionCelularVO.getNumCelular():"+numeracionCelularVO.getNumCelular());
			//EN_NUM_CELULAR        IN GA_RESNUMCEL.NUM_CELULAR%TYPE,
			cstmt.setLong(1, numeracionCelularVO.getNumCelular().longValue());									
			cstmt.registerOutParameter(2, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);
			
			logger.info(" Iniciando Ejecución");
			logger.info("Execute Antes");

			cstmt.execute();

			logger.info("Execute Despues");
			logger.info(" Finalizo ejecución");
			
			codError = cstmt.getInt(2);
			msgError = cstmt.getString(3);
			numEvento = cstmt.getInt(4);
			logger.info("codError[" + codError + "]");
			logger.info("msgError[" + msgError + "]");
			logger.info("numEvento[" + numEvento + "]");
			
			if (codError!=0) {
				
				cat.error("Ocurrió un error al eliminar la reserva numero de celular");
				throw new ProductDomainException("Ocurrió un error al eliminar la reserva numero de celular", String
								.valueOf(codError), numEvento, msgError);
			}	

	 	} catch (Exception e) {
	 		if (!(e instanceof ProductDomainException)) {
				logger.error(global.getValor("ERR.0078"),e);
				logger.debug("Codigo de Error[" + codError + "]");
				logger.debug("Mensaje de Error[" + msgError + "]");
				logger.debug("Numero de Evento[" + numEvento + "]");
				throw new ProductDomainException("ERR_0078",78,global.getValor("ERR.0078"));
	 		}else throw (ProductDomainException)e;
	 	} finally {
			if (logger.isDebugEnabled()) {
				logger.debug("Cerrando conexiones...");
			}
			try {
				if (cstmt != null)cstmt.close();
				if (conn != null && !conn.isClosed())conn.close();
			} catch (SQLException e) {
				logger.error("SQLException[" + e + "]");
			}
		}
		logger.debug("desReservaNumeroCelular:end");						
	}
	
	/**
	 * La capa de negocio obtiene el código de error y su descripción luego de la ejecución del , a través de una consulta a la BD SCL.
	 * Tabla GA_TRANSACABO
	 * PACKAGE: PV_NUMERACION_PG
	 * PROCEDIMIENTO: PV_CONS_GA_TRANSACABO_PR
	 * @param ooSSBajaPuntualPrepagoVO
	 * 15/09/2008 16:15:51
	 * @author Santiago Ventura
	 */
	public void consultaTransaccionGATRANSACABO(NumeracionCelularDTO numeracionCelularVO)
		throws ProductDomainException 
	{
		Connection conn = null;
		CallableStatement cstmt = null;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		logger.debug("consultaTransaccionGATRANSACABO:start");
		conn = getConection();
		try {
	    	
			String call = getSQLDatos("VE_NUMERACION_PG","VE_CONS_GA_TRANSACABO_PR", 6);
			cstmt = conn.prepareCall(call);
			
			logger.info("SQL["+ call + "]");
			logger.info("Entrada en DAO:");
			logger.info("numeracionCelularVO.getSecuencia():"+numeracionCelularVO.getSecuencia());
			//EN_NUM_TRANSACCION    IN    GA_TRANSACABO.NUM_TRANSACCION%TYPE,
			cstmt.setLong(1, new Long(numeracionCelularVO.getSecuencia()).longValue());
			//SN_COD_RETORNO_TRANS  OUT NOCOPY GA_TRANSACABO.COD_RETORNO%TYPE,
			cstmt.registerOutParameter(2, java.sql.Types.NUMERIC);
			//SV_DES_CADENA_TRANS      OUT NOCOPY  GA_TRANSACABO.DES_CADENA%TYPE,
			cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
			
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(5, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(6, java.sql.Types.NUMERIC);
			
			logger.info(" Iniciando Ejecución");
			logger.info("Execute Antes");

			cstmt.execute();

			logger.info("Execute Despues");
			logger.info(" Finalizo ejecución");
			
			codError = cstmt.getInt(4);
			msgError = cstmt.getString(5);
			numEvento = cstmt.getInt(6);
			logger.info("codError[" + codError + "]");
			logger.info("msgError[" + msgError + "]");
			logger.info("numEvento[" + numEvento + "]");						
			
			int codRetorno = cstmt.getInt(2);
			if (codRetorno!=0) {
				if (codError!=0) {
					
					cat.error("Ocurrió un error al reservar numero de celular");
					throw new ProductDomainException("Ocurrió un error al reervar numero de celular", String
									.valueOf(codError), numEvento, msgError);
				}	
			}
			
			numeracionCelularVO.setCodRetornoTrans(new Long(cstmt.getLong(2)));
			numeracionCelularVO.setDesCadenaTrans(cstmt.getString(3));
			logger.info("Salida en DAO:");
			logger.info("numeracionCelularVO.getCodRetornoTrans():"+numeracionCelularVO.getCodRetornoTrans());
			logger.info("numeracionCelularVO.getDesCadenaTrans():"+numeracionCelularVO.getDesCadenaTrans());
			
	 	} catch (Exception e) {
	 		if (!(e instanceof ProductDomainException)) {
				logger.error(global.getValor("ERR.0078"),e);
				logger.debug("Codigo de Error[" + codError + "]");
				logger.debug("Mensaje de Error[" + msgError + "]");
				logger.debug("Numero de Evento[" + numEvento + "]");
				throw new ProductDomainException("ERR_0078",78,global.getValor("ERR.0078"));
	 		}else throw (ProductDomainException)e;
	 	} finally {
			if (logger.isDebugEnabled()) {
				logger.debug("Cerrando conexiones...");
			}
			try {
				if (cstmt != null)cstmt.close();
				if (conn != null && !conn.isClosed())conn.close();
			} catch (SQLException e) {
				logger.error("SQLException[" + e + "]");
			}
		}
		logger.debug("consultaTransaccionGATRANSACABO:end");		
	}
	
	
	
    //TODO: 15DIC2008 BUG PF-PV-034, Se agregan atributos para recuperar los valores de la tabla GA_RESERVA(Se modifica el metodo).
	/**
	 * La capa de negocio efectua una consulta la tabla GA_RESERVA.
	 * Consulta los datos sobre la tabla GA_RESERVA
	 * PACKAGE: PV_NUMERACION_PG
	 * PROCEDIMIENTO: PV_CONS_NUM_CEL_GA_RESERVA_PR 
	 * @param numeracionCelularVO
	 * @throws ProductDomainException
	 * 07/10/2008 15:42:12
	 * @author Santiago Ventura (V1) / Rodrigo Espinoza (V2)
	 */
	public void consultaNumeroCelularGAReservado(NumeracionCelularDTO numeracionCelularVO) 
		throws ProductDomainException
	{
		Connection conn = null;
		CallableStatement cstmt = null;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		conn = getConection();
		logger.debug("consultaNumeroCelularGAReservado:start");
	    try {	    	
	    	conn = getConection();
			String call = getSQLDatos("VE_NUMERACION_PG","VE_CONS_NUM_CEL_GA_RESERVA_PR", 17);
			cstmt = conn.prepareCall(call);
			
			logger.info("SQL["+ call + "]");
			logger.info("Entrada en DAO:");
			logger.info("numeracionCelularVO.getNumCelular():"+numeracionCelularVO.getNumCelular());
			
			//Entrada:
			//EN_NUM_CELULAR        IN GA_HRESERVA.NUM_CELULAR%TYPE,
			cstmt.setLong(1, numeracionCelularVO.getNumCelular().longValue());
			
			
			//Salida:
			//SN_COD_CLIENTE
			cstmt.registerOutParameter(2, java.sql.Types.NUMERIC);
			//SN_COD_VENDEDOR
			cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
			//SV_ORIGEN
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			//SD_FEC_RESERVA
			cstmt.registerOutParameter(5, java.sql.Types.VARCHAR);
			//SV_COD_SUBALM
			cstmt.registerOutParameter(6, java.sql.Types.VARCHAR);
			//SN_COD_PRODUCTO
			cstmt.registerOutParameter(7, java.sql.Types.NUMERIC);
			//SN_COD_CENTRAL
			cstmt.registerOutParameter(8, java.sql.Types.NUMERIC);
			//SN_COD_CAT
			cstmt.registerOutParameter(9, java.sql.Types.NUMERIC);
			//SN_COD_USO
			cstmt.registerOutParameter(10, java.sql.Types.NUMERIC);
			//SD_FEC_BAJA
			cstmt.registerOutParameter(11, java.sql.Types.VARCHAR);
			//SN_IND_EQUIPADO
			cstmt.registerOutParameter(12, java.sql.Types.NUMERIC);
			//SN_USO_ANTERIOR
			cstmt.registerOutParameter(13, java.sql.Types.NUMERIC);
			//SN_COD_VENDEALER
			cstmt.registerOutParameter(14, java.sql.Types.NUMERIC);


			//Error:
			cstmt.registerOutParameter(15, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(16, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(17, java.sql.Types.NUMERIC);
			
			logger.info(" Iniciando Ejecución");
			logger.info("Execute Antes");

			cstmt.execute();

			logger.info("Execute Despues");
			logger.info(" Finalizo ejecución");			
			codError = cstmt.getInt(15);
			msgError = cstmt.getString(16);
			numEvento = cstmt.getInt(17);
			logger.info("codError[" + codError + "]");
			logger.info("msgError[" + msgError + "]");
			logger.info("numEvento[" + numEvento + "]");
			
			//Salida:
			numeracionCelularVO.setCodCliente(new Long(cstmt.getLong(2)));
			numeracionCelularVO.setCodVendedor(new Long(cstmt.getLong(3)));
			numeracionCelularVO.setOrigen(cstmt.getString(4));
			numeracionCelularVO.setFecReserva(cstmt.getString(5));
			numeracionCelularVO.setCodSubALM(cstmt.getString(6));
			numeracionCelularVO.setCodProducto(new Long(cstmt.getLong(7)));
			numeracionCelularVO.setCodCentral(cstmt.getString(8));
			numeracionCelularVO.setCodCat(cstmt.getString(9));
			numeracionCelularVO.setCodUso(cstmt.getString(10));
			numeracionCelularVO.setFecBaja(cstmt.getString(11));
			numeracionCelularVO.setIndEquipado(new Long(cstmt.getLong(12)));
			numeracionCelularVO.setUsoAnterior(new Long(cstmt.getLong(13)));
			numeracionCelularVO.setCodVendealer(new Long(cstmt.getLong(14)));
			logger.info("Salida en DAO:");
			logger.info("numeracionCelularVO.getCodCliente():"+numeracionCelularVO.getCodCliente());
			logger.info("numeracionCelularVO.getCodVendedor():"+numeracionCelularVO.getCodVendedor());
			logger.info("numeracionCelularVO.getOrigen():"+numeracionCelularVO.getOrigen());
			logger.info("numeracionCelularVO.getFecReserva():"+numeracionCelularVO.getFecReserva());
			logger.info("numeracionCelularVO.getCodSubALM():"+numeracionCelularVO.getCodSubALM());
			logger.info("numeracionCelularVO.getCodProducto():"+numeracionCelularVO.getCodProducto());
			logger.info("numeracionCelularVO.getCodCentral():"+numeracionCelularVO.getCodCentral());
			logger.info("numeracionCelularVO.getCodCat():"+numeracionCelularVO.getCodCat());
			logger.info("numeracionCelularVO.getCodUso():"+numeracionCelularVO.getCodUso());
			logger.info("numeracionCelularVO.getFecBaja():"+numeracionCelularVO.getFecBaja());
			logger.info("numeracionCelularVO.getIndEquipado():"+numeracionCelularVO.getIndEquipado());
			logger.info("numeracionCelularVO.getUsoAnterior():"+numeracionCelularVO.getUsoAnterior());

	 	} catch (Exception e) {
	 		if (!(e instanceof ProductDomainException)) {
				logger.error(global.getValor("ERR.0078"),e);
				logger.debug("Codigo de Error[" + codError + "]");
				logger.debug("Mensaje de Error[" + msgError + "]");
				logger.debug("Numero de Evento[" + numEvento + "]");
				throw new ProductDomainException("ERR_0078",78,global.getValor("ERR.0078"));
	 		}else throw (ProductDomainException)e;
	 	} finally {
			if (logger.isDebugEnabled()) {
				logger.debug("Cerrando conexiones...");
			}
			try {
				if (cstmt != null)cstmt.close();
				if (conn != null && !conn.isClosed())conn.close();
			} catch (SQLException e) {
				logger.error("SQLException[" + e + "]");
			}
		}
		logger.debug("consultaNumeroCelularGAReservado:end");
	}
	
	/**
	 * La capa de negocio efectua una consulta la tabla GA_CELNUM_USO. 
	 * PACKAGE: PV_NUMERACION_PG
	 * PROCEDIMIENTO: PV_CONS_GA_CELNUM_USO_PR
	 * @param numeracionCelularVO
	 * @throws ProductDomainException
	 * 14/10/2008 18:39:23
	 * @author Santiago Ventura
	 */
	public void consultaUsoNumeroCelular(NumeracionCelularDTO numeracionCelularVO) 
		throws ProductDomainException
	{
		Connection conn = null;
		CallableStatement cstmt = null;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		conn = getConection();
		logger.debug("consultaUsoNumeroCelular:start");
	    try {
	    	
			String call = getSQLDatos("VE_NUMERACION_PG","VE_CONS_GA_CELNUM_USO_PR",8);
			cstmt = conn.prepareCall(call);
			
			logger.info("SQL["+ call + "]");
			logger.info("Entrada en DAO:");
			logger.info("numeracionCelularVO.getNumCelular():"+numeracionCelularVO.getNumCelular());
			
			//EN_NUM_CELULAR                IN  GA_CELNUM_USO.NUM_DESDE%TYPE,
			cstmt.setLong(1, numeracionCelularVO.getNumCelular().longValue());
			//SV_COD_SUBALM                 OUT NOCOPY GA_CELNUM_USO.COD_SUBALM%TYPE,
			cstmt.registerOutParameter(2, java.sql.Types.VARCHAR);
			//SV_COD_CENTRAL                OUT NOCOPY GA_CELNUM_USO.COD_CENTRAL%TYPE,
			cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
			//SV_COD_CAT                    OUT NOCOPY GA_CELNUM_USO.COD_CAT%TYPE,
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);
			//SV_COD_USO                    OUT NOCOPY GA_CELNUM_USO.COD_USO%TYPE,	   
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);			
			cstmt.registerOutParameter(6, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(7, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(8, java.sql.Types.NUMERIC);
			
			logger.info(" Iniciando Ejecución");
			logger.info("Execute Antes");

			cstmt.execute();

			logger.info("Execute Despues");
			logger.info(" Finalizo ejecución");			
			codError = cstmt.getInt(6);
			msgError = cstmt.getString(7);
			numEvento = cstmt.getInt(8);
			logger.info("codError[" + codError + "]");
			logger.info("msgError[" + msgError + "]");
			logger.info("numEvento[" + numEvento + "]");
			
			if (codError!=0) {
				
				cat.error("Ocurrió un error al reservar numero de celular");
				throw new ProductDomainException("Ocurrió un error al reervar numero de celular", String
								.valueOf(codError), numEvento, msgError);
			}	
			
			numeracionCelularVO.setCodSubALM(cstmt.getString(2));
			numeracionCelularVO.setCodCentral(String.valueOf(cstmt.getLong(3)));
			numeracionCelularVO.setCodCat(String.valueOf(cstmt.getLong(4)));
			numeracionCelularVO.setCodUso(String.valueOf(cstmt.getLong(5)));
			logger.info("Salida en DAO:");
			logger.info("numeracionCelularVO.getCodSubALM():"+numeracionCelularVO.getCodSubALM());
			logger.info("numeracionCelularVO.getCodCentral():"+numeracionCelularVO.getCodCentral());
			logger.info("numeracionCelularVO.getCodCat():"+numeracionCelularVO.getCodCat());
			logger.info("numeracionCelularVO.getCodUso():"+numeracionCelularVO.getCodUso());
			
	 	} catch (Exception e) {
	 		if (!(e instanceof ProductDomainException)) {
				logger.error(global.getValor("ERR.0078"),e);
				logger.debug("Codigo de Error[" + codError + "]");
				logger.debug("Mensaje de Error[" + msgError + "]");
				logger.debug("Numero de Evento[" + numEvento + "]");
				throw new ProductDomainException("ERR_0078",78,global.getValor("ERR.0078"));
	 		}else throw (ProductDomainException)e;
	 	} finally {
			if (logger.isDebugEnabled()) {
				logger.debug("Cerrando conexiones...");
			}
			try {
				if (cstmt != null)cstmt.close();
				if (conn != null && !conn.isClosed())conn.close();
			} catch (SQLException e) {
				logger.error("SQLException[" + e + "]");
			}
		}
		logger.debug("consultaUsoNumeroCelular:end");			
	}	
	
	/**
	 * Package:PV_CAMPLAN_POST_IND_PG
     * Procedure: PV_VALIDA_NUM_FRECUENTES_PR
	 * Ejecuta PL que valida el numero frecuente informado.
	 * Si no encuentra información el metodo devuelve excepcion.
	 * @author H&eacute;tor Hermosilla
	 * @param OOSSCambioPlanPostPagoIndividualVO
	 * @exception ProyectoException
	 */	
	public void validaNumeroInternet(NumeroInternetDTO entrada)
		throws ProductDomainException
	{
		int codError = 0;
		String msgError = null;
		int numEvento = 0;		
		
		Connection conn = null;		
		conn = getConection();
		CallableStatement cstmt = null; 
		try {
						
			
			cat.debug("Inicio:getSecuenciaVenta");			
			String call = getSQLDatos("VE_Numeracion_Pg","VE_VALIDA_NUMERACION_PR",8);			
			cat.debug("sql[" + call + "]");			
			cstmt = conn.prepareCall(call);
						
			cstmt.setString(1,String.valueOf(entrada.getNumero()));
			logger.info("validaNumeroInternet.getNumero():"+entrada.getNumero());
			cstmt.setString(2,entrada.getCodOperadorMin());
			logger.info("validaNumeroInternet.getCodOperadorMin():"+ entrada.getCodOperadorMin());
			cstmt.setString(3,entrada.getProcedencia());
			logger.info("validaNumeroInternet.getProcedencia():"+entrada.getProcedencia());
			cstmt.setLong(4,entrada.getCodCliente());
			logger.info("validaNumeroInternet.getCodCliente():"+entrada.getCodCliente());
			
			cstmt.registerOutParameter(5,java.sql.Types.VARCHAR);
			
			cstmt.registerOutParameter(6,java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(7,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(8,java.sql.Types.NUMERIC);			
			
			logger.info("validaNumeroInternet:antes execute():");
			cstmt.execute();
			logger.info("validaNumeroInternet:despues execute");
			
			codError = cstmt.getInt(6);
			logger.info("validaNumeroInternet codError: " + codError);			
			msgError = cstmt.getString(7);
			logger.info("validaNumeroInternet codError: " + msgError);
			numEvento = cstmt.getInt(8);
			logger.info("validaNumeroInternet codError: " + numEvento);
			
			if(codError != 0)	
			{
				throw new ProductDomainException( String.valueOf(codError), numEvento,msgError);
			}
			
		} catch (Exception e) {
			cat.error("Ocurrió al validar el numero internet",e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
			if (e instanceof ProductDomainException ) throw (ProductDomainException) e;
	 	} finally {
			if (logger.isDebugEnabled()) {
				logger.debug("Cerrando conexiones...");
			}
			try {
				if (cstmt != null)cstmt.close();
				if (conn != null && !conn.isClosed())conn.close();
			} catch (SQLException e) {
				logger.error("SQLException[" + e + "]");
			}
		}		
	}
	
	//Inicio P-CSR-11002 JLGN 14-11-2011
	public void validaDisponibilidadNumero(String numCelular)throws ProductDomainException{
		int codError = 0;
		String msgError = null;
		int numEvento = 0;		
		
		Connection conn = null;		
		conn = getConection();
		CallableStatement cstmt = null; 
		try {
			cat.debug("Inicio:validaDisponibilidadNumero");			
			String call = getSQLDatos("VE_Numeracion_Pg","ve_val_disp_numero_pr",4);			
			cat.debug("sql[" + call + "]");			
			cstmt = conn.prepareCall(call);
			cat.debug("numCelular: "+ numCelular);			
			cstmt.setLong(1,Long.parseLong(numCelular));			
			cstmt.registerOutParameter(2,java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(3,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(4,java.sql.Types.NUMERIC);			
			
			logger.info("validaDisponibilidadNumero:antes execute():");
			cstmt.execute();
			logger.info("validaDisponibilidadNumero:despues execute");
			
			codError = cstmt.getInt(2);
			logger.info("codError: " + codError);			
			msgError = cstmt.getString(3);
			logger.info("msgError: " + msgError);
			numEvento = cstmt.getInt(4);
			logger.info("numEvento: " + numEvento);
			
			if(codError != 0)	
			{
				cat.error("Ocurrió un error al Validar número de celular");	
				throw new ProductDomainException( String.valueOf(codError), numEvento,msgError);
			}
			
		} catch (Exception e) {
			cat.error("Ocurrió un error al Validar número de celular",e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
			if (e instanceof ProductDomainException ) throw (ProductDomainException) e;
	 	} finally {
			if (logger.isDebugEnabled()) {
				logger.debug("Cerrando conexiones...");
			}
			try {
				if (cstmt != null)cstmt.close();
				if (conn != null && !conn.isClosed())conn.close();
			} catch (SQLException e) {
				logger.error("SQLException[" + e + "]");
			}
		}		
	}
	//Fin P-CSR-11002 JLGN 14-11-2011
	
}
