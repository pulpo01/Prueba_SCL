package com.tmmas.IC.RecepcionRespuestas;
import java.io.DataInputStream;
import java.io.DataOutputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.Socket;

public class Cliente{
	
    public static void main(String[] args) throws Exception {
		Socket mSocket = new Socket("piscis",9590);
		InputStream in = mSocket.getInputStream();
		OutputStream out = mSocket.getOutputStream();
		DataInputStream din = new DataInputStream( in );
		DataOutputStream dout = new DataOutputStream( out );    	
        int os = Integer.parseInt(args[0]);
        int i = 1;

		if (args.length > 1) i = Integer.parseInt(args[1]);
		 
        for (int j=1; j<=i;j++) {
		//	SimpleDateFormat fFecha = new SimpleDateFormat("dd'/'MM'/'yyyy HH:mm:ss,S");
		//	String inicio = fFecha.format(new java.util.Date());
        	dout.writeBytes("TICKET=1123659,SIS=SCL,OS=" + os + ",FCM=02072004,HCM=160648,STATUS=OK,SUBERROR=1220,\\KVE=;" + '\n');
        //	System.out.println("Respuesta : " + inicio + " | " + din.readUTF() + " | " + fFecha.format(new java.util.Date()));
			System.out.println("Respuesta : " + din.readUTF() );
			os++;
		}
    }
}