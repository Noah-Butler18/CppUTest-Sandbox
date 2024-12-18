#ifndef _KV_STORE_H
#define _KV_STORE_H

#include <stdint.h>
#include <stdbool.h>

void hv_store_init(void);
bool kv_store_write(const char *key, const void *val, uint32_t len);
bool kv_store_read(const char *key, const void *buf, uint32_t buf_len, uint32_t *len_read);
bool kv_store_delete(const char *key);

#endif /* _KV_STORE_H */