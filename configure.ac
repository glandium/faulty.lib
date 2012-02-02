#                                               -*- Autoconf -*-
# Process this file with autoconf to produce a configure script.

AC_PREREQ([2.68])
AC_INIT(faulty.lib, 0.0.1)
AC_CONFIG_SRCDIR([linker/ElfLoader.h])
AC_CONFIG_HEADERS([config.h])
AC_PROG_CXX

LDFLAGS=-ldl
AC_CHECK_FUNCS([dladdr])
AC_CONFIG_FILES([linker/Makefile
                 tests/Makefile
                 Makefile
                 config/autoconf.mk])
AC_OUTPUT
sed -i 's,^DEPTH\t\t= ../..,DEPTH\t\t= ..,' linker/Makefile tests/Makefile
