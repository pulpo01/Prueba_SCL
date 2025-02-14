#
# Hugo Sánchez Dibarrart
#


#makefile for the xmlParser library
#
all: xmlTest

xmlTest :
	g++ -fPIC -Wno-deprecated -g -o ${XPF_EXE}/FaConvertCarrier ./cpp/Conf.cpp ./cpp/xmlParser.cpp ./cpp/xmlTest.cpp ./cpp/LogReport.cpp -lstdc++ -ll -lnsl -lresolv -m64 -I./h

clean:
	rm FaConvertCarrier
	rm destino.dat

run: 
	./FaConvertCarrier PlantillaOrigen.xml PlantillaDestino.xml origen.dat destino.dat

