part of 'global_declaration.dart';

enum SnackbarType { success, error, warning, info }

void showCustomSnackBar(
  String text, {
  SnackbarType type = SnackbarType.info,
  bool isFloating = true,
}) {
  scaffoldMessengerKey.currentState?.showSnackBar(
    SnackBar(
      behavior: isFloating ? SnackBarBehavior.floating : SnackBarBehavior.fixed,
      margin: isFloating
          ? const EdgeInsets.only(
              bottom: 7,
              right: 7,
              left: 7,
            )
          : null,
      content: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Text(
              text,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          CircleAvatar(
            radius: 16,
            backgroundColor: _getSnackbarColor(type),
            child: Icon(
              _getSnackbarIcon(type),
              size: 18,
              color: Colors.white,
            ),
          ),
        ],
      ),
    ),
  );
}

Color _getSnackbarColor(SnackbarType type) {
  switch (type) {
    case SnackbarType.success:
      return Colors.green;
    case SnackbarType.error:
      return Colors.red;
    case SnackbarType.warning:
      return Colors.orange;
    case SnackbarType.info:
      return Colors.blue;
  }
}

IconData _getSnackbarIcon(SnackbarType type) {
  switch (type) {
    case SnackbarType.success:
      return FontAwesomeIcons.check;
    case SnackbarType.error:
      return FontAwesomeIcons.xmark;
    case SnackbarType.warning:
      return FontAwesomeIcons.exclamation;
    case SnackbarType.info:
      return FontAwesomeIcons.info;
  }
}
