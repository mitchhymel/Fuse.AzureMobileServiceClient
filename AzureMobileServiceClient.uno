using Fuse;
using Fuse.Platform;
using Uno;
using Uno.Compiler.ExportTargetInterop;

public extern(!iOS && !Android) class AzureMobileServiceClient
{
  extern(!iOS && !Android) object _client;

  public extern (!iOS && !Android) void Init(string azureUri)
  {

  }

  public extern(!iOS && !Android) void Login(string provider, string uriScheme, Action<User> onSuccess, Action<string> onError)
  {

  }
}
