//
//  SynthesizeSingleton.h
//  CocoaWithLove
//
//  Created by Matt Gallagher on 20/10/08.
//  Copyright 2009 Matt Gallagher. All rights reserved.
//
//  Permission is given to use this source code file without charge in any
//  project, commercial or otherwise, entirely at your risk, with the condition
//  that any redistribution (in part or whole) of source code must retain
//  this copyright and permission notice. Attribution in compiled projects is
//  appreciated but not required.
//
/*
	Singletons in Cocoa - http://cocoawithlove.com
 
 The solution to the encapsulation problem is to create classes that
 manage any global data as discreet modules. This is done through a singleton.
 I Userally like to put these singleton methods into a macro, which you can
 download in my SynthesizeSingleton.h file.
 
 1)  #import this header at the top of a class implementation
 2)  then all you need to do is write: "SYNTHESIZE_SINGLETON_FOR_CLASS(MyClassName);"
	 inside the @implementation MyClassName declaration and your class will become a singleton.
 3)  You will also need to add the line: "+ (MyClassName *)sharedMyClassName;" to the header 
	 file for MyClassName so the singleton accessor method can be found from other source files
	 if they #import the header. 
 4)  Once your class is a singleton, you can access the instance of it using the line:
	 [MyClassName sharedMyClassName];

 Note: A singleton does not need to be explicitly allocated or initialized (the alloc and init
	   methods will be called automatically on first access) but you can still implement the default
	   init method if you want to perform initialization.
*/

#define SYNTHESIZE_SINGLETON_FOR_CLASS(classname) \
 \
static classname *shared##classname = nil; \
 \
+ (classname *)shared##classname \
{ \
	@synchronized(self) \
	{ \
		if (shared##classname == nil) \
		{ \
			shared##classname = [[self alloc] init]; \
		} \
	} \
	 \
	return shared##classname; \
} \
 \
+ (id)allocWithZone:(NSZone *)zone \
{ \
	@synchronized(self) \
	{ \
		if (shared##classname == nil) \
		{ \
			shared##classname = [super allocWithZone:zone]; \
			return shared##classname; \
		} \
	} \
	 \
	return nil; \
} \
 \
- (id)copyWithZone:(NSZone *)zone \
{ \
	return self; \
} \
 \
- (id)retain \
{ \
	return self; \
} \
 \
- (NSUInteger)retainCount \
{ \
	return NSUIntegerMax; \
} \
 \
- (void)release \
{ \
} \
 \
- (id)autorelease \
{ \
	return self; \
}
