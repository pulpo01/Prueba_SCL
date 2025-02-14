/**
 * CargosDTO.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.4 Apr 22, 2006 (06:55:48 PDT) WSDL2Java emitter.
 */

package dataTransferObject.customerDomain.framework.scl.tmmas.com;

public class CargosDTO  implements java.io.Serializable {
    private dataTransferObject.customerDomain.framework.scl.tmmas.com.AtributosCargoDTO atributo;

    private int cantidad;

    private dataTransferObject.customerDomain.framework.scl.tmmas.com.DescuentoDTO[] descuento;

    private java.lang.String idProducto;

    private dataTransferObject.customerDomain.framework.scl.tmmas.com.PrecioDTO precio;

    public CargosDTO() {
    }

    public CargosDTO(
           dataTransferObject.customerDomain.framework.scl.tmmas.com.AtributosCargoDTO atributo,
           int cantidad,
           dataTransferObject.customerDomain.framework.scl.tmmas.com.DescuentoDTO[] descuento,
           java.lang.String idProducto,
           dataTransferObject.customerDomain.framework.scl.tmmas.com.PrecioDTO precio) {
           this.atributo = atributo;
           this.cantidad = cantidad;
           this.descuento = descuento;
           this.idProducto = idProducto;
           this.precio = precio;
    }


    /**
     * Gets the atributo value for this CargosDTO.
     * 
     * @return atributo
     */
    public dataTransferObject.customerDomain.framework.scl.tmmas.com.AtributosCargoDTO getAtributo() {
        return atributo;
    }


    /**
     * Sets the atributo value for this CargosDTO.
     * 
     * @param atributo
     */
    public void setAtributo(dataTransferObject.customerDomain.framework.scl.tmmas.com.AtributosCargoDTO atributo) {
        this.atributo = atributo;
    }


    /**
     * Gets the cantidad value for this CargosDTO.
     * 
     * @return cantidad
     */
    public int getCantidad() {
        return cantidad;
    }


    /**
     * Sets the cantidad value for this CargosDTO.
     * 
     * @param cantidad
     */
    public void setCantidad(int cantidad) {
        this.cantidad = cantidad;
    }


    /**
     * Gets the descuento value for this CargosDTO.
     * 
     * @return descuento
     */
    public dataTransferObject.customerDomain.framework.scl.tmmas.com.DescuentoDTO[] getDescuento() {
        return descuento;
    }


    /**
     * Sets the descuento value for this CargosDTO.
     * 
     * @param descuento
     */
    public void setDescuento(dataTransferObject.customerDomain.framework.scl.tmmas.com.DescuentoDTO[] descuento) {
        this.descuento = descuento;
    }

    public dataTransferObject.customerDomain.framework.scl.tmmas.com.DescuentoDTO getDescuento(int i) {
        return this.descuento[i];
    }

    public void setDescuento(int i, dataTransferObject.customerDomain.framework.scl.tmmas.com.DescuentoDTO _value) {
        this.descuento[i] = _value;
    }


    /**
     * Gets the idProducto value for this CargosDTO.
     * 
     * @return idProducto
     */
    public java.lang.String getIdProducto() {
        return idProducto;
    }


    /**
     * Sets the idProducto value for this CargosDTO.
     * 
     * @param idProducto
     */
    public void setIdProducto(java.lang.String idProducto) {
        this.idProducto = idProducto;
    }


    /**
     * Gets the precio value for this CargosDTO.
     * 
     * @return precio
     */
    public dataTransferObject.customerDomain.framework.scl.tmmas.com.PrecioDTO getPrecio() {
        return precio;
    }


    /**
     * Sets the precio value for this CargosDTO.
     * 
     * @param precio
     */
    public void setPrecio(dataTransferObject.customerDomain.framework.scl.tmmas.com.PrecioDTO precio) {
        this.precio = precio;
    }

    private java.lang.Object __equalsCalc = null;
    public synchronized boolean equals(java.lang.Object obj) {
        if (!(obj instanceof CargosDTO)) return false;
        CargosDTO other = (CargosDTO) obj;
        if (obj == null) return false;
        if (this == obj) return true;
        if (__equalsCalc != null) {
            return (__equalsCalc == obj);
        }
        __equalsCalc = obj;
        boolean _equals;
        _equals = true && 
            ((this.atributo==null && other.getAtributo()==null) || 
             (this.atributo!=null &&
              this.atributo.equals(other.getAtributo()))) &&
            this.cantidad == other.getCantidad() &&
            ((this.descuento==null && other.getDescuento()==null) || 
             (this.descuento!=null &&
              java.util.Arrays.equals(this.descuento, other.getDescuento()))) &&
            ((this.idProducto==null && other.getIdProducto()==null) || 
             (this.idProducto!=null &&
              this.idProducto.equals(other.getIdProducto()))) &&
            ((this.precio==null && other.getPrecio()==null) || 
             (this.precio!=null &&
              this.precio.equals(other.getPrecio())));
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
        if (getAtributo() != null) {
            _hashCode += getAtributo().hashCode();
        }
        _hashCode += getCantidad();
        if (getDescuento() != null) {
            for (int i=0;
                 i<java.lang.reflect.Array.getLength(getDescuento());
                 i++) {
                java.lang.Object obj = java.lang.reflect.Array.get(getDescuento(), i);
                if (obj != null &&
                    !obj.getClass().isArray()) {
                    _hashCode += obj.hashCode();
                }
            }
        }
        if (getIdProducto() != null) {
            _hashCode += getIdProducto().hashCode();
        }
        if (getPrecio() != null) {
            _hashCode += getPrecio().hashCode();
        }
        __hashCodeCalc = false;
        return _hashCode;
    }

    // Type metadata
    private static org.apache.axis.description.TypeDesc typeDesc =
        new org.apache.axis.description.TypeDesc(CargosDTO.class, true);

    static {
        typeDesc.setXmlType(new javax.xml.namespace.QName("java:com.tmmas.scl.framework.customerDomain.dataTransferObject", "CargosDTO"));
        org.apache.axis.description.ElementDesc elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("atributo");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.scl.framework.customerDomain.dataTransferObject", "Atributo"));
        elemField.setXmlType(new javax.xml.namespace.QName("java:com.tmmas.scl.framework.customerDomain.dataTransferObject", "AtributosCargoDTO"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("cantidad");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.scl.framework.customerDomain.dataTransferObject", "Cantidad"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "int"));
        elemField.setNillable(false);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("descuento");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.scl.framework.customerDomain.dataTransferObject", "Descuento"));
        elemField.setXmlType(new javax.xml.namespace.QName("java:com.tmmas.scl.framework.customerDomain.dataTransferObject", "DescuentoDTO"));
        elemField.setMinOccurs(0);
        elemField.setNillable(true);
        elemField.setMaxOccursUnbounded(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("idProducto");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.scl.framework.customerDomain.dataTransferObject", "IdProducto"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("precio");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.scl.framework.customerDomain.dataTransferObject", "Precio"));
        elemField.setXmlType(new javax.xml.namespace.QName("java:com.tmmas.scl.framework.customerDomain.dataTransferObject", "PrecioDTO"));
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
