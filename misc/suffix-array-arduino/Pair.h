/**
* Estrutura de dados para armazenar dois valores de tipos que
* podem ser informados no momento da criacao.
* Ex.: pair<char, int> p = {'a',   1};
*                            ^     ^
*                           char  int
*
* Alguns operadores de ordem são definidos aqui para que
* funcoes de ordenacao funcionem normalmente
*/

#ifndef PAIR_H
#define PAIR_H

template<typename T1, typename T2>
  struct pair {
    T1 first;
    T2 second;

    void operator=(const pair<T1, T2>& p)
      { first = p.first; second = p.second; }
  };

// Operador de ordem ==
template<typename T1, typename T2>
  bool operator==(const pair<T1, T2>& a, const pair<T1, T2>& b)
    { return (a.first == b.first && a.second == b.second); }

// Operador de ordem <
template<typename T1, typename T2>
  bool operator<(const pair<T1, T2>& a, const pair<T1, T2>& b)
    { return (a.first < b.first || (a.first == b.first && a.second < b.second)); }

// Operador de ordem >
template<typename T1, typename T2>
  bool operator>(const pair<T1, T2>& a, const pair<T1, T2>& b)
    { return b < a; }

// Operador de ordem <=
template<typename T1, typename T2>
  bool operator<=(const pair<T1, T2>& a, const pair<T1, T2>& b)
    { return (a == b || a < b); }

// Operador de ordem >=
template<typename T1, typename T2>
  bool operator>=(const pair<T1, T2>& a, const pair<T1, T2>& b)
    { return (a == b || a > b); }

#endif
