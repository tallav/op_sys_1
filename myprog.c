#include "types.h"
#include "stat.h"
#include "user.h"
#include "fcntl.h"

int
main(void)
{
  printf(1, "My first xv6 program\n");
  priority(5);
  priority(10);
  priority(1);
  priority(0);
  exit(0);
}
