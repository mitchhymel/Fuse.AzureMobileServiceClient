using Fuse;
using Fuse.Scripting;
using Uno.UX;
using Uno.Threading;

[UXGlobalModule]
public class AzureMobileServiceClientModule : NativeModule
{
  static readonly AzureMobileServiceClientModule _instance;
  readonly AzureMobileServiceClient _client;

  public AzureMobileServiceClientModule()
  {
    if (_instance != null)
    {
      return;
    }

    _client = new AzureMobileServiceClient();

    _instance = this;
    Resource.SetGlobalKey(_instance, "AzureMobileServiceClient");
    AddMember(new NativeFunction("initialize", (NativeCallback)Init));
    AddMember(new NativePromise<User, Fuse.Scripting.Object>("login", Login, User.Convert));
  }

  object Init(Context c, object[] args)
  {
    _client.Init((string)args[0]);
    return null;
  }

  Future<User> Login(object[] args)
  {
    return new LoginPromise(_client, (string)args[0], (string)args[1]);
  }
}
