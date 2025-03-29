import 'package:flutter/material.dart';

import '../../../features/chat/service/websocket_service.dart';

class ChatHeader extends StatelessWidget {
  final Stream<WebSocketStatus> connectionStatus;

  const ChatHeader({super.key, required this.connectionStatus});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<WebSocketStatus>(
      stream: connectionStatus,
      builder: (context, snapshot) {
        final status = snapshot.data ?? WebSocketStatus.disconnected;
        return Row(
          children: [
            const Text('Chat'),
            const SizedBox(width: 8),
            Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color:
                    status == WebSocketStatus.connected
                        ? Colors.green
                        : Colors.red,
              ),
            ),
          ],
        );
      },
    );
  }
}
