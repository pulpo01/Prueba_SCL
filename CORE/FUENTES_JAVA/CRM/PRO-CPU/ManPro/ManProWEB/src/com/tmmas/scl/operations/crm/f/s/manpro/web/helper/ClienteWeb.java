package com.tmmas.scl.operations.crm.f.s.manpro.web.helper;

import java.util.HashMap;

public class ClienteWeb {
	
	private HashMap listAbonadoWEB;
	
	public ClienteWeb(String idCliente){
		listAbonadoWEB= new HashMap();
		AbonadoWeb clienteAboWeb = new AbonadoWeb();
		listAbonadoWEB.put(idCliente, clienteAboWeb);
	}
	
	public void AgregarAbonWeb(String idAbonado,AbonadoWeb abonado){
		listAbonadoWEB.put(idAbonado, abonado);
	}

	public void setCodCliente(long frmCodCliente) {
		// TODO Auto-generated method stub
		
	}

}
