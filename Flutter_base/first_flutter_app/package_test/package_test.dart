
// 找到数组最小元素
num minValue(List<num> array) {
  num min;
  for (var item in array) {
    if (min < item) {
      min = item;
    }
  }
  return min;
}