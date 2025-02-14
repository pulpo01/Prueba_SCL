#include "LogReport.h"

#define LENGTH_NAME_FILE     255
#define LENGTH_BUFFER       1024
        
#define NAME_IS_NOT_SET     0x10
#define NAME_IS_SET         0x11
#define NAME_FILE_TOO_LONG  0x12
#define NAME_IS_NULL        0x13
#define NAME_OF_OUT_IS_NULL 0x14

#define NO_IS_END_OF_FILE   0x00
#define UNABLE_OPEN_FILE    0x20
#define FILE_IS_OPENED      0x21
#define FILE_IS_CLOSED      0x22

#define LENGTH_FLAG            3
#define OPEN_ONLY_READ       "r"
#define OPEN_READ_WRITE     "r+"
#define CREATE_WRITE         "w"
#define CREATE_READ_WRITE   "w+"
#define OPEN_APEND           "a"
#define OPEN_CREAT_APEND    "a+"

#define OUT_BUFFER_NULL     0x30
#define ERROR_READ_STRING   0x31
#define ERROR_WRITE_STRING  0x32
#define END_OF_FILE         0x33

#define SEPARADOR_CAMPOS		"\t"


LogReport::LogReport():state_file(FILE_IS_CLOSED) {}

LogReport::~LogReport() {
	closeFile();
}

int LogReport::openFile() {
	if         (state_file == FILE_IS_OPENED) {
    return 0;
  }

	if (nameLog.size() == 0) return NAME_IS_NULL;
  
  fp = fopen((const char *)nameLog.c_str(), CREATE_READ_WRITE);

  if (fp == (FILE *) NULL) {
    return UNABLE_OPEN_FILE;
  }
  
  state_file = FILE_IS_OPENED;

  return 0;	
}

int LogReport::closeFile() {
	if (state_file == FILE_IS_CLOSED) {
    return 0;
  }
  
  fclose(fp);
  
  state_file = FILE_IS_CLOSED;
	nameLog = "";
  fp =  (FILE *) NULL;

  return 0;
}

int LogReport::writeFile(char *buff, int len) {
	if (fp == (FILE *)NULL) return FILE_IS_CLOSED;
	if (buff == 0) return OUT_BUFFER_NULL;
	if (len <= 0) return OUT_BUFFER_NULL;
	int rtn = fwrite( (const void *)buff, sizeof(unsigned char), len, fp );
	
	if (rtn < len) return ERROR_WRITE_STRING;
	
	return 0;
}
		
int LogReport::init(char *namelog) {
	nameLog = namelog;
	openFile();
	
	return 0;
}

int LogReport::addCampo(const char *campo) {
	if (campo == 0) return -1;
	char cmpo[LENGTH_BUFFER];
	strcpy(cmpo, campo);
	for (int i = 0; i < strlen(cmpo); ++i) {
		if (cmpo[i] == '\t') { cmpo[i] = ' ';}
	}
	string camp = cmpo;
	campos.push_back(camp);
	
	return 0;
}

int LogReport::printCampos() {
	char buff[LENGTH_BUFFER];
	
	memset(buff, 0, LENGTH_BUFFER);
	
	contCampo_t::iterator itr;
		
	bool pves = true;
	for (itr = campos.begin(); itr != campos.end(); ++itr) {
		if (pves == false) {
			strcat(buff, SEPARADOR_CAMPOS);
		}
		strcat(buff, itr->c_str());
		pves = false;
	}
	
	buff[strlen(buff)] = '\n';
	buff[strlen(buff)+1] = 0;
	
	int rtn = writeFile(buff, strlen(buff));
	
	campos.clear();
	
	return rtn;
}




