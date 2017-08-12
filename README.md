# Fuse.AzureMobileServiceClient
An uno wrapper around [Azure Mobile Service](https://azure.microsoft.com/en-us/services/app-service/mobile/) clients for [Fuse](https://www.fusetools.com/). 

Functionality supported (Android only):
- Login with Google
- Login with Facebook


# Setup

You must define an Android resource with the mobile service URI scheme that is registered as a valid auth URI for your azure app.
You can do this by adding the below to a .uxl file and including it in your .unoproj

```
<Extensions Backend="CPlusPlus">
  <Require Condition="Android" Android.ResStrings.Declaration>
    <![CDATA[
      <string name="AZURE_MOBILE_SERVICE_URI_SCHEME">com.example.app</string>
    ]]>
  </Require>
</Extensions>
```

Note: The library requires some changes to the Android Manifest. Check [here](https://github.com/mitchhymel/Fuse.AzureMobileServiceClient/blob/master/AzureMobileServiceClient.uxl) to see the changes.

# Usage
Will fill this out eventually.

# Disclaimer
Since this repo relates to Microsoft owned technologies, and I'm currently an employee at Microsoft, I feel the need to add a disclaimer.
Any views, opinions, code found in this repo are my own and do not represent the official views or opinions of Microsoft.
