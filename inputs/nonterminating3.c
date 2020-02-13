//=============================================================================
// FILE:
//      input_for_hello.c
//
// DESCRIPTION:
//      Sample input file for HelloWorld and InjectFuncCall
//
// License: MIT
//=============================================================================
int foo(int a)
{
	int i = 0;
	while (i < 10)
	{
		i++;
		for (int j = 0; j < i; j++)
			for (int k = 0; k < j; k--)
				continue;
	}
	return a * 2;
}

int bar(int a, int b)
{
	return (a + foo(b) * 2);
}

int fez(int a, int b, int c)
{
	int i = 0;
	return (a + bar(a, b) * 2 + c * 3);
}

int main(int argc, char *argv[])
{
	int a = 123;
	int ret = 0;

	ret += foo(a);
	ret += bar(a, ret);
	ret += fez(a, ret, 123);

	return ret;
}
