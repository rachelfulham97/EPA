var builder = WebApplication.CreateBuilder(args);
var app = builder.Build();
app.Urls.Add("http://0.0.0.0:8080");
app.MapGet("/",() =>
{
Console.WriteLine("Log Message:App started");
return $"Congradulations you got the app working @ {DateTime.UtcNow} - !!";
})

.WithName("hello");
app.Run();
