using Fuse;
using Fuse.Platform;
using Uno;
using Uno.Compiler.ExportTargetInterop;

[Require("Gradle.Repository", "jcenter()")]
[Require("Gradle.Dependency", "compile('com.microsoft.azure:azure-mobile-android:3.3.0@aar')")]
[Require("Gradle.Dependency", "compile('com.squareup.okhttp:okhttp:2.5.0')")]
[Require("Gradle.Dependency", "compile('com.google.guava:guava:20.0') { exclude module: 'support-v4' }")]
[Require("Gradle.Dependency", "compile('com.google.code.gson:gson:2.7')")]
[Require("Gradle.Dependency", "compile('com.android.support:customtabs:25.3.1') { exclude module: 'support-v4' }")]
[ForeignInclude(Language.Java, "com.microsoft.windowsazure.mobileservices.MobileServiceActivityResult")]
[ForeignInclude(Language.Java, "com.microsoft.windowsazure.mobileservices.MobileServiceClient")]
[ForeignInclude(Language.Java, "android.util.Log")]
[ForeignInclude(Language.Java, "com.fuse.Activity")]
[TargetSpecificImplementation]
public extern(Android) class AzureMobileServiceClient
{
  extern(Android) Java.Object _client;
  extern(Android) int _requestCode = 1;

  [Foreign(Language.Java)]
  public extern(Android) void Init(string azureUri)
  @{
    com.fuse.Activity.ResultListener listener = new com.fuse.Activity.ResultListener() {
      @Override public boolean onResult(int requestCode, int resultCode, android.content.Intent data) {
        return @{AzureMobileServiceClient:Of(_this).OnResult(int, int, Java.Object):Call(requestCode, resultCode, data)};
      }
    };
    com.fuse.Activity.subscribeToResults(listener);

    try {
      MobileServiceClient client = new MobileServiceClient(azureUri, com.fuse.Activity.getRootActivity());
      @{AzureMobileServiceClient:Of(_this)._client:Set(client)};
    }
    catch (Exception e) {
      Log.e("AzureMobileServiceClient", e.getMessage());
    }
  @}

  [Foreign(Language.Java)]
  public extern(Android) void Login(string provider, string uriScheme)
  @{
    MobileServiceClient client = (MobileServiceClient)@{AzureMobileServiceClient:Of(_this)._client:Get()};
    try
    {
      client.login(provider, uriScheme, (int)@{AzureMobileServiceClient:Of(_this)._requestCode});
    }
    catch (Exception e)
    {
      Log.e("AzureMobileServiceClient", e.getMessage());
    }
  @}

  [Foreign(Language.Java)]
  extern(Android) bool OnResult(int requestCode, int resultCode, Java.Object intent)
  @{
    Log.e("AzureMobileServiceClient", "in OnResult()");
    if (resultCode == android.app.Activity.RESULT_OK)
    {
      if (requestCode == (int)@{AzureMobileServiceClient:Of(_this)._requestCode})
      {
        @{AzureMobileServiceClient:Of(_this).HandleIntent(Java.Object):Call(intent)};
      }
    }
    else
    {
      Log.e("AzureMobileServiceClient", "code: " + resultCode);
    }

    return false;
  @}

  [Foreign(Language.Java)]
  extern(Android) void HandleIntent(Java.Object intent)
  @{
    Log.e("AzureMobileServiceClient", "inHandleIntent");
    MobileServiceClient client = (MobileServiceClient)@{AzureMobileServiceClient:Of(_this)._client:Get()};
    MobileServiceActivityResult result = client.onActivityResult((android.content.Intent)intent);
    if (result.isLoggedIn())
    {
      Log.e("AzureMobileServiceClient", "You are now logged in " + client.getCurrentUser().getUserId());
    }
    else
    {
      String errorMessage = result.getErrorMessage();
      Log.e("AzureMobileServiceClient", "Error: " + errorMessage);
    }
  @}



}
