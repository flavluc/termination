//=============================================================================
// FILE:
//      input_for_hello.c
//
// DESCRIPTION:
//      Sample input file for HelloWorld and InjectFuncCall
//
// License: MIT
//=============================================================================
#ifndef THIS_IS_UNSUPPORTED
struct INVALID
{
	int i;
};
#endif

int foo(int a)
{
	int i = 0;
	while (i < 10)
		i++;
}

int main(int argc, char *argv[])
{
	int a = 123;

	foo(a);

	return 0;
}
