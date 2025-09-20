/*
 * Non-Recursive implementation of Quick Sort
 * Time Complexity: O(n*log(n))
 * Auxiliary Space: O(n)
 * Font: https://www.geeksforgeeks.org/iterative-quick-sort/
 */


#ifndef IterativeQuickSort_H
#define IterativeQuickSort_H

  template <typename T>
  void swap(T& a, T& b)
  {
    T aux = a;
    a = b;
    b = aux;
  }

  template <typename T>
  int partition(T* arr, int l, int h)
  {
    T x = arr[h];
    int i = (l - 1);

    for (int j = l; j <= h - 1; j++) {
      if (arr[j] <= x) {
        i++;
        swap(arr[i], arr[j]);
      }
    }
    swap(arr[i + 1], arr[h]);
    return (i + 1);
  }
  
  /* A[] --> Array to be sorted,
  l --> Starting index,
  h --> Ending index */
  template <typename T>
  void quickSortIterative(T* arr, int l, int h)
  {
    // Create an auxiliary stack
    int stack[h - l + 1];

    // initialize top of stack
    int top = -1;

    // push initial values of l and h to stack
    stack[++top] = l;
    stack[++top] = h;

    // Keep popping from stack while is not empty
    while (top >= 0) {
      // Pop h and l
      h = stack[top--];
      l = stack[top--];

      // Set pivot element at its correct position
      // in sorted array
      int p = partition(arr, l, h);

      // If there are elements on left side of pivot,
      // then push left side to stack
      if (p - 1 > l) {
        stack[++top] = l;
        stack[++top] = p - 1;
      }

      // If there are elements on right side of pivot,
      // then push right side to stack
      if (p + 1 < h) {
        stack[++top] = p + 1;
        stack[++top] = h;
      }
    }
  }

#endif
