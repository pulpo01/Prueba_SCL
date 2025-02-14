package com.tmmas.scl.doblecuenta.businessobject.dao.test;

import com.tmmas.scl.doblecuenta.businessobject.dao.ClienteDAO;
import com.tmmas.scl.doblecuenta.commonapp.dto.ClienteDTO;
import com.tmmas.scl.doblecuenta.commonapp.dto.ClientesAsociadosDTO;
import com.tmmas.scl.doblecuenta.commonapp.exception.ProyectoException;


public class ClienteDAOTest extends BaseTest {

	private ClienteDAO clienteDAO = new ClienteDAO();

	public void testObtenerListaClientesAsociados() {
		ClienteDTO cliente = new ClienteDTO();
		try {
			cliente.setCodCliente(1771525);
			cliente.setNumIdent("123");
			cliente.setNomCliente("nom");
			cliente.setNomApeClien1("ap1");
			cliente.setNomApeClien2("ap2");
			cliente.setCodCiclo(2);
			ClienteDTO[] clientes = clienteDAO.obtenerListaClientesAsociados(cliente);
			System.out.println("Cantidad de clientes: "+clientes.length);
		} catch (ProyectoException e) {
			System.out.println("Error: "+e.getMessage());
		}
	}

	public void testObtenerInformacionCliente() {
		ClienteDTO cliente = new ClienteDTO();
		try {
			cliente.setCodClienteContra(1771525);
			ClienteDTO cliente2 = clienteDAO.obtenerInformacionCliente(cliente);
			System.out.println("Nombre cliente: "+cliente2.getNomCliente());
			System.out.println("Primer apellido cliente: "+cliente2.getNomApeClien1());
			System.out.println("Segundo apellido cliente: "+cliente2.getNomApeClien2());
		} catch (ProyectoException e) {
			System.out.println("Error: "+e.getMessage());
		}
	}

	public void testBuscarClientesAsociados() {
		ClienteDTO cliente = new ClienteDTO();
		try {
			cliente.setCodClienteContra(1771525);
			ClientesAsociadosDTO[] clientesAsociados = clienteDAO.buscarClientesAsociados(cliente);
			System.out.println("Cantidad de clientes asociados: "+clientesAsociados.length);
		} catch (ProyectoException e) {
			System.out.println("Error: "+e.getMessage());
		}
	}

}
