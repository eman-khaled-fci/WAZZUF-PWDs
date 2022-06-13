import 'package:flutter/material.dart';

const kSpacingUnit = 10.00;

const kSilverColor = Color(0xFFF6F7FB);
const kAccentColor = Color(0xFFED5575);
const kPrimaryTextColor = Color(0xFF211D42);
const kSecondaryTextColor = Color(0xFFB9B8CD);

const kCardShadow = BoxShadow(
  color: Color.fromRGBO(0, 0, 0, 0.05),
  blurRadius: 20,
  offset: Offset(10, 10),
);

const kFooterShadow = BoxShadow(
  color: Color.fromRGBO(0, 0, 0, 0.10),
  blurRadius: 50,
  offset: Offset(0, -10),
);

const kHeadingTextStyle = TextStyle(
  color: kPrimaryTextColor,
  fontFamily: 'SF Pro Rounded',
  fontSize: 34,
  fontWeight: FontWeight.w100,
);

const kTitleTextStyle = TextStyle(
  color: kPrimaryTextColor,
  fontSize: 17,
  fontWeight: FontWeight.w500,
);

const kSubTitleTextStyle = TextStyle(
  color: kPrimaryTextColor,
  fontSize: 15,
  fontWeight: FontWeight.w500,
);

const kCardTitleTextStyle = TextStyle(
  color: kSecondaryTextColor,
  fontSize: 13,
  fontWeight: FontWeight.w500,
);

const kBodyTextStyle = TextStyle(
  color: kPrimaryTextColor,
  fontSize: 13,
);

const kCaptionTextStyle = TextStyle(
  color: kSecondaryTextColor,
  fontSize: 10,
);
