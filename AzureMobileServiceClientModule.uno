using Fuse;
using Fuse.Scripting;
using Uno.UX;
using Uno.Threading;

[UXGlobalModule]
public class AzureMobileServiceClientModule : NativeModule
{
  readonly AzureMobileServiceClient _client;
  static readonly AzureMobileServiceClientModule _instance;

  public AzureMobileServiceClientModule()
  {
    if (_instance != null)
    {
      return;
    }

    _instance = this;
    Resource.SetGlobalKey(_instance, "AzureMobileServiceClient");

    _client = new AzureMobileServiceClient();

    AddMember(new NativeFunction("initialize", (NativeCallback)Init));
    AddMember(new NativePromise<User, Fuse.Scripting.Object>("login", Login, User.Convert));
    AddMember(new NativeFunction("getCurrentUser", (NativeCallback)GetCurrentUser));
  }

  object Init(Context c, object[]args)
  {
    _client.Init((string)args[0]);
    return null;
  }

  Future<User> Login(object[] args)
  {
    return new LoginPromise(_client, (string)args[0], (string)args[1]);
  }

  Fuse.Scripting.Object GetCurrentUser(Context c, object[] args)
  {
    return User.Convert(c, _client.GetCurrentUser());
  }
}
