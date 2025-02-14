package com.tmmas.cl.scl.spnsclorq.negocio.ejb.helper.validation;

import java.rmi.RemoteException;
import java.util.ArrayList;

import javax.ejb.CreateException;

import org.apache.commons.configuration.CompositeConfiguration;
import org.apache.log4j.Logger;

import com.tmmas.cl.framework.exception.GeneralException;
import com.tmmas.cl.framework.exception.ServiceLocatorException;
import com.tmmas.cl.framework.util.ServiceLocator;
import com.tmmas.cl.framework.util.StackTraceUtl;
import com.tmmas.cl.framework20.util.UtilLog;
import com.tmmas.cl.framework20.util.UtilProperty;
import com.tmmas.cl.scl.commonapp.dto.WsCunetaAltaDeLineaDTO;
import com.tmmas.cl.scl.commonapp.dto.WsLineaInDTO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.PlanTarifarioDTO;
import com.tmmas.cl.scl.gestiondecliente.negocio.ejb.session.GestionDeCliente;
import com.tmmas.cl.scl.gestiondecliente.negocio.ejb.session.GestionDeClienteHome;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.CentralDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.ClienteComDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.CuentaComDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.DatosGeneralesVentaDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.RetornoLineaDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.VendedorDTO;


public class  ValidacionesAltaLinea {
	
	
	private static CompositeConfiguration config = UtilProperty.getConfiguration("SpnSclORQ.properties","com/tmmas/cl/scl/spnsclorq/negocio/ejb/properties/SpnSclORQBean.properties");
	private final static Logger logger = Logger.getLogger(Validaciones.class);	
	
	
	private static GestionDeCliente getGestionDeCliente()
	throws GeneralException {
		UtilLog.setLog(config.getString("SpnSclOrqBean.log"));
		logger.debug("getGestionDeCliente():start");
		GestionDeClienteHome GestionDeClienteHome = null;
		String jndi = config.getString("GestionDeCliente.jndi");
		logger.debug("Buscando servicio[" + jndi + "]");
		String url = config.getString("GestionDeCliente.url.provider");
		logger.debug("Url provider[" + url + "]");

		try {
			GestionDeClienteHome = (GestionDeClienteHome) ServiceLocator.getInstance().getRemoteHome(url, jndi, GestionDeClienteHome.class);
		} catch (ServiceLocatorException e) {
			// TODO Auto-generated catch block
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("ServiceLocatorException[" + log + "]");
			throw new GeneralException(e);
		}

		logger.debug("Recuperada interfaz home de GestionDeCliente...");
		GestionDeCliente GestionDeCliente = null;

		try {
			GestionDeCliente = GestionDeClienteHome.create();
		} catch (CreateException e) {
			//TODO Auto-generated catch block
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("CreateException[" + log + "]");
			throw new GeneralException(e);
		} catch (RemoteException e) {
			// TODO Auto-generated catch block
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + log + "]");
			throw new GeneralException(e);
		}

		logger.debug("getGestionDeCliente()():end");
		return GestionDeCliente;
	}			
	
	
	
	public static CuentaComDTO obtieneCliente(WsCunetaAltaDeLineaDTO CunetaAltaDeLinea) throws GeneralException, RemoteException{
		
		CuentaComDTO  cuentaCom   = new CuentaComDTO();
		ClienteComDTO clienteCom  = new ClienteComDTO();		
		clienteCom.setCodigoCliente(CunetaAltaDeLinea.getCodigoDeCliente());
		cuentaCom.setClienteComDTO(clienteCom); 
		
		cuentaCom = getGestionDeCliente().getcliente(cuentaCom);
		
		
		if (!cuentaCom.getCodigoCuenta().equals(CunetaAltaDeLinea.getCodigoDeCuenta())){
			logger.debug("192266 Error el cliente no pertenece a la cuenta informada - Cuenta Entrada["+CunetaAltaDeLinea.getCodigoDeCuenta()+"] Cuenta Cliente entrada ["+cuentaCom.getCodigoCuenta()+"]");						
			throw new GeneralException("192266",1,"Error el cliente no pertenece a la cuenta informada - Cuenta Entrada["+CunetaAltaDeLinea.getCodigoDeCuenta()+"] Cuenta Cliente entrada ["+cuentaCom.getCodigoCuenta()+"]");								
		}
		
		return cuentaCom;		
	}
	
	
	public static VendedorDTO obtieneVendedor(WsCunetaAltaDeLineaDTO CunetaAltaDeLinea) throws GeneralException, RemoteException{
		
		VendedorDTO vendedor = new VendedorDTO();
		vendedor.setCodigoVendedor(CunetaAltaDeLinea.getLinea().getAntecedentesVenta().getCodigoVendedor());
		
		if ( CunetaAltaDeLinea.getLinea().getAntecedentesVenta().getCodigoDealer() != null){
			logger.debug("Codigo Dealer(): "+CunetaAltaDeLinea.getLinea().getAntecedentesVenta().getCodigoDealer());
		}
		
		if (CunetaAltaDeLinea.getLinea().getAntecedentesVenta().getCodigoDealer().equals("") || CunetaAltaDeLinea.getLinea().getAntecedentesVenta().getCodigoDealer() == null){
			logger.debug("ENTRO AQUI 1 ");
			vendedor.setCodigoVendedorDealer(0);
		}else{
			logger.debug("ENTRO AQUI 2 ");
			vendedor.setCodigoVendedorDealer(Long.parseLong(CunetaAltaDeLinea.getLinea().getAntecedentesVenta().getCodigoDealer()));
		}
		logger.debug("Codigo Dealer FINAL (): "+vendedor.getCodigoVendedorDealer());
		vendedor = getGestionDeCliente().getVendedor(vendedor); 
		
		return vendedor;
	}	
	
	public static ArrayList validaIndicadorAltaCliente(CuentaComDTO cuentaCom, ArrayList listaerrores,PlanTarifarioDTO plantarifario){
		
		RetornoLineaDTO retorno = null; 
		
		if (cuentaCom.getClienteComDTO().getCodigoCiclo() == 25 ){	
			if (!plantarifario.getCodigoTipoPlan().equals("1")){
				logger.debug("112265 Error el cliente es prepago, solo puede activar lineas prepago Ciclo ["+cuentaCom.getClienteComDTO().getCodigoCiclo()+" Cliente ["+cuentaCom.getClienteComDTO().getCodigoCliente()+"] plantarifario.getCodigoTipoPlan() ["+plantarifario.getCodigoTipoPlan()+"]");	
				retorno = new RetornoLineaDTO(); 
				retorno.setCodError("112265");
				retorno.setMensajseError("Error el cliente es prepago, solo puede activar lineas prepago");					
				listaerrores.add(retorno);
			}
		}else{
			if (plantarifario.getCodigoTipoPlan().equals("1")){
				logger.debug("112266 Error el cliente es pospago, solo puede activar lineas pospago Ciclo ["+cuentaCom.getClienteComDTO().getCodigoCiclo()+" Cliente ["+cuentaCom.getClienteComDTO().getCodigoCliente()+"] plantarifario.getCodigoTipoPlan() ["+plantarifario.getCodigoTipoPlan()+"]");	
				retorno = new RetornoLineaDTO(); 
				retorno.setCodError("112266");
				retorno.setMensajseError("Error el cliente es pospago, solo puede activar lineas pospago");					
				listaerrores.add(retorno);
			}

		}
		
		return listaerrores;				
	}
	
	/* CSR-11002
	public static String obtieneIndPortado(WsLineaInDTO linea) throws GeneralException{
		    	
    	if (linea.getCodigoOperador().length() > 0 ){
    		return "1";
    	}else{
    		return "0";
    	}
    					
	}
     */   
	/* CSR-11002
    public static ArrayList validaIndPortado(String IndVenPortado, DatosGeneralesVentaDTO datosVenta, ArrayList listaerrores, int numlinea) throws GeneralException{
    	RetornoLineaDTO retorno = null;
    	    	
    	if (!datosVenta.getIndicadorPortado().equals(IndVenPortado)){
			logger.debug("12265 Error solo puede activar Lineas portadas o no portadas");	
			retorno = new RetornoLineaDTO(); 
			retorno.setCodError("12265");
			retorno.setMensajseError("Error solo puede activar Lineas portadas o no portadas");	
			retorno.setNumLinea(String.valueOf(numlinea+1));
			listaerrores.add(retorno);	
		}
		return listaerrores;    	    	
    }
     */   
    public static ArrayList validaClienteEmpresa(CuentaComDTO cuentaCom, WsCunetaAltaDeLineaDTO CunetaAltaDeLinea, ArrayList listaerrores, int numlinea) throws GeneralException{
    	RetornoLineaDTO retorno = null;
    	    	
    	if (cuentaCom.getClienteComDTO().getTipoCliente().equals("E")){    		    		
			if (!cuentaCom.getClienteComDTO().getPlanTarifario().equals(CunetaAltaDeLinea.getLinea().getLineas()[numlinea].getDatosPlanTerifario().getPlanTarifario())){
				logger.debug("12266 Error solo puede activar un mismo plan para un cliente empresa");
				retorno = new RetornoLineaDTO(); 
				retorno.setCodError("12266");
				retorno.setMensajseError("Error solo puede activar un mismo plan para un cliente empresa");	
				retorno.setNumLinea(String.valueOf(numlinea+1));
				listaerrores.add(retorno);						
			}
		}
    	
		return listaerrores;    	   
    }    
        
    public static CentralDTO getCentralTecnologia(WsCunetaAltaDeLineaDTO CunetaAltaDeLinea, int numlinea) throws GeneralException, RemoteException{
    	
    	CentralDTO Central = new CentralDTO();    	
    	Central.setCodigoCentral(CunetaAltaDeLinea.getLinea().getLineas()[numlinea].getHomeLinea().getCodigCentral());
    	Central.setCodigoCelda(CunetaAltaDeLinea.getLinea().getLineas()[numlinea].getHomeLinea().getCelda());
    	
    	Central =  getGestionDeCliente().getCentralTecnologia(Central);			
		    	
		return Central;    	   
    }
    
    
    public static void ValidaUsuarioSCL(String nomUsuario)throws GeneralException, RemoteException{
    	  
    	getGestionDeCliente().ValidaUsuarioSCL(nomUsuario);			
		    	    	   
    }    

}
