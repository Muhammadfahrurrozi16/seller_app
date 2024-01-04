// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:seller_app_fic/Data/Models/Category_model_respon.dart';
import 'package:seller_app_fic/Data/Models/request/product_request_model.dart';
import 'package:seller_app_fic/bloc/addImage/add_image_bloc.dart';
import 'package:seller_app_fic/bloc/addproduct/add_product_bloc.dart';
import 'package:seller_app_fic/common/Global_Variabel.dart';
import 'package:seller_app_fic/pages/Dashboard/seller_dashboard.dart';
import '../../bloc/category/category_bloc.dart';
import '../../pages/base_widget/custom_app_bar.dart';
import '../../utilis/color_resource.dart';
import '../../utilis/custom_theme.dart';
import '../../utilis/dimensions.dart';
import 'widgets/custom_text_field.dart';

class SelleraddProduct extends StatefulWidget {
  const SelleraddProduct({super.key});

  @override
  State<SelleraddProduct> createState() => _SelleraddProductState();
}

class _SelleraddProductState extends State<SelleraddProduct> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descController = TextEditingController();
  final TextEditingController priceController = TextEditingController();

  @override
  void initState() {
    context.read<CategoryBloc>().add(const CategoryEvent.getCategory());
    super.initState();
  }

  Category? selectCategory;

  XFile? _imageFile;
  String imageUrl = '';

  Future<void> getImage(ImageSource source) async {
    final ImagePicker picker = ImagePicker();
    final XFile? photo = await picker.pickImage(
      source: source,
      imageQuality: 50,
    );
    if (photo != null) {
      _imageFile = photo;
      context.read<AddImageBloc>().add(AddImageEvent.addImage(photo));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomBarApp(title: 'Add product'),
      body: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: Dimensions.paddingSizeDefault),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: Dimensions.paddingSizeSmall,
            ),
            Row(
              children: [
                Text(
                  'Product name',
                  style: robotoRegular.copyWith(
                      color: ColorResources.titleColor(context),
                      fontSize: Dimensions.fontSizeDefault),
                ),
                Text(
                  '*',
                  style: robotoBold.copyWith(
                      color: ColorResources.mainCardFourColor(context),
                      fontSize: Dimensions.fontSizeDefault),
                ),
              ],
            ),
            const SizedBox(height: Dimensions.paddingSizeSmall),
            CustomTextfield(
              textInputAction: TextInputAction.next,
              controller: titleController,
              textInputType: TextInputType.name,
              hintText: 'Product title',
              border: true,
              onChanged: (String text) {},
            ),
            const SizedBox(
              height: Dimensions.paddingSizeExtraLarge,
            ),
            Row(
              children: [
                Text(
                  'Description',
                  style: robotoRegular.copyWith(
                      color: ColorResources.titleColor(context),
                      fontSize: Dimensions.fontSizeDefault),
                ),
                Text(
                  '*',
                  style: robotoBold.copyWith(
                      color: ColorResources.mainCardFourColor(context),
                      fontSize: Dimensions.fontSizeDefault),
                ),
              ],
            ),
            const SizedBox(
              height: Dimensions.paddingSizeSmall,
            ),
            CustomTextfield(
              isDescription: true,
              controller: descController,
              onChanged: (String text) {},
              textInputType: TextInputType.multiline,
              maxLine: 3,
              border: true,
              hintText: 'Enter description',
            ),
            const SizedBox(
              height: Dimensions.paddingSizeExtraLarge,
            ),
            Row(
              children: [
                Text('Uploud Image',
                    style: robotoRegular.copyWith(
                        color: ColorResources.titleColor(context),
                        fontSize: Dimensions.fontSizeDefault)),
                Text(
                  '*',
                  style: robotoBold.copyWith(
                      color: ColorResources.mainCardFourColor(context),
                      fontSize: Dimensions.fontSizeDefault),
                ),
              ],
            ),
            const SizedBox(
              height: Dimensions.paddingSizeExtraSmall,
            ),
            Center(
              child: BlocBuilder<AddImageBloc, AddImageState>(
                builder: (context, state) {
                  return state.maybeWhen(
                    orElse: () {
                      return const Text('Error');
                    },
                    loaded: (data) {
                      imageUrl = data.imagePath;
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(16.0),
                        child: _imageFile != null
                            ? Image.network(
                                '${GlobalVariables.baseUrl}${data.imagePath}',
                                height: 150,
                                fit: BoxFit.cover,
                              )
                            : Image.asset(
                                'assets/images/placeholder_1x1.png',
                                height: 150,
                              ),
                      );
                    },
                    loading: () {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    },
                    initial: () {
                      return Image.asset(
                        'assets/images/placeholder_1x1.png',
                        height: 150,
                      );
                    },
                  );
                },
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    getImage(ImageSource.camera);
                  },
                  child: const Text(
                    "Camera",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                ElevatedButton(
                  onPressed: () {
                    getImage(ImageSource.gallery);
                  },
                  style: ButtonStyle(
                    overlayColor: MaterialStateColor.resolveWith(
                      (states) => const Color(0xFFF5A1A1),
                    ),
                  ),
                  child: const Text(
                    "Galery",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: Dimensions.paddingSizeExtraLarge,
            ),
            Row(
              children: [
                Text('Select Category',
                    style: robotoRegular.copyWith(
                        color: ColorResources.titleColor(context),
                        fontSize: Dimensions.fontSizeDefault)),
                Text(
                  '*',
                  style: robotoBold.copyWith(
                      color: ColorResources.mainCardFourColor(context),
                      fontSize: Dimensions.fontSizeDefault),
                ),
              ],
            ),
            const SizedBox(
              height: Dimensions.paddingSizeExtraSmall,
            ),
            BlocBuilder<CategoryBloc, CategoryState>(
              builder: (context, state) {
                return state.maybeWhen(
                  orElse: () {
                    return const Text('Server error 2');
                  },
                  loading: () => const Center(
                    child: LinearProgressIndicator(),
                  ),
                  loaded: (data) {
                    selectCategory = selectCategory ?? data.data!.first;
                    return Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: Dimensions.paddingSizeSmall),
                      decoration: BoxDecoration(
                        color: Theme.of(context).cardColor,
                        borderRadius: BorderRadius.circular(
                            Dimensions.paddingSizeExtraSmall),
                        border: Border.all(
                            width: .5,
                            color: Theme.of(context).hintColor.withOpacity(.7)),
                      ),
                      child: DropdownButton<Category>(
                        value: selectCategory,
                        items: data.data!.map((val) {
                          return DropdownMenuItem<Category>(
                            value: val,
                            child: Text(val.name!),
                          );
                        }).toList(),
                        onChanged: (value) {
                          selectCategory = value;
                          setState(() {});
                        },
                        isExpanded: true,
                        underline: const SizedBox(),
                      ),
                    );
                  },
                );
              },
            ),
            const SizedBox(
              height: Dimensions.paddingSizeExtraLarge,
            ),
            Row(
              children: [
                Text('Price',
                    style: robotoRegular.copyWith(
                        color: ColorResources.titleColor(context),
                        fontSize: Dimensions.fontSizeDefault)),
                Text(
                  '*',
                  style: robotoRegular.copyWith(
                      color: ColorResources.mainCardFourColor(context),
                      fontSize: Dimensions.fontSizeDefault),
                ),
              ],
            ),
            const SizedBox(
              height: Dimensions.paddingSizeExtraSmall,
            ),
            CustomTextfield(
              textInputAction: TextInputAction.done,
              controller: priceController,
              textInputType: TextInputType.number,
              hintText: 'Price',
              border: true,
            ),
          ],
        ),
      ),
      bottomNavigationBar: BlocConsumer<AddProductBloc, AddProductState>(
        listener: (context, state) {
          state.maybeWhen(
            orElse: (){},
            loaded: (data) {
              Navigator.push(context, MaterialPageRoute(builder: (_){
                return const SellerDashboard();
              }));
            }, 
          );
        },
        builder: (context, state) {
          return state.maybeWhen(
            orElse: (){
            return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: InkWell(
              onTap: () {
                final request = ProductRequestModel(
                  name: titleController.text,
                  description: descController.text,
                  price: int.parse(priceController.text),
                  imageUrl: imageUrl,
                  categoryId: selectCategory!.id ?? 0,
                );

                context.read<AddProductBloc>().add(AddProductEvent.create(request));
              },
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 40,
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(Dimensions.paddingSizeExtraSmall),
                ),
                child: const Center(
                  child: Text(
                    'Add Product',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: Dimensions.fontSizeLarge
                    ),
                  )),
              ),
            ),
            );
            },
            loading: () => const Center(
              child: CircularProgressIndicator(),
            ),
            );
            },
          ),
    );
  }
}         
           