/**
 * WsStructuraClienteDTO.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.4 Apr 22, 2006 (06:55:48 PDT) WSDL2Java emitter.
 */

package dto.quiosco.spnsclwscommon.scl.cl.tmmas.com;

public class WsStructuraClienteDTO  implements java.io.Serializable {
    private dto.quiosco.spnsclwscommon.scl.cl.tmmas.com.WsStructuraAccesorioDTO[] accesorios;

    private dto.quiosco.spnsclwscommon.scl.cl.tmmas.com.WsStructuraActivacionLineaDTO activacion;

    private java.lang.String codCrediticia;

    private java.lang.String codigoCategoria;

    private java.lang.String codigoCategoriaCambio;

    private java.lang.String codigoCliente;

    private java.lang.String codigoOficina;

    private java.lang.String codigoTipoIdent;

    private dto.quiosco.spnsclwscommon.scl.cl.tmmas.com.WsDireccionQuioscoInDTO direccion;

    private java.lang.String nombreApeclien1;

    private java.lang.String nombreApeclien2;

    private java.lang.String nombreCliente;

    private java.lang.String numeroIdent;

    public WsStructuraClienteDTO() {
    }

    public WsStructuraClienteDTO(
           dto.quiosco.spnsclwscommon.scl.cl.tmmas.com.WsStructuraAccesorioDTO[] accesorios,
           dto.quiosco.spnsclwscommon.scl.cl.tmmas.com.WsStructuraActivacionLineaDTO activacion,
           java.lang.String codCrediticia,
           java.lang.String codigoCategoria,
           java.lang.String codigoCategoriaCambio,
           java.lang.String codigoCliente,
           java.lang.String codigoOficina,
           java.lang.String codigoTipoIdent,
           dto.quiosco.spnsclwscommon.scl.cl.tmmas.com.WsDireccionQuioscoInDTO direccion,
           java.lang.String nombreApeclien1,
           java.lang.String nombreApeclien2,
           java.lang.String nombreCliente,
           java.lang.String numeroIdent) {
           this.accesorios = accesorios;
           this.activacion = activacion;
           this.codCrediticia = codCrediticia;
           this.codigoCategoria = codigoCategoria;
           this.codigoCategoriaCambio = codigoCategoriaCambio;
           this.codigoCliente = codigoCliente;
           this.codigoOficina = codigoOficina;
           this.codigoTipoIdent = codigoTipoIdent;
           this.direccion = direccion;
           this.nombreApeclien1 = nombreApeclien1;
           this.nombreApeclien2 = nombreApeclien2;
           this.nombreCliente = nombreCliente;
           this.numeroIdent = numeroIdent;
    }


    /**
     * Gets the accesorios value for this WsStructuraClienteDTO.
     * 
     * @return accesorios
     */
    public dto.quiosco.spnsclwscommon.scl.cl.tmmas.com.WsStructuraAccesorioDTO[] getAccesorios() {
        return accesorios;
    }


    /**
     * Sets the accesorios value for this WsStructuraClienteDTO.
     * 
     * @param accesorios
     */
    public void setAccesorios(dto.quiosco.spnsclwscommon.scl.cl.tmmas.com.WsStructuraAccesorioDTO[] accesorios) {
        this.accesorios = accesorios;
    }

    public dto.quiosco.spnsclwscommon.scl.cl.tmmas.com.WsStructuraAccesorioDTO getAccesorios(int i) {
        return this.accesorios[i];
    }

    public void setAccesorios(int i, dto.quiosco.spnsclwscommon.scl.cl.tmmas.com.WsStructuraAccesorioDTO _value) {
        this.accesorios[i] = _value;
    }


    /**
     * Gets the activacion value for this WsStructuraClienteDTO.
     * 
     * @return activacion
     */
    public dto.quiosco.spnsclwscommon.scl.cl.tmmas.com.WsStructuraActivacionLineaDTO getActivacion() {
        return activacion;
    }


    /**
     * Sets the activacion value for this WsStructuraClienteDTO.
     * 
     * @param activacion
     */
    public void setActivacion(dto.quiosco.spnsclwscommon.scl.cl.tmmas.com.WsStructuraActivacionLineaDTO activacion) {
        this.activacion = activacion;
    }


    /**
     * Gets the codCrediticia value for this WsStructuraClienteDTO.
     * 
     * @return codCrediticia
     */
    public java.lang.String getCodCrediticia() {
        return codCrediticia;
    }


    /**
     * Sets the codCrediticia value for this WsStructuraClienteDTO.
     * 
     * @param codCrediticia
     */
    public void setCodCrediticia(java.lang.String codCrediticia) {
        this.codCrediticia = codCrediticia;
    }


    /**
     * Gets the codigoCategoria value for this WsStructuraClienteDTO.
     * 
     * @return codigoCategoria
     */
    public java.lang.String getCodigoCategoria() {
        return codigoCategoria;
    }


    /**
     * Sets the codigoCategoria value for this WsStructuraClienteDTO.
     * 
     * @param codigoCategoria
     */
    public void setCodigoCategoria(java.lang.String codigoCategoria) {
        this.codigoCategoria = codigoCategoria;
    }


    /**
     * Gets the codigoCategoriaCambio value for this WsStructuraClienteDTO.
     * 
     * @return codigoCategoriaCambio
     */
    public java.lang.String getCodigoCategoriaCambio() {
        return codigoCategoriaCambio;
    }


    /**
     * Sets the codigoCategoriaCambio value for this WsStructuraClienteDTO.
     * 
     * @param codigoCategoriaCambio
     */
    public void setCodigoCategoriaCambio(java.lang.String codigoCategoriaCambio) {
        this.codigoCategoriaCambio = codigoCategoriaCambio;
    }


    /**
     * Gets the codigoCliente value for this WsStructuraClienteDTO.
     * 
     * @return codigoCliente
     */
    public java.lang.String getCodigoCliente() {
        return codigoCliente;
    }


    /**
     * Sets the codigoCliente value for this WsStructuraClienteDTO.
     * 
     * @param codigoCliente
     */
    public void setCodigoCliente(java.lang.String codigoCliente) {
        this.codigoCliente = codigoCliente;
    }


    /**
     * Gets the codigoOficina value for this WsStructuraClienteDTO.
     * 
     * @return codigoOficina
     */
    public java.lang.String getCodigoOficina() {
        return codigoOficina;
    }


    /**
     * Sets the codigoOficina value for this WsStructuraClienteDTO.
     * 
     * @param codigoOficina
     */
    public void setCodigoOficina(java.lang.String codigoOficina) {
        this.codigoOficina = codigoOficina;
    }


    /**
     * Gets the codigoTipoIdent value for this WsStructuraClienteDTO.
     * 
     * @return codigoTipoIdent
     */
    public java.lang.String getCodigoTipoIdent() {
        return codigoTipoIdent;
    }


    /**
     * Sets the codigoTipoIdent value for this WsStructuraClienteDTO.
     * 
     * @param codigoTipoIdent
     */
    public void setCodigoTipoIdent(java.lang.String codigoTipoIdent) {
        this.codigoTipoIdent = codigoTipoIdent;
    }


    /**
     * Gets the direccion value for this WsStructuraClienteDTO.
     * 
     * @return direccion
     */
    public dto.quiosco.spnsclwscommon.scl.cl.tmmas.com.WsDireccionQuioscoInDTO getDireccion() {
        return direccion;
    }


    /**
     * Sets the direccion value for this WsStructuraClienteDTO.
     * 
     * @param direccion
     */
    public void setDireccion(dto.quiosco.spnsclwscommon.scl.cl.tmmas.com.WsDireccionQuioscoInDTO direccion) {
        this.direccion = direccion;
    }


    /**
     * Gets the nombreApeclien1 value for this WsStructuraClienteDTO.
     * 
     * @return nombreApeclien1
     */
    public java.lang.String getNombreApeclien1() {
        return nombreApeclien1;
    }


    /**
     * Sets the nombreApeclien1 value for this WsStructuraClienteDTO.
     * 
     * @param nombreApeclien1
     */
    public void setNombreApeclien1(java.lang.String nombreApeclien1) {
        this.nombreApeclien1 = nombreApeclien1;
    }


    /**
     * Gets the nombreApeclien2 value for this WsStructuraClienteDTO.
     * 
     * @return nombreApeclien2
     */
    public java.lang.String getNombreApeclien2() {
        return nombreApeclien2;
    }


    /**
     * Sets the nombreApeclien2 value for this WsStructuraClienteDTO.
     * 
     * @param nombreApeclien2
     */
    public void setNombreApeclien2(java.lang.String nombreApeclien2) {
        this.nombreApeclien2 = nombreApeclien2;
    }


    /**
     * Gets the nombreCliente value for this WsStructuraClienteDTO.
     * 
     * @return nombreCliente
     */
    public java.lang.String getNombreCliente() {
        return nombreCliente;
    }


    /**
     * Sets the nombreCliente value for this WsStructuraClienteDTO.
     * 
     * @param nombreCliente
     */
    public void setNombreCliente(java.lang.String nombreCliente) {
        this.nombreCliente = nombreCliente;
    }


    /**
     * Gets the numeroIdent value for this WsStructuraClienteDTO.
     * 
     * @return numeroIdent
     */
    public java.lang.String getNumeroIdent() {
        return numeroIdent;
    }


    /**
     * Sets the numeroIdent value for this WsStructuraClienteDTO.
     * 
     * @param numeroIdent
     */
    public void setNumeroIdent(java.lang.String numeroIdent) {
        this.numeroIdent = numeroIdent;
    }

    private java.lang.Object __equalsCalc = null;
    public synchronized boolean equals(java.lang.Object obj) {
        if (!(obj instanceof WsStructuraClienteDTO)) return false;
        WsStructuraClienteDTO other = (WsStructuraClienteDTO) obj;
        if (obj == null) return false;
        if (this == obj) return true;
        if (__equalsCalc != null) {
            return (__equalsCalc == obj);
        }
        __equalsCalc = obj;
        boolean _equals;
        _equals = true && 
            ((this.accesorios==null && other.getAccesorios()==null) || 
             (this.accesorios!=null &&
              java.util.Arrays.equals(this.accesorios, other.getAccesorios()))) &&
            ((this.activacion==null && other.getActivacion()==null) || 
             (this.activacion!=null &&
              this.activacion.equals(other.getActivacion()))) &&
            ((this.codCrediticia==null && other.getCodCrediticia()==null) || 
             (this.codCrediticia!=null &&
              this.codCrediticia.equals(other.getCodCrediticia()))) &&
            ((this.codigoCategoria==null && other.getCodigoCategoria()==null) || 
             (this.codigoCategoria!=null &&
              this.codigoCategoria.equals(other.getCodigoCategoria()))) &&
            ((this.codigoCategoriaCambio==null && other.getCodigoCategoriaCambio()==null) || 
             (this.codigoCategoriaCambio!=null &&
              this.codigoCategoriaCambio.equals(other.getCodigoCategoriaCambio()))) &&
            ((this.codigoCliente==null && other.getCodigoCliente()==null) || 
             (this.codigoCliente!=null &&
              this.codigoCliente.equals(other.getCodigoCliente()))) &&
            ((this.codigoOficina==null && other.getCodigoOficina()==null) || 
             (this.codigoOficina!=null &&
              this.codigoOficina.equals(other.getCodigoOficina()))) &&
            ((this.codigoTipoIdent==null && other.getCodigoTipoIdent()==null) || 
             (this.codigoTipoIdent!=null &&
              this.codigoTipoIdent.equals(other.getCodigoTipoIdent()))) &&
            ((this.direccion==null && other.getDireccion()==null) || 
             (this.direccion!=null &&
              this.direccion.equals(other.getDireccion()))) &&
            ((this.nombreApeclien1==null && other.getNombreApeclien1()==null) || 
             (this.nombreApeclien1!=null &&
              this.nombreApeclien1.equals(other.getNombreApeclien1()))) &&
            ((this.nombreApeclien2==null && other.getNombreApeclien2()==null) || 
             (this.nombreApeclien2!=null &&
              this.nombreApeclien2.equals(other.getNombreApeclien2()))) &&
            ((this.nombreCliente==null && other.getNombreCliente()==null) || 
             (this.nombreCliente!=null &&
              this.nombreCliente.equals(other.getNombreCliente()))) &&
            ((this.numeroIdent==null && other.getNumeroIdent()==null) || 
             (this.numeroIdent!=null &&
              this.numeroIdent.equals(other.getNumeroIdent())));
        __equalsCalc = null;
        return _equals;
    }

    private boolean __hashCodeCalc = false;
    public synchronized int hashCode() {
        if (__hashCodeCalc) {
            return 0;
        }
        __hashCodeCalc = true;
        int _hashCode = 1;
        if (getAccesorios() != null) {
            for (int i=0;
                 i<java.lang.reflect.Array.getLength(getAccesorios());
                 i++) {
                java.lang.Object obj = java.lang.reflect.Array.get(getAccesorios(), i);
                if (obj != null &&
                    !obj.getClass().isArray()) {
                    _hashCode += obj.hashCode();
                }
            }
        }
        if (getActivacion() != null) {
            _hashCode += getActivacion().hashCode();
        }
        if (getCodCrediticia() != null) {
            _hashCode += getCodCrediticia().hashCode();
        }
        if (getCodigoCategoria() != null) {
            _hashCode += getCodigoCategoria().hashCode();
        }
        if (getCodigoCategoriaCambio() != null) {
            _hashCode += getCodigoCategoriaCambio().hashCode();
        }
        if (getCodigoCliente() != null) {
            _hashCode += getCodigoCliente().hashCode();
        }
        if (getCodigoOficina() != null) {
            _hashCode += getCodigoOficina().hashCode();
        }
        if (getCodigoTipoIdent() != null) {
            _hashCode += getCodigoTipoIdent().hashCode();
        }
        if (getDireccion() != null) {
            _hashCode += getDireccion().hashCode();
        }
        if (getNombreApeclien1() != null) {
            _hashCode += getNombreApeclien1().hashCode();
        }
        if (getNombreApeclien2() != null) {
            _hashCode += getNombreApeclien2().hashCode();
        }
        if (getNombreCliente() != null) {
            _hashCode += getNombreCliente().hashCode();
        }
        if (getNumeroIdent() != null) {
            _hashCode += getNumeroIdent().hashCode();
        }
        __hashCodeCalc = false;
        return _hashCode;
    }

    // Type metadata
    private static org.apache.axis.description.TypeDesc typeDesc =
        new org.apache.axis.description.TypeDesc(WsStructuraClienteDTO.class, true);

    static {
        typeDesc.setXmlType(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.spnsclwscommon.quiosco.dto", "WsStructuraClienteDTO"));
        org.apache.axis.description.ElementDesc elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("accesorios");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.spnsclwscommon.quiosco.dto", "Accesorios"));
        elemField.setXmlType(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.spnsclwscommon.quiosco.dto", "WsStructuraAccesorioDTO"));
        elemField.setMinOccurs(0);
        elemField.setNillable(true);
        elemField.setMaxOccursUnbounded(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("activacion");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.spnsclwscommon.quiosco.dto", "Activacion"));
        elemField.setXmlType(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.spnsclwscommon.quiosco.dto", "WsStructuraActivacionLineaDTO"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("codCrediticia");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.spnsclwscommon.quiosco.dto", "CodCrediticia"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("codigoCategoria");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.spnsclwscommon.quiosco.dto", "CodigoCategoria"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("codigoCategoriaCambio");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.spnsclwscommon.quiosco.dto", "CodigoCategoriaCambio"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("codigoCliente");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.spnsclwscommon.quiosco.dto", "CodigoCliente"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("codigoOficina");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.spnsclwscommon.quiosco.dto", "CodigoOficina"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("codigoTipoIdent");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.spnsclwscommon.quiosco.dto", "CodigoTipoIdent"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("direccion");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.spnsclwscommon.quiosco.dto", "Direccion"));
        elemField.setXmlType(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.spnsclwscommon.quiosco.dto", "WsDireccionQuioscoInDTO"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("nombreApeclien1");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.spnsclwscommon.quiosco.dto", "NombreApeclien1"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("nombreApeclien2");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.spnsclwscommon.quiosco.dto", "NombreApeclien2"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("nombreCliente");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.spnsclwscommon.quiosco.dto", "NombreCliente"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("numeroIdent");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.spnsclwscommon.quiosco.dto", "NumeroIdent"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
    }

    /**
     * Return type metadata object
     */
    public static org.apache.axis.description.TypeDesc getTypeDesc() {
        return typeDesc;
    }

    /**
     * Get Custom Serializer
     */
    public static org.apache.axis.encoding.Serializer getSerializer(
           java.lang.String mechType, 
           java.lang.Class _javaType,  
           javax.xml.namespace.QName _xmlType) {
        return 
          new  org.apache.axis.encoding.ser.BeanSerializer(
            _javaType, _xmlType, typeDesc);
    }

    /**
     * Get Custom Deserializer
     */
    public static org.apache.axis.encoding.Deserializer getDeserializer(
           java.lang.String mechType, 
           java.lang.Class _javaType,  
           javax.xml.namespace.QName _xmlType) {
        return 
          new  org.apache.axis.encoding.ser.BeanDeserializer(
            _javaType, _xmlType, typeDesc);
    }

}
