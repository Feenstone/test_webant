import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:test_webant/core/network/network_info.dart';
import 'package:http/http.dart' as http;

import 'features/gallery/data/datasources/webant_gallery_remote_datasource.dart';
import 'features/gallery/data/repositories/webant_gallery_repository_impl.dart';
import 'features/gallery/domain/repositories/webant_gallery_repository.dart';
import 'features/gallery/presentation/state_notifier/photos_notifier.dart';

final httpClientProvider = Provider((ref) => http.Client());
final remoteDataSourceProvider = Provider<WebantGalleryRemoteDataSource>(
    (ref) => WebantGalleryRemoteDataSourceImpl(
        client: ref.watch(httpClientProvider)));
final dataConnectionCheckerProvider = Provider((ref) => DataConnectionChecker());
final networkInfoProvider = Provider<NetworkInfo>((ref) => NetworkInfoImpl(ref.watch(dataConnectionCheckerProvider)));
final photoRepositoryProvider = Provider<WebantGalleryRepository>((ref) =>
    WebantGalleryRepositoryImpl(
        remoteDataSource: ref.watch(remoteDataSourceProvider),
        networkInfo: ref.watch(networkInfoProvider)));
final newPhotosNotifierProvider = StateNotifierProvider.autoDispose(
    (ref) => PhotosNotifier(ref.watch(photoRepositoryProvider), ref.watch(photoRepositoryProvider).getNewPhotos));
final popularPhotosNotifierProvider = StateNotifierProvider.autoDispose(
    (ref) => PhotosNotifier(ref.watch(photoRepositoryProvider), ref.watch(photoRepositoryProvider).getPopularPhotos));
