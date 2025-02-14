package com.tmmas.cl.scl.socketps.dao;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.net.ConnectException;
import java.net.NoRouteToHostException;
import java.net.Socket;
import java.net.UnknownHostException;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.apache.log4j.Logger;
import org.apache.log4j.PropertyConfigurator;

import com.tmmas.cl.framework.util.WriteFile;
import com.tmmas.cl.scl.socketps.bo.helper.Global;
import com.tmmas.cl.scl.socketps.bo.helper.ParsearSocketPS;
import com.tmmas.cl.scl.socketps.common.dto.ConsultaListaDTO;
import com.tmmas.cl.scl.socketps.common.dto.ConsultaPlanDTO;
import com.tmmas.cl.scl.socketps.common.dto.ConsultaSaldoDTO;
import com.tmmas.cl.scl.socketps.common.dto.HeaderPSDTO;
import com.tmmas.cl.scl.socketps.common.dto.ListaDTO;
import com.tmmas.cl.scl.socketps.common.dto.ListasDTO;
import com.tmmas.cl.scl.socketps.common.dto.PlanDTO;
import com.tmmas.cl.scl.socketps.common.dto.RespuestaPSDTO;
import com.tmmas.cl.scl.socketps.common.dto.SaldoDTO;
import com.tmmas.cl.scl.socketps.common.exception.SocketPSException;
import com.tmmas.cl.scl.socketps.dao.interfaces.ConsultaDAOIT;

public class ConsultaDAO implements ConsultaDAOIT {

	private final Logger logger = Logger.getLogger(ConsultaDAO.class);

	private Global global = Global.getInstance();

	private ParsearSocketPS ps = new ParsearSocketPS();

	public ListasDTO consultaLista(ConsultaListaDTO consultaLista)
			throws SocketPSException {
		String log = global.getValor("bo.log");
		PropertyConfigurator.configure(log);
		logger.debug("consultaLista():start");

		String server_name = global.getValor("server.socket");
		logger.debug("Server[" + server_name + "]");

		int port = Integer.parseInt(global.getValor("port.socket"));
		logger.debug("Port[" + port + "]");

		StringBuffer mesg = new StringBuffer();
		BufferedReader is = null;
		PrintWriter os = null;
		Socket sock = null;
		HeaderPSDTO header = consultaLista.getHeader();
		String orden = null;
		ListasDTO lista = new ListasDTO();

		// Todos los parametros del objeto header pueden ser nulos
		// Se tomaran entonces los valores de los properties. O sea para
		// ejecutar un servicio solo son
		// necesarios los parametros de la consulta
		// Seteo la orden.
		if (header.getOrden() == null) {
			// Seteo la orden a la consulta de plan
			orden = global.getValor("param.ppga_listaact_q");
			header.setOrden(orden);
		}
		logger.debug("orden[" + orden + "]");
		
		boolean parametrosdeCliente = header.isParametrodelCliente();
		logger.debug("parametrosdeCliente[" + parametrosdeCliente + "]");
		if (!parametrosdeCliente) {
			// Los parametros no los creo el cliente, hay que construirlos del
			// DTO de entrada, de este metodo
			// que corresponden al primer nivel, es decir, sin el objeto
			// HeaderPSDTO.
			armarParametrosLista(consultaLista);
		}

		logger.debug("armarComando:antes");
		mesg.append(ps.armarComando(header));
		logger.debug("armarComando:despues");

		try {

			// Crea Socket
			sock = new Socket(server_name, port);
			logger.debug("*** Conectado a " + server_name + " ***");

			// Genera acceso para enviar y recibir informacion
			is = new BufferedReader(
					new InputStreamReader(sock.getInputStream()));

			os = new PrintWriter(sock.getOutputStream(), true);

			logger.debug("Mandando informacion...");
			os.print(mesg + WriteFile.newLine);
			logger.debug("Escribiendo informacion...");
			os.flush();
			logger.debug("Flusheando informacion...");

			String reply = is.readLine();

			logger.debug("Envío [" + mesg + "]");

			logger
					.debug("recibio (Acknolegment de recepcion)  [" + reply
							+ "]");

			RespuestaPSDTO respuesta = ps.armarRespuestaEstandar(reply);

			//Guardo la respuesta exitosa o erronea del acknolegmente de recepcion
			lista.setRespuesta(respuesta);
			String ok = global.getValor("status.ok");
			logger.debug("ok[" + ok + "]");

			logger.debug("--------------------------------------");
			logger.debug("status[" + respuesta.getStatus() + "]");
			logger.debug("ticket[" + respuesta.getTicket() + "]");
			logger.debug("os[" + respuesta.getOs() + "]");
			logger.debug("suberror[" + respuesta.getSubError() + "]");
			logger.debug("--------------------------------------");

			// Analizando acknolegment de recepcion
			if (!respuesta.getStatus().equalsIgnoreCase(ok)) {
				logger.debug("Error en acknolegment de envío");
				StringBuffer msg = new StringBuffer();
				msg.append("Error en acknolegment de envío. ");
				msg.append("ticket[" + respuesta.getTicket() + "]");
				msg.append("os[" + respuesta.getOs() + "]");
				msg.append("status[" + respuesta.getStatus() + "]");
				msg.append("suberror[" + respuesta.getSubError() + "]");
				logger.debug("Error[" + msg.toString() + "]");
				throw new SocketPSException(msg.toString());
			}
			reply = is.readLine();

			logger.debug("Recibio (Acknolegment de respuesta) [" + reply + "]");
			
			respuesta = ps.armarRespuestaEstandar(reply);
			
			//Guardo la respuesta exitosa o erronea del acknolegmente de respuesta
			lista.setRespuesta(respuesta);	
			logger.debug("--------------------------------------");
			logger.debug("status[" + respuesta.getStatus() + "]");
			logger.debug("ticket[" + respuesta.getTicket() + "]");
			logger.debug("os[" + respuesta.getOs() + "]");
			logger.debug("suberror[" + respuesta.getSubError() + "]");
			logger.debug("--------------------------------------");

			// Analizando acknolegment de respuesta
			if (!respuesta.getStatus().equalsIgnoreCase(ok)) {
				logger.debug("Error en acknolegment de respuesta");
				StringBuffer msg = new StringBuffer();
				msg.append("Error en acknolegment de respuesta. ");
				msg.append("ticket[" + respuesta.getTicket() + "]");
				msg.append("os[" + respuesta.getOs() + "]");
				msg.append("status[" + respuesta.getStatus() + "]");
				msg.append("suberror[" + respuesta.getSubError() + "]");
				logger.debug("Error[" + msg.toString() + "]");
				throw new SocketPSException(msg.toString());
			}	
			
			//Obtengo la respuesta
			String regExp = global.getValor("reg.exp.lista");
			logger.debug("Regular expresion lista[" + regExp + "]");
			
			String valores[] = ps.armarRespuestaValues(reply, regExp);
			ListaDTO[] listaData = null;
			int n = valores.length;
			logger.debug("n[" + n + "]");
			
			
			//Se cargan los elementos de la lista en el arreglo de lista frecuente
			if (n!= 0) {
				listaData = new ListaDTO[n] ;
				for (int i = 0; i < n; i++){
					ListaDTO dto = new ListaDTO();
					dto.setNumero(valores[i]);
					listaData[i] = dto;
					logger.debug("numero[" + i + "] valor[" + dto.getNumero() + "]");
				}
			}
			
			//Este valor puede contener un elemento null
			//Se debera validar con el dto de respuesta de lista para verificar previamente
			//existen datos, sino podria ocurrir un NullPointerException
			
			lista.setLista(listaData);

		} catch (UnknownHostException e) {
			logger.debug("UnknownHostException:", e);
			throw new SocketPSException(e);
		} catch (NoRouteToHostException e) {
			logger.debug("NoRouteToHostException:", e);
			throw new SocketPSException(e);
		} catch (ConnectException e) {
			logger.debug("ConnectException:", e);
			throw new SocketPSException(e);
		} catch (IOException e) {
			logger.debug("Error conectando a " + server_name, e);
			throw new SocketPSException(e);
		} catch (SocketPSException e) {
			logger.debug("SocketPSException", e);
			throw e;
		} catch (Exception e) {
			logger.debug("Exception", e);
			throw new SocketPSException(e);
		} finally {
			logger.debug("finally...");
			logger.debug("va a cerrar is...");
			if (is != null) {
				try {
					logger.debug("is:antes");
					is.close();
					logger.debug("is:despues");
				} catch (IOException e) {
					logger.debug("error cerrando is", e);
				}
			}
			logger.debug("va a cerrar os...");
			if (os != null) {
				logger.debug("os:antes");
				os.close();
				logger.debug("os:despues");
			}

			logger.debug("va a cerrar socket...");
			if (sock != null) {
				try {
					logger.debug("socket cierre:antes");
					sock.close();
					logger.debug("socket cierre:despues");
				} catch (IOException e) {
					logger.debug("error cerrando socket", e);
				}
			}
		}
		logger.debug("consultaLista():end");
		return lista;
	}


	public PlanDTO consultaPlan(ConsultaPlanDTO consultaPlan)
			throws SocketPSException {
		String log = global.getValor("bo.log");
		PropertyConfigurator.configure(log);
		logger.debug("consultaPlan():start");

		String server_name = global.getValor("server.socket");
		logger.debug("Server[" + server_name + "]");

		int port = Integer.parseInt(global.getValor("port.socket"));
		logger.debug("Port[" + port + "]");

		StringBuffer mesg = new StringBuffer();
		BufferedReader is = null;
		PrintWriter os = null;
		Socket sock = null;
		HeaderPSDTO header = consultaPlan.getHeader();
		String orden = null;
		PlanDTO plan = new PlanDTO();

		// Todos los parametros del objeto header pueden ser nulos
		// Se tomaran entonces los valores de los properties. O sea para
		// ejecutar un servicio solo son
		// necesarios los parametros de la consulta
		// Seteo la orden.
		if (header.getOrden() == null) {
			// Seteo la orden a la consulta de plan
			orden = global.getValor("param.ppga_plan_q");
			header.setOrden(orden);
		}
		logger.debug("orden[" + orden + "]");
		
		boolean parametrosdeCliente = header.isParametrodelCliente();
		logger.debug("parametrosdeCliente[" + parametrosdeCliente + "]");
		if (!parametrosdeCliente) {
			// Los parametros no los creo el cliente, hay que construirlos del
			// DTO de entrada, de este metodo
			// que corresponden al primer nivel, es decir, sin el objeto
			// HeaderPSDTO.
			armarParametrosPlan(consultaPlan);
		}

		logger.debug("armarComando:antes");
		mesg.append(ps.armarComando(header));
		logger.debug("armarComando:despues");

		try {

			// Crea Socket
			sock = new Socket(server_name, port);
			logger.debug("*** Conectado a " + server_name + " ***");

			// Genera acceso para enviar y recibir informacion
			is = new BufferedReader(
					new InputStreamReader(sock.getInputStream()));

			os = new PrintWriter(sock.getOutputStream(), true);

			logger.debug("Mandando informacion...");
			os.print(mesg + WriteFile.newLine);
			logger.debug("Escribiendo informacion...");
			os.flush();
			logger.debug("Flusheando informacion...");

			String reply = is.readLine();

			logger.debug("Envío [" + mesg + "]");

			logger
					.debug("recibio (Acknolegment de recepcion)  [" + reply
							+ "]");

			RespuestaPSDTO respuesta = ps.armarRespuestaEstandar(reply);

			//Guardo la respuesta exitosa o erronea del acknolegmente de recepcion
			plan.setRespuesta(respuesta);
			String ok = global.getValor("status.ok");
			logger.debug("ok[" + ok + "]");

			logger.debug("--------------------------------------");
			logger.debug("status[" + respuesta.getStatus() + "]");
			logger.debug("ticket[" + respuesta.getTicket() + "]");
			logger.debug("os[" + respuesta.getOs() + "]");
			logger.debug("suberror[" + respuesta.getSubError() + "]");
			logger.debug("--------------------------------------");

			// Analizando acknolegment de recepcion
			if (!respuesta.getStatus().equalsIgnoreCase(ok)) {
				logger.debug("Error en acknolegment de envío");
				StringBuffer msg = new StringBuffer();
				msg.append("Error en acknolegment de envío. ");
				msg.append("ticket[" + respuesta.getTicket() + "]");
				msg.append("os[" + respuesta.getOs() + "]");
				msg.append("status[" + respuesta.getStatus() + "]");
				msg.append("suberror[" + respuesta.getSubError() + "]");
				logger.debug("Error[" + msg.toString() + "]");
				throw new SocketPSException(msg.toString());
			}
			reply = is.readLine();

			logger.debug("Recibio (Acknolegment de respuesta) [" + reply + "]");
			
			respuesta = ps.armarRespuestaEstandar(reply);
			
			//Guardo la respuesta exitosa o erronea del acknolegmente de respuesta
			plan.setRespuesta(respuesta);	
			logger.debug("--------------------------------------");
			logger.debug("status[" + respuesta.getStatus() + "]");
			logger.debug("ticket[" + respuesta.getTicket() + "]");
			logger.debug("os[" + respuesta.getOs() + "]");
			logger.debug("suberror[" + respuesta.getSubError() + "]");
			logger.debug("--------------------------------------");

			// Analizando acknolegment de respuesta
			if (!respuesta.getStatus().equalsIgnoreCase(ok)) {
				logger.debug("Error en acknolegment de respuesta");
				StringBuffer msg = new StringBuffer();
				msg.append("Error en acknolegment de respuesta. ");
				msg.append("ticket[" + respuesta.getTicket() + "]");
				msg.append("os[" + respuesta.getOs() + "]");
				msg.append("status[" + respuesta.getStatus() + "]");
				msg.append("suberror[" + respuesta.getSubError() + "]");
				logger.debug("Error[" + msg.toString() + "]");
				throw new SocketPSException(msg.toString());
			}	
			
			//Obtengo la respuesta
			String regExp = global.getValor("reg.exp.ppga_plan_q");
			logger.debug("Regular expresion plan[" + regExp + "]");
			
			String valor = ps.armarRespuestaDetail(reply, regExp);
			logger.debug("valor[" + valor + "]");
			plan.setPlan(valor);

		} catch (UnknownHostException e) {
			logger.debug("UnknownHostException:", e);
			throw new SocketPSException(e);
		} catch (NoRouteToHostException e) {
			logger.debug("NoRouteToHostException:", e);
			throw new SocketPSException(e);
		} catch (ConnectException e) {
			logger.debug("ConnectException:", e);
			throw new SocketPSException(e);
		} catch (IOException e) {
			logger.debug("Error conectando a " + server_name, e);
			throw new SocketPSException(e);
		} catch (SocketPSException e) {
			logger.debug("SocketPSException", e);
			throw e;
		} catch (Exception e) {
			logger.debug("Exception", e);
			throw new SocketPSException(e);
		} finally {
			logger.debug("finally...");
			logger.debug("va a cerrar is...");
			if (is != null) {
				try {
					logger.debug("is:antes");
					is.close();
					logger.debug("is:despues");
				} catch (IOException e) {
					logger.debug("error cerrando is", e);
				}
			}
			logger.debug("va a cerrar os...");
			if (os != null) {
				logger.debug("os:antes");
				os.close();
				logger.debug("os:despues");
			}

			logger.debug("va a cerrar socket...");
			if (sock != null) {
				try {
					logger.debug("socket cierre:antes");
					sock.close();
					logger.debug("socket cierre:despues");
				} catch (IOException e) {
					logger.debug("error cerrando socket", e);
				}
			}
		}
		logger.debug("consultaPlan():end");
		return plan;
	}


	public SaldoDTO consultaSaldo(ConsultaSaldoDTO consultaSaldo)
			throws SocketPSException {
		String log = global.getValor("bo.log");
		PropertyConfigurator.configure(log);
		logger.debug("consultaSaldo():start");

		String server_name = global.getValor("server.socket");
		logger.debug("Server[" + server_name + "]");

		int port = Integer.parseInt(global.getValor("port.socket"));
		logger.debug("Port[" + port + "]");

		StringBuffer mesg = new StringBuffer();
		BufferedReader is = null;
		PrintWriter os = null;
		Socket sock = null;
		HeaderPSDTO header = consultaSaldo.getHeader();
		String orden = null;
		SaldoDTO saldo = new SaldoDTO();

		// Todos los parametros del objeto header pueden ser nulos
		// Se tomaran entonces los valores de los properties. O sea para
		// ejecutar un servicio solo son
		// necesarios los parametros de la consulta
		// Seteo la orden.
		if (header.getOrden() == null) {
			// Seteo la orden a la consulta de plan
			orden = global.getValor("param.ppga_sal_q");
			header.setOrden(orden);
		}
		logger.debug("orden[" + orden + "]");
		
		boolean parametrosdeCliente = header.isParametrodelCliente();
		logger.debug("parametrosdeCliente[" + parametrosdeCliente + "]");
		if (!parametrosdeCliente) {
			// Los parametros no los creo el cliente, hay que construirlos del
			// DTO de entrada, de este metodo
			// que corresponden al primer nivel, es decir, sin el objeto
			// HeaderPSDTO.
			armarParametrosSaldo(consultaSaldo);
		}

		logger.debug("armarComando:antes");
		mesg.append(ps.armarComando(header));
		logger.debug("armarComando:despues");

		try {

			// Crea Socket
			sock = new Socket(server_name, port);
			logger.debug("*** Conectado a " + server_name + " ***");

			// Genera acceso para enviar y recibir informacion
			is = new BufferedReader(
					new InputStreamReader(sock.getInputStream()));

			os = new PrintWriter(sock.getOutputStream(), true);

			logger.debug("Mandando informacion...");
			os.print(mesg + WriteFile.newLine);
			logger.debug("Escribiendo informacion...");
			os.flush();
			logger.debug("Flusheando informacion...");

			String reply = is.readLine();

			logger.debug("Envío [" + mesg + "]");

			logger
					.debug("recibio (Acknolegment de recepcion)  [" + reply
							+ "]");

			RespuestaPSDTO respuesta = ps.armarRespuestaEstandar(reply);

			//Guardo la respuesta exitosa o erronea del acknolegmente de recepcion
			saldo.setRespuesta(respuesta);
			String ok = global.getValor("status.ok");
			logger.debug("ok[" + ok + "]");

			logger.debug("--------------------------------------");
			logger.debug("status[" + respuesta.getStatus() + "]");
			logger.debug("ticket[" + respuesta.getTicket() + "]");
			logger.debug("os[" + respuesta.getOs() + "]");
			logger.debug("suberror[" + respuesta.getSubError() + "]");
			logger.debug("--------------------------------------");

			// Analizando acknolegment de recepcion
			if (!respuesta.getStatus().equalsIgnoreCase(ok)) {
				logger.debug("Error en acknolegment de envío");
				StringBuffer msg = new StringBuffer();
				msg.append("Error en acknolegment de envío. ");
				msg.append("ticket[" + respuesta.getTicket() + "]");
				msg.append("os[" + respuesta.getOs() + "]");
				msg.append("status[" + respuesta.getStatus() + "]");
				msg.append("suberror[" + respuesta.getSubError() + "]");
				logger.debug("Error[" + msg.toString() + "]");
				throw new SocketPSException(msg.toString());
			}
			reply = is.readLine();

			logger.debug("Recibio (Acknolegment de respuesta) [" + reply + "]");
			
			respuesta = ps.armarRespuestaEstandar(reply);
			
			//Guardo la respuesta exitosa o erronea del acknolegmente de respuesta
			saldo.setRespuesta(respuesta);	
			logger.debug("--------------------------------------");
			logger.debug("status[" + respuesta.getStatus() + "]");
			logger.debug("ticket[" + respuesta.getTicket() + "]");
			logger.debug("os[" + respuesta.getOs() + "]");
			logger.debug("suberror[" + respuesta.getSubError() + "]");
			logger.debug("--------------------------------------");

			// Analizando acknolegment de respuesta
			if (!respuesta.getStatus().equalsIgnoreCase(ok)) {
				logger.debug("Error en acknolegment de respuesta");
				StringBuffer msg = new StringBuffer();
				msg.append("Error en acknolegment de respuesta. ");
				msg.append("ticket[" + respuesta.getTicket() + "]");
				msg.append("os[" + respuesta.getOs() + "]");
				msg.append("status[" + respuesta.getStatus() + "]");
				msg.append("suberror[" + respuesta.getSubError() + "]");
				logger.debug("Error[" + msg.toString() + "]");
				throw new SocketPSException(msg.toString());
			}	
			
			//Obtengo la respuesta
			String regExp = global.getValor("reg.exp.ppga_sal_q");
			logger.debug("Regular expresion saldo[" + regExp + "]");
			
			String valor = ps.armarRespuestaDetail(reply, regExp);
			logger.debug("valor[" + valor + "]");
			saldo.setSaldo(valor);

		} catch (UnknownHostException e) {
			logger.debug("UnknownHostException:", e);
			throw new SocketPSException(e);
		} catch (NoRouteToHostException e) {
			logger.debug("NoRouteToHostException:", e);
			throw new SocketPSException(e);
		} catch (ConnectException e) {
			logger.debug("ConnectException:", e);
			throw new SocketPSException(e);
		} catch (IOException e) {
			logger.debug("Error conectando a " + server_name, e);
			throw new SocketPSException(e);
		} catch (SocketPSException e) {
			logger.debug("SocketPSException", e);
			throw e;
		} catch (Exception e) {
			logger.debug("Exception", e);
			throw new SocketPSException(e);
		} finally {
			logger.debug("finally...");
			logger.debug("va a cerrar is...");
			if (is != null) {
				try {
					logger.debug("is:antes");
					is.close();
					logger.debug("is:despues");
				} catch (IOException e) {
					logger.debug("error cerrando is", e);
				}
			}
			logger.debug("va a cerrar os...");
			if (os != null) {
				logger.debug("os:antes");
				os.close();
				logger.debug("os:despues");
			}

			logger.debug("va a cerrar socket...");
			if (sock != null) {
				try {
					logger.debug("socket cierre:antes");
					sock.close();
					logger.debug("socket cierre:despues");
				} catch (IOException e) {
					logger.debug("error cerrando socket", e);
				}
			}
		}
		logger.debug("consultaSaldo():end");
		return saldo;
	}

	private void armarParametrosLista(ConsultaListaDTO consultaLista) {
		logger.debug("armarParametrosLista():start");
		String listaParametros = global.getValor("lista.param.ppga_listaact_q");
		logger.debug("listaParametros[" + listaParametros + "]");

		String separador = global.getValor("lista.separador");
		logger.debug("separador[" + separador + "]");

		String paramNombre[] = new String[3];
		String arrListaParametros[] = listaParametros.split(separador);
		for (int i = 0; i < arrListaParametros.length; i++) {
			logger.debug("arrListaParametros[" + i + "]=["
					+ arrListaParametros[i] + "]");
			paramNombre[i] = arrListaParametros[i];
		}

		String paramValores[] = new String[3];
		paramValores[0] = consultaLista.getLin();
		paramValores[1] = consultaLista.getNumItems();
		paramValores[2] = consultaLista.getCodListIni();
		logger.debug("Lin[" + consultaLista.getLin() + "]");
		logger.debug("NumItems[" + consultaLista.getNumItems() + "]");
		logger.debug("CodListIni[" + consultaLista.getCodListIni() + "]");

		HeaderPSDTO header = consultaLista.getHeader();
		header.setParametrosNombre(paramNombre);
		header.setParametrosValor(paramValores);
		logger.debug("armarParametrosLista():end");
		
	}
	
	
	private void armarParametrosSaldo(ConsultaSaldoDTO consultaSaldo) {
		logger.debug("armarParametrosSaldo():start");
		String listaParametros = global.getValor("lista.param.ppga_sal_q");
		logger.debug("listaParametros[" + listaParametros + "]");

		String separador = global.getValor("lista.separador");
		logger.debug("separador[" + separador + "]");

		String paramNombre[] = new String[2];
		String arrListaParametros[] = listaParametros.split(separador);
		for (int i = 0; i < arrListaParametros.length; i++) {
			logger.debug("arrListaParametros[" + i + "]=["
					+ arrListaParametros[i] + "]");
			paramNombre[i] = arrListaParametros[i];
		}

		String paramValores[] = new String[2];
		paramValores[0] = consultaSaldo.getLin();
		paramValores[1] = consultaSaldo.getRegion();
		logger.debug("Lin[" + consultaSaldo.getLin() + "]");
		logger.debug("Region[" + consultaSaldo.getRegion() + "]");

		HeaderPSDTO header = consultaSaldo.getHeader();
		header.setParametrosNombre(paramNombre);
		header.setParametrosValor(paramValores);
		logger.debug("armarParametrosSaldo():end");
	}

	private void armarParametrosPlan(ConsultaPlanDTO consultaPlan) {
		logger.debug("armarParametrosPlan():start");
		String listaParametros = global.getValor("lista.param.ppga_plan_q");
		logger.debug("listaParametros[" + listaParametros + "]");

		String separador = global.getValor("lista.separador");
		logger.debug("separador[" + separador + "]");

		String paramNombre[] = new String[2];
		String arrListaParametros[] = listaParametros.split(separador);
		for (int i = 0; i < arrListaParametros.length; i++) {
			logger.debug("arrListaParametros[" + i + "]=["
					+ arrListaParametros[i] + "]");
			paramNombre[i] = arrListaParametros[i];
		}

		String paramValores[] = new String[2];
		paramValores[0] = consultaPlan.getLin();
		paramValores[1] = consultaPlan.getIcc();
		logger.debug("Lin[" + consultaPlan.getLin() + "]");
		logger.debug("Icc[" + consultaPlan.getIcc() + "]");

		HeaderPSDTO header = consultaPlan.getHeader();
		header.setParametrosNombre(paramNombre);
		header.setParametrosValor(paramValores);
		logger.debug("armarParametrosPlan():end");
	}
	
	public static void main(String[] argv) {
		String str = "TICKET=1581550,OS=1002,STATUS=OK,SUBERROR=";
		String regexp = ",";
		/*
		 * String arr[] = Pattern.compile(regexp).split(str); //Pos 2 for (int i =
		 * 0; i < arr.length - 1; i++) { System.out.println("arr[" + i + "]=["+
		 * arr[i]+"]"); }
		 * 
		 * System.out.println("-----------------------------------------------------");
		 * str =
		 * ">\\KVESUBERROR=,STATUS=OK,OS=1002,TICKET=1581550,DETAIL=DATOS\\=PLAN\\\\\\=BP\\,OPER\\=plan\\,TIPO\\=T1";
		 * arr = Pattern.compile(regexp).split(str); //Pos 4 for (int i = 0; i <
		 * arr.length - 1; i++) { System.out.println("arr[" + i + "]=["+
		 * arr[i]+"]"); }
		 */
		System.out
				.println("-----------------------------------------------------");
		str = "DETAIL=DATOS\\=PLAN\\\\\\=BP0\\";
		// regexp = "PLAN\\\\\\=BP\\";
		//regexp = "PLAN\\\\\\\\\\\\=\\w+\\\\";
		regexp = "PLAN\\\\\\\\\\\\=\\w+";
		Pattern plan = Pattern.compile(regexp);
		Matcher matchedPlan = plan.matcher(str);
		while (matchedPlan.find()) {
			System.out.println("Pattern encontrado en start:"
					+ matchedPlan.start() + " end:" + matchedPlan.end());
			System.out.println(str.substring(matchedPlan.start(), matchedPlan
					.end()));
		}
		
		str = "lin#icc#cola";
		//str = "TICKET=1581550,OS=1002,STATUS=OK,SUBERROR=";
		//String a[] = str.split("|");
		//String a[] = Pattern.compile(",").split(str);
		String a[] = Pattern.compile("#").split(str);
		for (int i = 0; i < a.length; i++) {
			System.out.println("a[" + i + "]=["	+ a[i] + "]");
		}

	}
}
