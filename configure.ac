#                                               -*- Autoconf -*-
# Process this file with autoconf to produce a configure script.

AC_PREREQ([2.68])
AC_INIT(faulty.lib, 0.0.1)
AC_CANONICAL_HOST
AC_CANONICAL_BUILD
AC_CONFIG_SRCDIR([linker/ElfLoader.h])
AC_CONFIG_HEADERS([config.h])
AC_PROG_CXX
AC_PROG_RANLIB
AC_LANG_CPLUSPLUS

if test -z "${BUILDCXX}"; then
  if test "${build}" = "${host}"; then
    BUILDCXX="${CXX}"
  elif test -n "${build_alias}"; then
    AC_CHECK_PROGS([BUILDCXX], [${build_alias}-g++])
  else
    AC_CHECK_PROGS([BUILDCXX], [g++])
  fi
fi
if test -z "${BUILDCXX}"; then
  AC_MSG_ERROR([C++ compiler for build not found.])
fi

case "$host" in
*-android*|*-linuxandroid*)
  AC_DEFINE([ANDROID], 1, Define to 1 when building for Android)
  LDFLAGS="${LDFLAGS} -llog"
  ;;
esac
LDFLAGS="${LDFLAGS} -ldl"
AC_CHECK_FUNCS([dladdr])
AC_CHECK_SIZEOF([void *])
if test "${ac_cv_sizeof_void_p}" = 8; then
  AC_DEFINE([HAVE_64BIT_OS], 1, Define to 1 when building for 64-bit OS)
elif test "${ac_cv_sizeof_void_p}" != 4; then
  AC_MSG_ERROR([Unsupported pointer size ${ac_cv_sizeof_void_p}])
fi

AC_CONFIG_FILES([linker/Makefile
                 tests/Makefile
                 mozilla/Makefile
                 Makefile
                 config/autoconf.mk])
AC_OUTPUT
sed -i 's,^DEPTH\t\t= ../..,DEPTH\t\t= ..,' linker/Makefile tests/Makefile mozilla/Makefile
