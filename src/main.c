#include <stdio.h>
#include "kv_store.h"

int main(void)
{
	const char key = 12;

	if( kv_store_delete( &key ) )
		printf("TRUE!\n");

	
	return 0;
}