CREATE OR REPLACE PACKAGE GA_ELIGEDIRECCION_PG IS

   PROCEDURE GA_DATOSCLIENTE_PR (EV_cod_cliente IN OUT NOCOPY VARCHAR2,
                                 EV_apellido    IN OUT NOCOPY VARCHAR2,
                                 EV_salida      IN OUT NOCOPY VARCHAR2);


   PROCEDURE GA_IP_COLOMBIA_PR (EV_ip          IN OUT NOCOPY VARCHAR2,
                                EV_puerto      IN OUT NOCOPY VARCHAR2,
                                EV_codregistro IN OUT NOCOPY VARCHAR2,
                                EV_salida      IN OUT NOCOPY VARCHAR2);

END GA_ELIGEDIRECCION_PG;
/
SHOW ERRORS
