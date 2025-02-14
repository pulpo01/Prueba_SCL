package com.tmmas.cl.scl.ss911correofax.bo.interfaces;

import com.tmmas.cl.framework.exception.GeneralException;
import com.tmmas.cl.scl.ss911correofax.dto.CodigosDTO;
import com.tmmas.cl.scl.ss911correofax.dto.ContactoAbonadoTT;
import com.tmmas.cl.scl.ss911correofax.dto.GaContactoAbonadoTO;
import com.tmmas.cl.scl.ss911correofax.dto.GaContactoAbonadoToDTO;
import com.tmmas.cl.scl.ss911correofax.dto.ParametrosGeneralesDTO;
import com.tmmas.cl.scl.ss911correofax.dto.DireccionNegocioWebDTO;

public interface ServSupl911CorreoFaxBOIT {
	
	public void insertUpdateDeleteGaContactoAbonadoTO(GaContactoAbonadoToDTO gaContactoAbonadoTO)throws GeneralException; 
	public CodigosDTO[] getListCodigos(CodigosDTO entrada)throws GeneralException;
	public ContactoAbonadoTT[] obtenerListaContactos(ContactoAbonadoTT contactoAbonadoTTs) throws GeneralException;
	public void deleteInsertPvContactoAbonadoTT(ContactoAbonadoTT[] contactoAbonadoTTs)throws GeneralException;
	public ParametrosGeneralesDTO getParametroGeneral(ParametrosGeneralesDTO entrada) throws GeneralException;
	public void setDireccion(DireccionNegocioWebDTO entrada) throws GeneralException;
	public void setGaContTHDelGaContTO_DelDireccion(GaContactoAbonadoTO gaContactoAbonadoTO)throws GeneralException;
}
