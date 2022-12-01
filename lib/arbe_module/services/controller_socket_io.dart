// import 'package:novel_project/arbe_module/utils/custom_log.dart';
// import 'package:novel_project/helper/request_helper.dart';
// import 'package:novel_project/screen/widgets/show_top_snack_bar.dart';
// import 'package:socket_io_client/socket_io_client.dart' as IO;
//
// class ControllerSocketIo {
//   static ControllerSocketIo? _instance;
//
//   static ControllerSocketIo get instance {
//     if (_instance == null) _instance = ControllerSocketIo._internal();
//
//     return _instance!;
//   }
//
//   ControllerSocketIo._internal();
//   IO.Socket? socket;
//
//   connectSocket(String firebaseId) {
//     if (socket != null && socket!.connected) return;
//
//     socket = IO.io(
//       "https://" + API.BASE_URL,
//       IO.OptionBuilder()
//           .setPath('/api/socket.io')
//           .setTransports(['websocket'])
//           .disableAutoConnect()
//           .build(),
//     );
//
//     socket!.connect();
//     socket!.onConnect(
//       (data) => socket!.emit(
//         'hand_shake',
//         {
//           'permission': "application",
//           'firebaseId': firebaseId,
//         },
//       ),
//     );
//
//     registerListener();
//
//     socket!.onConnectError((data) => CustomLog.log(data));
//     socket!.onDisconnect((data) => socket!.dispose());
//   }
//
//   registerListener() {
//     // listern
//     socket!.on('connect_msg', (data) => CustomLog.log(data['msg']));
//     socket!.on('join_room', (data) => CustomLog.log(data));
//     socket!.on('server_noti', (data) {
//       CustomLog.log(data);
//       showTopSnackBar(data['title'], data['message']);
//     });
//
//     // ping pong
//     socket!.onPing((data) => {}); //CustomLog.log("ping"));
//     socket!.onPong((data) => {}); //CustomLog.log('pong'));
//   }
//
//   disconnect() {
//     if (socket != null) {
//       socket!.disconnect();
//     }
//   }
// }
