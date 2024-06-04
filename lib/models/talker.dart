enum Talker {
  user, model;

  static Talker toEnum(String name) {
    return Talker.values.byName(name.toLowerCase());
  }
}
