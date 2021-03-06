
library contrast.comparators_test;

import 'package:unittest/unittest.dart';
import 'package:contrast/contrast.dart';

main() {

  group('by', () {

    test('should return comparator which compares by result of key', () {
      var b = by((s) => s.length);
      expect(b('*', '**'), -1);
      expect(b('*', '*'), 0);
      expect(b('**', '*'), 1);
    });

    test('should use `compare` to compare items', () {
      expect(by((s) => s.length, (a, b) => 0)('*', '**'), 0);
    });

  });

  group('reverse', () {

    test('should return upper when not equal', () {
      var r = reverse();
      expect(r(0, 1), 1);
      expect(r(0, 0), 0);
      expect(r(1, 0), -1);
    });

    test('should use `compare` to compare items', () {
      var d = reverse((a, b) => 0);
      expect(d(5, 10), 0);
      expect(d(10, 5), 0);
    });

  });

  group('lexicographic', () {

    test('should treat shorter length arg as less when it prefixes other', () {
      expect(lexicographic()([0, 1], [0, 1, 2]), -1);
    });

    test('should ignore length when shorter does not prefix other', () {
      expect(lexicographic()([1, 2], [0, 1, 2]), 1);
    });

    test('should compare equal when same elements', () {
      expect(lexicographic()([0, 1, 2], [0, 1, 2]), 0);
    });

    test('should compare elements pairwise until non-zero result found', () {
      expect(lexicographic()([0, 1, 3], [0, 1, 2]), 1);
      expect(lexicographic()([0, 1, 2], [0, 1, 3]), -1);
    });

    test('should use `compare` to compare elements', () {
      var l = lexicographic((a, b) => -1);
      expect(l([0], [1]), -1);
      expect(l([1], [0]), -1);
    });

  });

  group('compound', () {

    test('should throw when comparators empty', () {
      expect(() => compound([]), throwsA(new isInstanceOf<ArgumentError>()));
    });

    test('should use tie breaker comparator when zero', () {
      expect(compound([Comparable.compare, (a, b) => -1])(0, 0), -1);
    });

    test('should use base comparator when non-zero', () {
      expect(compound([Comparable.compare, (a, b) => -1])(0, 1), -1);
      expect(compound([Comparable.compare, (a, b) => -1])(1, 0), 1);
    });

    test('should respect custom base comparator', () {
      expect(compound([(a, b) => 1, (a, b) => -1])(0, 0), 1);
    });

  });

  group('nullsFirst', () {

    test('should consider two nulls equal', () {
      expect(nullsFirst()(null, null), 0);
    });

    test('should order null less than non-nulls', () {
      expect(nullsFirst()(null, 0), -1);
      expect(nullsFirst()(0, null), 1);
    });

    test('should order two non-nulls using `compare`', () {
      expect(nullsFirst()(0, 1), -1);
      expect(nullsFirst()(0, 0), 0);
      expect(nullsFirst()(1, 0), 1);
      expect(nullsFirst((a, b) => -1)(1, 0), -1);
    });

  });

  group('nullsLast', () {

    test('should consider two nulls equal', () {
      expect(nullsLast()(null, null), 0);
    });

    test('should order null greater than non-nulls', () {
      expect(nullsLast()(null, 0), 1);
      expect(nullsLast()(0, null), -1);
    });

    test('should order two non-nulls using `compare`', () {
      expect(nullsLast()(0, 1), -1);
      expect(nullsLast()(0, 0), 0);
      expect(nullsLast()(1, 0), 1);
      expect(nullsLast((a, b) => -1)(1, 0), -1);
    });

  });

}
