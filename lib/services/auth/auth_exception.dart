// Login exceptions
class UserNotFoundException implements Exception {}

class WrongPasswordException implements Exception {}

// Register exceptions
class EmailAlreadyInUseException implements Exception {}

class WeakPasswordException implements Exception {}

class InvalidEmailException implements Exception {}

class GenericAuthException implements Exception {}
class UserNotLoggedInException implements Exception {}
