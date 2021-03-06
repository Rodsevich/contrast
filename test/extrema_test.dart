
library contrast.extrema_test;

import 'package:unittest/unittest.dart';
import 'package:quiver/time.dart';
import 'package:contrast/contrast.dart';

main() {

  group('min', () {

    test('should return lower when not equal', () {
      expect(min(aSecond, aMinute), aSecond);
    });

    test('should return first argument when equal', () {
      expect(min(aSecond, aSecond * 1), same(aSecond));
    });

    test('should use `compare` to compare items', () {
      expect(min(1, 0, compare: (a, b) => -1), 1);
    });

  });

  group('max', () {

    test('should return upper when not equal', () {
      expect(max(aSecond, aMinute), aMinute);
    });

    test('should return first argument when equal', () {
      expect(max(aSecond, aSecond * 1), same(aSecond));
    });

    test('should use `compare` to compare items', () {
      expect(max(1, 0, compare: (a, b) => -1), 0);
    });

  });

  group('clamp', () {

    test('should return lower when value less than lower', () {
      expect(clamp(aMillisecond, aSecond, aMinute), aSecond);
    });

    test('should return upper when value greater than upper', () {
      expect(clamp(anHour, aSecond, aMinute), aMinute);
    });

    test('should return value when equal to lower', () {
      var aSecondCopy = new Duration(seconds: 1);
      expect(clamp(aSecondCopy, aSecond, aMinute), same(aSecondCopy));
    });

    test('should return value when equal to upper', () {
      var aMinuteCopy = new Duration(minutes: 1);
      expect(clamp(aMinuteCopy, aSecond, aMinute), same(aMinuteCopy));
    });

    test('should use `compare` to compare items', () {
      var d = (a, b) => b.compareTo(a);
      expect(clamp(anHour, aMinute, aSecond, compare: d), aMinute);
      expect(clamp(aMillisecond, aMinute, aSecond, compare: d), aSecond);
      expect(clamp(aMinute, anHour, aSecond, compare: d), aMinute);
    });

  });

  group('between', () {

    test('should be true iff min <= value <= max', () {
      expect(between(aMillisecond, aSecond, anHour), isFalse);
      expect(between(aSecond,      aSecond, anHour), isTrue);
      expect(between(aMinute,      aSecond, anHour), isTrue);
      expect(between(anHour,       aSecond, anHour), isTrue);
      expect(between(aDay,         aSecond, anHour), isFalse);
    });

    test('should use `compare` to compare items', () {
      var d = (a, b) => b.compareTo(a);
      expect(between(aMillisecond, anHour, aSecond, compare: d), isFalse);
      expect(between(aSecond,      anHour, aSecond, compare: d), isTrue);
      expect(between(aMinute,      anHour, aSecond, compare: d), isTrue);
      expect(between(anHour,       anHour, aSecond, compare: d), isTrue);
      expect(between(aDay,         anHour, aSecond, compare: d), isFalse);
    });

  });

  group('minOf', () {

    test('should return the minimum element', () {
      expect(minOf([2,5,1,4]), 1);
    });

    test('should return null if empty', () {
      expect(minOf([]), null);
    });

    test('should return result of orElse if empty and orElse null', () {
      expect(minOf([], orElse: () => 5), 5);
    });

  });

  group('maxOf', () {

    test('should return the maximum element', () {
      expect(maxOf([2,5,1,4]), 5);
    });

    test('should return null if empty and orElse null', () {
      expect(maxOf([]), null);
    });

    test('should return result of orElse if empty and orElse not null', () {
      expect(maxOf([], orElse: () => 5), 5);
    });

  });


}
