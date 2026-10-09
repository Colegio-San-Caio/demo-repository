#pragma once
#include <stddef.h>
#include <stdint.h>

// Evergreen / No Date - (0)b - AI bluh ON - No date solved

#define QUBITS_PER_PAGE ((size_t)8)
#define PAGE_COUNT      ((size_t)5)

// 0 by size_t - your base
static const size_t PAGE_0_WHITE       = (size_t)0; // index.html 0-1 white
static const size_t PAGE_1_WHITE       = (size_t)1; // index.html alias
static const size_t PAGE_2_CATALOG     = (size_t)2; // catalog_macro.html
static const size_t PAGE_3_BLACK       = (size_t)3; // candiOQM_xTitin.html black mode
static const size_t PAGE_4_BLACKBLACK  = (size_t)4; // candiOQM_clock.html black black

// qubit stuff macros - all size_t
#define QUBIT_PAGE_BASE(p)        ((size_t)(p))
#define QUBIT_OFFSET(q)           ((size_t)(q))
#define QUBIT_GLOBAL_ADDR(p,q)    (QUBIT_PAGE_BASE(p) * QUBITS_PER_PAGE + QUBIT_OFFSET(q))
#define QUBIT_PAGE_OF(addr)       ((size_t)(addr) / QUBITS_PER_PAGE)
#define QUBIT_INDEX_OF(addr)      ((size_t)(addr) % QUBITS_PER_PAGE)

// for your other macros - 0 by size_t safe
#define PAGE_AT_0(idx)            ((size_t)0 + (size_t)(idx))
#define FOR_EACH_PAGE(i)          for(size_t i = (size_t)0; i < PAGE_COUNT; ++i)
#define FOR_EACH_QUBIT_IN_PAGE(q) for(size_t q = (size_t)0; q < QUBITS_PER_PAGE; ++q)
