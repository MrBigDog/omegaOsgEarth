# Add external project osgBullet
# Pro Trick here: we can't pass the string directly as a CMAKE_ARG in 
# ExternalProject_Add, because it would keep the double quotes, and we
# do not want them. Passing it as a variable removes the dobule quotes.
#set(BulletInstallType "Source And Build Tree")
#set(OsgInstallType "Source And Build Tree")

# The OSGWORKS_STATIC preprocessor definition tells osgBullet that
# we are using the static version of osgWorks.
if(WIN32)
    set(OSGEARTH_CXX_FLAGS "${CMAKE_CXX_FLAGS} /D\"OSGWORKS_STATIC\"")
else()
    set(OSGEARTH_CXX_FLAGS "${CMAKE_CXX_FLAGS} -DOSGWORKS_STATIC")
endif()
if(WIN32)
	ExternalProject_Add(
		osgearth
	    GIT_REPOSITORY https://github.com/gwaldron/osgearth.git
		CMAKE_GENERATOR ${OSGWORKS_GENERATOR}
		DEPENDS osg
		CMAKE_ARGS 
			-DCMAKE_SHARED_LINKER_FLAGS:STRING="${CMAKE_SHARED_LINKER_FLAGS} /NODEFAULTLIB:msvcprt.lib /NODEFAULTLIB:libcpmt.lib"
			-DCMAKE_LINKER_FLAGS:STRING="${CMAKE_LINKER_FLAGS} /NODEFAULTLIB:libcpmt.lib /NODEFAULTLIB:msvcprt.lib"
            -DCMAKE_CXX_FLAGS:STRING=${OSGEARTH_CXX_FLAGS}
			-DCMAKE_BUILD_TYPE:STRING=${CMAKE_BUILD_TYPE}
			-DCMAKE_RUNTIME_OUTPUT_DIRECTORY_DEBUG:PATH=${CMAKE_RUNTIME_OUTPUT_DIRECTORY_DEBUG}
			-DCMAKE_RUNTIME_OUTPUT_DIRECTORY_RELEASE:PATH=${CMAKE_RUNTIME_OUTPUT_DIRECTORY_RELEASE}

			-DOSGInstallType:STRING=${OsgInstallType}
            -DOSGSourceRoot:STRING=${CMAKE_BINARY_DIR}/modules/omegaOsg/osg-prefix/src/osg
            -DOSGBuildRoot:STRING=${CMAKE_BINARY_DIR}/modules/omegaOsg/osg-prefix/src/osg-build
			
			-DBUILD_SHARED_LIBS:BOOLEAN=false
            #-DOSGBULLET_BUILD_APPLICATIONS=OFF
            #-DOSGBULLET_BUILD_EXAMPLES=OFF
            #-DOSGBULLET_INSTALL_DATA=OFF
			#Bullet
            #-DBulletInstallType:STRING=${BulletInstallType}
            #-DBulletSourceRoot:PATH=${CMAKE_BINARY_DIR}/modules/omegaOsg/bullet-prefix/src/bullet
            #-DBulletBuildRoot:PATH=${CMAKE_BINARY_DIR}/src/bullet-prefix/src/bullet-build
			#osgWorks
            #-DosgWorks_DIR:PATH=${CMAKE_BINARY_DIR}/modules/omegaOsg/osgWorks-prefix/src/osgWorks-build/lib
			#osg
			-DOSG_INCLUDE_DIR:PATH=${OSG_INCLUDES}
			-DOSG_LIBRARY:PATH=${osg_LIBRARY}
			-DOSG_LIBRARY_DEBUG:PATH=${osg_LIBRARY_DEBUG}
			#osgGA
			-DOSGGA_INCLUDE_DIR:PATH=${OSG_INCLUDES}
			-DOSGGA_LIBRARY:PATH=${osgGA_LIBRARY}
			-DOSGGA_LIBRARY_DEBUG:PATH=${osgGA_LIBRARY_DEBUG}
			#osgText
			-DOSGTEXT_INCLUDE_DIR:PATH=${OSG_INCLUDES}
			-DOSGTEXT_LIBRARY:PATH=${osgText_LIBRARY}
			-DOSGTEXT_LIBRARY_DEBUG:PATH=${osgText_LIBRARY_DEBUG}
			#osgViewer
			-DOSGVIEWER_INCLUDE_DIR:PATH=${OSG_INCLUDES}
			-DOSGVIEWER_LIBRARY:PATH=${osgViewer_LIBRARY}
			-DOSGVIEWER_LIBRARY_DEBUG:PATH=${osgViewer_LIBRARY_DEBUG}
			#osgSim
			-DOSGSIM_INCLUDE_DIR:PATH=${OSG_INCLUDES}
			-DOSGSIM_LIBRARY:PATH=${osgSim_LIBRARY}
			-DOSGSIM_LIBRARY_DEBUG:PATH=${osgSim_LIBRARY_DEBUG}
			#osgDB
			-DOSGDB_INCLUDE_DIR:PATH=${OSG_INCLUDES}
			-DOSGDB_LIBRARY:PATH=${osgDB_LIBRARY}
			-DOSGDB_LIBRARY_DEBUG:PATH=${osgDB_LIBRARY_DEBUG}
			#osgUtil
			-DOSGUTIL_INCLUDE_DIR:PATH=${OSG_INCLUDES}
			-DOSGUTIL_LIBRARY:PATH=${osgUtil_LIBRARY}
			-DOSGUTIL_LIBRARY_DEBUG:PATH=${osgUtil_LIBRARY_DEBUG}
			#osgShadow
			-DOSGSHADOW_INCLUDE_DIR:PATH=${OSG_INCLUDES}
			-DOSGSHADOW_LIBRARY:PATH=${osgShadow_LIBRARY}
			-DOSSHADOW_LIBRARY_DEBUG:PATH=${osgShadow_LIBRARY_DEBUG}
			#openthreads
			-DOPENTHREADS_INCLUDE_DIR:PATH=${OSG_INCLUDES}
			-DOPENTHREADS_LIBRARY:PATH=${OpenThreads_LIBRARY}
			-DOPENTHREADS_LIBRARY_DEBUG:PATH=${OpenThreads_LIBRARY_DEBUG}
			INSTALL_COMMAND ""
		)
elseif(APPLE)
	ExternalProject_Add(
		osgearth
	    GIT_REPOSITORY https://github.com/gwaldron/osgearth.git
		CMAKE_GENERATOR ${OSGWORKS_GENERATOR}
		DEPENDS osg
		CMAKE_ARGS 
			#-DCMAKE_SHARED_LINKER_FLAGS:STRING="${CMAKE_SHARED_LINKER_FLAGS} /NODEFAULTLIB:msvcprt.lib /NODEFAULTLIB:libcpmt.lib"
			#-DCMAKE_LINKER_FLAGS:STRING="${CMAKE_LINKER_FLAGS} /NODEFAULTLIB:libcpmt.lib /NODEFAULTLIB:msvcprt.lib"
            -DCMAKE_CXX_FLAGS:STRING=${OSGEARTH_CXX_FLAGS}
			-DCMAKE_BUILD_TYPE:STRING=${CMAKE_BUILD_TYPE}
			-DCMAKE_RUNTIME_OUTPUT_DIRECTORY_DEBUG:PATH=${CMAKE_RUNTIME_OUTPUT_DIRECTORY_DEBUG}
			-DCMAKE_RUNTIME_OUTPUT_DIRECTORY_RELEASE:PATH=${CMAKE_RUNTIME_OUTPUT_DIRECTORY_RELEASE}

            #-DOSGInstallType:STRING=${OsgInstallType}
            #-DOSGSourceRoot:STRING=${CMAKE_BINARY_DIR}/modules/omegaOsg/osg-prefix/src/osg
            #-DOSGBuildRoot:STRING=${CMAKE_BINARY_DIR}/modules/omegaOsg/osg-prefix/src/osg-build
			
			# Bild a shared lib on linux, or linking with apps will fail (why? Because little
			# gnomes live in your computer to make your life miserable)
			-DBUILD_SHARED_LIBS:BOOLEAN=false
            -DOSGEARTH_USE_QT=OFF
            #-DOSGBULLET_BUILD_APPLICATIONS=OFF
            #-DOSGBULLET_BUILD_EXAMPLES=OFF
            #-DOSGBULLET_INSTALL_DATA=OFF
			#Bullet
            #-DBulletInstallType:STRING=${BulletInstallType}
            #-DBulletSourceRoot:PATH=${CMAKE_BINARY_DIR}/modules/omegaOsg/bullet-prefix/src/bullet
            #-DBulletBuildRoot:PATH=${CMAKE_BINARY_DIR}/modules/omegaOsg/bullet-prefix/src/bullet-build
			#osgWorks
            #-DosgWorks_DIR:PATH=${CMAKE_BINARY_DIR}/modules/omegaOsg/osgWorks-prefix/src/osgWorks-build/lib
            -DOSG_DIR:PATH=${OSG_INSTALL_DIR}
            #osg
            #-DOSG_INCLUDE_DIR:PATH=${OSG_INSTALL_DIR}/include
            #-DOSG_INCLUDE_DIR:PATH=${OSG_INCLUDES}
            #-DOSG_LIBRARY:PATH=${osg_LIBRARY}
            #-DOSG_LIBRARY_DEBUG:PATH=${osg_LIBRARY_DEBUG}
			#osgGA
            #-DOSGGA_INCLUDE_DIR:PATH=${OSG_INCLUDES}
            #-DOSGGA_LIBRARY:PATH=${osgGA_LIBRARY}
            #-DOSGGA_LIBRARY_DEBUG:PATH=${osgGA_LIBRARY_DEBUG}
			#osgText
            #-DOSGTEXT_INCLUDE_DIR:PATH=${OSG_INCLUDES}
            #-DOSGTEXT_LIBRARY:PATH=${osgText_LIBRARY}
            #-DOSGTEXT_LIBRARY_DEBUG:PATH=${osgText_LIBRARY_DEBUG}
			#osgViewer
            #-DOSGVIEWER_INCLUDE_DIR:PATH=${OSG_INCLUDES}
            #-DOSGVIEWER_LIBRARY:PATH=${osgViewer_LIBRARY}
            #-DOSGVIEWER_LIBRARY_DEBUG:PATH=${osgViewer_LIBRARY_DEBUG}
			#osgSim
            #-DOSGSIM_INCLUDE_DIR:PATH=${OSG_INCLUDES}
            #-DOSGSIM_LIBRARY:PATH=${osgSim_LIBRARY}
            #-DOSGSIM_LIBRARY_DEBUG:PATH=${osgSim_LIBRARY_DEBUG}
			#osgDB
            #-DOSGDB_INCLUDE_DIR:PATH=${OSG_INCLUDES}
            #-DOSGDB_LIBRARY:PATH=${osgDB_LIBRARY}
            #-DOSGDB_LIBRARY_DEBUG:PATH=${osgDB_LIBRARY_DEBUG}
			#osgUtil
            #-DOSGUTIL_INCLUDE_DIR:PATH=${OSG_INCLUDES}
            #-DOSGUTIL_LIBRARY:PATH=${osgUtil_LIBRARY}
            #-DOSGUTIL_LIBRARY_DEBUG:PATH=${osgUtil_LIBRARY_DEBUG}
			#osgShadow
            #-DOSGSHADOW_INCLUDE_DIR:PATH=${OSG_INCLUDES}
            #-DOSGSHADOW_LIBRARY:PATH=${osgShadow_LIBRARY}
            #-DOSGSHADOW_LIBRARY_DEBUG:PATH=${osgShadow_LIBRARY_DEBUG}
            #osgFX
            #-DOSGFX_LIBRARY:PATH=${osgFX_LIBRARY}
            #-DOSGFX_LIBRARY_DEBUG:PATH=${osgFX_LIBRARY_DEBUG}
            #osgTerrain
            #-DOSGTERRAIN_LIBRARY:PATH=${osgTerrain_LIBRARY}
            #-DOSGTERRAIN_LIBRARY_DEBUG:PATH=${osgTerrain_LIBRARY_DEBUG}
            #osgTerrain
            #-DOSGMANIPULATOR_LIBRARY:PATH=${osgManipulator_LIBRARY}
            #-DOSGMANIPULATOR_LIBRARY_DEBUG:PATH=${osgManipulator_LIBRARY_DEBUG}
            #osgWidget
            #-DOSGWIDGET_LIBRARY:PATH=${osgWidget_LIBRARY}
            #-DOSGWIDGET_LIBRARY_DEBUG:PATH=${osgWidget_LIBRARY_DEBUG}
            #openthreads
            #-DOPENTHREADS_INCLUDE_DIR:PATH=${OSG_INCLUDES}
            #-DOPENTHREADS_LIBRARY:PATH=${OpenThreads_LIBRARY}
            #-DOPENTHREADS_LIBRARY_DEBUG:PATH=${OpenThreads_LIBRARY_DEBUG}
			INSTALL_COMMAND ""
		)
else()
	ExternalProject_Add(
        osgearth
	    GIT_REPOSITORY https://github.com/gwaldron/osgearth.git
		CMAKE_GENERATOR ${OSGWORKS_GENERATOR}
		DEPENDS bullet osgWorks osg
		CMAKE_ARGS 
        -DCMAKE_CXX_FLAGS:STRING=${OSGEARTH_CXX_FLAGS}
			-DCMAKE_BUILD_TYPE:STRING=${CMAKE_BUILD_TYPE}
			-DCMAKE_RUNTIME_OUTPUT_DIRECTORY_DEBUG:PATH=${CMAKE_RUNTIME_OUTPUT_DIRECTORY_DEBUG}
			-DCMAKE_RUNTIME_OUTPUT_DIRECTORY_RELEASE:PATH=${CMAKE_RUNTIME_OUTPUT_DIRECTORY_RELEASE}

			-DOSGInstallType:STRING=${OsgInstallType}
			-DOSGSourceRoot:STRING=${CMAKE_BINARY_DIR}/modules/omegaOsg/osg-prefix/src/osg
			-DOSGBuildRoot:STRING=${CMAKE_BINARY_DIR}/modules/omegaOsg/osg-prefix/src/osg-build
			
			# Bild a shared lib on linux, or linking with apps will fail (why? Because little
			# gnomes live in your computer to make your life miserable)
			-DBUILD_SHARED_LIBS:BOOLEAN=true
            #-DOSGBULLET_BUILD_APPLICATIONS=OFF
            #-DOSGBULLET_BUILD_EXAMPLES=OFF
            #-DOSGBULLET_INSTALL_DATA=OFF
			#Bullet
            #-DBulletInstallType:STRING=${BulletInstallType}
            #-DBulletSourceRoot:PATH=${CMAKE_BINARY_DIR}/modules/omegaOsg/bullet-prefix/src/bullet
            #-DBulletBuildRoot:PATH=${CMAKE_BINARY_DIR}/modules/omegaOsg/bullet-prefix/src/bullet-build
			#osg
			-DOSG_INCLUDE_DIR:PATH=${OSG_INCLUDES}
			-DOSG_LIBRARY:PATH=${osg_LIBRARY}
			-DOSG_LIBRARY_DEBUG:PATH=${osg_LIBRARY_DEBUG}
			#osgGA
			-DOSGGA_INCLUDE_DIR:PATH=${OSG_INCLUDES}
			-DOSGGA_LIBRARY:PATH=${osgGA_LIBRARY}
			-DOSGGA_LIBRARY_DEBUG:PATH=${osgGA_LIBRARY_DEBUG}
			#osgText
			-DOSGTEXT_INCLUDE_DIR:PATH=${OSG_INCLUDES}
			-DOSGTEXT_LIBRARY:PATH=${osgText_LIBRARY}
			-DOSGTEXT_LIBRARY_DEBUG:PATH=${osgText_LIBRARY_DEBUG}
			#osgViewer
			-DOSGVIEWER_INCLUDE_DIR:PATH=${OSG_INCLUDES}
			-DOSGVIEWER_LIBRARY:PATH=${osgViewer_LIBRARY}
			-DOSGVIEWER_LIBRARY_DEBUG:PATH=${osgViewer_LIBRARY_DEBUG}
			#osgSim
			-DOSGSIM_INCLUDE_DIR:PATH=${OSG_INCLUDES}
			-DOSGSIM_LIBRARY:PATH=${osgSim_LIBRARY}
			-DOSGSIM_LIBRARY_DEBUG:PATH=${osgSim_LIBRARY_DEBUG}
			#osgDB
			-DOSGDB_INCLUDE_DIR:PATH=${OSG_INCLUDES}
			-DOSGDB_LIBRARY:PATH=${osgDB_LIBRARY}
			-DOSGDB_LIBRARY_DEBUG:PATH=${osgDB_LIBRARY_DEBUG}
			#osgUtil
			-DOSGUTIL_INCLUDE_DIR:PATH=${OSG_INCLUDES}
			-DOSGUTIL_LIBRARY:PATH=${osgUtil_LIBRARY}
			-DOSGUTIL_LIBRARY_DEBUG:PATH=${osgUtil_LIBRARY_DEBUG}
			#osgShadow
			-DOSGSHADOW_INCLUDE_DIR:PATH=${OSG_INCLUDES}
			-DOSGSHADOW_LIBRARY:PATH=${osgShadow_LIBRARY}
			-DOSSHADOW_LIBRARY_DEBUG:PATH=${osgShadow_LIBRARY_DEBUG}
			#openthreads
			-DOPENTHREADS_INCLUDE_DIR:PATH=${OSG_INCLUDES}
			-DOPENTHREADS_LIBRARY:PATH=${OpenThreads_LIBRARY}
			-DOPENTHREADS_LIBRARY_DEBUG:PATH=${OpenThreads_LIBRARY_DEBUG}
			
			INSTALL_COMMAND ""
		)
endif()

set_target_properties(osgearth PROPERTIES FOLDER "3rdparty")

set(OSGEARTH_BASE_DIR ${CMAKE_BINARY_DIR}/modules/omegaOsgEarth/osgearth-prefix/src)
# NOTE: setting the OSGEARTH_INCLUDES as an internal cache variable, makes it accessible to other modules.
set(OSGEARTH_INCLUDES ${OSGEARTH_INCLUDES} ${OSGEARTH_BASE_DIR}/osgEarth/include CACHE INTERNAL "")

set(OSGEARTH_LIB_DIR ${OSGEARTH_BASE_DIR}/osgearth-build/lib)
#set(OSGEARTH_COMPONENTS osgbCollision osgbDynamics osgbInteraction)
if(OMEGA_OS_WIN)
	foreach( C ${OSGEARTH_COMPONENTS})
		set(${C}_LIBRARY ${OSGEARTH_LIB_DIR}/Release/${C}.lib)
		set(${C}_LIBRARY_DEBUG ${OSGEARTH_LIB_DIR}/Debug/${C}d.lib)
		set(OSGEARTH_LIBRARIES ${OSGEARTH_LIBRARIES} optimized ${${C}_LIBRARY} debug ${${C}_LIBRARY_DEBUG})
	endforeach()
elseif(OMEGA_OS_LINUX)
    foreach( C ${OSGEARTH_COMPONENTS} )
		set(${C}_LIBRARY ${OSGEARTH_LIB_DIR}/lib${C}.so)
		set(${C}_LIBRARY_DEBUG ${OSGEARTH_LIB_DIR}/lib${C}.so)
		set(OSGEARTH_LIBRARIES ${OSGEARTH_LIBRARIES} optimized ${${C}_LIBRARY} debug ${${C}_LIBRARY_DEBUG})
	endforeach()
elseif(APPLE)
	foreach( C ${OSGEARTH_COMPONENTS} )
		set(${C}_LIBRARY ${OSGEARTH_LIB_DIR}/lib${C}.a)
		set(${C}_LIBRARY_DEBUG ${OSGEARTH_LIB_DIR}/lib${C}.a)
		set(OSGEARTH_LIBRARIES ${OSGEARTH_LIBRARIES} optimized ${${C}_LIBRARY} debug ${${C}_LIBRARY_DEBUG})
	endforeach()
endif(OMEGA_OS_WIN)

if(WIN32)
	# Add the DOSGEARTH_STATIC to following projects, so we tell the header files 
	# we are not importing dll symbols.
	add_definitions(-DOSGEARTH_STATIC)
endif()

include_directories(${OSG_INCLUDES})
# NOTE: setting the OSGEARTH_LIBS as an internal cache variable, makes it accessible to other modules.
set(OSGEARTH_LIBS ${OSGEARTH_LIBRARIES} ${OSGEARTH_LIBS} CACHE INTERNAL "")
