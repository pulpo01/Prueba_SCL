package com.tmmas.cl.scl.socketps.service.servicios.interfaces;

import com.tmmas.cl.scl.socketps.common.dto.ConsultaListaDTO;
import com.tmmas.cl.scl.socketps.common.dto.ConsultaPlanDTO;
import com.tmmas.cl.scl.socketps.common.dto.ConsultaSaldoDTO;
import com.tmmas.cl.scl.socketps.common.dto.ListasDTO;
import com.tmmas.cl.scl.socketps.common.dto.PlanDTO;
import com.tmmas.cl.scl.socketps.common.dto.SaldoDTO;
import com.tmmas.cl.scl.socketps.common.exception.SocketPSException;

public interface ConsultaSrvIT {
	public PlanDTO consultaPlan(ConsultaPlanDTO consultaPlan) throws SocketPSException;
	public SaldoDTO consultaSaldo(ConsultaSaldoDTO consultaSaldo) throws SocketPSException;
	public ListasDTO consultaLista(ConsultaListaDTO consultaLista) throws SocketPSException;
}
