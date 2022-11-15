#ifndef PAIR_H
#define PAIR_H

template<typename T1, typename T2>
  struct pair {
    T1 first;
    T2 second;

    void operator=(const pair<T1, T2>& p)
      { first = p.first; second = p.second; }
  };

template<typename T1, typename T2>
  bool operator==(const pair<T1, T2>& a, const pair<T1, T2>& b)
    { return (a.first == b.first && a.second == b.second); }

template<typename T1, typename T2>
  bool operator<(const pair<T1, T2>& a, const pair<T1, T2>& b)
    { return (a.first < b.first || (a.first == b.first && a.second < b.second)); }

template<typename T1, typename T2>
  bool operator>(const pair<T1, T2>& a, const pair<T1, T2>& b)
    { return b < a; }

template<typename T1, typename T2>
  bool operator<=(const pair<T1, T2>& a, const pair<T1, T2>& b)
    { return (a == b || a < b); }

template<typename T1, typename T2>
  bool operator>=(const pair<T1, T2>& a, const pair<T1, T2>& b)
    { return (a == b || a > b); }

#endif
