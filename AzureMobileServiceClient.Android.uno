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
  extern(Android) Java.Object _resultListener;

  [Foreign(Language.Java)]
  public extern(Android) void Init(string azureUri)
  @{

    try
    {
      MobileServiceClient client = new MobileServiceClient(azureUri, com.fuse.Activity.getRootActivity());
      @{AzureMobileServiceClient:Of(_this)._client:Set(client)};
    }
    catch (Exception e) {
      Log.e("AzureMobileServiceClient", e.getMessage());
    }
  @}

  [Foreign(Language.Java)]
  public extern(Android) void Login(string provider, string uriScheme, Action<User> onSuccess, Action<string> onError)
  @{
    com.fuse.Activity.ResultListener listener = (com.fuse.Activity.ResultListener)@{AzureMobileServiceClient:Of(_this)._resultListener:Get()};
    if (listener != null)
    {
      com.fuse.Activity.unsubscribeFromResults(listener);
    }

    listener = new com.fuse.Activity.ResultListener() {
      @Override public boolean onResult(int requestCode, int resultCode, android.content.Intent data) {
        return @{AzureMobileServiceClient:Of(_this).OnResult(int, int, Java.Object, Action<User>, Action<string>):Call(requestCode, resultCode, data, onSuccess, onError)};
      }
    };
    @{AzureMobileServiceClient:Of(_this)._resultListener:Set(listener)};
    com.fuse.Activity.subscribeToResults(listener);

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
  public extern(Android) User GetCurrentUser()
  @{
    MobileServiceClient client = (MobileServiceClient)@{AzureMobileServiceClient:Of(_this)._client:Get()};
    if (client.getCurrentUser() != null)
    {
      String userId = client.getCurrentUser().getUserId();
      String authenticationToken = client.getCurrentUser().getAuthenticationToken();
      UnoObject user = @{User(string, string):New(userId, authenticationToken)};
      return user;
    }
    else
    {
      return null;
    }
  @}


  [Foreign(Language.Java)]
  extern(Android) bool OnResult(int requestCode, int resultCode, Java.Object intent, Action<User> onSuccess, Action<string> onError)
  @{
    Log.e("AzureMobileServiceClient", "in OnResult()");
    if (resultCode == android.app.Activity.RESULT_OK)
    {
      if (requestCode == (int)@{AzureMobileServiceClient:Of(_this)._requestCode:Get()})
      {
        MobileServiceClient client = (MobileServiceClient)@{AzureMobileServiceClient:Of(_this)._client:Get()};
        MobileServiceActivityResult result = client.onActivityResult((android.content.Intent)intent);
        if (result.isLoggedIn())
        {
          Log.e("AzureMobileServiceClient", "You are now logged in " + client.getCurrentUser().getUserId());
          onSuccess.run((UnoObject)@{AzureMobileServiceClient:Of(_this).GetCurrentUser():Call()});
        }
        else
        {
          String errorMessage = result.getErrorMessage();
          Log.e("AzureMobileServiceClient", "Error: " + errorMessage);

          onError.run(errorMessage);
        }
      }
    }
    else
    {
      Log.e("AzureMobileServiceClient", "code: " + resultCode);
    }

    return false;
  @}



}
