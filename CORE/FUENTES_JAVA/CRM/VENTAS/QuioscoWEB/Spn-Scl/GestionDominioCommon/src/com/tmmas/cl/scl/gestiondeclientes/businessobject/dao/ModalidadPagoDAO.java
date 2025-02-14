/**
 * Copyright � 2007 Telef&oacute;nica M&oacute;viles Soluciones y Aplicaciones, SA.
 * Av. Del Condor 720, Huechuraba, Santiago de Chile, Chile
 * Todos los derechos reservados.
 *
 * Este software es informaci&oacute;n propietaria y confidencial de TM-mAs SA.
 * Usted no debe develar tal informaci�n y s&oactute;lo debe usarla en concordancia
 * con los t&eacute;rminos de derechos de licencias que sean adquiridos con TM-mAs.
 *
 * Fecha ------------------- Autor  ------------------------- Cambios ----------
 * 16/01/2007     H&eacute;ctor Hermosilla      					Versi�n Inicial
 */

package com.tmmas.cl.scl.gestiondeclientes.businessobject.dao;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import oracle.jdbc.driver.OracleTypes;

import org.apache.log4j.Category;

import com.tmmas.cl.framework.base.ConnectionDAO;
import com.tmmas.cl.framework.exception.GeneralException;
import com.tmmas.cl.framework.util.ArrayUtl;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.ModalidadPagoDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.NumeroCuotasDTO;
import com.tmmas.cl.scl.gestiondeclietnes.businessobject.helper.Global;


public class ModalidadPagoDAO extends ConnectionDAO{
	private static Category cat = Category.getInstance(ModalidadPagoDAO.class);

	Global global = Global.getInstance();
	
	private Connection getConection() throws GeneralException
	{
		Connection conn = null;
		try {
			conn = getConnectionFromWLSInitialContext(global.getJndiForDataSource());
		} catch (Exception e1) {
			conn = null;
			cat.error(" No se pudo obtener una conexi�n ", e1);
			throw new GeneralException("No se pudo obtener una conexi�n", e1);
		}
		
		return conn;
	}
	
	
	private String getSQLPackage(String packageName, String procedureName, int paramCount)
	{
		StringBuffer sb = new StringBuffer("{call "+packageName+"."+procedureName+"(");
        for (int n = 1; n <= paramCount; n++) {
            sb.append("?");
            if (n < paramCount) sb.append(",");
        }
        return sb.append(")}").toString();
	
	}
	
	private ModalidadPagoDTO getResultset(ResultSet rs, int i) throws GeneralException
	{
		ModalidadPagoDTO plans = new ModalidadPagoDTO();
		
		try
		{
			if(global.ModoEjecucion().equals("prueba1"))
			{
				plans.setCodigoModalidadPago("codPlans"+i);
				plans.setDescripcionModalidadPago("desPlans"+i);
				
			}
			else
			{
				plans.setCodigoModalidadPago(rs.getString(1));
				plans.setDescripcionModalidadPago(rs.getString(2));
				
			}

		}
		catch(SQLException e)
		{
			throw new GeneralException(global.errorgetListado() +  " [" + i + "]", e);
		}
		
		return plans;
	}

	public ModalidadPagoDTO[] getListadoModalidadPago(ModalidadPagoDTO modalidad) throws GeneralException{
		
		cat.debug("getListadoModalidadPago:start");
		ModalidadPagoDTO[] resultado=null;
		Connection conn = null;
		CallableStatement cstmt = null;
		conn = getConection();
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		cat.debug("Coneccion obtenida OK");
		try {
		
			if(global.ModoEjecucion().equals("prueba1"))
			{
				ArrayList lista = new ArrayList();
				for(int i=0;i<=80;i++)
				{
					cat.debug("Procesando iteraci�n :" + i);
					ModalidadPagoDTO  ModalidadPago = null;
					ModalidadPago = getResultset(null, i);
					lista.add(ModalidadPago);
				}
				resultado = (ModalidadPagoDTO[])ArrayUtl.copiaArregloTipoEspecifico(lista.toArray(), 
							 ModalidadPagoDTO.class);
			}
			else
			{
				//INI-01 (AL) String call = getSQLPackage("VE_PARAMETROS_COMERCIALES_PG","VE_modalidadpago_PR",11);
				String call = getSQLPackage("VE_PARAMETROS_COMER_QUIOSCO_PG","VE_modalidadpago_PR",11);
				cat.debug("sql[" + call + "]");
				cstmt = conn.prepareCall(call);
				cat.debug("Execute Antes");
				cstmt.setString(1,modalidad.getTipoContrato());
				cat.debug("modalidad.getTipoContrato()" + modalidad.getTipoContrato());
				cstmt.setInt(2,Integer.parseInt(modalidad.getMeses()));
				cat.debug("modalidad.getMeses()" + modalidad.getMeses());
				cstmt.setInt(3,Integer.parseInt(modalidad.getVendedorArchivo()));
				cat.debug("modalidad.getVendedorArchivo()" + modalidad.getVendedorArchivo());
				cstmt.setString(4,modalidad.getUsuarioArchivo());
				cat.debug("modalidad.getUsuarioArchivo()" + modalidad.getUsuarioArchivo());
				cstmt.setInt(5,modalidad.getCodigoProducto());
				cat.debug("getValorCodigoProducto()" + modalidad.getCodigoProducto());
				cstmt.setString(6,modalidad.getCodigoOperacion());
				cat.debug("getValorColumnaCodigoOperacion()" + modalidad.getCodigoOperacion());
				cstmt.setString(7,modalidad.getDatosPrograma().getCodigoPrograma());
				cat.debug("modalidad.getDatosPrograma().getCodigoPrograma()");
				cstmt.registerOutParameter(8, OracleTypes.CURSOR);
				cstmt.registerOutParameter(9, java.sql.Types.NUMERIC);
				cstmt.registerOutParameter(10, java.sql.Types.VARCHAR);
				cstmt.registerOutParameter(11, java.sql.Types.NUMERIC);
				cstmt.execute();
				cat.debug("Execute Despues");
				
				codError = cstmt.getInt(9);
				cat.debug("codError[" + codError + "]");
				msgError = cstmt.getString(10);
				cat.debug("msgError[" + msgError + "]");
				numEvento = cstmt.getInt(11);
				cat.debug("numEvento[" + numEvento + "]");
				
				if (codError != 0) {
					cat.error("Ocurri� un error al consultar las Modalidades de Pago");
					throw new GeneralException(
							"Ocurri� un error al consultar las Modalidades de Pago", String
									.valueOf(codError), numEvento, msgError);
					
				}else{
					ResultSet rs = (ResultSet)cstmt.getObject(8);
					ArrayList lista = new ArrayList();
					while (rs.next()) {
						cat.debug("Procesando iteraci�n :" + lista.size());
						ModalidadPagoDTO ModalidadPago = null;
						ModalidadPago= getResultset(rs, lista.size());
						lista.add(ModalidadPago);
					}
					rs.close();
					resultado =(ModalidadPagoDTO[])ArrayUtl.copiaArregloTipoEspecifico(lista.toArray(), 
								ModalidadPagoDTO.class);
				}
				if (cat.isDebugEnabled()) {
					cat.debug(" Finalizo ejecuci�n");
					cat.debug(" Recuperando salidas");
				}
			}
		} catch (GeneralException e) {
			cat.error("Ocurri� un error al consultar las Modalidades de Pago",e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new GeneralException(
					"Ocurri� un error al consultar las Modalidades de Pago", String
							.valueOf(codError), numEvento, msgError);
		} catch (Exception e) {
		cat.error("Ocurri� un error al consultar las Modalidades de Pago",e);
		if (cat.isDebugEnabled()) {
			cat.debug("Codigo de Error[" + codError + "]");
			cat.debug("Mensaje de Error[" + msgError + "]");
			cat.debug("Numero de Evento[" + numEvento + "]");
		}
		throw new GeneralException(
				"Ocurri� un error al consultar las Modalidades de Pago",e);
		} finally {
		 	if (cat.isDebugEnabled()) 
				cat.debug("Cerrando conexiones...");
			try {
				if (cstmt!=null)
					cstmt.close();
				if (!conn.isClosed()) {
					conn.close();
				}
			} catch (SQLException e) {
				cat.debug("SQLException", e);
			}
		}
		cat.debug("getListadoModalidadPago():end");

		return resultado; 
		}
	
	public NumeroCuotasDTO[] getListadoNumeroCuotas(ModalidadPagoDTO modalidad) throws GeneralException{
		
		cat.debug("getListadoNumeroCuotas:start");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		NumeroCuotasDTO[] resultado = null;
		Connection conn = null;
		CallableStatement cstmt = null;
		conn = getConection();
		cat.debug("Coneccion obtenida OK");
		try {
			//INI-01 (AL) String call = getSQLPackage("VE_PARAMETROS_COMERCIALES_PG","VE_nrocuotas_PR",8);
			String call = getSQLPackage("VE_PARAMETROS_COMER_QUIOSCO_PG","VE_nrocuotas_PR",8);
			cat.debug("sql[" + call + "]");
			cstmt = conn.prepareCall(call);
			cat.debug("ModalidadPago " + modalidad.getCodigoModalidadPago());
			cat.debug("vendedor " + modalidad.getVendedorArchivo());
			cat.debug("usuario " + modalidad.getUsuarioArchivo());
			cstmt.setInt(1,Integer.parseInt(modalidad.getCodigoModalidadPago()));
			
			cstmt.setInt(2,Integer.parseInt(modalidad.getVendedorArchivo()));
			cstmt.setString(3,modalidad.getUsuarioArchivo());
			cstmt.setInt(4,modalidad.getCodigoProducto());
			cstmt.registerOutParameter(5,OracleTypes.CURSOR);
			cstmt.registerOutParameter(6, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(7, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(8, java.sql.Types.NUMERIC);
			cat.debug("Execute Antes");
			cstmt.execute();
			cat.debug("Execute Despues");
			
			codError = cstmt.getInt(6);
			cat.debug("codError[" + codError + "]");
			msgError = cstmt.getString(7);
			cat.debug("msgError[" + msgError + "]");
			numEvento = cstmt.getInt(8);
			cat.debug("numEvento[" + numEvento + "]");
			
			if (codError != 0) {
				cat.error("Ocurri� un error al consultar N�mero de Cuotas");
				throw new GeneralException(
						"Ocurri� un error al consultar N�mero de Cuotas", String
								.valueOf(codError), numEvento, msgError);
				
			}else{
				cat.debug("Llenado Numero de Cuotas");
				ResultSet rs = (ResultSet) cstmt.getObject(5);
				ArrayList lista = new ArrayList();
				while (rs.next()) {
					cat.debug("Procesando iteraci�n :" + lista.size());
					NumeroCuotasDTO numeroCuotas = new NumeroCuotasDTO();
					numeroCuotas.setCodigo(rs.getString(1));
					numeroCuotas.setDescripcion(rs.getString(2));
					lista.add(numeroCuotas);
				}
				rs.close();
				resultado =(NumeroCuotasDTO[])ArrayUtl.copiaArregloTipoEspecifico(lista.toArray(), 
							NumeroCuotasDTO.class);;
			}
			if (cat.isDebugEnabled()) {
				cat.debug(" Finalizo ejecuci�n");
				cat.debug(" Recuperando salidas");
			}
		} catch (GeneralException e) {
			throw e;
		} catch (Exception e) {
			cat.error("Ocurri� un error al consultar los numeros de cuotas",e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new GeneralException(
					"Ocurri� un error al consultar los Numeros de Cuotas",e);
		} finally {
		 	if (cat.isDebugEnabled()) 
				cat.debug("Cerrando conexiones...");
			try {
				if (cstmt!=null)
					cstmt.close();
				if (!conn.isClosed()) {
					conn.close();
				}
			} catch (SQLException e) {
				cat.debug("SQLException", e);
			}
		}

		cat.debug("getListadoNumeroCuotas():end");

		return resultado;
		
	}
	
	public ModalidadPagoDTO getModalidadPago(ModalidadPagoDTO modalidad) throws GeneralException{
		
		cat.debug("getModalidadPago:start");
		Connection conn = null;
		CallableStatement cstmt = null;
		conn = getConection();
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		cat.debug("Coneccion obtenida OK");
		try {
			//INI-01 (AL) String call = getSQLPackage("Ve_Servicios_Venta_Pg","VE_con_modalidadpago_PR",6);
			String call = getSQLPackage("Ve_Servicios_Venta_quiosco_Pg","VE_con_modalidadpago_PR",6);
			cat.debug("sql[" + call + "]");
			cstmt = conn.prepareCall(call);
			cat.debug("Execute Antes");
			cstmt.setInt(1,Integer.parseInt(modalidad.getCodigoModalidadPago()));
			cstmt.registerOutParameter(2, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(5, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(6, java.sql.Types.NUMERIC);
			cstmt.execute();
			cat.debug("Execute Despues");
			
			codError = cstmt.getInt(4);
			cat.debug("codError[" + codError + "]");
			msgError = cstmt.getString(5);
			cat.debug("msgError[" + msgError + "]");
			numEvento = cstmt.getInt(6);
			cat.debug("numEvento[" + numEvento + "]");
			
			if (codError != 0) {
				cat.error("Ocurri� un error al consultar la modalidad de pago");
				throw new GeneralException(
						"Ocurri� un error al consultar la modalidad de pago", String
								.valueOf(codError), numEvento, msgError);
				
			}else{
			
				modalidad.setDescripcionModalidadPago(cstmt.getString(2));
				modalidad.setIndicadorCuotas(String.valueOf(cstmt.getInt(3)));
			}
			if (cat.isDebugEnabled()) {
				cat.debug(" Finalizo ejecuci�n");
				cat.debug(" Recuperando salidas");
			}
			
		} catch (GeneralException e) {
			throw e;
		} catch (Exception e) {
			cat.error("Ocurri� un error al consultar la modalidad de pago",e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new GeneralException(
					"Ocurri� un error al consultar la modalidad de pago",e);
		} finally {
		 	if (cat.isDebugEnabled()) 
				cat.debug("Cerrando conexiones...");
			try {
				if (cstmt!=null)
					cstmt.close();
				if (!conn.isClosed()) {
					conn.close();
				}
			} catch (SQLException e) {
				cat.debug("SQLException", e);
			}
		}
		cat.debug("getModalidadPago():end");

		return modalidad; 
		}
	
	/**
	 * Obtiene modalidades de pago segun indicador manual
	 * @param N/A
	 * @return ModalidadPagoDTO[]
	 * @throws GeneralException
	 */
	public ModalidadPagoDTO[] getListModalidadPagoIndManual(ModalidadPagoDTO entrada) 
	throws GeneralException{
		cat.debug("Inicio:getListModalidadPagoIndManual()");
		ModalidadPagoDTO[] resultado = null;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt =null;
		try {
			//INI-01 (AL) String call = getSQLPackage("VE_alta_cliente_PG","VE_getListModalidadPago_PR",5);
			String call = getSQLPackage("VE_alta_cliente_Quiosco_PG","VE_getListModalidadPago_PR",5);

			cat.debug("sql[" + call + "]");
			
			cstmt = conn.prepareCall(call);
			
			cstmt.setInt(1,entrada.getIndicadorManual());
			cstmt.registerOutParameter(2,OracleTypes.CURSOR);
			cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);
			
			cat.debug("Inicio:getListModalidadPagoIndManual:execute");
			cstmt.execute();
			cat.debug("Fin:getListModalidadPagoIndManual:execute");

			codError = cstmt.getInt(3);
			msgError = cstmt.getString(4);
			numEvento = cstmt.getInt(5);
			
			cat.debug("Codigo de Error[" + codError + "]");
			cat.debug("Mensaje de Error[" + msgError + "]");
			cat.debug("Numero de Evento[" + numEvento + "]");
			
			if (codError != 0) {
				cat.error("Ocurri� un error al recuperar modalidades de pago segun indicador manual");
				throw new GeneralException(
						"Ocurri� un error al recuperar modalidades de pago segun indicador manual", String
								.valueOf(codError), numEvento, msgError);
			}else{
				cat.debug("Recuperando  modalidades de pago segun indicador manual");
				ArrayList lista = new ArrayList();
				ResultSet rs = (ResultSet) cstmt.getObject(2);
				while (rs.next()) {
					ModalidadPagoDTO modalidadPagoDTO = new ModalidadPagoDTO();
					modalidadPagoDTO.setCodigoModalidadPago(rs.getString(1));
					modalidadPagoDTO.setDescripcionModalidadPago(rs.getString(2));
					lista.add(modalidadPagoDTO);
				}
				rs.close();
				resultado =(ModalidadPagoDTO[]) ArrayUtl.copiaArregloTipoEspecifico(
					lista.toArray(), ModalidadPagoDTO.class);
				
			}
			if (cat.isDebugEnabled()) {
				cat.debug(" Finalizo ejecuci�n");
				cat.debug(" Recuperando modalidades de pago segun indicador manual");
			}
		} catch (GeneralException e) {
			throw e;
		} catch (Exception e) {
			cat.error("Ocurri� un error al recuperar modalidades de pago segun indicador manual",e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
		} finally {
		 	if (cat.isDebugEnabled()) 
				cat.debug("Cerrando conexiones...");
			try {
				if (cstmt!=null)
					cstmt.close();
				if (!conn.isClosed()) {
					conn.close();
				}
			} catch (SQLException e) {
				cat.debug("SQLException", e);
			}
		}
		cat.debug("Fin:getListModalidadPagoIndManual()");
		return resultado;
	}//fin getListModalidadPagoIndManual	
	
}//fin class ModalidadPagoDAO


