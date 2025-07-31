import 'dart:ui' as ui;

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nodelabs_case_study/product/constant/text.dart';
import 'package:nodelabs_case_study/product/language/locale_keys.g.dart';
import 'package:nodelabs_case_study/product/network/model/movie_list_response_model.dart';

class MovieCard extends StatefulWidget {
  const MovieCard({
    required this.movie,
    required this.index,
    this.onFavoritePressed,
    super.key,
  });

  final Movies movie;
  final int index;
  final VoidCallback? onFavoritePressed;

  @override
  State<MovieCard> createState() => _MovieCardState();
}

class _MovieCardState extends State<MovieCard> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Colors.black,
      child: Stack(
        children: [
          Positioned.fill(
            child: Image.network(
              widget.movie.poster ?? 'https://picsum.photos/400/800',
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Image.network(
                  'https://picsum.photos/seed/${widget.index}/400/800',
                  fit: BoxFit.cover,
                );
              },
            ),
          ),
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.transparent,
                    Colors.black54,
                    Colors.black87,
                  ],
                  stops: [0.0, 0.5, 0.8, 1.0],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 30,
            left: 10,
            right: 70,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const CircleAvatar(
                  radius: 30,
                  backgroundImage: AssetImage('assets/images/logo.png'),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        widget.movie.title ?? 'Unknown Title',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      if (widget.movie.plot != null) ...[
                        _buildExpandablePlot(),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            right: 20,
            bottom: 80,
            child: GestureDetector(
              onTap: widget.onFavoritePressed,
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(30)),
                child: BackdropFilter(
                  filter: ui.ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  child: Container(
                    width: 50,
                    height: 70,
                    decoration: BoxDecoration(
                      color: Colors.black45,
                      borderRadius: const BorderRadius.all(Radius.circular(30)),
                      border: Border.all(color: Colors.grey.shade600),
                    ),
                    child: Center(
                      child: FaIcon(
                        FontAwesomeIcons.solidHeart,
                        color: widget.movie.isFavorite!
                            ? Colors.red
                            : Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExpandablePlot() {
    final plot = widget.movie.plot!;

    return LayoutBuilder(
      builder: (context, constraints) {
        final textPainter = TextPainter(
          text: TextSpan(
            text: plot,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontFamily: TextConstants.mainFontFamily,
            ),
          ),
          maxLines: 2,
          textDirection: ui.TextDirection.ltr,
        )..layout(maxWidth: constraints.maxWidth);
        final isOverflowing = textPainter.didExceedMaxLines;

        if (isExpanded) {
          return GestureDetector(
            onTap: () {
              setState(() {
                isExpanded = false;
              });
            },
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: plot,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontFamily: TextConstants.mainFontFamily,
                    ),
                  ),
                  const TextSpan(
                    text: ' ',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                  TextSpan(
                    text: LocaleKeys.pages_home_less.tr(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      fontFamily: TextConstants.mainFontFamily,
                    ),
                  ),
                ],
              ),
            ),
          );
        } else if (isOverflowing) {
          return GestureDetector(
            onTap: () {
              setState(() {
                isExpanded = true;
              });
            },
            child: _buildTruncatedTextWithShowMore(plot, constraints.maxWidth),
          );
        } else {
          return Text(
            plot,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
            ),
          );
        }
      },
    );
  }

  Widget _buildTruncatedTextWithShowMore(String text, double maxWidth) {
    final showMoreText = '... ${LocaleKeys.pages_home_more.tr()}';
    final showMoreSpan = TextSpan(
      text: showMoreText,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 14,
        fontWeight: FontWeight.bold,
      ),
    );

    final showMorePainter = TextPainter(
      text: showMoreSpan,
      textDirection: ui.TextDirection.ltr,
    )..layout(maxWidth: maxWidth);

    var truncatedText = text;
    for (var i = text.length; i > 0; i--) {
      final testText = text.substring(0, i);
      final testPainter = TextPainter(
        text: TextSpan(
          text: testText,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
          ),
        ),
        maxLines: 2,
        textDirection: ui.TextDirection.ltr,
      )..layout(maxWidth: maxWidth - showMorePainter.width);

      if (!testPainter.didExceedMaxLines) {
        truncatedText = testText;
        break;
      }
    }

    return RichText(
      text: TextSpan(
        style: const TextStyle(
          fontFamily: TextConstants.mainFontFamily,
        ),
        children: [
          TextSpan(
            text: truncatedText,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
            ),
          ),
          const TextSpan(
            text: '... ',
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
            ),
          ),
          TextSpan(
            text: LocaleKeys.pages_home_more.tr(),
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
          ),
        ],
      ),
    );
  }
}
