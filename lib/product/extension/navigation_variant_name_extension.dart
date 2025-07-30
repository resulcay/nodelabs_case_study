import 'package:nodelabs_case_study/product/global/global_declaration.dart';

extension NavigationVariantExtension on NavigationVariant {
  String get formattedName {
    return name
        .replaceAllMapped(
          RegExp('([a-z])([A-Z])'),
          (match) => '${match.group(1)} ${match.group(2)}',
        )
        .replaceFirstMapped(
          RegExp(r'^\w'),
          (match) => match.group(0)!.toUpperCase(),
        );
  }
}
