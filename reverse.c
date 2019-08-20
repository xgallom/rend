#include <stdio.h>
#include <unistd.h>

int main(int argc, char *argv[])
{
	if(argc != 3)
		return 1;

	FILE *src = fopen(argv[1], "rb"), *dst = fopen(argv[2], "wb");

	if(!src || !dst)
		return 2;

	fseek(src, 0L, SEEK_END);
	for(long n = ftell(src) - 1; n >= 0; n--) {
		fseek(src, n, SEEK_SET);
		fputc(fgetc(src), dst);
	}

	fclose(src);
	fclose(dst);

	return 0;
}

