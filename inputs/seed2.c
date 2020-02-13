

int main(int argc, char *argv[])
{
	int a = 123;
	int ret = 0;

	while (ret < 1000)
	{
		ret += a;
		ret += ret;
		ret += 123;
	}

	return ret;
}
