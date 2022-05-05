class InputTextValidator {
  static String? onValidateEmptyText({
    required String? value,
    required String errorText,
  }) {
    if (value == null || value == "") return errorText;

    return null;
  }
}
