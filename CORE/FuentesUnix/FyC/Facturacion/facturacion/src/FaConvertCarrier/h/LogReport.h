#ifndef _LOGREPORT_H_
#define _LOGREPORT_H_

#include <iostream>
#include <cstdlib>
#include <cstdio>
#include <cstring>
#include <vector>
#include <string>

using namespace std;

// contenedor de campos
typedef vector<string> contCampo_t;

class LogReport {
	private:
		contCampo_t campos;
		int state_file;
		FILE      *fp;
		int openFile();
		int writeFile(char *buff, int len);
	public:
		LogReport();
		~LogReport();
		int init(char *namelog);
		int addCampo(const char *campo);
		int printCampos();
		int closeFile();
		string nameLog;
};






#endif // _LOGREPORT_H_
