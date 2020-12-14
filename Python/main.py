import ctypes

lib = ctypes.WinDLL("DLL.dll")

Somar = lib.Somar
Somar.restype = ctypes.c_int
Somar.argtypes = ctypes.c_int, ctypes.c_int

retval = Somar(800, 1000)
print(retval)

Subtrair = lib.Subtrair
Subtrair.restype = ctypes.c_int
Subtrair.argtypes = ctypes.c_int, ctypes.c_int

retval = Subtrair(8000, 1000)
print(retval)

Mutiplicar = lib.Mutiplicar
Mutiplicar.restype = ctypes.c_int
Mutiplicar.argtypes = ctypes.c_int, ctypes.c_int

retval = Mutiplicar(5566, 45)
print(retval)

Dividir = lib.Dividir
Dividir.restype = ctypes.c_double
Dividir.argtypes = ctypes.c_double, ctypes.c_double

retval = Dividir(66.44, 77.63)
print(retval)

TesteString = lib.testeString
TesteString.restype = ctypes.c_wchar_p
TesteString.argtypes = ctypes.c_wchar_p, ctypes.c_wchar_p

c_name = ctypes.c_wchar_p('Murilo')
c_last = ctypes.c_wchar_p('Beluco')

retval = TesteString(c_name, c_last)
print(retval)

tela = lib.abrir
tela()
