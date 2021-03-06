import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/product.dart';
import '../providers/products_provider.dart';

class EditProductScreen extends StatefulWidget {
  //const EditProductScreen({Key? key}) : super(key: key);
   static const routeName = '/edit-product';
  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _priceFocusNode =FocusNode();
  final _descriptionFocusNode =FocusNode();
  final _imageUrlController = TextEditingController();
  final _imageUrlFocusNode =FocusNode();
  final _form = GlobalKey<FormState>();
  var _editedProduct = Product(
    id: '',
    title: '',
    price:0,
    description:'',
    imageUrl:'',
  );
  var _initVaues ={
  'title': '',
  'price': '',
  'description':'',
  'imageUrl':'',
  };
  var _isInit =true;



  @override
  void initState() {
    _imageUrlFocusNode.addListener(_updateImageUrl);
    super.initState();
  }

  @override
  void dispose() {
    _imageUrlFocusNode.removeListener(_updateImageUrl);
    _imageUrlController.dispose();
    _priceFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _imageUrlFocusNode.dispose();
    super.dispose();
  }
  void _updateImageUrl(){

    if(!_imageUrlFocusNode.hasFocus){
      if(
          (!_imageUrlController.text.startsWith('http') && !_imageUrlController.text.startsWith('https'))
      ||(!_imageUrlController.text.endsWith('.png') && _imageUrlController.text.endsWith('.jpg')&&!_imageUrlController.text.endsWith('.jpeg'))){
        return ;
      }
      setState(() {

      });
    }
  }

  void _saveForm(){

   final _isValid = _form.currentState?.validate();
   if (!_isValid!){
     return;
   }
   _form.currentState?.save();
   if(_editedProduct.id != null){
     Provider.of<Products>(context, listen: false).updateProduct(_editedProduct.id,_editedProduct);
     Navigator.of(context).pop();
   } else {
     Provider.of<Products>(context, listen: false).addProduct(_editedProduct);
     Navigator.of(context).pop();
   }
  }

  @override
  void didChangeDependencies() {
       if(_isInit){
        final productId = ModalRoute.of(context)!.settings.arguments as String;
        if(productId != null){
          _editedProduct = Provider.of<Products>(context, listen: false).findById(productId);
          _initVaues={
            'title': _editedProduct.title,
            'price': _editedProduct.price.toString(),
            'description':_editedProduct.description,
            //'imageUrl':_editedProduct.imageUrl,
            'imageUrl':'',
          };
          _imageUrlController.text =_editedProduct.imageUrl;
        }

       }
       _isInit =false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Product'),
        actions: <Widget>[
          IconButton(
           icon: Icon(Icons.save),
            onPressed: _saveForm,
          )
        ],
      ),
      body:Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _form,
          child: ListView(
            children: <Widget>[
              TextFormField(
                initialValue: _initVaues['title'],
                decoration: InputDecoration(labelText: 'Title'),
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_){
                  FocusScope.of(context).requestFocus(_priceFocusNode);
                },
                validator: (value){
                  if(value!.isEmpty){
                    return "Please provide a value";
                  }
                  return null;
                },
                onSaved: (value){
                  _editedProduct =Product(
                    title: value!,
                    price: _editedProduct.price,
                    imageUrl: _editedProduct.imageUrl,
                    description: _editedProduct.description,
                    id: _editedProduct.id,
                    isFavorite: _editedProduct.isFavorite
                  );
                },

              ),
              TextFormField(
                initialValue: _initVaues['price'],
                decoration: InputDecoration(labelText: 'Price'),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                focusNode: _priceFocusNode,
                onFieldSubmitted: (_){
                 Focus.of(context).requestFocus(_descriptionFocusNode);
                },
                validator: (value){
                  if(value!.isEmpty){
                    return 'Please enter a price';
                  }
                  if(double.tryParse(value)== null){
                    return 'Please enter a valid number';
                  } 
                  if(double.parse(value)<=0) {
                    return 'Please enter a number greater than zero ';
                  }
                  return null;
                },
                onSaved: (value){
                  _editedProduct =Product(
                    title: _editedProduct.title,
                    price: double.parse(value!) ,
                    imageUrl: _editedProduct.imageUrl,
                    description: _editedProduct.description,
                      id: _editedProduct.id,
                      isFavorite: _editedProduct.isFavorite
                  );
                },
              ),
              TextFormField(
                initialValue: _initVaues['description'],
                decoration: InputDecoration(labelText: 'Description'),
                maxLines: 3,
                keyboardType: TextInputType.multiline,
                focusNode: _descriptionFocusNode,
                validator: (value){
                  if(value!.isEmpty){
                    return "Please enter a description";
                  }
                  if(value!.length <10){
                    return "Should be atleast 10 characters long";
                  }
                  return null;
                },
                onSaved: (value){
                  _editedProduct =Product(
                    title: _editedProduct.title,
                    price: _editedProduct.price,
                    imageUrl: _editedProduct.imageUrl,
                    description: value!,
                      id: _editedProduct.id,
                      isFavorite: _editedProduct.isFavorite
                  );
                },
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Container(
                    width: 100,
                    height: 100,
                    margin: EdgeInsets.only(top: 8,right: 10,),
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 1,
                        color: Colors.grey,
                      ),
                    ),
                    child: _imageUrlController.text.isEmpty ? Text('Enter a URL')
                    :FittedBox(
                      child:Image.network(_imageUrlController.text,
                      fit: BoxFit.cover,) ,
                    ),
                  ),
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(labelText: 'Image URL'),
                      keyboardType: TextInputType.url,
                      textInputAction: TextInputAction.done,
                      controller: _imageUrlController,
                      focusNode: _imageUrlFocusNode,
                      validator: (value){
                        if(value!.isEmpty){
                          return 'Please enter an image URL';
                        }
                          if(!value.startsWith('http') && !value.startsWith('https')){
                            return "Please enter a valid URL";
                          }
                          if(!value.endsWith('.png') && !value.endsWith('.jpg')&&!value.endsWith('.jpeg')){
                            return "Please enter a valid image";
                          }

                      },
                      onFieldSubmitted: (_){
                        _saveForm();
                    },
                      onSaved: (value){
                        _editedProduct =Product(
                          title: _editedProduct.title,
                          price: _editedProduct.price,
                          imageUrl: value!,
                          description: _editedProduct.description,
                            id: _editedProduct.id,
                            isFavorite: _editedProduct.isFavorite
                        );
                      },
                    ),
                  )
                ],
              )

            ],
          ),
        ),
      ) ,
    );
  }
}
