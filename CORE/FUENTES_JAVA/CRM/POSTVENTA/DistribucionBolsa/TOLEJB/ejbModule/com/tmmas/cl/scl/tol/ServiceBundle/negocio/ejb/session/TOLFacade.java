/**
 * Copyright © 2006 Telef&oacute;nica M&oacute;viles Soluciones y Aplicaciones, SA.
 * Av. Del Condor 720, Huechuraba, Santiago de Chile, Chile
 * Todos los derechos reservados.
 *
 * Este software es informaci&oacute;n propietaria y confidencial de TM-mAs SA.
 * Usted no debe develar tal información y s&oactute;lo debe usarla en concordancia
 * con los t&eacute;rminos de derechos de licencias que sean adquiridos con TM-mAs.
 *
 * Fecha ------------------- Autor  ------------------------- Cambios ----------
 * 25/08/2006     Ricardo Fernandez              					Versión Inicial
 */
package com.tmmas.cl.scl.tol.ServiceBundle.negocio.ejb.session;

import java.rmi.RemoteException;

import javax.ejb.EJBObject;

import com.tmmas.cl.scl.pv.customerorder.commonapp.dto.BolsaAbonadoDTO;
import com.tmmas.cl.scl.pv.customerorder.commonapp.dto.CustomerAccountDTO;
import com.tmmas.cl.scl.pv.customerorder.commonapp.dto.DistribucionBolsaDTO;
import com.tmmas.cl.scl.pv.customerorder.commonapp.dto.LimiteConsumoDTO;
import com.tmmas.cl.scl.pv.customerorder.commonapp.dto.ProductDTO;
import com.tmmas.cl.scl.pv.customerorder.commonapp.dto.ProductListDTO;
import com.tmmas.cl.scl.pv.customerorder.commonapp.exception.TOLException;

public interface TOLFacade extends EJBObject {
	public void setServiceBundle(ProductListDTO list) throws TOLException, RemoteException;
	public void installServiceBundle(ProductListDTO list) throws TOLException, RemoteException;
	public void uninstallServiceBundle(ProductListDTO list) throws TOLException, RemoteException;
	
	public void createStorageAndFreeUnitStock(DistribucionBolsaDTO dto) throws TOLException, RemoteException;
	public void deleteStorageAndFreeUnitStock(DistribucionBolsaDTO dto) throws TOLException, RemoteException;
	public void deleteFreeUnitStock(DistribucionBolsaDTO dto) throws TOLException, RemoteException;
	public LimiteConsumoDTO[] getServiceLimitProfiles(ProductDTO prod) throws TOLException, RemoteException;
	public BolsaAbonadoDTO[] getFreeUnitStock(CustomerAccountDTO dto) throws TOLException, RemoteException;
	public void setServiceBundleAttributes(ProductListDTO prodList) throws TOLException, RemoteException;
	public void setFreeUnitStock(DistribucionBolsaDTO dto) throws TOLException, RemoteException;		
	public CustomerAccountDTO getFreeUnitBagId(CustomerAccountDTO dto) throws TOLException, RemoteException;	
}
