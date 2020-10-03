#include "bios0.h"
#include "io.h"
#include "biosfunc.h"
#include "boot.h"
#include "startup.h"

void init_iv() {

}

int main() {
    unsigned int i, j;

    while (1) {
        for (i = 0; i < 16; i++) {
            DisplayNumber(i);
            for (j = 0; j < 10000; j++) ;
        }
    }

    init_iv();
    startup();
    boot();

    while (1) ;
}
