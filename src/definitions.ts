import {
  IdentifiedLanguage,
  IdentifiedLanguagesResponse,
  LanguageIdentificationRequest,
} from './mlkit';

declare global {
  interface PluginRegistry {
    MLKit: MLKitPlugin;
  }
}

export interface MLKitPlugin {
  /**
   * Identify the language of the provided text.
   *
   * @param {LanguageIdentificationRequest} options Request object containing text and language identification options.
   * @returns {Promise<IdentifiedLanguage>} The identified language
   */
  NLLIdentifyLanguage(
    options: LanguageIdentificationRequest,
  ): Promise<IdentifiedLanguage>;

  /**
   * Identify the possible languages of the provided text.
   *
   * @param {LanguageIdentifierOptions} options Request object containing text and language identification options.
   * @returns {Promise<IdentifiedLanguagesResponse>}
   */
  NLLIdentifyPossibleLanguages(
    options: LanguageIdentificationRequest,
  ): Promise<IdentifiedLanguagesResponse>;
}
