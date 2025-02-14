package com;

import java.util.Date;
import java.util.Hashtable;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.rmi.PortableRemoteObject;

import com.tmmas.scl.vendedor.dto.ConfiguracionVendedorCPUDTO;
import com.tmmas.scl.vendedor.dto.UsuarioSistemaDTO;
import com.tmmas.scl.vendedor.dto.UsuarioVendedorDTO;
import com.tmmas.scl.vendedor.dto.VendedorDTO;
import com.tmmas.scl.vendedor.negocio.ejb.session.VendedorFacadeSTL;
import com.tmmas.scl.vendedor.negocio.ejb.session.VendedorFacadeSTLHome;

public class VendedorClient {

	/**
	 * @param args
	 */
	public static void main(String[] args) throws Exception {
		Hashtable env = new Hashtable();
		System.out.println("0");
		
		//env.put(Context.INITIAL_CONTEXT_FACTORY, "com.evermind.server.ApplicationClientInitialContextFactory");
		env.put(Context.INITIAL_CONTEXT_FACTORY, "oracle.j2ee.rmi.RMIInitialContextFactory");		
		env.put(Context.PROVIDER_URL, "ormi://localhost:12401/VendedorEJBEAR");
		env.put(Context.SECURITY_PRINCIPAL, "jlopez");
		env.put(Context.SECURITY_CREDENTIALS, "jlopez2008");	
		env.put(Context.SECURITY_PRINCIPAL, "");
		env.put(Context.SECURITY_CREDENTIALS, "");		
		env.put(Context.SECURITY_PRINCIPAL, "oc4jadmin");
		env.put(Context.SECURITY_CREDENTIALS, "oc4jadmin");		
		
		System.out.println("1");
		
		Context context = new InitialContext(env);
		System.out.println("2");
		
		Object obj = context.lookup("VendedorFacadeSTL");
		System.out.println("3");
		

		VendedorFacadeSTLHome home =
		(VendedorFacadeSTLHome) PortableRemoteObject.narrow(obj, VendedorFacadeSTLHome.class);
		System.out.println("4");
		

		VendedorFacadeSTL srv = home.create();
		
		VendedorDTO dto = new VendedorDTO();
		dto.setCod_vendedor("105269");
			
		dto.setCod_vendedor("");
		dto.setCod_vendedor("102116");
		dto.setCod_vendedor("140003");
		dto.setCod_vendedor("100121");
		dto.setCod_vendedor("140003");
		dto.setCod_vendedor("");
		dto.setInd_interno(true);
		
		System.out.println("5");
/*
		VendedorDTO resultado = srv.recuperarInformacionVendedor(dto);
		System.out.println("getCod_vendedor()[" + resultado.getCod_vendedor() + "]");
		System.out.println("getNom_vendedor()[" + resultado.getNom_vendedor() + "]");	
		System.out.println("getCod_vendealer()[" + resultado.getCod_vendealer() + "]");
		System.out.println("getNom_vendealer()[" + resultado.getNom_vendealer() + "]");				
		System.out.println("isInd_interno()[" + resultado.isInd_interno() + "]");				
		
		System.out.println("getCod_oficina()[" + resultado.getCod_oficina() + "]");
		System.out.println("getNom_oficina()[" + resultado.getNom_oficina() + "]");
		System.out.println("getCod_tipcomis()[" + resultado.getCod_tipcomis() + "]");	
		System.out.println("getNom_tipcomis()[" + resultado.getNom_tipcomis() + "]");
		
		System.out.println("getNumOOSS()[" + resultado.getNumOOSS() + "]");	
		System.out.println("getUsuario()[" + resultado.getUsuario() + "]");
		System.out.println("getFecha()[" + resultado.getFecha() + "]");
		System.out.println("getCod_os()[" + resultado.getCod_os() + "]");
		System.out.println("getSub_tipo()[" + resultado.getSub_tipo() + "]");		
		
		System.out.println("getCod_region()[" + resultado.getCod_region() + "]");	
		System.out.println("getDes_region()[" + resultado.getDes_region() + "]");
		System.out.println("getCod_provincia()[" + resultado.getCod_provincia() + "]");
		System.out.println("getDes_provincia()[" + resultado.getDes_provincia() + "]");
		System.out.println("getCod_ciudad()[" + resultado.getCod_ciudad() + "]");					
		System.out.println("getDes_ciudad()[" + resultado.getDes_ciudad() + "]");*/
		
		
		System.out.println("6");
		
		/**
		dto = new VendedorDTO();
		dto.setCod_vendedor("01");
		dto.setCod_vendealer("02");
		dto.setInd_interno(true);
		dto.setCod_oficina("01");
		dto.setCod_tipcomis("02");
		dto.setNumOOSS("001");
		dto.setUsuario("jlopez");
		dto.setFecha(new Date());
		dto.setCod_os("00");
		dto.setSub_tipo("90");
		srv.registrarInformacionVendedor(dto);
		**/
		
		
		ConfiguracionVendedorCPUDTO config = new ConfiguracionVendedorCPUDTO();
		config.setCod_ooss("40006");
		config.setCombinatoria("PREPAGOPREPAGO");
		config.setCombinatoria("");
		ConfiguracionVendedorCPUDTO res = srv.recuperarConfiguracionVendedorCPU(config);
		System.out.println("res[" + res.getFlag_estado() + "]");
		
		
		UsuarioSistemaDTO usuarioSistema = new UsuarioSistemaDTO();
		usuarioSistema.setNom_usuario("CERVENTAS");
		UsuarioVendedorDTO resultado = srv.obtenerInformacionUsuarioVendedor(usuarioSistema);
		usuarioSistema = resultado.getUsuario();
		VendedorDTO vendedor = resultado.getVendedor();
		System.out.println("Usuario--------------------------");
		System.out.println("getNom_usuario()[" + usuarioSistema.getNom_usuario() + "]");
		System.out.println("getNom_operador()[" + usuarioSistema.getNom_operador() + "]");
		System.out.println("getInd_adm()[" + usuarioSistema.getInd_adm() + "]");
		System.out.println("getCod_oficina()[" + usuarioSistema.getCod_oficina() + "]");
		System.out.println("getCod_tipcomis()[" + usuarioSistema.getCod_tipcomis() + "]");
		System.out.println("getCod_vendedor()[" + usuarioSistema.getCod_vendedor() + "]");
		System.out.println("getInd_excep_eriesgo()[" + usuarioSistema.getInd_excep_eriesgo() + "]");
		System.out.println("getDes_ofician()[" + usuarioSistema.getDes_ofician() + "]");
		System.out.println("getCod_comuna()[" + usuarioSistema.getCod_comuna() + "]");
		System.out.println("getDes_comuna()[" + usuarioSistema.getDes_comuna() + "]");	
		System.out.println("getCall_center()[" + usuarioSistema.getCall_center() + "]");
		
		System.out.println("Vendedor--------------------------");		
		System.out.println("getCod_vendedor()[" + vendedor.getCod_vendedor() + "]");
		System.out.println("getNom_vendedor()[" + vendedor.getNom_vendedor() + "]");	
		System.out.println("getCod_vendealer()[" + vendedor.getCod_vendealer() + "]");
		System.out.println("getNom_vendealer()[" + vendedor.getNom_vendealer() + "]");				
		System.out.println("isInd_interno()[" + vendedor.isInd_interno() + "]");				
		
		System.out.println("getCod_oficina()[" + vendedor.getCod_oficina() + "]");
		System.out.println("getNom_oficina()[" + vendedor.getNom_oficina() + "]");
		System.out.println("getCod_tipcomis()[" + vendedor.getCod_tipcomis() + "]");	
		System.out.println("getNom_tipcomis()[" + vendedor.getNom_tipcomis() + "]");
		
		
		System.out.println("getCod_region()[" + vendedor.getCod_region() + "]");	
		System.out.println("getDes_region()[" + vendedor.getDes_region() + "]");
		System.out.println("getCod_provincia()[" + vendedor.getCod_provincia() + "]");
		System.out.println("getDes_provincia()[" + vendedor.getDes_provincia() + "]");
		System.out.println("getCod_ciudad()[" + vendedor.getCod_ciudad() + "]");					
		System.out.println("getDes_ciudad()[" + vendedor.getDes_ciudad() + "]");		
		

		
		
	}

}
