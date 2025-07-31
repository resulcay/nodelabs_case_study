import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inner_shadow/flutter_inner_shadow.dart';
import 'package:nodelabs_case_study/product/common/primary_button.dart';
import 'package:nodelabs_case_study/product/constant/color.dart';
import 'package:nodelabs_case_study/product/language/locale_keys.g.dart';

class LimitedOfferDraggableSheet extends StatefulWidget {
  const LimitedOfferDraggableSheet({super.key});

  @override
  State<LimitedOfferDraggableSheet> createState() =>
      _LimitedOfferDraggableSheetState();
}

class _LimitedOfferDraggableSheetState
    extends State<LimitedOfferDraggableSheet> {
  final DraggableScrollableController _controller =
      DraggableScrollableController();

  final offerAssets = [
    'assets/images/octahedron.png',
    'assets/images/multi-heart.png',
    'assets/images/up.png',
    'assets/images/heart.png',
  ];

  final offerTexts = [
    LocaleKeys.pages_limited_offer_bonusses_premium.tr(),
    LocaleKeys.pages_limited_offer_bonusses_matching.tr(),
    LocaleKeys.pages_limited_offer_bonusses_visibility.tr(),
    LocaleKeys.pages_limited_offer_bonusses_like.tr(),
  ];

  final discountTexts = [
    '+10%',
    '+70%',
    '+35%',
  ];

  final oldPriceTexts = [
    '200',
    '2000',
    '1000',
  ];

  final newTokensTexts = [
    '330',
    '3375',
    '1350',
  ];

  final finalPriceTexts = [
    '₺99,99',
    '₺799,99',
    '₺399,99',
  ];

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.8,
      minChildSize: 0.2,
      expand: false,
      maxChildSize: 0.9,
      controller: _controller,
      builder: (context, scrollController) {
        return SingleChildScrollView(
          child: Container(
            clipBehavior: Clip.antiAlias,
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Positioned(
                  top: 40,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      boxShadow: [
                        BoxShadow(
                          color:
                              ColorConstants.primaryColor.withValues(alpha: .4),
                          blurRadius: 200,
                          spreadRadius: 120,
                        ),
                      ],
                    ),
                  ),
                ),
                Column(
                  children: [
                    Text(
                      LocaleKeys.pages_limited_offer_title.tr(),
                      style:
                          Theme.of(context).textTheme.headlineSmall?.copyWith(
                                fontWeight: FontWeight.w600,
                                fontSize: 20,
                              ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      textAlign: TextAlign.center,
                      LocaleKeys.pages_limited_offer_description.tr(),
                    ),
                    const SizedBox(height: 16),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        gradient: RadialGradient(
                          colors: [
                            Colors.white.withValues(alpha: .1),
                            Colors.white.withValues(alpha: .03),
                          ],
                        ),
                        border: Border.all(
                          color: Colors.white.withValues(alpha: .1),
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            LocaleKeys.pages_limited_offer_bonus.tr(),
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 15,
                                ),
                          ),
                          const SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: List.generate(
                              4,
                              (index) => Expanded(
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8),
                                      child: Stack(
                                        children: [
                                          Container(
                                            width: 55,
                                            height: 55,
                                            decoration: const BoxDecoration(
                                              color: ColorConstants
                                                  .bonusCircleBackgroundColor,
                                              shape: BoxShape.circle,
                                            ),
                                          ),
                                          Container(
                                            width: 55,
                                            height: 55,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              gradient: RadialGradient(
                                                colors: [
                                                  ColorConstants
                                                      //
                                                      // ignore: lines_longer_than_80_chars
                                                      .bonusCircleBackgroundColor,
                                                  Colors.white
                                                      .withValues(alpha: .6),
                                                ],
                                                stops: const [0.75, 1.0],
                                              ),
                                            ),
                                            child: Center(
                                              child: Image.asset(
                                                offerAssets[index],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Text(
                                      textAlign: TextAlign.center,
                                      offerTexts[index],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      LocaleKeys.pages_limited_offer_select_package.tr(),
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w500,
                            fontSize: 15,
                          ),
                    ),
                    const SizedBox(height: 32),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: List.generate(
                        3,
                        (index) => Stack(
                          clipBehavior: Clip.none,
                          alignment: Alignment.center,
                          children: [
                            InnerShadow(
                              shadows: [
                                Shadow(
                                  color: Colors.white.withValues(alpha: 0.5),
                                  blurRadius: 40,
                                  offset: const Offset(0, -4),
                                ),
                              ],
                              child: Container(
                                height: 220,
                                width: 100,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: Colors.white.withValues(alpha: .4),
                                  ),
                                  gradient: LinearGradient(
                                    begin: Alignment.bottomRight,
                                    end: Alignment.topLeft,
                                    colors: [
                                      ColorConstants.primaryColor,
                                      if (index == 1)
                                        ColorConstants.radialGradientColor
                                      else
                                        ColorConstants
                                            .bonusCircleBackgroundColor,
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              top: -10,
                              child: InnerShadow(
                                shadows: [
                                  Shadow(
                                    color: Colors.white.withValues(alpha: 0.5),
                                    blurRadius: 25,
                                    offset: const Offset(0, -4),
                                  ),
                                ],
                                child: Container(
                                  height: 25,
                                  width: 60,
                                  decoration: BoxDecoration(
                                    color: index != 1
                                        ? ColorConstants
                                            .bonusCircleBackgroundColor
                                        : ColorConstants.radialGradientColor,
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                      color:
                                          Colors.white.withValues(alpha: 0.4),
                                    ),
                                  ),
                                  child:
                                      Center(child: Text(discountTexts[index])),
                                ),
                              ),
                            ),
                            Column(
                              children: [
                                Text(
                                  oldPriceTexts[index],
                                  style: const TextStyle(
                                    decoration: TextDecoration.lineThrough,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  newTokensTexts[index],
                                  style: const TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                                Text(
                                  LocaleKeys.pages_limited_offer_token.tr(),
                                  style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Divider(
                                  color: Colors.white.withValues(alpha: .1),
                                ),
                                Text(
                                  finalPriceTexts[index],
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w900,
                                    fontFamily: 'RobotoMono',
                                  ),
                                ),
                                Text(
                                  LocaleKeys.pages_limited_offer_per_week.tr(),
                                  style: const TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Positioned(
                          top: 40,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              boxShadow: [
                                BoxShadow(
                                  color: ColorConstants.primaryColor
                                      .withValues(alpha: .4),
                                  blurRadius: 200,
                                  spreadRadius: 120,
                                ),
                              ],
                            ),
                          ),
                        ),
                        PrimaryButton(
                          onPressed: () async {},
                          text: LocaleKeys.pages_limited_offer_see_all.tr(),
                          loadingText: '',
                          isLoading: false,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
