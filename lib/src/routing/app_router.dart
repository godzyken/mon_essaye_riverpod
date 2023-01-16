import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mon_essaye_riverpod/src/features/authentication/data/auth_repository.dart';
import 'package:mon_essaye_riverpod/src/features/authentication/presentation/auth/views/auth_screen.dart';
import 'package:mon_essaye_riverpod/src/features/authentication/presentation/sign_in/views/sign_in_screen.dart';
import 'package:mon_essaye_riverpod/src/features/onboarding/data/onboarding_repository.dart';
import 'package:mon_essaye_riverpod/src/features/onboarding/presentation/views/onboarding_screen.dart';
import 'package:mon_essaye_riverpod/src/routing/go_router_refresh_stream.dart';

import '../features/authentication/presentation/email_password/utils/email_password_sign_in_form_type.dart';
import '../features/authentication/presentation/email_password/views/email_password_sign_in_screen.dart';
import '../features/entries/presentation/views/entries_screen.dart';
import '../features/jobs/domain/entry.dart';
import '../features/jobs/domain/job.dart';
import '../features/jobs/presentation/edit_job_screen/views/edit_job_screen.dart';
import '../features/jobs/presentation/entry_screen/views/entry_screen.dart';
import '../features/jobs/presentation/job_entries_screen/views/job_entries_screen.dart';
import '../features/jobs/presentation/jobs_screen/views/jobs_screen.dart';
import '../utils/scaffold_with_bottom_nav_bar.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

enum AppRoute {
  onboarding,
  signIn,
  emailPassword,
  account,
  jobs,
  entries,
  job,
  addJob,
  editJob,
  addEntry,
  entry,
}

final goRouterProvider = Provider<GoRouter>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  final onboardingRepository = ref.watch(onboardingRepositoryProvider);

  return GoRouter(
      initialLocation: '/sign-in',
      navigatorKey: _rootNavigatorKey,
      debugLogDiagnostics: true,
      redirect: (context, state) {
        final didCompleteOnboarding =
            onboardingRepository.isOnboardingComplete();
        if (!didCompleteOnboarding) {
          if (state.subloc != '/onboarding') {
            return '/onboarding';
          }
        }
        final isLoggedIn = authRepository.currentUser != null;
        if (isLoggedIn) {
          if (state.subloc.startsWith('signIn')) {
            return '/account';
          }
        } else {
          if (state.subloc.startsWith('/users') ||
              state.subloc.startsWith('/entries') ||
              state.subloc.startsWith('/account')) {
            return '/signIn';
          }
        }
        return null;
      },
      refreshListenable:
          GoRouterRefreshStream(authRepository.authStateChanges()),
      routes: [
        GoRoute(
            path: '/onboarding',
            name: AppRoute.onboarding.name,
            pageBuilder: (context, state) => NoTransitionPage(
                key: state.pageKey, child: const OnboardingScreen())),
        GoRoute(
            path: '/sign-in',
            name: AppRoute.signIn.name,
            pageBuilder: (context, state) => NoTransitionPage(
                key: state.pageKey, child: const SignInScreen()),
            routes: [
              GoRoute(
                  path: 'emailPassword',
                  name: AppRoute.emailPassword.name,
                  pageBuilder: (context, state) => MaterialPage(
                      key: state.pageKey,
                      fullscreenDialog: true,
                      child: const EmailPasswordSignInScreen(
                          formType: EmailPasswordSignInFormType.signIn))),
            ]),
        ShellRoute(
            navigatorKey: _shellNavigatorKey,
            builder: (context, state, child) {
              return ScaffoldWithBottomNavBar(child: child);
            },
            routes: [
              GoRoute(
                  path: '/jobs',
                  name: AppRoute.jobs.name,
                  pageBuilder: (context, state) => NoTransitionPage(
                        key: state.pageKey,
                        child: const JobsScreen(),
                      ),
                  routes: [
                    GoRoute(
                      path: 'add',
                      name: AppRoute.addJob.name,
                      parentNavigatorKey: _rootNavigatorKey,
                      pageBuilder: (context, state) {
                        return MaterialPage(
                          key: state.pageKey,
                          fullscreenDialog: true,
                          child: const EditJobScreen(),
                        );
                      },
                    ),
                    GoRoute(
                        path: ':id',
                        name: AppRoute.job.name,
                        pageBuilder: (context, state) {
                          final id = state.params['id']!;
                          return MaterialPage(
                            key: state.pageKey,
                            child: JobEntriesScreen(jobId: id),
                          );
                        },
                        routes: [
                          GoRoute(
                            path: 'entries/add',
                            name: AppRoute.addEntry.name,
                            parentNavigatorKey: _rootNavigatorKey,
                            pageBuilder: (context, state) {
                              final jobId = state.params['id']!;
                              return MaterialPage(
                                key: state.pageKey,
                                fullscreenDialog: true,
                                child: EntryScreen(
                                  jobId: jobId,
                                ),
                              );
                            },
                          ),
                          GoRoute(
                            path: 'entries/:eid',
                            name: AppRoute.entry.name,
                            pageBuilder: (context, state) {
                              final jobId = state.params['id']!;
                              final entryId = state.params['eid']!;
                              final entry = state.extra as Entry?;
                              return MaterialPage(
                                key: state.pageKey,
                                child: EntryScreen(
                                  jobId: jobId,
                                  entryId: entryId,
                                  entry: entry,
                                ),
                              );
                            },
                          ),
                          GoRoute(
                            path: 'edit',
                            name: AppRoute.editJob.name,
                            pageBuilder: (context, state) {
                              final jobId = state.params['id'];
                              final job = state.extra as Job?;
                              return MaterialPage(
                                key: state.pageKey,
                                fullscreenDialog: true,
                                child: EditJobScreen(jobId: jobId, job: job),
                              );
                            },
                          ),
                        ]),
                  ]),
              GoRoute(
                path: '/entries',
                name: AppRoute.entries.name,
                pageBuilder: (context, state) => NoTransitionPage(
                  key: state.pageKey,
                  child: const EntriesScreen(),
                ),
              ),
              GoRoute(
                  path: '/account',
                  name: AppRoute.account.name,
                  pageBuilder: (context, state) => NoTransitionPage(
                      key: state.pageKey, child: const AuthScreen()))
            ])
      ]);
});
