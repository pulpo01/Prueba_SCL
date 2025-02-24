/**
 * Fecha ------------------- Autor  ------------------------- Cambios ----------
 * 30/05/2007	     	Elizabeth Vera        				Versi�n Inicial
 * 18/07/2007           Ra�l Lozano                     se agrega metodo getCliente 
 */
package com.tmmas.scl.framework.customerDomain.dao;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.SQLException;

import org.apache.log4j.Logger;
import org.apache.log4j.PropertyConfigurator;

import com.tmmas.cl.framework.base.ConnectionDAO;
import com.tmmas.cl.framework.util.StackTraceUtl;
import com.tmmas.scl.framework.customerDomain.dao.interfaces.ClienteDAOIT;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ClienteDTO;
import com.tmmas.scl.framework.customerDomain.exception.CustomerException;
import com.tmmas.scl.framework.customerDomain.helper.Global;



public class ClienteDAO extends ConnectionDAO implements ClienteDAOIT {

	private final Logger logger = Logger.getLogger(ClienteDAO.class);

	private final Global global = Global.getInstance();
	
	private String getSQLobtenerDatosCliente() {
		StringBuffer call = new StringBuffer();
		
		call.append(" DECLARE ");
		call.append("   so_cliente PV_CLIENTE2_QT := NEW PV_CLIENTE2_QT;");
		call.append(" BEGIN ");
		call.append("   so_cliente.COD_CLIENTE := ?;");
		call.append("   PV_DATOS_CLIENTES2_PG.PV_OBTIENE_DATOS_CLIENTE_PR( so_cliente, ?, ?, ?);");
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
	
	private String getSQLobtenerDatosCliente2() {
		StringBuffer call = new StringBuffer();
		
		call.append(" DECLARE ");
		call.append("   so_cliente PV_CLIENTE_QT := PV_INICIA_ESTRUCTURAS_PG.PV_INICIA_PV_CLIENTE_QT_FN;");
		call.append(" BEGIN ");
		call.append("   so_cliente.COD_CLIENTE := ?;");
		call.append("    PV_DATOS_CLIENTES_PG.PV_OBTIENE_DATOS_CLIENTE2_PR( so_cliente, ?, ?, ?);");
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
			logger.debug("Par�metros de entrada");
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
				logger.error(" Ocurri� un error al recuperar los datos del cliente");
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
			logger.error("Ocurri� un error general al recuperar al recuperar los datos del cliente", e);
			throw new CustomerException("Ocurri� un error general al recuperar los datos del cliente",e);
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
	 * Obtiene los datos del cliente para las OOSS Aviso y Anulacion de Siniestro.
	 * Package: PV_DATOS_CLIENTES_PG.PV_OBTIENE_DATOS_CLIENTE2_PR
	 * @param cliente del tipo ClienteDTO
	 * @return ClienteDTO
	 * @throws CustomerException
	 * @author Santiago Ventura
	 * @date 15-04-2010 
	 */
	public ClienteDTO obtenerDatosCliente2(ClienteDTO cliente) throws CustomerException {
		logger.debug("obtenerDatosCliente2():start");
		
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		ClienteDTO respuesta = null;		
		Connection conn = null;
		CallableStatement cstmt = null;
		
		String call = getSQLobtenerDatosCliente2();
		try {
			logger.debug("CALL: "+call);
			logger.debug("Par�metros de entrada");
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
				logger.error(" Ocurri� un error al recuperar los datos del cliente");
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
			logger.error("Ocurri� un error general al recuperar al recuperar los datos del cliente", e);
			throw new CustomerException("Ocurri� un error general al recuperar los datos del cliente",e);
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
		logger.debug("obtenerDatosCliente2():end");
		return respuesta;
	}	

}