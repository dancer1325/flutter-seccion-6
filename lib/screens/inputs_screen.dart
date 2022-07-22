import 'package:fl_components/widgets/widgets.dart';
import 'package:flutter/material.dart';

class InputsScreen extends StatelessWidget {
   
  const InputsScreen({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {

    // Key to keep the reference to the widget
    final GlobalKey<FormState> myFormKey = GlobalKey<FormState>();

    // Map to keep form's values. Normally a state will be used
    final Map<String, String> formValues = {
      'first_name': 'Fernando',
      'last_name' : 'Herrera',
      'email'     : 'fernando@google.com',
      'password'  : '123456',
      'role'      : 'Admin'
    };

    return Scaffold(
      appBar: AppBar(
        title: const Text('Inputs y Forms'),
      ),
      // Since we are going to create a form, a keyboard could appear in the screen --> Required to use a Widget which allows doing scroll
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric( horizontal: 20, vertical: 10 ),
          child: Form(
            key: myFormKey,
            child: Column(
              children: [
          
                 CustomInputField( labelText: 'Nombre', hintText: 'Nombre del usuario', formProperty: 'first_name', formValues: formValues, icon: Icons.assignment_ind_outlined, suffixIcon: Icons.group_outlined,),
                 const SizedBox( height: 30 ),
          
                 CustomInputField( labelText: 'Apellido', hintText: 'Apellido del usuario', formProperty: 'last_name', formValues: formValues ),
                 const SizedBox( height: 30 ),
          
                 CustomInputField( labelText: 'Correo', hintText: 'Correo del usuario', keyboardType: TextInputType.emailAddress, formProperty: 'email', formValues: formValues ),
                 const SizedBox( height: 30 ),
                 
                 CustomInputField( labelText: 'Contraseña', hintText: 'Contraseña del usuario', obscureText: true, formProperty: 'password', formValues: formValues ),
                 const SizedBox( height: 30 ),


                DropdownButtonFormField<String>(      // <TypeOfObjectWhichIsUsedInTheDropDown>
                  value: 'Admin',
                  items: const[       // Drop down's options
                    DropdownMenuItem( value: 'Admin', child: Text('Admin')),      // value  Value returned, when it's selected      child    It's the Widget to be displayed
                    DropdownMenuItem( value: 'Superuser', child: Text('Superuser')),
                    DropdownMenuItem( value: 'Developer', child: Text('Developer')),
                    DropdownMenuItem( value: 'Jr. Developer', child: Text('Jr. Developerddd')),
                  ],
                  onChanged: ( value ) {    // Required event always in Drop down buttons
                    print(value);
                    formValues['role'] = value ?? 'Admin';    // ??   If value == null --> Right element is the default one
                  }
                ),


                 
                 ElevatedButton(
                   child: const SizedBox(
                     width: double.infinity,
                     child: Center(child: const Text('Guardar'))
                    ),
                   onPressed: () {

                     // Disable the keyboard which has appeared when you put the focus on the input field
                      FocusScope.of(context).requestFocus( FocusNode() );

                      // Get the form by the key, and validate it
                      if ( !myFormKey.currentState!.validate() ) {
                        print('Formulario no válido');
                        return;
                      }

                      //* imprimir valores del formulario
                      print(formValues);
                   }, 
                  )
          
              ],
            ),
          )
        ),
      )
    );
  }
}
