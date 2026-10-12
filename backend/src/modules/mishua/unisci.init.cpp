#include "unisci.init.h"
namespace MISHUA {
    size_t getERPSize(const UNISCI_Init& init) {
        return init.moduleCount * init.bufferSize;
    }
}
