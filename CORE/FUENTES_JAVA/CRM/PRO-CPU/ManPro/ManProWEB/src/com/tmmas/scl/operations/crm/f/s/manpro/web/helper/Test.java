package com.tmmas.scl.operations.crm.f.s.manpro.web.helper;

import weblogic.security.internal.SerializedSystemIni;
import weblogic.security.internal.encryption.ClearOrEncryptedService;
import weblogic.security.internal.encryption.EncryptionService;


public class Test {
	private static String PATH = "D:\\deploy";
	private static String USERNAME = "{3DES}uS5hguwkXs6m/cMT14Ef4g==";
	private static String PASSWORD = "{3DES}tDS7KkSQvxDckPvKZt5EnA==";
	public static void main(String[] args) {
		System.out.println("RootDir: ["+PATH+"]");
		EncryptionService es = SerializedSystemIni.getEncryptionService(PATH);
		ClearOrEncryptedService service = new ClearOrEncryptedService(es);
		System.out.println("User: ["+service.decrypt(USERNAME)+"]");
		System.out.println("Pass: ["+service.decrypt(PASSWORD)+"]");
	}
}
