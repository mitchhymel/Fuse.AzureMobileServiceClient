using Uno;
using Uno.Threading;
using Fuse;
using Uno.Compiler.ExportTargetInterop;

[TargetSpecificImplementation]
public extern(iOS) class AzureMobileServiceClient
{
  extern(iOS) ObjC.Object _client;

  [Foreign(Language.ObjC)]
  public extern(iOS) void Init(string azureUri)
  @{

  @}

  [Foreign(Language.ObjC)]
  public extern(iOS) void Login(string provider, string uriScheme, Action<User> onSuccess, Action<string> onError)
  @{

  @}

  [Foreign(Language.ObjC)]
  public extern(iOS) User GetCurrentUser()
  @{
    return null;
  @}

}
