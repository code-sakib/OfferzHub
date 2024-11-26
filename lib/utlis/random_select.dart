import 'dart:math';

String randomSubtitle() {
  final list = [
    'Interest in collaborating on this..',
    'Wanna groupbuy?',
    'Need this product, somebody else too?',
    'Anybody up for it..',
    'Need to save money, please collaborate',
  ];

  return list[Random().nextInt(5)];
}
