enum Environment { dev, stage, prod }

// Get this value from dart define
// defaultValue: Environment.dev.name doesn't work
const environment = String.fromEnvironment("ENVIRONMENT", defaultValue: "dev");

bool get isProduction => environment == Environment.prod.name;
bool get isDevelopment => environment == Environment.dev.name;
bool get isStage => environment == Environment.stage.name;

String get baseURL => "https://uuhvsgyassyghpddztxd.supabase.co";
String get anonKey =>
    "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InV1aHZzZ3lhc3N5Z2hwZGR6dHhkIiwicm9sZSI6ImFub24iLCJpYXQiOjE2NjU1NTgyMTYsImV4cCI6MTk4MTEzNDIxNn0.KabQNBBLwDp-_D1pG1RFsu8OX-yr6p0dwl2wyG4lSE0";
