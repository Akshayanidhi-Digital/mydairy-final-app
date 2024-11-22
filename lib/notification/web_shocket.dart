import 'package:flutter/material.dart';
import 'package:mydairy/export.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class WebShocketScreen extends ConsumerStatefulWidget {
  const WebShocketScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _WebShocketScreenState();
}

class _WebShocketScreenState extends ConsumerState<WebShocketScreen> {
  final TextEditingController _controller = TextEditingController();
  final channel = WebSocketChannel.connect(
    Uri.parse('wss://echo.websocket.events'),
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(title: "Web Socket"),
      body: Column(children: [
        TxtField(
          controller: _controller,
        ),
        StreamBuilder(
            stream: channel.stream,
            builder: (context, snapshot) {
              print("hello------");
              return Text(snapshot.hasData ? '${snapshot.data}' : '');
            })
      ]),
      floatingActionButton: buttonContainer(
          onTap: () {
            channel.sink.add(_controller.text);
            print("value ${_controller.text}");
          },
          txt: "submit"),
    );
  }

  @override
  void dispose() {
    channel.sink.close();
    super.dispose();
  }
}
