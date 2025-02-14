package com.tmmas.scl.wsventaenlace.businessobject.dao;

import java.sql.Connection;

import com.tmmas.cl.framework.base.ConnectionDAO;
import com.tmmas.scl.wsventaenlace.businessobject.dao.helper.JUnitConexion;
import com.tmmas.scl.wsventaenlace.common.exception.ServicioVentasEnlaceException;
import com.tmmas.scl.wsventaenlace.common.helper.GlobalProperties;

public class BaseDAO extends ConnectionDAO {
	protected GlobalProperties global =  GlobalProperties.getInstance();
	protected Connection iniciaConexion() throws Exception{
		if (global.getValor("GE.pruebas.unitarias.GE") == null) {
			throw new ServicioVentasEnlaceException("ERR.0002", 2, global.getValor("ERR.0002"));
		} else if (global.getValor("GE.pruebas.unitarias.GE").equals("0")){
			return getConnectionFromWLSInitialContext(global.getJndiForDataSource("GE.jndi.dataSource.DAO"));
		} else {
			JUnitConexion conexion = new JUnitConexion();
			return conexion.conexionBD();
		}
	}
}
