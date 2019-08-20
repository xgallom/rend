#include <stdio.h>
#include <unistd.h>

struct __attribute__((__packed__)) Color {
	char r, g, b;
};

int main(int argc, char *argv[])
{
	if(argc != 3)
		return 1;

	FILE *src = fopen(argv[1], "rb"), *dst = fopen(argv[2], "wb");

	if(!src || !dst)
		return 2;

	for(int y = 0; y < 200; ++y) {
		struct Color buffer[320], reversedBuffer[320];

		fread(buffer, sizeof(struct Color), 320, src);
		
		for(int n = 0; n < 320; ++n)
			reversedBuffer[319 - n] = buffer[n];

		size_t written = fwrite(reversedBuffer, sizeof(struct Color), 320, dst);
	}

	fclose(src);
	fclose(dst);

	return 0;
}

