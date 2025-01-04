import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BlogPage extends StatefulWidget {
  const BlogPage({super.key});
  @override
  State<BlogPage> createState() => _BlogPageState();

  static route() => MaterialPageRoute(
        builder: (context) => const BlogPage(),
      );
}

class _BlogPageState extends State<BlogPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Blog App'),
        actions: [
          IconButton(
            onPressed: () {
              // Navigator.push(context, AddNewBlogPage.route());
            },
            icon: const Icon(
              CupertinoIcons.add_circled,
            ),
          ),
        ],
      ),
      // body: BlocConsumer<BlogBloc, BlogState>(
      //   listener: (context, state) {
      //     if (state is BlogFailure) {
      //       showSnackBar(context, state.error);
      //     }
      //   },
      //   builder: (context, state) {
      //     if (state is BlogLoading) {
      //       return const Loader();
      //     }
      //     if (state is BlogsDisplaySuccess) {
      //       return ListView.builder(
      //         itemCount: state.blogs.length,
      //         itemBuilder: (context, index) {
      //           final blog = state.blogs[index];
      //           return BlogCard(
      //             blog: blog,
      //             color: index % 2 == 0
      //                 ? AppPallete.gradient1
      //                 : AppPallete.gradient2,
      //           );
      //         },
      //       );
      //     }
      //     return const SizedBox();
      //   },
      // ),
    );
  }

  @override
  void initState() {
    super.initState();
    // context.read<BlogBloc>().add(BlogFetchAllBlogs());
  }
}