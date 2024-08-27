enum MessageType {
  text('text'),
  image('image'),
  video('video'),
  audio('audio'),
  file('file'),
  location('location'),
  contact('contact'),
  vcard('vcard'),
  gif('gif');

  final String type;

  const MessageType(this.type);
}

extension ConvertMessage on String {
  MessageType toEnum() {
    switch (this) {
      case 'text':
        return MessageType.text;
      case 'image':
        return MessageType.image;
      case 'video':
        return MessageType.video;
      case 'audio':
        return MessageType.audio;
      case 'file':
        return MessageType.file;
      case 'location':
        return MessageType.location;
      case 'contact':
        return MessageType.contact;
      case 'vcard':
        return MessageType.vcard;
      case 'gif':
        return MessageType.gif;
      default:
      return MessageType.text;
      
    }
  }
}
