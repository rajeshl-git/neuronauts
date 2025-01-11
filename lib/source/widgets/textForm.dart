// ignore: file_names

import 'package:flutter/material.dart';

Widget textForm(TextEditingController controller, String vld, String hnt, IconData iccon){
    return TextFormField(
                          style: const TextStyle(
                              color: Colors.white),
                          controller: controller,
                          validator: (text) {
                            if (text == null || text.isEmpty) {
                              return vld;
                            }
                            return null;
                          },
                          decoration:  InputDecoration(
                            enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.transparent),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(14)),
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.transparent),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(14)),
                            ),
                            prefixIcon: Icon(
                              iccon,
                              color: Colors.white
                            ),
                            suffixIcon: const Icon(
                              Icons.star_purple500,
                              color: Colors.white
                            ),
                            hintText: hnt,
                            hintStyle: const TextStyle(
                              color: Colors.white
                            ),
                            filled: true,
                            fillColor: Colors.black87,
                          ),
                        );
  }