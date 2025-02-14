package com.tmmas.cl.scl.socketps.service.servicios;

import org.apache.log4j.Logger;
import org.apache.log4j.PropertyConfigurator;

import com.tmmas.cl.scl.socketps.bo.ConsultaBOFactory;
import com.tmmas.cl.scl.socketps.bo.interfaces.ConsultaBOFactoryIT;
import com.tmmas.cl.scl.socketps.bo.interfaces.ConsultaIT;
import com.tmmas.cl.scl.socketps.common.dto.ConsultaListaDTO;
import com.tmmas.cl.scl.socketps.common.dto.ConsultaPlanDTO;
import com.tmmas.cl.scl.socketps.common.dto.ConsultaSaldoDTO;
import com.tmmas.cl.scl.socketps.common.dto.ListasDTO;
import com.tmmas.cl.scl.socketps.common.dto.PlanDTO;
import com.tmmas.cl.scl.socketps.common.dto.SaldoDTO;
import com.tmmas.cl.scl.socketps.common.exception.SocketPSException;
import com.tmmas.cl.scl.socketps.dao.ConsultaDAO;
import com.tmmas.cl.scl.socketps.service.servicios.helper.Global;
import com.tmmas.cl.scl.socketps.service.servicios.interfaces.ConsultaSrvIT;

public class ConsultaSrv implements ConsultaSrvIT {
	
	private ConsultaBOFactoryIT factoryBOConsulta = new  ConsultaBOFactory();
	private ConsultaIT consultaBO = factoryBOConsulta.getBOFactoryConsulta();
	private final Logger logger = Logger.getLogger(ConsultaSrv.class);
	private Global global = Global.getInstance();
	
	public ListasDTO consultaLista(ConsultaListaDTO consultaLista) throws SocketPSException {
		String log = global.getValor("service.log");
		PropertyConfigurator.configure(log);
		logger.debug("consultaLista():start");
		ListasDTO lista = consultaBO.consultaLista(consultaLista);
		logger.debug("consultaLista():end");
		return lista;
	}

	public PlanDTO consultaPlan(ConsultaPlanDTO consultaPlan) throws SocketPSException {
		String log = global.getValor("service.log");
		PropertyConfigurator.configure(log);
		logger.debug("consultaPlan():start");		
		PlanDTO plan = consultaBO.consultaPlan(consultaPlan);
		logger.debug("consultaPlan():end");			
		return plan;
	}

	public SaldoDTO consultaSaldo(ConsultaSaldoDTO consultaSaldo) throws SocketPSException {
		String log = global.getValor("service.log");
		PropertyConfigurator.configure(log);
		logger.debug("consultaSaldo():start");		
		SaldoDTO saldo = consultaBO.consultaSaldo(consultaSaldo);
		logger.debug("consultaSaldo():end");		
		return saldo;
	}

}
