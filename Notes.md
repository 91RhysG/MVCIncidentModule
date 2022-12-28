Resolved Issues:

******************************************************************
Database was building to an unknown and unexpected location:
- expected location: (localdb)MSSQLLocalDB; 
- actual location: (localdb)\ProjectModels

******************************************************************
Website was not building, was giving a null reference exception due to bootstrap.

![image](https://user-images.githubusercontent.com/91763894/209790619-b51bb7bf-5c3f-49c1-a9e5-d35bb36bcc63.png)

Investigating revealed that 'new ScriptBundle' within the App_Start/BundleConfig.cs is out of date and the more recent syntax of bootstrap is not supported due to a parsing error.

Changing ScriptBundle to Bundle resolved the issue.

![image](https://user-images.githubusercontent.com/91763894/209790887-09fa7610-6f5d-4f02-a311-c5e57729a0ea.png)
