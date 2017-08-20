using Uno.Threading;
using Uno.Permissions;
using Uno;

public class LoginPromise : Promise<User>
{
  readonly AzureMobileServiceClient _client;
  string _provider;
  string _uriScheme;

  public LoginPromise(AzureMobileServiceClient client, string provider, string uriScheme)
  {
    _client = client;
    _provider = provider;
    _uriScheme = uriScheme;

    if defined(Android)
    {
      Permissions.Request(Permissions.Android.INTERNET).Then(
        OnPermissionsPermitted,
        OnPermissionsRejected);
    }
    else
    {
      Fuse.UpdateManager.AddOnceAction(Login);
    }
  }

  void Login()
  {
    if defined(Android)
    {
      _client.Login(_provider, _uriScheme, this.Resolve, OnError);
    }
    else
    {
      debug_log "Not implemented";
    }
  }

  void OnError(string error)
  {
    Reject(new Exception(error));
  }

  extern(Android) void OnPermissionsPermitted(PlatformPermission p)
	{
		Fuse.UpdateManager.AddOnceAction(Login);
	}

	extern(Android) void OnPermissionsRejected(Exception e)
	{
		Reject(e);
	}
}
