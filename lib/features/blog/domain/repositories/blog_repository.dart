import 'dart:io';

import 'package:fpdart/fpdart.dart';

import '../../../../core/errors/failures.dart';
import '../entities/blog.dart';

abstract interface class BlogRepository {
  Future<Either<Failure, List<Blog>>> getAllBlogs();

  Future<Either<Failure, Blog>> uploadBlog({
    required File image,
    required String title,
    required String content,
    required String posterId,
    required List<String> topics,
  });
}
