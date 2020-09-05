declare module '@capacitor/core' {
  interface PluginRegistry {
    MLKitLanguage: MLKitLanguagePlugin;
  }
}

export interface MLKitLanguagePlugin {
  echo(options: { value: string }): Promise<{ value: string }>;
}
