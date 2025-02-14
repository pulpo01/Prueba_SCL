
<%!

public String convierte(String numero)	{

	String parteEntero = null;
	String parteDecimal = null;
	
	java.math.BigDecimal bdNumero = new java.math.BigDecimal(numero);
	bdNumero = bdNumero.setScale(4, java.math.BigDecimal.ROUND_DOWN);
	
	System.out.println("bdNumero: " + bdNumero.toString());
	
	java.util.StringTokenizer st = new java.util.StringTokenizer(bdNumero.toString(), ".");
	
//	String[] partes = bdNumero.toString().split(".");

	if(st.hasMoreTokens()){
		
		parteEntero = st.nextToken();
	}
	
	if(st.hasMoreTokens()){
		
		parteDecimal = st.nextToken();
	}
	
	String texto = "";
	int cont = 0;
	
	double numeroN = bdNumero.doubleValue();
	
	if(numeroN >= 0){

		for (int i=parteEntero.length()-1; i>=0; i--)	{
			cont++;
			texto = texto + parteEntero.charAt(i);
			if ((cont==3) && (i != 0)){
				texto = texto + ",";
				cont = 0;
			} // if
		} // for
		
	}else{
		//no considera el signo menos
		for (int i=parteEntero.length()-1; i>0; i--)	{
			cont++;
			texto = texto + parteEntero.charAt(i);
			if ((cont==3) && (i != 1)){
				texto = texto + ",";
				cont = 0;
			} // if
		} // for
	}

	String textoFinal = "";

	for (int i=texto.length()-1; i>=0; i--){
		
		textoFinal= textoFinal + texto.charAt(i);
		
	}

	if(numeroN < 0){
	
		textoFinal = "-" + textoFinal;
		
	}

	if(parteDecimal == null){
		return textoFinal;
	}else{
		return textoFinal+"."+parteDecimal;
	}
		
	
} // convierte

%>