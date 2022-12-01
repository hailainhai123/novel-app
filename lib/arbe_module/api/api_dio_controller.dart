import 'dart:io';

import 'package:dio/dio.dart';
import 'package:get/get.dart' hide Response, FormData, MultipartFile;
import 'package:novel_app_client/constant/api_url.dart';
import 'package:novel_app_client/constant/routes.dart';
import 'package:novel_app_client/models/app_setting_model.dart';
import 'package:novel_app_client/models/banner/model_banner.dart';
import 'package:novel_app_client/models/chapter_model.dart';
import 'package:novel_app_client/models/grid_novel/grid_novel_model.dart';
import 'package:novel_app_client/models/home/new_model/categories_novel_model.dart';
import 'package:novel_app_client/models/meta_model.dart';
import 'package:novel_app_client/models/notification_model.dart';
import 'package:novel_app_client/models/settings.model.dart';
import 'package:novel_app_client/models/user_infomation.dart';
import 'package:novel_app_client/utils/global_controller.dart';

import '../../models/comment_model.dart';
import '../../models/home/new_model/novel_response_model.dart';
import '../../models/list_chap_model.dart';
import '../../models/reading_state_model.dart';
import '../../models/response_temp_model.dart';
import '../utils/user_pref.dart';
import 'custom_log.dart';

const int kDefaultTimeOut = 60 * 1000;

class ApiDioController {
  static const _baseUrl = 'https://api.truyen3k.com';

  static BaseOptions options = BaseOptions(
    baseUrl: _baseUrl,
    headers: {
      'apiKey':
          '\$2b\$10\$A1rUeYglkeiUywujh8wWJu0W3eoI3esyZ27ze62LHkzJpdZxhXdei',
    },
    connectTimeout: kDefaultTimeOut,
    receiveTimeout: kDefaultTimeOut,
  );

  // Contruction to use multiple project
  static Future<T?> getData<T>({
    Function(MetaModel?)? metaCallback,
    required String url,
    required Dio dio,
    Map<String, dynamic>? query,
    required Function(dynamic) asModel,
  }) async {
    try {
      // dio.options.headers['x-access-token'] =
      //     Get.find<GlobalController>().accessToken.value;
      // print(accessToken);
      dio.options.headers['Authorization'] =
          "Bearer ${Get.find<GlobalController>().accessToken.value}";
      Response<Map<String, dynamic>> response = await dio.get(
        url,
        queryParameters: query,
      );

      if (response.statusCode == 200) {
        if (response.data!['message'] == "success") {
          if (response.data?['meta'] != null) {
            var meta = MetaModel.fromJson(response.data?['meta']);
            if (meta.hasNextPage != null) {
              // nextPage!(meta.hasNextPage ?? false);
              if (metaCallback != null) {
                metaCallback(meta);
              }
            }
          }
          if (response.data!['data'] != null) {
            return asModel(response.data!['data']);
          } else {
            return asModel(response.data!);
          }
        }
      } else if (response.statusCode == 403) {
        Get.find<GlobalController>().refreshToken();
        return null;
      }

      return null;
    } on DioError catch (e) {
      CustomLog.log(e);
      return null;
    } catch (e) {
      CustomLog.log(e);
      Get.defaultDialog(
          barrierDismissible: false,
          title: 'Phiên làm việc hết hạn, vui lòng đăng nhập lại!',
          onConfirm: () {
            Get.offAndToNamed(kLoginPage);
          });
      return null;
    }
  }

  static Future<T?> postMethods<T>({
    required String url,
    required Dio dio,
    dynamic body,
    required Function(Map<String, dynamic>) asModel,
  }) async {
    try {
      print(body);
      print(url);
      dio.options.headers['Authorization'] =
          "Bearer ${Get.find<GlobalController>().accessToken.value}";

      Response<Map<String, dynamic>> response = await dio.post(
        url,
        data: body,
      );
      CustomLog.log(response);
      if (response.statusCode == 200) {
        if (response.data!['message'] == "success") {
          return asModel(response.data!);
        }
      } else if (response.statusCode == 403) {
        print('token het han');
        Get.find<GlobalController>().refreshToken();
        return null;
      }

      return null;
    } on DioError catch (e) {
      CustomLog.log(e);
      return null;
    } catch (e) {
      CustomLog.log(e);
      return null;
    }
  }

  static Future<T?> putMethods<T>({
    required String url,
    required Dio dio,
    dynamic body,
    required Function(Map<String, dynamic>) asModel,
  }) async {
    try {
      dio.options.headers['x-access-token'] =
          Get.find<GlobalController>().accessToken.value;

      Response<Map<String, dynamic>> response = await dio.put(url, data: body);

      CustomLog.log(response.data);

      if (response.statusCode == 200) {
        if (response.data!['message']) {
          return asModel(response.data!);
        }
      } else if (response.statusCode == 403) {
        Get.find<GlobalController>().refreshToken();
        return null;
      }

      return null;
    } on DioError catch (e) {
      CustomLog.log(e);
      return null;
    } catch (e) {
      CustomLog.log(e);
      return null;
    }
  }

  static Future<T?> pathMethods<T>({
    required String url,
    required Dio dio,
    dynamic body,
    required Function(Map<String, dynamic>) asModel,
  }) async {
    try {
      dio.options.headers['x-access-token'] =
          Get.find<GlobalController>().accessToken.value;

      Response<Map<String, dynamic>> response =
          await dio.patch(url, data: body);

      CustomLog.log(response);

      if (response.statusCode == 200) {
        if (response.data!['message'] == "success") {
          return asModel(response.data!);
        }
      } else if (response.statusCode == 403) {
        Get.find<GlobalController>().refreshToken();
        return null;
      }

      return null;
    } on DioError catch (e) {
      CustomLog.log(e);
      return null;
    } catch (e) {
      CustomLog.log(e);
      return null;
    }
  }

  static Future<T?> deleteMethod<T>({
    required String url,
    required Dio dio,
    Map<String, dynamic>? body,
    required Function(Map<String, dynamic>) asModel,
  }) async {
    try {
      dio.options.headers['x-access-token'] =
          Get.find<GlobalController>().accessToken.value;

      Response<Map<String, dynamic>> response = await dio.delete(
        url,
        data: body,
      );

      // CustomLog.log(response.data);

      if (response.statusCode == 200) {
        if (response.data!['message']) {
          return asModel(response.data!);
        }
      }

      return null;
    } on DioError catch (e) {
      CustomLog.log(e);
      return null;
    } catch (e) {
      CustomLog.log(e);
      return null;
    }
  }

  static Future<bool> getAndSaveToken(String tokenFireBase) async {
    try {
      Dio dio = Dio(options);

      Response response = await dio.post('$_baseUrl/api/auth/verify',
          options:
              Options(headers: {'Authorization': 'Bearer $tokenFireBase'}));
      if (response.statusCode == 200) {
        UserInformation info = UserInformation.fromJson(response.data['data']);
        info.firebaseToken = tokenFireBase;
        UserPref().setUser(info);
        Get.find<GlobalController>().setToken(tokenFireBase);
      }
      return true;
    } on DioError catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (e.response != null) {
        CustomLog.log('Dio error!');
        CustomLog.log('STATUS: ${e.response?.statusCode}');
        CustomLog.log('DATA: ${e.response?.data}');
        CustomLog.log('HEADERS: ${e.response?.headers}');
      } else {
        // Error due to setting up or sending the request
        CustomLog.log('Error sending request!');
        CustomLog.log(e.message);
      }
      return false;
    }
  }

  static Future loginAsAnonymous({required Function(bool) callback}) async {
    Dio dio = Dio(options);

    await getData(
      url: ApiURL.getAnonymousToken,
      dio: dio,
      asModel: (map) async {
        if (map['success']) {
          await getAndSaveToken("");
          callback(true);
        }
      },
    );

    return callback(true);
  }

  static Future<List<BannerModel>> getBanners() async {
    Dio dio = Dio(options);

    List<BannerModel> listBanner = [];
    await getData<List<BannerModel>>(
      url: ApiURL.bannerUrl,
      dio: dio,
      asModel: (map) {
        final responseList = map as List;
        listBanner = responseList.map((e) => BannerModel.fromJson(e)).toList();
      },
    );

    return listBanner;
  }

  static Future<List<NovelResponseModel>> getArrivals() async {
    Dio dio = Dio(options);

    List<NovelResponseModel> listArrivals = [];
    await getData<List<NovelResponseModel>>(
      url: ApiURL.arrivalUrl,
      dio: dio,
      // nextPage: nextPage,
      asModel: (map) {
        final responseList = map as List;
        listArrivals =
            responseList.map((e) => NovelResponseModel.fromJson(e)).toList();
      },
    );

    return listArrivals;
  }

  static Future<List<NovelResponseModel>> getHotNovels() async {
    Dio dio = Dio(options);

    List<NovelResponseModel> listArrivals = [];
    await getData<List<NovelResponseModel>>(
      url: ApiURL.hotNovelUrl,
      dio: dio,
      // nextPage: nextPage,
      asModel: (map) {
        final responseList = map as List;
        listArrivals =
            responseList.map((e) => NovelResponseModel.fromJson(e)).toList();
      },
    );

    return listArrivals;
  }

  static Future<NovelResponseModel> getTopNovel() async {
    Dio dio = Dio(options);
    NovelResponseModel top = NovelResponseModel();
    List<NovelResponseModel> listTop = [];

    await getData<NovelResponseModel>(
      url: ApiURL.topNovelUrl,
      dio: dio,
      // nextPage: nextPage,
      asModel: (map) {
        final responseList = map as List;
        listTop =
            responseList.map((e) => NovelResponseModel.fromJson(e)).toList();
        top = listTop[0];
      },
    );
    return top;
  }

  static Future<List<NovelResponseModel>> getTopCommentNovel(int page,
      {required Function(bool) isNextPage}) async {
    Dio dio = Dio(options);
    List<NovelResponseModel> listTopComment = [];
    await getData<List<NovelResponseModel>>(
      url: ApiURL.topNovelUrl,
      dio: dio,
      query: {'page': page},
      metaCallback: (meta) {
        if (meta == null) return;
        isNextPage(meta.hasNextPage ?? false);
      },
      asModel: (map) {
        final responseList = map as List;
        listTopComment =
            responseList.map((e) => NovelResponseModel.fromJson(e)).toList();
      },
    );
    return listTopComment;
  }

  static Future<List<CategoriesNovelModel>> getCategories() async {
    Dio dio = Dio(options);

    List<CategoriesNovelModel> categories = [];

    await getData<CategoriesNovelModel>(
      url: '${ApiURL.categoriesUrl}?page=1&limit=100',
      dio: dio,
      // nextPage: nextPage,
      asModel: (map) {
        final responseList = map as List;
        categories =
            responseList.map((e) => CategoriesNovelModel.fromJson(e)).toList();
      },
    );
    return categories;
  }

  static Future<List<NovelResponseModel>> getNovelInCate(String idCate) async {
    Dio dio = Dio(options);

    List<NovelResponseModel> categories = [];

    await getData<NovelResponseModel>(
      url: '${ApiURL.novelInCateUrl}$idCate/book?page=1&limit=1000',
      dio: dio,
      metaCallback: (meta) {},
      asModel: (map) {
        final responseList = map as List;
        categories =
            responseList.map((e) => NovelResponseModel.fromJson(e)).toList();
      },
    );
    return categories;
  }

  //TODO: BookMark
  static Future<List<NovelResponseModel>> getListBookMark() async {
    Dio dio = Dio(options);
    List<NovelResponseModel> listBookMark = [];
    await getData<List<NovelResponseModel>>(
      url: ApiURL.bookMarkUrl,
      dio: dio,
      metaCallback: (meta) {},
      asModel: (map) {
        final responseList = map as List;
        listBookMark =
            responseList.map((e) => NovelResponseModel.fromJson(e)).toList();
      },
    );
    return listBookMark;
  }

  //TODO: Book Details
  static Future<ReadingStateModel?> getReadingState(String bookId) async {
    if (Get.find<GlobalController>().accessToken.value == "") {
      return null;
    }
    Dio dio = Dio(options);
    dio.options.headers['Authorization'] =
        "Bearer ${Get.find<GlobalController>().accessToken.value}";
    ReadingStateModel? top = ReadingStateModel();
    await getData<ReadingStateModel?>(
      url: '${ApiURL.readingStateUrl}$bookId',
      dio: dio,
      // nextPage: nextPage,
      asModel: (map) {
        CustomLog.log(map);
        if (map == null) return;
        top = ReadingStateModel.fromJson(map);
      },
    );
    return top;
  }

  static Future<NovelResponseModel?> getNovelDetails(String id) async {
    Dio dio = Dio(options);
    NovelResponseModel? top;
    await getData<NovelResponseModel>(
      url: '${ApiURL.novelDetailsUrl}$id',
      dio: dio,
      // nextPage: nextPage,
      asModel: (map) {
        if (map == null) return;
        top = NovelResponseModel.fromJson(map);
      },
    );
    return top;
  }

  static Future<List<CommentModel>> getNovelComments(
    String id,
    int page,
    int limit,
  ) async {
    Dio dio = Dio(options);
    List<CommentModel> listComment = [];
    await getData<List<CommentModel>>(
      url:
          '${ApiURL.novelDetailsUrl}$id${ApiURL.commentsNovelUrl}?page=$page&limit=$limit',
      dio: dio,
      // nextPage: nextPage,
      asModel: (map) {
        final responseList = map as List;
        listComment =
            responseList.map((e) => CommentModel.fromJson(e)).toList();
      },
    );
    return listComment;
  }

  static Future<bool> postComment({
    String? bookId,
    required String content,
    String? chapterId,
  }) async {
    Dio dio = Dio(options);
    Map<String, String> body =
        bookId == null ? {'chapterId': chapterId!} : {'bookId': bookId};
    body.addAll({'content': content});
    bool? success = await postMethods<bool?>(
      url: ApiURL.postCommentUrl,
      dio: dio,
      body: body,
      // nextPage: nextPage,
      asModel: (map) {
        return ResponseTempModel.fromJson(map).message == "success";
      },
    );
    return success ?? false;
  }

  //Up viewed chapter
  static Future<bool> upViewed({
    required String bookId,
    required String chapterId,
  }) async {
    Dio dio = Dio(options);
    Map<String, String> body = {'chapterId': chapterId, 'bookId': bookId};
    bool? success = await postMethods<bool?>(
      url: ApiURL.logViewUrls,
      dio: dio,
      body: body,
      // nextPage: nextPage,
      asModel: (map) {
        return ResponseTempModel.fromJson(map).message == "success";
      },
    );
    return success ?? false;
  }

  static Future<List<CommentModel>> getChapterComment(
      String chapterId, int page, int limit) async {
    Dio dio = Dio(options);
    List<CommentModel> listComments = [];
    await getData<List<CommentModel>>(
      url:
          "${ApiURL.chapterDetailsUrl}$chapterId${ApiURL.commentsNovelUrl}?page=$page&limit=$limit",
      dio: dio,
      // nextPage: nextPage,
      asModel: (map) {
        final responseList = map as List;
        listComments =
            responseList.map((e) => CommentModel.fromJson(e)).toList();
      },
    );
    return listComments;
  }

  static Future<ChapterModel?> getChapterDetails(String id) async {
    Dio dio = Dio(options);
    ChapterModel? top;
    await getData<ChapterModel>(
      url: '${ApiURL.chapterDetailsUrl}$id',
      dio: dio,
      // nextPage: nextPage,
      asModel: (map) {
        if (map == null) return;
        top = ChapterModel.fromJson(map);
      },
    );
    return top;
  }

  static Future<ChapterModel?> getContentChapterByNumber(
      int number, String bookId) async {
    Dio dio = Dio(options);
    ChapterModel? chapter;
    await getData<ChapterModel>(
      url: '/api/book/id/$bookId/chapter/$number',
      dio: dio,
      // nextPage: nextPage,
      asModel: (map) {
        if (map == null) return;
        chapter = ChapterModel.fromJson(map);
      },
    );
    return chapter;
  }

  static Future<List<ListChapModel>> getListChapter(String id, int page,
      {int? limit = 10, required Function(bool) nextPage}) async {
    Dio dio = Dio(options);
    List<ListChapModel> chapters = [];
    await getData<List<ListChapModel>>(
      url: ApiURL.listChapterUrl,
      dio: dio,
      query: {
        'page': page,
        'limit': limit == null ? '10' : '$limit',
        'bookId': id
      },
      metaCallback: (meta) {
        if (meta == null) return;
        nextPage(meta.hasNextPage ?? false);
      },
      asModel: (map) {
        final responseList = map as List;
        chapters = responseList.map((e) => ListChapModel.fromJson(e)).toList();
      },
    );
    return chapters;
  }

  static Future<UserInformation?> getUserInformation() async {
    Dio dio = Dio(options);
    dio.options.headers['Authorization'] =
        "Bearer ${Get.find<GlobalController>().accessToken.value}";
    UserInformation? info;
    await getData<UserInformation>(
      url: ApiURL.userInfoUrl,
      dio: dio,
      asModel: (map) {
        info = UserInformation.fromJson(map);
      },
    );
    return info;
  }

  static Future<List<GridNovelModel>> getGridNovel(String url, int page,
      {required Function(bool) nextPage}) async {
    Dio dio = Dio(options);

    List<GridNovelModel> books = [];
    await getData<List<GridNovelModel>>(
      url: url,
      dio: dio,
      query: {
        'page': page,
        'limit': '10',
      },
      metaCallback: (meta) {
        if (meta == null) return;
        nextPage(meta.hasNextPage ?? false);
      },
      asModel: (map) {
        final responseList = map as List;
        books = responseList.map((e) => GridNovelModel.fromJson(e)).toList();
      },
    );
    return books;
  }

  static Future updateAvatar(File file) async {
    Dio dio = Dio(options);
    var dataForm = FormData.fromMap({});

    dataForm.files.addAll([
      MapEntry(
          "images",
          await MultipartFile.fromFile(file.path,
              filename: file.path.split('/').last))
    ]);
    await pathMethods(
        url: ApiURL.updateAvatarUrl,
        dio: dio,
        body: dataForm,
        asModel: (map) {});
  }

  static Future updateUserName(String name) async {
    Dio dio = Dio(options);
    await pathMethods(
        url: ApiURL.updateInfoUrl,
        dio: dio,
        body: {'displayName': name},
        asModel: (map) {
          return map;
        });
  }

  static Future<List<NovelResponseModel>> getNovelInSearch(
      {required Function(bool) hasNextPage,
      required String text,
      required int page}) async {
    Dio dio = Dio(options);
    List<NovelResponseModel> list = [];
    await getData(
        url: "/api/book/search/$text?limit=10",
        dio: dio,
        query: {'page': page},
        metaCallback: (meta) {
          if (meta == null) return;
          hasNextPage(meta.hasNextPage ?? false);
        },
        asModel: (map) {
          final responseList = map as List;
          list =
              responseList.map((e) => NovelResponseModel.fromJson(e)).toList();
        });
    return list;
  }

  static Future<List<NotificationModel>> getAllNoti(
      {required Function(bool) hasNextPage, required int page}) async {
    Dio dio = Dio(options);
    List<NotificationModel> list = [];
    await getData(
        url: "/api/notification",
        dio: dio,
        query: {'page': page},
        metaCallback: (meta) {
          if (meta == null) return;
          hasNextPage(meta.hasNextPage ?? false);
        },
        asModel: (map) {
          final responseList = map as List;
          list =
              responseList.map((e) => NotificationModel.fromJson(e)).toList();
        });
    return list;
  }

  static Future<Map<String, dynamic>?> setReadingState(
      ReadingStateModel body) async {
    Dio dio = Dio(options);
    Map<String, dynamic>? readingStateModel;
    print(body);
    await postMethods<Map<String, dynamic>?>(
      url: ApiURL.postReadingStateUrl,
      dio: dio,
      body: body.toJson(),
      asModel: (map) {
        readingStateModel = map;
        return;
      },
    );
    return readingStateModel;
  }

  static Future<Map<String, dynamic>> getLastReading() async {
    Dio dio = Dio(options);
    Map<String, dynamic> data = {};
    await getData<Map<String, dynamic>>(
        url: ApiURL.lastReadingUrl,
        dio: dio,
        asModel: (map) {
          return data = map;
        });
    return data;
  }

  static Future<List<NovelResponseModel>> getTopNovelSearch() async {
    Dio dio = Dio(options);
    List<NovelResponseModel> data = [];
    await getData<List<NovelResponseModel>>(
        url: ApiURL.topBookSearchUrl,
        dio: dio,
        asModel: (map) {
          var listResponse = map as List;
          return data =
              listResponse.map((e) => NovelResponseModel.fromJson(e)).toList();
        });
    return data;
  }

  static Future logSearch(String bookId) async {
    Dio dio = Dio(options);
    await postMethods(
        url: '${ApiURL.logSearchUrl}$bookId', dio: dio, asModel: (map) {});
  }

  static Future<AppSettingModel?> getSetting() async {
    Dio dio = Dio(options);
    AppSettingModel? settingModel;
    await getData<AppSettingModel>(
        url: ApiURL.userSetting,
        dio: dio,
        asModel: (map) {
          return settingModel = AppSettingModel.fromJson(map['app']);
        });
    return settingModel;
  }

  static Future saveSetting(Map<String, dynamic> data) async {
    Dio dio = Dio(options);
    await postMethods(
        url: ApiURL.userSetting,
        dio: dio,
        body: data,
        asModel: (map) {
          return data = map;
        });
  }
}
