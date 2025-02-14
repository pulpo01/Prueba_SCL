package com.tmmas.scl.operations.crm.fab.cim.manreq.frmk.dataTransferObject;

import java.util.ArrayList;
import java.util.Iterator;

import org.apache.log4j.Logger;

import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.ClienteDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.AbonadoDTO;


public class ClienteFrmkDTO {
	private long idCliente;
	private String nombre;
	private String apellidoPaterno;
	private String apellidoMaterno;
	private String codCategoria;
	private ArrayList abonadoDTOWeb;
	private ClienteDTO clienteDTO;
	
	private final Logger logger = Logger.getLogger(ClienteFrmkDTO.class);
	

	public ClienteFrmkDTO(ClienteDTO clienteDTO) {
		// TODO Auto-generated constructor stub
		this.clienteDTO = clienteDTO;
		nombre = clienteDTO.getNombres();
		apellidoPaterno = clienteDTO.getApellido1();
		apellidoMaterno = clienteDTO.getApellido2();
		idCliente = clienteDTO.getCodCliente();
		abonadoDTOWeb = new ArrayList();

		
		AbonadoDTO[] abonados = clienteDTO.getAbonados().getAbonados();
		for(int i = 0; i < clienteDTO.getAbonados().getAbonados().length; i++)
		{						
			abonadoDTOWeb.add(new AbonadoFrmkDTO(
										abonados[i].getNumAbonado(), 
										abonados[i].getNumCelular(), 
										abonados[i].getNombre(),
										clienteDTO.getCodCliente()
										));
			logger.debug("Abonado =>" + abonados[i].getNombre());
		} 
	}
	public ArrayList getListadoAbonados() {
		return abonadoDTOWeb;
	}
//	public void setAbonadoDTO(ArrayList abonadoDTO) {
//		this.abonadoDTO = abonadoDTO;
//	}
	public String getApellidoMaterno() {
		return apellidoMaterno;
	}
	public void setApellidoMaterno(String apellidoMaterno) {
		this.apellidoMaterno = apellidoMaterno;
	}
	public String getApellidoPaterno() {
		return apellidoPaterno;
	}
	public void setApellidoPaterno(String apellidoPaterno) {
		this.apellidoPaterno = apellidoPaterno;
	}
	public String getCodCategoria() {
		return codCategoria;
	}
	public void setCodCategoria(String codCategoria) {
		this.codCategoria = codCategoria;
	}
	public long getIdCliente() {
		return idCliente;
	}
	public void setIdCliente(long idCliente) {
		this.idCliente = idCliente;
	}
	public String getNombre() {
		return nombre;
	}
	public void setNombre(String nombre) {
		this.nombre = nombre;
	}
	public AbonadoFrmkDTO getAbonado(long idAbonado) {	
		Iterator lista = abonadoDTOWeb.iterator();
		AbonadoFrmkDTO abonado;
		while (lista.hasNext())
		{
			abonado = (AbonadoFrmkDTO) lista.next();
			if (abonado.getIdAbonado()==idAbonado){
				return abonado;
			}
		}
		return null;		
	}
	
	
}
