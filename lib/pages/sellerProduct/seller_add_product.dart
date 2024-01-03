// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:seller_app_fic/Data/Models/Category_model_respon.dart';
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
  @override
  void initState(){
    context.read<CategoryBloc>().add(const CategoryEvent.getCategory());
    super.initState();
  }

  Category? selectCategory;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomBarApp(title: 'Add product'),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: Dimensions.paddingSizeDefault
        ),
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
                    fontSize: Dimensions.fontSizeDefault
                  ),
                ),
                Text(
                  '*',
                  style: robotoBold.copyWith(
                    color: ColorResources.mainCardFourColor(context),
                    fontSize: Dimensions.fontSizeDefault
                  ),
                ),
              ],
            ),
            const SizedBox(height: Dimensions.paddingSizeSmall),
            CustomTextfield(
              textInputAction: TextInputAction.next,
              controller: TextEditingController(),
              textInputType: TextInputType.name,
              hintText: 'Product title',
              border: true,
              onChanged: (String text) {},
            ),
            const SizedBox(height: Dimensions.paddingSizeExtraLarge,
            ),
            Row(
              children: [
                Text(
                  'Description',
                  style: robotoRegular.copyWith(
                    color: ColorResources.titleColor(context),
                    fontSize: Dimensions.fontSizeDefault
                  ),
                ),
                Text(
                  '*',
                  style: robotoBold.copyWith(
                    color: ColorResources.mainCardFourColor(context),
                    fontSize: Dimensions.fontSizeDefault
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: Dimensions.paddingSizeSmall,
            ),
            CustomTextfield(
              isDescription: true,
              controller: TextEditingController(),
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
                Text('Select Category',
                style: robotoRegular.copyWith(
                  color: ColorResources.titleColor(context),
                  fontSize: Dimensions.fontSizeDefault
                )),
              Text(
                '*',
                style: robotoBold.copyWith(
                  color: ColorResources.mainCardFourColor(context),
                  fontSize: Dimensions.fontSizeDefault
                ),
              ),
              ],
            ),
            const SizedBox(
              height: Dimensions.paddingSizeExtraSmall,
            ),
            BlocBuilder<CategoryBloc, CategoryState>(
              builder: (context, state) {
                return state.maybeWhen(
                  orElse: (){
                    return const Text('Server error 2');
                  },
                  loading: () => const Center(
                    child: LinearProgressIndicator(),
                  ),
                  loaded: (data) {
                    selectCategory = selectCategory ?? data.data!.first;
                    return Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: Dimensions.paddingSizeSmall
                      ),
                      decoration: BoxDecoration(
                        color: Theme.of(context).cardColor,
                        borderRadius: BorderRadius.circular(
                          Dimensions.paddingSizeExtraSmall
                        ),
                        border: Border.all(
                          width: .5,
                          color: Theme.of(context).hintColor.withOpacity(.7)
                        ),
                      ),
                      child: DropdownButton<Category>(
                        value: selectCategory,
                        items: data.data!.map((val) {
                          return DropdownMenuItem<Category>(
                            value: val,
                            child: Text(val.name!),
                          );
                        }).toList(), 
                        onChanged: (value){
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
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 8),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 40,
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(Dimensions.paddingSizeExtraSmall),
          ),
          child: const Center(
            child: Text(
              'Continue',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: Dimensions.fontSizeLarge
              ),
            )
          ),
        ),),
    );
  }
}