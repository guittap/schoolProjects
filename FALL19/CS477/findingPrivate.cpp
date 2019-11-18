#include <iostream>
#include <assert.h>

using namespace std;

int expo(int base, int exponent, int modulus) {
    assert(exponent >= 0);
    assert(modulus > 1);
    int leftside = base % modulus;
    int rightside = exponent;
    int rslt = 1;
    while(rightside > 0) {
        if(rightside%2) rslt = rslt*leftside % modulus;
        leftside = leftside*leftside % modulus;
        rightside = rightside/2;
    }
    return rslt;
}

int main() {
    int message, e = 3, p = 17, q = 23, n = 391, d = 235;
    cout << "The private key is " << endl;
    cout << " Enter a message" << endl;
    //cin >> message;
    message = 41;

    int encrypt = expo(message, e, n);
    cout << "Your message is: " << message << endl;
    cout << "The encryption is " << message << "^" << e << " mod " << n << " = " << encrypt << endl;
    cout << "The decryption is " << encrypt << "^" << d << " mod " << n << " = " << expo(encrypt, d, n) << endl;

    return 0;
}