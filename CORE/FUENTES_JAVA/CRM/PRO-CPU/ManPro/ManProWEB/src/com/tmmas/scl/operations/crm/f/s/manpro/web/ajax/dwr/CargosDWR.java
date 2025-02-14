package com.tmmas.scl.operations.crm.f.s.manpro.web.ajax.dwr;

import java.util.ArrayList;
import java.util.Iterator;

import javax.servlet.http.HttpSession;

import uk.ltd.getahead.dwr.WebContextFactory;

import com.tmmas.scl.operations.crm.f.s.manpro.frmk.dataTransferObject.CargoWebDTO;

public class CargosDWR 
{
	public CargosDWR()
	{
		
	}
	
	public ArrayList getDescuentos(String codConcepto)
	{
		
		HttpSession session = WebContextFactory.get().getSession();
		ArrayList listaCargos=new ArrayList();
		ArrayList listaDescuentos=new ArrayList();
		
		listaCargos=(ArrayList)session.getAttribute("ListaCargosMostrados");
		
		if(listaCargos!=null)
		{
			Iterator it=listaCargos.iterator();
			
			while(it.hasNext())
			{
				CargoWebDTO dtoCargoWeb=(CargoWebDTO)it.next();	
				
				if(codConcepto.equalsIgnoreCase(dtoCargoWeb.getCodConcepto()))
				{
					for(int i=0;i<dtoCargoWeb.getDescuentos().getDescuentoList().length;i++)
					{
						listaDescuentos.add(dtoCargoWeb.getDescuentos().getDescuentoList()[i]);
					}
				}
			}
		}
		
		return listaDescuentos;
	}

}
