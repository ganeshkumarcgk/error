void validateAndUpload() async{
    if(_formKey.currentState.validate()){
      if(_image1 != null){
        print('image1');
        print(_image1);
        print('image2');
        print(_image2);
        print('image3');
        print(_image3);
        print('image4');
        print(_image4);
        print('image5');
        print(_image5);
        print('image6');
        print(_image6);
        print(radioButtonItem);
        List<int> imageBytes6 = _image6.readAsBytesSync();
        String baseimage6 = base64Encode(imageBytes6);
        List<int> imageBytes5 = _image5.readAsBytesSync();
        String baseimage5 = base64Encode(imageBytes5);
        List<int> imageBytes4 = _image4.readAsBytesSync();
        String baseimage4= base64Encode(imageBytes4);
        List<int> imageBytes3 = _image3.readAsBytesSync();
        String baseimage3 = base64Encode(imageBytes3);
        List<int> imageBytes2 = _image2.readAsBytesSync();
        String baseimage2 = base64Encode(imageBytes2);
        List<int> imageBytes1 = _image1.readAsBytesSync();
        String baseimage1 = base64Encode(imageBytes1);

        var url="api-url";

        var response=await http.post(url,headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
            body:jsonEncode({"pname": productNameController.text,
          "pdesc":productDescController.text,"qun":quatityController.text,"cond":radioButtonItem,"stck":stckController.text,
          "ptype":radioButtonItems,"payment":radioButtonItemss, "location":locaController.text,"price":mnyController.text,
          "image1": baseimage1,
          "image2":baseimage2,
          "image3":baseimage3,
          "image4":baseimage4,
          "image5":baseimage5,
          "image6":baseimage6,
        })
        );

        var resq=jsonDecode(response.body);

        if(resq == "success")
        {
          Fluttertoast.showToast(
            msg: "SuccessFully",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.TOP,
            backgroundColor: Colors.green,
            // also possible "TOP" and "CENTER"
          );
        }

        if(resq == "fail")
        {
          Fluttertoast.showToast(
            msg: " Failed",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.TOP,
            backgroundColor: Colors.red,
            // also possible "TOP" and "CENTER"
          );
        }

      }
      else{
        Fluttertoast.showToast(msg: 'One image must be provided');
      }
    }
  }
