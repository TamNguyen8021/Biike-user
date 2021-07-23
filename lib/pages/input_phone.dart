library intl_phone_field;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:bikes_user/widgets/phones/contries.dart';
import 'package:bikes_user/widgets/phones/phone_numbers.dart';


// ignore: must_be_immutable
class PhoneField extends StatefulWidget {
  final bool obscureText;
  final TextAlign textAlign;
  final TextAlignVertical? textAlignVertical;
  final VoidCallback? onTap;
final bool readOnly;
  final FormFieldSetter<PhoneNumber>? onSaved;
  final ValueChanged<PhoneNumber>? onChanged;
  final ValueChanged<PhoneNumber>? onCountryChanged;
   final FormFieldValidator<String>? validator;
  final bool autoValidate;
  final TextInputType keyboardType;
  final TextEditingController? controller;
   final FocusNode? focusNode;
    final void Function(String)? onSubmitted;
    final bool enabled;
    final Brightness keyboardAppearance;
    final String? initialValue;
    final String? initialCountryCode;
    final List<String>? countries;
    final InputDecoration? decoration;
    final TextStyle? style;
    final bool showDropdownIcon;
    final BoxDecoration dropdownDecoration;
     final List<TextInputFormatter>? inputFormatters;
     final String searchText;
     final Color? countryCodeTextColor;
     final IconPosition iconPosition;
     final Icon dropDownIcon;
     final bool autofocus;
     final AutovalidateMode? autovalidateMode;
     final bool showCountryFlag;
     TextInputAction? textInputAction;
     PhoneField(
      {this.initialCountryCode,
      this.obscureText = false,
      this.textAlign = TextAlign.left,
      this.textAlignVertical,
      this.onTap,
      this.readOnly = false,
      this.initialValue,
      this.keyboardType = TextInputType.number,
      this.autoValidate = true,
      this.controller,
      this.focusNode,
      this.decoration,
      this.style,
      this.onSubmitted,
      this.validator,
      this.onChanged,
      this.countries,
      this.onCountryChanged,
      this.onSaved,
      this.showDropdownIcon = true,
      this.dropdownDecoration = const BoxDecoration(),
      this.inputFormatters,
      this.enabled = true,
      this.keyboardAppearance = Brightness.light,
      this.searchText = 'Search by Country Name',
      this.countryCodeTextColor,
      this.iconPosition = IconPosition.leading,
      this.dropDownIcon = const Icon(Icons.arrow_drop_down),
      this.autofocus = false,
      this.textInputAction,
      this.autovalidateMode,
      this.showCountryFlag = true
      }
      );
       @override
  IntlPhoneFieldState createState() => IntlPhoneFieldState();
}

class IntlPhoneFieldState extends State<PhoneField> {
  late List<Map<String, dynamic>> _countryList;
  late Map<String, dynamic> _selectedCountry;
  late List<Map<String, dynamic>> filteredCountries;

  FormFieldValidator<String>? validator;

  @override
  void initState() {
    super.initState();
    _countryList = widget.countries == null
        ? countries
        : countries
            .where((country) => widget.countries!.contains(country['code']))
            .toList();
    filteredCountries = _countryList;
    _selectedCountry = _countryList.firstWhere(
        (item) => item['code'] == (widget.initialCountryCode ?? 'US'),
        orElse: () => _countryList.first);

    validator = widget.autoValidate
        ? ((value) =>
            value != null && value.length != _selectedCountry['max_length']
                ? 'Invalid Mobile Number'
                : null)
        : widget.validator;
  }

  Future<void> _changeCountry() async {
    filteredCountries = _countryList;
    await showDialog(
      context: context,
      useRootNavigator: false,
      builder: (context) => StatefulBuilder(
        builder: (ctx, setState) => Dialog(
          child: Container(
            padding: EdgeInsets.all(10),
            child: Column(
              children: <Widget>[
                TextField(
                  decoration: InputDecoration(
                    suffixIcon: Icon(Icons.search),
                    labelText: widget.searchText,
                  ),
                  onChanged: (value) {
                    filteredCountries = _countryList
                      .where((country) => country['name']!
                      .toLowerCase()
                      .contains(value.toLowerCase()))
                      .toList();
                    if (this.mounted) setState(() {});
                  },
                ),
                SizedBox(height: 20),
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: filteredCountries.length,
                    itemBuilder: (ctx, index) => Column(
                      children: <Widget>[
                        ListTile(
                          leading: Image.asset(
                            'assets/flags/${filteredCountries[index]['code']!.toLowerCase()}.png',
                            package: 'intl_phone_field',
                            width: 32,
                          ),
                          title: Text(
                            filteredCountries[index]['name']!,
                            style: TextStyle(fontWeight: FontWeight.w700),
                          ),
                          trailing: Text(
                            '+${filteredCountries[index]['dial_code']}',
                            style: TextStyle(fontWeight: FontWeight.w700),
                          ),
                          onTap: () {
                            _selectedCountry = filteredCountries[index];

                            if (widget.onCountryChanged != null) {
                              widget.onCountryChanged!(
                                PhoneNumber(
                                  countryISOCode: _selectedCountry['code'],
                                  countryCode:
                                      '+${_selectedCountry['dial_code']}',
                                  number: '',
                                ),
                              );
                            }

                            Navigator.of(context).pop();
                          },
                        ),
                        Divider(thickness: 1),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
    if (this.mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        _buildFlagsButton(),
        SizedBox(width: 8),
        Expanded(
          child: TextFormField(
            initialValue: widget.initialValue,
            readOnly: widget.readOnly,
            obscureText: widget.obscureText,
            textAlign: widget.textAlign,
            textAlignVertical: widget.textAlignVertical,
            onTap: () {
              if (widget.onTap != null) widget.onTap!();
            },
            controller: widget.controller,
            focusNode: widget.focusNode,
            onFieldSubmitted: (s) {
              if (widget.onSubmitted != null) widget.onSubmitted!(s);
            },
            decoration: widget.decoration?.copyWith(
              counterText: !widget.enabled ? '' : null,
            ),
            style: widget.style,
            onSaved: (value) {
              if (widget.onSaved != null)
                widget.onSaved!(
                  PhoneNumber(
                    countryISOCode: _selectedCountry['code'],
                    countryCode: '+${_selectedCountry['dial_code']}',
                    number: value,
                  ),
                );
            },
            onChanged: (value) {
              if (widget.onChanged != null)
                widget.onChanged!(
                  PhoneNumber(
                    countryISOCode: _selectedCountry['code'],
                    countryCode: '+${_selectedCountry['dial_code']}',
                    number: value,
                  ),
                );
            },
            validator: validator,
            maxLength: _selectedCountry['max_length'],
            keyboardType: widget.keyboardType,
            inputFormatters: widget.inputFormatters,
            enabled: widget.enabled,
            keyboardAppearance: widget.keyboardAppearance,
            autofocus: widget.autofocus,
            textInputAction: widget.textInputAction,
            autovalidateMode: widget.autovalidateMode,
          ),
        ),
      ],
    );
  }

  DecoratedBox _buildFlagsButton() {
    return DecoratedBox(
      decoration: widget.dropdownDecoration,
      child: InkWell(
        borderRadius: widget.dropdownDecoration.borderRadius as BorderRadius?,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              if (widget.enabled &&
                  widget.showDropdownIcon &&
                  widget.iconPosition == IconPosition.leading) ...[
                widget.dropDownIcon,
                SizedBox(width: 4)
              ],
              if (widget.showCountryFlag) ...[
                Image.asset(
                  'assets/flags/${_selectedCountry['code']!.toLowerCase()}.png',
                  package: 'intl_phone_field',
                  width: 32,
                ),
                SizedBox(width: 8)
              ],
              FittedBox(
                child: Text(
                  '+${_selectedCountry['dial_code']}',
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: widget.countryCodeTextColor),
                ),
              ),
              SizedBox(width: 8),
              if (widget.enabled &&
                  widget.showDropdownIcon &&
                  widget.iconPosition == IconPosition.trailing) ...[
                widget.dropDownIcon,
                SizedBox(width: 4)
              ],
            ],
          ),
        ),
        onTap: widget.enabled ? _changeCountry : null,
      ),
    );
  }
}

enum IconPosition {
  leading,
  trailing,
}


