//=============================================================================
// FILE:
//      input_for_hello.c
//
// DESCRIPTION:
//      Sample input file for HelloWorld and InjectFuncCall
//
// License: MIT
//=============================================================================

#include <stdio.h>
#include <stdlib.h>

int main(int argc, char *argv[])
{
	int r, i = 10;
	while (i > 0)
	{
		scanf("%i", &r);

		if (r > 0)
			i++;
		else
			i--;
	}

	return 0;
}