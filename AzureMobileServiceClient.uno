using Fuse;
using Fuse.Platform;
using Uno;
using Uno.Compiler.ExportTargetInterop;

public extern(!iOS && !Android) class AzureMobileServiceClient
{
  extern(!iOS && !Android) object _client;
  extern(!iOS && !Android) User _defaultUser = new User("1", "998877665544");

  public extern (!iOS && !Android) void Init(string azureUri)
  {

  }

  public extern(!iOS && !Android) void Login(string provider, string uriScheme, Action<User> onSuccess, Action<string> onError)
  {
    onSuccess(_defaultUser);
  }

  public extern(!iOS && !Android) User GetCurrentUser()
  {
    return _defaultUser;
  }
}
