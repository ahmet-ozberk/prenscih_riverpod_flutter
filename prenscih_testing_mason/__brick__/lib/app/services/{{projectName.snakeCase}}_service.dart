// ignore_for_file: unnecessary_brace_in_string_interps

import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:grock/grock.dart';

class {{projectName.pascalCase()}}Service<T> {
  static const String baseUrl = "https://doooner.wookapp5.com/api/";
  static const String imageUrl = "https://doooner.wookapp5.com";
  static Options? getToken() {
    final token = GetStorage().read("token");
    if(token == null){
      return null;
    }
    return Options(headers: {"Authorization": "Bearer $token"});
  }

  static saveToken(String token) async {
    await GetStorage().write("token", token);
  }

  Future<T?> getMethod(
      {required String url,
      bool token = true,
      Function(Map<String, dynamic> type)? fromJson,
      bool isLoad = true}) async {
    loading();
    Response? response;
    final dio = Dio();
    try {
      response =
          await dio.get("${baseUrl}${url}", options: token ? getToken() : null);
      log("${response.data}", name: "${baseUrl}${url}");
      if (response.statusCode == HttpStatus.ok) {
        if (isLoad) {
          Grock.back();
        }
        return fromJson == null ? response.data : fromJson(response.data);
      } else {
        if (isLoad) {
          Grock.back();
        }
        log(response.statusCode.toString(), name: "GET ERROR");
        return null;
      }
    } catch (error) {
      log(error.toString(), name: "GET ERROR");
      Grock.toast(
          text: "Bir sorun oluştu, tekrar deneyin.",
          backgroundColor: Colors.black.withOpacity(0.6),
          textColor: Colors.white,
          duration: const Duration(seconds: 2));
    }
  }

  Future<T?> postMethod(
      {required String url,
      bool token = true,
      Map<String, dynamic>? data,
      Function(Map<String, dynamic> type)? fromJson,
      bool isLoad = true}) async {
    if (isLoad) {
      loading();
    }
    Response response;
    final dio = Dio();
    try {
      response = await dio.post("${baseUrl}${url}",
          data: data, options: token ? getToken() : null);
      log("${response.data}", name: "${baseUrl}${url}");
      if (response.statusCode == HttpStatus.ok) {
        if (isLoad) {
          Grock.back();
        }
        return fromJson == null ? response.data : fromJson(response.data);
      } else {
        if (isLoad) {
          Grock.back();
        }
        log(response.statusCode.toString(), name: "POST ERROR");
        return null;
      }
    } catch (error) {
      Grock.back();
      log(error.toString(), name: "POST ERROR");
      Grock.toast(
          text: "Bir sorun oluştu, tekrar deneyin.",
          backgroundColor: Colors.black.withOpacity(0.6),
          textColor: Colors.white,
          duration: const Duration(seconds: 2));
    }
  }

  Future<T?> putMethod({
    required String url,
    bool token = true,
    Map<String, dynamic>? data,
    Function(Map<String, dynamic> type)? fromJson,
  }) async {
    loading();
    Response response;
    final dio = Dio();
    try {
      response = await dio.put("${baseUrl}${url}",
          data: data, options: token ? getToken() : null);
      if (response.statusCode == HttpStatus.ok) {
        Grock.back();
        return fromJson == null ? response.data : fromJson(response.data);
      } else {
        Grock.back();
        log(response.statusCode.toString(), name: "PUT ERROR");
        return null;
      }
    } catch (error) {
      Grock.back();
      log(error.toString(), name: "PUT ERROR");
      Grock.toast(
          text: "Bir sorun oluştu, tekrar deneyin.",
          backgroundColor: Colors.black.withOpacity(0.6),
          textColor: Colors.white,
          duration: const Duration(seconds: 2));
    }
  }

  Future<T?> deleteMethod({
    required String url,
    bool token = true,
    Function(Map<String, dynamic> type)? fromJson,
  }) async {
    loading();
    Response? response;
    final dio = Dio();
    try {
      response = await dio.delete("${baseUrl}${url}",
          options: token ? getToken() : null);
      log("${response.data}", name: "${baseUrl}${url}");
      if (response.statusCode == HttpStatus.ok) {
        Grock.back();
        return fromJson == null ? response.data : fromJson(response.data);
      } else {
        Grock.back();
        log(response.statusCode.toString(), name: "DELETE ERROR");
        return null;
      }
    } catch (error) {
      Grock.back();
      log(error.toString(), name: "DELETE ERROR");
      Grock.toast(
          text: "Bir sorun oluştu, tekrar deneyin.",
          backgroundColor: Colors.black.withOpacity(0.6),
          textColor: Colors.white,
          duration: const Duration(seconds: 2));
    }
  }

  void loading() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Grock.dialog(
        builder: (p0) {
          return Grock.loadingPopup();
        },
        barrierDismissible: false,
      );
    });
  }

  static void toast(String text) {
    Grock.toast(
      text: text,
      backgroundColor: Colors.black.withOpacity(0.8),
      textColor: Colors.white,
      curve: Curves.fastOutSlowIn,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      duration: const Duration(seconds: 3),
    );
  }
}