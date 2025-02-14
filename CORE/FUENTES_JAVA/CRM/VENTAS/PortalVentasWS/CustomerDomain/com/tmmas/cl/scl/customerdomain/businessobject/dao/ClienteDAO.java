/**
 * Av. Del Condor 720, Huechuraba, Santiago de Chile, Chile
 * Todos los derechos reservados.
 *
 * Este software es informaci&oacute;n propietaria y confidencial de TM-mAs SA.
 * Usted no debe develar tal información y s&oactute;lo debe usarla en concordancia
 * con los t&eacute;rminos de derechos de licencias que sean adquiridos con TM-mAs.
 *
 * Fecha ------------------- Autor  ------------------------- Cambios ----------
 * 23/01/2007     Héctor Hermosilla      					Versión Inicial
 */

package com.tmmas.cl.scl.customerdomain.businessobject.dao; 

import java.io.IOException;
import java.io.InputStream;
import java.lang.reflect.Array;
import java.net.HttpURLConnection;
import java.net.SocketTimeoutException;
import java.net.URL;
import java.net.URLConnection;
//import java.net.*;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.net.ssl.HttpsURLConnection;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;

import oracle.jdbc.driver.OracleTypes;

import org.apache.log4j.Category;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.NodeList;
import org.xml.sax.SAXException;

import weblogic.net.http.SOAPHttpsURLConnection;
import weblogic.security.SSL.SSLSocketFactory;

import com.tmmas.cl.framework.base.ConnectionDAO;
import com.tmmas.cl.framework.util.ArrayUtl;
import com.tmmas.cl.framework.util.StackTraceUtl;
import com.tmmas.cl.scl.altaclientecommon.commonapp.dto.CargoLaboralDTO;
import com.tmmas.cl.scl.altaclientecommon.commonapp.dto.ClasificacionDTO;
import com.tmmas.cl.scl.altaclientecommon.commonapp.dto.ClienteAltaDTO;
import com.tmmas.cl.scl.altaclientecommon.commonapp.dto.DatosClienteBuroDTO;
import com.tmmas.cl.scl.altaclientecommon.commonapp.dto.DatosHijoClienteBuroDTO;
import com.tmmas.cl.scl.altaclientecommon.commonapp.dto.DatosLaboralHistoricoBuroDTO;
import com.tmmas.cl.scl.altaclientecommon.commonapp.dto.MensajePromocionalDTO;
import com.tmmas.cl.scl.altaclientecommon.commonapp.dto.OperadoraDTO;
import com.tmmas.cl.scl.altaclientecommon.commonapp.dto.ProfesionDTO;
import com.tmmas.cl.scl.altaclientecommon.commonapp.dto.ReferenciaClienteDTO;
import com.tmmas.cl.scl.altaclientecommon.commonapp.dto.TipoNombramientoDTO;
import com.tmmas.cl.scl.altaclientecommon.commonapp.dto.ValorClasificacionDTO;
import com.tmmas.cl.scl.altaclientecommon.commonapp.exception.AltaClienteException;
import com.tmmas.cl.scl.commonbusinessentities.commonapp.DireccionNegocioDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.ParametrosValidacionDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.ResultadoValidacionVentaDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.exception.CustomerDomainException;
import com.tmmas.cl.scl.crmcommon.commonapp.exception.VentasException;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.AbonadoDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.AnexoTerminalDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.BusquedaClienteDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.CategoriaCambioClienteDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.CategoriaCambioDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.ClienteDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.ContratoDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.DatosAnexoTerminalesDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.DatosContrato;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.DatosGeneralesDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.DatosLineaContratoDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.helper.Global;
import com.tmmas.cl.scl.direccioncommon.commonapp.dto.DirecClienteDTO;
import com.tmmas.cl.scl.direccioncommon.commonapp.dto.DirecClienteListDTO;

public class ClienteDAO extends ConnectionDAO
{
	private static Category cat = Category.getInstance(ClienteDAO.class);

	Global global = Global.getInstance();

	private Connection getConection() throws CustomerDomainException
	{
		Connection conn = null;
		try
		{
			conn = getConnectionFromWLSInitialContext(global.getJndiForDataSource());
		}
		catch (Exception e1)
		{
			conn = null;
			cat.error(" No se pudo obtener una conexión ", e1);
			throw new CustomerDomainException("No se pudo obtener una conexión", e1);
		}

		return conn;
	}

	private String getSQLDatosCliente(String packageName, String procedureName, int paramCount)
	{
		StringBuffer sb = new StringBuffer("{call " + packageName + "." + procedureName + "(");
		for (int n = 1; n <= paramCount; n++)
		{
			sb.append("?");
			if (n < paramCount)
				sb.append(",");
		}
		return sb.append(")}").toString();

	}

	private String getSQLDirecCliente()
	{
		StringBuffer calling = new StringBuffer();
		calling.append("");
		calling.append("DECLARE");
		calling.append("   SO_DIRECCIONES GA_TIPOS_PG.TIP_GA_DIRECCLIENTE;");
		calling.append("   SN_COD_RETORNO NUMBER;");
		calling.append("   SV_MENS_RETORNO VARCHAR2(200);");
		calling.append("   SN_NUM_EVENTO NUMBER;");
		calling.append(" BEGIN ");
		calling.append("  SO_DIRECCIONES(1).cod_cliente := ?;");
		calling.append("  GE_cliente_SB_PG.GE_consultarDirecCliente_PR(SO_DIRECCIONES,?, ?, ?, ? );");
		calling.append(" END;");
		cat.debug("calling : " + calling);
		return calling.toString();
	}

	public ClienteDTO getCliente(ClienteDTO cliente) 
		throws CustomerDomainException
	{
		cat.debug("getCliente:inicio");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		cat.debug("Coneccion obtenida OK");
		CallableStatement cstmt = null;
		try
		{
			String call = getSQLDatosCliente("VE_servicios_venta_PG", "VE_consulta_cliente_PR", 27);
			cat.debug("sql[" + call + "]");
			cstmt = conn.prepareCall(call);
			cstmt.setLong(1, Long.parseLong(cliente.getCodigoCliente()));
			cstmt.registerOutParameter(2, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(6, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(7, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(8, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(9, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(10, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(11, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(12, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(13, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(14, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(15, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(16, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(17, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(18, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(19, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(20, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(21, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(22, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(23, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(24, java.sql.Types.VARCHAR);

			cstmt.registerOutParameter(25, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(26, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(27, java.sql.Types.NUMERIC);

			cat.debug("Execute Antes");
			cstmt.execute();
			cat.debug("Execute Despues");
			codError = cstmt.getInt(25);
			cat.debug("codError[" + codError + "]");
			msgError = cstmt.getString(26);
			cat.debug("msgError[" + msgError + "]");
			numEvento = cstmt.getInt(27);
			cat.debug("numEvento[" + numEvento + "]");
			if (codError != 0)
			{
				/*
				 * codError = 10; numEvento = 10; msgError = "No se pudo
				 * rescatar la Información";
				 */

				cat.error("Ocurrió un error al consultar el Cliente");
				throw new CustomerDomainException("Ocurrió un error al consultar el cliente", String.valueOf(codError),
						numEvento, "Ocurrió un error al consultar el cliente");
			}
			else
			{
				cliente.setNumeroIdentificacion(cstmt.getString(2));
				cat.debug("Numero Identificacion: ["+cliente.getNumeroIdentificacion()+"]");
				cliente.setCodigoTipoIdentificacion(cstmt.getString(3));
				cat.debug("Tipo Identificacion: ["+cliente.getCodigoTipoIdentificacion()+"]");
				cliente.setNombreCliente(cstmt.getString(4));
				cliente.setCodigoCuenta(String.valueOf(cstmt.getLong(5)));
				cliente.setNombreApellido1(cstmt.getString(6));
				cliente.setNombreApellido2(cstmt.getString(7));
				cliente.setFechaNacimiento(cstmt.getString(8));
				cliente.setIndicadorEstadoCivil(cstmt.getString(9));
				cliente.setIndicadorSexo(cstmt.getString(10));
				cliente.setCodigoActividad(String.valueOf(cstmt.getLong(11)));
				DireccionNegocioDTO[] direccion = new DireccionNegocioDTO[1];
				direccion[0] = new DireccionNegocioDTO();
				direccion[0].setRegion(cstmt.getString(12));
				direccion[0].setCiudad(cstmt.getString(13));
				direccion[0].setProvincia(cstmt.getString(14));
				direccion[0].setCodigo(cstmt.getString(20));

				cliente.setDirecciones(direccion);
				cliente.setCodigoCelda(cstmt.getString(15));
				cliente.setCodigoCalidadCliente(cstmt.getString(16));
				cliente.setIndicativoFacturable(cstmt.getInt(17));
				cliente.setCodigoCiclo(cstmt.getInt(18));
				if (cstmt.getLong(19) > 0)
				{
					cliente.setCodigoEmpresa(cstmt.getLong(19));
					cliente.setCodigoPlanTarifario(cstmt.getString(21));
				}
				cliente.setCodigoOperadora(cstmt.getString(22));
				cliente.setCodCalificacion(cstmt.getString(23));
				cliente.setTipoCliente(cstmt.getString(24));
			}
			if (cat.isDebugEnabled())
			{
				cat.debug(" Finalizo ejecución");
				cat.debug(" Recuperando salidas");
			}
			// Recuperacion de valores de salida

		}
		catch (Exception e)
		{
			cat.error("Ocurrió un error al consultar el cliente", e);
			if (cat.isDebugEnabled())
			{
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
			if (e instanceof CustomerDomainException)
				throw (CustomerDomainException) e;
		}
		finally
		{
			if (cat.isDebugEnabled())
				cat.debug("Cerrando conexiones...");
			try
			{
				if (cstmt != null)
					cstmt.close();
				if (!conn.isClosed())
				{
					conn.close();
				}
			}
			catch (SQLException e)
			{
				cat.debug("SQLException", e);
			}
		}

		cat.debug("getCliente():end");

		return cliente;
	}

	public ClienteDTO getCategoriaTributariaCliente(ClienteDTO cliente) 
		throws CustomerDomainException
	{
		cat.debug("getCategoriaTributariaCliente:inicio");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		cat.debug("Coneccion obtenida OK");
		CallableStatement cstmt = null;
		try
		{
			String call = getSQLDatosCliente("VE_servicios_venta_PG", "VE_obtiene_cat_trib_cliente_PR", 5);
			cat.debug("sql[" + call + "]");
			cstmt = conn.prepareCall(call);
			cstmt.setInt(1, Integer.parseInt(cliente.getCodigoCliente()));
			cstmt.registerOutParameter(2, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);
			cat.debug("Execute Antes");
			cstmt.execute();
			cat.debug("Execute Despues");
			String resultado = cstmt.getString(2);
			String categoria = null;
			if (resultado.equalsIgnoreCase("B"))
			{
				categoria = "BOLETA";
			}
			else if (resultado.equalsIgnoreCase("F"))
			{
				categoria = "FACTURA";
			}
			else
			{
				throw new CustomerDomainException(
						"Ocurrió un problema en consulta de categoria, no retornó ni Boleta(B) ni Factura(F)", String
								.valueOf(codError), numEvento, msgError);
			}
			cliente.setCategoriaTributaria(categoria);
			codError = cstmt.getInt(3);
			cat.debug("codError[" + codError + "]");
			msgError = cstmt.getString(4);
			cat.debug("msgError[" + msgError + "]");
			numEvento = cstmt.getInt(5);
			cat.debug("numEvento[" + numEvento + "]");
			if (codError != 0)
			{
				cat.error("Ocurrió un error al consultar categoria tributaria cliente");
				throw new CustomerDomainException("Ocurrió un error al consultar categoria tributaria del cliente",
						String.valueOf(codError), numEvento, msgError);
			}
			if (cat.isDebugEnabled())
			{
				cat.debug(" Finalizo ejecución");
				cat.debug(" Recuperando salidas");
			}
			// Recuperacion de valores de salida

		}
		catch (Exception e)
		{
			cat.error("Ocurrió un error al consultar el cliente", e);
			if (cat.isDebugEnabled())
			{
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
		}
		finally
		{
			if (cat.isDebugEnabled())
				cat.debug("Cerrando conexiones...");
			try
			{
				if (cstmt != null)
					cstmt.close();
				if (!conn.isClosed())
				{
					conn.close();
				}
			}
			catch (SQLException e)
			{
				cat.debug("SQLException", e);
			}
		}
		cat.debug("getCategoriaTributariaCliente():end");
		return cliente;
	}

	public ContratoDTO getContratoCliente(ContratoDTO contrato)
		throws CustomerDomainException
	{
		cat.debug("getContratoCliente:start");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		ContratoDTO resultado = new ContratoDTO();
		Connection conn = null;
		conn = getConection();
		cat.debug("Coneccion obtenida OK");
		CallableStatement cstmt = null;
		ResultSet rs = null;
		try
		{
			String call = getSQLDatosCliente("VE_PARAMETROS_COMERCIALES_PG", "VE_contratocliente_PR", 6);

			cat.debug("sql[" + call + "]");
			cstmt = conn.prepareCall(call);
			cat.debug("Execute Antes");
			cstmt.setInt(1, Integer.parseInt(contrato.getCodigoCliente()));
			cat.debug("contrato.getCodigoCliente[" + contrato.getCodigoCliente() + "]");
			cstmt.setString(2, contrato.getCodigoTipoContrato());
			cat.debug("contrato.getCodigoTipoContrato[" + contrato.getCodigoTipoContrato() + "]");
			cstmt.registerOutParameter(3, OracleTypes.CURSOR);
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
			rs = (ResultSet) cstmt.getObject(3);
			ArrayList lista = new ArrayList();
			cat.debug("inicio llenado");
			while (rs.next())
			{
				lista.add(rs.getString(2));
			}
			cat.debug("fin llenado");
			resultado.setContratos(lista);
			if (resultado.getContratos() == null)
			{
				codError = 10;
				numEvento = 10;
				msgError = "No se pudo rescatar la Información";
				cat.error("Ocurrió un error al consultar los contratos del cliente");
				throw new CustomerDomainException("Ocurrió un error al consultar los contratos del cliente", String
						.valueOf(codError), numEvento, msgError);
				/*
				 * throw new CustomerDomainException( "Ocurrió un error al
				 * consultar el cliente");
				 */
			}
			if (cat.isDebugEnabled())
			{
				cat.debug(" Finalizo ejecución");
				cat.debug(" Recuperando salidas");
			}
			// Recuperacion de valores de salida

		}
		catch (Exception e)
		{
			cat.error("Ocurrió un error al consultar los contratos del cliente", e);
			if (cat.isDebugEnabled())
			{
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
		}
		finally
		{
			if (cat.isDebugEnabled())
				cat.debug("Cerrando conexiones...");
			try
			{
				if (rs != null)
					rs.close();
				if (cstmt != null)
					cstmt.close();
				if (!conn.isClosed())
				{
					conn.close();
				}
			}
			catch (SQLException e)
			{
				cat.debug("SQLException", e);
			}
		}

		cat.debug("getContratoCliente():end");

		return resultado;
	}

	public ResultadoValidacionVentaDTO getExisteCliente(ParametrosValidacionDTO parametros)
			throws CustomerDomainException
	{
		cat.debug("getExisteCliente:start");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		ResultadoValidacionVentaDTO resultado = new ResultadoValidacionVentaDTO();
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null;
		cat.debug("Coneccion obtenida OK");
		try
		{
			String call = getSQLDatosCliente("VE_validacion_linea_PG", "VE_existe_cliente_PR", 5);
			cat.debug("sql[" + call + "]");
			cstmt = conn.prepareCall(call);
			cstmt.setLong(1, Integer.parseInt(parametros.getCodigoCliente()));
			cstmt.registerOutParameter(2, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);

			cat.debug("Execute Antes");
			cstmt.execute();
			cat.debug("Execute Despues");
			resultado.setResultadoBase(cstmt.getInt(2));
			codError = cstmt.getInt(3);
			cat.debug("codError[" + codError + "]");
			msgError = cstmt.getString(4);
			cat.debug("msgError[" + msgError + "]");
			numEvento = cstmt.getInt(5);
			cat.debug("numEvento[" + numEvento + "]");
			if (codError != 0)
			{
				cat.error("Ocurrió un error al consultar el Cliente");
				throw new CustomerDomainException("Ocurrió un error al consultar el cliente", String.valueOf(codError),
						numEvento, msgError);
			}
			if (cat.isDebugEnabled())
			{
				cat.debug(" Finalizo ejecución");
				cat.debug(" Recuperando salidas");
			}
			// Recuperacion de valores de salida

		}
		catch (Exception e)
		{
			cat.error("Ocurrió un error al consultar el cliente", e);
			if (cat.isDebugEnabled())
			{
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
		}
		finally
		{
			if (cat.isDebugEnabled())
				cat.debug("Cerrando conexiones...");
			try
			{
				if (cstmt != null)
					cstmt.close();
				if (!conn.isClosed())
				{
					conn.close();
				}
			}
			catch (SQLException e)
			{
				cat.debug("SQLException", e);
			}
		}

		cat.debug("getExisteCliente():end");

		return resultado;
	}

	public ResultadoValidacionVentaDTO getExisteClienteEmpresa(ParametrosValidacionDTO parametros)
			throws CustomerDomainException
	{
		cat.debug("getExisteClienteEmpresa:start");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		ResultadoValidacionVentaDTO resultado = new ResultadoValidacionVentaDTO();
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null;
		cat.debug("Coneccion obtenida OK");
		try
		{
			String call = getSQLDatosCliente("VE_validacion_linea_PG", "VE_existe_cliente_empresa_PR", 5);
			cat.debug("sql[" + call + "]");
			cstmt = conn.prepareCall(call);
			cstmt.setLong(1, Integer.parseInt(parametros.getCodigoCliente()));
			cstmt.registerOutParameter(2, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);
			cstmt.execute();
			resultado.setResultadoBase(cstmt.getInt(2));
			codError = cstmt.getInt(3);
			cat.debug("codError[" + codError + "]");
			msgError = cstmt.getString(4);
			cat.debug("msgError[" + msgError + "]");
			numEvento = cstmt.getInt(5);
			cat.debug("numEvento[" + numEvento + "]");
			if (codError != 0)
			{
				cat.error("Ocurrió un error al consultar el Cliente");
				throw new CustomerDomainException("Ocurrió un error al consultar el cliente", String.valueOf(codError),
						numEvento, msgError);
			}
			if (cat.isDebugEnabled())
			{
				cat.debug(" Finalizo ejecución");
				cat.debug(" Recuperando salidas");
			}
			// Recuperacion de valores de salida

		}
		catch (Exception e)
		{
			cat.error("Ocurrió un error al consultar el cliente", e);
			if (cat.isDebugEnabled())
			{
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
		}
		finally
		{
			if (cat.isDebugEnabled())
				cat.debug("Cerrando conexiones...");
			try
			{
				if (cstmt != null)
					cstmt.close();
				if (!conn.isClosed())
				{
					conn.close();
				}
			}
			catch (SQLException e)
			{
				cat.debug("SQLException", e);
			}
		}

		cat.debug("getExisteClienteEmpresa():end");

		return resultado;
	}

	public ResultadoValidacionVentaDTO getValidaClienteAgenteComercial(ParametrosValidacionDTO entradaValidacionVentas)
			throws CustomerDomainException
	{
		ResultadoValidacionVentaDTO resultado = new ResultadoValidacionVentaDTO();
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null;
		try
		{
			cat.debug("Inicio:getValidaClienteAgenteComercial");

			String call = getSQLDatosCliente("VE_validacion_linea_PG", "VE_agente_comercial_PR", 5);
			cat.debug("sql[" + call + "]");
			cstmt = conn.prepareCall(call);
			cstmt.setInt(1, Integer.parseInt(entradaValidacionVentas.getCodigoCliente()));
			cstmt.registerOutParameter(2, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);

			cat.debug("Inicio:getValidaClienteAgenteComercial:execute");
			cstmt.execute();
			cat.debug("Fin:getValidaClienteAgenteComercial:execute");

			msgError = cstmt.getString(4);
			cat.debug("msgError[" + msgError + "]");

			resultado.setResultadoBase(cstmt.getInt(2));

		}
		catch (Exception e)
		{
			cat.error("Ocurrió un error al verificar si cliente es agente comercial", e);
			if (cat.isDebugEnabled())
			{
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
		}
		finally
		{
			if (cat.isDebugEnabled())
				cat.debug("Cerrando conexiones...");
			try
			{
				if (cstmt != null)
					cstmt.close();
				if (!conn.isClosed())
				{
					conn.close();
				}
			}
			catch (SQLException e)
			{
				cat.debug("SQLException", e);
			}
		}

		cat.debug("Fin:getValidaClienteAgenteComercial()");

		return resultado;
	}// fin getValidaClienteAgenteComercial

	public ClienteDTO getPlanComercial(ClienteDTO cliente) 
		throws CustomerDomainException
	{
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null;
		try
		{
			cat.debug("Inicio:getPlanComercial");

			String call = getSQLDatosCliente("VE_parametros_comerciales_PG", "VE_plan_comercial_cliente_PR", 5);
			cat.debug("sql[" + call + "]");
			cstmt = conn.prepareCall(call);
			cstmt.setInt(1, Integer.parseInt(cliente.getCodigoCliente()));
			cstmt.registerOutParameter(2, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);

			cat.debug("Inicio:getValidaClienteAgenteComercial:execute");
			cstmt.execute();
			cat.debug("Fin:getValidaClienteAgenteComercial:execute");
			codError = cstmt.getInt(3);
			msgError = cstmt.getString(4);
			numEvento = cstmt.getInt(5);
			cat.debug("msgError[" + msgError + "]");
			if (codError == 0)
				cliente.setPlanComercial(String.valueOf(cstmt.getLong(2)));

		}
		catch (Exception e)
		{
			cat.error("Ocurrió un error al buscar plan comercial", e);
			if (cat.isDebugEnabled())
			{
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
		}
		finally
		{
			if (cat.isDebugEnabled())
				cat.debug("Cerrando conexiones...");
			try
			{
				if (cstmt != null)
					cstmt.close();
				if (!conn.isClosed())
				{
					conn.close();
				}
			}
			catch (SQLException e)
			{
				cat.debug("SQLException", e);
			}
		}

		cat.debug("Fin:getPlanComercial()");

		return cliente;
	}// fin getPlanComercial

	/**
	 * Obtiene subcategoria impositiva
	 * 
	 * @param cliente
	 * @return ClienteDTO[]
	 * @throws CustomerDomainException
	 */
	public ClienteDTO[] getListSubCategImpos(ClienteDTO cliente) 
		throws CustomerDomainException
	{
		ClienteDTO[] resultado = null;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null;
		ResultSet rs = null;
		try
		{
			cat.debug("Inicio:getListSubCategImpos");

			String call = getSQLDatosCliente("VE_alta_cliente_PG", "VE_getListSubCategImpos_PR", 5);
			cat.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);

			cstmt.setInt(1, Integer.parseInt(cliente.getCodigoCategImpos()));
			cstmt.registerOutParameter(2, OracleTypes.CURSOR);
			cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);

			cat.debug("Inicio:getListSubCategImpos:execute");
			cstmt.execute();
			cat.debug("Fin:getListSubCategImpos:execute");

			codError = cstmt.getInt(3);
			msgError = cstmt.getString(4);
			numEvento = cstmt.getInt(5);

			if (codError != 0)
			{
				cat.error("Ocurrió un error al recuperar sub categorias impositivas");
				throw new CustomerDomainException("Ocurrió un error al recuperar aub categorias impositivas", String
						.valueOf(codError), numEvento, msgError);
			}
			else
			{
				cat.debug("Recuperando sub categorias");
				ArrayList lista = new ArrayList();
				rs = (ResultSet) cstmt.getObject(2);
				while (rs.next())
				{
					ClienteDTO clienteDTO = new ClienteDTO();
					clienteDTO.setCodigoSubCategImpos(rs.getString(1));
					clienteDTO.setDescripcionSubCategImpos(rs.getString(2));

					lista.add(clienteDTO);
				}
				resultado = (ClienteDTO[]) ArrayUtl.copiaArregloTipoEspecifico(lista.toArray(), ClienteDTO.class);
			}
			if (cat.isDebugEnabled())
			{
				cat.debug(" Finalizo ejecución");
				cat.debug(" Recuperando salidas");
			}
		}
		catch (Exception e)
		{
			cat.error("Ocurrió un error al recuperar sub categorias impositivas", e);
			if (cat.isDebugEnabled())
			{
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
		}
		finally
		{
			if (cat.isDebugEnabled())
				cat.debug("Cerrando conexiones...");
			try
			{
				if (rs != null)
					rs.close();
				if (cstmt != null)
					cstmt.close();
				if (!conn.isClosed())
				{
					conn.close();
				}
			}
			catch (SQLException e)
			{
				cat.debug("SQLException", e);
			}
		}
		cat.debug("Fin:getListSubCategImpos()");
		return resultado;
	}// fin getListSubCategImpos

	/**
	 * Obtiene listado de categorias impositivas
	 * 
	 * @param N/A
	 * @return clienteDTO[]
	 * @throws CustomerDomainException
	 */
	public ClienteDTO[] getListCategImpositivas() 
		throws CustomerDomainException
	{
		cat.debug("Inicio:getListCategImpositivas()");
		ClienteDTO[] resultado = null;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null;
		ResultSet rs = null;
		try
		{
			String call = getSQLDatosCliente("VE_alta_cliente_PG", "VE_getListCategImpositivas_PR", 4);

			cat.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);

			cstmt.registerOutParameter(1, OracleTypes.CURSOR);
			cstmt.registerOutParameter(2, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);

			cat.debug("Inicio:getListCategImpositivas:execute");
			cstmt.execute();
			cat.debug("Fin:getListCategImpositivas:execute");

			codError = cstmt.getInt(2);
			msgError = cstmt.getString(3);
			numEvento = cstmt.getInt(4);

			if (codError != 0)
			{
				cat.error("Ocurrió un error al recuperar categorias impositivas");
				throw new CustomerDomainException("Ocurrió un error al recuperar categorias impositivas", String
						.valueOf(codError), numEvento, msgError);
			}
			else
			{
				cat.debug("Recuperando categorias");
				ArrayList lista = new ArrayList();
				rs = (ResultSet) cstmt.getObject(1);
				while (rs.next())
				{
					ClienteDTO clienteDTO = new ClienteDTO();
					clienteDTO.setCodigoCategImpos(rs.getString(1));
					clienteDTO.setDescripcionCategImpos(rs.getString(2));

					lista.add(clienteDTO);
				}
				resultado = (ClienteDTO[]) ArrayUtl.copiaArregloTipoEspecifico(lista.toArray(), ClienteDTO.class);
			}
			if (cat.isDebugEnabled())
			{
				cat.debug(" Finalizo ejecución");
				cat.debug(" Recuperando salidas");
			}
		}
		catch (Exception e)
		{
			cat.error("Ocurrió un error al recuperar categorias impositivas", e);
			if (cat.isDebugEnabled())
			{
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
		}
		finally
		{
			if (cat.isDebugEnabled())
				cat.debug("Cerrando conexiones...");
			try
			{
				if (rs != null)
					rs.close();
				if (cstmt != null)
					cstmt.close();
				if (!conn.isClosed())
				{
					conn.close();
				}
			}
			catch (SQLException e)
			{
				cat.debug("SQLException", e);
			}
		}
		cat.debug("Fin:getListCategImpositivas()");
		return resultado;
	}// fin getListCategImpositivas


	/**
	 * Obtiene relacion cliente vendedor
	 * 
	 * @param entrada
	 * @return resultado
	 * @throws CustomerDomainException
	 */
	public ClienteDTO getClienteVendedor(ClienteDTO entrada) 
		throws CustomerDomainException
	{
		cat.debug("Inicio:getClienteVendedor");
		ClienteDTO resultado = new ClienteDTO();
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		cat.debug("Coneccion obtenida OK");
		CallableStatement cstmt = null;
		try
		{
			String call = getSQLDatosCliente("VE_alta_cliente_PG", "VE_getClienteVendedor_PR", 9);
			cat.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);

			cstmt.setString(1, entrada.getCodigoTipoIdentificacion());
			cstmt.setString(2, entrada.getNumeroIdentificacion());

			cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(6, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(7, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(8, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(9, java.sql.Types.NUMERIC);

			cat.debug("Iniico:getClienteVendedor:Execute");
			cstmt.execute();
			cat.debug("Fin:getClienteVendedor:Execute");

			codError = cstmt.getInt(7);
			msgError = cstmt.getString(8);
			numEvento = cstmt.getInt(9);

			if (codError != 0)
			{
				cat.error("Ocurrió un error al obtener relacion cliente vendedor");
				throw new CustomerDomainException("Ocurrió un error al obtener relacion cliente vendedor", String
						.valueOf(codError), numEvento, msgError);
			}
			else
			{
				resultado.setCodigoCategoria(cstmt.getString(3));
				resultado.setCodigoSector(cstmt.getInt(4));
				resultado.setCodigoSupervisor(cstmt.getInt(5));
				resultado.setCodigoVendedor(cstmt.getInt(6));
			}

			if (cat.isDebugEnabled())
			{
				cat.debug(" Finalizo ejecución");
				cat.debug(" Recuperando salidas");
			}
		}
		catch (Exception e)
		{
			cat.error("Ocurrió un error al obtener relacion cliente vendedor", e);
			if (cat.isDebugEnabled())
			{
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
		}
		finally
		{
			if (cat.isDebugEnabled())
				cat.debug("Cerrando conexiones...");
			try
			{
				if (cstmt != null)
					cstmt.close();
				if (!conn.isClosed())
				{
					conn.close();
				}
			}
			catch (SQLException e)
			{
				cat.debug("SQLException", e);
			}
		}
		cat.debug("Fin:getClienteVendedor()");
		return resultado;
	}// fin getClienteVendedor

	/**
	 * Obtiene codigo de la nueva empresa
	 * 
	 * @param N/A
	 * @return resultado
	 * @throws CustomerDomainException
	 */
	public ClienteDTO getCodigoNuevaEmpresa() 
		throws CustomerDomainException
	{
		cat.debug("Inicio:getCodigoNuevaEmpresa");
		ClienteDTO resultado = new ClienteDTO();
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		cat.debug("Coneccion obtenida OK");
		CallableStatement cstmt = null;
		try
		{
			String call = getSQLDatosCliente("VE_alta_cliente_PG", "getCodigoNuevaEmpresa", 4);
			cat.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);

			cstmt.registerOutParameter(1, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(2, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);

			cat.debug("Iniico:getCodigoNuevaEmpresa:Execute");
			cstmt.execute();
			cat.debug("Fin:getCodigoNuevaEmpresa:Execute");

			codError = cstmt.getInt(2);
			msgError = cstmt.getString(3);
			numEvento = cstmt.getInt(4);

			if (codError != 0)
			{
				cat.error("Ocurrió un error al obtener codigo nueva empresa");
				throw new CustomerDomainException("Ocurrió un error al obtener codigo nueva empresa", String
						.valueOf(codError), numEvento, msgError);
			}
			else
				resultado.setCodigoEmpresa(cstmt.getLong(1));

			if (cat.isDebugEnabled())
			{
				cat.debug(" Finalizo ejecución");
				cat.debug(" Recuperando salidas");
			}
		}
		catch (Exception e)
		{
			cat.error("Ocurrió un error al obtener codigo nueva empresa", e);
			if (cat.isDebugEnabled())
			{
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
		}
		finally
		{
			if (cat.isDebugEnabled())
				cat.debug("Cerrando conexiones...");
			try
			{
				if (cstmt != null)
					cstmt.close();
				if (!conn.isClosed())
				{
					conn.close();
				}
			}
			catch (SQLException e)
			{
				cat.debug("SQLException", e);
			}
		}
		cat.debug("Fin:getCodigoNuevaEmpresa()");
		return resultado;
	}// fin getCodigoNuevaEmpresa

	/**
	 * Obtiene nuevo codigo de cliente
	 * 
	 * @param N/A
	 * @return resultado
	 * @throws CustomerDomainException
	 */
	public ClienteDTO getNuevoCliente() 
		throws CustomerDomainException
	{
		cat.debug("Inicio:getNuevoCliente");
		ClienteDTO resultado = new ClienteDTO();
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null;
		cat.debug("Coneccion obtenida OK");
		try
		{
			String call = getSQLDatosCliente("VE_alta_cliente_PG", "VE_getNuevoCliente_PR", 4);
			cat.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);

			cstmt.registerOutParameter(1, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(2, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);

			cat.debug("Iniico:getNuevoCliente:Execute");
			cstmt.execute();
			cat.debug("Fin:getNuevoCliente:Execute");

			codError = cstmt.getInt(2);
			msgError = cstmt.getString(3);
			numEvento = cstmt.getInt(4);

			if (codError != 0)
			{
				cat.error("Ocurrió un error al obtener nuevo codigo de cliente");
				throw new CustomerDomainException("Ocurrió un error al obtener nuevo codigo de cliente", String
						.valueOf(codError), numEvento, msgError);
			}
			else
				resultado.setCodigoCliente(cstmt.getString(1));

			if (cat.isDebugEnabled())
			{
				cat.debug(" Finalizo ejecución");
				cat.debug(" Recuperando salidas");
			}
		}
		catch (Exception e)
		{
			cat.error("Ocurrió un error al obtener nuevo codigo de cliente", e);
			if (cat.isDebugEnabled())
			{
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
		}
		finally
		{
			if (cat.isDebugEnabled())
				cat.debug("Cerrando conexiones...");
			try
			{
				if (cstmt != null)
					cstmt.close();
				if (!conn.isClosed())
				{
					conn.close();
				}
			}
			catch (SQLException e)
			{
				cat.debug("SQLException", e);
			}
		}
		cat.debug("Fin:getNuevoCliente()");
		return resultado;
	}// fin getNuevoCliente

	/**
	 * Inserta cliente
	 * 
	 * @param cliente
	 * @return N/A
	 * @throws CustomerDomainException
	 */
	public void insCliente(ClienteAltaDTO cliente) 
		throws CustomerDomainException
	{
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null;
		try
		{
			cat.debug("Inicio:insCliente");

			String call = getSQLDatosCliente("VE_alta_cliente_PG", "VE_insCliente_PR", 97);
			cat.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);

			cstmt.setString(1, cliente.getCodigoCliente());
			cat.debug("cliente.getCodigoCliente(): " + cliente.getCodigoCliente());
			cstmt.setString(2, cliente.getNombreCliente());
			cat.debug("cliente.getNombreCliente(): " + cliente.getNombreCliente());
			cstmt.setString(3, cliente.getCodigoTipoIdentificacion());
			cat.debug("cliente.getCodigoTipoIdentificacion(): " + cliente.getCodigoTipoIdentificacion());
			cstmt.setString(4, cliente.getNumeroIdentificacion());
			cat.debug("cliente.getNumeroIdentificacion(): " + cliente.getNumeroIdentificacion());
			cstmt.setString(5, cliente.getCodigoCalidadCliente());
			cat.debug("cliente.getCodigoCalidadCliente(): " + cliente.getCodigoCalidadCliente());
			cstmt.setString(6, cliente.getIndicadorSituacion());
			cat.debug("cliente.getIndicadorSituacion(): " + cliente.getIndicadorSituacion());
			cstmt.setString(7, String.valueOf(cliente.getIndicativoFacturable()));
			cat.debug("cliente.getIndicativoFacturable(): " + cliente.getIndicativoFacturable());
			cstmt.setString(8, cliente.getIndicadorTraspaso());
			cat.debug("cliente.getIndicadorTraspaso(): " + cliente.getIndicadorTraspaso());
			cstmt.setString(9, cliente.getIndicadorAgente());
			cat.debug("cliente.getIndicadorAgente(): " + cliente.getIndicadorAgente());
			cstmt.setString(10, cliente.getNumeroFax());
			cat.debug("cliente.getNumeroFax(): " + cliente.getNumeroFax());
			cstmt.setString(11, cliente.getIndicadorMandato());
			cat.debug("cliente.getIndicadorMandato(): " + cliente.getIndicadorMandato());
			cstmt.setString(12, cliente.getNombreUsuarOra());
			cat.debug("cliente.getNombreUsuarOra(): " + cliente.getNombreUsuarOra());
			cstmt.setString(13, cliente.getIndicadorAlta());
			cat.debug("cliente.getIndicadorAlta(): " + cliente.getIndicadorAlta());
			cstmt.setString(14, cliente.getCodigoCuenta());
			cat.debug("cliente.getCodigoCuenta(): " + cliente.getCodigoCuenta());
			cstmt.setString(15, cliente.getIndicadorAcepVenta());
			cat.debug("cliente.getIndicadorAcepVenta(): " + cliente.getIndicadorAcepVenta());
			cstmt.setString(16, cliente.getCodigoABC());
			cat.debug("cliente.getCodigoABC(): " + cliente.getCodigoABC());
			cstmt.setString(17, cliente.getCodigo123());
			cat.debug("cliente.getCodigo123(): " + cliente.getCodigo123());
			cstmt.setString(18, cliente.getCodigoActividad());
			cat.debug("cliente.getCodigoActividad(): " + cliente.getCodigoActividad());
			cstmt.setString(19, cliente.getCodigoPais());
			cat.debug("cliente.getCodigoPais()): " + cliente.getCodigoPais());
			cstmt.setString(20, cliente.getNumeroTelefono1());
			cat.debug("cliente.getNumeroTelefono1(): " + cliente.getNumeroTelefono1());
			cstmt.setString(21, cliente.getNumeroAbocel());
			cat.debug("cliente.getNumeroAbocel(): " + cliente.getNumeroAbocel());
			cstmt.setString(22, cliente.getNumeroTelefono2());
			cat.debug("cliente.getNumeroTelefono2(): " + cliente.getNumeroTelefono2());
			cstmt.setString(23, cliente.getNumeroAbobeep());
			cat.debug("cliente.getNumeroAbobeep(): " + cliente.getNumeroAbobeep());
			cstmt.setString(24, cliente.getIndicadorDebito());
			cat.debug("cliente.getIndicadorDebito(): " + cliente.getIndicadorDebito());
			cstmt.setString(25, cliente.getNumeroAbotrunk());
			cat.debug("cliente.getNumeroAbotrunk(): " + cliente.getNumeroAbotrunk());
			cstmt.setString(26, cliente.getCodigoProspecto());
			cat.debug("cliente.getCodigoProspecto(): " + cliente.getCodigoProspecto());
			cstmt.setString(27, cliente.getNumeroAbotrek());
			cat.debug("cliente.getNumeroAbotrek(): " + cliente.getNumeroAbotrek());
			cstmt.setString(28, cliente.getCodigoSistemaPago());
			cat.debug("cliente.getCodigoSistemaPago(): " + cliente.getCodigoSistemaPago());
			cstmt.setString(29, cliente.getNombreApellido1());
			cat.debug("cliente.getNombreApellido1(): " + cliente.getNombreApellido1());
			cstmt.setString(30, cliente.getDireccionEMail());
			cat.debug("cliente.getDireccionEMail(): " + cliente.getDireccionEMail());
			cstmt.setString(31, cliente.getNumeroAborent());
			cat.debug("cliente.getNumeroAborent(): " + cliente.getNumeroAborent());
			cstmt.setString(32, cliente.getNombreApellido2());
			cat.debug("cliente.getNombreApellido2(): " + cliente.getNombreApellido2());
			cstmt.setString(33, cliente.getNumeroAboroaming());
			cat.debug("cliente.getNumeroAboroaming(): " + cliente.getNumeroAboroaming());
			cstmt.setString(34, cliente.getFechaAcepVenta());
			cat.debug("cliente.getFechaAcepVenta(): " + cliente.getFechaAcepVenta());
			cstmt.setString(35, cliente.getImporteLimiteDebito());
			cat.debug("cliente.getImporteLimiteDebito(): " + cliente.getImporteLimiteDebito());
			cstmt.setString(36, cliente.getCodigoBanco());
			cat.debug("cliente.getCodigoBanco(): " + cliente.getCodigoBanco());
			cstmt.setString(37, cliente.getCodigoSucursal());
			cat.debug("cliente.getCodigoSucursal(): " + cliente.getCodigoSucursal());
			cstmt.setString(38, cliente.getIndicadorTipoCuenta());
			cat.debug("cliente.getIndicadorTipoCuenta(): " + cliente.getIndicadorTipoCuenta());
			cstmt.setString(39, cliente.getCodigoTipoTarjeta());
			cat.debug("cliente.getCodigoTipoTarjeta(): " + cliente.getCodigoTipoTarjeta());
			cstmt.setString(40, cliente.getNumeroCuentaCorriente());
			cat.debug("cliente.getNumeroCuentaCorriente(): " + cliente.getNumeroCuentaCorriente());
			cstmt.setString(41, cliente.getNumeroTarjeta());
			cat.debug("cliente.getNumeroTarjeta(): " + cliente.getNumeroTarjeta());
			cstmt.setString(42, cliente.getFechaVencimientoTarjeta());
			cat.debug("cliente.getFechaVencimientoTarjeta(): " + cliente.getFechaVencimientoTarjeta());
			cstmt.setString(43, cliente.getCodigoBancoTarjeta());
			cat.debug("cliente.getCodigoBancoTarjeta(): " + cliente.getCodigoBancoTarjeta());
			cstmt.setString(44, cliente.getCodigoTipoIdentificacionTributaria());
			cat.debug("cliente.getCodigoTipoIdentificacionTributaria(): "
					+ cliente.getCodigoTipoIdentificacionTributaria());
			cstmt.setString(45, cliente.getNumeroIdentificacionTributaria());
			cat.debug("cliente.getNumeroIdentificacionTributaria(): " + cliente.getNumeroIdentificacionTributaria());
			cstmt.setString(46, cliente.getCodigoTipoIdentificacionApoderado());
			cat.debug("cliente.getCodigoTipoIdentificacionApoderado(): "
					+ cliente.getCodigoTipoIdentificacionApoderado());
			cstmt.setString(47, cliente.getNumeroIdentificacionApoderado());
			cat.debug("cliente.getNumeroIdentificacionApoderado(): " + cliente.getNumeroIdentificacionApoderado());
			cstmt.setString(48, cliente.getNombreApoderado());
			cat.debug("cliente.getNombreApoderado(): " + cliente.getNombreApoderado());
			cstmt.setString(49, cliente.getCodigoOficina());
			cat.debug("cliente.getCodigoOficina(): " + cliente.getCodigoOficina());
			cstmt.setString(50, cliente.getFechaBaja());
			cat.debug("cliente.getFechaBaja(): " + cliente.getFechaBaja());
			cstmt.setString(51, cliente.getCodigoCobrador());
			cat.debug("cliente.getCodigoCobrador(): " + cliente.getCodigoCobrador());
			cstmt.setString(52, cliente.getCodigoPincli());
			cat.debug("cliente.getCodigoPincli(): " + cliente.getCodigoPincli());
			cstmt.setString(53, cliente.getCodigoCicloFacturacion());
			cat.debug("cliente.getCodigoCicloFacturacion(): " + cliente.getCodigoCicloFacturacion());
			cstmt.setString(54, cliente.getNumeroCelular());
			cat.debug("cliente.getNumeroCelular(): " + cliente.getNumeroCelular());
			cstmt.setString(55, cliente.getIndicadirTipPersona());
			cat.debug("cliente.getIndicadirTipPersona(): " + cliente.getIndicadirTipPersona());
			cstmt.setString(56, cliente.getCodigoCicloNuevo());
			cat.debug("cliente.getCodigoCicloNuevo(): " + cliente.getCodigoCicloNuevo());
			cstmt.setString(57, cliente.getCodigoCategoria());
			cat.debug("cliente.getCodigoCategoriaEmpresa(): " + cliente.getCodigoCategoria());
			cstmt.setString(58, cliente.getCodigoSector() != 0 ? String.valueOf(cliente.getCodigoSector()) : null);
			cat.debug("cliente.getCodigoSector(): " + cliente.getCodigoSector());
			cstmt.setString(59, String.valueOf(cliente.getCodigoSupervisor()));
			cat.debug("cliente.getCodigoSupervisor(): " + cliente.getCodigoSupervisor());
			cstmt.setString(60, cliente.getIndicadorEstadoCivil());
			cat.debug("cliente.getIndicadorEstadoCivil(): " + cliente.getIndicadorEstadoCivil());
			cstmt.setString(61, cliente.getFechaNacimiento());
			cat.debug("cliente.getFechaNacimiento(): " + cliente.getFechaNacimiento());
			cstmt.setString(62, cliente.getIndicadorSexo());
			cat.debug("cliente.getIndicadorSexo(): " + cliente.getIndicadorSexo());
			cstmt.setString(63, cliente.getNumeroIntGrupoFam());
			cat.debug("cliente.getNumeroIntGrupoFam(): " + cliente.getNumeroIntGrupoFam());
			cstmt.setString(64, cliente.getCodigoNPI());
			cat.debug("cliente.getCodigoNPI(): " + cliente.getCodigoNPI());
			cstmt.setString(65, cliente.getCodigoSubCategoria());
			cat.debug("cliente.getCodigoSubCategoria(): " + cliente.getCodigoSubCategoria());
			cstmt.setString(66, cliente.getCodigoUso());
			cat.debug("cliente.getCodigoUso(): " + cliente.getCodigoUso());
			cstmt.setString(67, cliente.getCodigoIdioma());
			cat.debug("cliente.getCodigoIdioma(): " + cliente.getCodigoIdioma());
			cstmt.setString(68, cliente.getCodigoTipIdent2());
			cat.debug("cliente.getCodigoTipIdent2(): " + cliente.getCodigoTipIdent2());
			cstmt.setString(69, cliente.getNumIdent2());
			cat.debug("cliente.getNumIdent2(): " + cliente.getNumIdent2());
			cstmt.setString(70, cliente.getNombreUsuarioAsesor());
			cat.debug("cliente.getNombreUsuarioAsesor(): " + cliente.getNombreUsuarioAsesor());
			cstmt.setString(71, cliente.getCodigoOperadora());
			cat.debug("cliente.getCodigoOperadora(): " + cliente.getCodigoOperadora());
			cstmt.setString(72, cliente.getIndentificadorSegmento());
			cat.debug("cliente.getIndentificadorSegmento(): " + cliente.getIndentificadorSegmento());

			// Parametros nuevos Guatemala - El Salvador
			cstmt.setString(73, cliente.getNomConyuge());
			cat.debug("cliente.getNomConyuge(): " + cliente.getNomConyuge());
			cstmt.setString(74, cliente.getCodOperadoraAnterior());
			cat.debug("cliente.getCodOperadoraAnterior(): " + cliente.getCodOperadoraAnterior());
			cstmt.setString(75, cliente.getMensajePromocional());
			cat.debug("cliente.getMensajePromocional(): " + cliente.getMensajePromocional());
			cstmt.setString(76, cliente.getCodigoActividad());
			cat.debug("cliente.getCodigoActividad(): " + cliente.getCodigoActividad());
			cstmt.setString(77, cliente.getNomEmpresaTrabaja());
			cat.debug("cliente.getNomEmpresaTrabaja(): " + cliente.getNomEmpresaTrabaja());
			cstmt.setString(78, cliente.getTelefonoOficina());
			cat.debug("cliente.getTelefonoOficina(): " + cliente.getTelefonoOficina());
			cstmt.setString(79, cliente.getCodCargo());
			cat.debug("cliente.getCodCargo(): " + cliente.getCodCargo());
			cstmt.setDouble(80, cliente.getIngresosMensuales());
			cat.debug("cliente.getIngresosMensuales(): " + cliente.getIngresosMensuales());
			cstmt.setString(81, cliente.getJefeInmediato());
			cat.debug("cliente.getJefeInmediato(): " + cliente.getJefeInmediato());
			if (cliente.getCant_antLaborando() != null)
			{
				cstmt.setLong(82, cliente.getCant_antLaborando().longValue());
			}
			else
				cstmt.setLong(82, 0);
			cat.debug("cliente.getCant_antLaborando(): " + cliente.getCant_antLaborando());
			cstmt.setString(83, cliente.getNombreReferenciaI());
			cat.debug("cliente.getNombreReferenciaI(): " + cliente.getNombreReferenciaI());
			cstmt.setString(84, cliente.getNumeroReferenciaI());
			cat.debug("cliente.getNumeroReferenciaI(): " + cliente.getNumeroReferenciaI());
			cstmt.setString(85, cliente.getNombreReferenciaII());
			cat.debug("cliente.getNombreReferenciaII(): " + cliente.getNombreReferenciaII());
			cstmt.setString(86, cliente.getNumeroReferenciaII());
			cat.debug("cliente.getNumeroReferenciaII(): " + cliente.getNumeroReferenciaII());
			cstmt.setString(87, cliente.getCodigoTipoCliente());
			cat.debug("cliente.getTipoCliente(): " + cliente.getCodigoTipoCliente());
			cstmt.setString(88, cliente.getCodColor());
			cat.debug("cliente.getCodColor(): " + cliente.getCodColor());
			cstmt.setString(89, cliente.getCodCrediticia());
			cat.debug("cliente.getCodCrediticia(): " + cliente.getCodCrediticia());
			cstmt.setString(90, cliente.getCodSegmento());
			cat.debug("cliente.getCodSegmento(): " + cliente.getCodSegmento());
			cstmt.setString(91, cliente.getCodCalificacion());
			cat.debug("cliente.getCodSegmento(): " + cliente.getCodCalificacion());
			cstmt.setString(92, cliente.getNomTipTarjeta());
			cat.debug("cliente.getNomTipTarjeta(): " + cliente.getNomTipTarjeta());
			cstmt.setString(93, cliente.getObsPac());
			cat.debug("cliente.getObsPac(): " + cliente.getObsPac());
			cstmt.setString(94, cliente.getFacturaElectronica());
			cat.debug("cliente.getFacturaElectronica(): " + cliente.getFacturaElectronica());
			cstmt.registerOutParameter(95, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(96, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(97, java.sql.Types.NUMERIC);

			cat.debug("Inicio:insCliente:execute");
			cstmt.execute();
			cat.debug("Fin:insCliente:execute");

			codError = cstmt.getInt(95);
			msgError = cstmt.getString(96);
			numEvento = cstmt.getInt(97);

			if (codError != 0)
			{
				cat.error("Ocurrió un error al insertar registro de cliente");
				throw new CustomerDomainException("Ocurrió un error al insertar registro de cliente", String
						.valueOf(codError), numEvento, msgError);
			}
		}
		catch (Exception e)
		{
			cat.error("Ocurrió un error al insertar registro de modificación del cliente", e);
			if (cat.isDebugEnabled())
			{
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
			if (e instanceof CustomerDomainException)
				throw (CustomerDomainException) e;
		}
		finally
		{
			if (cat.isDebugEnabled())
				cat.debug("Cerrando conexiones...");
			try
			{
				if (cstmt != null)
					cstmt.close();
				if (!conn.isClosed())
				{
					conn.close();
				}
			}
			catch (SQLException e)
			{
				cat.debug("SQLException", e);
			}
		}
		cat.debug("Fin:insCliente()");
	}// fin insCliente

	/**
	 * Inserta cliente
	 * 
	 * @param cliente
	 * @return N/A
	 * @throws CustomerDomainException
	 */
	public void insSegmentacion(ClienteDTO cliente) 
		throws CustomerDomainException
	{
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null;
		try
		{
			cat.debug("Inicio:insSegmentacion");

			String call = getSQLDatosCliente("VE_alta_cliente_PG", "VE_insSegmentacion_PR", 5);
			cat.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);

			cstmt.setString(1, cliente.getCodigoCliente());
			cat.debug("cliente.getCodigoCliente(): " + cliente.getCodigoCliente());
			cstmt.setString(2, cliente.getTipoPlanDestino());
			cat.debug("cliente.getTipoPlanDestino(): " + cliente.getTipoPlanDestino());

			cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);

			cat.debug("Inicio:insSegmentacion:execute");
			cstmt.execute();
			cat.debug("Fin:insSegmentacion:execute");

			codError = cstmt.getInt(3);
			msgError = cstmt.getString(4);
			numEvento = cstmt.getInt(5);

			if (codError != 0)
			{
				cat.error("Ocurrió un error al insertar segmentacion del cliente");
				throw new CustomerDomainException("Ocurrió un error al insertar segmentacion del cliente", String
						.valueOf(codError), numEvento, msgError);
			}
		}
		catch (Exception e)
		{
			cat.error("Ocurrió un error al insertar registro de modificación del cliente", e);
			if (cat.isDebugEnabled())
			{
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
			if (e instanceof CustomerDomainException)
				throw (CustomerDomainException) e;
		}
		finally
		{
			if (cat.isDebugEnabled())
				cat.debug("Cerrando conexiones...");
			try
			{
				if (cstmt != null)
					cstmt.close();
				if (!conn.isClosed())
				{
					conn.close();
				}
			}
			catch (SQLException e)
			{
				cat.debug("SQLException", e);
			}
		}
		cat.debug("Fin:insSegmentacion()");
	}// fin insSegmentacion

	// Fin Inc. 72269 3-11-2008

	/**
	 * Actualiza categoria del cliente
	 * 
	 * @param cliente
	 * @return N/A
	 * @throws CustomerDomainException
	 */
	public void updCategCliente(ClienteDTO cliente)
		throws CustomerDomainException
	{
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null;
		try
		{
			cat.debug("Inicio:updCategCliente");

			String call = getSQLDatosCliente("VE_alta_cliente_PG", "VE_updCategCliente_PR", 5);
			cat.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);
			cat.debug("cliente.getCodigoCliente(): " + cliente.getCodigoCliente());
			cstmt.setString(1, cliente.getCodigoCliente());
			cat.debug("cliente.getCodigoCategoria(): " + cliente.getCodigoCategoria());
			cstmt.setString(2, String.valueOf(cliente.getCodigoCategoria()));

			cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);

			cat.debug("Inicio:updCategCliente:execute");
			cstmt.execute();
			cat.debug("Fin:updCategCliente:execute");

			codError = cstmt.getInt(3);
			msgError = cstmt.getString(4);
			numEvento = cstmt.getInt(5);

			if (codError != 0)
			{
				cat.error("Ocurrió un error al actualizar categoria del cliente");
				throw new CustomerDomainException("Ocurrió un error al actualizar categoria del cliente", String
						.valueOf(codError), numEvento, msgError);
			}

		}
		catch (Exception e)
		{
			cat.error("Ocurrió un error al actualizar categoria del cliente", e);
			if (cat.isDebugEnabled())
			{
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
		}
		finally
		{
			if (cat.isDebugEnabled())
				cat.debug("Cerrando conexiones...");
			try
			{
				if (cstmt != null)
					cstmt.close();
				if (!conn.isClosed())
				{
					conn.close();
				}
			}
			catch (SQLException e)
			{
				cat.debug("SQLException", e);
			}
		}
		cat.debug("Fin:updCategCliente()");
	}// fin updCategCliente

	/**
	 * Inserta registro en tabla GE_MODCLI
	 * 
	 * @param cliente
	 * @return N/A
	 * @throws CustomerDomainException
	 */
	public void setModificacionCliente(ClienteAltaDTO cliente) 
		throws CustomerDomainException
	{
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null;
		try
		{
			cat.debug("Inicio:setModificacionCliente");

			String call = getSQLDatosCliente("VE_alta_cliente_PG", "VE_insModCliente_PR", 59);
			cat.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);

			cstmt.setString(1, cliente.getCodigoCliente());
			cat.debug("cliente.getCodigoCliente(): " + cliente.getCodigoCliente());
			cstmt.setString(2, cliente.getCodigoModificacion());
			cat.debug("cliente.getCodigoModificacion(): " + cliente.getCodigoModificacion());
			cstmt.setString(3, null);
			cat.debug("fecha modificacion: null");
			cstmt.setString(4, cliente.getNombreUsuarOra());
			cat.debug("cliente.getNombreUsuarOra(): " + cliente.getNombreUsuarOra());
			cstmt.setString(5, cliente.getNombreCliente());
			cat.debug("cliente.getNombreCliente(): " + cliente.getNombreCliente());
			cstmt.setString(6, cliente.getCodigoTipoIdentificacion());
			cat.debug("cliente.getCodigoTipoIdentificacion(): " + cliente.getCodigoTipoIdentificacion());
			cstmt.setString(7, cliente.getNumeroIdentificacion());
			cat.debug("cliente.getNumeroIdentificacion(): " + cliente.getNumeroIdentificacion());
			cstmt.setString(8, cliente.getCodigoCalidadCliente());
			cat.debug("cliente.getCodigoCalidadCliente(): " + cliente.getCodigoCalidadCliente());
			cstmt.setString(9, cliente.getCodigoPlanComercial());
			cat.debug("cliente.getCodigoPlanComercial(): " + cliente.getCodigoPlanComercial());
			cstmt.setString(10, String.valueOf(cliente.getIndicativoFacturable()));
			cat.debug("cliente.getIndicativoFacturable(): " + cliente.getIndicativoFacturable());
			cstmt.setString(11, cliente.getIndicadorTraspaso());
			cat.debug("cliente.getIndicadorTraspaso(): " + cliente.getIndicadorTraspaso());
			cstmt.setString(12, cliente.getCodigoActividad());
			cat.debug("cliente.getCodigoActividad(): " + cliente.getCodigoActividad());
			cstmt.setString(13, cliente.getCodigoPais());
			cat.debug("cliente.getCodigoPais()): " + cliente.getCodigoPais());
			cstmt.setString(14, cliente.getNumeroTelefono1());
			cat.debug("cliente.getNumeroTelefono1(): " + cliente.getNumeroTelefono1());
			cstmt.setString(15, cliente.getNumeroTelefono2());
			cat.debug("cliente.getNumeroTelefono2(): " + cliente.getNumeroTelefono2());
			cstmt.setString(16, cliente.getNumeroFax());
			cat.debug("cliente.getNumeroFax(): " + cliente.getNumeroFax());
			cstmt.setString(17, cliente.getIndicadorDebito());
			cat.debug("cliente.getIndicadorDebito(): " + cliente.getIndicadorDebito());
			cstmt.setString(18, cliente.getCodigoSistemaPago());
			cat.debug("cliente.getCodigoSistemaPago(): " + cliente.getCodigoSistemaPago());
			cstmt.setString(19, cliente.getNombreApellido1());
			cat.debug("cliente.getNombreApellido1(): " + cliente.getNombreApellido1());
			cstmt.setString(20, cliente.getNombreApellido2());
			cat.debug("cliente.getNombreApellido2(): " + cliente.getNombreApellido2());
			cstmt.setString(21, cliente.getImporteLimiteDebito());
			cat.debug("cliente.getImporteLimiteDebito(): " + cliente.getImporteLimiteDebito());
			cstmt.setString(22, cliente.getCodigoBanco());
			cat.debug("cliente.getCodigoBanco(): " + cliente.getCodigoBanco());
			cstmt.setString(23, cliente.getCodigoSucursal());
			cat.debug("cliente.getCodigoSucursal(): " + cliente.getCodigoSucursal());
			cstmt.setString(24, cliente.getIndicadorTipoCuenta());
			cat.debug("cliente.getIndicadorTipoCuenta(): " + cliente.getIndicadorTipoCuenta());
			cstmt.setString(25, cliente.getCodigoTipoTarjeta());
			cat.debug("cliente.getCodigoTipoTarjeta(): " + cliente.getCodigoTipoTarjeta());
			cstmt.setString(26, cliente.getNumeroCuentaCorriente());
			cat.debug("cliente.getNumeroCuentaCorriente(): " + cliente.getNumeroCuentaCorriente());
			cstmt.setString(27, cliente.getNumeroTarjeta());
			cat.debug("cliente.getNumeroTarjeta(): " + cliente.getNumeroTarjeta());
			cstmt.setString(28, cliente.getFechaVencimientoTarjeta());
			cat.debug("cliente.getFechaVencimientoTarjeta(): " + cliente.getFechaVencimientoTarjeta());
			cstmt.setString(29, cliente.getCodigoBancoTarjeta());
			cat.debug("cliente.getCodigoBancoTarjeta(): " + cliente.getCodigoBancoTarjeta());
			cstmt.setString(30, cliente.getCodigoTipoIdentificacionTributaria());
			cat.debug("cliente.getCodigoTipoIdentificacionTributaria(): "
					+ cliente.getCodigoTipoIdentificacionTributaria());
			cstmt.setString(31, cliente.getNumeroIdentificacionTributaria());
			cat.debug("cliente.getNumeroIdentificacionTributaria(): " + cliente.getNumeroIdentificacionTributaria());
			cstmt.setString(32, cliente.getCodigoTipoIdentificacionApoderado());
			cat.debug("cliente.getCodigoTipoIdentificacionApoderado(): "
					+ cliente.getCodigoTipoIdentificacionApoderado());
			cstmt.setString(33, cliente.getNumeroIdentificacionApoderado());
			cat.debug("cliente.getNumeroIdentificacionApoderado(): " + cliente.getNumeroIdentificacionApoderado());
			cstmt.setString(34, cliente.getNombreApoderado());
			cat.debug("cliente.getNombreApoderado(): " + cliente.getNombreApoderado());
			cstmt.setString(35, cliente.getCodigoOficina());
			cat.debug("cliente.getCodigoOficina(): " + cliente.getCodigoOficina());
			cstmt.setString(36, cliente.getCodigoIdentificacionCliente());
			cat.debug("cliente.getCodigoIdentificacionCliente(): " + cliente.getCodigoIdentificacionCliente());
			cstmt.setString(37, cliente.getDireccionEMail());
			cat.debug("cliente.getDireccionEMail(): " + cliente.getDireccionEMail());
			cstmt.setString(38, cliente.getCodigoCicloFacturacion());
			cat.debug("cliente.getCodigoCicloFacturacion(): " + cliente.getCodigoCicloFacturacion());
			cstmt.setString(39, cliente.getCodigoCategoria());
			cat.debug("cliente.getCodigoCategoriaEmpresa(): " + cliente.getCodigoCategoria());
			cstmt.setString(40, String.valueOf(cliente.getCodigoSector()));
			cat.debug("cliente.getCodigoSector(): " + cliente.getCodigoSector());
			cstmt.setString(41, String.valueOf(cliente.getCodigoSupervisor()));
			cat.debug("cliente.getCodigoSupervisor(): " + cliente.getCodigoSupervisor());
			cstmt.setString(42, cliente.getIndicadorPrivacidad());
			cat.debug("cliente.getIndicadorPrivacidad(): " + cliente.getIndicadorPrivacidad());
			cstmt.setString(43, String.valueOf(cliente.getCodigoEmpresa()));
			cat.debug("cliente.getCodigoEmpresa(): " + cliente.getCodigoEmpresa());
			cstmt.setString(44, cliente.getTipoPlanTarifario());
			cat.debug("cliente.getTipoPlanTarifario(): " + cliente.getTipoPlanTarifario());
			cstmt.setString(45, cliente.getCodigoPlanTarifario());
			cat.debug("cliente.getCodigoPlanTarifario(): " + cliente.getCodigoPlanTarifario());
			cstmt.setString(46, cliente.getCodigoCargoBasico());
			cat.debug("cliente.getCodigoCargoBasico(): " + cliente.getCodigoCargoBasico());
			cstmt.setString(47, cliente.getNumeroOrdenServicio());
			cat.debug("cliente.getNumeroOrdenServicio(): " + cliente.getNumeroOrdenServicio());
			cstmt.setString(48, cliente.getNumeroCiclos());
			cat.debug("cliente.getNumeroCiclos(): " + cliente.getNumeroCiclos());
			cstmt.setString(49, cliente.getNumeroMinutos());
			cat.debug("cliente.getNumeroMinutos(): " + cliente.getNumeroMinutos());
			cstmt.setString(50, cliente.getCodigoIdioma());
			cat.debug("cliente.getCodigoIdioma(): " + cliente.getCodigoIdioma());
			cstmt.setString(51, cliente.getCodigoTipIdent2());
			cat.debug("cliente.getCodigoTipIdent2(): " + cliente.getCodigoTipIdent2());
			cstmt.setString(52, cliente.getNumIdent2());
			cat.debug("cliente.getNumIdent2(): " + cliente.getNumIdent2());
			cstmt.setString(53, cliente.getCodigoPlaza());
			cat.debug("cliente.getCodigoPlaza(): " + cliente.getCodigoPlaza());
			cstmt.setString(54, cliente.getDescripcionReferenciaDocumento());
			cat.debug("cliente.getDescripcionReferenciaDocumento(): " + cliente.getDescripcionReferenciaDocumento());
			cstmt.setString(55, cliente.getCodigoLimiteConsumo());
			cat.debug("cliente.getCodigoLimiteConsumo(): " + cliente.getCodigoLimiteConsumo());
			cstmt.setString(56, cliente.getCodigoSubCategoria());
			cat.debug("cliente.getCodigoSubCategoria(): " + cliente.getCodigoSubCategoria());
			cstmt.registerOutParameter(57, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(58, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(59, java.sql.Types.NUMERIC);

			cat.debug("Inicio:setModificacionCliente:execute");
			cstmt.execute();
			cat.debug("Fin:setModificacionCliente:execute");

			codError = cstmt.getInt(57);
			msgError = cstmt.getString(58);
			numEvento = cstmt.getInt(59);

			if (codError != 0)
			{
				cat.error("Ocurrió un error al insertar registro de modificación del cliente");
				throw new CustomerDomainException("Ocurrió un error al insertar registro de modificación del cliente",
						String.valueOf(codError), numEvento, msgError);
			}

		}
		catch (Exception e)
		{
			cat.error("Ocurrió un error al insertar registro de modificación del cliente", e);
			if (cat.isDebugEnabled())
			{
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
			if (e instanceof CustomerDomainException)
				throw (CustomerDomainException) e;
		}
		finally
		{
			if (cat.isDebugEnabled())
				cat.debug("Cerrando conexiones...");
			try
			{
				if (cstmt != null)
					cstmt.close();
				if (!conn.isClosed())
				{
					conn.close();
				}
			}
			catch (SQLException e)
			{
				cat.debug("SQLException", e);
			}
		}
		cat.debug("Fin:setModificacionCliente()");
	}// fin setModificacionCliente

	/**
	 * Inserta registro en tabla GA_CLIENTE_PCOM
	 * 
	 * @param cliente
	 * @return N/A
	 * @throws CustomerDomainException
	 */
	public void setClientePlanComercial(ClienteAltaDTO cliente) 
		throws CustomerDomainException
	{
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null;
		try
		{
			cat.debug("Inicio:setClientePlanComercial");

			String call = getSQLDatosCliente("VE_alta_cliente_PG", "VE_insPlanComCliente_PR", 6);
			cat.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);

			cstmt.setString(1, cliente.getCodigoCliente());
			cat.debug("cliente.getCodigoCliente(): " + cliente.getCodigoCliente());
			cstmt.setString(2, cliente.getCodigoPlanComercial());
			cat.debug("cliente.getCodigoPlanComercial(): " + cliente.getCodigoPlanComercial());
			cstmt.setString(3, cliente.getNombreUsuarOra());
			cat.debug("cliente.getNombreUsuarOra(): " + cliente.getNombreUsuarOra());
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(5, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(6, java.sql.Types.NUMERIC);

			cat.debug("Inicio:setClientePlanComercial:execute");
			cstmt.execute();
			cat.debug("Fin:setClientePlanComercial:execute");

			codError = cstmt.getInt(4);
			msgError = cstmt.getString(5);
			numEvento = cstmt.getInt(6);

			if (codError != 0)
			{
				cat.error("Ocurrió un error al insertar registro en plan comercial");
				throw new CustomerDomainException("Ocurrió un error al insertar registro en plan comercial", String
						.valueOf(codError), numEvento, msgError);
			}

		}
		catch (Exception e)
		{
			cat.error("Ocurrió un error al insertar registroen plan comercial", e);
			if (cat.isDebugEnabled())
			{
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
			if (e instanceof CustomerDomainException)
				throw (CustomerDomainException) e;
		}
		finally
		{
			if (cat.isDebugEnabled())
				cat.debug("Cerrando conexiones...");
			try
			{
				if (cstmt != null)
					cstmt.close();
				if (!conn.isClosed())
				{
					conn.close();
				}
			}
			catch (SQLException e)
			{
				cat.debug("SQLException", e);
			}
		}
		cat.debug("Fin:setClientePlanComercial()");
	}// fin setClientePlanComercial

	/**
	 * Inserta registro en tabla GA_RESPCLIENTES (Resonsables del cliente)
	 * 
	 * @param cliente
	 * @return N/A
	 * @throws CustomerDomainException
	 */
	public void setResponsablesDelCliente(ClienteAltaDTO cliente)
		throws CustomerDomainException
	{
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null;
		try
		{
			cat.debug("Inicio:setResponsablesDelCliente");

			String call = getSQLDatosCliente("VE_alta_cliente_PG", "VE_insRespCliente_PR", 11);
			cat.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);

			cstmt.setString(1, cliente.getCodigoCliente());
			cat.debug("cliente.getCodigoCliente(): " + cliente.getCodigoCliente());

			cstmt.setString(2, String.valueOf(cliente.getNumeroOrdenRepresentanteLegal()));
			cat.debug("cliente.getNumeroOrdenRepresentante(): " + cliente.getNumeroOrdenRepresentanteLegal());

			cstmt.setString(3, cliente.getRepresentanteLegalComDTO()[cliente.getNumeroOrdenRepresentanteLegal() - 1]
					.getCodigoTipoIdentificacion());
			cat.debug("cliente.getCodigoTipoIdentificacion(): "
					+ cliente.getRepresentanteLegalComDTO()[cliente.getNumeroOrdenRepresentanteLegal() - 1]
							.getCodigoTipoIdentificacion());

			cstmt.setString(4, cliente.getRepresentanteLegalComDTO()[cliente.getNumeroOrdenRepresentanteLegal() - 1]
					.getNumeroTipoIdentificacion());
			cat.debug("cliente.getNumeroTipoIdentificacion(): "
					+ cliente.getRepresentanteLegalComDTO()[cliente.getNumeroOrdenRepresentanteLegal() - 1]
							.getNumeroTipoIdentificacion());
			cstmt.setString(5, cliente.getRepresentanteLegalComDTO()[cliente.getNumeroOrdenRepresentanteLegal() - 1]
					.getNombre());
			cat
					.debug("cliente.getNombre(): "
							+ cliente.getRepresentanteLegalComDTO()[cliente.getNumeroOrdenRepresentanteLegal() - 1]
									.getNombre());

			// Valores neuvos GUATEMALA - EL SALVADOR
			cstmt.setString(6, cliente.getRepresentanteLegalComDTO()[cliente.getNumeroOrdenRepresentanteLegal() - 1]
					.getApellido1());
			cat.debug("cliente.getApellido1(): "
					+ cliente.getRepresentanteLegalComDTO()[cliente.getNumeroOrdenRepresentanteLegal() - 1]
							.getApellido1());
			cstmt.setString(7, cliente.getRepresentanteLegalComDTO()[cliente.getNumeroOrdenRepresentanteLegal() - 1]
					.getApellido2());
			cat.debug("cliente.getApellido2(): "
					+ cliente.getRepresentanteLegalComDTO()[cliente.getNumeroOrdenRepresentanteLegal() - 1]
							.getApellido2());
			cstmt.setString(8, cliente.getRepresentanteLegalComDTO()[cliente.getNumeroOrdenRepresentanteLegal() - 1]
					.getCodigoTipoRepresentante());
			cat.debug("cliente.getCodigoTipoRepresentante(): "
					+ cliente.getRepresentanteLegalComDTO()[cliente.getNumeroOrdenRepresentanteLegal() - 1]
							.getCodigoTipoRepresentante());

			cstmt.registerOutParameter(9, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(10, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(11, java.sql.Types.NUMERIC);

			cat.debug("Inicio:setResponsablesDelCliente:execute");
			cstmt.execute();
			cat.debug("Fin:setResponsablesDelCliente:execute");

			codError = cstmt.getInt(9);
			msgError = cstmt.getString(10);
			numEvento = cstmt.getInt(11);
			if (codError != 0)
			{
				cat.error("Ocurrió un error al insertar representante");
				throw new CustomerDomainException("Ocurrió un error al insertar representante", String
						.valueOf(codError), numEvento, msgError);
			}

		}
		catch (Exception e)
		{
			cat.error("Ocurrió un error al insertar representante", e);
			if (cat.isDebugEnabled())
			{
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
			if (e instanceof CustomerDomainException)
				throw (CustomerDomainException) e;
		}
		finally
		{
			if (cat.isDebugEnabled())
				cat.debug("Cerrando conexiones...");
			try
			{
				if (cstmt != null)
					cstmt.close();
				if (!conn.isClosed())
				{
					conn.close();
				}
			}
			catch (SQLException e)
			{
				cat.debug("SQLException", e);
			}
		}
		cat.debug("Fin:setResponsablesDelCliente()");
	}// fin setResponsablesDelCliente

	/**
	 * Inserta empresa
	 * 
	 * @param cliente
	 * @return N/A
	 * @throws CustomerDomainException
	 */
	public void insEmpresa(ClienteAltaDTO cliente) 
		throws CustomerDomainException
	{
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null;
		try
		{
			cat.debug("Inicio:insEmpresa");

			String call = getSQLDatosCliente("VE_alta_cliente_PG", "VE_insEmpresa_PR", 13);
			cat.debug("sql[" + call + "]");
			cstmt = conn.prepareCall(call);

			cstmt.setString(1, cliente.getNombreCliente());
			cat.debug("cliente.getDescripcionEmpresa(): " + cliente.getNombreCliente());
			cstmt.setInt(2, cliente.getCodigoProducto());
			cat.debug("cliente.getCodigoProducto(): " + cliente.getCodigoProducto());
			cstmt.setString(3, cliente.getPlanTarifario());
			cat.debug("cliente.getPlanTarifario(): " + cliente.getPlanTarifario());
			cstmt.setInt(4, Integer.parseInt(cliente.getCodigoCicloFacturacion()));
			cat.debug("cliente.getCodigoCiclo(): " + cliente.getCodigoCicloFacturacion());
			cstmt.setLong(5, Long.parseLong(cliente.getCodigoCliente()));
			cat.debug("cliente.getCodigoCliente(): " + cliente.getCodigoCliente());
			cstmt.setInt(6, cliente.getNumeroAbonados());
			cat.debug("cliente.getNumeroAbonados(): " + cliente.getNumeroAbonados());
			cstmt.setString(7, cliente.getNombreUsuarOra());
			cat.debug("cliente.getUsuario(): " + cliente.getNombreUsuarOra());
			cstmt.setString(8, cliente.getRazonSocial());
			cat.debug("cliente.getRazonSocial(): " + cliente.getRazonSocial());
			cstmt.setString(9, cliente.getPatenteComercio());
			cat.debug("cliente.getPatenteComercio(): " + cliente.getPatenteComercio());

			cstmt.registerOutParameter(10, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(11, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(12, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(13, java.sql.Types.NUMERIC);

			cat.debug("Inicio:insEmpresa:execute");
			cstmt.execute();
			cat.debug("Fin:insEmpresa:execute");

			codError = cstmt.getInt(11);
			msgError = cstmt.getString(12);
			numEvento = cstmt.getInt(13);

			if (codError != 0)
			{
				cat.error("Ocurrió un error al insertar empresa");
				throw new CustomerDomainException("Ocurrió un error al insertar empresa", String.valueOf(codError),
						numEvento, msgError);
			}
			else
			{
				long codEmpresa = cstmt.getInt(10);
				cliente.setCodigoEmpresa(codEmpresa);
			}

		}
		catch (Exception e)
		{
			cat.error("Ocurrió un error al insertar empresa", e);
			if (cat.isDebugEnabled())
			{
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
			if (e instanceof CustomerDomainException)
				throw (CustomerDomainException) e;
		}
		finally
		{
			if (cat.isDebugEnabled())
				cat.debug("Cerrando conexiones...");
			try
			{
				if (cstmt != null)
					cstmt.close();
				if (!conn.isClosed())
				{
					conn.close();
				}
			}
			catch (SQLException e)
			{
				cat.debug("SQLException", e);
			}
		}
		cat.debug("Fin:insEmpresa()");
	}// fin insEmpresa

	/**
	 * Inserta secuencia de despacho
	 * 
	 * @param cliente
	 * @return N/A
	 * @throws CustomerDomainException
	 */
	public void insSecDespachoCliente(ClienteAltaDTO cliente) 
		throws CustomerDomainException
	{
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null;
		try
		{
			cat.debug("Inicio:insSecDespachoCliente");

			String call = getSQLDatosCliente("VE_alta_cliente_PG", "VE_insSecDespachoCliente_PR", 5);
			cat.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);

			cstmt.setString(1, cliente.getCodigoCliente());
			cstmt.setString(2, cliente.getNombreUsuarOra());

			cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);

			cat.debug("Inicio:insSecDespachoCliente:execute");
			cstmt.execute();
			cat.debug("Fin:insSecDespachoCliente:execute");

			codError = cstmt.getInt(3);
			msgError = cstmt.getString(4);
			numEvento = cstmt.getInt(5);

			if (codError != 0)
			{
				cat.error("Ocurrió un error al insertar secuencia despacho del cliente");
				throw new CustomerDomainException("Ocurrió un error al insertar secuencia despacho del cliente", String
						.valueOf(codError), numEvento, msgError);
			}

		}
		catch (Exception e)
		{
			cat.error("Ocurrió un error al insertar secuencia despacho", e);
			if (cat.isDebugEnabled())
			{
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
			if (e instanceof CustomerDomainException)
				throw (CustomerDomainException) e;
		}
		finally
		{
			if (cat.isDebugEnabled())
				cat.debug("Cerrando conexiones...");
			try
			{
				if (cstmt != null)
					cstmt.close();
				if (!conn.isClosed())
				{
					conn.close();
				}
			}
			catch (SQLException e)
			{
				cat.debug("SQLException", e);
			}
		}
		cat.debug("Fin:insSecDespachoCliente()");
	}// fin insSecDespachoCliente

	/**
	 * Inserta categoria tributaria del cliente
	 * 
	 * @param cliente
	 * @return N/A
	 * @throws CustomerDomainException
	 */
	public void insCategTributCliente(ClienteAltaDTO cliente) 
		throws CustomerDomainException
	{
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null;
		try
		{
			cat.debug("Inicio:insCategTributCliente");

			String call = getSQLDatosCliente("VE_alta_cliente_PG", "VE_insCategoriaTributaria_PR", 5);
			cat.debug("sql[" + call + "]");
			cat.debug("Codigo Cliente [" + cliente.getCodigoCliente() + "]");
			cat.debug("Categoría Tributaria[" + cliente.getCategoriaTributaria() + "]");
			cstmt = conn.prepareCall(call);

			cstmt.setString(1, cliente.getCodigoCliente());
			cstmt.setString(2, cliente.getCategoriaTributaria());

			cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);

			cat.debug("Inicio:insCategTributCliente:execute");
			cstmt.execute();
			cat.debug("Fin:insCategTributCliente:execute");

			codError = cstmt.getInt(3);
			msgError = cstmt.getString(4);
			numEvento = cstmt.getInt(5);

			if (codError != 0)
			{
				cat.error("Ocurrió un error al insertar categoria tributaria del cliente");
				throw new CustomerDomainException("Ocurrió un error al insertar categoria tributaria del cliente",
						String.valueOf(codError), numEvento, msgError);
			}

		}
		catch (Exception e)
		{
			cat.error("Ocurrió un error al insertar categoria tributaria del cliente", e);
			if (cat.isDebugEnabled())
			{
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
			if (e instanceof CustomerDomainException)
				throw (CustomerDomainException) e;
		}
		finally
		{
			if (cat.isDebugEnabled())
				cat.debug("Cerrando conexiones...");
			try
			{
				if (cstmt != null)
					cstmt.close();
				if (!conn.isClosed())
				{
					conn.close();
				}
			}
			catch (SQLException e)
			{
				cat.debug("SQLException", e);
			}
		}
		cat.debug("Fin:insCategTributCliente()");
	}// fin insCategTributCliente

	/**
	 * Inserta categoria impositiva del cliente
	 * 
	 * @param cliente
	 * @return N/A
	 * @throws CustomerDomainException
	 */
	public void insCategImposCliente(ClienteAltaDTO cliente) 
		throws CustomerDomainException
	{
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null;
		try
		{
			cat.debug("Inicio:insCategImposCliente");

			String call = getSQLDatosCliente("VE_alta_cliente_PG", "VE_insCatImposCliente_PR", 5);
			cat.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);

			cstmt.setString(1, cliente.getCodigoCliente());
			cstmt.setString(2, String.valueOf(cliente.getCodigoCategImpos()));

			cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);

			cat.debug("Inicio:insCategImposCliente:execute");
			cstmt.execute();
			cat.debug("Fin:insCategImposCliente:execute");

			codError = cstmt.getInt(3);
			msgError = cstmt.getString(4);
			numEvento = cstmt.getInt(5);

			/*
			 * if (codError !=0){ cat.error("Ocurrió un error al insertar
			 * categoria impositiva del cliente"); throw new
			 * CustomerDomainException( "Ocurrió un error al insertar categoria
			 * impositiva del cliente", String .valueOf(codError), numEvento,
			 * msgError); }
			 */

		}
		catch (Exception e)
		{
			cat.error("Ocurrió un error al insertar categoria impositiva del cliente", e);
			if (cat.isDebugEnabled())
			{
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
		}
		finally
		{
			if (cat.isDebugEnabled())
				cat.debug("Cerrando conexiones...");
			try
			{
				if (cstmt != null)
					cstmt.close();
				if (!conn.isClosed())
				{
					conn.close();
				}
			}
			catch (SQLException e)
			{
				cat.debug("SQLException", e);
			}
		}
		cat.debug("Fin:insCategImposCliente()");
	}// fin insCategImposCliente

	/**
	 * Inserta direccion del cliente
	 * 
	 * @param cliente
	 * @return N/A
	 * @throws CustomerDomainException
	 */
	public void insDireccionCliente(ClienteAltaDTO cliente) 
		throws CustomerDomainException
	{
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null;
		try
		{
			cat.debug("Inicio:insDireccionCliente");

			String call = getSQLDatosCliente("VE_alta_cliente_PG", "VE_insDireccionCliente_PR", 6);
			cat.debug("sql[" + call + "]");

			if (cliente.getDirecciones() != null)
			{
				for (int i = 0; i < cliente.getDirecciones().length; i++)
				{
					if (cliente.getDirecciones()[i] != null)
					{
						cstmt = conn.prepareCall(call);
						cstmt.setString(1, cliente.getCodigoCliente());
						cstmt.setString(2, String.valueOf(cliente.getDirecciones()[i].getTipo()));
						cstmt.setString(3, String.valueOf(cliente.getDirecciones()[i].getCodigo()));
						cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);
						cstmt.registerOutParameter(5, java.sql.Types.VARCHAR);
						cstmt.registerOutParameter(6, java.sql.Types.NUMERIC);

						cat.debug("Inicio:insDireccionCliente:execute");
						cstmt.execute();
						cat.debug("Fin:insDireccionCliente:execute");

						codError = cstmt.getInt(4);
						msgError = cstmt.getString(5);
						numEvento = cstmt.getInt(6);

						if (codError != 0)
						{
							cat.error("Ocurrió un error al insertar direccion del cliente");
							throw new CustomerDomainException("Ocurrió un error al insertar direccion del cliente",
									String.valueOf(codError), numEvento, msgError);
						}
					}
				}// fin for
			}

		}
		catch (Exception e)
		{
			cat.error("Ocurrió un error al insertar direccion del cliente", e);
			if (cat.isDebugEnabled())
			{
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
			if (e instanceof CustomerDomainException)
				throw (CustomerDomainException) e;
		}
		finally
		{
			if (cat.isDebugEnabled())
				cat.debug("Cerrando conexiones...");
			try
			{
				if (cstmt != null)
					cstmt.close();
				if (!conn.isClosed())
				{
					conn.close();
				}
			}
			catch (SQLException e)
			{
				cat.debug("SQLException", e);
			}
		}
		cat.debug("Fin:insDireccionCliente()");
	}// fin insDireccionCliente

	/**
	 * Inserta relacion vendedor cliente
	 * 
	 * @param cliente
	 * @return N/A
	 * @throws CustomerDomainException
	 */
	public void insVendCliente(ClienteDTO cliente) 
		throws CustomerDomainException
	{
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null;
		try
		{
			cat.debug("Inicio:insVendCliente");

			String call = getSQLDatosCliente("VE_alta_cliente_PG", "VE_insVendCliente_PR", 6);
			cat.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);

			cstmt.setString(1, String.valueOf(cliente.getCodigoVendedor()));
			cstmt.setString(2, cliente.getCodigoCliente());
			cstmt.setString(3, cliente.getNombreUsuarOra());

			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(5, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(6, java.sql.Types.NUMERIC);

			cat.debug("Inicio:insVendCliente:execute");
			cstmt.execute();
			cat.debug("Fin:insVendCliente:execute");

			codError = cstmt.getInt(4);
			msgError = cstmt.getString(5);
			numEvento = cstmt.getInt(6);

			if (codError != 0)
			{
				cat.error("Ocurrió un error al insertar relacion vendedor cliente");
				throw new CustomerDomainException("Ocurrió un error al insertar relacion vendedor cliente", String
						.valueOf(codError), numEvento, msgError);
			}

		}
		catch (Exception e)
		{
			cat.error("Ocurrió un error al insertar relacion vendedor cliente", e);
			if (cat.isDebugEnabled())
			{
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
		}
		finally
		{
			if (cat.isDebugEnabled())
				cat.debug("Cerrando conexiones...");
			try
			{
				if (cstmt != null)
					cstmt.close();
				if (!conn.isClosed())
				{
					conn.close();
				}
			}
			catch (SQLException e)
			{
				cat.debug("SQLException", e);
			}
		}
		cat.debug("Fin:insVendCliente()");
	}// fin insVendCliente

	/**
	 * Actualiza categoria de los clientes por la categoria de la cuenta
	 * 
	 * @param cliente
	 * @return N/A
	 * @throws CustomerDomainException
	 */
	public void actualizaCategoriasClientes(ClienteDTO cliente) 
		throws CustomerDomainException
	{
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null;
		try
		{
			cat.debug("Inicio:actualizaCategoriasClientes");

			String call = getSQLDatosCliente("VE_alta_cliente_PG", "VE_updCategClienteCta_PR", 5);
			cat.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);

			cstmt.setString(1, cliente.getCodigoCuenta());
			cstmt.setString(2, String.valueOf(cliente.getCodigoCategoria()));

			cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);

			cat.debug("Inicio:actualizaCategoriasClientes:execute");
			cstmt.execute();
			cat.debug("Fin:actualizaCategoriasClientes:execute");

			codError = cstmt.getInt(3);
			msgError = cstmt.getString(4);
			numEvento = cstmt.getInt(5);

			if (codError != 0)
			{
				cat.error("Ocurrió un error al actualizar categorias de los clientes");
				throw new CustomerDomainException("Ocurrió un error al actualizar categorias de los clientes", String
						.valueOf(codError), numEvento, msgError);
			}

		}
		catch (Exception e)
		{
			cat.error("Ocurrió un error al actualizar categorias de los clientes", e);
			if (cat.isDebugEnabled())
			{
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
		}
		finally
		{
			if (cat.isDebugEnabled())
				cat.debug("Cerrando conexiones...");
			try
			{
				if (cstmt != null)
					cstmt.close();
				if (!conn.isClosed())
				{
					conn.close();
				}
			}
			catch (SQLException e)
			{
				cat.debug("SQLException", e);
			}
		}
		cat.debug("Fin:actualizaCategoriasClientes()");
	}// fin actualizaCategoriasClientes

	/**
	 * Actualiza categoria de los clientes por la categoria de la cuenta
	 * 
	 * @param cliente
	 * @return N/A
	 * @throws CustomerDomainException
	 */
	public void actualizaCodigoUsoClientes(ClienteDTO cliente)
		throws CustomerDomainException
	{
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null;
		try
		{
			cat.debug("Inicio:actualizaCodigoUsoClientes");

			String call = getSQLDatosCliente("VE_alta_cliente_PG", "VE_updCodigoUsoCliente_PR", 5);
			cat.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);

			cstmt.setString(1, cliente.getCodigoCuenta());
			cstmt.setString(2, cliente.getCodigoUso());

			cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);

			cat.debug("Inicio:actualizaCodigoUsoClientes:execute");
			cstmt.execute();
			cat.debug("Fin:actualizaCodigoUsoClientes:execute");

			codError = cstmt.getInt(3);
			msgError = cstmt.getString(4);
			numEvento = cstmt.getInt(5);

			if (codError != 0)
			{
				cat.error("Ocurrió un error al actualizar codigo uso de los clientes");
				throw new CustomerDomainException("Ocurrió un error al actualizar codigo uso de los clientes", String
						.valueOf(codError), numEvento, msgError);
			}

		}
		catch (Exception e)
		{
			cat.error("Ocurrió un error al actualizar codigo uso de los clientes", e);
			if (cat.isDebugEnabled())
			{
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
		}
		finally
		{
			if (cat.isDebugEnabled())
				cat.debug("Cerrando conexiones...");
			try
			{
				if (cstmt != null)
					cstmt.close();
				if (!conn.isClosed())
				{
					conn.close();
				}
			}
			catch (SQLException e)
			{
				cat.debug("SQLException", e);
			}
		}
		cat.debug("Fin:actualizaCodigoUsoClientes()");
	}// fin actualizaCodigoUsoClientes

	/**
	 * Actualiza subcategoria impositiva del cliente por la subcategoria de la
	 * cuenta} en base al resultado del analisis de categoria de la cuenta
	 * realizado en la alta del cliente.
	 * 
	 * @param cliente
	 * @return N/A
	 * @throws CustomerDomainException
	 */
	public void actualizaSubCategoriaImpositiva(ClienteDTO cliente) 
		throws CustomerDomainException
	{
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null;
		try
		{
			cat.debug("Inicio:actualizaSubCategoriaImpositiva");

			String call = getSQLDatosCliente("VE_alta_cliente_PG", "VE_updSubCategCliente_PR", 5);
			cat.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);

			cstmt.setString(1, cliente.getCodigoCliente());
			cstmt.setString(2, String.valueOf(cliente.getCodigoSubCategoria()));

			cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);

			cat.debug("Inicio:actualizaSubCategoriaImpositiva:execute");
			cstmt.execute();
			cat.debug("Fin:actualizaSubCategoriaImpositiva:execute");

			codError = cstmt.getInt(3);
			msgError = cstmt.getString(4);
			numEvento = cstmt.getInt(5);

			if (codError != 0)
			{
				cat.error("Ocurrió un error al actualizar la subcategoria impositva del cliente");
				throw new CustomerDomainException(
						"Ocurrió un error al actualizar la subcategoria impositva del cliente", String
								.valueOf(codError), numEvento, msgError);
			}

		}
		catch (Exception e)
		{
			cat.error("Ocurrió un error al actualizar la subcategoria impositva del cliente", e);
			if (cat.isDebugEnabled())
			{
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
		}
		finally
		{
			if (cat.isDebugEnabled())
				cat.debug("Cerrando conexiones...");
			try
			{
				if (cstmt != null)
					cstmt.close();
				if (!conn.isClosed())
				{
					conn.close();
				}
			}
			catch (SQLException e)
			{
				cat.debug("SQLException", e);
			}
		}
		cat.debug("Fin:actualizaSubCategoriaImpositiva()");
	}// fin actualizaSubCategoriaImpositiva

	/**
	 * Consulta datos del cliente tipo empresa
	 * 
	 * @param clienteDTO
	 * @return resultado
	 * @throws CustomerDomainException
	 */
	public ClienteDTO getDatosEmpresa(ClienteDTO clienteDTO) 
		throws CustomerDomainException
	{
		cat.debug("getDatosEmpresa:inicio");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		cat.debug("Coneccion obtenida OK");
		CallableStatement cstmt = null;
		ClienteDTO resultado = null;
		try
		{
			String call = getSQLDatosCliente("VE_servicios_venta_PG", "VE_consulta_cliente_PR", 22);
			cat.debug("sql[" + call + "]");
			cstmt = conn.prepareCall(call);
			cstmt.setLong(1, Long.parseLong(clienteDTO.getCodigoCliente()));
			cstmt.registerOutParameter(2, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);
			cstmt.execute();
			codError = cstmt.getInt(3);
			cat.debug("codError[" + codError + "]");
			msgError = cstmt.getString(4);
			cat.debug("msgError[" + msgError + "]");
			numEvento = cstmt.getInt(5);
			cat.debug("numEvento[" + numEvento + "]");
			if (codError == 0)
			{
				resultado = clienteDTO;
				resultado.setNumeroAbonados(cstmt.getInt(2));
			}

		}
		catch (Exception e)
		{
			cat.error("Ocurrió un error al consultar el cliente tipo empresa", e);
			if (cat.isDebugEnabled())
			{
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
		}
		finally
		{
			if (cat.isDebugEnabled())
				cat.debug("Cerrando conexiones...");
			try
			{
				if (cstmt != null)
					cstmt.close();
				if (!conn.isClosed())
				{
					conn.close();
				}
			}
			catch (SQLException e)
			{
				cat.debug("SQLException", e);
			}
		}
		cat.debug("getDatosEmpresa():end");
		return resultado;
	}

	/**
	 * Obtine plaza del cliente
	 * 
	 * @param clienteDTO
	 * @return resultado
	 * @throws CustomerDomainException
	 */
	public ClienteDTO ObtienePlazaCliente(ClienteDTO cliente) 
		throws CustomerDomainException
	{
		cat.debug("ObtienePlazaCliente:inicio");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		cat.debug("Coneccion obtenida OK");
		CallableStatement cstmt = null;
		try
		{
			String call = getSQLDatosCliente("VE_intermediario_PG", "VE_ObtienePlazaCliente_PR", 5);
			cat.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);

			/*-- entrada --*/
			cstmt.setString(1, cliente.getCodigoCliente());
			/*-- salida --*/
			cstmt.registerOutParameter(2, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);

			cat.debug("ObtienePlazaCliente:Execute Antes");
			cstmt.execute();
			cat.debug("ObtienePlazaCliente:Execute Despues");

			codError = cstmt.getInt(3);
			msgError = cstmt.getString(4);
			numEvento = cstmt.getInt(5);

			if (codError != 0)
			{
				cat.error("Ocurrió un error al obtener codigo de la plaza del cliente");
				throw new CustomerDomainException("Ocurrió un error al obtener codigo de la plaza del cliente", String
						.valueOf(codError), numEvento, msgError);
			}
			else
				cliente.setCodigoPlaza(cstmt.getString(2));

			if (cat.isDebugEnabled())
			{
				cat.debug(" Finalizo ejecución");
				cat.debug(" Recuperando salidas");
			}
		}
		catch (Exception e)
		{
			cat.error("Ocurrió un error al obtener codigo de la plaza del cliente", e);
			if (cat.isDebugEnabled())
			{
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
		}
		finally
		{
			if (cat.isDebugEnabled())
				cat.debug("Cerrando conexiones...");
			try
			{
				if (cstmt != null)
					cstmt.close();
				if (!conn.isClosed())
				{
					conn.close();
				}
			}
			catch (SQLException e)
			{
				cat.debug("SQLException", e);
			}
		}
		cat.debug("ObtienePlazaCliente():end");
		return cliente;
	}// fin ObtienePlazaCliente

	public DirecClienteListDTO obtenerDireccionCliente(DirecClienteDTO direcClienteDTO) 
		throws CustomerDomainException
	{
		if (cat.isDebugEnabled())
		{
			cat.debug("comuna():start");
		}

		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		DirecClienteDTO[] direcCliente = null;
		DirecClienteListDTO direcClienteList = null;
		String call = null;
		Connection conn = null;
		CallableStatement cstmt = null;
		ResultSet rs = null;

		try
		{
			conn = getConnectionFromWLSInitialContext(global.getJndiForDataSource());

		}
		catch (Exception e1)
		{
			cat.error(" No se pudo obtener una conexión ", e1);
			throw new CustomerDomainException("-2129", 0, "No se pudo obtener una conexión");
		}

		try
		{

			call = getSQLDirecCliente();

			if (cat.isDebugEnabled())
			{
				cat.debug("sql[" + call + "]");
			}

			cstmt = conn.prepareCall(call.toString());

			if (cat.isDebugEnabled())
			{
				cat.debug("Registrando Entradas");
			}

			cstmt.setLong(1, direcClienteDTO.getcodCliente().longValue());

			if (cat.isDebugEnabled())
			{
				cat.debug(" Registrando salidas");
			}

			cstmt.registerOutParameter(2, oracle.jdbc.driver.OracleTypes.CURSOR);
			cstmt.registerOutParameter(3, oracle.jdbc.driver.OracleTypes.NUMBER);
			cstmt.registerOutParameter(4, oracle.jdbc.driver.OracleTypes.VARCHAR);
			cstmt.registerOutParameter(5, oracle.jdbc.driver.OracleTypes.NUMBER);

			if (cat.isDebugEnabled())
			{
				cat.debug(" Iniciando Ejecución");
			}

			cat.debug("Execute Antes");
			cstmt.execute();
			cat.debug("Execute Despues");

			if (cat.isDebugEnabled())
			{
				cat.debug(" Finalizo ejecución");
				cat.debug(" Recuperando salidas");
			}
			// Recuperacion de valores de salida

			codError = cstmt.getInt(3);
			cat.debug("codError[" + codError + "]");
			msgError = cstmt.getString(4);
			cat.debug("msgError[" + msgError + "]");
			numEvento = cstmt.getInt(5);
			cat.debug("numEvento[" + numEvento + "]");

			if (codError != 0)
			{
				cat.error(" Ocurrió un error al recuperar dirección cliente");
				throw new CustomerDomainException(String.valueOf(codError), numEvento, msgError);
			}
			cat.debug("Recuperando cursor...");
			rs = (ResultSet) cstmt.getObject(2);
			ArrayList lista = new ArrayList();

			boolean retVal = true;
			while (rs.next())
			{
				retVal = false;
				DirecClienteDTO dirsCliente = new DirecClienteDTO();
				dirsCliente.setcodTipDireccion(rs.getString(1));
				dirsCliente.setcodDireccion(new Long(rs.getLong(2)));
				dirsCliente.setdesTipDireccion(rs.getString(3));
				lista.add(dirsCliente);
			}

			direcCliente = (DirecClienteDTO[]) ArrayUtl.copiaArregloTipoEspecifico(lista.toArray(),
					DirecClienteDTO.class);
			direcClienteList = new DirecClienteListDTO();
			direcClienteList.setalldirecCliente(direcCliente);
			if (retVal)
			{
				CustomerDomainException e = new CustomerDomainException();
				e.setCodigo("1244");
				e.setCodigoEvento(0);
				e
						.setDescripcionEvento("No es posible obtener código de dirección del cliente para los parámetros ingresados");
				throw e;
			}
			if (cat.isDebugEnabled())
			{
				cat.debug(" Finalizo ejecución");
				cat.debug(" Recuperando salidas");
			}
			// Recuperacion de valores de salida

		}

		catch (CustomerDomainException e)
		{
			e.printStackTrace();
			cat.error("Ocurrió un error general al obtener dirección cliente", e);
			if (cat.isDebugEnabled())
			{
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
			throw e;
		}
		catch (Exception e)
		{
			e.printStackTrace();
			cat.error("Ocurrió un error general al obtener dirección cliente", e);
			if (cat.isDebugEnabled())
			{
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new CustomerDomainException("Ocurrió un error general al obtener dirección cliente", e);

		}
		finally
		{
			/*
			 * direcClienteList.setCod_error(new Long (codError));
			 * direcClienteList.setDes_error(msgError);
			 * direcClienteList.setNum_evento(new Long(numEvento));
			 */
			if (cat.isDebugEnabled())
			{
				cat.debug("Cerrando conexiones...");
			}
			try
			{

				if (rs != null)
				{
					rs.close();
				}

				if (cstmt != null)
				{
					cstmt.close();
				}
				if (!conn.isClosed())
				{
					conn.close();
				}
			}
			catch (SQLException e)
			{
				// TODO Auto-generated catch block
				cat.debug("SQLException[" + e + "]");
			}
		}

		if (cat.isDebugEnabled())
		{
			cat.debug("getUnInstalledCustomerAccountProductBundle():end");
		}

		return direcClienteList;
	}

	public ClienteDTO[] getDatosCliente(BusquedaClienteDTO entrada) 
		throws CustomerDomainException
	{
		cat.debug("getDatosCliente:inicio");
		ClienteDTO[] resultado = null;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		cat.debug("Conexion obtenida OK");
		CallableStatement cstmt = null;
		ResultSet rs = null;
		try
		{

			String call = getSQLDatosCliente("Ve_Servs_ActivacionesWeb_Pg", "VE_getCliente2_PR", 13);
			cat.debug("sql[" + call + "]");
			cstmt = conn.prepareCall(call);

			cstmt.setString(1, entrada.getCodCliente());
			cat.debug("entrada.getCodCliente(): " + entrada.getCodCliente());
			cstmt.setString(2, entrada.getCodTipoIdentificacion());
			cat.debug("entrada.getCodTipoIdentificacion(): " + entrada.getCodTipoIdentificacion());
			cstmt.setString(3, entrada.getNumIdentificacion());
			cat.debug("entrada.getNumIdentificacion(): " + entrada.getNumIdentificacion());
			cstmt.setString(4, entrada.getCodTipoCliente());
			cat.debug("entrada.getCodTipoCliente(): " + entrada.getCodTipoCliente());
			cstmt.setString(5, entrada.getNumTelefono());
			cat.debug("entrada.getNumTelefono(): " + entrada.getNumTelefono());
			cstmt.setString(6, entrada.getNombreCliente());
			cat.debug("entrada.getNombreCliente(): " + entrada.getNombreCliente());
			cstmt.setString(7, entrada.getPrimerApellido());
			cat.debug("entrada.getPrimerApellido(): " + entrada.getPrimerApellido());
			cstmt.setString(8, entrada.getSegundoApellido());
			cat.debug("entrada.getSegundoApellido(): " + entrada.getSegundoApellido());
			cstmt.setString(9, entrada.getNombreEmpresa());
			cat.debug("entrada.getNombreEmpresa(): " + entrada.getNombreEmpresa());

			cstmt.registerOutParameter(10, OracleTypes.CURSOR);
			cstmt.registerOutParameter(11, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(12, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(13, java.sql.Types.NUMERIC);

			cat.debug("getDatosCliente:Execute Antes");
			cstmt.execute();
			cat.debug("getDatosCliente:Execute Despues");

			codError = cstmt.getInt(11);
			msgError = cstmt.getString(12);
			numEvento = cstmt.getInt(13);

			cat.debug("codError[" + codError + "]");
			cat.debug("msgError[" + msgError + "]");
			cat.debug("numEvento[" + numEvento + "]");

			if (codError != 0)
			{
				cat.error("Ocurrió un error al recuperar datos del cliente");
				throw new CustomerDomainException("Ocurrió un error al recuperar datos del cliente", String
						.valueOf(codError), numEvento, msgError);

			}
			else
			{
				cat.debug("Recuperando datos del cliente");
				ArrayList lista = new ArrayList();
				rs = (ResultSet) cstmt.getObject(10);
				while (rs.next())
				{
					ClienteDTO cliente = new ClienteDTO();
					cliente.setCodigoCliente(rs.getString(1));
					cliente.setNombreCliente(rs.getString(2));
					cliente.setNombreApellido1(rs.getString(3));
					cliente.setNombreApellido2(rs.getString(4));
					cliente.setCodigoTipoIdentificacion(rs.getString(5));
					cliente.setNumeroIdentificacion(rs.getString(6));
					cliente.setNumeroTelefono1(rs.getString(7));
					cliente.setDireccionEMail(rs.getString(8));
					cliente.setFechaNacimiento(rs.getString(9));
					cliente.setFechaNacimientoDate(rs.getDate(9));
					cliente.setGlsTipoCliente(rs.getString(10));
					cliente.setCodCrediticia(rs.getString(11));
					cliente.setMontoPreAutorizado(rs.getDouble(12));
					cliente.setCodCalificacion(rs.getString(13));
					cliente.setTipoCliente(rs.getString(14));
					cliente.setDescripcionTipoIdentificacion(rs.getString(15));
					cliente.setDescripcionColor(rs.getString(16));
					cliente.setDescripcionSegmento(rs.getString(17));
					cliente.setDescripcionEmpresa(rs.getString(18));
					cliente.setIngresosMensuales(new Double(rs.getDouble(19)));
					lista.add(cliente);
				}
				resultado = (ClienteDTO[]) ArrayUtl.copiaArregloTipoEspecifico(lista.toArray(), ClienteDTO.class);
				cat.debug("Fin recuperacion datos de cliente");
			}
			if (cat.isDebugEnabled())
				cat.debug(" Finalizo ejecución");
		}
		catch (Exception e)
		{
			cat.error("Ocurrió un error al recuperar datos del cliente", e);
			if (cat.isDebugEnabled())
			{
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}

			if (e instanceof CustomerDomainException)
			{
				throw (CustomerDomainException) e;
			}
			else
			{
				CustomerDomainException c = new CustomerDomainException();
				c.setMessage(e.getMessage());
				throw c;
			}
		}
		finally
		{
			if (cat.isDebugEnabled())
				cat.debug("Cerrando conexiones...");
			try
			{
				if (rs != null)
					rs.close();
				if (cstmt != null)
					cstmt.close();
				if (!conn.isClosed())
				{
					conn.close();
				}
			}
			catch (SQLException e)
			{
				cat.debug("SQLException", e);
			}
		}
		cat.debug("getDatosCliente():end");
		return resultado;
	}// fin getDatosCliente

	/**
	 * Obtiene codigo de operadora
	 * 
	 * @param N/A
	 * @return resultado
	 * @throws CustomerDomainException
	 */
	public String getCodigoOperadoraCliente() 
		throws CustomerDomainException
	{
		cat.debug("Inicio:getCodigoOperadoraCliente");
		String resultado = "";
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null;
		cat.debug("Coneccion obtenida OK");
		try
		{
			String call = getSQLDatosCliente("VE_alta_cliente_PG", "VE_getOperadoraCliente_PR", 4);
			cat.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);

			cstmt.registerOutParameter(1, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(2, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);

			cat.debug("Iniico:getNuevoCliente:Execute");
			cstmt.execute();
			cat.debug("Fin:getNuevoCliente:Execute");

			codError = cstmt.getInt(2);
			msgError = cstmt.getString(3);
			numEvento = cstmt.getInt(4);

			if (codError != 0)
			{
				cat.error("Ocurrió un error al obtener el codigo de la operadora");
				throw new CustomerDomainException("Ocurrió un error al obtener el codigo de la operadora", String
						.valueOf(codError), numEvento, msgError);
			}
			else
				resultado = cstmt.getString(1);

			if (cat.isDebugEnabled())
			{
				cat.debug(" Finalizo ejecución");
				cat.debug(" Recuperando salidas");
			}
		}
		catch (Exception e)
		{
			cat.error("Ocurrió un error al obtener el codigo de la operadora", e);
			if (cat.isDebugEnabled())
			{
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
		}
		finally
		{
			if (cat.isDebugEnabled())
				cat.debug("Cerrando conexiones...");
			try
			{
				if (cstmt != null)
					cstmt.close();
				if (!conn.isClosed())
				{
					conn.close();
				}
			}
			catch (SQLException e)
			{
				cat.debug("SQLException", e);
			}
		}
		cat.debug("Fin:getCodigoOperadoraCliente()");
		return resultado;
	}// fin getNuevoCliente

	/**
	 * @author Héctor Hermosilla
	 * 
	 * Obtiene numero de abonados del cliente
	 * @param clienteDTO
	 * @return resultado
	 * @throws CustomerDomainException
	 */
	public ClienteDTO ObtieneNumeroAbonadosporCliente(ClienteDTO clienteDTO) 
		throws CustomerDomainException
	{
		cat.debug("ObtieneNumeroAbonadosporCliente:inicio");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		cat.debug("Coneccion obtenida OK");
		CallableStatement cstmt = null;
		try
		{
			String call = getSQLDatosCliente("Ve_Servicios_Venta_Pg", "VE_num_abonados_cliente_PR", 6);
			cat.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);

			/*-- entrada --*/
			cstmt.setString(1, clienteDTO.getCodigoCliente());
			cstmt.setString(2, clienteDTO.getCodigoPlanTarifario());
			/*-- salida --*/
			cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(5, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(6, java.sql.Types.NUMERIC);

			cat.debug("ObtieneNumeroAbonadosporCliente:Execute Antes");
			cstmt.execute();
			cat.debug("ObtieneNumeroAbonadosporCliente:Execute Despues");

			codError = cstmt.getInt(4);
			msgError = cstmt.getString(5);
			numEvento = cstmt.getInt(6);

			if (codError == 0)
				clienteDTO.setNumeroAbonados(cstmt.getInt(3));

			if (cat.isDebugEnabled())
			{
				cat.debug(" Finalizo ejecución");
				cat.debug(" Recuperando salidas");
			}
		}
		catch (Exception e)
		{
			cat.error("Ocurrió un error al obtener numero de abonados por cliente", e);
			if (cat.isDebugEnabled())
			{
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
		}
		finally
		{
			if (cat.isDebugEnabled())
				cat.debug("Cerrando conexiones...");
			try
			{
				if (cstmt != null)
					cstmt.close();
				if (!conn.isClosed())
				{
					conn.close();
				}
			}
			catch (SQLException e)
			{
				cat.debug("SQLException", e);
			}
		}
		cat.debug("ObtieneNumeroAbonadosporCliente():end");
		return clienteDTO;
	}// fin ObtieneNumeroAbonadosporCliente

	/**
	 * Actualiza categoria de los clientes por la categoria de la cuenta
	 * 
	 * @param cliente
	 * @return N/A
	 * @throws CustomerDomainException
	 */
	public void actualizaFechaConsultaComputec(ClienteDTO cliente, int tipoDireccion) 
		throws CustomerDomainException
	{
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null;
		try
		{
			cat.debug("Inicio:actualizaFechaConsultaComputec");

			String call = getSQLDatosCliente("VE_alta_cliente_PG", "VE_ActualizaConsultaDirec_PR", 6);
			cat.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);
			cstmt.setString(1, cliente.getCodigoCliente());
			cstmt.setString(2, Integer.toString(tipoDireccion));
			cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);

			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(5, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(6, java.sql.Types.NUMERIC);

			cat.debug("Inicio:actualizaFechaConsultaComputec:execute");
			cstmt.execute();
			cat.debug("Fin:actualizaFechaConsultaComputec:execute");

			codError = cstmt.getInt(4);
			msgError = cstmt.getString(5);
			numEvento = cstmt.getInt(6);

			if (codError != 0)
			{
				cat.error("Ocurrió un error al actualizar fecha de consulta computec");
				throw new CustomerDomainException("Ocurrió un error al actualizar fecha de consulta computec", String
						.valueOf(codError), numEvento, msgError);
			}
			else
			{
				String retorno = cstmt.getString(3);
				if (retorno != null && retorno.equals("FALSE"))
				{
					cat.error("No se pudo actualizar fecha de consulta computec");
					throw new CustomerDomainException("No se pudo actualizar fecha de consulta computec", String
							.valueOf(codError), numEvento, msgError);
				}
			}
		}
		catch (Exception e)
		{
			cat.error("Ocurrió un error al actualizar fecha de consulta computec", e);
			if (cat.isDebugEnabled())
			{
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
		}
		finally
		{
			if (cat.isDebugEnabled())
				cat.debug("Cerrando conexiones...");
			try
			{
				if (cstmt != null)
					cstmt.close();
				if (!conn.isClosed())
				{
					conn.close();
				}
			}
			catch (SQLException e)
			{
				cat.debug("SQLException", e);
			}
		}
		cat.debug("Fin:actualizaFechaConsultaComputec()");
	}// fin actualizaFechaConsultaComputec

	/**
	 * Inserta el descuento de bolsa dinámica para clientes empresa
	 * 
	 * @param cliente
	 * @return N/A
	 * @throws CustomerDomainException
	 */
	public void insDescCliBolsaDinamica(ClienteDTO cliente) 
		throws CustomerDomainException
	{
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null;
		try
		{
			cat.debug("Inicio:insDescCliBolsaDinamica");
			String call = getSQLDatosCliente("FA_DCTO_CLTE_SN_PG", "FA_INS_DCTO_CLTE_BLSDINAM_PR", 9);

			cat.debug("sql[" + call + "]");
			cstmt = conn.prepareCall(call);
			cstmt.setString(1, cliente.getCodigoCliente());
			cat.debug("cliente.getCodigoCliente(): " + cliente.getCodigoCliente());
			cstmt.setString(2, cliente.getCodigoCargoBasico());
			cat.debug("cliente.getCodigoCargoBasico(): " + cliente.getCodigoCargoBasico());
			cstmt.setString(3, cliente.getPlanTarifario());
			cat.debug("cliente.getPlanTarifario(): " + cliente.getPlanTarifario());
			cstmt.setFloat(4, cliente.getMontoDescuento().floatValue());
			cat.debug("cliente.getMontoDescuento(): " + cliente.getMontoDescuento());
			cstmt.setTimestamp(5, new java.sql.Timestamp(System.currentTimeMillis()));// sysdate
			cstmt.setString(6, cliente.getFechaHastaDcto());
			cat.debug("cliente.getFechaHastaDcto(): " + cliente.getFechaHastaDcto());

			cstmt.registerOutParameter(7, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(8, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(9, java.sql.Types.NUMERIC);

			cat.debug("Inicio:insDescCliBolsaDinamica:execute");
			cstmt.execute();
			cat.debug("Fin:insDescCliBolsaDinamica:execute");

			codError = cstmt.getInt(7);
			msgError = cstmt.getString(8);
			numEvento = cstmt.getInt(9);

			if (codError != 0)
			{
				cat.error("Ocurrió un error al insertar el descuento del cliente bolsa dinámica");
				throw new CustomerDomainException(
						"Ocurrió un error al insertar el descuento del cliente bolsa dinámica", String
								.valueOf(codError), numEvento, msgError);
			}

		}
		catch (Exception e)
		{
			cat.error("Ocurrió un error al insertar el descuento del cliente bolsa dinámica", e);
			if (cat.isDebugEnabled())
			{
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
			if (e instanceof CustomerDomainException)
				throw (CustomerDomainException) e;
		}
		finally
		{
			if (cat.isDebugEnabled())
				cat.debug("Cerrando conexiones...");
			try
			{
				if (cstmt != null)
					cstmt.close();
				if (!conn.isClosed())
				{
					conn.close();
				}
			}
			catch (SQLException e)
			{
				cat.debug("SQLException", e);
			}
		}
		cat.debug("Fin:insDescCliBolsaDinamica()");
	}// fin insDescCliBolsaDinamica

	// Ini. Inc. 71895 10-11-2008
	public boolean validarNumeroIdentificacion(ClienteDTO cliente) 
		throws CustomerDomainException
	{
		cat.debug("validarNumeroIdentificacion:start");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		int resultado = 0;
		boolean respuesta = false;
		Connection conn = null;

		String strTipoIdent = "";
		String strValIdent = "";

		conn = getConection();
		CallableStatement cstmt = null;
		cat.debug("Coneccion obtenida OK");
		try
		{
			String call = getSQLDatosCliente("VE_alta_cuenta_PG", "VE_valida_identificacion_PR", 6);
			cat.debug("sql[" + call + "]");
			cstmt = conn.prepareCall(call);
			// cstmt.setString(1,cliente.getNumeroIdentificacion());
			// cat.debug("cliente.getNumeroIdentificacion()(): " +
			// cliente.getNumeroIdentificacion());
			// cstmt.setString(2,cliente.getCodigoTipoIdentificacion());
			// cat.debug("cliente.getCodigoIdentificacionCliente(): " +
			// cliente.getCodigoIdentificacionCliente());
			strValIdent = cliente.getNumeroIdentificacion().toString();
			strTipoIdent = cliente.getCodigoIdentificacionCliente().toString();
			cstmt.setString(1, strValIdent);
			cat.debug("cliente.getNumeroIdentificacion()-strValIndent: " + strValIdent);
			cstmt.setString(2, strTipoIdent);
			cat.debug("cliente.getCodigoIdentificacionCliente()-strTipoIndent: " + strTipoIdent);
			cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(5, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(6, java.sql.Types.NUMERIC);

			cat.debug("Execute Antes");
			cstmt.execute();
			cat.debug("Execute Despues");

			resultado = cstmt.getInt(3);
			if (resultado == 0)
			{
				respuesta = true;
			}
			codError = cstmt.getInt(4);
			cat.debug("codError[" + codError + "]");
			msgError = cstmt.getString(5);
			cat.debug("msgError[" + msgError + "]");
			numEvento = cstmt.getInt(6);
			cat.debug("numEvento[" + numEvento + "]");
			if (codError != 0)
			{
				cat.error("Ocurrió un error al validar Numero de Identificacion");
				throw new CustomerDomainException("Ocurrió un error al validar Numero de Identificacion", String
						.valueOf(codError), numEvento, msgError);
			}
			if (cat.isDebugEnabled())
			{
				cat.debug(" Finalizo ejecución");
			}

		}
		catch (Exception e)
		{
			cat.error("Ocurrió un error al consultar el cliente", e);
			if (cat.isDebugEnabled())
			{
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
		}
		finally
		{
			if (cat.isDebugEnabled())
				cat.debug("Cerrando conexiones...");
			try
			{
				if (cstmt != null)
					cstmt.close();
				if (!conn.isClosed())
				{
					conn.close();
				}
			}
			catch (SQLException e)
			{
				cat.debug("SQLException", e);
			}
		}

		cat.debug("Respuesta [" + respuesta + "]");
		cat.debug("validarNumeroIdentificacion():end");

		return respuesta;
	}

	// Fin validarNumeroIdentificacion
	// Fin Inc. 71895 10-11-2008

	// Ini. Inc. 72637 15-11-2008
	public String obtenerCicloDefault() 
		throws CustomerDomainException
	{
		cat.debug("obtenerCicloDefault:start");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		String respuesta = "";
		Connection conn = null;

		conn = getConection();
		CallableStatement cstmt = null;
		cat.debug("Coneccion obtenida OK");
		try
		{
			String call = getSQLDatosCliente("VE_alta_cliente_PG", "VE_getCicloPorDefecto_PR", 4);
			cat.debug("sql[" + call + "]");
			cstmt = conn.prepareCall(call);
			cstmt.registerOutParameter(1, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(2, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);

			cat.debug("Execute Antes");
			cstmt.execute();
			cat.debug("Execute Despues");

			respuesta = cstmt.getString(1);

			codError = cstmt.getInt(2);
			cat.debug("codError[" + codError + "]");
			msgError = cstmt.getString(3);
			cat.debug("msgError[" + msgError + "]");
			numEvento = cstmt.getInt(4);
			cat.debug("numEvento[" + numEvento + "]");
			if (codError != 0)
			{
				cat.error("Ocurrió un error al obtener Ciclo por Defecto");
				throw new CustomerDomainException("Ocurrió un error al obtener Ciclo por Defecto", String
						.valueOf(codError), numEvento, msgError);
			}
			if (cat.isDebugEnabled())
			{
				cat.debug(" Finalizo ejecución");
			}

		}
		catch (Exception e)
		{
			cat.error("Ocurrió un error al obtener Ciclo por Defecto", e);
			if (cat.isDebugEnabled())
			{
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
		}
		finally
		{
			if (cat.isDebugEnabled())
				cat.debug("Cerrando conexiones...");
			try
			{
				if (cstmt != null)
					cstmt.close();
				if (!conn.isClosed())
				{
					conn.close();
				}
			}
			catch (SQLException e)
			{
				cat.debug("SQLException", e);
			}
		}

		cat.debug("Respuesta [" + respuesta + "]");
		cat.debug("obtenerCicloDefault():end");

		return respuesta;
	}

	// Fin obtenerCicloDefault
	// Fin Inc. 72637 15-11-2008

	public void crearClienteFacturaImprimible(ClienteAltaDTO entrada)
		throws CustomerDomainException
	{
		cat.debug("crearClienteFacturaImprimible:start");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;

		conn = getConection();
		CallableStatement cstmt = null;
		cat.debug("Coneccion obtenida OK");
		try
		{
			String call = getSQLDatosCliente("VE_alta_cliente_PG", "VE_insdatclifactura_PR", 13);
			cat.debug("sql[" + call + "]");
			cstmt = conn.prepareCall(call);

			cstmt.setLong(1, Long.valueOf(entrada.getCodigoCliente()).longValue());
			cat.debug("entrada.getCodigoCliente(): " + entrada.getCodigoCliente());
			cstmt.setString(2, entrada.getTipoIdentClienteFactura());
			cat.debug("entrada.getCodigoTipoIdentificacion(): " + entrada.getTipoIdentClienteFactura());
			cstmt.setString(3, entrada.getNumeroIdentClienteFactura());
			cat.debug("entrada.getNumeroIdentificacion(): " + entrada.getNumeroIdentClienteFactura());
			cstmt.setString(4, entrada.getNombreClienteFactura());
			cat.debug("entrada.getNombreCliente(): " + entrada.getNombreClienteFactura());
			cstmt.setString(5, entrada.getApellido1ClienteFactura());
			cat.debug("entrada.getNombreApellido1(): " + entrada.getApellido1ClienteFactura());
			cstmt.setString(6, entrada.getApellido2ClienteFactura());
			cat.debug("entrada.getNombreApellido2(): " + entrada.getApellido2ClienteFactura());
			cstmt.setString(7, entrada.getTipoFacturaClienteFactura());
			cat.debug("entrada.getTipoFacturaClienteFactura(): " + entrada.getTipoFacturaClienteFactura());
			cstmt.setLong(8, entrada.getTipoDocumentoClienteFactura().longValue());
			cat.debug("entrada.getTipoDocumentoClienteFactura(): " + entrada.getTipoDocumentoClienteFactura());
			if (entrada.getNumVentaClienteFactura() != null)
			{
				cstmt.setLong(9, entrada.getNumVentaClienteFactura().longValue());
			}
			else
				cstmt.setString(9, null);
			cat.debug("Tipo Numero de venta: null");
			cstmt.setString(10, entrada.getNombreUsuarOra());
			cat.debug("entrada.getNombreUsuarOra(): " + entrada.getNombreUsuarOra());
			cstmt.registerOutParameter(11, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(12, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(13, java.sql.Types.NUMERIC);

			cat.debug("Execute Antes");
			cstmt.execute();
			cat.debug("Execute Despues");

			codError = cstmt.getInt(11);
			cat.debug("codError[" + codError + "]");
			msgError = cstmt.getString(12);
			cat.debug("msgError[" + msgError + "]");
			numEvento = cstmt.getInt(13);
			cat.debug("numEvento[" + numEvento + "]");
			if (codError != 0)
			{
				cat.error("Ocurrió un error al insertar los datos del cliente factura imprimible");
				throw new CustomerDomainException(
						"Ocurrió un error al insertar los datos del cliente factura imprimible", String
								.valueOf(codError), numEvento, msgError);
			}
			if (cat.isDebugEnabled())
			{
				cat.debug(" Finalizo ejecución");
			}

		}
		catch (Exception e)
		{
			cat.error("Ocurrió un error al insertar los datos del cliente factura imprimible", e);
			if (cat.isDebugEnabled())
			{
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
		}
		finally
		{
			if (cat.isDebugEnabled())
				cat.debug("Cerrando conexiones...");
			try
			{
				if (cstmt != null)
					cstmt.close();
				if (!conn.isClosed())
				{
					conn.close();
				}
			}
			catch (SQLException e)
			{
				cat.debug("SQLException", e);
			}
		}
		cat.debug("crearClienteFacturaImprimible():end");
	}

	public void insMontoPreautorizado(ClienteAltaDTO entrada)
		throws CustomerDomainException
	{
		cat.debug("insMontoPreautorizado:start");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;

		conn = getConection();
		CallableStatement cstmt = null;
		cat.debug("Coneccion obtenida OK");
		try
		{
			String call = getSQLDatosCliente("VE_alta_cliente_PG", "VE_insMontoPreautorizado_PR", 6);
			cat.debug("sql[" + call + "]");
			cstmt = conn.prepareCall(call);

			cstmt.setLong(1, Long.valueOf(entrada.getCodigoCliente()).longValue());
			cat.debug("entrada.getCodigoCliente(): " + entrada.getCodigoCliente());
			cstmt.setString(2, global.getValor("monto.preautorizado"));
			cat.debug("entrada.monto.preautorizado: " + 0);
			cstmt.setString(3, entrada.getNombreUsuarOra());
			cat.debug("entrada.getNombreUsuarOra(): " + entrada.getNombreUsuarOra());
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(5, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(6, java.sql.Types.NUMERIC);

			cat.debug("Execute Antes");
			cstmt.execute();
			cat.debug("Execute Despues");

			codError = cstmt.getInt(4);
			cat.debug("codError[" + codError + "]");
			msgError = cstmt.getString(5);
			cat.debug("msgError[" + msgError + "]");
			numEvento = cstmt.getInt(6);
			cat.debug("numEvento[" + numEvento + "]");
			if (codError != 0)
			{
				cat.error("Ocurrió un error al insertar el monto preautorizado");
				throw new CustomerDomainException("Ocurrió un error al insertar el monto preautorizado", String
						.valueOf(codError), numEvento, msgError);
			}
			if (cat.isDebugEnabled())
			{
				cat.debug(" Finalizo ejecución");
			}

		}
		catch (Exception e)
		{
			cat.error("Ocurrió un error al insertar el monto preautorizado", e);
			if (cat.isDebugEnabled())
			{
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
		}
		finally
		{
			if (cat.isDebugEnabled())
				cat.debug("Cerrando conexiones...");
			try
			{
				if (cstmt != null)
					cstmt.close();
				if (!conn.isClosed())
				{
					conn.close();
				}
			}
			catch (SQLException e)
			{
				cat.debug("SQLException", e);
			}
		}
		cat.debug("insMontoPreautorizado():end");
	}

	public OperadoraDTO[] getOperadoras() 
		throws CustomerDomainException
	{
		cat.debug("getOperadoras:start");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		OperadoraDTO[] resultado = null;
		Connection conn = null;
		CallableStatement cstmt = null;
		conn = getConection();
		ResultSet rs = null;
		cat.debug("Coneccion obtenida OK");
		try
		{
			String call = getSQLDatosCliente("VE_alta_cliente_PG", "VE_getListoperadoras_PR", 4);
			cat.debug("sql[" + call + "]");
			cstmt = conn.prepareCall(call);
			cstmt.registerOutParameter(1, OracleTypes.CURSOR);
			cstmt.registerOutParameter(2, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);
			cat.debug("Execute Antes");
			cstmt.execute();
			cat.debug("Execute Despues");
			codError = cstmt.getInt(2);
			cat.debug("codError[" + codError + "]");
			msgError = cstmt.getString(3);
			cat.debug("msgError[" + msgError + "]");
			numEvento = cstmt.getInt(4);
			cat.debug("numEvento[" + numEvento + "]");
			if (codError != 0)
			{
				cat.error("Ocurrió un error al consultar las operadoras");
				throw new CustomerDomainException("Ocurrió un error al consultar las operadoras", String
						.valueOf(codError), numEvento, msgError);

			}
			else
			{
				cat.debug("Llenado Numero de Operadoras");
				rs = (ResultSet) cstmt.getObject(1);
				ArrayList lista = new ArrayList();
				while (rs.next())
				{
					cat.debug("Procesando iteración :" + lista.size());
					OperadoraDTO operadoras = new OperadoraDTO();
					operadoras.setCodigoOperadora(rs.getString(1));
					operadoras.setDescripcionOperadora(rs.getString(2));
					lista.add(operadoras);
				}
				resultado = (OperadoraDTO[]) ArrayUtl.copiaArregloTipoEspecifico(lista.toArray(), OperadoraDTO.class);
				;
			}
			if (cat.isDebugEnabled())
			{
				cat.debug(" Finalizo ejecución");
				cat.debug(" Recuperando salidas");
			}
		}
		catch (Exception e)
		{
			cat.error("Ocurrió un error al consultar las operadoras", e);
			if (cat.isDebugEnabled())
			{
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
			if (e instanceof CustomerDomainException)
			{
				throw (CustomerDomainException) e;
			}
			else
			{
				CustomerDomainException c = new CustomerDomainException();
				c.setMessage(e.getMessage());
				throw c;
			}
		}
		finally
		{
			if (cat.isDebugEnabled())
				cat.debug("Cerrando conexiones...");
			try
			{
				if (rs != null)
					rs.close();
				if (cstmt != null)
					cstmt.close();
				if (!conn.isClosed())
				{
					conn.close();
				}
			}
			catch (SQLException e)
			{
				cat.debug("SQLException", e);
			}
		}
		cat.debug("getOperadoras():end");
		return resultado;
	}

	public ProfesionDTO[] getProfesiones() 
		throws CustomerDomainException
	{
		cat.debug("getProfesiones:start");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		ProfesionDTO[] resultado = null;
		Connection conn = null;
		CallableStatement cstmt = null;
		conn = getConection();
		ResultSet rs = null;
		cat.debug("Coneccion obtenida OK");
		try
		{
			String call = getSQLDatosCliente("VE_alta_cliente_PG", "VE_getListProfesiones_PR", 4);
			cat.debug("sql[" + call + "]");
			cstmt = conn.prepareCall(call);
			cstmt.registerOutParameter(1, OracleTypes.CURSOR);
			cstmt.registerOutParameter(2, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);
			cat.debug("Execute Antes");
			cstmt.execute();
			cat.debug("Execute Despues");
			codError = cstmt.getInt(2);
			cat.debug("codError[" + codError + "]");
			msgError = cstmt.getString(3);
			cat.debug("msgError[" + msgError + "]");
			numEvento = cstmt.getInt(4);
			cat.debug("numEvento[" + numEvento + "]");
			if (codError != 0)
			{
				cat.error("Ocurrió un error al consultar las profesiones");
				throw new CustomerDomainException("Ocurrió un error al consultar las profesiones", String
						.valueOf(codError), numEvento, msgError);

			}
			else
			{
				cat.debug("Llenado Numero de profesiones");
				rs = (ResultSet) cstmt.getObject(1);
				ArrayList lista = new ArrayList();
				while (rs.next())
				{
					cat.debug("Procesando iteración :" + lista.size());
					ProfesionDTO profesiones = new ProfesionDTO();
					profesiones.setCodigoActividad(rs.getString(1));
					profesiones.setDescripcionActividad(rs.getString(2));
					lista.add(profesiones);
				}
				resultado = (ProfesionDTO[]) ArrayUtl.copiaArregloTipoEspecifico(lista.toArray(), ProfesionDTO.class);
				;
			}
			if (cat.isDebugEnabled())
			{
				cat.debug(" Finalizo ejecución");
				cat.debug(" Recuperando salidas");
			}
		}
		catch (Exception e)
		{
			cat.error("Ocurrió un error al consultar las profesiones", e);
			if (cat.isDebugEnabled())
			{
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
			if (e instanceof CustomerDomainException)
			{
				throw (CustomerDomainException) e;
			}
			else
			{
				CustomerDomainException c = new CustomerDomainException();
				c.setMessage(e.getMessage());
				throw c;
			}
		}
		finally
		{
			if (cat.isDebugEnabled())
				cat.debug("Cerrando conexiones...");
			try
			{
				if (rs != null)
					rs.close();
				if (cstmt != null)
					cstmt.close();
				if (!conn.isClosed())
				{
					conn.close();
				}
			}
			catch (SQLException e)
			{
				cat.debug("SQLException", e);
			}
		}
		cat.debug("getProfesiones():end");
		return resultado;
	}

	public CargoLaboralDTO[] getCargosLaborales() 
		throws CustomerDomainException
	{
		cat.debug("getCargosLaborales:start");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		CargoLaboralDTO[] resultado = null;
		Connection conn = null;
		CallableStatement cstmt = null;
		conn = getConection();
		ResultSet rs = null;
		cat.debug("Coneccion obtenida OK");
		try
		{
			String call = getSQLDatosCliente("VE_alta_cliente_PG", "VE_getListCargosLaborales_PR", 4);
			cat.debug("sql[" + call + "]");
			cstmt = conn.prepareCall(call);
			cstmt.registerOutParameter(1, OracleTypes.CURSOR);
			cstmt.registerOutParameter(2, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);
			cat.debug("Execute Antes");
			cstmt.execute();
			cat.debug("Execute Despues");
			codError = cstmt.getInt(2);
			cat.debug("codError[" + codError + "]");
			msgError = cstmt.getString(3);
			cat.debug("msgError[" + msgError + "]");
			numEvento = cstmt.getInt(4);
			cat.debug("numEvento[" + numEvento + "]");
			if (codError != 0)
			{
				cat.error("Ocurrió un error al consultar los cargos laborales");
				throw new CustomerDomainException("Ocurrió un error al consultar los cargos laborales", String
						.valueOf(codError), numEvento, msgError);

			}
			else
			{
				cat.debug("Llenado Numero de Operadoras");
				rs = (ResultSet) cstmt.getObject(1);
				ArrayList lista = new ArrayList();
				while (rs.next())
				{
					cat.debug("Procesando iteración :" + lista.size());
					CargoLaboralDTO cargosLaborales = new CargoLaboralDTO();
					cargosLaborales.setCodigoOcupacion(rs.getString(1));
					cargosLaborales.setDescripcionOcupacion(rs.getString(2));
					lista.add(cargosLaborales);
				}
				resultado = (CargoLaboralDTO[]) ArrayUtl.copiaArregloTipoEspecifico(lista.toArray(),
						CargoLaboralDTO.class);
				;
			}
			if (cat.isDebugEnabled())
			{
				cat.debug(" Finalizo ejecución");
				cat.debug(" Recuperando salidas");
			}
		}
		catch (Exception e)
		{
			cat.error("Ocurrió un error al consultar los cargos laborales", e);
			if (cat.isDebugEnabled())
			{
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
			if (e instanceof CustomerDomainException)
			{
				throw (CustomerDomainException) e;
			}
			else
			{
				CustomerDomainException c = new CustomerDomainException();
				c.setMessage(e.getMessage());
				throw c;
			}
		}
		finally
		{
			if (cat.isDebugEnabled())
				cat.debug("Cerrando conexiones...");
			try
			{
				if (rs != null)
					rs.close();
				if (cstmt != null)
					cstmt.close();
				if (!conn.isClosed())
				{
					conn.close();
				}
			}
			catch (SQLException e)
			{
				cat.debug("SQLException", e);
			}
		}
		cat.debug("getCargosLaborales():end");
		return resultado;
	}

	public boolean validarTelefonoReferencia(String telefono, String tipo) 
		throws CustomerDomainException
	{
		cat.debug("Inicio");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		boolean r = false;
		Connection conn = null;

		conn = getConection();
		CallableStatement cstmt = null;
		cat.debug("Conexión obtenida OK");
		try
		{
			String nombrePackage = "VE_Numeracion_Pg";
			String nombrePL = "VE_VALIDA_NUMERACION_PR";
			String call = getSQLDatosCliente(nombrePackage, nombrePL, 5);
			cat.debug("sql [" + call + "]");
			cstmt = conn.prepareCall(call);

			cstmt.setString(1, telefono);
			cat.debug("telefono: " + telefono);
			cstmt.setString(2, tipo);
			cat.debug("tipo: " + tipo);
			cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);

			cat.debug("Execute Antes");
			cstmt.execute();
			cat.debug("Execute Despues");

			codError = cstmt.getInt(3);
			cat.debug("codError[" + codError + "]");
			msgError = cstmt.getString(4);
			cat.debug("msgError[" + msgError + "]");
			numEvento = cstmt.getInt(5);
			cat.debug("numEvento[" + numEvento + "]");
			if (codError != 0)
			{
				cat.error("Ocurrió un error al validar teléfono de referencia");
				throw new CustomerDomainException("Ocurrió un error al validar teléfono de referencia", String
						.valueOf(codError), numEvento, msgError);
			}
			else
			{
				r = true;
			}
			if (cat.isDebugEnabled())
			{
				cat.debug("Finalizó ejecución");
			}
		}
		catch (Exception e)
		{
			cat.error("Ocurrió un error en la consulta", e);
			if (cat.isDebugEnabled())
			{
				cat.debug("Codigo de Error [" + codError + "]");
				cat.debug("Mensaje de Error [" + msgError + "]");
				cat.debug("Numero de Evento [" + numEvento + "]");
			}
		}
		finally
		{
			if (cat.isDebugEnabled())
				cat.debug("Cerrando conexiones...");
			try
			{
				if (cstmt != null)
					cstmt.close();
				if (!conn.isClosed())
				{
					conn.close();
				}
			}
			catch (SQLException e)
			{
				cat.debug("SQLException", e);
			}
		}
		cat.debug("Respuesta [" + r + "]");
		cat.debug("validarNumeroIdentificacion():end");
		return r;
	}

	/**
	 * Inserta referencia del cliente
	 * 
	 * @param cliente
	 * @return N/A
	 * @throws CustomerDomainException
	 */
	public void insReferenciaCliente(ReferenciaClienteDTO entrada)
		throws CustomerDomainException
	{
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null;
		final int cantidadParametros = 11;
		final String nombrePackage = "VE_alta_cliente_PG";
		final String nombrePL = "VE_insRefCliente_PR";
		try
		{
			cat.debug("Inicio:insReferenciaCliente");
			
			String call = getSQLDatosCliente(nombrePackage, nombrePL, cantidadParametros);
			cat.debug("sql[" + call + "]");
			cstmt = conn.prepareCall(call);
			cstmt.setLong(1, entrada.getCodigoCliente());
			cat.debug("entrada.getCodigoCliente(): " + entrada.getCodigoCliente());
			cstmt.setLong(2, entrada.getNumeroReferencia());
			cat.debug("entrada.getNumeroReferencia(): " + entrada.getNumeroReferencia());
			cstmt.setString(3, entrada.getNomCliente());
			cat.debug("entrada.getNomCliente(): " + entrada.getNomCliente());
			cstmt.setString(4, entrada.getApellido1());
			cat.debug("entrada.getApellido1(): " + entrada.getApellido1());
			cstmt.setString(5, entrada.getApellido2());
			cat.debug("entrada.getApellido2(): " + entrada.getApellido2());
			
			cstmt.setLong(6, entrada.getTelefonoReferenciaMovil());
			cat.debug("entrada.getTelefonoReferenciaMovil(): " + entrada.getTelefonoReferenciaMovil());
			
			cstmt.setLong(7, entrada.getTelefonoReferenciaFijo());
			cat.debug("entrada.getTelefonoReferenciaFijo(): " + entrada.getTelefonoReferenciaFijo());
			
			
			cstmt.setString(8, entrada.getNomUsuario());
			cat.debug("entrada.getNomUsuario(): " + entrada.getNomUsuario());

			cstmt.registerOutParameter(9, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(10, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(cantidadParametros, java.sql.Types.NUMERIC);

			cat.debug("Inicio:insReferenciaCliente:execute");
			cstmt.execute();
			cat.debug("Fin:insReferenciaCliente:execute");

			codError = cstmt.getInt(9);
			msgError = cstmt.getString(10);
			numEvento = cstmt.getInt(cantidadParametros);

			if (codError != 0)
			{
				cat.error("Ocurrió un error al insertar la referencia del cliente");
				throw new CustomerDomainException("Ocurrió un error al insertar la referencia del cliente", String
						.valueOf(codError), numEvento, msgError);
			}
		}
		catch (Exception e)
		{
			cat.error("Ocurrió un error al insertar la referencia del cliente", e);
			if (cat.isDebugEnabled())
			{
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
			if (e instanceof CustomerDomainException)
				throw (CustomerDomainException) e;
		}
		finally
		{
			if (cat.isDebugEnabled())
				cat.debug("Cerrando conexiones...");
			try
			{
				if (cstmt != null)
					cstmt.close();
				if (!conn.isClosed())
				{
					conn.close();
				}
			}
			catch (SQLException e)
			{
				cat.debug("SQLException", e);
			}
		}
		cat.debug("Fin:insReferenciaCliente()");
	}// fin insReferenciaCliente
	
	
	/**
	 * Verifica si el cliente tiene ventas
	 * Devuelve el total de abonados activos
	 * @param codCliente
	 * @return Integer
	 * @throws CustomerDomainException
	 */
	public Integer consultaVentasCliente(Long codCliente) 
		throws CustomerDomainException
	{
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Integer resultado = new Integer(0);
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null;
		try
		{
			cat.debug("Inicio:consultaVentasCliente");
			String nombrePackage = "Ve_Servicios_solicitud_Pg";
			String nombrePL = "VE_Consulta_Vta_abo_PR";
			String call = getSQLDatosCliente(nombrePackage, nombrePL, 5);
			cat.debug("sql[" + call + "]");
			cstmt = conn.prepareCall(call);
			cstmt.setLong(1, codCliente.longValue());
			cat.debug("codCliente: " + codCliente.longValue());
			
			cstmt.registerOutParameter(2, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);

			cat.debug("Inicio:consultaVentasCliente:execute");
			cstmt.execute();
			cat.debug("Fin:consultaVentasCliente:execute");

			codError = cstmt.getInt(3);
			msgError = cstmt.getString(4);
			numEvento = cstmt.getInt(5);

			if (codError != 0)
			{
				cat.error("Ocurrió un error al consultar ventas del cliente");
				throw new CustomerDomainException("Ocurrió un error al consultar ventas del cliente", String
						.valueOf(codError), numEvento, msgError);
			}
			
			resultado = new Integer(cstmt.getInt(2));
			
		}
		catch (Exception e)
		{
			cat.error("Ocurrió un error al consultar ventas del cliente", e);
			if (cat.isDebugEnabled())
			{
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
			if (e instanceof CustomerDomainException)
				throw (CustomerDomainException) e;
		}
		finally
		{
			if (cat.isDebugEnabled())
				cat.debug("Cerrando conexiones...");
			try
			{
				if (cstmt != null)
					cstmt.close();
				if (!conn.isClosed())
				{
					conn.close();
				}
			}
			catch (SQLException e)
			{
				cat.debug("SQLException", e);
			}
		}
		cat.debug("Fin:consultaVentasCliente()");
		return resultado;
	}
	
	public ClasificacionDTO[] getClasificaciones() 
		throws CustomerDomainException
	{
		cat.debug("getClasificaciones:start");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		ClasificacionDTO[] resultado = null;
		Connection conn = null;
		CallableStatement cstmt = null;
		conn = getConection();
		ResultSet rs = null;
		cat.debug("Coneccion obtenida OK");
		try
		{
			String call = getSQLDatosCliente("VE_alta_cliente_PG", "VE_getListClasificaciones_PR", 4);
			cat.debug("sql[" + call + "]");
			cstmt = conn.prepareCall(call);
			cstmt.registerOutParameter(1, OracleTypes.CURSOR);
			cstmt.registerOutParameter(2, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);
			cat.debug("Execute Antes");
			cstmt.execute();
			cat.debug("Execute Despues");
			codError = cstmt.getInt(2);
			cat.debug("codError[" + codError + "]");
			msgError = cstmt.getString(3);
			cat.debug("msgError[" + msgError + "]");
			numEvento = cstmt.getInt(4);
			cat.debug("numEvento[" + numEvento + "]");
			if (codError != 0)
			{
				cat.error("Ocurrió un error al consultar clasificaciones");
				throw new CustomerDomainException("Ocurrió un error al consultar clasificaciones", String
						.valueOf(codError), numEvento, msgError);

			}
			else
			{
				cat.debug("Listado clasificaciones");
				rs = (ResultSet) cstmt.getObject(1);
				ArrayList lista = new ArrayList();
				while (rs.next())
				{
					ClasificacionDTO clasificacion = new ClasificacionDTO();
					clasificacion.setCodElemento(rs.getString(1));
					clasificacion.setDesElemento(rs.getString(2));
					clasificacion.setIndActivo(rs.getInt(3));
					clasificacion.setIndVisible(rs.getInt(4));
					lista.add(clasificacion);
				}
				resultado = (ClasificacionDTO[]) ArrayUtl.copiaArregloTipoEspecifico(lista.toArray(), ClasificacionDTO.class);
				;
			}
			if (cat.isDebugEnabled())
			{
				cat.debug(" Finalizo ejecución");
			}
		}
		catch (Exception e)
		{
			cat.error("Ocurrió un error al consultar clasificaciones", e);
			if (cat.isDebugEnabled())
			{
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
			if (e instanceof CustomerDomainException)
			{
				throw (CustomerDomainException) e;
			}
			else
			{
				CustomerDomainException c = new CustomerDomainException();
				c.setMessage(e.getMessage());
				throw c;
			}
		}
		finally
		{
			if (cat.isDebugEnabled())
				cat.debug("Cerrando conexiones...");
			try
			{
				if (rs != null)
					rs.close();
				if (cstmt != null)
					cstmt.close();
				if (!conn.isClosed())
				{
					conn.close();
				}
			}
			catch (SQLException e)
			{
				cat.debug("SQLException", e);
			}
		}
		cat.debug("getClasificaciones():end");
		return resultado;
	}

	public ValorClasificacionDTO[] getCalificaciones() 
		throws CustomerDomainException
	{
		cat.debug("getCalificaciones:start");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		ValorClasificacionDTO[] resultado = null;
		Connection conn = null;
		CallableStatement cstmt = null;
		conn = getConection();
		ResultSet rs = null;
		cat.debug("Coneccion obtenida OK");
		try
		{
			String call = getSQLDatosCliente("VE_alta_cliente_PG", "VE_getListCalificacion1_PR", 4);
			cat.debug("sql[" + call + "]");
			cstmt = conn.prepareCall(call);
			cstmt.registerOutParameter(1, OracleTypes.CURSOR);
			cstmt.registerOutParameter(2, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);
			cat.debug("Execute Antes");
			cstmt.execute();
			cat.debug("Execute Despues");
			codError = cstmt.getInt(2);
			cat.debug("codError[" + codError + "]");
			msgError = cstmt.getString(3);
			cat.debug("msgError[" + msgError + "]");
			numEvento = cstmt.getInt(4);
			cat.debug("numEvento[" + numEvento + "]");
			if (codError != 0)
			{
				cat.error("Ocurrió un error al consultar calificaciones");
				throw new CustomerDomainException("Ocurrió un error al consultar calificaciones", String
						.valueOf(codError), numEvento, msgError);

			}
			else
			{
				cat.debug("Listado calificaciones");
				rs = (ResultSet) cstmt.getObject(1);
				ArrayList lista = new ArrayList();
				while (rs.next())
				{
					ValorClasificacionDTO valorClasificacion = new ValorClasificacionDTO();
					valorClasificacion.setCodClasificacion(rs.getString(1));
					valorClasificacion.setDesClasificacion(rs.getString(2));
					valorClasificacion.setIndDefecto(rs.getInt(3));
					lista.add(valorClasificacion);
				}
				resultado = (ValorClasificacionDTO[]) ArrayUtl.copiaArregloTipoEspecifico(lista.toArray(), ValorClasificacionDTO.class);
				;
			}
			if (cat.isDebugEnabled())
			{
				cat.debug(" Finalizo ejecución");
			}
		}
		catch (Exception e)
		{
			cat.error("Ocurrió un error al consultar calificaciones", e);
			if (cat.isDebugEnabled())
			{
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
			if (e instanceof CustomerDomainException)
			{
				throw (CustomerDomainException) e;
			}
			else
			{
				CustomerDomainException c = new CustomerDomainException();
				c.setMessage(e.getMessage());
				throw c;
			}
		}
		finally
		{
			if (cat.isDebugEnabled())
				cat.debug("Cerrando conexiones...");
			try
			{
				if (rs != null)
					rs.close();
				if (cstmt != null)
					cstmt.close();
				if (!conn.isClosed())
				{
					conn.close();
				}
			}
			catch (SQLException e)
			{
				cat.debug("SQLException", e);
			}
		}
		cat.debug("getCalificaciones():end");
		return resultado;
	}

	
	public ValorClasificacionDTO[] getCrediticia() 
		throws CustomerDomainException
	{
		cat.debug("getCrediticia:start");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		ValorClasificacionDTO[] resultado = null;
		Connection conn = null;
		CallableStatement cstmt = null;
		conn = getConection();
		ResultSet rs = null;
		cat.debug("Coneccion obtenida OK");
		try
		{
			String call = getSQLDatosCliente("VE_alta_cliente_PG", "VE_getListCrediticia_PR", 4);
			cat.debug("sql[" + call + "]");
			cstmt = conn.prepareCall(call);
			cstmt.registerOutParameter(1, OracleTypes.CURSOR);
			cstmt.registerOutParameter(2, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);
			cat.debug("Execute Antes");
			cstmt.execute();
			cat.debug("Execute Despues");
			codError = cstmt.getInt(2);
			cat.debug("codError[" + codError + "]");
			msgError = cstmt.getString(3);
			cat.debug("msgError[" + msgError + "]");
			numEvento = cstmt.getInt(4);
			cat.debug("numEvento[" + numEvento + "]");
			if (codError != 0)
			{
				cat.error("Ocurrió un error al consultar clasificacion crediticia");
				throw new CustomerDomainException("Ocurrió un error al consultar clasificacion crediticia", String
						.valueOf(codError), numEvento, msgError);

			}
			else
			{
				cat.debug("Listado clasificacion crediticia");
				rs = (ResultSet) cstmt.getObject(1);
				ArrayList lista = new ArrayList();
				while (rs.next())
				{
					ValorClasificacionDTO valorClasificacion = new ValorClasificacionDTO();
					valorClasificacion.setCodClasificacion(rs.getString(1));
					valorClasificacion.setDesClasificacion(rs.getString(2));
					valorClasificacion.setIndDefecto(rs.getInt(3));
					lista.add(valorClasificacion);
				}
				resultado = (ValorClasificacionDTO[]) ArrayUtl.copiaArregloTipoEspecifico(lista.toArray(), ValorClasificacionDTO.class);
				;
			}
			if (cat.isDebugEnabled())
			{
				cat.debug(" Finalizo ejecución");
			}
		}
		catch (Exception e)
		{
			cat.error("Ocurrió un error al consultar clasificacion crediticia", e);
			if (cat.isDebugEnabled())
			{
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
			if (e instanceof CustomerDomainException)
			{
				throw (CustomerDomainException) e;
			}
			else
			{
				CustomerDomainException c = new CustomerDomainException();
				c.setMessage(e.getMessage());
				throw c;
			}
		}
		finally
		{
			if (cat.isDebugEnabled())
				cat.debug("Cerrando conexiones...");
			try
			{
				if (rs != null)
					rs.close();
				if (cstmt != null)
					cstmt.close();
				if (!conn.isClosed())
				{
					conn.close();
				}
			}
			catch (SQLException e)
			{
				cat.debug("SQLException", e);
			}
		}
		cat.debug("getCrediticia():end");
		return resultado;
	}
	
	public ValorClasificacionDTO[] getColores() 
		throws CustomerDomainException
	{
		cat.debug("getColores:start");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		ValorClasificacionDTO[] resultado = null;
		Connection conn = null;
		CallableStatement cstmt = null;
		conn = getConection();
		ResultSet rs = null;
		cat.debug("Coneccion obtenida OK");
		try
		{
			String call = getSQLDatosCliente("VE_alta_cliente_PG", "VE_getListColores_PR", 4);
			cat.debug("sql[" + call + "]");
			cstmt = conn.prepareCall(call);
			cstmt.registerOutParameter(1, OracleTypes.CURSOR);
			cstmt.registerOutParameter(2, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);
			cat.debug("Execute Antes");
			cstmt.execute();
			cat.debug("Execute Despues");
			codError = cstmt.getInt(2);
			cat.debug("codError[" + codError + "]");
			msgError = cstmt.getString(3);
			cat.debug("msgError[" + msgError + "]");
			numEvento = cstmt.getInt(4);
			cat.debug("numEvento[" + numEvento + "]");
			if (codError != 0)
			{
				cat.error("Ocurrió un error al consultar colores");
				throw new CustomerDomainException("Ocurrió un error al consultar colores", String
						.valueOf(codError), numEvento, msgError);

			}
			else
			{
				cat.debug("Listado colores");
				rs = (ResultSet) cstmt.getObject(1);
				ArrayList lista = new ArrayList();
				while (rs.next())
				{
					ValorClasificacionDTO valorClasificacion = new ValorClasificacionDTO();
					valorClasificacion.setCodClasificacion(rs.getString(1));
					valorClasificacion.setDesClasificacion(rs.getString(2));
					valorClasificacion.setIndDefecto(rs.getInt(3));
					lista.add(valorClasificacion);
				}
				resultado = (ValorClasificacionDTO[]) ArrayUtl.copiaArregloTipoEspecifico(lista.toArray(), ValorClasificacionDTO.class);
				;
			}
			if (cat.isDebugEnabled())
			{
				cat.debug(" Finalizo ejecución");
			}
		}
		catch (Exception e)
		{
			cat.error("Ocurrió un error al consultar colores", e);
			if (cat.isDebugEnabled())
			{
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
			if (e instanceof CustomerDomainException)
			{
				throw (CustomerDomainException) e;
			}
			else
			{
				CustomerDomainException c = new CustomerDomainException();
				c.setMessage(e.getMessage());
				throw c;
			}
		}
		finally
		{
			if (cat.isDebugEnabled())
				cat.debug("Cerrando conexiones...");
			try
			{
				if (rs != null)
					rs.close();
				if (cstmt != null)
					cstmt.close();
				if (!conn.isClosed())
				{
					conn.close();
				}
			}
			catch (SQLException e)
			{
				cat.debug("SQLException", e);
			}
		}
		cat.debug("getColores():end");
		return resultado;
	}

	public ValorClasificacionDTO[] getSegmentos(String codTipoCliente) 
		throws CustomerDomainException
	{
		cat.debug("getSegmento:start");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		ValorClasificacionDTO[] resultado = null;
		Connection conn = null;
		CallableStatement cstmt = null;
		conn = getConection();
		ResultSet rs = null;
		cat.debug("Coneccion obtenida OK");
		try
		{
			String call = getSQLDatosCliente("VE_alta_cliente_PG", "VE_getListsegmentos_PR", 5);
			cat.debug("sql[" + call + "]");
			cstmt = conn.prepareCall(call);
			cstmt.setString(1, codTipoCliente);
			cstmt.registerOutParameter(2, OracleTypes.CURSOR);
			cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);
			cat.debug("Execute Antes");
			cstmt.execute();
			cat.debug("Execute Despues");
			codError = cstmt.getInt(3);
			cat.debug("codError[" + codError + "]");
			msgError = cstmt.getString(4);
			cat.debug("msgError[" + msgError + "]");
			numEvento = cstmt.getInt(5);
			cat.debug("numEvento[" + numEvento + "]");
			if (codError != 0)
			{
				cat.error("Ocurrió un error al consultar segmentos");
				throw new CustomerDomainException("Ocurrió un error al consultar segmentos", String
						.valueOf(codError), numEvento, msgError);

			}
			else
			{
				cat.debug("Listado segmentos");
				rs = (ResultSet) cstmt.getObject(2);
				ArrayList lista = new ArrayList();
				while (rs.next())
				{
					ValorClasificacionDTO valorClasificacion = new ValorClasificacionDTO();
					valorClasificacion.setCodClasificacion(rs.getString(1));
					valorClasificacion.setDesClasificacion(rs.getString(2));
					valorClasificacion.setIndDefecto(rs.getInt(3));
					lista.add(valorClasificacion);
				}
				resultado = (ValorClasificacionDTO[]) ArrayUtl.copiaArregloTipoEspecifico(lista.toArray(), ValorClasificacionDTO.class);
				;
			}
			if (cat.isDebugEnabled())
			{
				cat.debug(" Finalizo ejecución");
			}
		}
		catch (Exception e)
		{
			cat.error("Ocurrió un error al consultar segmentos", e);
			if (cat.isDebugEnabled())
			{
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
			if (e instanceof CustomerDomainException)
			{
				throw (CustomerDomainException) e;
			}
			else
			{
				CustomerDomainException c = new CustomerDomainException();
				c.setMessage(e.getMessage());
				throw c;
			}
		}
		finally
		{
			if (cat.isDebugEnabled())
				cat.debug("Cerrando conexiones...");
			try
			{
				if (rs != null)
					rs.close();
				if (cstmt != null)
					cstmt.close();
				if (!conn.isClosed())
				{
					conn.close();
				}
			}
			catch (SQLException e)
			{
				cat.debug("SQLException", e);
			}
		}
		cat.debug("getSegmento():end");
		return resultado;
	}

	public ValorClasificacionDTO[] getCategorias() 
		throws CustomerDomainException
	{
		cat.debug("getCategorias:start");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		ValorClasificacionDTO[] resultado = null;
		Connection conn = null;
		CallableStatement cstmt = null;
		conn = getConection();
		ResultSet rs = null;
		cat.debug("Coneccion obtenida OK");
		try
		{
			String call = getSQLDatosCliente("VE_alta_cliente_PG", "VE_getListCategorias_PR", 4);
			cat.debug("sql[" + call + "]");
			cstmt = conn.prepareCall(call);
			cstmt.registerOutParameter(1, OracleTypes.CURSOR);
			cstmt.registerOutParameter(2, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);
			cat.debug("Execute Antes");
			cstmt.execute();
			cat.debug("Execute Despues");
			codError = cstmt.getInt(2);
			cat.debug("codError[" + codError + "]");
			msgError = cstmt.getString(3);
			cat.debug("msgError[" + msgError + "]");
			numEvento = cstmt.getInt(4);
			cat.debug("numEvento[" + numEvento + "]");
			if (codError != 0)
			{
				cat.error("Ocurrió un error al consultar categorias");
				throw new CustomerDomainException("Ocurrió un error al consultar categorias", String
						.valueOf(codError), numEvento, msgError);

			}
			else
			{
				cat.debug("Listado categorias");
				rs = (ResultSet) cstmt.getObject(1);
				ArrayList lista = new ArrayList();
				while (rs.next())
				{
					ValorClasificacionDTO valorClasificacion = new ValorClasificacionDTO();
					valorClasificacion.setCodClasificacion(rs.getString(1));
					valorClasificacion.setDesClasificacion(rs.getString(2));
					valorClasificacion.setIndDefecto(rs.getInt(3));
					lista.add(valorClasificacion);
				}
				resultado = (ValorClasificacionDTO[]) ArrayUtl.copiaArregloTipoEspecifico(lista.toArray(), ValorClasificacionDTO.class);
				;
			}
			if (cat.isDebugEnabled())
			{
				cat.debug(" Finalizo ejecución");
			}
		}
		catch (Exception e)
		{
			cat.error("Ocurrió un error al consultar categorias", e);
			if (cat.isDebugEnabled())
			{
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
			if (e instanceof CustomerDomainException)
			{
				throw (CustomerDomainException) e;
			}
			else
			{
				CustomerDomainException c = new CustomerDomainException();
				c.setMessage(e.getMessage());
				throw c;
			}
		}
		finally
		{
			if (cat.isDebugEnabled())
				cat.debug("Cerrando conexiones...");
			try
			{
				if (rs != null)
					rs.close();
				if (cstmt != null)
					cstmt.close();
				if (!conn.isClosed())
				{
					conn.close();
				}
			}
			catch (SQLException e)
			{
				cat.debug("SQLException", e);
			}
		}
		cat.debug("getCategorias():end");
		return resultado;
	}
	
	public CategoriaCambioDTO[] getCategoriasCambio() 
		throws CustomerDomainException
	{
		cat.debug("getCategoriasCambio:start");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		CategoriaCambioDTO[] resultado = null;
		Connection conn = null;
		CallableStatement cstmt = null;
		conn = getConection();
		ResultSet rs = null;
		cat.debug("Coneccion obtenida OK");
		try
		{
			String call = getSQLDatosCliente("VE_alta_cliente_PG", "VE_getListCategoriaCambio_PR", 4);
			cat.debug("sql[" + call + "]");
			cstmt = conn.prepareCall(call);
			cstmt.registerOutParameter(1, OracleTypes.CURSOR);
			cstmt.registerOutParameter(2, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);
			cat.debug("Execute Antes");
			cstmt.execute();
			cat.debug("Execute Despues");
			codError = cstmt.getInt(2);
			cat.debug("codError[" + codError + "]");
			msgError = cstmt.getString(3);
			cat.debug("msgError[" + msgError + "]");
			numEvento = cstmt.getInt(4);
			cat.debug("numEvento[" + numEvento + "]");
			if (codError != 0)
			{
				cat.error("Ocurrió un error al consultar categorias de cambio");
				throw new CustomerDomainException("Ocurrió un error al consultar categorias de cambio", String
						.valueOf(codError), numEvento, msgError);

			}
			else
			{
				cat.debug("Listado categorias cambio");
				rs = (ResultSet) cstmt.getObject(1);
				ArrayList lista = new ArrayList();
				while (rs.next())
				{
					CategoriaCambioDTO categoriaCambio = new CategoriaCambioDTO();
					categoriaCambio.setCodCategoria(rs.getString(1));
					categoriaCambio.setDesCategoria(rs.getString(2));
					lista.add(categoriaCambio);
				}
				resultado = (CategoriaCambioDTO[]) ArrayUtl.copiaArregloTipoEspecifico(lista.toArray(), CategoriaCambioDTO.class);
				;
			}
			if (cat.isDebugEnabled())
			{
				cat.debug(" Finalizo ejecución");
			}
		}
		catch (Exception e)
		{
			cat.error("Ocurrió un error al consultar categorias de cambio", e);
			if (cat.isDebugEnabled())
			{
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
			if (e instanceof CustomerDomainException)
			{
				throw (CustomerDomainException) e;
			}
			else
			{
				CustomerDomainException c = new CustomerDomainException();
				c.setMessage(e.getMessage());
				throw c;
			}
		}
		finally
		{
			if (cat.isDebugEnabled())
				cat.debug("Cerrando conexiones...");
			try
			{
				if (rs != null)
					rs.close();
				if (cstmt != null)
					cstmt.close();
				if (!conn.isClosed())
				{
					conn.close();
				}
			}
			catch (SQLException e)
			{
				cat.debug("SQLException", e);
			}
		}
		cat.debug("getCategoriasCambio():end");
		return resultado;
	}
	
	/**
	 * Inserta categoria de cambio del cliente
	 * 
	 * @param categCambioCliente
	 * @return N/A
	 * @throws CustomerDomainException
	 */
	public void insCategoriaCambioCliente(CategoriaCambioClienteDTO categCambioCliente) throws CustomerDomainException
	{
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null;
		try
		{
			cat.debug("Inicio:insCategoriaCambioCliente");
			String nombrePackage = "VE_alta_cliente_PG";
			String nombrePL = "VE_insCategCambioCliente_PR";
			String call = getSQLDatosCliente(nombrePackage, nombrePL, 6);
			cat.debug("sql[" + call + "]");
			cstmt = conn.prepareCall(call);
			cstmt.setLong(1, categCambioCliente.getCodCliente());
			cat.debug("categCambioCliente.getCodCliente(): " + categCambioCliente.getCodCliente());
			cstmt.setInt(2, categCambioCliente.getCodCategoriaCambio());
			cat.debug("categCambioCliente.getCodCategoriaCambio(): " + categCambioCliente.getCodCategoriaCambio());
			cstmt.setString(3, categCambioCliente.getNomUsuario());
			cat.debug("categCambioCliente.getNomUsuario(): " + categCambioCliente.getNomUsuario());

			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(5, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(6, java.sql.Types.NUMERIC);

			cat.debug("Inicio:insCategoriaCambioCliente:execute");
			cstmt.execute();
			cat.debug("Fin:insCategoriaCambioCliente:execute");

			codError = cstmt.getInt(4);
			msgError = cstmt.getString(5);
			numEvento = cstmt.getInt(6);

			if (codError != 0)
			{
				cat.error("Ocurrió un error al insertar categoria de cambio del cliente");
				throw new CustomerDomainException("Ocurrió un error al insertar categoria de cambio del cliente", String
						.valueOf(codError), numEvento, msgError);
			}
		}
		catch (Exception e)
		{
			cat.error("Ocurrió un error al insertar categoria de cambio del cliente", e);
			if (cat.isDebugEnabled())
			{
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
			if (e instanceof CustomerDomainException)
				throw (CustomerDomainException) e;
		}
		finally
		{
			if (cat.isDebugEnabled())
				cat.debug("Cerrando conexiones...");
			try
			{
				if (cstmt != null)
					cstmt.close();
				if (!conn.isClosed())
				{
					conn.close();
				}
			}
			catch (SQLException e)
			{
				cat.debug("SQLException", e);
			}
		}
		cat.debug("Fin:insCategoriaCambioCliente()");
	}// fin insCategoriaCambioCliente

	
	/**
	 * @author mwn40031
	 * @param codCliente
	 * @param numIdent
	 * @param codTipIdent
	 * @return
	 * @throws CustomerDomainException
	 */
	public Boolean validaClienteLN(String codCliente, String numIdent, String codTipIdent)
			throws CustomerDomainException {
		/*
		 * PROCEDURE VE_VALIDA_CLIENTELN_PR (EN_COD_CLIENTE IN GE_CLIENTES.COD_CLIENTE%TYPE, EV_NUM_IDENT
		 * GE_CLIENTES.NUM_IDENT%TYPE, EV_COD_TIPIDENT GE_CLIENTES.COD_TIPIDENT%TYPE, SN_cod_retorno OUT NOCOPY
		 * ge_errores_pg.CodError, SV_mens_retorno OUT NOCOPY ge_errores_pg.MsgError, SN_num_evento OUT NOCOPY
		 * ge_errores_pg.Evento);
		 */

		cat.info("Inicio");
		final String nombrePackage = "VE_SERVICIOS_SOLICITUD_PG";
		final String nombrePL = "VE_VALIDA_CLIENTELN_PR";

		cat.debug("codCliente: " + codCliente);
		cat.debug("numIdent: " + numIdent);
		cat.debug("codTipIdent: " + codTipIdent);

		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = getConection();

		CallableStatement cstmt = null;
		
		final int numParametros = 6;
		try {
			String call = getSQLDatosCliente(nombrePackage, nombrePL, numParametros);
			cat.debug("SQL [" + call + "]");
			cstmt = conn.prepareCall(call);
			
			if (codCliente != null) {
				cstmt.setString(1, codCliente);
			}
			else {
				cstmt.setNull(1, java.sql.Types.VARCHAR);
			}
			if (numIdent != null) {
				cstmt.setString(2, numIdent);
			}
			else {
				cstmt.setNull(2, java.sql.Types.VARCHAR);
			}
			if (codTipIdent != null) {
				cstmt.setString(3, codTipIdent);
			}
			else {
				cstmt.setNull(3, java.sql.Types.VARCHAR);
			}
					
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(5, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(6, java.sql.Types.NUMERIC);

			cat.debug("Antes de cstmt.execute()...");
			cstmt.execute();
			cat.debug("...después.");

			codError = cstmt.getInt(4);
			msgError = cstmt.getString(5);
			numEvento = cstmt.getInt(6);

			cat.debug("codError [" + codError + "]");
			cat.debug("msgError [" + msgError + "]");
			cat.debug("numEvento [" + numEvento + "]");

			if (codError != 0) {
				throw new CustomerDomainException("Ocurrió un error al obtener datos", String.valueOf(codError),
						numEvento, msgError);
			}

		}
		catch (Exception e) {
			cat.error("Ocurrió un error al obtener datos", e);
			if (cat.isDebugEnabled()) {
				cat.debug("codError [" + codError + "]");
				cat.debug("msgError [" + msgError + "]");
				cat.debug("numEvento [" + numEvento + "]");
			}
			if (e instanceof CustomerDomainException) {
				throw (CustomerDomainException) e;
			}
		}
		finally {
			if (cat.isDebugEnabled())
				cat.debug("Cerrando conexiones...");
			try {
				if (cstmt != null)
					cstmt.close();
				if (!conn.isClosed()) {
					conn.close();
				}
			}
			catch (SQLException e) {
				cat.debug("SQLException", e);
			}
		}
		cat.info("Fin");
		return Boolean.TRUE;
	}
	
	public boolean validarTelefonoLDI(String telefono) throws CustomerDomainException {
		cat.debug("validarTelefonoLDI, inicio");
		final String nombrePackage = "VE_Numeracion_Pg";
		final String nombrePL = "VE_VALIDA_NUMERACION_LDI_PR";
		final int cantidadParametros = 4;
		final String mensajeError = "Ocurrió un error al validar el número";
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		boolean r = false;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null;
		cat.debug("Conexión obtenida OK");
		try {
			String sql = getSQLDatosCliente(nombrePackage, nombrePL, cantidadParametros);
			cat.debug("sql [" + sql + "]");
			cstmt = conn.prepareCall(sql);
			cstmt.setString(1, telefono);
			cat.debug("telefono: " + telefono);
			cstmt.registerOutParameter(cantidadParametros - 2, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(cantidadParametros - 1, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(cantidadParametros - 0, java.sql.Types.NUMERIC);

			cat.debug("cstmt.execute(), antes");
			cstmt.execute();
			cat.debug("cstmt.execute(), después");

			codError = cstmt.getInt(cantidadParametros - 2);
			cat.debug("codError [" + codError + "]");
			msgError = cstmt.getString(cantidadParametros - 1);
			cat.debug("msgError [" + msgError + "]");
			numEvento = cstmt.getInt(cantidadParametros);
			cat.debug("numEvento [" + numEvento + "]");
			if (codError != 0) {
				cat.error(mensajeError);
				throw new CustomerDomainException(mensajeError, String.valueOf(codError), numEvento, msgError);
			}
			else {
				r = true;
			}
			if (cat.isDebugEnabled()) {
				cat.debug("Finalizó ejecución");
			}
		}
		catch (Exception e) {
			cat.error(mensajeError, e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error [" + codError + "]");
				cat.debug("Mensaje de Error [" + msgError + "]");
				cat.debug("Numero de Evento [" + numEvento + "]");
			}
		}
		finally {
			if (cat.isDebugEnabled())
				cat.debug("Cerrando conexiones...");
			try {
				if (cstmt != null) {
					cstmt.close();
				}
				if (!conn.isClosed()) {
					conn.close();
				}
			}
			catch (SQLException e) {
				cat.debug("SQLException", e);
			}
		}
		cat.debug("Respuesta [" + r + "]");
		cat.debug("validarTelefonoLDI, fin");
		return r;
	}
	
	public boolean verificaPrestacionCliente(Long codCliente, String codPrestacion) throws CustomerDomainException {
		cat.info("verificaPrestacionCliente, inicio");
		cat.debug("codCliente [" + codCliente + "]");
		cat.debug("codPrestacion [" + codPrestacion + "]");
		final String nombrePackage = "Ve_Servicios_Venta_Pg".toUpperCase();
		final String nombrePL = "VE_verificaPrestClte_PR".toUpperCase();
		final int cantidadParametros = 6;
		final String mensajeError = "Ocurrió un error al verificar prestacion cliente";
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		boolean r = false;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null;
		int count = 0;
		try {
			int i = 1;
			final String sql = getSQLDatosCliente(nombrePackage, nombrePL, cantidadParametros);
			cat.debug("sql [" + sql + "]");
			cstmt = conn.prepareCall(sql);
			cstmt.setLong(i++, codCliente.longValue());
			cstmt.setString(i++, codPrestacion);

			cstmt.registerOutParameter(i++, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(i++, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(i++, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(i++, java.sql.Types.NUMERIC);

			cat.debug("cstmt.execute(), antes");
			cstmt.execute();
			cat.debug("cstmt.execute(), después");

			codError = cstmt.getInt(cantidadParametros - 2);
			cat.debug("codError [" + codError + "]");
			msgError = cstmt.getString(cantidadParametros - 1);
			cat.debug("msgError [" + msgError + "]");
			numEvento = cstmt.getInt(cantidadParametros);
			cat.debug("numEvento [" + numEvento + "]");
			if (codError != 0) {
				throw new CustomerDomainException(mensajeError, String.valueOf(codError), numEvento, msgError);
			}
			count = cstmt.getInt(cantidadParametros - 3);
			cat.debug("count [" + count + "]");
			r = count == 0 ? false : true;
			cat.debug("Finalizó ejecución");
		}
		catch (Exception e) {
			cat.error(mensajeError, e);
			cat.error("Codigo de Error [" + codError + "]");
			cat.error("Mensaje de Error [" + msgError + "]");
			cat.error("Numero de Evento [" + numEvento + "]");
		}
		finally {

			cat.debug("Cerrando conexiones...");
			try {
				if (cstmt != null) {
					cstmt.close();
				}
				if (!conn.isClosed()) {
					conn.close();
				}
			}
			catch (SQLException e) {
				cat.debug("SQLException", e);
			}
		}
		cat.debug("Respuesta [" + r + "]");
		cat.info("verificaPrestacionCliente, fin");
		return r;
	}
	
	public void updIngresosMensualesCliente(ClienteDTO cliente) 
		throws CustomerDomainException
	{
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null;
		final String mensajeError = "Ocurrió un error actualizar los ingresos mensuales del cliente";
		try
		{
			cat.debug("Inicio:updIngresosMensualesCliente");
	
			String call = getSQLDatosCliente("VE_alta_cliente_PG", "VE_updIngresosMensuales_PR", 5);
			cat.debug("sql[" + call + "]");
	
			cstmt = conn.prepareCall(call);
	
			cstmt.setString(1, cliente.getCodigoCliente());
			cat.debug("cliente.getCodigoCliente(): " + cliente.getCodigoCliente());
			cstmt.setDouble(2, cliente.getIngresosMensuales().doubleValue());
			cat.debug("cliente.getIngresosMensuales(): " + cliente.getIngresosMensuales());
	
			cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);
	
			cat.debug("Inicio:updIngresosMensualesCliente:execute");
			cstmt.execute();
			cat.debug("Fin:updIngresosMensualesCliente:execute");
	
			codError = cstmt.getInt(3);
			msgError = cstmt.getString(4);
			numEvento = cstmt.getInt(5);
	
			if (codError != 0)
			{
				cat.error(mensajeError);
				throw new CustomerDomainException(mensajeError, String.valueOf(codError), numEvento, msgError);
			}
		}
		catch (Exception e)
		{
			cat.error(mensajeError, e);
			if (cat.isDebugEnabled())
			{
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
			if (e instanceof CustomerDomainException)
				throw (CustomerDomainException) e;
		}
		finally
		{
			if (cat.isDebugEnabled())
				cat.debug("Cerrando conexiones...");
			try
			{
				if (cstmt != null)
					cstmt.close();
				if (!conn.isClosed())
				{
					conn.close();
				}
			}
			catch (SQLException e)
			{
				cat.debug("SQLException", e);
			}
		}
		cat.debug("Fin:updIngresosMensualesCliente()");
	}// fin updIngresosMensualesCliente
	
	//Inicio P-CSR-11002 JLGN 26-04-2011 RMS-003 Despliegue de parámetros en la Creación del Cliente
	/**
	 * Inserta Datos Redes Sociales
	 * 
	 * @param cliente
	 * @return N/A
	 * @throws CustomerDomainException
	 */
	public void insDatosRedSocial(ClienteAltaDTO cliente) 
		throws CustomerDomainException
	{
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null;
		try
		{
			cat.debug("Inicio:insDatosRedSocial");

			String call = getSQLDatosCliente("VE_alta_cliente_PG", "VE_insRedSocial_PR", 6);
			cat.debug("sql[" + call + "]");
			cstmt = conn.prepareCall(call);

			cat.debug("cliente.getCodigoCliente(): " + cliente.getCodigoCliente());
			cstmt.setLong(1, Long.parseLong(cliente.getCodigoCliente()));			
			cat.debug("cliente.getCuentaFacebook(): " + cliente.getCuentaFacebook());
			cstmt.setString(2, cliente.getCuentaFacebook());
			cat.debug("cliente.getCuentaTwitter(): " + cliente.getCuentaTwitter());
			cstmt.setString(3, cliente.getCuentaTwitter());
			
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(5, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(6, java.sql.Types.NUMERIC);

			cat.debug("Inicio:insDatosRedSocial:execute");
			cstmt.execute();
			cat.debug("Fin:insDatosRedSocial:execute");

			codError = cstmt.getInt(4);
			msgError = cstmt.getString(5);
			numEvento = cstmt.getInt(6);

			if (codError != 0)
			{
				cat.error("Ocurrió un error al insertar Datos de Red Social");
				throw new CustomerDomainException("Ocurrió un error al insertar Datos de Red Social", String.valueOf(codError),
						numEvento, msgError);
			}
		}
		catch (Exception e)
		{
			cat.error("Ocurrió un error al insertar Datos de Red Social", e);
			if (cat.isDebugEnabled())
			{
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
			if (e instanceof CustomerDomainException)
				throw (CustomerDomainException) e;
		}
		finally
		{
			if (cat.isDebugEnabled())
				cat.debug("Cerrando conexiones...");
			try
			{
				if (cstmt != null)
					cstmt.close();
				if (!conn.isClosed())
				{
					conn.close();
				}
			}
			catch (SQLException e)
			{
				cat.debug("SQLException", e);
			}
		}
		cat.debug("Fin:insDatosRedSocial()");
	}// fin insDatosRedSocial
	
	/**
	 * Inserta Datos Envio Factura Fisica
	 * 
	 * @param cliente
	 * @return N/A
	 * @throws CustomerDomainException
	 */
	public void insEnvioFacturaFisica(ClienteAltaDTO cliente) 
		throws CustomerDomainException
	{
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null;
		try
		{
			cat.debug("Inicio:insEnvioFacturaFisica");
			
			cat.debug("INC-184210 25-05-2012 INICIO");
			//String call = getSQLDatosCliente("VE_alta_cliente_PG", "VE_insEnvFacturFisi_PR", 4);
			String call = getSQLDatosCliente("VE_alta_cliente_PG", "VE_insEnvFacturFisi_PR", 5);
			cat.debug("INC-184210 25-05-2012 FIN");
			
			cat.debug("sql[" + call + "]");
			cstmt = conn.prepareCall(call);

			cat.debug("cliente.getCodigoCliente(): " + cliente.getCodigoCliente());
			cstmt.setLong(1, Long.parseLong(cliente.getCodigoCliente()));			
			
			cstmt.registerOutParameter(2, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);
			cat.debug("INC-184210 25-05-2012 INICIO");
			cstmt.setString(5, cliente.getEnvioFacturaFisica());	
			cat.debug("INC-184210 25-05-2012 FIN");

			cat.debug("Inicio:insEnvioFacturaFisica:execute");
			cstmt.execute();
			cat.debug("Fin:insEnvioFacturaFisica:execute");

			codError = cstmt.getInt(2);
			msgError = cstmt.getString(3);
			numEvento = cstmt.getInt(4);

			if (codError != 0)
			{
				cat.error("Ocurrió un error al insertar Envio de Factura Fisica");
				throw new CustomerDomainException("Ocurrió un error al insertar Envio de Factura Fisica", String.valueOf(codError),
						numEvento, msgError);
			}
		}
		catch (Exception e)
		{
			cat.error("Ocurrió un error al insertar Envio de Factura Fisica", e);
			if (cat.isDebugEnabled())
			{
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
			if (e instanceof CustomerDomainException)
				throw (CustomerDomainException) e;
		}
		finally
		{
			if (cat.isDebugEnabled())
				cat.debug("Cerrando conexiones...");
			try
			{
				if (cstmt != null)
					cstmt.close();
				if (!conn.isClosed())
				{
					conn.close();
				}
			}
			catch (SQLException e)
			{
				cat.debug("SQLException", e);
			}
		}
		cat.debug("Fin:insEnvioFacturaFisica()");
	}// fin insEnvioFacturaFisica
	//Fin P-CSR-11002 JLGN 26-04-2011 
	//Inicio P-CSR-11002 JLGN 04-05-2011
	public DatosClienteBuroDTO consultaBuro(String url, String tipIdent) throws AltaClienteException, IOException , Exception{
		cat.debug("consultaBuro:start");
		DatosClienteBuroDTO resultado =  new DatosClienteBuroDTO();
		try{
			cat.debug("Carga Ruta: "+url);
			cat.debug("tipIdent: "+tipIdent);
			URL ruta = new URL(url);
			cat.debug("Abre Conexion");
			SSLSocketFactory sslsocketfactory = (SSLSocketFactory) SSLSocketFactory.getDefault();
			SOAPHttpsURLConnection conn = (SOAPHttpsURLConnection)ruta.openConnection();
			conn.setSSLSocketFactory(sslsocketfactory); 
			cat.debug("Despues de Abrir Conexion");
			conn.setDoInput(true); 
			conn.setDoOutput(true);
			//Se lee la respuesta	
			
			/*URL ruta = new URL(url);		
			HttpURLConnection conn = null;		
			conn = (HttpURLConnection)ruta.openConnection();*/
				cat.debug("Conexion OK");
				InputStream is = conn.getInputStream();
				DocumentBuilderFactory dml = DocumentBuilderFactory.newInstance();
			    DocumentBuilder db = dml.newDocumentBuilder();
			    Document doc = db.parse(is);
			    Element rootElement = doc.getDocumentElement();
			    NodeList nodeLst = null;
			    
			    nodeLst = rootElement.getElementsByTagName("KeyRef");			        
		        if(nodeLst != null && nodeLst.getLength()>0){
		        	Element el = (Element)nodeLst.item(0);			        	
		        	if(el.getFirstChild() != null){
		        		cat.debug("KeyRef: " + el.getFirstChild().getNodeValue());
		        		resultado.setKeyRef(el.getFirstChild().getNodeValue());
		        	}else{
		        		cat.debug("KeyRef es Vacio o Nulo");
		        		resultado.setKeyRef("");
		        	}	
		        }    
			    
			    nodeLst = rootElement.getElementsByTagName("datos_generales");			    
			    //Inicio seteo datos generales
			    for(int i=0;i<nodeLst.getLength();i++){
			    	Element element = (Element)nodeLst.item(i);
			    	NodeList nodeList2 = null;			    	
			    	//Se valida primer Tag que indica si cliente existe 			    	
			    	nodeList2 = element.getElementsByTagName("dato");
			    	if(nodeList2 != null && nodeList2.getLength()>0){
			        	Element el = (Element)nodeList2.item(0);			        				        	
			        	if(el.getFirstChild() != null){	
			        		cat.debug("dato: " + el.getFirstChild().getNodeValue());
			        		String dato = el.getFirstChild().getNodeValue();				        	
				        	if (dato.toUpperCase().equals("1")){ //Cliente no existe en Buro
				        		cat.debug("Cliente no Existe");
				        		//Inicio Inc.179734 03-01-2012 JLGN
				        		//Inc.179734 03-01-2012 Si el tipo de Identificacion es de tipo cedula o pasaporte continua el Flujo normal
				        		if(tipIdent.trim().equals("JUR")){ 
				        			throw new AltaClienteException("1001",1,"Cliente no Existe");		
				        		}else{
				        			throw new AltaClienteException("1004",1,"Cliente no Existe, Se debe ingresar los datos manualmente");
				        		}
				        		//Fin Inc.179734 03-01-2012 JLGN
				        	}else if (dato.toUpperCase().equals("2")){ //Cliente Bloqueado en Buro
				        		nodeList2 = element.getElementsByTagName("nombre");
				        		if(nodeList2 != null && nodeList2.getLength()>0){
						        	Element el2 = (Element)nodeList2.item(0);
						        	if(el2.getFirstChild() != null){
						        		String nombre = el2.getFirstChild().getNodeValue();
						        		cat.debug("Cliente con error: "+nombre);
						        		throw new AltaClienteException("1001",2,nombre);
						        	}
						        }						        	
				        	}				        
			        	}else{
			        		cat.debug("Error al Validar si Cliente Existe");
			        		throw new AltaClienteException("Error al Validar si Cliente Existe");			        		
			        	}	
			        }
			    	//Inicio P-CSR-11002 JLGN 09-08-2011			    	
			    	//Se valida valor que valor del Flag sea 1
			    	DatosGeneralesDAO datosGeneralesDAO  = new DatosGeneralesDAO();
			    	DatosGeneralesDTO datosGenerales = new DatosGeneralesDTO();
			    	datosGenerales.setCodigoModulo("VE");
			    	datosGenerales.setCodigoProducto("1");
			    	datosGenerales.setCodigoParametro("FLAG_MENSAJE_XML");
			    	datosGenerales = datosGeneralesDAO.getValorParametro(datosGenerales);
			    	
			    	//Inicio Inc.179734 05-01-2012 JGLN
			    	resultado.setFlagDDA("false");
			    	resultado.setMensError("");
			    	//Fin Inc.179734 05-01-2012 JGLN
			    	
			    	if(datosGenerales.getValorParametro().trim().equals("1")){
				    	cat.debug("Flag Activado");
			    		//Inicio P-CSR-11002 JLGN 04-08-2011
				    	nodeList2 = element.getElementsByTagName("cod_mensaje");			    	
				    	if(nodeList2 != null && nodeList2.getLength()>0){
				    		Element el = (Element)nodeList2.item(0);			        				        	
				        	if(el.getFirstChild() != null){	
				        		cat.debug("cod_mensaje: " + el.getFirstChild().getNodeValue());
				        		String cod_mensaje = el.getFirstChild().getNodeValue();
				        		if (!cod_mensaje.toUpperCase().equals("0")){//Es distinto de 0		
				        			String menError = "";
				        			if(tipIdent.trim().equals("JUR")){//Cliente Empresa
				        				//Se Valida si el codigo del mensaje esta configurado para realizar Domiciliación Débito Automático 
					        			//Inicio Inc.179734 01-2012 JLGN
				        				if(validaMensajeError("JUR",cod_mensaje)){
				        					resultado.setFlagDDA("false");
				        					//menError = obtieneMensajeError("JUR",cod_mensaje);
				        					//resultado.setMensError(menError);
				        				}else{
				        					cat.debug("Error Cliente Buro "+ menError);
				        					menError = obtieneMensajeError("JUR",cod_mensaje);
					        				resultado.setFlagDDA("false");
						        			throw new AltaClienteException("1003",1,menError);
				        				}
				        				
				        			}else{
				        				//Se Valida si el codigo del mensaje esta configurado para realizar Domiciliación Débito Automático 
					        			//Inicio Inc.179734 01-2012 JLGN
				        				if(validaMensajeError("RES",cod_mensaje)){
				        					resultado.setFlagDDA("false");
				        					//menError = obtieneMensajeError("CED",cod_mensaje);
				        					//resultado.setMensError(menError);
				        				}else{
				        					cat.debug("Error Cliente Buro "+ menError);
				        					menError = obtieneMensajeError("CED",cod_mensaje);
					        				resultado.setFlagDDA("false");
						        			throw new AltaClienteException("1003",1,menError);
				        				}				        				
				        			}	
				        			
				        			//Inicio Inc.179734 01-2012 Si el tipo de Identificacion es de tipo cedula o pasaporte continua el Flujo normal
				        			/*if(tipIdent.trim().equals("CED") || tipIdent.trim().equals("PAS")){ 
				        				cat.debug("Error Cliente Buro "+ menError);
				        				resultado.setFlagDDA("false");
					        			throw new AltaClienteException("1003",1,menError);
				        			}*/				        			
									//Fin Inc.179734 01-2012
				        		}
				        	}else{
				        		cat.debug("Error al Validar Motivo del Rechazo");
				        		throw new AltaClienteException("Error al Validar Motivo del Rechazo");			        		
				        	}			    		
				    	}
				    	//Fin P-CSR-11002 JLGN 04-08-2011
			    	}	
			    	//Fin P-CSR-11002 JLGN 09-08-2011
			    	
			    	//Se valida que cliente no se encuentre fallecido
			    	nodeList2 = element.getElementsByTagName("fallecido");			        
			        if(nodeList2 != null && nodeList2.getLength()>0){
			        	Element el = (Element)nodeList2.item(0);			        				        	
			        	//if(el.getFirstChild().getNodeValue() != null || !el.getFirstChild().getNodeValue().equals("")){
			        	if(el.getFirstChild() != null){	
			        		cat.debug("fallecido: " + el.getFirstChild().getNodeValue());
			        		String fallecido = el.getFirstChild().getNodeValue();				        	
				        	if (fallecido.toUpperCase().equals("SI")){
				        		//cat.debug("La identificación consultada pertenece a un cliente Fallecido");
				        		cat.debug("Persona Consultada se encuentra Fallecida, debe notificar al Área de Creditos");
				        		//throw new AltaClienteException("1000",0,"La identificación consultada pertenece a un cliente Fallecido");
				        		throw new AltaClienteException("1000",0,"Persona Consultada se encuentra Fallecida, debe notificar al Área de Creditos");
				        	}
			        	}else{
			        		cat.debug("Error al Obtener Fallecimiento del Cliente");
			        		throw new AltaClienteException("Error al Obtener Fallecimiento del Cliente");			        		
			        	}	
			        }			        
			        //Persona no se encuentra fallecida continua con el Alta de Cliente
			        nodeList2 = element.getElementsByTagName("KeyRef");			        
			        if(nodeList2 != null && nodeList2.getLength()>0){
			        	Element el = (Element)nodeList2.item(0);			        	
			        	if(el.getFirstChild() != null){
			        		cat.debug("KeyRef: " + el.getFirstChild().getNodeValue());
			        		resultado.setKeyRef(el.getFirstChild().getNodeValue());
			        	}else{
			        		cat.debug("KeyRef es Vacio o Nulo");
			        		resultado.setKeyRef("");
			        	}	
			        }			        
			    	nodeList2 = element.getElementsByTagName("nombre");			        
			        if(nodeList2 != null && nodeList2.getLength()>0){
			        	Element el = (Element)nodeList2.item(0);			        		
			        	if(el.getFirstChild() != null){
			        		cat.debug("Nombre: " + el.getFirstChild().getNodeValue());
			        		resultado.setNombre(el.getFirstChild().getNodeValue());
			        		resultado.setRazonSocial(el.getFirstChild().getNodeValue());
			        	}else{
			        		cat.debug("Nombre es Vacio o Nulo");
			        		resultado.setNombre("");
			        		resultado.setRazonSocial("");
			        	}	
			        }			        
			        //Inicio P-CSR-11002 JLGN 11-07-2011
			        //Inicio Inc.179734 01-01-2012 JLGN
					//if(!tipIdent.equals("JUR")){
				        nodeList2 = element.getElementsByTagName("apellido1");			        
				        if(nodeList2 != null && nodeList2.getLength()>0){
				        	Element el = (Element)nodeList2.item(0);			        	
				        	if(el.getFirstChild() != null){
				        		cat.debug("apellido1: " + el.getFirstChild().getNodeValue());
				        		resultado.setApellido1(el.getFirstChild().getNodeValue());
				        	}else{
				        		cat.debug("apellido1 es Vacio o Nulo");
				        		resultado.setApellido1("");
				        	}	
				        }			        
				        nodeList2 = element.getElementsByTagName("apellido2");			        
				        if(nodeList2 != null && nodeList2.getLength()>0){
				        	Element el = (Element)nodeList2.item(0);			        	
				        	if(el.getFirstChild() != null){
				        		cat.debug("apellido2: " + el.getFirstChild().getNodeValue());
				        		resultado.setApellido2(el.getFirstChild().getNodeValue());
				        	}else{
				        		cat.debug("apellido2 es Vacio o Nulo");
				        		resultado.setApellido2("");
				        	}	
				        }
			        //}  //Fin Inc.179734 01-01-2012 JLGN  
			        nodeList2 = element.getElementsByTagName("cedula");			        
			        if(nodeList2 != null && nodeList2.getLength()>0){
			        	Element el = (Element)nodeList2.item(0);			        	
			        	if(el.getFirstChild() != null){
			        		cat.debug("cedula: " + el.getFirstChild().getNodeValue());
			        		resultado.setNumeroCedula(el.getFirstChild().getNodeValue());
			        	}else{
			        		cat.debug("cedula es Vacio o Nulo");
			        		resultado.setNumeroCedula("");
			        	}	
			        }				        
			        nodeList2 = element.getElementsByTagName("fallecido");			        
			        if(nodeList2 != null && nodeList2.getLength()>0){
			        	Element el = (Element)nodeList2.item(0);			        	
			        	if(el.getFirstChild() != null){
			        		cat.debug("fallecido: " + el.getFirstChild().getNodeValue());
			        		resultado.setFallecido(el.getFirstChild().getNodeValue());
			        	}else{
			        		cat.debug("Fallecido es Vacio o Nulo");
			        		resultado.setFallecido("");
			        	}
			        }			        
			        nodeList2 = element.getElementsByTagName("cod_fallecido");			        
			        if(nodeList2 != null && nodeList2.getLength()>0){
			        	Element el = (Element)nodeList2.item(0);			        	
			        	if(el.getFirstChild() != null){
			        		cat.debug("cod_fallecido: " + el.getFirstChild().getNodeValue());
			        		resultado.setCodFallecido(el.getFirstChild().getNodeValue());
			        	}else{
			        		cat.debug("cod_Fallecido es Vacio o Nulo");
			        		resultado.setCodFallecido("");
			        	}
			        }			        
			        nodeList2 = element.getElementsByTagName("EsPEP");			        
			        if(nodeList2 != null && nodeList2.getLength()>0){
			        	Element el = (Element)nodeList2.item(0);			        	
			        	if(el.getFirstChild() != null){
			        		cat.debug("EsPEP: " + el.getFirstChild().getNodeValue());
			        		resultado.setEsPEP(el.getFirstChild().getNodeValue());
			        	}else{
			        		cat.debug("EsPEP es Vacio o Nulo");
			        		resultado.setEsPEP("");
			        	}
			        }			        
			        nodeList2 = element.getElementsByTagName("Institucion");			        
			        if(nodeList2 != null && nodeList2.getLength()>0){
			        	Element el = (Element)nodeList2.item(0);			        	
			        	if(el.getFirstChild() != null){
			        		cat.debug("Institucion: " + el.getFirstChild().getNodeValue());
			        		resultado.setInstitucionPEP(el.getFirstChild().getNodeValue());
			        	}else{
			        		cat.debug("Institucion es Vacio o Nulo");
			        		resultado.setInstitucionPEP("");
			        	}
			        }
			        nodeList2 = element.getElementsByTagName("Cargo");			        
			        if(nodeList2 != null && nodeList2.getLength()>0){
			        	Element el = (Element)nodeList2.item(0);			        	
			        	if(el.getFirstChild() != null){
			        		cat.debug("Cargo: " + el.getFirstChild().getNodeValue());
			        		resultado.setCargoPEP(el.getFirstChild().getNodeValue());
			        	}else{
			        		cat.debug("CargoPEP es Vacio o Nulo");
			        		resultado.setCargoPEP("");
			        	}
			        }
			        nodeList2 = element.getElementsByTagName("Periodo");			        
			        if(nodeList2 != null && nodeList2.getLength()>0){
			        	Element el = (Element)nodeList2.item(0);			        	
			        	if(el.getFirstChild() != null){
			        		cat.debug("Periodo: " + el.getFirstChild().getNodeValue());
			        		resultado.setPeriodoPEP(el.getFirstChild().getNodeValue());
			        	}else{
			        		cat.debug("PeridoPEP es Vacio o Nulo");
			        		resultado.setPeriodoPEP("");
			        	}
			        }
			        nodeList2 = element.getElementsByTagName("fechavencimientocedula");			        
			        if(nodeList2 != null && nodeList2.getLength()>0){
			        	Element el = (Element)nodeList2.item(0);			        	
			        	if(el.getFirstChild() != null){
			        		cat.debug("fechavencimientocedula: " + el.getFirstChild().getNodeValue());
			        		resultado.setFechaVencimientoCedula(el.getFirstChild().getNodeValue());
			        	}else{
			        		cat.debug("FechaVencimientoCedula es Vacio o Nulo");
			        		resultado.setFechaVencimientoCedula("");
			        	}
			        }
			        nodeList2 = element.getElementsByTagName("sexo");			        
			        if(nodeList2 != null && nodeList2.getLength()>0){
			        	Element el = (Element)nodeList2.item(0);			        	
			        	if(el.getFirstChild() != null){
			        		cat.debug("sexo: " + el.getFirstChild().getNodeValue());
			        		resultado.setSexo(el.getFirstChild().getNodeValue());
			        	}else{
			        		cat.debug("Sexo es Vacio o Nulo");
			        		resultado.setSexo("");
			        	}
			        }
			        nodeList2 = element.getElementsByTagName("fec_nacimiento");			        
			        if(nodeList2 != null && nodeList2.getLength()>0){
			        	Element el = (Element)nodeList2.item(0);			        	
			        	if(el.getFirstChild() != null){
			        		cat.debug("fec_nacimiento: " + el.getFirstChild().getNodeValue());
			        		resultado.setFechaNacimiento(el.getFirstChild().getNodeValue());
			        	}else{
			        		cat.debug("FechaNacimiento es Vacio o Nulo");
			        		resultado.setFechaNacimiento("");
			        	}
			        }
			        nodeList2 = element.getElementsByTagName("pais_nacimiento");			        
			        if(nodeList2 != null && nodeList2.getLength()>0){
			        	Element el = (Element)nodeList2.item(0);			        	
			        	if(el.getFirstChild() != null){
			        		cat.debug("pais_nacimiento: " + el.getFirstChild().getNodeValue());
			        		resultado.setPaisNacimiento(el.getFirstChild().getNodeValue());
			        	}else{
			        		cat.debug("PaisNacimiento es Vacio o Nulo");
			        		resultado.setPaisNacimiento("");
			        	}
			        }
			        nodeList2 = element.getElementsByTagName("cod_pais_nacimiento");			        
			        if(nodeList2 != null && nodeList2.getLength()>0){
			        	Element el = (Element)nodeList2.item(0);			        	
			        	if(el.getFirstChild() != null){
			        		cat.debug("cod_pais_nacimiento: " + el.getFirstChild().getNodeValue());
			        		resultado.setPrefijoPais(el.getFirstChild().getNodeValue());
			        	}else{
			        		cat.debug("cod_pais_nacimiento es Vacio o Nulo");
			        		resultado.setPrefijoPais("");
			        	}
			        }			        
			        //Inicio P-CSR-11002 JLGN 11-07-2011
			        nodeList2 = element.getElementsByTagName("codtel_pais_nacimiento");			        
			        if(nodeList2 != null && nodeList2.getLength()>0){
			        	Element el = (Element)nodeList2.item(0);			        	
			        	if(el.getFirstChild() != null){
			        		cat.debug("codtel_pais_nacimiento: " + el.getFirstChild().getNodeValue());
			        		resultado.setCodPaisNacimiento(el.getFirstChild().getNodeValue());
			        	}else{
			        		cat.debug("codtel_pais_nacimiento es Vacio o Nulo");
			        		resultado.setCodPaisNacimiento("");
			        	}
			        }
			        //Fin P-CSR-11002 JLGN 11-07-2011
			        nodeList2 = element.getElementsByTagName("ciudad_nacimiento");			        
			        if(nodeList2 != null && nodeList2.getLength()>0){
			        	Element el = (Element)nodeList2.item(0);			        	
			        	if(el.getFirstChild() != null){
			        		cat.debug("ciudad_nacimiento: " + el.getFirstChild().getNodeValue());
			        		resultado.setCiudadNacimiento(el.getFirstChild().getNodeValue());
			        	}else{
			        		cat.debug("CiudadNacimiento es Vacio o Nulo");
			        		resultado.setCiudadNacimiento("");
			        	}
			        }
			        nodeList2 = element.getElementsByTagName("cod_ciudad_nacimiento_mav");			        
			        if(nodeList2 != null && nodeList2.getLength()>0){
			        	Element el = (Element)nodeList2.item(0);			        	
			        	if(el.getFirstChild() != null){
			        		cat.debug("cod_ciudad_nacimiento_mav: " + el.getFirstChild().getNodeValue());
			        		resultado.setCodCiudadNacimiento(el.getFirstChild().getNodeValue());
			        	}else{
			        		cat.debug("CodCiudadNacimiento es Vacio o Nulo");
			        		resultado.setCodCiudadNacimiento("");
			        	}
			        }
			        nodeList2 = element.getElementsByTagName("edad");			        
			        if(nodeList2 != null && nodeList2.getLength()>0){
			        	Element el = (Element)nodeList2.item(0);			        	
			        	if(el.getFirstChild() != null){
			        		cat.debug("edad: " + el.getFirstChild().getNodeValue());
			        		resultado.setEdad(el.getFirstChild().getNodeValue());
			        	}else{
			        		cat.debug("Edad es Vacio o Nulo");
			        		resultado.setEdad("");
			        	}
			        }
			        nodeList2 = element.getElementsByTagName("estado_civil");			        
			        if(nodeList2 != null && nodeList2.getLength()>0){
			        	Element el = (Element)nodeList2.item(0);			        	
			        	if(el.getFirstChild() != null){
			        		cat.debug("estado_civil: " + el.getFirstChild().getNodeValue());
			        		resultado.setEstadoCivil(el.getFirstChild().getNodeValue());
			        	}else{
			        		cat.debug("EstadoCivil es Vacio o Nulo");
			        		resultado.setEstadoCivil("");
			        	}
			        }
			        nodeList2 = element.getElementsByTagName("COD_estado_civil");			        
			        if(nodeList2 != null && nodeList2.getLength()>0){
			        	Element el = (Element)nodeList2.item(0);			        	
			        	if(el.getFirstChild() != null){
			        		cat.debug("COD_estado_civil: " + el.getFirstChild().getNodeValue());
			        		resultado.setCodEstadoCivil(el.getFirstChild().getNodeValue());
			        	}else{
			        		cat.debug("CodEstadoCivil es Vacio o Nulo");
			        		resultado.setCodEstadoCivil("");
			        	}
			        }
			        nodeList2 = element.getElementsByTagName("cantidad_eventos");			        
			        if(nodeList2 != null && nodeList2.getLength()>0){
			        	Element el = (Element)nodeList2.item(0);			        	
			        	if(el.getFirstChild() != null){
			        		cat.debug("cantidad_eventos: " + el.getFirstChild().getNodeValue());
			        		resultado.setCantidadEventos(el.getFirstChild().getNodeValue());
			        	}else{
			        		cat.debug("CantidadEventos es Vacio o Nulo");
			        		resultado.setCantidadEventos("");
			        	}
			        }
			        nodeList2 = element.getElementsByTagName("celular");			        
			        if(nodeList2 != null && nodeList2.getLength()>0){
			        	Element el = (Element)nodeList2.item(0);			        	
			        	if(el.getFirstChild() != null){
			        		cat.debug("celular : " + el.getFirstChild().getNodeValue());
			        		resultado.setCelular(el.getFirstChild().getNodeValue());
			        	}else{
			        		cat.debug("Celular es Vacio o Nulo");
			        		resultado.setCelular("");
			        	}
			        }			        
			        //Se obtienen los codigos de canton, provincia, etc de la direccion
			        nodeList2 = element.getElementsByTagName("direccion");			        
			        if(nodeList2 != null && nodeList2.getLength()>0){			        	
			        	for(int x=0;x<nodeList2.getLength();x++){
			        		Element el = (Element)nodeList2.item(x);
			        		//se consulta si existe el atributo num en el nodo direccion
			        		if(el.hasAttribute("num")){
			        			//solo se obtiene la primera direccion del cliente
			        			if(el.getAttribute("num").equals("1")){
			        				cat.debug("cod_Provincia: "+el.getAttribute("cod_Provincia"));
			        				resultado.setCodProvincia(el.getAttribute("cod_Provincia"));
			        				cat.debug("cod_Canton: "+el.getAttribute("cod_Canton"));
			        				resultado.setCodCanton(el.getAttribute("cod_Canton"));
			        				cat.debug("cod_Distrito: "+el.getAttribute("cod_Distrito"));
			        				resultado.setCodDistrito(el.getAttribute("cod_Distrito"));
			        				cat.debug("bloqueado: "+el.getAttribute("bloqueado"));
			        				resultado.setBloqueo(el.getAttribute("bloqueado"));
			        				cat.debug("codigoBloqueo: "+el.getAttribute("codigoBloqueo"));
			        				resultado.setCodigoBloqueo(el.getAttribute("codigoBloqueo"));			        				
			        				if(el.getFirstChild() != null){
			        					cat.debug("direccion : " + el.getFirstChild().getNodeValue());
			        					resultado.setDesDireccion(el.getFirstChild().getNodeValue());
			        				}else{
			        					cat.debug("DesDireccion es Vacio o Nulo");
						        		resultado.setDesDireccion("");
			        				}
			        			} 			        			
			        		}
			        	}
			        }	
			        //Inicio Datos de Cedula Juridica
			        nodeList2 = element.getElementsByTagName("fecha_vencimiento");			        
			        if(nodeList2 != null && nodeList2.getLength()>0){
			        	Element el = (Element)nodeList2.item(0);			        	
			        	if(el.getFirstChild() != null){
			        		cat.debug("fecha_vencimiento : " + el.getFirstChild().getNodeValue());
			        		resultado.setFechaVencimiento(el.getFirstChild().getNodeValue());
			        	}else{
			        		cat.debug("fecha_vencimiento es Vacio o Nulo");
			        		resultado.setFechaVencimiento("");
			        	}
			        }
			        nodeList2 = element.getElementsByTagName("tomo");			        
			        if(nodeList2 != null && nodeList2.getLength()>0){
			        	Element el = (Element)nodeList2.item(0);			        	
			        	if(el.getFirstChild() != null){
			        		cat.debug("tomo : " + el.getFirstChild().getNodeValue());
			        		resultado.setTomo(el.getFirstChild().getNodeValue());
			        	}else{
			        		cat.debug("tomo es Vacio o Nulo");
			        		resultado.setTomo("");
			        	}
			        }
			        nodeList2 = element.getElementsByTagName("folio");			        
			        if(nodeList2 != null && nodeList2.getLength()>0){
			        	Element el = (Element)nodeList2.item(0);			        	
			        	if(el.getFirstChild() != null){
			        		cat.debug("folio : " + el.getFirstChild().getNodeValue());
			        		resultado.setFolio(el.getFirstChild().getNodeValue());
			        	}else{
			        		cat.debug("folio es Vacio o Nulo");
			        		resultado.setFolio("");
			        	}
			        }
			        nodeList2 = element.getElementsByTagName("asiento");			        
			        if(nodeList2 != null && nodeList2.getLength()>0){
			        	Element el = (Element)nodeList2.item(0);			        	
			        	if(el.getFirstChild() != null){
			        		cat.debug("asiento : " + el.getFirstChild().getNodeValue());
			        		resultado.setAsiento(el.getFirstChild().getNodeValue());
			        	}else{
			        		cat.debug("asiento es Vacio o Nulo");
			        		resultado.setAsiento("");
			        	}
			        }
			        nodeList2 = element.getElementsByTagName("clasificacion");			        
			        if(nodeList2 != null && nodeList2.getLength()>0){
			        	Element el = (Element)nodeList2.item(0);			        	
			        	if(el.getFirstChild() != null){
			        		cat.debug("clasificacion : " + el.getFirstChild().getNodeValue());
			        		resultado.setClasificacion(el.getFirstChild().getNodeValue());
			        	}else{
			        		cat.debug("clasificacion es Vacio o Nulo");
			        		resultado.setClasificacion("");
			        	}
			        }
			        nodeList2 = element.getElementsByTagName("actividad");			        
			        if(nodeList2 != null && nodeList2.getLength()>0){
			        	Element el = (Element)nodeList2.item(0);			        	
			        	if(el.getFirstChild() != null){
			        		cat.debug("actividad : " + el.getFirstChild().getNodeValue());
			        		resultado.setActividad(el.getFirstChild().getNodeValue());
			        	}else{
			        		cat.debug("actividad es Vacio o Nulo");
			        		resultado.setActividad("");
			        	}
			        }
			        nodeList2 = element.getElementsByTagName("telefono");			        
			        if(nodeList2 != null && nodeList2.getLength()>0){
			        	Element el = (Element)nodeList2.item(0);			        	
			        	if(el.getFirstChild() != null){
			        		cat.debug("telefono : " + el.getFirstChild().getNodeValue());
			        		resultado.setTelefono(el.getFirstChild().getNodeValue());
			        	}else{
			        		cat.debug("telefono es Vacio o Nulo");
			        		resultado.setTelefono("");
			        	}
			        }
			        nodeList2 = element.getElementsByTagName("personeria");			        
			        if(nodeList2 != null && nodeList2.getLength()>0){
			        	Element el = (Element)nodeList2.item(0);			        	
			        	if(el.getFirstChild() != null){
			        		cat.debug("personeria : " + el.getFirstChild().getNodeValue());
			        		resultado.setPersoneriaSociedad(el.getFirstChild().getNodeValue());
			        	}else{
			        		cat.debug("personeria es Vacio o Nulo");
			        		resultado.setPersoneriaSociedad("");
			        	}
			        }
			        nodeList2 = element.getElementsByTagName("domicilio");			        
			        if(nodeList2 != null && nodeList2.getLength()>0){
			        	Element el = (Element)nodeList2.item(0);			        	
			        	if(el.getFirstChild() != null){
			        		cat.debug("domicilio : " + el.getFirstChild().getNodeValue());
			        		resultado.setDomicilio(el.getFirstChild().getNodeValue());
			        	}else{
			        		cat.debug("domicilio es Vacio o Nulo");
			        		resultado.setDomicilio("");
			        	}
			        }
			        nodeList2 = element.getElementsByTagName("representacion");			        
			        if(nodeList2 != null && nodeList2.getLength()>0){
			        	Element el = (Element)nodeList2.item(0);			        	
			        	if(el.getFirstChild() != null){
			        		cat.debug("representacion : " + el.getFirstChild().getNodeValue());
			        		resultado.setRepresentacion(el.getFirstChild().getNodeValue());
			        	}else{
			        		cat.debug("representacion es Vacio o Nulo");
			        		resultado.setRepresentacion("");
			        	}
			        }
			        
			        nodeList2 = element.getElementsByTagName("nombramientos");
				    //Inicio datos Nombramientos
				    if(nodeList2 != null && nodeList2.getLength()>0){
				    	Element el = (Element)nodeLst.item(0);
				    	NodeList nodeList3 = null;
				    	nodeList3 = el.getElementsByTagName("nombramiento");		
				    	//Inicio Seteo Datos nombramiento
				    	ArrayList lista = new ArrayList();
				    	cat.debug("Numero nombramiento["+nodeList3.getLength()+"]");
				    	for(int x=0;x<nodeList3.getLength();x++){
				    		cat.debug("Historico Trabajo Numero ["+(x+1)+"]");
					    	Element el2 = (Element)nodeList3.item(x);			        
					    	NodeList nodeList4 = null;
					    	TipoNombramientoDTO tipoNombramientoDTO = new TipoNombramientoDTO();					    	
					    	nodeList4 = el2.getElementsByTagName("tipo_nombramiento");
				        	if(nodeList4 != null && nodeList4.getLength()>0){
					        	Element el3 = (Element)nodeList4.item(0);				        	
					        	if(el3.getFirstChild() != null){
					        		cat.debug("tipo_nombramiento: " + el3.getFirstChild().getNodeValue());
					        		tipoNombramientoDTO.setTipNombramiento(el3.getFirstChild().getNodeValue());
					        	}else{
					        		cat.debug("tipo_nombramiento es Vacio o Nulo");
					        		tipoNombramientoDTO.setTipNombramiento("");
					        	}
					        }
				        	nodeList4 = el2.getElementsByTagName("nombre");
				        	if(nodeList4 != null && nodeList4.getLength()>0){
					        	Element el3 = (Element)nodeList4.item(0);				        	
					        	if(el3.getFirstChild() != null){
					        		cat.debug("nombre: " + el3.getFirstChild().getNodeValue());
					        		tipoNombramientoDTO.setNombreNombramiento(el3.getFirstChild().getNodeValue());
					        	}else{
					        		cat.debug("nombre es Vacio o Nulo");
					        		tipoNombramientoDTO.setNombreNombramiento("");
					        	}
					        }
				        	nodeList4 = el2.getElementsByTagName("apellido1");
				        	if(nodeList4 != null && nodeList4.getLength()>0){
					        	Element el3 = (Element)nodeList4.item(0);				        	
					        	if(el3.getFirstChild() != null){
					        		cat.debug("apellido1: " + el3.getFirstChild().getNodeValue());
					        		tipoNombramientoDTO.setApellido1Nombramiento(el3.getFirstChild().getNodeValue());
					        	}else{
					        		cat.debug("apellido1 es Vacio o Nulo");
					        		tipoNombramientoDTO.setApellido1Nombramiento("");
					        	}
					        }
				        	nodeList4 = el2.getElementsByTagName("apellido2");
				        	if(nodeList4 != null && nodeList4.getLength()>0){
					        	Element el3 = (Element)nodeList4.item(0);				        	
					        	if(el3.getFirstChild() != null){
					        		cat.debug("apellido2: " + el3.getFirstChild().getNodeValue());
					        		tipoNombramientoDTO.setApellido2Nombramiento(el3.getFirstChild().getNodeValue());
					        	}else{
					        		cat.debug("apellido2 es Vacio o Nulo");
					        		tipoNombramientoDTO.setApellido2Nombramiento("");
					        	}
					        }
				        	nodeList4 = el2.getElementsByTagName("tipo_identificacion");
				        	if(nodeList4 != null && nodeList4.getLength()>0){
					        	Element el3 = (Element)nodeList4.item(0);				        	
					        	if(el3.getFirstChild() != null){
					        		cat.debug("tipo_identificacion: " + el3.getFirstChild().getNodeValue());
					        		tipoNombramientoDTO.setTipIdentNombramiento(el3.getFirstChild().getNodeValue());
					        	}else{
					        		cat.debug("tipo_identificacion es Vacio o Nulo");
					        		tipoNombramientoDTO.setTipIdentNombramiento("");
					        	}
					        }
				        	nodeList4 = el2.getElementsByTagName("identificacion");
				        	if(nodeList4 != null && nodeList4.getLength()>0){
					        	Element el3 = (Element)nodeList4.item(0);				        	
					        	if(el3.getFirstChild() != null){
					        		cat.debug("identificacion: " + el3.getFirstChild().getNodeValue());
					        		tipoNombramientoDTO.setNumidentNombramiento(el3.getFirstChild().getNodeValue());
					        	}else{
					        		cat.debug("identificacion es Vacio o Nulo");
					        		tipoNombramientoDTO.setNumidentNombramiento("");
					        	}
					        }
				        	nodeList4 = el2.getElementsByTagName("nacionalidad");
				        	if(nodeList4 != null && nodeList4.getLength()>0){
					        	Element el3 = (Element)nodeList4.item(0);				        	
					        	if(el3.getFirstChild() != null){
					        		cat.debug("nacionalidad: " + el3.getFirstChild().getNodeValue());
					        		tipoNombramientoDTO.setNacionalidadNombramiento(el3.getFirstChild().getNodeValue());
					        	}else{
					        		cat.debug("nacionalidad es Vacio o Nulo");
					        		tipoNombramientoDTO.setNacionalidadNombramiento("");
					        	}
					        }
				        	nodeList4 = el2.getElementsByTagName("estado_civil");
				        	if(nodeList4 != null && nodeList4.getLength()>0){
					        	Element el3 = (Element)nodeList4.item(0);				        	
					        	if(el3.getFirstChild() != null){
					        		cat.debug("estado_civil: " + el3.getFirstChild().getNodeValue());
					        		tipoNombramientoDTO.setEstadoCivilNombramiento(el3.getFirstChild().getNodeValue());
					        	}else{
					        		cat.debug("estado_civil es Vacio o Nulo");
					        		tipoNombramientoDTO.setEstadoCivilNombramiento("");
					        	}
					        }
				        	nodeList4 = el2.getElementsByTagName("ocupacion");
				        	if(nodeList4 != null && nodeList4.getLength()>0){
					        	Element el3 = (Element)nodeList4.item(0);				        	
					        	if(el3.getFirstChild() != null){
					        		cat.debug("ocupacion: " + el3.getFirstChild().getNodeValue());
					        		tipoNombramientoDTO.setOcupacionNombramiento(el3.getFirstChild().getNodeValue());
					        	}else{
					        		cat.debug("ocupacion es Vacio o Nulo");
					        		tipoNombramientoDTO.setOcupacionNombramiento("");
					        	}
					        }
				        	nodeList4 = el2.getElementsByTagName("domicilio");
				        	if(nodeList4 != null && nodeList4.getLength()>0){
					        	Element el3 = (Element)nodeList4.item(0);				        	
					        	if(el3.getFirstChild() != null){
					        		cat.debug("domicilio: " + el3.getFirstChild().getNodeValue());
					        		tipoNombramientoDTO.setDomicilioNombramiento(el3.getFirstChild().getNodeValue());
					        	}else{
					        		cat.debug("domicilio es Vacio o Nulo");
					        		tipoNombramientoDTO.setDomicilioNombramiento("");
					        	}
					        }				        	
				        	nodeList4 = el2.getElementsByTagName("direccion_oficina");
				        	if(nodeList4 != null && nodeList4.getLength()>0){
					        	Element el3 = (Element)nodeList4.item(0);				        	
					        	if(el3.getFirstChild() != null){
					        		cat.debug("direccion_oficina: " + el3.getFirstChild().getNodeValue());
					        		tipoNombramientoDTO.setDireccionOficina(el3.getFirstChild().getNodeValue());
					        	}else{
					        		cat.debug("direccion_oficina es Vacio o Nulo");
					        		tipoNombramientoDTO.setDireccionOficina("");
					        	}
					        }
				        	
				        	lista.add(tipoNombramientoDTO); //Fin Seteo Datos nombramientos	
					    }
				    	resultado.setTipoNombramientoDTO((TipoNombramientoDTO[]) ArrayUtl.copiaArregloTipoEspecifico(lista.toArray(), TipoNombramientoDTO.class));			    	
				    }//Fin datos Nombramientos			        
			        //Fin Datos de Cedula Juridica
			    }//Fin seteo datos generales			    
			    nodeLst = rootElement.getElementsByTagName("calificador");
			    //Inicio seteo datos calificador
			    for(int i=0;i<nodeLst.getLength();i++){
			    	Element element = (Element)nodeLst.item(i);
			    	NodeList nodeList2 = null;			    	
			    	nodeList2 = element.getElementsByTagName("TipoProducto");			        
			        if(nodeList2 != null && nodeList2.getLength()>0){
			        	Element el = (Element)nodeList2.item(0);			        	
			        	if(el.getFirstChild() != null){
			        		cat.debug("TipoProducto: " + el.getFirstChild().getNodeValue());
			        		resultado.setTipProducto(el.getFirstChild().getNodeValue());
			        	}else{
			        		cat.debug("TipoProducto es Vacio o Nulo");
			        		resultado.setTipProducto("");
			        	}
			        }	
			        nodeList2 = element.getElementsByTagName("TipoSegmento");			        
			        if(nodeList2 != null && nodeList2.getLength()>0){
			        	Element el = (Element)nodeList2.item(0);			        	
			        	if(el.getFirstChild() != null){
			        		cat.debug("TipoSegmento: " + el.getFirstChild().getNodeValue());
			        		resultado.setTipSegmento(el.getFirstChild().getNodeValue());
			        	}else{
			        		cat.debug("TipSegmento es Vacio o Nulo");
			        		resultado.setTipSegmento("");
			        	}
			        }
			        nodeList2 = element.getElementsByTagName("DatosGenerales");			        
			        if(nodeList2 != null && nodeList2.getLength()>0){
			        	Element el = (Element)nodeList2.item(0);			        	
			        	if(el.getFirstChild() != null){
			        		cat.debug("DatosGenerales: " + el.getFirstChild().getNodeValue());
			        		resultado.setDatosGenerales(el.getFirstChild().getNodeValue());
			        	}else{
			        		cat.debug("DatosGenerales es Vacio o Nulo");
			        		resultado.setDatosGenerales("");
			        	}
			        }	
			        nodeList2 = element.getElementsByTagName("Laboral");			        
			        if(nodeList2 != null && nodeList2.getLength()>0){
			        	Element el = (Element)nodeList2.item(0);			        	
			        	if(el.getFirstChild() != null){
			        		cat.debug("Laboral: " + el.getFirstChild().getNodeValue());
			        		resultado.setLaboral(el.getFirstChild().getNodeValue());
			        	}else{
			        		cat.debug("Laboral es Vacio o Nulo");
			        		resultado.setLaboral("");
			        	}
			        }
			        nodeList2 = element.getElementsByTagName("HistoricoConsultas");			        
			        if(nodeList2 != null && nodeList2.getLength()>0){
			        	Element el = (Element)nodeList2.item(0);			        		
			        	if(el.getFirstChild() != null){
			        		cat.debug("HistoricoConsultas: " + el.getFirstChild().getNodeValue());
			        		resultado.setHistConsulta(el.getFirstChild().getNodeValue());
			        	}else{
			        		cat.debug("HistConsulta es Vacio o Nulo");
			        		resultado.setHistConsulta("");
			        	}
			        }	
			        nodeList2 = element.getElementsByTagName("ReferenciasCredito");			        
			        if(nodeList2 != null && nodeList2.getLength()>0){
			        	Element el = (Element)nodeList2.item(0);		        	
			        	if(el.getFirstChild() != null){
			        		cat.debug("ReferenciasCredito: " + el.getFirstChild().getNodeValue());
			        		resultado.setRefCredito(el.getFirstChild().getNodeValue());
			        	}else{
			        		cat.debug("RefCredito es Vacio o Nulo");
			        		resultado.setRefCredito("");
			        	}
			        }
			        nodeList2 = element.getElementsByTagName("LibrosEntradaHistoricos");			        
			        if(nodeList2 != null && nodeList2.getLength()>0){
			        	Element el = (Element)nodeList2.item(0);			        		
			        	if(el.getFirstChild() != null){
			        		cat.debug("LibrosEntradaHistoricos: " + el.getFirstChild().getNodeValue());
			        		resultado.setLibEntradaHistorico(el.getFirstChild().getNodeValue());
			        	}else{
			        		cat.debug("LibEntradaHistorico es Vacio o Nulo");
			        		resultado.setLibEntradaHistorico("");
			        	}
			        }	
			        nodeList2 = element.getElementsByTagName("LibrosEntradaActivos");			        
			        if(nodeList2 != null && nodeList2.getLength()>0){
			        	Element el = (Element)nodeList2.item(0);			        		
			        	if(el.getFirstChild() != null){
			        		cat.debug("LibrosEntradaActivos: " + el.getFirstChild().getNodeValue());
			        		resultado.setLibEntradaActivo(el.getFirstChild().getNodeValue());
			        	}else{
			        		cat.debug("LibEntradaActivo es Vacio o Nulo");
			        		resultado.setLibEntradaActivo("");
			        	}
			        }
			        nodeList2 = element.getElementsByTagName("ResultadoCalificacion");			        
			        if(nodeList2 != null && nodeList2.getLength()>0){
			        	Element el = (Element)nodeList2.item(0);			        		
			        	if(el.getFirstChild() != null){
			        		cat.debug("ResultadoCalificacion: " + el.getFirstChild().getNodeValue());
			        		resultado.setResulCalificacion(el.getFirstChild().getNodeValue());
			        	}else{
			        		cat.debug("ResulCalificacion es Vacio o Nulo");
			        		resultado.setResulCalificacion("");
			        	}
			        }	
			        
			        //Inicio P-CSR-11002 JLGN 31-05-2011
			        nodeList2 = element.getElementsByTagName("LimiteDeCredito");			        
			        if(nodeList2 != null && nodeList2.getLength()>0){
			        	Element el = (Element)nodeList2.item(0);			        		
			        	if(el.getFirstChild() != null){
			        		cat.debug("LimiteDeCredito: " + el.getFirstChild().getNodeValue());
			        		resultado.setLimiteDeCredito(el.getFirstChild().getNodeValue());
			        	}else{
			        		cat.debug("LimiteDeCredito es Vacio o Nulo");
			        		resultado.setLimiteDeCredito("");
			        	}
			        }	
			        //Fin P-CSR-11002 JLGN 31-05-2011
			        
			        nodeList2 = element.getElementsByTagName("CodigosInternos");			        
			        if(nodeList2 != null && nodeList2.getLength()>0){
			        	Element el = (Element)nodeList2.item(0);			        		
			        	if(el.getFirstChild()!= null){
			        		cat.debug("CodigosInternos: " + el.getFirstChild().getNodeValue());
			        		resultado.setCodInterno(el.getFirstChild().getNodeValue());
			        	}else{
			        		cat.debug("CodInterno es Vacio o Nulo");
			        		resultado.setCodInterno("");
			        	}
			        }			    	
			    }//Fin seteo datos calificador			    			    
			    nodeLst = rootElement.getElementsByTagName("informacion_laboral");
			    //Inicio datos Seteo Informacion Laboral 
			    if(nodeLst != null && nodeLst.getLength()>0){
			    	Element element = (Element)nodeLst.item(0);
			    	NodeList nodeList2 = null;
			    	nodeList2 = element.getElementsByTagName("trabajo");			        
			        //Inicio Seteo Datos Trabajo
			    	if(nodeList2 != null && nodeList2.getLength()>0){
			        	Element el = (Element)nodeList2.item(0);
			        	NodeList nodeList3 = null;			        	
			        	nodeList3 = el.getElementsByTagName("nombre_trabajo");			        	
			        	if(nodeList3 != null && nodeList3.getLength()>0){
				        	Element el2 = (Element)nodeList3.item(0);				        	
				        	if(el2.getFirstChild() != null){
				        		cat.debug("nombre_trabajo: " + el2.getFirstChild().getNodeValue());
				        		resultado.setNombreTrabajo(el2.getFirstChild().getNodeValue());
				        	}else{
				        		cat.debug("NombreTrabajo es Vacio o Nulo");
				        		resultado.setNombreTrabajo("");
				        	}
				        }
			        	nodeList3 = el.getElementsByTagName("nombre_comercial");			        	
			        	if(nodeList3 != null && nodeList3.getLength()>0){
				        	Element el2 = (Element)nodeList3.item(0);				        	
				        	if(el2.getFirstChild() != null){
				        		cat.debug("nombre_comercial: " + el2.getFirstChild().getNodeValue());	
				        		resultado.setNombreComercial(el2.getFirstChild().getNodeValue());
				        	}else{
				        		cat.debug("NombreComercial es Vacio o Nulo");
				        		resultado.setNombreComercial("");
				        	}
				        }
			        	nodeList3 = el.getElementsByTagName("patrono_provincia");			        	
			        	if(nodeList3 != null && nodeList3.getLength()>0){
				        	Element el2 = (Element)nodeList3.item(0);				        		
				        	if(el2.getFirstChild() != null){
				        		cat.debug("patrono_provincia: " + el2.getFirstChild().getNodeValue());
				        		resultado.setProvinciaPatrono(el2.getFirstChild().getNodeValue());
				        	}else{
				        		cat.debug("ProvinciaPatrono es Vacio o Nulo");
				        		resultado.setProvinciaPatrono("");
				        	}
				        }
			        	nodeList3 = el.getElementsByTagName("patrono_canton");			        	
			        	if(nodeList3 != null && nodeList3.getLength()>0){
				        	Element el2 = (Element)nodeList3.item(0);				        		
				        	if(el2.getFirstChild() != null){
				        		cat.debug("patrono_canton: " + el2.getFirstChild().getNodeValue());
				        		resultado.setCantonPatrono(el2.getFirstChild().getNodeValue());
				        	}else{
				        		cat.debug("CantonPatrono es Vacio o Nulo");
				        		resultado.setCantonPatrono("");
				        	}
				        }
			        	nodeList3 = el.getElementsByTagName("patrono_distrito");			        	
			        	if(nodeList3 != null && nodeList3.getLength()>0){
				        	Element el2 = (Element)nodeList3.item(0);				        	
				        	if(el2.getFirstChild() != null){
				        		cat.debug("patrono_distrito: " + el2.getFirstChild().getNodeValue());	
				        		resultado.setDistritoPatrono(el2.getFirstChild().getNodeValue());
				        	}else{
				        		cat.debug("DistritoPatrono es Vacio o Nulo");
				        		resultado.setDistritoPatrono("");
				        	}				        		
				        }
			        	nodeList3 = el.getElementsByTagName("cod_tipo_patrono");			        	
			        	if(nodeList3 != null && nodeList3.getLength()>0){
				        	Element el2 = (Element)nodeList3.item(0);				        	
				        	if(el2.getFirstChild() != null){
				        		cat.debug("cod_tipo_patrono: " + el2.getFirstChild().getNodeValue());	
				        		resultado.setCodTipPatrono(el2.getFirstChild().getNodeValue());
				        	}else{
				        		cat.debug("CodTipPatrono es Vacio o Nulo");
				        		resultado.setCodTipPatrono("");
				        	}
				        }
			        	nodeList3 = el.getElementsByTagName("cedula_trabajo");			        	
			        	if(nodeList3 != null && nodeList3.getLength()>0){
				        	Element el2 = (Element)nodeList3.item(0);				        	
				        	if(el2.getFirstChild() != null){
				        		cat.debug("cedula_trabajo: " + el2.getFirstChild().getNodeValue());
				        		resultado.setCedulaTrabajo(el2.getFirstChild().getNodeValue());
				        	}else{
				        		cat.debug("CedulaTrabajo es Vacio o Nulo");
				        		resultado.setCedulaTrabajo("");
				        	}				        		
				        }
			        	nodeList3 = el.getElementsByTagName("fines_empresa");			        	
			        	if(nodeList3 != null && nodeList3.getLength()>0){
				        	Element el2 = (Element)nodeList3.item(0);				        	
				        	if(el2.getFirstChild() != null){
				        		cat.debug("fines_empresa: " + el2.getFirstChild().getNodeValue());	
				        		resultado.setFinesTrabajo(el2.getFirstChild().getNodeValue());
				        	}else{
				        		cat.debug("FinesTrabajo es Vacio o Nulo");
				        		resultado.setFinesTrabajo("");
				        	}
				        }
			        	nodeList3 = el.getElementsByTagName("ocupacion");			        	
			        	if(nodeList3 != null && nodeList3.getLength()>0){
				        	Element el2 = (Element)nodeList3.item(0);				        	
				        	if(el2.getFirstChild() != null){
				        		cat.debug("ocupacion: " + el2.getFirstChild().getNodeValue());	
				        		resultado.setOcupacion(el2.getFirstChild().getNodeValue());
				        	}else{
				        		cat.debug("Ocupacion es Vacio o Nulo");
				        		resultado.setOcupacion("");
				        	}
				        }
			        	nodeList3 = el.getElementsByTagName("cod_ocupacion");			        	
			        	if(nodeList3 != null && nodeList3.getLength()>0){
				        	Element el2 = (Element)nodeList3.item(0);				        	
				        	if(el2.getFirstChild() != null){
				        		cat.debug("cod_ocupacion: " + el2.getFirstChild().getNodeValue());	
				        		resultado.setCodOcupacion(el2.getFirstChild().getNodeValue());
				        	}else{
				        		cat.debug("CodOcupacion es Vacio o Nulo");
				        		resultado.setCodOcupacion("");
				        	}
				        }
			        	nodeList3 = el.getElementsByTagName("salario");			        	
			        	if(nodeList3 != null && nodeList3.getLength()>0){
				        	Element el2 = (Element)nodeList3.item(0);				        		
				        	if(el2.getFirstChild() != null){
				        		cat.debug("salario: " + el2.getFirstChild().getNodeValue());
				        		resultado.setSalario(el2.getFirstChild().getNodeValue());
				        	}else{
				        		cat.debug("Salario es Vacio o Nulo");
				        		resultado.setSalario("");
				        	}
				        }
			        	nodeList3 = el.getElementsByTagName("SalarioPromedioTresMeses");			        	
			        	if(nodeList3 != null && nodeList3.getLength()>0){
				        	Element el2 = (Element)nodeList3.item(0);				        		
				        	if(el2.getFirstChild() != null){
				        		cat.debug("SalarioPromedioTresMeses: " + el2.getFirstChild().getNodeValue());
				        		resultado.setProm3Meses(el2.getFirstChild().getNodeValue());
				        	}else{
				        		cat.debug("Prom3Meses es Vacio o Nulo");
				        		resultado.setProm3Meses("");
				        	}
				        }
			        	nodeList3 = el.getElementsByTagName("SalarioPromedioSeisMeses");			        	
			        	if(nodeList3 != null && nodeList3.getLength()>0){
				        	Element el2 = (Element)nodeList3.item(0);				        	
				        	if(el2.getFirstChild() != null){
				        		cat.debug("SalarioPromedioSeisMeses: " + el2.getFirstChild().getNodeValue());	
				        		resultado.setProm6Meses(el2.getFirstChild().getNodeValue());
				        	}else{
				        		cat.debug("Prom6Meses es Vacio o Nulo");
				        		resultado.setProm6Meses("");
				        	}
				        }
			        	nodeList3 = el.getElementsByTagName("SalarioPromedioDoceMeses");			        	
			        	if(nodeList3 != null && nodeList3.getLength()>0){
				        	Element el2 = (Element)nodeList3.item(0);				        		
				        	if(el2.getFirstChild() != null){
				        		cat.debug("SalarioPromedioDoceMeses: " + el2.getFirstChild().getNodeValue());
				        		resultado.setProm12Meses(el2.getFirstChild().getNodeValue());
				        	}else{
				        		cat.debug("Prom12Meses es Vacio o Nulo");
				        		resultado.setProm12Meses("");
				        	}
				        }
			        	nodeList3 = el.getElementsByTagName("Fecha_Registro");			        	
			        	if(nodeList3 != null && nodeList3.getLength()>0){
				        	Element el2 = (Element)nodeList3.item(0);				        	
				        	if(el2.getFirstChild() != null){
				        		cat.debug("Fecha_Registro: " + el2.getFirstChild().getNodeValue());
				        		resultado.setFechaRegistro(el2.getFirstChild().getNodeValue());
				        	}else{
				        		cat.debug("FechaRegistro es Vacio o Nulo");
				        		resultado.setFechaRegistro("");
				        	}
				        }
			        	nodeList3 = el.getElementsByTagName("Tiempo_De_Laborar");			        	
			        	if(nodeList3 != null && nodeList3.getLength()>0){
				        	Element el2 = (Element)nodeList3.item(0);				        	
				        	if(el2.getFirstChild() != null){
				        		cat.debug("Tiempo_De_Laborar: " + el2.getFirstChild().getNodeValue());	
				        		resultado.setTiempoLaboral(el2.getFirstChild().getNodeValue());
				        	}else{
				        		cat.debug("TiempoLaboral es Vacio o Nulo");
				        		resultado.setTiempoLaboral("");
				        	}
				        }
			        	nodeList3 = el.getElementsByTagName("Meses_De_Laborar");			        	
			        	if(nodeList3 != null && nodeList3.getLength()>0){
				        	Element el2 = (Element)nodeList3.item(0);				        		
				        	if(el2.getFirstChild() != null){
				        		cat.debug("Meses_De_Laborar: " + el2.getFirstChild().getNodeValue());
				        		resultado.setMesesLaboral(el2.getFirstChild().getNodeValue());
				        	}else{
				        		cat.debug("MesesLaboral es Vacio o Nulo");
				        		resultado.setMesesLaboral("");
				        	}
				        }
			        	//Inicio Seteo Datos Morosidad
			        	nodeList3 = el.getElementsByTagName("MorosidadCCSS");			        	
			        	if(nodeList3 != null && nodeList3.getLength()>0){
			        		Element el2 = (Element)nodeList3.item(0);
					    	NodeList nodeList4 = null;
					    	nodeList4 = el2.getElementsByTagName("MontoDeuda");
					    	if(nodeList4 != null && nodeList4.getLength()>0){
					        	Element el3 = (Element)nodeList4.item(0);					        		
					        	if(el3.getFirstChild() != null){
					        		cat.debug("MontoDeuda: " + el3.getFirstChild().getNodeValue());
					        		resultado.setMontoDeuda(el3.getFirstChild().getNodeValue());
					        	}else{
					        		cat.debug("MontoDeuda es Vacio o Nulo");
					        		resultado.setMontoDeuda("");
					        	}
					        }
					    	nodeList4 = el2.getElementsByTagName("NumeroDeCuotas");
					    	if(nodeList4 != null && nodeList4.getLength()>0){
					        	Element el3 = (Element)nodeList4.item(0);					        		
					        	if(el3.getFirstChild() != null){
					        		cat.debug("NumeroDeCuotas: " + el3.getFirstChild().getNodeValue());
					        		resultado.setNumCuotas(el3.getFirstChild().getNodeValue());
					        	}else{
					        		cat.debug("NumCuotas es Vacio o Nulo");
					        		resultado.setNumCuotas("");
					        	}
					        }	        		
				        }//Fin Seteo Datos Morosidad
			        	
			        	//Inicio Seteo Datos direccion trabajo
			        	nodeList3 = el.getElementsByTagName("direcciones_trabajo");			        	
			        	if(nodeList3 != null && nodeList3.getLength()>0){
			        		Element el2 = (Element)nodeList3.item(0);
					    	NodeList nodeList4 = null;
					    	nodeList4 = el2.getElementsByTagName("direccion_trabajo");
					    	cat.debug("Cantidad Direccion Trabajo: "+nodeList4.getLength());
					    	if(nodeList4 != null && nodeList4.getLength()>0){
					    		for(int x=0;x<nodeList4.getLength();x++){
					    			cat.debug("Numero de Ingreso: "+x);
					    			cat.debug("Cantidad Direccion Trabajo: "+nodeList4.getLength());
					        		Element el3 = (Element)nodeList4.item(x);
					        		//se consulta si existe el atributo num en el nodo direccion
					        		if(el3.hasAttribute("num")){
					        			//solo se obtiene la primera direccion del cliente
					        			if(el3.getAttribute("num").equals("1")){
								        	Element el4 = (Element)nodeList4.item(0);								        	
								        	if(el4.getFirstChild() != null){
								        		cat.debug("DesDirecTrabajo: " + el3.getFirstChild().getNodeValue());
								        		resultado.setDesDirecTrabajo(el4.getFirstChild().getNodeValue());
								        	}else{
								        		cat.debug("DesDirecTrabajo es Vacio o Nulo");
								        		resultado.setDesDirecTrabajo("");
								        	}
					        			}	
					        		}
					    		}	
					        }					    			        		
				        }//Fin Seteo direccion trabajo			        	
			        	nodeList3 = el.getElementsByTagName("central_telefonica");			        	
			        	if(nodeList3 != null && nodeList3.getLength()>0){
				        	Element el2 = (Element)nodeList3.item(0);				        	
				        	if(el2.getFirstChild() != null){
				        		cat.debug("central_telefonica: " + el2.getFirstChild().getNodeValue());
				        		resultado.setCentralTelefonica(el2.getFirstChild().getNodeValue());
				        	}else{
				        		cat.debug("CentralTelefonica es Vacio o Nulo");
				        		resultado.setCentralTelefonica("");
				        	}
				        }
			        }//Fin Seteo Datos Trabajo			    	
			    }//Fin datos Seteo Informacion Laboral
			    
			    
			    nodeLst = rootElement.getElementsByTagName("historico_Laboral");
			    //Inicio datos Seteo Hitorico Laboral
			    if(nodeLst != null && nodeLst.getLength()>0){
			    	Element element = (Element)nodeLst.item(0);
			    	NodeList nodeList2 = null;
			    	nodeList2 = element.getElementsByTagName("historico");		
			    	//Inicio Seteo Datos Historico Trabajos
			    	ArrayList lista = new ArrayList();
			    	cat.debug("Numero Historico Trabajos["+nodeList2.getLength()+"]");
			    	for(int i=0;i<nodeList2.getLength();i++){
			    		cat.debug("Historico Trabajo Numero ["+(i+1)+"]");
				    	Element el = (Element)nodeList2.item(i);			        
				    	NodeList nodeList3 = null;
				    	DatosLaboralHistoricoBuroDTO historicoBuroDTO = new DatosLaboralHistoricoBuroDTO();
				    	nodeList3 = el.getElementsByTagName("cedula");
			        	if(nodeList3 != null && nodeList3.getLength()>0){
				        	Element el2 = (Element)nodeList3.item(0);				        	
				        	if(el2.getFirstChild() != null){
				        		cat.debug("cedulaTrabajo: " + el2.getFirstChild().getNodeValue());
				        		historicoBuroDTO.setCedulaHist(el2.getFirstChild().getNodeValue());
				        	}else{
				        		cat.debug("cedulaTrabajo es Vacio o Nulo");
				        		historicoBuroDTO.setCedulaHist("");
				        	}
				        }
			        	nodeList3 = el.getElementsByTagName("cod_tipo_patrono");
			        	if(nodeList3 != null && nodeList3.getLength()>0){
				        	Element el2 = (Element)nodeList3.item(0);				        	
				        	if(el2.getFirstChild() != null){
				        		cat.debug("cod_tipo_patrono: " + el2.getFirstChild().getNodeValue());
				        		historicoBuroDTO.setCodTipPatronoHist(el2.getFirstChild().getNodeValue());
				        	}else{
				        		cat.debug("cod_tipo_patrono es Vacio o Nulo");
				        		historicoBuroDTO.setCodTipPatronoHist("");
				        	}
				        }
			        	nodeList3 = el.getElementsByTagName("nombre");
			        	if(nodeList3 != null && nodeList3.getLength()>0){
				        	Element el2 = (Element)nodeList3.item(0);				        	
				        	if(el2.getFirstChild() != null){
				        		cat.debug("nombre: " + el2.getFirstChild().getNodeValue());
				        		historicoBuroDTO.setNombreHist(el2.getFirstChild().getNodeValue());
				        	}else{
				        		cat.debug("nombre es Vacio o Nulo");
				        		historicoBuroDTO.setNombreHist("");
				        	}
				        }
			        	nodeList3 = el.getElementsByTagName("fecha_inicio");
			        	if(nodeList3 != null && nodeList3.getLength()>0){
				        	Element el2 = (Element)nodeList3.item(0);				        	
				        	if(el2.getFirstChild() != null){
				        		cat.debug("fecha_inicio: " + el2.getFirstChild().getNodeValue());
				        		historicoBuroDTO.setFecInicioHist(el2.getFirstChild().getNodeValue());
				        	}else{
				        		cat.debug("fecha_inicio es Vacio o Nulo");
				        		historicoBuroDTO.setFecInicioHist("");
				        	}
				        }
			        	nodeList3 = el.getElementsByTagName("fechacompleta_inicio");
			        	if(nodeList3 != null && nodeList3.getLength()>0){
				        	Element el2 = (Element)nodeList3.item(0);				        	
				        	if(el2.getFirstChild() != null){
				        		cat.debug("fechacompleta_inicio: " + el2.getFirstChild().getNodeValue());
				        		historicoBuroDTO.setFecCompInicioHist(el2.getFirstChild().getNodeValue());
				        	}else{
				        		cat.debug("fechacompleta_inicio es Vacio o Nulo");
				        		historicoBuroDTO.setFecCompInicioHist("");
				        	}
				        }
			        	nodeList3 = el.getElementsByTagName("fecha_fin");
			        	if(nodeList3 != null && nodeList3.getLength()>0){
				        	Element el2 = (Element)nodeList3.item(0);				        	
				        	if(el2.getFirstChild() != null){
				        		cat.debug("fecha_fin: " + el2.getFirstChild().getNodeValue());
				        		historicoBuroDTO.setFecFinHist(el2.getFirstChild().getNodeValue());
				        	}else{
				        		cat.debug("fecha_fin es Vacio o Nulo");
				        		historicoBuroDTO.setFecFinHist("");
				        	}
				        }
			        	nodeList3 = el.getElementsByTagName("fechacompleta_fin");
			        	if(nodeList3 != null && nodeList3.getLength()>0){
				        	Element el2 = (Element)nodeList3.item(0);				        	
				        	if(el2.getFirstChild() != null){
				        		cat.debug("fechacompleta_fin: " + el2.getFirstChild().getNodeValue());
				        		historicoBuroDTO.setFecCompFinHist(el2.getFirstChild().getNodeValue());
				        	}else{
				        		cat.debug("fechacompleta_fin es Vacio o Nulo");
				        		historicoBuroDTO.setFecCompFinHist("");
				        	}
				        }
			        	nodeList3 = el.getElementsByTagName("meses_Laborados");
			        	if(nodeList3 != null && nodeList3.getLength()>0){
				        	Element el2 = (Element)nodeList3.item(0);				        	
				        	if(el2.getFirstChild() != null){
				        		cat.debug("meses_Laborados: " + el2.getFirstChild().getNodeValue());
				        		historicoBuroDTO.setMesesLaboradosHist(el2.getFirstChild().getNodeValue());
				        	}else{
				        		cat.debug("meses_Laborados es Vacio o Nulo");
				        		historicoBuroDTO.setMesesLaboradosHist("");
				        	}
				        }			        	
			        	lista.add(historicoBuroDTO); //Fin Seteo Datos Historico Trabajos	
				    }
			    	resultado.setDatosLaboralHist((DatosLaboralHistoricoBuroDTO[]) ArrayUtl.copiaArregloTipoEspecifico(lista.toArray(), DatosLaboralHistoricoBuroDTO.class));			    	
			    }//Fin datos Seteo Hitorico Laboral
			    
			    nodeLst = rootElement.getElementsByTagName("parientes");
			    //Inicio datos parientes
			    if(nodeLst != null && nodeLst.getLength()>0){
			    	Element element = (Element)nodeLst.item(0);
			    	NodeList nodeList2 = null;
			    	nodeList2 = element.getElementsByTagName("nombre_conyugue");
			    	if(nodeList2 != null && nodeList2.getLength()>0){
			        	Element el2 = (Element)nodeList2.item(0);				        	
			        	if(el2.getFirstChild() != null){
			        		cat.debug("nombre_conyugue: " + el2.getFirstChild().getNodeValue());
			        		resultado.setNombreConyuge(el2.getFirstChild().getNodeValue());
			        	}else{
			        		cat.debug("nombre_conyugue es Vacio o Nulo");
			        		resultado.setNombreConyuge("");
			        	}
			        }
			    	nodeList2 = element.getElementsByTagName("apellido1_conyugue");
			    	if(nodeList2 != null && nodeList2.getLength()>0){
			        	Element el2 = (Element)nodeList2.item(0);				        	
			        	if(el2.getFirstChild() != null){
			        		cat.debug("apellido1_conyugue: " + el2.getFirstChild().getNodeValue());
			        		resultado.setApellido1Conyuge(el2.getFirstChild().getNodeValue());
			        	}else{
			        		cat.debug("apellido1_conyugue es Vacio o Nulo");
			        		resultado.setApellido1Conyuge("");
			        	}
			        }
			    	nodeList2 = element.getElementsByTagName("apellido2_conyugue");
			    	if(nodeList2 != null && nodeList2.getLength()>0){
			        	Element el2 = (Element)nodeList2.item(0);				        	
			        	if(el2.getFirstChild() != null){
			        		cat.debug("apellido2_conyugue: " + el2.getFirstChild().getNodeValue());
			        		resultado.setApellido2Conyuge(el2.getFirstChild().getNodeValue());
			        	}else{
			        		cat.debug("apellido2_conyugue es Vacio o Nulo");
			        		resultado.setApellido2Conyuge("");
			        	}
			        }
			    	nodeList2 = element.getElementsByTagName("conyugue_nombre");
			    	if(nodeList2 != null && nodeList2.getLength()>0){
			        	Element el2 = (Element)nodeList2.item(0);				        	
			        	if(el2.getFirstChild() != null){
			        		cat.debug("conyugue_nombre: " + el2.getFirstChild().getNodeValue());
			        		resultado.setNombreCompletoConyuge(el2.getFirstChild().getNodeValue());
			        	}else{
			        		cat.debug("conyugue_nombre es Vacio o Nulo");
			        		resultado.setNombreCompletoConyuge("");
			        	}
			        }
			    	nodeList2 = element.getElementsByTagName("fallecido");
			    	if(nodeList2 != null && nodeList2.getLength()>0){
			        	Element el2 = (Element)nodeList2.item(0);				        	
			        	if(el2.getFirstChild() != null){
			        		cat.debug("fallecido: " + el2.getFirstChild().getNodeValue());
			        		resultado.setFallecidoConyuge(el2.getFirstChild().getNodeValue());
			        	}else{
			        		cat.debug("fallecido es Vacio o Nulo");
			        		resultado.setFallecidoConyuge("");
			        	}
			        }
			    	nodeList2 = element.getElementsByTagName("cod_fallecido");
			    	if(nodeList2 != null && nodeList2.getLength()>0){
			        	Element el2 = (Element)nodeList2.item(0);				        	
			        	if(el2.getFirstChild() != null){
			        		cat.debug("cod_fallecido: " + el2.getFirstChild().getNodeValue());
			        		resultado.setCodFallecidoConyuge(el2.getFirstChild().getNodeValue());
			        	}else{
			        		cat.debug("cod_fallecido es Vacio o Nulo");
			        		resultado.setCodFallecidoConyuge("");
			        	}
			        }
			    	nodeList2 = element.getElementsByTagName("conyugue_cedula");
			    	if(nodeList2 != null && nodeList2.getLength()>0){
			        	Element el2 = (Element)nodeList2.item(0);				        	
			        	if(el2.getFirstChild() != null){
			        		cat.debug("conyugue_cedula: " + el2.getFirstChild().getNodeValue());
			        		resultado.setCedulaConyuge(el2.getFirstChild().getNodeValue());
			        	}else{
			        		cat.debug("conyugue_cedula es Vacio o Nulo");
			        		resultado.setCedulaConyuge("");
			        	}
			        }
			    	nodeList2 = element.getElementsByTagName("conyugue_relacion");
			    	if(nodeList2 != null && nodeList2.getLength()>0){
			        	Element el2 = (Element)nodeList2.item(0);				        	
			        	if(el2.getFirstChild() != null){
			        		cat.debug("conyugue_relacion: " + el2.getFirstChild().getNodeValue());
			        		resultado.setNomRelacion(el2.getFirstChild().getNodeValue());
			        	}else{
			        		cat.debug("conyugue_relacion es Vacio o Nulo");
			        		resultado.setNomRelacion("");
			        	}
			        }
			    	nodeList2 = element.getElementsByTagName("COD_conyugue_relacion");
			    	if(nodeList2 != null && nodeList2.getLength()>0){
			        	Element el2 = (Element)nodeList2.item(0);				        	
			        	if(el2.getFirstChild() != null){
			        		cat.debug("COD_conyugue_relacion: " + el2.getFirstChild().getNodeValue());
			        		resultado.setCodRelacion(el2.getFirstChild().getNodeValue());
			        	}else{
			        		cat.debug("COD_conyugue_relacion es Vacio o Nulo");
			        		resultado.setCodRelacion("");
			        	}
			        }
			    	//Inicio Datos psibles Hijos
			    	nodeList2 = element.getElementsByTagName("posibles_hijos");
			    	if(nodeList2 != null && nodeList2.getLength()>0){
			    		Element el = (Element)nodeList2.item(0);
				    	NodeList nodeList3 = null;
				    	nodeList3 = el.getElementsByTagName("hijo");		
				    	//Inicio Seteo Datos hijos
				    	ArrayList lista = new ArrayList();
				    	cat.debug("Numero hijos ["+nodeList3.getLength()+"]");
				    	for(int i=0;i<nodeList3.getLength();i++){
				    		cat.debug("Hijo Numero ["+(i+1)+"]");
					    	Element el2 = (Element)nodeList3.item(i);			        
					    	NodeList nodeList4 = null;
					    	DatosHijoClienteBuroDTO hijoClienteBuroDTO = new DatosHijoClienteBuroDTO();
					    	nodeList4 = el2.getElementsByTagName("nombre");
				        	if(nodeList4 != null && nodeList4.getLength()>0){
					        	Element el3 = (Element)nodeList4.item(0);				        	
					        	if(el3.getFirstChild() != null){
					        		cat.debug("nombre: " + el3.getFirstChild().getNodeValue());
					        		hijoClienteBuroDTO.setNombreHijo(el3.getFirstChild().getNodeValue());
					        	}else{
					        		cat.debug("nombre es Vacio o Nulo");
					        		hijoClienteBuroDTO.setNombreHijo("");
					        	}
					        }
				        	nodeList4 = el2.getElementsByTagName("nombre_completo");
				        	if(nodeList4 != null && nodeList4.getLength()>0){
					        	Element el3 = (Element)nodeList4.item(0);				        	
					        	if(el3.getFirstChild() != null){
					        		cat.debug("nombre_completo: " + el3.getFirstChild().getNodeValue());
					        		hijoClienteBuroDTO.setNombreCompletoHijo(el3.getFirstChild().getNodeValue());
					        	}else{
					        		cat.debug("nombre_completo es Vacio o Nulo");
					        		hijoClienteBuroDTO.setNombreCompletoHijo("");
					        	}
					        }
				        	nodeList4 = el2.getElementsByTagName("apellido1");
				        	if(nodeList4 != null && nodeList4.getLength()>0){
					        	Element el3 = (Element)nodeList4.item(0);				        	
					        	if(el3.getFirstChild() != null){
					        		cat.debug("apellido1: " + el3.getFirstChild().getNodeValue());
					        		hijoClienteBuroDTO.setApellido1Hijo(el3.getFirstChild().getNodeValue());
					        	}else{
					        		cat.debug("apellido1 es Vacio o Nulo");
					        		hijoClienteBuroDTO.setApellido1Hijo("");
					        	}
					        }
				        	nodeList4 = el2.getElementsByTagName("apellido2");
				        	if(nodeList4 != null && nodeList4.getLength()>0){
					        	Element el3 = (Element)nodeList4.item(0);				        	
					        	if(el3.getFirstChild() != null){
					        		cat.debug("apellido2: " + el3.getFirstChild().getNodeValue());
					        		hijoClienteBuroDTO.setApellido2Hijo(el3.getFirstChild().getNodeValue());
					        	}else{
					        		cat.debug("apellido2 es Vacio o Nulo");
					        		hijoClienteBuroDTO.setApellido2Hijo("");
					        	}
					        }
				        	nodeList4 = el2.getElementsByTagName("cod_parentesco");
				        	if(nodeList4 != null && nodeList4.getLength()>0){
					        	Element el3 = (Element)nodeList4.item(0);				        	
					        	if(el3.getFirstChild() != null){
					        		cat.debug("cod_parentesco: " + el3.getFirstChild().getNodeValue());
					        		hijoClienteBuroDTO.setCodParentesco(el3.getFirstChild().getNodeValue());
					        	}else{
					        		cat.debug("cod_parentesco es Vacio o Nulo");
					        		hijoClienteBuroDTO.setCodParentesco("");
					        	}
					        }
				        	nodeList4 = el2.getElementsByTagName("cedula");
				        	if(nodeList4 != null && nodeList4.getLength()>0){
					        	Element el3 = (Element)nodeList4.item(0);				        	
					        	if(el3.getFirstChild() != null){
					        		cat.debug("cedula: " + el3.getFirstChild().getNodeValue());
					        		hijoClienteBuroDTO.setCedulaHijo(el3.getFirstChild().getNodeValue());
					        	}else{
					        		cat.debug("cedula es Vacio o Nulo");
					        		hijoClienteBuroDTO.setCedulaHijo("");
					        	}
					        }
				        	nodeList4 = el2.getElementsByTagName("fallecido");
				        	if(nodeList4 != null && nodeList4.getLength()>0){
					        	Element el3 = (Element)nodeList4.item(0);				        	
					        	if(el3.getFirstChild() != null){
					        		cat.debug("fallecido: " + el3.getFirstChild().getNodeValue());
					        		hijoClienteBuroDTO.setFallecidoHijo(el3.getFirstChild().getNodeValue());
					        	}else{
					        		cat.debug("fallecido es Vacio o Nulo");
					        		hijoClienteBuroDTO.setFallecidoHijo("");
					        	}
					        }
				        	nodeList4 = el2.getElementsByTagName("cod_fallecido");
				        	if(nodeList4 != null && nodeList4.getLength()>0){
					        	Element el3 = (Element)nodeList4.item(0);				        	
					        	if(el3.getFirstChild() != null){
					        		cat.debug("cod_fallecido: " + el3.getFirstChild().getNodeValue());
					        		hijoClienteBuroDTO.setCodFallecidoHijo(el3.getFirstChild().getNodeValue());
					        	}else{
					        		cat.debug("cod_fallecido es Vacio o Nulo");
					        		hijoClienteBuroDTO.setCodFallecidoHijo("");
					        	}
					        }
				        	nodeList4 = el2.getElementsByTagName("edad");
				        	if(nodeList4 != null && nodeList4.getLength()>0){
					        	Element el3 = (Element)nodeList4.item(0);				        	
					        	if(el3.getFirstChild() != null){
					        		cat.debug("edad: " + el3.getFirstChild().getNodeValue());
					        		hijoClienteBuroDTO.setEdadHijo(el3.getFirstChild().getNodeValue());
					        	}else{
					        		cat.debug("edad es Vacio o Nulo");
					        		hijoClienteBuroDTO.setEdadHijo("");
					        	}
					        }
				        	nodeList4 = el2.getElementsByTagName("fechanacimiento");
				        	if(nodeList4 != null && nodeList4.getLength()>0){
					        	Element el3 = (Element)nodeList4.item(0);				        	
					        	if(el3.getFirstChild() != null){
					        		cat.debug("fechanacimiento: " + el3.getFirstChild().getNodeValue());
					        		hijoClienteBuroDTO.setFecNacimientoHijo(el3.getFirstChild().getNodeValue());
					        	}else{
					        		cat.debug("fechanacimiento es Vacio o Nulo");
					        		hijoClienteBuroDTO.setFecNacimientoHijo("");
					        	}
					        }
				        	nodeList4 = el2.getElementsByTagName("genero");
				        	if(nodeList4 != null && nodeList4.getLength()>0){
					        	Element el3 = (Element)nodeList4.item(0);				        	
					        	if(el3.getFirstChild() != null){
					        		cat.debug("genero: " + el3.getFirstChild().getNodeValue());
					        		hijoClienteBuroDTO.setSexoHijo(el3.getFirstChild().getNodeValue());
					        	}else{
					        		cat.debug("genero es Vacio o Nulo");
					        		hijoClienteBuroDTO.setSexoHijo("");
					        	}
					        }
				        	lista.add(hijoClienteBuroDTO); //Fin Seteo Datos hijos	
					    }
				    	resultado.setHijosCliente((DatosHijoClienteBuroDTO[]) ArrayUtl.copiaArregloTipoEspecifico(lista.toArray(), DatosHijoClienteBuroDTO.class));			        	
			        }//Fin Datos psibles Hijos
			    	
			    	nodeList2 = element.getElementsByTagName("madre");
			    	if(nodeList2 != null && nodeList2.getLength()>0){
			        	Element el2 = (Element)nodeList2.item(0);				        	
			        	if(el2.getFirstChild() != null){
			        		cat.debug("madre: " + el2.getFirstChild().getNodeValue());
			        		resultado.setNombreMadre(el2.getFirstChild().getNodeValue());
			        	}else{
			        		cat.debug("madre es Vacio o Nulo");
			        		resultado.setCedulaConyuge("");
			        	}
			        }
			    	nodeList2 = element.getElementsByTagName("cod_parentesco");
			    	if(nodeList2 != null && nodeList2.getLength()>0){
			        	Element el2 = (Element)nodeList2.item(0);				        	
			        	if(el2.getFirstChild() != null){
			        		cat.debug("cod_parentesco: " + el2.getFirstChild().getNodeValue());
			        		resultado.setCodParentescoMadre(el2.getFirstChild().getNodeValue());
			        	}else{
			        		cat.debug("cod_parentesco es Vacio o Nulo");
			        		resultado.setCodParentescoMadre("");
			        	}
			        }
			    	nodeList2 = element.getElementsByTagName("madre_fallecida");
			    	if(nodeList2 != null && nodeList2.getLength()>0){
			        	Element el2 = (Element)nodeList2.item(0);				        	
			        	if(el2.getFirstChild() != null){
			        		cat.debug("madre_fallecida: " + el2.getFirstChild().getNodeValue());
			        		resultado.setFallecidaMadre(el2.getFirstChild().getNodeValue());
			        	}else{
			        		cat.debug("madre_fallecida es Vacio o Nulo");
			        		resultado.setFallecidaMadre("");
			        	}
			        }
			    	nodeList2 = element.getElementsByTagName("cod_madrefallecido");
			    	if(nodeList2 != null && nodeList2.getLength()>0){
			        	Element el2 = (Element)nodeList2.item(0);				        	
			        	if(el2.getFirstChild() != null){
			        		cat.debug("cod_madrefallecido: " + el2.getFirstChild().getNodeValue());
			        		resultado.setCodFallecidaMadre(el2.getFirstChild().getNodeValue());
			        	}else{
			        		cat.debug("cod_madrefallecido es Vacio o Nulo");
			        		resultado.setCodFallecidaMadre("");
			        	}
			        }
			    	nodeList2 = element.getElementsByTagName("cedula_madre");
			    	if(nodeList2 != null && nodeList2.getLength()>0){
			        	Element el2 = (Element)nodeList2.item(0);				        	
			        	if(el2.getFirstChild() != null){
			        		cat.debug("cedula_madre: " + el2.getFirstChild().getNodeValue());
			        		resultado.setCedulaMadre(el2.getFirstChild().getNodeValue());
			        	}else{
			        		cat.debug("cedula_madre es Vacio o Nulo");
			        		resultado.setCedulaMadre("");
			        	}
			        }
			    	nodeList2 = element.getElementsByTagName("padre_nombre");
			    	if(nodeList2 != null && nodeList2.getLength()>0){
			        	Element el2 = (Element)nodeList2.item(0);				        	
			        	if(el2.getFirstChild() != null){
			        		cat.debug("padre_nombre: " + el2.getFirstChild().getNodeValue());
			        		resultado.setNombrePadre(el2.getFirstChild().getNodeValue());
			        	}else{
			        		cat.debug("padre_nombre es Vacio o Nulo");
			        		resultado.setNombrePadre("");
			        	}
			        }
			    	nodeList2 = element.getElementsByTagName("cod_parentesco");
			    	if(nodeList2 != null && nodeList2.getLength()>0){
			        	Element el2 = (Element)nodeList2.item(0);				        	
			        	if(el2.getFirstChild() != null){
			        		cat.debug("cod_parentesco: " + el2.getFirstChild().getNodeValue());
			        		resultado.setCodParentescoPadre(el2.getFirstChild().getNodeValue());
			        	}else{
			        		cat.debug("cod_parentesco es Vacio o Nulo");
			        		resultado.setCodParentescoPadre("");
			        	}
			        }
			    	nodeList2 = element.getElementsByTagName("padre_fallecido");
			    	if(nodeList2 != null && nodeList2.getLength()>0){
			        	Element el2 = (Element)nodeList2.item(0);				        	
			        	if(el2.getFirstChild() != null){
			        		cat.debug("padre_fallecido: " + el2.getFirstChild().getNodeValue());
			        		resultado.setFallecidaPadre(el2.getFirstChild().getNodeValue());
			        	}else{
			        		cat.debug("padre_fallecido es Vacio o Nulo");
			        		resultado.setFallecidaPadre("");
			        	}
			        }
			    	nodeList2 = element.getElementsByTagName("cod_padrefallecido");
			    	if(nodeList2 != null && nodeList2.getLength()>0){
			        	Element el2 = (Element)nodeList2.item(0);				        	
			        	if(el2.getFirstChild() != null){
			        		cat.debug("cod_padrefallecido: " + el2.getFirstChild().getNodeValue());
			        		resultado.setCodFallecidaPadre(el2.getFirstChild().getNodeValue());
			        	}else{
			        		cat.debug("cod_padrefallecido es Vacio o Nulo");
			        		resultado.setCodFallecidaPadre("");
			        	}
			        }
			    	nodeList2 = element.getElementsByTagName("padre_cedula");
			    	if(nodeList2 != null && nodeList2.getLength()>0){
			        	Element el2 = (Element)nodeList2.item(0);				        	
			        	if(el2.getFirstChild() != null){
			        		cat.debug("padre_cedula: " + el2.getFirstChild().getNodeValue());
			        		resultado.setCedulaPadre(el2.getFirstChild().getNodeValue());
			        	}else{
			        		cat.debug("padre_cedula es Vacio o Nulo");
			        		resultado.setCedulaPadre("");
			        	}
			        }
			    }//Fin datos parientes
			    
			    nodeLst = rootElement.getElementsByTagName("sociedades");
			    //Inicio datos Sociedades
			    if(nodeLst != null && nodeLst.getLength()>0){
			    	Element element = (Element)nodeLst.item(0);
			    	NodeList nodeList2 = null;
			    	nodeList2 = element.getElementsByTagName("sociedad");
			    	if(nodeList2 != null && nodeList2.getLength()>0){
			    		Element el2 = (Element) nodeList2.item(0);
			    		NodeList nodeList3 = null;
				    	nodeList3 = el2.getElementsByTagName("nombre");
				    	if(nodeList3 != null && nodeList3.getLength()>0){
				        	Element el3 = (Element)nodeList3.item(0);				        	
				        	if(el3.getFirstChild() != null){
				        		cat.debug("nombre: " + el3.getFirstChild().getNodeValue());
				        		resultado.setNombreSociedad(el3.getFirstChild().getNodeValue());
				        	}else{
				        		cat.debug("nombre es Vacio o Nulo");
				        		resultado.setNombreSociedad("");
				        	}
				        }
				    	nodeList3 = el2.getElementsByTagName("cedula");
				    	if(nodeList3 != null && nodeList3.getLength()>0){
				        	Element el3 = (Element)nodeList3.item(0);				        	
				        	if(el3.getFirstChild() != null){
				        		cat.debug("cedula: " + el3.getFirstChild().getNodeValue());
				        		resultado.setCedulaSociedad(el3.getFirstChild().getNodeValue());
				        	}else{
				        		cat.debug("cedula es Vacio o Nulo");
				        		resultado.setCedulaSociedad("");
				        	}
				        }
				    	nodeList3 = el2.getElementsByTagName("puesto");
				    	if(nodeList3 != null && nodeList3.getLength()>0){
				        	Element el3 = (Element)nodeList3.item(0);				        	
				        	if(el3.getFirstChild() != null){
				        		cat.debug("puesto: " + el3.getFirstChild().getNodeValue());
				        		resultado.setPuestoSociedad(el3.getFirstChild().getNodeValue());
				        	}else{
				        		cat.debug("puesto es Vacio o Nulo");
				        		resultado.setPuestoSociedad("");
				        	}
				        }
				    	nodeList3 = el2.getElementsByTagName("fecha_consultada");
				    	if(nodeList3 != null && nodeList3.getLength()>0){
				        	Element el3 = (Element)nodeList3.item(0);				        	
				        	if(el3.getFirstChild() != null){
				        		cat.debug("fecha_consultada: " + el3.getFirstChild().getNodeValue());
				        		resultado.setFechaConsultadaSociedad(el3.getFirstChild().getNodeValue());
				        	}else{
				        		cat.debug("fecha_consultada es Vacio o Nulo");
				        		resultado.setFechaConsultadaSociedad("");
				        	}
				        }
			        }
			    }//Fin datos Sociedades
			    is.close();				
			//}else{
			//	cat.debug("Conexion no OK");
			//	cat.debug("Ocurrió un error con el request: " + rc + ", " + conn.getResponseMessage());
			//}  
		    cat.debug("Se cierra conexion a Buro");	
		}catch(AltaClienteException e){
			String log = StackTraceUtl.getStackTrace(e);
			cat.debug("AltaClienteException[" + log + "]");
			e.printStackTrace();
			throw e;			
		}catch(SocketTimeoutException e){ 
			String log = StackTraceUtl.getStackTrace(e);
			cat.debug("SocketTimeoutException[" + log + "]");
			cat.debug("SocketTimeoutException[" + e.getMessage() + "]");
			e.printStackTrace();
			//throw new AltaClienteException("1002",0,e.getMessage());		
			throw new AltaClienteException("1002",0,"No Existe Conexión con Buró");
	    }catch (IOException e) {
			String log = StackTraceUtl.getStackTrace(e);
			cat.debug("IOException[" + log + "]");			
			cat.debug("IOException[" + e.getMessage()+ "]");
			e.printStackTrace();
			//throw new AltaClienteException("1002",0,e.getMessage());
			throw new AltaClienteException("1002",0,"No Existe Conexión con Buró");
		} catch (ParserConfigurationException e) {
			String log = StackTraceUtl.getStackTrace(e);
			cat.debug("ParserConfigurationException[" + log + "]");
			e.printStackTrace();
			throw new Exception(e);
		} catch (SAXException e) {
			String log = StackTraceUtl.getStackTrace(e);
			cat.debug("SAXException[" + log + "]");
			e.printStackTrace();
			//throw new Exception(e);
			//throw new AltaClienteException("1002",0,e.getMessage());
			throw new AltaClienteException("1002",0,"No Existe Conexión con Buró");
		}catch(Exception e){
			String log = StackTraceUtl.getStackTrace(e);
			cat.debug("Exception[" + log + "]");
			e.printStackTrace();
			throw e;
		}
		cat.debug("consultaBuro():end");
		return resultado;
	}//Fin P-CSR-11002 JLGN 04-05-2011
	
	//Inicio P-CSR-11002 JLGN 06-05-2011
	/**
	 * Inserta cliente buro
	 * 
	 * @param cliente
	 * @return N/A
	 * @throws CustomerDomainException
	 */
	public void insertaClienteBuro(DatosClienteBuroDTO clienteBuroDTO, String usuario)throws CustomerDomainException{
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null;
		try
		{
			cat.debug("Inicio:insertaClienteBuro");

			//Inicio MA-184592 JLGN 15-05-2012
			//String call = getSQLDatosCliente("VE_alta_cliente_PG", "VE_insClienteBuro_PR", 99);
			//Fin MA-184592 JLGN 15-05-2012
			String call = getSQLDatosCliente("VE_alta_cliente_PG", "VE_insClienteBuro_PR", 100);
			cat.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);
			
			cstmt.setLong(1,Long.parseLong(clienteBuroDTO.getKeyRef().trim()));
			cat.debug("clienteBuroDTO.getKeyRef(): "+clienteBuroDTO.getKeyRef());
			cstmt.setString(2, clienteBuroDTO.getNombre()!=null?clienteBuroDTO.getNombre().trim():null);
			cat.debug("clienteBuroDTO.getNombre(): "+clienteBuroDTO.getNombre());
			cstmt.setString(3, clienteBuroDTO.getApellido1()!=null?clienteBuroDTO.getApellido1().trim():null);
			cat.debug("clienteBuroDTO.getApellido1(): "+clienteBuroDTO.getApellido1());
			cstmt.setString(4, clienteBuroDTO.getApellido2()!=null?clienteBuroDTO.getApellido2().trim():null);
			cat.debug("clienteBuroDTO.getApellido2(): "+clienteBuroDTO.getApellido2());
			cstmt.setString(5, clienteBuroDTO.getNumeroCedula()!=null?clienteBuroDTO.getNumeroCedula().trim():null);
			cat.debug("clienteBuroDTO.getNumeroCedula(): "+clienteBuroDTO.getNumeroCedula());
			cstmt.setString(6, clienteBuroDTO.getFallecido()!=null?clienteBuroDTO.getFallecido().trim():null);
			cat.debug("clienteBuroDTO.getFallecido(): "+clienteBuroDTO.getFallecido());
			cstmt.setString(7, clienteBuroDTO.getCodFallecido()!=null?clienteBuroDTO.getCodFallecido().trim():null);
			cat.debug("clienteBuroDTO.getCodFallecido(): "+clienteBuroDTO.getCodFallecido());
			cstmt.setString(8, clienteBuroDTO.getEsPEP()!=null?clienteBuroDTO.getEsPEP().trim():null);
			cat.debug("clienteBuroDTO.getEsPEP(): "+clienteBuroDTO.getEsPEP());
			cstmt.setString(9, clienteBuroDTO.getInstitucionPEP()!=null?clienteBuroDTO.getInstitucionPEP().trim():null);
			cat.debug("clienteBuroDTO.getInstitucionPEP(): "+clienteBuroDTO.getInstitucionPEP());
			cstmt.setString(10, clienteBuroDTO.getCargoPEP()!=null?clienteBuroDTO.getCargoPEP().trim():null);
			cat.debug("clienteBuroDTO.getCargoPEP(): "+clienteBuroDTO.getCargoPEP());
			cstmt.setString(11, clienteBuroDTO.getPeriodoPEP()!=null?clienteBuroDTO.getPeriodoPEP().trim():null);
			cat.debug("clienteBuroDTO.getPeriodoPEP(): "+clienteBuroDTO.getPeriodoPEP());
			cstmt.setString(12, clienteBuroDTO.getFechaVencimientoCedula()!=null?clienteBuroDTO.getFechaVencimientoCedula().trim():null);
			cat.debug("clienteBuroDTO.getFechaVencimientoCedula(): "+clienteBuroDTO.getFechaVencimientoCedula());
			cstmt.setString(13, clienteBuroDTO.getSexo()!=null?clienteBuroDTO.getSexo().trim():null);
			cat.debug("clienteBuroDTO.getSexo(): "+clienteBuroDTO.getSexo());
			cstmt.setString(14, clienteBuroDTO.getFechaNacimiento()!=null?clienteBuroDTO.getFechaNacimiento().trim():null);
			cat.debug("clienteBuroDTO.getFechaNacimiento(): "+clienteBuroDTO.getFechaNacimiento());
			cstmt.setString(15, clienteBuroDTO.getPaisNacimiento()!=null?clienteBuroDTO.getPaisNacimiento().trim():null);
			cat.debug("clienteBuroDTO.getPaisNacimiento(): "+clienteBuroDTO.getPaisNacimiento());
			cstmt.setString(16, clienteBuroDTO.getCodPaisNacimiento()!=null?clienteBuroDTO.getCodPaisNacimiento().trim():null);
			cat.debug("clienteBuroDTO.getCodPaisNacimiento(): "+clienteBuroDTO.getCodPaisNacimiento());
			cstmt.setString(17, clienteBuroDTO.getCiudadNacimiento()!=null?clienteBuroDTO.getCiudadNacimiento().trim():null);
			cat.debug("clienteBuroDTO.getCiudadNacimiento(): "+clienteBuroDTO.getCiudadNacimiento());
			cstmt.setString(18, clienteBuroDTO.getCodCiudadNacimiento()!=null?clienteBuroDTO.getCodCiudadNacimiento().trim():null);
			cat.debug("clienteBuroDTO.getCodCiudadNacimiento(): "+clienteBuroDTO.getCodCiudadNacimiento());
			cstmt.setString(19, clienteBuroDTO.getEdad()!=null?clienteBuroDTO.getEdad().trim():null);
			cat.debug("clienteBuroDTO.getEdad(): "+clienteBuroDTO.getEdad());
			cstmt.setString(20, clienteBuroDTO.getEstadoCivil()!=null?clienteBuroDTO.getEstadoCivil().trim():null);
			cat.debug("clienteBuroDTO.getEstadoCivil(): "+clienteBuroDTO.getEstadoCivil());
			cstmt.setString(21, clienteBuroDTO.getCodEstadoCivil()!=null?clienteBuroDTO.getCodEstadoCivil().trim():null);
			cat.debug("clienteBuroDTO.getCodEstadoCivil(): "+clienteBuroDTO.getCodEstadoCivil());
			cstmt.setString(22, clienteBuroDTO.getCantidadEventos()!=null?clienteBuroDTO.getCantidadEventos().trim():null);
			cat.debug("clienteBuroDTO.getCantidadEventos(): "+clienteBuroDTO.getCantidadEventos());
			cstmt.setString(23, clienteBuroDTO.getCodProvincia()!=null?clienteBuroDTO.getCodProvincia().trim():null);
			cat.debug("clienteBuroDTO.getCodProvincia(): "+clienteBuroDTO.getCodProvincia());
			cstmt.setString(24, clienteBuroDTO.getCodCanton()!=null?clienteBuroDTO.getCodCanton().trim():null);
			cat.debug("clienteBuroDTO.getCodCanton(): "+clienteBuroDTO.getCodCanton());
			cstmt.setString(25, clienteBuroDTO.getCodDistrito()!=null?clienteBuroDTO.getCodDistrito().trim():null);
			cat.debug("clienteBuroDTO.getCodDistrito(): "+clienteBuroDTO.getCodDistrito());
			cstmt.setString(26, clienteBuroDTO.getBloqueo()!=null?clienteBuroDTO.getBloqueo().trim():null);
			cat.debug("clienteBuroDTO.getBloqueo(): "+clienteBuroDTO.getBloqueo());
			cstmt.setString(27, clienteBuroDTO.getCodigoBloqueo()!=null?clienteBuroDTO.getCodigoBloqueo().trim():null);
			cat.debug("clienteBuroDTO.getCodigoBloqueo(): "+clienteBuroDTO.getCodigoBloqueo());
			cstmt.setString(28, clienteBuroDTO.getDesDireccion()!=null?clienteBuroDTO.getDesDireccion().trim():null);
			cat.debug("clienteBuroDTO.getDesDireccion(): "+clienteBuroDTO.getDesDireccion());
			cstmt.setString(29, clienteBuroDTO.getFechaVencimiento()!=null?clienteBuroDTO.getFechaVencimiento().trim():null);
			cat.debug("clienteBuroDTO.getFechaVencimiento(): "+clienteBuroDTO.getFechaVencimiento());
			cstmt.setString(30, clienteBuroDTO.getTomo()!=null?clienteBuroDTO.getTomo().trim():null);
			cat.debug("clienteBuroDTO.getTomo(): "+clienteBuroDTO.getTomo());
			cstmt.setString(31, clienteBuroDTO.getFolio()!=null?clienteBuroDTO.getFolio().trim():null);
			cat.debug("clienteBuroDTO.getFolio(): "+clienteBuroDTO.getFolio());
			cstmt.setString(32, clienteBuroDTO.getAsiento()!=null?clienteBuroDTO.getAsiento().trim():null);
			cat.debug("clienteBuroDTO.getAsiento(): "+clienteBuroDTO.getAsiento());
			cstmt.setString(33, clienteBuroDTO.getClasificacion()!=null?clienteBuroDTO.getClasificacion().trim():null);
			cat.debug("clienteBuroDTO.getClasificacion(): "+clienteBuroDTO.getClasificacion());
			cstmt.setString(34, clienteBuroDTO.getActividad()!=null?clienteBuroDTO.getActividad().trim():null);
			cat.debug("clienteBuroDTO.getActividad(): "+clienteBuroDTO.getActividad());
			cstmt.setString(35, clienteBuroDTO.getTelefono()!=null?clienteBuroDTO.getTelefono().trim():null);
			cat.debug("clienteBuroDTO.getTelefono(): "+clienteBuroDTO.getTelefono());
			//Se realiza Truncate cuando el largo es mayor de 100
			if(clienteBuroDTO.getPersoneriaSociedad() != null){
				if(clienteBuroDTO.getPersoneriaSociedad().length() > 99){
					cstmt.setString(36, clienteBuroDTO.getPersoneriaSociedad().substring(0, 99));
				}else{
					cstmt.setString(36, clienteBuroDTO.getPersoneriaSociedad());
				}
			}else{
				cstmt.setString(36, null);
			}
			cat.debug("clienteBuroDTO.getPersoneriaSociedad(): "+ clienteBuroDTO.getPersoneriaSociedad());
			/*cstmt.setString(36, clienteBuroDTO.getPersoneriaSociedad());
			cat.debug("clienteBuroDTO.getPersoneriaSociedad(): "+clienteBuroDTO.getPersoneriaSociedad());*/
			cstmt.setString(37, clienteBuroDTO.getDomicilio()!=null?clienteBuroDTO.getDomicilio().trim():null);
			cat.debug("clienteBuroDTO.getDomicilio(): "+clienteBuroDTO.getDomicilio());
			//Se realiza Truncate cuando el largo es mayor de 249
			if(clienteBuroDTO.getRepresentacion() != null){
				if(clienteBuroDTO.getRepresentacion().length() > 249){
					cstmt.setString(38,clienteBuroDTO.getRepresentacion().substring(0, 249));
				}else{
					cstmt.setString(38, clienteBuroDTO.getRepresentacion());
				}
			}else{
				cstmt.setString(38, null);
			}
			cat.debug("clienteBuroDTO.getRepresentacion(): "+ clienteBuroDTO.getRepresentacion());
			/*cstmt.setString(38, clienteBuroDTO.getRepresentacion());
			cat.debug("clienteBuroDTO.getRepresentacion(): "+clienteBuroDTO.getRepresentacion());*/
			cstmt.setString(39, clienteBuroDTO.getCelular()!=null?clienteBuroDTO.getCelular().trim():null);
			cat.debug("clienteBuroDTO.getCelular(): "+clienteBuroDTO.getCelular());
			cstmt.setString(40, clienteBuroDTO.getTipProducto()!=null?clienteBuroDTO.getTipProducto().trim():null);
			cat.debug("clienteBuroDTO.getTipProducto(): "+clienteBuroDTO.getTipProducto());
			cstmt.setString(41, clienteBuroDTO.getTipSegmento()!=null?clienteBuroDTO.getTipSegmento().trim():null);
			cat.debug("clienteBuroDTO.getTipSegmento(): "+clienteBuroDTO.getTipSegmento());
			cstmt.setString(42, clienteBuroDTO.getDatosGenerales()!=null?clienteBuroDTO.getDatosGenerales().trim():null);
			cat.debug("clienteBuroDTO.getDatosGenerales(): "+clienteBuroDTO.getDatosGenerales());
			cstmt.setString(43, clienteBuroDTO.getLaboral()!=null?clienteBuroDTO.getLaboral().trim():null);
			cat.debug("clienteBuroDTO.getLaboral(): "+clienteBuroDTO.getLaboral());
			cstmt.setString(44, clienteBuroDTO.getHistConsulta()!=null?clienteBuroDTO.getHistConsulta().trim():null);
			cat.debug("clienteBuroDTO.getHistConsulta(): "+clienteBuroDTO.getHistConsulta());
			cstmt.setString(45, clienteBuroDTO.getRefCredito()!=null?clienteBuroDTO.getRefCredito().trim():null);
			cat.debug("clienteBuroDTO.getRefCredito(): "+clienteBuroDTO.getRefCredito());
			cstmt.setString(46, clienteBuroDTO.getLibEntradaHistorico()!=null?clienteBuroDTO.getLibEntradaHistorico().trim():null);
			cat.debug("clienteBuroDTO.getLibEntradaHistorico(): "+clienteBuroDTO.getLibEntradaHistorico());
			cstmt.setString(47, clienteBuroDTO.getLibEntradaActivo()!=null?clienteBuroDTO.getLibEntradaActivo().trim():null);
			cat.debug("clienteBuroDTO.getLibEntradaActivo(): "+clienteBuroDTO.getLibEntradaActivo());
			cstmt.setString(48, clienteBuroDTO.getResulCalificacion()!=null?clienteBuroDTO.getResulCalificacion().trim():null);
			cat.debug("clienteBuroDTO.getResulCalificacion(): "+clienteBuroDTO.getResulCalificacion());
			cstmt.setString(49, clienteBuroDTO.getCodInterno()!=null?clienteBuroDTO.getCodInterno().trim():null);
			cat.debug("clienteBuroDTO.getCodInterno(): "+clienteBuroDTO.getCodInterno());
			cstmt.setString(50, clienteBuroDTO.getNombreTrabajo()!=null?clienteBuroDTO.getNombreTrabajo().trim():null);
			cat.debug("clienteBuroDTO.getNombreTrabajo(): "+clienteBuroDTO.getNombreTrabajo());
			cstmt.setString(51, clienteBuroDTO.getNombreComercial()!=null?clienteBuroDTO.getNombreComercial().trim():null);
			cat.debug("clienteBuroDTO.getNombreComercial(): "+clienteBuroDTO.getNombreComercial());
			cstmt.setString(52, clienteBuroDTO.getProvinciaPatrono()!=null?clienteBuroDTO.getProvinciaPatrono().trim():null);
			cat.debug("clienteBuroDTO.getProvinciaPatrono(): "+clienteBuroDTO.getProvinciaPatrono());
			cstmt.setString(53, clienteBuroDTO.getCantonPatrono()!=null?clienteBuroDTO.getCantonPatrono().trim():null);
			cat.debug("clienteBuroDTO.getCantonPatrono(): "+clienteBuroDTO.getCantonPatrono());
			cstmt.setString(54, clienteBuroDTO.getDistritoPatrono()!=null?clienteBuroDTO.getDistritoPatrono().trim():null);
			cat.debug("clienteBuroDTO.getDistritoPatrono(): "+clienteBuroDTO.getDistritoPatrono());
			cstmt.setString(55, clienteBuroDTO.getCodTipPatrono()!=null?clienteBuroDTO.getCodTipPatrono().trim():null);
			cat.debug("clienteBuroDTO.getCodTipPatrono(): "+clienteBuroDTO.getCodTipPatrono());
			cstmt.setString(56, clienteBuroDTO.getCedulaTrabajo()!=null?clienteBuroDTO.getCedulaTrabajo().trim():null);
			cat.debug("clienteBuroDTO.getCedulaTrabajo(): "+clienteBuroDTO.getCedulaTrabajo());
			cstmt.setString(57, clienteBuroDTO.getFinesTrabajo()!=null?clienteBuroDTO.getFinesTrabajo().trim():null);
			cat.debug("clienteBuroDTO.getFinesTrabajo(): "+clienteBuroDTO.getFinesTrabajo());
			cstmt.setString(58, clienteBuroDTO.getOcupacion()!=null?clienteBuroDTO.getOcupacion().trim():null);
			cat.debug("clienteBuroDTO.getOcupacion(): "+clienteBuroDTO.getOcupacion());
			cstmt.setString(59, clienteBuroDTO.getCodOcupacion()!=null?clienteBuroDTO.getCodOcupacion().trim():null);
			cat.debug("clienteBuroDTO.getCodOcupacion(): "+clienteBuroDTO.getCodOcupacion());
			cstmt.setString(60, clienteBuroDTO.getSalario()!=null?clienteBuroDTO.getSalario().trim():null);
			cat.debug("clienteBuroDTO.getSalario(): "+clienteBuroDTO.getSalario());
			cstmt.setString(61, clienteBuroDTO.getProm3Meses()!=null?clienteBuroDTO.getProm3Meses().trim():null);
			cat.debug("clienteBuroDTO.getProm3Meses(): "+clienteBuroDTO.getProm3Meses());
			cstmt.setString(62, clienteBuroDTO.getProm6Meses()!=null?clienteBuroDTO.getProm6Meses().trim():null);
			cat.debug("clienteBuroDTO.getProm6Meses(): "+clienteBuroDTO.getProm6Meses());
			cstmt.setString(63, clienteBuroDTO.getProm12Meses()!=null?clienteBuroDTO.getProm12Meses().trim():null);
			cat.debug("clienteBuroDTO.getProm12Meses(): "+clienteBuroDTO.getProm12Meses());
			cstmt.setString(64, clienteBuroDTO.getFechaRegistro()!=null?clienteBuroDTO.getFechaRegistro().trim():null);
			cat.debug("clienteBuroDTO.getFechaRegistro(): "+clienteBuroDTO.getFechaRegistro());
			cstmt.setString(65, clienteBuroDTO.getTiempoLaboral()!=null?clienteBuroDTO.getTiempoLaboral().trim():null);
			cat.debug("clienteBuroDTO.getTiempoLaboral(): "+clienteBuroDTO.getTiempoLaboral());
			cstmt.setString(66, clienteBuroDTO.getMesesLaboral()!=null?clienteBuroDTO.getMesesLaboral().trim():null);
			cat.debug("clienteBuroDTO.getMesesLaboral(): "+clienteBuroDTO.getMesesLaboral());
			cstmt.setString(67, clienteBuroDTO.getMontoDeuda()!=null?clienteBuroDTO.getMontoDeuda().trim():null);
			cat.debug("clienteBuroDTO.getMontoDeuda(): "+clienteBuroDTO.getMontoDeuda());
			cstmt.setString(68, clienteBuroDTO.getNumCuotas()!=null?clienteBuroDTO.getNumCuotas().trim():null);
			cat.debug("clienteBuroDTO.getNumCuotas(): "+clienteBuroDTO.getNumCuotas());
			cstmt.setString(69, clienteBuroDTO.getDesDirecTrabajo()!=null?clienteBuroDTO.getDesDirecTrabajo().trim():null);
			cat.debug("clienteBuroDTO.getDesDirecTrabajo(): "+clienteBuroDTO.getDesDirecTrabajo());
			cstmt.setString(70, clienteBuroDTO.getCentralTelefonica()!=null?clienteBuroDTO.getCentralTelefonica().trim():null);
			cat.debug("clienteBuroDTO.getCentralTelefonica(): "+clienteBuroDTO.getCentralTelefonica());
			cstmt.setString(71, clienteBuroDTO.getNombreConyuge()!=null?clienteBuroDTO.getNombreConyuge().trim():null);
			cat.debug("clienteBuroDTO.getNombreConyuge(): "+clienteBuroDTO.getNombreConyuge());
			cstmt.setString(72, clienteBuroDTO.getApellido1Conyuge()!=null?clienteBuroDTO.getApellido1Conyuge().trim():null);
			cat.debug("clienteBuroDTO.getApellido1Conyuge(): "+clienteBuroDTO.getApellido1Conyuge());
			cstmt.setString(73, clienteBuroDTO.getApellido2Conyuge()!=null?clienteBuroDTO.getApellido2Conyuge().trim():null);
			cat.debug("clienteBuroDTO.getApellido2Conyuge(): "+clienteBuroDTO.getApellido2Conyuge());
			cstmt.setString(74, clienteBuroDTO.getNombreCompletoConyuge()!=null?clienteBuroDTO.getNombreCompletoConyuge().trim():null);
			cat.debug("clienteBuroDTO.getNombreCompletoConyuge(): "+clienteBuroDTO.getNombreCompletoConyuge());
			cstmt.setString(75, clienteBuroDTO.getFallecidoConyuge()!=null?clienteBuroDTO.getFallecidoConyuge().trim():null);
			cat.debug("clienteBuroDTO.getFallecidoConyuge(): "+clienteBuroDTO.getFallecidoConyuge());
			cstmt.setString(76, clienteBuroDTO.getCodFallecidoConyuge()!=null?clienteBuroDTO.getCodFallecidoConyuge().trim():null);
			cat.debug("clienteBuroDTO.getCodFallecidoConyuge(): "+clienteBuroDTO.getCodFallecidoConyuge());
			cstmt.setString(77, clienteBuroDTO.getCedulaConyuge()!=null?clienteBuroDTO.getCedulaConyuge().trim():null);
			cat.debug("clienteBuroDTO.getCedulaConyuge(): "+clienteBuroDTO.getCedulaConyuge());
			cstmt.setString(78, clienteBuroDTO.getNomRelacion()!=null?clienteBuroDTO.getNomRelacion().trim():null);
			cat.debug("clienteBuroDTO.getNomRelacion(): "+clienteBuroDTO.getNomRelacion());
			cstmt.setString(79, clienteBuroDTO.getCodRelacion()!=null?clienteBuroDTO.getCodRelacion().trim():null);
			cat.debug("clienteBuroDTO.getCodRelacion(): "+clienteBuroDTO.getCodRelacion());
			cstmt.setString(80, clienteBuroDTO.getLaboraConyuge()!=null?clienteBuroDTO.getLaboraConyuge().trim():null);
			cat.debug("clienteBuroDTO.getLaboraConyuge(): "+clienteBuroDTO.getLaboraConyuge());
			cstmt.setString(81, clienteBuroDTO.getNombreMadre()!=null?clienteBuroDTO.getNombreMadre().trim():null);
			cat.debug("clienteBuroDTO.getNombreMadre(): "+clienteBuroDTO.getNombreMadre());
			cstmt.setString(82, clienteBuroDTO.getCodParentescoMadre()!=null?clienteBuroDTO.getCodParentescoMadre().trim():null);
			cat.debug("clienteBuroDTO.getCodParentescoMadre(): "+clienteBuroDTO.getCodParentescoMadre());
			cstmt.setString(83, clienteBuroDTO.getFallecidaMadre()!=null?clienteBuroDTO.getFallecidaMadre().trim():null);
			cat.debug("clienteBuroDTO.getFallecidaMadre(): "+clienteBuroDTO.getFallecidaMadre());
			cstmt.setString(84, clienteBuroDTO.getCodFallecidaMadre()!=null?clienteBuroDTO.getCodFallecidaMadre().trim():null);
			cat.debug("clienteBuroDTO.getCodFallecidaMadre(): "+clienteBuroDTO.getCodFallecidaMadre());
			cstmt.setString(85, clienteBuroDTO.getCedulaMadre()!=null?clienteBuroDTO.getCedulaMadre().trim():null);
			cat.debug("clienteBuroDTO.getCedulaMadre(): "+clienteBuroDTO.getCedulaMadre());
			cstmt.setString(86, clienteBuroDTO.getNombrePadre()!=null?clienteBuroDTO.getNombrePadre().trim():null);
			cat.debug("clienteBuroDTO.getNombrePadre(): "+clienteBuroDTO.getNombrePadre());
			cstmt.setString(87, clienteBuroDTO.getCodParentescoPadre()!=null?clienteBuroDTO.getCodParentescoPadre().trim():null);
			cat.debug("clienteBuroDTO.getCodParentescoPadre(): "+clienteBuroDTO.getCodParentescoPadre());
			cstmt.setString(88, clienteBuroDTO.getFallecidaPadre()!=null?clienteBuroDTO.getFallecidaPadre().trim():null);
			cat.debug("clienteBuroDTO.getFallecidaPadre(): "+clienteBuroDTO.getFallecidaPadre());
			cstmt.setString(89, clienteBuroDTO.getCodFallecidaPadre()!=null?clienteBuroDTO.getCodFallecidaPadre().trim():null);
			cat.debug("clienteBuroDTO.getCodFallecidaPadre(): "+clienteBuroDTO.getCodFallecidaPadre());
			cstmt.setString(90, clienteBuroDTO.getCedulaPadre()!=null?clienteBuroDTO.getCedulaPadre().trim():null);
			cat.debug("clienteBuroDTO.getCedulaPadre(): "+clienteBuroDTO.getCedulaPadre());
			cstmt.setString(91, clienteBuroDTO.getNombreSociedad()!=null?clienteBuroDTO.getNombreSociedad().trim():null);
			cat.debug("clienteBuroDTO.getNombreSociedad(): "+clienteBuroDTO.getNombreSociedad());
			cstmt.setString(92, clienteBuroDTO.getCedulaSociedad()!=null?clienteBuroDTO.getCedulaSociedad().trim():null);
			cat.debug("clienteBuroDTO.getCedulaSociedad(): "+clienteBuroDTO.getCedulaSociedad());
			cstmt.setString(93, clienteBuroDTO.getPuestoSociedad()!=null?clienteBuroDTO.getPuestoSociedad().trim():null);
			cat.debug("clienteBuroDTO.getPuestoSociedad(): "+clienteBuroDTO.getPuestoSociedad());
			cstmt.setString(94, clienteBuroDTO.getFechaConsultadaSociedad()!=null?clienteBuroDTO.getFechaConsultadaSociedad().trim():null);
			cat.debug("clienteBuroDTO.getFechaConsultadaSociedad(): "+clienteBuroDTO.getFechaConsultadaSociedad());
			//P-CSR-11002 JLGN 31-05-2011
			cstmt.setString(95, clienteBuroDTO.getLimiteDeCredito()!=null?clienteBuroDTO.getLimiteDeCredito().trim():null);
			cat.debug("clienteBuroDTO.getLimiteDeCredito(): "+clienteBuroDTO.getLimiteDeCredito());
			//P-CSR-11002 JLGN 16-06-2011
			cstmt.setString(96, clienteBuroDTO.getRazonSocial()!=null?clienteBuroDTO.getRazonSocial().trim():null);
			cat.debug("clienteBuroDTO.getRazonSocial(): "+clienteBuroDTO.getRazonSocial());
			//MA-184592 JLGN 15-05-2012
			cstmt.setString(97, usuario);
			cat.debug("usuario: "+clienteBuroDTO.getRazonSocial());
			
			cstmt.registerOutParameter(98, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(99, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(100, java.sql.Types.NUMERIC);

			cat.debug("Inicio:insertaClienteBuro:execute");
			cstmt.execute();
			cat.debug("Fin:insertaClienteBuro:execute");

			codError = cstmt.getInt(98);
			msgError = cstmt.getString(99);
			numEvento = cstmt.getInt(100);
			
			cat.debug("Codigo de Error[" + codError + "]");
			cat.debug("Mensaje de Error[" + msgError + "]");
			cat.debug("Numero de Evento[" + numEvento + "]");

			if (codError != 0)
			{
				cat.error("Ocurrió un error al insertar registro de cliente Buro");
				throw new CustomerDomainException("Ocurrió un error al insertar registro de cliente Buro", String
						.valueOf(codError), numEvento, msgError);
			}
		}
		catch (Exception e)
		{
			cat.error("Ocurrió un error al insertar registro de cliente Buro", e);
			if (cat.isDebugEnabled())
			{
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
			if (e instanceof CustomerDomainException)
				throw (CustomerDomainException) e;
		}
		finally
		{
			if (cat.isDebugEnabled())
				cat.debug("Cerrando conexiones...");
			try
			{
				if (cstmt != null)
					cstmt.close();
				if (!conn.isClosed())
				{
					conn.close();
				}
			}
			catch (SQLException e)
			{
				cat.debug("SQLException", e);
			}
		}
		cat.debug("Fin:insertaClienteBuro()");
	}// fin insertaClienteBuro
	
	/**
	 * Inserta nombramiento cliente buro
	 * 
	 * @param cliente
	 * @return N/A
	 * @throws CustomerDomainException
	 */
	public void insertaNombramientoBuro(TipoNombramientoDTO nombramientoDTO, String keyRef)throws CustomerDomainException{
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null;
		try
		{
			cat.debug("Inicio:insertaNombramientoBuro");

			String call = getSQLDatosCliente("VE_alta_cliente_PG", "VE_insNombramientoBuro_PR", 15);
			cat.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);
			
			cstmt.setLong(1,Long.parseLong(keyRef));
			cat.debug("TipoNombramientoDTO.getKeyRef(): "+ keyRef);
			cstmt.setString(2, nombramientoDTO.getTipNombramiento());
			cat.debug("TipoNombramientoDTO.getTipNombramiento(): "+nombramientoDTO.getTipNombramiento());
			cstmt.setString(3, nombramientoDTO.getNombreNombramiento());
			cat.debug("TipoNombramientoDTO.getNombreNombramiento(): "+nombramientoDTO.getNombreNombramiento());
			cstmt.setString(4, nombramientoDTO.getApellido1Nombramiento());
			cat.debug("TipoNombramientoDTO.getApellido1Nombramiento(): "+nombramientoDTO.getApellido1Nombramiento());
			cstmt.setString(5, nombramientoDTO.getApellido2Nombramiento());
			cat.debug("TipoNombramientoDTO.getApellido2Nombramiento(): "+nombramientoDTO.getApellido2Nombramiento());
			cstmt.setString(6, nombramientoDTO.getTipIdentNombramiento());
			cat.debug("TipoNombramientoDTO.getTipIdentNombramiento(): "+nombramientoDTO.getTipIdentNombramiento());
			cstmt.setString(7, nombramientoDTO.getNumidentNombramiento());
			cat.debug("TipoNombramientoDTO.getNumidentNombramiento(): "+nombramientoDTO.getNumidentNombramiento());
			cstmt.setString(8, nombramientoDTO.getNacionalidadNombramiento());
			cat.debug("TipoNombramientoDTO.getNacionalidadNombramiento(): "+nombramientoDTO.getNacionalidadNombramiento());
			cstmt.setString(9, nombramientoDTO.getEstadoCivilNombramiento());
			cat.debug("TipoNombramientoDTO.getEstadoCivilNombramiento(): "+nombramientoDTO.getEstadoCivilNombramiento());
			cstmt.setString(10, nombramientoDTO.getOcupacionNombramiento());
			cat.debug("TipoNombramientoDTO.getOcupacionNombramiento(): "+nombramientoDTO.getOcupacionNombramiento());
			cstmt.setString(11, nombramientoDTO.getDomicilioNombramiento());
			cat.debug("TipoNombramientoDTO.getDomicilioNombramiento(): "+nombramientoDTO.getDomicilioNombramiento());
			cstmt.setString(12, nombramientoDTO.getDireccionOficina());
			cat.debug("TipoNombramientoDTO.getDireccionOficina(): "+nombramientoDTO.getDireccionOficina());
		
			cstmt.registerOutParameter(13, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(14, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(15, java.sql.Types.NUMERIC);

			cat.debug("Inicio:insertaNombramientoBuro:execute");
			cstmt.execute();
			cat.debug("Fin:insertaNombramientoBuro:execute");

			codError = cstmt.getInt(13);
			msgError = cstmt.getString(14);
			numEvento = cstmt.getInt(15);
			
			cat.debug("Codigo de Error[" + codError + "]");
			cat.debug("Mensaje de Error[" + msgError + "]");
			cat.debug("Numero de Evento[" + numEvento + "]");

			if (codError != 0)
			{
				cat.error("Ocurrió un error al insertar registro de nombramiento cliente Buro");
				throw new CustomerDomainException("Ocurrió un error al insertar registro de nombramiento cliente Buro", String
						.valueOf(codError), numEvento, msgError);
			}
		}
		catch (Exception e)
		{
			cat.error("Ocurrió un error al insertar registro de nombramiento cliente Buro", e);
			if (cat.isDebugEnabled())
			{
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
			if (e instanceof CustomerDomainException)
				throw (CustomerDomainException) e;
		}
		finally
		{
			if (cat.isDebugEnabled())
				cat.debug("Cerrando conexiones...");
			try
			{
				if (cstmt != null)
					cstmt.close();
				if (!conn.isClosed())
				{
					conn.close();
				}
			}
			catch (SQLException e)
			{
				cat.debug("SQLException", e);
			}
		}
		cat.debug("Fin:insertaNombramientoBuro()");
	}// fin insertaNombramientoBuro
	
	/**
	 * Inserta Historico Laboral cliente buro
	 * 
	 * @param cliente
	 * @return N/A
	 * @throws CustomerDomainException
	 */
	public void insertaHistLaboralBuro(DatosLaboralHistoricoBuroDTO historicoBuroDTO, String keyRef)throws CustomerDomainException{
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null;
		try
		{
			cat.debug("Inicio:insertaHistLaboralBuro");

			String call = getSQLDatosCliente("VE_alta_cliente_PG", "VE_histLabBuro_PR", 12);
			cat.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);
			
			cstmt.setLong(1,Long.parseLong(keyRef));
			cat.debug("DatosLaboralHistoricoBuroDTO.getKeyRef(): "+ keyRef);
			cstmt.setString(2, historicoBuroDTO.getCedulaHist());
			cat.debug("DatosLaboralHistoricoBuroDTO.getCedulaHist: "+historicoBuroDTO.getCedulaHist());
			cstmt.setString(3, historicoBuroDTO.getCodTipPatronoHist());
			cat.debug("DatosLaboralHistoricoBuroDTO.getCodTipPatronoHist(): "+historicoBuroDTO.getCodTipPatronoHist());
			cstmt.setString(4, historicoBuroDTO.getNombreHist());
			cat.debug("DatosLaboralHistoricoBuroDTO.getNombreHist(): "+historicoBuroDTO.getNombreHist());
			cstmt.setString(5, historicoBuroDTO.getFecInicioHist());
			cat.debug("DatosLaboralHistoricoBuroDTO.getFecInicioHist(): "+historicoBuroDTO.getFecInicioHist());
			cstmt.setString(6, historicoBuroDTO.getFecCompInicioHist());
			cat.debug("DatosLaboralHistoricoBuroDTO.getFecCompInicioHist(): "+historicoBuroDTO.getFecCompInicioHist());
			cstmt.setString(7, historicoBuroDTO.getFecFinHist());
			cat.debug("DatosLaboralHistoricoBuroDTO.getFecFinHist(): "+historicoBuroDTO.getFecFinHist());
			cstmt.setString(8, historicoBuroDTO.getFecCompFinHist());
			cat.debug("DatosLaboralHistoricoBuroDTO.getFecCompFinHist(): "+historicoBuroDTO.getFecCompFinHist());
			cstmt.setString(9, historicoBuroDTO.getMesesLaboradosHist());
			cat.debug("DatosLaboralHistoricoBuroDTO.getMesesLaboradosHist(): "+historicoBuroDTO.getMesesLaboradosHist());			
		
			cstmt.registerOutParameter(10, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(11, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(12, java.sql.Types.NUMERIC);

			cat.debug("Inicio:insertaHistLaboralBuro:execute");
			cstmt.execute();
			cat.debug("Fin:insertaHistLaboralBuro:execute");

			codError = cstmt.getInt(10);
			msgError = cstmt.getString(11);
			numEvento = cstmt.getInt(12);
			
			cat.debug("Codigo de Error[" + codError + "]");
			cat.debug("Mensaje de Error[" + msgError + "]");
			cat.debug("Numero de Evento[" + numEvento + "]");

			if (codError != 0)
			{
				cat.error("Ocurrió un error al insertar registro de historico laboral cliente Buro");
				throw new CustomerDomainException("Ocurrió un error al insertar registro de historico laboral cliente Buro", String
						.valueOf(codError), numEvento, msgError);
			}
		}
		catch (Exception e)
		{
			cat.error("Ocurrió un error al insertar registro de historico laboral cliente Buro", e);
			if (cat.isDebugEnabled())
			{
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
			if (e instanceof CustomerDomainException)
				throw (CustomerDomainException) e;
		}
		finally
		{
			if (cat.isDebugEnabled())
				cat.debug("Cerrando conexiones...");
			try
			{
				if (cstmt != null)
					cstmt.close();
				if (!conn.isClosed())
				{
					conn.close();
				}
			}
			catch (SQLException e)
			{
				cat.debug("SQLException", e);
			}
		}
		cat.debug("Fin:insertaHistLaboralBuro()");
	}// fin insertaHistLaboralBuro
	
	/**
	 * Inserta Datos Hijo Cliente buro
	 * 
	 * @param cliente
	 * @return N/A
	 * @throws CustomerDomainException
	 */
	public void insertaHijosClienteBuro(DatosHijoClienteBuroDTO hijoClienteBuroDTO, String keyRef)throws CustomerDomainException{
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null;
		try
		{
			cat.debug("Inicio:insertaHijosClienteBuro");

			String call = getSQLDatosCliente("VE_alta_cliente_PG", "VE_hijosClienteBuro_PR", 15);
			cat.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);
			
			cstmt.setLong(1,Long.parseLong(keyRef));
			cat.debug("DatosHijoClienteBuroDTO.getKeyRef(): "+ keyRef);
			cstmt.setString(2, hijoClienteBuroDTO.getNombreHijo());
			cat.debug("DatosHijoClienteBuroDTO.getNombreHijo(): "+hijoClienteBuroDTO.getNombreHijo());
			cstmt.setString(3, hijoClienteBuroDTO.getNombreCompletoHijo());
			cat.debug("DatosHijoClienteBuroDTO.getCodTipPatronoHist(): "+hijoClienteBuroDTO.getNombreCompletoHijo());
			cstmt.setString(4, hijoClienteBuroDTO.getApellido1Hijo());
			cat.debug("DatosHijoClienteBuroDTO.getNombreHist(): "+hijoClienteBuroDTO.getApellido1Hijo());
			cstmt.setString(5, hijoClienteBuroDTO.getApellido2Hijo());
			cat.debug("DatosHijoClienteBuroDTO.getFecInicioHist(): "+hijoClienteBuroDTO.getApellido2Hijo());
			cstmt.setString(6, hijoClienteBuroDTO.getCodParentesco());
			cat.debug("DatosHijoClienteBuroDTO.getFecCompInicioHist(): "+hijoClienteBuroDTO.getCodParentesco());
			cstmt.setString(7, hijoClienteBuroDTO.getCedulaHijo());
			cat.debug("DatosHijoClienteBuroDTO.getFecFinHist(): "+hijoClienteBuroDTO.getCedulaHijo());
			cstmt.setString(8, hijoClienteBuroDTO.getFallecidoHijo());
			cat.debug("DatosHijoClienteBuroDTO.getFecCompFinHist(): "+hijoClienteBuroDTO.getFallecidoHijo());
			cstmt.setString(9, hijoClienteBuroDTO.getCodFallecidoHijo());
			cat.debug("DatosHijoClienteBuroDTO.getMesesLaboradosHist(): "+hijoClienteBuroDTO.getCodFallecidoHijo());			
			cstmt.setString(10, hijoClienteBuroDTO.getEdadHijo());
			cat.debug("DatosHijoClienteBuroDTO.getFecFinHist(): "+hijoClienteBuroDTO.getEdadHijo());
			cstmt.setString(11, hijoClienteBuroDTO.getFecNacimientoHijo());
			cat.debug("DatosHijoClienteBuroDTO.getFecCompFinHist(): "+hijoClienteBuroDTO.getFecNacimientoHijo());
			cstmt.setString(12, hijoClienteBuroDTO.getSexoHijo());
			cat.debug("DatosHijoClienteBuroDTO.getMesesLaboradosHist(): "+hijoClienteBuroDTO.getSexoHijo());	
			
			cstmt.registerOutParameter(13, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(14, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(15, java.sql.Types.NUMERIC);

			cat.debug("Inicio:insertaHijosClienteBuro:execute");
			cstmt.execute();
			cat.debug("Fin:insertaHijosClienteBuro:execute");

			codError = cstmt.getInt(13);
			msgError = cstmt.getString(14);
			numEvento = cstmt.getInt(15);
			
			cat.debug("Codigo de Error[" + codError + "]");
			cat.debug("Mensaje de Error[" + msgError + "]");
			cat.debug("Numero de Evento[" + numEvento + "]");

			if (codError != 0)
			{
				cat.error("Ocurrió un error al insertar registro del Hijo del Cliente Buro");
				throw new CustomerDomainException("Ocurrió un error al insertar registro del Hijo del Cliente Buro", String
						.valueOf(codError), numEvento, msgError);
			}
		}
		catch (Exception e)
		{
			cat.error("Ocurrió un error al insertar registro del Hijo del Cliente Buro", e);
			if (cat.isDebugEnabled())
			{
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
			if (e instanceof CustomerDomainException)
				throw (CustomerDomainException) e;
		}
		finally
		{
			if (cat.isDebugEnabled())
				cat.debug("Cerrando conexiones...");
			try
			{
				if (cstmt != null)
					cstmt.close();
				if (!conn.isClosed())
				{
					conn.close();
				}
			}
			catch (SQLException e)
			{
				cat.debug("SQLException", e);
			}
		}
		cat.debug("Fin:insertaHijosClienteBuro()");
	}// fin insertaHijosClienteBuro
	
	/**
	 * Obtiene datos direccion
	 * 
	 * @param cliente
	 * @return N/A
	 * @throws CustomerDomainException
	 */
	public void getDatosDireccionBuro(DatosClienteBuroDTO buroDTO)throws CustomerDomainException{
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null;
		try
		{
			cat.debug("Inicio:getDatosDireccionBuro");

			String call = getSQLDatosCliente("VE_parametros_comerciales_PG", "ve_datos_direccion_pr", 9);
			cat.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);
			cstmt.setString(1, buroDTO.getCodProvincia());
			cstmt.setString(2, buroDTO.getCodCanton());
			cstmt.setString(3, buroDTO.getCodDistrito());
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(6, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(7, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(8, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(9, java.sql.Types.NUMERIC);

			cat.debug("Inicio:getDatosDireccionBuro:execute");
			cstmt.execute();
			cat.debug("Fin:getDatosDireccionBuro:execute");

			codError = cstmt.getInt(7);
			msgError = cstmt.getString(8);
			numEvento = cstmt.getInt(9);
			
			cat.debug("Codigo de Error[" + codError + "]");
			cat.debug("Mensaje de Error[" + msgError + "]");
			cat.debug("Numero de Evento[" + numEvento + "]");

			if (codError != 0)
			{
				cat.error("Ocurrió un error al obtener datos de la Direccion");
				throw new CustomerDomainException("Ocurrió un error al obtener datos de la Direccion", String
						.valueOf(codError), numEvento, msgError);
			}
			
			cat.debug("Se Obtiene descripciones de direccion");
			buroDTO.setDesProvincia(cstmt.getString(4));			
			buroDTO.setDesDistrito(cstmt.getString(5));
			buroDTO.setDesCanton(cstmt.getString(6));
			cat.debug("Region: "+ buroDTO.getDesProvincia());
			cat.debug("Ciudad: "+ buroDTO.getDesCanton());
			cat.debug("Provincia: "+ buroDTO.getDesDistrito());
		}
		catch (Exception e)
		{
			cat.error("Ocurrió un error al obtener datos de la Direccion", e);
			if (cat.isDebugEnabled())
			{
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
			if (e instanceof CustomerDomainException)
				throw (CustomerDomainException) e;
		}
		finally
		{
			if (cat.isDebugEnabled())
				cat.debug("Cerrando conexiones...");
			try
			{
				if (cstmt != null)
					cstmt.close();
				if (!conn.isClosed())
				{
					conn.close();
				}
			}
			catch (SQLException e)
			{
				cat.debug("SQLException", e);
			}
		}
		cat.debug("Fin:getDatosDireccionBuro()");
	}// fin getDatosDireccionBuro
	
	//Fin P-CSR-11002 JLGN 06-05-2011

	//Inicio P-CSR-11002 JLGN 16-05-2011
	/**
	 * Obtiene datos Password Calificacion
	 * 
	 * @param String
	 * @return boolean
	 * @throws CustomerDomainException
	 */
	public boolean validaPassClasificacion(String passCalificacion) throws CustomerDomainException{
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null;
		int existePass;
		boolean resultado = false;
		try
		{
			cat.debug("Inicio:validaPassClasificacion");

			String call = getSQLDatosCliente("VE_parametros_comerciales_PG", "ve_valida_codigos_pr", 5);
			cat.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);
			cstmt.setString(1, passCalificacion);
			cat.debug("PassCalificacion: "+passCalificacion);
			cstmt.registerOutParameter(2, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);

			cat.debug("Inicio:validaPassClasificacion:execute");
			cstmt.execute();
			cat.debug("Fin:validaPassClasificacion:execute");

			codError = cstmt.getInt(3);
			msgError = cstmt.getString(4);
			numEvento = cstmt.getInt(5);
			
			cat.debug("Codigo de Error[" + codError + "]");
			cat.debug("Mensaje de Error[" + msgError + "]");
			cat.debug("Numero de Evento[" + numEvento + "]");

			if (codError != 0)
			{
				cat.error("Ocurrió un error al validar Password Calificacion");
				throw new CustomerDomainException("Ocurrió un error al validar Password Calificacion", String
						.valueOf(codError), numEvento, msgError);
			}
			
			cat.debug("Se Obtiene cantidad GedCodigos");
			existePass = cstmt.getInt(2);
			cat.debug("cantidad: "+existePass);
			if (existePass > 0){
				resultado = true;
			}else{
				resultado = false;
			}			
		}
		catch (Exception e)
		{
			cat.error("Ocurrió un error al validar Password Calificacion", e);
			if (cat.isDebugEnabled())
			{
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
			if (e instanceof CustomerDomainException)
				throw (CustomerDomainException) e;
		}
		finally
		{
			if (cat.isDebugEnabled())
				cat.debug("Cerrando conexiones...");
			try
			{
				if (cstmt != null)
					cstmt.close();
				if (!conn.isClosed())
				{
					conn.close();
				}
			}
			catch (SQLException e)
			{
				cat.debug("SQLException", e);
			}
		}
		cat.debug("Fin:validaPassClasificacion()");
		return resultado;
	}// fin validaPassClasificacion
	
	//Fin P-CSR-11002 JLGN 16-05-2011
	
	//Inicio P-CSR-11002 JLGN 17-05-2011
	/**
	 * Inserta Excepcion Calificacion
	 * 
	 * @param String
	 * @return N/A
	 * @throws CustomerDomainException
	 */
	public void insExcepcioCalificacion(String codCliente, String codPlanTarif, String nomUserOra, String codPass, String limiteCredito) throws CustomerDomainException{
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null;
		try
		{
			cat.debug("Inicio:insExcepcioCalificacion");

			String call = getSQLDatosCliente("Ve_Alta_Cliente_Pg", "VE_excepcionCalificacion_PR", 8);
			cat.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);
			cstmt.setLong(1, Long.parseLong(codCliente));
			cat.debug("codCliente: "+codCliente);
			cstmt.setString(2, codPlanTarif);
			cat.debug("codPlanTarif: "+codPlanTarif);
			cstmt.setString(3, nomUserOra);
			cat.debug("nomUserOra: "+nomUserOra);
			cstmt.setString(4, codPass);
			cat.debug("codPass: "+codPass);
			cstmt.setString(5, limiteCredito);
			cat.debug("limiteCredito: "+limiteCredito);
			cstmt.registerOutParameter(6, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(7, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(8, java.sql.Types.NUMERIC);

			cat.debug("Inicio:insExcepcioCalificacion:execute");
			cstmt.execute();
			cat.debug("Fin:insExcepcioCalificacion:execute");

			codError = cstmt.getInt(6);
			msgError = cstmt.getString(7);
			numEvento = cstmt.getInt(8);
			
			cat.debug("Codigo de Error[" + codError + "]");
			cat.debug("Mensaje de Error[" + msgError + "]");
			cat.debug("Numero de Evento[" + numEvento + "]");

			if (codError != 0)
			{
				cat.error("Ocurrió un error al Insertar Excepcion Calificacion");
				throw new CustomerDomainException("Ocurrió un error al Insertar Excepcion Calificacion", String
						.valueOf(codError), numEvento, msgError);
			}				
		}
		catch (Exception e)
		{
			cat.error("Ocurrió un error al Insertar Excepcion Calificacion", e);
			if (cat.isDebugEnabled())
			{
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
			if (e instanceof CustomerDomainException)
				throw (CustomerDomainException) e;
		}
		finally
		{
			if (cat.isDebugEnabled())
				cat.debug("Cerrando conexiones...");
			try
			{
				if (cstmt != null)
					cstmt.close();
				if (!conn.isClosed())
				{
					conn.close();
				}
			}
			catch (SQLException e)
			{
				cat.debug("SQLException", e);
			}
		}
		cat.debug("Fin:insExcepcioCalificacion()");
	}// fin insExcepcioCalificacion
	
	//Inicio P-CSR-11002 JLGN 26-05-2011
	/**
	 * Obtiene Datos Cliente
	 * 
	 * @param N/A
	 * @return N/A
	 * @throws CustomerDomainException
	 */
	public DatosContrato datosCliente(DatosContrato datosContrato) throws CustomerDomainException{
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null;
		try
		{
			cat.debug("Inicio:datosCliente");

			String call = getSQLDatosCliente("Ve_Alta_Cliente_Pg", "VE_datos_cliente_PR", 24);
			cat.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);
			cstmt.setLong(1, Long.parseLong(datosContrato.getNumVenta()));
			cat.debug("numVenta: "+ datosContrato.getNumVenta());
			cstmt.registerOutParameter(2, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(6, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(7, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(8, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(9, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(10, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(11, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(12, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(13, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(14, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(15, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(16, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(17, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(18, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(19, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(20, java.sql.Types.VARCHAR); //Tipo de Cliente
			cstmt.registerOutParameter(21, java.sql.Types.VARCHAR); //Tipo Identificacion Representante
			cstmt.registerOutParameter(22, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(23, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(24, java.sql.Types.NUMERIC);

			cat.debug("Inicio:datosCliente:execute");
			cstmt.execute();
			cat.debug("Fin:datosCliente:execute");

			codError = cstmt.getInt(22);
			msgError = cstmt.getString(23);
			numEvento = cstmt.getInt(24);
			
			cat.debug("Codigo de Error[" + codError + "]");
			cat.debug("Mensaje de Error[" + msgError + "]");
			cat.debug("Numero de Evento[" + numEvento + "]");

			if (codError != 0)
			{
				cat.error("Ocurrió un error al obtener datos del Cliente");
				throw new CustomerDomainException("Ocurrió un error al obtener datos del Cliente", String
						.valueOf(codError), numEvento, msgError);
			}				
			
			datosContrato.setNumIdent(cstmt.getString(2)!= null ? cstmt.getString(2):"");
			
			datosContrato.setNombreCliente(cstmt.getString(4)!= null ? cstmt.getString(4):"");			
			datosContrato.setApellidosCliente(cstmt.getString(5)!= null ? cstmt.getString(5):"");
			datosContrato.setDesDomicilio(cstmt.getString(6)!= null ? cstmt.getString(6):"");
			datosContrato.setDesProvincia(cstmt.getString(7)!= null ? cstmt.getString(7):"");
			datosContrato.setDesCanton(cstmt.getString(8)!= null ? cstmt.getString(8):"");
			datosContrato.setDesMail(cstmt.getString(9)!= null ? cstmt.getString(9):"");
			//P-CSR-11002 JLGN 16-06-2011
			datosContrato.setTipIdent(cstmt.getString(13)!= null ? cstmt.getString(13):"");
			//P-CSR-11002 JLGN 30-06-2011
			datosContrato.setNumCuentaCorriente(cstmt.getString(14)!= null ? cstmt.getString(14):"");
			datosContrato.setCodBanco(cstmt.getString(15)!= null ? cstmt.getString(15):"");
			datosContrato.setEntidad(cstmt.getString(16)!= null ? cstmt.getString(16):"");
			datosContrato.setNumTarjeta(cstmt.getString(17)!= null ? cstmt.getString(17):"");
			datosContrato.setTipTarjeta(cstmt.getString(18)!= null ? cstmt.getString(18):"");
			//Inicio P-CSR-11002 30-09-2011 JLGN
			//Se Valida si Cliente es Empresa o no
			if(cstmt.getString(20).trim().equals("1")){
				//Cliente es Empresa
				datosContrato.setTipCliEmpre("X");
				datosContrato.setTipCliParti("");
				datosContrato.setTipCliPyme("");
				datosContrato.setNomRepresentante(cstmt.getString(10)!= null ? cstmt.getString(10):"");
				datosContrato.setNumIdentRepresentante(cstmt.getString(11)!= null ? cstmt.getString(11):"");
				datosContrato.setTipIdentRepre(cstmt.getString(21)!= null ? cstmt.getString(21):"");
			//Se Valida si Cliente es Pyme	MA-184592 JLGN 15-05-2012
			}else if(cstmt.getString(20).trim().equals("4")){
				//Cliente es Pyme
				datosContrato.setTipCliEmpre("");
				datosContrato.setTipCliParti("");
				datosContrato.setTipCliPyme("X");
				datosContrato.setNomRepresentante(cstmt.getString(10)!= null ? cstmt.getString(10):"");
				datosContrato.setNumIdentRepresentante(cstmt.getString(11)!= null ? cstmt.getString(11):"");
				datosContrato.setTipIdentRepre(cstmt.getString(21)!= null ? cstmt.getString(21):"");				
			}
			else{
				//Categoria 74 = pyme	
				//MA-184592 JLGN 15-05-2012
				/*if(String.valueOf(cstmt.getLong(3)).equals("74")){
					datosContrato.setTipCliEmpre("");
					datosContrato.setTipCliParti("");
					datosContrato.setTipCliPyme("X");				
					datosContrato.setNomRepresentante(cstmt.getString(10)!= null ? cstmt.getString(10):"");
					datosContrato.setNumIdentRepresentante(cstmt.getString(11)!= null ? cstmt.getString(11):"");
					datosContrato.setTipIdentRepre(cstmt.getString(21)!= null ? cstmt.getString(21):"");
				}else{*/
					datosContrato.setTipCliEmpre("");
					datosContrato.setTipCliParti("X");
					datosContrato.setTipCliPyme("");
					datosContrato.setNomRepresentante("");
					datosContrato.setNumIdentRepresentante("");
					datosContrato.setTipIdentRepre("");
				//}				
			}						
			//Fin P-CSR-11002 30-09-2011 JLGN
			
			//Inicio P-CSR-11002 JLGN 05-08-2011
			//Envio de mensajes promocionales
			if(cstmt.getString(12).equals("S")){//Solo Movistar				
				datosContrato.setInfTerSI("");
				datosContrato.setInfTerNO("X");
				datosContrato.setMensPromSi("X");
				datosContrato.setMensPromNo("");			
			}else if (cstmt.getString(12).equals("N")){//Ninguno
				datosContrato.setInfTerSI("");
				datosContrato.setInfTerNO("X");
				datosContrato.setMensPromSi("");
				datosContrato.setMensPromNo("X");
			}else if (cstmt.getString(12).equals("A")){//Ambos
				datosContrato.setInfTerSI("X");
				datosContrato.setInfTerNO("");
				datosContrato.setMensPromSi("X");
				datosContrato.setMensPromNo("");		
			}else if (cstmt.getString(12).equals("T")){//Solo terceros
				datosContrato.setInfTerSI("X");
				datosContrato.setInfTerNO("");
				datosContrato.setMensPromSi("");
				datosContrato.setMensPromNo("X");		
			}//Fin P-CSR-11002 JLGN 05-08-2011
		}
		catch (Exception e)
		{
			cat.error("Ocurrió un error al obtener datos del Cliente", e);
			if (cat.isDebugEnabled())
			{
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
			if (e instanceof CustomerDomainException)
				throw (CustomerDomainException) e;
		}
		finally
		{
			if (cat.isDebugEnabled())
				cat.debug("Cerrando conexiones...");
			try
			{
				if (cstmt != null)
					cstmt.close();
				if (!conn.isClosed())
				{
					conn.close();
				}
			}
			catch (SQLException e)
			{
				cat.debug("SQLException", e);
			}
		}
		cat.debug("Fin:datosCliente()");
		return datosContrato;
	}// fin datosCliente
	
	/**
	 * Obtiene codigo de comuna
	 * 
	 * @param cliente
	 * @return N/A
	 * @throws CustomerDomainException
	 */
	public void getComunaDireccionBuro(DatosClienteBuroDTO buroDTO)throws CustomerDomainException{
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null;
		try
		{
			cat.debug("Inicio:getComunaDireccionBuro");

			String call = getSQLDatosCliente("VE_parametros_comerciales_PG", "ve_obtiene_comuna_pr", 7);
			cat.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);
			cstmt.setString(1, buroDTO.getCodProvincia());
			cstmt.setString(2, buroDTO.getCodCanton());
			cstmt.setString(3, buroDTO.getCodDistrito());
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(6, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(7, java.sql.Types.NUMERIC);

			cat.debug("Inicio:getComunaDireccionBuro:execute");
			cstmt.execute();
			cat.debug("Fin:getComunaDireccionBuro:execute");

			codError = cstmt.getInt(5);
			msgError = cstmt.getString(6);
			numEvento = cstmt.getInt(7);
			
			cat.debug("Codigo de Error[" + codError + "]");
			cat.debug("Mensaje de Error[" + msgError + "]");
			cat.debug("Numero de Evento[" + numEvento + "]");

			if (codError != 0)
			{
				cat.error("Ocurrió un error al obtener codigo de comuna");
				throw new CustomerDomainException("Ocurrió un error al obtener codigo de comuna", String
						.valueOf(codError), numEvento, msgError);
			}
			
			cat.debug("Se Obtiene codigo de la comuna");
			buroDTO.setCodComuna(cstmt.getString(4));			
			cat.debug("CodComuna: "+ buroDTO.getCodComuna());			
		}
		catch (Exception e)
		{
			cat.error("Ocurrió un error al obtener codigo de comuna", e);
			if (cat.isDebugEnabled())
			{
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
			if (e instanceof CustomerDomainException)
				throw (CustomerDomainException) e;
		}
		finally
		{
			if (cat.isDebugEnabled())
				cat.debug("Cerrando conexiones...");
			try
			{
				if (cstmt != null)
					cstmt.close();
				if (!conn.isClosed())
				{
					conn.close();
				}
			}
			catch (SQLException e)
			{
				cat.debug("SQLException", e);
			}
		}
		cat.debug("Fin:getComunaDireccionBuro()");
	}// fin getComunaDireccionBuro
	
	//Inicio P-CSR-11002 JLGN 17-06-2011
	/**
	 * Obtiene Datos Cliente
	 * 
	 * @param N/A
	 * @return N/A
	 * @throws CustomerDomainException
	 */
	public DatosContrato datosLinea(DatosContrato datosContrato) throws CustomerDomainException{
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null;
		ResultSet rs = null;
		try
		{
			cat.debug("Inicio:datosLinea");

			String call = getSQLDatosCliente("ve_parametros_comerciales_pg", "ve_celular_cliente_pr", 5);
			cat.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);
			cstmt.setLong(1, Long.parseLong(datosContrato.getNumVenta()));
			cat.debug("numVenta: "+ datosContrato.getNumVenta());			
			cstmt.registerOutParameter(2, OracleTypes.CURSOR);
			cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);

			cat.debug("Inicio:datosLinea:execute");
			cstmt.execute();
			cat.debug("Fin:datosLinea:execute");

			codError = cstmt.getInt(3);
			msgError = cstmt.getString(4);
			numEvento = cstmt.getInt(5);
			
			cat.debug("Codigo de Error[" + codError + "]");
			cat.debug("Mensaje de Error[" + msgError + "]");
			cat.debug("Numero de Evento[" + numEvento + "]");

			if (codError != 0)
			{
				cat.error("Ocurrio un error al obtener datos de la Linea");
				throw new CustomerDomainException("Ocurrio un error al obtener datos de la Linea", String
						.valueOf(codError), numEvento, msgError);
			}				
			
			
			cat.debug("Listado Lineas Venta");
			rs = (ResultSet) cstmt.getObject(2);
			ArrayList lista = new ArrayList();
			while (rs.next())
			{
				DatosLineaContratoDTO contratoDTO = new DatosLineaContratoDTO();
				
				contratoDTO.setNumCelular(rs.getString(1));
				contratoDTO.setNumAbonado(rs.getString(2));
				contratoDTO.setPlanTarif(rs.getString(3));
				contratoDTO.setTipRed(rs.getString(4));
				//Inicio P-CSR-11002 JLGN 25-10-2011
				contratoDTO.setLdiNO("");
				contratoDTO.setLdiSI("X");
				//Fin P-CSR-11002 JLGN 25-10-2011
				lista.add(contratoDTO);
			}
			datosContrato.setLineascontrato((DatosLineaContratoDTO[]) ArrayUtl.copiaArregloTipoEspecifico(lista.toArray(), DatosLineaContratoDTO.class));
		}
		catch (Exception e)
		{
			cat.error("Ocurrió un error al obtener datos de la Linea", e);
			if (cat.isDebugEnabled())
			{
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
			if (e instanceof CustomerDomainException)
				throw (CustomerDomainException) e;
		}
		finally
		{
			if (cat.isDebugEnabled())
				cat.debug("Cerrando conexiones...");
			try
			{
				if (cstmt != null)
					cstmt.close();
				if (!conn.isClosed())
				{
					conn.close();
				}
			}
			catch (SQLException e)
			{
				cat.debug("SQLException", e);
			}
		}
		cat.debug("Fin:datosCliente()");
		return datosContrato;
	}// fin datosCliente	
	
	//Inicio P-CSR-11002 JLGN 16-05-2011
	public long obtineLimConsuCliente(String numIdent, String tipIdent) throws VentasException, CustomerDomainException{
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null;
		long resultado = 0;
		try
		{
			cat.debug("Inicio:obtineLimConsuCliente");

			String call = getSQLDatosCliente("VE_parametros_comerciales_PG", "ve_sum_cargos_pt_pr", 6);
			cat.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);
			cstmt.setString(1, numIdent);
			cstmt.setString(2, tipIdent);
			cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(5, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(6, java.sql.Types.NUMERIC);

			cat.debug("Inicio:obtineLimConsuCliente:execute");
			cstmt.execute();
			cat.debug("Fin:obtineLimConsuCliente:execute");

			codError = cstmt.getInt(4);
			msgError = cstmt.getString(5);
			numEvento = cstmt.getInt(6);
			
			cat.debug("Codigo de Error[" + codError + "]");
			cat.debug("Mensaje de Error[" + msgError + "]");
			cat.debug("Numero de Evento[" + numEvento + "]");

			if (codError != 0)
			{
				cat.error("Ocurrió un error al obtener suma de limite de consumo");
				throw new CustomerDomainException("Ocurrió un error al obtener suma de limite de consumo", String
						.valueOf(codError), numEvento, msgError);
			}
			
			cat.debug("Se Obtiene Suma de Cargos Basicos de los PT");
			cat.debug("Cargos: "+ cstmt.getLong(3));
			resultado = cstmt.getLong(3);						
		}
		catch (Exception e)
		{
			cat.error("Ocurrió un error al obtener suma de limite de consumo", e);
			if (cat.isDebugEnabled())
			{
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
			if (e instanceof CustomerDomainException)
				throw (CustomerDomainException) e;
		}
		finally
		{
			if (cat.isDebugEnabled())
				cat.debug("Cerrando conexiones...");
			try
			{
				if (cstmt != null)
					cstmt.close();
				if (!conn.isClosed())
				{
					conn.close();
				}
			}
			catch (SQLException e)
			{
				cat.debug("SQLException", e);
			}
		}
		cat.debug("Fin:obtineLimConsuCliente()");
		return resultado;
	}// fin obtineLimConsuCliente	
	//Fin P-CSR-11002 JLGN 16-05-2011
	
	//Inicio P-CSR-11002 JLGN 04-08-2011
	public String obtieneMensajeError(String tipIdent, String codMensaje) throws VentasException, CustomerDomainException{
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null;
		String resultado = "";
		try
		{
			cat.debug("Inicio:obtieneMensajeError");

			String call = getSQLDatosCliente("VE_parametros_comerciales_PG", "VE_MENSAJE_ERROR_PR", 8);
			cat.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);
			cstmt.setString(1, "VE");
			cstmt.setString(2, "PORTAL_VENTAS");
			cstmt.setString(3, tipIdent.trim());
			cstmt.setString(4, codMensaje.trim());
			cstmt.registerOutParameter(5, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(6, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(7, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(8, java.sql.Types.NUMERIC);

			cat.debug("Inicio:obtieneMensajeError:execute");
			cstmt.execute();
			cat.debug("Fin:obtieneMensajeError:execute");

			codError = cstmt.getInt(6);
			msgError = cstmt.getString(7);
			numEvento = cstmt.getInt(8);
			
			cat.debug("Codigo de Error[" + codError + "]");
			cat.debug("Mensaje de Error[" + msgError + "]");
			cat.debug("Numero de Evento[" + numEvento + "]");

			if (codError != 0)
			{
				cat.error("Ocurrió un error al obtener Mensaje de Error");
				throw new CustomerDomainException("Ocurrió un error al obtener Mensaje de Error", String
						.valueOf(codError), numEvento, msgError);
			}
			
			cat.debug("Se Obtiene Mensaje de Error");
			resultado = cstmt.getString(5);						
		}
		catch (Exception e)
		{
			cat.error("Ocurrió un error al obtener Mensaje de Error", e);
			if (cat.isDebugEnabled())
			{
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
			if (e instanceof CustomerDomainException)
				throw (CustomerDomainException) e;
		}
		finally
		{
			if (cat.isDebugEnabled())
				cat.debug("Cerrando conexiones...");
			try
			{
				if (cstmt != null)
					cstmt.close();
				if (!conn.isClosed())
				{
					conn.close();
				}
			}
			catch (SQLException e)
			{
				cat.debug("SQLException", e);
			}
		}
		cat.debug("Fin:obtieneMensajeError()");
		return resultado;
	}// fin obtieneMensajeError	
	//Fin P-CSR-11002 JLGN 04-08-2011
	
	//Inicio P-CSR-11002 JLGN 05-08-2011
	public MensajePromocionalDTO[] getMensajePromocional() throws CustomerDomainException
	{
		cat.debug("getMensajePromocional:start");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		MensajePromocionalDTO[] resultado = null;
		Connection conn = null;
		CallableStatement cstmt = null;
		conn = getConection();
		ResultSet rs = null;
		cat.debug("Coneccion obtenida OK");
		try
		{
			String call = getSQLDatosCliente("VE_alta_cliente_PG", "VE_mens_promo_PR", 4);
			cat.debug("sql[" + call + "]");
			cstmt = conn.prepareCall(call);
			cstmt.registerOutParameter(1, OracleTypes.CURSOR);
			cstmt.registerOutParameter(2, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);
			
			cat.debug("Execute Antes");
			cstmt.execute();
			cat.debug("Execute Despues");
			
			codError = cstmt.getInt(2);
			cat.debug("codError[" + codError + "]");
			msgError = cstmt.getString(3);
			cat.debug("msgError[" + msgError + "]");
			numEvento = cstmt.getInt(4);
			cat.debug("numEvento[" + numEvento + "]");
			if (codError != 0)
			{
				cat.error("Ocurrió un error al consultar Mensaje Promocional");
				throw new CustomerDomainException("Ocurrió un error al consultar Mensaje Promocional", String
						.valueOf(codError), numEvento, msgError);	
			}
			else
			{
				cat.debug("Listado Mensajes");
				rs = (ResultSet) cstmt.getObject(1);
				ArrayList lista = new ArrayList();
				while (rs.next())
				{
					MensajePromocionalDTO mensajePromocional = new MensajePromocionalDTO();
					mensajePromocional.setCodMensaje(rs.getString(1));
					mensajePromocional.setDesMensaje(rs.getString(2));
					lista.add(mensajePromocional);
				}
				resultado = (MensajePromocionalDTO[]) ArrayUtl.copiaArregloTipoEspecifico(lista.toArray(), MensajePromocionalDTO.class);
				;
			}
			if (cat.isDebugEnabled())
			{
				cat.debug(" Finalizo ejecución");
			}
		}
		catch (Exception e)
		{
			cat.error("Ocurrió un error al consultar Mensaje Promocional", e);
			if (cat.isDebugEnabled())
			{
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
			if (e instanceof CustomerDomainException)
			{
				throw (CustomerDomainException) e;
			}
			else
			{
				CustomerDomainException c = new CustomerDomainException();
				c.setMessage(e.getMessage());
				throw c;
			}
		}
		finally
		{
			if (cat.isDebugEnabled())
				cat.debug("Cerrando conexiones...");
			try
			{
				if (rs != null)
					rs.close();
				if (cstmt != null)
					cstmt.close();
				if (!conn.isClosed())
				{
					conn.close();
				}
			}
			catch (SQLException e)
			{
				cat.debug("SQLException", e);
			}
		}
		cat.debug("getMensajePromocional():end");
		return resultado;
	}
	//Fin P-CSR-11002 JLGN 05-08-2011
	
	//Inicio P-CSR-11002 JLGN 20-10-2011
	/**
	 * Obtiene Limite de Consummo por linea
	 * 
	 * @param N/A
	 * @return N/A
	 * @throws CustomerDomainException
	 */
	public DatosContrato limiteConsumoXLinea(DatosContrato datosContrato) throws CustomerDomainException{
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null;
		try
		{
			cat.debug("Inicio:limiteConsumoXLinea");
			String call = getSQLDatosCliente("ve_parametros_comerciales_pg", "ve_limite_consumo_linea_pr", 5);
			cat.debug("sql[" + call + "]");
			cstmt = conn.prepareCall(call);
			
			for(int i=0; i < datosContrato.getLineascontrato().length; i++){
				//PARAMETROS DE ENTRADA
				cstmt.setLong(1, Long.parseLong(datosContrato.getLineascontrato()[i].getNumAbonado()));
				cat.debug("numAbonado: "+ datosContrato.getLineascontrato()[i].getNumAbonado());			
				cstmt.registerOutParameter(2, java.sql.Types.VARCHAR);
				cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
				cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
				cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);

				cat.debug("Inicio:limiteConsumoXLinea:execute");
				cstmt.execute();
				cat.debug("Fin:limiteConsumoXLinea:execute");

				codError = cstmt.getInt(3);
				msgError = cstmt.getString(4);
				numEvento = cstmt.getInt(5);
				
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");

				if (codError != 0)
				{
					cat.error("Ocurrio un error al obtener limite de consumo de la Linea");
					throw new CustomerDomainException("Ocurrio un error al obtener limite de consumo de la Linea", String
							.valueOf(codError), numEvento, msgError);
				}else{
					datosContrato.getLineascontrato()[i].setLimiteConsumoLinea("¢ "+cstmt.getString(2));					
				}	
			}			
		}
		catch (Exception e)
		{
			cat.error("Ocurrio un error al obtener limite de consumo de la Linea", e);
			if (cat.isDebugEnabled())
			{
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
			if (e instanceof CustomerDomainException)
				throw (CustomerDomainException) e;
		}
		finally
		{
			if (cat.isDebugEnabled())
				cat.debug("Cerrando conexiones...");
			try
			{
				if (cstmt != null)
					cstmt.close();
				if (!conn.isClosed())
				{
					conn.close();
				}
			}
			catch (SQLException e)
			{
				cat.debug("SQLException", e);
			}
		}
		cat.debug("Fin:limiteConsumoXLinea()");
		return datosContrato;
	}
	//Fin P-CSR-11002 JLGN 20-10-2011
	
	//Inicio Inc.179734 01-01-2012 JLGN
	public boolean validaMensajeError(String tipIdent, String codMensaje) throws VentasException, CustomerDomainException{
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null;
		boolean resultado = false;
		int contador = 0;
		try
		{
			cat.debug("Inicio:validaMensajeError");

			String call = getSQLDatosCliente("VE_parametros_comerciales_PG", "ve_valida_error_pr", 8);
			cat.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);
			cstmt.setString(1, "VE");
			cstmt.setString(2, "MENS_DDA");
			cstmt.setString(3, tipIdent.trim());
			cstmt.setString(4, codMensaje.trim());
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(6, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(7, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(8, java.sql.Types.NUMERIC);

			cat.debug("Inicio:validaMensajeError:execute");
			cstmt.execute();
			cat.debug("Fin:validaMensajeError:execute");

			codError = cstmt.getInt(6);
			msgError = cstmt.getString(7);
			numEvento = cstmt.getInt(8);
			
			cat.debug("Codigo de Error[" + codError + "]");
			cat.debug("Mensaje de Error[" + msgError + "]");
			cat.debug("Numero de Evento[" + numEvento + "]");

			if (codError != 0)
			{
				cat.error("Ocurrió un error al obtener Mensaje de Error");
				throw new CustomerDomainException("Ocurrió un error al obtener Mensaje de Error", String
						.valueOf(codError), numEvento, msgError);
			}
			
			cat.debug("Se Valida si mensaje esta configurado Mensaje de Error");
			
			contador = cstmt.getInt(5);
			
			if (contador > 0){
				cat.debug("Codigo Mensaje se encuentra configurado");
				resultado = false;
			}else{
				cat.debug("Codigo Mensaje no se encuentra configurado");
				resultado = true;
			}
		}
		catch (Exception e)
		{
			cat.error("Ocurrió un error al obtener Mensaje de Error", e);
			if (cat.isDebugEnabled())
			{
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
			if (e instanceof CustomerDomainException)
				throw (CustomerDomainException) e;
		}
		finally
		{
			if (cat.isDebugEnabled())
				cat.debug("Cerrando conexiones...");
			try
			{
				if (cstmt != null)
					cstmt.close();
				if (!conn.isClosed())
				{
					conn.close();
				}
			}
			catch (SQLException e)
			{
				cat.debug("SQLException", e);
			}
		}
		cat.debug("Fin:validaMensajeError()");
		return resultado;
	}// fin validaMensajeError	
	//Inicio Inc.179734 01-01-2012 JLGN
	
	//Inicio Inc.179734 JLGN 04-01-2012
	public boolean validaClienteDDA(String codCliente) throws VentasException, CustomerDomainException{
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null;
		boolean resultado = false;
		int respuesta = 0;
		try
		{
			cat.debug("Inicio:validaClienteDDA");

			String call = getSQLDatosCliente("VE_parametros_comerciales_PG", "ve_valida_cliente_dda_pr", 5);
			cat.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);
			cat.debug("Codigo cliente: "+codCliente);
			cstmt.setInt(1, Integer.parseInt(codCliente));
			cstmt.registerOutParameter(2, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);

			cat.debug("Inicio:validaClienteDDA:execute");
			cstmt.execute();
			cat.debug("Fin:validaClienteDDA:execute");

			codError = cstmt.getInt(3);
			msgError = cstmt.getString(4);
			numEvento = cstmt.getInt(5);
			
			cat.debug("Codigo de Error[" + codError + "]");
			cat.debug("Mensaje de Error[" + msgError + "]");
			cat.debug("Numero de Evento[" + numEvento + "]");

			if (codError != 0)
			{
				cat.error("Ocurrió un error al validar forma de pago del cliente");
				throw new CustomerDomainException("Ocurrió un error al validar forma de pago del cliente", String
						.valueOf(codError), numEvento, msgError);
			}
			
			cat.debug("Se Valida si el cliente tiene la forma de pago correcta");
			
			respuesta = cstmt.getInt(2);
			
			if (respuesta == 0){
				cat.debug("Cliente no tiene forma de pago correcta");
				resultado = false;
			}else{
				cat.debug("Cliente si tiene forma de pago correcta");
				resultado = true;
			}
		}
		catch (Exception e)
		{
			cat.error("Ocurrió un error al validar forma de pago del cliente", e);
			if (cat.isDebugEnabled())
			{
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
			if (e instanceof CustomerDomainException)
				throw (CustomerDomainException) e;
		}
		finally
		{
			if (cat.isDebugEnabled())
				cat.debug("Cerrando conexiones...");
			try
			{
				if (cstmt != null)
					cstmt.close();
				if (!conn.isClosed())
				{
					conn.close();
				}
			}
			catch (SQLException e)
			{
				cat.debug("SQLException", e);
			}
		}
		cat.debug("Fin:validaClienteDDA()");
		return resultado;
	}// fin validaClienteDDA
	//Fin Inc.179734 JLGN 04-01-2012
	
	//Inicio Inc.179734 JLGN 05-01-2012
	public boolean validaLineasClienteDDA(String tipIdent, String numIdent) throws VentasException, CustomerDomainException{
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null;
		boolean resultado = false;
		int respuesta = 0;
		try
		{
			cat.debug("Inicio:validaLineasClienteDDA");

			String call = getSQLDatosCliente("VE_parametros_comerciales_PG", "ve_lineas_activas_dda_pr", 6);
			cat.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);
			cat.debug("tipo Identificacion: "+tipIdent);
			cstmt.setString(1, tipIdent);
			cat.debug("Numero Identificacion: "+numIdent);
			cstmt.setString(2, numIdent);
			cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(5, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(6, java.sql.Types.NUMERIC);

			cat.debug("Inicio:validaLineasClienteDDA:execute");
			cstmt.execute();
			cat.debug("Fin:validaLineasClienteDDA:execute");

			codError = cstmt.getInt(4);
			msgError = cstmt.getString(5);
			numEvento = cstmt.getInt(6);
			
			cat.debug("Codigo de Error[" + codError + "]");
			cat.debug("Mensaje de Error[" + msgError + "]");
			cat.debug("Numero de Evento[" + numEvento + "]");

			if (codError != 0)
			{
				cat.error("Ocurrió un error al consultar cantidad de lineas activas del cliente");
				throw new CustomerDomainException("Ocurrió un error al consultar cantidad de lineas activas del cliente", String
						.valueOf(codError), numEvento, msgError);
			}
			
			cat.debug("Se consulta cuantas lineas activas tiene el cliente");			
			respuesta = cstmt.getInt(3);
			cat.debug("Nº de lineas activas: "+ respuesta);
			
			DatosGeneralesDAO datosGeneralesDAO  = new DatosGeneralesDAO();
	    	DatosGeneralesDTO datosGenerales = new DatosGeneralesDTO();
	    	datosGenerales.setCodigoModulo("VE");
	    	datosGenerales.setCodigoProducto("1");
	    	datosGenerales.setCodigoParametro("CANTIDAD_LINEAS_DDA");
	    	datosGenerales = datosGeneralesDAO.getValorParametro(datosGenerales);
			
			if (respuesta >= Integer.parseInt(datosGenerales.getValorParametro())){
				cat.debug("Cliente tiene "+ datosGenerales.getValorParametro() +" o mas lineas activas");
				resultado = false;
			}else{
				cat.debug("Cliente tiene menos de "+ datosGenerales.getValorParametro() +" lineas activas");
				resultado = true;
			}
		}
		catch (Exception e)
		{
			cat.error("Ocurrió un error al consultar cantidad de lineas activas del cliente", e);
			if (cat.isDebugEnabled())
			{
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
			if (e instanceof CustomerDomainException)
				throw (CustomerDomainException) e;
		}
		finally
		{
			if (cat.isDebugEnabled())
				cat.debug("Cerrando conexiones...");
			try
			{
				if (cstmt != null)
					cstmt.close();
				if (!conn.isClosed())
				{
					conn.close();
				}
			}
			catch (SQLException e)
			{
				cat.debug("SQLException", e);
			}
		}
		cat.debug("Fin:validaLineasClienteDDA()");
		return resultado;
	}// fin validaLineasClienteDDA
	//Fin Inc.179734 JLGN 05-01-2012
	
//	Inicio MA-180654 HOM
	public AbonadoDTO[] getAbonadosActvos(String tipIdent, String numIdent) throws VentasException, CustomerDomainException{
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null;
		ResultSet rs = null;
		AbonadoDTO[] resultado=null;
		try
		{
			cat.debug("Inicio:getAbonadosActvos");

			String call = getSQLDatosCliente("Ve_Servicios_solicitud_Pg", "VE_GET_ABONADOS_ACTIVOS_PR", 6);
			cat.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);
			cat.debug("Numero Identificacion: "+numIdent);
			cstmt.setString(1, numIdent);
			cat.debug("tipo Identificacion: "+tipIdent);
			cstmt.setString(2, tipIdent);
			cstmt.registerOutParameter(3, OracleTypes.CURSOR);
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(5, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(6, java.sql.Types.NUMERIC);

			cat.debug("Inicio:getAbonadosActvos:execute");
			cstmt.execute();
			cat.debug("Fin:getAbonadosActvos:execute");

			codError = cstmt.getInt(4);
			msgError = cstmt.getString(5);
			numEvento = cstmt.getInt(6);
			
			cat.debug("Codigo de Error[" + codError + "]");
			cat.debug("Mensaje de Error[" + msgError + "]");
			cat.debug("Numero de Evento[" + numEvento + "]");

			if (codError != 0)
			{
				cat.error("Ocurrió un error al consultar los abonados activos del cliente");
				throw new CustomerDomainException("Ocurrió un error al consultar los abonados activos del cliente", String
						.valueOf(codError), numEvento, msgError);
			}
			
			rs = (ResultSet) cstmt.getObject(3);
			ArrayList lista = new ArrayList();
			while(rs.next()){
				AbonadoDTO abonadoDTO = new AbonadoDTO();
				abonadoDTO.setCodCliente(rs.getLong(1));
				abonadoDTO.setNumCelular(rs.getLong(2));
				abonadoDTO.setFecAlta(rs.getString(3));
				abonadoDTO.setDesSituacion(rs.getString(4));
				abonadoDTO.setStrEstadoVenta(rs.getString(5));		
				lista.add(abonadoDTO);
			}
			
			resultado = (AbonadoDTO[]) ArrayUtl.copiaArregloTipoEspecifico(lista.toArray(), AbonadoDTO.class);
			
			
		}
		catch (Exception e)
		{
			cat.error("Ocurrió un error al consultar los abonados activos del cliente", e);
			if (cat.isDebugEnabled())
			{
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
			if (e instanceof CustomerDomainException)
				throw (CustomerDomainException) e;
		}
		finally
		{
			if (cat.isDebugEnabled())
				cat.debug("Cerrando conexiones...");
			try
			{
				if (cstmt != null)
					cstmt.close();
				if (!conn.isClosed())
				{
					conn.close();
				}
			}
			catch (SQLException e)
			{
				cat.debug("SQLException", e);
			}
		}
		cat.debug("Fin:getAbonadosActvos()");
		return resultado;
	}// fin getAbonadosActvos
	
	public DatosAnexoTerminalesDTO getDatosAnexoTerminales(Long numVenta) throws VentasException, CustomerDomainException{
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null;
		ResultSet rs = null;
		DatosAnexoTerminalesDTO resultado = null;
		try
		{
			cat.debug("Inicio:getDatosAnexoTerminales");

			String call = getSQLDatosCliente("Ve_Servicios_solicitud_Pg", "VE_DATOS_ANEXOTERMINALES_PR", 8);
			cat.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);
			cat.debug("numVenta: "+numVenta.intValue());
			cstmt.setLong(1, numVenta.longValue());

			cstmt.registerOutParameter(2, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, OracleTypes.CURSOR);
			cstmt.registerOutParameter(6, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(7, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(8, java.sql.Types.NUMERIC);

			cat.debug("Inicio:getDatosAnexoTerminales:execute");
			cstmt.execute();
			cat.debug("Fin:getDatosAnexoTerminales:execute");

			codError = cstmt.getInt(6);
			msgError = cstmt.getString(7);
			numEvento = cstmt.getInt(8);
			
			cat.debug("Codigo de Error[" + codError + "]");
			cat.debug("Mensaje de Error[" + msgError + "]");
			cat.debug("Numero de Evento[" + numEvento + "]");

			if (codError != 0)
			{
				cat.error("Ocurrió un error los datos de Anexos de Terminales");
				throw new CustomerDomainException("Ocurrió un error los datos de Anexos de Terminales", String
						.valueOf(codError), numEvento, msgError);
			}
			
			resultado = new DatosAnexoTerminalesDTO();
			resultado.setNomCliente(cstmt.getString(2));
			resultado.setTipIdent(cstmt.getString(3));
			resultado.setNumIdent(cstmt.getString(4));
			
			rs = (ResultSet) cstmt.getObject(5);
			ArrayList lista = new ArrayList();
			while(rs.next()){
				AnexoTerminalDTO anexoTerminalDTO= new AnexoTerminalDTO();
				anexoTerminalDTO.setDesEquipo(rs.getString(1));
				anexoTerminalDTO.setNumSerie(rs.getString(2));
				anexoTerminalDTO.setDesPlan(rs.getString(3));
				anexoTerminalDTO.setPrcVenta(rs.getString(4));
				anexoTerminalDTO.setFormaPago(rs.getString(5));
				anexoTerminalDTO.setPeriodoContrato(rs.getString(6));
				anexoTerminalDTO.setMarca(rs.getString(7));
				anexoTerminalDTO.setModelo(rs.getString(8));
				anexoTerminalDTO.setPrecioPrepago(rs.getString(9));
				anexoTerminalDTO.setOficina(rs.getString(10));
				//JLGN
				cat.debug("Penalidad[" + rs.getString(11) + "]");
				anexoTerminalDTO.setPenalidad(rs.getString(11));
				lista.add(anexoTerminalDTO);
			}
			
			AnexoTerminalDTO[] anexoTerminalDTOs = (AnexoTerminalDTO[]) ArrayUtl.copiaArregloTipoEspecifico(lista.toArray(), AnexoTerminalDTO.class);
			
			resultado.setAnexoTerminalDTOs(anexoTerminalDTOs);
			
			
		}
		catch (Exception e)
		{
			cat.error("Ocurrió un error los datos de Anexos de Terminales", e);
			if (cat.isDebugEnabled())
			{
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
			if (e instanceof CustomerDomainException)
				throw (CustomerDomainException) e;
		}
		finally
		{
			if (cat.isDebugEnabled())
				cat.debug("Cerrando conexiones...");
			try
			{
				if (cstmt != null)
					cstmt.close();
				if (!conn.isClosed())
				{
					conn.close();
				}
			}
			catch (SQLException e)
			{
				cat.debug("SQLException", e);
			}
		}
		cat.debug("Fin:getDatosAnexoTerminales()");
		return resultado;
	}// fin getDatosAnexoTerminales
//	Fin MA-180654 HOM
	
}// fin class ClienteDAO
