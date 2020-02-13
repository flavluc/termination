void bar(int *);
int foo()
{
	int i = 0;
	while (i < 10)
	{
		bar(&i);

		if (i >= 0)
			i++;
		else
			i--;
	}
}