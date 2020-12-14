#include <stdio.h>
#include <stdlib.h>
#include <windows.h>

int main()
{

    typedef int (*TestFunc)();

    TestFunc _TestFunc;

    getchar();
    HINSTANCE hGetProcIDDLL = LoadLibrary("DLL.dll");

    if (!hGetProcIDDLL)
    {
        printf("could not load the dynamic library");
        return EXIT_FAILURE;
    }

    _TestFunc = (TestFunc)GetProcAddress(hGetProcIDDLL, "abrir");

    if (!_TestFunc)
    {
        printf("could not locate the function");
        return EXIT_FAILURE;
    }
    else
    {
        printf("hahaha");
        _TestFunc();
    }
    FreeLibrary(hGetProcIDDLL);
    getchar();
}
