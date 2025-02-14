package com.tmmas.scl.doblecuenta.ajax.dwr;

import java.util.ArrayList;
import java.util.Iterator;

import javax.servlet.http.HttpSession;
import com.tmmas.scl.doblecuenta.commonapp.dto.AbonadoDTO;
import com.tmmas.scl.doblecuenta.commonapp.dto.ClienteDTO;


import uk.ltd.getahead.dwr.ExecutionContext;
public class ClienteDWR {
	
	public String validaAbonRepetido(String numCelu)
	{
		
		HttpSession session = ExecutionContext.get().getHttpServletRequest().getSession();		
		ArrayList listaAbonados=new ArrayList();
		listaAbonados = (ArrayList)session.getAttribute("listaAbonados");
		String repetido="";
		String numerocelular="";
		if(listaAbonados!=null)
		{
			Iterator it=listaAbonados.iterator();
			AbonadoDTO abonadoDTO = new AbonadoDTO();
			
		 while(it.hasNext())
			{
			 abonadoDTO=(AbonadoDTO)it.next();
			 numerocelular=String.valueOf(abonadoDTO.getNumCelular());	
				
				if(numCelu.equals(numerocelular))
				 {
					repetido="numeroCelularRepetido";
				
				 }else{
					 
					 repetido="numeroCelularNoRepetido"; 
				 }
				
			}
		}
		
		return repetido;
	}
	

	
	
	public String validaClienRepetido(String codCliente)
	{
		
		HttpSession session = ExecutionContext.get().getHttpServletRequest().getSession();		
		ArrayList listaCliente=new ArrayList();
		listaCliente = (ArrayList)session.getAttribute("listaClienteAsociados");
		String repetidoCli="";
		String codigoCli="";
		if(listaCliente!=null)
		{
			Iterator it=listaCliente.iterator();
			ClienteDTO clienteDTO = new ClienteDTO();
			
		 while(it.hasNext())
			{
			 clienteDTO=(ClienteDTO)it.next();
			 codigoCli=String.valueOf(clienteDTO.getCodCliente());	
				
				if(codCliente.equals(codigoCli))
				 {
					repetidoCli="codigoClienteRepetido";
				
				 }else{
					 
					 repetidoCli="codigoClienteNoRepetido"; 
				 }
				
			}
		}
		
		return repetidoCli;
	}	
	
	
	
	
	
	

}
