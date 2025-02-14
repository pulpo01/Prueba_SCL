package com.tmmas.scl.wsventaenlace.businessobject.dao.test;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import junit.framework.Assert;
import junit.framework.Test;
import junit.framework.TestCase;
import junit.framework.TestSuite;

import org.apache.log4j.Logger;

import com.tmmas.scl.wsventaenlace.businessobject.dao.AsociaDesasociaRangoDAO;
import com.tmmas.scl.wsventaenlace.transport.vo.AbonadoVO;
import com.tmmas.scl.wsventaenlace.transport.vo.asociarango.NumeroPilotoVO;
import com.tmmas.scl.wsventaenlace.transport.vo.asociarango.OOSSAsociaRangoVO;

public class AsociaRangoDAOTest extends TestCase {
	private AsociaDesasociaRangoDAO asociaRangoDAO;
	private OOSSAsociaRangoVO asociaRangoVO;
	private static Logger logger = Logger.getLogger(AsociaRangoDAOTest.class);

	public void testObtieneRangosDisponibles() {
		try {
			asociaRangoDAO.obtieneRangosDisponibles(asociaRangoVO);

			List rangos = asociaRangoVO.getRangosDisponibles();

			Assert.assertNotNull(rangos);
			Assert.assertTrue(rangos.size() > 0);

			for (Iterator i = rangos.iterator(); i.hasNext();)
				System.out.println(i.next());
		} catch (Throwable t) {
			Assert.fail("Falla indebida");
		}
	}

	public void testObtieneRangosAsociados() {
		logger.debug("testObtieneRangosAsociados");

		try {
			AbonadoVO abonadoVO = new AbonadoVO();
			abonadoVO.setNumAbonado(4571555);
			asociaRangoVO.setAbonado(abonadoVO);
			OOSSAsociaRangoVO asociaRangoVO = new OOSSAsociaRangoVO();
			asociaRangoVO.setAbonado(abonadoVO);

			asociaRangoDAO.obtieneRangosAsociados(asociaRangoVO);

			Assert.assertNotNull(asociaRangoVO.getRangosAsociados());
			Assert.assertTrue(asociaRangoVO.getRangosAsociados().size() > 0);

			for (Iterator i = asociaRangoVO.getRangosAsociados().iterator(); i.hasNext();)
				logger.debug(i.next());
		} catch (Throwable t) {
			Assert.fail("Falla indebida");
		}
	}

	/*
	 * public void testAdicionaRangos() { try { OOSSAsociaRangoVO asociaRangoVO = new OOSSAsociaRangoVO(); List rangos = new ArrayList(); RangoVO rangoVO = null;
	 * 
	 * rangoVO = new RangoVO(); rangoVO.setNumDesde(4001); rangoVO.setNumHasta(4099); rangoVO.setFechaAlta(new Date(new java.util.Date().getTime())); rangoVO.setFechaBaja(null); rangoVO.setFechaSuspension(null); rangoVO.setFechaRehabilitacion(null); rangoVO.setEstado("1"); rangoVO.setNomUsuarOra("junit"); rangos.add(rangoVO);
	 * 
	 * rangoVO = new RangoVO(); rangoVO.setNumDesde(5001); rangoVO.setNumHasta(5099); rangoVO.setFechaAlta(new Date(new java.util.Date().getTime())); rangoVO.setFechaBaja(null); rangoVO.setFechaSuspension(null); rangoVO.setFechaRehabilitacion(null); rangoVO.setEstado("1"); rangoVO.setNomUsuarOra("junit"); rangos.add(rangoVO);
	 * 
	 * asociaRangoVO.setRangosAdicionados(rangos);
	 * 
	 * asociaRangoDAO.adicionaRangos(asociaRangoVO); } catch(Throwable t) { t.printStackTrace();
	 * 
	 * Assert.fail("Falla indebida"); } }
	 */

	public List crearNumerosPiloto(long numPiloto, int total) {
		List pilotos = new ArrayList();
		NumeroPilotoVO numeroPilotoVO = null;
		int sum = 0;

		for (int i = 0; i < total; i++) {
			sum += 100;
			numeroPilotoVO = new NumeroPilotoVO();
			numeroPilotoVO.setNumPiloto(numPiloto + sum);
			numeroPilotoVO.setNumDesde(numeroPilotoVO.getNumPiloto() + 1);
			numeroPilotoVO.setNomUsuarOra("junit");

			logger.debug(numeroPilotoVO);

			pilotos.add(numeroPilotoVO);
		}

		return pilotos;
	}

	public void testInsertaNumerosPiloto() {
		try {
			OOSSAsociaRangoVO asociaRangoVO = new OOSSAsociaRangoVO();
			List pilotos = crearNumerosPiloto(10000, 2);

			asociaRangoVO.setPilotosAdicionados(pilotos);
			asociaRangoDAO.insertaNumeroPiloto(asociaRangoVO);
		} catch (Throwable t) {
			t.printStackTrace();

			Assert.fail("Falla indebida");
		}
	}

	public void testEliminaNumerosPiloto() {
		try {
			List pilotos = crearNumerosPiloto(20000, 2);
			OOSSAsociaRangoVO asociaRangoVO = new OOSSAsociaRangoVO();

			asociaRangoVO.setPilotosAdicionados(pilotos);
			asociaRangoDAO.insertaNumeroPiloto(asociaRangoVO);

			asociaRangoVO.setPilotosEliminados(pilotos);
			asociaRangoDAO.eliminaNumeroPiloto(asociaRangoVO);
		} catch (Throwable t) {
			t.printStackTrace();

			Assert.fail("Falla indebida");
		}
	}

	protected void setUp() {
		asociaRangoDAO = new AsociaDesasociaRangoDAO();
		asociaRangoVO = new OOSSAsociaRangoVO();
	}

	protected void tearDown() {
	}

	public static Test suite() {
		return new TestSuite(AsociaRangoDAOTest.class);
	}
}
