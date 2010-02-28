Mobile Context Framework
========================

The progressive spreading of wireless networks and increasingly powerful mobile computers creates a big potential for a wide spectrum of innovative applications. Context-aware applications adapt the circumstances of the user's current situation which enables new and intelligent user interfaces. Nevertheless, the sheer diversity of exploitable contexts and the plethora of sensing technologies are actually working against the deployment of context-aware systems. A framework for context retrieval should enable the development of context-aware applications without considering details of context acquisition and context management. Moreover, exchange and reusability of context information should be allowed between applications and users.

The *Mobile Context Framework* tries to solve the described issues. It consists of three components:

* The [Mobile Context Server](http://github.com/flxmllr/mobile-context-server/)
* The Mobile Context iPhone Library (this project)
* The [Mobile Context iPhone Demo App](http://github.com/flxmllr/mobile-context-iphone-demo/)

The Mobile Context iPhone Library
---------------------------------

### Installation notes ###

The *Mobile Context iPhone Library* is a static library that can be easily included into iPhone Xcode projects as framework. The functions can be used by the API methods provided by the framework. The following steps are needed to include the library into an iPhone project:

#### 1. Download the framework files ####

Download or checkout the source files of this project and save the folder `mobile-context-iphone-lib` into the same top level directory your own projects folder lives in.

#### 2. Configure and build the framework ####

1. Open the Xcode project of the library and open the source file `ContextService.m`.

2. Enter the correct URL of your previously set up and running [Mobile Context Server](http://github.com/flxmllr/mobile-context-server/).

3. Build the project for the *Simulator* and the *Device* configurations.

#### 3. Include the library as framework ####

The framework is now prepared and built. Here is how to include the library into an own iPhone Xcode project:

1. In Xcode, open the contextual menu of the frameworks folder and then choose "Frameworks" > "Add" > "Existing Frameworks" > "Add Other" and then select the `libContextFramework.o` from the folder matching your active configuration.

2. Now you need to include some system frameworks, too. Open the contextual menu of the frameworks folder again and choose "Frameworks" > "Add" > "Existing Frameworks" and then choose the `CoreLocation.framework`. Repeat the procedure for the `AudioTools.framework`.

3. The next step is to set up the paths to the library and header files in a generic way, so the files can always be found, no matter which configuration and platforms you select. Open the contextual menu on your active target and choose "Get Info". Swich to "All Configurations". Search for "Library Search Paths" and enter the path `$(SRCROOT)/../mobile-context-iphone-lib/build/$(CONFIGURATION)$(EFFECTIVE_PLATFORM_NAME)`. Find the setting "Header Search Paths" and add the path `${PROJECT_DIR}/../mobile-context-iphone-lib/build/${BUILD_STYLE}-${PLATFORM_NAME}/usr/local/include`.

4. Lastly, you have to set up a few linker flags. Find the "Other Linker Flags" setting and add `-ObjC` and `-all_load`.

#### 3. First steps in using the framework ####

You are now ready to use the included framework. Here are a few hints how to get started:

1. The first step is to init the context service, for example in the `applicationDidFinishLaunching:application` method of your application delegate:

	ContextService *contextService = [[ContextService alloc] init];

2. To save a list of all available context sources, simply call

	NSArray *contextSources = [delegate.contextService getContextSources];

3. To enable or disable a specific context source, you can use

	[delegate.contextService enableContextSource:SOURCE_TO_ENABLE];

	[delegate.contextService disableContextSource:SOURCE_TO_DISABLE];


### API documentation ###

coming soon...



Copyright (c) 2010 Felix Mueller, released under the [MIT license](http://github.com/flxmllr/mobile-context-iphone-lib/blob/master/MIT-LICENSE)
