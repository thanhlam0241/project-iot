import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mobilemanager/pages/home/home-page.dart';
import 'package:mobilemanager/pages/login/login-page.dart';
import 'package:mobilemanager/pages/machine-detail/machine-detail.dart';
import 'package:mobilemanager/pages/machine-qr-scan/machine-qr-scan.dart';

final class RouteUrls {
  static const MACHINE_URL = '/machine';
  static const LOGIN_URL = '/login';
  static const MACHINE_DETAIL_URL = '/machine/detail/:id';
  static const MACHINE_QR_SCAN_URL = '/machine/scanner';
}

final routes = GoRouter(
    routes: <RouteBase>[
        GoRoute(
            path: '/',
            builder: (context, state) => const HomePage(title: 'Quản lý máy chấm công'),
        ),
        GoRoute(
            path: RouteUrls.LOGIN_URL,
            builder: (context, state) => LoginPage(),
        ),
        GoRoute(
            path: RouteUrls.MACHINE_URL,
            builder: (context, state) => const HomePage(title: 'Quản lý máy chấm công'),
        ),
        GoRoute(
            path: RouteUrls.MACHINE_DETAIL_URL,
            builder: (context, state) {
              var machineId = state.pathParameters['id'];
              return MachineDetail(machineId: machineId ?? '',);
            }
        ),
        GoRoute(
            path: RouteUrls.MACHINE_QR_SCAN_URL,
            builder: (context, state) => const MachineQrScan(),
        )
    ]
);