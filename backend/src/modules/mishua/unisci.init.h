#pragma once
#include <cstddef>
namespace MISHUA {
    struct UNISCI_Init {
        size_t version = 0x243232;
        size_t moduleCount = 6;
        size_t bufferSize = 4096;
    };
    size_t getERPSize(const UNISCI_Init& init);
}
