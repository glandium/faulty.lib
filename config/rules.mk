ifdef LIBRARY_NAME
LIBRARY = lib$(LIBRARY_NAME).a
TARGETS = $(LIBRARY)
else
ifdef SIMPLE_PROGRAMS
TARGETS = $(SIMPLE_PROGRAMS)
endif
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
