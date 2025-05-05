import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ref_listen_exception_handler_sample/data/repositories/repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'provider.g.dart';

@Riverpod(keepAlive: true)
UserRepository userRepository(Ref ref) => UserRepository(ref);
