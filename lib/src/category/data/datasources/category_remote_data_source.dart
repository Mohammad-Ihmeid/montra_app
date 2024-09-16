import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:montra_app/core/enums/update_category.dart';
import 'package:montra_app/core/errors/exceptions.dart';
import 'package:montra_app/core/utils/datasource_utils.dart';
import 'package:montra_app/core/utils/typedef.dart';
import 'package:montra_app/src/category/data/model/category_model.dart';
import 'package:montra_app/src/category/domain/entities/category.dart';

abstract class CategoryRemoteDataSource {
  const CategoryRemoteDataSource();
  Future<List<CategoryModel>> getCategories(int type);

  Future<List<String>> getCategoriesIcon();

  Future<void> addCategory(Category category);

  Future<void> deleteCategory(String categoryId);

  Future<void> editCategory({
    required String categoryId,
    required UpdateCategoryAction action,
    dynamic categoryData,
  });
}

class CategoryRemoteDataSrcImp extends CategoryRemoteDataSource {
  CategoryRemoteDataSrcImp({
    required FirebaseFirestore firestore,
    required FirebaseStorage storage,
    required FirebaseAuth auth,
  })  : _firestore = firestore,
        _storage = storage,
        _auth = auth;

  final FirebaseFirestore _firestore;
  final FirebaseStorage _storage;
  final FirebaseAuth _auth;

  @override
  Future<void> addCategory(Category category) async {
    try {
      await DatasourceUtils.authorizeUser(_auth);

      final categoryRef = _firestore.collection('categories').doc();

      final categoryModel = category.toModel().copyWith(
            categoryId: categoryRef.id,
          );

      // final imageRef = _storage.ref().child(
      //       'categories/${categoryModel.categoryId}/profile_image/${categoryModel.desEn}-pfp',
      //     );

      // await imageRef.putFile(File(categoryModel.image)).then((value) async {
      //   final url = await value.ref.getDownloadURL();

      //   categoryModel = categoryModel.copyWith(image: url);
      // });

      await categoryRef.set(categoryModel.toMap());
    } on FirebaseException catch (e) {
      throw ServerException(
        message: e.message ?? 'Unknown error occurred',
        statusCode: e.code,
      );
    } on ServerException {
      rethrow;
    } catch (e) {
      throw ServerException(message: e.toString(), statusCode: '505');
    }
  }

  @override
  Future<List<CategoryModel>> getCategories(int type) async {
    try {
      await DatasourceUtils.authorizeUser(_auth);

      return _firestore
          .collection('categories')
          .where('Type', isEqualTo: type)
          .get()
          .then(
            (value) => value.docs
                .map((doc) => CategoryModel.fromMap(doc.data()))
                .toList(),
          );
    } on ServerException {
      rethrow;
    } catch (e) {
      throw ServerException(message: e.toString(), statusCode: '505');
    }
  }

  @override
  Future<List<String>> getCategoriesIcon() async {
    try {
      await DatasourceUtils.authorizeUser(_auth);

      final storageRef = _storage.ref().child('Categories');

      final result = await storageRef.listAll();

      List<String> urls = [];
      for (final fileRef in result.items) {
        final downloadURL = await fileRef.getDownloadURL();
        urls.add(downloadURL);
      }

      return urls;
    } on ServerException {
      rethrow;
    } catch (e) {
      throw ServerException(message: e.toString(), statusCode: '505');
    }
  }

  @override
  Future<void> deleteCategory(String categoryId) async {
    try {
      await DatasourceUtils.authorizeUser(_auth);

      await _firestore.collection('categories').doc(categoryId).delete();
    } on FirebaseException catch (e) {
      throw ServerException(
        message: e.message ?? 'Unknown error occurred',
        statusCode: e.code,
      );
    } on ServerException {
      rethrow;
    } catch (e) {
      throw ServerException(message: e.toString(), statusCode: '505');
    }
  }

  @override
  Future<void> editCategory({
    required String categoryId,
    required UpdateCategoryAction action,
    dynamic categoryData,
  }) async {
    try {
      await DatasourceUtils.authorizeUser(_auth);

      switch (action) {
        case UpdateCategoryAction.image:
          await _updateUserData(
            categoryId: categoryId,
            data: {'Image': categoryData as String},
          );
        case UpdateCategoryAction.color:
          await _updateUserData(
            categoryId: categoryId,
            data: {'Color': categoryData as String},
          );
        case UpdateCategoryAction.description:
          await _updateUserData(
            categoryId: categoryId,
            data: {'Description': categoryData as String},
          );
      }
    } on ServerException {
      rethrow;
    } catch (e) {
      throw ServerException(message: e.toString(), statusCode: '505');
    }
  }

  Future<void> _updateUserData({
    required String categoryId,
    required DataMap data,
  }) async {
    await _firestore.collection('categories').doc(categoryId).update(data);
  }
}
