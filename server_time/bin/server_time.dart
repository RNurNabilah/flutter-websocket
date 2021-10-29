import 'dart:convert';
import 'package:web_socket_channel/io.dart';
// import 'package:web_socket_channel/status.dart' as status;

void main(List<String> arguments) {
  final channel = IOWebSocketChannel.connect(
      'wss://ws.binaryws.com/websockets/v3?app_id=1089');

  channel.stream.listen((tick) {
    final decodedMessage = jsonDecode(tick);
    final symbolName = decodedMessage['tick']['symbol'];
    final quotePrice = decodedMessage['tick']['quote'];
    final serverTimeAsEpoch = decodedMessage['tick']['epoch'];
    final serverTime =
        DateTime.fromMillisecondsSinceEpoch(serverTimeAsEpoch * 1000);

    print("Name: $symbolName Price: $quotePrice Date and Time: $serverTime");
    //channel.sink.close(); //to disconnect socket
  });
  channel.sink.add('{"ticks": "frxAUDUSD", "subscribe": 1}');
}
