#include <iostream>  // cin, cout
#include <algorithm> // sort
#include <string>    // string, getline
using namespace std;

void buildSuffixArray(int *, const int, string);
void printArray(int *, const int);

int main()
{
  string s;
  getline(cin, s);
  s += char(0);
  int n = s.size();
  int p[n];

  buildSuffixArray(p, n, s);
  printArray(p, n);

  return 0;
}

void buildSuffixArray(int *p, const int n, string s)
{
  int c[n];
  {
    // k = 0
    pair<char, int> a[n];
    for (int i = 0; i < n; i++)
      a[i] = {s[i], i};
    sort(a, a + n);

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
    sort(a, a + n);
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

void printArray(int *p, const int n)
{
  cout << p[0];
  for (int i = 1; i < n; i++)
    cout << ' ' << p[i];
  cout << '\n';
}
