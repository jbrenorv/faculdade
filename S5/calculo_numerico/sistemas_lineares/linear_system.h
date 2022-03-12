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
  float **M;

  // type (determined, undetermined, incompatible)
  enum linear_system_type type;

  // solution
  float *X;
};

/* expected file structure:
  n
  a11 ... a1n b1
  .  .        .
  .    .      .
  .      .    .
  an1 ... ann bn
 */
extern struct linear_system *make_linear_system_from_file(char *);

extern void gauss_method(struct linear_system *);

/* find a solution (if any) of an upper triangular linear system */
extern void solve_linear_system_ut(struct linear_system *);

extern void show_extended_coefficient_matrix(struct linear_system *);

extern void show_solution(struct linear_system *);

#endif
