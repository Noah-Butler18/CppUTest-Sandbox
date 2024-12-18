#include "average.h"

float Average(float nums[], int len)
{
	float mean = 0;

	for(int i = 0; i < len; i++)
	{
		mean += nums[i];
	}

	return (mean / ((float) len));
}