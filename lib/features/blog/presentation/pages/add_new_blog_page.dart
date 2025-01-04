import 'dart:io';

import 'package:flutter/material.dart';

class AddNewBlogPage extends StatefulWidget {
  const AddNewBlogPage({super.key});
  @override
  State<AddNewBlogPage> createState() => _AddNewBlogPageState();

  static route() => MaterialPageRoute(
        builder: (context) => const AddNewBlogPage(),
      );
}

class _AddNewBlogPageState extends State<AddNewBlogPage> {
  final titleController = TextEditingController();
  final contentController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  List<String> selectedTopics = [];
  File? image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              // uploadBlog();
            },
            icon: const Icon(Icons.done_rounded),
          ),
        ],
      ),
      // body: BlocConsumer<BlogBloc, BlogState>(
      //   listener: (context, state) {
      //     if (state is BlogFailure) {
      //       showSnackBar(context, state.error);
      //     } else if (state is BlogUploadSuccess) {
      //       Navigator.pushAndRemoveUntil(
      //         context,
      //         BlogPage.route(),
      //         (route) => false,
      //       );
      //     }
      //   },
      //   builder: (context, state) {
      //     if (state is BlogLoading) {
      //       return const Loader();
      //     }

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                image != null
                    ? GestureDetector(
                        // onTap: selectImage,
                        child: SizedBox(
                          width: double.infinity,
                          height: 150,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.file(
                              image!,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      )
                    : GestureDetector(
                        onTap: () {
                          // selectImage();
                        },
                        // child: DottedBorder(
                        //   color: AppPallete.borderColor,
                        //   dashPattern: const [10, 4],
                        //   radius: const Radius.circular(10),
                        //   borderType: BorderType.RRect,
                        //   strokeCap: StrokeCap.round,
                        //   child: SizedBox(
                        //     height: 150,
                        //     width: double.infinity,
                        //     child: const Column(
                        //       mainAxisAlignment: MainAxisAlignment.center,
                        //       children: [
                        //         Icon(
                        //           Icons.folder_open,
                        //           size: 40,
                        //         ),
                        //         SizedBox(height: 15),
                        //         Text(
                        //           'Select your image',
                        //           style: TextStyle(
                        //             fontSize: 15,
                        //           ),
                        //         ),
                        //       ],
                        //     ),
                        //   ),
                        // ),
                      ),
                const SizedBox(height: 20),
                // SingleChildScrollView(
                //   scrollDirection: Axis.horizontal,
                //   child: Row(
                //     children: Constants.topics
                //         .map(
                //           (e) => Padding(
                //             padding: const EdgeInsets.all(5.0),
                //             child: GestureDetector(
                //               onTap: () {
                //                 if (selectedTopics.contains(e)) {
                //                   selectedTopics.remove(e);
                //                 } else {
                //                   selectedTopics.add(e);
                //                 }
                //                 setState(() {});
                //               },
                //               child: Chip(
                //                 label: Text(e),
                //                 color: selectedTopics.contains(e)
                //                     ? const WidgetStatePropertyAll(
                //                         AppPallete.gradient1,
                //                       )
                //                     : null,
                //                 side: selectedTopics.contains(e)
                //                     ? null
                //                     : const BorderSide(
                //                         color: AppPallete.borderColor,
                //                       ),
                //               ),
                //             ),
                //           ),
                //         )
                //         .toList(),
                //   ),
                // ),
                // const SizedBox(height: 10),
                // BlogEditor(
                //   controller: titleController,
                //   hintText: 'Blog title',
                // ),
                // const SizedBox(height: 10),
                // BlogEditor(
                //   controller: contentController,
                //   hintText: 'Blog content',
                // ),
              ],
            ),
          ),
        ),
        //   );
        // },
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    titleController.dispose();
    contentController.dispose();
  }

  // void selectImage() async {
  //   final pickedImage = await pickImage();
  //   if (pickedImage != null) {
  //     setState(() {
  //       image = pickedImage;
  //     });
  //   }
  // }

  // void uploadBlog() {
  //   if (formKey.currentState!.validate() &&
  //       selectedTopics.isNotEmpty &&
  //       image != null) {
  //     final posterId =
  //         (context.read<AppUserCubit>().state as AppUserLoggedIn).user.id;
  //     context.read<BlogBloc>().add(
  //           BlogUpload(
  //             posterId: posterId,
  //             title: titleController.text.trim(),
  //             content: contentController.text.trim(),
  //             image: image!,
  //             topics: selectedTopics,
  //           ),
  //         );
  //   }
  // }
}
