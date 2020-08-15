import 'package:flutter/material.dart';
import 'dart:math' as math;

class PlayCard {
  final CardRank rank;
  final CardSuit suit;

  PlayCard(this.rank, this.suit);

  Color color() {
    switch (suit) {
      case CardSuit.clubs:
      case CardSuit.spades:
        return Colors.black;
      case CardSuit.diamonds:
      case CardSuit.hearts:
      default:
        return Colors.red[600];
    }
  }

  @override
  String toString() => '$rank of $suit';
}

class CardRank {
  static const CardRank ace = const CardRank._ofValue(1, 'Ace');
  static const CardRank two = const CardRank._ofValue(2, '2');
  static const CardRank three = const CardRank._ofValue(3, '3');
  static const CardRank four = const CardRank._ofValue(4, '4');
  static const CardRank five = const CardRank._ofValue(5, '5');
  static const CardRank six = const CardRank._ofValue(6, '6');
  static const CardRank seven = const CardRank._ofValue(7, '7');
  static const CardRank eight = const CardRank._ofValue(8, '8');
  static const CardRank nine = const CardRank._ofValue(9, '9');
  static const CardRank ten = const CardRank._ofValue(10, '10');
  static const CardRank jack = const CardRank._ofValue(11, 'Jack');
  static const CardRank queen = const CardRank._ofValue(12, 'Queen');
  static const CardRank king = const CardRank._ofValue(13, 'King');

  static List<CardRank> all = List.unmodifiable([ace, two, three, four, five,
  six, seven, eight, nine, ten, jack, queen, king]);

  final int value;
  final String name;
  const CardRank._ofValue(this.value, this.name);

  @override
  String toString() => name;
}

class CardSuit {
  static const CardSuit clubs = const CardSuit._ofString("Clubs");
  static const CardSuit diamonds = const CardSuit._ofString("Diamonds");
  static const CardSuit hearts = const CardSuit._ofString("Hearts");
  static const CardSuit spades = const CardSuit._ofString("Spades");

  static List<CardSuit> all = List.unmodifiable([clubs, diamonds, hearts, spades]);

  final String name;
  const CardSuit._ofString(this.name);

  @override
  String toString() => name;
}

class CardStack {
  final math.Random _random;
  List<PlayCard> _stackOfCards;

  CardStack([int seed]) : _random = math.Random(seed) {
    _stackOfCards = List();
    CardSuit.all.map((s) => CardRank.all.map((r) => PlayCard(r, s))).forEach((p) => _stackOfCards.addAll(p));
    _stackOfCards.shuffle(_random);
  }

  PlayCard get pull => _stackOfCards.isEmpty ? null : _stackOfCards.removeLast();
}