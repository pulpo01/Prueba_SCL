package com.tmmas.cl.scl.socketps.bo;

import org.apache.log4j.Logger;
import org.apache.log4j.PropertyConfigurator;

import com.tmmas.cl.scl.socketps.bo.helper.Global;
import com.tmmas.cl.scl.socketps.bo.interfaces.ConsultaIT;
import com.tmmas.cl.scl.socketps.common.dto.ConsultaBolsasDTO;
import com.tmmas.cl.scl.socketps.common.dto.ConsultaListaDTO;
import com.tmmas.cl.scl.socketps.common.dto.ConsultaPlanDTO;
import com.tmmas.cl.scl.socketps.common.dto.ConsultaSaldoDTO;
import com.tmmas.cl.scl.socketps.common.dto.ListasDTO;
import com.tmmas.cl.scl.socketps.common.dto.PlanDTO;
import com.tmmas.cl.scl.socketps.common.dto.SaldoDTO;
import com.tmmas.cl.scl.socketps.common.exception.SocketPSException;
import com.tmmas.cl.scl.socketps.dao.ConsultaDAO;
import com.tmmas.cl.scl.socketps.dao.interfaces.ConsultaDAOIT;

public class Consulta implements ConsultaIT {
	
	private ConsultaDAOIT consultaDAO = new ConsultaDAO();
	private final Logger logger = Logger.getLogger(ConsultaDAO.class);
	private Global global = Global.getInstance();	

	public ListasDTO consultaLista(ConsultaListaDTO consultaLista) throws SocketPSException{
		String log = global.getValor("bo.log");
		log = System.getProperty("user.dir") + log;
		PropertyConfigurator.configure(log);		
		logger.debug("consultaLista():start");		
		ListasDTO lista = consultaDAO.consultaLista(consultaLista);
		logger.debug("consultaLista():end");		
		return lista;
	}

	public PlanDTO consultaPlan(ConsultaPlanDTO consultaPlan) throws SocketPSException{
		String log = global.getValor("bo.log");
		log = System.getProperty("user.dir") + log;
		PropertyConfigurator.configure(log);		
		logger.debug("consultaPlan():start");		
		PlanDTO plan = consultaDAO.consultaPlan(consultaPlan);
		logger.debug("consultaPlan():end");		
		return plan;
	}

	public SaldoDTO consultaSaldo(ConsultaSaldoDTO consultaSaldo) throws SocketPSException{
		String log = global.getValor("bo.log");
		log = System.getProperty("user.dir") + log;
		PropertyConfigurator.configure(log);		
		logger.debug("consultaSaldo():start");		
		SaldoDTO saldo = consultaDAO.consultaSaldo(consultaSaldo);
		logger.debug("consultaSaldo():end");		
		return saldo;
	}
	
	public SaldoDTO consultaBolsas(ConsultaBolsasDTO consultaBolsas) throws SocketPSException{
		String log = global.getValor("bo.log");
		log = System.getProperty("user.dir") + log;
		PropertyConfigurator.configure(log);		
		logger.debug("consultaBolsas():start");		
		consultaBolsas.setCodMoneda(global.getValor("param.cod_moneda"));
		consultaBolsas.setCantRegs(global.getValor("param.cant_regs"));
		SaldoDTO saldo = consultaDAO.consultaBolsas(consultaBolsas);
		logger.debug("consultaBolsas():end");		
		return saldo;
	}
	
	

}
