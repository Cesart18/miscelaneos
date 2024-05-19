// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:miscelaneus/config/config.dart';

final canCheckBiometricProvider = FutureProvider<bool>((ref) async {
  return await LocalAuthPlugin.canCheckBiometrics();
});


final localAuthProvider = StateNotifierProvider<LocalAuthNotifier,LocalAuthState>((ref) {
  return LocalAuthNotifier();
});

class LocalAuthNotifier extends StateNotifier<LocalAuthState> {
  LocalAuthNotifier(): super(LocalAuthState());

  Future<(bool, String)> authenticateUser() async {

    final ( didAuthenticate, message ) = await LocalAuthPlugin.authenticate();

    state = state.copyWith(
      didAuthenticate: didAuthenticate,
      message: message,
      authStatus: didAuthenticate ? LocalAuthStatus.authenticated : LocalAuthStatus.notAuthenticated
    );
    return ( didAuthenticate, message );
  }
  
}

enum LocalAuthStatus { authenticated, notAuthenticated, authenticating }

class LocalAuthState {
  final bool didAuthenticate;
  final LocalAuthStatus authStatus;
  final String message;

  LocalAuthState(
      {this.didAuthenticate = false,
      this.authStatus = LocalAuthStatus.notAuthenticated,
      this.message = ''
      });

  LocalAuthState copyWith({
    bool? didAuthenticate,
    LocalAuthStatus? authStatus,
    String? message,
  }) =>
      LocalAuthState(
        didAuthenticate: didAuthenticate ?? this.didAuthenticate,
        authStatus: authStatus ?? this.authStatus,
        message: message ?? this.message,
      );

  @override
  String toString() {
    return '''

      didAuthenticate: $didAuthenticate
      authStatus: $authStatus
      message: $message
    ''';
  }
}
