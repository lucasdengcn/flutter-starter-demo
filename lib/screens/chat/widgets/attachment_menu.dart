import 'package:flutter/material.dart';

import '../../../features/chat/model/chat_message.dart';

class AttachmentMenu extends StatelessWidget {
  final Function(MessageType) onAttachmentSelected;
  final Function(String) onEmojiSelected;

  const AttachmentMenu({
    super.key,
    required this.onAttachmentSelected,
    required this.onEmojiSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: GridView.count(
        crossAxisCount: 4,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          _buildAttachmentItem(
            context,
            icon: Icons.image,
            label: 'Image',
            onTap: () => onAttachmentSelected(MessageType.image),
          ),
          _buildAttachmentItem(
            context,
            icon: Icons.videocam,
            label: 'Video',
            onTap: () => onAttachmentSelected(MessageType.video),
          ),
          _buildAttachmentItem(
            context,
            icon: Icons.attach_file,
            label: 'File',
            onTap: () => onAttachmentSelected(MessageType.file),
          ),
          _buildAttachmentItem(
            context,
            icon: Icons.emoji_emotions,
            label: 'Emoji',
            onTap: () async {
              Navigator.pop(context);
              final emoji = await showModalBottomSheet<String>(
                context: context,
                builder:
                    (context) => EmojiPicker(onEmojiSelected: onEmojiSelected),
              );
              if (emoji != null) {
                onEmojiSelected(emoji);
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildAttachmentItem(
    BuildContext context, {
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 32, color: Theme.of(context).primaryColor),
            const SizedBox(height: 12),
            Text(label, style: Theme.of(context).textTheme.titleMedium),
          ],
        ),
      ),
    );
  }
}

class EmojiPicker extends StatelessWidget {
  final Function(String) onEmojiSelected;

  const EmojiPicker({super.key, required this.onEmojiSelected});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: GridView.count(
        crossAxisCount: 8,
        children:
            [
                  '😀',
                  '😃',
                  '😄',
                  '😁',
                  '😅',
                  '😂',
                  '🤣',
                  '😊',
                  '😇',
                  '🙂',
                  '🙃',
                  '😉',
                  '😌',
                  '😍',
                  '🥰',
                  '😘',
                  '😗',
                  '😙',
                  '😚',
                  '😋',
                  '😛',
                  '😝',
                  '😜',
                  '🤪',
                ]
                .map(
                  (e) => InkWell(
                    onTap: () => Navigator.pop(context, e),
                    child: Center(
                      child: Text(e, style: const TextStyle(fontSize: 24)),
                    ),
                  ),
                )
                .toList(),
      ),
    );
  }
}
