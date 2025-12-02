import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../features/auth/data/auth_repository.dart';
import '../../features/auth/presentation/screens/login_screen.dart';
import '../../features/auth/presentation/screens/register_screen.dart';
import '../../features/driver_dashboard/presentation/screens/driver_dashboard_screen.dart';
import '../../features/driver_dashboard/presentation/screens/qr_scanner_screen.dart';
import '../../features/driver_dashboard/presentation/screens/delivery_confirmation_screen.dart';
import '../../features/driver_registration/presentation/screens/driver_registration_screen.dart';
import '../../features/shipment/presentation/screens/create_shipment_screen.dart';
import '../../features/shipment/presentation/screens/customer_dashboard_screen.dart';
import '../../features/tracking/presentation/screens/tracking_screen.dart';

part 'app_router.g.dart';

@riverpod
GoRouter goRouter(GoRouterRef ref) {
  final authState = ref.watch(authStateProvider);

  return GoRouter(
    initialLocation: '/login',
    redirect: (context, state) {
      final isLoggedIn = authState.value != null;
      final isLoggingIn = state.uri.path == '/login' || state.uri.path == '/register';

      if (!isLoggedIn && !isLoggingIn) {
        return '/login';
      }

      if (isLoggedIn && isLoggingIn) {
        return '/home'; // TODO: Redirect based on role
      }

      return null;
    },
    routes: [
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/register',
        builder: (context, state) => const RegisterScreen(),
      ),
      GoRoute(
        path: '/home',
        builder: (context, state) => const CustomerDashboardScreen(),
      ),
      GoRoute(
        path: '/driver-registration',
        builder: (context, state) => const DriverRegistrationScreen(),
      ),
      GoRoute(
        path: '/create-shipment',
        builder: (context, state) => const CreateShipmentScreen(),
      ),
      GoRoute(
        path: '/tracking/:id',
        builder: (context, state) {
          final id = state.pathParameters['id']!;
          return TrackingScreen(shipmentId: id);
        },
      ),
      GoRoute(
        path: '/driver-dashboard',
        builder: (context, state) => const DriverDashboardScreen(),
      ),
      GoRoute(
        path: '/qr-scanner',
        builder: (context, state) => const QRScannerScreen(),
      ),
      GoRoute(
        path: '/delivery-confirmation/:id',
        builder: (context, state) {
          final id = state.pathParameters['id']!;
          return DeliveryConfirmationScreen(shipmentId: id);
        },
      ),
    ],
  );
}
