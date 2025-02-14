package com.tmmas.cl.scl.tol.ServiceBundle.negocio.cliente;

import java.rmi.RemoteException;

import javax.ejb.CreateException;

import org.apache.log4j.Category;

import com.tmmas.cl.framework.exception.ServiceLocatorException;
import com.tmmas.cl.framework.util.ServiceLocator;
import com.tmmas.cl.framework.util.StackTraceUtl;
import com.tmmas.cl.scl.pv.customerorder.commonapp.dto.CustomerAccountDTO;
import com.tmmas.cl.scl.pv.customerorder.commonapp.dto.LimiteConsumoDTO;
import com.tmmas.cl.scl.pv.customerorder.commonapp.dto.OrdenServicioDTO;
import com.tmmas.cl.scl.pv.customerorder.commonapp.dto.ProductDTO;
import com.tmmas.cl.scl.pv.customerorder.commonapp.dto.ProductListDTO;
import com.tmmas.cl.scl.pv.customerorder.commonapp.exception.TOLException;
import com.tmmas.cl.scl.tol.ServiceBundle.negocio.ejb.session.TOLFacade;
import com.tmmas.cl.scl.tol.ServiceBundle.negocio.ejb.session.TOLFacadeHome;

public class ClienteEjb {
	private final Category cat = Category.getInstance(ClienteEjb.class);
	
	private TOLFacade getTOLFacade() throws TOLException
	{
		cat.debug("getTOLFacade():start");
		
		String jndi = "TOL.ejb.TOLFacadeSTLBean";
		cat.debug("Buscando servicio[" + jndi + "]");
		String url = "t3://localhost:7001";
		cat.debug("Url provider[" + url + "]");		
	
		TOLFacadeHome facadeHome = null;

		try {
			facadeHome = (TOLFacadeHome) ServiceLocator
					.getInstance().getRemoteHome(url, jndi,
							TOLFacadeHome.class);
		} catch (ServiceLocatorException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			String log = StackTraceUtl.getStackTrace(e);
			cat.debug("ServiceLocatorException[" + log + "]");
			throw new TOLException(e);
		}

		cat.debug("Recuperada interfaz home de TOL Order facade...");
		TOLFacade facade = null;
		try {
			facade = facadeHome.create();
		} catch (CreateException e) {
			String log = StackTraceUtl.getStackTrace(e);
			cat.debug("CreateException[" + log + "]");
			throw new TOLException(e);
			
		} catch (RemoteException e) {
			String log = StackTraceUtl.getStackTrace(e);
			cat.debug("RemoteException[" + log + "]");
			throw new TOLException(e);
		}

		cat.debug("getTOLFacade()():end");
		return facade;
	}
	
	public static void main(String[] args) {
		ClienteEjb cli = new ClienteEjb();
		TOLFacade bean = null;
		try {
			bean = cli.getTOLFacade();
		} catch (TOLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		/*
	  	  try {
			  ProductListDTO list = new ProductListDTO(); 
			  CustomerAccountDTO cust = new CustomerAccountDTO();
			  cust.setCode(65042029);
			
			  cust.setCodePlanRate("RSL");
			  
			  OrdenServicioDTO os = new OrdenServicioDTO();
			  os.setNumeroAbonado(17136361);
			  ProductDTO[] prdLst = new ProductDTO[1];
			  ProductDTO dto = new ProductDTO();
			  dto.setProfileId("81");
			  prdLst[0]= dto;

			  list.setCustomer(cust);
			  list.setProducts(prdLst);
			  list.setOrdenServicio(os);

			  bean.createLimitProfileService(list);
			} catch (TOLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (RemoteException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}*/		

		/*
	  	  try {
			  ProductListDTO list = new ProductListDTO(); 
			  CustomerAccountDTO cust = new CustomerAccountDTO();
			  cust.setCode(65042029);
			
			  cust.setCodePlanRate("RSL");
			  
			  OrdenServicioDTO os = new OrdenServicioDTO();
			  os.setNumeroAbonado(17136361);
			  ProductDTO[] prdLst = new ProductDTO[1];
			  ProductDTO dto = new ProductDTO();
			  dto.setProfileId("81");
			  prdLst[0]= dto;

			  list.setCustomer(cust);
			  list.setProducts(prdLst);
			  list.setOrdenServicio(os);

			  bean.deleteLimitProfileService(list);
			} catch (TOLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (RemoteException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}*/
		
/*		
	  	  try {
			  ProductListDTO list = new ProductListDTO(); 
			  CustomerAccountDTO cust = new CustomerAccountDTO();
			  cust.setCode(64993940);
			  cust.setCodePlanRate("RSL");
			  
			  OrdenServicioDTO os = new OrdenServicioDTO();
			  os.setNumeroAbonado(17136361);
			  ProductDTO[] prdLst = new ProductDTO[1];
			  ProductDTO dto = new ProductDTO();
			  dto.setId("73");
			  dto.setPriority("2");
			  dto.setExceedId("DPT");
			  prdLst[0]= dto;

			  list.setCustomer(cust);
			  list.setProducts(prdLst);
			  list.setOrdenServicio(os);

			  bean.setServiceBundleAttributes(list);
			} catch (TOLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (RemoteException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}*/		
		
/*		
		try {
			ProductListDTO list = new ProductListDTO();
			CustomerAccountDTO co = new CustomerAccountDTO();
			co.setCode(66001815);
			list.setCustomer(co);
			
			
			ProductDTO p = new ProductDTO();
			//p.set
			
			ProductDTO pl[] = new ProductDTO[]{p};
			list.setProducts(pl);
			list.setProductsDisabled(new ProductDTO[]{});
			
			bean.setServiceBundle(list);
			
		} catch (TOLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (RemoteException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}*/
		
		
		  ProductDTO dto = new ProductDTO();
		  dto.setCodPlan("5444");
		
		try {
			LimiteConsumoDTO[] perf = bean.getServiceLimitProfiles(dto);
			for (int i=0; i<perf.length;i++){
				LimiteConsumoDTO lim = perf[i];
				System.out.println("profileid[" + lim.getProfileId() + "]");
				System.out.println("descprofile[" + lim.getDescProfileId() + "]");
			}
		} catch (TOLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (RemoteException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}		
		
	}
	
	/*
	public static void main(String[] args) {
		ClienteEjb cli = new ClienteEjb();
		TOLFacade bean = null;
		try {
			bean = cli.getTOLFacade();
		} catch (TOLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		try {
			DistribucionBolsaDTO dto = new DistribucionBolsaDTO();
			dto.setCod_cliente("2837464");
		    dto.setNum_abonado("27941661");
		    dto.setCod_limcons("81");
		    dto.setCod_plantarif("RD1");
			
			bean.createStorageAndFreeUnitStock(dto);

		} catch (TOLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (RemoteException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}*/

}
