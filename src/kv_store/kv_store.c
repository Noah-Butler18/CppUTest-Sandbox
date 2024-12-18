#include "kv_store.h"

void hv_store_init(void)
{

}

bool kv_store_write(const char *key, const void *val, uint32_t len)
{
	(void)key;
	(void)val;
	(void)len;
	return true;
}

bool kv_store_read(const char *key, const void *buf, uint32_t buf_len, uint32_t *len_read)
{
	(void)key;
	(void)buf;
	(void)buf_len;
	(void)len_read;
	return true;
}

bool kv_store_delete(const char *key)
{
	(void)key;
	return true;
}