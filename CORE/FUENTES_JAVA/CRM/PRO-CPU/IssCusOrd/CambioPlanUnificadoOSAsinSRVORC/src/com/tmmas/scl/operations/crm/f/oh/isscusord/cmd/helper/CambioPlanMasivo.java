package com.tmmas.scl.operations.crm.f.oh.isscusord.cmd.helper;

import java.io.File;
import java.io.IOException;
import java.io.Serializable;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.rmi.RemoteException;
import java.sql.Timestamp;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;
import org.jdom.Document;
import org.jdom.Element;
import org.jdom.JDOMException;
import org.jdom.input.SAXBuilder;

import com.tmmas.cl.framework.exception.GeneralException;
import com.tmmas.cl.framework.util.StackTraceUtl;
import com.tmmas.cl.scl.socketps.common.dto.ListaDTO;
import com.tmmas.cl.scl.socketps.common.dto.ListasDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.ParametroDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.SecuenciaDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.AbonadoDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.IntegraProdCPUDTO;
import com.tmmas.scl.framework.serviceDomain.serviceSpecEntitiesABE.businessObject.dataTransferObject.ListaActivaDTO;
import com.tmmas.scl.framework.serviceDomain.serviceSpecEntitiesABE.businessObject.dataTransferObject.ListaActivaListDTO;
import com.tmmas.scl.operations.crm.f.oh.isscusord.cmd.orc.helper.Global;
import com.tmmas.scl.operations.crm.f.oh.isscusord.common.dataTransferObject.ParamRegistroOrdenServicioDTO;
import com.tmmas.scl.operations.crm.f.oh.isscusord.common.dataTransferObject.RegistroPlanDTO;
import com.tmmas.scl.operations.crm.f.oh.isscusord.common.exception.IssCusOrdException;
import com.tmmas.scl.operations.crm.f.sel.negsal.dataTransferObject.CambioPlanAdicionalDTO;
import com.tmmas.scl.operations.crm.f.sel.negsal.exception.NegSalException;
import com.tmmas.scl.operations.crm.fab.cim.mancon.bean.ejb.session.ManConFacade;
import com.tmmas.scl.operations.crm.fab.cim.mancon.common.exception.ManConException;
import com.tmmas.scl.operations.crm.o.csr.manprooffinv.common.exception.ManProOffInvException;
import com.tmmas.scl.operations.crm.o.csr.supordhan.common.exception.SupOrdHanException;
import com.tmmas.scl.operations.crm.osr.mancusinv.common.exception.ManCusInvException;

public class CambioPlanMasivo implements Serializable {

	private static final long serialVersionUID = 1L;

	transient static Logger cat = Logger.getLogger(CambioPlanMasivo.class);

	transient Map datosExtra = new HashMap();

	transient IntegraProdCPUDTO[] integracionProdCPU = new IntegraProdCPUDTO[0];

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		// TODO Auto-generated method stub

	}

	/**
	 * Ejecuta la orden de servicio masiva
	 * 
	 * @param param
	 */
	public void EjecutarOrdenServicioMasiva(ParamRegistroOrdenServicioDTO param)
			throws GeneralException {
		cat.debug("EjecutarOrdenServicioMasiva():start");
		Global global = Global.getInstance();

		// Valido los parametros de entrada principales
		cat.debug("validacionParametroOrdenServicio:antes");
		validacionParametroOrdenServicio(param);

		// Ejecuto la orden de servicio masiva
		cat.debug("validacionParametroOrdenServicio:despues");
		registroOrden(param);

		cat.debug("EjecutarOrdenServicioMasiva():end");

	}

	private void registroOrden(ParamRegistroOrdenServicioDTO objeto)
			throws GeneralException {
		cat.debug("registroOrden():start");

		RegistroPlanDTO registro = objeto.getRegistroPlan();
		Global global = Global.getInstance();

		// Procesa el xml, su ubicacion y nombre
		SAXBuilder builder = new SAXBuilder();
		Document doc = null;

		String userDir = global.getPathInstancia();
		cat.debug("userDir[" + userDir + "]");

		String xmlcnfg = global.getValor("OOSSConf.definition");
		cat.debug("xmlcnfg[" + xmlcnfg + "]");

		try {
			cat.debug("Accesando xml:antes");
			doc = builder.build(new File(userDir + xmlcnfg));
			cat.debug("Accesando xml:despues");
		} catch (JDOMException e1) {
			cat.debug("JDOMException", e1);
			throw new IssCusOrdException(e1);
		} catch (IOException e1) {
			cat.debug("JDOMException", e1);
			throw new IssCusOrdException(e1);
		}

		// Arma la combinatoria
		String combinatoria = registro.getParamRegistroPlan().getCombinatoria();
		cat.debug("combinatoria[" + combinatoria + "]");

		String tipoOOSS = registro.getParamRegistroPlan().getTipOOSS();

		String combinatoriaRecibida = combinatoria + tipoOOSS;
		cat.debug(" combinatoria recibida[" + combinatoriaRecibida + "]");

		// Estas combinatorias pueden ser masivas
		// verifica si la combinatoria actual cae dentro de alguna combinatoria
		// masiva

		String POSPOSPUN = global.getValor("POSPOSPUN");
		cat.debug("POSPOSPUN[" + POSPOSPUN + "]");

		String POSPREPUN = global.getValor("POSPREPUN");
		cat.debug("POSPREPUN[" + POSPREPUN + "]");

		String HIBPREPUN = global.getValor("HIBPREPUN");
		cat.debug("HIBPREPUN[" + HIBPREPUN + "]");

		// Bandera que indica si la combinatoria recibida en una de
		// las combinatorias que pueden ser masivas
		boolean masiva = false;

		// Averigua si una de las combinatorias es masiva
		if (POSPOSPUN.equalsIgnoreCase(combinatoriaRecibida)
				|| POSPREPUN.equalsIgnoreCase(combinatoriaRecibida)
				|| HIBPREPUN.equalsIgnoreCase(combinatoriaRecibida)) {

			cat.debug("Combinatoria Masiva");
			masiva = true;
		}

		cat.debug("Acesando combinatoria recibida dentro del xml:antes");
		Element comb = doc.getRootElement().getChild(combinatoriaRecibida);
		cat.debug("Acesando combinatoria recibida dentro del xml:despues");

		// Si la combinatoria no se encuentra hay un problema en el xml
		if (comb == null) {
			cat.debug("combinatoriaRecibida[" + combinatoriaRecibida + "]");
			String msg = "combinatoriaRecibida[" + combinatoriaRecibida
					+ "] no existente en xml";
			throw new IssCusOrdException(msg);
		}

		cat.debug("Combinatoria existente en el xml");

		// Obtiene los metodos de la combinatoria
		List arregloMetodos = doc.getRootElement().getChild(
				combinatoriaRecibida).getChildren();

		int nMetodos = arregloMetodos == null ? 0 : arregloMetodos.size();
		cat.debug("nMetodos[" + nMetodos + "]");

		AbonadoDTO[] arregloAbonados = null;

		// obtiene un arreglo de numeros de abonado
		cat.debug("Obteniendo arreglo de numero de abonado...");
		String[] numeroAbonados = registro.getParamRegistroPlan()
				.getNumAbonados();

		cat.debug("ir a verificar si es posible los numeros de abonados...");
		// Averiguo si viene un arreglo de numero de abonados
		// para obtener los demas datos de los abonados
		if (numeroAbonados != null) {
			try {
				cat.debug("obtenerAbonados:antes");
				arregloAbonados = obtenerAbonados(numeroAbonados);
				cat.debug("obtenerAbonados:despues");
			} catch (ManConException e) {
				String loge = StackTraceUtl.getStackTrace(e);
				cat.debug("ManConException[" + loge + "]");
				throw new IssCusOrdException(e.getMessage(), e.getCause(), e
						.getCodigo(), e.getCodigoEvento(), e
						.getDescripcionEvento());
			}
		}

		cat.debug("Proceso de abonados terminado...");

		// Averigua el numero de abonados
		// Si la cantidad de abonados seleccionados es nula, solo se iterará una
		// vez
		// Sino Si la combinatoria recibida es masiva se itera una vez por
		// abonado seleccionado
		// Sino se itera solamente una vez
		int numerodeAbonados = 0;

		cat.debug("Calculando número de abonados...");

		if (numeroAbonados == null) {
			cat.debug("numeroAbonados == null");
			numerodeAbonados = 1;
		} else {
			if (masiva) {
				cat.debug("masiva == true");
				cat.debug("numero de abonados[" + numeroAbonados.length + "]");
				numerodeAbonados = numeroAbonados.length;
			} else {
				cat.debug("masiva == false");
				numerodeAbonados = 1;
			}
		}
		cat.debug("numerodeAbonados[" + numerodeAbonados + "]");

		// Itero por el número de abonados, para tratar de ejecutar los metodos
		// para una combinatoria
		for (int nAbonados = 0; nAbonados < numerodeAbonados; nAbonados++) {
			// setea el abonado
			cat.debug("seteando abonado...");
			if (arregloAbonados != null && arregloAbonados.length > 0) {
				registro.setAbonado(arregloAbonados[nAbonados]);
				cat.debug("Abonado seteado["
						+ registro.getAbonado().getNumAbonado() + "]");
			}

			// Proceso los metodos de una combinatoria
			cat.debug("procesandoMetodosXML:antes");
			procesandoMetodosXML(objeto, registro, arregloMetodos);
			cat.debug("procesandoMetodosXML:despues");
		}

		// Realiza el proceso de integracion con cpu
		cat.debug("procesaIntegracionconCPU:antes");
		//jimmy
		//procesaIntegracionconCPU();
		cat.debug("procesaIntegracionconCPU:despues");

		cat.debug("registroOrden():end");
	}

	public void procesandoMetodosXML(ParamRegistroOrdenServicioDTO objeto,
			RegistroPlanDTO registro, List arregloMetodos)
			throws GeneralException {
		cat.debug("procesandoMetodosXML():start");

		Global global = Global.getInstance();

		int n = arregloMetodos.size();
		cat.debug("Numero de metodos[" + n + "]");

		// Itera por cada uno de los metodos del xml
		for (int i = 0; i < n; i++) {
			// Metodo que se encuentra en el indice i para la combinatoria
			// recibida
			Element metodo = (Element) arregloMetodos.get(i);

			String strMetodo = metodo.getAttributeValue("nombre");
			cat.debug("Método que se ejecutará["
					+ metodo.getAttributeValue("nombre") + "]");

			// ontiene el valor "registroCambPlanServ"
			String registroCambioPlanServ = global
					.getValor("registro.cambio.plan.serv");
			cat
					.debug("registroCambioPlanServ [" + registroCambioPlanServ
							+ "]");

			// Verifica si el metodo es igual al metodo "registroCambPlanServ"
			boolean bregistroCambioPlanServ = strMetodo
					.equalsIgnoreCase(registroCambioPlanServ);
			cat
					.debug("bregistroCambioPlanServ[" + bregistroCambioPlanServ
							+ "]");

			String codigoPlanServ = registro.getAbonado().getCodPlanServ();
			cat.debug("codigoPlanServ[" + codigoPlanServ + "]");

			String codigoPlanServNuevo = registro.getParamRegistroPlan()
					.getCodPlanServNuevo();
			cat.debug("codigoPlanServNuevo[" + codigoPlanServNuevo + "]");

			boolean bcodigoPlanServ = codigoPlanServ
					.equalsIgnoreCase(codigoPlanServNuevo);
			cat.debug("bcodigoPlanServ[" + bcodigoPlanServ + "]");

			// Si el método que se debe ejecutar es el registroCambPlanServ y el
			// getCodPlanServ del abonado != de nulo y el codPlanServNuevo !=
			// codPlanServ del abonado
			// O si el método que se debe ejecutar != registroCambPlanServ
			// también se ejecuta .
			if ((bregistroCambioPlanServ && (codigoPlanServ != null && !bcodigoPlanServ))
					|| (!bregistroCambioPlanServ)) {

				// Ejecuta el metodo
				cat.debug("Procediendo a ejecutar metodo");
				Object retorno = utilizaMetodo(metodo, registro, objeto);
				cat.debug("Tipo de retorno del método ejecutado :"
						+ retorno.getClass().getName());

				// Verifica si es una secuencia o no para almacenarla
				cat.debug("almacenaSecuencia:antes");
				almacenaSecuencia(retorno);
				cat.debug("almacenaSecuencia:despues");

				// Procede a verificar si hay una etiqueta de loop especifica
				cat.debug("procesarLoopEspecifico:antes");
				//jimmy 
				//procesarLoopEspecifico(objeto, registro, metodo, retorno);
				cat.debug("procesarLoopEspecifico:despues");
			}
		}
		cat.debug("procesandoMetodosXML():end");
	}

	/**
	 * Ejecuta el método descrito en el objeto "metodo".
	 * 
	 * @param metodo
	 *            Element que contiene toda la información referente al método
	 *            que se quiere ejecutar.
	 * @param registro
	 *            Objeto que ha sido encolado, el cual contiene todos los datos
	 *            necesarios para crear el DTO que utiliza el método que se
	 *            invocará.
	 * @return Object que retorna el método que fué invocado(Se debe hacer Cast
	 *         al tipo que retorna originalmente el método para ver su
	 *         resultado).
	 * @throws GeneralException
	 */
	private Object utilizaMetodo(Element metodo, RegistroPlanDTO registro,
			ParamRegistroOrdenServicioDTO objetoCompleto)
			throws  GeneralException {
		cat.debug("utilizaMetodo():start");
		Global global = Global.getInstance();

		// contiene el valor "DTOEntrada"
		String strDTOEntrada = global.getValor("dto.entrada");
		cat.debug("strDTOEntrada[" + strDTOEntrada + "]");

		// Arreglo de tipos de datos que recibe el método que se invocará
		Class tiposEntrada[] = null;

		// Arreglo de parametros que recibe el método que se invocará
		Object arrayObject[] = null;
		Element DTOEntrada = metodo.getChild(strDTOEntrada);

		// Verifica si el dto de entrada es nulo
		// Esta version debe contener el tag DTOEntrada
		if (DTOEntrada == null) {
			cat.debug("DTOEntrada es nulo");
			throw new IssCusOrdException("DTOEntrada es nulo");
		}
		cat.debug("DTOEntrada no es nulo..");

		// contiene el valor del dto de integracion "com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.IntegraProdCPUDTO"
		String strDtoIntegracionCpuProducto = global.getValor("dto.integracion.cpu.producto");
		cat.debug("strDtoIntegracionCpuProducto[" + strDtoIntegracionCpuProducto + "]");	
		
		String DTOEntradaValor = metodo.getChildText(strDTOEntrada);
		
		boolean integracionCpuProducto = DTOEntradaValor.equalsIgnoreCase(strDtoIntegracionCpuProducto);
		cat.debug("integracionCpuProducto[" + integracionCpuProducto + "]");


		//Carga los parametros de entrada en el dto de entrada
		cat.debug("instanciarParametroEntrada:antes");
		instanciarParametroEntrada(objetoCompleto, registro,metodo, strDTOEntrada, arrayObject, tiposEntrada, integracionCpuProducto);
		cat.debug("instanciarParametroEntrada:despues");

		//Ejecuta el metodo en runtime definido en el xml
		cat.debug("ejecutarMetodoenRuntime:antes");
		//jimmy
		Object retornod = null; //Lo puso jimmy borrarlo
		//Object retornod = ejecutarMetodoenRuntime(metodo, tiposEntrada, arrayObject, integracionCpuProducto);
		cat.debug("ejecutarMetodoenRuntime:despues");

		if ((Element) metodo.getChild("Almacenar") != null) {
			cat.debug("-Almacenar-");
			for (int i = 0; i < metodo.getChild("Almacenar").getChildren()
					.size(); i++) {
				String origen = ((Element) metodo.getChild("Almacenar")
						.getChildren().get(i)).getChildText("Origen");
				String destino = ((Element) metodo.getChild("Almacenar")
						.getChildren().get(i)).getChildText("Destino");
				cat.debug("-origen=" + origen);
				cat.debug("-destino=" + destino);
				guardarDatosExtra(retornod, origen, destino);
			}
		}

		cat.debug("utilizaMetodo():end");
		return retornod;

	}

	/**
	 * Ejecuta el metodo en runtime definido en el xml
	 * @param metodo
	 * @param tiposEntrada
	 * @param arrayObject
	 * @return
	 * @throws SupOrdHanException
	 * @throws RemoteException
	 * @throws IssCusOrdException
	 * @throws ClassNotFoundException
	 * @throws IllegalAccessException
	 * @throws IllegalArgumentException
	 * @throws InvocationTargetException
	 * @throws NoSuchMethodException
	 * @throws SecurityException
	 */
	private Object ejecutarMetodoenRuntime(Element metodo, Class[] tiposEntrada, Object[] arrayObject, boolean integracionCpuProducto) throws GeneralException {
		cat.debug("ejecutarMetodoenRuntime():start");
		Object retornod = null;
		Global global = Global.getInstance();
		
		//instancia el manejador de la fachada
		cat.debug("integracionCpuProducto[" + integracionCpuProducto + "]");
		FacadeHelper facade = new FacadeHelper();

		//Verifica si es una integracion de producto con cpu o no.
		if (integracionCpuProducto) {
			cat.debug("Es una integracion de producto con cpu");
			
			
			try {
				cat.debug("creaEstructuraProdCPU:antes");
				integracionProdCPU = (IntegraProdCPUDTO[]) facade.getSupOrdHanFacade()
						.creaEstructuraProdCPU((IntegraProdCPUDTO) arrayObject[0],
								integracionProdCPU);
				cat.debug("creaEstructuraProdCPU:despues");				
			} catch (Exception e) {
				cat.debug("Exception", e);
				throw new IssCusOrdException (e);
			}

			
			retornod = integracionProdCPU;
			
		} else {
			cat.debug("No es una integracion de producto con cpu");
			
			//Obtiene la fachada y su clase asociada
			Object fachada;
			try {
				cat.debug("obtenerFacade:antes");
				fachada = facade.obtenerFacade(metodo);
				cat.debug("obtenerFacade:despues");
			} catch (Exception e) {
				cat.debug("Exception", e);
				throw new IssCusOrdException (e);
			}
			Class clase = fachada.getClass();
			
			cat.debug("Nombre de clase de la fachada[" + clase.getName() + "]");
			
			String strTagNombre = global.getValor("tag.nombre.metodo");
			cat.debug("strTagNombre[" + strTagNombre + "]");

			//Obtiene el nombre del metodo a ejecutar			
			String nombreMetodo = metodo.getAttributeValue(strTagNombre);
			
			
			//Declarando el metodo
			Method miMetodo;
			try {
				cat.debug("Declara el metodo:antes");
				miMetodo = clase.getMethod(nombreMetodo, tiposEntrada);
				cat.debug("Declara el metodo:despues");				
			} catch (Exception e) {
				cat.debug("Exception", e);
				throw new IssCusOrdException (e);
			}
			
			//Ejecutando el metodo
			try {
				cat.debug("Ejecuta el metodo:antes");
				retornod = miMetodo.invoke(fachada, arrayObject);
				cat.debug("Ejecuta el metodo:despues");
			} catch (Exception e) {
				cat.debug("Exception", e);
				throw new IssCusOrdException (e);
			}
			
			//Contiene el valor "registroReordenamientoAbonados"
			String registroReordenamientoAbonados = global.getValor("registro.reordenamiento.abonados");
			cat.debug("registroReordenamientoAbonados[" + registroReordenamientoAbonados + "]");

			// Si es registroReordenamientoAbonados entonces debe rescatar los
			// datos retornados
			// ya que estos son requeridos para la integración CPU-Producto
		
			if (nombreMetodo.equalsIgnoreCase(registroReordenamientoAbonados)){
				integracionProdCPU = retornod != null ? (IntegraProdCPUDTO[]) retornod
						: null;
			}
		}
		cat.debug("ejecutarMetodoenRuntime():end");
		return retornod;
	}
	
	
	/**
	 * Instancia el dto de entrada y sus parametros
	 * @param objetoCompleto
	 * @param registro
	 * @param metodo
	 * @param strDTOEntrada
	 * @param arrayObject
	 * @param tiposEntrada
	 * @param integracionCpuProducto
	 * @throws GeneralException
	 */
	public void instanciarParametroEntrada(ParamRegistroOrdenServicioDTO objetoCompleto, RegistroPlanDTO registro, 
			Element metodo, String strDTOEntrada, Object [] arrayObject, Class[] tiposEntrada, boolean integracionCpuProducto) 
			throws GeneralException {
		
		cat.debug("instanciarParametroEntrada():start");
		//Contiene nombre y package del dto de entrada	
		
		String nombreDTOEntrada = metodo.getChild(strDTOEntrada).getText();
		cat.debug("nombreDTOEntrada[" + nombreDTOEntrada + "]");
		
		//Obtiene una instancia del dto

		Object objEntrada = null;
		try {
			cat.debug("Instanciando clase antes");
			objEntrada = Class.forName(nombreDTOEntrada).newInstance();
			cat.debug("Instanciando clase despues");				
		} catch (Exception e) {
			String msg = "Error instanciando clase[" + nombreDTOEntrada + "]";			
			cat.debug(msg);
			cat.debug("Exception", e);
			throw new IssCusOrdException(msg, e);
		}
			
		
		//Hay que verificar si es una integracion de cpu con producto
		cat.debug("integracionCpuProducto[" + integracionCpuProducto + "]");
		if (integracionCpuProducto) {
			cat.debug("Si es integracion de cpu con producto");
			arrayObject = new Object[2];
			tiposEntrada = new Class[2];
			arrayObject[0] = objEntrada;
			
			//se llena el parametro de entrada
			cat.debug("llenarParametros:antes");
			Object parametroEntrada = llenarParametros(arrayObject[0], metodo, registro, objetoCompleto);
			cat.debug("llenarParametros:despues");
			
			arrayObject[0] = parametroEntrada;
		} else {
			cat.debug("No es integracion de cpu con producto");
			arrayObject = new Object[1];
			tiposEntrada = new Class[1];
			
			arrayObject[0] = objEntrada;
			
			//se llena el parametro de entrada
			cat.debug("llenarParametros:antes");
			Object parametroEntrada = llenarParametros(arrayObject[0], metodo, registro, objetoCompleto);
			cat.debug("llenarParametros:despues");
			
			arrayObject[0] = parametroEntrada;
			tiposEntrada[0] = arrayObject[0].getClass();
		}		
		cat.debug("instanciarParametroEntrada():end");
	}

	/**
	 * Procesa etiqueta loop dentro del xml
	 * 
	 * @param objeto
	 * @param registro
	 * @param metodo
	 * @param retorno
	 */
	private void procesarLoopEspecifico(ParamRegistroOrdenServicioDTO objeto,
			RegistroPlanDTO registro, Element metodo, Object retorno) throws GeneralException {
		cat.debug("procesarLoopEspecifico():start");
		Global global = Global.getInstance();
		// Este procedimiento es especifico para la logica de consulta de listas
		// del socket P+S
		// ver proyecto SocketPSEJB
		if (retorno instanceof ListasDTO) {
			cat
					.debug("El objeto retornado del metodo no es una instancia de ListasDTO");

			String strLoop = global.getValor("loop");
			cat.debug("strLoop[" + strLoop + "]");

			Element loop = metodo.getChild(strLoop);
			// Verifica si encuentra una etiqueta Loop

			cat.debug("va a procesar loop...");
			if (loop != null) {
				cat.debug("Loop != null");
				ListaDTO[] listaActiva = ((ListasDTO) retorno).getLista();

				List arregloMetodosLoop = loop.getChildren();

				int nLista = listaActiva.length;
				cat.debug("nLista[" + nLista + "]");

				// Itera por cada elemento de la lista
				cat.debug("For Lista:antes");
				for (int j = 0; j < nLista; j++) {

					// Setea el parametro de la lista obtenida
					registro.getParamRegistroPlan().setValorListaActiva(
							listaActiva[j].getNumero());

					cat.debug("For Loop: antes");
					int nMetodos = arregloMetodosLoop.size();
					cat.debug("nMetodos[" + nMetodos + "]");

					// Itero en la lista de metodos
					for (int f = 0; f < nMetodos; f++) {

						Element metodoLoop = (Element) arregloMetodosLoop
								.get(f);

						cat.debug("Metodo dentro del Loop["
								+ metodoLoop.getAttributeValue("nombre") + "]");
						Object retornoLoop = utilizaMetodo(metodoLoop,
								registro, objeto);
						cat
								.debug("Tipo de Retorno del objeto dentro del Loop ["
										+ retornoLoop.getClass().getName()
										+ "]");

						cat.debug("almacenaSecuencia:antes");
						almacenaSecuencia(retornoLoop);
						cat.debug("almacenaSecuencia:despues");
					}
					cat.debug("For Loop: despues");
				}
				cat.debug("For Lista:despues");
			} else {
				cat.debug("Loop == null");
			}
		} else {
			cat
					.debug("El objeto retornado del metodo no es una instancia de ListasDTO");
		}
		cat.debug("procesarLoopEspecifico():end");
	}

	/**
	 * Alamacena la secuencia en una estructura Map
	 * 
	 * @param retorno
	 */
	private void almacenaSecuencia(Object retorno) {
		cat.debug("almacenaSecuencia():start");
		// Verifica que el objeto retornado por el metodo sea una instancia de
		// SecuenciaDTO
		if (retorno instanceof SecuenciaDTO) {
			cat
					.debug("retorno es una instacia de SecuenciaDTO.Almacenado la secuencia en el map...");

			// Recupero los valores de la secuencia
			SecuenciaDTO secuencia = (SecuenciaDTO) retorno;

			String nombreSecuencia = secuencia.getNomSecuencia();
			cat.debug("nombreSecuencia[" + nombreSecuencia + "]");

			long numeroSecuencia = secuencia.getNumSecuencia();
			cat.debug("numeroSecuencia[" + numeroSecuencia + "]");

			// Si es una secuencia la guarda en el map de datosExtra para su
			// posterior obtención en
			// algún otro método de la combinatoria.
			cat.debug("Almacenando secuencia:antes");
			datosExtra.put(nombreSecuencia, new Long(numeroSecuencia));
			cat.debug("Almacenando secuencia:despues");

		} else {
			cat.debug("retorno no es una instacia de SecuenciaDTO");
		}
		cat.debug("almacenaSecuencia():end");
	}

	/**
	 * Valida los parametros principales de la orden de servicio
	 * 
	 * @param param
	 * @throws GeneralException
	 */
	private void validacionParametroOrdenServicio(
			ParamRegistroOrdenServicioDTO param) throws GeneralException {
		cat.debug("validacionParametroOrdenServicio():start");

		// Valida el parametro de la cola
		if (param != null) {
			cat.debug("Parametro de la cola distinto de nulo");
		} else {
			cat.debug("Parametro de la cola nulo");
			throw new IssCusOrdException("El objeto que se encolo es nulo");
		}

		// Valida el registro de plan
		RegistroPlanDTO registroPlan = param.getRegistroPlan();

		if (registroPlan == null) {
			cat.debug("Registro de plan nulo");
			throw new IssCusOrdException("Registro de plan nulo");
		}

		// Valida la combinatoria
		String combinatoria = registroPlan.getParamRegistroPlan()
				.getCombinatoria();
		cat.debug("combinatoria[" + combinatoria + "]");

		// Valida la orden de servicio
		String tipoOOSS = registroPlan.getParamRegistroPlan().getTipOOSS();
		cat.debug("tipoOOSS[" + tipoOOSS + "]");

		if (combinatoria == null) {
			cat.debug("Combinatoria nula");
			throw new IssCusOrdException("Combinatoria nula");
		}

		if (tipoOOSS == null) {
			cat.debug("tipoOOSS nula");
			throw new IssCusOrdException("tipoOOSS nula");
		}
		cat.debug("validacionParametroOrdenServicio():end");
	}

	private AbonadoDTO[] obtenerAbonados(String[] numAbonados)
			throws GeneralException {
		cat.debug("obtenerAbonados():start");
		AbonadoDTO[] abonados = new AbonadoDTO[numAbonados.length];
		FacadeHelper facade = new FacadeHelper();
		ManConFacade manConFacade;
		try {
			cat.debug("getManConFacade: antes");
			manConFacade = facade.getManConFacade();
			cat.debug("getManConFacade: desues");
		} catch (IssCusOrdException e) {
			cat.debug("IssCusOrdException", e);
			throw new IssCusOrdException(e);
		} catch (ManConException e) {
			cat.debug("ManConException", e);
			throw new IssCusOrdException(e);
		}

		int n = abonados.length;
		cat.debug("numero de abonados[" + n + "]");

		for (int i = 0; i < abonados.length; i++) {
			abonados[i] = new AbonadoDTO();
			abonados[i].setNumAbonado(Long.valueOf(numAbonados[i]).longValue());
			try {
				cat.debug("obtenerDatosAbonado: antes");
				abonados[i] = manConFacade.obtenerDatosAbonado(abonados[i]);
				cat.debug("obtenerDatosAbonado: despues");
			} catch (RemoteException e) {
				cat.debug("RemoteException", e);
				throw new IssCusOrdException(e);
			}
		}
		cat.debug("obtenerAbonados():end");
		return abonados;
	}

	/**
	 * Realiza lña integracion con cpu
	 * 
	 * @throws GeneralException
	 */
	private void procesaIntegracionconCPU() throws GeneralException {
		cat.debug("procesaIntegracionconCPU():start");

		// verifica que se pueda realizar la integracion con cpu
		if (integracionProdCPU != null && integracionProdCPU.length != 0) {
			int n = integracionProdCPU.length;
			cat.debug("Longitud de integracion[" + n + "]");

			CambioPlanAdicionalDTO[] cambPlan = new CambioPlanAdicionalDTO[n];

			cat.debug("Almacenando estructura para integracion...");
			for (int i = 0; i < n; i++) {
				cambPlan[i] = new CambioPlanAdicionalDTO();
				cambPlan[i].setClienteOrigen(String
						.valueOf(integracionProdCPU[i].getClienteOrigen()));
				cambPlan[i].setAbonadoOrigen(String
						.valueOf(integracionProdCPU[i].getAbonadoOrigen()));
				cambPlan[i].setPlanTarifOrigen(integracionProdCPU[i]
						.getPlanTarifOrigen());
				cambPlan[i].setClienteDestino(String
						.valueOf(integracionProdCPU[i].getClienteDestino()));
				cambPlan[i].setAbonadoDestino(String
						.valueOf(integracionProdCPU[i].getAbonadoDestino()));
				cambPlan[i].setPlanTarifDestino(integracionProdCPU[i]
						.getPlanTarifDestino());
				cambPlan[i].setFechaActivacionPlanes(String
						.valueOf(integracionProdCPU[i]
								.getFechaActivacionPlanes()));
				cambPlan[i].setFechaDesactivacionPlanes(String
						.valueOf(integracionProdCPU[i]
								.getFechaDesactivacionPlanes()));
				cambPlan[i].setNumMovCentral(String
						.valueOf(integracionProdCPU[i].getNumMovCentral()));
				cambPlan[i].setOrigenProceso(integracionProdCPU[i]
						.getOrigenProceso());
				cambPlan[i].setNumProceso(String.valueOf(integracionProdCPU[i]
						.getNumProceso()));
			}
			cat.debug("Almacenando estructura para integracion fin...");

			cat.debug("integrarProductoConCPU:antes");
			integrarProductoConCPU(cambPlan);
			cat.debug("integrarProductoConCPU:despues");
		}
		cat.debug("procesaIntegracionconCPU():end");
	}

	/**
	 * Integra producto con cpu
	 * 
	 * @param cambioPlanAdicionalArr
	 * @throws GeneralException
	 */
	private void integrarProductoConCPU(
			CambioPlanAdicionalDTO[] cambioPlanAdicionalArr)
			throws GeneralException {
		cat.debug("integrarProductoConCPU():start");

		Global global = Global.getInstance();
		boolean aplicaProducto = false;

		// Setea los valores para obtener el parametro general
		ParametroDTO param = new ParametroDTO();

		cat.debug("Seteando los valores del parametro general...");

		String codigoModulo = global.getValor("codigo.modulo");
		cat.debug("codigoModulo[" + codigoModulo + "]");

		param.setCodModulo(codigoModulo);
		param.setCodProducto(1);

		String nombreParametro = global.getValor("nombre.parametro");
		cat.debug("nombre.parametro[" + nombreParametro + "]");

		param.setNomParametro(nombreParametro);

		FacadeHelper facade = new FacadeHelper();

		try {
			cat.debug("obtenerParametroGeneral:antes");
			param = facade.getSupOrdHanFacade().obtenerParametroGeneral(param);
			cat.debug("obtenerParametroGeneral:despues");
		} catch (RemoteException e) {
			cat.debug("RemoteException", e);
			throw new IssCusOrdException(e);
		}

		// Verificando los valores devueltos del parametro general
		if (param != null && param.getValor() != null
				&& param.getValor().equals("TRUE")) {
			aplicaProducto = true;
		} else {
			aplicaProducto = false;
		}

		cat.debug("aplicaProducto[" + aplicaProducto + "]");

		if (aplicaProducto) {
			cat.debug("Ejecutando la integracion...");
			// getCusRelManWSFacade().activarDesactivarMantenerProductos(cambioPlanAdicionalArr);

		}
		cat.debug("integrarProductoConCPU():end");
	}
	
	/**
	 * Se encarga de llenar el objeto DTO que se utilizará para invocar un método determinado 
	 * 
	 * @param objeto Es la instancia del objeto DTO al que se le setean los parametros.
	 * @param metodo Contiene todoa la información referente al método que se quiere utilizar (EJ: Tipo de parametro entrada, salida, y con qué parametros se debe llenar el DTO que utiliza). 
	 * @param registro Objeto que fué encolado y contiene los datos necesarios para llenar el DTO de entrada al método que se quiere utilizar.
	 * @return La instancia del objeto DTO con sus parametros necesarios llenos.
	 * @throws SecurityException
	 * @throws ClassNotFoundException
	 * @throws IllegalArgumentException
	 * @throws IllegalAccessException
	 * @throws InvocationTargetException
	 * @throws NoSuchFieldException
	 * @throws InstantiationException
	 * @throws NoSuchMethodException
	 */
	private Object llenarParametros(Object objeto, Element metodo, RegistroPlanDTO registro, ParamRegistroOrdenServicioDTO objetoCompleto) throws GeneralException {
		cat.debug("llenarParametros():start");
		Global global = Global.getInstance();
		
		//Recupera el valor "Parametros"
		String tagParametros = global.getValor("tag.parametros");
		cat.debug("tagParametros[" + tagParametros + "]");
		
		//Recupera el valor "Secuencia"
		String tagSecuencia = global.getValor("tag.secuencia");
		cat.debug("tagSecuencia[" + tagSecuencia + "]");
		
		//Recupera el valor "Fijo"
		String tagFijo = global.getValor("tag.fijo");
		cat.debug("tagFijo[" + tagFijo + "]");
		
		//Recupera el valor "Guardado"
		String tagGuardado = global.getValor("tag.guardado");
		cat.debug("tagGuardado[" + tagGuardado + "]");
		
		//Recupera el valor "Objeto"
		String tagObjeto = global.getValor("tag.objeto");
		cat.debug("tagObjeto[" + tagObjeto + "]");	
		
		//Recupera el valor "Destino"
		String tagDestino = global.getValor("tag.destino");
		cat.debug("tagDestino[" + tagDestino + "]");
		
		
		//Recupera el valor "Origen"
		String tagOrigen = global.getValor("tag.origen");
		cat.debug("tagOrigen[" + tagOrigen + "]");
		
		//Recupera el valor "ParametrosGenerales"
		String tagParametrosGenerales = global.getValor("tag.parametrosgenerales");
		cat.debug("tagParametrosGenerales[" + tagParametrosGenerales + "]");	
		
		//Recupera el valor "Session"
		String tagSession = global.getValor("tag.session");
		cat.debug("tagSession[" + tagSession + "]");	
		
		
		//Recupera el valor "Tipo"
		String tagTipo = global.getValor("tag.tipo");
		cat.debug("tagTipo[" + tagTipo + "]");		
		
		//Lee la cantidad de parametros del xml
		List oParametros = metodo.getChild("Parametros").getChildren();
		
		//Obtiene la cantidad de parametros
		int cantidadParametros = oParametros.size();
		cat.debug("cantidadParametros[" + cantidadParametros + "]");
		
		String desde;
		String hasta;
		String objetoOrigen;
		Object paramEntrada[] = new Object[1];
		Class clase = objeto.getClass();
		cat.debug("nombre de clase[" + clase.getName() + "]");
		
		cat.debug("Obteniendo los metodos del dto de entrada");
		Method metodos[] = clase.getMethods();
		
		//Procesa los parametros del xml
		for(int i = 0 ; i < cantidadParametros; i++){
			
			cat.debug("Parametro[" + i + "]");
			Element miParametro = (Element) oParametros.get(i);
			
			objetoOrigen = miParametro.getChildText(tagObjeto);
			cat.debug("objetoOrigen[" + objetoOrigen + "]");
			
			//Procesa cada uno de los casos de asignacion del dto
			if(miParametro.getChild(tagSecuencia)!= null){
				//Caso de secuencia
				cat.debug("Entre por tag secuencia");
				cat.debug("seteaParametrosEnDuro:antes");
				seteaParametrosEnDuro(objeto, metodos, miParametro);
				cat.debug("seteaParametrosEnDuro:despues");
			}
			else if(miParametro.getChild(tagFijo)!= null){
				//Caso tag fijo
				cat.debug("Entre por tag fijo");
				cat.debug("seteaParametrosEnDuro:antes");
				seteaParametrosEnDuro(objeto, metodos, miParametro);
				cat.debug("seteaParametrosEnDuro:despues");
			}
			else if(miParametro.getChild(tagGuardado)!= null){
				//Caso tag guardado
				cat.debug("Entre por tag Guardado");
				cat.debug("Seteo parametros que ya fueron guardados en un MAP");
				
				String miGuardado = miParametro.getChildText(tagGuardado);
				cat.debug("miGuardado[" + miGuardado + "]");
				
				String miDestino = miParametro.getChildText(tagDestino);
				cat.debug("miDestino[" + miDestino + "]");
				
				String miTipo = miParametro.getChildText(tagTipo);
				cat.debug("miTipo[" + miTipo + "]");
				
				cat.debug("seteaParametrosDesdeMAP:antes");
				seteaParametrosDesdeMAP(objeto, miGuardado , miDestino, miTipo, metodos);
				cat.debug("seteaParametrosDesdeMAP:despues");
			}
			else if(objetoOrigen != null && objetoOrigen.equalsIgnoreCase(tagParametrosGenerales) && 
					miParametro.getChildren().size()== 1){
				//Caso parametros generales
				cat.debug("Entre por caso de parametros Generales");
				objeto = registro;
			}
			else if(objetoOrigen != null && objetoOrigen.equalsIgnoreCase(tagSession)&& 
					miParametro.getChildren().size()==1){
				//Caso session
				cat.debug("Entre por caso de session");
				objeto = objetoCompleto;
			}
			else{
				//Caso objeto, origen y destino
				cat.debug("Entre por caso de objeto, origen y destino");
				//objetoOrigen =((Element)oParametros.get(i)).getChildText("Objeto");
				desde = miParametro.getChildText(tagOrigen);
				cat.debug("desde[" + desde + "]");
				
				hasta = miParametro.getChildText(tagDestino);
				cat.debug("hasta[" + hasta + "]");
				
				//Busca el metodo a ejecutar en el pool de metodos del dto
				for (int x = 0; x < metodos.length; x++){
					cat.debug("Metodo[" + metodos[x].getName() + "]");
					if (metodos[x].getName().equalsIgnoreCase(hasta)){
						cat.debug("metodo encontrado...");
						Object paso = null;
						try {
							//Obtengo la clase
							Class miclase = registro.getClass();
							cat.debug("clase[" + miclase.getName() + "]");
							
							//Ejemplo. Abonado (Pertenece al tag Objeto)
							String tempMetodo = "get" + objetoOrigen;
							cat.debug("tempMetodo[" + tempMetodo + "]");
							
							cat.debug("Declarando metodo");
							Method oMetodo = miclase.getMethod(tempMetodo, null);
							
							//Obtengo el valor del super objeto. Ejemplo getAbonado(). (Pertenece al tag Objeto)
							cat.debug("Invocando 1:antes");
							paso = oMetodo.invoke(registro, null);
							cat.debug("Invocando 1:despues");
							
							//Obtengo el valor del objeto anidado. Ejemplo.getAbonado().getNumCelular().
							//(Pertenece al tag Origen)
							cat.debug("Invocando 2:antes");
							paso = paso.getClass().getMethod(desde, null).invoke(paso, null);
							cat.debug("Invocando 2:despues");
							
						} catch (Exception e) {
							cat.debug("Exception", e);
							throw new IssCusOrdException (e);
						}
						
						cat.debug("Verficando condicion de paso...");
						if (paso != null && paso.toString().trim().equalsIgnoreCase("null")) {
							cat.debug("Entre por condicion de paso");
							paso = null;
						}
						
						cat.debug("Asignando parametro obtenido...");
						paramEntrada[0] = paso;
						cat.debug("Ejecutando[" + metodos[x].getName() + "] Valor [" + paso + "]");
						try {
							cat.debug("Invocando 3:antes");
							metodos[x].invoke(objeto, paramEntrada);
							cat.debug("Invocando 3:despues");
						} catch (Exception e) {
							cat.debug("Exception", e);
							throw new IssCusOrdException (e);
						}
					}
				}
			}
		}
		cat.debug("llenarParametros():end");
		return objeto;
	}
	
	/**
	 * Setea los parametros desde el Map
	 * @param objeto
	 * @param origen
	 * @param destino
	 * @param tipo
	 * @param metodos
	 * @throws GeneralException
	 */
	private void seteaParametrosDesdeMAP(Object objeto, String origen, String destino, String tipo, Method[]metodos) throws GeneralException{
		cat.debug("seteaParametrosDesdeMAP():start");
		cat.debug("seteaParametrosDesdeMAP, origen, destino=" + origen + "," + destino);
		Object paramEntrada[] = new Object[1];
		for (int x = 0; x < metodos.length; x++){
			if (metodos[x].getName().equalsIgnoreCase(destino)){
				paramEntrada = seteaParametros(tipo, String.valueOf(datosExtra.get(origen)));
				try {
					metodos[x].invoke(objeto, paramEntrada);
				} catch (Exception e) {
					cat.debug("Exception", e);
					throw new IssCusOrdException (e);
				}
			}
		}
		cat.debug("seteaParametrosDesdeMAP():end");
	}

	/**
	 * Setea los parametros de un tipo
	 * @param tipo
	 * @param valorASetear
	 * @return
	 */
	private Object[] seteaParametros(String tipo, String valorASetear){
		cat.debug("seteaParametros():start");
		cat.debug("tipo[" + tipo + "]");
		cat.debug("valorASetear[" + valorASetear + "]");
		Object paramEntrada[] = new Object[1];
		if ((valorASetear == null) || (valorASetear.trim().equalsIgnoreCase("null"))){//(+)evera 22 nov 07
			cat.debug("Es NULL");
			paramEntrada[0] = null;
		}
		else{ 
		if(tipo.equalsIgnoreCase("int")){
			Integer valor;
			valor = new Integer(String.valueOf(valorASetear));
			paramEntrada[0] = valor;
		}else if(tipo.equalsIgnoreCase("String")){
			String valor;
			valor = new String(String.valueOf(valorASetear));
			paramEntrada[0] = valor;
		}else if(tipo.equalsIgnoreCase("long")){
			Long valor; 
			valor = Long.valueOf(String.valueOf(valorASetear));
			paramEntrada[0] = valor;
		}else if(tipo.equalsIgnoreCase("Timestamp")){
			Timestamp valor; 
			valor = Timestamp.valueOf(String.valueOf(valorASetear));
			paramEntrada[0] = valor;
			}
		}//fin if ((valorASetear!=null)
		cat.debug("seteaParametros():end");
		return paramEntrada;
	}

	/**
	 * Lee desde el XML
	 * 
	 * @param objeto Instancia del objeto al que se le setean los parámetros.
	 * @param metodos[] Metodos del DTO al que se le setean los parámetros
	 * @param parametro Element que contiene el valor fijo que se encuentra en el XML y los nombres de los getter y setter a utilizar. 
	 * @return Instancia del objeto de entrada al que se le setean los parámetros, ahora con el parámetro fijo o sequiencia ya seteado. 
	 * @throws IllegalArgumentException
	 * @throws IllegalAccessException
	 * @throws InvocationTargetException
	 */
	private Object seteaParametrosEnDuro(Object objeto, Method metodos[],Element parametro) throws GeneralException {
		cat.debug("seteaParametrosEnDuro():start");
		Object paramEntrada[] = new Object[1];
		String hasta = parametro.getChildText("Destino");
		cat.debug("hasta[" + hasta + "]");
		for (int x = 0; x < metodos.length; x++){
			cat.debug("metodo[" + metodos[x].getName() + "]");
			if (metodos[x].getName().equalsIgnoreCase(hasta)){
				cat.debug("Metodo encontrado...");
				if (parametro.getChild("Secuencia")!= null){
					cat.debug("Caso secuencia");
					if (datosExtra.containsKey(parametro.getChildText("Secuencia"))){
						Long e = ((Long)datosExtra.get(parametro.getChildText("Secuencia")));
						paramEntrada[0] = e;
					}else{
						cat.debug("DEBE ARROJAR EXCEPTION por que la sequencia buscada no se ha seteado aún (MALA CONFIGURACION EN EL XML"); 
					}
				}else{
					cat.debug("Caso fijo");
					cat.debug("seteaParametros:antes");
					paramEntrada = seteaParametros(parametro.getChildText("Fijo"), parametro.getChildText("Valor"));
					cat.debug("seteaParametros:despues");
				}
				cat.debug("Ejecutando " + metodos[x].getName());
				try {
					cat.debug("Ejecutar:antes");
					metodos[x].invoke(objeto, paramEntrada);
					cat.debug("Ejecutar:despues");
				} catch (Exception e) {
					cat.debug("Exception", e);
					throw new IssCusOrdException(e);
				} 
			}
		}
		cat.debug("seteaParametrosEnDuro():end");
		return objeto;
	}
	
	/**
	 * Almacena parametros o variables de salida en el map
	 * @param objeto
	 * @param origen
	 * @param destino
	 * @throws IllegalArgumentException
	 * @throws SecurityException
	 * @throws IllegalAccessException
	 * @throws InvocationTargetException
	 * @throws NoSuchMethodException
	 */
	private void guardarDatosExtra(Object objeto, String origen, String destino) throws GeneralException{
		//Guarda variables en un map
		cat.debug("guardarDatosExtra():start");
		try {
			cat.debug("Colocando parametros en map:antes");
			datosExtra.put(destino, objeto.getClass().getMethod(origen, null).invoke(objeto, null));
			cat.debug("Colocando parametros en map:despues");
		} catch (Exception e) {
			cat.debug("RemoteException", e);
			throw new IssCusOrdException(e);
		}
		cat.debug("guardarDatosExtra():end");
	}	
}
