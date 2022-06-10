#include "set_associative_cache.h"
#include "string"
#include <fstream>
#include <cmath>
#include <map>
#include <list>
using namespace std;

float set_associative(string filename, int way, int block_size, int cache_size)
{
    int total_num = -1;
    int hit_num = 0;

    /*write your code HERE*/
    int NumOfBlock = cache_size/block_size;
    int NumOfSet = NumOfBlock/4;
    int indexbit = log2(NumOfSet);
    int offsetbit = log2(block_size);
    int tagbit = 32-indexbit-offsetbit;

    ifstream input_file(filename);
    string line;

    map<int, list<int> > cache;
    while (getline(input_file, line)) {
        line.insert(line.begin(),8-line.length(),'0');
        string bin = hex2bin(line);
        int index = stoi(bin.substr(tagbit, indexbit),0,2);
        int tag = stoi(bin.substr(0, tagbit),0,2);
        map<int,list<int>>::iterator it;
        it = cache.find(index);
        int done=0;
        list<int>::iterator lit;
        if(it!=cache.end()){
            for(lit=it->second.begin();lit!=it->second.end();lit++){
                if(*lit==tag){
                    hit_num++;
                    it->second.erase(lit);
                    it->second.push_back(tag);
                    done=1;
                }
            }
            if(done==0){
                it->second.push_back(tag);
                if(it->second.size()==4){ //remove LRU
                    it->second.push_back(tag);
                }
            }
        }
        else{ //miss
            list<int> temp;
            temp.resize(4);
            temp.push_back(tag);
            cache[index] = temp;
        }
        total_num++;
    }
    return (float)hit_num/total_num;
}

string hex2bin(string hex) {
    string ret = "";
    for (int i = 0; i < hex.length(); i++) {
        switch (hex[i]) {
        case '0':
            ret += "0000";
            break;
        case '1':
            ret += "0001";
            break;
        case '2':
            ret += "0010";
            break;
        case '3':
            ret += "0011";
            break;
        case '4':
            ret += "0100";
            break;
        case '5':
            ret += "0101";
            break;
        case '6':
            ret += "0110";
            break;
        case '7':
            ret += "0111";
            break;
        case '8':
            ret += "1000";
            break;
        case '9':
            ret += "1001";
            break;
        case 'a':
            ret += "1010";
            break;
        case 'b':
            ret += "1011";
            break;
        case 'c':
            ret += "1100";
            break;
        case 'd':
            ret += "1101";
            break;
        case 'e':
            ret += "1110";
            break;
        case 'f':
            ret += "1111";
            break;
        }
    }
    return ret;
}