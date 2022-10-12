enum Environment { dev, stage, prod }

// Get this value from dart define
// defaultValue: Environment.dev.name doesn't work
const environment = String.fromEnvironment("ENVIRONMENT", defaultValue: "dev");

bool get isProduction => environment == Environment.prod.name;
bool get isDevelopment => environment == Environment.dev.name;
bool get isStage => environment == Environment.stage.name;
