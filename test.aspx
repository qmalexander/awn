<html>
<head>/head>
<body>
IS_CONTAINER: <%:Environment.GetEnvironmentVariable("IS_CONTAINER", EnvironmentVariableTarget.Machine) ??
                Environment.GetEnvironmentVariable("IS_CONTAINER", EnvironmentVariableTarget.User) ??
                Environment.GetEnvironmentVariable("IS_CONTAINER", EnvironmentVariableTarget.Process) ??
                "Not found"  %>
</body>
</html>
