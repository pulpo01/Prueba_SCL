package com.tmmas.scl.frameworkooss.srv;

import com.tmmas.scl.frameworkooss.srv.interfaces.FrmkOOSSSrvFactoryIF;
import com.tmmas.scl.frameworkooss.srv.interfaces.FrmkOOSSSrvIF;

public class FrmkOOSSSrvFactory implements FrmkOOSSSrvFactoryIF{

	public FrmkOOSSSrvIF getApplicationService() {
		return new FrmkOOSSSrv();
	}

}
