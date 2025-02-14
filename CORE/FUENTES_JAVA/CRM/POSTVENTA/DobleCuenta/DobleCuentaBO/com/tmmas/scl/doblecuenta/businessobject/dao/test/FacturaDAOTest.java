package com.tmmas.scl.doblecuenta.businessobject.dao.test;

import java.util.Date;

import com.tmmas.scl.doblecuenta.businessobject.dao.FacturaDAO;
import com.tmmas.scl.doblecuenta.commonapp.dto.AbonadoDTO;
import com.tmmas.scl.doblecuenta.commonapp.dto.ClienteDTO;
import com.tmmas.scl.doblecuenta.commonapp.dto.ConceptoDTO;
import com.tmmas.scl.doblecuenta.commonapp.dto.FacturaDTO;
import com.tmmas.scl.doblecuenta.commonapp.dto.RetornoDTO;
import com.tmmas.scl.doblecuenta.commonapp.exception.ProyectoException;

public class FacturaDAOTest extends BaseTest {

	private FacturaDAO facturaDAO = new FacturaDAO();

	public void testObtenerListaConceptos() {
		try {
			ConceptoDTO[] conceptos = facturaDAO.obtenerListaConceptos();
			System.out.println("Total de conceptos: "+conceptos.length);
		} catch (ProyectoException e) {
			System.out.println("Error: "+e.getMessage());
		}
	}

	public RetornoDTO testInsertaFacturacionDiferenciadaCabecera() {
		try {
			FacturaDTO factura = new FacturaDTO();
			ClienteDTO cliente = new ClienteDTO();
			
			cliente.setCodClienteContra(1771525);
			factura.setFecIngRegistro(new Date());
			factura.setFecCieRegistro(new Date());
			factura.setCodCiclo(5);
			factura.setTipOperación(1);
			factura.setTipModalidad(1);
			factura.setTipValor(1);
			factura.setUser("SISCEL");
			
			RetornoDTO retorno = facturaDAO.insertaFacturacionDiferenciadaCabecera(factura, cliente);
			return retorno;
		} catch (ProyectoException e) {
			System.out.println("Error: "+e.getMessage());
			return new RetornoDTO();
		}
	}

	public void testInsertarFacturacionDiferenciadaDetalle() {
		try {
			FacturaDTO factura = new FacturaDTO();
			ClienteDTO cliente = new ClienteDTO();
			AbonadoDTO abonado = new AbonadoDTO();
			ConceptoDTO concepto = new ConceptoDTO();
			
			RetornoDTO retorno = testInsertaFacturacionDiferenciadaCabecera();
			
			factura.setNumSecEncabezadoFd(retorno.getNumSecEncabezadoFd());
			cliente.setCodClienteAsoc(245235);
			abonado.setNumAbonado("345346");
			concepto.setCodConceptoOrig(1);
			concepto.setMontoConcepto(1);
			factura.setFecIngRegistro(new Date());
			factura.setFecCieRegistro(new Date());
			factura.setUser("SISCEL");
			
			facturaDAO.insertarFacturacionDiferenciadaDetalle(factura, abonado, cliente, concepto);
		} catch (ProyectoException e) {
			System.out.println("Error: "+e.getMessage());
		}
	}

	public void testUpdateFacturacionDiferenciadaCabecera() {
		try {
			FacturaDTO factura = new FacturaDTO();
			ClienteDTO cliente = new ClienteDTO();
			AbonadoDTO abonado = new AbonadoDTO();

			factura.setNumSecDetalleFd(1);
			cliente.setCodClienteAsoc(1212412);
			abonado.setNumAbonado("2134234");
			factura.setUser("SISCEL");

			facturaDAO.updateFacturacionDiferenciadaCabecera(cliente, abonado, factura);
		} catch (ProyectoException e) {
			System.out.println("Error: "+e.getMessage());
		}
	}

	public void testBajaMasivaFacturacion() {
		try {
			FacturaDTO factura = new FacturaDTO();

			factura.setNumSecEncabezadoFd(1);
			factura.setUser("SISCEL");

			facturaDAO.bajaMasivaFacturacion(factura);
		} catch (ProyectoException e) {
			System.out.println("Error: "+e.getMessage());
		}
	}

}
