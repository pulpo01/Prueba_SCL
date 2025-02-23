CREATE OR REPLACE PACKAGE PV_TIPOS_PG IS

   TYPE R_PV_IORSERV 	   	  		   IS TABLE OF PV_IORSERV%ROWTYPE 		 	    INDEX BY BINARY_INTEGER;
   TYPE R_PV_ERECORRIDO       	 	   IS TABLE OF PV_ERECORRIDO%ROWTYPE 	 	    INDEX BY BINARY_INTEGER;
   TYPE R_PV_CAMCOM  	   	  	 	   IS TABLE OF PV_CAMCOM%ROWTYPE 	 	 	    INDEX BY BINARY_INTEGER;
   TYPE R_PV_PARAM_ABOCEL     	 	   IS TABLE OF PV_PARAM_ABOCEL%ROWTYPE 	 	    INDEX BY BINARY_INTEGER;
   TYPE R_PV_PARAM_CLIENTE     	 	   IS TABLE OF PV_PARAM_CLIENTE%ROWTYPE	 	    INDEX BY BINARY_INTEGER;--OCB
   TYPE R_PV_PROG		   	  	 	   IS TABLE OF PV_PROG%ROWTYPE 	 		 	    INDEX BY BINARY_INTEGER;
   TYPE R_PV_MOVIMIENTOS      	 	   IS TABLE OF PV_MOVIMIENTOS%ROWTYPE 	 	    INDEX BY BINARY_INTEGER;
   TYPE R_PV_TRASPASO_CARGOS   	 	   IS TABLE OF PV_TRASPASO_CARGOS%ROWTYPE  	    INDEX BY BINARY_INTEGER; --OCB

   TYPE R_GA_SERVSUPLABO 	  	 	   IS TABLE OF GA_SERVSUPLABO%ROWTYPE 	 	    INDEX BY BINARY_INTEGER;
   TYPE R_GA_INTARCEL		  	 	   IS TABLE OF GA_INTARCEL%ROWTYPE		 	   	INDEX BY BINARY_INTEGER;
   TYPE R_GA_INTARCEL_ACCIONES_TO	   IS TABLE OF GA_INTARCEL_ACCIONES_TO%ROWTYPE	INDEX BY BINARY_INTEGER;
   TYPE R_PV_ICGENERICA_TO		  	   IS TABLE OF PV_ICGENERICA_TO%ROWTYPE		 	INDEX BY BINARY_INTEGER;
   TYPE R_GE_CLIENTES 				   IS TABLE OF GE_CLIENTES%ROWTYPE		 		INDEX BY BINARY_INTEGER;
   TYPE R_GA_ABOAMI_PROM 			   IS TABLE OF GA_ABOAMI_PROM%ROWTYPE		 	INDEX BY BINARY_INTEGER;
   TYPE R_FA_CICLFACT 			   	   IS TABLE OF FA_CICLFACT%ROWTYPE		 		INDEX BY BINARY_INTEGER;
   TYPE R_GA_HDTOSTARIF   			   IS TABLE OF GA_HDTOSTARIF%ROWTYPE		 	INDEX BY BINARY_INTEGER;
   TYPE R_GA_DTOSTARIF 				   IS TABLE OF GA_DTOSTARIF%ROWTYPE		 	    INDEX BY BINARY_INTEGER;
   TYPE R_ICG_CENTRAL 			   	   IS TABLE OF ICG_CENTRAL%ROWTYPE		 		INDEX BY BINARY_INTEGER;
   TYPE R_GA_NUMCEL_PERSONAL_TO 	   IS TABLE OF GA_NUMCEL_PERSONAL_TO%ROWTYPE	INDEX BY BINARY_INTEGER;
   TYPE R_GA_ABOCEL		               IS TABLE OF GA_ABOCEL%ROWTYPE		        INDEX BY BINARY_INTEGER;
   TYPE TIP_GA_SEGMENTACION_CARGOS 	   IS TABLE OF PV_SEGMENTACION_CARGOS_TD%ROWTYPE 	INDEX BY BINARY_INTEGER;
   TYPE TIP_TA_CARGOSBASICO            IS TABLE OF TA_CARGOSBASICO%ROWTYPE          INDEX BY BINARY_INTEGER;
   TYPE TIP_TA_PLANTARIF			   IS TABLE OF TA_PLANTARIF%ROWTYPE             INDEX BY BINARY_INTEGER;
   TYPE TIP_GED_CODIGOS   			   IS TABLE OF GED_CODIGOS%ROWTYPE              INDEX BY BINARY_INTEGER;
   TYPE TIP_GA_ABOCEL   			   IS TABLE OF GA_ABOCEL%ROWTYPE		        INDEX BY BINARY_INTEGER;
   TYPE tip_ve_matrizestados_td		   IS TABLE OF ve_matrizestados_td%ROWTYPE		INDEX BY BINARY_INTEGER;
   TYPE TIP_AL_ARTICULOS               IS TABLE OF AL_ARTICULOS%ROWTYPE             INDEX BY BINARY_INTEGER;
   TYPE TIP_GAD_DESCUENTOS             IS TABLE OF GAD_DESCUENTOS%ROWTYPE           INDEX BY BINARY_INTEGER;
   TYPE TIP_VE_TIPCOMIS                IS TABLE OF VE_TIPCOMIS%ROWTYPE              INDEX BY BINARY_INTEGER;
   TYPE TIP_FA_CONCEPTOS			   IS TABLE OF FA_CONCEPTOS%ROWTYPE             INDEX BY BINARY_INTEGER;
   TYPE TIP_GAT_EST_DEVLEQUIPOS        IS TABLE OF GAT_EST_DEVLEQUIPOS%ROWTYPE      INDEX BY BINARY_INTEGER;

--   TYPE TIP_GA_PENALIZA                IS TABLE OF GA_PENALIZA%ROWTYPE              INDEX BY BINARY_INTEGER;
--   TYPE TIP_GA_IMPPENALIZA             IS TABLE OF GA_IMPPENALIZA%ROWTYPE              INDEX BY BINARY_INTEGER;
   --TYPE TIP_GA_PERCONTRATO             IS TABLE OF GA_PERCONTRATO%ROWTYPE            INDEX BY BINARY_INTEGER;
   --TYPE TIP_GA_ACTUASERV               IS TABLE OF GA_ACTUASERV%ROWTYPE              INDEX BY BINARY_INTEGER;
   --TYPE TIP_GA_SERVICIOS               IS TABLE OF GA_SERVICIOS%ROWTYPE              INDEX BY BINARY_INTEGER;


END PV_TIPOS_PG;
/
SHOW ERRORS
