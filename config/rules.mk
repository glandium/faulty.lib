VPATH := $(foreach path,$(VPATH),$(path:%/mfbt=%/mozilla))

ifdef LIBRARY_NAME
LIBRARY = lib$(LIBRARY_NAME).a
TARGETS = $(LIBRARY)
else
ifdef SIMPLE_PROGRAMS
TARGETS = $(SIMPLE_PROGRAMS)
endif
endif
ifdef HOST_PROGRAM
TARGETS += $(HOST_PROGRAM)
endif

OBJS = $(CPPSRCS:.cpp=.o)
EXPAND_LIBNAME_PATH = $(foreach lib,$(1),$(2)/lib$(lib).a)

build: $(TARGETS)

clean:
	rm -f $(TARGETS) $(OBJS)

$(SIMPLE_PROGRAMS): %: %.o $(LIBS)
	$(CXX) -o $@ $^ $(LDFLAGS) $(LIBS) $(EXTRA_LIBS)

$(LIBRARY): $(OBJS)
	$(AR) cr $@ $^
	$(RANLIB) $@

$(OBJS): %.o: %.cpp
	$(CXX) $(CXXFLAGS) -include $(DEPTH)/config.h $(LOCAL_INCLUDES) -I$(topsrcdir) -o $@ -c $<

# HOST doesn't mean the same as in configure.ac. Here, it means "build".
# This is due to the makefiles coming from a system using configure 2.13.
HOSTOBJS = $(HOST_CPPSRCS:%.cpp=host_%.o)

$(HOST_PROGRAM): $(HOSTOBJS)
	$(BUILDCXX) -o $@ $^ $(BUILDLDFLAGS) $(HOST_LIBS)

$(HOSTOBJS): host_%.o: %.cpp
	$(BUILDCXX) $(BUILDCXXFLAGS) -I$(topsrcdir) -o $@ -c $<
