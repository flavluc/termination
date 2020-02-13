

int main(int argc, char *argv[])
{
	int a = 123;
	int ret = 0;

	while (ret < 1000)
	{
		for (int i = 0; i < 10; i++)
		{
			ret += a;
			ret += ret;
			ret += 123;
		}
	}

	return ret;
}
