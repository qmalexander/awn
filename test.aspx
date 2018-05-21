<%@ Page Language="C#" AutoEventWireup="true"%>
<html>
<head></head>
<body>
IS_CONTAINER: <%:Environment.GetEnvironmentVariable("IS_CONTAINER", EnvironmentVariableTarget.Machine) ??
                Environment.GetEnvironmentVariable("IS_CONTAINER", EnvironmentVariableTarget.User) ??
                Environment.GetEnvironmentVariable("IS_CONTAINER", EnvironmentVariableTarget.Process) ??
                "Not found"  %>
URL: <%:Environment.GetEnvironmentVariable("URL", EnvironmentVariableTarget.Machine) ??
                Environment.GetEnvironmentVariable("URL", EnvironmentVariableTarget.User) ??
                Environment.GetEnvironmentVariable("URL", EnvironmentVariableTarget.Process) ??
                "Not found"  %>
</body>
</html>
