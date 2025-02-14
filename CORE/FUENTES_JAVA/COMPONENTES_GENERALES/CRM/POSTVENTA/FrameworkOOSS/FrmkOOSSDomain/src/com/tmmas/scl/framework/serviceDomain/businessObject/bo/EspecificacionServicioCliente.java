package com.tmmas.scl.framework.serviceDomain.businessObject.bo;

import java.util.ArrayList;

import org.apache.log4j.Logger;

import com.tmmas.cl.framework.base.ConnectionDAO;
import com.tmmas.cl.framework.util.ArrayUtl;
import com.tmmas.scl.framework.productDomain.dataTransferObject.EspecProductoDTO;
import com.tmmas.scl.framework.serviceDomain.businessObject.bo.interfaces.EspecificacionPlanTasacionBOFactoryIT;
import com.tmmas.scl.framework.serviceDomain.businessObject.bo.interfaces.EspecificacionPlanTasacionIT;
import com.tmmas.scl.framework.serviceDomain.businessObject.bo.interfaces.EspecificacionServicioAltamiraBOFactoryIT;
import com.tmmas.scl.framework.serviceDomain.businessObject.bo.interfaces.EspecificacionServicioAltamiraIT;
import com.tmmas.scl.framework.serviceDomain.businessObject.bo.interfaces.EspecificacionServicioClienteIT;
import com.tmmas.scl.framework.serviceDomain.businessObject.bo.interfaces.EspecificacionServicioListaBOFactoryIT;
import com.tmmas.scl.framework.serviceDomain.businessObject.bo.interfaces.EspecificacionServicioListaIT;
import com.tmmas.scl.framework.serviceDomain.businessObject.bo.interfaces.EspecificacionServicioPromAtlantidaBOFactoryIT;
import com.tmmas.scl.framework.serviceDomain.businessObject.bo.interfaces.EspecificacionServicioPromAtlantidaIT;
import com.tmmas.scl.framework.serviceDomain.businessObject.dao.EspecificacionServicioClienteDAO;
import com.tmmas.scl.framework.serviceDomain.businessObject.dao.interfaces.EspecificacionServicioClienteDAOIT;
import com.tmmas.scl.framework.serviceDomain.businessObject.helper.Global;
import com.tmmas.scl.framework.serviceDomain.dataTransferObject.EspecPlanTasacionListDTO;
import com.tmmas.scl.framework.serviceDomain.dataTransferObject.EspecPromAtlantidaListDTO;
import com.tmmas.scl.framework.serviceDomain.dataTransferObject.EspecProvisionamientoListDTO;
import com.tmmas.scl.framework.serviceDomain.dataTransferObject.EspecServicioAltamiraListDTO;
import com.tmmas.scl.framework.serviceDomain.dataTransferObject.EspecServicioClienteDTO;
import com.tmmas.scl.framework.serviceDomain.dataTransferObject.EspecServicioClienteListDTO;
import com.tmmas.scl.framework.serviceDomain.dataTransferObject.EspecServicioListaDTO;
import com.tmmas.scl.framework.serviceDomain.dataTransferObject.EspecServicioListaListDTO;
import com.tmmas.scl.framework.serviceDomain.dataTransferObject.ReglasListaNumerosListDTO;
import com.tmmas.scl.framework.serviceDomain.exception.ServiceSpecEntitiesException;

public class EspecificacionServicioCliente extends ConnectionDAO implements EspecificacionServicioClienteIT 
{
	
	
	private EspecificacionPlanTasacionBOFactoryIT espPlanTasFactory=new  EspecificacionPlanTasacionBOFactory();
	private EspecificacionPlanTasacionIT espPlanTasBO=espPlanTasFactory.getBusinessObject1();
	
	private EspecificacionServicioPromAtlantidaBOFactoryIT espSerProAtlFactory = new EspecificacionServicioPromAtlantidaBOFactory();
	private EspecificacionServicioPromAtlantidaIT espSerProAtlBO=espSerProAtlFactory.getBusinessObject();
	
	private EspecificacionServicioAltamiraBOFactoryIT espSerAltFactory=new EspecificacionServicioAltamiraBOFactory();
	private EspecificacionServicioAltamiraIT espSerAltBO= espSerAltFactory.getBusinessObject1();
	
	private EspecificacionServicioListaBOFactoryIT espServList = new EspecificacionServicioListaBOFactory();
	private EspecificacionServicioListaIT espServListBO = espServList.getBusinessObject();

		
	private final Logger logger = Logger.getLogger(CategoriasNumeroDestino.class);
	private Global global = Global.getInstance();
	
	EspecificacionServicioClienteDAOIT espServClienteDAO=new EspecificacionServicioClienteDAO();
	
	
	public EspecProductoDTO obtenerEspecificacionServicioCliente(EspecProductoDTO especProducto) throws ServiceSpecEntitiesException 
	{		
		EspecPlanTasacionListDTO   subRetorno1=null;
		EspecPromAtlantidaListDTO  subRetorno2=null;
		EspecServicioAltamiraListDTO subRetorno3=null;
		EspecServicioListaListDTO subRetorno4=null;
		
		ArrayList especServicioClienteAA=new ArrayList();		
		ArrayList especServicioClienteATL=new ArrayList();
		ArrayList especServicioClienteTOL=new ArrayList();
		ArrayList especServicioClienteLST=new ArrayList();
		
		EspecServicioClienteListDTO espSerCliList=new EspecServicioClienteListDTO();	
		
		logger.debug("Inicio:obtenerEspecificacionServicioCliente()");
		espSerCliList = espServClienteDAO.obtenerEspecificacionServicioCliente(especProducto);
		
		
		EspecServicioClienteDTO aux=null;
		EspecServicioClienteDTO[] listAA=null;
		EspecServicioClienteDTO[] listATL=null;
		EspecServicioClienteDTO[] listTOL=null;
		EspecServicioClienteDTO[] listLST=null;
		
		for(int i=0;(espSerCliList.getEspServCliList()!=null && i<espSerCliList.getEspServCliList().length);i++)
		{
			aux=espSerCliList.getEspServCliList()[i];
			
			if("AA".equalsIgnoreCase(aux.getTipoServicio()))			
				especServicioClienteAA.add(aux);						
			else if("ATL".equalsIgnoreCase(aux.getTipoServicio()))
				especServicioClienteATL.add(aux);
			else if("TOL".equalsIgnoreCase(aux.getTipoServicio()))
			{
				if(aux.getCodPerfilLista()!=null && !"".equals(aux.getCodPerfilLista()))
					especServicioClienteLST.add(aux);				
			}
		}
		
		 listAA= (EspecServicioClienteDTO[]) ArrayUtl.copiaArregloTipoEspecifico(especServicioClienteAA.toArray(), EspecServicioClienteDTO.class);		 
		 listATL=(EspecServicioClienteDTO[]) ArrayUtl.copiaArregloTipoEspecifico(especServicioClienteATL.toArray(), EspecServicioClienteDTO.class);
		 //listTOL=(EspecServicioClienteDTO[]) ArrayUtl.copiaArregloTipoEspecifico(especServicioClienteTOL.toArray(), EspecServicioClienteDTO.class);
		 listLST=(EspecServicioClienteDTO[]) ArrayUtl.copiaArregloTipoEspecifico(especServicioClienteLST.toArray(), EspecServicioClienteDTO.class);
		
		EspecServicioClienteListDTO especServicioClienteAAList= new EspecServicioClienteListDTO();
		especServicioClienteAAList.setEspServCliList(listAA);
		EspecServicioClienteListDTO especServicioClienteATLList=new EspecServicioClienteListDTO();
		especServicioClienteATLList.setEspServCliList(listATL);
		//EspecServicioClienteListDTO especServicioClienteTOLList=new EspecServicioClienteListDTO();
		//especServicioClienteTOLList.setEspServCliList(listTOL);
		EspecServicioClienteListDTO especServicioClienteLSTList=new EspecServicioClienteListDTO();
		especServicioClienteLSTList.setEspServCliList(listLST);		
		
		
		//subRetorno1=espPlanTasBO.obtenerEspecPlanTasacion(especServicioClienteTOLList);		
		//subRetorno2=espSerProAtlBO.obtenerEspecServicioAtlantida(especServicioClienteATLList);
		subRetorno3=espSerAltBO.obtenerEspecServicioAltamira(especServicioClienteAAList);
		subRetorno4=espServListBO.obtenerEspecServicioLista(especServicioClienteLSTList);
		
		//espSerCliList.setEspecPlanTasList(subRetorno1);
		espSerCliList.setEspecPromAtlList(subRetorno2);
		espSerCliList.setEspecSerAltList(subRetorno3);
		espSerCliList.setEspecSerLisList(subRetorno4);		
		
		especProducto.setEspecServicioClienteList(espSerCliList);
		
		logger.debug("Fin:obtenerEspecificacionServicioCliente()");
		return especProducto;
	}

	public EspecProvisionamientoListDTO obtenerEspecificacionesProvisionamiento(EspecServicioClienteListDTO espServCliList) throws ServiceSpecEntitiesException 
	{
		EspecProvisionamientoListDTO resultado=null;
		logger.debug("Inicio:obtenerEspecificacionesProvisionamiento()");
		resultado = espServClienteDAO.obtenerEspecificacionesProvisionamiento(espServCliList);
		logger.debug("Fin:obtenerEspecificacionesProvisionamiento()");
		return resultado;
	}
	
	public ReglasListaNumerosListDTO obtenerEspecificacionServicioLista(EspecServicioListaDTO especServicioLista) throws ServiceSpecEntitiesException 
	{		
		ReglasListaNumerosListDTO  resultado = null;
		logger.debug("Inicio:obtenerEspecificacionServicioLista()");		
		resultado = espServListBO.obtenerReglasValidacion(especServicioLista);
		logger.debug("Fin:obtenerEspecificacionServicioLista()");
		return resultado;
	}

}
