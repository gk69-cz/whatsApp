import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp/features/contract/repository/contact_repository.dart';

final contactControllerProvider = FutureProvider((ref){
final ContactRepository = ref.watch(ContactRepositoryProvider);
return ContactRepository.getAllContact();
});