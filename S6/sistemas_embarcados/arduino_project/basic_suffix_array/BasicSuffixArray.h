/*
 * Basic implementation of Suffix Array
 * Time Complexity: O(n*log^2(n))
 * Auxiliary Space: ~5n -> O(n)
 * Font: https://www.geeksforgeeks.org/iterative-quick-sort/
 */

#ifndef BasicSuffixArray_H
#define BasicSuffixArray_H

  #include "IterativeQuickSort.h"
  #include "Pair.h"
  #define N 128
  
  void _fill(int *a, int value) {
    for (int i = 0; i < N; i++)
      a[i] = value;
  }

  void _copy(int *a, int *b) {
    for (int i = 0; i < N; i++)
      a[i] = b[i];
  }
  
  void _count_sort(int *p, int *c) {
    int cnt[N], p_new[N], pos[N];
    _fill(cnt, 0);    
    for (int i = 0; i < N; i++)
      cnt[c[i]]++;
    pos[0] = 0;
    for (int i = 1; i < N; i++)
      pos[i] = pos[i - 1] + cnt[i - 1];
    for (int i = 0; i < N; i++) {
      int j = c[p[i]];
      p_new[pos[j]] = p[i];
      pos[j]++;      
    }
    _copy(p, p_new);    
  }

  void buildSuffixArray(int *p, char *s/*, const int n, String& s*/) {
    s[N-1] = char(0);
    int c[N];
    {
      // k = 0
      pair<char, int> a[N];
      for (int i = 0; i < N; i++)
        a[i] = {s[i], i};
      quickSortIterative(a, 0, N-1);

      for (int i = 0; i < N; i++)
        p[i] = a[i].second;
      c[p[0]] = 0;
      for (int i = 1; i < N; i++)
      {
        if (a[i].first == a[i - 1].first)
          c[p[i]] = c[p[i - 1]];
        else
          c[p[i]] = c[p[i - 1]] + 1;
      }
    }

    int k = 0;
    while ((1 << k) < N) // log2 (N) vezes
    {
      for (int i = 0; i < N; i++)
        p[i] = (p[i] - (1 << k) + N) % N;

      //quickSortIterative(a, 0, n-1);
      _count_sort(p, c); // N

      int c_new[N];
      c_new[p[0]] = 0;
      pair<int, int> prev;
      pair<int, int> now;

      for (int i = 1; i < N; i++) {
        prev = {c[p[i - 1]], c[(p[i - 1] + (1 << k)) % N]};
        now = {c[p[i]], c[(p[i] + (1 << k)) % N]};

        if (prev == now)
          c_new[p[i]] = c_new[p[i - 1]];
        else
          c_new[p[i]] = c_new[p[i - 1]] + 1;
      }

      _copy(c, c_new);
      k++;
    }
  }

#endif
