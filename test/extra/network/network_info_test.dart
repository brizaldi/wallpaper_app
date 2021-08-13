import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:wallpaper_app/extra/network/network_info.dart';

import 'network_info_test.mocks.dart';

@GenerateMocks([Connectivity])
void main() {
  late NetworkInfo networkInfo;
  final mockConnectivity = MockConnectivity();

  setUp(() {
    networkInfo = NetworkInfo(mockConnectivity);
  });

  group('isConnected', () {
    test(
      '\nGiven a connectivity result on wifi'
      '\nWhen isConnected called'
      '\nThen return true',
      () async {
        // arrange
        final tCheckConnectivityResult = Future.value(ConnectivityResult.wifi);

        when(mockConnectivity.checkConnectivity())
            .thenAnswer((_) => tCheckConnectivityResult);
        // act
        final result = await networkInfo.isConnected();
        // assert
        verify(mockConnectivity.checkConnectivity());
        expect(result, true);
      },
    );

    test(
      '\nGiven a connectivity result is none'
      '\nWhen isConnected called'
      '\nThen return false',
      () async {
        // arrange
        final tCheckConnectivityResult = Future.value(ConnectivityResult.none);

        when(mockConnectivity.checkConnectivity())
            .thenAnswer((_) => tCheckConnectivityResult);
        // act
        final result = await networkInfo.isConnected();
        // assert
        verify(mockConnectivity.checkConnectivity());
        expect(result, false);
      },
    );
  });
}
