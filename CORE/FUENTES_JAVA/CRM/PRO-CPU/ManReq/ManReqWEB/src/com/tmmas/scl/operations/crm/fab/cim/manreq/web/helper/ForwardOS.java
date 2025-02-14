package com.tmmas.scl.operations.crm.fab.cim.manreq.web.helper;

public class ForwardOS {
	public static String forwardOS(String OS, int i){
		return "OOSS-" + OS + "-" + String.valueOf(i).trim();
	}

}
