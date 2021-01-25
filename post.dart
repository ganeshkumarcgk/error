import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
TextEditingController _fnameController =  TextEditingController();
FocusNode _fnameFocusNode =  FocusNode();
String _fname;
class SingleImageUpload extends StatefulWidget {
  @override
  _SingleImageUploadState createState() {
    return _SingleImageUploadState();
  }
}

class _SingleImageUploadState extends State<SingleImageUpload> {
  List<Object> images = List<Object>();
  Future<File> _imageFile;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      images.add("Add Image");
      images.add("Add Image");
      images.add("Add Image");
      images.add("Add Image");
      images.add("Add Image");
      images.add("Add Image");
    });
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      home:  Scaffold(
        resizeToAvoidBottomPadding: false,
      resizeToAvoidBottomInset: false,
        appBar: AppBar(

          title:Text("POST"),
          titleSpacing: 00.0,
          centerTitle: true,
          toolbarHeight: 60.2,
          elevation: 6.00,
          backgroundColor: Color.fromRGBO(14, 120, 18, 0.75),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: _fnameController,
             decoration: InputDecoration(
               hintText: "",
               labelText: "Write Something...",
             ),
              maxLines: 6,
              maxLength: 256,
              keyboardType: TextInputType.multiline,

            ),

            Expanded(
              child: buildGridView(),
            ),
            ElevatedButton(
              onPressed: () {
               print(_fnameController.text);
                Scaffold
                    .of(context)
                    .showSnackBar(SnackBar(content: Text('Processing Data')));

              },
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildGridView() {
    return   GridView.count(
      shrinkWrap: true,
      crossAxisCount: 3,
      childAspectRatio: 1,
      children: List.generate(images.length, (index) {
        if (images[index] is ImageUploadModel) {
          ImageUploadModel uploadModel = images[index];
          return Card(
            clipBehavior: Clip.antiAlias,
            child: Stack(
              children: <Widget>[
                Image.file(
                  uploadModel.imageFile,
                  width: 300,
                  height: 300,
                ),
                Positioned(
                  right: 5,
                  top: 5,
                  child: InkWell(
                    child: Icon(
                      Icons.remove_circle,
                      size: 20,
                      color: Colors.red,
                    ),
                    onTap: () {
                      setState(() {
                        images.replaceRange(index, index + 1, ['Add Image']);
                      });
                    },
                  ),
                ),
              ],
            ),
          );
        } else {
          return Card(
            child: IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                _onAddImageClick(index);
              },
            ),
          );
        }
      }),

    );
  }

  Future _onAddImageClick(int index) async {
    setState(() {
      _imageFile = ImagePicker.pickImage(source: ImageSource.gallery);
      getFileImage(index);
    });
  }

  void getFileImage(int index) async {
//    var dir = await path_provider.getTemporaryDirectory();

    _imageFile.then((file) async {
      setState(() {
        ImageUploadModel imageUpload = new ImageUploadModel();
        imageUpload.isUploaded = false;
        imageUpload.uploading = false;
        imageUpload.imageFile = file;
        imageUpload.imageUrl = '';
        images.replaceRange(index, index + 1, [imageUpload]);
      });
    });
  }
}

class ImageUploadModel {
bool isUploaded;
bool uploading;
File imageFile;
String imageUrl;

ImageUploadModel({
this.isUploaded,
this.uploading,
this.imageFile,
this.imageUrl,
});
}
