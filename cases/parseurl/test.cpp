/*
 * Based on ParseURLTest.cpp in proxygen/lib/utils/tests
 */

#include <iostream>
#include "../../proxygen/proxygen/lib/utils/ParseURL.h"

using proxygen::ParseURL;
using std::string;
using std::cin;

int main(int argc, char *argv[]) {
    string input_url;
   
    cin >> input_url;

    ParseURL url(input_url);
    url.scheme();
    url.path();
    url.query();
    url.host();
    url.port();
    url.authority();
    url.valid();
    url.hostIsIPAddress();
    url.hostNoBrackets();

    return 0;

}
