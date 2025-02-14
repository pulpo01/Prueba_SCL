/**
 * Fecha ------------------- Autor  ------------------------- Cambios ----------
 * 30/05/2007	     	Elizabeth Vera        				Versión Inicial
 * 18/07/2007           Raúl Lozano                     se agrega metodo getCliente 
 */
package com.tmmas.scl.framework.customerDomain.businessObject.dao;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.SQLException;

import org.apache.log4j.Logger;

import com.tmmas.cl.framework.base.ConnectionDAO;
import com.tmmas.cl.framework.util.StackTraceUtl;
import com.tmmas.scl.framework.customerDomain.businessObject.dao.interfaces.ClienteDAOIT;
import com.tmmas.scl.framework.customerDomain.businessObject.helper.Global;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ClienteDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.DireccionNegocioDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.itermediario.ClienteDTOInt;
import com.tmmas.scl.framework.customerDomain.exception.CustomerException;

public class ClienteDAO extends ConnectionDAO implements ClienteDAOIT {

	private final Logger logger = Logger.getLogger(ClienteDAO.class);

	private final Global global = Global.getInstance();
	
	private String getSQLobtenerDatosCliente() {
		StringBuffer call = new StringBuffer();
		
		call.append(" DECLARE ");
		call.append("   so_cliente PV_CLIENTE_QT := PV_INICIA_ESTRUCTURAS_PG.PV_INICIA_PV_CLIENTE_QT_FN;");
		call.append(" BEGIN ");
		call.append("   so_cliente.COD_CLIENTE := ?;");
		call.append("   PV_DATOS_CLIENTES_PG.PV_OBTIENE_DATOS_CLIENTE_PR( so_cliente, ?, ?, ?);");
		call.append("		? := so_cliente.NOM_CLIENTE;");
		call.append("		? := so_cliente.COD_PLANTARIF;");
		call.append("		? := so_cliente.DES_PLANTARIF;");
		call.append("		? := so_cliente.TIP_TERMINAL;");
		call.append("		? := so_cliente.DES_TERMINAL;");
		call.append("		? := so_cliente.TIP_PLANTARIF;");
		call.append("		? := so_cliente.DES_TIPPLANTARIF;");
		call.append("		? := so_cliente.COD_CARGOBASICO;");
		call.append("		? := so_cliente.DES_CARGOBASICO;");
		call.append("		? := so_cliente.COD_TIPLAN;");
		call.append("		? := so_cliente.DES_TIPLAN;");
		call.append("		? := so_cliente.COD_CICLO;");
		call.append("		? := so_cliente.COD_CUENTA;");
		call.append("		? := so_cliente.DES_CUENTA;");
		call.append("		? := so_cliente.COD_SUBCUENTA;");
		call.append("		? := so_cliente.DES_SUBCUENTA;");
		call.append("		? := so_cliente.COD_LIMCONSUMO;");
		call.append("		? := so_cliente.DES_LIMCONSUMO;");
		call.append("		? := so_cliente.NUM_ABONADOS;");
		call.append("		? := so_cliente.IMP_CARGOBASICO;");
		call.append("		? := so_cliente.COD_TIPIDENT ;");	
		call.append("		? := so_cliente.NUM_IDENT;");
		call.append("		? := so_cliente.IND_FAMILIAR;");	
		call.append("		? := so_cliente.COD_PROD_PADRE;");	
		call.append("		? := so_cliente.TIP_CUENTA;");	
		call.append("		? := so_cliente.FLG_RANGO;");
		call.append("		? := so_cliente.COD_EMPRESA;");	
		call.append("		? := so_cliente.IND_PRIMERAVENTA;");
		call.append(" END;");
		
		return call.toString();		
	}
	
	private String getSQLobtenerCategoriaTributaria() {
		StringBuffer call = new StringBuffer();
		
		call.append(" DECLARE ");
		call.append("   so_cliente PV_CLIENTE_QT := PV_INICIA_ESTRUCTURAS_PG.PV_INICIA_PV_CLIENTE_QT_FN;");
		call.append(" BEGIN ");
		call.append("   so_cliente.COD_CLIENTE := ?;");
		call.append("   PV_DATOS_CLIENTES_PG.PV_OBTENER_CATEG_CLIENTE_PR( so_cliente, ?, ?, ?);");
		call.append("		? := so_cliente.COD_CATEGORIA;");
		call.append(" END;");
		
		return call.toString();		
	}
	
	private String getSQLDatosCliente(String packageName, String procedureName, int paramCount)
	{
		StringBuffer sb = new StringBuffer("{call "+packageName+"."+procedureName+"(");
        for (int n = 1; n <= paramCount; n++) {
            sb.append("?");
            if (n < paramCount) sb.append(",");
        }
        return sb.append(")}").toString();
	
	}
	
	/**
	 * Recupera la informacion del cliente
	 * 
	 * @param cliente
	 * @return clienteDTO
	 * @throws CustomerException
	 */
	public ClienteDTO obtenerDatosCliente(ClienteDTO cliente)
	throws CustomerException {

		logger.debug("obtenerDatosCliente():start");
		
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		ClienteDTO respuesta = null;		
		Connection conn = null;
		CallableStatement cstmt = null;
		
		String call = getSQLobtenerDatosCliente();
		try {
		
			logger.debug("cliente.getCodCliente()[" + cliente.getCodCliente() + "]");
			
			conn = getConnectionFromWLSInitialContext(global.getJndiForDataSource());
			
			cstmt = conn.prepareCall(call);
			
			cstmt.setLong(1, cliente.getCodCliente());
			
			cstmt.registerOutParameter(2, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);
			
			
			cstmt.registerOutParameter(5, java.sql.Types.VARCHAR); //NOM_CLIENTE
			cstmt.registerOutParameter(6, java.sql.Types.VARCHAR); //COD_PLANTARIF
			cstmt.registerOutParameter(7, java.sql.Types.VARCHAR); //DES_PLANTARIF
			cstmt.registerOutParameter(8, java.sql.Types.VARCHAR); //TIP_TERMINAL
			cstmt.registerOutParameter(9, java.sql.Types.VARCHAR); //DES_TERMINAL		
			cstmt.registerOutParameter(10, java.sql.Types.VARCHAR); //TIP_PLANTARIF
			cstmt.registerOutParameter(11, java.sql.Types.VARCHAR);	//DES_TIPPLANTARIF		
			cstmt.registerOutParameter(12, java.sql.Types.VARCHAR); //COD_CARGOBASICO
			cstmt.registerOutParameter(13, java.sql.Types.VARCHAR);	//DES_CARGOBASICO		
			cstmt.registerOutParameter(14, java.sql.Types.VARCHAR);	//COD_TIPLAN		
			cstmt.registerOutParameter(15, java.sql.Types.VARCHAR); //DES_TIPLAN
			cstmt.registerOutParameter(16, java.sql.Types.NUMERIC);	//COD_CICLO		
			cstmt.registerOutParameter(17, java.sql.Types.NUMERIC);	//COD_CUENTA		
			cstmt.registerOutParameter(18, java.sql.Types.VARCHAR);	//DES_CUENTA		
			cstmt.registerOutParameter(19, java.sql.Types.VARCHAR);	//COD_SUBCUENTA		
			cstmt.registerOutParameter(20, java.sql.Types.VARCHAR); //DES_SUBCUENTA
			cstmt.registerOutParameter(21, java.sql.Types.VARCHAR);	//COD_LIMCONSUMO
			cstmt.registerOutParameter(22, java.sql.Types.VARCHAR); //DES_LIMCONSUMO
			cstmt.registerOutParameter(23, java.sql.Types.NUMERIC); //NUM_ABONADOS
			cstmt.registerOutParameter(24, java.sql.Types.NUMERIC); //IMP_CARGOBASICO
			cstmt.registerOutParameter(25, java.sql.Types.VARCHAR); //COD_TIPIDENT
			cstmt.registerOutParameter(26, java.sql.Types.VARCHAR); //NUM_IDENT
			cstmt.registerOutParameter(27, java.sql.Types.NUMERIC); //IND_FAMILIAR
			cstmt.registerOutParameter(28, java.sql.Types.NUMERIC); //COD_PROD_PADRE
			cstmt.registerOutParameter(29, java.sql.Types.VARCHAR); //TIP_CUENTA
			cstmt.registerOutParameter(30, java.sql.Types.NUMERIC); //FLG_RANGO
			cstmt.registerOutParameter(31, java.sql.Types.NUMERIC); //COD_EMPRESA
			cstmt.registerOutParameter(32, java.sql.Types.VARCHAR); //IND_PRIMERAVENTA
			
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
				logger.error(" Ocurrió un error al recuperar los datos del cliente");
				throw new CustomerException(String.valueOf(codError),numEvento, msgError);
			}
			
			//obtener info del cliente y completar respuesta
			logger.debug("Recuperando data...");
			
			String nomCliente = cstmt.getString(5);
			logger.debug("nomCliente[" + nomCliente + "]");
			
			String codPlanTarif = cstmt.getString(6);
			logger.debug("codPlanTarif[" + codPlanTarif + "]");
			
			String desPlanTarif = cstmt.getString(7);
			logger.debug("desPlanTarif[" + desPlanTarif + "]");			
			
			String tipTerminal = cstmt.getString(8);
			logger.debug("tipTerminal[" + tipTerminal + "]");	

			String desTerminal = cstmt.getString(9);
			logger.debug("desTerminal[" + desTerminal + "]");

			String tipPlanTarif = cstmt.getString(10);
			logger.debug("tipPlanTarif[" + tipPlanTarif + "]");	
			
			String desTipPlanTarif = cstmt.getString(11);
			logger.debug("desTipPlanTarif[" + desTipPlanTarif + "]");

			String codCargoBasico = cstmt.getString(12);
			logger.debug("codCargoBasico[" + codCargoBasico + "]");

			String desCargoBasico = cstmt.getString(13);
			logger.debug("desCargoBasico[" + desCargoBasico + "]");			
			
			String codTipPlan = cstmt.getString(14);
			logger.debug("codTipPlan[" + codTipPlan + "]");			

			String desTipPlan = cstmt.getString(15);
			logger.debug("desTipPlan[" + desTipPlan + "]");				
			
			int codCiclo = cstmt.getInt(16);
			logger.debug("codCiclo[" + codCiclo + "]");				

			long codCuenta = cstmt.getInt(17);
			logger.debug("codCuenta[" + codCuenta + "]");				
			
			String desCuenta= cstmt.getString(18);
			logger.debug("desCuenta[" + desCuenta + "]");				
			
			String codSubCuenta= cstmt.getString(19);
			logger.debug("codSubCuenta[" + codSubCuenta + "]");				
		
			String desSubCuenta= cstmt.getString(20);
			logger.debug("desSubCuenta[" + desSubCuenta + "]");				

			String codLimiteConsumo= cstmt.getString(21);
			logger.debug("codLimiteConsumo[" + codLimiteConsumo + "]");		
			
			String desLimiteConsumo= cstmt.getString(22);
			logger.debug("desLimiteConsumo[" + desLimiteConsumo + "]");		
			
			int numAbonados= cstmt.getInt(23);
			logger.debug("numAbonados[" + numAbonados + "]");	
			
			float impCargoBasico= cstmt.getFloat(24);
			logger.debug("impCargoBasico[" + impCargoBasico + "]");	
			
			String codTipIdent= cstmt.getString(25);
			logger.debug("codTipIdent[" + codTipIdent + "]");	

			String numIdent= cstmt.getString(26);
			logger.debug("numIdent[" + numIdent + "]");	
			
			int indFamiliar = cstmt.getInt(27);
			logger.debug("indFamiliar[" + indFamiliar + "]");
			
			long codProdPadre = cstmt.getLong(28);
			logger.debug("codProdPadre[" + codProdPadre + "]");
			
			String tipCuenta = cstmt.getString(29);
			logger.debug("tipCuenta[" + tipCuenta + "]");
			
			int flgRango = cstmt.getInt(30);
			logger.debug("flgRango[" + flgRango + "]");		
			
			long codEmpresa = cstmt.getInt(31);
			logger.debug("codEmpresa[" + codEmpresa + "]");		
			
			String primeraVenta=cstmt.getString(32)!=null?cstmt.getString(32):"";
			logger.debug("primeraVenta[" + primeraVenta + "]");	
			
			respuesta = new ClienteDTO();
			respuesta.setCodCliente(cliente.getCodCliente());
			respuesta.setNombres(nomCliente);
			respuesta.setCodPlanTarif(codPlanTarif);
			respuesta.setDesPlanTarif(desPlanTarif);
			respuesta.setCodTipoTerminal(tipTerminal);
			respuesta.setDesTipoTerminal(desTerminal);
			respuesta.setCodTipoPlanTarif(tipPlanTarif);
			respuesta.setDesTipPlanTarif(desTipPlanTarif);
			respuesta.setCodCargoBasico(codCargoBasico);
			respuesta.setDesCargoBasico(desCargoBasico);
			respuesta.setCodTipoPlan(codTipPlan);
			respuesta.setDesTipPlan(desTipPlan);
			respuesta.setCodCiclo(codCiclo);
			respuesta.setCodCuenta(codCuenta);
			respuesta.setDesCuenta(desCuenta);
			respuesta.setCodSubCuenta(codSubCuenta);
			respuesta.setDesSubCuenta(desSubCuenta);
			respuesta.setLimiteConsumo(codLimiteConsumo);
			respuesta.setDesLimiteConsumo(desLimiteConsumo);
			respuesta.setNumAbonados(numAbonados);
			respuesta.setImpCargoBasico(impCargoBasico);
			respuesta.setCodigoTipoIdentificacion(codTipIdent);
			respuesta.setNumeroIdentificacion(numIdent);
			respuesta.setIndFamiliar(indFamiliar);
			respuesta.setCodProdPadre(codProdPadre);
			respuesta.setTipCuenta(tipCuenta);
			respuesta.setFlgRango(flgRango);
			respuesta.setCodEmpresa(codEmpresa);
			respuesta.setPrimeraVenta(primeraVenta);
			
		} catch (CustomerException e) {
			logger.debug("CustomerException");
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + loge + "]");
			throw e;
			
		}
		catch (Exception e) {
			logger.error("Ocurrió un error general al recuperar al recuperar los datos del cliente", e);
			throw new CustomerException("Ocurrió un error general al recuperar los datos del cliente",e);
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
		logger.debug("obtenerDatosCliente():end");
		return respuesta;
		
	}	
	
	/**
	 * Obtiene categoria tributaria del cliente
	 * 
	 * @param cliente
	 * @return ClienteDTO
	 * @throws CustomerException
	 */	
	public ClienteDTO obtenerCategoriaTributaria(ClienteDTO cliente) throws CustomerException{
		logger.debug("obtenerCategoriaTributaria():start");
		
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		ClienteDTO retorno = null;		
		Connection conn = null;
		CallableStatement cstmt = null;
		
		String call = getSQLobtenerCategoriaTributaria();
		try {
		
			logger.debug("cliente.getCodCliente()[" + cliente.getCodCliente() + "]");
			
			conn = getConnectionFromWLSInitialContext(global.getJndiForDataSource());
			
			cstmt = conn.prepareCall(call);
			
			cstmt.setLong(1, cliente.getCodCliente());
			cstmt.registerOutParameter(2, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(5, java.sql.Types.VARCHAR);
			
			logger.debug("execute:antes");
			cstmt.execute();
			logger.debug("execute:despues");


			codError = cstmt.getInt(2);
			logger.debug("codError[" + codError + "]");
			msgError = cstmt.getString(3);
			logger.debug("msgError[" + msgError + "]");
			numEvento = cstmt.getInt(4);
			logger.debug("numEvento[" + numEvento + "]");
			
			if (codError != 0) {
				logger.error(" Ocurrió un error al obtener categoria tributaria del cliente");
				throw new CustomerException(String.valueOf(codError),numEvento, msgError);
			}
			
			logger.debug("Recuperando data...");
			
			String categoria = cstmt.getString(5);
			logger.debug("categoria[" + categoria + "]");
			
			retorno = cliente;
			cliente.setCodCategoria(categoria);
		
		} catch (CustomerException e) {
			logger.debug("CustomerException");
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + loge + "]");
			throw e;
			
		}
		catch (Exception e) {
			logger.error("Ocurrió un error al obtener categoria tributaria del cliente", e);
			throw new CustomerException("Ocurrió un error general al obtener categoria tributaria del cliente",e);
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
		logger.debug("obtenerCategoriaTributaria():end");
		return retorno;			
	}
	
	
	private String getSQLgetCliente(){
		StringBuffer call = new StringBuffer();
			call.append(" BEGIN "+
							"VE_SERVICIOS_VENTA_PG.VE_CONSULTA_CLIENTE_PR ( ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ? ); "+
						"	END;"); 

		return call.toString();
	}
	public ClienteDTOInt getCliente(ClienteDTOInt cliente) throws CustomerException{
		logger.debug("getCliente:inicio");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		logger.debug("Coneccion obtenida OK");
		CallableStatement cstmt = null;
		try {
			String call = getSQLgetCliente();
			logger.debug("sql[" + call + "]");
			cstmt = conn.prepareCall(call);
			cstmt.setLong(1,Long.parseLong(cliente.getCodigoCliente()));
			cstmt.registerOutParameter(2,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(3,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(4,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5,java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(6,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(7,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(8,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(9,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(10,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(11,java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(12,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(13,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(14,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(15,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(16,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(17,java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(18,java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(19,java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(20,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(21,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(22,java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(23,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(24,java.sql.Types.NUMERIC);
			logger.debug("Execute Antes");
			cstmt.execute();
			logger.debug("Execute Despues");
			codError = cstmt.getInt(22);
			logger.debug("codError[" + codError + "]");
			msgError = cstmt.getString(23);
			logger.debug("msgError[" + msgError + "]");
			numEvento = cstmt.getInt(24);
			logger.debug("numEvento[" + numEvento + "]");
			if (codError != 0) {
				codError = 10;
				numEvento = 10;
				msgError = "No se pudo rescatar la Información";
				
				logger.error("Ocurrió un error al consultar el Cliente");
				throw new CustomerException(
						"Ocurrió un error al consultar el cliente", String
								.valueOf(codError), numEvento, msgError);
			}
			else{
				cliente.setNumeroIdentificacion(cstmt.getString(2));
				cliente.setCodigoTipoIdentificacion(cstmt.getString(3));
				cliente.setNombreCliente(cstmt.getString(4));
				cliente.setCodigoCuenta(String.valueOf(cstmt.getLong(5)));
				cliente.setNombreApellido1(cstmt.getString(6));
				cliente.setNombreApellido2(cstmt.getString(7));
				//cliente.setFechaNacimiento(cstmt.getTimestamp(8));
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
				if (cstmt.getLong(19) > 0){
					cliente.setCodigoEmpresa(cstmt.getLong(19));
					cliente.setCodigoPlanTarifario(cstmt.getString(21));
				}
			}
			if (logger.isDebugEnabled()) {
				logger.debug(" Finalizo ejecución");
				logger.debug(" Recuperando salidas");
			}
			// Recuperacion de valores de salida

		} catch (Exception e) {
			logger.error("Ocurrió un error al consultar el cliente",e);
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

		logger.debug("getCliente():end");

		return cliente;
	}

}