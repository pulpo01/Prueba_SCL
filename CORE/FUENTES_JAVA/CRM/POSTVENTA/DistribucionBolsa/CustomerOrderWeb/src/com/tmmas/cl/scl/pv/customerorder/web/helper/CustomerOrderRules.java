package com.tmmas.cl.scl.pv.customerorder.web.helper;

import java.rmi.RemoteException;
import java.util.HashMap;
import java.util.Map;

import org.apache.commons.configuration.CompositeConfiguration;
import org.apache.log4j.Category;
//import org.apache.log4j.Logger;

import com.tmmas.cl.framework.util.StackTraceUtl;
import com.tmmas.cl.framework20.util.UtilLog;
import com.tmmas.cl.framework20.util.UtilProperty;
import com.tmmas.cl.scl.pv.customerorder.commonapp.dto.CustomerAccountDTO;
import com.tmmas.cl.scl.pv.customerorder.commonapp.dto.ProductDTO;
import com.tmmas.cl.scl.pv.customerorder.commonapp.dto.ProductListDTO;
import com.tmmas.cl.scl.pv.customerorder.commonapp.dto.ReglasSSDTO;
import com.tmmas.cl.scl.pv.customerorder.commonapp.exception.CustomerOrderException;
import com.tmmas.cl.scl.pv.customerorder.web.delegate.CustomerOrderDelegate;


public class CustomerOrderRules {
	 
	  private Map todosServicios= new HashMap();
	  private Map contratadosMap= new HashMap();
	  private Map nocontratadosMap= new HashMap();
	  private Map transferenciaMap=new HashMap();
	  private ProductDTO[] contratadosTabla;
	  private ProductDTO[] nocontratadosTabla;
	  private ProductDTO[] transferenciaTabla;
	  private ReglasSSDTO[] reglasTabla;
	  private StringBuffer serviciosIncompatibles=new StringBuffer();
	  private long cust;
	  private CustomerAccountDTO customerAccount=new CustomerAccountDTO();
	/**
	 * 
	 * @param 
	 * @throws 
	 */
	  
	  
	   private static Category logger = Category.getInstance(CustomerOrderRules.class);
	  
		private CompositeConfiguration config;
		
		
		private void CustomerOrderRules() {
			setLogFile();
		}

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
	  
	  
	  public String GetServiciosIncompatibles(){
		  return serviciosIncompatibles.toString();
	  }
	  public ProductDTO[] getTransferenciaTabla(){
		  return this.transferenciaTabla;
	  }
	/**
	 * 
	 * @param 
	 * @throws 
	 */
	  public ProductDTO[] getContratadosTabla(){
		  return this.contratadosTabla;
	  }
	/**
	 * 
	 * @param 
	 * @throws 
	 */
	  public ProductDTO[] getNocontratadosTabla(){

		  return this.nocontratadosTabla;
	  }
	/**
	 * 
	 * @param 
	 * @throws 
	 */
	  public ReglasSSDTO[] getReglasTabla(){
		  return this.reglasTabla;
	  }
	/**
	 * 
	 * @param 
	 * @throws 
	 */
	  public long getCust(){
		  return this.cust;
	  }
	/**
	 * 
	 * @param 
	 * @throws 
	 */
	  public CustomerOrderRules getCustomerOrderRules(){
		  return this;
	  }
	/**
	 * 
	 * @param 
	 * @throws 
	 */
	  public CustomerAccountDTO getCustomerAccount(){
		  return this.customerAccount;
	  }
	/**
	 * 
	 * @param 
	 * @throws 
	 */
	  public void setCustomerAccount(long cust){
		  
		  logger.debug("setCustomerAccount():start");
		
		  logger.debug("cust ["+cust+"]");
	  
		  if(this.cust!=cust){
			  this.cust=cust;
		  }		  		  
		  logger.debug("setCustomerAccount():end");		  
	  }
	/**
	 * 
	 * @param 
	 * @throws 
	 */
	  public ProductDTO[] getServiciosContratados() 
	  {
		  int i;
		  logger.debug("getServiciosContratados():start");
		  ProductListDTO listaProductos=new ProductListDTO();
		  CustomerOrderDelegate validador=CustomerOrderDelegate.getInstance();
		  try{
			  this.customerAccount.setCode(this.cust);
			  logger.debug("this.customerAccount ["+this.customerAccount.getCode()+"]");
			  listaProductos= validador.getInstalledCustomerAccountProductBundle(this.customerAccount);
		  }catch(CustomerOrderException e){
			  String log = StackTraceUtl.getStackTrace(e);
			  logger.debug("CustomerOrderException[" + log + "]");
		  }
		  
		  this.contratadosTabla=listaProductos.getProducts();
		  for(i=0;i<contratadosTabla.length;i++){
			  todosServicios.put(contratadosTabla[i].getId(),contratadosTabla[i]);
		  }
		  for(i=0;i<contratadosTabla.length;i++){
			  contratadosMap.put(contratadosTabla[i].getId(),contratadosTabla[i]);
		  }

		  contratadosTabla=(ProductDTO[])contratadosMap.values().toArray(new ProductDTO[contratadosMap.size()]);
		  logger.debug("getServiciosContratados():end");
		  return this.contratadosTabla;
	  }
	/**
	 * 
	 * @param 
	 * @throws 
	 */
	  public ProductDTO[] getServiciosNoContratados() 
	  {
		  int i;
		  
		  ProductListDTO listaProductos=new ProductListDTO();
		  CustomerOrderDelegate validador=CustomerOrderDelegate.getInstance();
		  try{
			  this.customerAccount.setCode(this.cust);
			  listaProductos= validador.getUnInstalledCustomerAccountProductBundle(this.customerAccount);
		  }catch(RemoteException e){
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("CustomerOrderException[" + log + "]");
		  }catch(CustomerOrderException e){
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("CustomerOrderException[" + log + "]");
		  }
		  
		  this.nocontratadosTabla=listaProductos.getProducts();
		  for(i=0;i<nocontratadosTabla.length;i++){
			  todosServicios.put(nocontratadosTabla[i].getId(),nocontratadosTabla[i]);
		  }
		  for(i=0;i<nocontratadosTabla.length;i++){
			  nocontratadosMap.put(nocontratadosTabla[i].getId(),nocontratadosTabla[i]);
		  }

		  nocontratadosTabla=(ProductDTO[])nocontratadosMap.values().toArray(new ProductDTO[nocontratadosMap.size()]);
		  
		  return this.nocontratadosTabla;
		  
	  }
	/**
	 * 
	 * @param 
	 * @throws 
	 */
	  public ReglasSSDTO[] getReglas() {
		  
		  CustomerOrderDelegate validador=CustomerOrderDelegate.getInstance();
		  try{
			  this.reglasTabla= validador.getReglasdeValidacionSS();
		  }catch(RemoteException e){
			  String log = StackTraceUtl.getStackTrace(e);
			  logger.debug("CustomerOrderException[" + log + "]");
		  }catch(CustomerOrderException e){
			  String log = StackTraceUtl.getStackTrace(e);
			  logger.debug("CustomerOrderException[" + log + "]");
		  }
		  
		  return this.reglasTabla;
	  }
	/**
	 * 
	 * @param 
	 * @throws 
	 */
	  public ProductDTO[] ValidaProductoSeleccionado( String idproducto){
		 int i=0;
		 
		 ProductDTO[] validacion=null;
		 ProductDTO producto=new ProductDTO();
		 
		 producto.setId(idproducto);
		 ValidacionReglasSS validador=new ValidacionReglasSS();
		 /***** Retorna tabla de ligaduras incluyendo el producto seleccionado *****/
		 serviciosIncompatibles=new StringBuffer();
		 validacion=validador.ValidaCheckedSS(this.reglasTabla,this.contratadosTabla,this.nocontratadosTabla, producto,serviciosIncompatibles);
		 transferenciaMap.clear();
		  for(i=0;i<validacion.length;i++){
			  transferenciaMap.put(validacion[i].getId(),todosServicios.get(validacion[i].getId()));
		  }
		 this.transferenciaTabla=(ProductDTO[])transferenciaMap.values().toArray(new ProductDTO[transferenciaMap.size()]);

		 return this.transferenciaTabla;
	 }
	/**
	 * 
	 * @param 
	 * @throws 
	 */
	 public ProductDTO[] ValidaProductoDesSeleccionado(String idproducto){
		 int i=0;
		 ProductDTO[] validacion=null;
		 ProductDTO producto=new ProductDTO();
		 
		 producto.setId(idproducto);
		 ValidacionReglasSS validador=new ValidacionReglasSS();
		 /**** Retorna tabla de transferencia de productos ****/
		 validacion=validador.ValidaUnCheckedSS(this.reglasTabla,this.contratadosTabla,producto,this.nocontratadosTabla);
		 
		 transferenciaMap.clear();
		  for(i=0;i<validacion.length;i++){
			  transferenciaMap.put(validacion[i].getId(),todosServicios.get(validacion[i].getId()));
		  }
		 this.transferenciaTabla=(ProductDTO[])transferenciaMap.values().toArray(new ProductDTO[transferenciaMap.size()]);

		 return this.transferenciaTabla;
	 
	 }
	/**
	 * 
	 * @param 
	 * @throws 
	 */
	 public ProductDTO[] InstalaServicio(String idProducto)
	 {		 
		 this.AgregaServicioComoContratado(idProducto);
		 this.QuitaServicioComoNoContratado(idProducto);
		 this.TransfiereServicios();
		 return this.contratadosTabla;		 
	 }
	/**
	 * 
	 * @param 
	 * @throws 
	 */
	 public ProductDTO[] DesInstalaServicio(String idProducto){
		 
		 this.AgregaServicioComoNoContratado(idProducto);
		 this.QuitaServicioComoContratado(idProducto);
		 this.TransfiereServicios();
		 return this.nocontratadosTabla;
		 
	 }
	/**
	 * 
	 * @param 
	 * @throws 
	 */
	 private void QuitaServicioComoContratado(String idProducto){
		  
		  contratadosMap.remove(idProducto);
		  contratadosTabla=(ProductDTO[])contratadosMap.values().toArray(new ProductDTO[contratadosMap.size()]);
	 }
	/**
	 * 
	 * @param 
	 * @throws 
	 */
	 private void AgregaServicioComoNoContratado(String idProducto){
		  
		  nocontratadosMap.put(idProducto,todosServicios.get(idProducto));
		  nocontratadosTabla=(ProductDTO[])nocontratadosMap.values().toArray(new ProductDTO[nocontratadosMap.size()]);
	 }
	/**
	 * 
	 * @param 
	 * @throws 
	 */
	 private void QuitaServicioComoNoContratado(String idProducto){

		  nocontratadosMap.remove(idProducto);
		  nocontratadosTabla=(ProductDTO[])nocontratadosMap.values().toArray(new ProductDTO[nocontratadosMap.size()]);
	 }
	/**
	 * 
	 * @param 
	 * @throws 
	 */
	 private void AgregaServicioComoContratado(String idProducto){
		  
		  contratadosMap.put(idProducto,todosServicios.get(idProducto));
		  contratadosTabla=(ProductDTO[])contratadosMap.values().toArray(new ProductDTO[contratadosMap.size()]);
	 }
	/**
	 * 
	 * @param 
	 * @throws 
	 */
	 private void TransfiereServicios(){
		 int i=0;
		 
		 for(i=0;i<transferenciaTabla.length;i++){
			  this.AgregaServicioComoContratado((transferenciaTabla[i].getId()));
			  this.QuitaServicioComoNoContratado((transferenciaTabla[i].getId()));
		  }

	 }
	 
}







