extension ContainsAll on List {
  bool containsAll(List<int> x) {
    return contains(x[0]) && contains(x[1]) && contains(x[2]);
  }
}

extension Min on List {
  min(List<int> x) {
    return (contains(x[0]) && contains(x[1]) && !contains(x[2])) ||
        (contains(x[0]) && !contains(x[1]) && contains(x[2])) ||
        (!contains(x[0]) && contains(x[1]) && contains(x[2]));
  }
}


extension Num on List {

  num(List<int> x) {
    int? e ;
    int? c1;
    int? c2;
    if (contains(x[0]) && contains(x[1]) && !contains(x[2])) {
       e = x[2];
       c1 = x[0];
       c2 = x[1];
     // return true;
    } else if (contains(x[0]) && !contains(x[1]) && contains(x[2])) {
       e = x[1];
       c1 = x[0];
       c2 = x[2];
      //return true;
    } else if (!contains(x[0]) && contains(x[1]) && contains(x[2])) {
       e = x[0];
       c1 = x[1];
       c2 = x[2];
      //return true;
    }
      return [e,c1,c2];
  }
}
