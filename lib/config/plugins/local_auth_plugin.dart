import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:local_auth/error_codes.dart' as auth_error;

  class LocalAuthPlugin {

    static final LocalAuthentication auth = LocalAuthentication();

    static availableBiometrics() async {

      final List<BiometricType> availableBiometrics = await auth.getAvailableBiometrics();

    if (availableBiometrics.isNotEmpty) {
      // Some biometrics are enrolled.
    }

    if (availableBiometrics.contains(BiometricType.strong) ||
        availableBiometrics.contains(BiometricType.face)) {
    }
    }

    static Future<bool> canCheckBiometrics() async {
      return await auth.canCheckBiometrics;
    }

    static Future<( bool, String )> authenticate({ bool biometricOnly = false }) async {

      try {
        
        final bool disAuthenticate = await auth.authenticate(
          localizedReason: 'Por favor autenticate para continuar',
          options:  AuthenticationOptions(
            biometricOnly: biometricOnly
          ));

        return ( disAuthenticate, disAuthenticate ? 'Hecho' : 'Cancelado por usuario' );
      } on PlatformException catch (e) {
        if( e.code == auth_error.notAvailable ) return ( false, 'No hay biometricos' );
        if( e.code == auth_error.lockedOut ) return ( false, 'Muchos intentos fallidos' );
        if( e.code == auth_error.notAvailable ) return ( false, 'No hay biometricos disponibles' );
        if( e.code == auth_error.passcodeNotSet ) return ( false, 'no hay un PIN configurado' );
        if( e.code == auth_error.permanentlyLockedOut ) return ( false, 'Se requiere desbloquear el tlfno' );
        return (false, e.toString());
      }


    }
  }