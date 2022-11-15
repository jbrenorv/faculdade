/*
 * Basic implementation of Suffix Array
 * Time Complexity: O(n*log^2(n))
 * Auxiliary Space: ~5n -> O(n)
 * Font: https://www.geeksforgeeks.org/iterative-quick-sort/
 */

#ifndef BasicSuffixArray_H
#define BasicSuffixArray_H

  #include "IterativeQuickSort.h"

  void buildSuffixArray(int *p, String& s) {
    s += char(0);
    int n = s.length();
    int c[n];
    {
      // k = 0
      pair<char, int> a[n];
      for (int i = 0; i < n; i++)
        a[i] = {s[i], i};
      quickSortIterative(a, 0, n-1);

      for (int i = 0; i < n; i++)
        p[i] = a[i].second;
      c[p[0]] = 0;
      for (int i = 1; i < n; i++)
      {
        if (a[i].first == a[i - 1].first)
          c[p[i]] = c[p[i - 1]];
        else
          c[p[i]] = c[p[i - 1]] + 1;
      }
    }

    int k = 0;
    while ((1 << k) < n)
    {
      // k -> k+1
      pair<pair<int, int>, int> a[n];
      for (int i = 0; i < n; i++)
        a[i] = {{c[i], c[(i + (1 << k)) % n]}, i};
      quickSortIterative(a, 0, n-1);
      for (int i = 0; i < n; i++)
        p[i] = a[i].second;
      c[p[0]] = 0;
      for (int i = 1; i < n; i++)
      {
        if (a[i].first == a[i - 1].first)
          c[p[i]] = c[p[i - 1]];
        else
          c[p[i]] = c[p[i - 1]] + 1;
      }
      k++;
    }
  }

#endif
