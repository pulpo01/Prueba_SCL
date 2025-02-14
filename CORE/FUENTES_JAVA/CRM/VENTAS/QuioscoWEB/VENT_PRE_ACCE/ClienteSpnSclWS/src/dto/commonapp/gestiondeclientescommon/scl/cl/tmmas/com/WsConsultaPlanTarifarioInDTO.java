/**
 * WsConsultaPlanTarifarioInDTO.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.4 Apr 22, 2006 (06:55:48 PDT) WSDL2Java emitter.
 */

package dto.commonapp.gestiondeclientescommon.scl.cl.tmmas.com;

public class WsConsultaPlanTarifarioInDTO  implements java.io.Serializable {
    private java.lang.String codCategoria;

    private java.lang.String codSegmento;

    private java.lang.String codTecnologia;

    private int indFamiliar;

    private java.lang.String tipPlanTarif;

    private java.lang.String tipProducto;

    private java.lang.String tipRed;

    public WsConsultaPlanTarifarioInDTO() {
    }

    public WsConsultaPlanTarifarioInDTO(
           java.lang.String codCategoria,
           java.lang.String codSegmento,
           java.lang.String codTecnologia,
           int indFamiliar,
           java.lang.String tipPlanTarif,
           java.lang.String tipProducto,
           java.lang.String tipRed) {
           this.codCategoria = codCategoria;
           this.codSegmento = codSegmento;
           this.codTecnologia = codTecnologia;
           this.indFamiliar = indFamiliar;
           this.tipPlanTarif = tipPlanTarif;
           this.tipProducto = tipProducto;
           this.tipRed = tipRed;
    }


    /**
     * Gets the codCategoria value for this WsConsultaPlanTarifarioInDTO.
     * 
     * @return codCategoria
     */
    public java.lang.String getCodCategoria() {
        return codCategoria;
    }


    /**
     * Sets the codCategoria value for this WsConsultaPlanTarifarioInDTO.
     * 
     * @param codCategoria
     */
    public void setCodCategoria(java.lang.String codCategoria) {
        this.codCategoria = codCategoria;
    }


    /**
     * Gets the codSegmento value for this WsConsultaPlanTarifarioInDTO.
     * 
     * @return codSegmento
     */
    public java.lang.String getCodSegmento() {
        return codSegmento;
    }


    /**
     * Sets the codSegmento value for this WsConsultaPlanTarifarioInDTO.
     * 
     * @param codSegmento
     */
    public void setCodSegmento(java.lang.String codSegmento) {
        this.codSegmento = codSegmento;
    }


    /**
     * Gets the codTecnologia value for this WsConsultaPlanTarifarioInDTO.
     * 
     * @return codTecnologia
     */
    public java.lang.String getCodTecnologia() {
        return codTecnologia;
    }


    /**
     * Sets the codTecnologia value for this WsConsultaPlanTarifarioInDTO.
     * 
     * @param codTecnologia
     */
    public void setCodTecnologia(java.lang.String codTecnologia) {
        this.codTecnologia = codTecnologia;
    }


    /**
     * Gets the indFamiliar value for this WsConsultaPlanTarifarioInDTO.
     * 
     * @return indFamiliar
     */
    public int getIndFamiliar() {
        return indFamiliar;
    }


    /**
     * Sets the indFamiliar value for this WsConsultaPlanTarifarioInDTO.
     * 
     * @param indFamiliar
     */
    public void setIndFamiliar(int indFamiliar) {
        this.indFamiliar = indFamiliar;
    }


    /**
     * Gets the tipPlanTarif value for this WsConsultaPlanTarifarioInDTO.
     * 
     * @return tipPlanTarif
     */
    public java.lang.String getTipPlanTarif() {
        return tipPlanTarif;
    }


    /**
     * Sets the tipPlanTarif value for this WsConsultaPlanTarifarioInDTO.
     * 
     * @param tipPlanTarif
     */
    public void setTipPlanTarif(java.lang.String tipPlanTarif) {
        this.tipPlanTarif = tipPlanTarif;
    }


    /**
     * Gets the tipProducto value for this WsConsultaPlanTarifarioInDTO.
     * 
     * @return tipProducto
     */
    public java.lang.String getTipProducto() {
        return tipProducto;
    }


    /**
     * Sets the tipProducto value for this WsConsultaPlanTarifarioInDTO.
     * 
     * @param tipProducto
     */
    public void setTipProducto(java.lang.String tipProducto) {
        this.tipProducto = tipProducto;
    }


    /**
     * Gets the tipRed value for this WsConsultaPlanTarifarioInDTO.
     * 
     * @return tipRed
     */
    public java.lang.String getTipRed() {
        return tipRed;
    }


    /**
     * Sets the tipRed value for this WsConsultaPlanTarifarioInDTO.
     * 
     * @param tipRed
     */
    public void setTipRed(java.lang.String tipRed) {
        this.tipRed = tipRed;
    }

    private java.lang.Object __equalsCalc = null;
    public synchronized boolean equals(java.lang.Object obj) {
        if (!(obj instanceof WsConsultaPlanTarifarioInDTO)) return false;
        WsConsultaPlanTarifarioInDTO other = (WsConsultaPlanTarifarioInDTO) obj;
        if (obj == null) return false;
        if (this == obj) return true;
        if (__equalsCalc != null) {
            return (__equalsCalc == obj);
        }
        __equalsCalc = obj;
        boolean _equals;
        _equals = true && 
            ((this.codCategoria==null && other.getCodCategoria()==null) || 
             (this.codCategoria!=null &&
              this.codCategoria.equals(other.getCodCategoria()))) &&
            ((this.codSegmento==null && other.getCodSegmento()==null) || 
             (this.codSegmento!=null &&
              this.codSegmento.equals(other.getCodSegmento()))) &&
            ((this.codTecnologia==null && other.getCodTecnologia()==null) || 
             (this.codTecnologia!=null &&
              this.codTecnologia.equals(other.getCodTecnologia()))) &&
            this.indFamiliar == other.getIndFamiliar() &&
            ((this.tipPlanTarif==null && other.getTipPlanTarif()==null) || 
             (this.tipPlanTarif!=null &&
              this.tipPlanTarif.equals(other.getTipPlanTarif()))) &&
            ((this.tipProducto==null && other.getTipProducto()==null) || 
             (this.tipProducto!=null &&
              this.tipProducto.equals(other.getTipProducto()))) &&
            ((this.tipRed==null && other.getTipRed()==null) || 
             (this.tipRed!=null &&
              this.tipRed.equals(other.getTipRed())));
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
        if (getCodCategoria() != null) {
            _hashCode += getCodCategoria().hashCode();
        }
        if (getCodSegmento() != null) {
            _hashCode += getCodSegmento().hashCode();
        }
        if (getCodTecnologia() != null) {
            _hashCode += getCodTecnologia().hashCode();
        }
        _hashCode += getIndFamiliar();
        if (getTipPlanTarif() != null) {
            _hashCode += getTipPlanTarif().hashCode();
        }
        if (getTipProducto() != null) {
            _hashCode += getTipProducto().hashCode();
        }
        if (getTipRed() != null) {
            _hashCode += getTipRed().hashCode();
        }
        __hashCodeCalc = false;
        return _hashCode;
    }

    // Type metadata
    private static org.apache.axis.description.TypeDesc typeDesc =
        new org.apache.axis.description.TypeDesc(WsConsultaPlanTarifarioInDTO.class, true);

    static {
        typeDesc.setXmlType(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto", "WsConsultaPlanTarifarioInDTO"));
        org.apache.axis.description.ElementDesc elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("codCategoria");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto", "CodCategoria"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("codSegmento");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto", "CodSegmento"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("codTecnologia");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto", "CodTecnologia"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("indFamiliar");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto", "IndFamiliar"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "int"));
        elemField.setNillable(false);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("tipPlanTarif");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto", "TipPlanTarif"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("tipProducto");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto", "TipProducto"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("tipRed");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto", "TipRed"));
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
