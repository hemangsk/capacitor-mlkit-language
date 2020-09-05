import { Plugins } from '@capacitor/core';

const { MLKitLanguage } = Plugins;

/**
 * A LanguageIdentification client for identifying the language of a piece of text.
 */
export class LanguageIdentification {
  /**
   * Gets the languageIdentifier class instance.
   *
   * @param {LanguageIdentifierOptions} options Options for languageIdentification. Includes `confidenceThreshold`.
   * @returns {LanguageIdentifier}
   */
  public static getClient(
    options?: LanguageIdentifierOptions,
  ): LanguageIdentifier {
    if (options) {
      return new LanguageIdentifier(options);
    }

    return new LanguageIdentifier({});
  }
}

/**
 * Contains language identification techniques from the API
 */
export class LanguageIdentifier {
  languageIdentifierOptions: LanguageIdentifierOptions;

  constructor(options: LanguageIdentifierOptions) {
    this.languageIdentifierOptions = options;
  }

  /**
   * Identify the language of the provided text.
   *
   * @param {string} text The text whose language needs to be identified.
   * @returns {Promise<IdentifiedLanguage>} Object having languageCode of the identified language
   */
  public identifyLanguage(text: string): Promise<IdentifiedLanguage> {
    return MLKitLanguage.NLLIdentifyLanguage({
      text,
      languageIdentifierOptions: this.languageIdentifierOptions,
    });
  }

  /**
   * Identify the possible languages of the provided text.
   *
   * @param {string} text The text whose language needs to be identified.
   * @returns {Promise<IdentifiedLanguage>} Object having list of languageCodes of the possible languages with the confidence of each.
   */
  public identifyPossibleLanguages(
    text: string,
  ): Promise<IdentifiedLanguagesResponse> {
    return MLKitLanguage.NLLIdentifyPossibleLanguages({
      text,
      languageIdentifierOptions: this.languageIdentifierOptions,
    });
  }
}

export interface IdentifiedLanguage {
  /**
   * confidence score of the identified language
   */
  confidence?: number;
  /**
   * 'Two character code' of the identified language
   */
  languageCode: string;
}

export interface IdentifiedLanguagesResponse {
  /**
   * List of identified languages.
   * Contains response of LanguageIdentifier's [[identifyPossibleLanguages]] method.
   */
  possibleLanguages: IdentifiedLanguage[];
}

export interface LanguageIdentifierOptions {
  /**
   * The minimum threshold of confidence expected while language Identification.
   * Check google's docs for official defaults for `confidenceThreshold`.
   *
   * https://developers.google.com/android/reference/com/google/mlkit/nl/languageid/LanguageIdentifier#constant-summary
   */
  confidenceThreshold?: string;
}

export interface LanguageIdentificationRequest {
  /**
   * Text to be translated
   */
  text: string;
  /**
   * Options for language identification.
   */
  languageIdentifierOptions?: LanguageIdentifierOptions;
}
