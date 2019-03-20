#include "types.h"
#include "user.h"
#include "fcntl.h"

int
main(int argc, char **argv)
{
    if(argc < 2){
        printf(2, "usage: policy policy_id...\n");
        exit(0);
    }
    policy(atoi(argv[1]));
    exit(0);
}
