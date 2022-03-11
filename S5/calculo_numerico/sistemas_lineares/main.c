#include <stdio.h>
#include "linear_system.h"

int main(int argc, char **argv)
{
  if (argc < 2)
  {
    printf("Usage: path-to-program path-to-file-with-linear-system-data\n");
    return 0;
  }

  LinearSystem *linear_system = make_linear_system_from_file(argv[1]);

  if (linear_system != NULL)
    printf("Success\n");
  else
    printf("Failed\n");

  return 0;
}
