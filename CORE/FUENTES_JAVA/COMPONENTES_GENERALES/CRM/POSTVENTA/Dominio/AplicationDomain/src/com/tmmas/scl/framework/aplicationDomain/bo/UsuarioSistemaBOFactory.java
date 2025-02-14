package com.tmmas.scl.framework.aplicationDomain.bo;

import com.tmmas.scl.framework.aplicationDomain.bo.interfeces.UsuarioSistemaBOFactoryIT;
import com.tmmas.scl.framework.aplicationDomain.bo.interfeces.UsuarioSistemaBOIT;

public class UsuarioSistemaBOFactory implements UsuarioSistemaBOFactoryIT{

	public UsuarioSistemaBOIT getBusinessObject1() {
		return new UsuarioSistemaBO();
	}
	
}
