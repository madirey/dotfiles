/* idu-hash.h -- decls for hash table
   Copyright (C) 1995, 1999, 2007-2010 Free Software Foundation, Inc.
   Written by Greg McGary <gkm@gnu.ai.mit.edu>

   This program is free software; you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation; either version 3, or (at your option)
   any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.
*/

#ifndef _hash_h_
#define _hash_h_

#include <stdio.h>

typedef unsigned long (*hash_func_t) (void const *key);
typedef int (*hash_cmp_func_t) (void const *x, void const *y);
typedef void (*hash_map_func_t) (void const *item);

struct hash_table
{
  void **ht_vec;
  unsigned long ht_size;	/* total number of slots (power of 2) */
  unsigned long ht_capacity;	/* usable slots, limited by loading-factor */
  unsigned long ht_fill;	/* items in table */
  unsigned long ht_empty_slots;	/* empty slots not including deleted slots */
  unsigned long ht_collisions;	/* # of failed calls to comparison function */
  unsigned long ht_lookups;	/* # of queries */
  unsigned int ht_rehashes;	/* # of times we've expanded table */
  hash_func_t ht_hash_1;	/* primary hash function */
  hash_func_t ht_hash_2;	/* secondary hash function */
  hash_cmp_func_t ht_compare;	/* comparison function */
};

typedef int (*qsort_cmp_t) (void const *, void const *);

extern void hash_init (struct hash_table *ht, unsigned long size,
		       hash_func_t hash_1, hash_func_t hash_2,
		       hash_cmp_func_t hash_cmp);
extern void hash_load (struct hash_table *ht, void *item_table,
		       unsigned long cardinality, unsigned long size);
extern void **hash_find_slot (struct hash_table *ht, void const *key);
extern void *hash_find_item (struct hash_table *ht, void const *key);
extern void *hash_insert (struct hash_table *ht, void *item);
extern void *hash_insert_at (struct hash_table *ht, void *item,
			     void const *slot);
extern void *hash_delete (struct hash_table *ht, void const *item);
extern void *hash_delete_at (struct hash_table *ht, void const *slot);
extern void hash_delete_items (struct hash_table *ht);
extern void hash_free_items (struct hash_table *ht);
extern void hash_free (struct hash_table *ht, int free_items);
extern void hash_map (struct hash_table *ht, hash_map_func_t map);
extern void hash_print_stats (struct hash_table const *ht, FILE *out_FILE);
extern void **hash_dump (struct hash_table const *ht, void **vector_0,
			 qsort_cmp_t compare);

extern void *hash_deleted_item;
#define HASH_VACANT(item) ((item) == 0 || (void *) (item) == hash_deleted_item)


/* hash and comparison macros for string keys. */

#define STRING_HASH_1(_key_, _result_) { \
  unsigned char const *kk = (unsigned char const *) (_key_) - 1; \
  while (*++kk) \
    (_result_) += (*kk << (kk[1] & 0xf)); \
} while (0)
#define return_STRING_HASH_1(_key_) do { \
  unsigned long result = 0; \
  STRING_HASH_1 ((_key_), result); \
  return result; \
} while (0)

#define STRING_HASH_2(_key_, _result_) do { \
  unsigned char const *kk = (unsigned char const *) (_key_) - 1; \
  while (*++kk) \
    (_result_) += (*kk << (kk[1] & 0x7)); \
} while (0)
#define return_STRING_HASH_2(_key_) do { \
  unsigned long result = 0; \
  STRING_HASH_2 ((_key_), result); \
  return result; \
} while (0)

#define STRING_COMPARE(_x_, _y_, _result_) do { \
  unsigned char const *xx = (unsigned char const *) (_x_) - 1; \
  unsigned char const *yy = (unsigned char const *) (_y_) - 1; \
  do { \
    if (*++xx == '\0') { \
      yy++; \
      break; \
    } \
  } while (*xx == *++yy); \
  (_result_) = *xx - *yy; \
} while (0)
#define return_STRING_COMPARE(_x_, _y_) do { \
  int result; \
  STRING_COMPARE (_x_, _y_, result); \
  return result; \
} while (0)

/* hash and comparison macros for integer keys. */

#define INTEGER_HASH_1(_key_, _result_) do { \
  (_result_) += ((unsigned long)(_key_)); \
} while (0)
#define return_INTEGER_HASH_1(_key_) do { \
  unsigned long result = 0; \
  INTEGER_HASH_1 ((_key_), result); \
  return result; \
} while (0)

#define INTEGER_HASH_2(_key_, _result_) do { \
  (_result_) += ~((unsigned long)(_key_)); \
} while (0)
#define return_INTEGER_HASH_2(_key_) do { \
  unsigned long result = 0; \
  INTEGER_HASH_2 ((_key_), result); \
  return result; \
} while (0)

#define INTEGER_COMPARE(_x_, _y_, _result_) do { \
  (_result_) = _x_ - _y_; \
} while (0)
#define return_INTEGER_COMPARE(_x_, _y_) do { \
  int result; \
  INTEGER_COMPARE (_x_, _y_, result); \
  return result; \
} while (0)

/* hash and comparison macros for address keys. */

#define ADDRESS_HASH_1(_key_, _result_) INTEGER_HASH_1 (((unsigned long)(_key_)) >> 3, (_result_))
#define ADDRESS_HASH_2(_key_, _result_) INTEGER_HASH_2 (((unsigned long)(_key_)) >> 3, (_result_))
#define ADDRESS_COMPARE(_x_, _y_, _result_) INTEGER_COMPARE ((_x_), (_y_), (_result_))
#define return_ADDRESS_HASH_1(_key_) return_INTEGER_HASH_1 (((unsigned long)(_key_)) >> 3)
#define return_ADDRESS_HASH_2(_key_) return_INTEGER_HASH_2 (((unsigned long)(_key_)) >> 3)
#define return_ADDRESS_COMPARE(_x_, _y_) return_INTEGER_COMPARE ((_x_), (_y_))

#endif /* not _hash_h_ */
