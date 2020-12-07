IF(NOT $ENV{PM_PACKAGES_ROOT} EQUAL "")
	SET(CMAKE_SYSTEM_NAME Linux)

	INCLUDE(CMakeForceCompiler)

	SET(LINUX_ROOT "$ENV{LINUX_MULTIARCH_ROOT}/../v17_clang-10.0.1-centos7/x86_64-unknown-linux-gnu")
	STRING(REGEX REPLACE "\\\\" "/" LINUX_ROOT ${LINUX_ROOT})

	message (STATUS "LINUX_ROOT is '${LINUX_ROOT}'")
	SET(ARCHITECTURE_TRIPLE x86_64-unknown-linux-gnu)

	SET(CMAKE_CROSSCOMPILING TRUE)
	SET(CMAKE_SYSTEM_NAME Linux)
	SET(CMAKE_SYSTEM_VERSION 1)

	# sysroot
	SET(CMAKE_SYSROOT ${LINUX_ROOT})

	SET(CMAKE_LIBRARY_ARCHITECTURE ${ARCHITECTURE_TRIPLE})

	# specify the cross compiler
	CMAKE_FORCE_C_COMPILER ("${CMAKE_SYSROOT}/bin/clang.exe" Clang)	
	SET(CMAKE_C_COMPILER   ${CMAKE_SYSROOT}/bin/clang.exe)
	SET(CMAKE_C_COMPILER_TARGET ${ARCHITECTURE_TRIPLE})
	SET(CMAKE_C_FLAGS   "-target ${ARCHITECTURE_TRIPLE}  --sysroot ${LINUX_ROOT} ")

	CMAKE_FORCE_CXX_COMPILER ("${CMAKE_SYSROOT}/bin/clang++.exe" Clang)
	SET(CMAKE_CXX_COMPILER   ${CMAKE_SYSROOT}/bin/clang++.exe)
	SET(CMAKE_CXX_COMPILER_TARGET ${ARCHITECTURE_TRIPLE})
	SET(CMAKE_CXX_FLAGS   "-target ${ARCHITECTURE_TRIPLE} --sysroot ${LINUX_ROOT} ")

	SET(CMAKE_FIND_ROOT_PATH  ${LINUX_ROOT})
	#set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM ONLY)	# hoping to force it to use ar
	#set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
	#set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)
	
	SET(CMAKE_MAKE_PROGRAM "$ENV{PM_PACKAGES_ROOT}/MinGW/0.6.2/bin/mingw32-make.exe")

	# unreal custom libc++ stuff
	SET(CMAKE_CXX_FLAGS "-I $ENV{BRICKADIA_UNREAL_DIR}Engine/Source/ThirdParty/Linux/LibCxx/include -I $ENV{BRICKADIA_UNREAL_DIR}Engine/Source/ThirdParty/Linux/LibCxx/include/c++/v1")
	SET(UE_LINKER_FLAGS "-stdlib=libc++ -nodefaultlibs -Wl,--build-id -L $ENV{BRICKADIA_UNREAL_DIR}Engine/Source/ThirdParty/Linux/LibCxx/lib/Linux/x86_64-unknown-linux-gnu/ $ENV{BRICKADIA_UNREAL_DIR}Engine/Source/ThirdParty/Linux/LibCxx/lib/Linux/x86_64-unknown-linux-gnu/libc++.a $ENV{BRICKADIA_UNREAL_DIR}Engine/Source/ThirdParty/Linux/LibCxx/lib/Linux/x86_64-unknown-linux-gnu/libc++abi.a -lm -lc -lgcc_s")
	SET(CMAKE_EXE_LINKER_FLAGS ${UE_LINKER_FLAGS})
	SET(CAMKE_MODULE_LINKER_FLAGS ${UE_LINKER_FLAGS})
	SET(CMAKE_SHARED_LINKER_FLAGS ${UE_LINKER_FLAGS})
ELSE()
	MESSAGE("PM_PACKAGES_ROOT  variable not defined!")
ENDIF()


