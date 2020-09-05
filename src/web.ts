import { WebPlugin } from '@capacitor/core';
import { MLKitLanguagePlugin } from './definitions';

export class MLKitLanguageWeb extends WebPlugin implements MLKitLanguagePlugin {
  constructor() {
    super({
      name: 'MLKitLanguage',
      platforms: ['web'],
    });
  }

  async echo(options: { value: string }): Promise<{ value: string }> {
    console.log('ECHO', options);
    return options;
  }
}

const MLKitLanguage = new MLKitLanguageWeb();

export { MLKitLanguage };

import { registerWebPlugin } from '@capacitor/core';
registerWebPlugin(MLKitLanguage);
