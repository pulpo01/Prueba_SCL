package com.tmmas.scl.operations.rmo.rp.issresord.srvrec;

import com.tmmas.scl.operations.rmo.rp.issresord.srvrec.interfaces.GestionActivacionRecursosSrvFactoryIF;
import com.tmmas.scl.operations.rmo.rp.issresord.srvrec.interfaces.GestionActivacionRecursosSrvIF;

public class GestionActivacionRecursosSrvFactory implements GestionActivacionRecursosSrvFactoryIF 
{

	public GestionActivacionRecursosSrvIF getApplicationService1() {		
		return new GestionActivacionRecursosSrv();
	}

}
