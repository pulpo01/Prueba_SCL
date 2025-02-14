/**
 * Fecha ------------------- Autor  ------------------------- Cambios ----------
 * 30/05/2007	     	Elizabeth Vera        				Versión Inicial
 * 18/07/2007           Raúl Lozano                     se agrega metodo getCliente 
 */
package com.tmmas.scl.framework.customerDomain.businessObject.dao;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.StringTokenizer;

import oracle.jdbc.OracleCallableStatement;

import org.apache.log4j.Logger;

import com.tmmas.cl.framework.base.ConnectionDAO;
import com.tmmas.cl.framework.util.ArrayUtl;
import com.tmmas.cl.framework.util.StackTraceUtl;
import com.tmmas.scl.framework.customerDomain.businessObject.dao.interfaces.ClienteDAOIT;
import com.tmmas.scl.framework.customerDomain.businessObject.helper.Global;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.CargoClienteDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ClienteCobroAdentadoDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ClienteDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ClienteListDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.DireccionDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.LimiteLineasDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.LineasClienteDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.MorosidadClienteDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ObtencionLineasClienteDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.RetornoDTO;
import com.tmmas.scl.framework.customerDomain.exception.CustomerException;
import com.tmmas.scl.framework.marketSalesDomain.dataTransferObject.VentaDTO;
import com.tmmas.scl.framework.serviceDomain.dataTransferObject.NumeroDTO;

public class ClienteDAO extends ConnectionDAO implements ClienteDAOIT {

	private final Logger logger = Logger.getLogger(ClienteDAO.class);

	private final Global global = Global.getInstance();
	
	private String getSQLinsertarCobroAdelantado()
	{
		StringBuffer call = new StringBuffer();
		call.append(" BEGIN ");
		call.append("   PV_PAGOANTICIPADO_PG.PV_OBTENERSS_AUX_PR(?,?,?,?,?,?,?); ");
		call.append(" END; ");
		return call.toString();			
	} // getSQLPagoAnticipado
	
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
	
	private String getSQLactualizaCantAboCliente() {
		StringBuffer call = new StringBuffer();
		
		call.append(" DECLARE ");
		call.append("   eo_cliente GE_CLIENTES_QT := PV_INICIA_ESTRUCTURAS_PG.GE_CLIENTES_QT_FN;");
		call.append(" BEGIN ");
		call.append("   eo_cliente.COD_CLIENTE := ?;");
		call.append("   eo_cliente.CANTIDAD := ?;");
		call.append("   PV_DATOS_CLIENTES_PG.PV_ACTUA_CANT_ABOCLIENTE_PR( eo_cliente, ?, ?, ?);");
		call.append(" END;");		
		return call.toString();		
	}

	private String getSQLobtenerCargoBasicoActual() {
		StringBuffer call = new StringBuffer();
		call.append(" DECLARE ");
		call.append("   eo_cliente PV_BOLSAS_DINAMICAS_QT := PV_INICIA_ESTRUCTURAS_PG.PV_BOLSAS_DINAMICAS_QT_FN;");
		call.append(" BEGIN ");
		call.append("   eo_cliente.COD_CLIENTE := ?;");
		call.append("   eo_cliente.FECHA := ?;");
		call.append("   PV_DATOS_CLIENTES_PG.PV_Obt_CargoBasico_Actual_PR( eo_cliente, ?, ?, ?);");
		call.append("   	? := eo_cliente.IMP_CARGO ;");
		call.append(" END;");			
		return call.toString();		
	}

	private String getSQLbuscarCliente() {
		StringBuffer call = new StringBuffer();
		call.append("DECLARE");
		call.append("	EO_CLIENTE PV_CLIENTE_QT := PV_INICIA_ESTRUCTURAS_PG.PV_INICIA_PV_CLIENTE_QT_FN;");
		call.append("	BEGIN");	
		call.append("   eo_cliente.NUM_CELULAR := ?;");
		call.append("   eo_cliente.COD_TIPIDENT := ?;");
		call.append("   eo_cliente.NUM_IDENT := ?;");
		call.append("	PV_DATOS_CLIENTES_PG.PV_CLIENTE_BUSQUEDA_PR(EO_CLIENTE,?,?,?,?);");									
		call.append("	END;");
		return call.toString();		
	}
	
	
	private String getSQLobtenerDatosPorVenta() {
		StringBuffer call = new StringBuffer();
		call.append(" DECLARE ");
		call.append("   eo_cliente GA_ABONADO_QT := PV_INICIA_ESTRUCTURAS_PG.PV_INICIA_GA_ABONADO_QT_FN;");
		call.append(" BEGIN ");
		call.append("   eo_cliente.COD_CLIENTE := ?;");
		call.append("   eo_cliente.COD_PLANTARIF := ?;");
		call.append("   PV_DATOS_CLIENTES_PG.PV_VALIDAR_TIPO_PLANCLIENTE_PR( eo_cliente,?, ?, ?, ?);");
		call.append(" END;");			
		return call.toString();		
	}
	
	private String getSQLvalidarCliente() {
		StringBuffer call = new StringBuffer();
		call.append(" DECLARE ");
		call.append("   eo_cliente GA_ABONADO_QT := PV_INICIA_ESTRUCTURAS_PG.PV_INICIA_GA_ABONADO_QT_FN;");
		call.append(" BEGIN ");
		call.append("   eo_cliente.COD_CLIENTE := ?;");
		call.append("   eo_cliente.COD_PLANTARIF := ?;");
		call.append("   PV_DATOS_CLIENTES_PG.PV_VALIDAR_TIPO_PLANCLIENTE_PR( eo_cliente,?, ?, ?, ?);");
		call.append(" END;");			
		return call.toString();		
	}
	
	private String getSQLvalidarTipoPlanCliente() {
		StringBuffer call = new StringBuffer();
		call.append(" DECLARE ");
		call.append("   eo_cliente GA_ABONADO_QT := PV_INICIA_ESTRUCTURAS_PG.PV_INICIA_GA_ABONADO_QT_FN;");
		call.append(" BEGIN ");
		call.append("   eo_cliente.COD_CLIENTE := ?;");
		call.append("   eo_cliente.COD_PLANTARIF := ?;");
		call.append("   PV_DATOS_CLIENTES_PG.PV_VALIDAR_TIPO_PLANCLIENTE_PR( eo_cliente,?, ?, ?, ?);");
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
	
	private String getSQLObtenerCodigoValorCliente(){
		StringBuffer call = new StringBuffer();
		call.append("  DECLARE"); 
		call.append(" 	 SN_COD_CLIENTE NUMBER;");
		call.append(" 	 SN_COD_VALOR VARCHAR2(200);");
		call.append("  BEGIN ");
		call.append(" 	  SN_COD_CLIENTE := ?; ");
		call.append(" 	  PV_CARGOS_PG.PV_OBTENER_CODVALOR_PR(SN_COD_CLIENTE,?,?,?,?);");
		call.append(" 	END; ");
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
	
	private String getSQLobtenerValorCalculado(){
		StringBuffer call = new StringBuffer();
		call.append(" DECLARE ");
		call.append("   so_cliente PV_CLIENTE_QT := PV_INICIA_ESTRUCTURAS_PG.PV_INICIA_PV_CLIENTE_QT_FN;");
		call.append(" BEGIN ");
		call.append("   so_cliente.COD_CLIENTE := ?;");
		call.append("   PV_DATOS_CLIENTES_PG.PV_OBTENER_VALOR_CALC_PR( so_cliente, ?, ?, ?);");
		call.append("		? := so_cliente.COD_VALOR;");
		call.append(" END;");
		return call.toString();	
	}

	private String getSQLobtenerCantidadLineasCliente(){
		StringBuffer call = new StringBuffer();
		call.append(" DECLARE ");
		call.append("   numLineas NUMBER(9):= 0; ");
		call.append(" BEGIN ");
		call.append("   numLineas := PV_DATOS_CLIENTES_PG.PV_CLIENTE_CANTLINEAS_FN( ?, ?, ?, ?);");
		call.append("		? := numLineas;");
		call.append(" END;");
		return call.toString();			
		
	}
	
	private String getSQLobtenerMorosidadCliente(){
		StringBuffer call = new StringBuffer();
		call.append(" DECLARE ");
		call.append("   so_cliente PV_CLIENTE_QT := PV_INICIA_ESTRUCTURAS_PG.PV_INICIA_PV_CLIENTE_QT_FN;");
		call.append("   morosidad NUMBER(1):= 0; ");
		call.append(" BEGIN ");
		call.append("   so_cliente.COD_TIPIDENT := ?;");
		call.append("   so_cliente.NUM_IDENT := ?;");
		call.append("   morosidad := PV_DATOS_CLIENTES_PG.PV_DETERMINA_MOROCIDAD_FN( so_cliente, ?, ?, ?);");
		call.append("		? := morosidad;");
		call.append(" END;");
		return call.toString();			
		
	}

	private String getSQLObtenerLimiteLineas() {
		StringBuffer call = new StringBuffer();
		
		call.append(" DECLARE ");
		call.append(" eo_cliente PV_CLIENTE_QT := PV_INICIA_ESTRUCTURAS_PG.PV_INICIA_PV_CLIENTE_QT_FN;");
		call.append(" numLineas VARCHAR2(300):= ''; ");
		call.append(" BEGIN ");
		call.append("   eo_cliente.COD_CLIENTE := ?;");
		call.append("   eo_cliente.COD_TIPIDENT := ?;");
		call.append("   eo_cliente.NUM_IDENT := ?;");
		call.append("   eo_cliente.COD_CUENTA := ?;");
		call.append("   PV_DATOS_CLIENTES_PG.PV_OBTIENE_LIMITELINEAS_FN( eo_cliente, ?, ?, ?);");
		call.append("		? := numLineas;");
		call.append(" END;");		
		return call.toString();		
	}
	
	
	/**
	 * Obtiene el número de líneas máximo
	 * 
	 * @param cliente
	 * @return RetornoDTO
	 * @throws CustomerException
	 */
	public LimiteLineasDTO obtenerLimiteLineas(ObtencionLineasClienteDTO cliente) throws CustomerException{

		logger.debug("obtenerLimiteLineas():start");
		
		int codError = 0;
		String msgError = null;
		int numEvento = 0;	
		Connection conn = null;
		CallableStatement cstmt = null;
		LimiteLineasDTO retorno = new LimiteLineasDTO();
		
		String call = getSQLObtenerLimiteLineas();
		try {
		
			logger.debug("cliente.getCodCliente()[" + cliente.getCodCliente() + "]");
			
			conn = getConnectionFromWLSInitialContext(global.getJndiForDataSource());
			
			cstmt = conn.prepareCall(call);
			
			cstmt.setLong(1, cliente.getCodCliente());
			cstmt.setString(2, cliente.getCodTipIdent());
			cstmt.setString(3, cliente.getNumIdent());
			cstmt.setLong(4, cliente.getCodCuenta());
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(6, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(7, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(8, java.sql.Types.NUMERIC);
			
			logger.debug("execute:antes");
			cstmt.execute();
			logger.debug("execute:despues");
			
			logger.debug("Recuperando salidas");
			codError = cstmt.getInt(5);
			logger.debug("codError[" + codError + "]");
			msgError = cstmt.getString(6);
			logger.debug("msgError[" + msgError + "]");
			numEvento = cstmt.getInt(7);
			logger.debug("numEvento[" + numEvento + "]");
			
			if (codError != 0) {
				logger.error(" Ocurrió un error al obtener Limite de Lineas");
				throw new CustomerException(String.valueOf(codError),numEvento, msgError);
			}
			
			//obtener retorno
			logger.debug("Recuperando data...");
			String cadena = cstmt.getString(8);
			
			if(cadena!=null){
				StringTokenizer token = new StringTokenizer(cadena,"|");
				retorno.setSuperaLimite(token.nextToken());
				retorno.setNumeroLineasCliente(token.nextToken());
				retorno.setMaximoPermitido(token.nextToken());
			}else{
				logger.error(" No se encuentra la cadena");
				throw new CustomerException("No se encuentra la cadena");
			}
			
			
			
		
		} catch (CustomerException e) {
			logger.debug("CustomerException");
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + loge + "]");
			throw e;
			
		}
		catch (Exception e) {
			logger.error("Ocurrió un error al obtener el Limite de Lineas", e);
			throw new CustomerException("Ocurrió un error general al obtener el Limite de Lineas",e);
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
		logger.debug("obtenerLimiteLineas():end");
		return retorno;
		
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
	 * Actualiza la cantidad de abonados en el tabla ge_clientes
	 * 
	 * @param cliente
	 * @return RetornoDTO
	 * @throws CustomerException
	 */
	public RetornoDTO actualizaCantAboCliente(ClienteDTO cliente) throws CustomerException{

		logger.debug("actualizaCantAboCliente():start");
		
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		RetornoDTO retorno = null;		
		Connection conn = null;
		CallableStatement cstmt = null;
		
		String call = getSQLactualizaCantAboCliente();
		try {
		
			logger.debug("cliente.getCodCliente()[" + cliente.getCodCliente() + "]");
			
			conn = getConnectionFromWLSInitialContext(global.getJndiForDataSource());
			
			cstmt = conn.prepareCall(call);
			
			cstmt.setLong(1, cliente.getCodCliente());
			cstmt.setLong(2, cliente.getNumAbonados());
			
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
				logger.error(" Ocurrió un error al actualizar cantidad de abonados");
				throw new CustomerException(String.valueOf(codError),numEvento, msgError);
			}
			
			//obtener retorno
			logger.debug("Recuperando data...");
			retorno = new RetornoDTO();
			retorno.setCodigo(String.valueOf(codError));
			retorno.setDescripcion(msgError);
		
		} catch (CustomerException e) {
			logger.debug("CustomerException");
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + loge + "]");
			throw e;
			
		}
		catch (Exception e) {
			logger.error("Ocurrió un error al actualizar cantidad de abonados", e);
			throw new CustomerException("Ocurrió un error general al actualizar cantidad de abonados",e);
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
		logger.debug("actualizaCantAboCliente():end");
		return retorno;
		
	}
	
	
	
	/**
	 * Obtiene el cargo actual
	 * 
	 * @param cliente
	 * @return CargoDTO
	 * @throws CustomerException
	 */	
	public CargoClienteDTO obtenerCargoBasicoActual(CargoClienteDTO cliente) throws CustomerException{
		logger.debug("obtenerCargoBasicoActual():start");
		
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		CargoClienteDTO cargo = null;		
		Connection conn = null;
		CallableStatement cstmt = null;
		
		String call = getSQLobtenerCargoBasicoActual();
		try {
		
			logger.debug("cliente.getCodCliente()[" + cliente.getCodCliente() + "]");
			
			conn = getConnectionFromWLSInitialContext(global.getJndiForDataSource());
			
			cstmt = conn.prepareCall(call);

			long fecha = cliente.getFecha().getTime();
			cstmt.setLong(1, cliente.getCodCliente());
			cstmt.setDate(2, new java.sql.Date(fecha));
			cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(6, java.sql.Types.NUMERIC);
			
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
				logger.error(" Ocurrió un error al obtener cargo actual");
				throw new CustomerException(String.valueOf(codError),numEvento, msgError);
			}
			
			//obtener cargo
			logger.debug("Recuperando data...");
			cargo= new CargoClienteDTO();
			float impCargo = cstmt.getFloat(6);
			logger.debug("impCargo [" + impCargo + "]");
			
			cargo.setImpCargo(impCargo);
			
		} catch (CustomerException e) {
			logger.debug("CustomerException");
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + loge + "]");
			throw e;
			
		}
		catch (Exception e) {
			logger.error("Ocurrió un error al obtener cargo actual", e);
			throw new CustomerException("Ocurrió un error general al obtener cargo actual",e);
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
		logger.debug("obtenerCargoBasicoActual():end");
		return cargo;		
	}
	
	/**
	 * Valida tipo de plan tarifario
	 * 
	 * @param cliente
	 * @return RetornoDTO
	 * @throws CustomerException
	 */	
	public RetornoDTO validarTipoPlanCliente(ClienteDTO cliente) throws CustomerException{
		logger.debug("validarTipoPlanCliente():start");
		
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		RetornoDTO retorno = null;		
		Connection conn = null;
		CallableStatement cstmt = null;
		
		String call = getSQLvalidarTipoPlanCliente();
		try {
		
			logger.debug("cliente.getCodCliente()[" + cliente.getCodCliente() + "]");
			
			conn = getConnectionFromWLSInitialContext(global.getJndiForDataSource());
			
			cstmt = conn.prepareCall(call);
			
			cstmt.setLong(1, cliente.getCodCliente());
			cstmt.setString(2, cliente.getCodPlanTarif());
			cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(5, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(6, java.sql.Types.NUMERIC);
			
			logger.debug("execute:antes");
			cstmt.execute();
			logger.debug("execute:despues");

			logger.debug("Recuperando salidas");
			String exito = cstmt.getString(3);
			logger.debug("exito[" + exito + "]");
			
			codError = cstmt.getInt(4);
			logger.debug("codError[" + codError + "]");
			msgError = cstmt.getString(5);
			logger.debug("msgError[" + msgError + "]");
			numEvento = cstmt.getInt(6);
			logger.debug("numEvento[" + numEvento + "]");
			
			if (codError != 0) {
				logger.error(" Ocurrió un error al validar tipo de plan");
				throw new CustomerException(String.valueOf(codError),numEvento, msgError);
			}
			
			logger.debug("Recuperando data...");
			
			boolean exitob = (exito.equalsIgnoreCase("TRUE"))?true:false;
			logger.debug("exitob[" + exito + "]");
			
			retorno = new RetornoDTO();
			retorno.setDescripcion(msgError);
			retorno.setResultado(exitob);
		
		} catch (CustomerException e) {
			logger.debug("CustomerException");
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + loge + "]");
			throw e;
			
		}
		catch (Exception e) {
			logger.error("Ocurrió un error al validar tipo de plan", e);
			throw new CustomerException("Ocurrió un error general al validar tipo de plan",e);
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
		logger.debug("validarTipoPlanCliente():end");
		return retorno;			
	}

	public ClienteListDTO buscarCliente(NumeroDTO numero) throws CustomerException {
		logger.debug("buscarCliente():start");
		
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		ClienteListDTO clienteListRetorno = null;		
		Connection conn = null;
		OracleCallableStatement cstmt = null;
		
		String call = this.getSQLbuscarCliente();
		try {
			
			conn = getConnectionFromWLSInitialContext(global.getJndiForDataSource());
			
			cstmt = (OracleCallableStatement)conn.prepareCall(call);		
			
			//StructDescriptor sd = StructDescriptor.createDescriptor("PV_CLIENTE_QT", conn);			
			//STRUCT oracleObject = new STRUCT(sd, conn, numero.toStruct_PV_CLIENTE_QT());
			
			//logger.debug("numero.getNro()[" + numero.getNro() + "]");
			
			
			//NVL(iNum_celular,-1)<>-1
			//ini------------------CONTINUAR CARGA DE PARAMETROS-------------------
			cstmt.setString( 1, numero.getNro() );
			cstmt.setString( 2, "" );
			cstmt.setString( 3, "");
			cstmt.registerOutParameter(4, oracle.jdbc.driver.OracleTypes.CURSOR);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(6, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(7, java.sql.Types.NUMERIC);
			
			logger.debug("execute:antes");
			cstmt.execute();
			logger.debug("execute:despues");

			logger.debug("Recuperando salidas");
			
			
			if (codError != 0) {
				logger.error(" Ocurrió un error al buscar Cliente");
				throw new CustomerException(String.valueOf(codError),numEvento, msgError);
			}
			
			logger.debug("Recuperando data...");
			
			clienteListRetorno = new ClienteListDTO();
			ResultSet rs = (ResultSet) cstmt.getObject(4);
			ArrayList listClientes = new ArrayList();
			ClienteDTO clientedto = null;
			
			while(rs.next())
			{			  
				clientedto = new ClienteDTO();
				clientedto.setCodCliente(rs.getString("cod_cliente")!=null?rs.getLong("cod_cliente"):-1);
				clientedto.setNombres(rs.getString("nom_cliente")!=null?rs.getString("nom_cliente"):"");
				clientedto.setApellido1(rs.getString("nom_apeclien1")!=null?rs.getString("nom_apeclien1"):"");
				clientedto.setApellido2(rs.getString("nom_apeclien2")!=null?rs.getString("nom_apeclien2"):"");
				listClientes.add(clientedto);
			}
			
			ClienteDTO[] clienteList=(ClienteDTO[]) ArrayUtl.copiaArregloTipoEspecifico(listClientes.toArray(), ClienteDTO.class);
			clienteListRetorno.setClienteList(clienteList);
			
			
		} catch (CustomerException e) {
			logger.debug("CustomerException");
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + loge + "]");
			throw e;
			
		}
		catch (Exception e) {
			logger.error("Ocurrió un error al buscar cliente", e);
			throw new CustomerException("Ocurrió un error general al validar tipo de plan",e);
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
		logger.debug("buscarCliente():end");
		return clienteListRetorno;			
	}
	
	public ClienteListDTO buscarCliente(ClienteDTO cliente) throws CustomerException {
		logger.debug("buscarCliente():start");
		
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		ClienteListDTO clienteListRetorno = null;		
		Connection conn = null;
		OracleCallableStatement cstmt = null;
		
		String call = this.getSQLbuscarCliente();
		try {
			
			conn = getConnectionFromWLSInitialContext(global.getJndiForDataSource());
			
			cstmt = (OracleCallableStatement)conn.prepareCall(call);		
			
			//StructDescriptor sd = StructDescriptor.createDescriptor("PV_CLIENTE_QT", conn);			
			//STRUCT oracleObject = new STRUCT(sd, conn, numero.toStruct_PV_CLIENTE_QT());
			
			//logger.debug("numero.getNro()[" + numero.getNro() + "]");
			
			
			//NVL(iNum_celular,-1)<>-1
			//ini------------------CONTINUAR CARGA DE PARAMETROS-------------------
			cstmt.setString( 1,"-1" );
			cstmt.setString( 2,cliente.getCodigoTipoIdentificacion() );
			cstmt.setString( 3,cliente.getNumeroIdentificacion() );
			cstmt.registerOutParameter(4, oracle.jdbc.driver.OracleTypes.CURSOR);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(6, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(7, java.sql.Types.NUMERIC);
			
			logger.debug("execute:antes");
			cstmt.execute();
			logger.debug("execute:despues");

			logger.debug("Recuperando salidas");
			
			
			if (codError != 0) {
				logger.error(" Ocurrió un error al buscar Cliente");
				throw new CustomerException(String.valueOf(codError),numEvento, msgError);
			}
			
			logger.debug("Recuperando data...");
			
			clienteListRetorno = new ClienteListDTO();
			ResultSet rs = (ResultSet) cstmt.getObject(4);
			ArrayList listClientes = new ArrayList();
			ClienteDTO clientedto = null;
			
			while(rs.next())
			{			  
				clientedto = new ClienteDTO();
				clientedto.setCodCliente(rs.getString("cod_cliente")!=null?rs.getLong("cod_cliente"):-1);
				clientedto.setNombres(rs.getString("nom_cliente")!=null?rs.getString("nom_cliente"):"");
				clientedto.setApellido1(rs.getString("nom_apeclien1")!=null?rs.getString("nom_apeclien1"):"");
				clientedto.setApellido2(rs.getString("nom_apeclien2")!=null?rs.getString("nom_apeclien2"):"");
				listClientes.add(clientedto);
			}
			
			ClienteDTO[] clienteList=(ClienteDTO[]) ArrayUtl.copiaArregloTipoEspecifico(listClientes.toArray(), ClienteDTO.class);
			clienteListRetorno.setClienteList(clienteList);
			
			
		} catch (CustomerException e) {
			logger.debug("CustomerException");
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + loge + "]");
			throw e;
			
		}
		catch (Exception e) {
			logger.error("Ocurrió un error al buscar cliente", e);
			throw new CustomerException("Ocurrió un error general al validar tipo de plan",e);
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
		logger.debug("buscarCliente():end");
		return clienteListRetorno;			
	}

	public ClienteDTO obtenerDatosPorVenta(VentaDTO venta) throws CustomerException {
		logger.debug("obtenerDatosPorVenta():start");
		logger.debug("llamando funcion obtenerDatosCliente(clienteDTO)");
		ClienteDTO retorno = obtenerDatosCliente(venta.getCliente());
		logger.debug("fin llamada a funcion obtenerDatosCliente(clienteDTO)");
		logger.debug("obtenerDatosPorVenta():end");
		return retorno;	
	}

	public ClienteDTO validarCliente(ClienteDTO cliente) throws CustomerException {
		logger.debug("validarCliente():start");
		
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		ClienteDTO retorno = null;		
		Connection conn = null;
		CallableStatement cstmt = null;
		
		String call = this.getSQLvalidarCliente();
		try {
		
			logger.debug("cliente.getCodCliente()[" + cliente.getCodCliente() + "]");
			conn = getConnectionFromWLSInitialContext(global.getJndiForDataSource());
			cstmt = conn.prepareCall(call);	
			logger.debug("execute:antes");
				// cstmt.execute();
			logger.debug("execute:despues");

			logger.debug("Recuperando salidas");
			
			if (codError != 0) {
				logger.error(" Ocurrió un error al validar un cliente");
				throw new CustomerException(String.valueOf(codError),numEvento, msgError);
			}
			
			logger.debug("Recuperando data...");
			
			retorno = new ClienteDTO();			
		
		} catch (CustomerException e) {
			logger.debug("CustomerException");
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + loge + "]");
			throw e;
			
		}
		catch (Exception e) {
			logger.error("Ocurrió un error al validar un cliente", e);
			throw new CustomerException("Ocurrió un error general al validar un cliente",e);
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
		logger.debug("validarCliente():end");
		return retorno;	
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
			cstmt.registerOutParameter(2, java.sql.Types.VARCHAR);
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
	
	public ClienteDTO getCliente(ClienteDTO cliente) throws CustomerException{
		logger.debug("getCliente:inicio");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		logger.debug("Coneccion obtenida OK");
		CallableStatement cstmt = null;
		try {
			String call = getSQLDatosCliente("PV_SERVICIOS_POSVENTA_PG","VE_consulta_cliente_PR",24);
			logger.debug("sql[" + call + "]");
			conn=getConnectionFromWLSInitialContext(global.getJndiForDataSource());
			cstmt = conn.prepareCall(call);
			cstmt.setLong(1,cliente.getCodCliente());
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
			cstmt.registerOutParameter(19,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(20,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(21,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(22,java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(23,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(24,java.sql.Types.NUMERIC);
			
			
			logger.debug("Execute Antes");
			cstmt.execute();
			logger.debug("Execute Despues");
			cliente.setNumeroIdentificacion(cstmt.getString(2));
			cliente.setCodigoTipoIdentificacion(cstmt.getString(3));
			cliente.setNombres(cstmt.getString(4));
			cliente.setCodCuenta(cstmt.getLong(5));
			cliente.setApellido1(cstmt.getString(6));
			cliente.setApellido2(cstmt.getString(7));
			cliente.setFechaNacimiento(cstmt.getTimestamp(8));
			cliente.setIndicadorEstadoCivil(cstmt.getString(9));
			cliente.setIndicadorSexo(cstmt.getString(10));
			cliente.setCodigoActividad(String.valueOf(cstmt.getLong(11)));
			DireccionDTO direccion = new DireccionDTO();
			direccion.setRegion(cstmt.getString(12));
			direccion.setCiudad(cstmt.getString(13));
			direccion.setProvincia(cstmt.getString(14));
			cliente.setDireccion(direccion);
			cliente.setCodigoCelda(cstmt.getString(15));
			cliente.setCodigoCalidadCliente(cstmt.getString(16));
			cliente.setIndicativoFacturable(cstmt.getInt(17));
			cliente.setCodigoCiclo(cstmt.getString(18));
			cliente.setCodigoEmpresa(cstmt.getString(19));
				
			logger.debug("cod Empresa[" + cstmt.getLong(19) + "]");
			
			codError = cstmt.getInt(22);
			logger.debug("codError[" + codError + "]");
			msgError = cstmt.getString(23);
			logger.debug("msgError[" + msgError + "]");
			numEvento = cstmt.getInt(24);
			logger.debug("numEvento[" + numEvento + "]");
			if (codError != 0) {
				logger.error("Ocurrió un error al consultar el Cliente");
				throw new CustomerException(
						"Ocurrió un error al consultar el cliente", String
								.valueOf(codError), numEvento, msgError);
			}
			String codCliente=String.valueOf(cliente.getCodCliente());
			if (codCliente == null) {
				codError = 10;
				numEvento = 10;
				msgError = "No se pudo rescatar la Información";
				
				logger.error("Ocurrió un error al consultar el Cliente"+cliente.getCodCliente());
				throw new CustomerException(
						"Ocurrió un error al consultar el cliente", String
								.valueOf(codError), numEvento, msgError);
				/*throw new CustomerDomainException(
				"Ocurrió un error al consultar el cliente");*/
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
	
	public String getcodValorCliente (String codCliente)throws CustomerException{
		logger.debug("getcodValorCliente()");
		int codError = 0;
		String retValue=null;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		CallableStatement cstmt = null;
		try {
			String call = getSQLObtenerCodigoValorCliente();
			getConnectionFromWLSInitialContext(global.getJndiForDataSource());
			logger.debug("sql[" + call + "]");
			cstmt = conn.prepareCall(call);

			cstmt.setString(1,codCliente);
			cstmt.registerOutParameter(2, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);

			logger.debug("Inicio:getcodValorCliente:execute");
			cstmt.execute();
			logger.debug("Fin:getcodValorCliente:execute");
			
			codError = cstmt.getInt(3);
			msgError = cstmt.getString(4);
			numEvento = cstmt.getInt(5);
			logger.debug("msgError[" + msgError + "]");
			if (codError!=0){
				logger.error("Ocurrió un error al recuperar código valor de cliente");
				throw new CustomerException(
						"Ocurrió un error al recuperar código valor de cliente", String
								.valueOf(codError), numEvento, msgError);
			}
			else
			{
				retValue=cstmt.getString(2);
			}
			
			if (logger.isDebugEnabled()) {
				logger.debug(" Finalizo ejecución");
				logger.debug(" Recuperando salidas");
			}
		} catch (Exception e) {
			logger.error("Ocurrió un error al recuperar el codigo valor de cliente",e);
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
		return retValue;
	}
	
	
	/**
	 * Obtiene valor calculado
	 * 
	 * @param cliente
	 * @return ClienteDTO
	 * @throws CustomerException
	 */	
	public ClienteDTO obtenerValorCalculado(ClienteDTO cliente) throws CustomerException{
		logger.debug("obtenerValorCalculado():start");
		
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		ClienteDTO retorno = null;		
		Connection conn = null;
		CallableStatement cstmt = null;
		
		String call = getSQLobtenerValorCalculado();
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
			
			logger.debug("Recuperando salidas");
			codError = cstmt.getInt(2);
			logger.debug("codError[" + codError + "]");
			msgError = cstmt.getString(3);
			logger.debug("msgError[" + msgError + "]");
			numEvento = cstmt.getInt(4);
			logger.debug("numEvento[" + numEvento + "]");
			
			if (codError != 0) {
				logger.error(" Ocurrió un error al obtener valor calculado");
				throw new CustomerException(String.valueOf(codError),numEvento, msgError);
			}
			
			//obtener retorno
			logger.debug("Recuperando data...");
			String codValor = cstmt.getString(5);
			logger.debug("codValor[" + codValor + "]");
			
			retorno = cliente;
			retorno.setCodValor(codValor);
		
		} catch (CustomerException e) {
			logger.debug("CustomerException");
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + loge + "]");
			throw e;
			
		}
		catch (Exception e) {
			logger.error("Ocurrió un error al obtener valor calculado", e);
			throw new CustomerException("Ocurrió un error general al obtener valor calculado",e);
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
		logger.debug("obtenerValorCalculado():end");
		return retorno;

	}
	
	/**
	 * Obtiene numero de lineas del cliente
	 * 
	 * @param cliente
	 * @return LineasClienteDTO
	 * @throws CustomerException
	 */	
	public LineasClienteDTO obtenerCantidadLineasCliente(LineasClienteDTO cliente) throws CustomerException{
		logger.debug("obtenerCantidadLineasCliente():start");
		
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		LineasClienteDTO retorno = null;		
		Connection conn = null;
		CallableStatement cstmt = null;
		
		String call = getSQLobtenerCantidadLineasCliente();
		try {
		
			logger.debug("cliente.getCodCliente()[" + cliente.getCodCliente() + "]");
			
			conn = getConnectionFromWLSInitialContext(global.getJndiForDataSource());
			
			cstmt = conn.prepareCall(call);
			
			cstmt.setLong(1, cliente.getCodCliente());
		
			cstmt.registerOutParameter(2, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);
			
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
				logger.error(" Ocurrió un error al obtener número de líneas del cliente");
				throw new CustomerException(String.valueOf(codError),numEvento, msgError);
			}
			
			//obtener retorno
			logger.debug("Recuperando data...");
			int numLineas = cstmt.getInt(5);
			logger.debug("numLineas[" + numLineas + "]");
			
			retorno = cliente;
			retorno.setNumLineas(numLineas);
		
		} catch (CustomerException e) {
			logger.debug("CustomerException");
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + loge + "]");
			throw e;
			
		}
		catch (Exception e) {
			logger.error("Ocurrió un error al obtener número de líneas del cliente", e);
			throw new CustomerException("Ocurrió un error general al obtener número de líneas del cliente",e);
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
		logger.debug("obtenerCantidadLineasCliente():end");
		return retorno;

	}
	
	/**
	 * Obtiene morosidad del cliente
	 * 
	 * @param cliente
	 * @return MorosidadClienteDTO
	 * @throws CustomerException
	 */	
	public MorosidadClienteDTO obtenerMorosidadCliente(MorosidadClienteDTO cliente) throws CustomerException{
		logger.debug("obtenerMorosidadCliente():start");
		
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		MorosidadClienteDTO retorno = null;		
		Connection conn = null;
		CallableStatement cstmt = null;
		
		String call = getSQLobtenerMorosidadCliente();
		try {
		
			logger.debug("cliente.getCodTipIdent()[" + cliente.getCodTipIdent() + "]");
			logger.debug("cliente.getNumIdent()[" + cliente.getNumIdent() + "]");
			
			conn = getConnectionFromWLSInitialContext(global.getJndiForDataSource());
			
			cstmt = conn.prepareCall(call);
			
			cstmt.setString(1, cliente.getCodTipIdent());
			cstmt.setString(2, cliente.getNumIdent());
			cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(6, java.sql.Types.NUMERIC);
			
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
				logger.error(" Ocurrió un error al obtener morosidad del cliente");
				throw new CustomerException(String.valueOf(codError),numEvento, msgError);
			}
			
			//obtener retorno
			logger.debug("Recuperando data...");
			int morosidad = cstmt.getInt(6);
			logger.debug("morosidad[" + morosidad + "]");
			
			retorno = cliente;
			retorno.setMorosidad(morosidad);
		
		} catch (CustomerException e) {
			logger.debug("CustomerException");
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + loge + "]");
			throw e;
			
		}
		catch (Exception e) {
			logger.error("Ocurrió un error al obtener morosidad del cliente", e);
			throw new CustomerException("Ocurrió un error general al obtener morosidad del cliente",e);
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
		logger.debug("obtenerMorosidadCliente():end");
		return retorno;
		
	}

	// --------------------------------------------------------------------------------------------------------------------------------------------
	
	public RetornoDTO insertarCobroAdelantado(ClienteCobroAdentadoDTO clienteCobroAdelantadoDTO) throws CustomerException {
		logger.debug("insertarCobroAdelantado():start");
		RetornoDTO retValue=null;
		
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		CallableStatement cstmt = null;
		
		String call = getSQLinsertarCobroAdelantado();
		
		try{
			conn = getConnectionFromWLSInitialContext(global.getJndiForDataSource());
			cstmt = conn.prepareCall(call);
			
			/*-- entrada --*/
			logger.debug("codCliente: " + clienteCobroAdelantadoDTO.getCodCliente());
			logger.debug("numAbonado: " + clienteCobroAdelantadoDTO.getNumAbonado());
			logger.debug("codActAbo: " + clienteCobroAdelantadoDTO.getCodActabo());
			logger.debug("codCiclFact: " + clienteCobroAdelantadoDTO.getCodCicloFact());
			
			cstmt.setLong(1, clienteCobroAdelantadoDTO.getCodCliente());
			cstmt.setLong(2, clienteCobroAdelantadoDTO.getNumAbonado());			
			cstmt.setString(3, clienteCobroAdelantadoDTO.getCodActabo());
			cstmt.setString(4, clienteCobroAdelantadoDTO.getCodCicloFact());

			/*-- salida --*/
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(6, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(7, java.sql.Types.NUMERIC);
			
			logger.debug("Inicio:insertarCobroAdelantado:execute");
			cstmt.execute();
			logger.debug("Fin:insertarCobroAdelantado:execute");
			
			codError=cstmt.getInt(5);
			msgError = cstmt.getString(6);
			numEvento=cstmt.getInt(7);
			logger.debug("msgError[" + msgError + "]");
			if (codError != 0) {
				logger.error(" Ocurrió un error general al insertar Cobros Adelantados");
				throw new CustomerException(String.valueOf(codError),numEvento, msgError);
			}
			
			//obtener retorno
			logger.debug("Recuperando data...");
			retValue = new RetornoDTO();
			retValue.setDescripcion(msgError);
			logger.debug("msgError[" + retValue.getDescripcion() + "]");
			retValue.setCodigo(String.valueOf(codError));
			logger.debug("Codigo[" + retValue.getCodigo() + "]");
			retValue.setResultado(true);
			
			
		}
		catch (Exception e) {
			logger.error("Ocurrió un error general al insertar Cobros Adelantados.", e);
			throw new CustomerException("Ocurrió un error general al insertar Cobros Adelantados.",e);
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
		logger.debug("insertarCobroAdelantado():end");
		
		return retValue;
	} // insertarCobroAdelantado
	
	// --------------------------------------------------------------------------------------------------------------------------------------------
}