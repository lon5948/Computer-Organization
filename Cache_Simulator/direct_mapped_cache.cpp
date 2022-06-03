#include "direct_mapped_cache.h"
#include "string"
#include <iostream>
#include <fstream>
#include <cmath>
#include <vector>
#include <sstream>
#include <bitset>
using namespace std;

string hex2bin(string hex);

float direct_mapped(string filename, int block_size, int cache_size){
    
    int total_num = -1;
    int hit_num = 0;

    int offset = log2(block_size);
    int indexNum = log2(cache_size/block_size);
    int tagNum = 32-offset-indexNum;

    vector<long long> vec;
    vec.resize(cache_size/block_size,0);
    vector<bool> valid;
    valid.resize(cache_size/block_size,false);

    ifstream input_file(filename);
    string line;
    string bin;
    while (getline(input_file, line)){
        bin = hex2bin(line);
        int index = stoi(bin.substr(tagNum,tagNum+indexNum-1));
        int tag = stoi(bin.substr(0,tagNum-1));
        if(valid[index]==true && vec[index]==tag){
            hit_num++;
        }
        else{
            valid[index] = true;
            vec[index] = tag;
        }
        total_num++;
    }
    return (float)hit_num/total_num;
}

string hex2bin(string hex){
    string ret = ""; 
    for(int i=0;i<hex.length();i++){
        switch(hex[i]){
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
