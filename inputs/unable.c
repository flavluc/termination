void bar(int *, int);

int foo()
{
	int r, i = 0;
	while (i < 10)
	{
		bar(&r, i);

		if (r > 0)
			i++;
		else
			i--;
	}
}