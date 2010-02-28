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

4. Lastly, you have to set up two linker flags. Find the "Other Linker Flags" setting and add `-ObjC` and `-all_load`.

#### 3. First steps in using the framework ####

You are now ready to use the included framework. Here are a few hints how to get started:

* *Init the service*

	The first step is to init the context service, for example in the `applicationDidFinishLaunching:application` method of your application delegate:

		ContextService *contextService = [[ContextService alloc] init];

* *Manage context sources*

	To save a list of all available context sources, simply call

		NSArray *contextSources = [delegate.contextService getContextSources];

	To enable or disable a specific context source, you can use

		[delegate.contextService enableContextSource:SOURCE_TO_ENABLE];
		[delegate.contextService disableContextSource:SOURCE_TO_DISABLE];

* *Gather attribute values*

	To get all current attribute values, you can call

		NSDictionary *contexts = [delegate.contextService getSourceAttributeValues];


* *Get contexts*

	To get all currently matching contexts for a user, you can call
	
		NSDictionary *contexts = [delegate.contextService getContextsForUser:USER_NAME];

### API documentation ###

Here is the full API documentation of all methods provided by the context service:

#### User management ####

* **Request all existing users from the context model**

		- (NSArray *)getUsers;

	*Parameters*
	* none

	*Returns*
	* An NSArray of NSStrings with all user names
	* nil if no users were found or an error did occur
		

* **Add a user to the context model**

		- (BOOL)addUser:(NSString *)userName;

	*Parameters*
	* userName: An NSString containing the user name
		
	*Returns*
	* YES if the user was added successfully;
	* NO if the user does already exist or an error did occur


* **Remove a user from the context model**

		- (BOOL)removeUser:(NSString *)userName;

	*Parameters*
	* userName: An NSString containing the user name

	*Returns*
	* YES if the user was removed successfully
	* NO if the user was not found an error did occur



#### Context management ####

* **Request all global contexts from the context model**

		- (NSDictionary *)getContexts;

 	*Parameters*
	* none

 	*Returns*
 	* An NSDictionary of Context with keys = context types and values = Context objects
	* nil if no contexts were found or an error did occur


* **Request all contexts for a given user from the context model**

		- (NSDictionary *)getContextsForUser:(NSString *)userName;
		
	*Parameters*
	* `userName`: An NSString containing the user name

	*Returns*
	* An NSDictionary of Context with keys = context types and values = Context objects
	* nil if no contexts were found or an error did occur


* **Request all contexts for a given user and a given type from the context model**

		- (NSDictionary *)getContextsForUser:(NSString *)userName withType:(NSString *)contextType;

	*Parameters*
	* `userName`: An NSString containing the user name
 	* `contextType`: An NSString containing the context type

	*Returns*
	* An NSDictionary of Context with keys = context types and values = Context objects
	* nil if no contexts were found or an error did occur


* **Add a global context with a given type and given condidions to the context model**

		- (BOOL)addContext:(NSString *)contextName withType:(NSString *)contextType withConditions:(NSDictionary *)conditions;

	*Parameters*
	* `contextName`: An NSString containing the context name
	* `contextType`: An NSString containing the context type
	* `conditions`: An NSDictionary of NSString with keys = subjects and values = objects

	*Returns*
	* YES if context was successfully added
	* NO of context exists or an error did occur


* **Add a context with a given type and given condidions for a given user to the context model**

		- (BOOL)addContext:(NSString *)contextName withType:(NSString *)contextType withConditions:(NSDictionary *)conditions forUser:(NSString *)user;

	*Parameters*
	* `contextName`: An NSString containing the context name
	* `contextType`: An NSString containing the context type
	* `conditions`: An NSDictionary of NSString with keys = subjects and values = objects
	* `userName`: An NSString containing the user name

	*Returns*
	* YES if context was successfully added
	* NO of context exists or an error did occur


* **Remove a context with a given type from the context model**

		- (BOOL)removeContext:(NSString *)contextName;

	*Parameters*
	* `contextName`: An NSString containing the context name

	*Returns*
	* YES if the context was removed successful
	* NO if the context was not found an error did occur


* **Remove a context with a given type for a given user from the context model**

		- (BOOL)removeContext:(NSString *)contextName forUser:(NSString *)userName;

	*Parameters*
	* `contextName`: An NSString containing the context name
	* `userName`: An NSString containing the user name

	*Returns*
	* YES if the context was removed successfully
	* NO if the context was not found an error did occur



#### Data source management ####


* **Request all context sources currently available in the context service**

		- (NSArray *)getContextSources;

	*Parameters*
 	* none

 	*Returns*
 	* An NSArray of NSString with all context source names
 	* nil if no context sources were found or an error did occur


* **Request all attributes the context source can deliver**

		- (NSArray *)getSourceAttributes:(NSString *)source;

	*Parameters*
	* `source`: An NSString containing the context source name

	*Returns*
	* An NSArray if NSString with the names of the context attributes
	* nil if no attributes were found or an error did occur


* **Check if a given context source is enabled**

		- (BOOL)contextSourceEnabled:(NSString *)contextSource;

	*Parameters*
	* `contextSource`: An NSString containing the name of the context source

	*Returns*
	* YES if the context source is enabled
	* NO if the context source is disabled


* **Enable a given context source**

		- (BOOL)enableContextSource:(NSString *)contextSource;

	*Parameters*
	* `contextSource`: An NSString containing the name of the context source

	*Returns*
	* YES if the context source was enabled successfully
	* NO if the context source was not found an error did occur


* **Disable a given context source**

		- (BOOL)disableContextSource:(NSString *)contextSource;

	*Parameters*
	* `contextSource`: An NSString containing the name of the context source

	*Returns*
	* YES if the context source was disenabled successfully
	* NO if the context source was not found an error did occur


* **Request all context source attribute values currently available by the context service**

		- (NSDictionary *)getSourceAttributeValues;

	*Parameters*
	* none

	*Returns*
	* An NSDictionary of Attribute with keys = source and values = Attribute objects
	* nil if no context source attributes were found or an error did occur


* **Request a specific context attribute value from the context service**

		- (Attribute *)getSourceAttributeValue:(NSString *)contextSourceType;

	*Parameters*
	* `contextSourceType`: An NSString containing the context source type

	*Returns*
	* An Attribute with the current context data gathered by the source
	* nil if the context attribute was not found or an error did occur



#### Notification management ####


* **Register an object for context change notifications for a given context**

		- (BOOL)registerForContextChangeNotifications:(id)observer forContext:(NSString *)contextName;

	*Parameters*
 	* `observer`: An Object registering as an observer
 	* `contextName`: An NSString containing the context name

 	*Returns*
 	* YES if the registration was successful
 	* NO if an error did occur


* **Register an object for context change notifications for a given context and a given user**

		- (BOOL)registerForContextChangeNotifications:(id)observer forContext:(NSString *)contextName forUser:(NSString *)userName;

	*Parameters*
	* `observer`: An Object registering as an observer
	* `contextName`: An NSString containing the context name
	* `userName`: An NSString containing the user name

	*Returns*
	* YES if the registration was successful
	* NO if an error did occur


* **Unregister an object from context change notifications**

		- (BOOL)unregisterFromContextChangeNotifications:(id)observer;

	*Parameters*
	* `observer`: An Object registering as an observer
	* `contextName`: An NSString containing the context name
	* `userName`: An NSString containing the user name

	*Returns*
	* YES if the unregistration was successful
	* NO if an error did occur



Copyright (c) 2010 Felix Mueller, released under the [MIT license](http://github.com/flxmllr/mobile-context-iphone-lib/blob/master/MIT-LICENSE)
