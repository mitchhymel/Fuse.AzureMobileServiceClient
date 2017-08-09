# Fuse.AzureMobileServiceClient
An uno wrapper around [Azure Mobile Service](https://azure.microsoft.com/en-us/services/app-service/mobile/) clients for [Fuse](https://www.fusetools.com/). 

Currently only supports login through Facebook/Google on Android.


# Setup

You must define an Android resource with the mobile service URI scheme that is registered as a valid auth URI for your azure app.
You can do this by adding the below to a .uxl file and including it in your .unoproj

```
<Extensions Backend="CPlusPlus">
  <Require Condition="Android" Android.ResStrings.Declaration>
    <![CDATA[
      <string name="AZURE_MOBILE_SERVICE_URI_SCHEME"></string>
    ]]>
  </Require>
</Extensions>
```

You also have to make some modifications to the Android Manifest in order to get things working. Check the [example app](https://github.com/mitchhymel/Fuse.AzureMobileServiceClient/blob/master/AzureExample/AzureExample.uxl) for how to do this.

# Usage
See the [example app](https://github.com/mitchhymel/Fuse.AzureMobileServiceClient/tree/master/AzureExample)

```
      // Import Azure Mobile Service module and initialize
      var AzureMobileServiceClient = require("AzureMobileServiceClient");
      var azureUri = "";// something like https://contoso.azurewebsites.net;

      // app uri scheme can be anything, must be same as defined in the resource file
      // example: com.contoso.app
      var appUriScheme = "";
      AzureMobileServiceClient.initialize(azureUri);

      function loginWithFacebook() {
        AzureMobileServiceClient.login("facebook", appUriScheme);
      }

      function loginWithGoogle() {
        AzureMobileServiceClient.login("google", appUriScheme);
      }
```

# Disclaimer
Since this repo relates to Microsoft owned technologies, and I'm currently an employee at Microsoft, I feel the need to add a disclaimer.
Any views, opinions, code found in this repo are my own and do not represent the official views or opinions of Microsoft.
