package com.tmmas.scl.doblecuenta.businessobject.dao.test;

import com.tmmas.scl.doblecuenta.businessobject.dao.AbonadoDAO;
import com.tmmas.scl.doblecuenta.commonapp.dto.AbonadoDTO;
import com.tmmas.scl.doblecuenta.commonapp.exception.ProyectoException;

public class AbonadoDAOTest extends BaseTest {

	private AbonadoDAO abonadoDAO = new AbonadoDAO();
	
	public void testObtenerListaAbonado() {
		AbonadoDTO abonado = new AbonadoDTO();
		try {
			abonado.setCodCliente("1771525");
			abonado.setNumCelular(null);
            AbonadoDTO[] abonados = abonadoDAO.obtenerListaAbonado(abonado);
			System.out.println("Número de abonados obtenidos: "+abonados.length);
		} catch (ProyectoException e) {
			System.out.println("Error: "+e.getMessage());
		}
	}

}
