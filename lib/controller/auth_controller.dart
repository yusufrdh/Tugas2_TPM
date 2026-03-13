class AuthController {
  final Map<String, String> usernameToNim = {
    'yusuf': '123230188',
    'kevin': '123230110',
    'bintang': '123230137',
    'irham': '123230042',
  };

  String login({required String username, required String password}) {
    String inputUsername = username.trim().toLowerCase();
    String inputPassword = password.trim();

    if (usernameToNim.containsKey(inputUsername) &&
        usernameToNim[inputUsername] == inputPassword) {
      return inputUsername;
    }

    return "";
  }
}
