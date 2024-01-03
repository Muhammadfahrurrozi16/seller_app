import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:seller_app_fic/Data/DataResources/auth_local_datasources.dart';
import 'package:seller_app_fic/Data/Models/request/register_request_model.dart';
import 'package:seller_app_fic/pages/Dashboard/seller_dashboard.dart';
import 'package:seller_app_fic/pages/base_widget/button/custom_button.dart';
import '../../../bloc/Register/register_bloc.dart';

import '../../../utilis/color_resource.dart';
import '../../../utilis/custom_theme.dart';
import '../../../utilis/dimensions.dart';
import '../../base_widget/text_field/custom_password_textfield.dart';
import '../../base_widget/text_field/custom_textfield.dart';
// import '../../dashboard/dashboard.dart';




class SignUpWidget extends StatefulWidget {
  const SignUpWidget({Key? key}): super(key: key);

  @override
  SignUpWidgetState createState() => SignUpWidgetState();
}

class SignUpWidgetState extends State<SignUpWidget> {
  final TextEditingController _firstnameCotroller = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmpasswordController = TextEditingController();
  GlobalKey<FormState>?  _formKey;

  final FocusNode _fnameFocus = FocusNode();
  final FocusNode _1NameFocus = FocusNode();
  final FocusNode _emailFoucs = FocusNode();
  final FocusNode _phoneFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();
  final FocusNode _ConfirmPasswordFocus = FocusNode();
  bool isEmailVerified = false;

  addUser() async {
    if (_formKey!.currentState!.validate()) {
      _formKey!.currentState!.save();
      final model = RegisterRequestModel(
        email: _emailController.text, 
        password: _passwordController.text, 
        name: _firstnameCotroller.text,
        );
        context.read<RegisterBloc>().add(RegisterEvent.register(model));
        isEmailVerified = true;
    } else {
      isEmailVerified = false;
    }
  }

  @override
  void initState(){
    super.initState();
    _formKey = GlobalKey<FormState>();
  }
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeSmall),
      children: [
        Form(key: _formKey,
        child: Column(
          children: [ 
            Container(
              margin: const EdgeInsets.only(
                  left: Dimensions.marginSizeDefault,
                  right: Dimensions.marginSizeDefault,
              ),
              child: Row(
                children: [
                  Expanded(child: CustomTextField(
                    hintText: 'Name',
                    textInputType: TextInputType.name,
                    focusNode: _fnameFocus,
                    nexNode: _1NameFocus,
                    isPhoneNumber: false,
                    capitalization: TextCapitalization.words,
                    controller: _firstnameCotroller,
                  )),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(
                left: Dimensions.marginSizeDefault,
                right: Dimensions.marginSizeDefault,
                top: Dimensions.marginSizeDefault
              ),
              child: CustomTextField(
                hintText: 'Email',
                focusNode: _emailFoucs,
                nexNode: _phoneFocus,
                textInputType: TextInputType.emailAddress,
                controller: _emailController,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(
                left: Dimensions.marginSizeDefault,
                right: Dimensions.marginSizeDefault,
                top: Dimensions.marginSizeSmall
              ),
              child: CustomPasswordTextField(
                hintText: 'Password',
                controller: _passwordController,
                focusNode: _passwordFocus,
                nexNode: _ConfirmPasswordFocus,
                textInputAction: TextInputAction.next,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(
                left: Dimensions.marginSizeDefault,
                right: Dimensions.marginSizeDefault,
                top: Dimensions.marginSizeSmall
              ),
              child: CustomPasswordTextField(
                hintText: 'Password Confirmation',
                controller: _confirmpasswordController,
                focusNode: _ConfirmPasswordFocus,
                textInputAction: TextInputAction.done,
              ),
            ),
          ],
        ), 
        ),
        Container(
          margin: const EdgeInsets.only(
            left: Dimensions.marginSizeLarge,
            right: Dimensions.marginSizeLarge,
            bottom: Dimensions.marginSizeLarge,
            top: Dimensions.marginSizeLarge
          ),
          child: BlocListener<RegisterBloc, RegisterState>(
            listener: (context, state) {
              state.maybeWhen(
                orElse: () {},
                error: (message){
                  return ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(message)),
                  );
                },
                loaded: (data) async {
                  await AuthLocalDatasource().saveAuthData(data);
                  Navigator.pushAndRemoveUntil(context, 
                  MaterialPageRoute(builder: (context){
                    return SellerDashboard();
                  }), (route) => false);
                },
              );
          },
          child: BlocBuilder<RegisterBloc,RegisterState>(
            builder: (context,state) {
              return state.maybeWhen(orElse: (){
                return CustomButton(buttonText: 'Sign Up', onTap: addUser());
              },
              loading: () => const Center(
                child:  CircularProgressIndicator(),
              ),
              );           
              },
              ),
          ),
        ),
      Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextButton(onPressed: (){
              Navigator.pushAndRemoveUntil(context, 
              MaterialPageRoute(builder: (context){
                return const SellerDashboard();
              }), (route) => false);

            }, child: Text('Skip for Now',
                style: titilliumRegular.copyWith(
                    fontSize: Dimensions.fontSizeDefault,
                    color: ColorResources.getPrimary(context)
                ))),
            Icon(
              Icons.arrow_forward,
              size: 15,
              color: Theme.of(context).primaryColor,
            )
          ],
        )
      ),
      ],
    );
  }
}