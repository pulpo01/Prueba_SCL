package com.tmmas.gte.integraciongtecommon.dto;

import java.lang.reflect.Field;
import java.lang.reflect.Method;
import java.util.ArrayList;

public class ObtenerCampos {

	 public String nombre;
	 public String valor;
	 
	public static  ArrayList getAttributes(Class objeto,Object DTO) 
	{
		
		 ArrayList getters = new ArrayList(); 
	        
	        Method []metodos = objeto.getMethods();
	        //Field  []fields  = objeto.getDeclaredFields();
	        for (int i=0;i<metodos.length; i++)
	        {
	           Method metodo = metodos[i];
	           //Field field = fields[i];
	           NombreCamposDTO nombreCamposDTO = new NombreCamposDTO();
	           if(metodo.getName().substring(0, 3).equals("get"))
	          {
	                try{
	                	nombreCamposDTO.setNombreCampo(metodo.getName().substring(3));
	                	nombreCamposDTO.setValorCampo(""+metodo.invoke(DTO,null));
	                   }
	                catch (Exception e) {
	                    e.printStackTrace();
	                    nombreCamposDTO.setValorCampo(e.getMessage()) ;
	                }
	                if(!(nombreCamposDTO.getNombreCampo()).equals("SerialVersionUID")&&(!(nombreCamposDTO.getNombreCampo()).equals("Auditoria"))&&(!(nombreCamposDTO.getNombreCampo()).equals("Class")))
	                {
	                	getters.add(nombreCamposDTO);
	                }
	           }
	           if(metodo.getName().substring(0, 2).equals("is"))
	           {
	        	   try{
	                	nombreCamposDTO.setNombreCampo(metodo.getName().substring(2));
	                	nombreCamposDTO.setValorCampo(""+metodo.invoke(DTO,null));
	        		  // nombreCamposDTO.setNombreCampo(field.getName());
	        		   
	                }
	                catch (Exception e) {
	                    e.printStackTrace();
	                    nombreCamposDTO.setValorCampo(e.getMessage()) ;
	                }
	                getters.add(nombreCamposDTO);
	        	   
	           }
	        }
	    return   getters;
	}
}















