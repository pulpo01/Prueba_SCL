package com.tmmas.scl.serviciospostventasiga.businessobject.bo;

import com.tmmas.cl.framework.exception.GeneralException;
import com.tmmas.scl.serviciospostventasiga.businessobject.dao.BajaAbonadoPrepagoDAO;
import com.tmmas.scl.serviciospostventasiga.transport.AbonadoVtaDTO;

public class BajaAbonadoPrepagoBO {

	BajaAbonadoPrepagoDAO bajaDAO = new BajaAbonadoPrepagoDAO();
	
	public Boolean getAbonadoMigrado(AbonadoVtaDTO abonado)throws GeneralException
	{
		return bajaDAO.getAbonadoMigrado(abonado);
	}
	
	public String getCausaBaja()throws GeneralException
	{
		return bajaDAO.getCausaBaja();
	}
	
	public void bajaServSuplabo(AbonadoVtaDTO abonado)throws GeneralException
	{
		bajaDAO.bajaServSuplabo(abonado);
	}
	
	public void elimServSuplAmist(AbonadoVtaDTO abonado)throws GeneralException
	{
		bajaDAO.elimServSuplAmist(abonado);
	}
	
	public void updAbonadoPrepago(AbonadoVtaDTO abonado)throws GeneralException
	{
		bajaDAO.updAbonadoPrepago(abonado);
	}
	
	public void getNumAbonadoAboamist(AbonadoVtaDTO abonado)throws GeneralException
	{
		bajaDAO.getNumAbonadoAboamist(abonado);
	}
}
