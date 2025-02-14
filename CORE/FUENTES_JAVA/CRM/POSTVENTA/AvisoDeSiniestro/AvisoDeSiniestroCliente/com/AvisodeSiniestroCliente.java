package com;

import java.util.Hashtable;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.rmi.PortableRemoteObject;

import com.tmmas.scl.framework.ProductDomain.dto.CambioPlanPendienteDTO;
import com.tmmas.scl.operation.crm.fab.cusintman.avisinie.bean.ejb.session.AvisoDeSiniestroFacade;
import com.tmmas.scl.operation.crm.fab.cusintman.avisinie.bean.ejb.session.AvisoDeSiniestroFacadeHome;

public class AvisodeSiniestroCliente {

	/**
	 * @param args
	 */
	public static void main(String[] args) throws Exception{
		Hashtable env = new Hashtable();
		System.out.println("0");
		
		//env.put(Context.INITIAL_CONTEXT_FACTORY, "com.evermind.server.ApplicationClientInitialContextFactory");
		env.put(Context.INITIAL_CONTEXT_FACTORY, "oracle.j2ee.rmi.RMIInitialContextFactory");		
		env.put(Context.PROVIDER_URL, "ormi://localhost:12401/AvisoDeSiniestroEJBEAR");
		env.put(Context.SECURITY_PRINCIPAL, "oc4jadmin");
		env.put(Context.SECURITY_CREDENTIALS, "oc4jadmin");		
		
		System.out.println("1");
		
		Context context = new InitialContext(env);
		System.out.println("2");
		
		Object obj = context.lookup("AvisoDeSiniestroFacade");
		System.out.println("3");
		

		AvisoDeSiniestroFacadeHome home =
		(AvisoDeSiniestroFacadeHome) PortableRemoteObject.narrow(obj, AvisoDeSiniestroFacadeHome.class);
		System.out.println("4");
		

		AvisoDeSiniestroFacade srv = home.create();
		
		CambioPlanPendienteDTO dto = new CambioPlanPendienteDTO();
		dto.setCod_cliente(1);
		dto.setNum_abonado(1);
		
		System.out.println("5");

		CambioPlanPendienteDTO resultado = srv.validarCambioPlanPendiente(dto);
		
		System.out.println("6");
		
		System.out.println("getCod_retorno()[" + resultado.getCod_retorno() + "]");
		System.out.println("getGlosa_retorno()[" + resultado.getGlosa_retorno() + "]");		

	}

}
