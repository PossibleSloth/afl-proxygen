/*
 * Based on ParseURLTest.cpp in proxygen/lib/utils/tests
 */

#include <iostream>
#include "../../proxygen/proxygen/lib/utils/HTTPTime.h"

using proxygen::parseHTTPDateTime;
using std::string;
using std::cin;
using std::getline;

int main(int argc, char *argv[]) {
    string timestring;
   
    getline(cin,timestring);

    auto result = parseHTTPDateTime(timestring);
    if (result.hasValue()) {
        result.value();
    }

    return 0;

}
