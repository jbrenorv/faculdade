#ifndef LINEAR_SYSTEM_H
#define LINEAR_SYSTEM_H

typedef struct linear_system LinearSystem;
typedef enum linear_system_type LinearSystemType;

enum linear_system_type
{
  Determined,
  Undetermined,
  Incompatible
};

struct linear_system
{
  // number of variables or equations
  int n;

  // extended coefficient matrix
  float *extended_matrix;

  // type (determined, undetermined, incompatible)
  enum linear_system_type type;

  // solution
  float *solution;
};

extern struct linear_system *make_linear_system_from_file(char *);

/* find a solution (if any) of an upper triangular linear system */
extern void solve_linear_system_ut(struct linear_system *);

#endif
