int bar(int a);

int foo()
{
	while (bar(1) == 1)
		continue;
}

// para quaisquer possíveis valores de retorno de bar a função main termina? sim
