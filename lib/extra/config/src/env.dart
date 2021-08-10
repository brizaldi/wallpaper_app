part of configuration;

abstract class Env {
  Env() {
    _init();
  }

  void _init() {
    runZonedGuarded(() async {
      WidgetsFlutterBinding.ensureInitialized();

      await const MethodChannel('flavor')
          .invokeMethod<String>('getFlavor')
          .then((flavor) async {
        BuildConfig.init(flavor: flavor);
      }).catchError((error) {});

      Themes.initUiOverlayStyle();

      await configureDependencies();
      final app = await onCreate();

      runApp(app);
    }, (obj, stack) {
      print(obj);
      print(stack);
    });
  }

  FutureOr<StatelessWidget> onCreate();
}
