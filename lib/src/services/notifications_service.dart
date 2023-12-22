import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:developer';
import 'package:android_id/android_id.dart';
import 'package:attado_mobile/firebase_options.dart';
import 'package:attado_mobile/injection.dart';
import 'package:attado_mobile/src/models/auth_models/app_notyfications_register_body.dart';
import 'package:attado_mobile/src/models/auth_models/device_info.dart';
import 'package:attado_mobile/src/models/data_models/contacts/contact.dart';
import 'package:attado_mobile/src/models/data_models/documents/document.dart';
import 'package:attado_mobile/src/models/data_models/folders/folder.dart';
import 'package:attado_mobile/src/models/data_models/tasks/task.dart';
import 'package:attado_mobile/src/repos/auth_repo.dart';
import 'package:attado_mobile/src/routers/router.dart';
import 'package:attado_mobile/src/services/api_service.dart';
import 'package:attado_mobile/src/services/contacts_service.dart';
import 'package:attado_mobile/src/services/documents_service.dart';
import 'package:attado_mobile/src/services/folders_service.dart';
import 'package:attado_mobile/src/services/tasks_service.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart';
import 'package:injectable/injectable.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

@injectable
class NotyficationsService {
  final ApiService _api;
  final AuthRepo _authRepo;
  final DocumentsService _documentsService;
  FirebaseMessaging get _firebaseMessaging => FirebaseMessaging.instance;
  static const _logName = "NotificationsService";

  NotyficationsService(
    this._api,
    this._authRepo,
    this._documentsService,
  );

  Future<void> registerApp() async {
    try {
      DeviceInfo deviceInfo = (await getDeviceInfo())!;
      AppNotyficationsRegisterBody body = AppNotyficationsRegisterBody(
        deviceHash: deviceInfo.deviceHash,
        deviceName: deviceInfo.deviceName,
        fcmToken: (await getFcmToken())!,
        username: _authRepo.authUser!.username,
      );

      Response response = await _api.client.post(
        Uri.parse('${_api.getBaseUrl()}/api/Auth/device/register'),
        headers: _api.getHeaders(),
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        log(
          "App registered for notifications ${jsonEncode(body)}",
          name: _logName,
        );
      } else {
        log(
          "Api error during app register for notifications",
          error: "${response.statusCode} :  ${response.request?.url}",
          name: StackTrace.current.toString(),
        );
      }
    } catch (e, stackTrace) {
      log(
        "App register for notifications error",
        error: e,
        stackTrace: stackTrace,
        name: StackTrace.current.toString(),
      );
    }
  }

  Future<String?> getFcmToken() async {
    await _firebaseMessaging.requestPermission(provisional: true);
    return _firebaseMessaging.getToken();
  }

  Future<DeviceInfo?> getDeviceInfo() async {
    DeviceInfoPlugin deviceInfoProvider = DeviceInfoPlugin();
    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfoProvider.androidInfo;
      AndroidId androidIdPlugin = const AndroidId();
      return DeviceInfo(
        deviceName: androidInfo.model,
        deviceHash: (await androidIdPlugin.getId())!,
      );
    } else if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await deviceInfoProvider.iosInfo;
      return DeviceInfo(
        deviceName: iosInfo.name!,
        deviceHash: iosInfo.identifierForVendor!,
      );
    }
    return null;
  }

  static Future<void> initFirebaseApp() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }

  static Future<void> setUpNotyficationsHandlers() async {
    FirebaseMessaging.onMessage.listen(_firebaseMessagingForegroundHandler);
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    FirebaseMessaging.onMessageOpenedApp.listen(_onTapBackgroundNotification);
    await _setUpLocalNotificationsResender();
  }

  Future<bool> isAppStartedFromNotification() async {
    RemoteMessage? initialMessage =
        await _firebaseMessaging.getInitialMessage();
    return initialMessage != null;
  }

  Future<void> redirectFromInitNotification() async {
    RemoteMessage? initialMessage =
        await _firebaseMessaging.getInitialMessage();

    if (initialMessage != null &&
        initialMessage.data["objectType"] != null &&
        initialMessage.data["objectId"] != null) {
      await NotyficationsService.navigateToObject(
          initialMessage.data["objectType"],
          int.parse(initialMessage.data["objectId"]));
    }
  }

  static Future<void> _setUpLocalNotificationsResender() async {
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();
    var initializationSettingsAndroid =
        const AndroidInitializationSettings('icon');
    var initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: _onTapLocalNotification);
  }

  static Future<void> _onTapLocalNotification(
      NotificationResponse notificationResponse) async {
    if (notificationResponse.payload != null) {
      var data = jsonDecode(notificationResponse.payload!);
      if (data["objectType"] != null && data["objectId"] != null) {
        await NotyficationsService.navigateToObject(
            data["objectType"], int.parse(data["objectId"]));
      }
    }
  }

  static Future<void> _onTapBackgroundNotification(
      RemoteMessage message) async {
    if (message.data["objectType"] != null &&
        message.data["objectId"] != null) {
      await NotyficationsService.navigateToObject(
          message.data["objectType"], int.parse(message.data["objectId"]));
    }
  }

  static Future<void> navigateToObject(String objectType, int objectId) async {
    try {
      if (objectType == "Document") {
        Document document =
            await getIt<DocumentsService>().getDocument(objectId);
        router.go("/documents/details", extra: document);
      } else if (objectType == "Folder") {
        Folder folder = await getIt<FoldersService>().getFolder(objectId);
        router.go("/folders/details", extra: folder);
      } else if (objectType == "Contact") {
        Contact contact = await getIt<ContactsService>().getContact(objectId);
        router.go("/contacts/details", extra: contact);
      } else if (objectType == "Task") {
        Task task = await getIt<TasksService>().getTask(objectId);
        router.go("/tasks/details", extra: task);
      }
    } catch (e) {
      log(
        "Error during navigate to $objectType $objectId from tap on notification e=$e",
        name: _logName,
      );
    }
  }

  static Future<void> _firebaseMessagingForegroundHandler(
    RemoteMessage message,
  ) async {
    log(
      "Handling a Foreground Notification title=${message.notification?.title} data=${jsonEncode(message.data)}",
      name: _logName,
    );
    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;
    if (notification != null && android != null) {
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
          FlutterLocalNotificationsPlugin();
      flutterLocalNotificationsPlugin.show(
        notification.hashCode,
        notification.title,
        notification.body,
        const NotificationDetails(
          android: AndroidNotificationDetails(
            "ATTADO_NOTIFICATIONS",
            'Dokumenty do akceptacji',
            styleInformation: BigTextStyleInformation(''),
          ),
        ),
        payload: jsonEncode(message.data),
      );
    }
  }

  static Future<void> _firebaseMessagingBackgroundHandler(
    RemoteMessage message,
  ) async {
    log(
      "Handling a Background Notification title=${message.notification?.title} data=${jsonEncode(message.data)}",
      name: _logName,
    );
  }
}
