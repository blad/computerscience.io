---
title: Android Fragments and Lifecycle Considerations
subtitle: Correctly Handling Fragments in Android Applications
post: true
icon: android
---

## Why Fragments
Fragments in Android Operating System have been around since Android 3.0 (API level 11), and their primary use
is to give developers a way to design the UI of Android applications in a way that enables code reuse by providing the 
ability to bundle UI elements and business logic into one location. 

## Adding Fragments to an Activity
````XML
<!--file: res/layout/my_fragment_activity.xml-->
<LinearLayout
	android:id="@+id/aContainerInYourApplicationWithThisId"
	android:layout_width="match_parent"
	android:layout_height="match_parent" >
	<FrameLayout
		android:id="@+id/fragFrame"
		android:layout_width="match_parent"
		android:layout_height="match_parent"
		/>
</LinearLayout>
<!--...-->
````

````Java
// file: src/com.yourstartup.yourawesomeapp.FragmentedActivity.java
@Override
public void onCreate(Bundle savedInstanceState) {
	super.onCreate(savedInstatnceState)
	// ...
	Fragment myFragment = MyFragmentClass.getInstance();
	getSupportFragmentManager()
		.getTransaction()
		.add(R.id.fragFrame, myFragment)
		.commit();
	// ...
}
````

## Improvement \#1

````Java
// file: src/com.yourstartup.yourawesomeapp.FragmentedActivity.java
@Override
public void onCreate(Bundle savedInstanceState) {
	super.onCreate(savedInstatnceState)
	// ...
	Fragment myFragment = MyFragmentClass.getInstance();
	getSupportFragmentManager()
		.getTransaction()
		.replace(R.id.fragFrame, myFragment) // Replace instead of add
		.commit();
	// ...
}
````

## Improvement \#2

````Java
// file: src/com.yourstartup.yourawesomeapp.FragmentedActivity.java
@Override
public void onCreate(Bundle savedInstanceState) {
	super.onCreate(savedInstatnceState)
	// ...
	// savedInstanceState is null if this is the first time setting up the activity.
	// If savedInstanceState != null, then we can restore the fragment from a previously
	// created instance.
	if (savedInstanceState == null) {
		Fragment myFragment = MyFragmentClass.getInstance();
		getSupportFragmentManager()
			.getTransaction()
			.replace(R.id.fragFrame, myFragment) // Replace instead of add
			.commit();
	} else {
		myFragment = (Fragment) (getSupportFragmentManager()
						.findFragmentById(R.id.fragFrame));
	}
	// ...
}
````


## Conclusion


## Additional Resources

