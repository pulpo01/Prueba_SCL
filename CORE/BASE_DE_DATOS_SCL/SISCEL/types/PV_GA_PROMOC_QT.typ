CREATE OR REPLACE TYPE PV_GA_PROMOC_QT AS OBJECT
(
SV_COMBINATORIA       VARCHAR2(06),
NUM_ABONADO			  NUMBER  (09),
SN_APLICA			  NUMBER  (01),
SV_MSG				  VARCHAR2(255)
)
/
SHOW ERRORS
