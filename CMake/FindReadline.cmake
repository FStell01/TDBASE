if (APPLE)
  find_path(READLINE_INCLUDE_DIR readline/readline.h /opt/homebrew/opt/readline/include /usr/local/opt/readline/include /opt/local/include /opt/include /usr/local/include /usr/include NO_DEFAULT_PATH)
endif()
find_path(READLINE_INCLUDE_DIR readline/readline.h)

if (APPLE)
  find_library(READLINE_LIBRARY readline /opt/homebrew/opt/readline/lib /usr/local/opt/readline/lib /opt/local/lib /opt/lib /usr/local/lib /usr/lib NO_DEFAULT_PATH)
endif()
find_library(READLINE_LIBRARY readline)

if (READLINE_INCLUDE_DIR AND READLINE_LIBRARY AND NOT GNU_READLINE_FOUND)
  set(CMAKE_REQUIRED_INCLUDES "${READLINE_INCLUDE_DIR}")
  set(CMAKE_REQUIRED_LIBRARIES "${READLINE_LIBRARY}")
  include(CheckCXXSourceCompiles)
  unset(GNU_READLINE_FOUND CACHE)
  check_cxx_source_compiles("#include <stdio.h>\n#include <readline/readline.h>\nint main() { rl_replace_line(\"\", 0); }" GNU_READLINE_FOUND)
  if (NOT GNU_READLINE_FOUND)
    unset(READLINE_INCLUDE_DIR CACHE)
    unset(READLINE_LIBRARY CACHE)
  endif()
endif()

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(Readline DEFAULT_MSG READLINE_INCLUDE_DIR READLINE_LIBRARY)
mark_as_advanced(READLINE_INCLUDE_DIR READLINE_LIBRARY)
