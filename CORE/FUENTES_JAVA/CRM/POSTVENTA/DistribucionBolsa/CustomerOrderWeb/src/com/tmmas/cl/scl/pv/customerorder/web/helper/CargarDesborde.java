package com.tmmas.cl.scl.pv.customerorder.web.helper;

import java.util.ArrayList;
import java.util.Collection;
import java.util.Iterator;
import java.util.StringTokenizer;

import org.apache.commons.configuration.CompositeConfiguration;
import org.apache.log4j.Category;
import org.apache.struts.util.MessageResources;

import com.tmmas.cl.framework20.util.UtilLog;
import com.tmmas.cl.framework20.util.UtilProperty;
import com.tmmas.cl.scl.pv.customerorder.commonapp.dto.DesbordeDTO;

public class CargarDesborde {
	
	private static Category logger = Category.getInstance(CargarDesborde.class);
	
    private final String NUMERODEDESBORDELABEL = "numero.desbordes";
    private final String DESBORDELABEL = "desborde.";
    private final String SEPARATOR = "separator";
    
    private void CargarDesborde() {
    	setLogFile();
    } 
    
    //private static Logger logger = Logger.getLogger(CargarDesborde.class);
	private CompositeConfiguration config;
	

	private void setLogFile() {
		String strRuta = "/com/tmmas/cl/CustomerOrderWeb/web/properties/";
		String srtRutaDeploy = System.getProperty("user.dir");
		String strArchivoProperties= "CustomerOrderWeb.properties";
		String strArchivoLog="CustomerOrderWeb.log";
		String strRutaArchivoExterno = srtRutaDeploy + "/" + strRuta + strArchivoProperties;
	
		config = UtilProperty.getConfiguration(strRutaArchivoExterno, strRutaArchivoExterno);
		
		UtilLog.setLog(strRuta + config.getString(strArchivoLog) );
		logger.debug("Inicio CommentariesAction");
	}
    

    public Collection cargarConfiguracionDesborde() 
    {
        MessageResources messages = MessageResources.getMessageResources("com.tmmas.cl.scl.pv.customerorder.web.properties.web");
        if (logger.isDebugEnabled()) {
        	logger.debug("cargarConfiguracionDesborde::start");
        }

        ArrayList salida;
        String separator = messages.getMessage(SEPARATOR);
        String numero = messages.getMessage(NUMERODEDESBORDELABEL);
        logger.debug("numero[" + numero + "]");
        int numeroDesbordes = Integer.parseInt(numero);
        salida = new ArrayList();
        String key;
        String valor;
        String nombreDesborde;
        String desDesborde;
        StringTokenizer st;
        for (int i = 0; i < numeroDesbordes; i++) {
            key = DESBORDELABEL.toString() + Integer.toString(i).trim();
            valor = messages.getMessage(key);
            if (logger.isDebugEnabled()) {
            	logger.debug("key[" + key + "]");
            	logger.debug("valor[" + valor + "]");
            }
            st = new StringTokenizer(valor, separator);
            nombreDesborde = st.nextToken();
            desDesborde = st.nextToken();
            if (logger.isDebugEnabled()) {
            	logger.debug("Nombre Desborde[" + nombreDesborde + "]");
            	logger.debug("Descripcion Desborde[" + desDesborde + "]");
            }
            DesbordeDTO dto = new DesbordeDTO();
            dto.setCodigoDesborde(nombreDesborde);
            dto.setDescripcionDesborde(desDesborde);
            salida.add(dto);
        }
        if (logger.isDebugEnabled()) {
        	logger.debug("cargarConfiguracionDesborde::end");
        }
        return salida;
    }
    
    public static String find(String key, Collection listaDesbordes)
    {
    	logger.debug("find():start");
    	logger.debug("key[" + key + "]");
    	String resultado = null;
		Iterator it = listaDesbordes.iterator();
		while (it.hasNext()) {
			DesbordeDTO product = (DesbordeDTO)it.next();
			if (key.equalsIgnoreCase(product.getCodigoDesborde())) {
				logger.debug("Desborde encontrado");
				resultado = product.getDescripcionDesborde();
				return resultado;
			}
			logger.debug("Codigo Desborde[" + product.getCodigoDesborde() + "]");
			logger.debug("Descripcion Desborde[" + product.getDescripcionDesborde() + "]");
		}	
		logger.debug("find():end");
    	return resultado;
    }
}
