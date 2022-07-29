
using Microsoft.ApplicationInsights;
using Microsoft.ApplicationInsights.Extensibility;

var appInsightsConnectionString = Environment.GetEnvironmentVariable("APP_INSIGHTS_CONNECTION_STRING");
var intervalString = Environment.GetEnvironmentVariable("INTERVAL") ?? "5000";
var interval = int.Parse(intervalString);

var configuration = TelemetryConfiguration.CreateDefault();
configuration.ConnectionString = appInsightsConnectionString;
configuration.TelemetryChannel.DeveloperMode = true;

var telemetryClient = new TelemetryClient(configuration);

var counter = 0;
while (true)
{
	Console.WriteLine($"Sending trace {counter}...");
	telemetryClient.TrackTrace($"Hello World - {counter}");
	Thread.Sleep(interval);
	counter++;
}
