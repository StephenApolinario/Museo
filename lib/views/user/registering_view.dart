import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:museo/constants/colors.dart';
import 'package:museo/extensions/buildcontext/loc.dart';
import 'package:museo/helpers/loading_screen.dart';
import 'package:museo/utilities/dialogs/generic_dialog.dart';
import 'package:museo/utilities/registeringOrLogging/generic_textfield.dart';

class RegisteringTitleSubtitle {
  final String title, subtitle;

  RegisteringTitleSubtitle({
    required this.title,
    required this.subtitle,
  });
}

class RegisteringView extends StatefulWidget {
  const RegisteringView({super.key});

  @override
  State<RegisteringView> createState() => _RegisteringViewState();
}

class _RegisteringViewState extends State<RegisteringView> {
  // Page Controller
  late PageController _controller;
  int currentPage = 0;

  // Personal Data
  late final TextEditingController _name;
  late final TextEditingController _lastName;
  late final TextEditingController _email;
  late final TextEditingController _cpf;
  late final TextEditingController _birthday;
  late final TextEditingController _phoneNumber;

  // Address Data
  late final TextEditingController _cep;
  late final TextEditingController _state;
  late final TextEditingController _city;
  late final TextEditingController _neighborhood;
  late final TextEditingController _houseAddres;
  late final TextEditingController _houseNumber;
  late final TextEditingController _houseComplement;

  // Password Data
  late final TextEditingController _password;
  late final TextEditingController _repeatPassword;

  @override
  void initState() {
    // Page controller
    _controller = PageController(initialPage: 0);

    // Personal Data
    _name = TextEditingController();
    _lastName = TextEditingController();
    _email = TextEditingController();
    _cpf = TextEditingController();
    _birthday = TextEditingController();
    _phoneNumber = TextEditingController();

    // Address data
    _cep = TextEditingController();
    _state = TextEditingController();
    _city = TextEditingController();
    _neighborhood = TextEditingController();
    _houseAddres = TextEditingController();
    _houseNumber = TextEditingController();
    _houseComplement = TextEditingController();

    // Password data
    _password = TextEditingController();
    _repeatPassword = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    // Page Controller
    _controller.dispose();

    // Personal Data
    _name.dispose();
    _lastName.dispose();
    _email.dispose();
    _cpf.dispose();
    _birthday.dispose();
    _phoneNumber.dispose();

    // Addres Data
    _cep.dispose();
    _state.dispose();
    _city.dispose();
    _neighborhood.dispose();
    _houseAddres.dispose();
    _houseNumber.dispose();
    _houseComplement.dispose();

    // Password data
    _password.dispose();
    _repeatPassword.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<RegisteringTitleSubtitle> registerintSteps = [
      RegisteringTitleSubtitle(
        title: context.loc.registering_content_title,
        subtitle: context.loc.registering_personal_data_content_subtitle,
      ),
      RegisteringTitleSubtitle(
        title: context.loc.registering_content_title,
        subtitle: context.loc.registering_address_data_content_subtitle,
      ),
      RegisteringTitleSubtitle(
        title: context.loc.registering_content_title,
        // TODO -> Should be provided by the context.loc
        subtitle: 'Defina sua senha',
      ),
    ];

    return Scaffold(
      backgroundColor: mainBlue,
      appBar: AppBar(
        title: Text(
          context.loc.registering_title,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: mainBlue,
        leading: currentPage != 0
            ? IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  setState(() {
                    currentPage -= 2;
                  });
                  _controller.previousPage(
                    duration: const Duration(milliseconds: 250),
                    curve: Curves.easeOut,
                  );
                },
              )
            : null,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: PageView.builder(
          controller: _controller,
          itemCount: registerintSteps.length,
          onPageChanged: (value) => setState(() {
            currentPage++;
          }),
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, step) {
            switch (step) {
              case 0:
                return registeringPersonalData(
                    registerintSteps[step], currentPage);
              case 1:
                return registeringAddressData(
                    registerintSteps[step], currentPage);
              case 2:
                return registeringPasswordData(
                    registerintSteps[step], currentPage);
            }
            return null;
          },
        ),
      ),
    );
  }

  SingleChildScrollView registeringPersonalData(
    RegisteringTitleSubtitle registerTitleSubtitle,
    int currentPage,
  ) {
    return SingleChildScrollView(
      child: Column(
        children: [
          // Create your account && Personal data
          Center(
            child: Column(
              children: [
                Text(
                  registerTitleSubtitle.title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                  ),
                ),
                Text(
                  registerTitleSubtitle.subtitle,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Column(
              children: [
                // Name Textfield
                commonTextField(
                  specifiedController: _name,
                  hintTitle: context.loc.registering_name,
                ),
                // lastname title
                commonTextField(
                  specifiedController: _lastName,
                  hintTitle: context.loc.registering_lastname,
                ),
                // Email title
                // TODO -> Valid if the input is an email addres.
                commonTextField(
                  specifiedController: _email,
                  hintTitle: context.loc.registering_email,
                  keyboardType: TextInputType.emailAddress,
                ),
                // TODO -> Valid if the input is an CPF.
                commonTextField(
                  specifiedController: _cpf,
                  hintTitle: context.loc.registering_CPF,
                  keyboardType: TextInputType.datetime,
                  formatter: CpfInputFormatter(),
                ),
                // TODO -> Valid if the input is an Birthday type.
                commonTextField(
                  specifiedController: _birthday,
                  hintTitle: context.loc.registering_birthday,
                  keyboardType: TextInputType.datetime,
                  formatter: DataInputFormatter(),
                ),
                // TODO -> Valid if the input is an Phonenumber type.
                commonTextField(
                  specifiedController: _phoneNumber,
                  hintTitle: context.loc.registering_phonenumber,
                  keyboardType: TextInputType.datetime,
                  formatter: TelefoneInputFormatter(),
                ),
                // Continue Button
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () {
                    final name = _name.text;
                    final lastName = _lastName.text;
                    final email = _email.text;
                    final cpf = _cpf.text;
                    final birthday = _birthday.text;
                    final phoneNumber = _phoneNumber.text;

                    // TODO -> Check if each TextField is valid.
                    final allFilled = name.isNotEmpty &&
                        lastName.isNotEmpty &&
                        email.isNotEmpty &&
                        cpf.isNotEmpty &&
                        birthday.isNotEmpty &&
                        phoneNumber.isNotEmpty;
                    if (allFilled) {
                      _controller.nextPage(
                        duration: const Duration(milliseconds: 250),
                        curve: Curves.easeInExpo,
                      );
                    } else {
                      showGenericDialog(
                        context: context,
                        title: context.loc.dialog_error_ops,
                        content: context.loc.dialog_error_not_filled,
                        optionsBuilder: () => {
                          'Ok': false,
                        },
                      );
                    }
                  },
                  child: Text(
                    context.loc.continue_message,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  SingleChildScrollView registeringAddressData(
    RegisteringTitleSubtitle registerTitleSubtitle,
    int currentPage,
  ) {
    return SingleChildScrollView(
      child: Column(
        children: [
          // Create your account && Address data
          Center(
            child: Column(
              children: [
                Text(
                  registerTitleSubtitle.title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                  ),
                ),
                Text(
                  registerTitleSubtitle.subtitle,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Column(
              children: [
                // Cep
                // TODO -> Valid if the input is an CEP.
                commonTextField(
                  specifiedController: _cep,
                  hintTitle: context.loc.registering_house_CEP,
                  formatter: CepInputFormatter(),
                ),
                // TODO -> Retrive information about State, City, Neighborhood and Address from the CEP.
                // State
                commonTextField(
                  specifiedController: _state,
                  hintTitle: context.loc.registering_house_state,
                ),
                // City
                commonTextField(
                  specifiedController: _city,
                  hintTitle: context.loc.registering_house_city,
                ),
                // Neighborhood
                commonTextField(
                  specifiedController: _neighborhood,
                  hintTitle: context.loc.registering_house_neighborhood,
                ),
                // Address
                commonTextField(
                  specifiedController: _houseAddres,
                  hintTitle: context.loc.registering_house_address,
                ),
                // House Number
                commonTextField(
                  specifiedController: _houseNumber,
                  hintTitle: context.loc.registering_house_number,
                ),
                // House Complement
                commonTextField(
                  specifiedController: _houseComplement,
                  hintTitle: context.loc.registering_house_complement,
                ),
                // Continue Button
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () {
                    final cep = _cep.text;
                    final state = _state.text;
                    final city = _city.text;
                    final neighborhood = _neighborhood.text;
                    final houseAddres = _houseAddres.text;
                    final houseNumber = _houseNumber.text;
                    final houseComplement = _houseComplement.text;

                    // TODO -> Check if each TextField is valid.
                    final allFilled = cep.isNotEmpty &&
                        state.isNotEmpty &&
                        city.isNotEmpty &&
                        neighborhood.isNotEmpty &&
                        houseAddres.isNotEmpty &&
                        houseNumber.isNotEmpty;
                    if (allFilled) {
                      _controller.nextPage(
                        duration: const Duration(milliseconds: 250),
                        curve: Curves.easeInExpo,
                      );
                    } else {
                      showGenericDialog(
                        context: context,
                        title: context.loc.dialog_error_ops,
                        content: context.loc.dialog_error_not_filled,
                        optionsBuilder: () => {
                          'Ok': false,
                        },
                      );
                    }
                  },
                  child: Text(
                    context.loc.continue_message,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  SingleChildScrollView registeringPasswordData(
    RegisteringTitleSubtitle registerTitleSubtitle,
    int currentPage,
  ) {
    return SingleChildScrollView(
      child: Column(
        children: [
          // Create your account && Define your password
          Center(
            child: Column(
              children: [
                Text(
                  registerTitleSubtitle.title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                  ),
                ),
                Text(
                  registerTitleSubtitle.subtitle,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Column(
              children: [
                commonTextField(
                  specifiedController: _password,
                  hintTitle: context.loc.password_hint,
                  obsecure: true,
                ),
                commonTextField(
                  specifiedController: _repeatPassword,
                  // TODO -> Hint from context.loc
                  // hintTitle: context.loc.password_hint,
                  hintTitle: 'Repita sua senha',
                  obsecure: true,
                ),
                // Continue Button
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () {
                    final password = _password.text;
                    final repeatPassword = _repeatPassword.text;

                    // TODO -> Check if each TextField is valid.
                    final allFilled =
                        password.isNotEmpty && repeatPassword.isNotEmpty;
                    if (allFilled && (password == repeatPassword)) {
                      FocusManager.instance.primaryFocus?.unfocus();
                      // TODO -> Connection with databse and remove fake waiting.
                      LoadingScreen().show(
                          context: context,
                          title: 'AGUARDE...',
                          subtitle: 'Estamos processando suas informações');
                      Future.delayed(const Duration(milliseconds: 1000), () {
                        LoadingScreen().hide();
                      });
                    } else if (password != repeatPassword) {
                      showGenericDialog(
                        context: context,
                        title: context.loc.dialog_error_ops,
                        // TODO -> Content should be provided by L10N
                        // content: context.loc.dialog_error_not_filled,
                        content: 'As senhas devem ser iguais!',
                        optionsBuilder: () => {
                          'Ok': false,
                        },
                      );
                    } else {
                      showGenericDialog(
                        context: context,
                        title: context.loc.dialog_error_ops,
                        content: context.loc.dialog_error_not_filled,
                        optionsBuilder: () => {
                          'Ok': false,
                        },
                      );
                    }
                  },
                  child: Text(
                    context.loc.continue_message,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
