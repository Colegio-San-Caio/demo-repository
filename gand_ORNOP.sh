#!/bin/bash
echo "Building backend ORNOP..."
mkdir -p backend/src/modules/mishua
cat > backend/src/modules/mishua/unisci.init.h <<'EOF2'
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
EOF2
cat > backend/src/modules/mishua/unisci.init.cpp <<'EOF2'
#include "unisci.init.h"
namespace MISHUA {
    size_t getERPSize(const UNISCI_Init& init) {
        return init.moduleCount * init.bufferSize;
    }
}
EOF2
g++ -c backend/src/modules/mishua/unisci.init.cpp -o unisci.o && echo "UNISCI compiled OK"
