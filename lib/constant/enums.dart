String enumToString(Object o) => o.toString().split('.').last;

///Example
enum FieldError {
  empty,
  invalid,
}

enum LanguageType {
  en,
  fr,
  nl
}

enum RepositoryProviderType {
  lrf,
  home,
  profile,
}