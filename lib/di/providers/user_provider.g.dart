// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$mainKeyHash() => r'68cf1019b8bfc61f8019017f7eb41549f059696f';

/// See also [mainKey].
@ProviderFor(mainKey)
final mainKeyProvider = Provider<GlobalKey<NavigatorState>>.internal(
  mainKey,
  name: r'mainKeyProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$mainKeyHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef MainKeyRef = ProviderRef<GlobalKey<NavigatorState>>;
String _$userHash() => r'859c06c713736c760e46e8b1d8b97ce56e54d186';

/// See also [user].
@ProviderFor(user)
final userProvider = AutoDisposeProvider<UserRepositoryImpl>.internal(
  user,
  name: r'userProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$userHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef UserRef = AutoDisposeProviderRef<UserRepositoryImpl>;
String _$getUsersHash() => r'dd92dd28d3d58b9928594de6a4f6879f1b0af35b';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// See also [getUsers].
@ProviderFor(getUsers)
const getUsersProvider = GetUsersFamily();

/// See also [getUsers].
class GetUsersFamily extends Family<AsyncValue<List<UserDetailResponse>>> {
  /// See also [getUsers].
  const GetUsersFamily();

  /// See also [getUsers].
  GetUsersProvider call(
    WidgetRef widgetRef,
  ) {
    return GetUsersProvider(
      widgetRef,
    );
  }

  @override
  GetUsersProvider getProviderOverride(
    covariant GetUsersProvider provider,
  ) {
    return call(
      provider.widgetRef,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'getUsersProvider';
}

/// See also [getUsers].
class GetUsersProvider
    extends AutoDisposeFutureProvider<List<UserDetailResponse>> {
  /// See also [getUsers].
  GetUsersProvider(
    WidgetRef widgetRef,
  ) : this._internal(
          (ref) => getUsers(
            ref as GetUsersRef,
            widgetRef,
          ),
          from: getUsersProvider,
          name: r'getUsersProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getUsersHash,
          dependencies: GetUsersFamily._dependencies,
          allTransitiveDependencies: GetUsersFamily._allTransitiveDependencies,
          widgetRef: widgetRef,
        );

  GetUsersProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.widgetRef,
  }) : super.internal();

  final WidgetRef widgetRef;

  @override
  Override overrideWith(
    FutureOr<List<UserDetailResponse>> Function(GetUsersRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: GetUsersProvider._internal(
        (ref) => create(ref as GetUsersRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        widgetRef: widgetRef,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<UserDetailResponse>> createElement() {
    return _GetUsersProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GetUsersProvider && other.widgetRef == widgetRef;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, widgetRef.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin GetUsersRef on AutoDisposeFutureProviderRef<List<UserDetailResponse>> {
  /// The parameter `widgetRef` of this provider.
  WidgetRef get widgetRef;
}

class _GetUsersProviderElement
    extends AutoDisposeFutureProviderElement<List<UserDetailResponse>>
    with GetUsersRef {
  _GetUsersProviderElement(super.provider);

  @override
  WidgetRef get widgetRef => (origin as GetUsersProvider).widgetRef;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
