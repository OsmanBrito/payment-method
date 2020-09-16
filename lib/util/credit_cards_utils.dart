import 'package:flutter/material.dart';
import 'package:flutter_credit_card/credit_card_widget.dart';

class CreditCardsUtils {
  AnimationController controller;
  Gradient backgroundGradientColor;
  static bool isAmex = false;

  /// Credit Card prefix patterns as of March 2019
  /// A [List<String>] represents a range.
  /// i.e. ['51', '55'] represents the range of cards starting with '51' to those starting with '55'
  static Map<CardType, Set<List<String>>> cardNumPatterns =
      <CardType, Set<List<String>>>{
    CardType.visa: <List<String>>{
      <String>['4'],
    },
    CardType.americanExpress: <List<String>>{
      <String>['34'],
      <String>['37'],
    },
    CardType.discover: <List<String>>{
      <String>['6011'],
      <String>['622126', '622925'],
      <String>['644', '649'],
      <String>['65']
    },
    CardType.mastercard: <List<String>>{
      <String>['51', '55'],
      <String>['2221', '2229'],
      <String>['223', '229'],
      <String>['23', '26'],
      <String>['270', '271'],
      <String>['2720'],
    },
    CardType.elo: <List<String>>{
      <String>['636368'],
      <String>['438935'],
      <String>['504175'],
      <String>['451416'],
      <String>[
        '509048',
        '509067',
        '509049',
        '509069',
        '509050',
        '509074',
        '509068',
        '509040',
        '509045',
        '509051',
        '509046',
        '509066',
        '509047',
        '509042',
        '509052',
        '509043',
        '509064',
        '509040'
      ],
      <String>['36297'],
      <String>['5067'],
      <String>['4576'],
      <String>['4011']
    }
  };

  /// This function determines the Credit Card type based on the cardPatterns
  /// and returns it.
  static CardType detectCCType(String cardNumber) {
    //Default card type is other
    CardType cardType = CardType.otherBrand;

    if (cardNumber.isEmpty) {
      return cardType;
    }

    cardNumPatterns.forEach(
      (CardType type, Set<List<String>> patterns) {
        for (List<String> patternRange in patterns) {
          // Remove any spaces
          String ccPatternStr =
              cardNumber.replaceAll(RegExp(r'\s+\b|\b\s'), '');
          final int rangeLen = patternRange[0].length;
          // Trim the Credit Card number string to match the pattern prefix length
          if (rangeLen < cardNumber.length) {
            ccPatternStr = ccPatternStr.substring(0, rangeLen);
          }

          if (patternRange.length > 1) {
            // Convert the prefix range into numbers then make sure the
            // Credit Card num is in the pattern range.
            // Because Strings don't have '>=' type operators
            final int ccPrefixAsInt = int.parse(ccPatternStr);
            final int startPatternPrefixAsInt = int.parse(patternRange[0]);
            final int endPatternPrefixAsInt = int.parse(patternRange[1]);
            if (ccPrefixAsInt >= startPatternPrefixAsInt &&
                ccPrefixAsInt <= endPatternPrefixAsInt) {
              // Found a match
              cardType = type;
              break;
            }
          } else {
            // Just compare the single pattern prefix with the Credit Card prefix
            if (ccPatternStr == patternRange[0]) {
              // Found a match
              cardType = type;
              break;
            }
          }
        }
      },
    );

    return cardType;
  }

  // This method returns the icon for the visa card type if found
  // else will return the empty container
  static Widget getCardTypeIcon(String cardNumber) {
    Widget icon;
    switch (detectCCType(cardNumber)) {
      case CardType.visa:
        icon = Image.asset(
          'icons/visa.png',
          height: 48,
          width: 48,
          package: 'flutter_credit_card',
        );
        isAmex = false;
        break;

      case CardType.americanExpress:
        icon = Image.asset(
          'icons/amex.png',
          height: 48,
          width: 48,
          package: 'flutter_credit_card',
        );
        isAmex = true;
        break;

      case CardType.mastercard:
        icon = Image.asset(
          'icons/mastercard.png',
          height: 48,
          width: 48,
          package: 'flutter_credit_card',
        );
        isAmex = false;
        break;

      case CardType.elo:
        icon = Image.asset(
          'icons/elo.png',
          height: 48,
          width: 48,
          package: 'flutter_credit_card',
        );
        isAmex = false;
        break;

      case CardType.discover:
        icon = Image.asset(
          'icons/discover.png',
          height: 48,
          width: 48,
          package: 'flutter_credit_card',
        );
        isAmex = false;
        break;

      default:
        icon = Container(
          height: 48,
          width: 48,
        );
        isAmex = false;
        break;
    }

    return icon;
  }

  static String getCardTypeBrand(String cardNumber) {
    String brand;
    switch (detectCCType(cardNumber)) {
      case CardType.visa:
        brand = 'Visa';
        break;

      case CardType.americanExpress:
        brand = 'American Express';
        break;

      case CardType.mastercard:
        brand = 'Mastercard';
        break;

      case CardType.elo:
        brand = 'Elo';
        break;

      case CardType.discover:
        brand = 'Discover';
        break;

      default:
        brand = 'Cartão de crédito';
        break;
    }

    return brand;
  }


  static String hideCreditCardNumber(String number, {bool isCpf = false}) {
    if (isCpf) {
      return "xxx.xxx.xxx-xx";
    } else {
      String opa = number.substring(14);
      return "**** **** **** $opa";
    }
  }

}
