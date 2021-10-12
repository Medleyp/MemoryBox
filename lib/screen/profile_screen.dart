import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:provider/provider.dart';

import '/service/auth_serivce.dart';
import '/service/constants.dart';
import '/service/file_service.dart';

import '/screen/entry/registration_screen.dart';
import '/model/user_model.dart';

import '../widgets/widgets.dart';
import '../widgets/dialogs.dart';

class ProfileScreen extends StatefulWidget {
  static const routeName = '/profile';
  static const Color appBarColor = Constants.purpleColor;
  static const String appBarText = 'Профиль';
  final Function setAppBarLeding;

  const ProfileScreen(this.setAppBarLeding, {Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _isEditing = false;
  bool _isSignOut = false;

  late String _imageUrl;

  TextEditingController? _editPhoneController;
  TextEditingController? _editNameController;
  String? _editImageUrl;

  Future<void> saveChanges({
    required UserModel userModel,
    String? editImageUrl,
    TextEditingController? editNameController,
    TextEditingController? editPhoneController,
    required double height,
    required double width,
  }) async {
    if (editImageUrl != _imageUrl) {
      await userModel.setImageUrl(editImageUrl!);
    }
    if (editNameController!.text.isNotEmpty) {
      await userModel.setName(editNameController.text);
    }

    if (editPhoneController!.text.isNotEmpty &&
        editPhoneController.text != userModel.phone) {
      TextEditingController otpController = TextEditingController();
      try {
        await AuthService.getInstance()
            .verifyPhoneNumber(context, _editPhoneController!.text);
        await showDialog(
          context: context,
          builder: (ctx) => verifyNumberDialog(
            ctx,
            otpController,
            height: height,
            width: width,
          ),
        );

        await AuthService.getInstance().updatePhoneNumber(otpController.text);
        await userModel.setPhoneNumber(editPhoneController.text);
        await AuthService.getInstance()
            .signInWithCredentials(otpController.text);
      } on FirebaseAuthException catch (e) {
        if (e.code == 'credential-already-in-use') {
          await showErrorDialog(context, 'Это номер занят');
        } else {
          await showErrorDialog(context, 'Неправильный код');
        }
        setState(() {
          widget.setAppBarLeding(_backArrowAppBar());
          _isEditing = true;
        });
      }
    }
    setState(() {
      _imageUrl = editImageUrl!;
    });
    editImageUrl = null;
    editNameController = null;
    editPhoneController = null;
  }

  TextButton _buildEditButton(
    String text,
    UserModel userModel, {
    required double height,
    required double width,
  }) {
    return TextButton(
      onPressed: () {
        if (!_isEditing) {
          widget.setAppBarLeding(_backArrowAppBar());
        }

        setState(() {
          if (_isEditing) {
            widget.setAppBarLeding();
            saveChanges(
              userModel: userModel,
              editImageUrl: _editImageUrl,
              editNameController: _editNameController,
              editPhoneController: _editPhoneController,
              height: height,
              width: width,
            );
          }
          _isEditing = !_isEditing;
        });
      },
      child: Text(
        text,
        style: const TextStyle(
          fontFamily: 'TTNorms',
          fontSize: 13,
          fontWeight: FontWeight.w500,
          color: Constants.textColor,
        ),
      ),
    );
  }

  Widget _backArrowAppBar() {
    return Container(
      margin: const EdgeInsets.only(left: 9, top: 9),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15), color: Colors.white),
      child: IconButton(
        onPressed: () {
          setState(() {
            widget.setAppBarLeding();
            _isEditing = false;
            _editImageUrl = null;
            _editNameController = null;
            _editPhoneController = null;
          });
        },
        icon: SvgPicture.asset('assets/icons/Arrow - Left Circle.svg'),
      ),
    );
  }

  Widget _buildProfileImage(
    UserModel userModel, {
    required double height,
    required double width,
    required String imageUrl,
  }) {
    return Container(
      width: height * 0.26,
      height: height * 0.26,
      decoration: BoxDecoration(
        boxShadow: const [
          BoxShadow(color: Colors.black26, spreadRadius: 0, blurRadius: 10)
        ],
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Image.network(
          imageUrl,
          fit: BoxFit.fill,
        ),
      ),
    );
  }

  Widget _buildChangeProfileImage(
    UserModel userModel, {
    required double height,
    required double width,
  }) {
    _editImageUrl ??= _imageUrl;
    return InkWell(
      child: Stack(
        children: [
          _buildProfileImage(
            userModel,
            height: height,
            width: width,
            imageUrl: _editImageUrl!,
          ),
          InkWell(
            onTap: () async {
              File? file = await FileServise.pickFile();
              if (file == null) return;
              String url =
                  await FileServise.storeImageAndGetUrl(userModel.uid, file);
              setState(() {
                _editImageUrl = url;
              });
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.black.withOpacity(0.5),
              ),
              width: height * 0.26,
              height: height * 0.26,
              child: Center(
                child: Container(
                  width: height * 0.11,
                  height: height * 0.11,
                  padding: const EdgeInsets.all(17),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white.withOpacity(0.8),
                    ),
                  ),
                  child: SvgPicture.asset(
                    'assets/icons/Camera.svg',
                    color: Colors.white.withOpacity(0.8),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildMbLine(int mb) {
    return Container(
      width: double.infinity,
      height: 20,
      margin: const EdgeInsets.symmetric(horizontal: 40),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(15),
        color: Colors.amber,
        gradient: LinearGradient(
          colors: const [Constants.sendColor, Colors.white],
          stops: [mb / 500, mb / 500],
        ),
      ),
    );
  }

  TextButton _buildDeleteAcButton(
    BuildContext context,
    UserModel userModel, {
    required double height,
    required double width,
  }) {
    return TextButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (ctx) => acceptDialog(
            ctx,
            userModel,
            height: height,
            width: width,
          ),
        );
      },
      child: Text(
        'Удалить аккаунт',
        style: Theme.of(context)
            .textTheme
            .headline1!
            .copyWith(color: const Color(0xFFE27777)),
      ),
    );
  }

  TextButton _buildSignOutButton(BuildContext context, UserModel userModel) {
    return TextButton(
      onPressed: () async {
        _isSignOut = true;
        AuthService authService = AuthService.getInstance();
        await authService.signOut();
        Navigator.of(context)
            .pushReplacementNamed(RegistrationScreen.routeName);
      },
      child: Text(
        'Выйти из приложения',
        style: Theme.of(context).textTheme.headline1,
      ),
    );
  }

  @override
  void dispose() {
    if (_editImageUrl != null && _editImageUrl != _imageUrl) {
      FileServise.deleteFileFromUrl(_editImageUrl!);
    }

    if (!_isSignOut || _isEditing) {
      WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
        widget.setAppBarLeding();
      });
    }
    _editNameController?.dispose();
    _editPhoneController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    UserModel userModel = Provider.of<UserModel>(context);
    int mbData = userModel.mb;

    _imageUrl = userModel.imageUrl;

    TextEditingController _userNameContoroller =
        TextEditingController(text: userModel.name);
    TextEditingController _phoneNumberContoller =
        TextEditingController(text: userModel.phone);

    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;

    return paintedScaffold(
      body: Center(
        child: Column(
          children: [
            Text('Твоя частичка', style: Theme.of(context).textTheme.subtitle2),
            const SizedBox(height: 20),
            _isEditing
                ? _buildChangeProfileImage(
                    userModel,
                    height: height,
                    width: width,
                  )
                : _buildProfileImage(userModel,
                    height: height, width: width, imageUrl: _imageUrl),
            SizedBox(height: height * 0.01),
            SizedBox(
              width: 200,
              child: buildTextField(
                context,
                _editNameController ??= _userNameContoroller,
                enabled: _isEditing,
                keyboardType: TextInputType.name,
                showBorder: true,
              ),
            ),
            SizedBox(height: _isEditing ? height * 0.1 : 5),
            buildCardWithTextField(
              context,
              _editPhoneController ??= _phoneNumberContoller,
              enabled: _isEditing,
            ),
            _isEditing
                ? Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: _buildEditButton(
                      'Сохранить',
                      userModel,
                      height: height,
                      width: width,
                    ),
                  )
                : _buildEditButton(
                    'Редактировать',
                    userModel,
                    height: height,
                    width: width,
                  ),
            SizedBox(height: height * 0.04),
            if (!_isEditing) ...[
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: underlinedText(
                  context: context,
                  text: 'Подписка',
                  isWhite: false,
                ),
              ),
              _buildMbLine(mbData),
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text('$mbData/500 мб',
                    style: Theme.of(context).textTheme.headline1),
              ),
              Padding(
                padding: EdgeInsets.only(
                    right: 25, left: 25, top: height * 0.05 > 40 ? 40 : 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildSignOutButton(context, userModel),
                    _buildDeleteAcButton(
                      context,
                      userModel,
                      height: height,
                      width: width,
                    ),
                  ],
                ),
              )
            ],
          ],
        ),
      ),
    );
  }
}
