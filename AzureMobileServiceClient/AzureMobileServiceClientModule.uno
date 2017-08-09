using Fuse;
using Fuse.Scripting;
using Uno.UX;

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
    AddMember(new NativeFunction("login", (NativeCallback)Login));
  }

  object Init(Context c, object[] args)
  {
    _client.Init((string)args[0]);
    return null;
  }

  object Login(Context c, object[] args)
  {
    _client.Login((string)args[0], (string)args[1]);
    return null;
  }
}
