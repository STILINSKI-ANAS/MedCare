import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iconsax/iconsax.dart';
import 'package:medcare/utils/stringext.dart';
import '../config/database/sql_helper.dart';
import '../models/pill.dart';
import '../router/routes.dart';
import '../widgets/atoms/buttons.dart';
import '../widgets/atoms/text_field.dart';
import '../widgets/molecules/radio_card.dart';

class FormPage extends StatefulWidget {
  FormPage({
    Key? key,
  }) : super(key: key);
  final _formKey = GlobalKey<FormState>();
  Map<String, dynamic> formState = {
    'title': '',
    'weight': 0,
    'span': 0,
    'dosage': 0,
    'morning': null,
    'afternoon': null,
    'evening': null
  };

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  int id = 0;

  void getId() async {
    var data = await SQLhelper.getmaxId();
    setState(() {
      id = data + 1;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getId();
  }

  var tod = DateTime(DateTime.now().year, DateTime.now().month,
      DateTime.now().day, DateTime.now().hour, DateTime.now().minute, 1, 1, 1);
  var todrad = DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day,
      DateTime.now().hour,
      DateTime.now().minute,
      DateTime.now().second,
      DateTime.now().millisecond,
      DateTime.now().microsecond);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: _buildAppBar(),
        body: Stack(
          alignment: Alignment.topCenter,
          children: [
            Positioned(
              top: 0,
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 1.0,
                child: Image.asset(
                  "assets/images/bg.png",
                ),
              ),
            ),
            DraggableScrollableSheet(
                maxChildSize: .75,
                initialChildSize: .75,
                minChildSize: .70,
                builder: (context, scrollController) {
                  return Container(
                    padding: const EdgeInsets.only(
                        left: 15, right: 15, top: 30, bottom: 20),
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: Theme.of(context).scaffoldBackgroundColor),
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                        color: Theme.of(context).colorScheme.surface),
                    child: Stack(
                      alignment: Alignment.center,
                      clipBehavior: Clip.none,
                      children: [
                        Positioned(
                          top: -12,
                          child: Container(
                            margin: const EdgeInsets.only(
                              bottom: 12,
                            ),
                            width: 90,
                            height: 5,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Theme.of(context).colorScheme.surface),
                          ),
                        ),
                        SingleChildScrollView(
                          controller: scrollController,
                          physics: const BouncingScrollPhysics(),
                          child: Form(
                            key: widget._formKey,
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  titleForm(),
                                  weightForm(),
                                  amountAndSpanForm(),
                                  notificationsForm(),
                                  ButtonWidget(
                                    text: const Text(
                                      'Ajouter',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16,
                                          color: Colors.white),
                                    ),
                                    onPressed: () async {
                                      if (widget._formKey.currentState!
                                              .validate() ||
                                          [
                                            widget.formState['morning'],
                                            widget.formState['afternoon'],
                                            widget.formState['evening']
                                          ].any((element) => element != null)) {
                                        widget._formKey.currentState?.save();
                                        List<DateTime> times = [
                                          Map.from(widget.formState)[
                                                  'morning'] ??
                                              tod,
                                          Map.from(widget.formState)[
                                                  'afternoon'] ??
                                              tod,
                                          Map.from(widget.formState)[
                                                  'evening'] ??
                                              tod
                                        ];
                                        widget.formState.remove('morning');
                                        widget.formState.remove('afternoon');
                                        widget.formState.remove('evening');
                                        for (DateTime? time in times) {
                                          if (time == tod) {
                                            continue;
                                          }
                                          setState(() {
                                            id = id + 1;
                                          });
                                          Pill pill = Pill.fromJson({
                                            ...widget.formState,
                                            'time': time,
                                            'id': id
                                          });
                                          // print(pill.toJson());
                                          // print("year: ${pill.time.year} day: ${pill.time.day} hour: ${pill.time.hour}");
                                          await SQLhelper.insertPill(pill);
                                        }
                                        await Navigator.of(context)
                                            .pushNamed(RouteManager.bottomBar);
                                      }
                                    },
                                  )
                                ]),
                          ),
                        ),
                      ],
                    ),
                  );
                }),
          ],
        ));
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: const Color(0xFF32A060),
      elevation: 0,
      iconTheme: const IconThemeData(color: Colors.white),
      leading: IconButton(
        icon: const Icon(Iconsax.arrow_left, size: 20),
        onPressed: () => Navigator.pop(context),
      ), systemOverlayStyle: SystemUiOverlayStyle.light,
    );
  }

  Column notificationsForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Notifications',
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          children: [
            Expanded(
              child: RadioCard(
                  onTap: () {
                    setState(() {
                      widget.formState['morning'] =
                          ((widget.formState['morning'] == null)
                              ? DateTime(todrad.year, todrad.month, todrad.day,
                                  7, 0, 0, 0, 0)
                              : null);
                    });
                  },
                  active: (widget.formState['morning'] != null),
                  text: '7:00'),
            ),
            const SizedBox(
              width: 8,
            ),
            Expanded(
              child: RadioCard(
                  onTap: () {
                    setState(() {
                      widget.formState['afternoon'] =
                          ((widget.formState['afternoon'] == null)
                              ? DateTime(todrad.year, todrad.month, todrad.day,
                                  13, 0, 0, 0, 0)
                              : null);
                    });
                  },
                  active: (widget.formState['afternoon'] != null),
                  text: '13:00'),
            ),
            const SizedBox(
              width: 8,
            ),
            Expanded(
              child: RadioCard(
                  onTap: () {
                    setState(() {
                      widget.formState['evening'] =
                          ((widget.formState['evening'] == null)
                              ? DateTime(todrad.year, todrad.month, todrad.day,
                                  19, 0, 0, 0, 0)
                              : null);
                    });
                  },
                  active: (widget.formState['evening'] != null),
                  text: '19:00'),
            )
          ],
        ),
      ],
    );
  }

  Row amountAndSpanForm() {
    return Row(
      children: [
        Expanded(
          child: TextFieldWidget(
              onSave: (val) {
                setState(() {
                  widget.formState['dosage'] = int.parse(val);
                });
              },
              inputFormatters: [
                FilteringTextInputFormatter.allow(
                  RegExp(r"[0-9]"),
                )
              ],
              validator: (val) {
                if (val == null) {
                  return null;
                } else if (!val.isValidNumber) {
                  return 'Entrez une quantité valide';
                }
                return null;
              },
              icon: Iconsax.copy,
              hint: '1 Comprimé'),
        ),
        const SizedBox(
          width: 8,
        ),
        Expanded(
          child: TextFieldWidget(
              onSave: (val) {
                setState(() {
                  widget.formState['span'] = int.parse(val);
                });
              },
              inputFormatters: [
                FilteringTextInputFormatter.allow(
                  RegExp(r"[0-9]"),
                )
              ],
              validator: (val) {
                if (val == null) {
                  return null;
                } else if (!val.isValidNumber) {
                  return 'Entrez un  temps valide';
                }
                return null;
              },
              icon: Iconsax.calendar_1,
              hint: '21 jours'),
        )
      ],
    );
  }

  Column weightForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Dosage',
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
        ),
        TextFieldWidget(
            onSave: (val) {
              setState(() {
                widget.formState['weight'] = int.parse(val);
              });
            },
            inputFormatters: [
              FilteringTextInputFormatter.allow(
                RegExp(r"[0-9]"),
              )
            ],
            validator: (val) {
              if (val == null) {
                return null;
              } else if (!val.isValidNumber) {
                return 'Entrez un dosage valide';
              }
              return null;
            },
            icon: Iconsax.weight,
            hint: '69 mg'),
        const Text(
          'Quantité & Combien de Fois ?',
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
        ),
      ],
    );
  }

  Column titleForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Nom de Comprimé',
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
        ),
        TextFieldWidget(
            onSave: (val) {
              setState(() {
                widget.formState['title'] = val;
              });
            },
            inputFormatters: [
              FilteringTextInputFormatter.allow(
                RegExp(r"[a-zA-Z]+|\s"),
              )
            ],
            validator: (val) {
              if (val == null) {
                return null;
              } else if (!val.isValidName) {
                return 'Entrez un nom de comprimé valide';
              }
              return null;
            },
            icon: Icons.medical_services_outlined,
            hint: 'Doliprane'),
      ],
    );
  }
}
