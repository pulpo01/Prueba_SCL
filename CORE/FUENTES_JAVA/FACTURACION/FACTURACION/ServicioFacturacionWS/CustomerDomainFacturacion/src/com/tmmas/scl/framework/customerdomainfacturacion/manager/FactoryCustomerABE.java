//
//
//  Generated by StarUML(tm) Java Add-In
//
//  @ Project : P-TMM-08004
//  @ File Name : FactoryCustomerABE.java
//  @ Date : 09/09/2008
//  @ Author : hsegura
//
//



package com.tmmas.scl.framework.customerdomainfacturacion.manager;

import com.tmmas.scl.framework.customerdomainfacturacion.CustomerABE.bo.ClienteBO;
import com.tmmas.scl.framework.customerdomainfacturacion.CustomerABE.bo.OficinaBO;
import com.tmmas.scl.framework.customerdomainfacturacion.CustomerABE.bo.Interface.ClienteBOIT;
import com.tmmas.scl.framework.customerdomainfacturacion.CustomerABE.bo.Interface.OficinaBOIT;


public class FactoryCustomerABE {



		private static FactoryCustomerABE instance;

		private static OficinaBOIT m_oficinaBO = null;

		private static ClienteBOIT m_clienteBO= null;

		
		public FactoryCustomerABE getInstance() {
			if (instance == null)
				instance = new FactoryCustomerABE();
			return instance;

		}

		/**
		 * Devuelve la instancia de OficinaBO, si no est�, la crea (SINGLETON).
		 * 
		 * @return
		 */
		public synchronized OficinaBOIT getOficinaBO() {
			if (m_oficinaBO == null) {
				m_oficinaBO = new OficinaBO();
			}
			return m_oficinaBO;
		}

		/**
		 * Devuelve la instancia de ClienteBO, si no est�, la crea
		 * (SINGLETON).
		 * 
		 * @return
		 */
		public synchronized ClienteBOIT getClienteBO() {
			if (m_clienteBO == null) {
				m_clienteBO = new ClienteBO();
			}
			return m_clienteBO;
		}
	
}
