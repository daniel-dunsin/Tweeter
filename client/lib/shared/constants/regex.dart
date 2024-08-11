class DefaultMatchers {
  static RegExp email = RegExp(
    r"^[a-z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$",
  );

  static RegExp base64 = RegExp(r"/data:([a-zA-Z0-9]+\/[a-zA-Z0-9-.+]+)/");

  static RegExp phoneNumber =
      RegExp(r"^(?:\+1)?\s?\(?\d{3}\)?[-.\s]?\d{3}[-.\s]?\d{4}$");
}
