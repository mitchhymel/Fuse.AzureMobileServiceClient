using Uno;
using Fuse.Scripting;

public class User
{
	extern string _userId;
	extern string _authenticationToken;

	public User(string userId, string authenticationToken)
	{
		_userId = userId;
		_authenticationToken = authenticationToken;
	}

	public string  getUserId() {
		return _userId;
	}

	public string getAuthenticationToken() {
		return _authenticationToken;
	}

  public static Fuse.Scripting.Object Convert(Context context, User user)
  {
    var wrapperObject = context.NewObject();
    wrapperObject["userId"] = user.getUserId();
    wrapperObject["authenticationToken"] = user.getAuthenticationToken();
    return wrapperObject;
  }

}
